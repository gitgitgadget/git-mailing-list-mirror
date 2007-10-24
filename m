From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 00:33:37 +0200
Message-ID: <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <waste.manager@gmx.de>, Andreas Ericsson <ae@op5.se>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 00:32:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikom8-0007w3-D7
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 00:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558AbXJXWcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 18:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756148AbXJXWcT
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 18:32:19 -0400
Received: from mailer.zib.de ([130.73.108.11]:50600 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754822AbXJXWcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 18:32:19 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9OMWAvb011554;
	Thu, 25 Oct 2007 00:32:10 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1097b.pool.einsundeins.de [77.177.9.123])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9OMW9Mv002893
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 25 Oct 2007 00:32:09 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710242258201.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62249>


On Oct 25, 2007, at 12:14 AM, Johannes Schindelin wrote:

> And here I have to disagree strongly.  In a workflow based on a shared
> repository, you do not want to merge.  You want to rebase.  First  
> thing
> you do when switching to another branch is fetch + rebase (that's  
> why I
> want an option to "pull --rebase" other branches).
>
> But _even if_ you merge instead of rebase, I fail to see how the  
> current
> situation is different from CVS (which many people maintain is  
> _easier_
> than gi), where first thing you do is to "cvs update".  Just for  
> git it is
> "git pull".
>
> But I think I have to drive my message home again: if what you desire
> becomes reality, you take away the clear distinction between local
> and remote branches.  In fact, those branches are neither local  
> (because
> the next pull will automatically update them with remote changes, but
> _only_ if they fast-forward) nor remote (because you plan to work  
> on them
> locally).

Exactly, because I do not work on those branches alone. These
are _shared_ branches. I can work on such a branch with a
group of developers. I'm willing to accept this bit of chaos.

Your rebase workflow is not possible if more than one dev wants
to work on the topic branch together.

Eventually you can linearize such a topic branch using rebase.
But you need to agree first that everyone else needs to delete
the branch.



> But here is a proposal which should make you and your developers  
> happy,
> _and_ should be even easier to explain:
>
> Work with topic branches.  And when you're done, delete them.

Again, if you want to share the topic branch the situation gets
more complex.

I absolutely agree that for purely local work topic branches that
are deleted before pushing are a good solution.


> So the beginning of the day could look like this:
>
> 	git fetch
> 	git checkout -b todays-topic origin/master
>
> 	[hack hack hack]
> 	[test test test]
> 	[debug debug debug]
> 	[occasionally commit]
> 	[occasionally git rebase -i origin/master]
>
> and the end of the topic
>
> 	git branch -M master
> 	git push origin master
>
> If you should not be ready to push by the end of the day, no need to
> worry.  Just stay on that topic branch, and before pushing, do
>
> 	git fetch
> 	git rebase origin/master
>
> In _every_ case where I explained git, I found that people  
> appreciated the
> two-step procedures (like you will find in the examples I showed you
> above): one git command to work locally, and one to push/fetch to/from
> origin.

Maybe. I know git quite well now and in a shared workflow "git pull"
with auto-fast-forward would help me. I often need to run "for each
local branch: git checkout ; git merge" to get rid of the errors
reported by "git push".

	Steffen
