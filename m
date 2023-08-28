Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC9FC83F11
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 20:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjH1UGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjH1UFj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 16:05:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430011BF
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 13:05:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B87F930C25;
        Mon, 28 Aug 2023 16:05:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=b
        d/xM2kY1x2rexfKWqss3Ac3C1Xo8QJlcxKOjWFU8g0=; b=XNrNaxMh1uSPn1Ekf
        4gfjCC3S8HJmPKciiw/Y7EtY2uqC9E4ZAkgNyLgj4n8voIuxeoXGiW/naQz4mMvF
        d5juzpXupUsK94xio63dnUNJJo1NQdjG21ESuL5XHeT2UDMXQRmQQWkac9L04lN8
        zZDcvUnLqkIoWCZjcu438Yn50s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0A1E30C24;
        Mon, 28 Aug 2023 16:05:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31A7530C22;
        Mon, 28 Aug 2023 16:05:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2023, #07; Fri, 25)
X-master-at: 6807fcfedab84bc8cd0fbf721bc13c4e68cda9ae
X-next-at: f2c9fb9f5c8eb1d665cf784c008132152540004c
Date:   Mon, 28 Aug 2023 13:05:07 -0700
Message-ID: <xmqq5y4zgcgc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30671C60-45DE-11EE-9140-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: for some reason I forgot to send this out last week]
--------------------------------------------------

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

The cycle for 2.43 has started.  Hopefully we can drain the topics
that have been cooking in 'next' during the pre-release freeze
period down to 'master' by the end of next week.

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

* ds/maintenance-schedule-fuzz (2023-08-10) 8 commits
  (merged to 'next' on 2023-08-18 at 8d17424818)
 + maintenance: update schedule before config
 + maintenance: fix systemd schedule overlaps
 + maintenance: use random minute in systemd scheduler
 + maintenance: swap method locations
 + maintenance: use random minute in cron scheduler
 + maintenance: use random minute in Windows scheduler
 + maintenance: use random minute in launchctl scheduler
 + maintenance: add get_random_minute()

 Hourly and other schedule of "git maintenance" jobs are randomly
 distributed now.
 source: <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>


* ds/upload-pack-error-sequence-fix (2023-08-16) 2 commits
  (merged to 'next' on 2023-08-16 at d0522d547d)
 + upload-pack: fix exit code when denying fetch of unreachable object ID
  (merged to 'next' on 2023-08-13 at 6c740593cf)
 + upload-pack: fix race condition in error messages

 Error message generation fix.
 source: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
 source: <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>


* ja/worktree-orphan (2023-08-13) 1 commit
  (merged to 'next' on 2023-08-18 at b2a6f7fb71)
 + builtin/worktree.c: fix typo in "forgot fetch" msg

 Typofix in an error message.
 source: <20230811233940.30264-1-jacobabel@nullpo.dev>


* jk/function-pointer-mismatches-fix (2023-08-19) 1 commit
  (merged to 'next' on 2023-08-19 at d59a3bf2b4)
 + hashmap: use expected signatures for comparison functions

 Code clean-up to please clang-18.
 source: <20230819235530.GB600744@coredump.intra.peff.net>


* mp/rebase-label-length-limit (2023-08-10) 2 commits
  (merged to 'next' on 2023-08-13 at 85536da9f7)
 + rebase: allow overriding the maximal length of the generated labels
 + sequencer: truncate labels to accommodate loose refs

 Overly long label names used in the sequencer machinery are now
 chopped to fit under filesystem limitation.
 source: <pull.1562.git.git.1691685300.gitgitgadget@gmail.com>


* ob/sequencer-rearrange-cleanup (2023-08-09) 1 commit
  (merged to 'next' on 2023-08-09 at df4360945c)
 + sequencer: simplify allocation of result array in todo_list_rearrange_squash()

 Code clean-up.
 source: <20230809171532.2564880-1-oswald.buddenhagen@gmx.de>


* ob/t9001-indent-fix (2023-08-13) 1 commit
  (merged to 'next' on 2023-08-18 at 00c1cf4fe7)
 + t9001: fix indentation in test_no_confirm()

 Test style fix.
 source: <20230813104649.2919412-1-oswald.buddenhagen@gmx.de>


* ob/test-lib-rebase-fake-editor-updates (2023-08-10) 3 commits
  (merged to 'next' on 2023-08-13 at 16b87e890a)
 + t/lib-rebase: improve documentation of set_fake_editor()
 + t/lib-rebase: set_fake_editor(): handle FAKE_LINES more consistently
 + t/lib-rebase: set_fake_editor(): fix recognition of reset's short command

 Test updates.
 source: <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
 source: <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>


* rj/branch-in-use-error-message (2023-08-08) 2 commits
  (merged to 'next' on 2023-08-09 at 5510985b1c)
 + branch: error message checking out a branch in use
 + branch: error message deleting a branch in use

 A message written in olden time prevented a branch from getting
 checked out saying it is already checked out elsewhere, but these
 days, we treat a branch that is being bisected or rebased just like
 a branch that is checked out and protect it.  Rephrase the message
 to say that the branch is in use.
 source: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>


* rs/parse-options-negation-help (2023-08-06) 8 commits
  (merged to 'next' on 2023-08-18 at 9d37b5fbfe)
 + parse-options: simplify usage_padding()
 + parse-options: no --[no-]no-...
 + parse-options: factor out usage_indent() and usage_padding()
 + parse-options: show negatability of options in short help
 + t1502: test option negation
 + t1502: move optionspec help output to a file
 + t1502, docs: disallow --no-help
 + subtree: disallow --no-{help,quiet,debug,branch,message}

 "git cmd -h" learned to signal which options can be negated by
 listing such options like "--[no-]opt".
 cf. <xmqqbkfm3gne.fsf@gitster.g>
 source: <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>


* tb/repack-geometry-cleanup (2023-08-09) 1 commit
  (merged to 'next' on 2023-08-13 at d79c778057)
 + repack: move `pack_geometry` struct to the stack

 Code clean-up.
 source: <2e2a760381be1f7cdae83e2f43b17d16aa8ab161.1691613149.git.me@ttaylorr.com>


* ws/git-push-doc-grammofix (2023-08-09) 1 commit
  (merged to 'next' on 2023-08-13 at f15e9bbe75)
 + git-push.txt: fix grammar

 Doc update.
 source: <20230810012105.1423462-1-wesleys@opperschaap.net>

--------------------------------------------------
[New Topics]

* jk/diff-result-code-cleanup (2023-08-21) 7 commits
  (merged to 'next' on 2023-08-25 at 3b1280d42f)
 + diff: drop useless "status" parameter from diff_result_code()
 + diff: drop useless return values in git-diff helpers
 + diff: drop useless return from run_diff_{files,index} functions
 + diff: die when failing to read index in git-diff builtin
 + diff: show usage for unknown builtin_diff_files() options
 + diff-files: avoid negative exit value
 + diff: spell DIFF_INDEX_CACHED out when calling run_diff_index()

 "git diff --no-such-option" and other corner cases around the exit
 status of the "diff" command has been corrected.

 Will merge to 'master'.
 source: <20230821201358.GA2663749@coredump.intra.peff.net>


* tb/path-filter-fix (2023-08-21) 15 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: drop unnecessary `graph_read_bloom_data_context`
 - commit-graph.c: unconditionally load Bloom filters
 - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - commit-graph: new filter ver. that fixes murmur3
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - t/helper/test-read-graph: implement `bloom-filters` mode
 - bloom.h: make `load_bloom_filter_from_graph()` public
 - t/helper/test-read-graph.c: extract `dump_graph_info()`
 - gitformat-commit-graph: describe version 2 of BDAT

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Comments?
 source: <cover.1692654233.git.me@ttaylorr.com>


* ch/t6300-verify-commit-test-cleanup (2023-08-23) 2 commits
  (merged to 'next' on 2023-08-24 at 15b842867e)
 + t/t6300: drop magic filtering
 + t/lib-gpg: forcibly run a trustdb update

 Test clean-up.

 Will merge to 'master'.
 source: <20230822150149.541ccb35@leda.eworm.net>


* ts/unpacklimit-config-fix (2023-08-22) 1 commit
  (merged to 'next' on 2023-08-23 at 4fabd9a697)
 + transfer.unpackLimit: fetch/receive.unpackLimit takes precedence

 transfer.unpackLimit ought to be used as a fallback, but overrode
 fetch.unpackLimit and receive.unpackLimit instead.

 Will merge to 'master'.
 source: <xmqqpm3eh7f6.fsf@gitster.g>


* js/config-parse (2023-08-23) 4 commits
 - config-parse: split library out of config.[c|h]
 - config.c: accept config_parse_options in git_config_from_stdin
 - config: report config parse errors using cb
 - config: split out config_parse_options

 Split out parsing routines for the configuration files into a
 separate file.

 Needs review.
 source: <cover.1692827403.git.steadmon@google.com>


* jc/ci-skip-same-commit (2023-08-25) 1 commit
 - ci: avoid building from the same commit in parallel

 Tweak GitHub Actions CI so that pushing the same commit to multiple
 branch tips at the same time will not waste building and testing
 the same thing twice.

 Will merge to 'next'.
 source: <1da763f3-60bf-a572-2c71-336b1fa5553d@gmx.de>


* py/git-gui-updates (2023-08-24) 16 commits
 - Merge https://github.com/prati0100/git-gui
 - Merge branch 'ml/cygwin-fixes'
 - git-gui - use mkshortcut on Cygwin
 - git-gui - use cygstart to browse on Cygwin
 - git-gui - remove obsolete Cygwin specific code
 - git gui Makefile - remove Cygwin modifications
 - Merge branch 'ab/makeflags'
 - Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4
 - Merge branch 'js/windows-rce'
 - Work around Tcl's default `PATH` lookup
 - Move the `_which` function (almost) to the top
 - Move is_<platform> functions to the beginning
 - is_Cygwin: avoid `exec`ing anything
 - windows: ignore empty `PATH` elements
 - Merge branch 'vk/readme-typo'
 - git-gui: Fix a typo in README


* tb/mark-more-tests-as-leak-free (2023-08-24) 3 commits
 - leak tests: mark t5583-push-branches.sh as leak-free
 - leak tests: mark t3321-notes-stripspace.sh as leak-free
 - leak tests: mark a handful of tests as leak-free

 source: <cover.1692902414.git.me@ttaylorr.com>

--------------------------------------------------
[Stalled]

* cc/repack-sift-filtered-objects-to-separate-pack (2023-08-13) 8 commits
 . gc: add `gc.repackFilterTo` config option
 . repack: implement `--filter-to` for storing filtered out objects
 . gc: add `gc.repackFilter` config option
 . repack: add `--filter=<filter-spec>` option
 . repack: refactor finding pack prefix
 . repack: refactor finishing pack-objects command
 . t/helper: add 'find-pack' test-tool
 . pack-objects: allow `--filter` without `--stdout`

 "git repack" machinery learns to pay attention to the "--filter="
 option.

 Kicked out of the 'seen', as it still seems to be failing tests.
 cf. https://github.com/git/git/actions/runs/5850998716/job/15861158252#step:4:1822
 source: <20230812000011.1227371-1-christian.couder@gmail.com>


* ob/send-email-interactive-failure (2023-08-21) 1 commit
 - send-email: prompt-dependent exit codes

 "git send-email" exits with non-zero status when end-user
 interaction causes any prepared message not to be sent.

 Expecting a reroll.
 Without an opt-in fix, this will be a backward-incompatible
 change that needs mention in the release notes.
 source: <20230821170720.577835-1-oswald.buddenhagen@gmx.de>


* cc/git-replay (2023-06-03) 15 commits
 - replay: stop assuming replayed branches do not diverge
 - replay: add --contained to rebase contained branches
 - replay: add --advance or 'cherry-pick' mode
 - replay: disallow revision specific options and pathspecs
 - replay: use standard revision ranges
 - replay: make it a minimal server side command
 - replay: remove HEAD related sanity check
 - replay: remove progress and info output
 - replay: add an important FIXME comment about gpg signing
 - replay: don't simplify history
 - replay: introduce pick_regular_commit()
 - replay: die() instead of failing assert()
 - replay: start using parse_options API
 - replay: introduce new builtin
 - t6429: remove switching aspects of fast-rebase

 No reviews?
 source: <20230602102533.876905-1-christian.couder@gmail.com>


* tk/cherry-pick-sequence-requires-clean-worktree (2023-06-01) 1 commit
 - cherry-pick: refuse cherry-pick sequence if index is dirty

 "git cherry-pick A" that replays a single commit stopped before
 clobbering local modification, but "git cherry-pick A..B" did not,
 which has been corrected.

 Expecting a reroll.
 cf. <999f12b2-38d6-f446-e763-4985116ad37d@gmail.com>
 source: <pull.1535.v2.git.1685264889088.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* ob/sequencer-empty-hint-fix (2023-08-24) 1 commit
  (merged to 'next' on 2023-08-24 at 626c52ad72)
 + sequencer: rectify empty hint in call of require_clean_work_tree()

 Update the use of API for consistency between two calls to
 require_clean_work_tree() from the sequencer code.

 Will merge to 'master'.
 source: <20230824150046.802008-1-oswald.buddenhagen@gmx.de>


* jc/diff-exit-code-with-w-fixes (2023-08-21) 5 commits
  (merged to 'next' on 2023-08-23 at 436a0aec3d)
 + diff: the -w option breaks --exit-code for --raw and other output modes
 + t4040: remove test that succeeded for a wrong reason
 + diff: teach "--stat -w --exit-code" to notice differences
 + diff: mode-only change should be noticed by "--patch -w --exit-code"
 + diff: move the fallback "--exit-code" code down

 "git diff -w --exit-code" with various options did not work
 correctly, which is being addressed.

 Will merge to 'master'.
 source: <20230818235932.3253552-1-gitster@pobox.com>


* jc/update-index-show-index-version (2023-08-18) 3 commits
 - test-tool: retire "index-version"
 - update-index: add --show-index-version
 - update-index doc: v4 is OK with JGit and libgit2

 "git update-index" learns "--show-index-version" to inspect
 the index format version used by the on-disk index file.

 Needs review.
 source: <20230818233729.2766281-1-gitster@pobox.com>


* ob/revert-of-revert-is-reapply (2023-08-21) 2 commits
 - git-revert.txt: add discussion
 - sequencer: beautify subject of reverts of reverts

 Tweak the default log message created by "git revert" when
 reverting a commit that records a revert.

 Expecting a (hopefully small and final) reroll.
 cf. <ZOZnNDd2pMX6M2Au@nand.local>
 source: <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>


* ob/format-patch-description-file (2023-08-21) 1 commit
  (merged to 'next' on 2023-08-25 at 89ea619311)
 + format-patch: add --description-file option

 "git format-patch" learns a way to feed cover letter description,
 that (1) can be used on detached HEAD where there is no branch
 description available, and (2) also can override the branch
 description if there is one.

 Will merge to 'master'.
 source: <20230821170720.577820-1-oswald.buddenhagen@gmx.de>


* ds/scalar-updates (2023-08-22) 3 commits
 - scalar reconfigure: help users remove buggy repos
 - setup: add discover_git_directory_reason()
 - scalar: add --[no-]src option

 Scalar updates.
 source: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>


* jc/mv-d-to-d-error-message-fix (2023-08-11) 1 commit
  (merged to 'next' on 2023-08-21 at 2220d22d6f)
 + mv: fix error for moving directory to another

 Typofix in an error message.

 Will merge to 'master'.
 source: <xmqqjzu1njt0.fsf@gitster.g>


* sl/sparse-check-attr (2023-08-11) 3 commits
  (merged to 'next' on 2023-08-21 at c202b15517)
 + check-attr: integrate with sparse-index
 + attr.c: read attributes in a sparse directory
 + t1092: add tests for 'git check-attr'

 Teach "git check-attr" work better with sparse-index.

 Will merge to 'master'.
 cf. <3b2a5b4b-ab8f-746b-6b69-8e8262b6390b@github.com>
 source: <20230811142211.4547-1-cheskaqiqi@gmail.com>


* ws/svn-with-new-readline (2023-08-11) 1 commit
 - git-svn: avoid creating more than one than one Term::ReadLine object

 Adjust to newer Term::ReadLine to prevent it from breaking
 the interactive prompt code in git-svn.

 Not needed for correctness.
 source: <20230810011831.1423208-1-wesleys@opperschaap.net>


* ak/pretty-decorate-more (2023-08-21) 8 commits
 - decorate: use commit color for HEAD arrow
 - pretty: add pointer and tag options to %(decorate)
 - pretty: add %(decorate[:<options>]) format
 - decorate: color each token separately
 - decorate: avoid some unnecessary color overhead
 - decorate: refactor format_decorations()
 - pretty-formats: enclose options in angle brackets
 - pretty-formats: define "literal formatting code"

 Teach "git log --format" a customizable %(decorate) placeholder.

 What's the status of this thing?
 source: <20230820185009.20095-1-andy.koppe@gmail.com>


* tb/commit-graph-verify-fix (2023-08-21) 4 commits
  (merged to 'next' on 2023-08-23 at 2b4b74bb0d)
 + commit-graph: avoid repeated mixed generation number warnings
 + t/t5318-commit-graph.sh: test generation zero transitions during fsck
 + commit-graph: verify swapped zero/non-zero generation cases
 + commit-graph: introduce `commit_graph_generation_from_graph()`

 Update commit-graph verification code that detects mixture of zero
 and non-zero generation numbers.

 Will merge to 'master'.
 source: <cover.1692653671.git.me@ttaylorr.com>


* la/trailer-cleanups (2023-08-06) 5 commits
 - trailer: rename *_DEFAULT enums to *_UNSPECIFIED
 - trailer: teach find_patch_start about --no-divider
 - trailer: split process_command_line_args into separate functions
 - trailer: split process_input_file into separate pieces
 - trailer: separate public from internal portion of trailer_iterator

 Code clean-up.

 Expecting a reroll.
 cf. <owlyy1iifq0n.fsf@fine.c.googlers.com>
 source: <pull.1563.git.1691211879.gitgitgadget@gmail.com>


* la/trailer-test-and-doc-updates (2023-08-10) 14 commits
 - SQUASH???
 - trailer doc: <token> is a <key> or <keyAlias>, not both
 - trailer doc: separator within key suppresses default separator
 - trailer doc: emphasize the effect of configuration variables
 - trailer --unfold help: prefer "reformat" over "join"
 - trailer --parse docs: add explanation for its usefulness
 - trailer --only-input: prefer "configuration variables" over "rules"
 - trailer --parse help: expose aliased options
 - trailer --no-divider help: describe usual "---" meaning
 - trailer: trailer location is a place, not an action
 - trailer doc: narrow down scope of --where and related flags
 - trailer: add tests to check defaulting behavior with --no-* flags
 - trailer test description: this tests --where=after, not --where=before
 - trailer tests: make test cases self-contained

 Test coverage improvement for trailers.

 Expecting a reroll.
 cf. <owlyh6p5fpi7.fsf@fine.c.googlers.com>
 source: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>


* mh/credential-libsecret-attrs (2023-06-16) 1 commit
  (merged to 'next' on 2023-08-08 at dc73a2c55a)
 + credential/libsecret: store new attributes

 The way authentication related data other than passwords (e.g.
 oath token and password expiration data) are stored in libsecret
 keyrings has been rethought.

 Will merge to 'master'.
 source: <pull.1469.v5.git.git.1686945306242.gitgitgadget@gmail.com>


* jc/rerere-cleanup (2023-08-03) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function
 (this branch uses jc/unresolve-removal.)

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230731224409.4181277-1-gitster@pobox.com>


* pw/rebase-i-after-failure (2023-08-01) 7 commits
 - rebase -i: fix adding failed command to the todo list
 - rebase --continue: refuse to commit after failed command
 - rebase: fix rewritten list for failed pick
 - sequencer: factor out part of pick_commits()
 - sequencer: use rebase_path_message()
 - rebase -i: remove patch file after conflict resolution
 - rebase -i: move unlink() calls

 Various fixes to the behaviour of "rebase -i" when the command got
 interrupted by conflicting changes.

 Expecting a reroll.
 The latter half of the series should be reviewed by those who have
 more stake in the sequencer code than myself.
 cf. <619e458b-218b-a790-dfb4-9200e201b513@gmail.com>
 source: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>


* jc/unresolve-removal (2023-07-31) 7 commits
 - checkout: allow "checkout -m path" to unmerge removed paths
 - checkout/restore: add basic tests for --merge
 - checkout/restore: refuse unmerging paths unless checking out of the index
 - update-index: remove stale fallback code for "--unresolve"
 - update-index: use unmerge_index_entry() to support removal
 - resolve-undo: allow resurrecting conflicted state that resolved to deletion
 - update-index: do not read HEAD and MERGE_HEAD unconditionally
 (this branch is used by jc/rerere-cleanup.)

 "checkout --merge -- path" and "update-index --unresolve path" did
 not resurrect conflicted state that was resolved to remove path,
 but now they do.

 Needs review.
 source: <20230731224409.4181277-1-gitster@pobox.com>


* rj/status-bisect-while-rebase (2023-08-01) 1 commit
 - status: fix branch shown when not only bisecting

 "git status" is taught to show both the branch being bisected and
 being rebased when both are in effect at the same time.

 Needs review.
 cf. <xmqqtttia3vn.fsf@gitster.g>
 source: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>


* mh/credential-erase-improvements-more (2023-07-26) 2 commits
  (merged to 'next' on 2023-08-08 at fd1ba4accf)
 + credential/wincred: erase matching creds only
 + credential/libsecret: erase matching creds only

 Update two credential helpers to correctly match which credential
 to erase; they dropped not the ones with stale password.

 Will merge to 'master'.
 source: <pull.1527.v2.git.git.1690387585634.gitgitgadget@gmail.com>
 source: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>


* js/doc-unit-tests (2023-08-17) 3 commits
 - ci: run unit tests in CI
 - unit tests: add TAP unit test framework
 - unit tests: Add a project plan document

 Process to add some form of low-level unit tests has started.

 Comments?
 source: <cover.1692297001.git.steadmon@google.com>

--------------------------------------------------
[Discarded]

* jt/path-filter-fix (2023-08-08) 8 commits
  (merged to 'next' on 2023-08-09 at 59952b9ec9)
 + commit-graph: fix small leak with invalid changedPathsVersion
  (merged to 'next' on 2023-08-03 at d99958c287)
 + commit-graph: new filter ver. that fixes murmur3
 + repo-settings: introduce commitgraph.changedPathsVersion
 + t4216: test changed path filters with high bit paths
 + t/helper/test-read-graph: implement `bloom-filters` mode
 + bloom.h: make `load_bloom_filter_from_graph()` public
 + t/helper/test-read-graph.c: extract `dump_graph_info()`
 + gitformat-commit-graph: describe version 2 of BDAT

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Reverted out of 'next', superseded by the tb/path-filter-fix topic.
 cf. <ZMqp6K2iXixWH/zT@nand.local>
 source: <cover.1690912539.git.jonathantanmy@google.com>
 source: <20230808192240.GA4091261@coredump.intra.peff.net>


* ab/tag-object-type-errors (2023-05-10) 4 commits
 . tag: don't emit potentially incorrect "object is a X, not a Y"
 . tag: don't misreport type of tagged objects in errors
 . object tests: add test for unexpected objects in tags
 . Merge branch 'jk/parse-object-type-mismatch' into ab/tag-object-type-errors

 Hardening checks around mismatched object types when one of those
 objects is a tag.

 Stalled for too long.
 source: <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>
