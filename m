Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAD7C433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3C120760
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CL3riBPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGPXbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:31:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53995 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGPXbC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 19:31:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C212E8B5D;
        Thu, 16 Jul 2020 19:30:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=j
        N158scCDhwBqxXeBtpNk7Jd/E8=; b=CL3riBPkGQUjHRysLzVMbPKfwCfKtl4jY
        jSQbwn8h/R1crGQeFcthM92m4xGnZroc1PDiDlh5dZ8q72+6d4Fk1AAbroY7vRIE
        A2SJPE9u2XVqkmKuPZUhK/N+X1pWFrWX2sOKMFw722w92ykGl7cZLliQ1KcAbPDY
        HUKNSi9nXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=wJT
        ETBQni5FJHy+RUpk5JuLitpUnLO+8eh9AByoyjeHUucqj377v/pdXC/e67QRX0tv
        DqEofP6rBAeRN8HTSkpCl7Xc/z3KvDPF8UkpJ8wHhxJ6VaQa0ymxzNE638aMmUPT
        9Gu158XiBx4MNQLsXkoMIo76cFH6voUkpCrAEqXE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 530F8E8B5C;
        Thu, 16 Jul 2020 19:30:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90504E8B5B;
        Thu, 16 Jul 2020 19:30:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2020, #03; Thu, 16)
X-master-at: b6a658bd00c9c29e07f833cabfc0ef12224e277a
X-next-at: 85f634d5a6a972c5a89293a1aca2a0a727cb6315
Date:   Thu, 16 Jul 2020 16:30:50 -0700
Message-ID: <xmqqmu3zf36d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 638B2E40-C7BC-11EA-B44A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git 2.28-rc1 has not been tagged yet.  Hopefully the three patches
in jn/v0-with-extensions-fix can gain enough support to get merged
tomorrow for the real -rc1.

As I promised, I am not paying much attention to topics that are not
relevant to the upcoming release, so the comments on the topics may
be left stale in the below.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* ct/diff-with-merge-base-clarification (2020-07-13) 2 commits
  (merged to 'next' on 2020-07-15 at 041807cbbd)
 + git-diff.txt: reorder possible usages
 + git-diff.txt: don't mark required argument as optional

 Doc update.


* sg/commit-graph-progress-fix (2020-07-09) 2 commits
  (merged to 'next' on 2020-07-09 at 3a9f916ca4)
 + commit-graph: fix "Writing out commit graph" progress counter
 + commit-graph: fix progress of reachable commits

 The code to produce progress output from "git commit-graph --write"
 had a few breakages, which have been fixed.


* ta/wait-on-aliased-commands-upon-signal (2020-07-07) 2 commits
  (merged to 'next' on 2020-07-09 at de8bde9182)
 + Wait for child on signal death for aliases to externals
 + Wait for child on signal death for aliases to builtins

 When an aliased command, whose output is piped to a pager by git,
 gets killed by a signal, the pager got into a funny state, which
 has been corrected (again).


* tb/commit-graph-no-check-oids (2020-07-15) 1 commit
  (merged to 'next' on 2020-07-15 at d97ae59198)
 + commit-graph: fix "Collecting commits from input" progress line

 Fix to the code to produce progress bar, which is new in the
 upcoming release.

--------------------------------------------------
[New Topics]

* jn/v0-with-extensions-fix (2020-07-16) 3 commits
  (merged to 'next' on 2020-07-16 at 85f634d5a6)
 + verify_repository_format(): complain about new extensions in v0 repo
 + repository: allow repository format upgrade with extensions
 + Revert "check_repository_format_gently(): refuse extensions for old repositories"

 In 2.28-rc0, we corrected a bug that some repository extensions are
 honored by mistake even in a version 0 repositories (these
 configuration variables in extensions.* namespace were supposed to
 have special meaning in repositories whose version numbers are 1 or
 higher), but this was a bit too big a change.

 Will merge to 'master' before -rc1.


* bc/sha-256-part-3 (2020-07-15) 39 commits
 - t: remove test_oid_init in tests
 - docs: add documentation for extensions.objectFormat
 - ci: run tests with SHA-256
 - t: make SHA1 prerequisite depend on default hash
 - t: allow testing different hash algorithms via environment
 - t: add test_oid option to select hash algorithm
 - Enable SHA-256 support by default
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


* jk/tests-timestamp-fix (2020-07-15) 6 commits
  (merged to 'next' on 2020-07-16 at 2c69e97b92)
 + t9100: stop depending on commit timestamps
  (merged to 'next' on 2020-07-14 at 66ee0e6b45)
 + test-lib: set deterministic default author/committer date
 + t9100: explicitly unset GIT_COMMITTER_DATE
 + t5539: make timestamp requirements more explicit
 + t9700: loosen ident timezone regex
  (merged to 'next' on 2020-07-09 at 633bcd552f)
 + t6000: use test_tick consistently

 The test framework has been updated so that most tests will run
 with predictable (artificial) timestamps.

 Will cook in 'next'.


* jc/no-update-fetch-head (2020-07-13) 1 commit
 - fetch: optionally allow disabling FETCH_HEAD update

 "git fetch" learned the "--[no-]write-fetch-head" option to
 optionally stop describing what was fetched in FETCH_HEAD.


* mp/complete-show-color-moved (2020-07-15) 1 commit
 - completion: add show --color-moved[-ws]

 Command line completion (in contrib/) update.


* hn/reftable-prep-part-2 (2020-07-16) 3 commits
 - Make HEAD a PSEUDOREF rather than PER_WORKTREE.
 - Modify pseudo refs through ref backend storage
 - t1400: use git rev-parse for testing PSEUDOREF existence
 (this branch uses hn/reftable.)

 Further preliminary change to refs API.


* jt/avoid-lazy-fetching-upon-have-check (2020-07-16) 1 commit
 - upload-pack: do not lazy-fetch "have" objects

 Fetching from a lazily cloned repository resulted at the server
 side in attempts to lazy fetch objects that the client side has,
 many of which will not be available from the third-party anyway.

 Will merge to 'next'.


* rc/add-index-entry-optim-fix (2020-07-16) 1 commit
 - read-cache: remove bogus shortcut

 Fix to an ancient bug caused by an over-eager attempt for
 optimization.

--------------------------------------------------
[Stalled]

* jx/proc-receive-hook (2020-05-18) 11 commits
 - doc: add documentation for the proc-receive hook
 - transport: parse report options for tracking refs
 - t5411: test updates of remote-tracking branches
 - receive-pack: new config receive.procReceiveRefs
 - refs.c: refactor to reuse ref_is_hidden()
 - receive-pack: feed report options to post-receive
 - doc: add document for capability report-status-v2
 - New capability "report-status-v2" for git-push
 - receive-pack: add new proc-receive hook
 - t5411: add basic test cases for proc-receive hook
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Needs review.


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


* mr/bisect-in-c-2 (2020-07-08) 13 commits
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


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* dl/test-must-fail-fixes-6 (2020-07-07) 6 commits
 - test-lib-functions: restrict test_must_fail usage
 - t9400: don't use test_must_fail with cvs
 - t9834: remove use of `test_might_fail p4`
 - t7107: don't use test_must_fail()
 - t5324: reorder `run_with_limited_open_files test_might_fail`
 - t3701: stop using `env` in force_color()

 Dev support to limit the use of test_must_fail to only git commands.


* ds/maintenance (2020-07-07) 21 commits
 - midx: use start_delayed_progress()
 - maintenance: add pack-files auto condition
 - maintenance: create auto condition for loose-objects
 - maintenance: add auto condition for commit-graph task
 - maintenance: use pointers to check --auto
 - maintenance: create maintenance.<task>.enabled config
 - maintenance: auto-size pack-files batch
 - maintenance: add pack-files task
 - maintenance: add loose-objects task
 - maintenance: add fetch task
 - maintenance: take a lock on the objects directory
 - maintenance: add --task option
 - maintenance: add commit-graph task
 - maintenance: initialize task array and hashmap
 - maintenance: replace run_auto_gc()
 - maintenance: add --quiet option
 - maintenance: create basic maintenance runner
 - gc: drop the_repository in log location
 - gc: use repo config
 - gc: use repository in too_many_loose_objects()
 - gc: use the_repository less often

 A "git gc"'s big brother has been introduced to take care of more
 repository maintenance tasks, not limited to the object database
 cleaning.


* bw/fail-cloning-into-non-empty (2020-07-10) 1 commit
  (merged to 'next' on 2020-07-14 at a52b5ce7ab)
 + git clone: don't clone into non-empty directory

 "git clone --separate-git-dir=$elsewhere" used to stomp on the
 contents of the existing directory $elsewhere, which has been
 taught to fail when $elsewhere is not an empty directory.

 Will cook in 'next'.


* cc/pretty-contents-size (2020-07-16) 3 commits
 - ref-filter: add support for %(contents:size)
 - t6300: test refs pointing to tree and blob
 - Documentation: clarify %(contents:XXXX) doc

 "git for-each-ref --format=<>" learned %(contents:size).

 Will merge to 'next'.


* ls/mergetool-meld-auto-merge (2020-07-12) 2 commits
 - SQUASH???
 - Support auto-merge for meld to follow the vim-diff behavior

 The 'meld' backend of the "git mergetool" learned to give the
 underlying 'meld' the '--auto-merge' option, which would help
 reduce the amount of text that requires manual merging.


* pb/log-rev-list-doc (2020-07-08) 6 commits
  (merged to 'next' on 2020-07-14 at f1104dfb77)
 + git-log.txt: include rev-list-description.txt
 + git-rev-list.txt: move description to separate file
 + git-rev-list.txt: tweak wording in set operations
 + git-rev-list.txt: fix Asciidoc syntax
 + revisions.txt: describe 'rev1 rev2 ...' meaning for ranges
 + git-log.txt: add links to 'rev-list' and 'diff' docs

 "git help log" has been enhanced by sharing more material from the
 documentation for the underlying "git rev-list" command.

 Will cook in 'next'.


* tb/upload-pack-filters (2020-07-06) 4 commits
 - upload-pack.c: introduce 'uploadpack.filter.tree.maxDepth'
 - upload-pack.c: pass 'struct list_objects_filter_options *'
 - upload-pack.c: allow banning certain object filter(s)
 - list_objects_filter_options: introduce 'list_object_filter_config_name'

 The component to respond to "git fetch" request is made more
 configurable to selectively allow or reject object filtering
 specification used for partial cloning.

 Waiting for reviews to settle.
 cf. <cover.1593720075.git.me@ttaylorr.com>
 cf. <20200710022609.GC39052@syl.lan>


* mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
 - hex: make hash_to_hex_algop() and friends thread-safe
 - compat/win32/pthread: add pthread_once()

 hash_to_hex() used a set of rotating static buffers, which was not
 safe to use in a threaded environment.  This has been made safer by
 using thread-local storage.

 Expecting a reroll.
 cf. <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>


* ds/commit-graph-bloom-updates (2020-07-01) 10 commits
  (merged to 'next' on 2020-07-06 at 177e6b362e)
 + commit-graph: check all leading directories in changed path Bloom filters
 + revision: empty pathspecs should not use Bloom filters
 + revision.c: fix whitespace
 + commit-graph: check chunk sizes after writing
 + commit-graph: simplify chunk writes into loop
 + commit-graph: unify the signatures of all write_graph_chunk_*() functions
 + commit-graph: persist existence of changed-paths
 + bloom: fix logic in get_bloom_filter()
 + commit-graph: change test to die on parse, not load
 + commit-graph: place bloom_settings in context
 (this branch uses sg/commit-graph-cleanups.)

 Updates to the changed-paths bloom filter.

 Will cook in 'next'.


* ss/cmake-build (2020-06-26) 8 commits
 - ci: modification of main.yml to use cmake for vs-build job
 - cmake: support for building git on windows with msvc and clang.
 - cmake: support for building git on windows with mingw
 - cmake: support for testing git when building out of the source tree
 - cmake: support for testing git with ctest
 - cmake: installation support for git
 - cmake: generate the shell/perl/python scripts and templates, translations
 - Introduce CMake support for configuring Git

 CMake support to build with MSVC for Windows bypassing the Makefile.

 Waiting for a (hopefully final) review.


* sg/commit-graph-cleanups (2020-06-08) 10 commits
  (merged to 'next' on 2020-07-06 at 15c9d77eb9)
 + commit-graph: simplify write_commit_graph_file() #2
 + commit-graph: simplify write_commit_graph_file() #1
 + commit-graph: simplify parse_commit_graph() #2
 + commit-graph: simplify parse_commit_graph() #1
 + commit-graph: clean up #includes
 + diff.h: drop diff_tree_oid() & friends' return value
 + commit-slab: add a function to deep free entries on the slab
 + commit-graph-format.txt: all multi-byte numbers are in network byte order
 + commit-graph: fix parsing the Chunk Lookup table
 + tree-walk.c: don't match submodule entries for 'submod/anything'
 (this branch is used by ds/commit-graph-bloom-updates.)

 The changed-path Bloom filter is improved using ideas from an
 independent implementation.

 Will cook in 'next'.


* es/config-hooks (2020-05-21) 4 commits
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 What's the status of this one?  Abandoned?


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


* hn/reftable (2020-07-10) 4 commits
  (merged to 'next' on 2020-07-14 at e524883fec)
 + reflog: cleanse messages in the refs.c layer
 + bisect: treat BISECT_HEAD as a pseudo ref
 + t3432: use git-reflog to inspect the reflog for HEAD
 + lib-t6000.sh: write tag using git-update-ref
 (this branch is used by hn/reftable-prep-part-2.)

 Preliminary clean-up of the refs API in preparation for adding a
 new refs backend "reftable".

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* jc/credential-store-file-format-doc (2020-04-27) 1 commit
 . credential-store: document the file format a bit more

 Now has become a part of Carlo's credential-store fix patches.


* js/ci-skip-on-github-workflow (2020-05-02) 1 commit
 . ci: respect the [skip ci] convention in our GitHub workflow "CI/PR"

 Allow contributors to mark a branch/push that it does not have to
 be built via GitHub actions, in a way similar to how Travis lets
 them mark the commits with an embedded "[skip ci]" string.

 Superseded by dd/ci-only-on-selective-branches topic.


* dd/ci-only-on-selective-branches (2020-05-05) 2 commits
 - CI: limit GitHub Actions to designated branches
 - SubmittingPatches: advertise GitHub Actions CI

 Instead of always building all branches of all forks of our project
 at GitHub via GitHub Actions, only build when branches with known
 and specific names are updated, and also a pull request.

 Superseded by jk/ci-only-on-selected-branches


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


* ds/upgrade-with-existing-extension (2020-07-14) 2 commits
 . config: provide extra detail about worktree config
 . setup: tweak upgrade policy to grandfather worktreeconfig
 (this branch is used by jc/upgrade-v0-fixup.)

 In 2.28-rc0, we corrected a bug that some repository extensions are
 honored by mistake even in a version 0 repositories (these
 configuration variables in extensions.* namespace were supposed to
 have special meaning in repositories whose version numbers are 1 or
 higher), but this was a bit too big a change.

 Superseded by jn/v0-with-extensions-fix


* jc/upgrade-v0-fixup (2020-07-15) 1 commit
 . setup: grandfather other extensions that used to be honored by mistake
 (this branch uses ds/upgrade-with-existing-extension.)
