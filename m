From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2015, #08; Mon, 23)
Date: Mon, 23 Mar 2015 14:35:57 -0700
Message-ID: <xmqqmw338khu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 22:36:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaA13-0002uI-4g
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 22:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbbCWVgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 17:36:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752214AbbCWVgA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 17:36:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8B1C42B7B;
	Mon, 23 Mar 2015 17:35:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=z
	DJtIJ/95Sa7p0LG13ohTe8MGAw=; b=wB/vneufYDaKzn27b2+nKOusOBfrAvFqb
	17xfbHM6Kw+N+bzWzm3ZHjQj22NoIYAHd/GqJeZGBtpHp2QuckVxJSJkpabeAyW+
	HYzTZEVa5b8kC8aZWzHMoQdoT+XbSM04Xq0rI9IUuo9jKQqK8Niqq+pRSz5V27Ht
	UV2HxVFqJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=fFq
	DWSo2/r73PDFRb01Hetk7dexv+yFXk489Nij1yQq+GG6tF4dc20Do2NfJP5zkpOf
	ZMwLc9DNQmaV5Q2v8ptp4q6Cei5lEdnuCba7NRYCQHWlMW4R8LFTid3sq0Me4Abe
	P4W25+gfu9rkIHTLPO+fDHLxPUWR2UW7F6t9yW7Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C183042B7A;
	Mon, 23 Mar 2015 17:35:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1A2342B77;
	Mon, 23 Mar 2015 17:35:58 -0400 (EDT)
X-master-at: f53fc38c083da1a1d14f54713ffd8fd0965a2194
X-next-at: b1122c2910374ef5dde8cb25b25be0abb1538aba
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98628852-D1A4-11E4-8717-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266165>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

This cycle is turning out to be a "shoot for product excellence"
release.  About half of the commits that have been merged to the
'master' so far have also been merged to 'maint' and v2.3.4 has been
tagged.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/push-config (2015-03-14) 4 commits
  (merged to 'next' on 2015-03-16 at 6452570)
 + push: allow --follow-tags to be set by config push.followTags
 + cmd_push: pass "flags" pointer to config callback
 + cmd_push: set "atomic" bit directly
 + git_push_config: drop cargo-culted wt_status pointer

 Restructure "git push" codepath to make it easier to add new
 configuration bits and then add push.followTags configuration that
 turns --follow-tags option on by default.


* jk/smart-http-hide-refs (2015-03-12) 2 commits
  (merged to 'next' on 2015-03-16 at 530df4c)
 + upload-pack: do not check NULL return of lookup_unknown_object
 + upload-pack: fix transfer.hiderefs over smart-http

 The transfer.hiderefs support did not quite work for smart-http
 transport.


* jk/tag-h-column-is-a-listing-option (2015-03-12) 1 commit
  (merged to 'next' on 2015-03-16 at 42b04c6)
 + tag: fix some mis-organized options in "-h" listing

 "git tag -h" used to show the "--column" and "--sort" options
 that are about listing in a wrong section.


* jk/test-annoyances (2015-03-12) 5 commits
  (merged to 'next' on 2015-03-16 at 845b091)
 + t5551: make EXPENSIVE test cheaper
 + t5541: move run_with_cmdline_limit to test-lib.sh
 + t: pass GIT_TRACE through Apache
 + t: redirect stderr GIT_TRACE to descriptor 4
 + t: translate SIGINT to an exit

 Test fixes.


* js/completion-ctags-pattern-substitution-fix (2015-03-14) 1 commit
  (merged to 'next' on 2015-03-17 at 4a68861)
 + contrib/completion: escape the forward slash in __git_match_ctag

 The code that reads from the ctags file in the completion script
 (in contrib/) did not spell ${param/pattern/string} substitution
 correctly, which happened to work with bash but not with zsh.


* nd/config-doc-camelCase (2015-03-13) 1 commit
  (merged to 'next' on 2015-03-16 at 0e3fedb)
 + *config.txt: stick to camelCase naming convention

 Documentation updates.

--------------------------------------------------
[New Topics]

* jc/diff-no-index-d-f (2015-03-22) 1 commit
 - align D/F handling of "diff --no-index" with that of normal Git

 The usual "git diff" when seeing a file turning into a directory
 showed a patchset to remove the file and create all files in the
 directory, but "git diff --no-index" simply refused to work.


* jk/run-command-capture (2015-03-22) 7 commits
  (merged to 'next' on 2015-03-23 at f6db88b)
 + run-command: forbid using run_command with piped output
 + trailer: use capture_command
 + submodule: use capture_command
 + wt-status: use capture_command
 + run-command: introduce capture_command helper
 + wt_status: fix signedness mismatch in strbuf_read call
 + wt-status: don't flush before running "submodule status"

 The run-command interface was easy to abuse and make a pipe for us
 to read from the process, wait for the process to finish and then
 attempt to read its output, which is a pattern that lead to a
 deadlock.  Fix such uses by introducing a helper to do this
 correctly (i.e. we need to read first and then wait the process to
 finish) and also add code to prevent such abuse in the run-command
 helper.

 Will merge to 'master'.


* tg/fix-check-order-with-split-index (2015-03-20) 1 commit
  (merged to 'next' on 2015-03-23 at c361f8e)
 + read-cache: fix reading of split index

 The split-index mode introduced at v2.3.0-rc0~41 was broken in the
 codepath to protect us against a broken reimplementation of Git
 that writes an invalid index with duplicated index entries, etc.

 Will merge to 'master'.


* ts/man-pdf (2015-03-20) 1 commit
 - Documentation: make 'make pdf' format manpages to PDF as well

 For offline consumption of manual pages, a target to produce one
 pdf document per manual page was added to Documentation/Makefile.

 Its usefulness is unknown, given that this does not produce a
 single document with all the manual pages in it, which would be not
 much better than keeping a bunch of HTML manual pages we already
 produce and use them instead for offline consumption.


* nd/diff-i-t-a (2015-03-23) 1 commit
 - diff-lib.c: adjust position of i-t-a entries in diff


* sb/leaks (2015-03-23) 9 commits
  (merged to 'next' on 2015-03-23 at 5397daf)
 + read-cache: fix memleak
 + add_to_index(): free unused cache-entry
 + commit.c: fix a memory leak
 + http-push: remove unneeded cleanup
 + merge-recursive: fix memleaks
 + merge-blobs.c: fix a memleak
 + builtin/apply.c: fix a memleak
 + update-index: fix a memleak
 + read-cache: free cache entry in add_to_index in case of early return

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* mh/fdopen-with-retry (2015-03-06) 6 commits
 - buffer_fdinit(): use fdopen_with_retry()
 - update_info_file(): use fdopen_with_retry()
 - copy_to_log(): use fdopen_with_retry()
 - fdopen_lock_file(): use fdopen_with_retry()
 - SQUASH??? $gmane/264889
 - xfdopen(): if first attempt fails, free memory and try again

 Various parts of the code where they call fdopen() can fail when
 they run out of memory; attempt to proceed by retrying the
 operation after freeing some resource.

 Waiting for further comments.


* nd/untracked-cache (2015-03-12) 24 commits
 - git-status.txt: advertisement for untracked cache
 - untracked cache: guard and disable on system changes
 - mingw32: add uname()
 - t7063: tests for untracked cache
 - update-index: test the system before enabling untracked cache
 - update-index: manually enable or disable untracked cache
 - status: enable untracked cache
 - untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
 - untracked cache: mark index dirty if untracked cache is updated
 - untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
 - untracked cache: avoid racy timestamps
 - read-cache.c: split racy stat test to a separate function
 - untracked cache: invalidate at index addition or removal
 - untracked cache: load from UNTR index extension
 - untracked cache: save to an index extension
 - ewah: add convenient wrapper ewah_serialize_strbuf()
 - untracked cache: don't open non-existent .gitignore
 - untracked cache: mark what dirs should be recursed/saved
 - untracked cache: record/validate dir mtime and reuse cached output
 - untracked cache: make a wrapper around {open,read,close}dir()
 - untracked cache: invalidate dirs recursively if .gitignore changes
 - untracked cache: initial untracked cache validation
 - untracked cache: record .gitignore information and dir hierarchy
 - dir.c: optionally compute sha-1 of a .gitignore file

 Need extra sets of eyes to review this.


* ak/stash-store-create-help (2015-01-13) 1 commit
 - stash: show "create" and "store" subcommands in usage-help

 Will discard.


* bp/diff-relative-config (2015-01-07) 2 commits
 - diff: teach diff.relative to give default to --relative=<value>
 - diff: teach --no-relative to override earlier --relative

 No comments?  No interests?


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 - remote: add --fetch and --both options to set-url

 Expecting a reroll.


* je/quiltimport-no-fuzz (2014-10-21) 2 commits
 - git-quiltimport: flip the default not to allow fuzz
 - git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".

 Tired of waiting for an Ack
 Will discard.


* tr/remerge-diff (2014-11-10) 9 commits
 - t4213: avoid "|" in sed regexp
 - log --remerge-diff: show what the conflict resolution changed
 - name-hash: allow dir hashing even when !ignore_case
 - merge-recursive: allow storing conflict hunks in index
 - merge_diff_mode: fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Waiting for a reroll ($gmane/256591).


* hv/submodule-config (2014-11-11) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* jk/cleanup-failed-clone (2015-03-19) 2 commits
  (merged to 'next' on 2015-03-23 at 1f26d93)
 + clone: drop period from end of die_errno message
 + clone: initialize atexit cleanup handler earlier

 An failure early in the "git clone" that started creating the
 working tree and repository could have resulted in some directories
 and files left without getting cleaned up.

 Will merge to 'master'.


* jk/fetch-pack (2015-03-19) 4 commits
  (merged to 'next' on 2015-03-23 at 4357f3d)
 + fetch-pack: remove dead assignment to ref->new_sha1
 + fetch_refs_via_pack: free extra copy of refs
 + filter_ref: make a copy of extra "sought" entries
 + filter_ref: avoid overwriting ref->old_sha1 with garbage

 "git fetch" that fetches a commit using the allow-tip-sha1-in-want
 extension could have failed to fetch all the requested refs.

 Will merge to 'master'.


* jk/prune-with-corrupt-refs (2015-03-20) 5 commits
  (merged to 'next' on 2015-03-23 at 68af8a9)
 + refs.c: drop curate_packed_refs
 + repack: turn on "ref paranoia" when doing a destructive repack
 + prune: turn on ref_paranoia flag
 + refs: introduce a "ref paranoia" flag
 + t5312: test object deletion code paths in a corrupted repository

 "git prune" used to largely ignore broken refs when deciding which
 objects are still being used, which could spread an existing small
 damage and make it a larger one.

 Will merge to 'master'.


* jk/simplify-csum-file-sha1fd-check (2015-03-19) 1 commit
  (merged to 'next' on 2015-03-20 at 6f6d1c2)
 + sha1fd_check: die when we cannot open the file

 Code simplification.

 Will merge to 'master'.


* mh/numparse (2015-03-19) 14 commits
 - diff_opt_parse(): use convert_i() when handling --abbrev=<num>
 - diff_opt_parse(): use convert_i() when handling "-l<num>"
 - opt_arg(): simplify pointer handling
 - opt_arg(): report errors parsing option values
 - opt_arg(): use convert_i() in implementation
 - opt_arg(): val is always non-NULL
 - builtin_diff(): detect errors when parsing --unified argument
 - handle_revision_opt(): use convert_ui() when handling "--abbrev="
 - strtoul_ui(), strtol_i(): remove functions
 - handle_revision_opt(): use convert_i() when handling "-<digit>"
 - handle_revision_opt(): use skip_prefix() in many places
 - write_subdirectory(): use convert_ui() for parsing mode
 - cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
 - numparse: new module for parsing integral numbers

 Many codepaths use unchecked use of strtol() and friends (or even
 worse, atoi()).  Introduce a set of wrappers that try to be more
 careful.


* tf/gitweb-project-listing (2015-03-19) 5 commits
 - gitweb: make category headings into links when they are directories
 - gitweb: optionally set project category from its pathname
 - gitweb: add a link under the search box to clear a project filter
 - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
 - gitweb: fix typo in man page

 Update gitweb to make it more pleasant to deal with a hierarchical
 forest of repositories.

 Any comments from those who use or have their own code in Gitweb?


* ws/grep-quiet-no-pager (2015-03-19) 1 commit
  (merged to 'next' on 2015-03-20 at b3f5fe6)
 + grep: fix "--quiet" overwriting current output

 Even though "git grep --quiet" is run merely to ask for the exit
 status, we spawned the pager regardless.  Stop doing that.

 Will merge to 'master'.


* kd/rev-list-bisect-first-parent (2015-03-19) 1 commit
  (merged to 'next' on 2015-03-20 at 5477bf5)
 + rev-list: refuse --first-parent combined with --bisect

 "git rev-list --bisect --first-parent" does not work (yet) and can
 even cause SEGV; forbid it.  "git log --bisect --first-parent"
 would not be useful until "git bisect --first-parent" materializes,
 so it is also forbidden for now.

 Will merge to 'master'.


* jk/test-chain-lint (2015-03-22) 28 commits
 - t6039: fix broken && chain
 - t9158, t9161: fix broken &&-chain in git-svn tests
 - t9104: fix test for following larger parents
 - t4104: drop hand-rolled error reporting
 - t0005: fix broken &&-chains
 - t7004: fix embedded single-quotes
 - t0050: appease --chain-lint
 - t9001: use test_when_finished
 - t4117: use modern test_* helpers
 - t6034: use modern test_* helpers
 - t1301: use modern test_* helpers
 - t0020: use modern test_* helpers
 - t6030: use modern test_* helpers
 - t9502: fix &&-chain breakage
 - t7201: fix &&-chain breakage
 - t3600: fix &&-chain breakage for setup commands
 - t: avoid using ":" for comments
 - t: wrap complicated expect_code users in a block
 - t: use test_expect_code instead of hand-rolled comparison
 - t: use test_might_fail for diff and grep
 - t: fix &&-chaining issues around setup which might fail
 - t: use test_must_fail instead of hand-rolled blocks
 - t: use verbose instead of hand-rolled errors
 - t: assume test_cmp produces verbose output
 - t: fix trivial &&-chain breakage
 - t: fix moderate &&-chain breakage
 - t: fix severe &&-chain breakage
 - t/test-lib: introduce --chain-lint option

 People often forget to chain the commands in their test together
 with &&, leaving a failure from an earlier command in the test go
 unnoticed.  The new GIT_TEST_CHAIN_LINT mechanism allows you to
 catch such a mistake more easily.

 What I queued here has fix to the issue J6t found in 15/25 squashed
 in, and also has 26/25 and 27/25 follow-up fixes from Michael, plus
 28/25 follow-up from Torsten.  If everybody involved is happy with
 it, we can just proceed with this copy, otherwise I'll let Peff
 reroll.  I am happy either way.


* tg/test-index-v4 (2015-03-20) 1 commit
  (merged to 'next' on 2015-03-23 at 6b2eb0a)
 + t1700: make test pass with index-v4

 A test fix.

 Will merge to 'master'.


* jc/a-lone-dash-stands-for-previous-branch (2015-03-16) 1 commit
 - "-" and "@{-1}" on various programs

 Lose special case code to make a lone dash "-" mean the previous
 branch aka "@{-1}" from a handful subcommands, and instead support
 the notation throughout the system by reimplementing it at the
 revisions layer.

 Needs tests, documentation updates, etc.  Also does only a half-way
 job dealing with range notation, which needs to be fixed before the
 series goes anywhere.


* jc/submitting-patches-mention-send-email (2015-03-15) 1 commit
  (merged to 'next' on 2015-03-23 at a9581fd)
 + SubmittingPatches: encourage users to use format-patch and send-email

 Recommend format-patch and send-email for those who want to submit
 patches to this project.

 Will merge to 'master'.


* as/userdiff-sh (2015-03-13) 1 commit
 - userdiff: funcname and word patterns for sh

 Add a built-in "userdiff" patterns to word-split and identify
 notable lines in shell scripts to help presentation of diff and
 grep output.

 Comments???


* bc/object-id (2015-03-13) 10 commits
 - apply: convert threeway_stage to object_id
 - patch-id: convert to use struct object_id
 - commit: convert parts to struct object_id
 - diff: convert struct combine_diff_path to object_id
 - bulk-checkin.c: convert to use struct object_id
 - zip: use GIT_SHA1_HEXSZ for trailers
 - archive.c: convert to use struct object_id
 - bisect.c: convert leaf functions to use struct object_id
 - define utility functions for object IDs
 - define a structure for object IDs

 Identify parts of the code that knows that we use SHA-1 hash to
 name our objects too much, and use (1) symbolic constants instead
 of hardcoded 20 as byte count and/or (2) use struct object_id
 instead of unsigned char [20] for object names.

 Will merge to and cook in 'next'.


* ct/prompt-untracked-fix (2015-03-15) 1 commit
  (merged to 'next' on 2015-03-20 at 0d57eaf)
 + git prompt: use toplevel to find untracked files

 The prompt script (in contrib/) did not show the untracked sign
 when working in a subdirectory without any untracked files.

 Will merge to 'master'.


* dj/log-graph-with-no-walk (2015-03-19) 1 commit
  (merged to 'next' on 2015-03-20 at cb636c0)
 + revision: forbid combining --graph and --no-walk

 "git log --graph --no-walk A B..." is a otcnflicting request that
 asks nonsense; no-walk tells us show discrete points in the
 history, while graph asks to draw connections between these
 discrete points. Forbid the combination.

 Will merge to 'master'.


* nd/slim-index-pack-memory-usage (2015-02-27) 2 commits
 - index-pack: kill union delta_base to save memory
 - index-pack: reduce object_entry size to save memory

 Memory usage of "git index-pack" has been trimmed by tens of
 per-cent.

 Waiting for further comments.


* nd/list-files (2015-02-09) 21 commits
 - t3080: tests for git-list-files
 - list-files: -M aka diff-cached
 - list-files -F: show submodules with the new indicator '&'
 - list-files: add -F/--classify
 - list-files: show directories as well as files
 - list-files: do not show duplicate cached entries
 - list-files: sort output and remove duplicates
 - list-files: add -t back
 - list-files: add -1 short for --no-column
 - list-files: add -R/--recursive short for --max-depth=-1
 - list-files: -u does not imply showing stages
 - list-files: make alias 'ls' default to 'list-files'
 - list-files: a user friendly version of ls-files and more
 - ls-files: support --max-depth
 - ls-files: add --column
 - ls-files: add --color to highlight file names
 - ls-files: buffer full item in strbuf before printing
 - ls_colors.c: highlight submodules like directories
 - ls_colors.c: add a function to color a file name
 - ls_colors.c: parse color.ls.* from config file
 - ls_colors.c: add $LS_COLORS parsing code

 A new "git list-files" Porcelain command, "ls-files" with bells and
 whistles.

 Reroll to base on wt-status work ($gmane/265142) has seen some
 positive discussions. Waiting for a further polished reroll
 ($gmane/265534).


* js/fsck-opt (2015-01-21) 19 commits
 - fsck: support ignoring objects in `git fsck` via fsck.skiplist
 - fsck: git receive-pack: support excluding objects from fsck'ing
 - fsck: introduce `git fsck --quick`
 - fsck: support demoting errors to warnings
 - fsck: document the new receive.fsck.* options
 - fsck: allow upgrading fsck warnings to errors
 - fsck: optionally ignore specific fsck issues completely
 - fsck: disallow demoting grave fsck errors to warnings
 - fsck: add a simple test for receive.fsck.*
 - fsck: make fsck_tag() warn-friendly
 - fsck: handle multiple authors in commits specially
 - fsck: make fsck_commit() warn-friendly
 - fsck: make fsck_ident() warn-friendly
 - fsck: report the ID of the error/warning
 - fsck: allow demoting errors to warnings via receive.fsck.warn = <key>
 - fsck: offer a function to demote fsck errors to warnings
 - fsck: provide a function to parse fsck message IDs
 - fsck: introduce identifiers for fsck messages
 - fsck: introduce fsck options

 "fsck.warnings = <list of error tokens>" I suggested turned out to
 be an unpopular choice (sorry Dscho).

 Expecting a reroll.


* nd/multiple-work-trees (2015-03-20) 39 commits
  (merged to 'next' on 2015-03-20 at cc98ed0)
 + t2026: fix broken &&-chain
  (merged to 'next' on 2015-02-18 at b51f696)
 + t2026 needs procondition SANITY
 + git-checkout.txt: a note about multiple checkout support for submodules
 + checkout: add --ignore-other-wortrees
 + checkout: pass whole struct to parse_branchname_arg instead of individual flags
 + git-common-dir: make "modules/" per-working-directory directory
 + checkout: do not fail if target is an empty directory
 + t2025: add a test to make sure grafts is working from a linked checkout
 + checkout: don't require a work tree when checking out into a new one
 + git_path(): keep "info/sparse-checkout" per work-tree
 + count-objects: report unused files in $GIT_DIR/worktrees/...
 + gc: support prune --worktrees
 + gc: factor out gc.pruneexpire parsing code
 + gc: style change -- no SP before closing parenthesis
 + checkout: clean up half-prepared directories in --to mode
 + checkout: reject if the branch is already checked out elsewhere
 + prune: strategies for linked checkouts
 + checkout: support checking out into a new working directory
 + use new wrapper write_file() for simple file writing
 + wrapper.c: wrapper to open a file, fprintf then close
 + setup.c: support multi-checkout repo setup
 + setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 + setup.c: convert check_repository_format_gently to use strbuf
 + setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 + setup.c: convert is_git_directory() to use strbuf
 + git-stash: avoid hardcoding $GIT_DIR/logs/....
 + *.sh: avoid hardcoding $GIT_DIR/hooks/...
 + git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 + $GIT_COMMON_DIR: a new environment variable
 + commit: use SEQ_DIR instead of hardcoding "sequencer"
 + fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 + reflog: avoid constructing .lock path with git_path
 + *.sh: respect $GIT_INDEX_FILE
 + git_path(): be aware of file relocation in $GIT_DIR
 + path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 + path.c: rename vsnpath() to do_git_path()
 + git_snpath(): retire and replace with strbuf_git_path()
 + path.c: make get_pathname() call sites return const char *
 + path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Will cook in 'next'.
