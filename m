Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF5C001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 21:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjHDVMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 17:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjHDVMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 17:12:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8565275
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 14:11:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6ACF1A62D5;
        Fri,  4 Aug 2023 17:10:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=x
        sT4tab/ln1wmaZmsR4OfnJbElj9Q3tLVNN+dEGhMUg=; b=LDq72aVGZioZBF9AL
        9zxf9rN16TD+PV6MTPgNunnTLw2jCeIrWDXkXxcYeGBZhvhnmU+N018Q6wJFgAiW
        VOw7R0UdJ4fU/rBJWYvXbclQ0Zs1E5pU6hBoSi4kmOE2KnjU0InDdtwStsxzFYNO
        5wDsX3prGw0e88XO+kiZwbRR+w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B83341A62D4;
        Fri,  4 Aug 2023 17:10:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 197631A62D3;
        Fri,  4 Aug 2023 17:10:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2023, #02; Fri, 4)
X-master-at: ac83bc5054c2ac489166072334b4147ce6d0fccb
X-next-at: 6953b252045fa7a4c836b56ff7a46e3e85c8275b
Date:   Fri, 04 Aug 2023 14:10:58 -0700
Message-ID: <xmqqzg36jyxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68D0692A-330B-11EE-9F37-307A8E0A682E-77302942!pb-smtp2.pobox.com
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

Git 2.42-rc0 has been tagged.  Hopefully people can help find and
fix plenty of regressions before we tag -rc1 mid next week ;-)

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

* hy/blame-in-bare-with-contents (2023-07-21) 1 commit
  (merged to 'next' on 2023-07-31 at 39ac96d8d8)
 + blame: allow --contents to work with bare repo

 "git blame --contents=file" has been taught to work in a bare
 repository.
 source: <20230721035758.61956-1-hanyang.tony@bytedance.com>


* ja/worktree-orphan-fix (2023-07-26) 3 commits
  (merged to 'next' on 2023-07-27 at e475016065)
 + t2400: rewrite regex to avoid unintentional PCRE
 + builtin/worktree.c: convert tab in advice to space
 + t2400: drop no-op `--sq` from rev-parse call

 Fix tests with unportable regex patterns.
 source: <20230726214202.15775-1-jacobabel@nullpo.dev>


* jc/branch-in-use-error-message (2023-07-21) 1 commit
  (merged to 'next' on 2023-07-31 at 22f17d131b)
 + branch: update the message to refuse touching a branch in-use

 "git branch -f X" to repoint the branch X said that X was "checked
 out" in another worktree, even when branch X was not and instead
 being bisected or rebased.  The message was reworded to say the
 branch was "in use".
 source: <xmqqr0p1szhz.fsf_-_@gitster.g>


* jc/doc-sent-patch-now-what (2023-07-27) 1 commit
  (merged to 'next' on 2023-07-31 at 51f5d9d465)
 + MyFirstContribution: refrain from self-iterating too much

 Process document update.
 source: <xmqqmszg987u.fsf_-_@gitster.g>


* jc/parse-options-short-help (2023-07-19) 3 commits
  (merged to 'next' on 2023-07-31 at e076d1f497)
 + short help: allow a gap smaller than USAGE_GAP
 + remote: simplify "remote add --tags" help text
 + short help: allow multi-line opthelp

 Command line parser fix, and a small parse-options API update.
 source: <xmqq5y6gg8fn.fsf@gitster.g>


* jc/retire-get-sha1-hex (2023-07-24) 1 commit
  (merged to 'next' on 2023-07-27 at eeb9cc37f5)
 + hex: retire get_sha1_hex()

 The implementation of "get_sha1_hex()" that reads a hexadecimal
 string that spells a full object name has been extended to cope
 with any hash function used in the repository, but the "sha1" in
 its name survived.  Rename it to get_hash_hex(), a name that is
 more consistent within its friends like get_hash_hex_algop().
 source: <xmqq1qgwoqgo.fsf_-_@gitster.g>


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


* pv/doc-submodule-update-settings (2023-07-25) 1 commit
  (merged to 'next' on 2023-07-27 at e27b5b7ba8)
 + doc: highlight that .gitmodules does not support !command

 Rewrite the description of giving a custom command to the
 submodule.<name>.update configuration variable.
 source: <20230725212218.711116-1-pvutov@imap.cc>

--------------------------------------------------
[New Topics]

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
 - docs: update when `git bisect visualize` uses `gitk`
 - compat/mingw: implement a native locate_in_PATH()
 - run-command: conditionally define locate_in_PATH()

 "git bisect visualize" stopped running "gitk" on Git for Windows
 when the command was reimplemented in C around Git 2.34 timeframe.
 This has been corrected.

 Will merge to 'next'.
 source: <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>


* pw/rebase-skip-commit-message-fix (2023-08-03) 1 commit
 - rebase --skip: fix commit message clean up when skipping squash

 "git rebase -i" with a series of squash/fixup, when one of the
 steps stopped in conflicts and ended up getting skipped, did not
 handle the accumulated commit log messages, which has been
 corrected.

 Will merge to 'next'.
 source: <pull.1558.git.git.1691068176051.gitgitgadget@gmail.com>


* bc/ignore-cland-cache (2023-08-04) 1 commit
  (merged to 'next' on 2023-08-04 at 5cf8d41911)
 + gitignore: ignore clangd .cache directory

 .gitignore update.

 Will merge to 'master'.
 source: <20230804171328.1737188-1-sandals@crustytoothpaste.net>

--------------------------------------------------
[Stalled]

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


* rs/parse-options-negation-help (2023-07-24) 5 commits
 - parse-options: show negatability of options in short help
 - t1502: test option negation
 - t1502: move optionspec help output to a file
 - t1502, docs: disallow --no-help
 - subtree: disallow --no-{help,quiet,debug,branch,message}

 "git cmd -h" learned to signal which options can be negated by
 listing such options like "--[no-]opt".

 Will merge to 'next'.
 I personally liked a later suggestion to deal with "--[no-]no-foo"
 but that can be done as a separate enhancement.
 cf. <31b71333-de8b-d9a8-3ec4-1bad9cae2bf3@web.de>
 cf. <xmqqjzug14jo.fsf@gitster.g>
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


* sl/sparse-check-attr (2023-07-18) 3 commits
 - check-attr: integrate with sparse-index
 - attr.c: read attributes in a sparse directory
 - t1092: add tests for 'git check-attr'

 Teach "git check-attr" work better with sparse-index.

 Expecting a reroll.
 cf. <c3ebe3b4-88b9-8ca2-2ee3-39a3e0d82201@github.com>
 cf. <5e478d8b-9ef4-864b-41e4-e0a79877d278@github.com>
 source: <20230718232916.31660-1-cheskaqiqi@gmail.com>


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

 Will merge to 'master'.
 cf. <ZMqp6K2iXixWH/zT@nand.local>
 source: <cover.1690912539.git.jonathantanmy@google.com>
