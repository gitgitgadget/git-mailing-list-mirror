From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2014, #07; Tue, 22)
Date: Tue, 22 Apr 2014 16:12:42 -0700
Message-ID: <xmqq38h52c2d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 01:12:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcjrz-0000U8-MV
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 01:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbaDVXMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 19:12:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbaDVXMq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 19:12:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 477C07F98B;
	Tue, 22 Apr 2014 19:12:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	5uQ3+/CKop+fmAj1GQ2T73xl7c=; b=cRHUkY4pVzjhnahks0MYkxQLc8Mo8X61B
	e5t53uMuRoWrSK/MKJ/1mbw+C4Yt0XQkIwXapjHTzZFqEcEKP1w8gyyMtrn77XCJ
	S0zfM6OSZIRqOX/UtaBL421qkIyEP603Gc+X3chS4gbTY7X8WiNJu5Jv8jizKWxi
	3rUdPR3vyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=g9U
	KxLyE6nXPlmzTW4vJQCMOrBvGdmv+mtmW4LpKza3cs4Edw11/AhYvopxwhX3Ttat
	2Objcu1sYgpjdvmTh3Hdufia7bIqUVBLYvtnHuHcvVwPYYxbbPF6KpNwg/RKNm69
	Yg+vFI4GSOZSL6GSnscQa/2dcx4cFoUVj1xVZHgo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2733F7F989;
	Tue, 22 Apr 2014 19:12:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D07B7F984;
	Tue, 22 Apr 2014 19:12:44 -0400 (EDT)
X-master-at: 779792a5f24bb4e8049c4f88ad752e70d4a8a080
X-next-at: 4f984835015ed69c2885f183cdc0198f90d08135
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C2F6DF8-CA73-11E3-8E58-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246804>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The tip of the 'master' branch has passed v2.0.0-rc0, an early
preview release.  There are a handful of topics still in 'next' (and
a few that are not in 'next') that I'd like to have in v2.0.0-rc1,
but other than that, this hopefully is fairly a close approximation
of the upcoming release.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* fc/remote-helpers-hg-bzr-graduation (2014-04-21) 3 commits
 - remote-helpers: move tests out of contrib
 - remote-helpers: move out of contrib
 - remote-helpers: squelch python import exceptions

 Move remote-hg and remote-bzr out of contrib/.

 Will merge to 'next' and keep it there for the remainder of the cycle.


* rs/ref-transaction (2014-04-22) 14 commits
 . SQUASH???
 . refs.c: change update_ref to use a transaction
 . walker.c: use ref transaction for ref updates
 . branch.c: use ref transaction for all ref updates
 . fast-import.c: change update_branch to use ref transactions
 . sequencer.c: use ref transactions for all ref updates
 . commit.c: use ref transactions for updates
 . replace.c: use the ref transaction functions for updates
 . tag.c: use ref transactions when doing updates
 . refs.c: ref_transaction_delete to check for error and return status
 . refs.c: change ref_transaction_create to do error checking and return status
 . refs.c: change ref_transaction_update() to do error checking and return status
 . refs.c: use a single exit path from transaction commit and handle onerr
 . refs.c: constify the sha arguments for ref_transaction_create|delete|update
 (this branch uses mh/ref-transaction.)

 Updates most of the callsites to write_sha1_ref(), the low-level
 mechanism to update a ref, to use the ref-transaction API.

 Seems to break the dumb walker test (t5550) when merged to 'pu',
 possibly due to misconversion of walker.c.  Kept out of 'pu' as I
 didn't want to resolve conflicts with the other topics only to get
 a known-broken version.


* fc/remote-helper-refmap (2014-04-21) 8 commits
 - transport-helper: remove unnecessary strbuf resets
 - transport-helper: add support to delete branches
 - fast-export: add support to delete refs
 - fast-import: add support to delete refs
 - transport-helper: add support to push symbolic refs
 - transport-helper: add support for old:new refspec
 - fast-export: add new --refspec option
 - fast-export: improve argument parsing

 Allow remote-helper/fast-import based transport to rename the refs
 while transferring the history.

 Will merge to 'next' and keep it there for the remainder of the cycle.


* jk/external-diff-use-argv-array (2014-04-21) 6 commits
 - run_external_diff: refactor cmdline setup logic
 - run_external_diff: hoist common bits out of conditional
 - run_external_diff: drop fflush(NULL)
 - run_external_diff: clean up error handling
 - run_external_diff: use an argv_array for the environment
 - run_external_diff: use an argv_array for the command line

 Code clean-up.

 Will keep in 'next' for the remainder of the cycle.


* jx/blame-align-relative-time (2014-04-22) 2 commits
 - blame: dynamic blame_date_width for different locales
 - blame:: fix broken time_buf paddings in relative timestamp

 "git blame" miscounted number of columns needed to show localized
 timestamps, resulting in jaggy left-side-edge of the source code
 lines in its output.

 Will merge to 'next' and keep it there for the remainder of the cycle.


* fc/merge-default-to-upstream (2014-04-22) 1 commit
  (merged to 'next' on 2014-04-22 at 4f98483)
 + merge: enable defaulttoupstream by default

 "git merge" without argument, even when there is an upstream
 defined for the current branch, refused to run until
 merge.defaultToUpstream is set to true. Flip the default of that
 configuration variable to true.

 Will keep in 'next' for the remainder of the cycle.


* fc/mergetool-prompt (2014-04-22) 1 commit
  (merged to 'next' on 2014-04-22 at dcaec94)
 + mergetool: run prompt only if guessed tool

 mergetool.prompt used to default to 'true', always causing a confirmation
 "do you really want to run the tool on this path" to be shown.

 Among the two purposes the prompt serves, ignore the use case to
 confirm that the user wants to view particular path with the named
 tool, and make the prompt only to confirm the choice of the tool
 made by autodetection and defaulting.  For those who configured the
 tool explicitly, the prompt shown for the latter purpose is simply
 annoying.
 
 Strictly speaking, this is a backward incompatible change and the
 users need to explicitly set the variable to 'true' if they want to
 resurrect the now-ignored use case.

 Will keep in 'next' for the remainder of the cycle.


* fc/mergetools-vimdiff3 (2014-04-22) 1 commit
  (merged to 'next' on 2014-04-22 at d843e75)
 + mergetools: add vimdiff3 mode

 Will keep in 'next' for the remainder of the cycle.


* km/git-svn-workaround-older-getopt-long (2014-04-22) 1 commit
 - t9117: use --prefix "" instead of --prefix=""

 Will merge to 'next' and hopefully merge to 'master' by -rc2 if not earlier.


* lr/git-run-setup-gently (2014-04-22) 1 commit
 - git.c: treat RUN_SETUP_GENTLY and RUN_SETUP as mutually exclusive

 Will keep in 'next' for the remainder of the cycle.


* mk/doc-git-gui-display-untracked (2014-04-21) 1 commit
 - Documentation: git-gui: describe gui.displayuntracked

 Will merge to 'next' and hopefully merge to 'master' by -rc2 if not earlier.


* rh/prompt-pcmode-avoid-eval-on-refname (2014-04-22) 1 commit
 - git-prompt.sh: don't put unsanitized branch names in $PS1

 Will merge to 'next' and hopefully merge to 'master' by -rc2 if not earlier.

--------------------------------------------------
[Graduated to "master"]

* ep/shell-command-substitution (2014-04-17) 14 commits
  (merged to 'next' on 2014-04-18 at ebd996d)
 + t9362-mw-to-git-utf8.sh: use the $( ... ) construct for command substitution
 + t9360-mw-to-git-clone.sh: use the $( ... ) construct for command substitution
 + git-tag.sh: use the $( ... ) construct for command substitution
 + git-revert.sh: use the $( ... ) construct for command substitution
 + git-resolve.sh: use the $( ... ) construct for command substitution
 + git-repack.sh: use the $( ... ) construct for command substitution
 + git-merge.sh: use the $( ... ) construct for command substitution
 + git-ls-remote.sh: use the $( ... ) construct for command substitution
 + git-fetch.sh: use the $( ... ) construct for command substitution
 + git-commit.sh: use the $( ... ) construct for command substitution
 + git-clone.sh: use the $( ... ) construct for command substitution
 + git-checkout.sh: use the $( ... ) construct for command substitution
 + install-webdoc.sh: use the $( ... ) construct for command substitution
 + howto-index.sh: use the $( ... ) construct for command substitution


* jx/i18n (2014-04-18) 4 commits
  (merged to 'next' on 2014-04-18 at 2ace126)
 + i18n: mention "TRANSLATORS:" marker in Documentation/CodingGuidelines
 + i18n: only extract comments marked with "TRANSLATORS:"
 + i18n: remove obsolete comments for translators in diffstat generation
 + i18n: fix uncatchable comments for translators in date.c


* km/avoid-non-function-return-in-rebase (2014-04-17) 2 commits
  (merged to 'next' on 2014-04-18 at 6982c3e)
 + Revert "rebase: fix run_specific_rebase's use of "return" on FreeBSD"
 + rebase: avoid non-function use of "return" on FreeBSD

 Work around /bin/sh that does not like "return" at the top-level
 of a file that is dot-sourced from inside a function definition.

--------------------------------------------------
[Stalled]

* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)

 Will hold.


* tr/remerge-diff (2014-02-26) 5 commits
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . revision: fold all merge diff variants into an enum merge_diff_mode
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Needs to be rebased, now kb/fast-hashmap topic is in.


* bc/blame-crlf-test (2014-02-18) 1 commit
 - blame: add a failing test for a CRLF issue.

 I have a feeling that a fix for this should be fairly isolated and
 trivial (it should be just the matter of paying attention to the
 crlf settings when synthesizing the fake commit)---perhaps somebody
 can squash in a fix to this?


* jk/makefile (2014-02-05) 16 commits
 - FIXUP
 - move LESS/LV pager environment to Makefile
 - Makefile: teach scripts to include make variables
 - FIXUP
 - Makefile: auto-build C strings from make variables
 - Makefile: drop *_SQ variables
 - FIXUP
 - Makefile: add c-quote helper function
 - Makefile: introduce sq function for shell-quoting
 - Makefile: always create files via make-var
 - Makefile: store GIT-* sentinel files in MAKE/
 - Makefile: prefer printf to echo for GIT-*
 - Makefile: use tempfile/mv strategy for GIT-*
 - Makefile: introduce make-var helper function
 - Makefile: fix git-instaweb dependency on gitweb
 - Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 . t1507 (rev-parse-upstream): fix typo in test title
 . implement @{publish} shorthand
 . branch_get: provide per-branch pushremote pointers
 . branch_get: return early on error
 . sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Meant to be used as a basis for whatever Ram wants to build on.

 Ejected from 'pu' to make room for fc/publish-vs-upstream topic.


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


* jl/submodule-recursive-checkout (2013-12-26) 5 commits
 - Teach checkout to recursively checkout submodules
 - submodule: teach unpack_trees() to update submodules
 - submodule: teach unpack_trees() to repopulate submodules
 - submodule: teach unpack_trees() to remove submodule contents
 - submodule: prepare for recursive checkout of submodules

 An RFCv2 exists ($gmane/241455) with sizable review comments.
 Expecting a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Needs to be rebased, now the pack-bitmap series is in.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* fc/publish-vs-upstream (2014-04-21) 8 commits
 - sha1_name: add support for @{publish} marks
 - sha1_name: simplify track finding
 - sha1_name: cleanup interpret_branch_name()
 - branch: display publish branch
 - push: add --set-publish option
 - branch: add --set-publish-to option
 - Add concept of 'publish' branch
 - t5516 (fetch-push): fix test restoration

 Add branch@{publish}; it seems that this is somewhat different from
 Ram and Peff started working on.  There were many discussion
 messages going back and forth but it does not appear that the
 design issues have been worked out among participants yet.


* jl/git-gui-show-added-submodule-changes (2014-04-15) 1 commit
 - git-gui: show staged submodules regardless of ignore config

 Tentatively queued what I expect to receive via Pat Thoyts.


* jl/gitk-show-added-submodule-changes (2014-04-15) 3 commits
 - gitk: show staged submodules regardless of ignore config
 - gitk: Merge branch 'new' of https://github.com/vnwildman/gitk
 - l10n: Init Vietnamese translation

 Tentatively queued what I expect to receive via Paul Mackerras.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* ef/send-email-absolute-path-to-the-command (2014-04-16) 1 commit
  (merged to 'next' on 2014-04-21 at 43bebb5)
 + send-email: recognize absolute path on Windows

 Will keep in 'next' for the remainder of the cycle.


* jh/submodule-tests (2014-04-17) 1 commit
 - t7410: 210 tests for various 'git submodule update' scenarios


* rs/ref-update-check-errors-early (2014-04-17) 2 commits
  (merged to 'next' on 2014-04-21 at acc62aa)
 + commit.c: check for lock error and return early
 + sequencer.c: check for lock failure and bail early in fast_forward_to

 Will keep in 'next' for the remainder of the cycle.


* sk/svn-parse-datestamp (2014-04-17) 1 commit
  (merged to 'next' on 2014-04-21 at 5ff519f)
 + SVN.pm::parse_svn_date: allow timestamps with a single-digit hour

 Will keep in 'next' for the remainder of the cycle.


* fc/transport-helper-sync-error-fix (2014-04-21) 6 commits
  (merged to 'next' on 2014-04-21 at f53a08a)
 + t5801 (remote-helpers): cleanup environment sets
 + transport-helper: fix sync issue on crashes
 + transport-helper: trivial cleanup
 + transport-helper: propagate recvline() error pushing
 + remote-helpers: make recvline return an error
 + transport-helper: remove barely used xchgline()

 Make sure the marks are not written out when the transport helper
 did not finish happily, to avoid marks file that is out of sync
 with the reality.

 Will merge to 'master' by -rc1 if no regressions are reported.


* db/make-with-curl (2014-04-15) 2 commits
  (merged to 'next' on 2014-04-16 at b9c8527)
 + Makefile: allow static linking against libcurl
 + Makefile: use curl-config to determine curl flags

 Ask curl-config how to link with the curl library, instead of
 having only a limited configurability knobs in the Makefile.

 Will merge to 'master' by -rc1 if no regressions are reported.


* nd/index-pack-one-fd-per-thread (2014-04-16) 1 commit
  (merged to 'next' on 2014-04-16 at b38d5a9)
 + index-pack: work around thread-unsafe pread()

 Enable threaded index-pack on platforms without thread-unsafe
 pread() emulation.

 Will keep in 'next' for the remainder of the cycle.


* ym/fix-opportunistic-index-update-race (2014-04-10) 2 commits
  (merged to 'next' on 2014-04-16 at cb92f4f)
 + read-cache.c: verify index file before we opportunistically update it
 + wrapper.c: add xpread() similar to xread()

 Read-only operations such as "git status" that internally refreshes
 the index write out the refreshed index to the disk to optimize
 future accesses to the working tree, but this could race with a
 "read-write" operation that modify the index while it is running.
 Detect such a race and avoid overwriting the index.

 Duy raised a good point that we may need to do the same for the
 normal writeout codepath, not just the "opportunistic" update
 codepath.  While that is true, nobody sane would be running two
 simultaneous operations that are clearly write-oriented competing
 with each other against the same index file.  So in that sense that
 can be done as a less urgent follow-up for this topic.

 Will keep in 'next' for the remainder of the cycle.


* jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
 - commit -m: commit staged submodules regardless of ignore config
 - status/commit: show staged submodules regardless of ignore config

 There also are a few patches Ronald Weiss and Jens are working on
 polishing around this topic, and a patch from Jens each for gitk
 and git-gui.

 Waiting for the dust to settle until picking them up all.


* mh/lockfile (2014-04-15) 25 commits
 - trim_last_path_elm(): replace last_path_elm()
 - resolve_symlink(): take a strbuf parameter
 - resolve_symlink(): use a strbuf for internal scratch space
 - change lock_file::filename into a strbuf
 - commit_lock_file(): use a strbuf to manage temporary space
 - try_merge_strategy(): use a statically-allocated lock_file object
 - try_merge_strategy(): remove redundant lock_file allocation
 - struct lock_file: declare some fields volatile
 - lockfile: avoid transitory invalid states
 - commit_lock_file(): die() if called for unlocked lockfile object
 - commit_lock_file(): inline temporary variable
 - remove_lock_file(): call rollback_lock_file()
 - lock_file(): exit early if lockfile cannot be opened
 - write_packed_entry_fn(): convert cb_data into a (const int *)
 - prepare_index(): declare return value to be (const char *)
 - delete_ref_loose(): don't muck around in the lock_file's filename
 - cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 - lockfile.c: document the various states of lock_file objects
 - lock_file(): always add lock_file object to lock_file_list
 - hold_lock_file_for_append(): release lock on errors
 - lockfile: unlock file if lockfile permissions cannot be adjusted
 - rollback_lock_file(): set fd to -1
 - rollback_lock_file(): do not clear filename redundantly
 - api-lockfile: expand the documentation
 - unable_to_lock_die(): rename function from unable_to_lock_index_die()

 Refactor and fix corner-case bugs in the lockfile API, all looked
 sensible.

 Expecting a reroll.


* mt/patch-id-stable (2014-03-31) 3 commits
  (merged to 'next' on 2014-04-08 at 0188d44)
 + patch-id-test: test --stable and --unstable flags
 + patch-id: document new behaviour
 + patch-id: make it stable against hunk reordering

 Introduce a new way to compute patch-id for a patch that is not
 affected by the order of the paths that appear in the input.

 This changes the generated patch-id unless the users add an extra
 option to their command lines, but I deliberately queued the series
 to 'next' without reverting that compatibility breakage to see if
 people complain.  It could be that we do not have to worry about
 the default flipping at all.  We'll see.

 Will keep in 'next' for the remainder of the cycle.


* mh/ref-transaction (2014-04-07) 27 commits
  (merged to 'next' on 2014-04-16 at a99f84d)
 + ref_transaction_commit(): work with transaction->updates in place
 + struct ref_update: add a type field
 + struct ref_update: add a lock field
 + ref_transaction_commit(): simplify code using temporary variables
 + struct ref_update: store refname as a FLEX_ARRAY
 + struct ref_update: rename field "ref_name" to "refname"
 + refs: remove API function update_refs()
 + update-ref --stdin: reimplement using reference transactions
 + refs: add a concept of a reference transaction
 + update-ref --stdin: harmonize error messages
 + update-ref --stdin: improve the error message for unexpected EOF
 + t1400: test one mistake at a time
 + update-ref --stdin -z: deprecate interpreting the empty string as zeros
 + update-ref.c: extract a new function, parse_next_sha1()
 + t1400: test that stdin -z update treats empty <newvalue> as zeros
 + update-ref --stdin: simplify error messages for missing oldvalues
 + update-ref --stdin: make error messages more consistent
 + update-ref --stdin: improve error messages for invalid values
 + update-ref.c: extract a new function, parse_refname()
 + parse_cmd_verify(): copy old_sha1 instead of evaluating <oldvalue> twice
 + update-ref --stdin: read the whole input at once
 + update_refs(): fix constness
 + refs.h: rename the action_on_err constants
 + t1400: add some more tests involving quoted arguments
 + parse_arg(): really test that argument is properly terminated
 + t1400: provide more usual input to the command
 + t1400: fix name and expected result of one test
 (this branch is used by rs/ref-transaction.)

 Update "update-ref --stdin [-z]" and then introduce a transactional
 support for (multi-)reference updates.

 Will keep in 'next' for the remainder of the cycle.


* jc/apply-ignore-whitespace (2014-03-26) 1 commit
  (merged to 'next' on 2014-04-04 at 53779a7)
 + apply --ignore-space-change: lines with and without leading whitespaces do not match

 "--ignore-space-change" option of "git apply" ignored the
 spaces at the beginning of line too aggressively, which is
 inconsistent with the option of the same name "diff" and "git diff"
 have.

 Will keep in 'next' for the remainder of the cycle.


* as/grep-fullname-config (2014-03-20) 1 commit
  (merged to 'next' on 2014-03-28 at 810a076)
 + grep: add grep.fullName config variable

 Add a configuration variable to force --full-name to be default for
 "git grep".

 This may cause regressions on scripted users that do not expect
 this new behaviour.

 Will keep in 'next' for the remainder of the cycle.


* nd/multiple-work-trees (2014-03-25) 28 commits
 - count-objects: report unused files in $GIT_DIR/repos/...
 - gc: support prune --repos
 - gc: style change -- no SP before closing bracket
 - prune: strategies for linked checkouts
 - checkout: detach if the branch is already checked out elsewhere
 - checkout: clean up half-prepared directories in --to mode
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - $GIT_COMMON_DIR: a new environment variable
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - git_path(): be aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 - path.c: rename vsnpath() to do_git_path()
 - git_snpath(): retire and replace with strbuf_git_path()
 - path.c: make get_pathname() call sites return const char *
 - path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Will hold.


* ks/tree-diff-nway (2014-04-09) 20 commits
  (merged to 'next' on 2014-04-09 at c17228e)
 + mingw: activate alloca
  (merged to 'next' on 2014-04-08 at 6b74773)
 + combine-diff: speed it up, by using multiparent diff tree-walker directly
 + tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
 + Portable alloca for Git
  (merged to 'next' on 2014-03-31 at 16a7bd4)
 + tree-diff: reuse base str(buf) memory on sub-tree recursion
 + tree-diff: no need to call "full" diff_tree_sha1 from show_path()
 + tree-diff: rework diff_tree interface to be sha1 based
 + tree-diff: diff_tree() should now be static
 + tree-diff: remove special-case diff-emitting code for empty-tree cases
  (merged to 'next' on 2014-03-25 at cfcbdac)
 + tree-diff: simplify tree_entry_pathcmp
 + tree-diff: show_path prototype is not needed anymore
 + tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
 + tree-diff: move all action-taking code out of compare_tree_entry()
 + tree-diff: don't assume compare_tree_entry() returns -1,0,1
  (merged to 'next' on 2014-03-21 at d872679)
 + tree-diff: consolidate code for emitting diffs and recursion in one place
 + tree-diff: show_tree() is not needed
 + tree-diff: no need to pass match to skip_uninteresting()
 + tree-diff: no need to manually verify that there is no mode change for a path
 + combine-diff: move changed-paths scanning logic into its own function
 + combine-diff: move show_log_first logic/action out of paths scanning

 Instead of running N pair-wise diff-trees when inspecting a
 N-parent merge, find the set of paths that were touched by walking
 N+1 trees in parallel.  These set of paths can then be turned into
 N pair-wise diff-tree results to be processed through rename
 detections and such.  And N=2 case nicely degenerates to the usual
 2-way diff-tree, which is very nice.

 Will keep in 'next' for the remainder of the cycle.


* cc/interpret-trailers (2014-04-07) 12 commits
 - trailer: add blank line before the trailers if needed
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from stdin and arguments
 - trailer: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.

 I was planning to merge it to 'next' and keep it there for the
 remainder of the cycle, but it appears that there still will be
 another round of reroll, at least for the documentation?
