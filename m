Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B92120286
	for <e@80x24.org>; Mon, 11 Sep 2017 01:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbdIKBig (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 21:38:36 -0400
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:56744 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdIKBid (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 21:38:33 -0400
Received: from pb-sasl-trial3.pobox.com (localhost [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 81AC31B6E2;
        Sun, 10 Sep 2017 21:38:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=V
        OUg6dey5YVtgnxi6dmgJ7ylbLE=; b=YyCPjBUvY2zElyZnphyrXpZyyUj8BdhZi
        Kx5apm8HSbUa44NjYpcpT0vpf/JcolywrcFLRX4I4XtdWyvZ8CnCO8MkiVYC4R60
        lYnHY/4fpl2n090DRm4gmEKJvX83BIIdTfohhBQWqdo2NmBYlXLTkjMcZqbeFeMU
        ExRpudtkhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=v30
        0r9Js6V6NDCQPM4HB9kORZd/MDaRyLWVcIH0Q1XzXEHW7/xqicmZV9gMCB8VN+dO
        U6egDfMUTJjYhSGwpSBG1y7AlUq4T4WwIDZDLSURsY2I1khmIKLfEmyN2uXXaccN
        RLBMulPfz/+VnQ6JVYcL7SAkS+dsEd7awSPtDhWY=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 6E3D81B6E1;
        Sun, 10 Sep 2017 21:38:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6FB190B33;
        Sun, 10 Sep 2017 21:38:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2017, #02; Mon, 11)
X-master-at: 6867272d5b5615bd74ec97bf35b4c4a8d9fe3a51
X-next-at: bb1197296efa678ff409ab67d32a984cae7b07a6
Date:   Mon, 11 Sep 2017 10:38:20 +0900
Message-ID: <xmqqpoay3tgz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8D7450C-9691-11E7-AF82-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

We are at week #6 of this cycle.  It seems that people had a
productive week while I was away, which I am reasonably happy about
;-)  Quite a many topics that have been in 'master' are now also
merged to 'maint', so perhaps I should tag 2.14.2 soonish.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/drop-sha1-entry-pos (2017-08-25) 1 commit
  (merged to 'next' on 2017-08-25 at 7ef03bb281)
 + sha1-lookup: remove sha1_entry_pos() from header file

 Code clean-up.


* ls/convert-filter-progress (2017-08-24) 1 commit
  (merged to 'next' on 2017-08-25 at ce0bb30e8f)
 + convert: display progress for filtered objects that have been delayed

 The codepath to call external process filter for smudge/clean
 operation learned to show the progress meter.


* ma/ts-cleanups (2017-08-23) 4 commits
  (merged to 'next' on 2017-08-25 at e0e8cc53ec)
 + ThreadSanitizer: add suppressions
 + strbuf_setlen: don't write to strbuf_slopbuf
 + pack-objects: take lock before accessing `remaining`
 + convert: always initialize attr_action in convert_attrs

 Assorted bugfixes and clean-ups.


* ma/up-to-date (2017-08-23) 2 commits
  (merged to 'next' on 2017-08-25 at 902f6e9140)
 + treewide: correct several "up-to-date" to "up to date"
 + Documentation/user-manual: update outdated example output

 Message and doc updates.


* mm/send-email-cc-cruft (2017-08-24) 2 commits
  (merged to 'next' on 2017-08-25 at 65933523ab)
 + send-email: don't use Mail::Address, even if available
 + send-email: fix garbage removal after address

 In addition to "cc: <a@dd.re.ss> # cruft", "cc: a@dd.re.ss # cruft"
 was taught to "git send-email" as a valid way to tell it that it
 needs to also send a carbon copy to <a@dd.re.ss> in the trailer
 section.


* nd/worktree-kill-parse-ref (2017-08-24) 1 commit
  (merged to 'next' on 2017-08-25 at a5da82b2ea)
 + branch: fix branch renaming not updating HEADs correctly

 "git branch -M a b" while on a branch that is completely unrelated
 to either branch a or branch b misbehaved when multiple worktree
 was in use.  This has been fixed.


* rs/apply-epoch (2017-08-25) 2 commits
  (merged to 'next' on 2017-08-26 at c2bf5ceca3)
 + apply: remove epoch date from regex
 + apply: check date of potential epoch timestamps first

 Code simplification.

--------------------------------------------------
[New Topics]

* bb/doc-eol-dirty (2017-09-07) 1 commit
 - Documentation: mention that `eol` can change the dirty status of paths

 Doc update.

 Will merge to 'next'.


* jh/hashmap-disable-counting (2017-09-07) 1 commit
 - hashmap: add API to disable item counting when threaded

 Our hashmap implementation in hashmap.[ch] is not thread-safe when
 adding a new item needs to expand the hashtable by rehashing; add
 an API to disable the automatic rehashing to work it around.

 Will merge to 'next'.


* jk/incore-lockfile-removal (2017-09-06) 20 commits
 - stop leaking lock structs in some simple cases
 - ref_lock: stop leaking lock_files
 - lockfile: update lifetime requirements in documentation
 - tempfile: auto-allocate tempfiles on heap
 - tempfile: remove deactivated list entries
 - tempfile: use list.h for linked list
 - tempfile: release deactivated strbufs instead of resetting
 - tempfile: robustify cleanup handler
 - tempfile: factor out deactivation
 - tempfile: factor out activation
 - tempfile: replace die("BUG") with BUG()
 - tempfile: handle NULL tempfile pointers gracefully
 - tempfile: prefer is_tempfile_active to bare access
 - lockfile: do not rollback lock on failed close
 - tempfile: do not delete tempfile on failed close
 - always check return value of close_tempfile
 - verify_signed_buffer: prefer close_tempfile() to close()
 - setup_temporary_shallow: move tempfile struct into function
 - setup_temporary_shallow: avoid using inactive tempfile
 - write_index_as_tree: cleanup tempfile on error

 The long-standing rule that an in-core lockfile instance, once it
 is used, must not be freed, has been lifted and the lockfile and
 tempfile APIs have been updated to reduce the chance of programming
 errors.

 Will merge to 'next'.


* jk/leak-checkers (2017-09-08) 10 commits
 - add UNLEAK annotation for reducing leak false positives
 - set_git_dir: handle feeding gitdir to itself
 - repository: free fields before overwriting them
 - reset: free allocated tree buffers
 - reset: make tree counting less confusing
 - config: plug user_config leak
 - update-index: fix cache entry leak in add_one_file()
 - add: free leaked pathspec after add_files_to_cache()
 - test-lib: set LSAN_OPTIONS to abort by default
 - test-lib: --valgrind should not override --verbose-log

 Many of our programs consider that it is OK to release dynamic
 storage that is used throughout the life of the program by simply
 exiting, but this makes it harder to leak detection tools to avoid
 reporting false positives.  Plug many existing leaks and introduce
 a mechanism for developers to mark that the region of memory
 pointed by a pointer is not lost/leaking to help these tools.

 Will merge to 'next'.


* jk/system-path-cleanup (2017-09-07) 2 commits
 - git_extract_argv0_path: do nothing without RUNTIME_PREFIX
 - system_path: move RUNTIME_PREFIX to a sub-function

 Code clean-up.

 Will merge to 'next'.


* jn/per-repo-obj-store (2017-09-07) 39 commits
 - pack: allow sha1_loose_object_info to handle arbitrary repositories
 - pack: allow map_sha1_file to handle arbitrary repositories
 - pack: allow map_sha1_file_1 to handle arbitrary repositories
 - pack: allow open_sha1_file to handle arbitrary repositories
 - pack: allow stat_sha1_file to handle arbitrary repositories
 - pack: allow sha1_file_name to handle arbitrary repositories
 - pack: allow reprepare_packed_git to handle arbitrary repositories
 - pack: allow prepare_packed_git to handle arbitrary repositories
 - pack: allow prepare_packed_git_one to handle arbitrary repositories
 - pack: allow prepare_packed_git_mru to handle arbitrary repositories
 - pack: allow rearrange_packed_git to handle arbitrary repositories
 - pack: allow install_packed_git to handle arbitrary repositories
 - object-store: allow foreach_alt_odb to handle arbitrary repositories
 - object-store: allow prepare_alt_odb to handle arbitrary repositories
 - sha1_file: allow alt_odb_usable to handle arbitrary repositories
 - pack: add repository argument to map_sha1_file
 - pack: add repository argument to sha1_file_name
 - pack: add repository argument to reprepare_packed_git
 - pack: add repository argument to prepare_packed_git
 - pack: add repository argument to prepare_packed_git_mru
 - pack: add repository argument to rearrange_packed_git
 - pack: add repository argument to prepare_packed_git_one
 - pack: add repository argument to install_packed_git
 - object-store: add repository argument to foreach_alt_odb
 - object-store: add repository argument to prepare_alt_odb
 - sha1_file: add repository argument to sha1_loose_object_info
 - sha1_file: add repository argument to map_sha1_file_1
 - sha1_file: add repository argument to open_sha1_file
 - sha1_file: add repository argument to stat_sha1_file
 - sha1_file: add repository argument to link_alt_odb_entries
 - sha1_file: add repository argument to read_info_alternates
 - sha1_file: add repository argument to link_alt_odb_entry
 - sha1_file: add repository argument to alt_odb_usable
 - pack: move approximate object count to object store
 - pack: move prepare_packed_git_run_once to object store
 - object-store: move packed_git and packed_git_mru to object store
 - object-store: move alt_odb_list and alt_odb_tail to object store
 - repository: introduce object store field
 - pack: make packed_git_mru global a value instead of a pointer

 We now can have separate instances of in-core object store per
 repository we visit.

 Will be rerolled.


* jt/packmigrate (2017-09-06) 1 commit
 - Remove inadvertently added outgoing/packfile.h

 An oops fix.

 Will merge to 'next'.


* kd/doc-for-each-ref (2017-09-07) 1 commit
 - doc/for-each-ref: explicitly specify option names

 Expecting a reroll.
 cf. <20170901231933.GC143138@aiede.mtv.corp.google.com>


* kw/write-index-reduce-alloc (2017-09-08) 2 commits
 - read-cache: fix index corruption with index v4
 - Add t/helper/test-write-cache to .gitignore

 Expecting a reroll.
 cf. <CALgYhfNYgmCJqptNQLKaQpCs9mAgqZHUrDS3BVEqCv_f+WX-qg@mail.gmail.com>


* ma/remove-config-maybe-bool (2017-09-07) 1 commit
 - config: remove git_config_maybe_bool

 Finishing touches to a recent topic.

 Will merge to 'next'.


* mh/packed-ref-store-prep (2017-09-07) 1 commit
 - rev-parse: don't trim bisect refnames

 Finishing touches to a recent topic.

 Will merge to 'next'.


* mh/packed-ref-transactions (2017-09-09) 11 commits
 - files_transaction_finish(): delete reflogs before references
 - packed-backend: rip out some now-unused code
 - files_ref_store: use a transaction to update packed refs
 - t1404: demonstrate two problems with reference transactions
 - files_initial_transaction_commit(): use a transaction for packed refs
 - prune_refs(): also free the linked list
 - files_pack_refs(): use a reference transaction to write packed refs
 - packed_delete_refs(): implement method
 - packed_ref_store: implement reference transactions
 - struct ref_transaction: add a place for backends to store data
 - packed-backend: don't adjust the reference count on lock/unlock

 Implement transactional update to the packed-ref representation of
 references.

 Will merge to 'next'.


* nm/pull-submodule-recurse-config (2017-09-07) 2 commits
 - pull: honor submodule.recurse config option
 - pull: fix cli and config option parsing order

 "git -c submodule.recurse=yes pull" did not work as if the
 "--recurse-submodules" option was given from the command line.
 This has been corrected.

 Will merge to 'next'.


* rs/strbuf-leakfix (2017-09-10) 34 commits
 - wt-status: release strbuf after use in wt_longstatus_print_tracking()
 - wt-status: release strbuf after use in read_rebase_todolist()
 - vcs-svn: release strbuf after use in end_revision()
 - utf8: release strbuf on error return in strbuf_utf8_replace()
 - userdiff: release strbuf after use in userdiff_get_textconv()
 - transport-helper: release strbuf after use in process_connect_service()
 - sequencer: release strbuf after use in save_head()
 - shortlog: release strbuf after use in insert_one_record()
 - sha1_file: release strbuf on error return in index_path()
 - send-pack: release strbuf on error return in send_pack()
 - remote: release strbuf after use in set_url()
 - remote: release strbuf after use in migrate_file()
 - remote: release strbuf after use in read_remote_branches()
 - refs: release strbuf on error return in write_pseudoref()
 - notes: release strbuf after use in notes_copy_from_stdin()
 - merge: release strbuf after use in write_merge_heads()
 - merge: release strbuf after use in save_state()
 - mailinfo: release strbuf on error return in handle_boundary()
 - mailinfo: release strbuf after use in handle_from()
 - help: release strbuf on error return in exec_woman_emacs()
 - help: release strbuf on error return in exec_man_man()
 - help: release strbuf on error return in exec_man_konqueror()
 - diff: release strbuf after use in show_stats()
 - diff: release strbuf after use in show_rename_copy()
 - diff: release strbuf after use in diff_summary()
 - convert: release strbuf on error return in filter_buffer_or_fd()
 - connect: release strbuf on error return in git_connect()
 - commit: release strbuf on error return in commit_tree_extended()
 - clone: release strbuf after use in remove_junk()
 - clean: release strbuf after use in remove_dirs()
 - check-ref-format: release strbuf after use in check_ref_format_branch()
 - am: release strbuf after use in safe_to_abort()
 - am: release strbuf on error return in hg_patch_to_mail()
 - am: release strbufs after use in detect_patch_format()

 Many leaks of strbuf have been fixed.

 Will merge to 'next'.


* jk/shortlog-ident-cleanup (2017-09-09) 1 commit
 - shortlog: skip format/parse roundtrip for internal traversal

 Code clean-up.

 Will merge to 'next'.


* mg/name-rev-tests-with-short-stack (2017-09-08) 4 commits
 - t6120: test describe and name-rev with deep repos
 - t6120: clean up state after breaking repo
 - t6120: test name-rev --all and --stdin
 - t7004: move limited stack prereq to test-lib

 A handful of tests to demonstrates a recursive implementation of
 "name-rev" hurts.

 Will merge to 'next'.


* rk/commit-tree-make-F-verbatim (2017-09-10) 1 commit
 - commit-tree: do not complete line in -F input

 Unlike "git commit-tree < file", "git commit-tree -F file" did not
 pass the contents of the file verbatim and instead completed an
 incomplete line at the end, if exists.  The latter has been updated
 to match the behaviour of the former.

 Will merge to 'next'.


* sb/merge-commit-msg-hook (2017-09-08) 1 commit
 - builtin/merge: honor commit-msg hook for merges

 As "git commit" to conclude a conflicted "git merge" honors the
 commit-msg hook, "git merge" that recoreds a merge commit that
 cleanly auto-merges should, but it didn't.

 Will merge to 'next'.


* ls/travis-scriptify (2017-09-11) 3 commits
 - travis: dedent a few scripts that are indented overly deeply
 - travis-ci: skip a branch build if equal tag is present
 - travis-ci: move Travis CI code into dedicated scripts

 The scripts to drive TravisCI has been reorganized and then an
 optimization to avoid spending cycles on a branch whose tip is
 tagged has been implemented.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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

 Expecting a reroll.


* bp/fsmonitor (2017-06-12) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 Expecting a reroll.
 cf. <bade1166-e646-b05a-f65b-adb8da8ba0a7@gmail.com>

--------------------------------------------------
[Cooking]

* dw/diff-highlight-makefile-fix (2017-09-06) 1 commit
  (merged to 'next' on 2017-09-10 at 8dfda480ac)
 + diff-highlight: add clean target to Makefile

 Build clean-up.

 Will merge to 'master'.


* jk/config-lockfile-leak-fix (2017-09-06) 1 commit
  (merged to 'next' on 2017-09-10 at 7b91d71749)
 + config: use a static lock_file struct

 A leakfix.

 Will merge to 'master'.


* kw/merge-recursive-cleanup (2017-09-08) 3 commits
 - merge-recursive: change current file dir string_lists to hashmap
 - merge-recursive: remove return value from get_files_dirs
 - merge-recursive: fix memory leak

 A leakfix and code clean-up.

 Will merge to 'next'.


* ma/pkt-line-leakfix (2017-09-06) 1 commit
  (merged to 'next' on 2017-09-10 at f0d9994319)
 + pkt-line: re-'static'-ify buffer in packet_write_fmt_1()

 A leakfix.

 Will merge to 'master'.


* ma/split-symref-update-fix (2017-09-10) 4 commits
  (merged to 'next' on 2017-09-10 at 96c403fca7)
 + refs/files-backend: add `refname`, not "HEAD", to list
 + refs/files-backend: correct return value in lock_ref_for_update
 + refs/files-backend: fix memory leak in lock_ref_for_update
 + refs/files-backend: add longer-scoped copy of string to list

 A leakfix.

 Will merge to 'master'.


* mg/timestamp-t-fix (2017-09-06) 1 commit
  (merged to 'next' on 2017-09-10 at a5df4d5b3e)
 + name-rev: change ULONG_MAX to TIME_MAX

 A mismerge fix.

 Will merge to 'master'.


* pc/submodule-helper (2017-08-25) 4 commits
 - submodule: port submodule subcommand 'status' from shell to C
 - submodule: port set_name_rev() from shell to C
 - submodule--helper: introduce for_each_listed_submodule()
 - submodule--helper: introduce get_submodule_displaypath()

 GSoC.


* sb/parse-options-blank-line-before-option-list (2017-08-25) 1 commit
 - usage_with_options: omit double new line on empty option list

 "git worktree" with no option and no subcommand showed too many
 blank lines in its help text, which has been reduced.


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

 Will merge to 'master'.


* nd/prune-in-worktree (2017-08-24) 16 commits
 - refs.c: reindent get_submodule_ref_store()
 - refs.c: remove fallback-to-main-store code get_submodule_ref_store()
 - rev-list: expose and document --single-worktree
 - revision.c: --reflog add HEAD reflog from all worktrees
 - files-backend: make reflog iterator go through per-worktree reflog
 - revision.c: --all adds HEAD from all worktrees
 - refs: remove dead for_each_*_submodule()
 - refs.c: move for_each_remote_ref_submodule() to submodule.c
 - revision.c: use refs_for_each*() instead of for_each_*_submodule()
 - refs: add refs_head_ref()
 - refs: move submodule slash stripping code to get_submodule_ref_store
 - refs.c: refactor get_submodule_ref_store(), share common free block
 - revision.c: --indexed-objects add objects from all worktrees
 - revision.c: refactor add_index_objects_to_pending()
 - refs.c: use is_dir_sep() in resolve_gitlink_ref()
 - revision.h: new flag in struct rev_info wrt. worktree-related refs

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Will merge to 'next'.


* bc/hash-algo (2017-08-20) 5 commits
 - hash-algo: switch empty tree and blob lookups to use hash abstraction
 - hash-algo: integrate hash algorithm support with repo setup
 - hash-algo: add structure representing hash algorithm
 - setup: expose enumerated repo info
 - Merge branch 'bc/vcs-svn-cleanup' into bc/hash-algo

 RFC
 cf. <20170821000022.26729-1-sandals@crustytoothpaste.net>


* mk/diff-delta-uint-may-be-shorter-than-ulong (2017-08-10) 1 commit
 . diff-delta: fix encoding size that would not fit in "unsigned int"

 The machinery to create xdelta used in pack files received the
 sizes of the data in size_t, but lost the higher bits of them by
 storing them in "unsigned int" during the computation, which is
 fixed.

 Dropped, as it was rerolled for review as part of a larger series.
 cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Will be rerolled after tc/curl-with-backports stabilizes.


* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Dropped, as it was rerolled for review as part of a larger series.
 cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>


* mk/diff-delta-avoid-large-offset (2017-08-11) 1 commit
 . diff-delta: do not allow delta offset truncation

 The delta format used in the packfile cannot reference data at
 offset larger than what can be expressed in 4-byte, but the
 generator for the data failed to make sure the offset does not
 overflow.  This has been corrected.

 Dropped, as it was rerolled for review as part of a larger series.
 cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>


* bw/git-clang-format (2017-08-14) 2 commits
 - Makefile: add style build rule
 - clang-format: outline the git project's coding style

 "make style" runs git-clang-format to help developers by pointing
 out coding style issues.


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


* ti/external-sha1dc (2017-08-16) 2 commits
  (merged to 'next' on 2017-08-26 at a0fb4e91a5)
 + sha1dc: allow building with the external sha1dc library
 + sha1dc: build git plumbing code more explicitly

 Platforms that ship with a separate sha1 with collision detection
 library can link to it instead of using the copy we ship as part of
 our source tree.

 Will merge to 'master'.


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


* sd/branch-copy (2017-06-18) 3 commits
 - branch: add a --copy (-c) option to go with --move (-m)
 - branch: add test for -m renaming multiple config sections
 - config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 I personally do not think "branch --copy master backup" while on
 "master" that switches to "backup" is a good UI, and I *will* say
 "I told you so" when users complain after we merge this down to
 'master'.

--------------------------------------------------
[Discarded]

* jc/apply-with-crlf (2017-08-16) 5 commits
 . apply: clarify read_old_data() is about no-index case
 . apply: localize the CRLF business to read_old_data()
 . apply: only pay attention to CRLF in the preimage
 . apply: remove unused field apply_state.flags
 . apply: file commited with CRLF should roundtrip diff and apply

 This served as an input to updated tb/apply-with-crlf.
