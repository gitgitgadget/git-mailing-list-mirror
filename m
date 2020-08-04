Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DF7C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 05:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767022073E
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 05:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ipA/iqKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgHDFfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:35:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64696 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgHDFfr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 01:35:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6887387FD2;
        Tue,  4 Aug 2020 01:35:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=l
        kE9T7UGmTxMcJ5OjB/pyRpfjM8=; b=ipA/iqKHCsHZiJe+QK0DLm0z6VLuDO4D7
        KFmBU5AndXp2EvLa6e1+S8FRydGaVFu6+vIrTnlVSAQ7Xp2S30GG5J8FAbRdzirO
        1VR1Abc/vwA+WJsCwdpvsGbnIWFy2q2LaBZYTWy/tnKZJQwVSBK85yMhqrKdkpeC
        wE75Mdr34U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=l+E
        ghhwLF+AqbY7T0dXNPkZM6fslPfeKwfatmX3c2w2BCcCkHex0wejvTyrrNIw9vxV
        hdm5rx8kbL13EQMUHAu0q3PQbXxB9HzpxjPFq1kt/Qfb1gz7BNI9X2gYRloWkq/L
        68nLOAtNivxSja7+7x1ic9wBeg6nBAjiCdW+MlTw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5364387FD0;
        Tue,  4 Aug 2020 01:35:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B33DC87FCF;
        Tue,  4 Aug 2020 01:35:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2020, #01; Mon, 3)
X-master-at: 85b4e0a6dc8407de6f69808d9ee6debdf167ced3
X-next-at: 39fefa6b823f48851746819838919f3118e4317f
Date:   Mon, 03 Aug 2020 22:35:40 -0700
Message-ID: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 555462CC-D614-11EA-AB5A-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Some topics that have been cooking in 'next' during the previous
cycle, in addition to some fixes to 2.28, have been merged to
'master', and the tip of 'next' has been rewound.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* en/eol-attrs-gotchas (2020-08-03) 4 commits
 - checkout: support renormalization with checkout -m <paths>
 - merge: make merge.renormalize work for all uses of merge machinery
 - t6038: remove problematic test
 - t6038: make tests fail for the right reason

 All "mergy" operations that internally use the merge-recursive
 machinery should honor the merge.renormalize configuration, but
 many of them didn't.

 Will merge to 'next'.


* en/merge-recursive-comment-fixes (2020-08-02) 1 commit
 - merge-recursive: fix unclear and outright wrong comments

 Comment fix.

 Will merge to 'next'.


* es/adjust-subtree-test-for-merge-msg-update (2020-08-03) 1 commit
 - Revert "contrib: subtree: adjust test to change in fmt-merge-msg"

 Adjust tests in contrib/ to the recent change to fmt-merge-msg.

 Will merge to 'next'.


* es/worktree-cleanup (2020-07-31) 4 commits
 - worktree: retire special-case normalization of main worktree path
 - worktree: drop bogus and unnecessary path munging
 - worktree: drop unused code from get_linked_worktree()
 - worktree: drop pointless strbuf_release()

 Code cleanup around "worktree" API implementation.

 Will merge to 'next'.


* es/worktree-doc-cleanups (2020-08-03) 5 commits
 - git-worktree.txt: link to man pages when citing other Git commands
 - git-worktree.txt: make start of new sentence more obvious
 - git-worktree.txt: fix minor grammatical issues
 - git-worktree.txt: consistently use term "working tree"
 - git-worktree.txt: employ fixed-width typeface consistently

 Doc cleanup around "worktree".

 Will merge to 'next'.


* ma/t1450-quotefix (2020-08-01) 1 commit
 - t1450: fix quoting of NUL byte when corrupting pack

 Test fix.

 Will merge to 'next'.


* ny/notes-doc-sample-update (2020-08-03) 1 commit
 - docs: improve the example that illustrates git-notes path names

 Doc updates.

 Will merge to 'next'.


* pb/guide-docs (2020-08-02) 4 commits
 - SQUASH???
 - git.txt: add list of guides
 - help: drop usage of 'common' and 'useful' for guides
 - command-list.txt: add missing 'gitcredentials' and 'gitremote-helpers'

 Update "git help guides" documentation organization.


* rs/bisect-oid-to-hex-fix (2020-08-02) 1 commit
 - bisect: use oid_to_hex_r() instead of memcpy()+oid_to_hex()

 Code cleanup.

 Will merge to 'next'.


* rs/more-buffered-io (2020-08-02) 3 commits
 - upload-pack: use buffered I/O to talk to rev-list
 - midx: use buffered I/O to talk to pack-objects
 - connected: use buffered I/O to talk to rev-list

--------------------------------------------------
[Graduated to 'master']

* ar/help-guides-doc (2020-07-29) 1 commit
  (merged to 'next' on 2020-07-30 at e4b0370bfa)
 + git-help.txt: fix mentions of option --guides

 Doc update.


* cc/pretty-contents-size (2020-07-31) 1 commit
  (merged to 'next' on 2020-07-31 at 0ad958f31d)
 + t6300: fix issues related to %(contents:size)

 Brown-paper-bag fix.


* en/typofixes (2020-07-28) 2 commits
  (merged to 'next' on 2020-07-30 at 64776daa9a)
 + hashmap: fix typo in usage docs
 + Remove doubled words in various comments

 Typofixes.


* hn/reftable (2020-07-31) 1 commit
  (merged to 'next' on 2020-07-31 at 9e34be957e)
 + refs: move the logic to add \t to reflog to the files backend

 Brown-paper-bag fix.


* jb/doc-packfile-name (2020-07-22) 1 commit
  (merged to 'next' on 2020-07-30 at b46c3f6675)
 + pack-write/docs: update regarding pack naming

 Doc update.


* jc/fmt-merge-msg-suppress-destination (2020-07-30) 2 commits
  (merged to 'next' on 2020-07-30 at c44f57f46d)
 + fmt-merge-msg: allow merge destination to be omitted again
 + Revert "fmt-merge-msg: stop treating `master` specially"

 "git merge" learned to selectively omit " into <branch>" at the end
 of the title of default merge message with merge.suppressDest
 configuration.


* rs/grep-simpler-parse-object-or-die-call (2020-07-28) 1 commit
  (merged to 'next' on 2020-07-30 at 6d22dd3058)
 + grep: avoid using oid_to_hex() with parse_object_or_die()

 Code clean-up.


* sg/ci-git-path-fix-with-pyenv (2020-07-23) 1 commit
  (merged to 'next' on 2020-07-30 at afe304633d)
 + ci: use absolute PYTHON_PATH in the Linux jobs

 CI fixup---tests of Python scripts didn't use the version of Git
 that is being tested.


* sk/typofixes (2020-07-29) 1 commit
  (merged to 'next' on 2020-07-30 at c56d9e5313)
 + comment: fix spelling mistakes inside comments

 Typofixes.

--------------------------------------------------
[Stalled]

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

* jk/log-fp-implies-m (2020-07-29) 7 commits
  (merged to 'next' on 2020-08-03 at 39fefa6b82)
 + doc/git-log: clarify handling of merge commit diffs
 + doc/git-log: move "-t" into diff-options list
 + doc/git-log: drop "-r" diff option
 + doc/git-log: move "Diff Formatting" from rev-list-options
 + log: enable "-m" automatically with "--first-parent"
 + revision: add "--no-diff-merges" option to counteract "-m"
 + log: drop "--cc implies -m" logic

 Originally merged to 'next' on 2020-08-01

 "git log --first-parent -p" showed patches only for single-parent
 commits on the first-parent chain; the "--first-parent" option has
 been made to imply "-m".  Use "--no-diff-merges" to restore the
 previous behaviour to omit patches for merge commits.

 Waiting for the discussion to settle.
 cf. <87lfivqvgf.fsf@osv.gnss.ru>
 If Sergey wants to send in --diff-merges=(none|<num>|c|cc|all)
 enhancement reasonably soon, I do not mind holding this off for a
 bit longer out of 'master'.


* jk/strvec (2020-07-30) 11 commits
 - strvec: rename struct fields
 - strvec: drop argv_array compatibility layer
 - strvec: update documention to avoid argv_array
 - strvec: fix indentation in renamed calls
 - strvec: convert remaining callers away from argv_array name
 - strvec: convert more callers away from argv_array name
 - strvec: convert builtin/ callers away from argv_array name
 - quote: rename sq_dequote_to_argv_array to mention strvec
 - strvec: rename files from argv-array to strvec
 - argv-array: rename to strvec
 - argv-array: use size_t for count and alloc
 (this branch is used by ds/maintenance.)

 The argv_array API is useful for not just managing argv but any
 "vector" (NULL-terminated array) of strings, and has seen adoption
 to a certain degree.  It has been renamed to "strvec" to reduce the
 barrier to adoption.

 Will merge to 'next'.


* pd/mergetool-nvimdiff (2020-07-29) 2 commits
 - mergetools: add support for nvimdiff (neovim) family
 - mergetool--lib: improve support for vimdiff-style tool variants

 The existing backends for "git mergetool" based on variants of vim
 have been refactored and then support for "nvim" has been added.


* al/bisect-first-parent (2020-07-29) 3 commits
 - bisect: combine args passed to find_bisection()
 - bisect: introduce first-parent flag
 - rev-list: allow bisect and first-parent flags

 "git bisect" learns the "--first-parent" option to find the first
 breakage along the first-parent chain.


* dd/send-email-config (2020-07-23) 1 commit
 - git-send-email: die if sendmail.* config is set

 Stop when "sendmail.*" configuration variables are defined, which
 could be a mistaken attempt to define "sendemail.*" variables.


* jt/pack-objects-prefetch-in-batch (2020-07-21) 2 commits
  (merged to 'next' on 2020-08-03 at 29424e614d)
 + pack-objects: prefetch objects to be packed
 + pack-objects: refactor to oid_object_info_extended

 Originally merged to 'next' on 2020-08-01

 While packing many objects in a repository with a promissor remote,
 lazily fetching missing objects from the promissor remote one by
 one may be inefficient---the code now attempts to fetch all the
 missing objects in batch (obviously this won't work for a lazy
 clone that lazily fetches tree objects as you cannot even enumerate
 what blobs are missing until you learn which trees are missing).

 Will merge to 'master'.


* jt/pretend-object-never-come-from-elsewhere (2020-07-21) 1 commit
  (merged to 'next' on 2020-08-03 at 36cd23aae5)
 + sha1-file: make pretend_object_file() not prefetch

 Originally merged to 'next' on 2020-08-01

 The pretend-object mechanism checks if the given object already
 exists in the object store before deciding to keep the data
 in-core, but the check would have triggered lazy fetching of such
 an object from a promissor remote.

 Will merge to 'master'.


* bc/sha-256-part-3 (2020-07-30) 39 commits
 - t: remove test_oid_init in tests
 - docs: add documentation for extensions.objectFormat
 - ci: run tests with SHA-256
 - t: make SHA1 prerequisite depend on default hash
 - t: allow testing different hash algorithms via environment
 - t: add test_oid option to select hash algorithm
 - repository: enable SHA-256 support by default
 - setup: add support for reading extensions.objectformat
 - bundle: add new version for use with SHA-256
 - builtin/verify-pack: implement an --object-format option
 - http-fetch: set up git directory before parsing pack hashes
 - t0410: mark test with SHA1 prerequisite
 - t5308: make test work with SHA-256
 - t9700: make hash size independent
 - t9500: ensure that algorithm info is preserved in config
 - t9350: make hash size independent
 - t9301: make hash size independent
 - t9300: use $ZERO_OID instead of hard-coded object ID
 - t9300: abstract away SHA-1-specific constants
 - t8011: make hash size independent
 - t8003: make hash size independent
 - t8002: make hash size independent
 - t7508: use $ZERO_OID instead of hard-coded constant
 - t7506: avoid checking for SHA-1-specific constants
 - t7405: make hash size independent
 - t7400: make hash size independent
 - t7102: abstract away SHA-1-specific constants
 - t7201: abstract away SHA-1-specific constants
 - t7063: make hash size independent
 - t7003: compute appropriate length constant
 - t6501: avoid hard-coded objects
 - t6500: specify test values for SHA-256
 - t6301: make hash size independent
 - t6101: make hash size independent
 - t6100: make hash size independent
 - t3404: prepare 'short SHA-1 collision' tests for SHA-256
 - t3305: make hash agnostic
 - t1001: use $ZERO_OID
 - t: make test-bloom initialize repository

 The final leg of SHA-256 transition.

 Will merge to 'next'.


* mp/complete-show-color-moved (2020-07-15) 1 commit
  (merged to 'next' on 2020-08-03 at c90fea8e5e)
 + completion: add show --color-moved[-ws]

 Originally merged to 'next' on 2020-08-01

 Command line completion (in contrib/) update.

 Will merge to 'master'.
 A follow-up patch to reduce duplication may be warranted.


* hn/reftable-prep-part-2 (2020-07-27) 3 commits
 - Make HEAD a PSEUDOREF rather than PER_WORKTREE.
 - Modify pseudo refs through ref backend storage
 - t1400: use git rev-parse for testing PSEUDOREF existence

 Further preliminary change to refs API.


* ds/maintenance (2020-07-30) 20 commits
 - maintenance: add trace2 regions for task execution
 - midx: use start_delayed_progress()
 - maintenance: add incremental-repack auto condition
 - maintenance: create auto condition for loose-objects
 - maintenance: add auto condition for commit-graph task
 - maintenance: use pointers to check --auto
 - maintenance: create maintenance.<task>.enabled config
 - maintenance: auto-size incremental-repack batch
 - maintenance: add incremental-repack task
 - midx: enable core.multiPackIndex by default
 - maintenance: add loose-objects task
 - maintenance: add prefetch task
 - fetch: optionally allow disabling FETCH_HEAD update
 - maintenance: take a lock on the objects directory
 - maintenance: add --task option
 - maintenance: add commit-graph task
 - maintenance: initialize task array
 - maintenance: replace run_auto_gc()
 - maintenance: add --quiet option
 - maintenance: create basic maintenance runner
 (this branch uses jk/strvec.)

 A "git gc"'s big brother has been introduced to take care of more
 repository maintenance tasks, not limited to the object database
 cleaning.


* ls/mergetool-meld-auto-merge (2020-07-12) 2 commits
 - SQUASH???
 - Support auto-merge for meld to follow the vim-diff behavior

 The 'meld' backend of the "git mergetool" learned to give the
 underlying 'meld' the '--auto-merge' option, which would help
 reduce the amount of text that requires manual merging.

 Expecting a reroll.


* tb/upload-pack-filters (2020-08-03) 3 commits
 - upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'
 - upload-pack.c: allow banning certain object filter(s)
 - list_objects_filter_options: introduce 'list_object_filter_config_name'

 The component to respond to "git fetch" request is made more
 configurable to selectively allow or reject object filtering
 specification used for partial cloning.

 Will merge to 'next'.


* mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
 - hex: make hash_to_hex_algop() and friends thread-safe
 - compat/win32/pthread: add pthread_once()

 hash_to_hex() used a set of rotating static buffers, which was not
 safe to use in a threaded environment.  This has been made safer by
 using thread-local storage.

 Expecting a reroll.
 cf. <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>


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

 Will merge to 'master'.
 cf. https://github.com/git/git/runs/892824895


* es/config-hooks (2020-07-30) 6 commits
 - hook: add 'run' subcommand
 - parse-options: parse into argv_array
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.


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

--------------------------------------------------
[Discarded]

* jk/fast-export-anonym (2020-06-22) 4 commits
  (merged to 'next' on 2020-06-22 at b517b2f707)
 + fast-export: allow dumping the path mapping
 + fast-export: refactor path printing to not rely on stdout
 + fast-export: anonymize "master" refname
 + fast-export: allow dumping the refname mapping

 The way refnames are anonymized has been updated and a way to help
 debugging using the anonymized output hsa been added.

 Superseded by 'jk/fast-export-anonym-alt'.


* jk/t6000-timestamp-fix (2020-07-07) 1 commit
  (merged to 'next' on 2020-07-09 at 633bcd552f)
 + t6000: use test_tick consistently

 Test update.

 Now it is part of jk/tests-timestamp-fix with a larger scope.


* jc/no-update-fetch-head (2020-07-29) 1 commit
 . fetch: optionally allow disabling FETCH_HEAD update

 "git fetch" learned the "--[no-]write-fetch-head" option to
 optionally stop describing what was fetched in FETCH_HEAD.

 Now it is part of ds/maintenance topic.
