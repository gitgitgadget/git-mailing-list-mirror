From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] General object parsing
Date: Sun, 17 Apr 2005 18:15:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171807590.7211@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504171958520.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:10:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKmU-0004EA-1K
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVDRBON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVDRBON
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:14:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:27595 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261454AbVDRBN7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 21:13:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3I1Dps4002539
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 18:13:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3I1Do5v016243;
	Sun, 17 Apr 2005 18:13:51 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504171958520.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Daniel Barkalow wrote:
> 
> Any comment on the design, or should I send my implementation?

Show the patches, and maybe I (and others) can make comments on the 
thing.. It doesn't sound broken by design, the only question is how much 
harder (if any) it is to use than the rather trivial "revision.h" which 
gets us really small files.

In particular, is there some easy way to walk backwards by time? "git log"  
definitely needs that, and merge-base clearly wants something similar. I
also pretty much guarantee that visualization tools want that - creating a
visual representation of the dag by time.

If you need to read the whole thing to get that representation, then 
trying to be clever isn't even worth it - it's such a common thing that I 
bet rev-tree + caches is actually way superior.

But if there are simple helper functions to get the "next backwards in 
time" case (by looking at the parent dates in a merge), then that should 
be ok to do incrementally.

			Linus
