Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D0E81806
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 00:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjIZAuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 20:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIZAuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 20:50:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132F8B3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 17:50:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1AECF3928B;
        Mon, 25 Sep 2023 20:50:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=2
        R/+pIT/kyixl1H93fK/oQhhbT8l+b5R34VVp8tN990=; b=sibGeIpv+z+Rf0zgo
        B5hfBexXYSXV3OfMkr94Xo5nKu4RAtZZQUrzihJLt3Ywaz5zQc/OMFzmKiDJL9Bw
        4BS2sx64K/21CkmpqYI3ijBAWSX+DN0YOxVNRvN4eREQrR6dOw/vcmL/HI1CAiXR
        tXW0DtIZiOWaCO4bHRcFHi/jQQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 139523928A;
        Mon, 25 Sep 2023 20:50:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C578F39288;
        Mon, 25 Sep 2023 20:50:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2023, #08; Mon, 25)
X-master-at: bcb6cae2966cc407ca1afc77413b3ef11103c175
X-next-at: 7ed318fc91ccd746a38d175b7664c6b964423c8f
Date:   Mon, 25 Sep 2023 17:50:22 -0700
Message-ID: <xmqqpm25pxkh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD1192DE-5C06-11EE-8C58-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
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

With Contributors' Summit happening this week, the early part of
the week may be slower than usual (my response time will certainly
be longer).

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
[New Topics]

* jx/remote-archive-over-smart-http (2023-09-25) 3 commits
 - archive: support remote archive from stateless transport
 - transport-helper: run do_take_over in connect_helper
 - transport-helper: no connection restriction in connect_helper

 "git archive --remote=<remote>" learned to talk over the smart
 http (aka stateless) transport.

 Expecting a reroll.
 cf. <CANYiYbFkG+CvrNFBkdNewZs7ADROVsjd051SDQsU0zVq8eBhew@mail.gmail.com>
 source: <20230923152201.14741-1-worldhello.net@gmail.com>


* jx/sideband-chomp-newline-fix (2023-09-25) 3 commits
 - pkt-line: do not chomp newlines for sideband messages
 - pkt-line: memorize sideband fragment in reader
 - test-pkt-line: add option parser for unpack-sideband

 Sideband demultiplexer fixes.

 Needs review.
 source: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>


* ks/ref-filter-mailmap (2023-09-25) 3 commits
 - ref-filter: add mailmap support
 - t/t6300: introduce test_bad_atom
 - t/t6300: cleanup test_atom

 "git for-each-ref" and friends learn to apply mailmap to authorname
 and other fields.

 Will merge to 'next'.
 source: <20230925175050.3498-1-five231003@gmail.com>


* ps/revision-cmdline-stdin-not (2023-09-25) 1 commit
 - revision: make pseudo-opt flags read via stdin behave consistently

 "git rev-list --stdin" learned to take non-revisions (like "--not")
 recently from the standard input, but the way such a "--not" was
 handled was quite confusing, which has been rethought.  This is
 potentially a change that breaks backward compatibility.

 Will merge to 'next'?
 source: <6221acd2796853144f8e84081655fbc79fdc6634.1695646898.git.ps@pks.im>


* ty/merge-tree-strategy-options (2023-09-25) 1 commit
 - merge-tree: add -X strategy option

 "git merge-tree" learned to take strategy backend specific options
 via the "-X" option, like "git merge" does.

 Will merge to 'next'?
 source: <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>

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


* jc/diff-cached-fsmonitor-fix (2023-09-15) 3 commits
 - diff-lib: fix check_removed() when fsmonitor is active
 - Merge branch 'jc/fake-lstat' into jc/diff-cached-fsmonitor-fix
 - Merge branch 'js/diff-cached-fsmonitor-fix' into jc/diff-cached-fsmonitor-fix
 (this branch uses jc/fake-lstat.)

 The optimization based on fsmonitor in the "diff --cached"
 codepath is resurrected with the "fake-lstat" introduced earlier.

 It is unknown if the optimization is worth resurrecting, but in case...
 source: <xmqqr0n0h0tw.fsf@gitster.g>

--------------------------------------------------
[Cooking]

* hy/doc-show-is-like-log-not-diff-tree (2023-09-20) 1 commit
  (merged to 'next' on 2023-09-22 at 5492c03eae)
 + show doc: redirect user to git log manual instead of git diff-tree

 Doc update.

 Will merge to 'master'.
 source: <20230920132731.1259-1-hanyang.tony@bytedance.com>


* jc/alias-completion (2023-09-20) 1 commit
  (merged to 'next' on 2023-09-22 at 1d069e900b)
 + completion: loosen and document the requirement around completing alias

 The command line completion script (in contrib/) can be told to
 complete aliases by including ": git <cmd> ;" in the alias to tell
 it that the alias should be completed similar to how "git <cmd>" is
 completed.  The parsing code for the alias as been loosened to
 allow ';' without an extra space before it.

 Will merge to 'master'.
 cf. <owlyjzssjro2.fsf@fine.c.googlers.com>
 source: <xmqqy1h08zsp.fsf_-_@gitster.g>


* jk/test-pass-ubsan-options-to-http-test (2023-09-21) 1 commit
  (merged to 'next' on 2023-09-22 at bbe2f75937)
 + test-lib: set UBSAN_OPTIONS to match ASan

 UBSAN options were not propagated through the test framework to git
 run via the httpd, unlike ASAN options, which has been corrected.

 Will merge to 'master'.
 source: <20230921041825.GA2814583@coredump.intra.peff.net>


* ob/am-msgfix (2023-09-21) 1 commit
  (merged to 'next' on 2023-09-22 at 7f7589a06a)
 + am: fix error message in parse_opt_show_current_patch()

 The parameters to generate an error message have been corrected.

 Will merge to 'master'.
 source: <20230921110727.789156-1-oswald.buddenhagen@gmx.de>


* js/ci-coverity (2023-09-25) 7 commits
 - SQUASH???
 - coverity: detect and report when the token or project is incorrect
 - coverity: allow running on macOS
 - coverity: support building on Windows
 - coverity: allow overriding the Coverity project
 - coverity: cache the Coverity Build Tool
 - ci: add a GitHub workflow to submit Coverity scans

 GitHub CI workflow has learned to trigger Coverity check.

 Looking good.
 source: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>


* js/doc-status-with-submodules-mark-up-fix (2023-09-22) 1 commit
  (merged to 'next' on 2023-09-25 at 7ed318fc91)
 + Documentation/git-status: add missing line breaks

 Docfix.

 Will merge to 'master'.
 source: <pull.1590.git.1695392082207.gitgitgadget@gmail.com>


* js/config-parse (2023-09-21) 5 commits
 - config-parse: split library out of config.[c|h]
 - config.c: accept config_parse_options in git_config_from_stdin
 - config: report config parse errors using cb
 - config: split do_event() into start and flush operations
 - config: split out config_parse_options

 The parsing routines for the configuration files have been split
 into a separate file.
 source: <cover.1695330852.git.steadmon@google.com>


* ml/git-gui-exec-path-fix (2023-09-18) 3 commits
  (merged to 'next' on 2023-09-19 at 0565b0b14b)
 + Merge git-gui into ml/git-gui-exec-path-fix
 + git-gui - use git-hook, honor core.hooksPath
 + git-gui - re-enable use of hook scripts

 Fix recent regression in Git-GUI that fails to run hook scripts at
 all.

 Will merge to 'master'.


* ds/stat-name-width-configuration (2023-09-18) 1 commit
  (merged to 'next' on 2023-09-22 at dbf5bd96e8)
 + diff --stat: add config option to limit filename width

 "git diff" learned diff.statNameWidth configuration variable, to
 give the default width for the name part in the "--stat" output.

 Will merge to 'master'.
 source: <87badb12f040d1c66cd9b89074d3de5015a45983.1694446743.git.dsimic@manjaro.org>


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


* jc/fake-lstat (2023-09-15) 1 commit
 - cache: add fake_lstat()
 (this branch is used by jc/diff-cached-fsmonitor-fix.)

 A new helper to let us pretend that we called lstat() when we know
 our cache_entry is up-to-date via fsmonitor.

 Needs review.
 source: <xmqqcyykig1l.fsf@gitster.g>


* kn/rev-list-ignore-missing-links (2023-09-20) 1 commit
 - revision: add `--ignore-missing-links` user option

 Surface the .ignore_missing_links bit that stops the revision
 traversal from stopping and dying when encountering a missing
 object to a new command line option of "git rev-list", so that the
 objects that are required but are missing can be enumerated.

 Waiting for review response.
 source: <20230920104507.21664-1-karthik.188@gmail.com>


* kh/range-diff-notes (2023-09-19) 1 commit
  (merged to 'next' on 2023-09-22 at ac04978b4b)
 + range-diff: treat notes like `log`

 "git range-diff --notes=foo" compared "log --notes=foo --notes" of
 the two ranges, instead of using just the specified notes tree.

 Will merge to 'master'.
 source: <6e114271a2e7d2323193bd58bb307f60101942ce.1695154855.git.code@khaugsbakk.name>


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


* cc/repack-sift-filtered-objects-to-separate-pack (2023-09-25) 10 commits
 - SQUASH??? t0080 is already taken
 - gc: add `gc.repackFilterTo` config option
 - repack: implement `--filter-to` for storing filtered out objects
 - gc: add `gc.repackFilter` config option
 - repack: add `--filter=<filter-spec>` option
 - pack-bitmap-write: rebuild using new bitmap when remapping
 - repack: refactor finding pack prefix
 - repack: refactor finishing pack-objects command
 - t/helper: add 'find-pack' test-tool
 - pack-objects: allow `--filter` without `--stdout`

 "git repack" machinery learns to pay attention to the "--filter="
 option.

 Looking better.
 source: <20230925152517.803579-1-christian.couder@gmail.com>


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


* js/doc-unit-tests-with-cmake (2023-09-25) 7 commits
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
 source: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>


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

 Still being discussed.
 cf. <20230830200218.GA5147@szeder.dev>
 cf. <20230901205616.3572722-1-jonathantanmy@google.com>
 cf. <20230924195900.GA1156862@szeder.dev>
 source: <cover.1693413637.git.jonathantanmy@google.com>


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
  (merged to 'next' on 2023-09-25 at 0563c8d8a1)
 + checkout: allow "checkout -m path" to unmerge removed paths
 + checkout/restore: add basic tests for --merge
 + checkout/restore: refuse unmerging paths unless checking out of the index
 + update-index: remove stale fallback code for "--unresolve"
 + update-index: use unmerge_index_entry() to support removal
 + resolve-undo: allow resurrecting conflicted state that resolved to deletion
 + update-index: do not read HEAD and MERGE_HEAD unconditionally
 (this branch is used by jc/rerere-cleanup.)

 "checkout --merge -- path" and "update-index --unresolve path" did
 not resurrect conflicted state that was resolved to remove path,
 but now they do.

 Will merge to 'master'.
 source: <20230731224409.4181277-1-gitster@pobox.com>


* rj/status-bisect-while-rebase (2023-08-01) 1 commit
 - status: fix branch shown when not only bisecting

 "git status" is taught to show both the branch being bisected and
 being rebased when both are in effect at the same time.

 Needs review.
 cf. <xmqqtttia3vn.fsf@gitster.g>
 source: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>

--------------------------------------------------
[Discarded]

* tb/ci-coverity (2023-09-21) 1 commit
 . .github/workflows: add coverity action

 GitHub CI workflow has learned to trigger Coverity check.

 Superseded by the js/ci-coverity topic.
 source: <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>
