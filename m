Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23148C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 23:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8259206B6
	for <git@archiver.kernel.org>; Thu, 14 May 2020 23:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HPDKfzLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgENX5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 19:57:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59831 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgENX5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 19:57:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 416DAC72DE;
        Thu, 14 May 2020 19:57:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=1
        XmauDeufubNJCYAi9UL6SmucWA=; b=HPDKfzLaL0BaffHbUTtD/JCf9uKZhMVC7
        jJk6liKrimOq0syoNhO5Y9viMJ2Kpgcn6VvK8YZj81vI6uYh/prmOC4Qegz7+1s9
        XVwlA3IomWFC4DSde31+LvBGK6FSf0WgzGrJWCh0OeCbtmvfvuD3R99MWvt+1Ztk
        gMVntgy1gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=JMC
        w3dBES4wVv0NbbzcvPyLlldPUdhCHxYisalMyHc7MTz9a2QukEiMLcSl/GMD2D/b
        jJDKGKHuDpnU1JcUsIQ/9KjmjEfMkI51v5W4PXBYGY+1pxK97nW7kEGPueCJtEMu
        huSqS1sNf97dzvO5Zmp3hc4qWDzh/4EL0A4KHuUI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38C97C72DC;
        Thu, 14 May 2020 19:57:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 771BAC72DA;
        Thu, 14 May 2020 19:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2020, #05; Thu, 14)
X-master-at: efcab5b7a3d2ce2ae4bf808b335938098b18d960
X-next-at: 67701bce43065d3b2fbf3423f8cb13c0db322fee
Date:   Thu, 14 May 2020 16:57:22 -0700
Message-ID: <xmqqpnb6nk7x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A85D0CAA-963E-11EA-BEF1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

2.27-rc0 has been tagged.  I haven't seen much discussion on
proposed topics for 2.26.3, so haven't merged anything (yet), but
now the 'master' and 'next' front would be more quiescent, efforts
focused on regressions, perhaps people can help pick the topics for
the maintenance track.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ao/p4-d-f-conflict-recover (2020-05-10) 1 commit
  (merged to 'next' on 2020-05-11 at a83a2f6178)
 + git-p4: recover from inconsistent perforce history

 "git p4" learned to recover from a (broken) state where a directory
 and a file are recorded at the same path in the Perforce repository
 the same way as their clients do.


* cw/bisect-replay-with-dos (2020-05-08) 1 commit
  (merged to 'next' on 2020-05-11 at 2eb0edf56d)
 + bisect: allow CRLF line endings in "git bisect replay" input

 "git bisect replay" had trouble with input files when they used
 CRLF line ending, which has been corrected.


* ds/bloom-cleanup (2020-05-11) 7 commits
  (merged to 'next' on 2020-05-11 at 046d49d455)
 + completion: offer '--(no-)patch' among 'git log' options
 + bloom: use num_changes not nr for limit detection
 + bloom: de-duplicate directory entries
 + Documentation: changed-path Bloom filters use byte words
 + bloom: parse commit before computing filters
 + test-bloom: fix usage typo
 + bloom: fix whitespace around tab length

 Code cleanup and typofixes.
 This is an early part of ds/line-log-on-bloom that has been cooking
 in 'next'.


* es/bugreport-with-hooks (2020-05-07) 1 commit
  (merged to 'next' on 2020-05-11 at 2dd5d90a34)
 + bugreport: collect list of populated hooks
 (this branch is used by es/bugreport-shell.)

 "git bugreport" learned to report enabled hooks in the repository.


* es/trace-log-progress (2020-05-12) 1 commit
  (merged to 'next' on 2020-05-13 at a127540258)
 + trace2: log progress time and throughput

 Teach codepaths that show progress meter to also use the
 start_progress() and the stop_progress() calls as a "region" to be
 traced.


* jc/codingstyle-compare-with-null (2020-05-08) 1 commit
  (merged to 'next' on 2020-05-11 at d18f0d930e)
 + CodingGuidelines: do not ==/!= compare with 0 or '\0' or NULL

 Doc update.


* js/rebase-autosquash-double-fixup-fix (2020-05-09) 1 commit
  (merged to 'next' on 2020-05-11 at 3cdf7f7ece)
 + rebase --autosquash: fix a potential segfault

 "rebase -i" segfaulted when rearranging a sequence that has a
 fix-up that applies another fix-up (which may or may not be a
 fix-up of yet another step).


* jt/t5500-unflake (2020-05-06) 1 commit
  (merged to 'next' on 2020-05-13 at 11450265ec)
 + t5500: count objects through stderr, not trace

 Test fix for a topic already in 'master' and meant for 'maint'.


* rs/fsck-duplicate-names-in-trees (2020-05-11) 1 commit
  (merged to 'next' on 2020-05-11 at f603ca2528)
 + fsck: report non-consecutive duplicate names in trees

 "git fsck" ensures that the paths recorded in tree objects are
 sorted and without duplicates, but it failed to notice a case where
 a blob is followed by entries that sort before a tree with the same
 name.  This has been corrected.


* sn/midx-repack-with-config (2020-05-10) 2 commits
  (merged to 'next' on 2020-05-11 at d73f8f51d6)
 + multi-pack-index: respect repack.packKeptObjects=false
 + midx: teach "git multi-pack-index repack" honor "git repack" configurations

 "git multi-pack-index repack" has been taught to honor some
 repack.* configuration variables.

--------------------------------------------------
[New Topics]

* cb/no-more-gmtime (2020-05-14) 1 commit
 - compat: remove gmtime

 Code clean-up by removing a compatibility implementation of a
 function we no longer use.

 Will merge to 'next'.


* cb/t4210-illseq-auto-detect (2020-05-14) 1 commit
 - t4210: detect REG_ILLSEQ dynamically

 As FreeBSD is not the only platform whose regexp library needs
 REG_ILLSEQ prerequisite, add a logic to detect the prerequisite
 automatically.


* en/merge-rename-rename-worktree-fix (2020-05-14) 1 commit
 - merge-recursive: fix rename/rename(1to2) for working tree with a binary

 When a binary file gets renamed and then merged with a minor
 change, the copy on the working tree while conflict resolution
 sometimes got "their" version and not "ours".

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* bk/p4-prepare-p4-only-fix (2020-05-12) 1 commit
 - git-p4.py: fix --prepare-p4-only error with multiple commits

 The "--prepare-p4-only" option is supposed to stop after replaying
 one changeset, but kept going (by mistake?)

 Needs review by some p4 folks.


* jt/curl-verbose-on-trace-curl (2020-05-11) 2 commits
  (merged to 'next' on 2020-05-11 at 814e31b9d4)
 + http, imap-send: stop using CURLOPT_VERBOSE
 + t5551: test that GIT_TRACE_CURL redacts password

 Rewrite support for GIT_CURL_VERBOSE in terms of GIT_TRACE_CURL.

 Expecting further work on optionally disabling reacting authinfo


* mt/grep-sparse-checkout (2020-05-11) 4 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: load the correct config.worktree file
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

 Expecting a reroll.


* js/ci-sdk-download-fix (2020-05-12) 1 commit
 - ci: avoid pounding on the poor ci-artifacts container

 Instead of downloading Windows SDK for CI jobs for windows builds
 from an external site (wingit.blob.core.windows.net), use the one
 created in the windows-build job, to work around quota issues at
 the external site.

 Will merge to 'next'.
 Hopefully this can go away once cmake-for-windows-build topic lands?


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


* dd/t1509-i18n-fix (2020-05-13) 1 commit
 - t1509: correct i18n test

 A few tests were not i18n clean.

 Will merge to 'next'.


* es/bugreport-shell (2020-05-12) 2 commits
 - bugreport: include user interactive shell
 - help: add shell-path to --build-options

 "git bugreport" learns to report what shell is in use.


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


* tb/commit-graph-no-check-oids (2020-05-14) 9 commits
 - fixup! builtin/commit-graph.c: extract 'read_one_commit()'
 - commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
 - t5318: reorder test below 'graph_read_expect'
 - commit-graph.c: simplify 'fill_oids_from_commits'
 - builtin/commit-graph.c: dereference tags in builtin
 - builtin/commit-graph.c: extract 'read_one_commit()'
 - commit-graph.c: peel refs in 'add_ref_to_set'
 - commit-graph.c: show progress of finding reachable commits
 - commit-graph.c: extract 'refs_cb_data'

 Clean-up the commit-graph codepath.


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

 Needs review.


* jx/proc-receive-hook (2020-05-07) 7 commits
 - doc: add documentation for the proc-receive hook
 - receive-pack: new config receive.procReceiveRefs
 - refs.c: refactor to reuse ref_is_hidden()
 - receive-pack: feed report options to post-receive
 - New capability "report-status-v2" for git-push
 - receive-pack: add new proc-receive hook
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Needs review.


* hn/refs-cleanup (2020-05-11) 6 commits
 - reftable: define version 2 of the spec to accomodate SHA256
 - reftable: clarify how empty tables should be written
 - reftable: file format documentation
 - refs: document how ref_iterator_advance_fn should handle symrefs
 - t: use update-ref and show-ref to reading/writing refs
 - refs.h: clarify reflog iteration order
 (this branch is used by hn/reftable.)

 Preliminary clean-ups around refs API, plus file format
 specification documentation for the reftable backend.

 I splitted these out of the hn/reftable topic, hoping that these
 should be easier to polish and merge quickly than the rest of the
 series.


* hn/reftable (2020-05-11) 7 commits
 - Add some reftable testing infrastructure
 - vcxproj: adjust for the reftable changes
 - Reftable support for git-core
 - Add reftable library
 - Add .gitattributes for the reftable/ directory
 - Iterate over the "refs/" namespace in for_each_[raw]ref
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
