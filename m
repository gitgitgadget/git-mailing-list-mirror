Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FEBC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 19:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACBE206B6
	for <git@archiver.kernel.org>; Wed, 20 May 2020 19:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xokl1bB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgETTRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 15:17:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56835 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgETTRa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 15:17:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B7835FC94;
        Wed, 20 May 2020 15:17:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=j
        37dRi7BQw3KfILZwc5Sr26wpC0=; b=xokl1bB9LimMWk681yQQODK+/wp59gJ/f
        5tFPnizcGQYpsdwmbWtOagIj42s0zHbuFew8WO7Aa+WYX6sDqjeX3Zj3tDq4pzQJ
        UtuLKCXHKQW9FzkypW29WdnPBYeqf2ULGYBMtmwL2G804yxzNEjgKqkgFJgvtd6+
        u1EpxVdMuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=JEg
        IHZvejKhMKKbRHB6gGMUSdEvye9m0RCOW7sySLPbo0YnaghLMy9KFfI7jg/+xBEQ
        90VvFLkpFjQTPFUrOY5gigKtvR6/dMczLjjRp8UBpjYYn9KLAJTeiL+SEIvLCt4K
        1TS0+MnyfM/Y6tkodvlO4YQeka4WwTYfNBo+QvDc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81FEB5FC93;
        Wed, 20 May 2020 15:17:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1C4E5FC91;
        Wed, 20 May 2020 15:17:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2020, #07; Wed, 20)
X-master-at: 87680d32efb6d14f162e54ad3bda4e3d6c908559
X-next-at: 8d5cacc8d1ede34c079dff20da097c4e1f481d2c
Date:   Wed, 20 May 2020 12:17:21 -0700
Message-ID: <xmqqr1vev2ke.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87B20F7A-9ACE-11EA-BD2A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git 2.27-rc1 has been tagged.  There are a handful of topics to
further fix-up what we have been built during this cycle still not
in 'next', and they will be merged to 'next' later today and then
down to 'master' before -rc2.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ak/slab-decl-cleanup (2020-05-18) 1 commit
  (merged to 'next' on 2020-05-19 at 7de41005de)
 + commit-slab-decl.h: update include guard

 Code clean-up.


* cb/no-more-gmtime (2020-05-14) 1 commit
  (merged to 'next' on 2020-05-15 at 160e0ada09)
 + compat: remove gmtime

 Code clean-up by removing a compatibility implementation of a
 function we no longer use.


* dd/t1509-i18n-fix (2020-05-13) 1 commit
  (merged to 'next' on 2020-05-15 at a6342455c1)
 + t1509: correct i18n test

 A few tests were not i18n clean.


* ds/trace-log-progress-fix (2020-05-15) 1 commit
  (merged to 'next' on 2020-05-15 at d82c1fd03f)
 + progress: call trace2_region_leave() only after calling _enter()

 Last-minute fix for our recent change to allow use of progress API
 as a traceable region.


* en/merge-rename-rename-worktree-fix (2020-05-14) 1 commit
  (merged to 'next' on 2020-05-15 at 7e1ddfa3c9)
 + merge-recursive: fix rename/rename(1to2) for working tree with a binary

 When a binary file gets modified and renamed on both sides of history
 to different locations, both files would be written to the working
 tree but both would have the contents from "ours".  This has been
 corrected so that the path from each side gets their original content.


* en/sparse-checkout (2020-05-15) 1 commit
  (merged to 'next' on 2020-05-15 at d4b3058787)
 + unpack-trees: also allow get_progress() to work on a different index

 Consistency fix to a topic already in 'master'.


* es/bugreport (2020-05-18) 1 commit
  (merged to 'next' on 2020-05-19 at ede8c892b8)
 + git-bugreport.txt: adjust reference to strftime(3)

 Doc fix.


* jc/fix-tap-output-under-bash (2020-05-15) 3 commits
  (merged to 'next' on 2020-05-15 at de8f92d652)
 + Revert "tests: when run in Bash, annotate test failures with file name/line number"
 + Revert "ci: add a problem matcher for GitHub Actions"
 + Revert "t/test_lib: avoid naked bash arrays in file_lineno"

 A recent attempt to make the test output nicer to view on CI
 systems broke TAP output under bash.  The effort has been reverted
 to be re-attempted in the next cycle.


* js/ci-sdk-download-fix (2020-05-15) 1 commit
  (merged to 'next' on 2020-05-15 at 9b28f7ec87)
 + ci: avoid pounding on the poor ci-artifacts container

 Instead of downloading Windows SDK for CI jobs for windows builds
 from an external site (wingit.blob.core.windows.net), use the one
 created in the windows-build job, to work around quota issues at
 the external site.

--------------------------------------------------
[New Topics]

* bc/faq (2020-05-20) 1 commit
 - command-list.txt: add gitfaq to the list of guides

 "git help guides" now includes the newly added FAQ document.

 Will merge to 'next' and then to 'master'.


* cb/bisect-replay-with-dos-fix (2020-05-20) 1 commit
 - bisect: avoid tailing CR characters from revision in replay

 Re-fix longstanding "edited bisect log may confuse bisect replay
 with trailing carriage-return" issue.

 Will merge to 'next' and then to 'master'.


* dl/merge-autostash (2020-05-20) 1 commit
 - t5520: avoid alternation in grep's BRE (not POSIX)

 Test fix.

 Will merge to 'next' and then to 'master'.


* gs/commit-graph-path-filter (2020-05-20) 1 commit
 - t4216: avoid unnecessary subshell in test_bloom_filters_not_used

 Test fix.

 Will merge to 'next' and then to 'master'.

--------------------------------------------------
[Stalled]

* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200416152145.wp2zeibxmuyas6y6@feanor>


* pw/rebase-i-more-options (2020-04-29) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_free
 - rebase -i: support --committer-date-is-author-date
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.

 Expecting a reroll.
 cf. <c3dad0e2-e381-499a-af02-ef3f49207c49@gmail.com>


* jk/complete-git-switch (2020-04-28) 11 commits
 - completion: complete remote branches for git switch --track
 - completion: recognize -c/-C when completing for git switch
 - completion: fix completion for git switch with no options
 - completion: perform DWIM logic directly in __git_complete_refs
 - completion: extract function __git_dwim_remote_heads
 - completion: rename --track option of __git_complete_refs
 - completion: stop completing refs for git switch --orphan
 - completion: add tests showing lack of support for git switch -c/-C
 - completion: add test highlighting subpar git switch --track completion
 - completion: add test showing subpar git switch completion
 - completion: add some simple test cases for git switch completion

 The command line completion (in contrib/) learned to complete
 options that the "git switch" command takes.

 Needs review.


* dl/test-must-fail-fixes-5 (2020-05-05) 4 commits
 - lib-submodule-update: pass OVERWRITING_FAIL
 - lib-submodule-update: prepend "git" to $command
 - lib-submodule-update: consolidate --recurse-submodules
 - lib-submodule-update: add space after function name

 The effort to avoid using test_must_fail on non-git command continues.

 Needs review.
 cf. <cover.1588162842.git.liu.denton@gmail.com>


* mr/bisect-in-c-2 (2020-04-23) 12 commits
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: finish porting `bisect_start()` to C
 - bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 - bisect--helper: reimplement `bisect_autostart` shell function in C
 - bisect--helper: introduce new `write_in_file()` function
 - bisect--helper: use '-res' in 'cmd_bisect__helper' return
 - bisect--helper: fix `cmd_*()` function switch default return

 Rewrite of the remainder of "git bisect" script in C continues.

 Needs review.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* an/merge-single-strategy-optim (2020-05-19) 1 commit
  (merged to 'next' on 2020-05-20 at 8d5cacc8d1)
 + merge: optimization to skip evaluate_result for single strategy

 Code optimization for a common case.

 Will cook in 'next'.


* cc/upload-pack-data (2020-05-18) 13 commits
 - upload-pack: use upload_pack_data fields in receive_needs()
 - upload-pack: pass upload_pack_data to create_pack_file()
 - upload-pack: remove static variable 'stateless_rpc'
 - upload-pack: pass upload_pack_data to check_non_tip()
 - upload-pack: pass upload_pack_data to send_ref()
 - upload-pack: move symref to upload_pack_data
 - upload-pack: use upload_pack_data writer in receive_needs()
 - upload-pack: pass upload_pack_data to receive_needs()
 - upload-pack: pass upload_pack_data to get_common_commits()
 - upload-pack: use 'struct upload_pack_data' in upload_pack()
 - upload-pack: move 'struct upload_pack_data' around
 - upload-pack: move {want,have}_obj to upload_pack_data
 - upload-pack: remove unused 'wants' from upload_pack_data

 Code clean-up.


* dl/remote-curl-deadlock-fix (2020-05-19) 7 commits
 - stateless-connect: send response end packet
 - pkt-line: define PACKET_READ_RESPONSE_END
 - remote-curl: error on incomplete packet
 - pkt-line: extern packet_length()
 - transport: extract common fetch_pack() call
 - remote-curl: remove label indentation
 - remote-curl: fix typo

 On-the-wire protocol v2 easily falls into a deadlock between the
 remote-curl helper and the fetch-pack process when the server side
 prematurely throws an error and disconnects.  The communication has
 been updated to make it more robust.

 Will merge to 'next'.


* gp/hppa-stack-test-fix (2020-05-18) 1 commit
  (merged to 'next' on 2020-05-20 at 57ed63b4ad)
 + tests: skip small-stack tests on hppa architecture

 Platform dependent tweak to a test for HP-PA.

 Will merge to 'master'.


* jk/ci-only-on-selected-branches (2020-05-18) 1 commit
 - ci/config: correct instruction for CI preferences

 Dev support.

 Will merge to 'next'.


* la/diff-relative-config (2020-05-19) 1 commit
 - diff: add config option relative

 The commands in the "diff" family learned to honor "diff.relative"
 configuration variable.

 Almost there.
 cf. <20200519230124.GA12509@danh.dev>


* ma/doc-fixes (2020-05-18) 5 commits
 - git-sparse-checkout.txt: add missing '
 - git-credential.txt: use list continuation
 - git-commit-graph.txt: fix list rendering
 - git-commit-graph.txt: fix grammo
 - date-formats.txt: fix list continuation

 Various doc fixes.

 Will merge to 'next' and then to 'master'.


* dd/t5703-grep-a-fix (2020-05-19) 1 commit
 - t5703: replace "grep -a" usage by perl

 Update an unconditional use of "grep -a" with a perl script in a test.

 Will merge to 'next' and then to 'master'.


* ds/multi-pack-verify (2020-05-19) 1 commit
 - fsck: use ERROR_MULTI_PACK_INDEX

 Fix for a copy-and-paste error introduced during 2.20 era.

 Will merge to 'next' and then to 'master'.


* jt/avoid-prefetch-when-able-in-diff (2020-05-19) 1 commit
 - t4067: make rename detection test output raw diff

 Test-coverage enhancement.

 Will merge to 'next' and then to 'master'.


* cb/t4210-illseq-auto-detect (2020-05-18) 2 commits
 - t4210: detect REG_ILLSEQ dynamically and skip affected tests
 - t/helper: teach test-regex to report pattern errors (like REG_ILLSEQ)

 As FreeBSD is not the only platform whose regexp library needs
 REG_ILLSEQ prerequisite, add a logic to detect the prerequisite
 automatically.

 Will merge to 'next'.


* bk/p4-prepare-p4-only-fix (2020-05-12) 1 commit
 - git-p4.py: fix --prepare-p4-only error with multiple commits

 The "--prepare-p4-only" option is supposed to stop after replaying
 one changeset, but kept going (by mistake?)

 Will merge to 'next'.
 cf. <CAE5ih797YYxsR2H0TA65w9W-1jF4jQLayja_nGjQMGtc=PB6Jw@mail.gmail.com>


* jt/curl-verbose-on-trace-curl (2020-05-11) 2 commits
  (merged to 'next' on 2020-05-11 at 814e31b9d4)
 + http, imap-send: stop using CURLOPT_VERBOSE
 + t5551: test that GIT_TRACE_CURL redacts password

 Rewrite support for GIT_CURL_VERBOSE in terms of GIT_TRACE_CURL.

 Expecting further work on optionally disabling redacting authinfo


* mt/grep-sparse-checkout (2020-05-11) 4 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: load the correct config.worktree file
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

 Expecting a reroll.


* bc/sha-256-part-2 (2020-05-13) 44 commits
 - remote-testgit: adapt for object-format
 - bundle: detect hash algorithm when reading refs
 - t5300: pass --object-format to git index-pack
 - t5703: use object-format serve option
 - t5702: offer an object-format capability in the test
 - t/helper: initialize the repository for test-sha1-array
 - remote-curl: avoid truncating refs with ls-remote
 - t1050: pass algorithm to index-pack when outside repo
 - builtin/index-pack: add option to specify hash algorithm
 - remote-curl: detect algorithm for dumb HTTP by size
 - builtin/ls-remote: initialize repository based on fetch
 - t5500: make hash independent
 - serve: advertise object-format capability for protocol v2
 - connect: parse v2 refs with correct hash algorithm
 - connect: pass full packet reader when parsing v2 refs
 - Documentation/technical: document object-format for protocol v2
 - t1302: expect repo format version 1 for SHA-256
 - builtin/show-index: provide options to determine hash algo
 - t5302: modernize test formatting
 - packfile: compute and use the index CRC offset
 - t3200: mark assertion with SHA1 prerequisite
 - setup: set the_repository's hash algo when checking format
 - fetch-pack: parse and advertise the object-format capability
 - t5704: send object-format capability with SHA-256
 - t5562: pass object-format in synthesized test data
 - builtin/clone: initialize hash algorithm properly
 - remote-curl: implement object-format extensions
 - transport-helper: implement object-format extensions
 - docs: update remote helper docs for object-format extensions
 - builtin/receive-pack: detect when the server doesn't support our hash
 - connect: detect algorithm when fetching refs
 - fetch-pack: detect when the server doesn't support our hash
 - connect: make parse_feature_value extern
 - send-pack: detect when the server doesn't support our hash
 - connect: add function to detect supported v1 hash functions
 - transport: add a hash algorithm member
 - pkt-line: add a member for hash algorithm
 - connect: add function to fetch value of a v2 server capability
 - connect: add function to parse multiple v1 capability values
 - remote: advertise the object-format capability on the server side
 - wrapper: add function to compare strings with different NUL termination
 - connect: have ref processing code take struct packet_reader
 - Documentation: document v1 protocol object-format capability
 - t1050: match object ID paths in a hash-insensitive way

 SHA-256 migration work continues.


* es/bugreport-shell (2020-05-12) 2 commits
 - bugreport: include user interactive shell
 - help: add shell-path to --build-options

 "git bugreport" learns to report what shell is in use.

 Will merge to 'next'.
 We may want to learn more details than just the path, but
 that can come later.
 cf. <20200512235924.GC6605@camp.crustytoothpaste.net>


* ds/line-log-on-bloom (2020-05-11) 5 commits
  (merged to 'next' on 2020-05-11 at 046d49d455)
 + line-log: integrate with changed-path Bloom filters
 + line-log: try to use generation number-based topo-ordering
 + line-log: more responsive, incremental 'git log -L'
 + t4211-line-log: add tests for parent oids
 + line-log: remove unused fields from 'struct line_log_data'

 "git log -L..." now takes advantage of the "which paths are touched
 by this commit?" info stored in the commit-graph system.

 Will cook in 'next'.


* tb/commit-graph-no-check-oids (2020-05-18) 8 commits
 - commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
 - t5318: reorder test below 'graph_read_expect'
 - commit-graph.c: simplify 'fill_oids_from_commits'
 - builtin/commit-graph.c: dereference tags in builtin
 - builtin/commit-graph.c: extract 'read_one_commit()'
 - commit-graph.c: peel refs in 'add_ref_to_set'
 - commit-graph.c: show progress of finding reachable commits
 - commit-graph.c: extract 'refs_cb_data'

 Clean-up the commit-graph codepath.

 Will merge to 'next'.


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


* hn/refs-cleanup (2020-05-20) 6 commits
 - reftable: define version 2 of the spec to accomodate SHA256
 - reftable: clarify how empty tables should be written
 - reftable: file format documentation
 - refs: improve documentation for ref iterator
 - t: use update-ref and show-ref to reading/writing refs
 - refs.h: clarify reflog iteration order
 (this branch is used by hn/reftable.)

 Preliminary clean-ups around refs API, plus file format
 specification documentation for the reftable backend.

 Will merge to 'next'.


* hn/reftable (2020-05-20) 9 commits
 - Add reftable testing infrastructure
 - vcxproj: adjust for the reftable changes
 - Add GIT_DEBUG_REFS debugging mechanism
 - Reftable support for git-core
 - Add reftable library
 - Add .gitattributes for the reftable/ directory
 - Iterate over the "refs/" namespace in for_each_[raw]ref
 - Move REF_LOG_ONLY to refs-internal.h
 - Write pseudorefs through ref backends.
 (this branch uses hn/refs-cleanup.)

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 Needs review.

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
