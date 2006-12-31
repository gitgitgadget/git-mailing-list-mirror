From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sat, 30 Dec 2006 22:01:19 -0500
Message-ID: <20061231030119.GD5082@spearce.org>
References: <20061231020218.GA5366@spearce.org> <7vodpkhjzq.fsf@assigned-by-dhcp.cox.net> <20061231023809.GC5082@spearce.org> <7vk608hiwq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 04:01:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0qww-0004Dh-K5
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 04:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWLaDBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 22:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWLaDBX
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 22:01:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40431 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691AbWLaDBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 22:01:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0qwf-0002x0-Ee; Sat, 30 Dec 2006 22:01:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E3E8F20FB65; Sat, 30 Dec 2006 22:01:19 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk608hiwq.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35659>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >> Also can we fix the definition of core.packedGitWindowSize to be
> >> independent of the page size on a particular platform?
> >
> > What do you mean?  mmap() only works in page units, and because of
> > the way the code is built the minimum size we can allow is 2 pages.
> >
> > Asking mmap() to map less than a full page in the last page of
> > a given window is silly, as that is just going to waste virtual
> > address space or cause pain for the OS, depending on how that
> > gets implemented.
> 
> Ah, I misread the code.  I thought the value is integer that
> states number of pages, but you are only rounding it down and
> enforcing two-page minimum.

So in your test case where you thought you entered 20 pages, what you
really had was just 2 pages.  We rounded 20 bytes down to 0 pages,
then forced that to a minimum of 2 pages.  :-)

-- 
Shawn.
