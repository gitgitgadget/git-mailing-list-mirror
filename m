From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sun, 31 Dec 2006 00:47:41 -0500
Message-ID: <20061231054741.GA6106@spearce.org>
References: <20061231020218.GA5366@spearce.org> <7vodpkhjzq.fsf@assigned-by-dhcp.cox.net> <20061231023809.GC5082@spearce.org> <7vk608hiwq.fsf@assigned-by-dhcp.cox.net> <20061231030119.GD5082@spearce.org> <7vejqgk4l1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 06:47:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tXy-000133-Hp
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 06:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932971AbWLaFrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 00:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932948AbWLaFrq
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 00:47:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44941 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932971AbWLaFrp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 00:47:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0tY4-0003vy-NY; Sun, 31 Dec 2006 00:47:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5CC9320FB65; Sun, 31 Dec 2006 00:47:42 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejqgk4l1.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35674>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > So in your test case where you thought you entered 20 pages, what you
> > really had was just 2 pages.  We rounded 20 bytes down to 0 pages,
> > then forced that to a minimum of 2 pages.  :-)
> 
> Yes.
> 
> And I found something else that is interesting.  I still had 2
> pages windows but reduced packedgitlimit to 256kB and re-run the
> same test to reproduce all merges in git.git.  It still did not
> fail, but it took even shorter wallclock time (again, it is only
> 3 seconds or so out of 5 1/2 minuts, so it is probably
> statistically insignificant).

Its possible the packed_git.windows list is hurting us here.
Its O(n) to locate a given window.  The larger the ratio between
packedGitWindowSize and packedGitLimit the longer that list can get,
and the longer it can take to locate a window.

Maybe that should be a simple red-black tree?

More testing probably needs to be done though.

-- 
Shawn.
