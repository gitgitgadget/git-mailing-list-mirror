From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2014, #01; Tue, 7)
Date: Tue, 07 Oct 2014 15:30:27 -0700
Message-ID: <xmqqd2a3cy2k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 00:30:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbdHC-00012j-8o
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 00:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbaJGWae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 18:30:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55689 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752691AbaJGWab (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 18:30:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 88ACD143F2;
	Tue,  7 Oct 2014 18:30:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=q
	m/6PauKhp3/9F6ayShz6B+CRws=; b=BnNl6c6w3yIUWlMmmNePrOw7TWJTC2sxT
	L9V45GVN1aoj3t2+bnQXkTw+Ju+Ue2T/rWvnG5+r7WmwPslW7466MX5/Ue5nCo1a
	lmhF6o4gWbd1DtH0I23FLb0sIvlNYV8ialqX/Ah3RK4CbHeGYmSH0gf2zRB7MJzu
	Jrjt0wE5uY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=hTT
	KhkrpA80nyiHKPW9beuKdijLB7HihWnOBzz74PITjQ5EteECM5ZqBw4gbWK23Gg/
	yzTKjAy8vpUYYS65VT+7vqofuTlsAN/ts/JyeZt6nRjFFRZnQfYQBAyYbSrrP/4Z
	9zOI/gl8TSiuituQRqbygZGSc5wUFQJqU3RiEMHo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8011B143F0;
	Tue,  7 Oct 2014 18:30:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C05FA143EB;
	Tue,  7 Oct 2014 18:30:28 -0400 (EDT)
X-master-at: 325602ce120e7bd7321b9ed409b49b48fd20888e
X-next-at: 4587c01894e202cf47b7eeaf1c9cc40e47b01777
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A62DBBE-4E71-11E4-A178-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* mh/lockfile-stdio (2014-10-01) 3 commits
 - commit_packed_refs(): reimplement using fdopen_lock_file()
 - dump_marks(): reimplement using fdopen_lock_file()
 - fdopen_lock_file(): access a lockfile using stdio
 (this branch uses mh/lockfile.)

 Will merge to 'next'.


* rs/daemon-fixes (2014-10-01) 3 commits
  (merged to 'next' on 2014-10-07 at 4171e10)
 + daemon: remove write-only variable maxfd
 + daemon: fix error message after bind()
 + daemon: handle gethostbyname() error

 "git daemon" (with NO_IPV6 build configuration) used to incorrectly
 use the hostname even when gethostbyname() reported that the given
 hostname is not found.

 Will merge to 'master'.


* rs/sha1-array-test (2014-10-01) 2 commits
 - sha1-lookup: handle duplicates in sha1_pos()
 - sha1-array: add test-sha1-array and basic tests

 Will merge to 'next'.


* da/completion-show-signature (2014-10-07) 1 commit
  (merged to 'next' on 2014-10-07 at 2467c19)
 + completion: add --show-signature for log and show

 Will merge to 'master'.


* jk/prune-mtime (2014-10-04) 18 commits
 - write_sha1_file: freshen existing objects
 - pack-objects: match prune logic for discarding objects
 - pack-objects: refactor unpack-unreachable expiration check
 - prune: keep objects reachable from recent objects
 - sha1_file: add for_each iterators for loose and packed objects
 - count-objects: use for_each_loose_file_in_objdir
 - count-objects: do not use xsize_t when counting object size
 - prune: factor out loose-object directory traversal
 - t5304: use helper to report failure of "test foo = bar"
 - t5304: use test_path_is_* instead of "test -f"
 - reachable: clear pending array after walking it
 - clean up name allocation in prepare_revision_walk
 - object_array: add a "clear" function
 - object_array: factor out slopbuf-freeing logic
 - isxdigit: cast input to unsigned char
 - foreach_alt_odb: propagate return value from callback
 - Merge branch 'dt/cache-tree-repair' into jk/prune-mtime
 - Merge branch 'jc/reopen-lock-file' into jk/prune-mtime
 (this branch uses dt/cache-tree-repair.)

 Expecting a reroll.


* jn/parse-config-slot (2014-10-07) 2 commits
 - color_parse: do not mention variable name in error message
 - pass config slots as pointers instead of offsets

 Expecting an Ack/Sign-off or update from Jonathan on the bottom one.


* rs/mailsplit (2014-10-07) 1 commit
 - mailsplit: remove unnecessary unlink(2) call

 Will merge to 'next'.


* rs/more-uses-of-skip-prefix (2014-10-07) 1 commit
 - use skip_prefix() to avoid more magic numbers

 Will merge to 'next'.


* rs/plug-leak-in-bundle (2014-10-07) 1 commit
 - bundle: plug minor memory leak in is_tag_in_date_range()

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* rs/ref-transaction (2014-09-10) 19 commits
 . ref_transaction_commit: bail out on failure to remove a ref
 . lockfile: remove unable_to_lock_error
 . refs.c: do not permit err == NULL
 . for-each-ref.c: improve message before aborting on broken ref
 . refs.c: fix handling of badly named refs
 . branch -d: avoid repeated symref resolution
 . refs.c: change resolve_ref_unsafe reading argument to be a flags field
 . refs.c: make write_ref_sha1 static
 . fetch.c: change s_update_ref to use a ref transaction
 . refs.c: ref_transaction_commit: distinguish name conflicts from other errors
 . refs.c: pass a skip list to name_conflict_fn
 . refs.c: call lock_ref_sha1_basic directly from commit
 . refs.c: move the check for valid refname to lock_ref_sha1_basic
 . rename_ref: don't ask read_ref_full where the ref came from
 . refs.c: pass the ref log message to _create/delete/update instead of _commit
 . refs.c: add an err argument to delete_ref_loose
 . wrapper.c: add a new function unlink_or_msg
 . wrapper.c: remove/unlink_or_warn: simplify, treat ENOENT as success
 . mv test: recreate mod/ directory instead of relying on stale copy

 Expecting the final reroll.


* tr/remerge-diff (2014-09-08) 8 commits
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


* hv/submodule-config (2014-06-30) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


* jt/timer-settime (2014-08-29) 6 commits
 - use timer_settime() for new platforms
 - autoconf: check for timer_settime()
 - autoconf: check for struct itimerspec
 - autoconf: check for struct sigevent
 - autoconf: check for struct timespec
 - autoconf: check for timer_t

 Reviewed, discussed and wanting for a reroll.


* jk/pack-bitmap (2014-08-04) 1 commit
 - pack-bitmap: do not use gcc packed attribute

 Hold, waiting for Karsten's replacement.


* cb/mergetool-difftool (2014-07-21) 2 commits
 - difftool: don't assume that default sh is sane
 - mergetool: don't require a work tree for --tool-help

 Update the way the "difftool --help" shows the help message that is
 shared with the "mergetool" to reduce one shell dependency.

 Will be rerolled.


* rr/mergetool-temporary-filename-tweak (2014-08-21) 1 commit
 - Allow the user to change the temporary file name for mergetool

 Needs rerolling (new paragraph in doc seems to be in a wrong place)


* jk/tag-contains (2014-06-30) 8 commits
 . perf: add tests for tag --contains
 . tag: use commit_contains
 . commit: provide a fast multi-tip contains function
 . string-list: add pos to iterator callback
 . add functions for memory-efficient bitmaps
 . paint_down_to_common: use prio_queue
 . tag: factor out decision to stream tags
 . tag: allow --sort with -n

 Expecting a reroll.


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* rh/prompt-tests (2014-06-05) 11 commits
 - t9904: new __git_ps1 tests for Zsh
 - test-lib: make it possible to override how test code is eval'd
 - lib-prompt-tests.sh: add variable for string that encodes percent in PS1
 - lib-prompt-tests.sh: put all tests inside a function
 - t9903: move prompt tests to a new lib-prompt-tests.sh file
 - t9903: move PS1 color code variable definitions to lib-bash.sh
 - t9903: include "Bash" in test names via new $shellname var
 - t9903: run pc mode tests again with PS1 expansion disabled
 - t9903: move test name prefix to a separate variable
 - t9903: put the Bash pc mode prompt test cases in a function
 - t9903: remove Zsh test from the suite of Bash prompt tests

 Expecting a reroll to limit the damage to test_eval_; also reported
 to be broken with older zsh that are still in the field ($gmane/251231).


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


* jk/makefile (2014-02-05) 16 commits
 . FIXUP
 . move LESS/LV pager environment to Makefile
 . Makefile: teach scripts to include make variables
 . FIXUP
 . Makefile: auto-build C strings from make variables
 . Makefile: drop *_SQ variables
 . FIXUP
 . Makefile: add c-quote helper function
 . Makefile: introduce sq function for shell-quoting
 . Makefile: always create files via make-var
 . Makefile: store GIT-* sentinel files in MAKE/
 . Makefile: prefer printf to echo for GIT-*
 . Makefile: use tempfile/mv strategy for GIT-*
 . Makefile: introduce make-var helper function
 . Makefile: fix git-instaweb dependency on gitweb
 . Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

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

* dt/cache-tree-repair (2014-09-30) 1 commit
  (merged to 'next' on 2014-10-07 at 923bd93)
 + t0090: avoid passing empty string to printf %d
 (this branch is used by jk/prune-mtime.)

 This fixes a topic that has graduated to 'master'.

 Will merge to 'master'.


* bw/use-write-script-in-tests (2014-09-29) 1 commit
  (merged to 'next' on 2014-09-29 at be4056e)
 + t/lib-credential: use write_script

 Will merge to 'master'.


* bw/trace-no-inline-getnanotime (2014-09-29) 1 commit
 - trace.c: do not mark getnanotime() as "inline"

 No file-scope static variables in an inlined function, please.


* po/everyday-doc (2014-09-29) 3 commits
 - Make 'git help everyday' work
 - doc: Makefile regularise OBSOLETE_HTML list building
 - doc: modernise everyday.txt wording and format in man page style

 Looks ready for 'next' except for minor nits.


* jc/push-cert-hmac-optim (2014-09-25) 2 commits
 - receive-pack: truncate hmac early and convert only necessary bytes
 - sha1_to_hex: split out "hex-format n bytes" helper and use it
 (this branch uses jc/push-cert.)

 This is "we could do this if we wanted to", not "we measured and it
 improves performance critical codepath".

 Will perhaps drop.


* je/quiltimport-no-fuzz (2014-09-26) 2 commits
 - git-quiltimport: flip the default not to allow fuzz
 - git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".

 Waiting for an Ack.


* nd/archive-pathspec (2014-09-22) 1 commit
  (merged to 'next' on 2014-09-25 at 8806f93)
 + archive: support filtering paths with glob

 "git archive" learned to filter what gets archived with pathspec.

 Will merge to 'master'.


* so/rebase-doc-fork-point (2014-09-29) 1 commit
  (merged to 'next' on 2014-10-07 at 03d8ed6)
 + Documentation/git-rebase.txt: document when --fork-point is auto-enabled

 Will merge to 'master'.


* sk/tag-contains-wo-recursion (2014-09-23) 1 commit
 - t7004: give the test a bit more stack space

 Waiting for an Ack ($gmane/257448).


* da/include-compat-util-first-in-c (2014-09-15) 1 commit
  (merged to 'next' on 2014-10-07 at ea5bcb4)
 + cleanups: ensure that git-compat-util.h is included first

 Code clean-up.

 Will merge to 'master'.


* mh/lockfile (2014-10-01) 38 commits
 - lockfile.h: extract new header file for the functions in lockfile.c
 - hold_locked_index(): move from lockfile.c to read-cache.c
 - hold_lock_file_for_append(): restore errno before returning
 - get_locked_file_path(): new function
 - lockfile.c: rename static functions
 - lockfile: rename LOCK_NODEREF to LOCK_NO_DEREF
 - commit_lock_file_to(): refactor a helper out of commit_lock_file()
 - trim_last_path_component(): replace last_path_elm()
 - resolve_symlink(): take a strbuf parameter
 - resolve_symlink(): use a strbuf for internal scratch space
 - lockfile: change lock_file::filename into a strbuf
 - commit_lock_file(): use a strbuf to manage temporary space
 - try_merge_strategy(): use a statically-allocated lock_file object
 - try_merge_strategy(): remove redundant lock_file allocation
 - struct lock_file: declare some fields volatile
 - lockfile: avoid transitory invalid states
 - git_config_set_multivar_in_file(): avoid call to rollback_lock_file()
 - dump_marks(): remove a redundant call to rollback_lock_file()
 - api-lockfile: document edge cases
 - commit_lock_file(): rollback lock file on failure to rename
 - close_lock_file(): if close fails, roll back
 - commit_lock_file(): die() if called for unlocked lockfile object
 - commit_lock_file(): inline temporary variable
 - remove_lock_file(): call rollback_lock_file()
 - lock_file(): exit early if lockfile cannot be opened
 - prepare_index(): declare return value to be (const char *)
 - delete_ref_loose(): don't muck around in the lock_file's filename
 - cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 - lockfile.c: document the various states of lock_file objects
 - lock_file(): always initialize and register lock_file object
 - hold_lock_file_for_append(): release lock on errors
 - lockfile: unlock file if lockfile permissions cannot be adjusted
 - rollback_lock_file(): set fd to -1
 - rollback_lock_file(): exit early if lock is not active
 - rollback_lock_file(): do not clear filename redundantly
 - close_lock_file(): exit (successfully) if file is already closed
 - api-lockfile: revise and expand the documentation
 - unable_to_lock_die(): rename function from unable_to_lock_index_die()
 (this branch is used by mh/lockfile-stdio.)

 The lockfile API and its users have been cleaned up.

 Will merge to 'next'.


* nd/multiple-work-trees (2014-09-27) 32 commits
 - t2025: add a test to make sure grafts is working from a linked checkout
 - checkout: don't require a work tree when checking out into a new one
 - git_path(): keep "info/sparse-checkout" per work-tree
 - count-objects: report unused files in $GIT_DIR/worktrees/...
 - gc: support prune --worktrees
 - gc: factor out gc.pruneexpire parsing code
 - gc: style change -- no SP before closing parenthesis
 - checkout: clean up half-prepared directories in --to mode
 - checkout: reject if the branch is already checked out elsewhere
 - prune: strategies for linked checkouts
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

 A few tests need some tweaks for MinGW ($gmane/{257756,257757}).


* cc/interpret-trailers (2014-09-22) 11 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from file or stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from input message and arguments
 - trailer: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.

 Discussion on the topic with Michael Tsirkin who wants to utilize
 this machinery is going on.  Finally a real functionality review
 that is very much welcomed.


* sp/stream-clean-filter (2014-09-22) 7 commits
  (merged to 'next' on 2014-09-29 at 47fc36d)
 + sha1_file: don't convert off_t to size_t too early to avoid potential die()
 + convert: stream from fd to required clean filter to reduce used address space
 + copy_fd(): do not close the input file descriptor
 + mmap_limit: introduce GIT_MMAP_LIMIT to allow testing expected mmap size
 + memory_limit: use git_env_ulong() to parse GIT_ALLOC_LIMIT
 + config.c: add git_env_ulong() to parse environment variable
 + convert: drop arguments other than 'path' from would_convert_to_git()

 When running a required clean filter, we do not have to mmap the
 original before feeding the filter.  Instead, stream the file
 contents directly to the filter and process its output.

 Will merge to 'master'.


* jc/push-cert (2014-09-25) 24 commits
  (merged to 'next' on 2014-09-25 at 3eb1d69)
 + receive-pack::hmac_sha1(): copy the entire SHA-1 hash out
  (merged to 'next' on 2014-09-24 at a99f5d8)
 + signed push: allow stale nonce in stateless mode
 + signed push: teach smart-HTTP to pass "git push --signed" around
 + signed push: fortify against replay attacks
 + signed push: add "pushee" header to push certificate
 + signed push: remove duplicated protocol info
 + send-pack: send feature request on push-cert packet
 + receive-pack: GPG-validate push certificates
 + push: the beginning of "git push --signed"
 + pack-protocol doc: typofix for PKT-LINE
 + gpg-interface: move parse_signature() to where it should be
 + gpg-interface: move parse_gpg_output() to where it should be
 + send-pack: clarify that cmds_sent is a boolean
 + send-pack: refactor inspecting and resetting status and sending commands
 + send-pack: rename "new_refs" to "need_pack_data"
 + receive-pack: factor out capability string generation
 + send-pack: factor out capability string generation
 + send-pack: always send capabilities
 + send-pack: refactor decision to send update per ref
 + send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
 + receive-pack: factor out queueing of command
 + receive-pack: do not reuse old_sha1[] for other things
 + receive-pack: parse feature request a bit earlier
 + receive-pack: do not overallocate command structure
 (this branch is used by jc/push-cert-hmac-optim.)

 Allow "git push" request to be signed, so that it can be verified and
 audited, using the GPG signature of the person who pushed, that the
 tips of branches at a public repository really point the commits
 the pusher wanted to, without having to "trust" the server.

 Will merge to 'master'.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.

 Nobody seems to be jumping up & down requesting this last step,
 which makes the result somewhat backward incompatible.
 Will perhaps drop.
