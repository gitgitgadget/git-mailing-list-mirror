From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/2] Add utilities for figuring out repositories
	for selected resources
Date: Tue, 2 Sep 2008 12:00:46 -0700
Message-ID: <20080902190046.GE28704@spearce.org>
References: <1220175524-1523-1-git-send-email-robin.rosenberg@dewire.com> <1220175524-1523-2-git-send-email-robin.rosenberg@dewire.com> <20080902150323.GC28704@spearce.org> <200809022053.35419.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:01:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kab8U-0007kl-Tf
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 21:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbYIBTAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 15:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbYIBTAs
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 15:00:48 -0400
Received: from george.spearce.org ([209.20.77.23]:56835 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbYIBTAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 15:00:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A2E2438375; Tue,  2 Sep 2008 19:00:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809022053.35419.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94692>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> tisdagen den 2 september 2008 17.03.23 skrev Shawn O. Pearce:
> > 
> > Hmm.  So if any one of the selected projects doesn't have a Git
> > repository at its top level we just plain fail and pretend none of
> > them have a Git repository?
> 
> That is the way everything in Eclipse work. For an operation to be applicable
> to a selection, it must be applicable to eache element.

OK.  Good reason then.
 
> > But I also wonder if that really makes sense when a project could
> > have a linked resource under it that points to the repository's
> > working directory.  In such cases we want operations on that project
> > to potentially impact the inner repository as maybe the project
> > repository does not have a repository itself.  IOW I'm questioning
> > the idea of getRepositoriesFor(getProjectsForSelectedResources()).
> 
> Ouch for linked resources. I really think we should ignore the link as much
> as we can. It's a trap! I any way it needs more fixing that this and not
> only here. A patch does not have to solve all problems in the world :)
> 
> I have no experience with linked resources, other that I found them enough
> awkward to use to prevent from doing that. How useful and portable is
> a C:\foo on my system? I don't mind anyone solving the problem, but it is
> very low on my personal agenda.

Linked resources are useful (sometimes), especially if the project files
are automatically generated for you from your build system.  My prior
day-job had a really nice build system that did this.  My current day-job
also has a build system that can generate Eclipse project files for you.

In both cases the project files aren't considered part of the source as
they can be rebuilt at any time and they both used linked resources to
point to the actual place where the source was stored, which typically
was outside of your workspace directory, while the project was within
the workspace directory.

Anyway, I wasn't trying to suggest solving the worlds problems.
But RepositoryMapping is smarter now and can (mostly) handle a
linked resource just fine.  Its the higher level GUI actions that
run into trouble.

I guess we should stick this series in as-is then.

-- 
Shawn.
