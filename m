From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Wed, 24 Oct 2007 23:14:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710242258201.25221@racer.site>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site>
 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org>
 <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org>
 <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org>
 <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx>
 <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Baumann <waste.manager@gmx.de>, Andreas Ericsson <ae@op5.se>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 00:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkoVn-0001fn-BN
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 00:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759388AbXJXWO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 18:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761077AbXJXWO4
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 18:14:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:37976 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761061AbXJXWOy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 18:14:54 -0400
Received: (qmail invoked by alias); 24 Oct 2007 22:14:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 25 Oct 2007 00:14:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7trNlazK75pFDNws3zjjwiM35I8ERmrkPbgseUO
	nQwuy2g4gLjL/3
X-X-Sender: gene099@racer.site
In-Reply-To: <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62247>

Hi,

On Wed, 24 Oct 2007, Steffen Prohaska wrote:

> On Oct 24, 2007, at 11:28 PM, Peter Baumann wrote:
> 
> > You can't check what got added in your pull, e.g you can't review the 
> > new code with something like
> > 
> > 	gitk next..origin/next
> 
> You're not forced to pull. Just use "git fetch" if you want to do this. 
> Or is something missing if you'd be limited to "git fetch"?

I am more concerned about having very fuzzy meanings of our nomenclature. 
As of now, "pull = fetch + merge".  You want to change that, and I am sure 
that it is harder to explain, Andreas' insistence on my being wrong 
notwithstanding.

Whenever I told people "pull = fetch + merge", they got it.  Often I would 
start a talk about git by introducing distributed development.  By stating 
that working in a working directory is already forking, only without 
commiting.  Then I'd go into details, by saying that there are multiple 
repositories, and that you can update local copies of the remote branches 
by "git fetch".  And you can merge by "git merge".  And then I would write 
down on the blackboard -- the first written thing in my talk! -- pull = 
fetch + merge.

My "pupils" _always_ liked the preciseness of the nomenclature.  And they 
made many less mistakes because they had a clear mental model of what is 
remote, and what is local.  And that local branches are always forks.

> > I often do something like this, just to see what got changed. So at 
> > least in my opinion you have to add a third point:
> > 
> >  * the branch has no modifications what so ever
> >  * the branch is set up to auto-merge with the particular branch
> >    fetched from the particular remote
> > 				AND
> >  * the user set a config option to always autofastfoward if the above
> >    conditions are true! This could be implemented as a global option with
> >    a per branch overwrite.
> 
> I (and, as I understood, Andreas, too) want to change the default. 
> Because we believe that git would be easier to use in workflows based on 
> a shared repository.

And here I have to disagree strongly.  In a workflow based on a shared 
repository, you do not want to merge.  You want to rebase.  First thing 
you do when switching to another branch is fetch + rebase (that's why I 
want an option to "pull --rebase" other branches).

But _even if_ you merge instead of rebase, I fail to see how the current 
situation is different from CVS (which many people maintain is _easier_ 
than gi), where first thing you do is to "cvs update".  Just for git it is 
"git pull".

But I think I have to drive my message home again: if what you desire 
becomes reality, you take away the clear distinction between local 
and remote branches.  In fact, those branches are neither local (because 
the next pull will automatically update them with remote changes, but 
_only_ if they fast-forward) nor remote (because you plan to work on them 
locally).

But here is a proposal which should make you and your developers happy, 
_and_ should be even easier to explain:

Work with topic branches.  And when you're done, delete them.

So the beginning of the day could look like this:

	git fetch
	git checkout -b todays-topic origin/master

	[hack hack hack]
	[test test test]
	[debug debug debug]
	[occasionally commit]
	[occasionally git rebase -i origin/master]

and the end of the topic

	git branch -M master
	git push origin master

If you should not be ready to push by the end of the day, no need to 
worry.  Just stay on that topic branch, and before pushing, do

	git fetch
	git rebase origin/master

In _every_ case where I explained git, I found that people appreciated the 
two-step procedures (like you will find in the examples I showed you 
above): one git command to work locally, and one to push/fetch to/from 
origin.

Ciao,
Dscho
