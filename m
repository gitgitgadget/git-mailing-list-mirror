Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69871C1975A
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 00:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9102073E
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 00:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hH6HJYwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgCRAHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:07:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65382 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCRAHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 20:07:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8B49C793C;
        Tue, 17 Mar 2020 20:06:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=m
        QIDnO9DF3nbh4VFG6+XIRXbtYU=; b=hH6HJYwXIkKUGb6p+m7LSsDrDTS6E6qYk
        cGzt6bCP9JSrz+D9VyGxr/BtKsEJ59tiA735yZjGhRlUKfODs0xr37G9xyloa9l0
        peSxn9CQpISqMsYWQHmhr57cIx4XsXt0PSjIZAjHAQJ07QcKK55lN5LPpXxhTMZi
        tg3ABiK5zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=AUo
        jdtgi8Qz1YhqB0Ufl2clhmvAsdByeoi2y1sBQERvH8yypb4zAxntfItFXNqPcUpZ
        bX4aRQgSyWvO2I28ed+3fzTy70o4sKkpz1pFn9syj9+1hqhlil3DwcUY3v2wKvtj
        c05EN+FN1/Aqh/gstJkmAPyr/2jeAzEWY0j2umBI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E07FFC793B;
        Tue, 17 Mar 2020 20:06:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 30C43C7939;
        Tue, 17 Mar 2020 20:06:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2020, #05; Tue, 17)
X-master-at: be8661a3286c67a5d4088f4226cbd7f8b76544b0
X-next-at: afcc196a35dfc757a1018548c1f32afeb8a936d2
Date:   Tue, 17 Mar 2020 17:06:51 -0700
Message-ID: <xmqqlfnyh6g4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F618356-68AC-11EA-9414-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git 2.26-rc2 has been tagged.  Many fixes accumulated on the
'master' front have been flushed to 'maint' and has been tagged
as Git 2.25.2.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Stalled]

* dl/merge-autostash (2020-01-13) 17 commits
 - pull: pass --autostash to merge
 - t5520: make test_pull_autostash() accept expect_parent_num
 - merge: teach --autostash option
 - sequencer: unlink autostash in apply_autostash()
 - sequencer: extract perform_autostash() from rebase
 - rebase: generify create_autostash()
 - rebase: extract create_autostash()
 - reset: extract reset_head() from rebase
 - rebase: generify reset_head()
 - rebase: use apply_autostash() from sequencer.c
 - sequencer: make apply_rebase() accept a path
 - rebase: use read_oneliner()
 - sequencer: make read_oneliner() extern
 - sequencer: configurably warn on non-existent files
 - sequencer: use file strbuf for read_oneliner()
 - t7600: use test_write_lines()
 - Makefile: alphabetically sort += lists

 "git merge" learns the "--autostash" option.

 Expecting a reroll.
 cf. <20200123042906.GA29009@generichostname>


* bk/p4-pre-edit-changelist (2020-02-14) 7 commits
 - git-p4: add RCS keyword status message
 - git-p4: add p4 submit hooks
 - git-p4: restructure code in submit
 - git-p4: add --no-verify option
 - git-p4: add p4-pre-submit exit text
 - git-p4: create new function run_git_hook
 - git-p4: rewrite prompt to be Windows compatible

 "git p4" learned four new hooks and also "--no-verify" option to
 bypass them (and the existing "p4-pre-submit" hook).

 Waiting for response to RFH from Windows/Python folks.
 cf. <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>


* en/fill-directory-exponential (2020-01-31) 6 commits
 - t7063: blindly accept diffs
 - dir: replace exponential algorithm with a linear one
 - dir: refactor treat_directory to clarify control flow
 - dir: fix confusion based on variable tense
 - dir: fix broken comment
 - dir: consolidate treat_path() and treat_one_path()

 The directory traversal code had redundant recursive calls which
 made its performance characteristics exponential with respect to
 the depth of the tree, which was corrected.

 Expecting an update.
 cf. <CABPp-BEnt4C_7XyxQKxk4aga=JjM9fXCE-7SFp7azO_v5-pQYw@mail.gmail.com>
 cf. <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
 cf. <CABPp-BF0SO92wxY-dM14Vxv6BGA5=T=CicdwbiaZ7c9w6-j2jQ@mail.gmail.com>


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* sg/commit-slab-clarify-peek (2020-03-10) 1 commit
  (merged to 'next' on 2020-03-11 at 0496b26f23)
 + commit-slab: clarify slabname##_peek()'s return value

 In-code comment update.

 Will cook in 'next'.


* rs/doc-passthru-fetch-options (2020-03-11) 1 commit
  (merged to 'next' on 2020-03-12 at f08dab7228)
 + pull: document more passthru options

 Doc update.

 Will cook in 'next'.


* bc/filter-process (2020-03-16) 8 commits
  (merged to 'next' on 2020-03-17 at 2cd9dbf794)
 + t0021: test filter metadata for additional cases
 + builtin/reset: compute checkout metadata for reset
 + builtin/rebase: compute checkout metadata for rebases
 + builtin/clone: compute checkout metadata for clones
 + builtin/checkout: compute checkout metadata for checkouts
 + convert: provide additional metadata to filters
 + convert: permit passing additional metadata to filter processes
 + builtin/checkout: pass branch info down to checkout_worktree

 Provide more information (e.g. the object of the tree-ish in which
 the blob being converted appears, in addition to its path, which
 has already been given) to smudge/clean conversion filters.

 Will cook in 'next'.


* bc/faq (2020-03-15) 1 commit
 - docs: add a FAQ

 Doc update.


* ds/check-connected-reprepare-packed-git (2020-03-15) 1 commit
  (merged to 'next' on 2020-03-16 at 609a322030)
 + connected.c: reprepare packs for corner cases

 Corner case "git fetch" fix.

 Will cook in 'next'.


* en/oidset-uninclude-hashmap (2020-03-15) 1 commit
  (merged to 'next' on 2020-03-16 at a79879866d)
 + oidset: remove unnecessary include

 Code clean-up.

 Will cook in 'next'.


* jc/log-no-mailmap (2020-03-16) 3 commits
 - log: give --[no-]use-mailmap a more sensible synonym --[no-]mailmap
 - clone: reorder --recursive/--recurse-submodules
 - parse-options: teach "git cmd -h" to show alias as alias

 "git log" learns "--[no-]mailmap" as a synonym to "--[no-]use-mailmap"


* yz/p4-py3 (2020-03-10) 14 commits
  (merged to 'next' on 2020-03-11 at 01ca57c2b2)
 + ci: use python3 in linux-gcc and osx-gcc and python2 elsewhere
 + git-p4: use python3's input() everywhere
 + git-p4: simplify regex pattern generation for parsing diff-tree
 + git-p4: use dict.items() iteration for python3 compatibility
 + git-p4: use functools.reduce instead of reduce
 + git-p4: fix freezing while waiting for fast-import progress
 + git-p4: use marshal format version 2 when sending to p4
 + git-p4: open .gitp4-usercache.txt in text mode
 + git-p4: convert path to unicode before processing them
 + git-p4: encode/decode communication with git for python3
 + git-p4: encode/decode communication with p4 for python3
 + git-p4: remove string type aliasing
 + git-p4: change the expansion test from basestring to list
 + git-p4: make python2.7 the oldest supported version

 Update "git p4" to work with Python 3.

 Will cook in 'next'.


* hi/gpg-prefer-check-signature (2020-03-15) 2 commits
  (merged to 'next' on 2020-03-17 at 2def2d9a7e)
 + gpg-interface: prefer check_signature() for GPG verification
 + t: increase test coverage of signature verification output

 The code to interface with GnuPG has been refactored.

 Will cook in 'next'.


* jc/maintain-doc (2020-03-09) 1 commit
  (merged to 'next' on 2020-03-09 at 7f1a754f60)
 + update how-to-maintain-git

 Doc update.

 Will cook in 'next'.


* am/real-path-fix (2020-03-10) 4 commits
  (merged to 'next' on 2020-03-11 at 1f843820a7)
 + get_superproject_working_tree(): return strbuf
 + real_path_if_valid(): remove unsafe API
 + real_path: remove unsafe API
 + set_git_dir: fix crash when used with real_path()

 The real_path() convenience function can easily be misused; with a
 bit of code refactoring in the callers' side, its use has been
 eliminated.

 Will cook in 'next'.


* tb/commit-graph-split-merge (2020-03-05) 3 commits
  (merged to 'next' on 2020-03-09 at f3aa7bb305)
 + builtin/commit-graph.c: support '--input=none'
 + builtin/commit-graph.c: introduce '--input=<source>'
 + builtin/commit-graph.c: support '--split[=<strategy>]'

 The code to write out the commit-graph has been taught a few
 options to control if the resulting graph chains should be merged
 or a single new incremental graph is created.

 Will cook in 'next'.


* ah/force-pull-rebase-configuration (2020-03-10) 1 commit
  (merged to 'next' on 2020-03-11 at c79dbbaf9c)
 + pull: warn if the user didn't say whether to rebase or to merge

 "git pull" learned to warn when no pull.rebase configuration
 exists, and neither --[no-]rebase nor --ff-only is given (which
 would result a merge).

 Will cook in 'next'.


* tg/retire-scripted-stash (2020-03-05) 2 commits
  (merged to 'next' on 2020-03-05 at 8e82eb9dec)
 + stash: remove the stash.useBuiltin setting
 + stash: get git_stash_config at the top level

 "git stash" has kept an escape hatch to use the scripted version
 for a few releases, which got stale.  It has been removed.

 Will cook in 'next'.
 cf. <20200306172913.GF1571684@cat>


* js/https-proxy-config (2020-03-05) 2 commits
  (merged to 'next' on 2020-03-09 at 8a06f8501d)
 + http: add environment variable support for HTTPS proxies
 + http: add client cert support for HTTPS proxies

 A handful of options to configure SSL when talking to proxies have
 been added.

 Will cook in 'next'.


* pw/advise-rebase-skip (2019-12-06) 7 commits
  (merged to 'next' on 2020-03-11 at 80386de756)
 + commit: give correct advice for empty commit during a rebase
 + commit: encapsulate determine_whence() for sequencer
 + commit: use enum value for multiple cherry-picks
 + sequencer: write CHERRY_PICK_HEAD for reword and edit
 + cherry-pick: check commit error messages
 + cherry-pick: add test for `--skip` advice in `git commit`
 + t3404: use test_cmp_rev

 The mechanism to prevent "git commit" from making an empty commit
 or amending during an interrupted cherry-pick was broken during the
 rewrite of "git rebase" in C, which has been corrected.

 Will cook in 'next'.
 cf. <xmqq7e0e7d9z.fsf@gitster-ct.c.googlers.com>


* at/rebase-fork-point-regression-fix (2020-02-11) 1 commit
  (merged to 'next' on 2020-03-02 at a1a84d37a7)
 + rebase: --fork-point regression fix

 The "--fork-point" mode of "git rebase" regressed when the command
 was rewritten in C back in 2.20 era, which has been corrected.

 Will cook in 'next'.


* jc/describe-misnamed-annotated-tag (2020-02-20) 1 commit
  (merged to 'next' on 2020-03-02 at b4e2ca6a46)
 + describe: force long format for a name based on a mislocated tag

 When "git describe C" finds an annotated tag with tagname A to be
 the best name to explain commit C, and the tag is stored in a
 "wrong" place in the refs/tags hierarchy, e.g. refs/tags/B, the
 command gave a warning message but used A (not B) to describe C.
 If C is exactly at the tag, the describe output would be "A", but
 "git rev-parse A^0" would not be equal as "git rev-parse C^0".  The
 behavior of the command has been changed to use the "long" form
 i.e. A-0-gOBJECTNAME, which is correctly interpreted by rev-parse.

 Will cook in 'next'.


* pb/recurse-submodules-fix (2020-02-19) 6 commits
  (merged to 'next' on 2020-03-17 at b46922ddd1)
 + t/lib-submodule-update: add test removing nested submodules
 + unpack-trees: check for missing submodule directory in merged_entry
 + unpack-trees: remove outdated description for verify_clean_submodule
 + t/lib-submodule-update: move a test to the right section
 + t/lib-submodule-update: remove outdated test description
 + t7112: remove mention of KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED

 Fix "git checkout --recurse-submodules" of a nested submodule
 hierarchy.

 Will cook in 'next'.


* bc/sha-256-part-1-of-4 (2020-02-28) 22 commits
  (merged to 'next' on 2020-03-17 at 436c4e64a7)
 + fast-import: add options for rewriting submodules
 + fast-import: add a generic function to iterate over marks
 + fast-import: make find_marks work on any mark set
 + fast-import: add helper function for inserting mark object entries
 + fast-import: permit reading multiple marks files
 + commit: use expected signature header for SHA-256
 + worktree: allow repository version 1
 + init-db: move writing repo version into a function
 + builtin/init-db: add environment variable for new repo hash
 + builtin/init-db: allow specifying hash algorithm on command line
 + setup: allow check_repository_format to read repository format
 + t/helper: make repository tests hash independent
 + t/helper: initialize repository if necessary
 + t/helper/test-dump-split-index: initialize git repository
 + t6300: make hash algorithm independent
 + t6300: abstract away SHA-1-specific constants
 + t: use hash-specific lookup tables to define test constants
 + repository: require a build flag to use SHA-256
 + hex: add functions to parse hex object IDs in any algorithm
 + hex: introduce parsing variants taking hash algorithms
 + hash: implement and use a context cloning function
 + builtin/pack-objects: make hash agnostic

 SHA-256 transition continues.

 Will cook in 'next'.


* hw/advise-ng (2020-03-05) 4 commits
  (merged to 'next' on 2020-03-09 at ea9e5a1fa3)
 + tag: use new advice API to check visibility
 + advice: revamp advise API
 + advice: change "setupStreamFailure" to "setUpstreamFailure"
 + advice: extract vadvise() from advise()

 Revamping of the advise API to allow more systematic enumeration of
 advice knobs in the future.

 Will cook in 'next'.


* hn/reftable (2020-02-26) 6 commits
 . Reftable support for git-core
 . Add reftable library
 . reftable: file format documentation
 . refs: document how ref_iterator_advance_fn should handle symrefs
 . create .git/refs in files-backend.c
 . refs.h: clarify reflog iteration order

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 Temporarily ejected as this unfortunately conflicts with the
 SHA-256 topic.


* es/bugreport (2020-03-06) 6 commits
 - SQUASH???
 - bugreport: add compiler info
 - bugreport: add uname info
 - bugreport: gather git version and build info
 - bugreport: add tool to generate debugging info
 - help: move list_config_help to builtin/help

 The "bugreport" tool.

 As the scope of the topic got trimmed, hopefully these early parts
 can be polished quickly enough to be merged down.


* gs/commit-graph-path-filter (2020-02-12) 12 commits
 - (bytesex breakage band-aid)
 - commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
 - revision.c: use Bloom filters to speed up path based revision walks
 - commit-graph: add --changed-paths option to write subcommand
 - commit-graph: reuse existing Bloom filters during write.
 - commit-graph: write Bloom filters to commit graph file
 - commit-graph: examine commits by generation number
 - commit-graph: examine changed-path objects in pack order
 - commit-graph: compute Bloom filters for changed paths
 - diff: halt tree-diff early after max_changes
 - bloom: core Bloom filter implementation for changed paths
 - commit-graph: use MAX_NUM_CHUNKS

 Introduce an extension to the commit-graph to make it efficient to
 check for the paths that were modified at each commit using Bloom
 filters.

 Will be rerolled with bytesex fixes squashed in.
 Breakage due to byte-order dependency reported.

--------------------------------------------------
[Discarded]

* jc/rebase-backend-keep-old-default (2020-03-10) 1 commit
 . rebase: do not switch the default to 'merge' just yet

 The "merge" backend of "git rebase" still has a few bugs and
 unexpected behaviour that need to be ironed out before it becomes
 the default.  Let's switch the default back to the "apply" backend
 for now.
