Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823E7C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 00:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54ADC60E54
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 00:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhJLAQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 20:16:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51586 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhJLAQS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 20:16:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E753BFAF0D;
        Mon, 11 Oct 2021 20:14:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=g
        anQlByiEbFQjdL2MgQz5wE9pxgsZmOQlJUR/+Tuzp4=; b=tmRCK33jDP2fFwLXP
        RzDOh05ACrhFYqvg74dAQF0vIooZd8ivujALLnuywNmE6F6N+sen59mqMiEsUR12
        WyLJXRQx7EPiUT3FUYEgpY0KxkTic4CTA+1dIUMwnlvEuSaK5Nvw1Yfh7P70gamu
        m3eaHGHsyIf/vn/yaqNM1kniMM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0CEAFAF0C;
        Mon, 11 Oct 2021 20:14:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1850EFAF0B;
        Mon, 11 Oct 2021 20:14:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2021, #03; Mon, 11)
X-master-at: 2a97289ad8b103625d3a1a12f66c27f50df822ce
X-next-at: b88fcb3f61432d526395a9937acaea0c67ee1aaf
Date:   Mon, 11 Oct 2021 17:14:14 -0700
Message-ID: <xmqqv9239k15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5611E1E8-2AF1-11EC-A89E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
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

The eleventh and twelfth batches of topics are in the 'master'
branch, and quite a many topics started cooking in 'next'.

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

* ab/designated-initializers (2021-09-27) 5 commits
  (merged to 'next' on 2021-10-03 at 179f652de6)
 + cbtree.h: define cb_init() in terms of CBTREE_INIT
 + *.h: move some *_INIT to designated initializers
 + *.h _INIT macros: don't specify fields equal to 0
 + *.[ch] *_INIT macros: use { 0 } for a "zero out" idiom
 + submodule-config.h: remove unused SUBMODULE_INIT macro
 (this branch is used by ab/designated-initializers-more.)

 Code clean-up.


* ab/http-pinned-public-key-mismatch (2021-09-27) 1 commit
  (merged to 'next' on 2021-10-03 at cd67328eed)
 + http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting errors

 HTTPS error handling updates.


* ab/retire-git-config-key-is-valid (2021-09-28) 1 commit
  (merged to 'next' on 2021-10-03 at fc7a0a55d1)
 + config.c: remove unused git_config_key_is_valid()

 Code cleanup.


* ab/sanitize-leak-ci (2021-09-23) 2 commits
  (merged to 'next' on 2021-10-03 at dcd62a3fc6)
 + tests: add a test mode for SANITIZE=leak, run it in CI
 + Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
 (this branch is used by ab/mark-leak-free-tests, ab/mark-leak-free-tests-more and ab/unpack-trees-leakfix.)

 CI learns to run the leak sanitizer builds.


* da/difftool (2021-09-30) 6 commits
  (merged to 'next' on 2021-10-03 at 3ba0335e4e)
 + difftool: add a missing space to the run_dir_diff() comments
 + difftool: remove an unnecessary call to strbuf_release()
 + difftool: refactor dir-diff to write files using helper functions
 + difftool: create a tmpdir path without repeated slashes
 + Merge branch 'da/difftool-dir-diff-symlink-fix' into da/difftool
 + Merge branch 'ab/retire-option-argument' into da/difftool

 Code clean-up in "git difftool".


* jk/ref-paranoia (2021-09-27) 16 commits
  (merged to 'next' on 2021-10-03 at 8c2cb6a3a6)
 + refs: drop "broken" flag from for_each_fullref_in()
 + ref-filter: drop broken-ref code entirely
 + ref-filter: stop setting FILTER_REFS_INCLUDE_BROKEN
 + repack, prune: drop GIT_REF_PARANOIA settings
 + refs: turn on GIT_REF_PARANOIA by default
 + refs: omit dangling symrefs when using GIT_REF_PARANOIA
 + refs: add DO_FOR_EACH_OMIT_DANGLING_SYMREFS flag
 + refs-internal.h: reorganize DO_FOR_EACH_* flag documentation
 + refs-internal.h: move DO_FOR_EACH_* flags next to each other
 + t5312: be more assertive about command failure
 + t5312: test non-destructive repack
 + t5312: create bogus ref as necessary
 + t5312: drop "verbose" helper
 + t5600: provide detached HEAD for corruption failures
 + t5516: don't use HEAD ref for invalid ref-deletion tests
 + t7900: clean up some more broken refs
 (this branch is used by jt/no-abuse-alternate-odb-for-submodules.)

 The ref iteration code used to optionally allow dangling refs to be
 shown, which has been tightened up.


* js/win-lazyload-buildfix (2021-09-28) 3 commits
  (merged to 'next' on 2021-10-03 at 26802e5d73)
 + Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better
 + lazyload.h: use an even more generic function pointer than FARPROC
 + lazyload.h: fix warnings about mismatching function pointer types

 Compilation fix.


* mr/bisect-in-c-4 (2021-10-01) 1 commit
  (merged to 'next' on 2021-10-06 at c13c14238d)
 + bisect--helper: add space between colon and following sentence

 Message fix.


* rs/p3400-lose-tac (2021-10-03) 1 commit
  (merged to 'next' on 2021-10-06 at 688dc7137c)
 + p3400: stop using tac(1)

 Test portability update.


* sg/test-split-index-fix (2021-09-07) 7 commits
  (merged to 'next' on 2021-09-29 at 661ae75778)
 + read-cache: fix GIT_TEST_SPLIT_INDEX
 + tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
 + read-cache: look for shared index files next to the index, too
 + t1600-index: disable GIT_TEST_SPLIT_INDEX
 + t1600-index: don't run git commands upstream of a pipe
 + t1600-index: remove unnecessary redirection
 + Merge branch 'ds/sparse-index-ignored-files' into sg/test-split-index-fix

 Test updates.


* tb/aggregate-ignore-leading-whitespaces (2021-10-04) 1 commit
  (merged to 'next' on 2021-10-06 at 619a7db2d4)
 + t/perf/aggregate.perl: tolerate leading spaces

 Test portability update.


* tb/midx-write-propagate-namehash (2021-09-17) 7 commits
  (merged to 'next' on 2021-09-29 at 24732fcfc8)
 + t5326: test propagating hashcache values
 + p5326: generate pack bitmaps before writing the MIDX bitmap
 + p5326: don't set core.multiPackIndex unnecessarily
 + p5326: create missing 'perf-tag' tag
 + midx.c: respect 'pack.writeBitmapHashcache' when writing bitmaps
 + pack-bitmap.c: propagate namehash values from existing bitmaps
 + t/helper/test-bitmap.c: add 'dump-hashes' mode

 "git multi-pack-index write --bitmap" learns to propagate the
 hashcache from original bitmap to resulting bitmap.

--------------------------------------------------
[New Topics]

* ab/mark-leak-free-tests (2021-10-07) 11 commits
 - leak tests: mark some misc tests as passing with SANITIZE=leak
 - leak tests: mark various "generic" tests as passing with SANITIZE=leak
 - leak tests: mark some read-tree tests as passing with SANITIZE=leak
 - leak tests: mark some ls-files tests as passing with SANITIZE=leak
 - leak tests: mark all checkout-index tests as passing with SANITIZE=leak
 - leak tests: mark all trace2 tests as passing with SANITIZE=leak
 - leak tests: mark all ls-tree tests as passing with SANITIZE=leak
 - leak tests: mark t0000-init.sh as passing with SANITIZE=leak
 - leak tests: run various "test-tool" tests in t00*.sh SANITIZE=leak
 - leak tests: run various built-in tests in t00*.sh SANITIZE=leak
 - Merge branch 'ab/sanitize-leak-ci' into ab/mark-leak-free-tests

 Bunch of tests are marked as "passing leak check".

 Expecting a reroll.
 cf. <xmqqmtnko3zn.fsf@gitster.g>


* ab/mark-leak-free-tests-more (2021-10-07) 8 commits
 - merge: add missing strbuf_release()
 - ls-files: add missing string_list_clear()
 - ls-files: fix a trivial dir_clear() leak
 - tests: fix test-oid-array leak, test in SANITIZE=leak
 - tests: fix a memory leak in test-oidtree.c
 - tests: fix a memory leak in test-parse-options.c
 - tests: fix a memory leak in test-prio-queue.c
 - Merge branch 'ab/sanitize-leak-ci' into ab/mark-leak-free-tests-more

 Bunch of tests are marked as "passing leak check".

 Will merge to 'next'?


* ab/unpack-trees-leakfix (2021-10-07) 2 commits
 - unpack-trees: don't leak memory in verify_clean_subdirectory()
 - Merge branch 'ab/sanitize-leak-ci' into ab/unpack-trees-leakfix

 Leakfix.

 Will merge to 'next'?


* jk/cat-file-batch-all-wo-replace (2021-10-08) 5 commits
  (merged to 'next' on 2021-10-11 at 9415f7c43a)
 + cat-file: use packed_object_info() for --batch-all-objects
 + cat-file: split ordered/unordered batch-all-objects callbacks
 + cat-file: disable refs/replace with --batch-all-objects
 + cat-file: mention --unordered along with --batch-all-objects
 + t1006: clean up broken objects

 "git cat-file --batch" with the "--batch-all-objects" option is
 supposed to iterate over all the objects found in a repository, but
 it used to translate these object names using the replace mechanism,
 which defeats the point of enumerating all objects in the repository.
 This has been corrected.

 Will merge to 'master'.


* js/userdiff-cpp (2021-10-10) 6 commits
 - userdiff-cpp: learn the C++ spaceship operator
 - userdiff-cpp: permit the digit-separating single-quote in numbers
 - userdiff-cpp: prepare test cases with yet unsupported features
 - userdiff-cpp: tighten word regex
 - t4034: add tests showing problematic cpp tokenizations
 - t4034/cpp: actually test that operator tokens are not split

 Userdiff patterns for the C++ language has been updated.

 Will merge to 'next'?


* mp/absorb-submodule-git-dir-upon-deinit (2021-10-07) 1 commit
 - submodule: absorb git dir instead of dying on deinit

 "git submodule deinit" for a submodule whose .git metadata
 directory is embedded in its working tree refused to work, until
 the submodule gets converted to use the "absorbed" form where the
 metadata directory is stored in superproject, and a gitfile at the
 top-level of the working tree of the submodule points at it.  The
 command is taught to convert such submodules to the absorbed form
 as needed.

 Under review.
 cf. <xmqqwnmopqqk.fsf@gitster.g>


* ns/remerge-diff (2021-10-08) 8 commits
 - doc/diff-options: explain the new --remerge-diff option
 - show, log: adapt Elijah Newren's changes to common tmp-objdir API
 - show, log: provide a --remerge-diff capability
 - merge-ort: capture and print ll-merge warnings in our preferred fashion
 - ll-merge: add API for capturing warnings in a strbuf instead of stderr
 - merge-ort: add ability to record conflict messages in a file
 - merge-ort: mark a few more conflict messages as omittable
 - Merge branch 'ns/tmp-objdir' into ns/remerge-diff
 (this branch uses ns/tmp-objdir.)

 A new presentation for two-parent merge "--remerge-diff" can be
 used to show the difference between mechanical (and possibly
 conflicted) merge results and the recorded resolution.

 On hold.
 This is Elijah's remerge-diff rebased on ns/tmp-objdir to share the
 "create objects temporarily, only to discard without committing
 them to longer-term storage" infrastructure with another topic.


* ns/tmp-objdir (2021-10-04) 2 commits
 - tmp-objdir: disable ref updates when replacing the primary odb
 - tmp-objdir: new API for creating temporary writable databases
 (this branch is used by ns/batched-fsync and ns/remerge-diff.)

 New interface into the tmp-objdir API to help in-core use of the
 quarantine feature.

 Will merge to 'next'?


* pw/sparse-cache-tree-verify-fix (2021-10-07) 1 commit
  (merged to 'next' on 2021-10-11 at 2f90c87850)
 + sparse index: fix use-after-free bug in cache_tree_verify()

 Recent sparse-index addition, namely any use of index_name_pos(),
 can expand sparse index entries and breaks any code that walks
 cache-tree or existing index entries.  One such instance of such a
 breakage has been corrected.

 Will merge to 'master'.


* rs/make-verify-path-really-verify-again (2021-10-07) 3 commits
  (merged to 'next' on 2021-10-11 at 6b4358876f)
 + read-cache: let verify_path() reject trailing dir separators again
 + read-cache: add verify_path_internal()
 + t3905: show failure to ignore sub-repo

 Recent sparse-index work broke safety against attempts to add paths
 with trailing slashes to the index, which has been corrected.

 Will merge to 'master'.


* vd/sparse-reset (2021-10-07) 8 commits
 - unpack-trees: improve performance of next_cache_entry
 - reset: make --mixed sparse-aware
 - reset: make sparse-aware (except --mixed)
 - reset: integrate with sparse index
 - reset: expand test coverage for sparse checkouts
 - update-index: add --force-full-index option for expand/collapse test
 - reset: preserve skip-worktree bit in mixed reset
 - reset: rename is_missing to !is_in_reset_tree

 Various operating modes of "git reset" have been made to work
 better with the sparse index.

 Needs review.

--------------------------------------------------
[Stalled]

* ar/submodule-update (2021-09-20) 8 commits
 . submodule--helper: rename helper functions
 . submodule--helper: remove unused helpers
 . submodule--helper: remove update-clone subcommand
 . submodule: move core cmd_update() logic to C
 . submodule--helper: refactor get_submodule_displaypath()
 . submodule--helper: rename helpers for update-clone
 . submodule--helper: get remote names from any repository
 . submodule--helper: split up ensure_core_worktree()

 Rewrite of "git submodule update" in C.

 Kicked out of 'seen' to make room for es/superproject-aware-submodules
 which is among the topics this topic stomps on.


* pw/diff-color-moved-fix (2021-08-05) 13 commits
 - diff: drop unused options parameter from cmp_in_block_with_wsd()
 - diff --color-moved: intern strings
 - diff: use designated initializers for emitted_diff_symbol
 - diff --color-moved-ws=allow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=allow-indentation-change: simplify and optimize
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zerba coloring
 - diff --color-moved=zebra: fix alternate coloring
 - diff --color-moved: add perf tests

 Originally merged to 'next' on 2021-08-05

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.

 Expecting a reroll.
 cf. <8bec1a6d-5052-50c3-4100-e6348289d581@gmail.com>


* cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
 - fetch: fix segfault on --set-upstream while on a detached HEAD

 "git fetch --set-upstream" while on detached HEAD segfaulted
 instead of noticing that such an operation did not make sense.

 Expecting a reroll.
 cf. <xmqqsg0ri5mq.fsf@gitster.g>

--------------------------------------------------
[Cooking]

* gc/use-repo-settings (2021-10-04) 3 commits
 - gc: perform incremental repack when implictly enabled
 - fsck: verify multi-pack-index when implictly enabled
 - fsck: verify commit graph when implicitly enabled

 It is wrong to read some settings directly from the config
 subsystem, as things like feature.experimental can affect their
 default values.

 Under review.
 cf. <70aca052-716f-40ed-47c4-1882fdbd221e@gmail.com>


* jh/perf-remove-test-times (2021-10-04) 1 commit
 - t/perf/perf-lib.sh: remove test_times.* at the end test_perf_()

 Perf test fix.

 Will merge to 'next'.


* pw/fix-some-issues-in-reset-head (2021-10-01) 12 commits
 - rebase -m: don't fork git checkout
 - rebase --apply: set ORIG_HEAD correctly
 - rebase --apply: fix reflog
 - reset_head(): take struct rebase_head_opts
 - rebase: cleanup reset_head() calls
 - reset_head(): make default_reflog_action optional
 - reset_head(): factor out ref updates
 - reset_head(): remove action parameter
 - reset_head(): don't run checkout hook if there is an error
 - reset_head(): fix checkout
 - rebase: factor out checkout for up to date branch
 - Merge branch 'pw/rebase-of-a-tag-fix' into pw/fix-some-issues-in-reset-head

 Fix "some issues" in a helper function reset_head().

 Expecting a reroll.
 Needs a lot better explanation, including what the issues are,
 which codepaths the helper is used and to do what, and tests to
 protect the fixes.


* rs/mergesort (2021-10-08) 10 commits
  (merged to 'next' on 2021-10-08 at 2e83706316)
 + test-mergesort: use repeatable random numbers
  (merged to 'next' on 2021-10-03 at 29a672574f)
 + mergesort: use ranks stack
 + p0071: test performance of llist_mergesort()
 + p0071: measure sorting of already sorted and reversed files
 + test-mergesort: add unriffle_skewed mode
 + test-mergesort: add unriffle mode
 + test-mergesort: add generate subcommand
 + test-mergesort: add test subcommand
 + test-mergesort: add sort subcommand
 + test-mergesort: use strbuf_getline()

 The mergesort implementation used to sort linked list has been
 optimized.

 Will merge to 'master'.


* bs/doc-blame-color-lines (2021-10-08) 2 commits
  (merged to 'next' on 2021-10-11 at a2cb7768b6)
 + blame: document --color-* options
 + blame: describe default output format

 The "--color-lines" and "--color-by-age" options of "git blame"
 have been missing, which are now documented.

 Will merge to 'master'.


* cm/save-restore-terminal (2021-10-06) 2 commits
  (merged to 'next' on 2021-10-11 at 962bb3e75b)
 + editor: save and reset terminal after calling EDITOR
 + terminal: teach git how to save/restore its terminal settings

 An editor session launched during a Git operation (e.g. during 'git
 commit') can leave the terminal in a funny state.  The code path
 has updated to save the terminal state before, and restore it
 after, it spawns an editor.

 Will merge to 'master'.


* ja/doc-status-types-and-copies (2021-10-04) 4 commits
  (merged to 'next' on 2021-10-06 at 4de6571bf7)
 + Documentation/git-status: mention how to detect copies
 + Documentation/git-status: document porcelain status T (typechange)
 + Documentation/diff-format: state in which cases porcelain status is T
 + Documentation/git-status: remove impossible porcelain status DR and DC

 A few kinds of changes "git status" can show were not described.

 Will merge to 'master'.


* ab/designated-initializers-more (2021-10-01) 6 commits
  (merged to 'next' on 2021-10-11 at 9b9836c3df)
 + builtin/remote.c: add and use SHOW_INFO_INIT
 + builtin/remote.c: add and use a REF_STATES_INIT
 + urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
 + builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
 + daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
 + Merge branch 'ab/designated-initializers' into ab/designated-initializers-more

 Code clean-up.

 Will merge to 'master'.


* ab/parse-options-cleanup (2021-10-08) 10 commits
 - parse-options: change OPT_{SHORT,UNSET} to an enum
 - parse-options tests: test optname() output
 - parse-options.[ch]: make opt{bug,name}() "static"
 - commit-graph: stop using optname()
 - parse-options.c: move optname() earlier in the file
 - parse-options.h: make the "flags" in "struct option" an enum
 - parse-options.c: use exhaustive "case" arms for "enum parse_opt_result"
 - parse-options.[ch]: consistently use "enum parse_opt_result"
 - parse-options.[ch]: consistently use "enum parse_opt_flags"
 - parse-options.h: move PARSE_OPT_SHELL_EVAL between enums

 Random changes to parse-options implementation.

 Will merge to 'next'?


* mt/grep-submodule-textconv (2021-09-29) 1 commit
  (merged to 'next' on 2021-10-06 at 1950944b8c)
 + grep: demonstrate bug with textconv attributes and submodules

 "git grep --recurse-submodules" takes trees and blobs from the
 submodule repository, but the textconv settings when processing a
 blob from the submodule is not taken from the submodule repository.
 A demonstration is added to demonstrate the issue, without fixing
 it.

 Will merge to 'master'.


* es/superproject-aware-submodules (2021-08-19) 5 commits
 - fixup! introduce submodule.superprojectGitDir record
 - submodule: record superproject gitdir during 'update'
 - submodule: record superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir record
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Brought back to 'seen' to see if it still plays well with the rest
 of 'seen', without the conflicting ar/submodule-update topic.


* ab/fsck-unexpected-type (2021-10-01) 17 commits
 - fsck: report invalid object type-path combinations
 - fsck: don't hard die on invalid object types
 - object-file.c: stop dying in parse_loose_header()
 - object-file.c: return ULHR_TOO_LONG on "header too long"
 - object-file.c: use "enum" return type for unpack_loose_header()
 - object-file.c: simplify unpack_loose_short_header()
 - object-file.c: make parse_loose_header_extended() public
 - object-file.c: return -1, not "status" from unpack_loose_header()
 - object-file.c: don't set "typep" when returning non-zero
 - cat-file tests: test for current --allow-unknown-type behavior
 - cat-file tests: add corrupt loose object test
 - cat-file tests: test for missing/bogus object with -t, -s and -p
 - cat-file tests: move bogus_* variable declarations earlier
 - fsck tests: test for garbage appended to a loose object
 - fsck tests: test current hash/type mismatch behavior
 - fsck tests: refactor one test to use a sub-repo
 - fsck tests: add test for fsck-ing an unknown type

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.

 Will merge to 'next'.


* ab/config-based-hooks-1 (2021-09-27) 8 commits
  (merged to 'next' on 2021-10-06 at d05325ed35)
 + hook-list.h: add a generated list of hooks, like config-list.h
 + hook.c users: use "hook_exists()" instead of "find_hook()"
 + hook.c: add a hook_exists() wrapper and use it in bugreport.c
 + hook.[ch]: move find_hook() from run-command.c to hook.c
 + Makefile: remove an out-of-date comment
 + Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
 + Makefile: stop hardcoding {command,config}-list.h
 + Makefile: mark "check" target as .PHONY

 Mostly preliminary clean-up in the hook API.

 Will merge to 'master'.


* ab/make-sparse-for-real (2021-09-22) 1 commit
  (merged to 'next' on 2021-10-06 at 10e3c31d6a)
 + Makefile: make the "sparse" target non-.PHONY

 Prevent "make sparse" from running for the source files that
 haven't been modified.

 Will merge to 'master'.


* jt/no-abuse-alternate-odb-for-submodules (2021-10-08) 9 commits
 - submodule: trace adding submodule ODB as alternate
 - submodule: pass repo to check_has_commit()
 - object-file: only register submodule ODB if needed
 - merge-{ort,recursive}: remove add_submodule_odb()
 - refs: peeling non-the_repository iterators is BUG
 - refs: teach arbitrary repo support to iterators
 - refs: plumb repo into ref stores
 - Merge branch 'jk/ref-paranoia' into jt/no-abuse-alternate-odb-for-submodules
 - Merge branch 'jt/add-submodule-odb-clean-up' into jt/no-abuse-alternate-odb-for-submodules

 Follow through the work to use the repo interface to access
 submodule objects in-process, instead of abusing the alternate
 object database interface.

 Will merge to 'next'?


* tp/send-email-completion (2021-10-07) 3 commits
 - send-email docs: add format-patch options
 - send-email: programmatically generate bash completions
 - send-email: terminate --git-completion-helper with LF

 The command line complation for "git send-email" options have been
 tweaked to make it easier to keep it in sync with the command itself.

 Expecting a reroll.
 cf. <87fst7lkjx.fsf@evledraar.gmail.com>


* hm/paint-hits-in-log-grep (2021-10-08) 5 commits
 - SQUASH???
 - grep: fix an edge case concerning ascii patterns and UTF-8 data
 - pretty: colorize pattern matches in commit messages
 - grep: refactor next_match() and match_one_pattern() for external use
 - Merge branch 'jk/grep-haystack-is-read-only' into hm/paint-hits-in-log-grep

 "git log --grep=string --author=name" learns to highlight hits just
 like "git grep string" does.

 Expecting a reroll.
 cf. <xmqq1r4vjji3.fsf@gitster.g>


* en/removing-untracked-fixes (2021-09-27) 12 commits
  (merged to 'next' on 2021-10-06 at fc4e387fda)
 + Documentation: call out commands that nuke untracked files/directories
 + Comment important codepaths regarding nuking untracked files/dirs
 + unpack-trees: avoid nuking untracked dir in way of locally deleted file
 + unpack-trees: avoid nuking untracked dir in way of unmerged file
 + Change unpack_trees' 'reset' flag into an enum
 + Remove ignored files by default when they are in the way
 + unpack-trees: make dir an internal-only struct
 + unpack-trees: introduce preserve_ignored to unpack_trees_options
 + read-tree, merge-recursive: overwrite ignored files by default
 + checkout, read-tree: fix leak of unpack_trees_options.dir
 + t2500: add various tests for nuking untracked files
 + Merge branch 'en/am-abort-fix' into en/removing-untracked-fixes

 Various fixes in code paths that move untracked files away to make room.

 Will merge to 'master'.


* ks/submodule-add-message-fix (2021-09-20) 1 commit
 - submodule--helper: fix incorrect newlines in an error message

 Message regression fix.

 Waiting for a response.
 cf. <m27df9lvm1.fsf@gmail.com>


* ns/batched-fsync (2021-10-08) 8 commits
 - core.fsyncobjectfiles: performance tests for add and stash
 - core.fsyncobjectfiles: tests for batch mode
 - unpack-objects: use the bulk-checkin infrastructure
 - update-index: use the bulk-checkin infrastructure
 - core.fsyncobjectfiles: add windows support for batch mode
 - core.fsyncobjectfiles: batched disk flushes
 - bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 - Merge branch 'ns/tmp-objdir' into ns/batched-fsync
 (this branch uses ns/tmp-objdir.)

 The "core.fsyncobjectfiles" configuration variable can now be set
 to "batch" for improved performance.

 Will merge to 'next'?


* jh/builtin-fsmonitor-part1 (2021-09-20) 7 commits
  (merged to 'next' on 2021-10-06 at 021f633b9c)
 + t/helper/simple-ipc: convert test-simple-ipc to use start_bg_command
 + run-command: create start_bg_command
 + simple-ipc/ipc-win32: add Windows ACL to named pipe
 + simple-ipc/ipc-win32: add trace2 debugging
 + simple-ipc: move definition of ipc_active_state outside of ifdef
 + simple-ipc: preparations for supporting binary messages.
 + trace2: add trace2_child_ready() to report on background children

 Built-in fsmonitor (part 1).

 Will merge to 'master'.


* ab/align-parse-options-help (2021-09-22) 4 commits
  (merged to 'next' on 2021-10-06 at e22da7ef85)
 + parse-options: properly align continued usage output
 + git rev-parse --parseopt tests: add more usagestr tests
 + send-pack: properly use parse_options() API for usage string
 + parse-options API users: align usage output in C-strings

 When "git cmd -h" shows more than one line of usage text (e.g.
 the cmd subcommand may take sub-sub-command), parse-options API
 learned to align these lines, even across i18n/l10n.

 Will merge to 'master'.


* ab/help-config-vars (2021-09-23) 9 commits
  (merged to 'next' on 2021-10-06 at bf9538cfbd)
 + help: move column config discovery to help.c library
 + help / completion: make "git help" do the hard work
 + help tests: test --config-for-completion option & output
 + help: simplify by moving to OPT_CMDMODE()
 + help: correct logic error in combining --all and --guides
 + help: correct logic error in combining --all and --config
 + help tests: add test for --config output
 + help: correct usage & behavior of "git help --guides"
 + help: correct the usage string in -h and documentation

 Teach "git help -c" into helping the command line completion of
 configuration variables.

 Will merge to 'master'.


* tb/repack-write-midx (2021-10-07) 10 commits
  (merged to 'next' on 2021-10-08 at ff8fec247e)
 + test-read-midx: fix leak of bitmap_index struct
  (merged to 'next' on 2021-10-06 at ccdd5aaf2a)
 + builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
 + builtin/repack.c: make largest pack preferred
 + builtin/repack.c: support writing a MIDX while repacking
 + builtin/repack.c: extract showing progress to a variable
 + builtin/repack.c: rename variables that deal with non-kept packs
 + builtin/repack.c: keep track of existing packs unconditionally
 + midx: preliminary support for `--refs-snapshot`
 + builtin/multi-pack-index.c: support `--stdin-packs` mode
 + midx: expose `write_midx_file_only()` publicly

 "git repack" has been taught to generate multi-pack reachability
 bitmaps.

 Will merge to 'master'.


* ds/add-rm-with-sparse-index (2021-09-28) 13 commits
  (merged to 'next' on 2021-10-06 at 80a9cda797)
 + advice: update message to suggest '--sparse'
 + mv: refuse to move sparse paths
 + rm: skip sparse paths with missing SKIP_WORKTREE
 + rm: add --sparse option
 + add: update --renormalize to skip sparse paths
 + add: update --chmod to skip sparse paths
 + add: implement the --sparse option
 + add: skip tracked paths outside sparse-checkout cone
 + add: fail when adding an untracked sparse file
 + dir: fix pattern matching on dirs
 + dir: select directories correctly
 + t1092: behavior for adding sparse files
 + t3705: test that 'sparse_entry' is unstaged

 "git add", "git mv", and "git rm" have been adjusted to avoid
 updating paths outside of the sparse-checkout definition unless
 the user specifies a "--sparse" option.

 Will merge to 'master'.


* en/zdiff3 (2021-09-20) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.


* js/scalar (2021-10-07) 15 commits
 - scalar: accept -C and -c options before the subcommand
 - scalar: implement the `version` command
 - scalar: implement the `delete` command
 - scalar: teach 'reconfigure' to optionally handle all registered enlistments
 - scalar: allow reconfiguring an existing enlistment
 - scalar: implement the `run` command
 - scalar: teach 'clone' to support the --single-branch option
 - scalar: implement the `clone` subcommand
 - scalar: implement 'scalar list'
 - scalar: let 'unregister' handle a deleted enlistment directory gracefully
 - scalar: 'unregister' stops background maintenance
 - scalar: 'register' sets recommended config and starts maintenance
 - scalar: create test infrastructure
 - scalar: start documenting the command
 - scalar: create a rudimentary executable

 Add pieces from "scalar" to contrib/.


* ms/customizable-ident-expansion (2021-09-01) 1 commit
 - keyword expansion: make "$Id$" string configurable

 Instead of "$Id$", user-specified string (like $FreeBSD$) can be
 used as an in-blob placeholder for keyword expansion.

 What's the status of this one?  Meh?


* js/retire-preserve-merges (2021-09-07) 11 commits
  (merged to 'next' on 2021-09-10 at f645ffd7a3)
 + sequencer: restrict scope of a formerly public function
 + rebase: remove a no-longer-used function
 + rebase: stop mentioning the -p option in comments
 + rebase: remove obsolete code comment
 + rebase: drop the internal `rebase--interactive` command
 + git-svn: drop support for `--preserve-merges`
 + rebase: drop support for `--preserve-merges`
 + pull: remove support for `--rebase=preserve`
 + tests: stop testing `git rebase --preserve-merges`
 + remote: warn about unhandled branch.<name>.rebase values
 + t5520: do not use `pull.rebase=preserve`

 The "--preserve-merges" option of "git rebase" has been removed.

 Will cook in 'next'.


* ab/refs-errno-cleanup (2021-08-25) 4 commits
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: explicitly return failure_errno from parse_loose_ref_contents
 - branch tests: test for errno propagating on failing read
 - refs: add failure_errno to refs_read_raw_ref() signature

 The "remainder" of hn/refs-errno-cleanup topic.


* ab/lib-subtest (2021-09-22) 9 commits
  (merged to 'next' on 2021-10-06 at e8fa261811)
 + test-lib tests: get rid of copy/pasted mock test code
 + test-lib tests: assert 1 exit code, not non-zero
 + test-lib tests: refactor common part of check_sub_test_lib_test*()
 + test-lib tests: avoid subshell for "test_cmp" for readability
 + test-lib tests: don't provide a description for the sub-tests
 + test-lib tests: split up "write and run" into two functions
 + test-lib tests: move "run_sub_test" to a new lib-subtest.sh
 + Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
 + Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest

 Updates to the tests in t0000 to test the test framework.

 Will merge to 'master'.


* ab/only-single-progress-at-once (2021-09-22) 8 commits
 - progress.c: add & assert a "global_progress" variable
 - pack-bitmap-write.c: add a missing stop_progress()
 - progress.c: add temporary variable from progress struct
 - progress.c: stop eagerly fflush(stderr) when not a terminal
 - progress.c: call progress_interval() from progress_test_force_update()
 - progress.c: move signal handler functions lower
 - progress.c tests: test some invalid usage
 - progress.c tests: make start/stop verbs on stdin

 Further tweaks on progress API.

 Under review.
 cf. <20211010212949.GC571180@szeder.dev>


* fs/ssh-signing (2021-09-10) 9 commits
  (merged to 'next' on 2021-10-11 at b456b95672)
 + ssh signing: test that gpg fails for unknown keys
 + ssh signing: tests for logs, tags & push certs
 + ssh signing: duplicate t7510 tests for commits
 + ssh signing: verify signatures using ssh-keygen
 + ssh signing: provide a textual signing_key_id
 + ssh signing: retrieve a default key from ssh-agent
 + ssh signing: add ssh key format and signing code
 + ssh signing: add test prereqs
 + ssh signing: preliminary refactoring and clean-up

 Use ssh public crypto for object and push-cert signing.

 Will merge to 'master'.


* hn/reftable (2021-10-08) 19 commits
 - Add "test-tool dump-reftable" command.
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
 - reftable: add LICENSE
 - hash.h: provide constants for the hash IDs

 The "reftable" backend for the refs API, without integrating into
 the refs subsystem.

--------------------------------------------------
[Discarded]

* en/remerge-diff (2021-08-31) 7 commits
 . doc/diff-options: explain the new --remerge-diff option
 . show, log: provide a --remerge-diff capability
 . tmp-objdir: new API for creating and removing primary object dirs
 . merge-ort: capture and print ll-merge warnings in our preferred fashion
 . ll-merge: add API for capturing warnings in a strbuf instead of stderr
 . merge-ort: add ability to record conflict messages in a file
 . merge-ort: mark a few more conflict messages as omittable

 A new presentation for two-parent merge "--remerge-diff" can be
 used to show the difference between mechanical (and possibly
 conflicted) merge results and the recorded resolution.
