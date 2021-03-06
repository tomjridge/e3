(** The signature of the simple interface provided by implementations. *)

module type S = sig

  (** A simple interface to Earley. More fine-grained access via full interface (make e3.docdir) *) 


  (** Nonterminals are ints *)
  type nt = int

  (** Terminals are ints *)
  type tm = int

  (** Symbols are either nts or tms *)
  type sym = [ `NT of nt | `TM of tm ]

  (** An item, a tuple representing an Earley item of the form E -> alpha.beta,i,j *)
  type nt_item = nt * sym list * sym list * int * int

  (** The parameters for Earley are the grammar (encoded as a function
      nt_items_for_nt, see {E3_examples} for an example), and a function
      {p_of_tm} which takes a terminal and a substring, and returns the
      prefixes (represented as an index) of the substrings that can be
      parsed by that terminal. *)
  type 'a params = {
    nt_items_for_nt: nt -> ('a*int*int) -> nt_item list;
    p_of_tm: tm -> ('a*int*int) -> int list }

  (** The result of parsing is an oracle which, given a list of symbols
      alpha, and a symbol X, and a span (i,j), returns the list of integers
      k such that (i,k) can be parsed as alpha, and (k,j) can be parsed as
      X. *)
  type oracle_t = (sym list * sym) -> (int * int) -> int list

  (** Parsing also returns information about which extents correspond to terminals. *)
  type tm_oracle_t = tm -> (int * int) -> bool

  val run_earley: 'a params -> nt -> 'a -> int -> (oracle_t * tm_oracle_t)


end
