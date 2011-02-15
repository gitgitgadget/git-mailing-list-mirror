From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Tue, 15 Feb 2011 19:48:33 +0000
Message-ID: <87pqqtaxke.fsf@fox.patthoyts.tk>
References: <20110212070538.GA2459@sigill.intra.peff.net>
	<20110213123151.GA31375@book.hvoigt.net>
	<20110215063903.GA28634@sigill.intra.peff.net>
	<20110215191620.GA56397@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org, Pat Thoyts <patthoyts@googlemail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 20:49:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpQtW-00008Y-8L
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 20:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152Ab1BOTsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 14:48:52 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:46353 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755908Ab1BOTsv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 14:48:51 -0500
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PpQtD-0005tH-Tp; Tue, 15 Feb 2011 19:48:48 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PpQt0-0007JJ-CS; Tue, 15 Feb 2011 19:48:34 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 8600823984; Tue, 15 Feb 2011 19:48:33 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20110215191620.GA56397@book.hvoigt.net> (Heiko Voigt's message
	of "Tue, 15 Feb 2011 20:16:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166870>

From: Heiko Voigt <hvoigt@hvoigt.net>
Date: Tue, 15 Feb 2011 19:43:54 +0000
Subject: [PATCH] git-gui: warn when trying to commit on a detached head

The commandline is already warning when checking out a detached head.
Since the only thing thats potentially dangerous is to create commits
on a detached head lets warn in case the user is about to do that.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

Heiko Voigt <hvoigt@hvoigt.net> writes:
>Hi,
>
>On Tue, Feb 15, 2011 at 01:39:03AM -0500, Jeff King wrote:
>> On Sun, Feb 13, 2011 at 01:31:52PM +0100, Heiko Voigt wrote:
>> 
>> > On Sat, Feb 12, 2011 at 02:05:38AM -0500, Jeff King wrote:
>> > >   1. Give some indication or warning during commit that you're in a
>> > >      detached state. The CLI template says "You are not on any branch"
>> > >      when editing the commit message, and mentions "detached HEAD" as
>> > >      the branch in the post-commit summary. As far as I can tell,
>> > >      git-gui says nothing at all.
>> > 
>> > How about something like this:
>> > [...]
>> > Subject: [PATCH] git-gui: warn when trying to commit on a detached head
>> > 
>> > The commandline is already warning when checking out a detached head.
>> > Since the only thing thats potentially dangerous is to create commits
>> > on a detached head lets warn in case the user is about to do that.
>> 
>> It seems a little heavy-handed to have a dialog pop up for each commit.
>> It's not actually dangerous to create a commit on a detached HEAD; it's
>> just dangerous to _leave_ without referencing your new commits.
>
>Hmm, how about adding a checkbox:
>
>  [ ] Do not ask again
>
>In my experience anything other than a popup will be overseen so I would
>suggest doing it at least once to prepare the user for the possible
>consequences.
>
>IMO such a message is a good thing for the GUI regardless whether we
>implement the leaving detached HEAD state warning. First I think a
>typical GUI user does not commit on a detached head that often since
>there is currently no way to use these commits from the GUI (e.g.
>format-patch, rebase, ...). Second because a detached head is very
>practical for testing work on a remote branch the message box would
>remind most users to switch to their development branch first. If they
>only get that message after a series of commits it might become a hassle
>for them to get these commits onto another branch (remember no
>format-patch or rebase currently).
>
>> So I think for making commits, something informational that doesn't
>> require a click-through would be the more appropriate level (similar to
>> what the CLI does; it just mentions it in the commit template). I guess
>> there isn't a commit template in the same way for git gui; instead, it
>> is always showing you the current state. And indeed, it does switch from
>> "Current Branch: master" to "Current Branch: HEAD" when you are on a
>> detached head. Maybe we should beef that up a bit to "You are not on any
>> branch." or something that is more self-explanatory. I dunno. I am just
>> guessing here about what users would want.
>> 
>> I do think a pop-up is appropriate when you try to check something else
>> out, and commits you have made on the detached HEAD are about to become
>> unreferenced. But this is something even the CLI doesn't do, so it would
>> make sense to see how the check is implemented there first before doing
>> anything in git-gui.
>
>From what I read in this thread it currently seems to be not so easy to
>precisely find out whether some commit is referenced. (If we care about
>stuff outside of remotes, heads and tags). But maybe we do not need
>that for the GUI.
>
>If a commit is referenced from non typical refs the worst we do is issue
>a false warning. Meaning we warn the user even though the commit is
>referenced. For a GUI I think being a little more restrictive is the
>right thing to do since it should guide the user much more into a safe
>workflow. If he wants to do special things than there still is the CLI
>to fall back on. And its just a warning so we are not preventing
>anything.
>
>Now it depends on what we would want for the CLI if we are going to
>implement a thorough check over everything in refs/ than there is no
>reason for not applying the same thing to git-gui. In case the current
>behavior is deemed sufficient we should go with the check mention
>
>Just to give you a practical example:
>
>At $dayjob we are currently even more restrictive and completely forbid
>commits on a detached head by a pre-commit hook. This was mainly done
>due to the lack of warnings but I do not recall a single incident where a
>user actually complained about this restriction (~90% GUI users).
>
>Cheers Heiko

My feeling is that the user should be making a branch to hold his
commits. So I suggest adding some text to suggest that a branch be
created and keep annoying the user every time they commit to a detached
head. This errs on the side of not dropping commits into the reflog
which seems the most useful strategy to me.

So here is a modded version of Heiko's patch.

 git-gui.sh     |    1 +
 lib/commit.tcl |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index d96df63..9f2e9ae 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -835,6 +835,7 @@ set default_config(gui.fontdiff) [font configure font_diff]
 # TODO: this option should be added to the git-config documentation
 set default_config(gui.maxfilesdisplayed) 5000
 set default_config(gui.usettk) 1
+set default_config(gui.warndetachedcommit) 1
 set font_descs {
 	{fontui   font_ui   {mc "Main Font"}}
 	{fontdiff font_diff {mc "Diff/Console Font"}}
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 5ce4687..372bed9 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -260,8 +260,23 @@ proc commit_prehook_wait {fd_ph curHEAD msg_p} {
 }
 
 proc commit_commitmsg {curHEAD msg_p} {
+	global is_detached repo_config
 	global pch_error
 
+	if {$is_detached && $repo_config(gui.warndetachedcommit)} {
+		set msg [mc "You are about to commit on a detached head.\
+This is a potentially dangerous thing to do because if you switch\
+to another branch you will loose your changes and it can be difficult\
+to retrieve them later from the reflog. You should probably cancel this\
+commit and create a new branch to continue.\n\
+\n\
+Do you really want to proceed with your commit?"]
+		if {[ask_popup $msg] ne yes} {
+			unlock_index
+			return
+		}
+	}
+
 	# -- Run the commit-msg hook.
 	#
 	set fd_ph [githook_read commit-msg $msg_p]
-- 
1.7.4.1
