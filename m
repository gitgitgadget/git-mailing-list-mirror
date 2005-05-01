From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 16:48:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505011638370.22864@ppc970.osdl.org>
References: <Pine.LNX.4.21.0505011656270.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0505011616230.22864@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 02 01:40:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSO2w-0005k3-J8
	for gcvg-git@gmane.org; Mon, 02 May 2005 01:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVEAXqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 19:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVEAXqQ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 19:46:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:1755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261239AbVEAXqJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 19:46:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j41Nk4s4008325
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 16:46:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j41Nk4Dq004053;
	Sun, 1 May 2005 16:46:04 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.58.0505011616230.22864@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Linus Torvalds wrote:
> 
> For example, take something like "git-diff-cache". I think it's a big
> bonus if you can just write
> 
> 	git-diff-cache HEAD
> 
> and it will pick up the sha1 ID from .git/HEAD. 

Ok, I just committed this. Almost all commands that take SHA1 strings from 
the command line can now use the shortened format. 

Right now it only does the "filename" version, and it tries to append 
".git/" to it if it doesn't work, so you can do

	git-diff-cache HEAD

or something like that if you want to. Where ".git/HEAD" would also have
worked, or ".git/refs/heads/master" (or just "refs/heads/master").

For example, if you have a refs/tags directory which has been populated 
with files that point to the tags, you can do

	git-diff-tree -p refs/tags/v2.6.12-rc3 HEAD

and it will do exactly what you'd expect it to do.

I didn't do the ".p1" for parent thing. It would be easy to add, I just 
haven't decided on a nice syntax for it (I'd like something that is nice 
and doesn't need quoting, but the ".p1" seems a bit _too_ ugly).

			Linus
