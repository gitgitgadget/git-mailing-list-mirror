From: "Ed S. Peschko" <esp5@pge.com>
Subject: Re: simple cvs-like git wrapper
Date: Tue, 29 Jan 2008 18:10:50 -0800
Message-ID: <20080130021050.GB9612@venus>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 03:56:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK37R-0002e4-Gb
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 03:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbYA3CzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 21:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbYA3Cy7
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 21:54:59 -0500
Received: from mta01.pge.com ([131.89.129.71]:56619 "EHLO mta01.pge.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753867AbYA3Cyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 21:54:45 -0500
X-Greylist: delayed 2632 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2008 21:54:45 EST
Received: from mta12.comp.pge.com (mta12.comp.pge.com [10.245.211.127])
	by mta01.pge.com (Switch-3.3.1/Switch-3.3.0) with ESMTP id m0U2AoXM012138;
	Tue, 29 Jan 2008 18:10:51 -0800 (PST)
Received: from mdssdr01.utility.pge.com (mdssdr01.utility.pge.com [10.244.52.48])
	by mta12.comp.pge.com (Switch-3.3.1/Switch-3.3.0) with ESMTP id m0U2Aneq000436;
	Tue, 29 Jan 2008 18:10:49 -0800 (PST)
Received: (from esp5@localhost)
	by mdssdr01.utility.pge.com (8.11.7p3+Sun/8.11.7) id m0U2Ao508006;
	Tue, 29 Jan 2008 18:10:50 -0800 (PST)
X-Authentication-Warning: mdssdr01.utility.pge.com: esp5 set sender to esp5@pge.com using -f
Content-Disposition: inline
In-Reply-To: <m3hcgw8dz7.fsf@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72018>

> One thing (besides horrible branching and even worse merging)  which I
> hated in multi-user CVS is the "cvs update", namely the fact that if
> you want to commit changes, you _have_ to rebase them on top of
> current work. So when you are ready to commit, when you have tested
> everything, you are sometimes forced to resolve a merge to be able to
> commit... and have to test resolved merge... and perhaps again, and
> again.

Yeah, I realize that it's not exactly the best solution for every
project, but for projects tied to a piece of hardware (ie: a database, a
particular box, etc), its much more important to be in sync, to have 
'one true view' of the world rather than to have the freedom to have 
multiple views.

In our case, our code is tied to a database and a database instance. An
environment equals attachment to a given oracle SID. If someone is out of sync
with other people's changes, then that person's environment is wrong.


> Working on branches is much nicer IMVHO. And it allows to separate
> changes into series of small, incremental commits[*1*]. If you want to
> work in centralized or semi-centralized way, you probably would want
> to use rebase based workflow, with "git pull --rebase" (which just got
> implemented).


I agree with you, however, with the working on branches. We need the 
ability to do the small incremental commits, and then tie them back to
SOX requirements (bleah). 

Hence the hope for the automatic merging along with a given branch - that, 
when you do an 'gvs update', it takes all the outstanding deltas on all the
branches that have been uploaded into the central repository, and applies 
them, one by one, to your local repository, and keeps the branch intact.

That it basically does the perfect patch series functionality you are
talking about, but in an automatic way..


A couple of questions:

	1. How do you get a list - on a shared, remote, repository - of all the 
       branches that a shared repository contains, from the point of
	   view of a client? ie: git-branch shows local branches..

    2. Could the above 'gvs update' be implemented in terms of a series 
	   of 'git pull --rebase' or even 'git pull' merges from the
	   centralized repository based on the output from the command 
       above?

Anyways, I wouldn't mind it if 'gvs update' paused at the end of
each merge - that you'd do a 'gvs update', it would show you exactly what
was going to merge before it did it (maybe even via a vimdiff of old and 
new side by side), and would allow you to do a regression test after
each patchset was applied..

After all, it's my wrapper so I'll implement it the way I like it.. ;-)

Thanks,

Ed


> 
> Footonotes:
> ===========
> [*1*] I'd like to point to LKML post about creating perfect patch
> *series*, but I have forgot to bookmark it, and canot find it again
> (IIRC somebody posted link some time ago here on git mailing list).
> 
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git
