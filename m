Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC892C001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 02:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHICmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 22:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHICmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 22:42:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0AA198A
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 19:42:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5A812F2B1;
        Tue,  8 Aug 2023 22:42:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=C
        AWbN5tFgi8P9h2vSY+20pfeQHSZ93f+r78ezaKQzSg=; b=nvk1NtHihYMt39wUG
        53cXP0LS2repiU8+H8k3uCxpECFM3A47txGko3bsG8PB3kkVwHkT0HTkVD009f1b
        otWERPMf1/tsVIHgaGxZrvAbuviFCECe6rokzyj7ax39QnGUKAtjzMnzRdL+uYz0
        pHpXXxcGFg2VfJb2OunUboDN4Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE7052F2B0;
        Tue,  8 Aug 2023 22:42:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 524C22F2AD;
        Tue,  8 Aug 2023 22:42:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2023, #03; Tue, 8)
X-master-at: a82fb66fed250e16d3010c75404503bea3f0ab61
X-next-at: fd1ba4accffeede84a3a0c749bb6e1e407769a41
Date:   Tue, 08 Aug 2023 19:42:04 -0700
Message-ID: <xmqqttt9543n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53A9AAEC-365E-11EE-8E60-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
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

There are some last-minute fixes that update or add messages that
are marked for i18n, and they may have to be fast-tracked to -rc1,
which we may want to delay by one day for that reason.

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

* am/doc-sha256 (2023-07-31) 1 commit
  (merged to 'next' on 2023-08-01 at d7419bf527)
 + doc: sha256 is no longer experimental

 Tone down the warning on SHA-256 repositories being an experimental
 curiosity.  We do not have support for them to interoperate with
 traditional SHA-1 repositories, but at this point, we do not plan
 to make breaking changes to SHA-256 repositories and there is no
 longer need for such a strongly phrased warning.
 source: <ZMe6KmzZGVubYpvO@adams>


* ew/sha256-gcrypt-leak-fixes (2023-07-31) 3 commits
  (merged to 'next' on 2023-08-01 at eed83801c3)
 + sha256/gcrypt: die on gcry_md_open failures
 + sha256/gcrypt: fix memory leak with SHA-256 repos
 + sha256/gcrypt: fix build with SANITIZE=leak

 Leakfixes.
 source: <20230731120808.1230210-1-e@80x24.org>


* rs/bundle-parseopt-cleanup (2023-07-31) 1 commit
  (merged to 'next' on 2023-08-01 at 405eb138fa)
 + bundle: use OPT_PASSTHRU_ARGV

 Code clean-up.
 source: <2dcb915f-b926-e024-6394-23aff200955c@web.de>


* tb/commit-graph-tests (2023-07-24) 5 commits
  (merged to 'next' on 2023-07-31 at 740a260315)
 + t/lib-commit-graph.sh: avoid sub-shell in `graph_git_behavior()`
 + t5328: avoid top-level directory changes
 + t5318: avoid top-level directory changes
 + t/lib-commit-graph.sh: avoid directory change in `graph_git_behavior()`
 + t/lib-commit-graph.sh: allow `graph_read_expect()` in sub-directories

 Test updates.
 source: <cover.1690216758.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

* la/trailer-cleanups (2023-08-06) 5 commits
 - trailer: rename *_DEFAULT enums to *_UNSPECIFIED
 - trailer: teach find_patch_start about --no-divider
 - trailer: split process_command_line_args into separate functions
 - trailer: split process_input_file into separate pieces
 - trailer: separate public from internal portion of trailer_iterator

 Code clean-up.

 Needs review.
 source: <pull.1563.git.1691211879.gitgitgadget@gmail.com>


* la/trailer-test-and-doc-updates (2023-08-06) 5 commits
 - trailer --no-divider help: describe usual "---" meaning
 - trailer: trailer location is a place, not an action
 - trailer: add tests to check defaulting behavior with --no-* flags
 - trailer test description: this tests --where=after, not --where=before
 - trailer tests: make test cases self-contained

 Test coverage improvement for trailers.

 Needs review.
 source: <pull.1564.git.1691210737.gitgitgadget@gmail.com>


* jk/repack-leakfix (2023-08-08) 1 commit
 - repack: free geometry struct

 Leakfix.

 Will merge to 'next'.
 source: <20230808185023.GA3498623@coredump.intra.peff.net>


* jk/send-email-with-new-readline (2023-08-08) 2 commits
 - send-email: avoid creating more than one Term::ReadLine object
 - send-email: drop FakeTerm hack

 Adjust to newer Term::ReadLine to prevent it from breaking
 the interactive prompt code in send-email.

 Will merge to 'next'.
 source: <20230808180935.GA2096901@coredump.intra.peff.net>


* js/allow-t4000-to-be-indented-with-spaces (2023-08-08) 1 commit
 - t0040: declare non-tab indentation to be okay in this script

 File attribute update.

 Will merge to 'next'.
 source: <pull.1568.git.1691491054706.gitgitgadget@gmail.com>


* ob/rebase-conflict-advice-i18n-fix (2023-08-07) 1 commit
 - advice: handle "rebase" in error_resolve_conflict()

 i18n coverage improvement and avoidance of sentence lego.

 Will merge to 'next'.
 source: <20230807170935.2336715-1-oswald.buddenhagen@gmx.de>


* rs/parse-opt-forbid-set-int-0-without-noneg (2023-08-08) 1 commit
 - parse-options: disallow negating OPTION_SET_INT 0

 Developer support to detect meaningless combination of options.

 Will merge to 'next'.
 source: <c4cd1591-3a83-920a-6a80-19ffbfe3089d@web.de>


* ds/maintenance-schedule-fuzz (2023-08-07) 6 commits
 - maintenance: use random minute in systemd scheduler
 - maintenance: swap method locations
 - maintenance: use random minute in cron scheduler
 - maintenance: use random minute in Windows scheduler
 - maintenance: use random minute in launchctl scheduler
 - maintenance: add get_random_minute()

 Allow "git maintenance" schedule to be randomly distributed.

 Still under discussion.
 Expecting a reroll.
 source: <pull.1567.git.1691434300.gitgitgadget@gmail.com>


* ob/send-email-interactive-failure (2023-08-07) 1 commit
 - send-email: prompt-dependent exit codes

 "git send-email" exits with non-zero status when end-user
 interaction causes any prepared message not to be sent.

 Expecting a reroll.
 Without an opt-in fix, this will be a backward-incompatible
 change that needs mention in the release notes.
 source: <20230807165850.2335067-1-oswald.buddenhagen@gmx.de>


* ob/sequencer-empty-hint-fix (2023-08-07) 1 commit
 - sequencer: rectify empty hint in call of require_clean_work_tree()

 Under some unspecified condition, a code that calls into the
 sequencer can produce an extra "error:" output that has no
 meaningful message on it.

 Expecting a reroll.
 cf. <xmqqcyzx6ma1.fsf@gitster.g>
 source: <20230807170935.2336730-1-oswald.buddenhagen@gmx.de>


* ob/test-lib-rebase-fake-editor-updates (2023-08-07) 3 commits
 - t/lib-rebase: improve documentation of set_fake_editor()
 - t/lib-rebase: set_fake_editor(): handle FAKE_LINES more consistently
 - t/lib-rebase: set_fake_editor(): fix recognition of reset's short command

 Test updates.

 Will merge to 'next'.
 source: <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>


* rj/branch-in-use-error-message (2023-08-08) 2 commits
 - branch: error message checking out a branch in use
 - branch: error message deleting a branch in use

 A message written in olden time prevented a branch from getting
 checked out saying it is already checked out elsewhere, but these
 days, we treat a branch that is being bisected or rebased just like
 a branch that is checked out and protect it.  Rephrase the message
 to say that the branch is in use.

 Will merge to 'next'.
 source: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>

--------------------------------------------------
[Stalled]

* sl/sparse-check-attr (2023-07-18) 3 commits
 - check-attr: integrate with sparse-index
 - attr.c: read attributes in a sparse directory
 - t1092: add tests for 'git check-attr'

 Teach "git check-attr" work better with sparse-index.

 Expecting a reroll.
 cf. <c3ebe3b4-88b9-8ca2-2ee3-39a3e0d82201@github.com>
 cf. <5e478d8b-9ef4-864b-41e4-e0a79877d278@github.com>
 source: <20230718232916.31660-1-cheskaqiqi@gmail.com>


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


* ab/tag-object-type-errors (2023-05-10) 4 commits
 - tag: don't emit potentially incorrect "object is a X, not a Y"
 - tag: don't misreport type of tagged objects in errors
 - object tests: add test for unexpected objects in tags
 - Merge branch 'jk/parse-object-type-mismatch' into ab/tag-object-type-errors

 Hardening checks around mismatched object types when one of those
 objects is a tag.

 Will discard.
 Stalled for too long.
 source: <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>

--------------------------------------------------
[Cooking]

* mh/credential-libsecret-attrs (2023-06-16) 1 commit
  (merged to 'next' on 2023-08-08 at dc73a2c55a)
 + credential/libsecret: store new attributes

 The way authentication related data other than passwords (e.g.
 oath token and password expiration data) are stored in libsecret
 keyrings has been rethought.

 Will cook in 'next'.
 Needs review.
 source: <pull.1469.v5.git.git.1686945306242.gitgitgadget@gmail.com>


* jc/rerere-cleanup (2023-08-03) 5 commits
 - rerere: plug small strbuf leak
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function
 (this branch uses jc/unresolve-removal.)

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230731224409.4181277-1-gitster@pobox.com>


* ma/locate-in-path-for-windows (2023-08-04) 3 commits
  (merged to 'next' on 2023-08-06 at 02bc13f4a3)
 + docs: update when `git bisect visualize` uses `gitk`
 + compat/mingw: implement a native locate_in_PATH()
 + run-command: conditionally define locate_in_PATH()

 "git bisect visualize" stopped running "gitk" on Git for Windows
 when the command was reimplemented in C around Git 2.34 timeframe.
 This has been corrected.

 Will merge to 'master'.
 source: <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>


* pw/rebase-skip-commit-message-fix (2023-08-03) 1 commit
  (merged to 'next' on 2023-08-06 at 1e44443e65)
 + rebase --skip: fix commit message clean up when skipping squash

 "git rebase -i" with a series of squash/fixup, when one of the
 steps stopped in conflicts and ended up getting skipped, did not
 handle the accumulated commit log messages, which has been
 corrected.

 Will merge to 'master'.
 source: <pull.1558.git.git.1691068176051.gitgitgadget@gmail.com>


* bc/ignore-clangd-cache (2023-08-04) 1 commit
  (merged to 'next' on 2023-08-04 at 5cf8d41911)
 + gitignore: ignore clangd .cache directory

 .gitignore update.

 Will merge to 'master'.
 source: <20230804171328.1737188-1-sandals@crustytoothpaste.net>


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


* bc/ident-dot-is-no-longer-crud-letter (2023-08-02) 1 commit
  (merged to 'next' on 2023-08-03 at e786442a9b)
 + ident: don't consider '.' a crud

 Exclude "." from the set of characters to be removed from the
 beginning and the end of the human-readable name.

 Will merge to 'master'.
 source: <xmqqsf918k4j.fsf@gitster.g>


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


* ew/hash-with-openssl-evp (2023-08-01) 2 commits
  (merged to 'next' on 2023-08-02 at 996db74865)
 + avoid SHA-1 functions deprecated in OpenSSL 3+
 + sha256: avoid functions deprecated in OpenSSL 3+

 Adjust to OpenSSL 3+, which deprecates its SHA-1 functions based on
 its traditional API, by using its EVP API instead.

 Will merge to 'master'.
 source: <20230801025454.1137802-1-e@80x24.org>


* rj/status-bisect-while-rebase (2023-08-01) 1 commit
 - status: fix branch shown when not only bisecting

 "git status" is taught to show both the branch being bisected and
 being rebased when both are in effect at the same time.

 Needs review.
 source: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>


* rs/parse-options-negation-help (2023-08-06) 8 commits
 - parse-options: simplify usage_padding()
 - parse-options: no --[no-]no-...
 - parse-options: factor out usage_indent() and usage_padding()
 - parse-options: show negatability of options in short help
 - t1502: test option negation
 - t1502: move optionspec help output to a file
 - t1502, docs: disallow --no-help
 - subtree: disallow --no-{help,quiet,debug,branch,message}

 "git cmd -h" learned to signal which options can be negated by
 listing such options like "--[no-]opt".

 Comments?
 source: <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>


* mh/credential-erase-improvements-more (2023-07-26) 2 commits
  (merged to 'next' on 2023-08-08 at fd1ba4accf)
 + credential/wincred: erase matching creds only
 + credential/libsecret: erase matching creds only

 Update two credential helpers to correctly match which credential
 to erase; they dropped not the ones with stale password.

 Will cook in 'next'.
 Needs review.
 source: <pull.1527.v2.git.git.1690387585634.gitgitgadget@gmail.com>
 source: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>


* cc/repack-sift-filtered-objects-to-separate-pack (2023-08-08) 8 commits
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

 Comments?
 source: <20230808082608.582319-1-christian.couder@gmail.com>


* js/doc-unit-tests (2023-08-07) 1 commit
 - unit tests: add a project plan document

 Process to add some form of low-level unit tests has started.

 Comments?
 source: <c7dca1a805a16fd4fd68e86efeec97510e3ac4b8.1691449216.git.steadmon@google.com>


* jt/path-filter-fix (2023-08-08) 8 commits
 - commit-graph: fix small leak with invalid changedPathsVersion
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

 Will cook in 'next'.
 cf. <ZMqp6K2iXixWH/zT@nand.local>
 source: <cover.1690912539.git.jonathantanmy@google.com>
 source: <20230808192240.GA4091261@coredump.intra.peff.net>
