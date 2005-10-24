From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Sun, 23 Oct 2005 20:32:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510232020030.10477@g5.osdl.org>
References: <4352F4C9.1040703@catalyst.net.nz> <20051021005145.GB30889@pasky.or.cz>
 <200510202137.22311.dtor_core@ameritech.net> <4358597A.6000306@catalyst.net.nz>
 <7vu0f7u3xc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510231804430.10477@g5.osdl.org>
 <7vy84jsn1o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 05:32:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETt4N-00014Q-CZ
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 05:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVJXDcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 23:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVJXDcQ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 23:32:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750948AbVJXDcQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 23:32:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9O3W5FC002684
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 23 Oct 2005 20:32:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9O3W4KK008624;
	Sun, 23 Oct 2005 20:32:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy84jsn1o.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10526>



On Sun, 23 Oct 2005, Junio C Hamano wrote:
> 
> The current callers only feed commits for "$heads" parameters,
> so the merge strategy backends are free to figure out the common
> ancestor or even generate weave on the fly, but an unwritten
> rule was that strategy backends are expected to do something
> sensible even when the "common ancestors" and "heads" fed to
> them are tree objects, which was my comment about 3-way was
> about.

Ahh. Yes, if you use raw trees, you're screwed - you can only ever do a 
3-way merge, since you can't try to figure out any history.

I agree that the "tree only" case is interesting too - it's how you can 
merge trees that may be related content-wise but don't share a history (eg 
the same project maintained in separate source trees), and it's obviously 
how you can merge totally unrelated projects (eg the gitk merge). At the 
same time, I think that's a different kind of merge, in general. And we 
definitely shouldn't limit ourselves to things where such merges work.

Yes, tree-merges are wonderful, and they work really quite well, but I 
definitely want to keep the window open for merges that end up taking the 
full history into account.

I just don't think they are nearly as important as some people seem to 
think. They should be a very special and unusual case, rather than 
something you expect to happen.

		Linus
