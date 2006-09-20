From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 12:21:45 -0400
Message-ID: <20060920162145.GA23260@spearce.org>
References: <20060919232851.GA12195@spearce.org> <7vac4ujzf0.fsf@assigned-by-dhcp.cox.net> <20060920161407.GQ8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:22:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4pg-00048g-RO
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbWITQVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWITQVy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:21:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:61332 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751733AbWITQVx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:21:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ4pR-0001MP-Cd; Wed, 20 Sep 2006 12:21:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7A0C920E48E; Wed, 20 Sep 2006 12:21:45 -0400 (EDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060920161407.GQ8259@pasky.or.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27365>

Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Wed, Sep 20, 2006 at 06:06:11PM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
[snip]
> >  (2) Although there is no inherent reason not allowing a working
> >      tree associated with the repository that is kept updated
> >      this way, the user will be utterly confused in a working
> >      tree whose current branch head is updated like this, until
> >      the working tree and the index is matched to the updated
> >      HEAD.
> 
> git-fetch --mirror-all can still be very useful even with a working copy
> if you are keeping all the remote heads in .git/refs/remotes/. I'd
> venture to say that in that case, this is frequently what you actually
> want when fetching from the repository (given that you have already let
> git clone do that once).

I think that's more `git fetch --all`.  You are pulling every remote
head available at a given remote into a subdirectory of your own ref
space.  That's rather different than replacing your entire ref space
with the one available on the remote, which is what --mirror-all
is doing and what you wanted for the hosting you are offering.

> ..snip..
> >      (the archive vs active repacking strategy we talked about,
> 
> Hmm, I think I've missed this, I must look that in the archive.

Junio pushed the core code out but nobody has done the Porecelain
for it.  The basic idea is to prevent repacking every pack all of
the time; there's probably no reason to repack a 100 MiB pack file
every time you repack your loose objects so you might want to keep
say a <5 MiB "active pack" holding your recent created objects
and repack that frequently and a larger 100+ MiB "history pack"
holding everything else.  Maybe you repack everything on a longer
time scale, such as once a year.

> >      combined with set of packs with staggered spans to help
> >      commit walkers Pasky talked about quite a while ago).
> 
> Yes, this is certainly one of things I would like to implement at
> repo.or.cz.

Borrowing your line:
Hmm, I think I've missed this, I must look that in the archive.

:-)

-- 
Shawn.
