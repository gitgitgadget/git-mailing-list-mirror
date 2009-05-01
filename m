From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git,
 dscms and a "whole product" approach)
Date: Fri, 1 May 2009 17:17:31 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905011618370.2147@iabervon.org>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3ocugod96.fsf@localhost.localdomain> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <20090430142244.GA23550@coredump.intra.peff.net> <alpine.LFD.2.00.0905011431460.5379@localhost.localdomain>
 <20090501190854.GA13770@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 01 23:17:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0073-0002F0-1z
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 23:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbZEAVRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 17:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbZEAVRc
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 17:17:32 -0400
Received: from iabervon.org ([66.92.72.58]:58977 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270AbZEAVRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 17:17:32 -0400
Received: (qmail 24551 invoked by uid 1000); 1 May 2009 21:17:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 May 2009 21:17:31 -0000
In-Reply-To: <20090501190854.GA13770@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118097>

On Fri, 1 May 2009, Jeff King wrote:

> On Fri, May 01, 2009 at 02:43:49PM -0400, Linus Torvalds wrote:
> 
> > > Like all generalizations, this is only mostly true. Fast network servers
> > > with big caches can outperform disks for some loads.
> > [...]
> > In contrast, a workstation with local filesystems and enough memory to 
> > cache it well will just be a lot nicer.
> > [...]
> > > I have never used perforce, but I get the impression that it is more 
> > > optimized for such a situation.
> > 
> > I doubt it. I suspect git will outperform pretty much anything else in 
> > that kind of situation too.
> 
> Thanks for the analysis; what you said makes sense to me. However, there
> is at least one case of somebody complaining that git doesn't scale as
> well as perforce for their load:
> 
>   http://gandolf.homelinux.org/blog/index.php?id=50
> 
> Part of his issue is with git-p4 sucking, which it probably does. But
> part of it sounds like he has a gigantic workload (the description of
> which sounds silly to me, but I respect the fact that he is probably
> describing standard practice among some companies), and that workload is
> just a little too gigantic for the workstations to handle. I.e., by
> throwing resources at the central server they can avoid throwing as many
> at each workstation.

I think his problem is that he's trying to replace his p4 repository with 
a git repository, which is a bit like trying to download github, rather 
than a project from github. Perforce is good at dealing with the case 
where people check in a vast quantity of junk that you don't check out.

That is, you can back up your workstation into Perforce, and it won't 
affect anyone's performance if you use a path that's not in the range that 
anybody else checks out. And people actually do that. And Perforce doesn't 
make a distinction between different projects and different branches of 
the same project and different subdirectories of a branch of the same 
project, so it's impossible to tease apart except by company policy.

Git doesn't scale in that it can't do the extremely narrow checkouts you 
need if your repository root directory contains thousands of complete 
unrelated projects with each branch of each project getting a 
subdirectory. On the other hand, it does a great job when the data is 
already partitioned into useful repositories.

	-Daniel
*This .sig left intentionally blank*
