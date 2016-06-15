From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2015, #04; Mon, 11)
Date: Mon, 11 May 2015 15:46:33 -0700
Message-ID: <xmqqk2we20mu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 00:46:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrwTK-0005Jy-Fm
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 00:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbbEKWqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 18:46:43 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33265 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbbEKWqf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 18:46:35 -0400
Received: by iepj10 with SMTP id j10so117951921iep.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=Mw6pOyoDLm4xKxMyiX6DlzrZpBa07npt+0sMTNFQsig=;
        b=GkrSWuR9vzkBJu52rezQPz+rKOz7fslaOmuUZf/NeaxV67dtYmHnAqHYUNatxytB4U
         OxQ0SibdQF8vsPz3TQsB6naKLyJ2oQURa8u0uTQWa9+mveFydGPZ0mZFfn+RPEBDdDi/
         BdjBig6Km/QY7fqqBLAPCRgCfBmTw8ZY5y/awZicilxSCXNv8iFs01anQXQBJl2p2LDQ
         9IyB7PVxF6UwKza+GS/cEbaJTJAgjbo2KwHq1tamwRkBvE5kUfFvwbLcS+wW0bhNEVA0
         UgVpEL5kpeSPSMsdUXHRpByFQ/xHWKh4AOkeolcQ7QyJakzA64//D9e0jOVCNsVgWtGA
         2R7A==
X-Received: by 10.107.131.135 with SMTP id n7mr16260316ioi.37.1431384395029;
        Mon, 11 May 2015 15:46:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id w4sm830966igl.22.2015.05.11.15.46.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 15:46:34 -0700 (PDT)
X-master-at: c518059b263bb506b96a0ae90c4d40408c760cb0
X-next-at: 91e4f9ead74701a5690c950e19c8b631ee8c7a4b
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268829>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Git 2.3.8 has been tagged; it contains Linus's favorite fix for "git
commit --date=now", among other things, and it will be the last for
2.3.x series for now.

We saw a few sizable topics rerolled this morning on the list;
sorry, but I didn't have time to get to them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ep/do-not-feed-a-pointer-to-array-size (2015-05-05) 1 commit
  (merged to 'next' on 2015-05-07 at 64d9a20)
 + git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array

 Catch a programmer mistake to feed a pointer not an array to
 ARRAY_SIZE() macro, by using a couple of GCC extensions.


* jc/daemon-no-ipv6-for-2.4.1 (2015-05-05) 1 commit
  (merged to 'next' on 2015-05-05 at 1eb279f)
 + daemon: unbreak NO_IPV6 build regression

 "git daemon" fails to build from the source under NO_IPV6
 configuration (regression in 2.4).


* jc/hash-object (2015-05-05) 4 commits
  (merged to 'next' on 2015-05-07 at 9b81a06)
 + write_sha1_file(): do not use a separate sha1[] array
 + t1007: add hash-object --literally tests
 + hash-object --literally: fix buffer overrun with extra-long object type
 + git-hash-object.txt: document --literally option

 "hash-object --literally" introduced in v2.2 was not prepared to
 take a really long object type name.


* jc/plug-fmt-merge-msg-leak (2015-04-20) 1 commit
  (merged to 'next' on 2015-05-05 at bd94828)
 + fmt-merge-msg: plug small leak of commit buffer

 Originally merged to 'next' on 2015-04-21


* jk/filter-branch-use-of-sed-on-incomplete-line (2015-04-29) 1 commit
  (merged to 'next' on 2015-05-07 at 849a24d)
 + filter-branch: avoid passing commit message through sed

 "filter-branch" corrupted commit log message that ends with an
 incomplete line on platforms with some "sed" implementations that
 munge such a line.  Work it around by avoiding to use "sed".


* jk/reading-packed-refs (2015-04-16) 9 commits
  (merged to 'next' on 2015-05-05 at 89b5694)
 + t1430: add another refs-escape test
 + read_packed_refs: avoid double-checking sane refs
 + strbuf_getwholeline: use getdelim if it is available
 + strbuf_getwholeline: avoid calling strbuf_grow
 + strbuf_addch: avoid calling strbuf_grow
 + config: use getc_unlocked when reading from file
 + strbuf_getwholeline: use getc_unlocked
 + git-compat-util: add fallbacks for unlocked stdio
 + strbuf_getwholeline: use getc macro

 Originally merged to 'next' on 2015-04-21

 An earlier rewrite to use strbuf_getwholeline() instead of fgets(3)
 to read packed-refs file revealed that the former is unacceptably
 inefficient.


* jk/rebase-quiet-noop (2015-04-28) 1 commit
  (merged to 'next' on 2015-05-05 at 82780b9)
 + rebase: silence "git checkout" for noop rebase

 "git rebase --quiet" was not quite quiet when there is nothing to
 do.


* jk/sha1-file-reduce-useless-warnings (2015-03-30) 1 commit
  (merged to 'next' on 2015-05-05 at a8de68e)
 + sha1_file: squelch "packfile cannot be accessed" warnings

 Originally merged to 'next' on 2015-04-21


* jk/still-interesting (2015-04-17) 1 commit
  (merged to 'next' on 2015-05-05 at 6a5c89c)
 + limit_list: avoid quadratic behavior from still_interesting

 Originally merged to 'next' on 2015-04-21

 "git rev-list --objects $old --not --all" to see if everything that
 is reachable from $old is already connected to the existing refs
 was very inefficient.


* jn/clean-use-error-not-fprintf-on-stderr (2015-05-04) 1 commit
  (merged to 'next' on 2015-05-05 at 12391f1)
 + config: use error() instead of fprintf(stderr, ...)

 Some error messages in "git config" were emitted without calling
 the usual error() facility.


* ld/p4-case-fold (2015-04-28) 1 commit
  (merged to 'next' on 2015-05-05 at 03ecbd0)
 + git-p4: add failing tests for case-folding p4d


* lm/squelch-bg-progress (2015-04-15) 2 commits
  (merged to 'next' on 2015-05-05 at a2fe74d)
 + compat/mingw: stubs for getpgid() and tcgetpgrp()
 + progress: no progress in background

 Originally merged to 'next' on 2015-04-21

 Many long-running operations show progress eye-candy, even when
 they are later backgrounded.  Hide the eye-candy when the process
 is sent to the background instead.


* ls/p4-changes-block-size (2015-04-20) 1 commit
  (merged to 'next' on 2015-05-05 at 92596d4)
 + git-p4: use -m when running p4 changes

 Originally merged to 'next' on 2015-04-21

 "git p4" learned "--changes-block-size <n>" to read the changes in
 chunks from Perforce, instead of making one call to "p4 changes"
 that may trigger "too many rows scanned" error from Perforce.


* mm/add-p-split-error (2015-04-16) 5 commits
  (merged to 'next' on 2015-05-05 at c556011)
 + stash -p: demonstrate failure of split with mixed y/n
 + t3904-stash-patch: factor PERL prereq at the top of the file
 + t3904-stash-patch: fix test description
 + add -p: demonstrate failure when running 'edit' after a split
 + t3701-add-interactive: simplify code

 Originally merged to 'next' on 2015-04-23

 When "add--interactive" splits a hunk into two overlapping hunks
 and then let the user choose only one, it sometimes feeds an
 incorrect patch text to "git apply".  Add tests to demonstrate
 this.

 I have a slight suspicion that this may be $gmane/87202 coming back
 and biting us (I seem to have said "let's run with this and see
 what happens" back then).


* nd/multiple-work-trees (2015-03-31) 41 commits
  (merged to 'next' on 2015-05-05 at 0f04a1c)
 + prune --worktrees: fix expire vs worktree existence condition
 + t1501: fix test with split index
 + t2026: fix broken &&-chain
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

 Originally merged to 'next' on 2015-04-02

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.


* nd/slim-index-pack-memory-usage (2015-04-18) 2 commits
  (merged to 'next' on 2015-05-05 at 42bd845)
 + index-pack: kill union delta_base to save memory
 + index-pack: reduce object_entry size to save memory

 Originally merged to 'next' on 2015-04-21

 Memory usage of "git index-pack" has been trimmed by tens of
 per-cent.


* pt/credential-xdg (2015-03-25) 4 commits
  (merged to 'next' on 2015-05-05 at 0d6711f)
 + t0302: "unreadable" test needs POSIXPERM
 + t0302: test credential-store support for XDG_CONFIG_HOME
 + git-credential-store: support XDG_CONFIG_HOME
 + git-credential-store: support multiple credential files
 (this branch is used by pt/xdg-config-path.)

 Originally merged to 'next' on 2015-03-25

 Tweak the sample "store" backend of the credential helper to honor
 XDG configuration file locations when specified.


* pt/xdg-config-path (2015-05-06) 7 commits
  (merged to 'next' on 2015-05-07 at 38e7071)
 + path.c: remove home_config_paths()
 + git-config: replace use of home_config_paths()
 + git-commit: replace use of home_config_paths()
 + credential-store.c: replace home_config_paths() with xdg_config_home()
 + dir.c: replace home_config_paths() with xdg_config_home()
 + attr.c: replace home_config_paths() with xdg_config_home()
 + path.c: implement xdg_config_home()
 (this branch uses pt/credential-xdg.)

 Code clean-up for xdg configuration path support.


* sb/prefix-path-free-results (2015-05-05) 1 commit
  (merged to 'next' on 2015-05-07 at 64f15a8)
 + prefix_path(): unconditionally free results in the callers

 Code clean-up (not a leak-fix).


* sg/complete-decorate-full-not-long (2015-05-03) 1 commit
  (merged to 'next' on 2015-05-07 at 2beb429)
 + completion: fix and update 'git log --decorate=' options

 The completion for "log --decorate=" parameter value was incorrect.


* sg/completion-no-redundant-all-command-list (2015-05-03) 1 commit
  (merged to 'next' on 2015-05-07 at 00b4bd9)
 + completion: remove redundant __git_compute_all_commands() call

 Code simplification.


* tb/blame-resurrect-convert-to-git (2015-05-03) 1 commit
  (merged to 'next' on 2015-05-05 at 8e1974e)
 + blame: CRLF in the working tree and LF in the repo

 Some time ago, "git blame" (incorrectly) lost the convert_to_git()
 call when synthesizing a fake "tip" commit that represents the
 state in the working tree, which broke folks who record the history
 with LF line ending to make their project portabile across
 platforms while terminating lines in their working tree files with
 CRLF for their platform.


* tb/t0027-crlf (2015-04-25) 3 commits
  (merged to 'next' on 2015-05-05 at 36accbb)
 + t0027: Add repoMIX and LF_nul
 + t0027: support NATIVE_CRLF platforms
 + t0027: cleanup: rename functions; avoid non-leading TABs

 Originally merged to 'next' on 2015-04-21

 More line-ending tests.


* va/fix-git-p4-tests (2015-04-28) 1 commit
  (merged to 'next' on 2015-05-05 at 795e858)
 + git-p4: t9814: prevent --chain-lint failure


* va/p4-client-path (2015-04-23) 2 commits
  (merged to 'next' on 2015-05-05 at 852facc)
 + git-p4: improve client path detection when branches are used
 + t9801: check git-p4's branch detection with client spec enabled

 Originally merged to 'next' on 2015-04-23

 git p4 attempts to better handle branches in Perforce.

--------------------------------------------------
[New Topics]

* dl/branch-error-message (2015-05-06) 1 commit
  (merged to 'next' on 2015-05-11 at ed947ab)
 + branch: do not call a "remote-tracking branch" a "remote branch"

 Error messages from "git branch" called remote-tracking branches as
 "remote branches".

 Will merge to 'master'.


* dl/subtree-push-no-squash (2015-05-07) 1 commit
  (merged to 'next' on 2015-05-11 at 74d07ca)
 + contrib/subtree: there's no push --squash

 "git subtree" script (in contrib/) does not have --squash option
 when pushing, but the documentation and help text pretended as if
 it did.

 Will merge to 'master'.


* ld/p4-editor-multi-words (2015-05-07) 2 commits
 - git-p4: fix handling of multi-word P4EDITOR
 - git-p4: add failing test for P4EDITOR handling

 Unlike "$EDITOR" and "$GIT_EDITOR" that can hold the path to the
 command and initial options (e.g. "/path/to/emacs -nw"), 'git p4'
 did not let the shell interpolate the contents of the environment
 variable that name the editor "$P4EDITOR" (and "$EDITOR", too).
 Make it in line with the rest of Git, as well as with Perforce.

 Reported to break some tests that assume the non-interpolating
 behaviour that need to be fixed.


* dl/subtree-avoid-tricky-echo (2015-05-08) 1 commit
  (merged to 'next' on 2015-05-11 at 36d4f0e)
 + contrib/subtree: portability fix for string printing

 "git subtree" script (in contrib/) used "echo -n" to produce
 progress messages in a non-portable way.

 Will merge to 'master'.


* ls/http-ssl-cipher-list (2015-05-08) 1 commit
  (merged to 'next' on 2015-05-11 at 55764ce)
 + http: add support for specifying an SSL cipher list

 Introduce http.<url>.SSLCipherList configuration variable to tweak
 the list of cipher suite to be used with libcURL when talking with
 https:// sites.

 Will merge to 'master'.


* ps/bundle-verify-arg (2015-05-08) 1 commit
  (merged to 'next' on 2015-05-11 at 9f1b1ae)
 + bundle: verify arguments more strictly

 "git bundle verify" did not diagnose extra parameters on the
 command line.

 Will merge to 'master'.


* sg/help-subcommands (2015-05-08) 1 commit
  (merged to 'next' on 2015-05-11 at 91e4f9e)
 + command-list.txt: fix whitespace inconsistency

 A preparatory clean-up step.

 Will merge to 'master'.


* mh/ref-directory-file-2 (2015-05-10) 19 commits
 - SQUASH???
 - reflog_expire(): integrate lock_ref_sha1_basic() errors into ours
 - ref_transaction_commit(): delete extra "the" from error message
 - ref_transaction_commit(): provide better error messages
 - rename_ref(): integrate lock_ref_sha1_basic() errors into ours
 - lock_ref_sha1_basic(): improve diagnostics for D/F conflicts
 - lock_ref_sha1_basic(): report errors via a "struct strbuf *err"
 - verify_refname_available(): report errors via a "struct strbuf *err"
 - verify_refname_available(): rename function
 - refs: check for D/F conflicts among refs processed in a transaction
 - ref_transaction_commit(): use a string_list for detecting duplicates
 - is_refname_available(): use dirname in first loop
 - struct nonmatching_ref_data: store a refname instead of a ref_entry
 - report_refname_conflict(): inline function
 - entry_matches(): inline function
 - is_refname_available(): convert local variable "dirname" to strbuf
 - is_refname_available(): avoid shadowing "dir" variable
 - is_refname_available(): explain the reason for an early exit
 - t1404: new tests of D/F conflicts within ref transactions
 (this branch uses mh/write-refs-sooner-2.2, mh/write-refs-sooner-2.3 and mh/write-refs-sooner-2.4.)

 A reroll is posted, but haven't got a chance to pick it up yet.


* mh/write-refs-sooner-2.2 (2015-05-10) 8 commits
 - ref_transaction_commit(): fix atomicity and avoid fd exhaustion
 - ref_transaction_commit(): remove the local flags variable
 - ref_transaction_commit(): inline call to write_ref_sha1()
 - rename_ref(): inline calls to write_ref_sha1() from this function
 - commit_ref_update(): new function, extracted from write_ref_sha1()
 - write_ref_to_lockfile(): new function, extracted from write_ref_sha1()
 - t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
 - update-ref: test handling large transactions properly
 (this branch is used by mh/ref-directory-file-2, mh/write-refs-sooner-2.3 and mh/write-refs-sooner-2.4.)

 Multi-ref transaction support we merged a few releases ago
 unnecessarily kept many file descriptors open, risking to fail with
 resource exhaustion.


* mh/write-refs-sooner-2.3 (2015-05-10) 1 commit
 - Merge branch 'mh/write-refs-sooner' into mh/write-refs-sooner-2.3
 (this branch is used by mh/ref-directory-file-2 and mh/write-refs-sooner-2.4; uses mh/write-refs-sooner-2.2.)

 Multi-ref transaction support we merged a few releases ago
 unnecessarily kept many file descriptors open, risking to fail with
 resource exhaustion.  This is for 2.3.x track.


* mh/write-refs-sooner-2.4 (2015-05-10) 1 commit
 - Merge branch 'mh/write-refs-sooner-2.3' into mh/write-refs-sooner-2.4
 (this branch is used by mh/ref-directory-file-2; uses mh/write-refs-sooner-2.2 and mh/write-refs-sooner-2.3.)

 Multi-ref transaction support we merged a few releases ago
 unnecessarily kept many file descriptors open, risking to fail with
 resource exhaustion.  This is for 2.4.x track.


* sb/ref-lock-lose-lock-fd (2015-05-10) 1 commit
 - refs.c: remove lock_fd from struct ref_lock

 The refs API uses ref_lock struct which had its own "int fd", even
 though the same file descriptor was in the lock struct it contains.
 Clean-up the code to lose this redundant field.

 Will merge to 'next'.

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


* nd/pathspec-strip-fix (2015-04-18) 1 commit
 - pathspec: adjust prefixlen after striping trailing slash

 Does not quite fix ($gmane/267614).


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

* sg/completion-omit-credential-helpers (2015-05-06) 1 commit
  (merged to 'next' on 2015-05-11 at aa7e554)
 + completion: remove credential helpers from porcelain commands

 The Git subcommand completion (in contrib/) listed credential
 helpers among candidates, which is not something the end user would
 invoke interatively.

 Will merge to 'master'.


* jk/skip-http-tests-under-no-curl (2015-05-07) 2 commits
  (merged to 'next' on 2015-05-11 at a52b711)
 + tests: skip dav http-push tests under NO_EXPAT=NoThanks
 + t/lib-httpd.sh: skip tests if NO_CURL is defined

 Test clean-up.

 Will merge to 'master'.


* nd/dwim-wildcards-as-pathspecs (2015-05-03) 1 commit
  (merged to 'next' on 2015-05-07 at 8176de7)
 + pathspec: avoid the need of "--" when wildcard is used

 A heuristic to help the "git <cmd> <revs> <pathspec>" command line
 convention to catch mistyped paths is to make sure all the non-rev
 parameters in the later part of the command line are names of the
 files in the working tree, but that means "git grep $str -- \*.c"
 must always be disambiguated with "--", because nobody sane will
 create a file whose name literally is asterisk-dot-see.  Loosen the
 heuristic to declare that with a wildcard string the user likely
 meant to give us a pathspec.

 Will merge to 'master' in the third batch.


* pt/pull-tests (2015-05-03) 7 commits
 - t5521: test --dry-run does not make any changes
 - t5520: test --rebase failure on unborn branch with index
 - t5520: test --rebase with multiple branches
 - t5520: test work tree fast-forward when fetch updates head
 - t5520: test for failure if index has unresolved entries
 - t5520: implement tests for no merge candidates cases
 - t5520: test pulling multiple branches into an empty repository

 Add more test coverage to "git pull".  This conflicts slightly with
 a new test jc/merge topic adds, but resolution is fairly trivial.

 Expecting a reroll ($gmane/268391).


* jc/clone-bundle (2015-04-30) 1 commit
 - repack: optionally create a clone.bundle

 Still an early WIP


* jk/at-push-sha1 (2015-05-03) 12 commits
 - for-each-ref: accept "%(push)" format
 - for-each-ref: use skip_prefix instead of starts_with
 - sha1_name: implement @{push} shorthand
 - sha1_name: refactor interpret_upstream_mark
 - sha1_name: refactor upstream_mark
 - remote.c: add branch_get_push
 - remote.c: report specific errors from branch_get_upstream
 - remote.c: introduce branch_get_upstream helper
 - remote.c: provide per-branch pushremote name
 - remote.c: hoist branch.*.remote lookup out of remote_get_1
 - remote.c: drop "remote" pointer from "struct branch"
 - remote.c: drop default_remote_name variable

 Introduce <branch>@{push} short-hand to denote the remote-tracking
 branch that tracks the branch at the remote the <branch> would be
 pushed to.

 Expecting a reroll ($gmane/268419, etc.).


* ph/rebase-i-redo (2015-04-29) 1 commit
  (merged to 'next' on 2015-05-07 at 8fc1f52)
 + rebase -i: redo tasks that die during cherry-pick

 "git rebase -i" moved the "current" command from "todo" to "done" a
 bit too prematurely, losing a step when a "pick" did not even start.

 Will merge to 'master' in the third batch.


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


* jc/gitignore-precedence (2015-04-22) 1 commit
  (merged to 'next' on 2015-05-05 at 6ef85da)
 + ignore: info/exclude should trump core.excludesfile

 core.excludesfile (defaulting to $XDG_HOME/git/ignore) is supposed
 to be overridden by repository-specific .git/info/exclude file, but
 the order was swapped from the beginning. This belatedly fixes it.

 Will merge to 'master' in the third batch.


* jk/git-no-more-argv0-path-munging (2015-04-22) 1 commit
  (merged to 'next' on 2015-05-05 at b3f9a45)
 + stop putting argv[0] dirname at front of PATH

 We have prepended $GIT_EXEC_PATH and the path "git" is installed in
 (typically "/usr/bin") to $PATH when invoking subprograms and hooks
 for almost eternity, but the original use case the latter tried to
 support was semi-bogus (i.e. install git to /opt/foo/git and run it
 without having /opt/foo on $PATH), and more importantly it has
 become less and less relevant as Git grew more mainstream (i.e. the
 users would _want_ to have it on their $PATH).  Stop prepending the
 path in which "git" is installed to users' $PATH, as that would
 interfere the command search order people depend on (e.g. they may
 not like versions of programs that are unrelated to Git in /usr/bin
 and want to override them by having different ones in /usr/local/bin
 and have the latter directory earlier in their $PATH).

 Will merge to 'master' in the third batch.


* jk/stash-require-clean-index (2015-04-22) 3 commits
  (merged to 'next' on 2015-05-05 at b5f6c32)
 + stash: require a clean index to apply
 + t3903: avoid applying onto dirty index
 + t3903: stop hard-coding commit sha1s

 "git stash pop/apply" forgot to make sure that not just the working
 tree is clean but also the index is clean. The latter is important
 as a stash application can conflict and the index will be used for
 conflict resolution.

 Will merge to 'master' in the third batch.


* jc/merge (2015-04-29) 15 commits
  (merged to 'next' on 2015-05-07 at 1c56512)
 + merge: deprecate 'git merge <message> HEAD <commit>' syntax
 + merge: handle FETCH_HEAD internally
 + merge: decide if we auto-generate the message early in collect_parents()
 + merge: make collect_parents() auto-generate the merge message
 + merge: extract prepare_merge_message() logic out
 + merge: narrow scope of merge_names
 + merge: split reduce_parents() out of collect_parents()
 + merge: clarify collect_parents() logic
 + merge: small leakfix and code simplification
 + merge: do not check argc to determine number of remote heads
 + merge: clarify "pulling into void" special case
 + t5520: test pulling an octopus into an unborn branch
 + t5520: style fixes
 + merge: simplify code flow
 + merge: test the top-level merge driver
 (this branch is used by jc/merge-drop-old-syntax.)

 "git merge FETCH_HEAD" learned that the previous "git fetch" could
 be to create an Octopus merge, i.e. recording multiple branches
 that are not marked as "not-for-merge"; this allows us to lose an
 old style invocation "git merge <msg> HEAD $commits..." in the
 implementation of "git pull" script; the old style syntax can now
 be deprecated.

 Will merge to 'master' in the third batch.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax
 (this branch uses jc/merge.)

 Stop supporting "git merge <messsage> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will merge to 'next' and keep there during the 2.5 cycle.


* jk/test-chain-lint (2015-04-28) 2 commits
  (merged to 'next' on 2015-05-05 at e6f0290)
 + test-lib: turn on GIT_TEST_CHAIN_LINT by default
 + t7502-commit.sh: fix a broken and-chain

 Developer support to automatically detect broken &&-chain in the
 test scripts is now turned on by default.

 Will merge to 'master' in the third batch.


* bc/connect-plink (2015-04-28) 3 commits
  (merged to 'next' on 2015-05-05 at 9def2e1)
 + connect: improve check for plink to reduce false positives
 + t5601: fix quotation error leading to skipped tests
 + connect: simplify SSH connection code path

 The connection initiation code for "ssh" transport tried to absorb
 differences between the stock "ssh" and Putty-supplied "plink" and
 its derivatives, but the logic to tell that we are using "plink"
 variants were too loose and falsely triggered when "plink" appeared
 anywhere in the path (e.g. "/home/me/bin/uplink/ssh").

 Will merge to 'master' in the third batch.


* jc/test-prereq-validate (2015-04-28) 1 commit
  (merged to 'next' on 2015-05-05 at a30464c)
 + test: validate prerequistes syntax

 Help us to find broken test script that splits the body part of the
 test by mistaken use of wrong kind of quotes.

 Will merge to 'master' in the third batch.


* fg/document-commit-message-stripping (2015-04-27) 1 commit
  (merged to 'next' on 2015-05-05 at 1892a99)
 + Documentation: clarify how "git commit" cleans up the edited log message

 Will merge to 'master' in the third batch.


* ah/usage-strings (2015-05-03) 2 commits
 - branch: fix funny-sounding error message
 - blame, log: format usage strings similarly to those in documentation

 A few usage string updates.  The tip one still needs work.


* kn/cat-file-literally (2015-05-06) 4 commits
 - t1006: add tests for git cat-file --allow-unknown-type
 - cat-file: teach cat-file a '--allow-unknown-type' option
 - cat-file: make the options mutually exclusive
 - sha1_file: support reading from a loose object of unknown type

 Add the "--allow-unknown-type" option to "cat-file" to allow
 inspecting loose objects of an experimental or a broken type.

 Will merge to 'next'.


* nd/diff-i-t-a (2015-03-23) 1 commit
  (merged to 'next' on 2015-05-05 at cba9cd9)
 + diff-lib.c: adjust position of i-t-a entries in diff

 Originally merged to 'next' on 2015-03-24

 After "git add -N", the path appeared in output of "git diff HEAD"
 and "git diff --cached HEAD", leading "git status" to classify it
 as "Changes to be committed".  Such a path, however, is not yet to
 be scheduled to be committed.  "git diff" showed the change to the
 path as modification, not as a "new file", in the header of its
 output.

 Treat such paths as "yet to be added to the index but Git already
 know about them"; "git diff HEAD" and "git diff --cached HEAD"
 should not talk about them, and "git diff" should show them as new
 files yet to be added to the index.

 Will merge to 'master' in the third batch.

--------------------------------------------------
[Discarded]


* mh/ref-directory-file (2015-05-05) 19 commits
 . SQUASH???
 . reflog_expire(): integrate lock_ref_sha1_basic() errors into ours
 . ref_transaction_commit(): delete extra "the" from error message
 . ref_transaction_commit(): provide better error messages
 . rename_ref(): integrate lock_ref_sha1_basic() errors into ours
 . lock_ref_sha1_basic(): improve diagnostics for D/F conflicts
 . lock_ref_sha1_basic(): report errors via a "struct strbuf *err"
 . verify_refname_available(): report errors via a "struct strbuf *err"
 . verify_refname_available(): rename function
 . refs: check for D/F conflicts among refs processed in a transaction
 . ref_transaction_commit(): use a string_list for detecting duplicates
 . is_refname_available(): use dirname in first loop
 . struct nonmatching_ref_data: store a refname instead of a ref_entry
 . report_refname_conflict(): inline function
 . entry_matches(): inline function
 . is_refname_available(): convert local variable "dirname" to strbuf
 . is_refname_available(): avoid shadowing "dir" variable
 . is_refname_available(): explain the reason for an early exit
 . t1404: new tests of D/F conflicts within ref transactions
 (this branch uses mh/ref-lock-avoid-running-out-of-fds.)

 Reroll posted, but didn't have time to pick it up.



* mh/ref-lock-avoid-running-out-of-fds (2015-04-25) 8 commits
 . ref_transaction_commit(): only keep one lockfile open at a time
 . ref_transaction_commit(): remove the local flags variables
 . write_ref_sha1(): inline function at callers
 . commit_ref_update(): new function, extracted from write_ref_sha1()
 . write_ref_to_lockfile(): new function, extracted from write_ref_sha1()
 . refs.c: remove lock_fd from struct ref_lock
 . t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
 . update-ref: test handling large transactions properly
 (this branch is used by mh/ref-directory-file.)

 Superseded by mh/write-refs-sooner* series.
