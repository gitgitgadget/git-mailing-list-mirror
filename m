From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Better error messages for corrupt databases
Date: Thu, 11 Jan 2007 19:40:44 -0500
Message-ID: <20070112004044.GA23864@spearce.org>
References: <20070111125726.GJ1759@mellanox.co.il> <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org> <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org> <45A6A97F.5080008@shadowen.org> <7vodp52qzz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701111400031.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Andy Whitcroft <apw@shadowen.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 01:41:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5ATb-0007RZ-OL
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 01:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbXALAk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 19:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbXALAk5
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 19:40:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42118 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXALAk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 19:40:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5ATJ-0005zJ-80; Thu, 11 Jan 2007 19:40:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6B9B720FBAE; Thu, 11 Jan 2007 19:40:44 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701111400031.3594@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36643>

Linus Torvalds <torvalds@osdl.org> wrote:
> So this just makes "xmmap()" return NULL for a zero-sized object (which is 
> a valid thing pointer, exactly the same way "malloc()" can return NULL for 
> a zero-sized allocation). That fixes the first problem (but we could have 
> fixed it in the caller too - I don't personally much care whichever way it 
> goes, but maybe somebody should check that the NO_MMAP case does 
> something sane in this case too?).

All calls to perform any sort of mmap go through xmmap().  If NO_MMAP
was defined at compile time than the mmap() call within xmmap() is
redefined to invoke git_mmap() via a preprocessor define slightly
earlier in git-compat-util.h.

So your patch will also automatically do the right thing in the
NO_MMAP case.

BTW, I like your solution of just fixing it here in xmmap().  Good idea.

-- 
Shawn.
