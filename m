From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 12:09:39 -0400
Message-ID: <20060913160939.GA29933@spearce.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 18:10:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNXJ5-0001Lu-OT
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 18:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWIMQJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 12:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWIMQJo
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 12:09:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:10416 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750947AbWIMQJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 12:09:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNXIt-0005v3-S9; Wed, 13 Sep 2006 12:09:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C6D0620E49A; Wed, 13 Sep 2006 12:09:39 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26919>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 9/13/06, Petr Baudis <pasky@suse.cz> wrote:
> >You could also stash the ref to refs/heads-abandoned/ instead of
> >refs/heads/ if you want to keep the junk around for some reason. Of
> >course you don't get the nice marker with explanation of why is this
> >abandoned and who decided that, but you can just use an empty commit for
> >the same purpose.
> >
> >Object classes are precious things and we shouldn't get carried away.
> 
> If this is done with an object there should probably be some way to
> encode it into the existing commit object.

I agree completely with what Petr is saying.  Allocating a new
class of object in Git is a *major* deal.  We don't really have
any IDs left.  Tags would quite easily carry information stating
that the branch is considered abandoned, who abandoned it, and
when the did so.  The tags can also easily be saved off into a
refs/abandoned directory.
 
> Moving the refs into refs/abandoned would work too. We would need new
> git commands to do this and flags on the visualization tools to
> include the abandoned branches.

I fail to see why.  If a branch is abandoned then its not merged into
any of the active branches.  If this is the case then gitk doesn't
display it when viewing an active branch.  So what's the problem?

> On the other hand doing this is
> recording state about the repository in the refs directory instead of
> writing this state into the repo itself.

Same difference.  The repository is a union of the objects stored
in the objects directory and the pack files and the symbolic
ref names holding the heads of the commit chains.  We're already
talking about some other ways to handle larger sets of refs, and
Linus has contributed some cleanup code heading in that direction.
The refs *are* the repository.

-- 
Shawn.
