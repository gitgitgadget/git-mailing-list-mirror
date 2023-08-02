Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8730CC001DF
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 18:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjHBSLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 14:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjHBSKw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 14:10:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014141981
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 11:10:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81C6E29963;
        Wed,  2 Aug 2023 14:10:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=l
        ngtZqz0EEPbH5kO9kcJXV3/Ycb+d4+lzlZuFpx4Wow=; b=FFUSmZma3xWMmm168
        I3kfjRDyLepap69L1NvsR8SnB5YBnMHdGQFS34zE9PwUPDnl/458MYl53yKrQzOx
        v99CthLkr+VhSBWbZ1iWAqkgxeMpFnra3Wz1qD2UcgGj37cdNKtfAsI+XP1S1okh
        5w1xkAuOlnlxfi84ILFopWxtkA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79E6329962;
        Wed,  2 Aug 2023 14:10:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5969F29960;
        Wed,  2 Aug 2023 14:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2023, #01; Wed, 2)
X-master-at: 1b0a5129563ebe720330fdc8f5c6843d27641137
X-next-at: ed35a5117f890568bcd8290b0000b7550ab351b8
Date:   Wed, 02 Aug 2023 11:10:34 -0700
Message-ID: <xmqqfs518gdh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E08947BE-315F-11EE-BFD4-C2DA088D43B2-77302942!pb-smtp20.pobox.com
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

We are getting closer to the final phase of this cycle, which begins
when -rc0 preview release is tagged this coming Friday, followed by
about 1 1/2 weeks of stabilization period that begins when -rc1 is
tagged (cf. tinyurl.com/gitCal).  There are a handful of topics that
still need reviews before getting merged to 'next', but because the
summer in the northern hemisphere is historically a slower season,
too few reviewers seem to be active, relative to the number of these
topics.

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

* ah/autoconf-fixes (2023-07-19) 3 commits
  (merged to 'next' on 2023-07-25 at 35ff66e0cb)
 + configure.ac: always save NO_ICONV to config.status
 + configure.ac: don't overwrite NO_CURL option
 + configure.ac: don't overwrite NO_EXPAT option

 "./configure --with-expat=no" did not work as a way to refuse use
 of the expat library on a system with the library installed, which
 has been corrected.
 source: <20230719145211.17854-2-aherrmann@suse.de>


* ah/sequencer-rewrite-todo-fix (2023-07-24) 1 commit
  (merged to 'next' on 2023-07-26 at 24e74d9eda)
 + sequencer: finish parsing the todo list despite an invalid first line

 When the user edits "rebase -i" todo file so that it starts with a
 "fixup", which would make it invalid, the command truncated the
 rest of the file before giving an error and returning the control
 back to the user.  Stop truncating to make it easier to correct
 such a malformed todo file.
 cf. <https://lore.kernel.org/git/0d1c5bfd-3ae5-83f0-a333-bbb8510a973a@gmail.com/>
 source: <20230722212830.132135-2-alexhenrie24@gmail.com>


* bb/use-trace2-counters-for-fsync-stats (2023-07-20) 1 commit
  (merged to 'next' on 2023-07-26 at f2c2e3f2b9)
 + wrapper: use trace2 counters to collect fsync stats

 Instead of inventing a custom counter variables for debugging,
 use existing trace2 facility in the fsync customization codepath.
 source: <20230720164823.625815-1-dev+git@drbeat.li>


* jc/tree-walk-drop-base-offset (2023-07-07) 2 commits
  (merged to 'next' on 2023-07-25 at cc050c60a6)
 + tree-walk: drop unused base_offset from do_match()
 + tree-walk: lose base_offset that is never used in tree_entry_interesting

 Code simplification.
 source: <20230707222116.4129415-1-gitster@pobox.com>


* ks/ref-filter-describe (2023-07-24) 2 commits
  (merged to 'next' on 2023-07-26 at f4b3b3b7ef)
 + ref-filter: add new "describe" atom
 + ref-filter: add multiple-option parsing functions

 "git branch --list --format=<format>" and friends are taught
 a new "%(describe)" placeholder.
 source: <20230723162717.68123-1-five231003@gmail.com>

--------------------------------------------------
[New Topics]

* bc/ident-dot-is-no-longer-crud-letter (2023-08-02) 1 commit
 - ident: don't consider '.' a crud

 Exclude "." from the set of characters to be removed from the
 beginning and the end of the human-readable name.

 Will merge to 'next'?
 source: <xmqqsf918k4j.fsf@gitster.g>


* jc/unresolve-removal (2023-07-31) 7 commits
 - checkout: allow "checkout -m path" to unmerge removed paths
 - checkout/restore: add basic tests for --merge
 - checkout/restore: refuse unmerging paths unless checking out of the index
 - update-index: remove stale fallback code for "--unresolve"
 - update-index: use unmerge_index_entry() to support removal
 - resolve-undo: allow resurrecting conflicted state that resolved to deletion
 - update-index: do not read HEAD and MERGE_HEAD unconditionally

 "checkout --merge -- path" and "update-index --unresolve path" did
 not resurrect conflicted state that was resolved to remove path,
 but now they do.

 Needs review.
 source: <20230731224409.4181277-1-gitster@pobox.com>


* ew/hash-with-openssl-evp (2023-08-01) 2 commits
 - avoid SHA-1 functions deprecated in OpenSSL 3+
 - sha256: avoid functions deprecated in OpenSSL 3+

 Adjust to OpenSSL 3+, which deprecates its SHA-1 functions based on
 its traditional API, by using its EVP API instead.

 Will merge to 'next'. 
 source: <20230801025454.1137802-1-e@80x24.org>


* rj/status-bisect-while-rebase (2023-08-01) 1 commit
 - status: fix branch shown when not only bisecting

 "git status" is taught to show both the branch being bisected and
 being rebased when both are in effect at the same time.

 Needs review.
 source: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>

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


* ob/revert-of-revert (2023-05-05) 1 commit
 - sequencer: beautify subject of reverts of reverts

 Instead of "Revert "Revert "original"", give "Reapply "original""
 as the title for a revert of a revert.

 Will discard.
 Have been expecting a hopefully final reroll for too long.
 Looking much better, except for minor cosmetic issues.
 cf. <xmqqmt21txid.fsf@gitster.g>
 source: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>


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

 Will merge to 'next'?
 cf. <xmqqa5vad6ea.fsf@gitster.g>
 cf. <xmqq5y5yd6d7.fsf@gitster.g>
 source: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* ew/sha256-gcrypt-leak-fixes (2023-07-31) 3 commits
  (merged to 'next' on 2023-08-01 at eed83801c3)
 + sha256/gcrypt: die on gcry_md_open failures
 + sha256/gcrypt: fix memory leak with SHA-256 repos
 + sha256/gcrypt: fix build with SANITIZE=leak

 Leakfixes.

 Will merge to 'master'.
 source: <20230731120808.1230210-1-e@80x24.org>


* rs/bundle-parseopt-cleanup (2023-07-31) 1 commit
  (merged to 'next' on 2023-08-01 at 405eb138fa)
 + bundle: use OPT_PASSTHRU_ARGV

 Code clean-up.

 Will merge to 'master'.
 source: <2dcb915f-b926-e024-6394-23aff200955c@web.de>


* pv/doc-submodule-update-settings (2023-07-25) 1 commit
  (merged to 'next' on 2023-07-27 at e27b5b7ba8)
 + doc: highlight that .gitmodules does not support !command

 Rewrite the description of giving a custom command to the
 submodule.<name>.update configuraiton variable.

 Will merge to 'master'.
 source: <20230725212218.711116-1-pvutov@imap.cc>


* la/doc-choose-starting-point-fixup (2023-07-27) 3 commits
  (merged to 'next' on 2023-07-28 at 047dcae31c)
 + SubmittingPatches: use of older maintenance tracks is an exception
 + SubmittingPatches: explain why 'next' and above are inappropriate base
 + SubmittingPatches: choice of base for fixing an older maintenance track
 (this branch uses la/doc-choose-starting-point.)

 Clarify how to pick a starting point for a new topic in the
 SubmittingPatches document.

 Will merge to 'master', together with the underlying topic.
 source: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
 source: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>


* am/doc-sha256 (2023-07-31) 1 commit
  (merged to 'next' on 2023-08-01 at d7419bf527)
 + doc: sha256 is no longer experimental

 Tone down the warning on SHA-256 repositories being an experimental
 curiosity.  We do not have support for them to interoperate with
 traditional SHA-1 repositories, but at this point, we do not plan
 to make breaking changes to SHA-256 repositories and there is no
 longer need for such a strongly phrased warning.

 Will merge to 'master'.
 source: <ZMe6KmzZGVubYpvO@adams>


* hy/blame-in-bare-with-contents (2023-07-21) 1 commit
  (merged to 'next' on 2023-07-31 at 39ac96d8d8)
 + blame: allow --contents to work with bare repo

 "git blame --contents=file" has been taught to work in a bare
 repository.

 Will merge to 'master'.
 source: <20230721035758.61956-1-hanyang.tony@bytedance.com>


* ja/worktree-orphan-fix (2023-07-26) 3 commits
  (merged to 'next' on 2023-07-27 at e475016065)
 + t2400: rewrite regex to avoid unintentional PCRE
 + builtin/worktree.c: convert tab in advice to space
 + t2400: drop no-op `--sq` from rev-parse call

 Fix tests with unportable regex patterns.

 Will merge to 'master'.
 source: <20230726214202.15775-1-jacobabel@nullpo.dev>


* jc/retire-get-sha1-hex (2023-07-24) 1 commit
  (merged to 'next' on 2023-07-27 at eeb9cc37f5)
 + hex: retire get_sha1_hex()

 The implementation of "get_sha1_hex()" that reads a hexadecimal
 string that spells a full object name has been extended to cope
 with any hash function used in the repository, but the "sha1" in
 its name survived.  Rename it to get_hash_hex(), a name that is
 more consistent within its friends like get_hash_hex_algop().

 Will merge to 'master'.
 source: <xmqq1qgwoqgo.fsf_-_@gitster.g>


* rs/parse-options-negation-help (2023-07-24) 5 commits
 - parse-options: show negatability of options in short help
 - t1502: test option negation
 - t1502: move optionspec help output to a file
 - t1502, docs: disallow --no-help
 - subtree: disallow --no-{help,quiet,debug,branch,message}

 "git cmd -h" learned to signal which options can be negated by
 listing such options like "--[no-]opt".

 Comments?
 Would showing "--[[no-]no-]opt" for "no-opt" be worth it?
 cf. <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
 source: <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>


* tb/commit-graph-tests (2023-07-24) 5 commits
  (merged to 'next' on 2023-07-31 at 740a260315)
 + t/lib-commit-graph.sh: avoid sub-shell in `graph_git_behavior()`
 + t5328: avoid top-level directory changes
 + t5318: avoid top-level directory changes
 + t/lib-commit-graph.sh: avoid directory change in `graph_git_behavior()`
 + t/lib-commit-graph.sh: allow `graph_read_expect()` in sub-directories

 Test updates.

 Will merge to 'master'.
 source: <cover.1690216758.git.me@ttaylorr.com>


* la/doc-choose-starting-point (2023-07-14) 5 commits
  (merged to 'next' on 2023-07-19 at 5a807cae46)
 + SubmittingPatches: simplify guidance for choosing a starting point
 + SubmittingPatches: emphasize need to communicate non-default starting points
 + SubmittingPatches: de-emphasize branches as starting points
 + SubmittingPatches: discuss subsystems separately from git.git
 + SubmittingPatches: reword awkward phrasing
 (this branch is used by la/doc-choose-starting-point-fixup.)

 Clarify how to choose the starting point for a new topic in
 developer guidance document.

 Will merge to 'master' together with the follow-on topic.
 source: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>


* jc/doc-sent-patch-now-what (2023-07-27) 1 commit
  (merged to 'next' on 2023-07-31 at 51f5d9d465)
 + MyFirstContribution: refrain from self-iterating too much

 Process document update.

 Will merge to 'master'.
 source: <xmqqmszg987u.fsf_-_@gitster.g>


* jc/parse-options-short-help (2023-07-19) 3 commits
  (merged to 'next' on 2023-07-31 at e076d1f497)
 + short help: allow a gap smaller than USAGE_GAP
 + remote: simplify "remote add --tags" help text
 + short help: allow multi-line opthelp

 Command line parser fix, and a small parse-options API update.

 Will merge to 'master'.
 source: <xmqq5y6gg8fn.fsf@gitster.g>


* sl/sparse-check-attr (2023-07-18) 3 commits
 - check-attr: integrate with sparse-index
 - attr.c: read attributes in a sparse directory
 - t1092: add tests for 'git check-attr'

 Teach "git check-attr" work better with sparse-index.

 Expecting a reroll.
 cf. <c3ebe3b4-88b9-8ca2-2ee3-39a3e0d82201@github.com>
 cf. <5e478d8b-9ef4-864b-41e4-e0a79877d278@github.com>
 source: <20230718232916.31660-1-cheskaqiqi@gmail.com>


* jc/branch-in-use-error-message (2023-07-21) 1 commit
  (merged to 'next' on 2023-07-31 at 22f17d131b)
 + branch: update the message to refuse touching a branch in-use

 "git branch -f X" to repoint the branch X seid that X was "checked
 out" in another worktree, even when branch X was not and instead
 being bisected or rebased.  The message was reworded to say the
 branch was "in use".

 Will merge to 'master'.
 source: <xmqqr0p1szhz.fsf_-_@gitster.g>


* mh/credential-erase-improvements-more (2023-07-26) 2 commits
 - credential/wincred: erase matching creds only
 - credential/libsecret: erase matching creds only

 Update two credential helpers to correctly match which credential
 to erase; they dropped not the ones with stale password.

 Needs review.
 source: <pull.1527.v2.git.git.1690387585634.gitgitgadget@gmail.com>
 source: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>


* cc/repack-sift-filtered-objects-to-separate-pack (2023-07-24) 8 commits
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

 Breaks CI with some environment variables configured.
 cf. <xmqqo7jzh9mh.fsf@gitster.g>
 source: <20230724085909.3831831-1-christian.couder@gmail.com>


* js/doc-unit-tests (2023-06-30) 1 commit
 - unit tests: Add a project plan document

 Process to add some form of low-level unit tests has started.

 Still filling in blanks.
 source: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>


* jt/path-filter-fix (2023-08-01) 7 commits
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

 Still under discussion.
 cf. <20230801185232.1457172-1-jonathantanmy@google.com>
 source: <cover.1690912539.git.jonathantanmy@google.com>


* mh/credential-libsecret-attrs (2023-06-16) 1 commit
 - credential/libsecret: store new attributes

 The way authentication related data other than passwords (e.g.
 oath token and password expiration data) are stored in libsecret
 keyrings has been rethought.

 Needs review.
 source: <pull.1469.v5.git.git.1686945306242.gitgitgadget@gmail.com>


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

 What's the status of this thing?
 source: <20230602102533.876905-1-christian.couder@gmail.com>

--------------------------------------------------
[Discarded]

* jc/doc-submodule-update-settings (2023-07-13) 1 commit
 . submodule: clarify that "!custom command" is the only oddball

 Rewrite the description of giving a custom command to the
 submodule.<name>.update configuraiton variable.

 Superseded by pv/doc-submodule-update-settings topic.
 source: <xmqqwmz3oacg.fsf@gitster.g>


* jc/rerere-read-rr-fix (2023-07-21) 1 commit
 . rerere: match the hash algorithm with its length

 SHA-256 fix.

 Superseded by jc/retire-get-sha1-hex
 source: <xmqqa5vou9ar.fsf@gitster.g>


* cb/checkout-same-branch-twice (2023-03-22) 2 commits
 . SQUASH??? the test marked to expect failure passes from day one
 . checkout/switch: disallow checking out same branch in multiple worktrees

 "git checkout -B $branch" failed to protect against checking out
 a branch that is checked out elsewhere, unlike "git branch -f" did.

 Have been expecting a hopefully minor and final reroll for too long.
 cf. <CAPUEspj_Bh+LgYLnWfeBdcq_uV5Cbou-7H51GLFjzSa5Qzby9w@mail.gmail.com>
 source: <20230120113553.24655-1-carenas@gmail.com>


* ed/fsmonitor-windows-named-pipe (2023-03-24) 1 commit
 . fsmonitor: handle differences between Windows named pipe functions

 Fix fsmonitor on Windows when the filesystem path contains certain
 characters.

 Have been expecting a reroll for too long.
 cf. <b9cf67e4-22a7-2ff0-8310-9223bea10d6d@jeffhostetler.com>
 source: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>


* rn/sparse-diff-index (2023-04-10) 1 commit
 . diff-index: enable sparse index

 "git diff-index" command has been taught to work better with the
 sparse index.

 Have been expecting a reroll for too long.
 cf. <62821012-4fc3-5ad8-695c-70f7ab14a8c9@github.com>
 source: <20230408112342.404318-1-nanth.raghul@gmail.com>


* es/recurse-submodules-option-is-a-bool (2023-04-10) 1 commit
 . usage: clarify --recurse-submodules as a boolean

 The "--[no-]recurse-submodules" option of "git checkout" and others
 supported an undocumented syntax --recurse-submodules=<value> where
 the value can spell a Boolean in various ways.  The support for the
 syntax is being dropped.

 Have been expecting a reroll for too long.
 cf. <ZDSTFwMFO7vbj/du@google.com>
 source: <ZDSTFwMFO7vbj/du@google.com>


* jc/checkout-merge-fix (2023-07-28) 2 commits
 . checkout/restore: add basic tests for --merge
 . checkout/restore: refuse unmerging paths unless checking out of the index

 "git checkout/restore --merge -- $path" improvements.

 Superseded by jc/unresolve-removal
 source: <xmqq7cqj4rme.fsf@gitster.g>


* jc/resolve-undo-fixes (2023-07-28) 4 commits
 . update-index: remove stale fallback code for "--unresolve"
 . update-index: use unmerge_index_entry() to support removal
 . resolve-undo: allow resurrecting conflicted state that resolved to deletion
 . update-index: do not read HEAD and MERGE_HEAD unconditionally

 Assorted fixes and clean-up around resolve-undo data.

 Superseded by jc/unresolve-removal
 source: <xmqqo7jv4y0t.fsf_-_@gitster.g>
