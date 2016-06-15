From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sat, 21 Jun 2008 02:44:50 -0700
Message-ID: <7vwskjazql.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 21 11:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9zgD-0006Ai-Qx
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 11:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbYFUJpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 05:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbYFUJpK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 05:45:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYFUJpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 05:45:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 357D1A701;
	Sat, 21 Jun 2008 05:45:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6BF56A700; Sat, 21 Jun 2008 05:44:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B8EAC49E-3F76-11DD-8C7B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85695>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

It already is beginning to become clear what 1.6.0 will look like.  What's
already in 'next' all are well intentioned (I do not guarantee they are
already bug-free --- that is what cooking them in 'next' is for) and are
good set of feature enhancements.  But bigger changes will be:

 * MinGW will be in.

 * /usr/bin/git-cat-file is no more.  The bulk of the git commands will
   move to /usr/libexec/git-core/ or somesuch.

 * git-merge will be rewritten in C.

Currently tip of 'pu' is broken and does not pass tests, as j6t/mingw has
interaction with dr/ceiling and jc/merge-theirs has interaction with
mv/merge-in-c.

----------------------------------------------------------------
[New Topics]

* jc/merge-theirs (Fri Jun 20 00:17:59 2008 -0700) 2 commits
 - git-merge-recursive-{ours,theirs}
 - git-merge-file --ours, --theirs

Punting a merge by discarding your own work in conflicting parts but still
salvaging the parts that are cleanly automerged.  It is likely that this
will result in nonsense mishmash, but somehow often people want this, so
here they are.  The interface to the backends may need to change, though.

* lt/racy-empty (Tue Jun 10 10:44:43 2008 -0700) 1 commit
 + racy-git: an empty blob has a fixed object name

* ph/mergetool (Mon Jun 16 17:33:41 2008 -0600) 1 commit
 + Remove the use of '--' in merge program invocation

* j6t/mingw (Sat Nov 17 20:48:14 2007 +0100) 38 commits
 - compat/pread.c: Add a forward declaration to fix a warning
 - Windows: Fix ntohl() related warnings about printf formatting
 - Windows: TMP and TEMP environment variables specify a temporary
   directory.
 - Windows: Make 'git help -a' work.
 - Windows: Work around an oddity when a pipe with no reader is
   written to.
 - Windows: Make the pager work.
 - When installing, be prepared that template_dir may be relative.
 - Windows: Use a relative default template_dir and ETC_GITCONFIG
 - Windows: Compute the fallback for exec_path from the program
   invocation.
 - Turn builtin_exec_path into a function.
 - Windows: Use a customized struct stat that also has the st_blocks
   member.
 - Windows: Add a custom implementation for utime().
 - Windows: Add a new lstat and fstat implementation based on Win32
   API.
 - Windows: Implement a custom spawnve().
 - Windows: Implement wrappers for gethostbyname(), socket(), and
   connect().
 - Windows: Work around incompatible sort and find.
 - Windows: Implement asynchronous functions as threads.
 - Windows: Disambiguate DOS style paths from SSH URLs.
 - Windows: A rudimentary poll() emulation.
 - Windows: Change the name of hook scripts to make them not
   executable.
 - Windows: Implement start_command().
 - Windows: A pipe() replacement whose ends are not inherited to
   children.
 - Windows: Wrap execve so that shell scripts can be invoked.
 - Windows: Implement setitimer() and sigaction().
 - Windows: Fix PRIuMAX definition.
 - Windows: Implement gettimeofday().
 - Windows: Handle absolute paths in
   safe_create_leading_directories().
 - Windows: Treat Windows style path names.
 - setup.c: Prepare for Windows directory separators.
 - Windows: Work around misbehaved rename().
 - Windows: always chmod(, 0666) before unlink().
 - Windows: A minimal implemention of getpwuid().
 - Windows: Implement a wrapper of the open() function.
 - Windows: Strip ".exe" from the program name.
 - Windows: Use the Windows style PATH separator ';'.
 - Add target architecture MinGW.
 - Compile some programs only conditionally.
 - Add compat/regex.[ch] and compat/fnmatch.[ch].

No explanation is necessary ;-).

* sn/static (Thu Jun 19 08:21:11 2008 +0900) 2 commits
 + config.c: make git_env_bool() static
 + environment.c: remove unused function

* lt/config-fsync (Wed Jun 18 15:18:44 2008 -0700) 4 commits
 + Add config option to enable 'fsync()' of object files
 + Split up default "i18n" and "branch" config parsing into helper
   routines
 + Split up default "user" config parsing into helper routine
 + Split up default "core" config parsing into helper routine

* lw/gitweb (Thu Jun 19 22:03:21 2008 +0200) 1 commit
 + gitweb: standarize HTTP status codes

* mv/merge-in-c (Fri Jun 20 01:22:36 2008 +0200) 11 commits
 - Add new test to ensure git-merge handles more than 25 refs.
 - Build in merge
 - Introduce filter_independent() in commit.c
 - Introduce get_octopus_merge_bases() in commit.c
 - git-fmt-merge-msg: make it usable from other builtins
 - Move read_cache_unmerged() to read-cache.c
 - parseopt: add a new PARSE_OPT_ARGV0_IS_AN_OPTION option
 - Add new test to ensure git-merge handles pull.twohead and
   pull.octopus
 - Move parse-options's skip_prefix() to git-compat-util.h
 - Move commit_list_count() to commit.c
 - Move split_cmdline() to alias.c

* jc/maint-combine-diff-pre-context (Wed Jun 18 23:59:41 2008 -0700) 1 commit
 + diff -c/--cc: do not include uninteresting deletion before leading
   context

* lt/maint-gitdir-relative (Thu Jun 19 12:34:06 2008 -0700) 1 commit
 + Make git_dir a path relative to work_tree in setup_work_tree()

----------------------------------------------------------------
[Actively Cooking]

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 + Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

* dr/ceiling (Mon May 19 23:49:34 2008 -0700) 4 commits
 + Eliminate an unnecessary chdir("..")
 + Add support for GIT_CEILING_DIRECTORIES
 + Fold test-absolute-path into test-path-utils
 + Implement normalize_absolute_path

* jn/web (Tue Jun 10 19:21:44 2008 +0200) 2 commits
 + gitweb: Separate generating 'sort by' table header
 + gitweb: Separate filling list of projects info

* rs/archive-ignore (Sun Jun 8 18:42:33 2008 +0200) 1 commit
 + Teach new attribute 'export-ignore' to git-archive

* rg/gitweb (Fri Jun 6 09:53:32 2008 +0200) 1 commit
 + gitweb: remove git_blame and rename git_blame2 to git_blame

* kh/update-ref (Tue Jun 3 01:34:53 2008 +0200) 2 commits
 + Make old sha1 optional with git update-ref -d
 + Clean up builtin-update-ref's option parsing

* mo/status-untracked (Thu Jun 5 14:47:50 2008 +0200) 3 commits
 + Add configuration option for default untracked files mode
 + Add argument 'no' commit/status option -u|--untracked-files
 + Add an optional <mode> argument to commit/status -u|--untracked-
   files option

* sr/tests (Sun Jun 8 16:04:35 2008 +0200) 3 commits
 + Hook up the result aggregation in the test makefile.
 + A simple script to parse the results from the testcases
 + Modify test-lib.sh to output stats to t/test-results/*

* jh/clone-packed-refs (Sun Jun 15 16:06:16 2008 +0200) 4 commits
 + Teach "git clone" to pack refs
 + Prepare testsuite for a "git clone" that packs refs
 + Move pack_refs() and friends into libgit
 + Incorporate fetched packs in future object traversal

This is useful when cloning from a repository with insanely large number
of refs.

* jc/reflog-expire (Sun Jun 15 23:48:46 2008 -0700) 1 commit
 - Per-ref reflog expiry configuration

Perhaps a good foundation for optionally unexpirable stash.  As 1.6.0 will
be a good time to make backward incompatible changes, we might make expiry
period of stash 'never' in new repositories.  Needs a concensus.

* lw/perlish (Thu Jun 19 22:32:49 2008 +0200) 2 commits
 + Git.pm: add test suite
 + t/test-lib.sh: add test_external and test_external_without_stderr

Beginning of regression tests for Perl part of the system.

* jk/test (Sat Jun 14 03:28:07 2008 -0400) 5 commits
 + enable whitespace checking of test scripts
 + avoid trailing whitespace in zero-change diffstat lines
 + avoid whitespace on empty line in automatic usage message
 + mask necessary whitespace policy violations in test scripts
 + fix whitespace violations in test scripts

Tightens whitespace rules for t/*.sh scripts.

* pb/fast-export (Wed Jun 11 13:17:04 2008 +0200) 1 commit
 + builtin-fast-export: Add importing and exporting of revision marks

----------------------------------------------------------------
[Graduated to "master"]

Nothing today but expect many small ones to come out of 'next' this
weekend.

----------------------------------------------------------------
[On Hold]

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 7 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output
 + git-blame --reverse
 + builtin-blame.c: allow more than 16 parents
 + builtin-blame.c: move prepare_final() into a separate function.
 + rev-list --children
 + revision traversal: --children option

The blame that finds where each line in the original lines moved to.  This
may help a GSoC project that wants to gather statistical overview of the
history.  The final presentation may need tweaking (see the log message of
the commit ""git-blame --reverse" on the series).

The tip two commits are for peeling to see what's behind the blamed
commit, which we should be able to separate out into an independent topic
from the rest.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

Kicked back to 'pu' for now.

* js/rebase-i-sequencer (Sun Apr 27 02:55:50 2008 -0400) 17 commits
 - Use perl instead of tac
 - Fix t3404 assumption that `wc -l` does not use whitespace.
 - rebase -i: Use : in expr command instead of match.
 - rebase -i: update the implementation of 'mark' command
 - Add option --preserve-tags
 - Teach rebase interactive the tag command
 - Add option --first-parent
 - Do rebase with preserve merges with advanced TODO list
 - Select all lines with fake-editor
 - Unify the length of $SHORT* and the commits in the TODO list
 - Teach rebase interactive the merge command
 - Move redo merge code in a function
 - Teach rebase interactive the reset command
 - Teach rebase interactive the mark command
 - Move cleanup code into it's own function
 - Don't append default merge message to -m message
 - fake-editor: output TODO list if unchanged

It is very likely that this whole thing will be reverted from 'next' and
be replaced with the new sequenser series during 1.6.0 cycle.

* sj/merge (Sat May 3 16:55:47 2008 -0700) 6 commits
 - Introduce fast forward option only
 - Head reduction before selecting merge strategy
 - Restructure git-merge.sh
 - Introduce -ff=<fast forward option>
 - New merge tests
 - Documentation for joining more than two histories

This will interfere with Miklos's rewrite of merge to C.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will be
hit due to tcl/tk's limitation, so I am holding this back for now.

* jc/cherry-pick (Wed Feb 20 23:17:06 2008 -0800) 3 commits
 - WIP: rethink replay merge
 - Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive

This is meant to improve cherry-pick's behaviour when renames are
involved, by not using merge-recursive (whose d/f conflict resolution is
quite broken), but unfortunately has stalled for some time now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

Just my toy at this moment.
