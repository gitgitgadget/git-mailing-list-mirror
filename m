From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 06 Jul 2008 03:04:28 -0700
Message-ID: <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
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
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 12:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFR7x-00062R-Fe
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 12:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbYGFKEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jul 2008 06:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbYGFKEn
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 06:04:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbYGFKEl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jul 2008 06:04:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F31D1E2C5;
	Sun,  6 Jul 2008 06:04:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 930611E2C3; Sun,  6 Jul 2008 06:04:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F2A4B514-4B42-11DD-816F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87511>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be applied to the maintenance series have "maint-" in their
names.

It already is beginning to become clear what 1.6.0 will look like.  Wha=
t's
already in 'next' all are well intentioned (I do not guarantee they are
already bug-free --- that is what cooking them in 'next' is for) and ar=
e
good set of feature enhancements.  Bigger changes will be:

 * Port for MinGW.

 * With the default Makefile settings, most of the programs will be
   installed outside your $PATH, except for "git", "gitk", "git-gui" an=
d
   some server side programs that need to be accessible for technical
   reasons.  Invoking a git subcommand as "git-xyzzy" from the command
   line has been deprecated since early 2006 (and officially announced =
in
   1.5.4 release notes); use of them from your scripts after adding
   output from "git --exec-path" to the $PATH will still be supported i=
n
   1.6.0, but users are again strongly encouraged to adjust their
   scripts to use "git xyzzy" form, as we will stop installing
   "git-xyzzy" hardlinks for built-in commands in later releases.

 * git-merge will be rewritten in C.

 * default pack and idx versions will be updated as scheduled for some
   time ago.

 * GIT_CONFIG, which was only documented as affecting "git config", but
   actually affected all git commands, now only affects "git config".
   GIT_LOCAL_CONFIG, also only documented as affecting "git config" and
   not different from GIT_CONFIG in a useful way, is removed.

----------------------------------------------------------------
[New Topics]

* js/maint-daemon-syslog (Thu Jul 3 16:27:24 2008 +0100) 1 commit
 - [PARKED improvement suggested not rolled in] git daemon: avoid
   calling syslog() from a signal handler

This will eventually appear in 'maint'; currently parked on 'pu', thoug=
h.

* jc/report-tracking (Sun Jul 6 02:54:56 2008 -0700) 5 commits
 - branch -r -v: do not spit out garbage
 + stat_tracking_info(): clear object flags used during counting
 + git-branch -v: show the remote tracking statistics
 + git-status: show the remote tracking statistics
 + Refactor "tracking statistics" code used by "git checkout"

Makes the "your branch is ahead of the tracked one by N commits" logic =
and
messages available to other commands; status and branch are updated.

* sg/stash-k-i (Fri Jun 27 16:37:15 2008 +0200) 1 commit
 - stash: introduce 'stash save --keep-index' option

One weakness of our "partial commit" workflow support used to be that t=
he
user can incrementally build what is to be committed in the index but t=
hat
state cannot be tested as a whole in the working tree.  This allows you=
 to
temporarily stash the remaining changes in the working tree so that the
index state before running "stash save --keep-index" can be seen in the
working tree to be tested and then committed.  A recommended workflow t=
o
use after that commit is made needs to be documented (and support needs=
 to
be added if necessary).

* tr/add-i-e (Thu Jul 3 00:00:00 2008 +0200) 3 commits
 + git-add--interactive: manual hunk editing mode
 + git-add--interactive: remove hunk coalescing
 + git-add--interactive: replace hunk recounting with apply --recount

Adds 'e/dit' action to interactive add command.

* am/stash-branch (Thu Jul 3 11:46:05 2008 +0530) 1 commit
 + Implement "git stash branch <newbranch> <stash>"

Creates a new branch out of the stashed state, after returning from the
interrupt that forced you to create the stash in the first place.

* jc/grafts (Wed Jul 2 17:14:12 2008 -0700) 1 commit
 - Ignore graft during object transfer [broken wrt shallow clones]

Cloning or fetching from a repository from grafts did not send objects
that are hidden by grafts, but the commits in the resulting repository =
do
need these to pass fsck.  This fixes object transfer to ignore grafts.

Another fix is needed to git-prune so that it ignores grafts but treats
commits that are mentioned in grafts as reachable.

* jk/pager-config (Thu Jul 3 07:46:57 2008 -0400) 1 commit
 - Allow per-command pager config

----------------------------------------------------------------
[Will merge to master soon]

* js/import-zip (Mon Jun 30 19:50:44 2008 +0100) 1 commit
 + Add another fast-import example, this time for .zip files

* js/apply-root (Wed Jul 2 15:28:22 2008 -0700) 2 commits
 + apply --root: thinkofix.
 + Teach "git apply" to prepend a prefix with "--root=3D<root>"

* db/no-git-config (Mon Jun 30 03:37:47 2008 -0400) 1 commit
 + Only use GIT_CONFIG in "git config", not other programs

* jc/reflog-expire (Sat Jun 28 22:24:49 2008 -0700) 2 commits
 + Make default expiration period of reflog used for stash infinite
 + Per-ref reflog expiry configuration

As 1.6.0 will be a good time to make backward incompatible changes, the
tip commit makes the default expiry period of stash 'never', unless you
configure them to expire explicitly using gc.refs/stash.* variables.
Needs consensus, but I am guessing that enough people would want stash
that does not expire.

* dr/ceiling (Mon May 19 23:49:34 2008 -0700) 4 commits
 + Eliminate an unnecessary chdir("..")
 + Add support for GIT_CEILING_DIRECTORIES
 + Fold test-absolute-path into test-path-utils
 + Implement normalize_absolute_path

This still feels "because we can", not "because we need to", but it cam=
e
from somebody who had the need to, and I do not think it hurts people
without the environment variable set.

* jc/rerere (Sun Jun 22 02:04:31 2008 -0700) 5 commits
 + rerere.autoupdate
 + t4200: fix rerere test
 + rerere: remove dubious "tail_optimization"
 + git-rerere: detect unparsable conflicts
 + rerere: rerere_created_at() and has_resolution() abstraction

A new configuration will allow paths that have been resolved cleanly by
rerere to be updated in the index automatically.

To me, this is "because we can", but was something requested by Ingo, s=
o
presumably some people may feel it useful in their workflow.

----------------------------------------------------------------
[Actively Cooking]

* mv/merge-in-c (Tue Jul 1 04:37:50 2008 +0200) 15 commits
 - [REJECT -- over-abuse of path-list] Build in merge
 + Fix t7601-merge-pull-config.sh on AIX
 + git-commit-tree: make it usable from other builtins
 + Add new test case to ensure git-merge prepends the custom merge
   message
 + Add new test case to ensure git-merge reduces octopus parents when
   possible
 + Introduce reduce_heads()
 + Introduce get_merge_bases_many()
 + Add new test to ensure git-merge handles more than 25 refs.
 + Introduce get_octopus_merge_bases() in commit.c
 + git-fmt-merge-msg: make it usable from other builtins
 + Move read_cache_unmerged() to read-cache.c
 + Add new test to ensure git-merge handles pull.twohead and
   pull.octopus
 + Move parse-options's skip_prefix() to git-compat-util.h
 + Move commit_list_count() to commit.c
 + Move split_cmdline() to alias.c

The last one is still not quite there, I am afraid.

----------------------------------------------------------------
[Graduated to "master"]

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

----------------------------------------------------------------
[On Hold]

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

This was previously in "will be in master soon" category, but it turns =
out
that the synonyms to the ones this one deletes are fairly new invention
that happend in 1.5.6 timeframe, and we cannot do this just yet.  Perha=
ps
in 1.7.0.

* jc/dashless (Thu Jun 26 16:43:34 2008 -0700) 2 commits
 + Revert "Make clients ask for "git program" over ssh and local
   transport"
 + Make clients ask for "git program" over ssh and local transport

This is the "botched" one.  Will be resurrected during 1.7.0 or 1.8.0
timeframe.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will=
 be
hit due to tcl/tk's limitation, so I am holding this back for now.

----------------------------------------------------------------
[Stalled/Needs more work]

* ph/parseopt-step-blame (Tue Jun 24 11:12:12 2008 +0200) 7 commits
 - Migrate git-blame to parse-option partially.
 + parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
 + parse-opt: fake short strings for callers to believe in.
 + parse-opt: do not print errors on unknown options, return -2
   intead.
 + parse-opt: create parse_options_step.
 + parse-opt: Export a non NORETURN usage dumper.
 + parse-opt: have parse_options_{start,end}.

I recall Pierre said something about cleaning up the last one when he
finds time, but other than that vague recollection, I lost track of thi=
s
series.  I am tempted to fork a few topics off of the pen=C3=BAltimo on=
e to
convert a few more commands as examples and merge the result to 'next'.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 7 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output
 + git-blame --reverse
 + builtin-blame.c: allow more than 16 parents
 + builtin-blame.c: move prepare_final() into a separate function.
 + rev-list --children
 + revision traversal: --children option

The blame that finds where each line in the original lines moved to.  T=
his
may help a GSoC project that wants to gather statistical overview of th=
e
history.  The final presentation may need tweaking (see the log message=
 of
the commit ""git-blame --reverse" on the series).

The tip two commits are for peeling to see what's behind the blamed
commit, which we should be able to separate out into an independent top=
ic
from the rest.

* jc/merge-theirs (Mon Jun 30 22:18:57 2008 -0700) 5 commits
 + Make "subtree" part more orthogonal to the rest of merge-
   recursive.
 + Teach git-pull to pass -X<option> to git-merge
 + Teach git-merge to pass -X<option> to the backend strategy module
 + git-merge-recursive-{ours,theirs}
 + git-merge-file --ours, --theirs

Punting a merge by discarding your own work in conflicting parts but st=
ill
salvaging the parts that are cleanly automerged.  It is likely that thi=
s
will result in nonsense mishmash, but somehow often people want this, s=
o
here they are.  The interface to the backends is updated so that you ca=
n
say "git merge -Xours -Xsubtree=3Dfoo/bar/baz -s recursive other" now.

The -X<option> part may change, Dscho mentions that a single-letter -X
that take stuck option is against syntax rules, and I think he's right.

This is more "because we can", not "because we need to".
