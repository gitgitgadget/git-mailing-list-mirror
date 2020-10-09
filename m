Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BCCC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDA9222BA
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="krAy8zDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389503AbgJIP77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 11:59:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63006 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389135AbgJIP77 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 11:59:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B36887E97;
        Fri,  9 Oct 2020 11:59:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=o
        I/vZcZgiKM7sCh0BRFGyZVhiSM=; b=krAy8zDxP6tTdCuFSpIxKDRMR/RdL/B7d
        M67+CgPfe6O0GQHhbz7+TvDg1pj6kqmt6Bc2xlHSAp1QJtzwM6q4997ZxUZkPFBL
        wcumMEGkFNfzDQXZFUqF3vYxN2YVRbJoSUpoX9S5iiEaqI0hmQzvjGEjy3cuv+1S
        4YVK032WHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=jRj
        HLSgSRkVNkviNfBg2kRNTPI8j20Bo9lweTaUM4JJFeuvBIpMs9MYtw7C9DvMCl93
        GsxQUTQ9uqKtrXbaE2cBpiAGEnlDtF+qQOfH5GIaz2gfebmUxdalFmwC/p8yj0xF
        w2JdK38AYBhN5L5+cDYtZCvT41I5ixQ08LiMrQjc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21E6987E96;
        Fri,  9 Oct 2020 11:59:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A005687E95;
        Fri,  9 Oct 2020 11:59:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2020, #02; Fri, 9)
X-master-at: d4a392452e292ff924e79ec8458611c0f679d6d4
X-next-at: fa9743e501541a5315e5d4873d4e0245bccccd89
Date:   Fri, 09 Oct 2020 08:59:51 -0700
Message-ID: <xmqq362nv18o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7714E054-0A48-11EB-BC85-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'seen' (formerly 'pu'---proposed updates) while
commits prefixed with '+' are in 'next'.  The ones marked with '.'
do not appear in any of the integration branches, but I am still
holding onto them.

The first release candidate for this cycle, Git v2.29.0-rc1, has
been tagged.  This -rc1 turned out to be a bit more ambitious than
usual in how I handled young-but-small topics.  I would have left
them out, saying "their benefit is low and don't have to be in the
upcoming release", in past cycles.  But this time, I tried to cram
them in -rc1, with an updated excluse "their scope is so small that
they cannot be so wrong to delay the release even if we later find
problems in them, so there is no point in delaying".

We'll see how well it turns out.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* dl/makefile-sort (2020-10-08) 1 commit
  (merged to 'next' on 2020-10-08 at a303ef6d14)
 + Makefile: ASCII-sort += lists

 Makefile clean-up.


* dl/mingw-header-cleanup (2020-10-07) 1 commit
  (merged to 'next' on 2020-10-08 at 35516a8b50)
 + compat/mingw.h: drop extern from function declaration

 Header clean-up.


* hx/push-atomic-with-cert (2020-10-06) 1 commit
  (merged to 'next' on 2020-10-08 at 0729586aa5)
 + t5534: split stdout and stderr redirection

 Hotfix to a recently added test script.


* ja/misc-doc-fixes (2020-10-08) 4 commits
  (merged to 'next' on 2020-10-08 at 167d6696bc)
 + doc: fix the bnf like style of some commands
 + doc: git-remote fix ups
 + doc: use linkgit macro where needed.
 + git-bisect-lk2009: make continuation of list indented

 Doc fixes.


* jk/index-pack-hotfixes (2020-10-07) 3 commits
  (merged to 'next' on 2020-10-08 at 46f5340c07)
 + index-pack: make get_base_data() comment clearer
 + index-pack: drop type_cas mutex
 + index-pack: restore "resolving deltas" progress meter

 Hotfix and clean-up for the jt/threaded-index-pack topic that has
 graduated to v2.29-rc0.


* js/ci-ghwf-dedup-tests (2020-10-08) 2 commits
  (merged to 'next' on 2020-10-08 at 83db2c0a89)
 + ci: do not skip tagged revisions in GitHub workflows
 + ci: skip GitHub workflow runs for already-tested commits/trees

 The logic to skip testing on the tagged commit and the tag itself
 was not quite consistent which led to failure of Windows test
 tasks.  It has been revamped to consistently skip revisions that
 have already been tested, based on the tree object of the revision.


* js/default-branch-name-part-3 (2020-10-08) 2 commits
  (merged to 'next' on 2020-10-08 at 1c02be024d)
 + tests: avoid using the branch name `main`
 + t1415: avoid using `main` as ref name

 Test preparation for the switch of default branch name continues.


* js/ghwf-setup-msbuild-update (2020-10-07) 1 commit
  (merged to 'next' on 2020-10-08 at d4c704f844)
 + GitHub workflow: automatically follow minor updates of setup-msbuild

 CI update.


* js/no-builtins-on-disk-option (2020-10-07) 1 commit
  (merged to 'next' on 2020-10-08 at 4033181bc4)
 + help: do not expect built-in commands to be hardlinked

 Hotfix to breakage introduced in the topic in v2.29-rc0

--------------------------------------------------
[New Topics]

* ag/merge-strategies-in-c (2020-10-06) 11 commits
 - sequencer: use the "octopus" merge strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-index: don't fork if the requested program is `git-merge-one-file'
 - merge-index: libify merge_one_path() and merge_all()
 - merge-one-file: rewrite in C
 - t6027: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.


* jk/symlinked-dotgitx-files (2020-10-06) 8 commits
  (merged to 'next' on 2020-10-08 at b9e128a280)
 + fsck: complain when .gitattributes or .gitignore is a symlink
 + verify_path(): disallow symlinks in .gitattributes and .gitignore
 + t0060: test obscured .gitattributes and .gitignore matching
 + t7450: test .gitmodules symlink matching against obscured names
 + t7450: test verify_path() handling of gitmodules
 + t7415: rename to expand scope
 + fsck_tree(): wrap some long lines
 + fsck_tree(): fix shadowed variable

 "git fsck" and the corresponding check done during the transport
 learned to ensure that in-tree files like `.gitignore` and
 `.gitattributes` are not symbolic links.

 Will cook in 'next'.


* dl/checkout-guess (2020-10-08) 2 commits
  (merged to 'next' on 2020-10-08 at c9a6bc9a54)
 + checkout: learn to respect checkout.guess
 + Documentation/config/checkout: replace sq with backticks

 "git checkout" learned to use checkout.guess configuration variable
 and enable/disable its "--[no-]guess" option accordingly.

 Will cook in 'next'.


* dl/checkout-p-merge-base (2020-10-07) 4 commits
  (merged to 'next' on 2020-10-08 at 807e047d68)
 + t2016: add a NEEDSWORK about the PERL prerequisite
 + add-patch: add NEEDSWORK about comparing commits
 + Doc: document "A...B" form for <tree-ish> in checkout and switch
 + builtin/checkout: fix `git checkout -p HEAD...` bug

 "git checkout -p A...B [-- <path>]" did not work, even though the
 same command without "-p" correctly used the merge-base between
 commits A and B.

 Will cook in 'next'.


* dl/resurrect-update-for-sha256 (2020-10-08) 2 commits
 - contrib/git-resurrect.sh: use hash-agnostic OID pattern
 - contrib/git-resurrect.sh: indent with tabs

 "git resurrect" script (in contrib/) learned that the object names
 may be longer than 40-hex depending on the hash function in use.


* ds/commit-graph-merging-fix (2020-10-08) 1 commit
 - commit-graph: ignore duplicates when merging layers

 When "git commit-graph" detects the same commit recorded more than
 once while it is merging the layers, it used to die.  The code now
 ignores all but one of them and continues.

 Shouldn't it make sure all copies match, or discard all of them, to
 avoid random corruptions kept in the repository?


* ds/maintenance-commit-graph-auto-fix (2020-10-08) 1 commit
 - maintenance: test commit-graph auto condition

 Test-coverage enhancement of running commit-graph task "git
 maintenance" as needed led to discovery and fix of a bug.


* js/userdiff-php (2020-10-07) 1 commit
  (merged to 'next' on 2020-10-08 at 988c7ea068)
 + userdiff: PHP: catch "abstract" and "final" functions

 Userdiff for PHP update.

 Will cook in 'next'.


* kb/userdiff-rust-macro-rules (2020-10-07) 1 commit
  (merged to 'next' on 2020-10-08 at 949063bcae)
 + userdiff: recognize 'macro_rules!' as starting a Rust function block

 Userdiff for Rust update.

 Will cook in 'next'.


* rk/completion-stash (2020-10-07) 2 commits
  (merged to 'next' on 2020-10-08 at ad60933f40)
 + git-completion.bash: stash-show: complete $__git_diff_common_options
 + git-completion.bash: __git_diff_common_options: add --[no-]patch

 The command line completion script (in contrib/) learned that "git
 stash show" takes the options "git diff" takes.

 Will cook in 'next'.


* sd/userdiff-css-update (2020-10-08) 1 commit
  (merged to 'next' on 2020-10-08 at 69b7e9df5d)
 + userdiff: expand detected chunk headers for css

 Userdiff for CSS update.

 Will cook in 'next'.


* ss/submodule-add-in-c (2020-10-07) 3 commits
 - t7400: add test to check 'submodule add' for tracked paths
 - submodule: port submodule subcommand 'add' from shell to C
 - dir: change the scope of function 'directory_exists_in_index()'

 "git submodule add" being rewritten in C.


* ak/corrected-commit-date (2020-10-08) 10 commits
 - doc: add corrected commit date info
 - commit-reach: use corrected commit dates in paint_down_to_common()
 - commit-graph: use generation v2 only if entire chain does
 - commit-graph: implement generation data chunk
 - commit-graph: implement corrected commit date
 - commit-graph: add a slab to store topological levels
 - commit-graph: return 64-bit generation number
 - commit-graph: consolidate fill_commit_graph_info
 - revision: parse parent in indegree_walk_step()
 - commit-graph: fix regression when computing Bloom filters

 The commit-graph learned to use corrected commit dates instead of
 the generation number to help topological revision traversal.

--------------------------------------------------
[Stalled]

* sv/t7001-modernize (2020-09-25) 11 commits
 - t7001: move cleanup code from outside the tests into them
 - t7001: use `test` rather than `[`
 - t7001: use here-docs instead of echo
 - t7001: put each command on a separate line
 - t7001: use ': >' rather than 'touch'
 - t7001: change (cd <path> && git foo) to (git -C <path> foo)
 - t7001: remove whitespace after redirect operators
 - t7001: change the style for cd according to subshell
 - t7001: remove unnecessary blank lines
 - t7001: use TAB instead of spaces
 - t7001: convert tests from the old style to the current style

 Test script modernization.

 Expecting a reroll.
 cf. <20200925170256.11490-1-shubhunic@gmail.com>


* ew/decline-core-abbrev (2020-09-01) 1 commit
 - core.abbrev <off|false|no> disables abbreviations

 Allow the configuration to specify no abbreviation regardless of
 the hash algorithm.

 Expecting a reroll.  The intent is very good.


* bc/rev-parse-path-format (2020-09-08) 1 commit
 - rev-parse: add option for absolute or relative path formatting

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.

 Expecting a reroll.
 cf. <20200909222333.GH241078@camp.crustytoothpaste.net>


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 - config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Needs more work.


* vv/send-email-with-less-secure-apps-access (2020-08-29) 1 commit
 - Documentation/git-send-email.txt: Mention less secure app access might need to enable.

 Doc update.

 Expecting a reroll.
 cf. <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
 cf. <xmqqft85i72s.fsf@gitster.c.googlers.com>


* jc/war-on-dashed-git (2020-08-27) 1 commit
 - git: catch an attempt to run "git-foo"

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 On hold for now.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Discard for now.
 cf. <xmqqv9gu7c61.fsf@gitster.c.googlers.com>
 cf. <20200911214358.acl3hy2e763begoo@feanor>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* mk/diff-ignore-regex (2020-10-01) 2 commits
 - t: add -I<regex> tests
 - diff: add -I<regex> that ignores matching changes

 "git diff" family of commands learned the "-I<regex>" option to
 ignore hunks whose changed lines all match the given pattern.

 Expecting a reroll.
 cf. <20201007194821.GA20549@larwa.hq.kempniu.pl>


* mt/parallel-checkout-part-1 (2020-10-05) 20 commits
  (merged to 'next' on 2020-10-05 at 571e16d68a)
 + parallel-checkout: drop unused checkout state parameter
  (merged to 'next' on 2020-10-04 at 20438c1143)
 + ci: run test round with parallel-checkout enabled
 + parallel-checkout: add tests related to .gitattributes
 + parallel-checkout: add tests related to clone collisions
 + parallel-checkout: add tests for basic operations
 + checkout-index: add parallel checkout support
 + builtin/checkout.c: complete parallel checkout support
 + make_transient_cache_entry(): optionally alloc from mem_pool
 + parallel-checkout: support progress displaying
 + parallel-checkout: make it truly parallel
 + unpack-trees: add basic support for parallel checkout
 + entry: add checkout_entry_ca() which takes preloaded conv_attrs
 + entry: move conv_attrs lookup up to checkout_entry()
 + entry: extract cache_entry update from write_entry()
 + entry: make fstat_output() and read_blob_entry() public
 + entry: extract a header file for entry.c functions
 + convert: add conv_attrs classification
 + convert: add get_stream_filter_ca() variant
 + convert: add [async_]convert_to_working_tree_ca() variants
 + convert: make convert_attrs() and convert structs public

 Parallel checkout.

 Will cook in 'next'.


* dl/diff-merge-base (2020-09-21) 10 commits
 - contrib/completion: complete `git diff --merge-base`
 - builtin/diff-tree: learn --merge-base
 - builtin/diff-index: learn --merge-base
 - t4068: add --merge-base tests
 - diff-lib: define diff_get_merge_base()
 - diff-lib: accept option flags in run_diff_index()
 - contrib/completion: extract common diff/difftool options
 - git-diff.txt: backtick quote command text
 - git-diff-index.txt: make --cached description a proper sentence
 - t4068: remove unnecessary >tmp

 "git diff A...B" learned "git diff --merge-base A B", which is a
 longer short-hand to say the same thing.


* sb/clone-origin (2020-09-30) 7 commits
  (merged to 'next' on 2020-10-06 at 7178c9af9c)
 + clone: allow configurable default for `-o`/`--origin`
 + clone: read new remote name from remote_name instead of option_origin
 + clone: validate --origin option before use
 + refs: consolidate remote name validation
 + remote: add tests for add and rename with invalid names
 + clone: use more conventional config/option layering
 + clone: add tests for --template and some disallowed option pairs

 "git clone" learned clone.defaultremotename configuration variable
 to customize what nickname to use to call the remote the repository
 was cloned from.

 Will cook in 'next'.


* sk/force-if-includes (2020-10-03) 4 commits
  (merged to 'next' on 2020-10-04 at 09c4c1e088)
 + t, doc: update tests, reference for "--force-if-includes"
 + push: parse and set flag for "--force-if-includes"
 + push: add reflog check for "--force-if-includes"
 + Merge branch 'ds/in-merge-bases-many-optim-bug' into sk/force-if-includes

 "git push --force-with-lease[=<ref>]" can easily be misused to lose
 commits unless the user takes good care of their own "git fetch".
 A new option "--force-if-includes" attempts to ensure that what is
 being force-pushed was created after examining the commit at the
 tip of the remote ref that is about to be force-replaced.

 Will cook in 'next'.


* hn/reftable (2020-10-01) 13 commits
 . reftable: "test-tool dump-reftable" command.
 . reftable: rest of library
 . reftable: file level tests
 . reftable: read reftable files
 . reftable: write reftable files
 . reftable: a generic binary tree implementation
 . reftable: reading/writing blocks
 . reftable: (de)serialization for the polymorphic record type.
 . reftable: utility functions
 . reftable: add a barebones unittest framework
 . vcxproj: adjust for the reftable changes
 . reftable: define the public API
 . reftable: add LICENSE

 The reftable backend for the refs API.

 Expecting a reroll.
 Seems not to build for Windows folks.
 cf. <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet>
 cf. <nycvar.QRO.7.76.6.2010021557570.50@tvgsbejvaqbjf.bet>


* ds/maintenance-part-3 (2020-10-05) 7 commits
 - maintenance: add troubleshooting guide to docs
 - maintenance: use default schedule if not configured
 - maintenance: add start/stop subcommands
 - maintenance: add [un]register subcommands
 - for-each-repo: run subcommands on configured repos
 - maintenance: add --schedule option and config
 - maintenance: optionally skip --auto process
 (this branch uses ds/maintenance-part-2.)

 Parts of "git maintenance" to ease writing crontab entries (and
 other scheduling system configuration) for it.

 cf. <20201005195701.14268-1-martin.agren@gmail.com>


* es/config-hooks (2020-09-09) 9 commits
 - run_commit_hook: take strvec instead of varargs
 - commit: use config-based hooks
 - hook: replace run-command.h:find_hook
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 Expecting a reroll.
 cf. <20201005212751.GH331156@google.com>


* mt/grep-sparse-checkout (2020-09-10) 9 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - config: make do_git_config_sequence receive a 'struct repository'
 - t/helper/test-config: unify exit labels
 - t/helper/test-config: diagnose missing arguments
 - t/helper/test-config: be consistent with exit codes
 - t1308-config-set: avoid false positives when using test-config
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.


* ds/maintenance-part-2 (2020-09-25) 8 commits
  (merged to 'next' on 2020-10-04 at c2a46f390c)
 + maintenance: add incremental-repack auto condition
 + maintenance: auto-size incremental-repack batch
 + maintenance: add incremental-repack task
 + midx: use start_delayed_progress()
 + midx: enable core.multiPackIndex by default
 + maintenance: create auto condition for loose-objects
 + maintenance: add loose-objects task
 + maintenance: add prefetch task
 (this branch is used by ds/maintenance-part-3.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.

 Will cook in 'next'.
