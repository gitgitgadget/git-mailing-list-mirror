Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C67CC3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29B520728
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tuUdetdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgCCWWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:22:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63009 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCWWA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 17:22:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 472C8CA66C;
        Tue,  3 Mar 2020 17:21:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=W
        pjpl5CBwplBXb5CuVUTiHjkK/s=; b=tuUdetdpLKcxYZ+vArqz2T1i4dBcB631N
        2Rabd3n5quy/QN9qpD1Z+fLR2neAe8nqv/dXxlvd4sws+xxt/+71a1D5pDjVxMED
        j1aQI7iG8Xi03eOC2AQu7WmDdO2IVVns5/+B++KWw7Bg/n8PkgKzy/E8prYReT1v
        oAGPa5CToI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=D+o
        71LDZDtR2ymDLTPw7Q/ReRq6LDtkVRsUOC4gw7ATt+q0JzxU0dlfms2AupxRpQV4
        kmaA7HcVmVgfxY75Z0uATZ6hS1jC8c37JxIAE1n6vaD4JL5h/jz/n6W1WdiM4r2d
        dTpmBYUVcL1Ve88zJFNe1SIV9OxL+/3Zv/0rixhI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E5DDCA66B;
        Tue,  3 Mar 2020 17:21:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38EDACA669;
        Tue,  3 Mar 2020 17:21:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2020, #01; Tue, 3)
X-master-at: 2f268890c2cd2f115424936bbee27f8269080e5e
X-next-at: 5e7596f4ac6ed24f8c8b715a297eeb8623e7c204
Date:   Tue, 03 Mar 2020 14:21:48 -0800
Message-ID: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60BD8B9C-5D9D-11EA-9985-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

2.26-rc0 is planned to happen tomorrow (see tinyurl.com/gitCal).
The set of remaining topics in 'next' has been shrinking and today
may be a good cut-off point to declare that anything that is not in
'next' isn't expected to ship with the 2.26 release, unless it is an
obvious regression fix.  That does not mean everything in 'next'
today will be in the release, either.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ak/test-log-graph (2020-02-24) 2 commits
  (merged to 'next' on 2020-02-25 at 2b68666ffa)
 + lib-log-graph: consolidate colored graph cmp logic
 + lib-log-graph: consolidate test_cmp_graph logic

 Test update.


* ds/partial-clone-fixes (2020-02-22) 2 commits
  (merged to 'next' on 2020-02-25 at a26434bb7a)
 + partial-clone: avoid fetching when looking for objects
 + partial-clone: demonstrate bugs in partial fetch

 Fix for a bug revealed by a recent change to make the protocol v2
 the default.


* en/check-ignore (2020-02-18) 1 commit
  (merged to 'next' on 2020-02-22 at f05a752211)
 + check-ignore: fix documentation and implementation to match

 "git check-ignore" did not work when the given path is explicitly
 marked as not ignored with a negative entry in the .gitignore file.


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

 "git rebase" has learned to use the merge backend (i.e. the
 machinery that drives "rebase -i") by default, while allowing
 "--apply" option to use the "apply" backend (e.g. the moral
 equivalent of "format-patch piped to am").  The rebase.backend
 configuration variable can be set to customize.


* en/t3433-rebase-stat-dirty-failure (2020-02-19) 2 commits
  (merged to 'next' on 2020-02-25 at 000d596d4c)
 + merge-recursive: fix the refresh logic in update_file_flags
 + t3433: new rebase testcase documenting a stat-dirty-like failure

 The merge-recursive machinery failed to refresh the cache entry for
 a merge result in a couple of places, resulting in an unnecessary
 merge failure, which has been fixed.


* es/worktree-cleanup (2020-02-24) 1 commit
  (merged to 'next' on 2020-02-25 at 59bc458bcd)
 + worktree: drop unused code from get_main_worktree()

 Code cleanup.


* jk/doc-diff-parallel (2020-02-18) 1 commit
  (merged to 'next' on 2020-02-19 at 62b2264fca)
 + doc-diff: use single-colon rule in rendering Makefile

 Update to doc-diff.


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
 object-filtering criteria that partial clones use inherently rely
 on object traversal, but the bitmap machinery is an optimization
 to bypass that object traversal.  There however are some cases
 where they can work together, and they were taught about them.


* jk/push-option-doc-markup-fix (2020-02-18) 1 commit
  (merged to 'next' on 2020-02-19 at 975e00fa99)
 + doc/config/push: use longer "--" line for preformatted example

 Doc markup fix.


* jk/run-command-formatfix (2020-02-22) 1 commit
  (merged to 'next' on 2020-02-25 at 39ad6eeb86)
 + run-command.h: fix mis-indented struct member

 Code style cleanup.


* ma/test-cleanup (2020-02-24) 3 commits
  (merged to 'next' on 2020-02-25 at ce00c705a9)
 + t: drop debug `cat` calls
 + t9810: drop debug `cat` call
 + t4117: check for files using `test_path_is_file`

 Code cleanup.


* rs/blame-typefix-for-fingerprint (2020-02-24) 1 commit
  (merged to 'next' on 2020-02-25 at 496309f50a)
 + blame: provide type of fingerprints pointer

 Code cleanup.


* rs/micro-cleanups (2020-02-24) 2 commits
  (merged to 'next' on 2020-02-25 at eaa8fd097b)
 + use strpbrk(3) to search for characters from a given set
 + quote: use isalnum() to check for alphanumeric characters

 Code cleanup.

--------------------------------------------------
[New Topics]

* ah/force-pull-rebase-configuration (2020-03-02) 1 commit
 . pull: warn if the user didn't say whether to rebase or to merge

 "git pull" learned to warn when no pull.rebase configuration
 exists, and neither --[no-]rebase nor --ff-only is given (which
 would result a merge).

 Needs to adjust some tests.


* hd/show-one-mergetag-fix (2020-03-02) 1 commit
  (merged to 'next' on 2020-03-02 at 12fe907f8d)
 + show_one_mergetag: print non-parent in hex form.

 "git show" and others gave an object name in raw format in its
 error output, which has been corrected to give it in hex.

 Will merge to 'master'.


* tg/retire-scripted-stash (2020-03-03) 2 commits
 - stash: remove the stash.useBuiltin setting
 - stash: get git_stash_config at the top level

 "git stash" has kept an escape hatch to use the scripted version
 for a few releases, which got stale.  It has been removed.

 Will merge to 'next'.


* es/outside-repo-errmsg-hints (2020-03-03) 1 commit
 - prefix_path: show gitdir if worktree unavailable

 An earlier update to show the location of working tree in the error
 message did not consider the possibility that a git command may be
 run in a bare repository, which has been corrected.

 May want a test or two.


* rs/show-progress-in-dumb-http-fetch (2020-03-03) 1 commit
 - remote-curl: show progress for fetches over dumb HTTP

 "git fetch" over HTTP walker protocol did not show any progress
 output.  We inherently do not know how much work remains, but still
 we can show something not to bore users.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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


* tb/commit-graph-split-merge (2020-02-12) 3 commits
 - builtin/commit-graph.c: support '--input=none'
 - builtin/commit-graph.c: introduce '--input=<source>'
 - builtin/commit-graph.c: support '--split[=<strategy>]'

 The code to write out the commit-graph has been taught a few
 options to control if the resulting graph chains should be merged
 or a single new incremental graph is created.

 Waiting for the discussion to settle.
 cf. <20200212205028.GE4364@syl.local>


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

* ag/rebase-remove-redundant-code (2020-02-26) 1 commit
  (merged to 'next' on 2020-02-27 at b1f5289b67)
 + builtin/rebase: remove a call to get_oid() on `options.switch_to'

 Code reduction.

 Will merge to 'master'.


* js/ci-windows-update (2020-02-27) 3 commits
  (merged to 'next' on 2020-02-27 at 691f1c929c)
 + Azure Pipeline: switch to the latest agent pools
 + ci: prevent `perforce` from being quarantined
 + t/lib-httpd: avoid using macOS' sed

 Updates to the CI settings.

 Will merge to 'master'.


* en/merge-path-collision (2020-02-27) 1 commit
  (merged to 'next' on 2020-03-02 at cb2655c779)
 + merge-recursive: apply collision handling unification to recursive case

 Handling of conflicting renames in merge-recursive have further
 been made consistent with how existing codepaths try to mimic what
 is done to add/add conflicts.

 Will merge to 'master'.


* en/test-cleanup (2020-02-27) 5 commits
  (merged to 'next' on 2020-03-02 at 93a81886b7)
 + t6020: new test with interleaved lexicographic ordering of directories
 + t6022, t6046: test expected behavior instead of testing a proxy for it
 + t3035: prefer test_must_fail to bash negation for git commands
 + t6020, t6022, t6035: update merge tests to use test helper functions
 + t602[1236], t6034: modernize test formatting

 Test cleanup.

 Will merge to 'master'.


* js/https-proxy-config (2020-02-27) 2 commits
 - config: documentation for HTTPS proxy client cert.
 - http: add client cert for HTTPS proxies.

 A handful of options to configure SSL when talking to proxies have
 been added.

 Not enough review.  Addition of on-disk key looks wrong.


* rs/commit-graph-code-simplification (2020-02-27) 1 commit
  (merged to 'next' on 2020-02-27 at f298c6ed49)
 + commit-graph: use progress title directly

 Code simplfication.

 Will merge to 'master'.


* jc/doc-single-h-is-for-help (2020-02-27) 1 commit
 - Documentation: clarify that `-h` alone stands for `help`

 Both "git ls-remote -h" and "git grep -h" give short usage help,
 like any other Git subcommand, but it is not unreasonable to expect
 that the former would behave the same as "git ls-remote --head"
 (there is no other sensible behaviour for the latter).  The
 documentation has been updated in an attempt to clarify this.


* hi/gpg-use-check-signature (2020-02-28) 1 commit
  (merged to 'next' on 2020-03-02 at 273fb30874)
 + Revert "gpg-interface: prefer check_signature() for GPG verification"

 "git merge signed-tag" while lacking the public key started to say
 "No signature", which was utterly wrong.  This regression has been
 reverted.

 Will merge to 'master'.


* rt/format-zero-length-fix (2020-02-28) 2 commits
  (merged to 'next' on 2020-03-02 at a4070ef573)
 + config.mak.dev: re-enable -Wformat-zero-length
 + rebase-interactive.c: silence format-zero-length warnings

 Recently we inadvertently added a few instances of using 0-width
 format string to functions that we mark as printf-like without any
 developers noticing.  The root cause was that the compiler warning
 that is triggered by this is almost always useless and we disabled
 the warning in our developer builds, but not for general public.
 The new instances have been corrected, and the warning has been
 resurrected in the developer builds.

 Will merge to 'master'.


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

 Will discard the tip two, which are still RFC, and advance the rest.
 cf. <xmqq7e0e7d9z.fsf@gitster-ct.c.googlers.com>


* at/rebase-fork-point-regression-fix (2020-02-11) 1 commit
  (merged to 'next' on 2020-03-02 at a1a84d37a7)
 + rebase: --fork-point regression fix

 The "--fork-point" mode of "git rebase" regressed when the command
 was rewritten in C back in 2.20 era, which has been corrected.

 Will merge to 'master'.
 Was waiting for a response to "shouldn't this be sufficient?" but
 I think it should.


* am/mingw-poll-fix (2020-02-27) 1 commit
  (merged to 'next' on 2020-03-02 at 7082619f34)
 + mingw: workaround for hangs when sending STDIN

 MinGW's poll() emulation has been improved.

 Will merge to 'master'.


* pb/am-show-current-patch (2020-02-20) 5 commits
  (merged to 'next' on 2020-03-02 at 30b5300705)
 + am: support --show-current-patch=diff to retrieve .git/rebase-apply/patch
 + am: support --show-current-patch=raw as a synonym for--show-current-patch
 + am: convert "resume" variable to a struct
 + parse-options: convert "command mode" to a flag
 + parse-options: add testcases for OPT_CMDMODE()

 "git am --short-current-patch" is a way to show the piece of e-mail
 for the stopped step, which is not suitable to directly feed "git
 apply" (it is designed to be a good "git am" input).  It learned a
 new option to show only the patch part.

 Will merge to 'master'.


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
  (merged to 'next' on 2020-02-27 at 8e8fcca7cd)
 + clone: pass --single-branch during --recurse-submodules
 + submodule--helper: use C99 named initializer

 "git clone --recurse-submodules --single-branch" now uses the same
 single-branch option when cloning the submodules.

 Will merge to 'master'.


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

 Will merge to 'master'.


* pb/recurse-submodules-fix (2020-02-19) 6 commits
 - t/lib-submodule-update: add test removing nested submodules
 - unpack-trees: check for missing submodule directory in merged_entry
 - unpack-trees: remove outdated description for verify_clean_submodule
 - t/lib-submodule-update: move a test to the right section
 - t/lib-submodule-update: remove outdated test description
 - t7112: remove mention of KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED


* rj/t1050-use-test-path-is-file (2020-02-24) 1 commit
  (merged to 'next' on 2020-03-02 at 68a681640e)
 + t1050: replace test -f with test_path_is_file

 Code cleanup.

 Will merge to 'master'.


* bc/sha-256-part-1-of-4 (2020-02-28) 22 commits
 - fast-import: add options for rewriting submodules
 - fast-import: add a generic function to iterate over marks
 - fast-import: make find_marks work on any mark set
 - fast-import: add helper function for inserting mark object entries
 - fast-import: permit reading multiple marks files
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

 SHA-256 transition continues.

 Tentatively I dropped the bits about signed tag, as it depended on
 a reverted change to the gpg interface API.


* es/do-not-let-rebase-switch-to-protected-branch (2020-02-24) 2 commits
  (merged to 'next' on 2020-02-27 at 4b0009b609)
 + rebase: refuse to switch to branch already checked out elsewhere
 + t3400: make test clean up after itself

 "git rebase BASE BRANCH" rebased/updated the tip of BRANCH and
 checked it out, even when the BRANCH is checked out in a different
 worktree.  This has been corrected.

 Will merge to 'master'.


* es/worktree-avoid-duplication-fix (2020-02-24) 3 commits
  (merged to 'next' on 2020-02-25 at 74c612837a)
 + worktree: don't allow "add" validation to be fooled by suffix matching
 + worktree: add utility to find worktree by pathname
 + worktree: improve find_worktree() documentation

 In rare cases "git worktree add <path>" could think that <path>
 was already a registered worktree even when it wasn't and refuse
 to add the new worktree. This has been corrected.

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
  (merged to 'next' on 2020-02-27 at 8f1e796030)
 + packfile: drop nth_packed_object_sha1()
 + packed_object_info(): use object_id internally for delta base
 + packed_object_info(): use object_id for returning delta base
 + pack-check: push oid lookup into loop
 + pack-check: convert "internal error" die to a BUG()
 + pack-bitmap: use object_id when loading on-disk bitmaps
 + pack-objects: use object_id struct in pack-reuse code
 + pack-objects: convert oe_set_delta_ext() to use object_id
 + pack-objects: read delta base oid into object_id struct
 + nth_packed_object_oid(): use customary integer return

 Code cleanup to use "struct object_id" more by replacing use of
 "char *sha1"

 Will merge to 'master'.


* kk/complete-diff-color-moved (2020-02-24) 1 commit
  (merged to 'next' on 2020-03-02 at 1bdb401f6a)
 + completion: add diff --color-moved[-ws]

 Completion update.

 Will merge to 'master'.


* be/describe-multiroot (2020-02-26) 1 commit
  (merged to 'next' on 2020-02-27 at b476663ffc)
 + describe: don't abort too early when searching tags

 "git describe" in a repository with multiple root commits sometimes
 gave up looking for the best tag to describe a given commit with
 too early, which has been adjusted.

 Will merge to 'master'.


* hw/advise-ng (2020-03-02) 5 commits
 - tag: use new advice API to check visibility
 - SQUASH???
 - advice: revamp advise API
 - advice: change "setupStreamFailure" to "setUpstreamFailure"
 - advice: extract vadvise() from advise()

 Revamping of the advise API to allow more systematic enumeration of
 advice knobs in the future.


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


* es/bugreport (2020-03-02) 5 commits
 - bugreport: add compiler info
 - bugreport: add uname info
 - bugreport: gather git version and build info
 - bugreport: add tool to generate debugging info
 - help: move list_config_help to builtin/help

 The "bugreport" tool.

 This round has narrowed its scope significantly, and IMHO should be
 easier to review.


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


* am/pathspec-f-f-more (2020-02-19) 8 commits
  (merged to 'next' on 2020-03-02 at 33ff7e29f0)
 + stash push: support the --pathspec-from-file option
 + stash: eliminate crude option parsing
 + doc: stash: synchronize <pathspec> description
 + doc: stash: document more options
 + doc: stash: split options from description (2)
 + doc: stash: split options from description (1)
 + rm: support the --pathspec-from-file option
 + doc: rm: synchronize <pathspec> description

 "git rm" and "git stash" learns the new "--pathspec-from-file"
 option.

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

* mt/describe-misnamed-annotated-tag (2020-02-18) 1 commit
 . describe: output tag's ref instead of embedded name

 When "git describe C" finds an annotated tag with tagname A to be
 the best name to explain commit C, and the tag is stored in a
 "wrong" place in the refs/tags hierarchy, e.g. refs/tags/B, the
 command gave a warning message but used A (not B) to describe C.
 If C is exactly at the tag, the describe output would be "A", but
 "git rev-parse A^0" would not be equal as "git rev-parse C^0".  The
 behavior of the command has been changed to use "B" to describe C
 instead.

 This is not the only possible approach for the issue, and it is
 unknown if the proposed solution is the best one.


* jn/reftable-doc (2020-02-22) 1 commit
  (merged to 'next' on 2020-02-25 at e128adbaf6)
 + reftable: file format documentation

 Doc update, in preparation for adding the reftable feature.

 Let's take and polish this as a part of hn/reftable topic.
