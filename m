From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git / Subversion Interoperability
Date: Thu, 22 Mar 2007 21:24:23 -0400
Message-ID: <20070323012422.GC17773@spearce.org>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Mar 23 02:24:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUYWP-00059c-IL
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 02:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbXCWBYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 21:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934257AbXCWBYe
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 21:24:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47208 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932664AbXCWBYd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 21:24:33 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HUYVs-00053g-UE; Thu, 22 Mar 2007 21:24:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A24E020FBAE; Thu, 22 Mar 2007 21:24:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42895>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Thu, 22 Mar 2007, Shawn O. Pearce wrote:
> >Bruno Cesar Ribas <ribas@c3sl.ufpr.br> wrote:
> >>2.  write a backend for Subversion
> >
> >In this case we try to reuse the existing SVN server code by
> >creating a library module that plugs into that system
...
> >downside is you have to write code to run within their library and
> >address space, and that conforms to their storage API.
> 
> This might run headlong into some of the issues facing the libification 
> project - in particular the tendancy of git code to die as a primary error 
> handling mechanism.  This approach may not viable without access to a 
> libified git?

Yes, exactly.  The libification won't be ready early enough for
this project.  So that does make it more difficult.  But this just
points out another reason why libification might be useful. ;-)

> >- Branches.  In SVN these are in the repository wide namespace,
> >but in Git they aren't.  I imagine we'd want to just enforce the
> >standard layout that the SVN people recommened:
...
> That would probably be good enough for the majority of 
> one-project-per-repo Subversion projects at least.  Though there is still 
> the issue that Subversion will actually let you create a "tag" simply by 
> committing whatever you currently have in your working copy (including 
> localally modified files ... yeuch).

Heh.  People do weird things.  ;-)
 
> >That's all I can think of right now.  But I'm sure there are more.
> 
> Properties are probably the next biggest headache.  Subversion allows you 
> to associate arbitrary keyword value pairs with files (which are 
> versioned) and with revisions (which are not versioned).  You would need 
> to find someway to support this in git.  Since revision properties are 
> disabled by default in Subversion you may be able to simply disallow them 
> permanently - but I don't know anything about the Subversion protocol ...

I thought about the properties, but didn't bother to write anything
on that subject as we may just be able to say "look, properties
are not supported in git-svnserver, so don't try to use them".

The git-svnserver is meant to help users migrate to Git, not to offer
up all of SVNs features and warts.  A big part of this project may
just be deciding what features we are willing to try to emulate.

-- 
Shawn.
