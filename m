From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 15:22:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707211427190.14781@racer.site>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
 <200707210951.00210.stimming@tuhh.de> <20070721080338.GT32566@spearce.org>
 <200707211433.29318.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-889713578-1185027736=:14781"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 16:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICFrB-0008Dz-3v
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 16:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760448AbXGUOWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 10:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764215AbXGUOWq
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 10:22:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:57057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757619AbXGUOWp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 10:22:45 -0400
Received: (qmail invoked by alias); 21 Jul 2007 14:22:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 21 Jul 2007 16:22:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++1qVLMDy+MhBqfhZbZm3g65VdTE9/ZpAs7u1ZVK
	bCSdhrAvF2CpVo
X-X-Sender: gene099@racer.site
In-Reply-To: <200707211433.29318.stimming@tuhh.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53168>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-889713578-1185027736=:14781
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 21 Jul 2007, Christian Stimming wrote:

> This patch starts over from before the first i18n patch has been applied 
> and takes into account all discussion with Shawn. Currently I don't 
> quite know how to apply these patches to the "mob" branch because one 
> would have to first revert those patches from me that have been applied 
> there... Thanks.

Usually you solve this by forcing a non-fastforwarding push.  IOW you 
really revert part of the history.  You would not even have had to call 
"git revert" or "git reset", since you started from a defined commit, 
d36cd968378cd3e509434b1b9f43f1417fdba57e.

_However_: Junio already pushed into the 'mob' branch, and if you would 
have forced a non-fastforwarding push, this commit would have been lost.  
At least from the repo's POV.

So the only real option that makes sense is for you to register as a user 
at repo.or.cz, send me your user name, and for me to add you as user so 
that you can push into your own branch easily.

FWIW, this is what I did with your patch series:

- I looked at the first diff to find out which version of git-gui.sh it 
  was based on:

	diff --git a/git-gui.sh b/git-gui.sh
	index c5ff7c8..0c5ca46 100755
	--- a/git-gui.sh
	+++ b/git-gui.sh

  Ah, okay, git-gui.sh was at c5ff7c8.  What commit was that?  Ask "git 
  log --raw":

	...
	commit d36cd968378cd3e509434b1b9f43f1417fdba57e
	Author: Shawn O. Pearce <spearce@spearce.org>
	Date:   Thu Jul 19 00:43:16 2007 -0400

	    git-gui: Avoid unnecessary global statements when possible

	    [commit message]

	:100755 100755 0aabfba... c5ff7c8... M  git-gui.sh

  Good.  So it is based on d36cd968.  (If my decorate patch would be in 
  'master', I could have told you an easy name like "shawn/master~3" or 
  some such).

- I started a new branch:

  git checkout -b christian-new d36cd968

- Then I saved all your mails into an own mbox with my mail program.  I 
  had to edit that mbox a little, since you sent the complete headers in 
  the body, not in the mail header.  So I just stripped all the 
  mail headers and only left the ones from the mail bodies.

- After that I applied the patches with

  git am -i <mbox-file>

  I like the interactive mode, especially since Pine likes to add a dummy 
  mail at the beginning of the mbox file, which I do not want to commit, 
  of course ;-)

- There were no conflicts at all, and just to see that nothing untoward 
  happened, I compared the diffstats with "git log --stat shawn/master.."

  Come to think of it, it's even easier to check the object name of the 
  new git-gui.sh: "git ls-files --stage" says

	...
	100755 95dac55[...] 0       git-gui.sh

  Worked.  (I could also have said "git log --raw" to see that.)

- Just a quick "make && ./git-gui" test.  Ooops:

	$ LC_ALL=C make
	Generating catalog po/de.msg
	msgfmt --statistics --tcl po/de.po -l de -d po/
	po/de.po:32:9: invalid multibyte sequence
	po/de.po:36:18: invalid multibyte sequence
	po/de.po:48:32: invalid multibyte sequence
	...

  Looking into line 32 I see an ISO-8859-1 'ü'.  But in the header it says 
  that it's UTF-8.  Just a quick try: change that to ISO-8859-1, and 
  'make' says:

	$ LC_ALL=C make
	Generating catalog po/de.msg
	msgfmt --statistics --tcl po/de.po -l de -d po/
	62 translated messages.

  Much better.

  Okay, let's fix that up.  First stash the changes:

	$ git stash encoding fix

  Then find out which commit added po/de.msg:

	$ git log -1 po/de.po
	...
	    Initial German translation [...]

  Now on to editing the patch series:

	$ git rebase -i HEAD~5

  Mark "Initial German translation [...]" with the command "edit" instead 
  of "pick".  Save, and wait for half a second.

	...
	You can amend the commit now, with

	        git commit --amend

  Apply the stashed changes, and make sure that it's what I want:

	$ git stash apply
	...
	$ git diff
	...
	-"Content-Type: text/plain; charset=UTF-8\n"
	+"Content-Type: text/plain; charset=ISO-8859-1\n"
	...

  Yes!  Amend the commit, and for good measure, sign off on it (after 
  reading it, of course):

	$ git commit --amend -s po/de.po

  Mention that the encoding was changed by me, so if it is wrong, it is 
  all my fault, not yours.

  Now finish "rebasing"...

	$ git rebase --continue

  Make sure that it works now:

	$ make libdir=$(pwd)/lib && ./git-gui

  Yep.  Everything's fine.

  (Usually I go through this procedure in less than 3 minutes, but today I 
  took more than double that, since I wrote this email explaining my 
  actions...)

- Push to repo.or.cz (which is my 'origin' remote):

	$ git push origin HEAD:refs/heads/christian-new

- Now for the real fun: rebase it on top of Shawn's new master:

	# I have installed a remote 'shawn' pointing to git-gui.git
	$ git fetch shawn
	$ git rebase shawn/master
	...

  Worked.  Just like that.  Brilliant.

- Let's just cherry-pick Junio's change, which is the latest commit in 
  origin/mob:

	$ git cherry-pick origin/mob
	Auto-merged Makefile
	CONFLICT (content): Merge conflict in Makefile
	Automatic cherry-pick failed.  After resolving the conflicts,
	mark the corrected paths with 'git-add <paths>'
	and commit the result.
	When commiting, use the option '-c 2d29ab2' to retain authorship 
	and message.

  Conflict in Makefile.  Okay, no problem, edit it.  Ah, of course, Shawn 
  asked for automatic inferring of the available languages, while Junio 
  added "ja".  Just take the current version (the version between "<<<<" 
  and "====").

	$ git add -u
	$ git commit -c 2d29ab2

- Make the current revision my new 'master'.  That branch already exists, 
  and I am on 'christian-new', though.  No problem:

	$ git branch -M christian-new master

  (But if you do that with "-M", which means _force_ rename, make sure 
  twice that this is really what you want.)

- Push it.

	$ git push origin +master
	...
	refs/heads/master: da7b699[...] -> cc2b761b[...]

  The "+" is necessary, since I rebased it...

  If there were more pushers than just me, I'd verify that da7b699 is 
  indeed the old state of my master:

	$ git reflog
	...
	d36cd96... HEAD@{20}: checkout: moving from master to christian-new
	da7b699... HEAD@{21}: commit [...]

  Yep.

Good.  Happy.

Ciao,
Dscho



--8323584-889713578-1185027736=:14781--
