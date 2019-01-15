Test that `enabled_if` fields work as expected.

This alias is disabled, building it should do nothing:
  $ dune build @x

This one is enabled:
  $ dune build @y
  Building alias y

This rule is disabled, trying to build a should fail:
  $ dune build a
  Don't know how to build a
  Hint: did you mean b?
  [1]

This one is enabled:
  $ dune build b
  Building file b

Test the enabled_if field for libraries:

  $ dune build main.exe
  File "dune", line 33, characters 12-15:
  33 |  (libraries foo))
                   ^^^
  Error: Library "foo" in _build/default is hidden (unsatisfied 'enabled_if').
  Hint: try: dune external-lib-deps --missing main.exe
  [1]

Ideally, the above message should mention the dependency path between
the requested target and the unsatisfied `enabled_if`.
