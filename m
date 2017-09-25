Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABFD20281
	for <e@80x24.org>; Mon, 25 Sep 2017 07:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933327AbdIYHZf (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 03:25:35 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:53807 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932578AbdIYHZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 03:25:32 -0400
Received: from pb-sasl-trial2.pobox.com (localhost [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 8F27416058;
        Mon, 25 Sep 2017 03:25:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=l
        VPg0+mFFUbmK+MBKDyVgg59gu0=; b=JZfZnLng0546DXNK1e7fGi9wnP6OVaQUS
        N4lO7+aiGF6IhqXuY9V/vkve8PdKqJV5xxkbMNs838lluassoiU/zx5dMcZwy/qJ
        3pkHSaiKKGmEnBGg5FPOaqLbUqjFXEmdyQxmDjUCPGkFPf6ra13ydl8r1YtTkNaV
        X8pcdcB70g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=x6N
        p8WjxtbvbfrVMgbGZcTfinD7iidmPmWdvw3d8rC+Muuoa0NSG8HSm7BBOS53se82
        I8f/68K4lBR+EVvOBpf7Lv9PeRC2WHITeaatUoB1v2gxS3FCjNHG8cEw1NPgeHWD
        ax0fstNOHxY5wOYmKNqIchj9S/Y0cOgpFwX5Ojw8=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 674F616057;
        Mon, 25 Sep 2017 03:25:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CD28B440D;
        Mon, 25 Sep 2017 03:25:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2017, #04; Mon, 25)
X-master-at: 28996cec80690d2322359d3650a57e8de6e01eb6
X-next-at: 2c7b836f3ab9b78a2baeee97e329e4c1a1e4c005
Date:   Mon, 25 Sep 2017 16:25:26 +0900
Message-ID: <xmqq7ewndyu1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B403D99E-A1C2-11E7-9FF7-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

We are at week #8 of this cycle.  Quite a many topics that have been
in 'master' are now also merged to 'maint', so perhaps I should tag
2.14.2 soonish.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* sb/merge-commit-msg-hook (2017-09-22) 1 commit
  (merged to 'next' on 2017-09-25 at 096e0502a8)
 + Documentation/githooks: mention merge in commit-msg hook

 As "git commit" to conclude a conflicted "git merge" honors the
 commit-msg hook, "git merge" that records a merge commit that
 cleanly auto-merges should, but it didn't.


* aw/gc-lockfile-fscanf-fix (2017-09-17) 1 commit
  (merged to 'next' on 2017-09-24 at 999ccd41aa)
 + gc: call fscanf() with %<len>s, not %<len>c, when reading hostname

 "git gc" tries to avoid running two instances at the same time by
 reading and writing pid/host from and to a lock file; it used to
 use an incorrect fscanf() format when reading, which has been
 corrected.


* bb/doc-eol-dirty (2017-09-07) 1 commit
  (merged to 'next' on 2017-09-14 at 2f0cb688c6)
 + Documentation: mention that `eol` can change the dirty status of paths

 Doc update.


* bw/git-clang-format (2017-08-14) 2 commits
  (merged to 'next' on 2017-09-24 at ae51a4e81c)
 + Makefile: add style build rule
 + clang-format: outline the git project's coding style

 "make style" runs git-clang-format to help developers by pointing
 out coding style issues.


* cc/subprocess-handshake-missing-capabilities (2017-09-11) 1 commit
  (merged to 'next' on 2017-09-19 at 7d0c272bc8)
 + subprocess: loudly die when subprocess asks for an unsupported capability

 Finishing touches to a topic already in 'master'.


* dw/diff-highlight-makefile-fix (2017-09-06) 1 commit
  (merged to 'next' on 2017-09-10 at 8dfda480ac)
 + diff-highlight: add clean target to Makefile

 Build clean-up.


* ez/doc-duplicated-words-fix (2017-09-14) 1 commit
  (merged to 'next' on 2017-09-19 at 20781bd866)
 + doc: fix minor typos (extra/duplicated words)

 Typofix.


* hv/mv-nested-submodules-test (2017-09-17) 1 commit
  (merged to 'next' on 2017-09-24 at d36650bbca)
 + add test for bug in git-mv for recursive submodules

 A test to demonstrate "git mv" failing to adjust nested submodules
 has been added.


* jh/hashmap-disable-counting (2017-09-07) 1 commit
  (merged to 'next' on 2017-09-14 at bbc08f4222)
 + hashmap: add API to disable item counting when threaded

 Our hashmap implementation in hashmap.[ch] is not thread-safe when
 adding a new item needs to expand the hashtable by rehashing; add
 an API to disable the automatic rehashing to work it around.


* jk/config-lockfile-leak-fix (2017-09-06) 1 commit
  (merged to 'next' on 2017-09-10 at 7b91d71749)
 + config: use a static lock_file struct

 A leakfix.


* jk/incore-lockfile-removal (2017-09-06) 20 commits
  (merged to 'next' on 2017-09-14 at 603dae7fb2)
 + stop leaking lock structs in some simple cases
 + ref_lock: stop leaking lock_files
 + lockfile: update lifetime requirements in documentation
 + tempfile: auto-allocate tempfiles on heap
 + tempfile: remove deactivated list entries
 + tempfile: use list.h for linked list
 + tempfile: release deactivated strbufs instead of resetting
 + tempfile: robustify cleanup handler
 + tempfile: factor out deactivation
 + tempfile: factor out activation
 + tempfile: replace die("BUG") with BUG()
 + tempfile: handle NULL tempfile pointers gracefully
 + tempfile: prefer is_tempfile_active to bare access
 + lockfile: do not rollback lock on failed close
 + tempfile: do not delete tempfile on failed close
 + always check return value of close_tempfile
 + verify_signed_buffer: prefer close_tempfile() to close()
 + setup_temporary_shallow: move tempfile struct into function
 + setup_temporary_shallow: avoid using inactive tempfile
 + write_index_as_tree: cleanup tempfile on error

 The long-standing rule that an in-core lockfile instance, once it
 is used, must not be freed, has been lifted and the lockfile and
 tempfile APIs have been updated to reduce the chance of programming
 errors.


* jk/info-alternates-fix (2017-09-20) 2 commits
  (merged to 'next' on 2017-09-24 at d1594d1397)
 + read_info_alternates: warn on non-trivial errors
 + Merge branch 'jk/info-alternates-fix-2.11' into jk/info-alternates-fix
 (this branch uses jk/info-alternates-fix-2.11.)

 A regression fix for 2.11 that made the code to read the list of
 alternate object stores overrun the end of the string.


* jk/info-alternates-fix-2.11 (2017-09-20) 1 commit
 + read_info_alternates: read contents into strbuf
 (this branch is used by jk/info-alternates-fix.)

 A regression fix for 2.11 that made the code to read the list of
 alternate object stores overrun the end of the string.


* jk/leak-checkers (2017-09-08) 11 commits
  (merged to 'next' on 2017-09-20 at 5e9ba01461)
 + git-compat-util: make UNLEAK less error-prone
  (merged to 'next' on 2017-09-14 at 906ed9f590)
 + add UNLEAK annotation for reducing leak false positives
 + set_git_dir: handle feeding gitdir to itself
 + repository: free fields before overwriting them
 + reset: free allocated tree buffers
 + reset: make tree counting less confusing
 + config: plug user_config leak
 + update-index: fix cache entry leak in add_one_file()
 + add: free leaked pathspec after add_files_to_cache()
 + test-lib: set LSAN_OPTIONS to abort by default
 + test-lib: --valgrind should not override --verbose-log

 Many of our programs consider that it is OK to release dynamic
 storage that is used throughout the life of the program by simply
 exiting, but this makes it harder to leak detection tools to avoid
 reporting false positives.  Plug many existing leaks and introduce
 a mechanism for developers to mark that the region of memory
 pointed by a pointer is not lost/leaking to help these tools.


* jk/revision-remove-cmdline-pathspec (2017-09-21) 2 commits
  (merged to 'next' on 2017-09-24 at 2adfb89370)
 + pathspec doc: parse_pathspec does not maintain references to args
 + revision: replace "struct cmdline_pathspec" with argv_array

 Code clean-up that also plugs memory leaks.


* jk/shortlog-ident-cleanup (2017-09-09) 1 commit
  (merged to 'next' on 2017-09-14 at 09695b6c39)
 + shortlog: skip format/parse roundtrip for internal traversal

 Code clean-up.


* jk/system-path-cleanup (2017-09-07) 2 commits
  (merged to 'next' on 2017-09-14 at c6faaf8858)
 + git_extract_argv0_path: do nothing without RUNTIME_PREFIX
 + system_path: move RUNTIME_PREFIX to a sub-function

 Code clean-up.


* jk/write-in-full-fix (2017-09-14) 8 commits
  (merged to 'next' on 2017-09-19 at 7b26691c07)
 + read_pack_header: handle signed/unsigned comparison in read result
 + config: flip return value of store_write_*()
 + notes-merge: use ssize_t for write_in_full() return value
 + pkt-line: check write_in_full() errors against "< 0"
 + convert less-trivial versions of "write_in_full() != len"
 + avoid "write_in_full(fd, buf, len) != len" pattern
 + get-tar-commit-id: check write_in_full() return against 0
 + config: avoid "write_in_full(fd, buf, len) < len" pattern

 Many codepaths did not diagnose write failures correctly when disks
 go full, due to their misuse of write_in_full() helper function,
 which have been corrected.


* jn/per-repo-object-store-fixes (2017-09-14) 3 commits
  (merged to 'next' on 2017-09-19 at 95aef30d5b)
 + replace-objects: evaluate replacement refs without using the object store
 + push, fetch: error out for submodule entries not pointing to commits
 + pack: make packed_git_mru global a value instead of a pointer

 Step #0 of a planned & larger series to make the in-core object
 store per in-core repository object.


* jt/packmigrate (2017-09-06) 1 commit
  (merged to 'next' on 2017-09-14 at 169e9573a0)
 + Remove inadvertently added outgoing/packfile.h

 Remove unneeded file added by a topic already in 'master'.


* kd/doc-for-each-ref (2017-09-12) 2 commits
  (merged to 'next' on 2017-09-19 at 993a2ae375)
 + doc/for-each-ref: explicitly specify option names
 + doc/for-each-ref: consistently use '=' to between argument names and values

 Doc update.


* ks/commit-do-not-touch-cut-line (2017-09-15) 1 commit
  (merged to 'next' on 2017-09-19 at 83891def6b)
 + commit-template: change a message to be more intuitive

 The explanation of the cut-line in the commit log editor has been
 slightly tweaked.


* ks/help-alias-label (2017-09-14) 1 commit
  (merged to 'next' on 2017-09-19 at 7737c853e0)
 + help: change a message to be more precise

 "git help co" now says "co is aliased to ...", not "git co is".


* ks/test-readme-phrasofix (2017-09-19) 1 commit
  (merged to 'next' on 2017-09-24 at 3a721d05f5)
 + t/README: fix typo and grammatically improve a sentence

 Doc updates.


* kw/merge-recursive-cleanup (2017-09-08) 3 commits
  (merged to 'next' on 2017-09-14 at 9f20025e6b)
 + merge-recursive: change current file dir string_lists to hashmap
 + merge-recursive: remove return value from get_files_dirs
 + merge-recursive: fix memory leak

 A leakfix and code clean-up.


* kw/write-index-reduce-alloc (2017-09-08) 2 commits
  (merged to 'next' on 2017-09-19 at d0e32c567a)
 + read-cache: fix index corruption with index v4
 + Add t/helper/test-write-cache to .gitignore

 A hotfix to a topic already in 'master'.


* ls/travis-scriptify (2017-09-22) 4 commits
  (merged to 'next' on 2017-09-24 at 6e808f0472)
 + travis-ci: fix "skip_branch_tip_with_tag()" string comparison
  (merged to 'next' on 2017-09-14 at 8fa685d3b7)
 + travis: dedent a few scripts that are indented overly deeply
 + travis-ci: skip a branch build if equal tag is present
 + travis-ci: move Travis CI code into dedicated scripts

 The scripts to drive TravisCI has been reorganized and then an
 optimization to avoid spending cycles on a branch whose tip is
 tagged has been implemented.


* ma/pkt-line-leakfix (2017-09-06) 1 commit
  (merged to 'next' on 2017-09-10 at f0d9994319)
 + pkt-line: re-'static'-ify buffer in packet_write_fmt_1()

 A leakfix.


* ma/remove-config-maybe-bool (2017-09-07) 1 commit
  (merged to 'next' on 2017-09-14 at d0c7fb97a9)
 + config: remove git_config_maybe_bool

 Finishing touches to a recent topic.


* ma/split-symref-update-fix (2017-09-10) 4 commits
  (merged to 'next' on 2017-09-10 at 96c403fca7)
 + refs/files-backend: add `refname`, not "HEAD", to list
 + refs/files-backend: correct return value in lock_ref_for_update
 + refs/files-backend: fix memory leak in lock_ref_for_update
 + refs/files-backend: add longer-scoped copy of string to list

 A leakfix.


* mg/name-rev-tests-with-short-stack (2017-09-08) 4 commits
  (merged to 'next' on 2017-09-14 at 1e4a0fe206)
 + t6120: test describe and name-rev with deep repos
 + t6120: clean up state after breaking repo
 + t6120: test name-rev --all and --stdin
 + t7004: move limited stack prereq to test-lib
 (this branch is used by rj/test-ulimit-on-windows.)

 A handful of tests to demonstrates a recursive implementation of
 "name-rev" hurts.


* mg/timestamp-t-fix (2017-09-06) 1 commit
  (merged to 'next' on 2017-09-10 at a5df4d5b3e)
 + name-rev: change ULONG_MAX to TIME_MAX

 A mismerge fix.


* mh/for-each-string-list-item-empty-fix (2017-09-20) 1 commit
  (merged to 'next' on 2017-09-24 at 7ca1782f86)
 + for_each_string_list_item: avoid undefined behavior for empty list

 Code cmp.std.c nitpick.


* mh/notes-cleanup (2017-09-09) 13 commits
  (merged to 'next' on 2017-09-10 at cb1d725504)
 + load_subtree(): check that `prefix_len` is in the expected range
  (merged to 'next' on 2017-08-26 at 2d6df46966)
 + load_subtree(): declare some variables to be `size_t`
 + hex_to_bytes(): simpler replacement for `get_oid_hex_segment()`
 + get_oid_hex_segment(): don't pad the rest of `oid`
 + load_subtree(): combine some common code
 + get_oid_hex_segment(): return 0 on success
 + load_subtree(): only consider blobs to be potential notes
 + load_subtree(): check earlier whether an internal node is a tree entry
 + load_subtree(): separate logic for internal vs. terminal entries
 + load_subtree(): fix incorrect comment
 + load_subtree(): reduce the scope of some local variables
 + load_subtree(): remove unnecessary conditional
 + notes: make GET_NIBBLE macro more robust

 Code clean-up.


* mh/packed-ref-store-prep (2017-09-07) 1 commit
  (merged to 'next' on 2017-09-14 at e3ef821847)
 + rev-parse: don't trim bisect refnames

 Fix regression to "gitk --bisect" by a recent update.


* mh/packed-ref-transactions (2017-09-09) 11 commits
  (merged to 'next' on 2017-09-14 at b926200d45)
 + files_transaction_finish(): delete reflogs before references
 + packed-backend: rip out some now-unused code
 + files_ref_store: use a transaction to update packed refs
 + t1404: demonstrate two problems with reference transactions
 + files_initial_transaction_commit(): use a transaction for packed refs
 + prune_refs(): also free the linked list
 + files_pack_refs(): use a reference transaction to write packed refs
 + packed_delete_refs(): implement method
 + packed_ref_store: implement reference transactions
 + struct ref_transaction: add a place for backends to store data
 + packed-backend: don't adjust the reference count on lock/unlock
 (this branch is used by mh/mmap-packed-refs.)

 Implement transactional update to the packed-ref representation of
 references.


* nd/prune-in-worktree (2017-08-24) 16 commits
  (merged to 'next' on 2017-09-14 at 3efe283118)
 + refs.c: reindent get_submodule_ref_store()
 + refs.c: remove fallback-to-main-store code get_submodule_ref_store()
 + rev-list: expose and document --single-worktree
 + revision.c: --reflog add HEAD reflog from all worktrees
 + files-backend: make reflog iterator go through per-worktree reflog
 + revision.c: --all adds HEAD from all worktrees
 + refs: remove dead for_each_*_submodule()
 + refs.c: move for_each_remote_ref_submodule() to submodule.c
 + revision.c: use refs_for_each*() instead of for_each_*_submodule()
 + refs: add refs_head_ref()
 + refs: move submodule slash stripping code to get_submodule_ref_store
 + refs.c: refactor get_submodule_ref_store(), share common free block
 + revision.c: --indexed-objects add objects from all worktrees
 + revision.c: refactor add_index_objects_to_pending()
 + refs.c: use is_dir_sep() in resolve_gitlink_ref()
 + revision.h: new flag in struct rev_info wrt. worktree-related refs

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.


* nm/imap-send-with-curl (2017-09-15) 4 commits
  (merged to 'next' on 2017-09-19 at d07debeb6c)
 + imap-send: use curl by default when possible
 + imap_send: setup_curl: retreive credentials if not set in config file
 + imap-send: add wrapper to get server credentials if needed
 + imap-send: return with error if curl failed

 "git imap-send" has our own implementation of the protocol and also
 can use more recent libCurl with the imap protocol support.  Update
 the latter so that it can use the credential subsystem, and then
 make it the default option to use, so that we can eventually
 deprecate and remove the former.


* nm/pull-submodule-recurse-config (2017-09-07) 2 commits
  (merged to 'next' on 2017-09-14 at 38bf2c88e0)
 + pull: honor submodule.recurse config option
 + pull: fix cli and config option parsing order

 "git -c submodule.recurse=yes pull" did not work as if the
 "--recurse-submodules" option was given from the command line.
 This has been corrected.


* ow/rev-parse-is-shallow-repo (2017-09-19) 1 commit
  (merged to 'next' on 2017-09-24 at 8f1b915908)
 + rev-parse: rev-parse: add --is-shallow-repository

 "git rev-parse" learned "--is-shallow-repository", that is to be
 used in a way similar to existing "--is-bare-repository" and
 friends.


* rj/test-ulimit-on-windows (2017-09-19) 3 commits
  (merged to 'next' on 2017-09-24 at b01a595c05)
 + t9010-*.sh: skip all tests if the PIPE prereq is missing
 + test-lib: use more compact expression in PIPE prerequisite
 + test-lib: don't use ulimit in test prerequisites on cygwin
 (this branch uses mg/name-rev-tests-with-short-stack.)

 On Cygwin, "ulimit -s" does not report failure but it does not work
 at all, which causes an unexpected success of some tests that
 expect failures under a limited stack situation.  This has been
 fixed.


* rk/commit-tree-make-F-verbatim (2017-09-10) 1 commit
  (merged to 'next' on 2017-09-14 at 3d40c900f3)
 + commit-tree: do not complete line in -F input

 Unlike "git commit-tree < file", "git commit-tree -F file" did not
 pass the contents of the file verbatim and instead completed an
 incomplete line at the end, if exists.  The latter has been updated
 to match the behaviour of the former.


* rs/archive-excluded-directory (2017-09-14) 1 commit
  (merged to 'next' on 2017-09-19 at c695db3039)
 + archive: don't add empty directories to archives

 "git archive", especially when used with pathspec, stored an empty
 directory in its output, even though Git itself never does so.
 This has been fixed.


* rs/strbuf-leakfix (2017-09-10) 34 commits
  (merged to 'next' on 2017-09-14 at bb46952e6a)
 + wt-status: release strbuf after use in wt_longstatus_print_tracking()
 + wt-status: release strbuf after use in read_rebase_todolist()
 + vcs-svn: release strbuf after use in end_revision()
 + utf8: release strbuf on error return in strbuf_utf8_replace()
 + userdiff: release strbuf after use in userdiff_get_textconv()
 + transport-helper: release strbuf after use in process_connect_service()
 + sequencer: release strbuf after use in save_head()
 + shortlog: release strbuf after use in insert_one_record()
 + sha1_file: release strbuf on error return in index_path()
 + send-pack: release strbuf on error return in send_pack()
 + remote: release strbuf after use in set_url()
 + remote: release strbuf after use in migrate_file()
 + remote: release strbuf after use in read_remote_branches()
 + refs: release strbuf on error return in write_pseudoref()
 + notes: release strbuf after use in notes_copy_from_stdin()
 + merge: release strbuf after use in write_merge_heads()
 + merge: release strbuf after use in save_state()
 + mailinfo: release strbuf on error return in handle_boundary()
 + mailinfo: release strbuf after use in handle_from()
 + help: release strbuf on error return in exec_woman_emacs()
 + help: release strbuf on error return in exec_man_man()
 + help: release strbuf on error return in exec_man_konqueror()
 + diff: release strbuf after use in show_stats()
 + diff: release strbuf after use in show_rename_copy()
 + diff: release strbuf after use in diff_summary()
 + convert: release strbuf on error return in filter_buffer_or_fd()
 + connect: release strbuf on error return in git_connect()
 + commit: release strbuf on error return in commit_tree_extended()
 + clone: release strbuf after use in remove_junk()
 + clean: release strbuf after use in remove_dirs()
 + check-ref-format: release strbuf after use in check_ref_format_branch()
 + am: release strbuf after use in safe_to_abort()
 + am: release strbuf on error return in hg_patch_to_mail()
 + am: release strbufs after use in detect_patch_format()

 Many leaks of strbuf have been fixed.


* tb/test-lint-echo-e (2017-09-21) 1 commit
  (merged to 'next' on 2017-09-24 at dfa5caa4ce)
 + test-lint: echo -e (or -E) is not portable

 The test linter has been taught that we do not like "echo -e".


* tg/refs-allowed-flags (2017-09-14) 1 commit
  (merged to 'next' on 2017-09-19 at 407066a925)
 + refs: strip out not allowed flags from ref_transaction_update

 API error-proofing which happens to also squelch warnings from GCC.


* ti/external-sha1dc (2017-08-16) 2 commits
  (merged to 'next' on 2017-08-26 at a0fb4e91a5)
 + sha1dc: allow building with the external sha1dc library
 + sha1dc: build git plumbing code more explicitly

 Platforms that ship with a separate sha1 with collision detection
 library can link to it instead of using the copy we ship as part of
 our source tree.

--------------------------------------------------
[New Topics]

* sb/merge-commit-msg-hook (2017-09-22) 1 commit
  (merged to 'next' on 2017-09-25 at 096e0502a8)
 + Documentation/githooks: mention merge in commit-msg hook

 Add documentation for a topic that has recently graduated to the
 'master' branch.

 Will merge to 'master'.


* jk/describe-omit-some-refs (2017-09-17) 1 commit
  (merged to 'next' on 2017-09-24 at c373c71279)
 + describe: fix matching to actually match all patterns
 (this branch is used by mk/describe-match-with-all.)

 "git describe --match" learned to take multiple patterns in v2.13
 series, but the feature ignored the patterns after the first one
 and did not work at all.  This has been fixed.

 Will merge to 'master'.


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
 - git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.

 Needs a test, perhaps as a follow-up patch.


* mg/merge-base-fork-point (2017-09-17) 3 commits
 - merge-base: find fork-point outside partial reflog
 - merge-base: return fork-point outside reflog
 - t6010: test actual test output

 "merge-base --fork-point $branch $commit" is used to guess on which
 commit among the commits that were once at the tip of the $branch the
 $commit was built on top of, and it learns these historical tips from
 the reflog of the $branch.  When the true fork-point is lost due to
 pruning of old reflog entries, the command does not give any output,
 because it has no way to guess correctly and does not want to mislead
 the user with a wrong guess.

 The command has been updated to give the best but not known to be
 correct guess, based on a hope that a merge-base between $commit and a
 virtual merge across all the reflog entries that still are available
 for $branch may still be a closer to the true fork-point than the
 merge-base between $commit and the current tip of the $branch.

 This may have to be offered by an additional option, to allow the
 users that are prepared to see a potentially incorrect guess to opt
 into the feature, without affecting the current callers that may not
 be prepared to accept a guess that is not known to be correct.


* bc/rev-parse-parseopt-fix (2017-09-25) 7 commits
 - parse-options: only insert newline in help text if needed
 - parse-options: write blank line to correct output stream
 - t0040,t1502: Demonstrate parse_options bugs
  (merged to 'next' on 2017-09-24 at e479bce0ff)
 + git-rebase: don't ignore unexpected command line arguments
 + rev-parse parseopt: interpret any whitespace as start of help text
 + rev-parse parseopt: do not search help text for flag chars
 + t1502: demonstrate rev-parse --parseopt option mis-parsing

 Recent versions of "git rev-parse --parseopt" did not parse the
 option specification that does not have the optional flags (*=?!)
 correctly, which has been corrected.

 Will merge to 'next'.


* ds/find-unique-abbrev-optim (2017-09-19) 4 commits
 - SQUASH???
 - sha1_name: parse less while finding common prefix
 - sha1_name: unroll len loop in find_unique_abbrev_r()
 - sha1_name: create perf test for find_unique_abbrev()


* ic/fix-filter-branch-to-handle-tag-without-tagger (2017-09-22) 4 commits
  (merged to 'next' on 2017-09-25 at c7550033df)
 + filter-branch: use hash-object instead of mktag
 + filter-branch: stash away ref map in a branch
 + filter-branch: preserve and restore $GIT_AUTHOR_* and $GIT_COMMITTER_*
 + filter-branch: reset $GIT_* before cleaning up

 "git filter-branch" cannot reproduce a history with a tag without
 the tagger field, which only ancient versions of Git allowed to be
 created.  This has been corrected.

 Will merge to 'master'.


* jm/status-ignored-directory-optim (2017-09-19) 1 commit
  (merged to 'next' on 2017-09-24 at ca50f5ed41)
 + Improve performance of git status --ignored

 "git status --ignored", when noticing that a directory without any
 tracked path is ignored, still enumerated all the ignored paths in
 the directory, which is unnecessary.  The codepath has been
 optimized to avoid this overhead.

 Will merge to 'master'.


* js/win32-lazyload-dll (2017-09-20) 1 commit
 - Win32: simplify loading of DLL functions

 Add a helper in anticipation for its need in a future topic RSN.

 Expecting a reroll.
 cf. <xmqqwp4sk21s.fsf@gitster.mtv.corp.google.com>


* ks/doc-use-camelcase-for-config-name (2017-09-25) 1 commit
 - doc: camelCase the config variables to improve readability

 Doc update.

 Will merge to 'next'.


* mk/describe-match-with-all (2017-09-20) 2 commits
  (merged to 'next' on 2017-09-24 at f96d58dd83)
 + describe: teach --match to handle branches and remotes
 + Merge branch 'jk/describe-omit-some-refs' into mk/describe-match-with-all
 (this branch uses jk/describe-omit-some-refs.)

 "git describe --match <pattern>" has been taught to play well with
 the "--all" option.

 Will merge to 'master'.


* jt/fast-export-copy-modify-fix (2017-09-21) 1 commit
  (merged to 'next' on 2017-09-24 at c02bfe1902)
 + fast-export: do not copy from modified file

 "git fast-export" with -M/-C option issued "copy" instruction on a
 path that is simultaneously modified, which was incorrect.

 Will merge to 'master'.


* ma/leakplugs (2017-09-24) 6 commits
  (merged to 'next' on 2017-09-25 at 69d381a96a)
 + pack-bitmap[-write]: use `object_array_clear()`, don't leak
 + object_array: add and use `object_array_pop()`
 + object_array: use `object_array_clear()`, not `free()`
 + leak_pending: use `object_array_clear()`, not `free()`
 + commit: fix memory leak in `reduce_heads()`
 + builtin/commit: fix memory leak in `prepare_index()`

 Memory leaks in various codepaths have been plugged.

 Will merge to 'master'.


* hn/typofix (2017-09-22) 1 commit
  (merged to 'next' on 2017-09-25 at 489ad60f5b)
 + submodule.h: typofix

 Will merge to 'master'.


* jk/diff-blob (2017-09-22) 1 commit
  (merged to 'next' on 2017-09-25 at 38286c8ff5)
 + cat-file: handle NULL object_context.path

 "git cat-file --textconv" started segfaulting recently, which
 has been corrected.

 Will merge to 'master'.


* jk/fallthrough (2017-09-22) 3 commits
  (merged to 'next' on 2017-09-25 at ad96c37620)
 + consistently use "fallthrough" comments in switches
 + curl_trace(): eliminate switch fallthrough
 + test-line-buffer: simplify command parsing

 Many codepaths have been updated to squelch -Wimplicit-fallthrough
 warnings from Gcc 7 (which is a good code hygiene).

 Will merge to 'master'.


* rj/no-sign-compare (2017-09-22) 4 commits
  (merged to 'next' on 2017-09-25 at 71ee264ce6)
 + ALLOC_GROW: avoid -Wsign-compare warnings
 + cache.h: hex2chr() - avoid -Wsign-compare warnings
 + commit-slab.h: avoid -Wsign-compare warnings
 + git-compat-util.h: xsize_t() - avoid -Wsign-compare warnings

 Many codepaths have been updated to squelch -Wsign-compare
 warnings.

 Will merge to 'master'.


* cc/perf-run-config (2017-09-24) 9 commits
 - perf: store subsection results in "test-results/$GIT_PERF_SUBSECTION/"
 - perf/run: show name of rev being built
 - perf/run: add run_subsection()
 - perf/run: update get_var_from_env_or_config() for subsections
 - perf/run: add get_subsections()
 - perf/run: add calls to get_var_from_env_or_config()
 - perf/run: add GIT_PERF_DIRS_OR_REVS
 - perf/run: add get_var_from_env_or_config()
 - perf/run: add '--config' option to the 'run' script

 Needs review.


* ik/userdiff-html-h-element-fix (2017-09-24) 1 commit
  (merged to 'next' on 2017-09-25 at e3cbe89672)
 + userdiff: fix HTML hunk header regexp

 The built-in pattern to detect the "function header" for HTML did
 not match <H1>..<H6> elements without any attributes, which has
 been fixed.

 Will merge to 'master'.


* jk/doc-read-tree-table-asciidoctor-fix (2017-09-24) 1 commit
  (merged to 'next' on 2017-09-25 at 070163b964)
 + doc: put literal block delimiter around table

 A docfix.

 Will merge to 'master'.


* mg/merge-pre-merge-hook (2017-09-24) 4 commits
 - t7503: add tests for pre-merge-hook
 - merge: --no-verify to bypass pre-merge hook
 - merge: do no-verify like commit
 - git-merge: honor pre-merge hook

 "git merge" learned a 'pre-merge' hook, that would be triggered
 before the merge commit is created by a clean auto-merge.

 Waiting for review to conclude.


* rs/mailinfo-qp-decode-fix (2017-09-24) 1 commit
  (merged to 'next' on 2017-09-25 at d48c594041)
 + mailinfo: don't decode invalid =XY quoted-printable sequences

 "git mailinfo" was loose in decoding quoted printable and produced
 garbage when the two letters after the equal sign are not
 hexadecimal.  This has been fixed.

 Will merge to 'master'.


* rs/resolve-ref-optional-result (2017-09-24) 3 commits
  (merged to 'next' on 2017-09-25 at b0f31228bb)
 + refs: pass NULL to resolve_ref_unsafe() if hash is not needed
 + refs: pass NULL to refs_resolve_ref_unsafe() if hash is not needed
 + refs: make sha1 output parameter of refs_resolve_ref_unsafe() optional

 Code clean-up.

 Will merge to 'master'.


* sb/doc-config-submodule-update (2017-09-24) 1 commit
  (merged to 'next' on 2017-09-25 at 447014b4ce)
 + Documentation/config: clarify the meaning of submodule.<name>.update

 Will merge to 'master'.


* jc/merge-x-theirs-docfix (2017-09-25) 1 commit
 - merge-strategies: avoid implying that "-s theirs" exists

 The documentation for '-X<option>' for merges was misleadingly
 written to suggest that "-s theirs" exists, which is not the case.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).


* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>


* sg/clone-refspec-from-command-line-config (2017-06-16) 2 commits
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch
 (this branch is used by sg/remote-no-string-refspecs.)

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Waiting for a response.
 cf. <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
 cf. <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com>

--------------------------------------------------
[Cooking]

* js/rebase-i-final (2017-07-27) 10 commits
 - rebase -i: rearrange fixup/squash lines using the rebase--helper
 - t3415: test fixup with wrapped oneline
 - rebase -i: skip unnecessary picks using the rebase--helper
 - rebase -i: check for missing commits in the rebase--helper
 - t3404: relax rebase.missingCommitsCheck tests
 - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 - rebase -i: remove useless indentation
 - rebase -i: generate the script via rebase--helper
 - t3415: verify that an empty instructionFormat is handled as before

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.

 Will merge to 'next'.


* mk/diff-delta-avoid-large-offset (2017-08-11) 1 commit
 - diff-delta: do not allow delta offset truncation

 The delta format used in the packfile cannot reference data at
 offset larger than what can be expressed in 4-byte, but the
 generator for the data failed to make sure the offset does not
 overflow.  This has been corrected.

 Will merge to 'next'.


* mk/diff-delta-uint-may-be-shorter-than-ulong (2017-08-10) 1 commit
 - diff-delta: fix encoding size that would not fit in "unsigned int"

 The machinery to create xdelta used in pack files received the
 sizes of the data in size_t, but lost the higher bits of them by
 storing them in "unsigned int" during the computation, which is
 fixed.

 Will merge to 'next'.


* bp/fsmonitor (2017-09-24) 12 commits
 - fsmonitor: add a performance test
 - fsmonitor: add a sample integration script for Watchman
 - fsmonitor: add test cases for fsmonitor extension
 - split-index: disable the fsmonitor extension when running the split index test
 - fsmonitor: add a test tool to dump the index extension
 - update-index: add fsmonitor support to update-index
 - ls-files: Add support in ls-files to display the fsmonitor valid bit
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - update-index: add a new --force-write-index option
 - preload-index: add override to enable testing preload-index
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status" and other
 operations that need to see which paths have been modified.

 Looking mostly ready.  Further comments?


* bw/protocol-v1 (2017-09-21) 9 commits
 - i5700: add interop test for protocol transition
 - http: tell server that the client understands v1
 - connect: tell server that the client understands v1
 - connect: teach client to recognize v1 server response
 - upload-pack, receive-pack: introduce protocol version 1
 - daemon: recognize hidden request arguments
 - protocol: introduce protocol extention mechanisms
 - connect: die when a capability line comes after a ref
 - pkt-line: add packet_write function

 A new mechanism to upgrade the wire protocol in place is proposed
 and demonstrated that it works with the older versions of Git
 without harming them.

 Expecting a reroll,
 together with Jonathan's update to get_remote_heads()
 cf. <20170922201551.15012-1-jonathantanmy@google.com>


* mh/mmap-packed-refs (2017-09-24) 22 commits
 - SQUASH???
 - packed-backend.c: rename a bunch of things and update comments
 - mmapped_ref_iterator: inline into `packed_ref_iterator`
 - ref_cache: remove support for storing peeled values
 - packed_ref_store: get rid of the `ref_cache` entirely
 - ref_store: implement `refs_peel_ref()` generically
 - packed_read_raw_ref(): read the reference from the mmapped buffer
 - packed_ref_iterator_begin(): iterate using `mmapped_ref_iterator`
 - read_packed_refs(): ensure that references are ordered when read
 - packed_ref_cache: keep the `packed-refs` file mmapped if possible
 - packed-backend.c: reorder some definitions
 - mmapped_ref_iterator_advance(): no peeled value for broken refs
 - mmapped_ref_iterator: add iterator over a packed-refs file
 - packed_ref_cache: remember the file-wide peeling state
 - read_packed_refs(): read references with minimal copying
 - read_packed_refs(): make parsing of the header line more robust
 - read_packed_refs(): only check for a header at the top of the file
 - read_packed_refs(): use mmap to read the `packed-refs` file
 - die_unterminated_line(), die_invalid_line(): new functions
 - packed_ref_cache: add a backlink to the associated `packed_ref_store`
 - prefix_ref_iterator: break when we leave the prefix
 - ref_iterator: keep track of whether the iterator output is ordered

 Operations that do not touch (majority of) packed refs have been
 optimized by making accesses to packed-refs file lazy; we no longer
 pre-parse everything, and an access to a single ref in the
 packed-refs does not touch majority of irrelevant refs, either.

 Under review; expecting an eventual reroll.
 cf. <b092c424-987a-fe00-43d4-17062000dfc0@alum.mit.edu> etc.


* pc/submodule-helper (2017-09-25) 4 commits
 - submodule: port submodule subcommand 'status' from shell to C
 - submodule: port set_name_rev() from shell to C
 - submodule--helper: introduce for_each_listed_submodule()
 - submodule--helper: introduce get_submodule_displaypath()

 GSoC.

 Looking good; it appeared to me that 3/4 is totally superfluous, though.


* sb/parse-options-blank-line-before-option-list (2017-08-25) 1 commit
 - usage_with_options: omit double new line on empty option list

 "git worktree" with no option and no subcommand showed too many
 blank lines in its help text, which has been reduced.

 Superseded by bc/rev-parse-parseopt-fix?


* bc/hash-algo (2017-08-20) 5 commits
 - hash-algo: switch empty tree and blob lookups to use hash abstraction
 - hash-algo: integrate hash algorithm support with repo setup
 - hash-algo: add structure representing hash algorithm
 - setup: expose enumerated repo info
 - Merge branch 'bc/vcs-svn-cleanup' into bc/hash-algo

 RFC
 cf. <20170821000022.26729-1-sandals@crustytoothpaste.net>


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Will be rerolled after tc/curl-with-backports stabilizes.


* sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
 - Documentation/checkout: clarify submodule HEADs to be detached
 - recursive submodules: detach HEAD from new state

 "git checkout --recursive" may overwrite and rewind the history of
 the branch that happens to be checked out in submodule
 repositories, which might not be desirable.  Detach the HEAD but
 still allow the recursive checkout to succeed in such a case.

 Undecided.
 This needs justification in a larger picture; it is unclear why
 this is better than rejecting recursive checkout, for example.


* jk/check-ref-format-oor-fix (2017-07-14) 1 commit
 - check-ref-format: require a repository for --branch

 Discussion slowly continues...
 cf. <20170717172709.GL93855@aiede.mtv.corp.google.com>
 cf. <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>


* rs/sha1-file-micro-optim (2017-07-09) 2 commits
 - SQUASH???
 - sha1_file: add slash once in for_each_file_in_obj_subdir()

 Code cleanup.

 Perhaps drop.
 cf. <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>


* jc/allow-lazy-cas (2017-07-06) 1 commit
 - push: disable lazy --force-with-lease by default

 Because "git push --force-with-lease[=<ref>]" that relies on the
 stability of remote-tracking branches is unsafe when something
 fetches into the repository behind user's back, it is now disabled
 by default.  A new configuration variable can be used to enable it
 by users who know what they are doing.  This would pave the way to
 possibly turn `--force` into `--force-with-lease`.

 Will discard.
 Independent from disabling the feature by default, this stirred up
 a discussion to replace the DWIM heuristics with a better one, which
 deserves to be its own topic.
 cf. <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-08-14 at 24db08a6e8)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.
 As the draft RelNotes says, let's merge this to 'master' after
 this release cycle.


* sd/branch-copy (2017-09-24) 4 commits
 - branch: fix "copy" to never touch HEAD
 - branch: add a --copy (-c) option to go with --move (-m)
 - branch: add test for -m renaming multiple config sections
 - config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 Will merge to 'next'.

--------------------------------------------------
[Discarded]

* jc/apply-with-crlf (2017-08-16) 5 commits
 . apply: clarify read_old_data() is about no-index case
 . apply: localize the CRLF business to read_old_data()
 . apply: only pay attention to CRLF in the preimage
 . apply: remove unused field apply_state.flags
 . apply: file commited with CRLF should roundtrip diff and apply

 This served as an input to updated tb/apply-with-crlf.


* jn/per-repo-obj-store (2017-09-07) 39 commits
 . pack: allow sha1_loose_object_info to handle arbitrary repositories
 . pack: allow map_sha1_file to handle arbitrary repositories
 . pack: allow map_sha1_file_1 to handle arbitrary repositories
 . pack: allow open_sha1_file to handle arbitrary repositories
 . pack: allow stat_sha1_file to handle arbitrary repositories
 . pack: allow sha1_file_name to handle arbitrary repositories
 . pack: allow reprepare_packed_git to handle arbitrary repositories
 . pack: allow prepare_packed_git to handle arbitrary repositories
 . pack: allow prepare_packed_git_one to handle arbitrary repositories
 . pack: allow prepare_packed_git_mru to handle arbitrary repositories
 . pack: allow rearrange_packed_git to handle arbitrary repositories
 . pack: allow install_packed_git to handle arbitrary repositories
 . object-store: allow foreach_alt_odb to handle arbitrary repositories
 . object-store: allow prepare_alt_odb to handle arbitrary repositories
 . sha1_file: allow alt_odb_usable to handle arbitrary repositories
 . pack: add repository argument to map_sha1_file
 . pack: add repository argument to sha1_file_name
 . pack: add repository argument to reprepare_packed_git
 . pack: add repository argument to prepare_packed_git
 . pack: add repository argument to prepare_packed_git_mru
 . pack: add repository argument to rearrange_packed_git
 . pack: add repository argument to prepare_packed_git_one
 . pack: add repository argument to install_packed_git
 . object-store: add repository argument to foreach_alt_odb
 . object-store: add repository argument to prepare_alt_odb
 . sha1_file: add repository argument to sha1_loose_object_info
 . sha1_file: add repository argument to map_sha1_file_1
 . sha1_file: add repository argument to open_sha1_file
 . sha1_file: add repository argument to stat_sha1_file
 . sha1_file: add repository argument to link_alt_odb_entries
 . sha1_file: add repository argument to read_info_alternates
 . sha1_file: add repository argument to link_alt_odb_entry
 . sha1_file: add repository argument to alt_odb_usable
 . pack: move approximate object count to object store
 . pack: move prepare_packed_git_run_once to object store
 . object-store: move packed_git and packed_git_mru to object store
 . object-store: move alt_odb_list and alt_odb_tail to object store
 . repository: introduce object store field
 . pack: make packed_git_mru global a value instead of a pointer

 We now can have separate instances of in-core object store per
 repository we visit.

 Will be rerolled.
