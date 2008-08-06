From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2008, #01; Tue, 05)
Date: Tue, 05 Aug 2008 23:20:11 -0700
Message-ID: <7vmyjqsm04.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 08:21:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQcOj-000396-2e
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 08:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbYHFGUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 02:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbYHFGUT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 02:20:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbYHFGUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 02:20:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 86C39570C4;
	Wed,  6 Aug 2008 02:20:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8B2C8570C3; Wed,  6 Aug 2008 02:20:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BBE6023A-637F-11DD-B6C0-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91485>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

Due to increased activity level from people including GSoC students, I
expect 'next' to stay somewhat more active than previous rounds during the
1.6.0-rc cycle.  The request for people who usually follow 'next' is the
same as usual, though.  After -rc1 is tagged, please run 'master' for your
daily git use instead, in order to make sure 'master' does what it claims
to do without regression.

Tentative schedule, my wishful thinking:

 - 1.6.0-rc2 (Aug  6)
 - 1.6.0-rc3 (Aug 10)

----------------------------------------------------------------
[New Topics]

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
 - add: refuse to add working tree items beyond symlinks
 - update-index: refuse to add working tree items beyond symlinks

The performance impact of this needs to be discussed in a separate
thread.

* dp/hash-literally (Sun Aug 3 18:36:22 2008 +0400) 6 commits
 + add --no-filters option to git hash-object
 + add --path option to git hash-object
 + use parse_options() in git hash-object
 + correct usage help string for git-hash-object
 + correct argument checking test for git hash-object
 + teach index_fd to work with pipes

Gives a bit more flexibility to hash-objects by allowing us to lie about
the path the contents comes from.

* jn/svn-log (Sun Aug 3 14:07:21 2008 +0200) 1 commit
 - git-svn: --clean-changelog=<style> to sanitize messages

Eric firmly rejected this one so I won't be merging this to 'next' but
this was an interesting firestarter for discussion nevertheless.

----------------------------------------------------------------
[On Hold and/or Cooking]

* rs/archive-parse-options (Fri Jul 25 12:41:26 2008 +0200) 1 commit
 + archive: allow --exec and --remote without equal sign

None of the following is for 1.6.0.

* mv/merge-custom (Sat Aug 2 10:08:38 2008 +0200) 6 commits
 + Builtin git-help.
 + builtin-help: always load_command_list() in cmd_help()
 + Add a second testcase for handling invalid strategies in git-merge
 + Add a new test for using a custom merge strategy
 + builtin-merge: allow using a custom strategy
 + builtin-help: make some internal functions available to other
   builtins

* cc/merge-base-many (Sun Jul 27 13:47:22 2008 -0700) 4 commits
 - git-merge-octopus: use (merge-base A (merge B C D E...)) for
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
 . diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will be
hit due to tcl/tk's limitation, so I am holding this back for now.
