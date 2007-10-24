From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 00:28:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710250021430.25221@racer.site>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site>
 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org>
 <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org>
 <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org>
 <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx>
 <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site>
 <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Baumann <waste.manager@gmx.de>, Andreas Ericsson <ae@op5.se>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 01:29:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikpf9-00076u-Q6
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 01:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbXJXX3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 19:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbXJXX3L
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 19:29:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:50299 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754278AbXJXX3K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 19:29:10 -0400
Received: (qmail invoked by alias); 24 Oct 2007 23:29:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 25 Oct 2007 01:29:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/aaqIFPiTa8laXso4PRxtnOShijmzJyWIr3JY5s2
	qkSkMC3PzbssYO
X-X-Sender: gene099@racer.site
In-Reply-To: <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62253>

Hi,

On Thu, 25 Oct 2007, Steffen Prohaska wrote:

> On Oct 25, 2007, at 12:14 AM, Johannes Schindelin wrote:
> 
> > But I think I have to drive my message home again: if what you desire 
> > becomes reality, you take away the clear distinction between local and 
> > remote branches.  In fact, those branches are neither local (because 
> > the next pull will automatically update them with remote changes, but 
> > _only_ if they fast-forward) nor remote (because you plan to work on 
> > them locally).
> 
> Exactly, because I do not work on those branches alone. These are 
> _shared_ branches. I can work on such a branch with a group of 
> developers. I'm willing to accept this bit of chaos.

It is not just a chaos.  I see a serious problem here.  On _your_ 
computer, you do _not_ have a shared branch.  Which is visible _even_ in 
your modified work flow when you have unpushed changes.

So your desired illusion that your local branches are anything but local 
branches will never be perfect enough.

> Your rebase workflow is not possible if more than one dev wants to work 
> on the topic branch together.

Why not?  I do it all the time.  CVS users do it all the time, for that 
matter.

> Eventually you can linearize such a topic branch using rebase. But you 
> need to agree first that everyone else needs to delete the branch.

No, you can linearize your branch already while cleaning up your local 
branch before continuing to work on the topic.

> > But here is a proposal which should make you and your developers 
> > happy, _and_ should be even easier to explain:
> > 
> > Work with topic branches.  And when you're done, delete them.
> 
> Again, if you want to share the topic branch the situation gets
> more complex.

Hardly so.  In my proposed solution to your problem, there is nothing 
which prevents you from working off of another branch than "master".

> > So the beginning of the day could look like this:
> > 
> > 	git fetch
> > 	git checkout -b todays-topic origin/master
> > 
> > 	[hack hack hack]
> > 	[test test test]
> > 	[debug debug debug]
> > 	[occasionally commit]
> > 	[occasionally git rebase -i origin/master]
> > 
> > and the end of the topic
> > 
> > 	git branch -M master
> > 	git push origin master
> > 
> > If you should not be ready to push by the end of the day, no need to
> > worry.  Just stay on that topic branch, and before pushing, do
> > 
> > 	git fetch
> > 	git rebase origin/master
> > 
> > In _every_ case where I explained git, I found that people appreciated the
> > two-step procedures (like you will find in the examples I showed you
> > above): one git command to work locally, and one to push/fetch to/from
> > origin.
> 
> Maybe. I know git quite well now and in a shared workflow "git pull"
> with auto-fast-forward would help me. I often need to run "for each
> local branch: git checkout ; git merge" to get rid of the errors
> reported by "git push".

The problem I see here: you know git quite well.  Others don't, and will 
be mightily confused why pull updates local branches sometimes, and 
sometimes not.

Ciao,
Dscho
