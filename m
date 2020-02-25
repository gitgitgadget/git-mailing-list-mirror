Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F008C4BA04
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 22:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F0321927
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 22:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AH9w+Hwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgBYWyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:54:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52488 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBYWyc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 17:54:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5074C5B25C;
        Tue, 25 Feb 2020 17:54:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=I
        Ws/o/9qlitxM6NHZyjYcP0W/HQ=; b=AH9w+HwgGZBehSGeKx7CZJIlrcB7bRrJ/
        qzmKDGRS59r0Qi6/1NFAK8rwW64J/I40i1RGq2Tue2A3Leyq9v4MshztQBYJINNy
        vhEUeymxHREirnkeNlT0LFnVhoYrS7oRGr6kiT4odrfBIZpVsZbMx02p8sUF/6f7
        SZiijw+v9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=fb0
        aHWTSTc/13q+Art3rdh8h/SF4Qzk/3Ja0/hqyhr2RfccxTNHRvhrN0vU9E/flSYI
        3JWNc1wr1yDtFs9KVrOiBXkV/uKCjXESAS+KNKkqLo09sjrP/LYtPMvKIrKE2jlP
        TwopL/sW7UdL5oqpKxJtYjbRwZ4HiCx7d17D50fA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4799B5B25B;
        Tue, 25 Feb 2020 17:54:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 949B25B25A;
        Tue, 25 Feb 2020 17:54:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2020, #05; Tue, 25)
X-master-at: 2d2118b814c11f509e1aa76cb07110f7231668dc
X-next-at: 5900a2a8f925f2c0ac44ac71f8d2c1959bdec53b
Date:   Tue, 25 Feb 2020 14:54:20 -0800
Message-ID: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2F50230-5821-11EA-9A6C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bw/remote-rename-update-config (2020-02-10) 6 commits
  (merged to 'next' on 2020-02-14 at 30b1a477de)
 + remote rename/remove: gently handle remote.pushDefault config
 + config: provide access to the current line number
 + remote rename/remove: handle branch.<name>.pushRemote config values
 + remote: clean-up config callback
 + remote: clean-up by returning early to avoid one indentation
 + pull --rebase/remote rename: document and honor single-letter abbreviations rebase types

 "git remote rename X Y" needs to adjust configuration variables
 (e.g. branch.<name>.remote) whose value used to be X to Y.
 branch.<name>.pushRemote is now also updated.


* es/bright-colors (2020-02-11) 3 commits
  (merged to 'next' on 2020-02-14 at cc17dbc7e8)
 + color.c: alias RGB colors 8-15 to aixterm colors
 + color.c: support bright aixterm colors
 + color.c: refactor color_output arguments

 The basic 7 colors learned the brighter counterparts
 (e.g. "brightred").


* es/doc-mentoring (2020-02-14) 2 commits
  (merged to 'next' on 2020-02-17 at e3f3e316eb)
 + MyFirstContribution: rephrase contact info
  (merged to 'next' on 2020-02-05 at 3b05aabbcd)
 + MyFirstContribution: add avenues for getting help

 Doc for new contributors.

--------------------------------------------------
[New Topics]

* am/mingw-poll-fix (2020-02-18) 1 commit
 - mingw: workaround for hangs when sending STDIN

 MinGW's poll() emulation has been improved.

 Needs review by Windows folks.


* en/check-ignore (2020-02-18) 1 commit
  (merged to 'next' on 2020-02-22 at f05a752211)
 + check-ignore: fix documentation and implementation to match

 "git check-ignore" did not work when the given path is explicitly
 marked as not ignored with a negative entry in the .gitignore file.

 Will merge to 'master'.


* en/t3433-rebase-stat-dirty-failure (2020-02-19) 2 commits
  (merged to 'next' on 2020-02-25 at 000d596d4c)
 + merge-recursive: fix the refresh logic in update_file_flags
 + t3433: new rebase testcase documenting a stat-dirty-like failure

 The merge-recursive machinery failed to refresh the cache entry for
 a merge result in a couple of places, resulting in an unnecessary
 merge failure, which has been fixed.

 Will merge to 'master'.


* jk/doc-diff-parallel (2020-02-18) 1 commit
  (merged to 'next' on 2020-02-19 at 62b2264fca)
 + doc-diff: use single-colon rule in rendering Makefile

 Update to doc-diff.

 Will merge to 'master'.


* jk/push-option-doc-markup-fix (2020-02-18) 1 commit
  (merged to 'next' on 2020-02-19 at 975e00fa99)
 + doc/config/push: use longer "--" line for preformatted example

 Doc markup fix.

 Will merge to 'master'.


* ak/test-log-graph (2020-02-24) 2 commits
  (merged to 'next' on 2020-02-25 at 2b68666ffa)
 + lib-log-graph: consolidate colored graph cmp logic
 + lib-log-graph: consolidate test_cmp_graph logic

 Test update.

 Will merge to 'master'.


* ds/partial-clone-fixes (2020-02-22) 2 commits
  (merged to 'next' on 2020-02-25 at a26434bb7a)
 + partial-clone: avoid fetching when looking for objects
 + partial-clone: demonstrate bugs in partial fetch

 Fix for a bug revealed by a recent change to make the protocol v2
 the default.

 Will merge to 'master'.


* pb/am-show-current-patch (2020-02-20) 5 commits
 - am: support --show-current-patch=diff to retrieve .git/rebase-apply/patch
 - am: support --show-current-patch=raw as a synonym for--show-current-patch
 - am: convert "resume" variable to a struct
 - parse-options: convert "command mode" to a flag
 - parse-options: add testcases for OPT_CMDMODE()

 "git am --short-current-patch" is a way to show the piece of e-mail
 for the stopped step, which is not suitable to directly feed "git
 apply" (it is designed to be a good "git am" input).  It learned a
 new option to show only the patch part.


* bc/wildcard-credential (2020-02-20) 5 commits
  (merged to 'next' on 2020-02-25 at ba3706cb90)
 + credential: allow wildcard patterns when matching config
 + credential: use the last matching username in the config
 + t0300: add tests for some additional cases
 + t1300: add test for urlmatch with multiple wildcards
 + mailmap: add an additional email address for brian m. carlson

 A configuration element used for credential subsystem can now use
 wildcard pattern to specify for which set of URLs the entry
 applies.

 Will merge to 'master'.


* es/recursive-single-branch-clone (2020-02-25) 2 commits
 - clone: pass --single-branch during --recurse-submodules
 - submodule--helper: use C99 named initializer

 "git clone --recurse-submodules --single-branch" now uses the same
 simgle-branch option when cloning the submodules.

 Will merge to 'next'.


* jc/describe-misnamed-annotated-tag (2020-02-20) 1 commit
 - describe: force long format for a name based on a mislocated tag

 When "git describe C" finds an annotated tag with tagname A to be
 the best name to explain commit C, and the tag is stored in a
 "wrong" place in the refs/tags hierarchy, e.g. refs/tags/B, the
 command gave a warning message but used A (not B) to describe C.
 If C is exactly at the tag, the desribe output would be "A", but
 "git rev-parse A^0" would not be equal as "git rev-parse C^0".  The
 behaviour of the command has been changed to use the "long" form
 i.e. A-0-gOBJECTNAME, which is correctly interpreted by rev-parse.


* jk/run-command-formatfix (2020-02-22) 1 commit
  (merged to 'next' on 2020-02-25 at 39ad6eeb86)
 + run-command.h: fix mis-indented struct member

 Code style cleanup.

 Will merge to 'master'.


* jn/reftable-doc (2020-02-22) 1 commit
  (merged to 'next' on 2020-02-25 at e128adbaf6)
 + reftable: file format documentation

 Doc update, in preparation for adding the reftable feature.

 Will merge to 'master'.


* pb/recurse-submodules-fix (2020-02-19) 6 commits
 - t/lib-submodule-update: add test removing nested submodules
 - unpack-trees: check for missing submodule directory in merged_entry
 - unpack-trees: remove outdated description for verify_clean_submodule
 - t/lib-submodule-update: move a test to the right section
 - t/lib-submodule-update: remove outdated test description
 - t7112: remove mention of KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED


* rj/t1050-use-test-path-is-file (2020-02-24) 1 commit
 - t1050: replace test -f with test_path_is_file

 Code cleanup.

 Almost there.


* bc/sha-256-part-1-of-4 (2020-02-25) 25 commits
 - SQUASH???
 - fast-import: add options for rewriting submodules
 - fast-import: add a generic function to iterate over marks
 - fast-import: make find_marks work on any mark set
 - fast-import: add helper function for inserting mark object entries
 - fast-import: permit reading multiple marks files
 - tag: store SHA-256 signatures in a header
 - gpg-interface: improve interface for parsing tags
 - commit: use expected signature header for SHA-256
 - worktree: allow repository version 1
 - init-db: move writing repo version into a function
 - builtin/init-db: add environment variable for new repo hash
 - builtin/init-db: allow specifying hash algorithm on command line
 - setup: allow check_repository_format to read repository format
 - t/helper: make repository tests hash independent
 - t/helper: initialize repository if necessary
 - t/helper/test-dump-split-index: initialize git repository
 - t6300: make hash algorithm independent
 - t6300: abstract away SHA-1-specific constants
 - t: use hash-specific lookup tables to define test constants
 - repository: require a build flag to use SHA-256
 - hex: add functions to parse hex object IDs in any algorithm
 - hex: introduce parsing variants taking hash algorithms
 - hash: implement and use a context cloning function
 - builtin/pack-objects: make hash agnostic


* es/do-not-let-rebase-switch-to-protected-branch (2020-02-24) 2 commits
 - rebase: refuse to switch to branch already checked out elsewhere
 - t3400: make test clean up after itself

 "git rebase BASE BRANCH" rebased/updated the tip of BRANCH and
 checked it out, even when the BRANCH is checked out in a different
 worktree.  This has been corrected.

 Will merge to 'next'.


* es/worktree-avoid-duplication-fix (2020-02-24) 3 commits
  (merged to 'next' on 2020-02-25 at 74c612837a)
 + worktree: don't allow "add" validation to be fooled by suffix matching
 + worktree: add utility to find worktree by pathname
 + worktree: improve find_worktree() documentation

 "git worktree add" used to get confused that the director to be
 used to add a new worktreey, when given as a relative path, is
 different from an existing one.  This has been corrected.

 Will merge to 'master'.


* es/worktree-cleanup (2020-02-24) 1 commit
  (merged to 'next' on 2020-02-25 at 59bc458bcd)
 + worktree: drop unused code from get_main_worktree()

 Code cleanup.

 Will merge to 'master'.


* hv/receive-denycurrent-everywhere (2020-02-24) 3 commits
  (merged to 'next' on 2020-02-25 at 84e35c4980)
 + receive.denyCurrentBranch: respect all worktrees
 + t5509: use a bare repository for test push target
 + get_main_worktree(): allow it to be called in the Git directory

 "git push" should stop from updating a branch that is checked out
 when receive.denyCurrentBranch configuration is set, but it failed
 to pay attention to checkouts in secondary worktrees.  This has
 been corrected.

 Will merge to 'master'.


* jk/nth-packed-object-id (2020-02-24) 10 commits
 - packfile: drop nth_packed_object_sha1()
 - packed_object_info(): use object_id internally for delta base
 - packed_object_info(): use object_id for returning delta base
 - pack-check: push oid lookup into loop
 - pack-check: convert "internal error" die to a BUG()
 - pack-bitmap: use object_id when loading on-disk bitmaps
 - pack-objects: use object_id struct in pack-reuse code
 - pack-objects: convert oe_set_delta_ext() to use object_id
 - pack-objects: read delta base oid into object_id struct
 - nth_packed_object_oid(): use customary integer return

 Code cleanup to use "struct object_id" more by replacing use of
 "char *sha1"

 Will merge to 'next'.


* kk/complete-diff-color-moved (2020-02-24) 1 commit
 - completion: add diff --color-moved[-ws]

 Completion update.

 Will merge to 'next'.


* ma/test-cleanup (2020-02-24) 3 commits
  (merged to 'next' on 2020-02-25 at ce00c705a9)
 + t: drop debug `cat` calls
 + t9810: drop debug `cat` call
 + t4117: check for files using `test_path_is_file`

 Code cleanup.

 Will merge to 'master'.


* rs/blame-typefix-for-fingerprint (2020-02-24) 1 commit
  (merged to 'next' on 2020-02-25 at 496309f50a)
 + blame: provide type of fingerprints pointer

 Code cleanup.

 Will merge to 'master'.


* rs/micro-cleanups (2020-02-24) 2 commits
  (merged to 'next' on 2020-02-25 at eaa8fd097b)
 + use strpbrk(3) to search for characters from a given set
 + quote: use isalnum() to check for alphanumeric characters

 Code cleanup.

 Will merge to 'master'.


* be/describe-multiroot (2020-02-25) 1 commit
 - describe: dont abort too early when searching tags

 "git describe" in a repository with multiple root commits sometimes
 gave up looking for the best tag to describe a given commit with
 too early, which has been adjusted.

--------------------------------------------------
[Stalled]

* pw/advise-rebase-skip (2019-12-06) 9 commits
 - rebase -i: leave CHERRY_PICK_HEAD when there are conflicts
 - rebase: fix advice when a fixup creates an empty commit
 - commit: give correct advice for empty commit during a rebase
 - commit: encapsulate determine_whence() for sequencer
 - commit: use enum value for multiple cherry-picks
 - sequencer: write CHERRY_PICK_HEAD for reword and edit
 - cherry-pick: check commit error messages
 - cherry-pick: add test for `--skip` advice in `git commit`
 - t3404: use test_cmp_rev

 The mechanism to prevent "git commit" from making an empty commit
 or amending during an interrupted cherry-pick was broken during the
 rewrite of "git rebase" in C, which has been corrected.

 What's the status of this one?
 The tip two are still RFC.
 cf. <CABPp-BE_ktNmDB43N_qijzYzhXvsK8Fi7TJQ7goHu+MzGvdpBQ@mail.gmail.com>


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

* jk/object-filter-with-bitmap (2020-02-18) 16 commits
  (merged to 'next' on 2020-02-19 at d38487e23d)
 + rev-list --count: comment on the use of count_right++
  (merged to 'next' on 2020-02-16 at 42425c3658)
 + pack-objects: support filters with bitmaps
 + pack-bitmap: implement BLOB_LIMIT filtering
 + pack-bitmap: implement BLOB_NONE filtering
 + bitmap: add bitmap_unset() function
 + rev-list: use bitmap filters for traversal
 + pack-bitmap: basic noop bitmap filter infrastructure
 + rev-list: allow commit-only bitmap traversals
 + t5310: factor out bitmap traversal comparison
 + rev-list: allow bitmaps when counting objects
 + rev-list: make --count work with --objects
 + rev-list: factor out bitmap-optimized routines
 + pack-bitmap: refuse to do a bitmap traversal with pathspecs
 + rev-list: fallback to non-bitmap traversal when filtering
 + pack-bitmap: fix leak of haves/wants object lists
 + pack-bitmap: factor out type iterator initialization

 The object reachability bitmap machinery and the partial cloning
 machinery were not prepared to work well together, because some
 object-filtering criteria partial clones use inherently rely on
 object traversal, but the bitmap machinery is an optimization to
 bypass that object traversal.  There however are some cases that
 they can work together, and they were taught about this case.

 Will merge to 'master'.


* hw/advise-ng (2020-02-25) 3 commits
 - tag: use new advice API to check visibility
 - advice: revamp advise API
 - advice: extract vadvise() from advise()

 Revamping of the advise API to allow more systematic enumeration of
 advice knobs in the future.

 Getting there, but not quite.


* ds/sparse-add (2020-02-20) 5 commits
  (merged to 'next' on 2020-02-25 at de68d14e77)
 + sparse-checkout: allow one-character directories in cone mode
  (merged to 'next' on 2020-02-14 at 3799757bbe)
 + sparse-checkout: work with Windows paths
 + sparse-checkout: create 'add' subcommand
 + sparse-checkout: extract pattern update from 'set' subcommand
 + sparse-checkout: extract add_patterns_from_input()

 "git sparse-checkout" learned a new "add" subcommand.

 Will merge to 'master'.


* at/rebase-fork-point-regression-fix (2020-02-11) 1 commit
 - rebase: --fork-point regression fix

 The "--fork-point" mode of "git rebase" regressed when the command
 was rewritten in C back in 2.20 era, which has been corrected.

 Was waiting for discussion to settle.
 cf. <CAPig+cQ-3Ds41hr91fRo_GvuFMTP7zNVJtaSqi-Yccq4Pk-8Qg@mail.gmail.com>
 cf. <xmqq36dtwcvw.fsf@gitster-ct.c.googlers.com>


* hn/reftable (2020-02-18) 5 commits
 . Reftable support for git-core
 . Add reftable library
 . refs: document how ref_iterator_advance_fn should handle symrefs
 . create .git/refs in files-backend.c
 . refs.h: clarify reflog iteration order

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 Temporarily ejected as this unfortunately conflicts with the
 SHA-256 topic.


* es/bugreport (2020-02-20) 15 commits
 - bugreport: summarize contents of alternates file
 - bugreport: list contents of $OBJDIR/info
 - bugreport: add packed object summary
 - bugreport: count loose objects
 - bugreport: collect list of populated hooks
 - bugreport: add config values from safelist
 - bugreport: generate config safelist based on docs
 - bugreport: include user interactive shell
 - bugreport: add git-remote-https version
 - bugreport: add compiler info
 - bugreport: add uname info
 - bugreport: gather git version and build info
 - bugreport: add tool to generate debugging info
 - help: add shell-path to --build-options
 - help: move list_config_help to builtin/help

 The "bugreport" tool.


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


* mr/bisect-in-c-1 (2020-02-19) 12 commits
  (merged to 'next' on 2020-02-25 at 7e9e7950fd)
 + bisect: libify `bisect_next_all`
 + bisect: libify `handle_bad_merge_base` and its dependents
 + bisect: libify `check_good_are_ancestors_of_bad` and its dependents
 + bisect: libify `check_merge_bases` and its dependents
 + bisect: libify `bisect_checkout`
 + bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and its dependents
 + bisect--helper: return error codes from `cmd_bisect__helper()`
 + bisect: add enum to represent bisect returning codes
 + bisect--helper: introduce new `decide_next()` function
 + bisect: use the standard 'if (!var)' way to check for 0
 + bisect--helper: change `retval` to `res`
 + bisect--helper: convert `vocab_*` char pointers to char arrays

 Underlying machinery of "git bisect--helper" is being refactored
 into pieces that are more easily reused.

 Will merge to 'master'.


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
 made its performance characteristics exponential wrt the depth of
 the tree, which was corrected.

 Expecting an update.
 cf. <CABPp-BEnt4C_7XyxQKxk4aga=JjM9fXCE-7SFp7azO_v5-pQYw@mail.gmail.com>
 cf. <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
 cf. <CABPp-BF0SO92wxY-dM14Vxv6BGA5=T=CicdwbiaZ7c9w6-j2jQ@mail.gmail.com>


* tb/commit-graph-split-merge (2020-02-12) 3 commits
 - builtin/commit-graph.c: support '--input=none'
 - builtin/commit-graph.c: introduce '--input=<source>'
 - builtin/commit-graph.c: support '--split[=<strategy>]'

 The code to write out the commit-graph has been taught a few
 options to control if the resulting graph chains should be merged
 or a single new incremental graph is created.

 Waiting for the discussion to settle.
 cf. <20200212205028.GE4364@syl.local>


* am/pathspec-f-f-more (2020-02-19) 8 commits
 - stash push: support the --pathspec-from-file option
 - stash: eliminate crude option parsing
 - doc: stash: synchronize <pathspec> description
 - doc: stash: document more options
 - doc: stash: split options from description (2)
 - doc: stash: split options from description (1)
 - rm: support the --pathspec-from-file option
 - doc: rm: synchronize <pathspec> description

 "git rm" and "git stash" learns the new "--pathspec-from-file"
 option.


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


* yz/p4-py3 (2020-02-13) 14 commits
 - ci: use python3 in linux-gcc and osx-gcc and python2 elsewhere
 - git-p4: use python3's input() everywhere
 - git-p4: simplify regex pattern generation for parsing diff-tree
 - git-p4: use dict.items() iteration for python3 compatibility
 - git-p4: use functools.reduce instead of reduce
 - git-p4: fix freezing while waiting for fast-import progress
 - git-p4: use marshal format version 2 when sending to p4
 - git-p4: open .gitp4-usercache.txt in text mode
 - git-p4: convert path to unicode before processing them
 - git-p4: encode/decode communication with git for python3
 - git-p4: encode/decode communication with p4 for python3
 - git-p4: remove string type aliasing
 - git-p4: change the expansion test from basestring to list
 - git-p4: make python2.7 the oldest supported version

 Update "git p4" to work with Python 3.

 Hold.
 Waiting for SoB from Szeder on the last step.
 cf. <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>


* en/rebase-backend (2020-02-16) 20 commits
  (merged to 'next' on 2020-02-22 at cae5eb0f18)
 + rebase: rename the two primary rebase backends
 + rebase: change the default backend from "am" to "merge"
 + rebase: make the backend configurable via config setting
 + rebase tests: repeat some tests using the merge backend instead of am
 + rebase tests: mark tests specific to the am-backend with --am
 + rebase: drop '-i' from the reflog for interactive-based rebases
 + git-prompt: change the prompt for interactive-based rebases
 + rebase: add an --am option
 + rebase: move incompatibility checks between backend options a bit earlier
 + git-rebase.txt: add more details about behavioral differences of backends
 + rebase: allow more types of rebases to fast-forward
 + t3432: make these tests work with either am or merge backends
 + rebase: fix handling of restrict_revision
 + rebase: make sure to pass along the quiet flag to the sequencer
 + rebase, sequencer: remove the broken GIT_QUIET handling
 + t3406: simplify an already simple test
 + rebase (interactive-backend): fix handling of commits that become empty
 + rebase (interactive-backend): make --keep-empty the default
 + t3404: directly test the behavior of interest
 + git-rebase.txt: update description of --allow-empty-message

 "git rebase" has learned to use the sequencer backend by default,
 while allowing "--am" option to go back to the traditional "am"
 backend.

 Will merge to 'master'.
 cf. <CABPp-BEnt4C_7XyxQKxk4aga=JjM9fXCE-7SFp7azO_v5-pQYw@mail.gmail.com>

--------------------------------------------------
[Discarded]

* mt/describe-misnamed-annotated-tag (2020-02-18) 1 commit
 . describe: output tag's ref instead of embedded name

 When "git describe C" finds an annotated tag with tagname A to be
 the best name to explain commit C, and the tag is stored in a
 "wrong" place in the refs/tags hierarchy, e.g. refs/tags/B, the
 command gave a warning message but used A (not B) to describe C.
 If C is exactly at the tag, the desribe output would be "A", but
 "git rev-parse A^0" would not be equal as "git rev-parse C^0".  The
 behaviour of the command has been changed to use "B" to describe C
 instead.

 This is not the only possible approach for the issue, and it is
 unknown if the proposed solution is the best one.
