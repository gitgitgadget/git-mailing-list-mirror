From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 12 Jan 2007 01:26:44 -0500
Message-ID: <20070112062644.GC24195@spearce.org>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701102241230.4964@xanadu.home> <20070111080035.GA28222@spearce.org> <45A6016B.4030800@op5.se> <Pine.LNX.4.64.0701110955100.4964@xanadu.home> <45A65F15.6040606@op5.se> <20070112004927.GB23864@spearce.org> <7vr6u0wz2s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 07:27:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5FsP-0006hb-Hc
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 07:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbXALG0t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 01:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbXALG0t
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 01:26:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51210 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161005AbXALG0s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 01:26:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5FsE-0006Mp-Fw; Fri, 12 Jan 2007 01:26:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BBBFC20FBAE; Fri, 12 Jan 2007 01:26:44 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6u0wz2s.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36663>

Junio C Hamano <junkio@cox.net> wrote:
> With the tip of linux-2.6 repository, v1.4.4 series takes 0.03s
> while v1.5.0-rc1 takes about 3.6s.  That is 100x fold, not just
> 4x.
> 
> It turns out that to describe 0404f87f (tip of linux-2.6) the
> new one picks up 61 tags in the posible-tag loop.
> 
> Since this loop uses the usual date-order, we can limit the
> number of candidate tags without losing too much precision.
> When limiting the candidates to only 6 (attached patch), the
> time drops to 0.25s.

OK.  Apply your patch to master.  3.6s is insane, even for
git-describe. I think your guess of 6 is reasonable, but I'd
obviously like to remove the need for it entirely.

I think I have a sketch in my head for an algorithm that can
compute the revision counts while in the possible-tag loop, which
would completely remove the huge cost of the per-tag revision
list later on.  I can't work on it right now (need to get other
stuff done before 1 pm Friday) but I will try to code and test it
tomorrow afternoon.  If I'm right I'll send a patch.

-- 
Shawn.
