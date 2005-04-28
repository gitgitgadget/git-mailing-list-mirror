From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: I'm missing isofs.h
Date: Thu, 28 Apr 2005 09:28:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504280918230.18901@ppc970.osdl.org>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz>
 <Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org> <20050428003246.GV22956@pasky.ji.cz>
 <7vhdhra2sg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504280740450.18901@ppc970.osdl.org>
 <7vvf6698zq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 18:22:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRBlB-0004ga-06
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 18:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVD1Q0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 12:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVD1Q0c
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 12:26:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:28056 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262138AbVD1Q0a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 12:26:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SGQOs4016313
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 09:26:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SGQNDS025619;
	Thu, 28 Apr 2005 09:26:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf6698zq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Junio C Hamano wrote:
> 
> Is /dev/null convention OK with you?

Absolutely. In fact, I prefer it, but I end up just using standard "patch 
-p1" in the end, so..

> Here is an example of diffstat getting confused:

diffstat is _way_ too easily confused by various things. I've seen it
claim "no files" just because the diff had some headers that confused it.  
And yes, you should always tell it to use "-p1" to get the right
pathnames, otherwise it does nonsensical things (if all the diffs happen
to be in "drivers/usb/" it ends up deciding that that's just a common
prefix, and won't actually show it at all).

However, I'm surprised that it's confused by /dev/null. Usually the 
confusion comes from the stuff _after_ the name (ie adding the "mode" etc 
is what I'd have expected to confuse it).

One way to un-confuse diffstat is to add the "Index: " line. I'm not
actually much of a fan of Index: lines myself, and I'd rather somebody
fixed diffstat, but they _do_ work around diffstat problems.

		Linus
