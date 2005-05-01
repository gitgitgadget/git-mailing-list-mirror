From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 16:23:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505011616230.22864@ppc970.osdl.org>
References: <Pine.LNX.4.21.0505011656270.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 02 01:16:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSNfX-0003be-N6
	for gcvg-git@gmane.org; Mon, 02 May 2005 01:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVEAXWL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 19:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVEAXWL
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 19:22:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:38360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261416AbVEAXWE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 19:22:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j41NLxs4007086
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 16:22:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j41NLwbC003300;
	Sun, 1 May 2005 16:21:59 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505011656270.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Daniel Barkalow wrote:
> 
> I added a get_ref_sha1() that just does the .git/refs/ case; I think that
> most things that want to accept various forms will also want to know what
> form they got and do something with it, so get_sha1() isn't a big win.

I really really disagree.

For example, take something like "git-diff-cache". I think it's a big
bonus if you can just write

	git-diff-cache HEAD

and it will pick up the sha1 ID from .git/HEAD. 

In general, I think a "get_sha1()" that tries as many user-friendly things 
as possible is good for the command line. Within reason. I really don't 
like the "try to autocomplete a partial sha1" thing, but I wouldn't at all 
mind having various helpers like

	git-diff-tree HEAD.p1 HEAD

where the ".p1" would just make it look up the first parent of the thing 
in HEAD (which in turn would mean "look up the sha1 from the .git/HEAD 
file".

Many of these are really easy to do, and I think most people would tend to 
prefer having the choice.

		Linus
