From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 17:42:03 -0400
Message-ID: <20060920214203.GE24415@spearce.org>
References: <20060919232851.GA12195@spearce.org> <7vac4ujzf0.fsf@assigned-by-dhcp.cox.net> <20060920161407.GQ8259@pasky.or.cz> <20060920162145.GA23260@spearce.org> <7vslimfcf9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:42:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9pe-0002dB-N4
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWITVmK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWITVmK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:42:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:61655 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932152AbWITVmH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 17:42:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ9pM-0007b2-DM; Wed, 20 Sep 2006 17:41:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C493920E48E; Wed, 20 Sep 2006 17:42:03 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslimfcf9.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27413>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >> >      (the archive vs active repacking strategy we talked about,
> >> 
> >> Hmm, I think I've missed this, I must look that in the archive.
> >
> > Junio pushed the core code out but nobody has done the Porecelain
> > for it.  The basic idea is to prevent repacking every pack all of
> > the time; there's probably no reason to repack a 100 MiB pack file
> > every time you repack your loose objects so you might want to keep
> > say a <5 MiB "active pack" holding your recent created objects
> > and repack that frequently and a larger 100+ MiB "history pack"
> > holding everything else.  Maybe you repack everything on a longer
> > time scale, such as once a year.
> 
> And IIRC we were stuck on the convention to tell which ones are
> archives and which ones are actives (i.e. fair game for
> repacking).  We were trying to figure out how to mark active
> ones (whose name changes every time you repack).

Yes.  I had pretty much given up on a size threshold concept and
was thus in agreement with you that we just needed a way to flag
each pack file...
 
> I realized that there is a very simple and obvious solution for
> it.  Introduce $GIT_OBJECT_DIRECTORY/info/archived-packs, a flat
> text file that lists the names of the archive packs.  Any pack
> not listed there are active one and are subject to repacking.

Like that.  :-)

-- 
Shawn.
