From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2016, #08; Thu, 26)
Date: Thu, 26 May 2016 15:50:14 -0700
Message-ID: <xmqqeg8otowp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 00:50:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b646i-0005R0-RY
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 00:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbcEZWuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 18:50:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755099AbcEZWuS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 18:50:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AE411F619;
	Thu, 26 May 2016 18:50:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=D
	sDGD5rCCf2Zbutl1+1A3WCIiIk=; b=X3LjXLmzwJisgNH5tzcuEB+2uFF4P9bDX
	P0+bNd8W8uHvYaHFAqEf/ogmmGRKyiua83e/uDlbV171agKEFb/a9I/ejb1L4Gbf
	XGGr+1BGGP72mRt4PHfwR6x1/QgQCgI57gCvDTSzVNS1pjRI8ujNCnnFu0rPLB1N
	3H2gM4163g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=oOK
	8W33e2CC4rdv6rko2Sb02hMrO/k5koArX36pJBoERPzzLF9+AGIkoH+PAIF3tDY7
	87GhOC6uyFhDRuGY/y4EyTrJXe1m53h3iux5LIQ013RU87mPWvfBeJ8zQGBWqHV5
	SxCdBaxrYu5VUqlNG3ZvSliJJWO6ERovwkxUYNac=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 528E01F618;
	Thu, 26 May 2016 18:50:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81AE21F616;
	Thu, 26 May 2016 18:50:16 -0400 (EDT)
X-master-at: 7777322816a31edff4fb9f429847d11f8974f264
X-next-at: 397704a2234a83bf7ba537e78d607ea550d3074c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 36F3908C-2394-11E6-968C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295703>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ar/diff-args-osx-precompose (2016-05-13) 1 commit
  (merged to 'next' on 2016-05-17 at 7b59b79)
 + diff: run arguments through precompose_argv

 Many commands normalize command line arguments from NFD to NFC
 variant of UTF-8 on OSX, but commands in the "diff" family did
 not, causing "git diff $path" to complain that no such path is
 known to Git.  They have been taught to do the normalization.


* da/difftool (2016-05-16) 2 commits
  (merged to 'next' on 2016-05-17 at ef5a435)
 + difftool: handle unmerged files in dir-diff mode
 + difftool: initialize variables for readability

 "git difftool" learned to handle unmerged paths correctly in
 dir-diff mode.


* jc/doc-lint (2016-05-10) 1 commit
  (merged to 'next' on 2016-05-17 at 9032aa5)
 + ci: validate "linkgit:" in documentation

 Find common mistakes when writing gitlink: in our documentation and
 drive the check from "make check-docs".


* jc/rerere-multi (2016-05-19) 2 commits
  (merged to 'next' on 2016-05-19 at 0520c90)
 + rerere: remove an null statement
  (merged to 'next' on 2016-05-13 at f4d1d82)
 + rerere: plug memory leaks upon "rerere forget" failure


* jc/test-parse-options-expect (2016-05-10) 4 commits
  (merged to 'next' on 2016-05-10 at 3ca5783)
 + t0040: convert a few tests to use test-parse-options --expect
 + t0040: remove unused test helpers
 + test-parse-options: --expect=<string> option to simplify tests
 + test-parse-options: fix output when callback option fails
 (this branch uses pb/commit-verbose-config.)

 t0040 had too many unnecessary repetitions in its test data.  Teach
 test-parse-options program so that a caller can tell what it
 expects in its output, so that these repetitions can be cleaned up.


* jk/test-z-n-unquoted (2016-05-14) 6 commits
  (merged to 'next' on 2016-05-17 at 65372cf)
 + always quote shell arguments to test -z/-n
 + t9103: modernize test style
 + t9107: switch inverted single/double quotes in test
 + t9107: use "return 1" instead of "exit 1"
 + t9100,t3419: enclose all test code in single-quotes
 + t/lib-git-svn: drop $remote_git_svn and $git_svn_id

 t9xxx series has been updated primarily for readability, while
 fixing small bugs in it.  A few scripted Porcelains have also been
 updated to fix possible bugs around their use of "test -z" and
 "test -n".


* js/perf-rebase-i (2016-05-13) 3 commits
  (merged to 'next' on 2016-05-13 at eb51ddd)
 + perf: run "rebase -i" under perf
 + perf: make the tests work in worktrees
 + perf: let's disable symlinks when they are not available

 Add perf test for "rebase -i"


* nd/worktree-various-heads (2016-04-22) 13 commits
  (merged to 'next' on 2016-05-10 at 61d3415)
 + branch: do not rename a branch under bisect or rebase
 + worktree.c: check whether branch is bisected in another worktree
 + wt-status.c: split bisect detection out of wt_status_get_state()
 + worktree.c: check whether branch is rebased in another worktree
 + worktree.c: avoid referencing to worktrees[i] multiple times
 + wt-status.c: make wt_status_check_rebase() work on any worktree
 + wt-status.c: split rebase detection out of wt_status_get_state()
 + path.c: refactor and add worktree_git_path()
 + worktree.c: mark current worktree
 + worktree.c: make find_shared_symref() return struct worktree *
 + worktree.c: store "id" instead of "git_dir"
 + path.c: add git_common_path() and strbuf_git_common_path()
 + dir.c: rename str(n)cmp_icase to fspath(n)cmp
 (this branch is used by nd/worktree-cleanup-post-head-protection.)

 The experimental "multiple worktree" feature gains more safety to
 forbid operations on a branch that is checked out or being actively
 worked on elsewhere, by noticing that e.g. it is being rebased.


* pb/commit-verbose-config (2016-05-10) 7 commits
 + commit: add a commit.verbose config variable
 + t7507-commit-verbose: improve test coverage by testing number of diffs
 + parse-options.c: make OPTION_COUNTUP respect "unspecified" values
 + t/t7507: improve test coverage
 + t0040-parse-options: improve test coverage
 + test-parse-options: print quiet as integer
 + t0040-test-parse-options.sh: fix style issues
 (this branch is used by jc/test-parse-options-expect.)

 "git commit" learned to pay attention to "commit.verbose"
 configuration variable and act as if "--verbose" option was
 given from the command line.


* ss/commit-dry-run-resolve-merge-to-no-op (2016-02-17) 1 commit
  (merged to 'next' on 2016-05-10 at 2ada404)
 + wt-status.c: set commitable bit if there is a meaningful merge.

 "git commit --dry-run" reported "No, no, you cannot commit." in one
 case where "git commit" would have allowed you to commit, and this
 improves it a little bit ("git commit --dry-run --short" still does
 not give you the correct answer, for example).  This is a stop-gap
 measure in that "commit --short --dry-run" still gives an incorrect
 result.


* tb/core-eol-fix (2016-04-25) 4 commits
  (merged to 'next' on 2016-05-10 at fa8a200)
 + convert.c: ident + core.autocrlf didn't work
 + t0027: test cases for combined attributes
 + convert: allow core.autocrlf=input and core.eol=crlf
 + t0027: make commit_chk_wrnNNO() reliable
 (this branch is used by tb/convert-peek-in-index.)

 A couple of bugs around core.autocrlf have been fixed.


* xy/format-patch-base (2016-04-26) 4 commits
  (merged to 'next' on 2016-05-10 at dd19e0a)
 + format-patch: introduce format.useAutoBase configuration
 + format-patch: introduce --base=auto option
 + format-patch: add '--base' option to record base tree info
 + patch-ids: make commit_patch_id() a public helper function

 "git format-patch" learned a new "--base" option to record what
 (public, well-known) commit the original series was built on in
 its output.

--------------------------------------------------
[New Topics]

* ak/t4204-shell-portability (2016-05-24) 1 commit
 - t4204: do not let $name variable clobbered

 Update a test to run also under ksh88.

 Will merge to 'next' and to 'master'.


* et/pretty-format-c-auto (2016-05-25) 1 commit
 - format_commit_message: honor `color=auto` for `%C(auto)`

 Expecting a reroll.
 ($gmane/295601)


* ew/daemon-socket-keepalive (2016-05-25) 1 commit
 - daemon: enable SO_KEEPALIVE for all sockets

 When "git daemon" is run without --[init-]timeout specified, a
 connection from a client that silently goes offline can hang around
 for a long time, wasting resources.  The socket-level KEEPALIVE has
 been enabled to allow the OS to notice such failed connections.

 Will merge to 'next'.


* jk/upload-pack-hook (2016-05-24) 6 commits
 - upload-pack: provide a hook for running pack-objects
 - config: add a notion of "scope"
 - config: return configset value for current_config_ functions
 - config: set up config_source for command-line config
 - git_config_parse_parameter: refactor cleanup code
 - git_config_with_options: drop "found" counting

 Allow a custom "git upload-pack" replacement to respond to
 "fetch/clone" request.

 Will merge to 'next'.


* kb/msys2-tty (2016-05-26) 1 commit
 - mingw: make isatty() recognize MSYS2's pseudo terminals (/dev/pty*)

 The "are we talking with TTY, doing an interactive session?"
 detection has been updated to work better for "Git for Windows".


* rs/xdiff-hunk-with-func-line (2016-05-26) 5 commits
 - grep: don't extend context to trailing empty lines with -W
 - xdiff: don't include common trailing empty lines with -W
 - xdiff: ignore empty lines before added functions with -W
 - xdiff: handle appended chunks better with -W
 - xdiff: factor out match_func_rec()

 "git show -W" (extend hunks to cover the entire function, delimited
 by lines that match the "funcname" pattern) used to show the entire
 file when a change added an entire function at the end of the file,
 which has been fixed.


* sb/submodule-misc-cleanups (2016-05-25) 1 commit
 - submodule update: make use of the existing fetch_in_submodule function

 Minor simplification.

 Will merge to 'next'.


* sb/submodule-default-paths (2016-05-26) 7 commits
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - Merge branch 'sb/pathspec-label' into sb/submodule-default-paths
 - Merge branch 'jc/attr' into sb/submodule-default-paths
 - Merge branch 'sb/clone-shallow-passthru' into sb/submodule-default-paths
 - Merge branch 'sb/submodule-deinit-all' into sb/submodule-default-paths
 - Merge branch 'sb/submodule-parallel-update' into sb/submodule-default-paths
 (this branch uses jc/attr and sb/pathspec-label.)

--------------------------------------------------
[Stalled]

* sb/bisect (2016-04-15) 22 commits
 - SQUASH???
 - bisect: get back halfway shortcut
 - bisect: compute best bisection in compute_relevant_weights()
 - bisect: use a bottom-up traversal to find relevant weights
 - bisect: prepare for different algorithms based on find_all
 - bisect: rename count_distance() to compute_weight()
 - bisect: make total number of commits global
 - bisect: introduce distance_direction()
 - bisect: extract get_distance() function from code duplication
 - bisect: use commit instead of commit list as arguments when appropriate
 - bisect: replace clear_distance() by unique markers
 - bisect: use struct node_data array instead of int array
 - bisect: get rid of recursion in count_distance()
 - bisect: make algorithm behavior independent of DEBUG_BISECT
 - bisect: make bisect compile if DEBUG_BISECT is set
 - bisect: plug the biggest memory leak
 - bisect: add test for the bisect algorithm
 - t6030: generalize test to not rely on current implementation
 - t: use test_cmp_rev() where appropriate
 - t/test-lib-functions.sh: generalize test_cmp_rev
 - bisect: allow 'bisect run' if no good commit is known
 - bisect: write about `bisect next` in documentation

 The internal algorithm used in "git bisect" to find the next commit
 to check has been optimized greatly.

 Expecting a reroll.
 ($gmane/291163)


* nd/shallow-deepen (2016-04-13) 26 commits
 - fetch, upload-pack: --deepen=N extends shallow boundary by N commits
 - upload-pack: add get_reachable_list()
 - upload-pack: split check_unreachable() in two, prep for get_reachable_list()
 - t5500, t5539: tests for shallow depth excluding a ref
 - clone: define shallow clone boundary with --shallow-exclude
 - fetch: define shallow boundary with --shallow-exclude
 - upload-pack: support define shallow boundary by excluding revisions
 - refs: add expand_ref()
 - t5500, t5539: tests for shallow depth since a specific date
 - clone: define shallow clone boundary based on time with --shallow-since
 - fetch: define shallow boundary with --shallow-since
 - upload-pack: add deepen-since to cut shallow repos based on time
 - shallow.c: implement a generic shallow boundary finder based on rev-list
 - fetch-pack: use a separate flag for fetch in deepening mode
 - fetch-pack.c: mark strings for translating
 - fetch-pack: use a common function for verbose printing
 - fetch-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move rev-list code out of check_non_tip()
 - upload-pack: tighten number parsing at "deepen" lines
 - upload-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move "unshallow" sending code out of deepen()
 - upload-pack: remove unused variable "backup"
 - upload-pack: move "shallow" sending code out of deepen()
 - upload-pack: move shallow deepen code out of receive_needs()
 - transport-helper.c: refactor set_helper_option()
 - remote-curl.c: convert fetch_git() to use argv_array

 The existing "git fetch --depth=<n>" option was hard to use
 correctly when making the history of an existing shallow clone
 deeper.  A new option, "--deepen=<n>", has been added to make this
 easier to use.  "git clone" also learned "--shallow-since=<date>"
 and "--shallow-exclude=<tag>" options to make it easier to specify
 "I am interested only in the recent N months worth of history" and
 "Give me only the history since that version".

 Needs review.


* sg/completion-updates (2016-02-28) 21 commits
 . completion: cache the path to the repository
 . completion: extract repository discovery from __gitdir()
 . completion: don't guard git executions with __gitdir()
 . completion: consolidate silencing errors from git commands
 . completion: don't use __gitdir() for git commands
 . completion: respect 'git -C <path>'
 . completion: fix completion after 'git -C <path>'
 . completion: don't offer commands when 'git --opt' needs an argument
 . rev-parse: add '--absolute-git-dir' option
 . completion: list short refs from a remote given as a URL
 . completion: don't list 'HEAD' when trying refs completion outside of a repo
 . completion: list refs from remote when remote's name matches a directory
 . completion: respect 'git --git-dir=<path>' when listing remote refs
 . completion: fix most spots not respecting 'git --git-dir=<path>'
 . completion: ensure that the repository path given on the command line exists
 . completion tests: add tests for the __git_refs() helper function
 . completion tests: check __gitdir()'s output in the error cases
 . completion tests: consolidate getting path of current working directory
 . completion tests: make the $cur variable local to the test helper functions
 . completion tests: don't add test cruft to the test repository
 . completion: improve __git_refs()'s in-code documentation

 Will be rerolled.
 ($gmane/287839)


* az/p4-bare-no-rebase (2016-02-19) 1 commit
 - git-p4.py: Don't try to rebase on submit from bare repository

 "git p4 submit" attempts to do a rebase, which would fail if done
 in a bare repository.  Not doing this rebase would paper over the
 failure, which is what this patch does, but it is unclear what the
 side effect of not rebasing is.

 Needs a better explanation.


* nd/icase (2016-02-15) 12 commits
 - grep.c: reuse "icase" variable
 - diffcore-pickaxe: support case insensitive match on non-ascii
 - diffcore-pickaxe: "share" regex error handling code
 - grep/pcre: support utf-8
 - gettext: add is_utf8_locale()
 - grep/pcre: prepare locale-dependent tables for icase matching
 - grep/icase: avoid kwsset when -F is specified
 - grep/icase: avoid kwsset on literal non-ascii strings
 - test-regex: expose full regcomp() to the command line
 - test-regex: isolate the bug test code
 - grep: break down an "if" stmt in preparation for next changes
 - grep: allow -F -i combination

 "git grep -i" has been taught to fold case in non-ascii locales.

 Needs review.
 ($gmane/286137)


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* dg/subtree-rebase-test (2016-01-19) 1 commit
 - contrib/subtree: Add a test for subtree rebase that loses commits

 Reviewed up to v5.
 Will be rerolled.
 ($gmane/284426)


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
 - am: make a direct call to merge_recursive
 - merge_recursive_options: introduce the "gently" flag

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Being able to make a direct call would be good in general, but as a
 performance thing, the change needs to be backed up by numbers.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.

 Will be rerolled.
 ($gmane/292205)


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for a reroll.
 ($gmane/284368).


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.
 Will discard.


* jc/merge-impossible-no-commit (2016-04-26) 2 commits
 - merge: warn --no-commit merge when no new commit is created
 - merge: do not contaminate option_commit with --squash

 "git merge --no-commit" silently succeeded when there is no need to
 create any commit, either when you are more recent than the commit
 you tried to merge, or you can fast-forward to the commit you tried
 to merge.  The command gives a warning message in such cases.

 Just tying loose ends in a discussion.  Unless somebody else
 champions this topic, I'll drop it.

 Will discard.

--------------------------------------------------
[Cooking]

* jk/cat-file-buffered-batch-all (2016-05-18) 2 commits
  (merged to 'next' on 2016-05-26 at 4da062d)
 + cat-file: default to --buffer when --batch-all-objects is used
 + cat-file: avoid noop calls to sha1_object_info_extended

 "git cat-file --batch-all" has been sped up, by taking advantage
 of the fact that it does not have to read a list of objects, in two
 ways.

 Will merge to 'master'.


* ah/no-verify-signature-with-pull-rebase (2016-05-20) 1 commit
 - pull: warn on --verify-signatures with --rebase

 "git pull --rebase --verify-signature" learned to warn the user
 that "--verify-signature" is a no-op.

 Will merge to 'next'.


* ak/t0008-ksh88-workaround (2016-05-20) 1 commit
  (merged to 'next' on 2016-05-26 at 9a34a2a)
 + t0008: 4 tests fail with ksh88

 Test portability workaround.

 Will merge to 'master'.


* ep/http-curl-trace (2016-05-24) 2 commits
 - imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
 - http.c: implement the GIT_TRACE_CURL environment variable

 HTTP transport gained an option to produce more detailed debugging
 trace.

 Rerolled.


* jc/attr (2016-05-25) 18 commits
 - attr: support quoting pathname patterns in C style
 - attr: expose validity check for attribute names
 - attr: add counted string version of git_attr()
 - attr: add counted string version of git_check_attr()
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct git_attr_check"
 - attr: (re)introduce git_check_attr() and struct git_attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line
 (this branch is used by sb/pathspec-label and sb/submodule-default-paths.)

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.

 Let's merge the early "clean-up" half to 'next', after splitting it
 into a separate topic.


* fc/fast-import-broken-marks-file (2016-05-17) 1 commit
  (merged to 'next' on 2016-05-26 at 9962fcf)
 + fast-import: do not truncate exported marks file

 "git fast-import --export-marks" would overwrite the existing marks
 file even when it makes a dump from its custom die routine.
 Prevent it from doing so when we have an import-marks file but
 haven't finished reading it.

 Will merge to 'master'.


* es/t1500-modernize (2016-05-18) 5 commits
  (merged to 'next' on 2016-05-26 at 274e39c)
 + t1500: avoid setting environment variables outside of tests
 + t1500: avoid setting configuration options outside of tests
 + t1500: avoid changing working directory outside of tests
 + t1500: test_rev_parse: facilitate future test enhancements
 + t1500: be considerate to future potential tests

 test updates to make it more readable and maintainable.

 Will merge to 'master'.


* cc/apply-introduce-state (2016-05-12) 48 commits
 - builtin/apply: rename 'prefix_' parameter to 'prefix'
 - builtin/apply: move applying patches into apply_all_patches()
 - builtin/apply: move 'state' check into check_apply_state()
 - builtin/apply: move 'symlink_changes' global into 'struct apply_state'
 - builtin/apply: move 'fn_table' global into 'struct apply_state'
 - builtin/apply: move 'state_linenr' global into 'struct apply_state'
 - builtin/apply: move 'max_change' and 'max_len' into 'struct apply_state'
 - builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
 - builtin/apply: move 'ws_error_action' into 'struct apply_state'
 - builtin/apply: move 'applied_after_fixing_ws' into 'struct apply_state'
 - builtin/apply: move 'squelch_whitespace_errors' into 'struct apply_state'
 - builtin/apply: remove whitespace_option arg from set_default_whitespace_mode()
 - builtin/apply: move 'whitespace_option' into 'struct apply_state'
 - builtin/apply: move 'whitespace_error' global into 'struct apply_state'
 - builtin/apply: move 'root' global into 'struct apply_state'
 - builtin/apply: move 'p_value_known' global into 'struct apply_state'
 - builtin/apply: move 'p_value' global into 'struct apply_state'
 - builtin/apply: move 'has_include' global into 'struct apply_state'
 - builtin/apply: move 'limit_by_name' global into 'struct apply_state'
 - builtin/apply: move 'patch_input_file' global into 'struct apply_state'
 - builtin/apply: move 'apply' global into 'struct apply_state'
 - builtin/apply: move 'p_context' global into 'struct apply_state'
 - builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
 - builtin/apply: move 'line_termination' global into 'struct apply_state'
 - builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
 - builtin/apply: move 'no_add' global into 'struct apply_state'
 - builtin/apply: move 'threeway' global into 'struct apply_state'
 - builtin/apply: move 'summary' global into 'struct apply_state'
 - builtin/apply: move 'numstat' global into 'struct apply_state'
 - builtin/apply: move 'diffstat' global into 'struct apply_state'
 - builtin/apply: move 'cached' global into 'struct apply_state'
 - builtin/apply: move 'allow_overlap' global into 'struct apply_state'
 - builtin/apply: move 'update_index' global into 'struct apply_state'
 - builtin/apply: move 'apply_verbosely' global into 'struct apply_state'
 - builtin/apply: move 'apply_with_reject' global into 'struct apply_state'
 - builtin/apply: move 'apply_in_reverse' global into 'struct apply_state'
 - builtin/apply: move 'check_index' global into 'struct apply_state'
 - builtin/apply: move 'check' global into 'struct apply_state'
 - builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
 - builtin/apply: move 'state' init into init_apply_state()
 - builtin/apply: introduce 'struct apply_state' to start libifying
 - builtin/apply: move 'read_stdin' global into cmd_apply()
 - builtin/apply: move 'options' variable into cmd_apply()
 - builtin/apply: extract line_by_line_fuzzy_match() from match_fragment()
 - builtin/apply: avoid local variable shadowing 'len' parameter
 - builtin/apply: avoid parameter shadowing 'linenr' global
 - builtin/apply: avoid parameter shadowing 'p_value' global
 - builtin/apply: make gitdiff_verify_name() return void

 The "git apply" standalone program is being libified; this is the
 first step to move many state variables into a structure that can
 be explicitly (re)initialized to make the machinery callable more
 than once.

 The next step that moves some remaining state variables into the
 structure and turns die()s into an error return that propagates up
 to the caller is not queued yet but in flight.  It would be good to
 review the above first and give the remainder of the series a solid
 base to build on.

 Reroll exists, but hasn't seen any review yet ($gmane/295429).


* pb/bisect (2016-05-24) 3 commits
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Beginning of GSoC "git bisect" project.


* sb/pathspec-label (2016-05-25) 4 commits
 - pathspec: allow querying for attributes
 - pathspec: move prefix check out of the inner loop
 - pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 (this branch is used by sb/submodule-default-paths; uses jc/attr.)

 The pathspec mechanism learned ":(attr:X)$pattern" pathspec magic
 to limit paths that match $pattern further by attribute settings.

 Will merge to 'next'.


* nd/worktree-cleanup-post-head-protection (2016-05-24) 6 commits
 - worktree: simplify prefixing paths
 - worktree: avoid 0{40}, too many zeroes, hard to read
 - worktree.c: use is_dot_or_dotdot()
 - git-worktree.txt: keep subcommand listing in alphabetical order
 - worktree.c: rewrite mark_current_worktree() to avoid strbuf
 - completion: support git-worktree

 Further preparatory clean-up for "worktree" feature.

 Expecting a reroll.
 ($gmane/294136, etc.)


* mh/split-under-lock (2016-05-13) 33 commits
 - lock_ref_sha1_basic(): only handle REF_NODEREF mode
 - commit_ref_update(): remove the flags parameter
 - lock_ref_for_update(): don't resolve symrefs
 - lock_ref_for_update(): don't re-read non-symbolic references
 - refs: resolve symbolic refs first
 - ref_transaction_update(): check refname_is_safe() at a minimum
 - unlock_ref(): move definition higher in the file
 - lock_ref_for_update(): new function
 - add_update(): initialize the whole ref_update
 - verify_refname_available(): adjust constness in declaration
 - refs: don't dereference on rename
 - refs: allow log-only updates
 - delete_branches(): use resolve_refdup()
 - ref_transaction_commit(): correctly report close_ref() failure
 - ref_transaction_create(): disallow recursive pruning
 - refs: make error messages more consistent
 - lock_ref_sha1_basic(): remove unneeded local variable
 - read_raw_ref(): move docstring to header file
 - read_raw_ref(): improve docstring
 - read_raw_ref(): rename symref argument to referent
 - read_raw_ref(): clear *type at start of function
 - read_raw_ref(): rename flags argument to type
 - ref_transaction_commit(): remove local variable n
 - rename_ref(): remove unneeded local variable
 - commit_ref_update(): write error message to *err, not stderr
 - refname_is_safe(): insist that the refname already be normalized
 - refname_is_safe(): don't allow the empty string
 - refname_is_safe(): use skip_prefix()
 - remove_dir_recursively(): add docstring
 - safe_create_leading_directories(): improve docstring
 - read_raw_ref(): don't get confused by an empty directory
 - commit_ref(): if there is an empty dir in the way, delete it
 - t1404: demonstrate a bug resolving references

 Further preparatory work on the refs API before the pluggable
 backend series can land.

 Updated (again).  Will wait for comments for the last time, and
 then merge to 'next'.


* mh/connect-leak (2016-04-28) 1 commit
 - git_connect(): fix memory leak with CONNECT_DIAG_URL

 Is already made obsolete with a patch in flight under discussion.
 ($gmane/292962)

 Will discard.


* ew/fast-import-unpack-limit (2016-05-19) 2 commits
  (merged to 'next' on 2016-05-19 at 50137c5)
 + (DO NOT MERGE YET) fast-import: discard object-table after closing a pack
  (merged to 'next' on 2016-05-11 at ffd4efb)
 + fast-import: implement unpack limit

 "git fast-import" learned the same performance trick to avoid
 creating too small a packfile as "git fetch" and "git push" have,
 using *.unpackLimit configuration.

 Will hold.


* jc/send-email-skip-backup (2016-04-12) 1 commit
 - send-email: detect and offer to skip backup files

 A careless invocation of "git send-email directory/" after editing
 0001-change.patch with an editor often ends up sending both
 0001-change.patch and its backup file, 0001-change.patch~, causing
 embarrassment and a minor confusion.  Detect such an input and
 offer to skip the backup files when sending the patches out.

 Needs review.


* kn/ref-filter-branch-list (2016-05-17) 17 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add `:dir` and `:base` options for ref printing atoms
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce symref_atom_parser() and refname_atom_parser()
 - ref-filter: introduce refname_atom_parser_internal()
 - ref-filter: make "%(symref)" atom work with the ':short' modifier
 - ref-filter: add support for %(upstream:track,nobracket)
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: move get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: include reference to 'used_atom' within 'atom_value'
 - ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Rerolled.
 Needs review.


* dt/index-helper (2016-05-20) 20 commits
 - index-helper: indexhelper.exitafter config
 - trace: measure where the time is spent in the index-heavy operations
 - index-helper: optionally automatically run
 - index-helper: autorun mode
 - index-helper: don't run if already running
 - index-helper: kill mode
 - watchman: add a config option to enable the extension
 - unpack-trees: preserve index extensions
 - update-index: enable/disable watchman support
 - index-helper: use watchman to avoid refreshing index with lstat()
 - watchman: support watchman to reduce index refresh cost
 - read-cache: add watchman 'WAMA' extension
 - index-helper: log warnings
 - index-helper: add --detach
 - daemonize(): set a flag before exiting the main process
 - index-helper: add --strict
 - index-helper: new daemon for caching index and related stuff
 - pkt-line: add gentle version of packet_write
 - read-cache: allow to keep mmap'd memory after reading
 - read-cache.c: fix constness of verify_hdr()

 A new "index-helper" daemon has been introduced to give newly
 spawned Git process a quicker access to the data in the index, and
 optionally interface with the watchman daemon to further reduce the
 refresh cost.

 Rerolled.
 ($gmane/295106).


* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 ($gmane/282594)

--------------------------------------------------
[Discarded]

* jc/diff-compact-always-use-blank-heuristics (2016-04-29) 1 commit
 . diff: enable "compaction heuristics" and lose experimentation knob

 Superseded by the tip commit on the jk/diff-compact-heuristic topic.
