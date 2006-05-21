From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/5] More ref logging
Date: Sun, 21 May 2006 00:51:46 -0400
Message-ID: <20060521045146.GA8269@spearce.org>
References: <20060519091456.GH22257@spearce.org> <20060519071603.11d3be5d.seanlkml@sympatico.ca> <20060521005009.GA7179@spearce.org> <20060520224344.7ebca48b.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 06:51:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhfv1-0002ly-IE
	for gcvg-git@gmane.org; Sun, 21 May 2006 06:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWEUEvx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 00:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWEUEvx
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 00:51:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:30434 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751451AbWEUEvw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 00:51:52 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fhfuv-0002WX-1J; Sun, 21 May 2006 00:51:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 30D7D212691; Sun, 21 May 2006 00:51:47 -0400 (EDT)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060520224344.7ebca48b.seanlkml@sympatico.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20430>

Sean <seanlkml@sympatico.ca> wrote:
> On Sat, 20 May 2006 20:50:09 -0400
> Shawn Pearce <spearce@spearce.org> wrote:
> 
> > It sort of is a new way of tagging commits with extra data.  But its
> > also sort of a way of versioning your ref `database'.  Using tags
> > to save the points in time might be useful but it would generate
> > a lot of temporary files.  A commit every 5 minutes for a typical
> > working week would generate 480 tags per week.  That's just too much.
> 
> But isn't that just an implementation detail?  I've actually run
> into another situation where tags would be perfect if only they weren't
> so expensive (ie. entire repo was in a 50Mb pack including tag objects,
> but the .git/refs/tags directory was over 100Mb).

Any chance we could get some details on why so many tags were useful?
You have a good argument here but I'm not sure how a better tag
store could be structured.  :-)
 
> So, if we found a way to store tags more efficiently your 480 tags per
> week shouldn't be a problem at all.   The main point being to extend
> and optimize the existing infrastructure rather than bolting on a new
> class of objects (ie. ref log) which only serves a narrow (albeit
> important) purpose.

Yea - despite being the author of ref log I'm still slightly unhappy
with the fact that it doesn't make reuse of existing GIT plumbing.
But I'm sort of OK with that right now as you can't map two indexes
into memory at once currently, nor is there a way to easily update
multiple refs at once if the ref log must serialize access to create
a string of trees and commits.

-- 
Shawn.
