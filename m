From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Pushing into a repository with working directory?
Date: Fri, 5 Jan 2007 14:36:46 -0500
Message-ID: <20070105193646.GC8753@spearce.org>
References: <20070102045108.GC27690@spearce.org> <459E1182.201@shadowen.org> <7vwt41j1le.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 20:37:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2us5-0003xz-NY
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 20:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbXAETgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 14:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbXAETgy
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 14:36:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53024 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422695AbXAETgx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 14:36:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H2urM-0006AY-6J; Fri, 05 Jan 2007 14:36:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 09E7420FB65; Fri,  5 Jan 2007 14:36:47 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwt41j1le.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36015>

Junio C Hamano <junkio@cox.net> wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
> > Special casing the 'current' branch makes any sort of automated push
> > setup unreliable.  Indeed the special case preventing a fetch into the
> > current branch is pretty annoying for the same reason.  I would almost
> > prefer to relax that than add the same for push.
> 
> How would you relax the fetch case?  Fetching into the current
> branch, unless the repository is bare, is always a fishy
> operation.

And so is pushing into the current branch, so long as the current
branch has a working directory attached to it.

Most new users to Git expect to be able to push into the current
branch of a repository and `just have it work`.  Only they don't
really seem to have an idea of _how_ that operation should behave,
which means they really don't want it to work at all.  I certainly
don't want an operation to succeed if I can't reason about what
its success means!

Right now pushing into the current branch makes the index become
way out of sync from HEAD.  This causes git-runstatus to display a
large number of differences, basically undoing any of the changes
introduced by HEAD@{1}..HEAD.  The user is left with a dirty
working tree that they can commit - and committing it will just
revert the prior commits.  The user will later cuss at Git for
losing their changes.  Not pretty.

-- 
Shawn.
