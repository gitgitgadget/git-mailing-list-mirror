Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DE3C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 04:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A2F61058
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 04:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhG0E4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 00:56:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61087 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbhG0EzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 00:55:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7311C9336;
        Tue, 27 Jul 2021 00:55:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=K3XoQbUlO99VswaLZwWcM1M68
        /I8r8Fpj18yzvzarpc=; b=nOF8WaP4u6CKLOe5H5/KH/n4uznQA5Cj9BZKGW9gI
        XuTJIBwSYEji+6U1mE6sg78VtSivYaJbu6oqeoirQwsPEstZUWMS+f15Ljkfxq62
        /uiHAdVmMXKUZSK83YSdP2odDq+Np946oJ0p5mxRSGzxsQUI4hnFujWcF023RkQK
        iw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE72FC9335;
        Tue, 27 Jul 2021 00:55:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11A46C9334;
        Tue, 27 Jul 2021 00:55:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2021, #06; Mon, 26)
X-master-at: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
X-next-at: 689316a459d26cd93a42ae056635db0b760bb0e9
Date:   Mon, 26 Jul 2021 21:55:15 -0700
Message-ID: <xmqq35s0fj9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D5974814-EE96-11EB-8052-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen',
which means nothing more than that I have found them of interest for
some reason (like "it may have hard-to-resolve conflicts with
another topic already in flight" or "this may turn out to be
useful").  Do not read too much into a topic being in (or not in)
'seen'.  The ones marked with '.' do not appear in any of the
integration branches, but I am still holding onto them.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* ab/gitignore-discovery-doc (2021-07-06) 1 commit
  (merged to 'next' on 2021-07-13 at 02f3b3deab)
 + docs: .gitignore parsing is to the top of the repo

 Doc update.


* ab/imap-send-read-everything-simplify (2021-07-07) 1 commit
  (merged to 'next' on 2021-07-13 at ab59128bfb)
 + imap-send.c: use less verbose strbuf_fread() idiom

 Code simplification.


* ab/send-email-optim (2021-05-28) 13 commits
  (merged to 'next' on 2021-07-08 at 35ac315894)
 + perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
 + send-email: move trivial config handling to Perl
 + perl: lazily load some common Git.pm setup code
 + send-email: lazily load modules for a big speedup
 + send-email: get rid of indirect object syntax
 + send-email: use function syntax instead of barewords
 + send-email: lazily shell out to "git var"
 + send-email: lazily load config for a big speedup
 + send-email: copy "config_regxp" into git-send-email.perl
 + send-email: refactor sendemail.smtpencryption config parsing
 + send-email: remove non-working support for "sendemail.smtpssl"
 + send-email tests: test for boolean variables without a value
 + send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=3Dtrue

 "git send-email" optimization.


* bc/rev-list-without-commit-line (2021-07-12) 1 commit
  (merged to 'next' on 2021-07-13 at 1ceed60061)
 + rev-list: add option for --pretty=3Dformat without header

 "git rev-list" learns to omit the "commit <object-name>" header
 lines from the output with the `--no-commit-header` option.


* jk/typofix (2021-07-13) 1 commit
  (merged to 'next' on 2021-07-13 at cce3caa34e)
 + doc/rev-list-options: fix duplicate word typo

 Typofix.


* js/ci-windows-update (2021-07-06) 7 commits
  (merged to 'next' on 2021-07-13 at 329771e960)
 + ci: accelerate the checkout
 + ci (vs-build): build with NO_GETTEXT
 + artifacts-tar: respect NO_GETTEXT
 + ci (windows): transfer also the Git-tracked files to the test jobs
 + ci: upgrade to using actions/{up,down}load-artifacts v2
 + ci (vs-build): use `cmd` to copy the DLLs, not `powershell`
 + ci: use the new GitHub Action to download git-sdk-64-minimal

 GitHub Actions / CI update.

--------------------------------------------------
[New Topics]

* ab/http-drop-old-curl (2021-07-21) 5 commits
 - http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
 - http: drop support for curl < 7.19.3 and < 7.16.4 (again)
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Support for ancient versions of cURL library has been dropped.

 Expecting a hopefully final reroll to correct log messages.


* ab/lib-subtest (2021-07-21) 10 commits
 - test-lib tests: assert 1 exit code, not non-zero
 - test-lib tests: refactor common part of check_sub_test_lib_test*()
 - test-lib tests: avoid subshell for "test_cmp" for readability
 - test-lib tests: get rid of copy/pasted mock test code
 - test-lib tests: don't provide a description for the sub-tests
 - test-lib tests: stop using a subshell in write_sub_test_lib_test()
 - test-lib tests: split up "write and run" into two functions
 - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
 - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
 - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest
 (this branch uses jk/t0000-subtests-fix and ps/t0000-output-directory-fi=
x.)

 Updates to the tests in t0000 to test th etest framework.


* ds/add-with-sparse-index (2021-07-26) 5 commits
 - add: remove ensure_full_index() with --renormalize
 - add: ignore outside the sparse-checkout in refresh()
 - pathspec: stop calling ensure_full_index
 - add: allow operating on a sparse-only index
 - t1092: test merge conflicts outside cone
 (this branch uses ds/commit-and-checkout-with-sparse-index and ds/status=
-with-sparse-index.)

 "git add" can work better with the sparse index.


* fc/pull-no-rebase-merges-theirs-into-ours (2021-07-21) 1 commit
 - doc: pull: fix rebase=3Dfalse documentation

 Documentation fix for "git pull --rebase=3Dno".

 Will merge to 'next'.


* ab/only-single-progress-at-once (2021-07-23) 8 commits
 - progress.c: add & assert a "global_progress" variable
 - pack-bitmap-write.c: add a missing stop_progress()
 - progress.c: add temporary variable from progress struct
 - progress.c: stop eagerly fflush(stderr) when not a terminal
 - progress.c: call progress_interval() from progress_test_force_update()
 - progress.c: move signal handler functions lower
 - progress.c tests: test some invalid usage
 - progress.c tests: make start/stop verbs on stdin

 Further tweaks on progress API.


* ab/progress-users-adjust-counters (2021-07-23) 3 commits
 - entry: show finer-grained counter in "Filtering content" progress line
 - midx: don't provide a total for QSORT() progress
 - commit-graph: fix bogus counter in "Scanning merged commits" progress =
line

 The code to show progress indicator in a few codepaths did not
 cover between 0-100%, which has been corrected.

 Will merge to 'next'.


* ar/submodule-add-config (2021-07-26) 1 commit
 - submodule--helper: introduce add-config subcommand
 (this branch uses ar/submodule-add.)

 Large part of "git submodule add" gets rewritten in C.


* en/ort-perf-batch-15 (2021-07-23) 7 commits
 - merge-ort: reuse path strings in pool_alloc_filespec
 - merge-ort: store filepairs and filespecs in our mem_pool
 - diffcore-rename, merge-ort: add wrapper functions for filepair alloc/d=
ealloc
 - merge-ort: switch our strmaps over to using memory pools
 - merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
 - merge-ort: set up a memory pool
 - diffcore-rename: use a mem_pool for exact rename detection's hashmap
 (this branch uses en/ort-perf-batch-14.)

 Final batch for "merge -sort" optimization.


* hn/refs-test-cleanup-contd (2021-07-22) 6 commits
 - t6001: avoid direct file system access
 - t6500: use "ls -1" to snapshot ref database state
 - t7064: use update-ref -d to remove upstream branch
 - t1410: mark test as REFFILES
 - t1405: mark test for 'git pack-refs' as REFFILES
 - t1405: use 'git reflog exists' to check reflog existence
 (this branch uses hn/refs-test-cleanup.)

 More test clean-up around refs

 Probably I should combine this into the base topic and have them
 graduate together.


* jk/check-pack-valid-before-opening-bitmap (2021-07-23) 1 commit
 - pack-bitmap: check pack validity when opening bitmap

 A race between repacking and using pack bitmaps has been corrected.

 Will merge to 'next'.


* jt/bulk-prefetch (2021-07-23) 2 commits
 - cache-tree: prefetch in partial clone read-tree
 - unpack-trees: refactor prefetching code

 "git read-tree" had a codepath where blobs are fetched one-by-one
 from the promisor remote, which has been corrected to fetch in bulk.

 Will merge to 'next'.


* pb/merge-autostash-more (2021-07-23) 4 commits
 - merge: apply autostash if merge strategy fails
 - merge: apply autostash if fast-forward fails
 - Documentation: define 'MERGE_AUTOSTASH'
 - merge: add missing word "strategy" to a message

 The local changes stashed by "git merge --autostash" were lost when
 the merge failed in certain ways, which has been corrected.

 Will merge to 'next'.


* ah/plugleaks (2021-07-26) 12 commits
 - reset: clear_unpack_trees_porcelain to plug leak
 - builtin/rebase: fix options.strategy memory lifecycle
 - builtin/merge: free found_ref when done
 - builtin/mv: free or UNLEAK multiple pointers at end of cmd_mv
 - convert: release strbuf to avoid leak
 - read-cache: call diff_setup_done to avoid leak
 - ref-filter: also free head for ATOM_HEAD to avoid leak
 - diffcore-rename: move old_dir/new_dir definition to plug leak
 - builtin/for-each-repo: remove unnecessary argv copy to plug leak
 - builtin/submodule--helper: release unused strbuf to avoid leak
 - environment: move strbuf into block to plug leak
 - fmt-merge-msg: free newly allocated temporary strings when done

 Leak plugging.

 Will merge to 'next'.


* js/expand-runtime-prefix (2021-07-26) 6 commits
 - expand_user_path: allow in-flight topics to keep using the old name
 - interpolate_path(): allow specifying paths relative to the runtime pre=
fix
 - Use a better name for the function interpolating paths
 - expand_user_path(): clarify the role of the `real_home` parameter
 - expand_user_path(): remove stale part of the comment
 - tests: exercise the RUNTIME_PREFIX feature

 Pathname expansion (like "~username/") learned a way to specify a
 location relative to Git installation (e.g. its $sharedir which is
 $(prefix)/share), with "%(prefix)".


* zh/cherry-pick-help-is-only-for-sequencer (2021-07-26) 1 commit
 - cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP

 "git cherry-pick" loses its state file when a stray
 GIT_CHERRY_PICK_HELP environment is present, which has been
 corrected.


* dt/submodule-diff-fixes (2021-07-26) 3 commits
 - diff --submodule=3Ddiff: do not print failure message twice
 - diff --submodule=3Ddiff: do not fail on ever-initialied deleted submod=
ules
 - t4060: remove unused variable

 "git diff --submodule=3Ddiff" showed failure from run_command() when
 trying to run diff inside a submodule, when the user manually
 removes the submodule directory.

 It is clear that a problem exists, but it is unclear if the
 proposed solution is a desirable one.

--------------------------------------------------
[Stalled]

* ao/p4-avoid-decoding (2021-04-12) 2 commits
 - git-p4: do not decode data from perforce by default
 - git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Waiting for reviews.


* tv/p4-fallback-encoding (2021-04-30) 1 commit
 - git-p4: git-p4.fallbackEncoding to specify non UTF-8 charset

 "git p4" learns the fallbackEncoding configuration variable to
 safely accept changeset descriptions that aren't written in UTF-8.

 Waiting for reviews.

--------------------------------------------------
[Cooking]

* ab/bundle-tests (2021-07-22) 2 commits
  (merged to 'next' on 2021-07-22 at 053b5d0ecf)
 + bundle tests: use test_cmp instead of grep
 + bundle tests: use ">file" not ": >file"

 "git bundle" gained more test coverage.

 Will merge to 'master'.


* es/config-based-hooks (2021-07-20) 9 commits
 - hook: implement hookcmd.<name>.skip
 - hook: teach 'hookcmd' config to alias hook scripts
 - hook: allow out-of-repo 'git hook' invocations
 - hook: include hooks from the config
 - hook: allow running non-native hooks
 - hook: treat hookdir hook specially
 - hook: introduce "git hook list"
 - hook: allow parallel hook execution
 - hook: run a list of hooks instead
 (this branch uses ab/config-based-hooks-base.)

 The "hooks defined via the configuration variables" topic.


* fs/ssh-signing (2021-07-20) 10 commits
 - SQUASH???
 - ssh signing: add documentation
 - ssh signing: add more tests for logs, tags & push certs
 - ssh signing: duplicate t7510 tests for commits
 - ssh signing: add test prereqs
 - ssh signing: parse ssh-keygen output and verify signatures
 - ssh signing: provide a textual representation of the signing key
 - ssh signing: retrieve a default key from ssh-agent
 - ssh signing: add ssh signature format and signing using ssh keys
 - ssh signing: preliminary refactoring and clean-up

 Use ssh public crypto for object and push-cert signing.

 Seems to break tests when merged to 'seen'.


* hn/refs-debug-empty-prefix (2021-07-19) 1 commit
  (merged to 'next' on 2021-07-20 at 2772d3efb2)
 + refs/debug: quote prefix

 Debugging aid.

 Will merge to 'master'.


* pb/submodule-recurse-doc (2021-07-20) 1 commit
  (merged to 'next' on 2021-07-22 at 4129e89833)
 + doc: clarify description of 'submodule.recurse'

 Doc update.

 Will merge to 'master'.


* ps/t0000-output-directory-fix (2021-07-20) 1 commit
  (merged to 'next' on 2021-07-20 at 7e0b7c1f0c)
 + t0000: fix test if run with TEST_OUTPUT_DIRECTORY
 (this branch is used by ab/lib-subtest; uses jk/t0000-subtests-fix.)

 "TEST_OUTPUT_DIRECTORY=3Dthere make test" failed to work, which has
 been corrected.

 Will merge to 'master'.


* tb/bitmap-type-filter-comment-fix (2021-07-20) 1 commit
  (merged to 'next' on 2021-07-22 at 8428556149)
 + pack-bitmap: clarify comment in filter_bitmap_exclude_type()

 In-code comment update.

 Will merge to 'master'.


* tb/reverse-midx (2021-07-19) 1 commit
  (merged to 'next' on 2021-07-20 at 995cb54b5b)
 + multi-pack-index: fix potential segfault without sub-command

 The code that gives an error message in "git multi-pack-index" when
 no subcommand is given tried to print a NULL pointer as a strong,
 which has been corrected.

 Will merge to 'master'.


* hn/refs-test-cleanup (2021-07-19) 5 commits
  (merged to 'next' on 2021-07-22 at 2ab8bc259a)
 + t2402: use ref-store test helper to create broken symlink
 + t3320: use git-symbolic-ref rather than filesystem access
 + t6120: use git-update-ref rather than filesystem access
 + t1503: mark symlink test as REFFILES
 + t6050: use git-update-ref rather than filesystem access
 (this branch is used by hn/refs-test-cleanup-contd.)

 A handful of tests that assumed implementation details of files
 backend for refs have been cleaned up.

 Will merge to 'master'.


* hn/reftable (2021-07-20) 26 commits
 - t7004: avoid direct filesystem access
 - t1404: annotate test cases with REFFILES
 - t1401,t2011: parameterize HEAD.lock for REFFILES
 - t1301: document what needs to be done for reftable
 - Add "test-tool dump-reftable" command.
 - git-prompt: prepare for reftable refs backend
 - refs: RFC: Reftable support for git-core
 - reftable: add dump utility
 - reftable: implement stack, a mutable database of reftable files.
 - reftable: implement refname validation
 - reftable: add merged table view
 - reftable: add a heap-based priority queue for reftable records
 - reftable: reftable file level tests
 - reftable: read reftable files
 - reftable: generic interface to tables
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - Provide zlib's uncompress2 from compat/zlib-compat.c
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: RFC: add LICENSE
 - init-db: set the_repository->hash_algo early on
 - hash.h: provide constants for the hash IDs

 The "reftable" backend for the refs API.


* jk/config-env-doc (2021-07-20) 3 commits
  (merged to 'next' on 2021-07-22 at 45616c831e)
 + doc/git-config: simplify "override" advice for FILES section
 + doc/git-config: clarify GIT_CONFIG environment variable
 + doc/git-config: explain --file instead of referring to GIT_CONFIG

 Documentation around GIT_CONFIG has been updated.

 Will merge to 'master'.


* js/ci-check-whitespace-updates (2021-07-14) 2 commits
  (merged to 'next' on 2021-07-22 at cdc9aa0622)
 + ci(check-whitespace): restrict to the intended commits
 + ci(check-whitespace): stop requiring a read/write token

 CI update.

 Will merge to 'master'.


* js/ci-make-sparse (2021-07-26) 3 commits
  (merged to 'next' on 2021-07-26 at 689316a459)
 + ci/install-dependencies: handle "sparse" job package installs
 + ci: run "apt-get update" before "apt-get install"
  (merged to 'next' on 2021-07-20 at 99f518bdef)
 + ci: run `make sparse` as part of the GitHub workflow

 The CI gained a new job to run "make sparse" check.

 Will merge to 'master'.


* pb/dont-complete-aliased-options (2021-07-16) 1 commit
  (merged to 'next' on 2021-07-20 at bbc531c710)
 + parse-options: don't complete option aliases by default

 The completion support used to offer alternate spelling of options
 that exist only for compatibility, which has been corrected.

 Will merge to 'master'.


* ab/refs-files-cleanup (2021-07-26) 11 commits
 - refs/files: remove unused "errno !=3D ENOTDIR" condition
 - refs/files: remove unused "errno =3D=3D EISDIR" code
 - refs/files: remove unused "oid" in lock_ref_oid_basic()
 - reflog expire: don't lock reflogs using previously seen OID
 - refs/files: add a comment about refs_reflog_exists() call
 - refs: make repo_dwim_log() accept a NULL oid
 - refs/debug: re-indent argument list for "prepare"
 - refs/files: remove unused "skip" in lock_raw_ref() too
 - refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
 - refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
 - refs/packet: add missing BUG() invocations to reflog callbacks
 (this branch is used by hn/refs-errno-cleanup.)

 Patches are mostly good, but needs typofixes etc.

 Will merge to 'next'.


* en/pull-conflicting-options (2021-07-22) 8 commits
 - pull: fix handling of multiple heads
 - pull: update docs & code for option compatibility with rebasing
 - pull: abort by default when fast-forwarding is not possible
 - pull: make --rebase and --no-rebase override pull.ff=3Donly
 - pull: since --ff-only overrides, handle it first
 - pull: abort if --ff-only is given and fast-forwarding is impossible
 - t7601: add tests of interactions with multiple merge heads and config
 - t7601: test interaction of merge/rebase/fast-forward flags and options

 "git pull" had various corner cases that were not well thought out
 around its --rebase backend, e.g. "git pull --ff-only" did not stop
 but went ahead and rebased when the history on other side is not a
 descendant of our history.  The series tries to fix them up.


* jk/t0000-subtests-fix (2021-07-19) 1 commit
  (merged to 'next' on 2021-07-20 at 81412e1684)
 + t0000: clear GIT_SKIP_TESTS before running sub-tests
 (this branch is used by ab/lib-subtest and ps/t0000-output-directory-fix=
.)

 Test fix.

 Will merge to 'master'.


* dl/packet-read-response-end-fix (2021-07-09) 1 commit
  (merged to 'next' on 2021-07-16 at 6a7734b6b5)
 + pkt-line: replace "stateless separator" with "response end"

 Error message update.

 Will merge to 'master'.


* hj/commit-allow-empty-message (2021-07-09) 2 commits
  (merged to 'next' on 2021-07-16 at 86b79d3010)
 + commit: remove irrelavent prompt on `--allow-empty-message`
 + commit: reorganise commit hint strings

 "git commit --allow-empty-message" won't abort the operation upon
 an empty message, but the hint shown in the editor said otherwise.

 Will merge to 'master'.


* ab/attribute-format (2021-07-13) 5 commits
  (merged to 'next' on 2021-07-20 at 44e5606a6e)
 + advice.h: add missing __attribute__((format)) & fix usage
 + *.h: add a few missing __attribute__((format))
 + *.c static functions: add missing __attribute__((format))
 + sequencer.c: move static function to avoid forward decl
 + *.c static functions: don't forward-declare __attribute__

 Many "printf"-like helper functions we have have been annotated
 with __attribute__() to catch placeholder/parameter mismatches.

 Will merge to 'master'.


* dl/diff-merge-base (2021-07-12) 1 commit
  (merged to 'next' on 2021-07-20 at 013d013bcf)
 + git-diff: fix missing --merge-base docs

 "git diff --merge-base" documentation has been updated.

 Will merge to 'master'.


* en/rename-limits-doc (2021-07-15) 4 commits
  (merged to 'next' on 2021-07-20 at a89253d530)
 + rename: bump limit defaults yet again
 + diffcore-rename: treat a rename_limit of 0 as unlimited
 + doc: clarify documentation for rename/copy limits
 + diff: correct warning message when renameLimit exceeded

 Documentation on "git diff -l<n>" and diff.renameLimit have been
 updated, and the defaults for these limits have been raised.

 Will merge to 'master'.


* ab/pkt-line-tests (2021-07-19) 1 commit
  (merged to 'next' on 2021-07-20 at 8e5e53450c)
 + test-lib-functions: use test-tool for [de]packetize()

 Tests that cover protocol bits have been updated and helpers
 used there have been consolidated.

 Will merge to 'master'.


* bc/inactive-submodules (2021-07-02) 1 commit
 - submodule: mark submodules with update=3Dnone as inactive

 Usability update for inactive submodules.

 Under review.
 cf. <fc5ec100-1d42-4199-236e-7a99c9218f38@gmail.com>
 cf. <bf1893ee-6973-d8b2-659e-bb239a0a9ae2@gmail.com>


* en/ort-perf-batch-14 (2021-07-20) 7 commits
 - merge-ort: restart merge with cached renames to reduce process entry c=
ost
 - merge-ort: avoid recursing into directories when we don't need to
 - merge-ort: defer recursing into directories when merge base is matched
 - merge-ort: add a handle_deferred_entries() helper function
 - merge-ort: add data structures for allowable trivial directory resolve=
s
 - merge-ort: add some more explanations in collect_merge_info_callback()
 - merge-ort: resolve paths early when we have sufficient information
 (this branch is used by en/ort-perf-batch-15.)

 Further optimization on "merge -sort" backend.

 Will merge to 'next'.


* cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
 - fetch: fix segfault on --set-upstream while on a detached HEAD

 "git fetch --set-upstream" while on detached HEAD segfaulted
 instead of noticing that such an operation did not make sense.

 Expecting a reroll.
 cf. <xmqqsg0ri5mq.fsf@gitster.g>


* ps/perf-with-separate-output-directory (2021-07-02) 1 commit
  (merged to 'next' on 2021-07-22 at af51ca0a39)
 + perf: fix when running with TEST_OUTPUT_DIRECTORY

 Test update.

 Will merge to 'master'.


* sm/worktree-add-lock (2021-07-15) 3 commits
  (merged to 'next' on 2021-07-16 at 609c0a4944)
 + worktree: teach `add` to accept --reason <string> with --lock
 + worktree: mark lock strings with `_()` for translation
 + t2400: clean up '"add" worktree with lock' test

 "git worktree add --lock" learned to record why the worktree is
 locked with a custom message.

 Will merge to 'master'.


* ab/bundle-doc (2021-07-20) 3 commits
 - bundle doc: elaborate on rev<->ref restriction
 - bundle doc: elaborate on object prerequisites
 - bundle doc: rewrite the "DESCRIPTION" section

 Doc update.

 Expecting a reroll.
 at least for the second patch.


* ab/pack-stdin-packs-fix (2021-07-09) 2 commits
 - pack-objects: fix segfault in --stdin-packs option
 - pack-objects tests: cover blindspots in stdin handling

 Input validation of "git pack-objects --stdin-packs" has been
 corrected.

 Ack?
 cf. <YND3h2l10PlnSNGJ@nand.local>


* ds/commit-and-checkout-with-sparse-index (2021-07-20) 7 commits
 - unpack-trees: resolve sparse-directory/file conflicts
 - t1092: document bad 'git checkout' behavior
 - checkout: stop expanding sparse indexes
 - sparse-index: recompute cache-tree
 - commit: integrate with sparse-index
 - p2000: compress repo names
 - p2000: add 'git checkout -' test and decrease depth
 (this branch is used by ds/add-with-sparse-index; uses ds/status-with-sp=
arse-index.)

 "git checkout" and "git commit" learn to work without unnecessarily
 expanding sparse indexes.

 Will merge to 'next'.


* ew/many-alternate-optim (2021-07-07) 5 commits
  (merged to 'next' on 2021-07-16 at a2d8bc731d)
 + oidtree: a crit-bit tree for odb_loose_cache
 + oidcpy_with_padding: constify `src' arg
 + make object_directory.loose_objects_subdir_seen a bitmap
 + avoid strlen via strbuf_addstr in link_alt_odb_entry
 + speed up alt_odb_usable() with many alternates

 Optimization for repositories with many alternate object store.

 Will merge to 'master'.


* jk/log-decorate-optim (2021-07-14) 7 commits
  (merged to 'next' on 2021-07-16 at 5637878b90)
 + load_ref_decorations(): fix decoration with tags
  (merged to 'next' on 2021-07-08 at a3b6f978ab)
 + add_ref_decoration(): rename s/type/deco_type/
 + load_ref_decorations(): avoid parsing non-tag objects
 + object.h: add lookup_object_by_type() function
 + object.h: expand docstring for lookup_unknown_object()
 + log: avoid loading decorations for userformats that don't need it
 + pretty.h: update and expand docstring for userformat_find_requirements=
()

 Optimize "git log" for cases where we wasted cycles to load ref
 decoration data that may not be needed.

 Will merge to 'master'.


* jt/push-negotiation-fixes (2021-07-15) 3 commits
 - fetch: die on invalid --negotiation-tip hash
 - send-pack: fix push nego. when remote has refs
 - send-pack: fix push.negotiate with remote helper

 Bugfix for common ancestor negotiation recently introduced in "git
 push" codepath.

 Needs review.


* ab/make-tags-cleanup (2021-07-22) 5 commits
 - Makefile: normalize clobbering & xargs for tags targets
 - Makefile: the "cscope" target always creates a "cscope.out"
 - Makefile: don't use "FORCE" for tags targets
 - Makefile: add QUIET_GEN to "cscope" target
 - Makefile: move ".PHONY: cscope" near its target

 Build clean-up for "make tags" and friends.

 Will merge to 'next'?
 4/5 may want a minor tweak to the log and the patch text but otherwise l=
ooks good.


* tb/multi-pack-bitmaps (2021-06-28) 24 commits
 - p5326: perf tests for MIDX bitmaps
 - p5310: extract full and partial bitmap tests
 - midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - t7700: update to work with MIDX bitmap test knob
 - t5319: don't write MIDX bitmaps in t5319
 - t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t5326: test multi-pack bitmap behavior
 - t/helper/test-read-midx.c: add --checksum mode
 - t5310: move some tests to lib-bitmap.sh
 - pack-bitmap: write multi-pack bitmaps
 - pack-bitmap: read multi-pack bitmaps
 - pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
 - pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
 - pack-bitmap.c: introduce 'bitmap_num_objects()'
 - midx: infer preferred pack when not given one
 - midx: respect 'core.multiPackIndex' when writing
 - midx: clear auxiliary .rev after replacing the MIDX
 - midx: make a number of functions non-static
 - Documentation: describe MIDX-based bitmaps
 - Documentation: build 'technical/bitmap-format' by default
 - pack-bitmap-write.c: free existing bitmaps
 - pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 - pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps

 The reachability bitmap file used to be generated only for a single
 pack, but now we've learned to generate bitmaps for history that
 span across multiple packfiles.

 Comments?


* ds/status-with-sparse-index (2021-07-14) 16 commits
  (merged to 'next' on 2021-07-20 at 1558d36c0f)
 + t1092: document bad sparse-checkout behavior
 + fsmonitor: integrate with sparse index
 + wt-status: expand added sparse directory entries
 + status: use sparse-index throughout
 + status: skip sparse-checkout percentage with sparse-index
 + diff-lib: handle index diffs with sparse dirs
 + dir.c: accept a directory as part of cone-mode patterns
 + unpack-trees: unpack sparse directory entries
 + unpack-trees: rename unpack_nondirectories()
 + unpack-trees: compare sparse directories correctly
 + unpack-trees: preserve cache_bottom
 + t1092: add tests for status/add and sparse files
 + t1092: expand repository data shape
 + t1092: replace incorrect 'echo' with 'cat'
 + sparse-index: include EXTENDED flag when expanding
 + sparse-index: skip indexes with unmerged entries
 (this branch is used by ds/add-with-sparse-index and ds/commit-and-check=
out-with-sparse-index.)

 "git status" codepath learned to work with sparsely populated index
 without hydrating it fully.

 Will merge to 'master'.


* ab/config-based-hooks-base (2021-06-29) 33 commits
 - hooks: fix a TOCTOU in "did we run a hook?" heuristic
 - receive-pack: convert receive hooks to hook.h
 - post-update: use hook.h library
 - receive-pack: convert 'update' hook to hook.h
 - hooks: allow callers to capture output
 - run-command: allow capturing of collated output
 - reference-transaction: use hook.h to run hooks
 - transport: convert pre-push hook to use config
 - hook: convert 'post-rewrite' hook in sequencer.c to hook.h
 - hook: provide stdin by string_list or callback
 - run-command: add stdin callback for parallelization
 - am: convert 'post-rewrite' hook to hook.h
 - hook: support passing stdin to hooks
 - run-command: allow stdin for run_processes_parallel
 - run-command: remove old run_hook_{le,ve}() hook API
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change hook to use config
 - commit: use hook.h to execute hooks
 - git-p4: use 'git hook' to run hooks
 - send-email: use 'git hook run' for 'sendemail-validate'
 - git hook run: add an --ignore-missing flag
 - merge: use config-based hooks for post-merge hook
 - hooks: convert 'post-checkout' hook to hook library
 - am: convert applypatch hooks to use config
 - rebase: teach pre-rebase to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - hook: add 'run' subcommand
 - hook-list.h: add a generated list of hooks, like config-list.h
 - hook.c: add a hook_exists() wrapper and use it in bugreport.c
 - hook.[ch]: move find_hook() to this new library
 - Makefile: remove an out-of-date comment
 - Makefile: stop hardcoding {command,config}-list.h
 - Makefile: mark "check" target as .PHONY
 (this branch is used by es/config-based-hooks.)

 Restructuring of (a subset of) Emily's config-based-hooks series,
 to demonstrate that a series can be presented as a more logical and
 focused progression.

 Waiting for reviews.


* ab/doc-retire-alice-bob (2021-06-16) 6 commits
 - pack-protocol doc: use "www-data" in place of "alice"
 - doc: replace "alice" and "bob" with "jdoe" and "msmith"
 - fast-import doc: change "bob" in an example to "file.txt"
 - daemon doc + code comments: reword "alice" example
 - gitcvs-migration doc: replace "alice" and "bob" with "you" and "www-da=
ta"
 - gittutorial doc: replace "alice" and "bob" with "you" and "www-data"

 Documentation update to avoid Alice and Bob in contexts where Eve
 does not appear in.

 Will discard.
 Let's shelve this one for now, as it does not seem to solve any
 real problems (other than ceasing to use Alice and Bob in contexts
 that do not call for Eve).


* ab/serve-cleanup (2021-06-28) 8 commits
 - upload-pack.c: convert to new serve.c "startup" config cb
 - serve: add support for a "startup" git_config() callback
 - serve.c: add trace2 regions for advertise & command
 - serve.c: add call_{advertise,command}() indirection
 - serve: use designated initializers
 - transport: use designated initializers
 - transport: rename "fetch" in transport_vtable to "fetch_refs"
 - serve: mark has_capability() as static

 Code clean-up around "git serve".

 Expecting a reroll.
 cf. <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
 cf. <87tul24iw2.fsf@evledraar.gmail.com>


* es/superproject-aware-submodules (2021-06-16) 5 commits
 - SQUASH???
 - submodule: cache superproject gitdir during 'update'
 - submodule: cache superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir cache
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Waiting for reviews.


* en/zdiff3 (2021-06-15) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.

 Expecting a reroll.
 cf. <CABPp-BE7-E03+x38EK-=3DAE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.co=
m>


* pw/diff-color-moved-fix (2021-07-20) 12 commits
 - diff --color-moved: intern strings
 - diff: use designated initializers for emitted_diff_symbol
 - diff --color-moved-ws=3Dallow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=3Dallow-indentation-change: simplify and optimiz=
e
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zerba color=
ing
 - diff --color-moved=3Dzebra: fix alternate coloring
 - diff --color-moved: add perf tests

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.


* hn/refs-errno-cleanup (2021-07-26) 7 commits
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: explicitly return failure_errno from parse_loose_ref_contents
 - refs: add failure_errno to refs_read_raw_ref() signature
 - refs: make errno output explicit for read_raw_ref_fn
 - refs/files-backend: stop setting errno from lock_ref_oid_basic
 - refs: remove EINVAL errno output from specification of read_raw_ref_fn
 - refs file backend: move raceproof_create_file() here
 (this branch uses ab/refs-files-cleanup.)

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the callchain.

 Will merge to 'next'.


* ab/test-tool-cache-cleanup (2021-06-08) 4 commits
 - read-cache perf: add a perf test for refresh_index()
 - test-tool: migrate read-cache-again to parse_options()
 - test-tool: migrate read-cache-perf to parse_options()
 - test-tool: split up test-tool read-cache

 Test code shuffling.

 Waiting for reviews.


* ab/pack-objects-stdin (2021-07-09) 5 commits
 - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
 - pack-objects.c: do stdin parsing via revision.c's API
 - revision.[ch]: add a "handle_stdin_line" API
 - revision.h: refactor "disable_stdin" and "read_from_stdin"
 - upload-pack: run is_repository_shallow() before setup_revisions()

 Introduce handle_stdin_line callback to revision API and uses it.


* ar/submodule-add (2021-07-26) 5 commits
 - submodule: drop unused sm_name parameter from show_fetch_remotes()
  (merged to 'next' on 2021-07-22 at b8b636c9a1)
 + submodule--helper: introduce add-clone subcommand
 + submodule--helper: refactor module_clone()
 + submodule: prefix die messages with 'fatal'
 + t7400: test failure to add submodule in tracked path
 (this branch is used by ar/submodule-add-config.)

 Rewrite of "git submodule" in C continues.

 Will merge to 'master'.


* ds/gender-neutral-doc-guidelines (2021-07-16) 1 commit
  (merged to 'next' on 2021-07-20 at 06d325e064)
 + CodingGuidelines: recommend gender-neutral description

 A guideline for gender neutral documentation has been added.

 Will merge to 'master'.


* gh/gitweb-branch-sort (2021-06-10) 1 commit
 - gitweb: use HEAD as secondary sort key in git_get_heads_list()

 Tie-break branches that point at the same object in the list of
 branches on GitWeb to show the one pointed at by HEAD early.

 Waiting for reviews.


* lh/systemd-timers (2021-07-02) 3 commits
 - maintenance: add support for systemd timers on Linux
 - maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>`
 - cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" function

 "git maintenance" scheduler learned to use systemd timers as a
 possible backend.

 Waiting for reviews.


* fc/completion-updates (2021-06-07) 4 commits
 - completion: bash: add correct suffix in variables
 - completion: bash: fix for multiple dash commands
 - completion: bash: fix for suboptions with value
 - completion: bash: fix prefix detection in branch.*

 Command line completion updates.

 Expecting a reroll.
 cf. <60be6f7fa4435_db80d208f2@natae.notmuch>


* ab/update-submitting-patches (2021-07-22) 2 commits
 - SubmittingPatches: replace discussion of Travis with GitHub Actions
 - SubmittingPatches: move discussion of Signed-off-by above "send"

 Reorganize and update the SubmitingPatches document.

 Will merge to 'next'.


* zh/ref-filter-raw-data (2021-07-26) 6 commits
 - ref-filter: add %(rest) atom
 - ref-filter: use non-const ref_format in *_atom_parser()
 - ref-filter: --format=3D%(raw) support --perl
 - ref-filter: add %(raw) atom
 - ref-filter: add obj-type check in grab contents
 - Merge branch 'zh/cat-file-batch-fix' into zh/ref-filter-raw-data

 Prepare the "ref-filter" machinery that drives the "--format"
 option of "git for-each-ref" and its friends to be used in "git
 cat-file --batch".

 Will merge to 'next'.


* jh/builtin-fsmonitor (2021-07-12) 35 commits
 - BANDAID: sparse fixes
 - t7527: test FS event reporing on MacOS WRT case and Unicode
 - fsmonitor: handle shortname for .git
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - fsmonitor: force update index after large responses
 - fsmonitor: enhance existing comments
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon: periodically truncate list of modified files
 - t7527: create test for fsmonitor--daemon
 - t/perf/p7519: add fsmonitor--daemon test cases
 - t/perf: avoid copying builtin fsmonitor files into test repo
 - t/perf/p7519: speed up test using "test-tool touch"
 - t/helper/test-touch: add helper to touch a series of files
 - fsmonitor--daemon: implement handle_client callback
 - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 - fsmonitor-fs-listen-macos: add macos header files for FSEvent
 - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor: do not try to operate on bare repos
 - fsmonitor--daemon: implement 'start' command
 - fsmonitor--daemon: implement 'run' command
 - fsmonitor-fs-listen-macos: stub in backend for MacOS
 - fsmonitor-fs-listen-win32: stub in backend for Windows
 - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daem=
on
 - fsmonitor--daemon: implement 'stop' and 'status' commands
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: use IPC to query the builtin FSMonitor daemon
 - fsmonitor: config settings are repository-specific
 - help: include fsmonitor--daemon feature flag in version info
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - fsmonitor--daemon: update fsmonitor documentation
 - fsmonitor--daemon: man page
 - simple-ipc: preparations for supporting binary messages.

 An attempt to write and ship with a watchman equivalent tailored
 for our use.

 So, where are we with this topic?


* es/trace2-log-parent-process-name (2021-07-22) 2 commits
 - tr2: log parent process name
 - tr2: make process info collection platform-generic

 trace2 logs learned to show parent process name to see in what
 context Git was invoked.

 Looking good.  Ready for 'next'?


* ab/fsck-unexpected-type (2021-07-12) 21 commits
 - fsck: report invalid object type-path combinations
 - fsck: report invalid types recorded in objects
 - object-store.h: move read_loose_object() below 'struct object_info'
 - fsck: don't hard die on invalid object types
 - object-file.c: return -2 on "header too long" in unpack_loose_header()
 - object-file.c: return -1, not "status" from unpack_loose_header()
 - object-file.c: guard against future bugs in loose_object_info()
 - object-file.c: stop dying in parse_loose_header()
 - object-file.c: split up ternary in parse_loose_header()
 - object-file.c: simplify unpack_loose_short_header()
 - object-file.c: add missing braces to loose_object_info()
 - object-file.c: make parse_loose_header_extended() public
 - object-file.c: don't set "typep" when returning non-zero
 - cache.h: move object functions to object-store.h
 - cat-file tests: test for current --allow-unknown-type behavior
 - cat-file tests: add corrupt loose object test
 - rev-list tests: test for behavior with invalid object types
 - cat-file tests: test that --allow-unknown-type isn't on by default
 - cat-file tests: test for missing object with -t and -s
 - fsck tests: add test for fsck-ing an unknown type
 - fsck tests: refactor one test to use a sub-repo

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.

 Needs review.
