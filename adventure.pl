/* <The name of this game>, by <your name goes here>. */

:- dynamic i_am_at/1, at/2, holding/1.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)).

i_am_at(university_center).

path(university_center, n, trembely).
path(trembely, s, university_center).
path(university_center, s, fml).
path(fml, n, university_center).
path(university_center, w, linderman_library).
path(linderman_library, e, university_center).
path(university_center, e, lehigh_memorial_building).
path(lehigh_memorial_building, w, university_center).
path(linderman_library, w, taylor_gym).
path(taylor_gym, e, linderman_library).
path(trembely, w, drown_hall).
path(drown_hall, e, trembely).
path(drown_hall, n, health_center).
path(health_center, s, drown_hall).
path(health_center, w, lamberton_hall).
path(lamberton_hall, e, health_center).
path(lamberton_hall, w, ideal_office).
path(ideal_office, e, lamberton_hall).
path(ideal_office, s, taylor_gym) :- holding(lehighid).
path(ideal_office, s, taylor_gym) :- write('Boiiiiii if you dont get your id you aint gettin in here'), nl, !, fail.
path(taylor_gym, n, ideal_office).
path(fml, s, bookstore).
path(bookstore, n, fml).

at(squirrel, universityecenter).
at(lehigh_id, fml).
at(lehighid, ideal_office).
at(weights, taylor_gym).
at(protien_powder, trembely).

/* These rules describe how to pick up an object. */
combine() :-
        holding(weights),
        holding(protien_powder),
        retract(holding(weights)),
        retract(holding(protien_powder)),
        assert(holding(protien_shake)),
        write('Whoo! congrats, you made your protien shake, youre big now!'),
        finish, !, nl.

combine() :-
        write('nothing to combine, make sure you have the weights and the powder'), nl.

take(X) :-
        holding(X),
        write('You''re already holding it!'),
        !, nl.

take(X) :-
        i_am_at(Place),
        at(X, Place),
        retract(at(X, Place)),
        assert(holding(X)),
        write('OK.'),
        !, nl.

take(_) :-
        write('I don''t see it here.'),
        nl.


/* These rules describe how to put down an object. */

drop(X) :-
        holding(X),
        i_am_at(Place),
        retract(holding(X)),
        assert(at(X, Place)),
        write('OK.'),
        !, nl.

drop(_) :-
        write('You aren''t holding it!'),
        nl.


/* These rules define the direction letters as calls to go/1. */

n :- go(n).

s :- go(s).

e :- go(e).

w :- go(w).


/* This rule tells how to move in a given direction. */

go(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        !, look.

go(_) :-
        write('You can''t go that way.').


/* This rule tells how to look about you. */

look :-
        i_am_at(Place),
        describe(Place),
        nl,
        notice_objects_at(Place),
        nl.


/* These rules set up a loop to mention all the objects
   in your vicinity. */

notice_objects_at(Place) :-
        at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).


/* This rule tells how to die. */

die :-
        finish.


/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */

finish :-
        nl,
        write('The game is over. Please enter the "halt." command.'),
        nl.


/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.             -- to start the game.'), nl,
        write('n.  s.  e.  w.     -- to go in that direction.'), nl,
        write('take(Object).      -- to pick up an object.'), nl,
        write('drop(Object).      -- to put down an object.'), nl,
        write('combine().         -- to combine objects.'), nl,
        write('look.              -- to look around you again.'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('halt.              -- to end the game and quit.'), nl,
        nl.


/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
        look.


/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(trembely) :- write('You are Trembely park.'), nl.
describe(university_center) :- write('You are at Lehigh University Center, go to the gym, its time to get big, then make sure to make your protien shake back home at Trembley'), nl.
describe(fml) :- write('You are at FML, dont be a nerd, procrastinate on that 327, this is the worst place'), nl.
describe(linderman_library) :- write('You are at Linderman Library, even worse than fml... how is that possible'), nl.
describe(lehigh_memorial_building) :- write('You are at Lehigh Memorial Building, this place brings back terrible memories...'), nl.
describe(bookstore) :- write('You are at the Lehigh Bookstore, be sure to by that 600 dollar leather bag they have...'), nl.
describe(drown_hall) :- write('You are at Drown hall, go turn your essay into a paper air plane'), nl.
describe(health_center) :- write('You are at the Lehigh Health Center, cant be making gains if youre sick...'), nl.
describe(lamberton_hall) :- write('You are at Lamberton Hall, their milk shakes slap, try the m&m one.'), nl.
describe(ideal_office) :- write('You are at the IDEALS office, where you can replace your lehigh ID and replace lost keys'), nl.
describe(taylor_gym) :- holding(lehighid), write('You are at Taylor Gym, time to get big'), nl, !.
describe(lehighid) :- write('blah blah blah'), nl, !.
describe(protien_powder) :- write('found the protien but do you have your weights?'), nl.
describe(protien_shake) :- write('Whoo congrats, youre big now'), finish, nl.
