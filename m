Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595E9C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 22:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B6820838
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 22:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mlj8XqYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMW2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:28:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60612 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgHMW2s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 18:28:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1ED20E1D6F;
        Thu, 13 Aug 2020 18:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=W
        v5DR5RBDmk+eCQ+5zJDph2AMaM=; b=Mlj8XqYkXM8xhH0gvuSK5nuucEMhaNN+9
        xk4Tzgil7HJ6e1+G9O0QZ89m3aT06ZNK626Hzuj/g0Lx3Jn6bgsG4+mJaQCtLwSj
        lOMKdUXTRv7qWqWkuqX/uak2oeK9wsmgHicQReu28XKx/o/NAVK9bZTQY+VhnDdx
        PsHerB0pzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=DXx
        7c4o3qr4za/UjE+lwH1HCrm9zhM+mCoaCtnEh4oHtICFGHU+DhT1shmyAloxRYhT
        lEh+uuAj1SJMRjl6BMR/cbax2Dvj69BVXCK0zHGgGlfAB/M5gLRQa36E7yXH6wEM
        HPtZEtU9njIqI+WtFwywBbD/UIIgIOo4SYDwLXX8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17C70E1D6E;
        Thu, 13 Aug 2020 18:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 40C8EE1D6D;
        Thu, 13 Aug 2020 18:28:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2020, #03; Thu, 13)
X-master-at: 878e727637ec5815ccb3301eb994a54df95b21b8
X-next-at: 1956fa8f8d7168157346f0cbc0f1f9dd1fca787a
Date:   Thu, 13 Aug 2020 15:28:36 -0700
Message-ID: <xmqqd03u18q3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 554754CC-DDB4-11EA-9507-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

We are at 7th batch.  I'm trying to merge smaller batches of topics
to the 'master' branch more often than the previous cycles.  I will
also experiment, for smaller topics, with shorter gestation period
in 'next' before merging them to the 'master' branch.  We'll see if
this lowers stability of the tip of 'master' significantly; not that
much, hopefully.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* bc/sha-256-cvs-svn-updates (2020-08-05) 1 commit
  (merged to 'next' on 2020-08-07 at b1ce7e5ec5)
 + git-cvsexportcommit: support Perl before 5.10.1

 Portability fix.


* bc/sha-256-part-3 (2020-07-30) 39 commits
  (merged to 'next' on 2020-08-04 at 57115e548f)
 + t: remove test_oid_init in tests
 + docs: add documentation for extensions.objectFormat
 + ci: run tests with SHA-256
 + t: make SHA1 prerequisite depend on default hash
 + t: allow testing different hash algorithms via environment
 + t: add test_oid option to select hash algorithm
 + repository: enable SHA-256 support by default
 + setup: add support for reading extensions.objectformat
 + bundle: add new version for use with SHA-256
 + builtin/verify-pack: implement an --object-format option
 + http-fetch: set up git directory before parsing pack hashes
 + t0410: mark test with SHA1 prerequisite
 + t5308: make test work with SHA-256
 + t9700: make hash size independent
 + t9500: ensure that algorithm info is preserved in config
 + t9350: make hash size independent
 + t9301: make hash size independent
 + t9300: use $ZERO_OID instead of hard-coded object ID
 + t9300: abstract away SHA-1-specific constants
 + t8011: make hash size independent
 + t8003: make hash size independent
 + t8002: make hash size independent
 + t7508: use $ZERO_OID instead of hard-coded constant
 + t7506: avoid checking for SHA-1-specific constants
 + t7405: make hash size independent
 + t7400: make hash size independent
 + t7102: abstract away SHA-1-specific constants
 + t7201: abstract away SHA-1-specific constants
 + t7063: make hash size independent
 + t7003: compute appropriate length constant
 + t6501: avoid hard-coded objects
 + t6500: specify test values for SHA-256
 + t6301: make hash size independent
 + t6101: make hash size independent
 + t6100: make hash size independent
 + t3404: prepare 'short SHA-1 collision' tests for SHA-256
 + t3305: make hash agnostic
 + t1001: use $ZERO_OID
 + t: make test-bloom initialize repository

 The final leg of SHA-256 transition.


* es/worktree-doc-cleanups (2020-08-03) 5 commits
  (merged to 'next' on 2020-08-04 at cbb53ca464)
 + git-worktree.txt: link to man pages when citing other Git commands
 + git-worktree.txt: make start of new sentence more obvious
 + git-worktree.txt: fix minor grammatical issues
 + git-worktree.txt: consistently use term "working tree"
 + git-worktree.txt: employ fixed-width typeface consistently

 Doc cleanup around "worktree".


* jt/has_object (2020-08-06) 4 commits
  (merged to 'next' on 2020-08-07 at ed08abb693)
 + fsck: do not lazy fetch known non-promisor object
 + pack-objects: no fetch when allow-{any,promisor}
 + apply: do not lazy fetch when applying binary
 + sha1-file: introduce no-lazy-fetch has_object()

 A new helper function has_object() has been introduced to make it
 easier to mark object existence checks that do and don't want to
 trigger lazy fetches, and a few such checks are converted using it.


* ma/test-quote-cleanup (2020-08-06) 2 commits
  (merged to 'next' on 2020-08-10 at 63a95c2926)
 + t4104: modernize and simplify quoting
 + t: don't spuriously close and reopen quotes

 Test cleanup.


* rp/blame-first-parent-doc (2020-08-06) 1 commit
  (merged to 'next' on 2020-08-10 at 3fdbebe1ea)
 + blame-options.txt: document --first-parent option

 The "git blame --first-parent" option was not documented, but now
 it is.


* ss/cmake-build (2020-06-26) 8 commits
  (merged to 'next' on 2020-08-03 at a0d70165c1)
 + ci: modification of main.yml to use cmake for vs-build job
 + cmake: support for building git on windows with msvc and clang.
 + cmake: support for building git on windows with mingw
 + cmake: support for testing git when building out of the source tree
 + cmake: support for testing git with ctest
 + cmake: installation support for git
 + cmake: generate the shell/perl/python scripts and templates, translations
 + Introduce CMake support for configuring Git

 Originally merged to 'next' on 2020-08-01

 CMake support to build with MSVC for Windows bypassing the Makefile.


* tb/upload-pack-filters (2020-08-05) 4 commits
  (merged to 'next' on 2020-08-05 at 918e7092fe)
 + t5616: use test_i18ngrep for upload-pack errors
  (merged to 'next' on 2020-08-04 at 3ae57cc90c)
 + upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'
 + upload-pack.c: allow banning certain object filter(s)
 + list_objects_filter_options: introduce 'list_object_filter_config_name'

 The component to respond to "git fetch" request is made more
 configurable to selectively allow or reject object filtering
 specification used for partial cloning.
 cf. <20200804003722.GA2726931@coredump.intra.peff.net>

--------------------------------------------------
[New Topics]

* en/merge-tests (2020-08-10) 11 commits
  (merged to 'next' on 2020-08-13 at eab952350b)
 + t6425: be more flexible with rename/delete conflict messages
 + t642[23]: be more flexible for add/add conflicts involving pair renames
 + t6422, t6426: be more flexible for add/add conflicts involving renames
 + t6423: add an explanation about why one of the tests does not pass
 + t6416, t6423: clarify some comments and fix some typos
 + t6422: fix multiple errors with the mod6 test expectations
 + t6423: fix test setup for a couple tests
 + t6416, t6422: fix incorrect untracked file count
 + t6422: fix bad check against missing file
 + t6418: tighten delete/normalize conflict testcase
 + Collect merge-related tests to t64xx

 Updates to "git merge" tests, in preparation for a new merge
 strategy backend.

 Will merge to 'master'.


* ma/stop-progress-null-fix (2020-08-10) 1 commit
  (merged to 'next' on 2020-08-13 at 8bdec5209f)
 + progress: don't dereference before checking for NULL

 NULL dereference fix.

 Will merge to 'master'.


* ds/midx-repack-to-batch-size (2020-08-11) 1 commit
 - multi-pack-index: repack batches below --batch-size

 The "--batch-size" option of "git multi-pack-index repack" command
 is now used to specify that very small packfiles are collected into
 one until the total size roughly exceeds it.

 Will merge to 'next'.


* rs/upload-pack-sigchain-fix (2020-08-11) 1 commit
 - upload-pack: remove superfluous sigchain_pop() call

 Code clean-up.

 Will merge to 'next'.


* so/log-diff-merges-opt (2020-08-11) 3 commits
  (merged to 'next' on 2020-08-11 at 99e070bdca)
 + t/t4013: add test for --diff-merges=off
 + doc/git-log: describe --diff-merges=off
 + revision: change "--diff-merges" option to require parameter
 (this branch uses jk/log-fp-implies-m.)

 Earlier, to countermand the implicit "-m" option when the
 "--first-parent" option is used with "git log", we added the
 "--[no-]diff-merges" option in the jk/log-fp-implies-m topic.  To
 leave the door open to allow the "--diff-merges" option to take
 values that instructs how patches for merge commits should be
 computed (e.g. "cc"? "-p against first parent?"), redefine
 "--diff-merges" to take non-optional value, and implement "off"
 that means the same thing as "--no-diff-merges".

 Will merge to 'master' together with 'jk/lo-implies-m'.


* tb/bloom-improvements (2020-08-11) 14 commits
 - builtin/commit-graph.c: introduce '--max-new-filters=<n>'
 - commit-graph: rename 'split_commit_graph_opts'
 - commit-graph: add large-filters bitmap chunk
 - commit-graph.c: sort index into commits list
 - bloom/diff: properly short-circuit on max_changes
 - bloom: use provided 'struct bloom_filter_settings'
 - csum-file.h: introduce 'hashwrite_be64()'
 - bloom: split 'get_bloom_filter()' in two
 - commit-graph.c: store maximum changed paths
 - commit-graph: respect 'commitGraph.readChangedPaths'
 - t/helper/test-read-graph.c: prepare repo settings
 - commit-graph: pass a 'struct repository *' in more places
 - t4216: use an '&&'-chain
 - commit-graph: introduce 'get_bloom_filter_settings()'

 Misc Bloom filter improvements.

 Expecting a reroll.
 It seems that the review is getting closer to result in another update.
 cf. <20200811220503.GC66656@syl.lan>


* ak/sequencer-fix-find-uniq-abbrev (2020-08-13) 1 commit
 - rebase -i: fix possibly wrong onto hash in todo

 Ring buffer with size 4 used for bin-hex translation resulted in a
 wrong object name in the sequencer's todo output, which has been
 corrected.

 Will merge to 'next'.


* en/dir-nonbare-embedded (2020-08-12) 2 commits
 - dir: avoid prematurely marking nonbare repositories as matches
 - t3000: fix some test description typos

 "ls-files -o" mishandled the top-level directory of another git
 working tree that hangs in the current git working tree.

 Will merge to 'next'.


* en/sequencer-merge-labels (2020-08-12) 1 commit
 - sequencer: avoid garbled merge machinery messages due to commit labels

 The commit labels used to explain each side of conflicted hunks
 placed by the sequencer machinery have been made more readable by
 humans.

 Will merge to 'next'.


* jb/commit-graph-doc-fix (2020-08-13) 1 commit
 - docs: commit-graph: fix some whitespace in the diagram

 Docfix.

 Will merge to 'next'.


* jk/blame-coalesce-fix (2020-08-13) 3 commits
 - blame: only coalesce lines that are adjacent in result
 - t8003: factor setup out of coalesce test
 - t8003: check output of coalesced blame

 When given more than one target line ranges, "git blame -La,b
 -Lc,d" was over-eager to coalesce groups of original lines and
 showed incorrect results, which has been corrected.

 Will merge to 'next'.


* jk/slimmed-down (2020-08-13) 5 commits
 - drop vcs-svn experiment
 - make git-fast-import a builtin
 - make git-bugreport a builtin
 - make credential helpers builtins
 - Makefile: drop builtins from MSVC pdb list

 Trim an unused binary and turn a bunch of commands into built-in.

 In general this is a good thing to do, modulo 'bugreport'.


* jk/unleak-fixes (2020-08-13) 2 commits
 - ls-remote: simplify UNLEAK() usage
 - stop calling UNLEAK() before die()

 Fix some incorrect UNLEAK() annotations.

 Will merge to 'next'.


* pb/set-url-docfix (2020-08-13) 1 commit
 - fetch, pull doc: correct description of '--set-upstream'

 Doc fix.

 Will merge to 'next'.


* pb/userdiff-fortran-update (2020-08-13) 2 commits
 - userdiff: improve Fortran xfuncname regex
 - userdiff: add tests for Fortran xfuncname regex

 The regexp to identify the function boundary for FORTRAN programs
 has been updated.

 Will merge to 'next'.


* rs/fast-export-anon-simplify (2020-08-13) 1 commit
 - fast-export: factor out print_oid()

 Code simplification.

 Will merge to 'next'.


* rs/preserve-merges-unused-code-removal (2020-08-12) 1 commit
 - rebase: remove unused function reschedule_last_action

 Code clean-up.

 Will merge to 'next'.


* ss/t7401-modernize (2020-08-12) 4 commits
 - t7401: add a NEEDSWORK
 - t7401: change indentation for enhanced readability
 - t7401: change test_i18ncmp syntax for clarity
 - t7401: modernize style

 Test clean-up.

 Expecting a reroll.
 cf. <c70f7bb5d1289f5318da7b99e41cf5828a451174.camel@gmail.com>
 Almost there, it seems.

--------------------------------------------------
[Stalled]

* pw/rebase-i-more-options (2020-07-16) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_free
 - rebase -i: support --committer-date-is-author-date
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.

 Waiting for a (hopefully final) review.


* mt/grep-sparse-checkout (2020-06-12) 6 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - t/helper/test-config: facilitate addition of new cli options
 - t/helper/test-config: return exit codes consistently
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

 Review needed on 4/6; otherwise looking sane.
 cf. <CABPp-BGdEyEeajYZj_rdxp=MyEQdszuyjVTax=hhYj3fOtRQUQ@mail.gmail.com>


* rs/more-buffered-io (2020-08-02) 3 commits
 - upload-pack: use buffered I/O to talk to rev-list
 - midx: use buffered I/O to talk to pack-objects
 - connected: use buffered I/O to talk to rev-list

 Expecting a reroll.


* ls/mergetool-meld-auto-merge (2020-07-12) 2 commits
 - SQUASH???
 - Support auto-merge for meld to follow the vim-diff behavior

 The 'meld' backend of the "git mergetool" learned to give the
 underlying 'meld' the '--auto-merge' option, which would help
 reduce the amount of text that requires manual merging.

 Expecting a reroll.


* jx/proc-receive-hook (2020-05-18) 11 commits
 . doc: add documentation for the proc-receive hook
 . transport: parse report options for tracking refs
 . t5411: test updates of remote-tracking branches
 . receive-pack: new config receive.procReceiveRefs
 . refs.c: refactor to reuse ref_is_hidden()
 . receive-pack: feed report options to post-receive
 . doc: add document for capability report-status-v2
 . New capability "report-status-v2" for git-push
 . receive-pack: add new proc-receive hook
 . t5411: add basic test cases for proc-receive hook
 . transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Ejected out of 'seen'; somehow its tests seem to break with clang
 cf. https://travis-ci.org/github/git/git/builds/713443572


* mf/submodule-summary-with-correct-repository (2020-06-24) 2 commits
 - submodule: use submodule repository when preparing summary
 - revision: use repository from rev_info when parsing commits

 "git diff/show" on a change that involves a submodule used to read
 the information on commits in the submodule from a wrong repository
 and gave a wrong information when the commit-graph is involved.

 Needs tests.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200416152145.wp2zeibxmuyas6y6@feanor>


* mr/bisect-in-c-2 (2020-07-17) 14 commits
 . SQUASH??? do not add new users of git_path_bisect_head()
 . bisect--helper: retire `--bisect-autostart` subcommand
 . bisect--helper: retire `--write-terms` subcommand
 . bisect--helper: retire `--check-expected-revs` subcommand
 . bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 . bisect--helper: retire `--next-all` subcommand
 . bisect--helper: retire `--bisect-clean-state` subcommand
 . bisect--helper: finish porting `bisect_start()` to C
 . bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 . bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
 . bisect--helper: reimplement `bisect_autostart` shell function in C
 . bisect--helper: introduce new `write_in_file()` function
 . bisect--helper: use '-res' in 'cmd_bisect__helper' return
 . bisect--helper: BUG() in cmd_*() on invalid subcommand

 Rewrite of the remainder of "git bisect" script in C continues.

 Needs more work.
 Ejected out of 'seen'; al/bisect-first-parent topic has a bit of
 textual conflict with this topic.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* ds/maintenance-part-2 (2020-08-06) 9 commits
 - maintenance: add incremental-repack auto condition
 - maintenance: auto-size incremental-repack batch
 - maintenance: add incremental-repack task
 - midx: use start_delayed_progress()
 - midx: enable core.multiPackIndex by default
 - maintenance: create auto condition for loose-objects
 - maintenance: add loose-objects task
 - maintenance: add prefetch task
 - fetch: optionally allow disabling FETCH_HEAD update
 (this branch uses ds/maintenance.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.

 Under review.
 A "review club" reviews have been posted for an early few steps.


* ma/doc-sha-256-is-experimental (2020-08-06) 1 commit
 - Documentation: mark `--object-format=sha256` as experimental

 The recent addition of SHA-256 support is marked as experimental in
 the documentation.

 Will merge to 'next'.
 cf. <xmqqmu2y1e0t.fsf@gitster.c.googlers.com>


* rp/apply-cached-with-i-t-a (2020-08-09) 3 commits
  (merged to 'next' on 2020-08-11 at c28eaa6a0e)
 + t4140: test apply with i-t-a paths
 + apply: make i-t-a entries never match worktree
 + apply: allow "new file" patches on i-t-a entries

 Recent versions of "git diff-files" shows a diff between the index
 and the working tree for "intent-to-add" paths as a "new file"
 patch; "git apply --cached" should be able to take "git diff-files"
 and should act as an equivalent to "git add" for the path, but the
 command failed to do so for such a path.

 Will merge to 'master'.


* jc/noop-with-static-inline (2020-08-06) 1 commit
  (merged to 'next' on 2020-08-11 at 8a63ff648e)
 + compat-util: type-check parameters of no-op replacement functions

 A no-op replacement function implemented as a C preprocessor macro
 does not perform as good a job as one implemented as a "static
 inline" function in catching errors in parameters; replace the
 former with the latter in <git-compat-util.h> header.

 Will merge to 'master'.


* ps/ref-transaction-hook (2020-08-11) 2 commits
  (merged to 'next' on 2020-08-11 at 311c045810)
 + t1416: avoid hard-coded sha1 ids
  (merged to 'next' on 2020-08-10 at d8ad7cc8f6)
 + refs: fix interleaving hook calls with reference-transaction hook

 The logic to find the ref transaction hook script attempted to
 cache the path to the found hook without realizing that it needed
 to keep a copied value, as the API it used returned a transitory
 buffer space.  This has been corrected.

 Will merge to 'master'.
 to be followed by a removal of the caching feature, which does not
 seem to help even as a negative cache.


* ss/submodule-summary-in-c (2020-08-12) 4 commits
 - submodule: port submodule subcommand 'summary' from shell to C
 - t7421: introduce a test script for verifying 'summary' output
 - submodule: rename helper functions to avoid ambiguity
 - submodule: remove extra line feeds between callback struct and macro

 Yet another subcommand of "git submodule" is getting rewritten in C.

 Will merge to 'next'.


* am/ci-wsfix (2020-08-10) 1 commit
 - ci: fix inconsistent indentation

 Aesthetic fix to a CI configuration file.

 Waiting for a reroll.
 It needs a better log message.


* es/init-no-separate-git-dir-in-bare (2020-08-10) 1 commit
 - init: disallow --separate-git-dir with bare repository

 The purpose of "git init --separate-git-dir" is to initialize a
 new project with the repository separate from the working tree,
 or, in the case of an existing project, to move the repository
 (the .git/ directory) out of the working tree. It does not make
 sense to use --separate-git-dir with a bare repository for which
 there is no working tree, so disallow its use with bare
 repositories.

 Will merge to 'next'.


* es/test-cmp-typocatcher (2020-08-09) 1 commit
  (merged to 'next' on 2020-08-11 at ee5557b170)
 + test_cmp: diagnose incorrect arguments

 Test framework update.

 Will merge to 'master'.


* jk/sideband-error-l10n (2020-08-07) 1 commit
  (merged to 'next' on 2020-08-11 at 27dbe05a65)
 + sideband: mark "remote error:" prefix for translation

 Mark error message for i18n.

 Will merge to 'master'.


* rp/ita-diff-modefix (2020-08-09) 1 commit
 - diff-lib: use worktree mode in diffs from i-t-a entries

 "git diff [<tree-ish>] $path" for a $path that is marked with i-t-a
 bit was not showing the mode bits from the working tree.

 Will merge to 'next'.


* jk/log-fp-implies-m (2020-07-29) 7 commits
  (merged to 'next' on 2020-08-03 at 39fefa6b82)
 + doc/git-log: clarify handling of merge commit diffs
 + doc/git-log: move "-t" into diff-options list
 + doc/git-log: drop "-r" diff option
 + doc/git-log: move "Diff Formatting" from rev-list-options
 + log: enable "-m" automatically with "--first-parent"
 + revision: add "--no-diff-merges" option to counteract "-m"
 + log: drop "--cc implies -m" logic
 (this branch is used by so/log-diff-merges-opt.)

 Originally merged to 'next' on 2020-08-01

 "git log --first-parent -p" showed patches only for single-parent
 commits on the first-parent chain; the "--first-parent" option has
 been made to imply "-m".  Use "--no-diff-merges" to restore the
 previous behaviour to omit patches for merge commits.

 Will merge to 'master' together with 'so/log-diff-merges-opt'


* pd/mergetool-nvimdiff (2020-07-29) 2 commits
  (merged to 'next' on 2020-08-11 at 947ce686d0)
 + mergetools: add support for nvimdiff (neovim) family
 + mergetool--lib: improve support for vimdiff-style tool variants

 The existing backends for "git mergetool" based on variants of vim
 have been refactored and then support for "nvim" has been added.

 Will merge to 'master'.


* al/bisect-first-parent (2020-08-07) 5 commits
  (merged to 'next' on 2020-08-11 at b232f7ca17)
 + bisect: combine args passed to find_bisection()
 + bisect: introduce first-parent flag
 + cmd_bisect__helper: defer parsing no-checkout flag
 + rev-list: allow bisect and first-parent flags
 + t6030: modernize "git bisect run" tests

 "git bisect" learns the "--first-parent" option to find the first
 breakage along the first-parent chain.

 Will merge to 'master'.


* dd/send-email-config (2020-07-23) 1 commit
  (merged to 'next' on 2020-08-11 at aaf9f3a301)
 + git-send-email: die if sendmail.* config is set

 Stop when "sendmail.*" configuration variables are defined, which
 could be a mistaken attempt to define "sendemail.*" variables.

 Will merge to 'master'.


* hn/reftable-prep-part-2 (2020-07-27) 3 commits
  (merged to 'next' on 2020-08-11 at 43ac0bc60a)
 + Make HEAD a PSEUDOREF rather than PER_WORKTREE.
 + Modify pseudo refs through ref backend storage
 + t1400: use git rev-parse for testing PSEUDOREF existence

 Further preliminary change to refs API.

 Will merge to 'master'.


* ds/maintenance (2020-08-06) 11 commits
 - maintenance: add trace2 regions for task execution
 - maintenance: add auto condition for commit-graph task
 - maintenance: use pointers to check --auto
 - maintenance: create maintenance.<task>.enabled config
 - maintenance: take a lock on the objects directory
 - maintenance: add --task option
 - maintenance: add commit-graph task
 - maintenance: initialize task array
 - maintenance: replace run_auto_gc()
 - maintenance: add --quiet option
 - maintenance: create basic maintenance runner
 (this branch is used by ds/maintenance-part-2.)

 A "git gc"'s big brother has been introduced to take care of more
 repository maintenance tasks, not limited to the object database
 cleaning.


* mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
 - hex: make hash_to_hex_algop() and friends thread-safe
 - compat/win32/pthread: add pthread_once()

 hash_to_hex() used a set of rotating static buffers, which was not
 safe to use in a threaded environment.  This has been made safer by
 using thread-local storage.

 Expecting a reroll.
 cf. <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>


* es/config-hooks (2020-07-30) 6 commits
 - hook: add 'run' subcommand
 - parse-options: parse into argv_array
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 Expecting a reroll.
 Now jk/strvec is in 'master', we may want to see the topic reworked
 on top of it.  Are there unresolved issues, or does the topic need
 a round of detailed review?
 cf. <xmqqmu3i9kvg.fsf@gitster.c.googlers.com>
