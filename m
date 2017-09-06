Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5C9208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 04:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdIFEjG (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 00:39:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53905 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751594AbdIFEjF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 00:39:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FB1D97B2B;
        Wed,  6 Sep 2017 00:39:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=/
        w6SjtrAwc3HbDQ9qdSV+VCXO6M=; b=aNieOibdiMcWJQbPIcrLOpX6wBtvdqS87
        rQXjPagPWos6Z6WFLotmZXGwmX8iHziKK1XLj4eSySqeKKIeIS0OUgx5b2trFNpv
        nfKHiJ1didx6JSlMpUNitKd/klapMUPOpOYTaW8PxN+9XkdWrXvCh/8d3q+CVsoW
        755HzktDnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=cQc
        mYxJaVfuzflB5D0za48fHfXCCaoyqE657ssC/zd/PRp3FbnLT3LPH0SRY13F3UTl
        9Wv3ugz6sqUndf5EyX9kENhkIZN7eLX9fUoRSPQpc2goGDfVKt4SNuAMPL+jmC4F
        PeCuooaybi/KU4ZLwT5muevEvINhIhR3r48Ehfp8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 765B597B2A;
        Wed,  6 Sep 2017 00:39:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B006597B29;
        Wed,  6 Sep 2017 00:39:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2017, #01; Wed, 6)
X-master-at: 3ec7d702a89c647ddf42a59bc3539361367de9d5
X-next-at: 1a2e63c10015eb714409797caf56c3d4ae975672
Date:   Wed, 06 Sep 2017 13:39:02 +0900
Message-ID: <xmqqh8wg7861.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F70E9CC-92BD-11E7-8ADB-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

We are at week #5 of this cycle.  It seems that people had a
productive week while I was away, which I am reasonably happy about
;-) I counted about a dozen or so topics, among which I managed to
pick up only 4 or 5 so far X-<.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ks/branch-set-upstream (2017-08-17) 3 commits
  (merged to 'next' on 2017-08-22 at 10fd938390)
 + branch: quote branch/ref names to improve readability
 + builtin/branch: stop supporting the "--set-upstream" option
 + t3200: cleanup cruft of a test

 "branch --set-upstream" that has been deprecated in Git 1.8 has
 finally been retired.


* po/read-graft-line (2017-08-18) 4 commits
  (merged to 'next' on 2017-08-22 at 1e3fe0d3a1)
 + commit: rewrite read_graft_line
 + commit: allocate array using object_id size
 + commit: replace the raw buffer with strbuf in read_graft_line
 + sha1_file: fix definition of null_sha1

 Conversion from uchar[20] to struct object_id continues; this is to
 ensure that we do not assume sizeof(struct object_id) is the same
 as the length of SHA-1 hash (or length of longest hash we support).


* rs/archive-excluded-directory (2017-08-19) 3 commits
  (merged to 'next' on 2017-08-22 at 1853597c35)
 + archive: don't queue excluded directories
 + archive: factor out helper functions for handling attributes
 + t5001: add tests for export-ignore attributes and exclude pathspecs

 "git archive" did not work well with pathspecs and the
 export-ignore attribute.

 We may want to resurrect the "we don't archive an empty directory"
 bonus patch, but I do not mind merging the above early to 'next'
 and leave it as a separate follow-up enhancement.
 cf. <20170820090629.tumvqwzkromcykjf@sigill.intra.peff.net>

--------------------------------------------------
[New Topics]

* dw/diff-highlight-makefile-fix (2017-09-06) 1 commit
 - diff-highlight: add clean target to Makefile

 Build clean-up.

 Will merge to 'next'.


* jk/config-lockfile-leak-fix (2017-09-06) 1 commit
 - config: use a static lock_file struct

 A leakfix.

 Will merge to 'next'.


* kw/merge-recursive-cleanup (2017-09-06) 4 commits
 - SQUASH???
 - merge-recursive: change current file dir string_lists to hashmap
 - merge-recursive: remove return value from get_files_dirs
 - merge-recursive: fix memory leak

 A leakfix and code clean-up.


* ma/pkt-line-leakfix (2017-09-06) 1 commit
 - pkt-line: re-'static'-ify buffer in packet_write_fmt_1()

 A leakfix.

 Will merge to 'next'.


* ma/split-symref-update-fix (2017-09-06) 3 commits
 - refs/files-backend: correct return value in lock_ref_for_update
 - refs/files-backend: fix memory leak in lock_ref_for_update
 - refs/files-backend: add longer-scoped copy of string to list

 A leakfix.

 Will merge to 'next'.


* mg/timestamp-t-fix (2017-09-06) 1 commit
 - name-rev: change ULONG_MAX to TIME_MAX

 A mismerge fix.

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

* jk/drop-sha1-entry-pos (2017-08-25) 1 commit
  (merged to 'next' on 2017-08-25 at 7ef03bb281)
 + sha1-lookup: remove sha1_entry_pos() from header file

 Code clean-up.

 Will merge to 'master'.


* ls/convert-filter-progress (2017-08-24) 1 commit
  (merged to 'next' on 2017-08-25 at ce0bb30e8f)
 + convert: display progress for filtered objects that have been delayed

 The codepath to call external process filter for smudge/clean
 operation learned to show the progress meter.

 Will merge to 'master'.


* mm/send-email-cc-cruft (2017-08-24) 2 commits
  (merged to 'next' on 2017-08-25 at 65933523ab)
 + send-email: don't use Mail::Address, even if available
 + send-email: fix garbage removal after address

 In addition to "cc: <a@dd.re.ss> # cruft", "cc: a@dd.re.ss # cruft"
 was taught to "git send-email" as a valid way to tell it that it
 needs to also send a carbon copy to <a@dd.re.ss> in the trailer
 section.

 Will merge to 'master'.


* nd/worktree-kill-parse-ref (2017-08-24) 1 commit
  (merged to 'next' on 2017-08-25 at a5da82b2ea)
 + branch: fix branch renaming not updating HEADs correctly

 "git branch -M a b" while on a branch that is completely unrelated
 to either branch a or branch b misbehaved when multiple worktree
 was in use.  This has been fixed.

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


* rs/apply-epoch (2017-08-25) 2 commits
  (merged to 'next' on 2017-08-26 at c2bf5ceca3)
 + apply: remove epoch date from regex
 + apply: check date of potential epoch timestamps first

 Code simplification.

 Will merge to 'master'.


* mh/notes-cleanup (2017-08-26) 12 commits
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


* ma/ts-cleanups (2017-08-23) 4 commits
  (merged to 'next' on 2017-08-25 at e0e8cc53ec)
 + ThreadSanitizer: add suppressions
 + strbuf_setlen: don't write to strbuf_slopbuf
 + pack-objects: take lock before accessing `remaining`
 + convert: always initialize attr_action in convert_attrs

 Assorted bugfixes and clean-ups.

 Will merge to 'master'.


* ma/up-to-date (2017-08-23) 2 commits
  (merged to 'next' on 2017-08-25 at 902f6e9140)
 + treewide: correct several "up-to-date" to "up to date"
 + Documentation/user-manual: update outdated example output

 Message and doc updates.

 Will merge to 'master'.


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
