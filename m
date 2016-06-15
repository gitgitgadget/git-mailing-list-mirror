From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2014, #04; Tue, 15)
Date: Tue, 15 Apr 2014 15:12:05 -0700
Message-ID: <xmqq61majl8q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 00:12:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaBaX-0007xY-NR
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 00:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbaDOWMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 18:12:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbaDOWMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 18:12:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F41577D6EA;
	Tue, 15 Apr 2014 18:12:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	ThPHlBvPD2lsfGkkWTSlNVPZmQ=; b=WVDdLnLiu5dW+JSKdfPRKKHXEmOxC4xT8
	i3RUslspKWJUX+72BghNis7RS7nuRkUYJf8dLf8XD6Z5RkXZDcwAhDY13bP4cEnd
	IskuUUGiFIOZIHX0jrCGUumxKWL1aElcq8yb2aMdl8JMzw/BtkVQ38TX+RL1rAnk
	FGoKKbu+Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=YGX
	a1FAWntpWZ/cc/1NirpEQ6u4mCRqoDnsEGQLr7tso9hKRhEKTZwdB/J0ogUD9M/n
	tABsqDUIFHxDNysRnLjOdHFbVuVE+Tujg9473XmlxJlNmoByYmzDHc7XLIdBvirV
	QVrIEbImAi+T9VsPCuWqWto94SftJLjNUtuWb0ec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDB6F7D6E9;
	Tue, 15 Apr 2014 18:12:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BF517D6E8;
	Tue, 15 Apr 2014 18:12:07 -0400 (EDT)
X-master-at: 68773ac915580e88016c34ce1269730382b501d4
X-next-at: eaba9156adf2b84a54a025dcd2c3fecdea5dc8a0
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB8A342E-C4EA-11E3-8E21-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246305>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The number of topics cooking in 'next' has been shrinking, and the
cycle is getting long. Hopefully we will have -rc0 late this week to
close the 'master' branch and a few rounds of -rc iterations until
2.0 final. Other topics under discussion may continue to flow to
'next', as usual, during that time, to be pushed out early in the
next cycle.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* fc/prompt-zsh-read-from-file (2014-04-14) 1 commit
 - prompt: fix missing file errors in zsh

 Will merge to 'next' and to 'master'.


* fc/transport-helper-sync-error-fix (2014-04-14) 5 commits
 - transport-helper: fix sync issue on crashes
 - transport-helper: trivial cleanup
 - transport-helper: propagate recvline() error pushing
 - remote-helpers: make recvline return an error
 - transport-helper: remove barely used xchgline()

 Make sure the marks are not written out when the transport helper
 did not finish happily, to avoid marks file that is out of sync
 with the reality.

 As I had to resolve some conflicts with the recent code, will wait
 until getting an OK from Felipe on the conflict resolution and then
 hopefully can be merged to 'next' and then later to 'master'.


* km/avoid-non-function-return-in-rebase (2014-04-14) 2 commits
 - Revert "rebase: fix run_specific_rebase's use of "return" on FreeBSD"
 - rebase: avoid non-function use of "return" on FreeBSD

 Work around /bin/sh that does not like "return" at the top-level
 of a file that is dot-sourced from inside a function definition.

 Will merge to 'next'.

 We may want to merge it to 'master' by -rc1 if no regressions are
 reported.


* db/make-with-curl (2014-04-15) 2 commits
 - Makefile: allow static linking against libcurl
 - Makefile: use curl-config to determine curl flags

 Ask curl-config how to link with the curl library, instead of
 having only a limited configurability knobs in the Makefile.

 Will merge to 'next'.

 We may want to merge it to 'master' by -rc1 if no regressions are
 reported.

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

* nd/index-pack-one-fd-per-thread (2014-04-09) 1 commit
 - index-pack: work around thread-unsafe pread()

 Enable threaded index-pack on platforms without thread-unsafe
 pread() emulation.

 The log message may need to be replaced ($gmane/246176, $gmane/246290).


* tb/unicode-6.3-zero-width (2014-04-09) 1 commit
  (merged to 'next' on 2014-04-14 at 72ce72a)
 + utf8.c: partially update to version 6.3

 Teach our display-column-counting logic about decomposed umlauts
 and friends.

 Will merge to 'master'.


* fc/complete-aliased-push (2014-04-09) 1 commit
 - completion: fix completing args of aliased "push", "fetch", etc.

 Will merge to 'next'.


* fc/remote-helper-fixes (2014-04-14) 5 commits
 - remote-bzr: trivial test fix
 - remote-bzr: include authors field in pushed commits
 - remote-bzr: add support for older versions
 - remote-hg: always normalize paths
 - remote-helpers: allow all tests running from any dir

 Will merge to 'next'.


* fc/publish-vs-upstream (2014-04-11) 8 commits
 - sha1_name: add support for @{publish} marks
 - sha1_name: simplify track finding
 - sha1_name: cleanup interpret_branch_name()
 - branch: display publish branch
 - push: add --set-publish option
 - branch: add --set-publish-to option
 - Add concept of 'publish' branch
 - t5516 (fetch-push): fix test restoration

 Add branch@{publish}; this round v3 hasn't yet seen much reviews
 yet.

 Seems to have some interactions to break t5516 when merged to 'pu'.


* ym/fix-opportunistic-index-update-race (2014-04-10) 2 commits
 - read-cache.c: verify index file before we opportunistically update it
 - wrapper.c: add xpread() similar to xread()

 Duy raised a good point that we may need to do the same for the
 normal writeout codepath, not just the "opportunistic" update
 codepath.  While that is true, nobody sane would be running two
 simultaneous operations that are clearly write-oriented competing
 with each other against the same index file.  So in that sense that
 can be done as a less urgent follow-up for this topic.

 Will merge to 'next' and keep it there for the remainder of the cycle.


* km/avoid-bs-in-shell-glob (2014-04-11) 1 commit
  (merged to 'next' on 2014-04-14 at a3d9a58)
 + test: fix t5560 on FreeBSD

 Portability fix.
 Will merge to 'master'.


* km/avoid-cp-a (2014-04-11) 1 commit
  (merged to 'next' on 2014-04-14 at be661c4)
 + test: fix t7001 cp to use POSIX options

 Portability fix.
 Will merge to 'master'.


* jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
 - commit -m: commit staged submodules regardless of ignore config
 - status/commit: show staged submodules regardless of ignore config

 There also are a few patches Ronald Weiss and Jens are working on
 polishing around this topic, and a patch from Jens each for gitk
 and git-gui.

 Waiting for the dust to settle until picking them up all.


* mh/multimail (2014-04-07) 1 commit
  (merged to 'next' on 2014-04-15 at eaba915)
 + git-multimail: update to version 1.0.0

 Will merge to 'master'.


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

 Still being commented on.


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
 - ref_transaction_commit(): work with transaction->updates in place
 - struct ref_update: add a type field
 - struct ref_update: add a lock field
 - ref_transaction_commit(): simplify code using temporary variables
 - struct ref_update: store refname as a FLEX_ARRAY
 - struct ref_update: rename field "ref_name" to "refname"
 - refs: remove API function update_refs()
 - update-ref --stdin: reimplement using reference transactions
 - refs: add a concept of a reference transaction
 - update-ref --stdin: harmonize error messages
 - update-ref --stdin: improve the error message for unexpected EOF
 - t1400: test one mistake at a time
 - update-ref --stdin -z: deprecate interpreting the empty string as zeros
 - update-ref.c: extract a new function, parse_next_sha1()
 - t1400: test that stdin -z update treats empty <newvalue> as zeros
 - update-ref --stdin: simplify error messages for missing oldvalues
 - update-ref --stdin: make error messages more consistent
 - update-ref --stdin: improve error messages for invalid values
 - update-ref.c: extract a new function, parse_refname()
 - parse_cmd_verify(): copy old_sha1 instead of evaluating <oldvalue> twice
 - update-ref --stdin: read the whole input at once
 - update_refs(): fix constness
 - refs.h: rename the action_on_err constants
 - t1400: add some more tests involving quoted arguments
 - parse_arg(): really test that argument is properly terminated
 - t1400: provide more usual input to the command
 - t1400: fix name and expected result of one test
 (this branch is used by rs/ref-closer-to-atomic.)

 Update "update-ref --stdin [-z]" and then introduce a transactional
 support for (multi-)reference updates.

 Will merge to 'next' and keep it there for the remainder of the cycle.


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

--------------------------------------------------
[Discarded]

* sz/mingw-index-pack-threaded (2014-03-19) 1 commit
 . Enable index-pack threading in msysgit.

 Queued a different attempt by Duy on nd/index-pack-one-fd-per-thread


* rs/ref-closer-to-atomic (2014-04-14) 3 commits
 . refs.c: change ref_transaction_commit to run the commit loops once all work is finished
 . refs.c: split delete_ref_loose() into a separate flag-for-deletion and commit phase
 . refs.c: split writing and commiting a ref into two separate functions
 (this branch uses mh/ref-transaction.)

 Builds on top of Michael's ref-transaction series to shrink the
 race window during multiple ref updates.

 Deferred to be rerolled ($gmane/246289).
