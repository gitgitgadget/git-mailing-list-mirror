From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2015, #07; Wed, 30)
Date: Wed, 30 Sep 2015 14:52:09 -0700
Message-ID: <xmqq4mib7eye.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 23:52:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhPIT-0001iD-6S
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 23:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbbI3VwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 17:52:16 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36717 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932769AbbI3VwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 17:52:12 -0400
Received: by pablk4 with SMTP id lk4so51530321pab.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=ydc+9LLHPySLBVIgQ8YSWc5EYRrofk3s/5vFZubiNB8=;
        b=nlzXZqf5GaC3uIIV7/pvtF0klq4YK5AHOtYBPNSdB3dCX7iIN8Vg8Sgi4fwkfIfmz2
         4A2vZEdVhEwb0NoRO9xUpQqo41XWDunsQnRRya6TphcW7UpcTih7tpOv/wDpYO1TAkhA
         zyaGvGJ+ris6NddrrAznAL6eNhJsgS4YQz7CiVOUktIn3QD9hmjNxSwyPqd6lKJBAJrw
         owwrwJsxYZXtWfRN5ujuBHMVP5wQcwiebIAID/sWrz08IPesVFMdZYGSS0eDBFnfpiRk
         mIiskrNMtKltNRhmE+y13IMXe1b6G/8wrGc/3F4cnqJYdZSfze2D/oxEpEy6vI5NM2h5
         6OFw==
X-Received: by 10.68.192.9 with SMTP id hc9mr7534819pbc.57.1443649931447;
        Wed, 30 Sep 2015 14:52:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id xm4sm2512800pab.27.2015.09.30.14.52.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 14:52:10 -0700 (PDT)
X-master-at: be08dee9738eaaa0423885ed189c2b6ad8368cf0
X-next-at: dd5055040e51c9a129af659ad956353485c78698
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278870>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Git 2.6.0 was released a few days ago.  I'll do 2.6.1 early next
week, together with updates to a few older maintenance tracks, and
we'll start the next cycle after that.

With somewhat reduced review bandwidth, I'd expect that the upcoming
cycle would be slower than usual.  At tinyurl.com/gitCal, I
tentatively drew a 14-week schedule for this cycle (I plan to be
offline during weeks #7-#9 myself---hopefully we'll have capable
interim maintainers to take care of the list traffic in the meantime
as in past years).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jk/asciidoctor-section-heading-markup-fix (2015-09-25) 1 commit
 - Documentation: fix section header mark-up

 Will merge to 'next'.


* jk/war-on-sprintf (2015-09-28) 68 commits
 - name-rev: use strip_suffix to avoid magic numbers
 - use strbuf_complete to conditionally append slash
 - fsck: use for_each_loose_file_in_objdir
 - Makefile: drop D_INO_IN_DIRENT build knob
 - fsck: drop inode-sorting code
 - convert strncpy to memcpy
 - notes: document length of fanout path with a constant
 - color: add color_set helper for copying raw colors
 - prefer memcpy to strcpy
 - help: clean up kfmclient munging
 - receive-pack: simplify keep_arg computation
 - avoid sprintf and strcpy with flex arrays
 - use alloc_ref rather than hand-allocating "struct ref"
 - color: add overflow checks for parsing colors
 - drop strcpy in favor of raw sha1_to_hex
 - use sha1_to_hex_r() instead of strcpy
 - daemon: use cld->env_array when re-spawning
 - stat_tracking_info: convert to argv_array
 - http-push: use an argv_array for setup_revisions
 - fetch-pack: use argv_array for index-pack / unpack-objects
 - diagnose_invalid_index_path: use strbuf to avoid strcpy/strcat
 - write_loose_object: convert to strbuf
 - remove_leading_path: use a strbuf for internal storage
 - enter_repo: convert fixed-size buffers to strbufs
 - merge-recursive: convert malloc / strcpy to strbuf
 - transport: use strbufs for status table "quickref" strings
 - apply: convert root string to strbuf
 - init: use strbufs to store paths
 - sha1_get_pack_name: use a strbuf
 - http-walker: store url in a strbuf
 - http-push: use strbuf instead of fwrite_buffer
 - remote-ext: simplify git pkt-line generation
 - upload-archive: convert sprintf to strbuf
 - resolve_ref: use strbufs for internal buffers
 - read_remotes_file: simplify string handling
 - read_branches_file: simplify string handling
 - mailmap: replace strcpy with xstrdup
 - help: drop prepend function in favor of xstrfmt
 - ref-filter: drop sprintf and strcpy calls
 - use strip_suffix and xstrfmt to replace suffix
 - fetch: replace static buffer with xstrfmt
 - config: use xstrfmt in normalize_value
 - replace trivial malloc + sprintf / strcpy calls with xstrfmt
 - receive-pack: convert strncpy to xsnprintf
 - http-push: replace strcat with xsnprintf
 - add_packed_git: convert strcpy into xsnprintf
 - entry.c: convert strcpy to xsnprintf
 - grep: use xsnprintf to format failure message
 - compat/hstrerror: convert sprintf to snprintf
 - stop_progress_msg: convert sprintf to xsnprintf
 - find_short_object_filename: convert sprintf to xsnprintf
 - use xsnprintf for generating git object headers
 - archive-tar: use xsnprintf for trivial formatting
 - convert trivial sprintf / strcpy calls to xsnprintf
 - compat/inet_ntop: fix off-by-one in inet_ntop4
 - test-dump-cache-tree: avoid overflow of cache-tree name
 - progress: store throughput display in a strbuf
 - trace: use strbuf for quote_crnl output
 - mailsplit: make PATH_MAX buffers dynamic
 - fsck: use strbuf to generate alternate directories
 - add reentrant variants of sha1_to_hex and find_unique_abbrev
 - strbuf: make strbuf_complete_line more generic
 - add git_path_buf helper function
 - add xsnprintf helper function
 - fsck: don't fsck alternates for connectivity-only check
 - archive-tar: fix minor indentation violation
 - mailsplit: fix FILE* leak in split_maildir
 - show-branch: avoid segfault with --reflog of unborn branch

 Needs further tweaking
 ($gmane/278837)


* rp/link-curl-before-ssl (2015-09-25) 3 commits
 - configure: make curl-config path configurable
 - configure.ac: detect ssl need with libcurl
 - Makefile: link libcurl before openssl and crypto

 Will merge to 'next'.


* sb/http-flaky-test-fix (2015-09-25) 1 commit
 - t5561: get rid of racy appending to logfile

 Will merge to 'next'.


* sb/perf-without-installed-git (2015-09-25) 1 commit
 - t/perf: make runner work even if Git is not installed

 Will merge to 'next'.


* tk/typofix-connect-unknown-proto-error (2015-09-25) 1 commit
 - connect: fix typo in result string of prot_name()

 Will merge to 'next'.


* js/clone-dissociate (2015-09-28) 1 commit
 - clone --dissociate: avoid locking pack files

 "git clone --dissociate" runs a big "git repack" process at the
 end, and it helps to close file descriptors that are open on the
 packs and their idx files before doing so on filesystems that
 cannot remove a file that is still open.

 Needs more review discussion.
 ($gmane/278859).


* js/gc-with-stale-symref (2015-09-28) 4 commits
 - gc: remove broken symrefs
 - mark_reachable_objects(): optionally collect broken symrefs
 - pack-objects: do not get distracted by broken symrefs
 - gc: demonstrate failure with stale remote HEAD

 The tip one both the original author and a reviewer felt iffy about.


* js/icase-wt-detection (2015-09-28) 1 commit
 - setup: fix "inside work tree" detection on case-insensitive filesystems

 Will merge to 'next'.


* mm/detach-at-HEAD-reflog (2015-09-28) 2 commits
 - status: don't say 'HEAD detached at HEAD'
 - t3203: test 'detached at' after checkout --detach

 Will merge to 'next'.


* nd/ls-remote-does-not-have-u-option (2015-09-28) 1 commit
 - ls-remote.txt: delete unsupported option

 Will merge to 'next'.


* pt/am-builtin (2015-09-30) 1 commit
 - am: configure gpg at startup

 When "git am" was rewritten as a built-in, it stopped paying
 attention to user.signingkey.

 Will merge to 'next'.


* sa/send-email-smtp-batch-data-limit (2015-09-30) 1 commit
 - git-send-email.perl: Fixed sending of many/huge changes/patches

 When "git send-email" wanted to talk over Net::SMTP::SSL,
 Net::Cmd::datasend() did not like to be fed too many bytes at the
 same time and failed to send messages.  Send the payload one line
 at a time to work around the problem.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Becoming tired of waiting for a reroll.
 with updated log message ($gmane/268061).


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Becoming tired of waiting for a reroll.
 ($gmane/271213).


* ak/format-patch-odir-config (2015-06-19) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Reroll exists but didn't pick it up as it seemed to be still
 collecting review comments.

 Becoming tired of waiting for a reroll.
 ($gmane/272180).


* mh/notes-allow-reading-treeish (2015-07-13) 1 commit
 - notes: allow treeish expressions as notes ref

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).

 Needs update to docs.
 ($gmane/273928)


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

--------------------------------------------------
[Cooking]

* ls/p4-translation-failure (2015-09-22) 2 commits
 - git-p4: handle "Translation of file content failed"
 - git-p4: add test case for "Translation of file content failed" error

 Work around "git p4" failing when the P4 depot records the contents
 in UTF-16 without UTF-16 BOM.

 Will merge to 'next'.


* mr/worktree-list (2015-09-23) 6 commits
 - SQUASH???
 - worktree: add 'list' command
 - worktree: add functions to get worktree details
 - worktree: refactor find_linked_symref function
 - SQUASH???
 - worktree: add top-level worktree.c

 Add the "list" subcommand to "git worktree".

 Waiting for a reroll.
 ($gmane/278529).


* jk/notes-dwim-doc (2015-09-22) 1 commit
 - notes: correct documentation of DWIMery for notes references

 The way how --ref/--notes to specify the notes tree reference are
 DWIMmed was not clearly documented.

 Will merge to 'next'.


* kn/for-each-branch (2015-09-25) 8 commits
 - branch: add '--points-at' option
 - branch.c: use 'ref-filter' APIs
 - branch.c: use 'ref-filter' data structures
 - branch: drop non-commit error reporting
 - branch: move 'current' check down to the presentation layer
 - branch: roll show_detached HEAD into regular ref_list
 - branch: bump get_head_description() to the top
 - branch: refactor width computation
 (this branch uses kn/for-each-tag and kn/for-each-tag-branch.)

 Update "git branch" that list existing branches, using the
 ref-filter API that is shared with "git tag" and "git
 for-each-ref".

 Will merge to 'next'.


* jc/fsck-dropped-errors (2015-09-23) 1 commit
 - fsck: exit with non-zero when problems are found

 There were some classes of errors that "git fsck" diagnosed to its
 standard error that did not cause it to exit with non-zero status.

 Will merge to 'next'.


* mm/keyid-docs (2015-09-21) 3 commits
  (merged to 'next' on 2015-09-21 at f50ccab)
 + Documentation: explain optional arguments better
 + Documentation/grep: fix documentation of -O
 + Documentation: use 'keyid' consistently, not 'key-id'

 Very small number of options take a parameter that is optional
 (which is not a great UI element as they can only appear at the end
 of the command line).  Add notice to documentation of each and
 every one of them.

 Will merge to 'master'.


* nd/gc-auto-background-fix (2015-09-21) 1 commit
 - gc: save log from daemonized gc --auto and print it next time

 When "git gc --auto" is backgrounded, its diagnosis message is
 lost.  Save it to a file in $GIT_DIR and show it next time the "gc
 --auto" is run.

 Will merge to 'next'.


* jk/blame-first-parent (2015-09-16) 1 commit
  (merged to 'next' on 2015-09-21 at 7580f6b)
 + blame: handle --first-parent

 "git blame --first-parent v1.0..v2.0" was not rejected but did not
 limit the blame to commits on the first parent chain.

 Will merge to 'master'.


* ld/p4-detached-head (2015-09-09) 2 commits
 - git-p4: work with a detached head
 - git-p4: add failing test for submit from detached head

 Will be rerolled.
 ($gmane/277574)


* jk/graph-format-padding (2015-09-14) 1 commit
 - pretty: pass graph width to pretty formatting for use in '%>|(N)'

 Redefine the way '%>|(N)' padding and the "--graph" option
 interacts.  It has been that the available columns to display the
 log message was measured from the edge of the area the graph ended,
 but with this it becomes the beginning of the entire output.

 I have a suspicion that 50% of the users would appreciate this
 change, and the remainder see this break their expectation.  If
 that is the case, we might need to introduce a similar but
 different alignment operator so that this new behaviour is
 available to those who want to use it, without negatively affecting
 existing uses.

 Undecided.
 ($gmane/278326)


* jk/make-findstring-makeflags-fix (2015-09-10) 1 commit
  (merged to 'next' on 2015-09-21 at 26ea6e0)
 + Makefile: fix MAKEFLAGS tests with multiple flags

 Customization to change the behaviour with "make -w" and "make -s"
 in our Makefile was broken when they were used together.

 Will merge to 'master'.


* jk/rebase-no-autostash (2015-09-10) 2 commits
  (merged to 'next' on 2015-09-21 at 034d726)
 + Documentation/git-rebase: fix --no-autostash formatting
 + rebase: support --no-autostash

 There was no way to defeat a configured rebase.autostash variable
 from the command line, as "git rebase --no-autostash" was missing.

 Will merge to 'master'.


* jw/make-arflags-customizable (2015-09-10) 1 commit
  (merged to 'next' on 2015-09-21 at cb3892c1)
 + Makefile: allow $(ARFLAGS) specified from the command line

 The Makefile always runs the library archiver with hardcoded "crs"
 options, which was inconvenient for exotic platforms on which
 people wants to use programs with totally different set of command
 line options.

 Will merge to 'master'.


* nd/ignore-then-not-ignore (2015-09-21) 2 commits
  (merged to 'next' on 2015-09-21 at 2182591)
 + dir.c: don't exclude whole dir prematurely if neg pattern may match
 + dir.c: make last_exclude_matching_from_list() run til the end

 Allow a later "!/abc/def" to override an earlier "/abc" that
 appears in the same .gitignore file to make it easier to express
 "everything in /abc directory is ignored, except for ...".

 Will merge to 'master'.


* sb/submodule-parallel-fetch (2015-09-30) 9 commits
 - submodules: allow parallel fetching, add tests and documentation
 - fetch_populated_submodules: use new parallel job processing
 - SQUASH??? return_value() is fed possibly uninitialized code
 - run-command: add an asynchronous parallel child processor
 - sigchain: add command to pop all common signals
 - strbuf: add strbuf_read_once to read without blocking
 - xread_nonblock: add functionality to read from fds without blocking
 - xread: poll on non blocking fds
 - submodule.c: write "Fetching submodule <foo>" to stderr
 (this branch uses sb/submodule-helper.)

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 The overall structure seems more-or-less sensible.


* mk/submodule-gitdir-path (2015-09-14) 2 commits
 - path: implement common_dir handling in git_pathdup_submodule()
 - submodule refactor: use strbuf_git_path_submodule() in add_submodule_odb()

 The submodule code has been taught to work better with separate
 work trees created via "git worktree add".

 Will merge to 'next'.


* jk/connect-clear-env (2015-09-08) 2 commits
  (merged to 'next' on 2015-09-08 at 86b64f7)
 + git_connect: clarify conn->use_shell flag
  (merged to 'next' on 2015-09-06 at 9ddbed8)
 + git_connect: clear GIT_* environment for ssh

 The ssh transport, just like any other transport over the network,
 did not clear GIT_* environment variables, but it is possible to
 use SendEnv and AcceptEnv to leak them to the remote invocation of
 Git, which is not a good idea at all.  Explicitly clear them just
 like we do for the local transport.

 Will merge to 'master'.


* ti/glibc-stdio-mutex-from-signal-handler (2015-09-04) 1 commit
  (merged to 'next' on 2015-09-08 at c8047ba)
 + pager: don't use unsafe functions in signal handlers

 Allocation related functions and stdio are unsafe things to call
 inside a signal handler, and indeed killing the pager can cause
 glibc to deadlock waiting on allocation mutex as our signal handler
 tries to free() some data structures in wait_for_pager().  Reduce
 these unsafe calls.

 Will merge to 'next'.


* as/subtree-with-spaces (2015-09-08) 2 commits
  (merged to 'next' on 2015-09-09 at f3d763d)
 + contrib/subtree: respect spaces in a repository path
 + t7900-subtree: test the "space in a subdirectory name" case

 Update "git subtree" (in contrib/) so that it can take whitespaces
 in the pathnames, not only in the in-tree pathname but the name of
 the directory that the repository is in.

 Will merge to 'master'.


* gb/filter-branch-progress (2015-09-21) 2 commits
  (merged to 'next' on 2015-09-21 at 15e698d)
 + filter-branch: make report-progress more readable
 + filter-branch: add passed/remaining seconds on progress

 Give progress meter to "git filter-branch".

 Will merge to 'master'.


* jk/interpret-trailers-outside-a-repository (2015-09-08) 1 commit
  (merged to 'next' on 2015-09-09 at a75fce3)
 + interpret-trailers: allow running outside a repository

 Allow "git interpret-trailers" to run outside of a Git repository.

 Will merge to 'master'.


* jk/test-lint-forbid-when-finished-in-subshell (2015-09-08) 5 commits
  (merged to 'next' on 2015-09-09 at 74ede61)
 + test-lib-functions: detect test_when_finished in subshell
 + t7800: don't use test_config in a subshell
 + test-lib-functions: support "test_config -C <dir> ..."
 + t5801: don't use test_when_finished in a subshell
 + t7610: don't use test_config in a subshell

 Because "test_when_finished" in our test framework queues the
 clean-up tasks to be done in a shell variable, it should not be
 used inside a subshell.  Add a mechanism to allow 'bash' to catch
 such uses, and fix the ones that were found.

 Will merge to 'master'.


* ls/p4-lfs (2015-09-28) 7 commits
 - git-p4: add Git LFS backend for large file system
 - git-p4: add support for large file systems
 - git-p4: check free space during streaming
 - git-p4: add file streaming progress in verbose mode
 - git-p4: return an empty list if a list config has no values
 - git-p4: add gitConfigInt reader
 - git-p4: add optional type specifier to gitConfig reader

 Teach "git p4" to send large blobs outside the repository by
 talking to Git LFS.

 Will merge to 'next'.


* nd/clone-linked-checkout (2015-09-28) 6 commits
 - clone: better error when --reference is a linked checkout
 - clone: allow --local from a linked checkout
 - enter_repo: allow .git files in strict mode
 - enter_repo: avoid duplicating logic, use is_git_directory() instead
 - t0002: add test for enter_repo(), non-strict mode
 - path.c: delete an extra space

 It was not possible to use a repository-lookalike created by "git
 worktree add" as a local source of "git clone".

 Will merge to 'next'.


* jh/quiltimport-explicit-series-file (2015-09-01) 1 commit
  (merged to 'next' on 2015-09-02 at 1129ca4)
 + git-quiltimport: add commandline option --series <file>

 "quiltimport" allows to specify the series file by honoring the
 $QUILT_SERIES environment and also --series command line option.

 Will merge to 'master'.


* jk/async-pkt-line (2015-09-01) 2 commits
  (merged to 'next' on 2015-09-02 at e185717)
 + pkt-line: show packets in async processes as "sideband"
 + run-command: provide in_async query function

 The debugging infrastructure for pkt-line based communication has
 been improved to mark the side-band communicatio specifically.

 Will merge to 'master'.


* jk/date-local (2015-09-03) 11 commits
  (merged to 'next' on 2015-09-08 at 66781d9)
 + t6300: add tests for "-local" date formats
 + t6300: make UTC and local dates different
 + date: make "local" orthogonal to date format
 + date: check for "local" before anything else
 + t6300: add test for "raw" date format
 + t6300: introduce test_date() helper
 + fast-import: switch crash-report date to iso8601
 + Documentation/rev-list: don't list date formats
 + Documentation/git-for-each-ref: don't list date formats
 + Documentation/config: don't list date formats
 + Documentation/blame-options: don't list date formats

 "git log --date=local" used to only allow to show the normal
 (default) format in the local timezone. The command learned to take
 'local' as an instruction to use the local timezone with other
 formats, e.g. "git show --date=rfc-local".

 Will merge to 'master'.


* nk/stash-show-config (2015-08-31) 1 commit
  (merged to 'next' on 2015-09-08 at 90dd06f)
 + stash: allow "stash show" diff output configurable

 Users who are too busy to type three extra keystrokes to ask for
 "git stash show -p" can now set stash.showPatch configuration
 varible to true to always see the actual patch, not just the list
 of paths affected with feel for the extent of damage via diffstat.

 Will merge to 'master'.


* ls/p4-path-encoding (2015-09-21) 3 commits
  (merged to 'next' on 2015-09-21 at 0772d82)
 + git-p4: use replacement character for non UTF-8 characters in paths
  (merged to 'next' on 2015-09-17 at 7f8b9e0)
 + git-p4: improve path encoding verbose output
  (merged to 'next' on 2015-09-08 at 56514f9)
 + git-p4: add config git-p4.pathEncoding

 "git p4" learned to reencode the pathname it uses to communicate
 with the p4 depot with a new option.

 Will merge to 'master'.


* ad/bisect-terms (2015-08-03) 4 commits
  (merged to 'next' on 2015-09-01 at ede6e64)
 + bisect: allow setting any user-specified in 'git bisect start'
 + bisect: add 'git bisect terms' to view the current terms
 + bisect: add the terms old/new
 + bisect: sanity check on terms

 The use of 'good/bad' in "git bisect" made it confusing to use when
 hunting for a state change that is not a regression (e.g. bugfix).
 The command learned 'old/new' and then allows the end user to
 say e.g. "bisect start --term-old=fast --term=new=slow" to find a
 performance regression.

 Michael's idea to make 'good/bad' more intelligent does have
 certain attractiveness ($gname/272867), and makes some of the work
 on this topic a moot point.

 Will merge to 'master'.


* dt/refs-bisection (2015-09-01) 3 commits
  (merged to 'next' on 2015-09-08 at 2b66bad)
 + refs: make refs/bisect/* per-worktree
 + path: optimize common dir checking
 + refs: clean up common_list

 Move the refs used during a "git bisect" session to per-worktree
 hierarchy refs/worktree/* so that independent bisect sessions can
 be done in different worktrees.

 Will merge to 'master'.


* ld/p4-import-labels (2015-08-28) 3 commits
  (merged to 'next' on 2015-09-01 at cf9f1d6)
 + git-p4: fix P4 label import for unprocessed commits
 + git-p4: do not terminate creating tag for unknown commit
 + git-p4: failing test for ignoring invalid p4 labels

 Will merge to 'master'.


* kn/for-each-tag (2015-09-17) 17 commits
  (merged to 'next' on 2015-09-17 at 1980952)
 + tag.c: implement '--merged' and '--no-merged' options
 + tag.c: implement '--format' option
 + tag.c: use 'ref-filter' APIs
 + tag.c: use 'ref-filter' data structures
 + ref-filter: add option to match literal pattern
 + ref-filter: add support to sort by version
 + ref-filter: add support for %(contents:lines=X)
 + ref-filter: add option to filter out tags, branches and remotes
 + ref-filter: implement an `align` atom
 + ref-filter: introduce match_atom_name()
 + ref-filter: introduce handler function for each atom
 + utf8: add function to align a string into given strbuf
 + ref-filter: introduce ref_formatting_state and ref_formatting_stack
 + ref-filter: move `struct atom_value` to ref-filter.c
 + strtoul_ui: reject negative values
 + Merge 'jk/git-path' into kn/for-each-tag
 + Merge 'kn/for-each-tag-branch' into kn/for-each-tag
 (this branch is used by kn/for-each-branch; uses kn/for-each-tag-branch.)

 The "ref-filter" code was taught about many parts of what "tag -l"
 does and then "tag -l" is reimplemented in terms of "ref-filter".

 Will merge to 'master'.


* nd/ita-cleanup (2015-09-06) 6 commits
 - grep: make it clear i-t-a entries are ignored
 - checkout(-index): do not checkout i-t-a entries
 - apply: make sure check_preimage() does not leave empty file on error
 - apply: fix adding new files on i-t-a entries
 - add and use a convenience macro ce_intent_to_add()
 - blame: remove obsolete comment

 Paths that have been told the index about with "add -N" are not yet
 in the index, but various commands behaved as if they already are.

 Some commits need better explanation.

 Waiting for a reroll.


* dk/gc-idx-wo-pack (2015-08-17) 3 commits
 - DONTMERGE: log message, grace-period and tests $gmane/276058
 - gc: remove stale .idx files without corresponding .pack file
 - prepare_packed_git(): refactor garbage reporting in pack directory

 Having a leftover .idx file without correspoinding .pack file in
 the repository hurts performance; "git gc" learned to prune them.

 Waiting for a reroll.


* bb/remote-get-url (2015-09-17) 1 commit
  (merged to 'next' on 2015-09-21 at c07a1e8)
 + remote: add get-url subcommand

 "git remote" learned "get-url" subcommand to show the URL for a
 given remote name used for fetching and pushing.

 Will merge to 'master'.


* sb/submodule-helper (2015-09-08) 4 commits
  (merged to 'next' on 2015-09-21 at 9354b31)
 + submodule: rewrite `module_clone` shell function in C
 + submodule: rewrite `module_name` shell function in C
 + submodule: rewrite `module_list` shell function in C
 + Merge 'hv/submodule-config' to 'sb/submodule-helper'
 (this branch is used by sb/submodule-parallel-fetch.)

 The infrastructure to rewrite "git submodule" in C is being built
 incrementally.  Let's polish these early parts well enough and make
 them graduate to 'next' and 'master', so that the more involved
 follow-up can start cooking on a solid ground.

 Will merge to 'master'.


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* kn/for-each-tag-branch (2015-08-03) 11 commits
  (merged to 'next' on 2015-08-03 at d9e94b9)
 + for-each-ref: add '--contains' option
 + ref-filter: implement '--contains' option
 + parse-options.h: add macros for '--contains' option
 + parse-option: rename parse_opt_with_commit()
 + for-each-ref: add '--merged' and '--no-merged' options
 + ref-filter: implement '--merged' and '--no-merged' options
 + ref-filter: add parse_opt_merge_filter()
 + for-each-ref: add '--points-at' option
 + ref-filter: implement '--points-at' option
 + tag: libify parse_opt_points_at()
 + t6302: for-each-ref tests for ref-filter APIs
 (this branch is used by kn/for-each-branch and kn/for-each-tag.)

 Originally merged to 'next' on 2015-07-15

 Some features from "git tag -l" and "git branch -l" have been made
 available to "git for-each-ref" so that eventually the unified
 implementation can be shared across all three, in a follow-up
 series or two.

 Will merge to 'master'.


* jc/rerere (2015-07-24) 21 commits
  (merged to 'next' on 2015-08-26 at 8ae15ef)
 + rerere: un-nest merge() further
 + rerere: use "struct rerere_id" instead of "char *" for conflict ID
 + rerere: call conflict-ids IDs
 + rerere: further clarify do_rerere_one_path()
 + rerere: further de-dent do_plain_rerere()
 + rerere: refactor "replay" part of do_plain_rerere()
 + rerere: explain the remainder
 + rerere: explain "rerere forget" codepath
 + rerere: explain the primary codepath
 + rerere: explain MERGE_RR management helpers
 + rerere: fix benign off-by-one non-bug and clarify code
 + rerere: explain the rerere I/O abstraction
 + rerere: do not leak mmfile[] for a path with multiple stage #1 entries
 + rerere: stop looping unnecessarily
 + rerere: drop want_sp parameter from is_cmarker()
 + rerere: report autoupdated paths only after actually updating them
 + rerere: write out each record of MERGE_RR in one go
 + rerere: lift PATH_MAX limitation
 + rerere: plug conflict ID leaks
 + rerere: handle conflicts with multiple stage #1 entries
 + rerere: fix an off-by-one non-bug
 (this branch is used by jc/rerere-multi.)

 Code clean-up and minor fixes.

 Will merge to 'master'.


* jc/rerere-multi (2015-09-14) 7 commits
 - rerere: do use multiple variants
 - t4200: rerere a merge with two identical conflicts
 - rerere: allow multiple variants to exist
 - rerere: delay the recording of preimage
 - rerere: handle leftover rr-cache/$ID directory and postimage files
 - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 - rerere: split conflict ID further
 (this branch uses jc/rerere.)

 "git rerere" can encounter two or more files with the same conflict
 signature that have to be resolved in different ways, but there was
 no way to record these separate resolutions.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-08-03 at a52c2b2)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Originally merged to 'next' on 2015-05-28

 Stop supporting "git merge <message> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will keep in 'next' during the 2.6 cycle.

--------------------------------------------------
[Discarded]

* sb/remove-get-pathspec (2015-08-03) 1 commit
 . builtin/mv: remove get_pathspec()

 ($gmane/276104)


* nd/list-files (2015-02-09) 21 commits
 . t3080: tests for git-list-files
 . list-files: -M aka diff-cached
 . list-files -F: show submodules with the new indicator '&'
 . list-files: add -F/--classify
 . list-files: show directories as well as files
 . list-files: do not show duplicate cached entries
 . list-files: sort output and remove duplicates
 . list-files: add -t back
 . list-files: add -1 short for --no-column
 . list-files: add -R/--recursive short for --max-depth=-1
 . list-files: -u does not imply showing stages
 . list-files: make alias 'ls' default to 'list-files'
 . list-files: a user friendly version of ls-files and more
 . ls-files: support --max-depth
 . ls-files: add --column
 . ls-files: add --color to highlight file names
 . ls-files: buffer full item in strbuf before printing
 . ls_colors.c: highlight submodules like directories
 . ls_colors.c: add a function to color a file name
 . ls_colors.c: parse color.ls.* from config file
 . ls_colors.c: add $LS_COLORS parsing code

 A new "git list-files" Porcelain command, "ls-files" with bells and
 whistles.

 Reroll to base on wt-status work ($gmane/265142) has seen some
 positive discussions.

 ($gmane/265534).


* mh/numparse (2015-03-19) 14 commits
 . diff_opt_parse(): use convert_i() when handling --abbrev=<num>
 . diff_opt_parse(): use convert_i() when handling "-l<num>"
 . opt_arg(): simplify pointer handling
 . opt_arg(): report errors parsing option values
 . opt_arg(): use convert_i() in implementation
 . opt_arg(): val is always non-NULL
 . builtin_diff(): detect errors when parsing --unified argument
 . handle_revision_opt(): use convert_ui() when handling "--abbrev="
 . strtoul_ui(), strtol_i(): remove functions
 . handle_revision_opt(): use convert_i() when handling "-<digit>"
 . handle_revision_opt(): use skip_prefix() in many places
 . write_subdirectory(): use convert_ui() for parsing mode
 . cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
 . numparse: new module for parsing integral numbers

 Many codepaths use unchecked use of strtol() and friends (or even
 worse, atoi()).  Introduce a set of wrappers that try to be more
 careful.

 ($gmane/268058).


* kk/log-merges-config (2015-04-21) 5 commits
 . bash-completion: add support for git-log --merges= and log.merges
 . t4202-log: add tests for --merges=
 . Documentation: add git-log --merges= option and log.merges config. var
 . log: honor log.merges= option
 . revision: add --merges={show|only|hide} option

 "git log" (but not other commands in the "log" family) learned to
 pay attention to the log.merges configuration variable that can be
 set to "show" (the normal behaviour), "only" (hide non-merge
 commits), or "hide" (hide merge commits).  --merges=(show|only|hide)
 can be used to override the setting from the command line.

 The documentation may need to be updated once more ($gmane/267250).


* bw/portability-solaris (2015-07-20) 3 commits
 . tests: fix sed usage in tests to work around broken xpg4/sed on Solaris
 . tests: fix sed usage in tests to work around broken xpg4/sed on Solaris
 . tests: modify tr expressions so that xpg4/tr handles it on Solaris

 ($gmane/274296)


* jc/clone-bundle (2015-04-30) 1 commit
 . repack: optionally create a clone.bundle

 Still an early WIP.


* mg/index-read-error-messages (2015-06-01) 2 commits
 . messages: uniform error messages for index write
 . show-index: uniform error messages for index read

 The tip was RFC.
 Waiting for a reroll.


* mk/utf8-no-iconv-warn (2015-06-08) 1 commit
 . utf8.c: print warning about disabled iconv

 Warn when a reencoding is requested in a build without iconv
 support, as the end user is likely to get an unexpected result.  I
 think the same level of safety should be added to a build with
 iconv support when the specified encoding is not available, but the
 patch does not go there.

 ($gmane/277424).


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 . remote: add --fetch and --both options to set-url

 Ejected.


* tr/remerge-diff (2014-11-10) 9 commits
 . t4213: avoid "|" in sed regexp
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . merge_diff_mode: fold all merge diff variants into an enum
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 . merge-recursive: -Xindex-only to leave worktree unchanged
 . merge-recursive: internal flag to avoid touching the worktree
 . merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Waiting for a reroll.
 ($gmane/256591).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 . perf-lib: add test_perf_cleanup target
 . perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.


* jc/show-branch (2014-03-24) 5 commits
 . show-branch: use commit slab to represent bitflags of arbitrary width
 . show-branch.c: remove "all_mask"
 . show-branch.c: abstract out "flags" operation
 . show-branch.c: lift all_mask/all_revs to a global static
 . show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit.
