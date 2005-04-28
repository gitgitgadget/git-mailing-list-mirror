From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 15:12:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281506500.18901@ppc970.osdl.org>
References: <42703E79.8050808@zytor.com>  <1114673723.12012.324.camel@baythorne.infradead.org>
  <20050428081005.GG8612@pasky.ji.cz>  <1114676955.12012.346.camel@baythorne.infradead.org>
  <1114680199.12012.363.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
 <1114723214.2734.9.camel@localhost.localdomain> <42715B30.6010705@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 00:06:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRH8D-0000Eq-J0
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVD1WKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVD1WKk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:10:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:6319 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262286AbVD1WKa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 18:10:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SMAOs4018274
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 15:10:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SMANbZ014891;
	Thu, 28 Apr 2005 15:10:24 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42715B30.6010705@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, H. Peter Anvin wrote:
>
> I thought about this for a few seconds (I really should do that more 
> often...) and realized what it is you want: you want a primary search 
> criterion which is "when did event X become visible to me", where "me" 
> in this case is the web tool.  That is not repository information, but 
> it is perfectly possible for the webtool to be aware of what it has 
> previously seen and when.

This is exactly what rev-tree does, and how things like the commit emails 
happen.

The problem is that since it's observer-dependent, it's not generally very 
useful for something like a web interface. You really don't want to keep 
track of what everybody has seen ;)

What you _can_ try to keep track of is what some "special observer" has
seen. That's really quite complicated too, but if you do a web interface,
the "special observer" is yourself. Then at every time you mirror the
thing, you need to remember what your "last view" was, and you base your
"new view" on the fact that you know what you saw last time, so you know
which things are new to _you_.

But it really means that each web interface ends up showing quite
_different_ information, and the particular information you show ends up
being dependent on when you started looking at the tree (and how often you
re-generate new views).

This really is why "time" is interesting. Because it's simple, and 
observers can agree about it (not because the time was the same, but 
because each observer just agrees that time is "whatever was reported as 
the local time at the point the action happened").

		Linus
