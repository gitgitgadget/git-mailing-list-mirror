From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Flag and skip over packfiles known to be invalid.
Date: Sun, 4 Feb 2007 00:02:37 -0500
Message-ID: <20070204050237.GD16766@spearce.org>
References: <dda240a4adf0511b3e1ab1eb74abdd28821358b0.1170403175.git.spearce@spearce.org> <20070202080010.GB21094@spearce.org> <7virelhsae.fsf@assigned-by-dhcp.cox.net> <20070202085108.GC20832@spearce.org> <7vr6t7bxsn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 06:02:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDZWU-00073r-PB
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 06:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbXBDFCl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 00:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbXBDFCl
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 00:02:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52115 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbXBDFCk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 00:02:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDZWE-0007bh-HU; Sun, 04 Feb 2007 00:02:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 98B8F20FBAE; Sun,  4 Feb 2007 00:02:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vr6t7bxsn.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38648>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > I almost submitted a patch to do that tonight, but I couldn't decide
> > on behavior: should we scan known packs, then try for loose, then
> > scan packs again until no object or no new pack is found?  Probably.
> 
> Hmmm.  Probably.  
> 
> But I tend to think that this particular failure scenario is
> probably rare enough that plugging this in "the right way" is
> not a high priority.  We should definitely revisit it post
> 1.5.0.

Indeed.  I'll come back to it after 1.5.0 is out.
 
> Also if we are adding a bitfield, I think pack_local should also
> become one, as it currently wastes a whole word to hold one bit
> (on the other hand if we do not want to add a field I think a
> different negative value in pack_fd could mean "do not bother to
> look at it again").

Good point. I forgot about that ~4 byte boolean hanging around.
As a comment on the TDWTF might say, "Yes, No, FileNotFound, 42,
192, 1088, ... these are all valid values for pack_local!"  :-)

-- 
Shawn.
