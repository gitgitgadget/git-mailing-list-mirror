Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF39203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbcGYWvJ (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:51:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753509AbcGYWvF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:51:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F12243092B;
	Mon, 25 Jul 2016 18:51:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	tmW9p1E82iKXOGr22lW3H99uwI=; b=XQMCnruv7qHrh5oaqgP1NNMn9piiDUmnN
	1ncLXNqgsbVIVF0Xma0G7IE2zi4v2xSES6sPonmJmniAX7ibkKbfznvenVOe7u+G
	iNUCO/44USI70auSVSHUUrY506xqbuJljPcVuBFqs9NoegeK2p1kK+6w7euTewlW
	T0hS1Z8Egc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=QDQ
	uAje6co4bAXrItKKOIiDbx3PdKleroN9sXedhp6OkghM5MO0Rq4by8Rxwq9hLMlh
	3ukJHqcKwevvzE4Q8Z1+tkQOmCBaDY1Re+WnP5KtXig3r1rlPa7J0FZGAAiAIoFL
	fRAUVT7NmxXiDzfczMjZwikZIuluvzUGEGd/gsrU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D93E13092A;
	Mon, 25 Jul 2016 18:51:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F75030925;
	Mon, 25 Jul 2016 18:51:01 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2016, #07; Mon, 25)
X-master-at: 8c6d1f9807c67532e7fb545a944b064faff0f70b
X-next-at: 73e62d03eaf435459000ac11b091e54ac5fc5b85
Date:	Mon, 25 Jul 2016 15:50:59 -0700
Message-ID: <xmqqh9bd2uy4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42E00786-52BA-11E6-BCDC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ew/autoconf-pthread (2016-07-18) 1 commit
  (merged to 'next' on 2016-07-19 at 146e249)
 + configure.ac: stronger test for pthread linkage

 Existing autoconf generated test for the need to link with pthread
 library did not check all the functions from pthread libraries;
 recent FreeBSD has some functions in libc but not others, and we
 mistakenly thought linking with libc is enough when it is not.


* jc/doc-diff-filter-exclude (2016-07-14) 1 commit
  (merged to 'next' on 2016-07-19 at 0c8aa92)
 + diff: document diff-filter exclusion

 Belated doc update for a feature added in v1.8.5.


* jc/renormalize-merge-kill-safer-crlf (2016-07-12) 2 commits
  (merged to 'next' on 2016-07-13 at c243dd6)
 + merge: avoid "safer crlf" during recording of merge results
 + convert: unify the "auto" handling of CRLF
 (this branch is tangled with tb/convert-peek-in-index.)

 "git merge" with renormalization did not work well with
 merge-recursive, due to "safer crlf" conversion kicking in when it
 shouldn't.


* jk/push-scrub-url (2016-07-20) 2 commits
  (merged to 'next' on 2016-07-20 at 22bb7ed)
 + t5541: fix url scrubbing test when GPG is not set
  (merged to 'next' on 2016-07-19 at 6ada3f1)
 + push: anonymize URL in status output

 "git fetch http://user:pass@host/repo..." scrubbed the userinfo
 part, but "git push" didn't.


* js/fsck-name-object (2016-07-18) 4 commits
  (merged to 'next' on 2016-07-19 at 6f39d2f)
 + fsck: optionally show more helpful info for broken links
 + fsck: give the error function a chance to see the fsck_options
 + fsck_walk(): optionally name objects on the go
 + fsck: refactor how to describe objects

 When "git fsck" reports a broken link (e.g. a tree object contains
 a blob that does not exist), both containing object and the object
 that is referred to were reported with their 40-hex object names.
 The command learned the "--name-objects" option to show the path to
 the containing object from existing refs (e.g. "HEAD~24^2:file.txt").


* js/ignore-space-at-eol (2016-07-11) 2 commits
  (merged to 'next' on 2016-07-13 at 429dd83)
 + diff: fix a double off-by-one with --ignore-space-at-eol
 + diff: demonstrate a bug with --patience and --ignore-space-at-eol

 An age old bug that caused "git diff --ignore-space-at-eol"
 misbehave has been fixed.


* ls/travis-enable-httpd-tests (2016-07-12) 1 commit
  (merged to 'next' on 2016-07-13 at 06fa12e)
 + travis-ci: enable web server tests t55xx on Linux

 Allow http daemon tests in Travis CI tests.


* mh/blame-worktree (2016-07-18) 2 commits
  (merged to 'next' on 2016-07-19 at 4c39534)
 + t/t8003-blame-corner-cases.sh: Use here documents
 + blame: allow to blame paths freshly added to the index

 "git blame file" allowed the lineage of lines in the uncommitted,
 unadded contents of "file" to be inspected, but it refused when
 "file" did not appear in the current commit.  When "file" was
 created by renaming an existing file (but the change has not been
 committed), this restriction was unnecessarily tight.


* mh/ref-iterators (2016-06-20) 13 commits
  (merged to 'next' on 2016-07-13 at a5b4e62)
 + for_each_reflog(): reimplement using iterators
 + dir_iterator: new API for iterating over a directory tree
 + for_each_reflog(): don't abort for bad references
 + do_for_each_ref(): reimplement using reference iteration
 + refs: introduce an iterator interface
 + ref_resolves_to_object(): new function
 + entry_resolves_to_object(): rename function from ref_resolves_to_object()
 + get_ref_cache(): only create an instance if there is a submodule
 + remote rm: handle symbolic refs correctly
 + delete_refs(): add a flags argument
 + refs: use name "prefix" consistently
 + do_for_each_ref(): move docstring to the header file
 + refs: remove unnecessary "extern" keywords
 (this branch is used by mh/ref-store; uses mh/split-under-lock; is tangled with mh/update-ref-errors.)

 The API to iterate over all the refs (i.e. for_each_ref(), etc.)
 has been revamped.


* mh/split-under-lock (2016-06-13) 33 commits
  (merged to 'next' on 2016-07-13 at aa598af)
 + lock_ref_sha1_basic(): only handle REF_NODEREF mode
 + commit_ref_update(): remove the flags parameter
 + lock_ref_for_update(): don't resolve symrefs
 + lock_ref_for_update(): don't re-read non-symbolic references
 + refs: resolve symbolic refs first
 + ref_transaction_update(): check refname_is_safe() at a minimum
 + unlock_ref(): move definition higher in the file
 + lock_ref_for_update(): new function
 + add_update(): initialize the whole ref_update
 + verify_refname_available(): adjust constness in declaration
 + refs: don't dereference on rename
 + refs: allow log-only updates
 + delete_branches(): use resolve_refdup()
 + ref_transaction_commit(): correctly report close_ref() failure
 + ref_transaction_create(): disallow recursive pruning
 + refs: make error messages more consistent
 + lock_ref_sha1_basic(): remove unneeded local variable
 + read_raw_ref(): move docstring to header file
 + read_raw_ref(): improve docstring
 + read_raw_ref(): rename symref argument to referent
 + read_raw_ref(): clear *type at start of function
 + read_raw_ref(): rename flags argument to type
 + ref_transaction_commit(): remove local variables n and updates
 + rename_ref(): remove unneeded local variable
 + commit_ref_update(): write error message to *err, not stderr
 + refname_is_safe(): insist that the refname already be normalized
 + refname_is_safe(): don't allow the empty string
 + refname_is_safe(): use skip_prefix()
 + remove_dir_recursively(): add docstring
 + safe_create_leading_directories(): improve docstring
 + read_raw_ref(): don't get confused by an empty directory
 + commit_ref(): if there is an empty dir in the way, delete it
 + t1404: demonstrate a bug resolving references
 (this branch is used by mh/ref-iterators, mh/ref-store and mh/update-ref-errors.)

 Further preparatory work on the refs API before the pluggable
 backend series can land.


* mh/update-ref-errors (2016-06-20) 6 commits
  (merged to 'next' on 2016-07-13 at 53482fa)
 + lock_ref_for_update(): avoid a symref resolution
 + lock_ref_for_update(): make error handling more uniform
 + t1404: add more tests of update-ref error handling
 + t1404: document function test_update_rejected
 + t1404: remove "prefix" argument to test_update_rejected
 + t1404: rename file to t1404-update-ref-errors.sh
 (this branch uses mh/split-under-lock; is tangled with mh/ref-iterators and mh/ref-store.)

 Error handling in the codepaths that updates refs has been
 improved.


* nd/cache-tree-ita (2016-07-18) 4 commits
  (merged to 'next' on 2016-07-19 at 512fd96)
 + cache-tree: do not generate empty trees as a result of all i-t-a subentries
 + cache-tree.c: fix i-t-a entry skipping directory updates sometimes
 + test-lib.sh: introduce and use $EMPTY_BLOB
 + test-lib.sh: introduce and use $EMPTY_TREE

 "git add -N dir/file && git write-tree" produced an incorrect tree
 when there are other paths in the same directory that sorts after
 "file".


* nd/test-helpers (2016-07-11) 3 commits
  (merged to 'next' on 2016-07-19 at 78ef465)
 + t/test-lib.sh: fix running tests with --valgrind
 + Makefile: use VCSSVN_LIB to refer to svn library
 + Makefile: drop extra dependencies for test helpers

 Build clean-up.


* rs/rm-strbuf-optim (2016-07-12) 1 commit
  (merged to 'next' on 2016-07-13 at 5b71fc8)
 + rm: reuse strbuf for all remove_dir_recursively() calls

 The use of strbuf in "git rm" to build filename to remove was a bit
 suboptimal, which has been fixed.


* rs/use-strbuf-addbuf (2016-07-22) 2 commits
  (merged to 'next' on 2016-07-22 at efbf09b)
 + strbuf: avoid calling strbuf_grow() twice in strbuf_addbuf()
  (merged to 'next' on 2016-07-19 at 679f992)
 + use strbuf_addbuf() for appending a strbuf to another

 Code cleanup.


* rs/worktree-use-strbuf-absolute-path (2016-07-12) 1 commit
  (merged to 'next' on 2016-07-13 at e8c9c02)
 + worktree: use strbuf_add_absolute_path() directly

 Code simplification.


* rw/make-needs-librt (2016-07-11) 2 commits
  (merged to 'next' on 2016-07-13 at 7fafd37)
 + config.mak.uname: define NEEDS_LIBRT under Linux, for now
 + Makefile: add NEEDS_LIBRT to optionally link with librt

 Makefile assumed that -lrt is always available on platforms that
 want to use clock_gettime() and CLOCK_MONOTONIC, which is not a
 case for recent Mac OS X.  The necessary symbols are often found in
 libc on many modern systems and having -lrt on the command line, as
 long as the library exists, had no effect, but when the platform
 removes librt.a that is a different matter--having -lrt will break
 the linkage.

 This change could be seen as a regression for those who do need to
 specify -lrt, as they now specifically ask for NEEDS_LIBRT when
 building. Hopefully they are in the minority these days.

--------------------------------------------------
[New Topics]

* jc/grep-commandline-vs-configuration (2016-07-25) 1 commit
 - grep: further simplify setting the pattern type

 "git -c grep.patternType=extended log --basic-regexp" misbehaved
 because the internal API to access the grep machinery was not
 designed well.

 Will merge to 'next'.


* jk/diff-do-not-reuse-wtf-needs-cleaning (2016-07-22) 1 commit
 - diff: do not reuse worktree files that need "clean" conversion

 There is an optimization used in "git diff $treeA $treeB" to borrow
 an already checked-out copy in the working tree when it is known to
 be the same as the blob being compared, expecting that open/mmap of
 such a file is faster than reading it from the object store, which
 involves inflating and applying delta.  This however kicked in even
 when the checked-out copy needs to go through the convert-to-git
 conversion (including the clean filter), which defeats the whole
 point of the optimization.  The optimization has been disabled when
 the conversion is necessary.

 Will merge to 'next'.


* jk/git-jump (2016-07-22) 3 commits
 - contrib/git-jump: fix typo in README
 - contrib/git-jump: add whitespace-checking mode
 - contrib/git-jump: fix greedy regex when matching hunks

 "git jump" script (in contrib/) has been updated a bit.

 Will merge to 'next'.


* jk/parse-options-concat (2016-07-06) 1 commit
 - parse_options: allocate a new array when concatenating

 Users of the parse_options_concat() API function needs to allocate
 extra slots in advance and fill them with OPT_END() when they want
 to decide the set of options to support dynamically, which is
 error-prone and hard to read.  This has been corrected by tweaking
 the API to allocate and return a new copy of "struct option" array.

 Will merge to 'next'.


* jk/push-progress (2016-07-20) 12 commits
 - receive-pack: send keepalives during quiet periods
 - receive-pack: turn on connectivity progress
 - receive-pack: relay connectivity errors to sideband
 - receive-pack: turn on index-pack resolving progress
 - index-pack: add flag for showing delta-resolution progress
 - clone: use a real progress meter for connectivity check
 - check_connected: add progress flag
 - check_connected: relay errors to alternate descriptor
 - check_everything_connected: use a struct with named options
 - check_everything_connected: convert to argv_array
 - rev-list: add optional progress reporting
 - check_everything_connected: always pass --quiet to rev-list

 "git push" and "git clone" learned to give better progress meters
 to the end user who is waiting on the terminal.

 Will merge to 'next'.


* jk/reflog-date (2016-07-22) 6 commits
 - date: add "unix" format
 - date: document and test "raw-local" mode
 - doc/pretty-formats: explain shortening of %gd
 - doc/pretty-formats: describe index/time formats for %gd
 - doc/rev-list-options: explain "-g" output formats
 - doc/rev-list-options: clarify "commit@{Nth}" for "-g" option

 The reflog output format is documented better, and a new format
 --date=unix to report the seconds-since-epoch (without timezone)
 has been added.

 Will merge to 'next'.


* mm/status-suggest-merge-abort (2016-07-22) 1 commit
 - status: suggest 'git merge --abort' when appropriate

 "git status" learned to suggest "merge --abort" during a conflicted
 merge, just like it already suggests "rebase --abort" during a
 conflicted rebase.

 Will merge to 'next'.


* pm/build-persistent-https-with-recent-go (2016-07-22) 2 commits
 - contrib/persistent-https: use Git version for build label
 - contrib/persistent-https: update ldflags syntax for Go 1.7+

 The build procedure for "git persistent-https" helper (in contrib/)
 has been updated so that it can be built with more recent versions
 of Go.

 Will merge to 'next'.


* sb/pack-protocol-doc-nak (2016-07-22) 1 commit
 - Documentation: pack-protocol correct NAK response

 A doc update.

 Will merge to 'next'.


* sb/submodule-clone-retry (2016-07-22) 2 commits
 - submodule-helper: fix indexing in clone retry error reporting path
 - git-submodule: forward exit code of git-submodule--helper more faithfully

 An earlier tweak to make "submodule update" retry a failing clone
 of submodules was buggy and caused segfault, which has been fixed.

 Will merge to 'next'.


* ew/find-perl-on-freebsd-in-local (2016-07-25) 1 commit
 - config.mak.uname: set PERL_PATH for FreeBSD 5.0+

 Recent FreeBSD stopped making perl available at /usr/bin/perl;
 switch the default the built-in path to /usr/local/bin/perl on not
 too ancient FreeBSD releases.

 Will wait for bikeshedding to settle.


* ew/git-svn-http-tests (2016-07-25) 2 commits
 - git svn: migrate tests to use lib-httpd
 - t/t91*: do not say how to avoid the tests

 Reuse the lib-httpd test infrastructure when testing the subversion
 integration that interacts with subversion repositories served over
 the http:// protocol.

 Will merge to 'next'.


* jk/push-force-with-lease-creation (2016-07-25) 3 commits
 - push: allow pushing new branches with --force-with-lease
 - push: add shorthand for --force-with-lease branch creation
 - Documentation/git-push: fix placeholder formatting

 "git push --force-with-lease" already had enough logic to allow
 ensuring that such a push results in creation of a ref (i.e. the
 receiving end did not have another push from sideways that would be
 discarded by our force-pushing), but didn't expose this possibility
 to the users.  It does so now.

 Perhaps needs s/memset/hashclr/, but other than that looked good.

--------------------------------------------------
[Stalled]

* cc/apply-am (2016-06-28) 41 commits
 - apply: use error_errno() where possible
 - builtin/am: use apply api in run_apply()
 - apply: change error_routine when be_silent is set
 - usage: add get_error_routine() and get_warn_routine()
 - usage: add set_warn_routine()
 - apply: don't print on stdout when be_silent is set
 - apply: make 'be_silent' incompatible with 'apply_verbosely'
 - apply: add 'be_silent' variable to 'struct apply_state'
 - write_or_die: use warning() instead of fprintf(stderr, ...)
 - environment: add set_index_file()
 - apply: make some parsing functions static again
 - apply: move libified code from builtin/apply.c to apply.{c,h}
 - apply: rename and move opt constants to apply.h
 - builtin/apply: rename option parsing functions
 - builtin/apply: make create_one_file() return -1 on error
 - builtin/apply: make try_create_file() return -1 on error
 - builtin/apply: make write_out_results() return -1 on error
 - builtin/apply: make write_out_one_result() return -1 on error
 - builtin/apply: make create_file() return -1 on error
 - builtin/apply: make add_index_file() return -1 on error
 - builtin/apply: make add_conflicted_stages_file() return -1 on error
 - builtin/apply: make remove_file() return -1 on error
 - builtin/apply: make build_fake_ancestor() return -1 on error
 - builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
 - builtin/apply: make gitdiff_*() return -1 on error
 - builtin/apply: make gitdiff_*() return 1 at end of header
 - builtin/apply: make parse_traditional_patch() return -1 on error
 - builtin/apply: make apply_all_patches() return 128 or 1 on error
 - builtin/apply: move check_apply_state() to apply.c
 - builtin/apply: make check_apply_state() return -1 instead of die()ing
 - apply: make init_apply_state() return -1 instead of exit()ing
 - builtin/apply: move init_apply_state() to apply.c
 - builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
 - builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
 - builtin/apply: make parse_single_patch() return -1 on error
 - builtin/apply: make parse_chunk() return a negative integer on error
 - builtin/apply: make find_header() return -128 instead of die()ing
 - builtin/apply: read_patch_file() return -1 instead of die()ing
 - builtin/apply: make apply_patch() return -1 or -128 instead of die()ing
 - apply: move 'struct apply_state' to apply.h
 - apply: make some names more specific
 (this branch is used by jh/clean-smudge-annex.)

 "git am" has been taught to make an internal call to "git apply"'s
 innards without spawning the latter as a separate process.

 Needs review.


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


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


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

--------------------------------------------------
[Cooking]

* ew/daemon-socket-keepalive (2016-07-22) 2 commits
  (merged to 'next' on 2016-07-22 at d39c827)
 + Windows: add missing definition of ENOTSOCK
  (merged to 'next' on 2016-07-19 at 0140849)
 + daemon: ignore ENOTSOCK from setsockopt

 Recent update to "git daemon" tries to enable the socket-level
 KEEPALIVE, but when it is spawned via inetd, the standard input
 file descriptor may not necessarily be connected to a socket.
 Suppress an ENOTSOCK error from setsockopt().

 Will merge to 'master'.


* jt/fetch-large-handshake-window-on-http (2016-07-19) 1 commit
 - fetch-pack: grow stateless RPC windows exponentially

 "git fetch" exchanges batched have/ack messages between the sender
 and the receiver, initially doubling every time and then falling
 back to use the maximum window size.  The "smart http" transport,
 being an half-duplex protocol, outgrows the preset limit too
 quickly and becomes inefficient when interacting with a large
 repository.  The internal mechanism learned to grow the window size
 more aggressively when working with the "smart http" transport.

 Will merge to 'next'.


* ew/svn-authorsprog-doc (2016-07-19) 1 commit
 - git-svn: document svn.authorsProg in config

 Belated doc update.

 Perhaps I will get a copy of this directly from Eric together with
 other updates to git-svn, in which case this needs to be scrapped.


* rs/submodule-config-code-cleanup (2016-07-19) 1 commit
  (merged to 'next' on 2016-07-19 at 59dbd58)
 + submodule-config: use explicit empty string instead of strbuf in config_from()

 Code cleanup.

 Will merge to 'master'.


* js/am-3-merge-recursive-direct (2016-07-22) 16 commits
 - merge-recursive: flush output buffer even when erroring out
 - merge_trees(): ensure that the output buffer is released after calling merge_trees()
 - merge-recursive: offer an option to retain the output in 'obuf'
 - merge-recursive: write the commit title in one go
 - merge-recursive: flush output buffer before printing error messages
 - am -3: use merge_recursive() directly again
 - merge-recursive: switch to returning errors instead of dying
 - merge-recursive: handle return values indicating errors
 - merge-recursive: allow write_tree_from_memory() to error out
 - merge-recursive: avoid returning a wholesale struct
 - merge_recursive: abort properly upon errors
 - prepare the builtins for a libified merge_recursive()
 - merge-recursive: clarify code in was_tracked()
 - die(_("BUG")): avoid translating bug messages
 - die("bug"): report bugs consistently
 - t5520: verify that `git pull --rebase` shows the helpful advice when failing

 "git am -3" calls "git merge-recursive" when it needs to fall back
 to a three-way merge; this call has been turned into an internal
 subroutine call instead of spawning a separate subprocess.

 Rerolled.
 Needs review.
 I started re-reading them, but I do want eyes from other people.


* nd/pack-ofs-4gb-limit (2016-07-13) 7 commits
  (merged to 'next' on 2016-07-13 at 91e217d)
 + fsck: use streaming interface for large blobs in pack
 + pack-objects: do not truncate result in-pack object size on 32-bit systems
 + index-pack: correct "offset" type in unpack_entry_data()
 + index-pack: report correct bad object offsets even if they are large
 + index-pack: correct "len" type in unpack_data()
 + sha1_file.c: use type off_t* for object_info->disk_sizep
 + pack-objects: pass length to check_pack_crc() without truncation

 "git pack-objects" and "git index-pack" mostly operate with off_t
 when talking about the offset of objects in a packfile, but there
 were a handful of places that used "unsigned long" to hold that
 value, leading to an unintended truncation.

 Will merge to 'master'.


* sb/push-options (2016-07-14) 4 commits
  (merged to 'next' on 2016-07-19 at ee9a83a)
 + add a test for push options
 + push: accept push options
 + receive-pack: implement advertising and receiving push options
 + push options: {pre,post}-receive hook learns about push options

 "git push" learned to accept and pass extra options to the
 receiving end so that hooks can read and react to them.

 Will merge to 'master'.


* ew/http-walker (2016-07-18) 4 commits
  (merged to 'next' on 2016-07-18 at a430a97)
 + list: avoid incompatibility with *BSD sys/queue.h
  (merged to 'next' on 2016-07-13 at 8585c03)
 + http-walker: reduce O(n) ops with doubly-linked list
 + http: avoid disconnecting on 404s for loose objects
 + http-walker: remove unused parameter from fetch_object

 Optimize dumb http transport on the client side.

 Will merge to 'master'.


* nd/log-decorate-color-head-arrow (2016-07-12) 1 commit
 - log: decorate HEAD -> branch with the same color for arrow and HEAD

 An entry "git log --decorate" for the tip of the current branch is
 shown as "HEAD -> name" (where "name" is the name of the branch);
 paint the arrow in the same color as "HEAD", not in the color for
 commits.

 Comments?  Personally I find it more-or-less "Meh".


* jh/clean-smudge-annex (2016-07-12) 9 commits
 - use smudgeToFile filter in recursive merge
 - use smudgeToFile filter in git am
 - better recovery from failure of smudgeToFile filter
 - warn on unusable smudgeToFile/cleanFromFile config
 - use smudgeToFile in git checkout etc
 - use cleanFromFile in git add
 - add smudgeToFile and cleanFromFile filter configs
 - clarify %f documentation
 - Merge branch 'cc/apply-am' into jh/clean-smudge-annex
 (this branch uses cc/apply-am.)

 The interface to "clean/smudge" filters require Git to feed the
 whole contents via pipe, which is suboptimal for some applications.
 "cleanFromFile/smudgeToFile" commands are the moral equilvalents
 for these filters but they interact with the files on the
 filesystem directly.

 Will hold.


* js/rebase-i-tests (2016-07-07) 3 commits
  (merged to 'next' on 2016-07-13 at b06b28f)
 + rebase -i: we allow extra spaces after fixup!/squash!
 + rebase -i: demonstrate a bug with --autosquash
 + t3404: add a test for the --gpg-sign option

 A few tests that specifically target "git rebase -i" have been
 added.

 Will merge to 'master'.


* rs/notes-merge-no-toctou (2016-07-07) 1 commit
  (merged to 'next' on 2016-07-13 at f08b530)
 + notes-merge: use O_EXCL to avoid overwriting existing files

 "git notes merge" had a code to see if a path exists (and fails if
 it does) and then open the path for writing (when it doesn't).
 Replace it with open with O_EXCL.

 Will merge to 'master'.


* jk/difftool-in-subdir (2016-07-19) 4 commits
 - difftool: use Git::* functions instead of passing around state
 - SQUASH???
 - difftool: avoid $GIT_DIR and $GIT_WORK_TREE
 - difftool: fix argument handling in subdirs

 "git difftool <paths>..." started in a subdirectory failed to
 interpret the paths relative to that directory, which has been
 fixed.


* dp/autoconf-curl-ssl (2016-06-28) 1 commit
 - ./configure.ac: detect SSL in libcurl using curl-config

 The ./configure script generated from configure.ac was taught how
 to detect support of SSL by libcurl better.

 Needs review.


* jc/pull-rebase-ff (2016-06-29) 1 commit
 -   pull: fast-forward "pull --rebase=true"

 "git pull --rebase", when there is no new commits on our side since
 we forked from the upstream, should be able to fast-forward without
 invoking "git rebase", but it didn't.

 Needs a real log message and a few tests.


* po/range-doc (2016-07-20) 8 commits
 - doc: revisions - clarify reachability examples
 - doc: revisions - define `reachable`
 - doc: gitrevisions - clarify 'latter case' is revision walk
 - doc: gitrevisions - use 'reachable' in page description
 - doc: give headings for the two and three dot notations
 - doc: show the actual left, right, and boundary marks
 - doc: revisions - name the left and right sides
 - doc: use 'symmetric difference' consistently

 Clarify various ways to specify the "revision ranges" in the
 documentation.

 Updates in 4/8 ("give headings") is reported to break formatting?
 ($gmane/300030)


* ex/deprecate-empty-pathspec-as-match-all (2016-06-22) 1 commit
  (merged to 'next' on 2016-07-13 at d9ca7fb)
 + pathspec: warn on empty strings as pathspec

 An empty string used as a pathspec element has always meant
 'everything matches', but it is too easy to write a script that
 finds a path to remove in $path and run 'git rm "$paht"', which
 ends up removing everything.  Start warning about this use of an
 empty string used for 'everything matches' and ask users to use a
 more explicit '.' for that instead.

 The hope is that existing users will not mind this change, and
 eventually the warning can be turned into a hard error, upgrading
 the deprecation into removal of this (mis)feature.

 Will hold to see if people scream.


* mh/ref-store (2016-06-20) 38 commits
 - refs: implement iteration over only per-worktree refs
 - refs: make lock generic
 - refs: add method to rename refs
 - refs: add methods to init refs db
 - refs: make delete_refs() virtual
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add method iterator_begin
 - files_ref_iterator_begin(): take a ref_store argument
 - split_symref_update(): add a files_ref_store argument
 - lock_ref_sha1_basic(): add a files_ref_store argument
 - lock_ref_for_update(): add a files_ref_store argument
 - commit_ref_update(): add a files_ref_store argument
 - lock_raw_ref(): add a files_ref_store argument
 - repack_without_refs(): add a files_ref_store argument
 - refs: make peel_ref() virtual
 - refs: make create_symref() virtual
 - refs: make pack_refs() virtual
 - refs: make verify_refname_available() virtual
 - refs: make read_raw_ref() virtual
 - resolve_gitlink_ref(): rename path parameter to submodule
 - resolve_gitlink_ref(): avoid memory allocation in many cases
 - resolve_gitlink_ref(): implement using resolve_ref_recursively()
 - resolve_ref_recursively(): new function
 - read_raw_ref(): take a (struct ref_store *) argument
 - resolve_gitlink_packed_ref(): remove function
 - resolve_packed_ref(): rename function from resolve_missing_loose_ref()
 - refs: reorder definitions
 - refs: add a transaction_commit() method
 - {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
 - resolve_missing_loose_ref(): add a files_ref_store argument
 - get_packed_ref(): add a files_ref_store argument
 - add_packed_ref(): add a files_ref_store argument
 - refs: create a base class "ref_store" for files_ref_store
 - refs: add a backend method structure
 - refs: rename struct ref_cache to files_ref_store
 - rename_ref_available(): add docstring
 - resolve_gitlink_ref(): eliminate temporary variable

 The ref-store abstraction was introduced to the refs API so that we
 can plug in different backends to store references.

 Needs a fixup.
 ($gmane/298137)


* jc/blame-reverse (2016-06-14) 2 commits
 - blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
 - blame: improve diagnosis for "--reverse NEW"

 It is a common mistake to say "git blame --reverse OLD path",
 expecting that the command line is dwimmed as if asking how lines
 in path in an old revision OLD have survived up to the current
 commit.

 Any supporters?  Otherwise will drop.


* nd/shallow-deepen (2016-06-13) 27 commits
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
 - upload-pack: make check_non_tip() clean things up on error
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

 Rerolled.  What this topic attempts to achieve is worthwhile, I
 would think.


* jc/attr-more (2016-06-09) 8 commits
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - fixup! d5ad6c13
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 (this branch uses jc/attr; is tangled with sb/pathspec-label and sb/submodule-default-paths.)

 The beginning of long and tortuous journey to clean-up attribute
 subsystem implementation.

 Needs to be redone.


* mh/connect (2016-06-06) 10 commits
 - connect: [host:port] is legacy for ssh
 - connect: move ssh command line preparation to a separate function
 - connect: actively reject git:// urls with a user part
 - connect: change the --diag-url output to separate user and host
 - connect: make parse_connect_url() return the user part of the url as a separate value
 - connect: group CONNECT_DIAG_URL handling code
 - connect: make parse_connect_url() return separated host and port
 - connect: re-derive a host:port string from the separate host and port variables
 - connect: call get_host_and_port() earlier
 - connect: document why we sometimes call get_port after get_host_and_port

 Rewrite Git-URL parsing routine (hopefully) without changing any
 behaviour.

 Comments?


* nd/worktree-lock (2016-07-08) 6 commits
  (merged to 'next' on 2016-07-13 at c768a85)
 + worktree.c: find_worktree() search by path suffix
 + worktree: add "unlock" command
 + worktree: add "lock" command
 + worktree.c: add is_worktree_locked()
 + worktree.c: add is_main_worktree()
 + worktree.c: add find_worktree()

 "git worktree prune" protected worktrees that are marked as
 "locked" by creating a file in a known location.  "git worktree"
 command learned a dedicated command pair to create and remoev such
 a file, so that the users do not have to do this with editor.

 Will merge to 'master'.


* sb/submodule-default-paths (2016-06-20) 5 commits
 - completion: clone can recurse into submodules
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - Merge branch 'sb/pathspec-label' into sb/submodule-default-paths
 - Merge branch 'jc/attr' into sb/submodule-default-paths
 (this branch uses jc/attr and sb/pathspec-label; is tangled with jc/attr-more.)

 Allow specifying the set of submodules the user is interested in on
 the command line of "git clone" that clones the superproject.


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
 (this branch is used by jc/attr-more, sb/pathspec-label and sb/submodule-default-paths.)

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.

 I wanted to polish this topic further to make the attribute
 subsystem thread-ready, but because other topics depend on this
 topic and they do not (yet) need it to be thread-ready, let's merge
 this early part together with the dependent topics to 'next', and
 back-burner the threading enhancement to another day.


* pb/bisect (2016-07-12) 9 commits
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 GSoC "bisect" topic.

 Are people happy with this version?  How much of the planned
 "porting" is finished by this part of the work?  How much more to
 go?


* sb/pathspec-label (2016-06-03) 6 commits
 - pathspec: disable preload-index when attribute pathspec magic is in use
 - pathspec: allow escaped query values
 - pathspec: allow querying for attributes
 - pathspec: move prefix check out of the inner loop
 - pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 (this branch is used by sb/submodule-default-paths; uses jc/attr; is tangled with jc/attr-more.)

 The pathspec mechanism learned ":(attr:X)$pattern" pathspec magic
 to limit paths that match $pattern further by attribute settings.
 The preload-index mechanism is disabled when the new pathspec magic
 is in use (at least for now), because the attribute subsystem is
 not thread-ready.


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
 This also really needs review.


* dt/index-helper (2016-07-06) 21 commits
 - index-helper: indexhelper.exitAfter config
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
 - unix-socket.c: add stub implementation when unix sockets are not supported
 - pkt-line: add gentle version of packet_write
 - read-cache: allow to keep mmap'd memory after reading
 - read-cache.c: fix constness of verify_hdr()

 A new "index-helper" daemon has been introduced to give newly
 spawned Git process a quicker access to the data in the index, and
 optionally interface with the watchman daemon to further reduce the
 refresh cost.

 Not quite ready yet, it seems.
 ($gmane/298949, $gmane/299506)


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

 While I think it would make it easier for people to experiment and
 build on if the topic is merged to 'next', I am at the same time a
 bit reluctant to merge an unproven new topic that introduces a new
 file format, which we may end up having to support til the end of
 time.  Comments?


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

* ew/svn-bad-ref (2016-07-06) 1 commit
 . git-svn: warn instead of dying when commit data is missing

 Pulled directly from upstream hence discarded.


* tb/convert-peek-in-index (2016-07-07) 2 commits
 . correct ce_compare_data() in a middle of a merge
 . read-cache: factor out get_sha1_from_index() helper

 Discarded and replaced by jc/renormalize-merge-kill-safer-crlf
