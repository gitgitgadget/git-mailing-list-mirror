From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2015, #07; Tue, 26)
Date: Tue, 26 May 2015 14:47:23 -0700
Message-ID: <xmqqegm3j9jo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 23:47:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMhL-00048J-ND
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 23:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbbEZVrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 17:47:31 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:32899 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbbEZVrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 17:47:25 -0400
Received: by igbpi8 with SMTP id pi8so71383216igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=9bc+HATEZRvtenzv+cH+jYNYhleyECSVrYFiavTkci4=;
        b=Y5gTSAt4Fry5+oXyurhy8SyW8o9RztCaU8Kmwa8MTVsftW5DuhPplnkc9VE3axJAWj
         n0Tpw2GqnGIYj3o5XSyFzUtXQUmjlB3u3JD3MTqbdsN+iCG7L/riDD7lwl1zB4VWQ0GS
         jvBuwCDxC23p3x3CEhmAni14sYl4EGKIsP9ynLcDgXoWLJL9u5fL372hPwZ7TJWZOZ5/
         WhLJNZeUKXZZ5X7bhAVDwS/2etI6aiecYJ2D+k/ylGWtutOO+TYf5yYxhs/d3nRoB4Bk
         MRIojhv9jQtWZp37XVQuu/Nue8QdrUz3rtG7opaZrrVNVNj2hN9hYSjfuuA6z5x6Zi+C
         FuBg==
X-Received: by 10.107.137.170 with SMTP id t42mr38227672ioi.16.1432676844880;
        Tue, 26 May 2015 14:47:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id rr5sm292774igb.7.2015.05.26.14.47.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 14:47:24 -0700 (PDT)
X-master-at: fae46aa0ae5318bbb20f0ef871721bf49e292cea
X-next-at: 37f085bb52bb507d786c36ae50951e460f4f15c7
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269984>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The "untracked cache" series is in 'master' now.  I do not use it
personally, but it is meant to make life easier for those with large
amount of untracked cruft in their working trees.  Please try it out
and report successes (and of course breakages, too).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/rerere-forget-check-enabled (2015-05-14) 1 commit
  (merged to 'next' on 2015-05-19 at bfe67dc)
 + rerere: exit silently on "forget" when rerere is disabled

 "git rerere forget" in a repository without rerere enabled gave a
 cryptic error message; it should be a silent no-op instead.


* nd/untracked-cache (2015-03-12) 24 commits
  (merged to 'next' on 2015-05-19 at 26e619b)
 + git-status.txt: advertisement for untracked cache
 + untracked cache: guard and disable on system changes
 + mingw32: add uname()
 + t7063: tests for untracked cache
 + update-index: test the system before enabling untracked cache
 + update-index: manually enable or disable untracked cache
 + status: enable untracked cache
 + untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
 + untracked cache: mark index dirty if untracked cache is updated
 + untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
 + untracked cache: avoid racy timestamps
 + read-cache.c: split racy stat test to a separate function
 + untracked cache: invalidate at index addition or removal
 + untracked cache: load from UNTR index extension
 + untracked cache: save to an index extension
 + ewah: add convenient wrapper ewah_serialize_strbuf()
 + untracked cache: don't open non-existent .gitignore
 + untracked cache: mark what dirs should be recursed/saved
 + untracked cache: record/validate dir mtime and reuse cached output
 + untracked cache: make a wrapper around {open,read,close}dir()
 + untracked cache: invalidate dirs recursively if .gitignore changes
 + untracked cache: initial untracked cache validation
 + untracked cache: record .gitignore information and dir hierarchy
 + dir.c: optionally compute sha-1 of a .gitignore file

 Teach the index to optionally remember already seen untracked files
 to speed up "git status" in a working tree with tons of cruft.


* pt/pull-ff-vs-merge-ff (2015-05-18) 2 commits
  (merged to 'next' on 2015-05-20 at 064a082)
 + pull: parse pull.ff as a bool or string
 + pull: make pull.ff=true override merge.ff

 The pull.ff configuration was supposed to override the merge.ff
 configuration, but it didn't.


* pt/pull-log-n (2015-05-18) 1 commit
  (merged to 'next' on 2015-05-20 at db6ce78)
 + pull: handle --log=<n>

 "git pull --log" and "git pull --no-log" worked as expected, but
 "git pull --log=20" did not.


* rs/plug-leak-in-pack-bitmaps (2015-05-19) 1 commit
  (merged to 'next' on 2015-05-20 at b70f647)
 + pack-bitmaps: plug memory leak, fix allocation size for recent_bitmaps

 The code to read pack-bitmap wanted to allocate a few hundred
 pointers to a structure, but by mistake allocated and leaked memory
 enough to hold that many actual structures.  Correct the allocation
 size and also have it on stack, as it is small enough.

--------------------------------------------------
[New Topics]

* ah/send-email-sendmail-alias (2015-05-25) 2 commits
 - t9001: write $HOME/, not ~/, to help shells without tilde expansion
 - send-email: add sendmail email aliases format

 "git send-email" learned the alias file format used by the sendmail
 program (in an abbreviated form).

 Reroll coming?  What's queued is good enough?


* bc/object-id (2015-05-25) 56 commits
  (merged to 'next' on 2015-05-26 at 8d9f645)
 + struct ref_lock: convert old_sha1 member to object_id
 + warn_if_dangling_symref(): convert local variable "junk" to object_id
 + each_ref_fn_adapter(): remove adapter
 + rev_list_insert_ref(): remove unneeded arguments
 + rev_list_insert_ref_oid(): new function, taking an object_oid
 + mark_complete(): remove unneeded arguments
 + mark_complete_oid(): new function, taking an object_oid
 + clear_marks(): rewrite to take an object_id argument
 + mark_complete(): rewrite to take an object_id argument
 + send_ref(): convert local variable "peeled" to object_id
 + upload-pack: rewrite functions to take object_id arguments
 + find_symref(): convert local variable "unused" to object_id
 + find_symref(): rewrite to take an object_id argument
 + write_one_ref(): rewrite to take an object_id argument
 + write_refs_to_temp_dir(): convert local variable sha1 to object_id
 + submodule: rewrite to take an object_id argument
 + shallow: rewrite functions to take object_id arguments
 + handle_one_ref(): rewrite to take an object_id argument
 + add_info_ref(): rewrite to take an object_id argument
 + handle_one_reflog(): rewrite to take an object_id argument
 + register_replace_ref(): rewrite to take an object_id argument
 + remote: rewrite functions to take object_id arguments
 + add_one_ref(): rewrite to take an object_id argument
 + string_list_add_one_ref(): rewrite to take an object_id argument
 + add_ref_decoration(): convert local variable original_sha1 to object_id
 + add_ref_decoration(): rewrite to take an object_id argument
 + show_head_ref(): convert local variable "unused" to object_id
 + http-backend: rewrite to take an object_id argument
 + append_similar_ref(): rewrite to take an object_id argument
 + builtin/show-ref: rewrite to take an object_id argument
 + show_ref(): convert local variable peeled to object_id
 + builtin/show-ref: rewrite to use object_id
 + fsck: change functions to use object_id
 + cmd_show_branch(): fix error message
 + builtin/show-branch: rewrite functions to work with object_id
 + append_one_rev(): rewrite to work with object_id
 + builtin/show-branch: rewrite functions to take object_id arguments
 + append_matching_ref(): rewrite to take an object_id argument
 + show_reference(): rewrite to take an object_id argument
 + builtin/remote: rewrite functions to take object_id arguments
 + add_branch_for_removal(): don't set "util" field of string_list entries
 + add_branch_for_removal(): rewrite to take an object_id argument
 + builtin/reflog: rewrite ref functions to take an object_id argument
 + show_ref_cb(): rewrite to take an object_id argument
 + builtin/pack-objects: rewrite to take an object_id argument
 + name_ref(): rewrite to take an object_id argument
 + grab_single_ref(): rewrite to take an object_id argument
 + builtin/fetch: rewrite to take an object_id argument
 + get_name(): rewrite to take an object_id argument
 + add_pending_uninteresting_ref(): rewrite to take an object_id argument
 + append_ref(): rewrite to take an object_id argument
 + register_ref(): rewrite to take an object_id argument
 + handle_one_ref(): rewrite to take an object_id argument
 + builtin/rev-parse: rewrite to take an object_id argument
 + each_ref_fn: change to take an object_id parameter
 + refs: convert struct ref_entry to use struct object_id

 for_each_ref() callback functions were taught to name the objects
 not with "unsigned char sha1[20]" but with "struct object_id".

 Will merge to 'master'.


* jc/diff-ws-check-deleted (2015-05-26) 4 commits
 - diff.c: --ws-check-deleted option
 - diff.c: add emit_del_line() and update callers of emit_line_0()
 - t4015: separate common setup and per-test expectation
 - t4015: modernise style

 Allow whitespace breakages in 'deleted' lines to be also painted
 in the output.

--------------------------------------------------
[Stalled]

* kk/log-merges-config (2015-04-21) 5 commits
 - bash-completion: add support for git-log --merges= and log.merges
 - t4202-log: add tests for --merges=
 - Documentation: add git-log --merges= option and log.merges config. var
 - log: honor log.merges= option
 - revision: add --merges={show|only|hide} option

 "git log" (but not other commands in the "log" family) learned to
 pay attention to the log.merges configuration variable that can be
 set to "show" (the normal behaviour), "only" (hide non-merge
 commits), or "hide" (hide merge commits).  --merges=(show|only|hide)
 can be used to override the setting from the command line.

 The documentation may need to be updated once more ($gmane/267250).
 Waiting for a reroll.


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962
 Will be rerolled.
 with updated log message ($gmane/268061).


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

 Will be rerolled.
 ($gmane/268058).


* tf/gitweb-project-listing (2015-03-19) 5 commits
 - gitweb: make category headings into links when they are directories
 - gitweb: optionally set project category from its pathname
 - gitweb: add a link under the search box to clear a project filter
 - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
 - gitweb: fix typo in man page

 Update gitweb to make it more pleasant to deal with a hierarchical
 forest of repositories.

 Any comments from those who use or have their own code in Gitweb?


* jc/a-lone-dash-stands-for-previous-branch (2015-03-16) 1 commit
 - "-" and "@{-1}" on various programs

 Lose special case code to make a lone dash "-" mean the previous
 branch aka "@{-1}" from a handful subcommands, and instead support
 the notation throughout the system by reimplementing it at the
 revisions layer.

 Needs tests, documentation updates, etc.  Also does only a half-way
 job dealing with range notation, which needs to be fixed before the
 series goes anywhere.


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
 positive discussions.

 Waiting for a further polished reroll ($gmane/265534).


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


* nd/pathspec-strip-fix (2015-04-18) 1 commit
 - pathspec: adjust prefixlen after striping trailing slash

 Does not quite fix ($gmane/267614).
 Will discard.


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

 Waiting for the final step to lift the hard-limit.

--------------------------------------------------
[Cooking]

* da/mergetool-winmerge (2015-05-20) 2 commits
  (merged to 'next' on 2015-05-26 at d6333e9)
 + mergetools: add winmerge as a builtin tool
 + mergetool--lib: set IFS for difftool and mergetool

 "git mergetool" learned to drive WinMerge as a backend.

 Will merge to 'master'.


* jk/http-backend-deadlock-2.2 (2015-05-25) 3 commits
 + http-backend: spool ref negotiation requests to buffer
 + t5551: factor out tag creation
 + http-backend: fix die recursion with custom handler
 (this branch is used by jk/http-backend-deadlock and jk/http-backend-deadlock-2.3.)

 Communication between the HTTP server and http_backend process can
 lead to a dead-lock when relaying a large ref negotiation request.
 Diagnose the situation better, and mitigate it by reading such a
 request first into core (to a reasonable limit).

 This was wiggled back to apply to the 2.2 maintenance track
 (original was for 2.4).

 Will merge to 'master'.


* jk/http-backend-deadlock-2.3 (2015-05-25) 1 commit
 + Merge branch 'jk/http-backend-deadlock-2.2' into jk/http-backend-deadlock-2.3
 (this branch is used by jk/http-backend-deadlock; uses jk/http-backend-deadlock-2.2.)

 Same for 2.3 maintenance track.

 Will merge to 'master'.


* jk/stash-options (2015-05-20) 2 commits
  (merged to 'next' on 2015-05-26 at 5dcb026)
 + stash: recognize "--help" for subcommands
 + stash: complain about unknown flags

 Make "git stash something --help" error out, so that users can
 safely say "git stash drop --help".

 Will merge to 'master'.


* mc/commit-doc-grammofix (2015-05-19) 1 commit
  (merged to 'next' on 2015-05-26 at 9d76e3b)
 + Documentation/git-commit: grammofix

 Will merge to 'master'.


* rs/janitorial (2015-05-20) 3 commits
  (merged to 'next' on 2015-05-26 at 9d5aee4)
 + dir: remove unused variable sb
 + clean: remove unused variable buf
 + use file_exists() to check if a file exists in the worktree

 Will merge to 'master'.


* fm/fetch-raw-sha1 (2015-05-22) 3 commits
  (merged to 'next' on 2015-05-26 at dc3f1b3)
 + upload-pack: optionally allow fetching reachable sha1
 + upload-pack: prepare to extend allow-tip-sha1-in-want
 + config.txt: clarify allowTipSHA1InWant with camelCase

 "git upload-pack" that serves "git fetch" can be told to serve
 commits that are not at the tip of any ref as long as they are
 reachable from a ref with uploadpack.allowReachableSHA1InWant
 configuration variable.

 Will merge to 'master'.


* jc/commit-slab (2015-05-22) 1 commit
 - commit-slab: introduce slabname##_peek() function

 Memory use reduction when commit-slab facility is used to annotate
 sparsely (which is not recommended in the first place).


* mm/rebase-i-post-rewrite-exec (2015-05-22) 3 commits
  (merged to 'next' on 2015-05-26 at 8ddaab1)
 + t5407: use <<- to align the expected output
 + rebase -i: fix post-rewrite hook with failed exec command
 + rebase -i: demonstrate incorrect behavior of post-rewrite

 "git rebase -i" fired post-rewrite hook when it shouldn't (namely,
 when it was told to stop sequencing with 'exec' insn).

 Will merge to 'master'.


* sb/submodule-doc-intro (2015-05-22) 1 commit
 - submodule documentation: reorder introductory paragraphs

 What's the doneness of this one???


* sb/test-bitmap-free-at-end (2015-05-22) 1 commit
  (merged to 'next' on 2015-05-26 at 1014ebf)
 + test_bitmap_walk: free bitmap with bitmap_free

 Will merge to 'master'.


* dt/cat-file-follow-symlinks (2015-05-20) 3 commits
  (merged to 'next' on 2015-05-26 at 7ae52d4)
 + cat-file: add --follow-symlinks to --batch
 + sha1_name: get_sha1_with_context learns to follow symlinks
 + tree-walk: learn get_tree_entry_follow_symlinks

 "git cat-file --batch(-check)" learned the "--follow-symlinks"
 option that follows an in-tree symbolic links when asked about an
 object via extended SHA-1 syntax, e.g. HEAD:RelNotes that points at
 Documentation/RelNotes/2.5.0.txt.  With the new option, the command
 behaves as if HEAD:Documentation/RelNotes/2.5.0.txt was given as
 input instead.

 Will merge to 'master'.


* dt/clean-pathspec-filter-then-lstat (2015-05-18) 1 commit
  (merged to 'next' on 2015-05-26 at 9b24d71)
 + clean: only lstat files in pathspec

 "git clean pathspec..." tried to lstat(2) and complain even for
 paths outside the given pathspec.

 Will merge to 'master'.


* jh/filter-empty-contents (2015-05-18) 1 commit
  (merged to 'next' on 2015-05-26 at 9cad398)
 + sha1_file: pass empty buffer to index empty file

 The clean/smudge interface did not work well when filtering an
 empty contents (failed and then passed the empty input through).
 It can be argued that a filter that produces anything but empty for
 an empty input is nonsense, but if the user wants to do strange
 things, then why not?

 Will merge to 'master'.


* jk/http-backend-deadlock (2015-05-25) 1 commit
  (merged to 'next' on 2015-05-26 at 9f3bd8a)
 + Merge branch 'jk/http-backend-deadlock-2.3' into jk/http-backend-deadlock
 (this branch uses jk/http-backend-deadlock-2.2 and jk/http-backend-deadlock-2.3.)

 Communication between the HTTP server and http_backend process can
 lead to a dead-lock when relaying a large ref negotiation request.
 Diagnose the situation better, and mitigate it by reading such a
 request first into core (to a reasonable limit).

 Will merge to 'master'.


* mm/log-format-raw-doc (2015-05-20) 2 commits
  (merged to 'next' on 2015-05-26 at 97e2c9d)
 + Documentation/log: clarify sha1 non-abbreviation in log --raw
 + Documentation/log: clarify what --raw means

 Clarify that "log --raw" and "log --format=raw" are unrelated
 concepts.

 Will merge to 'master'.


* sg/help-group (2015-05-21) 5 commits
  (merged to 'next' on 2015-05-26 at 2749912)
 + help: respect new common command grouping
 + command-list.txt: drop the "common" tag
 + generate-cmdlist: parse common group commands
 + command-list.txt: add the common groups block
 + command-list: prepare machinery for upcoming "common groups" section

 Group list of commands shown by "git help" along the workflow
 elements to help early learners.

 Will merge to 'master'.


* ld/p4-editor-multi-words (2015-05-26) 3 commits
 - git-p4: tests: use test-chmtime in place of touch
 - git-p4: fix handling of multi-word P4EDITOR
 - git-p4: add failing test for P4EDITOR handling

 Unlike "$EDITOR" and "$GIT_EDITOR" that can hold the path to the
 command and initial options (e.g. "/path/to/emacs -nw"), 'git p4'
 did not let the shell interpolate the contents of the environment
 variable that name the editor "$P4EDITOR" (and "$EDITOR", too).
 Make it in line with the rest of Git, as well as with Perforce.

 Will merge to 'next'.


* pt/pull-tests (2015-05-18) 8 commits
 - t5520: check reflog action in fast-forward merge
 - t5521: test --dry-run does not make any changes
 - t5520: test --rebase failure on unborn branch with index
 - t5520: test --rebase with multiple branches
 - t5520: test work tree fast-forward when fetch updates head
 - t5520: test for failure if index has unresolved entries
 - t5520: test no merge candidates cases
 - t5520: prevent field splitting in content comparisons

 Add more test coverage to "git pull".


* jc/clone-bundle (2015-04-30) 1 commit
 - repack: optionally create a clone.bundle

 Still an early WIP


* jk/at-push-sha1 (2015-05-22) 16 commits
  (merged to 'next' on 2015-05-26 at d9d342f)
 + for-each-ref: accept "%(push)" format
 + for-each-ref: use skip_prefix instead of starts_with
 + sha1_name: implement @{push} shorthand
 + sha1_name: refactor interpret_upstream_mark
 + sha1_name: refactor upstream_mark
 + remote.c: add branch_get_push
 + remote.c: return upstream name from stat_tracking_info
 + remote.c: untangle error logic in branch_get_upstream
 + remote.c: report specific errors from branch_get_upstream
 + remote.c: introduce branch_get_upstream helper
 + remote.c: hoist read_config into remote_get_1
 + remote.c: provide per-branch pushremote name
 + remote.c: hoist branch.*.remote lookup out of remote_get_1
 + remote.c: drop "remote" pointer from "struct branch"
 + remote.c: refactor setup of branch->merge list
 + remote.c: drop default_remote_name variable

 Introduce <branch>@{push} short-hand to denote the remote-tracking
 branch that tracks the branch at the remote the <branch> would be
 pushed to.

 Will merge to 'master'.


* ee/clean-remove-dirs (2015-04-26) 5 commits
 - clean: improve performance when removing lots of directories
 - p7300: add performance tests for clean
 - t7300: add tests to document behavior of clean and nested git
 - setup: sanity check file size in read_gitfile_gently
 - setup: add gentle version of read_gitfile

 Replace "is this subdirectory a separate repository that should not
 be touched?" check "git clean" does by checking if it has .git/HEAD
 using the submodule-related code with a more optimized check.

 Waiting for a reroll.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will merge to 'next' and keep there during the 2.5 cycle.


* ah/usage-strings (2015-05-03) 2 commits
 - branch: fix funny-sounding error message
 - blame, log: format usage strings similarly to those in documentation

 A few usage string updates.  The tip one still needs work.
