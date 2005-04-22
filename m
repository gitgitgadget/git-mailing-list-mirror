From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Fri, 22 Apr 2005 15:55:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504221544190.2344@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
 <7vis2fbr0p.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org>
 <7vzmvr72j6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504221147050.2344@ppc970.osdl.org>
 <7vbr867ecy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504221503270.2344@ppc970.osdl.org>
 <20050422223341.GC21204@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:49:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6xW-0002wV-2m
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDVWxr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDVWxr
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:53:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:65495 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261263AbVDVWxp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 18:53:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MMrbs4012729
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 15:53:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MMraMf017498;
	Fri, 22 Apr 2005 15:53:36 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422223341.GC21204@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Petr Baudis wrote:
> 
> Note that Cogito almost actually does not use show-diff anymore.
> I'm doing diff-cache now, since that is what matters to me.

Indeed.  "diff-tree" (between releases) and "diff-cache" (between a
release and the current state) are clearly much more fundamental
operations.

Also, they have absolutely zero policy, and they're designed to be used
with the same scripting engines (ie hopefully you can use just one tool to
show the output of either in whatever format you want).

They show you what the canonical names and associated information is, and
that's it. What you _do_ with them ends up being outside the scope of git,
exactly like it should be. Details like "what format of diff" to produce 
should be left to the tools around it.

In contrast, "show-diff" was _literally_ written to check what the
difference between the "real" file and a "sha1"  file was, back when I
couldn't write the sha1 files correctly (ie I corrupted anything that 
didn't fit in the first "[un]compression block", and then calling "diff" 
to show the difference between the original and the regenerated data was 
very important).

So "show-diff" just kind of expanded from an early debugging tool to
something that _almost_ looks like a real tool. But it's absolutely the
right thing to use "diff-tree" and "diff-cache" instead.

			Linus
