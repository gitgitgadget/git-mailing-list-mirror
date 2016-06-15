From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2008, #03; Thu, 14)
Date: Thu, 14 Aug 2008 01:51:56 -0700
Message-ID: <7v7iakdln7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 10:53:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTYZz-0008SS-E8
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 10:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbYHNIwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 04:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbYHNIwG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 04:52:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbYHNIwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 04:52:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 78E1B5858C;
	Thu, 14 Aug 2008 04:52:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6640858588; Thu, 14 Aug 2008 04:51:58 -0400 (EDT)
X-master-at: a0653d550524a0263d36fde6a8cf98941dd057ab
X-next-at: 8dd0c03fb2b8807ef71d5e807e65818dbd05a118
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 422C2D38-69DE-11DD-ADF8-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92336>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* ak/p4 (Sun Aug 10 19:26:35 2008 +0100) 12 commits
 + Put in the two other configuration elements found in the source
 + Put some documentation in about the parameters that have been
   added
 + Move git-p4.syncFromOrigin into a configuration parameters section
 + Consistently use 'git-p4' for the configuration entries
 + If the user has configured various parameters, use them.
 + Switch to using 'p4_build_cmd'
 + If we are in verbose mode, output what we are about to run (or
   return)
 + Add a single command that will be used to construct the 'p4'
   command
 + Utilise the new 'p4_system' function.
 + Have a command that specifically invokes 'p4' (via system)
 + Utilise the new 'p4_read_pipe_lines' command
 + Create a specific version of the read_pipe_lines command for p4
   invocations

Warmly received by the primary contributor of git-p4; I do not mind
merging this before 1.6.0.

* mv/merge-recursive (Tue Aug 12 22:14:00 2008 +0200) 3 commits
 - Make builtin-revert.c use merge_recursive_generic()
 - merge-recursive.c: Add more generic merge_recursive_generic()
 - Split out merge_recursive() to merge-recursive.c

I do not think builtlin-revert should use "recursive", but these patches
give a good starting point to separate the bulk of the "rename-aware
three-way merge" into library form.

* tr/rev-list-docs (Tue Aug 12 01:55:37 2008 +0200) 1 commit
 + Documentation: rev-list-options: move --simplify-merges
   documentation

* sp/missing-thin-base (Tue Aug 12 11:31:06 2008 -0700) 1 commit
 + pack-objects: Allow missing base objects when creating thin packs

* tr/filter-branch (Tue Aug 12 10:45:59 2008 +0200) 4 commits
 - filter-branch: use --simplify-merges
 - Merge branch 'jc/post-simplify' into tr/filter-branch
 - filter-branch: fix ref rewriting with --subdirectory-filter
 - filter-branch: Extend test to show rewriting bug

* js/checkout-dwim-local (Sat Aug 9 16:00:12 2008 +0200) 1 commit
 + checkout --track: make up a sensible branch name if '-b' was
   omitted

I like this low-impact usability enhancement; will most likely be in
master soon after 1.6.0.

* bd/diff-strbuf (Wed Aug 13 23:18:22 2008 -0700) 3 commits
 + xdiff-interface: hide the whole "xdiff_emit_state" business from
   the caller
 + Use strbuf for struct xdiff_emit_state's remainder
 + Make xdi_diff_outf interface for running xdiff_outf diffs

Gives measurable performance improvement to textual diff generation.  For
improving "blame" performance, it might be more effective to hook directly
to lower level of xdiff machinery so that we do not even have to generate
patch only to discard after reading "@@ -l,k +m,n @@" lines, but that
would be a separate topic.

* am/cherry-pick-rerere (Sun Aug 10 17:18:55 2008 +0530) 1 commit
 + Make cherry-pick use rerere for conflict resolution.

----------------------------------------------------------------
[On Hold and/or Cooking]

* jc/test-deeper (Fri Aug 8 02:26:28 2008 -0700) 1 commit
 - tests: use $TEST_DIRECTORY to refer to the t/ directory

* kh/diff-tree (Sun Aug 10 18:13:04 2008 +0200) 4 commits
 + Add test for diff-tree --stdin with two trees
 + Teach git diff-tree --stdin to diff trees
 + diff-tree: Note that the commit ID is printed with --stdin
 + Refactoring: Split up diff_tree_stdin

* js/parallel-test (Fri Aug 8 13:08:37 2008 +0200) 3 commits
 + Enable parallel tests
 + tests: Clarify dependencies between tests, 'aggregate-results' and
   'clean'
 + t9700: remove useless check

* xx/post-1.6.0 (Mon Aug 11 21:45:52 2008 -0400) 7 commits
 + git-submodule foreach - Include output and clarify usage.
 + Fix commit_tree() buffer leak
 + Teach git log --exit-code to return an appropriate exit code
 + Teach git log --check to return an appropriate exit code
 + git-submodule - Add 'foreach' subcommand
 + builtin-reflog: Allow reflog expire to name partial ref
 + git-am: ignore --binary option

Random collection of patches to queue for post-1.6.0 development.

* jc/post-simplify (Sun Aug 3 17:47:16 2008 -0700) 3 commits
 + Topo-sort before --simplify-merges
 + revision traversal: show full history with merge simplification
 + revision.c: whitespace fix

"log --full-history" is with too much clutter, "log" itself is too cleverer
than some people, and here is the middle level of merge simplification.

* sp/smart-http (Sun Aug 3 00:25:17 2008 -0700) 2 commits
 - [do not merge -- original version] Add Git-aware CGI for Git-aware
   smart HTTP transport
 - Add backdoor options to receive-pack for use in Git-aware CGI

The "magic" detection protocol was revised to use POST to info/refs; the
top one queued is from before that discussion.

* jc/add-stop-at-symlink (Mon Aug 4 00:52:37 2008 -0700) 2 commits
 + add: refuse to add working tree items beyond symlinks
 + update-index: refuse to add working tree items beyond symlinks

Fix for a longstanding bug that allows "git add" and "git update-index" to
add a path "a/b" to the index when "a" is a symbolic link.  We would need
a similar fix for the case where "a" is a submodule.

* dp/hash-literally (Sun Aug 3 18:36:22 2008 +0400) 6 commits
 + add --no-filters option to git hash-object
 + add --path option to git hash-object
 + use parse_options() in git hash-object
 + correct usage help string for git-hash-object
 + correct argument checking test for git hash-object
 + teach index_fd to work with pipes

Gives a bit more flexibility to hash-objects by allowing us to lie about
the path the contents comes from.

* mv/merge-custom (Wed Aug 13 23:32:43 2008 +0200) 7 commits
 + Update .gitignore to ignore git-help
 + Builtin git-help.
 + builtin-help: always load_command_list() in cmd_help()
 + Add a second testcase for handling invalid strategies in git-merge
 + Add a new test for using a custom merge strategy
 + builtin-merge: allow using a custom strategy
 + builtin-help: make some internal functions available to other
   builtins

* cc/merge-base-many (Sun Jul 27 13:47:22 2008 -0700) 4 commits
 + git-merge-octopus: use (merge-base A (merge B C D E...)) for
   stepwise merge
 + merge-base-many: add trivial tests based on the documentation
 + documentation: merge-base: explain "git merge-base" with more than
   2 args
 + merge-base: teach "git merge-base" to drive underlying
   merge_bases_many()

* rs/imap (Wed Jul 9 22:29:02 2008 +0100) 5 commits
 + Documentation: Improve documentation for git-imap-send(1)
 + imap-send.c: more style fixes
 + imap-send.c: style fixes
 + git-imap-send: Support SSL
 + git-imap-send: Allow the program to be run from subdirectories of
   a git tree

Some people seem to prefer having this feature available also with gnutls.
Such an enhancement can be done in-tree on top of this series if they are
so inclined.

* cc/bisect (Fri Jul 25 05:36:37 2008 +0200) 2 commits
 - bisect: only check merge bases when needed
 - bisect: test merge base if good rev is not an ancestor of bad rev

The first one alone does not pass its self-test but combined together they
seem to.  It does not build confidence as the latter one is supposed to be
an optimization only.

* jc/add-addremove (Tue Jul 22 22:30:40 2008 -0700) 2 commits
 + builtin-add.c: optimize -A option and "git add ."
 + builtin-add.c: restructure the code for maintainability

* jk/pager-swap (Tue Jul 22 03:14:12 2008 -0400) 2 commits
 + spawn pager via run_command interface
 + run-command: add pre-exec callback

This changes the parent-child relationship between the pager and the git
process.  We used to make pager the parent which meant that the exit
status from git is lost from the caller.

* ph/enable-threaded (Mon Jul 21 11:23:43 2008 +0200) 1 commit
 + Enable threaded delta search on *BSD and Linux.

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

This was previously in "will be in master soon" category, but it turns out
that the synonyms to the ones this one deletes are fairly new invention
that happend in 1.5.6 timeframe, and we cannot do this just yet.  Perhaps
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

This would be the right thing to do for command line use, but gitk will be
hit due to tcl/tk's limitation, so I am holding this back for now.
