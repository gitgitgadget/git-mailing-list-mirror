Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B889C001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 23:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjGMXJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 19:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjGMXJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 19:09:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE1A2720
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 16:09:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A304B1AC327;
        Thu, 13 Jul 2023 19:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=N
        Py0N/gcizRjIkbCBDwcp+aII881awKbeRkO/EiqN9w=; b=g7fCuHfiGVz7OBY42
        /1/jyM9XEWG1ccp10xdjke94jqXB8ZrhgIKAqoeDjG/EacjZ+UJM5zcXSrAgWav4
        rJRv5TiAxn47+zDQ7b3KKxpiLGHRUI4YHUDzYtaT47ZREFDKnly8LUKDN+eYL4qg
        RUESJUjuycvPCVTl4iluniVOvw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AB381AC326;
        Thu, 13 Jul 2023 19:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B28551AC325;
        Thu, 13 Jul 2023 19:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2023, #03; Thu, 13)
X-master-at: aa9166bcc0ba654fc21f198a30647ec087f733ed
X-next-at: 6d72f3e9957d90c2c3269bbf808b5f7ffda9b026
Date:   Thu, 13 Jul 2023 16:09:11 -0700
Message-ID: <xmqqr0pbjtns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47DB4586-21D2-11EE-A6E0-307A8E0A682E-77302942!pb-smtp2.pobox.com
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

There are quite a few topics that have been in "Expecting a reroll"
for too long.  I've moved those that are more than 3 months old to
the "Will discard" section, but given that Summer is a relatively
slow season, I'll keep these topics for a few more weeks at least.

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

* ah/configure-no-expat (2023-07-13) 1 commit
 - configure.ac: Don't overwrite NO_EXPAT option

 "./configure --with-expat=no" did not work as a way to refuse use
 of the expat library on a system with the library installed, which
 has been corrected.

 Review response sent.
 cf. <xmqqwmz3pwx2.fsf@gitster.g>
 source: <20230713074654.23957-1-aherrmann@suse.de>


* jc/branch-in-use-error-message (2023-07-12) 1 commit
 - branch: update the message to refuse touching a branch in-use

 "git branch -f X" to repoint the branch X seid that X was "checked
 out" in another worktree, even when branch X was not and instead
 being bisected or rebased.  The message was reworded to say the
 branch was "in use".

 Will merge to 'next'?
 source: <xmqqy1jkrcmg.fsf_-_@gitster.g>


* tb/object-access-overflow-protection (2023-07-12) 20 commits
 - commit-graph.c: prevent overflow in `verify_commit_graph()`
 - commit-graph.c: prevent overflow in `write_commit_graph()`
 - commit-graph.c: prevent overflow in `merge_commit_graph()`
 - commit-graph.c: prevent overflow in `split_graph_merge_strategy()`
 - commit-graph.c: prevent overflow in `load_tree_for_commit()`
 - commit-graph.c: prevent overflow in `fill_commit_in_graph()`
 - commit-graph.c: prevent overflow in `fill_commit_graph_info()`
 - commit-graph.c: prevent overflow in `load_oid_from_graph()`
 - commit-graph.c: prevent overflow in add_graph_to_chain()
 - commit-graph.c: prevent overflow in `write_commit_graph_file()`
 - pack-bitmap.c: ensure that eindex lookups don't overflow
 - midx.c: prevent overflow in `fill_included_packs_batch()`
 - midx.c: prevent overflow in `write_midx_internal()`
 - midx.c: store `nr`, `alloc` variables as `size_t`'s
 - midx.c: prevent overflow in `nth_midxed_offset()`
 - midx.c: prevent overflow in `nth_midxed_object_oid()`
 - midx.c: use `size_t`'s for fanout nr and alloc
 - packfile.c: use checked arithmetic in `nth_packed_object_offset()`
 - packfile.c: prevent overflow in `load_idx()`
 - packfile.c: prevent overflow in `nth_packed_object_id()`

 Various offset computation in the code that accesses the packfiles
 and other data in the object layer has been hardened against
 arithmetic overflow, especially on 32-bit systems.

 Expecting a reroll or a fix-up.
 cf. <5d2cf09f-34c7-9a88-bab2-8bf348dd13bb@gmail.com>
 source: <cover.1689205042.git.me@ttaylorr.com>


* jc/doc-submodule-update-settings (2023-07-13) 1 commit
 - submodule: clarify that "!custom command" is the only oddball

 Rewrite the description of giving a custom command to the
 submodule.<name>.update configuraiton variable.

 source: <xmqqwmz3oacg.fsf@gitster.g>

--------------------------------------------------
[Stalled]

* ed/fsmonitor-windows-named-pipe (2023-03-24) 1 commit
 - fsmonitor: handle differences between Windows named pipe functions

 Fix fsmonitor on Windows when the filesystem path contains certain
 characters.

 Will discard.
 Have been expecting a reroll for too long.
 cf. <b9cf67e4-22a7-2ff0-8310-9223bea10d6d@jeffhostetler.com>
 source: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>


* rn/sparse-diff-index (2023-04-10) 1 commit
 - diff-index: enable sparse index

 "git diff-index" command has been taught to work better with the
 sparse index.

 Will discard.
 Have been expecting a reroll for too long.
 cf. <62821012-4fc3-5ad8-695c-70f7ab14a8c9@github.com>
 source: <20230408112342.404318-1-nanth.raghul@gmail.com>


* es/recurse-submodules-option-is-a-bool (2023-04-10) 1 commit
 - usage: clarify --recurse-submodules as a boolean

 The "--[no-]recurse-submodules" option of "git checkout" and others
 supported an undocumented syntax --recurse-submodules=<value> where
 the value can spell a Boolean in various ways.  The support for the
 syntax is being dropped.

 Will discard.
 Have been expecting a reroll for too long.
 cf. <ZDSTFwMFO7vbj/du@google.com>
 source: <ZDSTFwMFO7vbj/du@google.com>


* cb/checkout-same-branch-twice (2023-03-22) 2 commits
 - SQUASH??? the test marked to expect failure passes from day one
 - checkout/switch: disallow checking out same branch in multiple worktrees

 "git checkout -B $branch" failed to protect against checking out
 a branch that is checked out elsewhere, unlike "git branch -f" did.

 Will discard.
 Have been expecting a hopefully minor and final reroll for too long.
 cf. <CAPUEspj_Bh+LgYLnWfeBdcq_uV5Cbou-7H51GLFjzSa5Qzby9w@mail.gmail.com>
 source: <20230120113553.24655-1-carenas@gmail.com>


* tk/pull-conflict-suggest-rebase-merge-not-rebase-true (2023-02-13) 1 commit
 - pull: conflict hint pull.rebase suggestion should offer "merges" vs "true"

 In an advice message after failed non-ff pull, we used to suggest
 setting pull.rebase=true, but these days pull.rebase=merges may be
 more inline with the original spirit of "rebuild your side on top
 of theirs".

 Will discard.
 This is too much of a departure from the existing practice.
 cf. <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 cf. <CABPp-BGqAxKnxDRVN4cYMteLp33hvto07R3=TJBT5WubJT4+Og@mail.gmail.com>
 source: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>


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


* ad/test-record-count-when-harness-is-in-use (2022-12-25) 1 commit
 - test-lib: allow storing counts with test harnesses

 Allow summary results from tests to be written to t/test-results
 directory even when a test harness like 'prove' is in use.

 Will discard.
 Have been expecting a reroll for too long.
 cf. <CABPp-BGoPuGCZw+9wCgdYyRR4Zf4y9Kun27GrQhtMdYWpOUsYQ@mail.gmail.com>
 source: <20221224225200.1027806-1-adam@dinwoodie.org>


* so/diff-merges-more (2022-12-18) 5 commits
 - diff-merges: improve --diff-merges documentation
 - diff-merges: issue warning on lone '-m' option
 - diff-merges: support list of values for --diff-merges
 - diff-merges: implement log.diffMerges-m-imply-p config
 - diff-merges: implement [no-]hide option and log.diffMergesHide config

 Assorted updates to "--diff-merges=X" option.

 Will discard.
 Breaking compatibility does not seem worth it.
 source: <20221217132955.108542-1-sorganov@gmail.com>


* ab/imap-send-requires-curl (2023-02-02) 6 commits
 - imap-send: correctly report "host" when using "tunnel"
 - imap-send: remove old --no-curl codepath
 - imap-send: make --curl no-optional
 - imap-send: replace auto-probe libcurl with hard dependency
 - imap-send doc: the imap.sslVerify is used with imap.tunnel
 - imap-send: note "auth_method", not "host" on auth method failure

 Give a hard dependency on cURL library to build "git imap-send",
 and remove the code to interact with IMAP server without using cURL.

 Will discard.
 Have been expecting a reroll for too long.
 The 'tunnel' part is still iffy.
 cf. <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
 source: <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>


* cw/submodule-status-in-parallel (2023-03-02) 6 commits
 - diff-lib: parallelize run_diff_files for submodules
 - diff-lib: refactor out diff_change logic
 - submodule: refactor is_submodule_modified()
 - submodule: move status parsing into function
 - submodule: rename strbuf variable
 - run-command: add on_stderr_output_fn to run_processes_parallel_opts

 "git submodule status" learned to run the comparison in submodule
 repositories in parallel.

 Will discard.
 Have been expecting a reroll for too long.
 cf. <CAFySSZDk05m6gU5-V1R+y3YnQ5PPduVW54+_gjBwD0rmacsLsw@mail.gmail.com>
 cf. <230307.865ybc273g.gmgdl@evledraar.gmail.com>
 source: <20230302215237.1473444-1-calvinwan@google.com>


* ob/revert-of-revert (2023-05-05) 1 commit
 - sequencer: beautify subject of reverts of reverts

 Instead of "Revert "Revert "original"", give "Reapply "original""
 as the title for a revert of a revert.

 Will discard.
 Have been expecting a hopefully final reroll for too long.
 Looking much better, except for minor cosmetic issues.
 cf. <xmqqmt21txid.fsf@gitster.g>
 source: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>


* pw/rebase-i-after-failure (2023-04-21) 6 commits
 - rebase -i: fix adding failed command to the todo list
 - rebase: fix rewritten list for failed pick
 - rebase --continue: refuse to commit after failed command
 - sequencer: factor out part of pick_commits()
 - rebase -i: remove patch file after conflict resolution
 - rebase -i: move unlink() calls

 Various fixes to the behaviour of "rebase -i" when the command got
 interrupted by conflicting changes.

 Expecting a reroll.
 cf. <xmqqsfcthrpb.fsf@gitster.g>
 cf. <1fd54422-b66a-c2e4-7cd7-934ea01190ad@gmail.com>
 source: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* ah/advise-force-pushing (2023-07-13) 3 commits
 - push: don't imply that integration is always required before pushing
 - remote: don't imply that integration is always required before pushing
 - wt-status: don't show divergence advice when committing

 Help newbies by suggesting that there are cases where force-pushing
 is a valid and sensible thing to update a branch at a remote
 repository, rather than reconciling with merge/rebase.

 Will merge to 'next'.
 cf. <919d1ba8-bb8b-a77b-cef3-db14f168ed4a@gmail.com>
 source: <20230713044128.3771818-1-alexhenrie24@gmail.com>


* jc/pathspec-match-with-common-prefix (2023-07-08) 2 commits
  (merged to 'next' on 2023-07-10 at 4146f391ed)
 + dir: match "attr" pathspec magic with correct paths
 + t6135: attr magic with path pattern

 "git ls-files '(attr:X)D/'" that triggers the common prefix
 optimization codepath failed to read from "D/.gitattributes",
 which has been corrected.

 Will merge to 'master'.
 source: <20230707220457.3655121-1-gitster@pobox.com>


* jc/tree-walk-drop-base-offset (2023-07-07) 2 commits
 - tree-walk: drop unused base_offset from do_match()
 - tree-walk: lose base_offset that is never used in tree_entry_interesting

 Code simplification.

 Needs review.
 source: <20230707222116.4129415-1-gitster@pobox.com>


* rs/ls-tree-prefix-simplify (2023-07-07) 1 commit
  (merged to 'next' on 2023-07-08 at 3e4826525f)
 + ls-tree: simplify prefix handling

 Code simplification.

 Will merge to 'master'.
 source: <b34aa99b-2bf1-c645-bdf5-03ac258b4bf5@web.de>


* rs/pretty-format-double-negation-fix (2023-07-07) 1 commit
  (merged to 'next' on 2023-07-08 at 6674b562ff)
 + pretty: avoid double negative in format_commit_item()

 Code clarification.

 Will merge to 'master'.
 source: <8d4fcad1-5f71-4790-17ee-e9ba0a3118dc@web.de>


* rs/userformat-find-requirements-simplify (2023-07-07) 1 commit
  (merged to 'next' on 2023-07-08 at 6cdc328a08)
 + pretty: use strchr(3) in userformat_find_requirements()

 Code simplification.

 Will merge to 'master'.
 source: <108ab1a2-28f4-dd62-1f90-64f37708aa8c@web.de>


* mh/doc-credential-helpers (2023-07-10) 1 commit
  (merged to 'next' on 2023-07-11 at a391669194)
 + doc: gitcredentials: link to helper list

 Doc update.

 Will merge to 'master'.
 source: <pull.1538.v3.git.1688848614262.gitgitgadget@gmail.com>


* tb/fsck-no-progress (2023-07-10) 6 commits
  (merged to 'next' on 2023-07-11 at aab8389518)
 + commit-graph.c: avoid duplicated progress output during `verify`
 + commit-graph.c: pass progress to `verify_one_commit_graph()`
 + commit-graph.c: iteratively verify commit-graph chains
 + commit-graph.c: extract `verify_one_commit_graph()`
 + fsck: suppress MIDX output with `--no-progress`
 + fsck: suppress commit-graph output with `--no-progress`

 "git fsck --no-progress" still spewed noise from the commit-graph
 subsystem, which has been corrected.

 Will merge to 'master'.
 source: <cover.1688776280.git.me@ttaylorr.com>


* tb/repack-cleanup (2023-07-11) 2 commits
  (merged to 'next' on 2023-07-11 at f598c59a8a)
 + builtin/repack.c: avoid dir traversal in `collect_pack_filenames()`
 + builtin/repack.c: only repack `.pack`s that exist

 The recent change to "git repack" made it react less nicely when a
 leftover .idx file that no longer has the corresponding .pack file
 in the repository, which has been corrected.

 Will merge to 'master'.
 source: <cover.1689096750.git.me@ttaylorr.com>


* cw/compat-util-header-cleanup (2023-07-05) 6 commits
  (merged to 'next' on 2023-07-08 at c244b65c4f)
 + git-compat-util: move alloc macros to git-compat-util.h
 + treewide: remove unnecessary includes for wrapper.h
 + kwset: move translation table from ctype
 + sane-ctype.h: create header for sane-ctype macros
 + git-compat-util: move wrapper.c funcs to its header
 + git-compat-util: move strbuf.c funcs to its header

 Further shuffling of declarations across header files to streamline
 file dependencies.

 Will merge to 'master'.
 source: <20230705170812.3833103-1-calvinwan@google.com>


* jk/imap-send-unused-variable-cleanup (2023-07-05) 3 commits
  (merged to 'next' on 2023-07-06 at d2798ee0fe)
 + imap-send: drop unused fields from imap_cmd_cb
 + imap-send: drop unused parameter from imap_cmd_cb callback
 + imap-send: use server conf argument in setup_curl()

 "imap-send" codepaths got cleaned up to get rid of unused
 parameters.

 Will merge to 'master'.
 source: <20230703063247.GA3524302@coredump.intra.peff.net>


* ma/t0091-fixup (2023-07-05) 1 commit
  (merged to 'next' on 2023-07-06 at 3f82b468b4)
 + t0091-bugreport.sh: actually verify some content of report

 "git bugreport" tests did not test what it wanted to test, which
 has been corrected.

 Will merge to 'master'.
 source: <20230705183532.3057433-1-martin.agren@gmail.com>


* rs/packet-length-simplify (2023-07-07) 1 commit
  (merged to 'next' on 2023-07-08 at 7f4b52e75b)
 + pkt-line: add size parameter to packet_length()

 Code simplification.

 Will merge to 'master'.
 source: <4d2bb49b-9c3c-ea58-274b-d9e9586620c1@web.de>


* vd/adjust-mfow-doc-to-updated-headers (2023-07-04) 1 commit
  (merged to 'next' on 2023-07-08 at 38103c697d)
 + docs: add necessary headers to Documentation/MFOW.txt

 Code snippets in a tutorial document no longer compiled after
 recent header shuffling, which have been corrected.

 Will merge to 'master'.
 source: <20230702151457.3227-1-vinayakdev.sci@gmail.com>


* mh/credential-erase-improvements-more (2023-06-24) 2 commits
 - credential/wincred: erase matching creds only
 - credential/libsecret: erase matching creds only

 Needs review.
 source: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>


* pw/diff-no-index-from-named-pipes (2023-07-05) 4 commits
  (merged to 'next' on 2023-07-08 at 225230a441)
 + diff --no-index: support reading from named pipes
 + t4054: test diff --no-index with stdin
 + diff --no-index: die on error reading stdin
 + diff --no-index: refuse to compare stdin to a directory

 "git diff --no-index" learned to read from named pipes as if they
 were regular files, to allow "git diff <(process) <(substitution)"
 some shells support.

 Will merge to 'master'.
 source: <cover.1688586536.git.phillip.wood@dunelm.org.uk>


* cc/repack-sift-filtered-objects-to-separate-pack (2023-07-05) 8 commits
 - gc: add `gc.repackFilterTo` config option
 - repack: implement `--filter-to` for storing filtered out objects
 - gc: add `gc.repackFilter` config option
 - repack: add `--filter=<filter-spec>` option
 - repack: refactor finding pack prefix
 - repack: refactor finishing pack-objects command
 - t/helper: add 'find-pack' test-tool
 - pack-objects: allow `--filter` without `--stdout`

 "git repack" machinery learns to pay attention to the "--filter="
 option.

 Comments?
 cf. <xmqqh6qi1byn.fsf@gitster.g>
 source: <20230705060812.2865188-1-christian.couder@gmail.com>


* js/doc-unit-tests (2023-06-30) 1 commit
 - unit tests: Add a project plan document

 Process to add some form of low-level unit tests has started.

 Still filling in blanks.
 source: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>


* mh/mingw-case-sensitive-build (2023-06-12) 1 commit
 - mingw: use lowercase includes for some Windows headers

 Names of MinGW header files are spelled in mixed case in some
 source files, but the build host can be using case sensitive
 filesystem with header files with their name spelled in all
 lowercase.

 Needs review.
 source: <20230604211934.1365289-1-mh@glandium.org>


* ks/ref-filter-signature (2023-06-06) 2 commits
  (merged to 'next' on 2023-07-06 at 1748d2bb93)
 + ref-filter: add new "signature" atom
 + t/lib-gpg: introduce new prereq GPG2

 The "git for-each-ref" family of commands learned placeholders
 related to GPG signature verification.

 Will merge to 'master'.
 cf. <CAP8UFD1CfUm+9PTXO0wBBdBs0U=YVte+EiPbDyUyg7T152aw2g@mail.gmail.com>
 source: <20230604185815.15761-1-five231003@gmail.com>


* jt/path-filter-fix (2023-06-13) 4 commits
 - commit-graph: new filter ver. that fixes murmur3
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - gitformat-commit-graph: describe version 2 of BDAT

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Expecting a reroll.
 cf. <c7b66d2c-cdc3-1f0f-60a0-a2ee21c277bf@github.com>
 source: <cover.1686677910.git.jonathantanmy@google.com>


* tk/cherry-pick-sequence-requires-clean-worktree (2023-06-01) 1 commit
 - cherry-pick: refuse cherry-pick sequence if index is dirty

 "git cherry-pick A" that replays a single commit stopped before
 clobbering local modification, but "git cherry-pick A..B" did not,
 which has been corrected.

 Expecting a reroll.
 cf. <999f12b2-38d6-f446-e763-4985116ad37d@gmail.com>
 source: <pull.1535.v2.git.1685264889088.gitgitgadget@gmail.com>


* mh/credential-libsecret-attrs (2023-06-16) 1 commit
 - credential/libsecret: store new attributes

 The way authentication related data other than passwords (e.g.
 oath token and password expiration data) are stored in libsecret
 keyrings has been rethought.

 Needs review.
 source: <pull.1469.v5.git.git.1686945306242.gitgitgadget@gmail.com>


* tb/refs-exclusion-and-packed-refs (2023-07-10) 16 commits
  (merged to 'next' on 2023-07-13 at 6d72f3e995)
 + ls-refs.c: avoid enumerating hidden refs where possible
 + upload-pack.c: avoid enumerating hidden refs where possible
 + builtin/receive-pack.c: avoid enumerating hidden references
 + refs.h: implement `hidden_refs_to_excludes()`
 + refs.h: let `for_each_namespaced_ref()` take excluded patterns
 + revision.h: store hidden refs in a `strvec`
 + refs/packed-backend.c: add trace2 counters for jump list
 + refs/packed-backend.c: implement jump lists to avoid excluded pattern(s)
 + refs/packed-backend.c: refactor `find_reference_location()`
 + refs: plumb `exclude_patterns` argument throughout
 + builtin/for-each-ref.c: add `--exclude` option
 + ref-filter.c: parameterize match functions over patterns
 + ref-filter: add `ref_filter_clear()`
 + ref-filter: clear reachable list pointers after freeing
 + ref-filter.h: provide `REF_FILTER_INIT`
 + refs.c: rename `ref_filter`

 Enumerating refs in the packed-refs file, while excluding refs that
 match certain patterns, has been optimized.

 Will merge to 'master'.
 source: <cover.1689023520.git.me@ttaylorr.com>


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

 source: <20230602102533.876905-1-christian.couder@gmail.com>
