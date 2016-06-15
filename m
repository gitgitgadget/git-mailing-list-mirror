From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 29 Jun 2008 01:55:13 -0700
Message-ID: <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
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
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 29 10:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCshx-0002wW-59
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbYF2Izc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYF2Izc
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:55:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbYF2Iz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:55:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9225D29C6;
	Sun, 29 Jun 2008 04:55:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E837C29C5; Sun, 29 Jun 2008 04:55:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1D6BB5CA-45B9-11DD-8A72-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86788>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be applied to the maintenance series have "maint-" in their
names.

It already is beginning to become clear what 1.6.0 will look like.  What's
already in 'next' all are well intentioned (I do not guarantee they are
already bug-free --- that is what cooking them in 'next' is for) and are
good set of feature enhancements.  Bigger changes will be:

 * MinGW will be in.

 * /usr/bin/git-cat-file is no more.  The bulk of the git commands will
   move to /usr/libexec/git-core/ or somesuch.

 * git-merge will be rewritten in C.

 * default pack and idx versions will be updated as scheduled for some
   time ago.

----------------------------------------------------------------
[New Topics]

* jk/maint-fetch-ref-hier (Thu Jun 26 23:59:50 2008 -0400) 1 commit
 + fetch: report local storage errors in status table

When the remote used to have "foo" branch but now has "foo/bar", fetch
refuses to delete the existing remote tracking branch "foo" to create a
new remote tracking branch "foo/bar", but the error message was
confusing.

* jc/maint-reset (Wed Jun 25 18:16:36 2008 -0700) 1 commit
 + Allow "git-reset path" when unambiguous

We used to require "git-reset -- path" even when there is no ambiguity
(i.e. path cannot be mistaken as a valid tree-ish and it is a filename in
the work tree).

* js/maint-clone-insteadof (Fri Jun 27 13:56:05 2008 +0100) 1 commit
 . clone: respect url.insteadOf setting in global configs

"git clone" does not honor "url.InsteadOf" in $HOME/.gitconfig; Daniel
seems to have ideas for a better fix than this, but this is worth fixing
on 'maint'.

* tr/send-email-ssl (Thu Jun 26 23:03:21 2008 +0200) 2 commits
 + git-send-email: prevent undefined variable warnings if no
   encryption is set
 + git-send-email: add support for TLS via Net::SMTP::SSL

* kb/send-email-fifo (Wed Jun 25 15:44:40 2008 -0700) 1 commit
 + git-send-email: Accept fifos as well as files

Two minor send-email feature enhancements for 1.6.0.

* jc/checkdiff (Thu Jun 26 16:08:05 2008 -0700) 6 commits
 + Update sample pre-commit hook to use "diff --check"
 + diff --check: detect leftover conflict markers
 + Teach "diff --check" about new blank lines at end
 + checkdiff: pass diff_options to the callback
 + check_and_emit_line(): rename and refactor
 + diff --check: explain why we do not care whether old side is
   binary

Allows us to replace the sample pre-commit hook that was not aware of the
line termination convention per path nor newer whitespace breakage rules.

* np/pack-default (Wed Jun 25 00:25:53 2008 -0400) 2 commits
 + pack.indexversion config option now defaults to 2
 + repack.usedeltabaseoffset config option now defaults to "true"

Updates the default value for pack.indexversion to 2 and use delta-base
offset encoding of the packfiles by default.

* js/apply-recount (Fri Jun 27 18:43:09 2008 +0100) 1 commit
 + Allow git-apply to recount the lines in a hunk (AKA recountdiff)

A good ingredient for implementing "apply --edit".

* dz/apply-again (Fri Jun 27 14:39:12 2008 -0400) 1 commit
 + git-apply: handle a patch that touches the same path more than
   once better

Allows us to feed a patch that touches the same path more than once.

* ph/parseopt-step-blame (Tue Jun 24 11:12:12 2008 +0200) 7 commits
 - Migrate git-blame to parse-option partially.
 - parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
 - parse-opt: fake short strings for callers to believe in.
 - parse-opt: do not pring errors on unknown options, return -2
   intead.
 - parse-opt: create parse_options_step.
 - parse-opt: Export a non NORETURN usage dumper.
 - parse-opt: have parse_options_{start,end}.

----------------------------------------------------------------
[Will merge to master soon]

* nd/dashless (Tue Jun 24 19:58:11 2008 -0700) 2 commits
 + Keep some git-* programs in $(bindir)
 + Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.  We'll leave server-side programs in $(bindir) 
so that ssh clients can ask for "git-program" and find them on the $PATH.

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

* jc/dashless (Thu Jun 26 16:43:34 2008 -0700) 4 commits
 + Revert "Make clients ask for "git program" over ssh and local
   transport"
 + Make clients ask for "git program" over ssh and local transport
 + Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 + git-shell: accept "git foo" form

----------------------------------------------------------------
[Actively Cooking]

* jc/reflog-expire (Sat Jun 28 22:24:49 2008 -0700) 2 commits
 - Make default expiration period of reflog used for stash infinite
 - Per-ref reflog expiry configuration

As 1.6.0 will be a good time to make backward incompatible changes, the
tip commit makes the default expiry period of stash 'never', unless you
configure them to expire explicitly using gc.refs/stash.* variables.
Needs consensus, but I am guessing that enough people would want stash
that does not expire.

* jc/merge-theirs (Sat Jun 28 17:28:22 2008 -0700) 3 commits
 - Teach git-merge to pass -X<option> to the backend strategy module
 - git-merge-recursive-{ours,theirs}
 - git-merge-file --ours, --theirs

Punting a merge by discarding your own work in conflicting parts but still
salvaging the parts that are cleanly automerged.  It is likely that this
will result in nonsense mishmash, but somehow often people want this, so
here they are.  The interface to the backends is updated so that you can
say "git merge -Xours -s recursive other" now.

* j6t/mingw (Sat Nov 17 20:48:14 2007 +0100) 38 commits
 + compat/pread.c: Add a forward declaration to fix a warning
 + Windows: Fix ntohl() related warnings about printf formatting
 + Windows: TMP and TEMP environment variables specify a temporary
   directory.
 + Windows: Make 'git help -a' work.
 + Windows: Work around an oddity when a pipe with no reader is
   written to.
 + Windows: Make the pager work.
 + When installing, be prepared that template_dir may be relative.
 + Windows: Use a relative default template_dir and ETC_GITCONFIG
 + Windows: Compute the fallback for exec_path from the program
   invocation.
 + Turn builtin_exec_path into a function.
 + Windows: Use a customized struct stat that also has the st_blocks
   member.
 + Windows: Add a custom implementation for utime().
 + Windows: Add a new lstat and fstat implementation based on Win32
   API.
 + Windows: Implement a custom spawnve().
 + Windows: Implement wrappers for gethostbyname(), socket(), and
   connect().
 + Windows: Work around incompatible sort and find.
 + Windows: Implement asynchronous functions as threads.
 + Windows: Disambiguate DOS style paths from SSH URLs.
 + Windows: A rudimentary poll() emulation.
 + Windows: Implement start_command().
 + Windows: A pipe() replacement whose ends are not inherited to
   children.
 + Windows: Wrap execve so that shell scripts can be invoked.
 + Windows: Implement setitimer() and sigaction().
 + Windows: Fix PRIuMAX definition.
 + Windows: Implement gettimeofday().
 + Make my_mktime() public and rename it to tm_to_time_t()
 + Windows: Work around misbehaved rename().
 + Windows: always chmod(, 0666) before unlink().
 + Windows: A minimal implemention of getpwuid().
 + Windows: Implement a wrapper of the open() function.
 + Windows: Strip ".exe" from the program name.
 + Windows: Handle absolute paths in
   safe_create_leading_directories().
 + Windows: Treat Windows style path names.
 + setup.c: Prepare for Windows directory separators.
 + Windows: Use the Windows style PATH separator ';'.
 + Add target architecture MinGW.
 + Compile some programs only conditionally.
 + Add compat/regex.[ch] and compat/fnmatch.[ch].

No explanation necessary ;-)

* mv/merge-in-c (Sat Jun 28 04:38:19 2008 +0200) 13 commits
 - Build in merge
 - Add new test case to ensure git-merge prepends the custom merge
   message
 - Add new test case to ensure git-merge reduces octopus parents when
   possible
 - Introduce reduce_heads()
 - Introduce get_merge_bases_many()
 - Add new test to ensure git-merge handles more than 25 refs.
 - Introduce get_octopus_merge_bases() in commit.c
 - git-fmt-merge-msg: make it usable from other builtins
 - Move read_cache_unmerged() to read-cache.c
 - Add new test to ensure git-merge handles pull.twohead and
   pull.octopus
 - Move parse-options's skip_prefix() to git-compat-util.h
 - Move commit_list_count() to commit.c
 - Move split_cmdline() to alias.c

The last one is a huge patch and it will take some time to review and get
details sorted out.

* dr/ceiling (Mon May 19 23:49:34 2008 -0700) 4 commits
 + Eliminate an unnecessary chdir("..")
 + Add support for GIT_CEILING_DIRECTORIES
 + Fold test-absolute-path into test-path-utils
 + Implement normalize_absolute_path

* jc/rerere (Sun Jun 22 02:04:31 2008 -0700) 5 commits
 + rerere.autoupdate
 + t4200: fix rerere test
 + rerere: remove dubious "tail_optimization"
 + git-rerere: detect unparsable conflicts
 + rerere: rerere_created_at() and has_resolution() abstraction

A new configuration will allow paths that have been resolved cleanly by
rerere to be updated in the index automatically.

----------------------------------------------------------------
[Graduated to "master"]

* sb/rebase (Sun Jun 22 01:55:50 2008 +0200) 2 commits
 + t3404: stricter tests for git-rebase--interactive
 + api-builtin.txt: update and fix typo

* sb/maint-rebase (Sun Jun 22 16:07:02 2008 +0200) 1 commit
 + git-rebase.sh: Add check if rebase is in progress

* lw/gitweb (Thu Jun 19 22:03:21 2008 +0200) 1 commit
 + gitweb: standarize HTTP status codes

* lt/config-fsync (Wed Jun 18 15:18:44 2008 -0700) 4 commits
 + Add config option to enable 'fsync()' of object files
 + Split up default "i18n" and "branch" config parsing into helper
   routines
 + Split up default "user" config parsing into helper routine
 + Split up default "core" config parsing into helper routine

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

* lw/perlish (Thu Jun 19 22:32:49 2008 +0200) 2 commits
 + Git.pm: add test suite
 + t/test-lib.sh: add test_external and test_external_without_stderr

Beginning of regression tests for Perl part of the system.

----------------------------------------------------------------
[On Hold]

* ph/mergetool (Mon Jun 16 17:33:41 2008 -0600) 1 commit
 + Remove the use of '--' in merge program invocation

Waiting for success reports from people who use various backends.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will be
hit due to tcl/tk's limitation, so I am holding this back for now.

----------------------------------------------------------------
[Stalled/Needs more work]

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

----------------------------------------------------------------
[Dropped for now]

* sj/merge (Sat May 3 16:55:47 2008 -0700) 6 commits
 . Introduce fast forward option only
 . Head reduction before selecting merge strategy
 . Restructure git-merge.sh
 . Introduce -ff=<fast forward option>
 . New merge tests
 . Documentation for joining more than two histories

This will interfere with Miklos's rewrite of merge to C.

* js/rebase-i-sequencer (Sun Apr 27 02:55:50 2008 -0400) 17 commits
 . Use perl instead of tac
 . Fix t3404 assumption that `wc -l` does not use whitespace.
 . rebase -i: Use : in expr command instead of match.
 . rebase -i: update the implementation of 'mark' command
 . Add option --preserve-tags
 . Teach rebase interactive the tag command
 . Add option --first-parent
 . Do rebase with preserve merges with advanced TODO list
 . Select all lines with fake-editor
 . Unify the length of $SHORT* and the commits in the TODO list
 . Teach rebase interactive the merge command
 . Move redo merge code in a function
 . Teach rebase interactive the reset command
 . Teach rebase interactive the mark command
 . Move cleanup code into it's own function
 . Don't append default merge message to -m message
 . fake-editor: output TODO list if unchanged

* jc/cherry-pick (Wed Feb 20 23:17:06 2008 -0800) 3 commits
 . WIP: rethink replay merge
 . Start using replay-tree merge in cherry-pick
 . revert/cherry-pick: start refactoring call to merge_recursive

This is meant to improve cherry-pick's behaviour when renames are
involved, by not using merge-recursive (whose d/f conflict resolution is
quite broken), but unfortunately has stalled for some time now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 . git-am --forge: add Signed-off-by: line for the author
 . git-am: clean-up Signed-off-by: lines
 . stripspace: add --log-clean option to clean up signed-off-by:
   lines
 . stripspace: use parse_options()
 . Add "git am -s" test
 . git-am: refactor code to add signed-off-by line for the committer

Just my toy at this moment.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 . "git push": tellme-more protocol extension
