From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] fail pull/merge early in the middle of conflicted merge
Date: Mon, 1 Jan 2007 15:43:54 -0500
Message-ID: <20070101204354.GA26687@spearce.org>
References: <7vwt478b5d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 21:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1U0p-00024k-DF
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 21:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbXAAUn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 15:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbXAAUn7
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 15:43:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58937 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813AbXAAUn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 15:43:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1U0b-0002GK-2X; Mon, 01 Jan 2007 15:43:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5010220FB65; Mon,  1 Jan 2007 15:43:55 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwt478b5d.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35741>

Junio C Hamano <junkio@cox.net> wrote:
> After a pull that results in a conflicted merge, a new user
> often tries another "git pull" in desperation.  When the index
> is unmerged, merge backends correctly bail out without touching
> either index nor the working tree, so this does not make the
> wound any worse.

I've seen this many times too.  I don't understand why users cannot
read output messages and realize the current command failed, but
they don't.  *sigh*
 
> Old timers may know better and would not to try pulling again
> before cleaning things up; this change adds extra overhead that
> is unnecessary for them.  But this would be worth paying for to
> save new people from needless confusion.

This penalty isn't very high though; its just a single pass through
the index to look for an unmerged entry.  I think that small
penalty is worth the better error message here, and that's the guy
who just submitted patches to remove other penalties in pull and
merge talking.  :-)

-- 
Shawn.
