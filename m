Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B644ACE79A9
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 00:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjITAuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 20:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjITAuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 20:50:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1E2AB
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 17:50:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA40A2ED9D;
        Tue, 19 Sep 2023 20:50:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=q
        x2uQIAMtYibfI8sMrB3ZMeXzTukqz0Px6ypRBS6K5w=; b=T/or0C46HuSbZUPmP
        UAY+a/fWFBSgZJLfpyudNSxAekQ8BgMLMp9yR9+0NrjoxpKZEfOyyHIxjn0y+0LY
        LTk7qF8jSkbpPaO+yjQAwguCAvbsSf3Zol+taC7IciyTtqz9JvVYbq8kKEHGDOyw
        BrRFzOQWGrR3o1w/fmoG7GzMhU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C15202ED9C;
        Tue, 19 Sep 2023 20:50:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7BE462ED95;
        Tue, 19 Sep 2023 20:49:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2023, #06; Tue, 19)
X-master-at: d4a83d07b8cc66d4afac2f33a8af729f2ba93bba
X-next-at: bd06505f9e3b71fbe55c339b9e635ade27246b0f
Date:   Tue, 19 Sep 2023 17:49:57 -0700
Message-ID: <xmqq8r91eki2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F826CDA-574F-11EE-85AF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

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

* js/complete-checkout-t (2023-09-08) 1 commit
  (merged to 'next' on 2023-09-08 at 461bb28fbd)
 + completion(switch/checkout): treat --track and -t the same

 The completion script (in contrib/) has been taught to treat the
 "-t" option to "git checkout" and "git switch" just like the
 "--track" option, to complete remote-tracking branches.
 source: <pull.1584.git.1694176123471.gitgitgadget@gmail.com>


* rs/grep-no-no-or (2023-09-07) 1 commit
  (merged to 'next' on 2023-09-08 at 33849032bc)
 + grep: reject --no-or

 "git grep -e A --no-or -e B" is accepted, even though the negation
 of "or" did not mean anything, which has been tightened.
 source: <6aeb0ebe-0fea-ccd3-089a-ee0b5b5baf10@web.de>

--------------------------------------------------
[New Topics]

* jc/diff-cached-fsmonitor-fix (2023-09-15) 3 commits
 - diff-lib: fix check_removed() when fsmonitor is active
 - Merge branch 'jc/fake-lstat' into jc/diff-cached-fsmonitor-fix
 - Merge branch 'js/diff-cached-fsmonitor-fix' into jc/diff-cached-fsmonitor-fix
 (this branch uses jc/fake-lstat and js/diff-cached-fsmonitor-fix.)

 The optimization based on fsmonitor in the "diff --cached"
 codepath is resurrected with the "fake-lstat" introduced earlier.

 It is unknown if the optimization is worth resurrecting, but in case...
 source: <xmqqr0n0h0tw.fsf@gitster.g>


* ml/git-gui-exec-path-fix (2023-09-18) 3 commits
  (merged to 'next' on 2023-09-19 at 0565b0b14b)
 + Merge git-gui into ml/git-gui-exec-path-fix
 + git-gui - use git-hook, honor core.hooksPath
 + git-gui - re-enable use of hook scripts

 Fix recent regression in Git-GUI that fails to run hook scripts at
 all.

 Will merge to 'master'.


* ds/stat-name-width-configuration (2023-09-18) 1 commit
 - diff --stat: add config option to limit filename width

 "git diff" learned diff.statNameWidth configuration variable, to
 give the default width for the name part in the "--stat" output.

 Will merge to 'next'.
 source: <87badb12f040d1c66cd9b89074d3de5015a45983.1694446743.git.dsimic@manjaro.org>


* tb/send-email-extract-valid-address-error-message-fix (2023-09-18) 1 commit
  (merged to 'next' on 2023-09-19 at d037282391)
 + git-send-email.perl: avoid printing undef when validating addresses

 An error message given by "git send-email" when given a malformed
 address did not give correct information, which has been corrected.

 Will merge to 'master'.
 source: <545729b619308c6f3397b9aa1747f26ddc58f461.1695054945.git.me@ttaylorr.com>


* jk/fsmonitor-unused-parameter (2023-09-18) 8 commits
  (merged to 'next' on 2023-09-19 at bd06505f9e)
 + run-command: mark unused parameters in start_bg_wait callbacks
 + fsmonitor: mark unused hashmap callback parameters
 + fsmonitor/darwin: mark unused parameters in system callback
 + fsmonitor: mark unused parameters in stub functions
 + fsmonitor/win32: mark unused parameter in fsm_os__incompatible()
 + fsmonitor: mark some maybe-unused parameters
 + fsmonitor/win32: drop unused parameters
 + fsmonitor: prefer repo_git_path() to git_pathdup()

 Unused parameters in fsmonitor related code paths have been marked
 as such.

 Will merge to 'master'.
 source: <20230918222908.GA2659096@coredump.intra.peff.net>

--------------------------------------------------
[Stalled]

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

* ob/sequencer-remove-dead-code (2023-09-12) 1 commit
  (merged to 'next' on 2023-09-13 at 1f6c2b336b)
 + sequencer: remove unreachable exit condition in pick_commits()

 Code clean-up.

 Will merge to 'master'.
 source: <20230912105541.272917-1-oswald.buddenhagen@gmx.de>


* ob/t3404-typofix (2023-09-12) 1 commit
  (merged to 'next' on 2023-09-13 at b17fa78c3f)
 + t3404-rebase-interactive.sh: fix typos in title of a rewording test

 Code clean-up.

 Will merge to 'master'.
 source: <20230912104237.271616-1-oswald.buddenhagen@gmx.de>


* jk/ort-unused-parameter-cleanups (2023-09-16) 5 commits
  (merged to 'next' on 2023-09-18 at 25a5dfc38e)
 + merge-ort: lowercase a few error messages
 + merge-ort: drop unused "opt" parameter from merge_check_renames_reusable()
 + merge-ort: drop unused parameters from detect_and_process_renames()
 + merge-ort: stop passing "opt" to read_oid_strbuf()
 + merge-ort: drop custom err() function

 Code clean-up.

 Will merge to 'master'.
 source: <20230914093409.GA2254811@coredump.intra.peff.net>


* jc/fake-lstat (2023-09-15) 1 commit
 - cache: add fake_lstat()
 (this branch is used by jc/diff-cached-fsmonitor-fix.)

 A new helper to let us pretend that we called lstat() when we know
 our cache_entry is up-to-date via fsmonitor.

 Needs review.
 source: <xmqqcyykig1l.fsf@gitster.g>


* jk/redact-h2h3-headers-fix (2023-09-15) 2 commits
  (merged to 'next' on 2023-09-19 at d40278ef9e)
 + http: update curl http/2 info matching for curl 8.3.0
 + http: factor out matching of curl http/2 trace lines

 HTTP Header redaction code has been adjusted for a newer version of
 cURL library that shows its traces differently from earlier
 versions.

 Will merge to 'master'.
 source: <20230915113237.GA3531328@coredump.intra.peff.net>


* ch/clean-docfix (2023-09-15) 1 commit
  (merged to 'next' on 2023-09-19 at 1e16b715bb)
 + git-clean doc: fix "without do cleaning" typo

 Typofix.

 Will merge to 'master'.
 source: <pull.1572.git.git.1694800409471.gitgitgadget@gmail.com>


* eg/config-type-path-docfix (2023-09-15) 1 commit
  (merged to 'next' on 2023-09-19 at 2c8ad3e731)
 + git-config: fix misworded --type=path explanation

 Typofix.

 Will merge to 'master'.
 source: <20230915202610.21206-1-evan.gates@gmail.com>


* kn/rev-list-ignore-missing-links (2023-09-15) 1 commit
 - revision: add `--ignore-missing-links` user option

 Surface the .ignore_missing_links bit that stops the revision
 traversal from stopping and dying when encountering a missing
 object to a new command line option of "git rev-list", so that the
 objects that are required but are missing can be enumerated.

 Waiting for review response.
 source: <20230915083415.263187-1-knayak@gitlab.com>


* js/systemd-timers-wsl-fix (2023-09-11) 1 commit
  (merged to 'next' on 2023-09-12 at 71c4cbb1df)
 + maintenance(systemd): support the Windows Subsystem for Linux

 Update "git maintainance" timers' implementation based on systemd
 timers to work with WSL.

 Will merge to 'master'.
 source: <pull.1586.git.1694334620260.gitgitgadget@gmail.com>


* kh/range-diff-notes (2023-09-19) 1 commit
 - range-diff: treat notes like `log`

 "git range-diff --notes=foo" compared "log --notes=foo --notes" of
 the two ranges, instead of using just the specified notes tree.

 Will merge to 'next'.
 source: <6e114271a2e7d2323193bd58bb307f60101942ce.1695154855.git.code@khaugsbakk.name>


* pw/diff-no-index-from-named-pipes (2023-09-11) 1 commit
  (merged to 'next' on 2023-09-12 at 135ecd136f)
 + diff --no-index: fix -R with stdin

 "git diff --no-index -R <(one) <(two)" did not work correctly,
 which has been corrected.

 Will merge to 'master'.
 source: <22fdfa3b-f90e-afcc-667c-705fb7670245@web.de>


* rs/parse-options-value-int (2023-09-18) 2 commits
 - parse-options: use and require int pointer for OPT_CMDMODE
 - parse-options: add int value pointer to struct option

 A bit of type safety for the "value" pointer used in the
 parse-options API.

 Comments?
 source: <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>


* so/diff-merges-d (2023-09-11) 2 commits
 - diff-merges: introduce '-d' option
 - diff-merges: improve --diff-merges documentation

 Teach a new "-d" option that shows the patch against the first
 parent for merge commits (which is "--diff-merges=first-parent -p").

 Letting a less useful combination of options squat on short-and-sweet "-d" feels dubious.
 source: <20230909125446.142715-1-sorganov@gmail.com>


* js/diff-cached-fsmonitor-fix (2023-09-11) 1 commit
  (merged to 'next' on 2023-09-12 at 7479278da0)
 + diff-lib: fix check_removed when fsmonitor is on
 (this branch is used by jc/diff-cached-fsmonitor-fix.)

 "git diff --cached" codepath did not fill the necessary stat
 information for a file when fsmonitor knows it is clean and ended
 up behaving as if it is not clean, which has been corrected.

 Will merge to 'master'.
 source: <20230911170901.49050-2-sokcevic@google.com>


* pb/completion-aliases-doc (2023-09-12) 1 commit
  (merged to 'next' on 2023-09-13 at b248a5bc26)
 + completion: improve doc for complex aliases

 Clarify how "alias.foo = : git cmd ; aliased-command-string" should
 be spelled with necessary whitespaces around punctuation marks to
 work.

 Will merge to 'master'.
 source: <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com>


* cc/repack-sift-filtered-objects-to-separate-pack (2023-09-11) 9 commits
 . gc: add `gc.repackFilterTo` config option
 . repack: implement `--filter-to` for storing filtered out objects
 . gc: add `gc.repackFilter` config option
 . repack: add `--filter=<filter-spec>` option
 . pack-bitmap-write: rebuild using new bitmap when remapping
 . repack: refactor finding pack prefix
 . repack: refactor finishing pack-objects command
 . t/helper: add 'find-pack' test-tool
 . pack-objects: allow `--filter` without `--stdout`

 "git repack" machinery learns to pay attention to the "--filter="
 option.

 May need to wait until tb/repack-existing-packs-cleanup stablizes.
 source: <20230911150618.129737-1-christian.couder@gmail.com>


* la/trailer-cleanups (2023-09-11) 6 commits
  (merged to 'next' on 2023-09-12 at 779c4a097a)
 + trailer: use offsets for trailer_start/trailer_end
 + trailer: rename *_DEFAULT enums to *_UNSPECIFIED
 + trailer: teach find_patch_start about --no-divider
 + trailer: split process_command_line_args into separate functions
 + trailer: split process_input_file into separate pieces
 + trailer: separate public from internal portion of trailer_iterator

 Code clean-up.

 Will merge to 'master'.
 source: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>


* tb/repack-existing-packs-cleanup (2023-09-13) 8 commits
  (merged to 'next' on 2023-09-14 at bb8065e89c)
 + builtin/repack.c: extract common cruft pack loop
 + builtin/repack.c: avoid directly inspecting "util"
 + builtin/repack.c: store existing cruft packs separately
 + builtin/repack.c: extract `has_existing_non_kept_packs()`
 + builtin/repack.c: extract redundant pack cleanup for existing packs
 + builtin/repack.c: extract redundant pack cleanup for --geometric
 + builtin/repack.c: extract marking packs for deletion
 + builtin/repack.c: extract structure to store existing packs

 The code to keep track of existing packs in the repository while
 repacking has been refactored.

 Will merge to 'master'.
 source: <cover.1694632644.git.me@ttaylorr.com>


* pb/complete-commit-trailers (2023-09-12) 2 commits
  (merged to 'next' on 2023-09-13 at 9a0ec17606)
 + completion: commit: complete trailers tokens more robustly
  (merged to 'next' on 2023-09-08 at 842587016d)
 + completion: commit: complete configured trailer tokens

 The command-line complation support (in contrib/) learned to
 complete "git commit --trailer=" for possible trailer keys.

 Will merge to 'master'.
 source: <pull.1583.v2.git.1694539827.gitgitgadget@gmail.com>


* pw/rebase-sigint (2023-09-07) 1 commit
 - rebase -i: ignore signals when forking subprocesses

 If the commit log editor or other external programs (spawned via
 "exec" insn in the todo list) receive internactive signal during
 "git rebase -i", it caused not just the spawned program but the
 "Git" process that spawned them, which is often not what the end
 user intended.  "git" learned to ignore SIGINT and SIGQUIT while
 waiting for these subprocesses.

 Expecting a reroll.
 cf. <12c956ea-330d-4441-937f-7885ab519e26@gmail.com>
 source: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>


* cw/git-std-lib (2023-09-11) 7 commits
 - SQUASH???
 - git-std-lib: add test file to call git-std-lib.a functions
 - git-std-lib: introduce git standard library
 - parse: create new library for parsing strings and env values
 - config: correct bad boolean env value error message
 - wrapper: remove dependency to Git-specific internal file
 - hex-ll: split out functionality from hex

 Another libification effort.

 Needs more work.
 cf. <xmqqy1hfrk6p.fsf@gitster.g>
 cf. <20230915183927.1597414-1-jonathantanmy@google.com>
 source: <20230908174134.1026823-1-calvinwan@google.com>


* cc/git-replay (2023-09-07) 15 commits
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

 Waiting for review response.
 cf. <52277471-4ddd-b2e0-62ca-c2a5b59ae418@gmx.de>
 cf. <58daa706-7efb-51dd-9061-202ef650b96a@gmx.de>
 cf. <f0e75d47-c277-9fbb-7bcd-53e4e5686f3c@gmx.de>
 May want to wait until tb/repack-existing-packs-cleanup stabilizes.
 source: <20230907092521.733746-1-christian.couder@gmail.com>


* la/trailer-test-and-doc-updates (2023-09-07) 13 commits
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

 Test coverage for trailers has been improved.
 source: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>


* js/doc-unit-tests (2023-08-17) 3 commits
 - ci: run unit tests in CI
 - unit tests: add TAP unit test framework
 - unit tests: Add a project plan document
 (this branch is used by js/doc-unit-tests-with-cmake.)

 Process to add some form of low-level unit tests has started.

 Waiting for review response.
 cf. <xmqq350hw6n7.fsf@gitster.g>
 source: <cover.1692297001.git.steadmon@google.com>


* js/doc-unit-tests-with-cmake (2023-09-18) 7 commits
 - cmake: handle also unit tests
 - cmake: use test names instead of full paths
 - cmake: fix typo in variable name
 - artifacts-tar: when including `.dll` files, don't forget the unit-tests
 - unit-tests: do show relative file paths
 - unit-tests: do not mistake `.pdb` files for being executable
 - cmake: also build unit tests
 (this branch uses js/doc-unit-tests.)

 Update the base topic to work with CMake builds.

 Waiting for the base topic to settle.
 source: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>


* tb/path-filter-fix (2023-08-30) 15 commits
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

 Needs more work.
 cf. <20230830200218.GA5147@szeder.dev>
 source: <cover.1693413637.git.jonathantanmy@google.com>


* js/config-parse (2023-08-23) 4 commits
 - config-parse: split library out of config.[c|h]
 - config.c: accept config_parse_options in git_config_from_stdin
 - config: report config parse errors using cb
 - config: split out config_parse_options

 The parsing routines for the configuration files have been split
 into a separate file.

 Needs review.
 source: <cover.1692827403.git.steadmon@google.com>


* jc/update-index-show-index-version (2023-09-12) 3 commits
  (merged to 'next' on 2023-09-13 at b754554df8)
 + test-tool: retire "index-version"
 + update-index: add --show-index-version
 + update-index doc: v4 is OK with JGit and libgit2

 "git update-index" learns "--show-index-version" to inspect
 the index format version used by the on-disk index file.

 Will merge to 'master'.
 source: <20230912193235.776292-1-gitster@pobox.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function
 (this branch uses jc/unresolve-removal.)

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230731224409.4181277-1-gitster@pobox.com>


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
