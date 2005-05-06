From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How do I...
Date: Fri, 6 May 2005 15:57:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505061552140.2233@ppc970.osdl.org>
References: <427B3DB3.4000507@tuxrocks.com>  <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
  <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0505061006060.2233@ppc970.osdl.org>
  <1115404771.16187.343.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.58.0505061158520.2233@ppc970.osdl.org>
 <1115406628.16187.353.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 00:58:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUBlZ-0000zk-9s
	for gcvg-git@gmane.org; Sat, 07 May 2005 00:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVEFXC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 19:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVEFW6g
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 18:58:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:15559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261315AbVEFWzr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 18:55:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46MtVU3010823
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 15:55:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46MtUZD004111;
	Fri, 6 May 2005 15:55:31 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115406628.16187.353.camel@hades.cambridge.redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 6 May 2005, David Woodhouse wrote:
> 
> When I said 'show' I meant merely provide sufficient information. 

To do that, you'd just have to always show the commit/parent pairs, 
regardless of whether it had a difference or not. That's actually what the 
first version did, but it was so ugly that I ended up changing it to only 
showing pairs that had differences. 

It would be easy to add a "--all" flag or something, that shows all 
commit/parent information, and then you would use that, but the thing is, 
you're likely better off just using git-rev-tree to build the graph in the 
first place.

So it's doable, and it has nothing to do with git-diff-tree. So normally
you'd do something like "show me all differences between v2.6.12-rc2 and
now, and then you _do_ end up using git-rev-tree first to make a list of
commits, and then you feed that list of commits into git-diff-tree - and
notice that when you did the rev-tree in the first place, you actually did
build up the history tree to get there, so if you want to visualize it,
you should now use _that_ tree that you already built.

diff-tree never has any commit history tree information available to it.  
It just doesn't know, care, or bother. 

		Linus
