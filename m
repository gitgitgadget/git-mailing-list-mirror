From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2008, #06; Wed, 20)
Date: Wed, 20 Aug 2008 17:30:16 -0700
Message-ID: <7vabf7mcpz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 02:31:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVy5J-0002fs-83
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 02:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbYHUAaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2008 20:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbYHUAaZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 20:30:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbYHUAaY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2008 20:30:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CDF0F61A6B;
	Wed, 20 Aug 2008 20:30:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2523C61A68; Wed, 20 Aug 2008 20:30:19 -0400 (EDT)
X-master-at: ea3594e04184475226109a21e71c539ff5f139fd
X-next-at: c5a00f7ff5becd929d3e3b3e900d0983cd6083af
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5777224E-6F18-11DD-91E9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93078>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

Today's 'pu' does not pass tests for me; it seems my box does not like =
new
tests for gitweb somehow.

By the way, here is a list of issues without any corresponding topic
branches yet:

 * Windows relocatable install=20

   Steffen Prohaska ($gmane/92605), Johannes Sixt.

 * Haiku port

   Andreas F=C3=A4rber ($gmane/92582)

 * ksh "trap foo EXIT" triggers on function return, loses exit status

   Brandon Casey ($gmane/92873)

 * document webdav debugging tip with davfs2

   Giovanni Funchal ($gmane/92745)

 * update "rebase -i" documentation with examples

   Eric Hanchrow ($gmane/92669)

 * pre-push hook

   Scott Chacon ($gmane/92900, $gmane/92936)

----------------------------------------------------------------
[New Topics]

* jc/no-slim-shell (Tue Aug 19 18:05:43 2008 -0700) 2 commits
 + Build-in "git-shell"
 + shell: do not play duplicated definition games to shrink the
   executable

----------------------------------------------------------------
[Stalled -- Needs Updates]

I've moved the "Stalled" section up so that it grabs more attention fro=
m
people.

* lt/time-reject-fractional-seconds (Sat Aug 16 21:25:40 2008 -0700) 1 =
commit
 - date/time: do not get confused by fractional seconds

Linus hints further enhancements as "the right way", so let's see if
somebody else steps up and tries it before merging this to 'next'.

* sp/smart-http (Sun Aug 3 00:25:17 2008 -0700) 2 commits
 - [do not merge -- original version] Add Git-aware CGI for Git-aware
   smart HTTP transport
 - Add backdoor options to receive-pack for use in Git-aware CGI

The "magic" detection protocol was revised to use POST to info/refs; th=
e
top one queued is from before that discussion.

* cc/bisect (Fri Jul 25 05:36:37 2008 +0200) 2 commits
 - bisect: only check merge bases when needed
 - bisect: test merge base if good rev is not an ancestor of bad rev

The first one alone does not pass its self-test but combined together t=
hey
seem to.  It does not build confidence as the latter one is supposed to=
 be
an optimization only.  Resend of fixed-up series is needed.

----------------------------------------------------------------
[Actively Cooking]

* jc/cc-ld-dynpath (Sat Aug 16 15:01:23 2008 +0200) 2 commits
 - configure: auto detect dynamic library path switches
 - Makefile: Allow CC_LD_DYNPATH to be overriden

Needs success reports from people who do use user-defined dynamic libra=
ry
path when they build their "git" before this series can go anywhere.

* sb/daemon (Thu Aug 14 20:02:20 2008 +0200) 4 commits
 - git-daemon: rewrite kindergarden, new option --max-connections
 - git-daemon: Simplify dead-children reaping logic
 - git-daemon: use LOG_PID, simplify logging code
 - git-daemon: call logerror() instead of error()

Can somebody who actually runs the daemon standalone comment on this on=
e?

* mv/merge-recursive (Tue Aug 12 22:14:00 2008 +0200) 3 commits
 - Make builtin-revert.c use merge_recursive_generic()
 - merge-recursive.c: Add more generic merge_recursive_generic()
 - Split out merge_recursive() to merge-recursive.c

Miklos will be working on updates.

* lw/gitweb (Mon Aug 18 21:39:49 2008 +0200) 3 commits
 - gitweb: use new Git::Repo API, and add optional caching
 - add new Perl API: Git::Repo, Git::Commit, Git::Tag, and
   Git::RepoRoot
 - gitweb: add test suite with Test::WWW::Mechanize::CGI

* jc/diff-prefix (Mon Aug 18 20:08:09 2008 -0700) 1 commit
 - diff: vary default prefix depending on what are compared

* sp/missing-thin-base (Tue Aug 12 11:31:06 2008 -0700) 1 commit
 + pack-objects: Allow missing base objects when creating thin packs

* tr/filter-branch (Tue Aug 12 10:45:59 2008 +0200) 3 commits
 + filter-branch: use --simplify-merges
 + filter-branch: fix ref rewriting with --subdirectory-filter
 + filter-branch: Extend test to show rewriting bug

=46ixes a longstanding filter branch bug.  Success stories?

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 8 commits
 - revision --simplify-merges: incremental simplification
 - revision --simplify-merges: prepare for incremental simplification
 - revision --simplify-merges: make it a no-op without pathspec
 + revision --simplify-merges: do not leave commits unprocessed
 + revision --simplify-merges: use decoration instead of commit->util
   field
 + Topo-sort before --simplify-merges
 + revision traversal: show full history with merge simplification
 + revision.c: whitespace fix

"log --full-history" is with too much clutter, "log" itself is too clev=
erer
than some people, and here is the middle level of merge simplification.

I started making this incremental but the progress is not so great.

* tr/rev-list-docs (Tue Aug 12 01:55:37 2008 +0200) 1 commit
 + Documentation: rev-list-options: move --simplify-merges
   documentation

----------------------------------------------------------------
[Will merge to master soon]

* ml/submodule-foreach (Sun Aug 10 19:10:04 2008 -0400) 1 commit
 + git-submodule - Add 'foreach' subcommand

* pm/log-exit-code (Mon Aug 11 08:46:25 2008 +0200) 2 commits
 + Teach git log --exit-code to return an appropriate exit code
 + Teach git log --check to return an appropriate exit code

* sb/commit-tree-minileak (Tue Aug 12 00:35:11 2008 +0200) 1 commit
 + Fix commit_tree() buffer leak

* pb/reflog-dwim (Sun Aug 10 22:22:21 2008 +0200) 1 commit
 + builtin-reflog: Allow reflog expire to name partial ref

* jc/add-stop-at-symlink (Mon Aug 4 00:52:37 2008 -0700) 2 commits
 + add: refuse to add working tree items beyond symlinks
 + update-index: refuse to add working tree items beyond symlinks

=46ix for a longstanding bug that allows "git add" and "git update-inde=
x" to
add a path "a/b" to the index when "a" is a symbolic link.  We would ne=
ed
a similar fix for the case where "a" is a submodule.

* mv/merge-custom (Wed Aug 13 23:32:43 2008 +0200) 7 commits
 + Update .gitignore to ignore git-help
 + Builtin git-help.
 + builtin-help: always load_command_list() in cmd_help()
 + Add a second testcase for handling invalid strategies in git-merge
 + Add a new test for using a custom merge strategy
 + builtin-merge: allow using a custom strategy
 + builtin-help: make some internal functions available to other
   builtins

* kh/diff-tree (Sun Aug 10 18:13:04 2008 +0200) 4 commits
 + Add test for diff-tree --stdin with two trees
 + Teach git diff-tree --stdin to diff trees
 + diff-tree: Note that the commit ID is printed with --stdin
 + Refactoring: Split up diff_tree_stdin

* mg/count-objects (Fri Aug 15 00:20:20 2008 -0400) 1 commit
 + count-objects: Add total pack size to verbose output

This one is without the human readable bits.

* mz/push-verbose (Sat Aug 16 19:58:32 2008 +0200) 1 commit
 + Make push more verbose about illegal combination of options

* jc/index-extended-flags (Sat Aug 16 23:02:08 2008 -0700) 1 commit
 + index: future proof for "extended" index entries

* cc/merge-base-many (Sun Jul 27 13:47:22 2008 -0700) 4 commits
 + git-merge-octopus: use (merge-base A (merge B C D E...)) for
   stepwise merge
 + merge-base-many: add trivial tests based on the documentation
 + documentation: merge-base: explain "git merge-base" with more than
   2 args
 + merge-base: teach "git merge-base" to drive underlying
   merge_bases_many()

* jc/add-addremove (Tue Jul 22 22:30:40 2008 -0700) 2 commits
 + builtin-add.c: optimize -A option and "git add ."
 + builtin-add.c: restructure the code for maintainability

* am/cherry-pick-rerere (Sun Aug 10 17:18:55 2008 +0530) 1 commit
 + Make cherry-pick use rerere for conflict resolution.

* js/parallel-test (Mon Aug 18 12:25:40 2008 -0400) 4 commits
 + Update t/.gitignore to ignore all trash directories
 + Enable parallel tests
 + tests: Clarify dependencies between tests, 'aggregate-results' and
   'clean'
 + t9700: remove useless check

* jc/test-deeper (Fri Aug 8 02:26:28 2008 -0700) 1 commit
 + tests: use $TEST_DIRECTORY to refer to the t/ directory

This does not actually move "t/test directory" any deeper, but fixes te=
st
scripts that assume they run immediately below "t/" to use TEST_DIRECTO=
RY
variable.

----------------------------------------------------------------
[On Hold]

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

* jc/merge-whitespace (Sun Feb 24 23:29:36 2008 -0800) 1 commit
 - WIP: start teaching the --whitespace=3Dfix to merge machinery

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

This was previously in "will be in master soon" category, but it turns =
out
that the synonyms to the ones this one deletes are fairly new invention
that happend in 1.5.6 timeframe, and we cannot do this just yet.  Perha=
ps
in 1.7.0.

* jc/dashless (Wed Jun 25 15:55:11 2008 -0700) 1 commit
 - Make clients ask for "git program" over ssh and local transport

This is the "botched" one.  Will be resurrected during 1.7.0 or 1.8.0
timeframe.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will=
 be
hit due to tcl/tk's limitation, so I am holding this back for now.

----------------------------------------------------------------
[Graduated to "master"]

* js/mingw-stat (Mon Aug 18 22:01:06 2008 +0200) 2 commits
 + Revert "Windows: Use a customized struct stat that also has the
   st_blocks member."
 + compat: introduce on_disk_bytes()

This gets rid of use of st_blocks member (which is XSI but not POSIX
proper), which was originally prompted by recent Haiku port but it turn=
s
out MinGW has the same issue as well.  Queued on 'pu' just to have a
chance to make sure I munged the version j6t sent me correctly before
merging it upwards.

* js/checkout-dwim-local (Sat Aug 9 16:00:12 2008 +0200) 1 commit
 + checkout --track: make up a sensible branch name if '-b' was
   omitted

Alex has update to dwim "checkout --track remotes/origin/hack" as well.

* bd/diff-strbuf (Wed Aug 13 23:18:22 2008 -0700) 3 commits
 + xdiff-interface: hide the whole "xdiff_emit_state" business from
   the caller
 + Use strbuf for struct xdiff_emit_state's remainder
 + Make xdi_diff_outf interface for running xdiff_outf diffs

Gives measurable performance improvement to textual diff generation.  F=
or
improving "blame" performance, it might be more effective to hook direc=
tly
to lower level of xdiff machinery so that we do not even have to genera=
te
patch only to discard after reading "@@ -l,k +m,n @@" lines, but that
would be a separate topic.

* dp/hash-literally (Sun Aug 3 18:36:22 2008 +0400) 6 commits
 + add --no-filters option to git hash-object
 + add --path option to git hash-object
 + use parse_options() in git hash-object
 + correct usage help string for git-hash-object
 + correct argument checking test for git hash-object
 + teach index_fd to work with pipes

Gives a bit more flexibility to hash-objects by allowing us to lie abou=
t
the path the contents comes from.

* rs/imap (Wed Jul 9 22:29:02 2008 +0100) 5 commits
 + Documentation: Improve documentation for git-imap-send(1)
 + imap-send.c: more style fixes
 + imap-send.c: style fixes
 + git-imap-send: Support SSL
 + git-imap-send: Allow the program to be run from subdirectories of
   a git tree

Some people seem to prefer having this feature available also with gnut=
ls.
Such an enhancement can be done in-tree on top of this series if they a=
re
so inclined.

* jk/pager-swap (Tue Jul 22 03:14:12 2008 -0400) 2 commits
 + spawn pager via run_command interface
 + run-command: add pre-exec callback

This changes the parent-child relationship between the pager and the gi=
t
process.  We used to make pager the parent which meant that the exit
status from git is lost from the caller.

* ph/enable-threaded (Mon Jul 21 11:23:43 2008 +0200) 1 commit
 + Enable threaded delta search on *BSD and Linux.
