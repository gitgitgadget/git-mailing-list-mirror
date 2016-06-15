From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2015, #03; Fri, 6)
Date: Fri, 06 Mar 2015 15:47:20 -0800
Message-ID: <xmqq385hwusq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 00:49:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU20B-0004ou-Kk
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 00:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbbCFXtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 18:49:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932269AbbCFXtr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 18:49:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67FD83FB6C;
	Fri,  6 Mar 2015 18:49:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=6
	VqIbbMX56SvYTh9z9sms/Bo3bE=; b=XjCqtruU1pGB9KVzCtjsYULz7uUvwrdLg
	fLOrfOM8J94pgUdKx52DGMh0txZYyL/CLTGV+p9MRtKR9yw3QRUL4us1KMGaAX94
	sdYHEI9JhYpuW6ncHfCL8aH8HyuXHcKp4hEzPfl8zaRH5C4KlcrAMTga/TEmA8Ce
	6ELf3Cvqwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=nFf
	ubv/54nFCG9GYFBUAYtyJQKqFbzjriH3lY5LPWmHJ1XvJjWybVrLIgvKmpHgP0xE
	CBp6AOaBPaEjpfg32JZsq27NxYQUNw9QDtV0+3DFXXSNKVTEPo+fjMIz88RHvEPC
	8XdjTRjxW8+kgezVjeqV5YBTpq4ymjS79K/dRp6g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F91E3FB6B;
	Fri,  6 Mar 2015 18:49:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4FFA33FB64;
	Fri,  6 Mar 2015 18:49:42 -0500 (EST)
X-master-at: d67f9d5e8fd2c165304153a87fd96054d2b74981
X-next-at: 9704172a1848f24ce72de64c49b043350d93b393
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 75AEEAF4-C45B-11E4-BA49-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264974>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

A few more batches of topics have been merged to 'master', including
both fixes and enhancements.  The second maintenance release for
v2.3 has been cut with many fixes that have already been merged to
'master'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ak/t5516-typofix (2015-03-03) 1 commit
  (merged to 'next' on 2015-03-03 at c37a677)
 + t5516: correct misspelled pushInsteadOf


* bw/kwset-use-unsigned (2015-03-02) 1 commit
  (merged to 'next' on 2015-03-05 at fd124ba)
 + kwset: use unsigned char to store values with high-bit set

 The borrowed code in kwset API did not follow our usual convention
 to use "unsigned char" to store values that range from 0-255.


* ja/clean-confirm-i18n (2015-03-02) 1 commit
  (merged to 'next' on 2015-03-03 at 314c322)
 + Add hint interactive cleaning

 The prompt string "remove?" used when "git clean -i" asks the user
 if a path should be removed was localizable, but the code always
 expects a substring of "yes" to tell it to go ahead.  Always show
 [y/N] as part of this prompt to hint that the answer is not (yet)
 localized.


* mg/doc-remote-tags-or-not (2015-03-02) 1 commit
  (merged to 'next' on 2015-03-03 at 1630171)
 + git-remote.txt: describe behavior without --tags and --no-tags

 "git remote add" mentioned "--tags" and "--no-tags" and was not
 clear that fetch from the remote in the future will use the default
 behaviour when neither is given to override it.


* mk/diff-shortstat-dirstat-fix (2015-03-02) 1 commit
  (merged to 'next' on 2015-03-03 at 42c282e)
 + diff --shortstat --dirstat: remove duplicate output

 "git diff --shortstat --dirstat=changes" showed a dirstat based on
 lines that was never asked by the end user in addition to the
 dirstat that the user asked for.


* mr/doc-clean-f-f (2015-02-26) 1 commit
  (merged to 'next' on 2015-03-03 at 67a77a2)
 + Documentation/git-clean.txt: document that -f may need to be given twice

 Documentation update.


* ms/submodule-update-config-doc (2015-03-02) 1 commit
  (merged to 'next' on 2015-03-03 at b94da4b)
 + submodule: improve documentation of update subcommand

 The interaction between "git submodule update" and the
 submodule.*.update configuration was not clearly documented.


* nd/grep-exclude-standard-help-fix (2015-02-27) 1 commit
  (merged to 'next' on 2015-03-03 at 61c9587)
 + grep: correct help string for --exclude-standard

 Description given by "grep -h" for its --exclude-standard option
 was phrased poorly.


* ye/http-accept-language (2015-02-26) 1 commit
  (merged to 'next' on 2015-03-03 at 58d195e)
 + gettext.c: move get_preferred_languages() from http.c

 Compilation fix for a recent topic in 'master'.

--------------------------------------------------
[New Topics]

* ak/git-done-help-cleanup (2015-03-06) 1 commit
 - git: make was_alias and done_help non-static

 Code simplification.

 Will merge to 'next'.


* es/rebase-i-count-todo (2015-03-06) 2 commits
 - rebase-interactive: re-word "item count" comment
 - rebase-interactive: suppress whitespace preceding item count

 "git rebase -i" recently started to include the number of
 commits in the insn sheet to be processed, but on a platform
 that prepends leading whitespaces to "wc -l" output, the numbers
 are shown with extra whitespaces that aren't necessary.

 Will merge to 'next'.


* mg/fdopen-with-retry (2015-03-06) 6 commits
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


* mg/log-decorate-HEAD (2015-03-06) 1 commit
 - log: decorate non-detached HEAD differently

 Output from "git log --decorate" mentions HEAD when it points at a
 tip of an branch differently from a detached HEAD.

 We probably want to de-dup the branch name in the output.

 Waiting for further comments.


* rs/daemon-hostname-in-strbuf (2015-03-06) 1 commit
 - daemon: use strbuf for hostname info

 Code in "git daemon" to parse out and hold hostnames used in
 request interpolation has been simplified.

 Needs updating with a few s/_reset/_release/ ($gmane/264962)


* rs/deflate-init-cleanup (2015-03-05) 1 commit
 - zlib: initialize git_zstream in git_deflate_init{,_gzip,_raw}

 Code simplification.

 Will merge to 'next'.


* rs/zip-text (2015-03-05) 1 commit
 - archive-zip: mark text files in archives

 "git archive" can now be told to set the 'text' attribute in the
 resulting zip archive.

 Will merge to 'next'.


* sg/completion-remote (2015-03-06) 2 commits
 - completion: simplify __git_remotes()
 - completion: add a test for __git_remotes() helper function

 Code simplification.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jk/push-config (2015-02-17) 4 commits
 - [NEEDSACK] push: allow --follow-tags to be set by config push.followTags
 - cmd_push: pass "flags" pointer to config callback
 - cmd_push: set "atomic" bit directly
 - git_push_config: drop cargo-culted wt_status pointer

 Waiting for Ack and/or update for the tip one from Dave Olszewski
 ($gmane/263880, $gmane/263991).


* nd/untracked-cache (2015-02-09) 24 commits
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

* mg/sequencer-commit-messages-always-verbatim (2015-03-06) 1 commit
 - sequencer: preserve commit messages

 "git cherry-pick" used to clean-up the log message even when it is
 merely replaying an existing commit.  It now replays the message
 verbatim unless you are editing the message of resulting commits.

 Will merge to 'next'.


* mg/detached-head-report (2015-03-06) 2 commits
 - branch: name detached HEAD analogous to status
 - wt-status: refactor detached HEAD analysis

 "git branch" on a detached HEAD always said "(detached from xyz)",
 even when "git status" would report "detached at xyz".  The HEAD is
 actually at xyz and haven't been moved since it was detached in
 such a case, but the user cannot read what the current value of
 HEAD is when "detached from" is used.

 Will merge to 'next'.


* mg/status-v-v (2015-03-06) 3 commits
 - commit/status: show the index-worktree diff with -v -v
 - t7508: test git status -v
 - t7508: .gitignore 'expect' and 'output' files

 "git status" now allows the "-v" to be given twice to show the
 differences that are left in the working tree not to be committed.

 Will merge to 'next'.


* jk/diffcore-rename-duplicate (2015-02-27) 2 commits
  (merged to 'next' on 2015-03-03 at 1d5a2d2)
 + diffcore-rename: avoid processing duplicate destinations
 + diffcore-rename: split locate_rename_dst into two functions

 A corrupt input to "git diff -M" can cause us to segfault.

 Will merge to 'master'.


* nd/versioncmp-prereleases (2015-02-27) 1 commit
  (merged to 'next' on 2015-03-03 at 6ab29cf)
 + versionsort: support reorder prerelease suffixes

 The versionsort.prerelease configuration variable can be used to
 specify that v1.0-pre1 comes before v1.0.

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

 Concern was raised that this is piggybacking on ls-files codebase,
 rather than wt-status codebase ($gmane/264258).

 Waiting for further comments or a reroll.


* jc/decorate-leaky-separator-color (2015-03-04) 7 commits
 - log --decorate: do not leak "commit" color into the next item
 - Documentation/config.txt: simplify boolean description in the syntax section
 - Documentation/config.txt: describe 'color' value type in the "Values" section
 - Documentation/config.txt: have a separate "Values" section
 - Documentation/config.txt: describe the structure first and then meaning
 - Documentation/config.txt: explain multi-valued variables once
 - Documentation/config.txt: avoid unnecessary negation

 "git log --decorate" did not reset colors correctly around the
 branch names.

 Waiting for reviews.


* mh/expire-updateref-fixes (2015-03-05) 9 commits
  (merged to 'next' on 2015-03-05 at 1caf9a6)
 + reflog_expire(): never update a reference to null_sha1
 + reflog_expire(): ignore --updateref for symbolic references
 + reflog: improve and update documentation
 + struct ref_lock: delete the force_write member
 + lock_ref_sha1_basic(): do not set force_write for missing references
 + write_ref_sha1(): move write elision test to callers
 + write_ref_sha1(): remove check for lock == NULL
 + Merge branch 'sb/atomic-push' into mh/ref-trans-value-check
 + Merge branch 'mh/reflog-expire' into mh/ref-trans-value-check

 Various issues around "reflog expire", e.g. using --updateref when
 expiring a reflog for a symbolic reference, have been corrected
 and/or made saner.

 Will merge to 'master'.


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


* nd/multiple-work-trees (2015-01-27) 38 commits
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
