From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Do not show empty diff in diff-cache uncached.
Date: Sun, 29 May 2005 11:53:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
 <7vsm091887.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
 <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> <7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
 <7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 20:49:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcSqv-00031T-V8
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVE2SwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVE2SwA
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:52:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:3728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261401AbVE2Sv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 14:51:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4TIpqjA017338
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 29 May 2005 11:51:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4TIppcL027633;
	Sun, 29 May 2005 11:51:51 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 28 May 2005, Junio C Hamano wrote:
>
> Pre- "diff --git" built-in diff did not add any extended header
> on its own, so it did not show anything for unmodified but
> stat-dirty file from diff-cache command without --cached flag.
> 
> Recent diff-cache produces "diff --git" header internally before
> calling the "diff" command, which results in an empty diff for
> such a file, cluttering the output.  This patch fixes this.

I'm not sure I like this.

I actually _expect_ that "git-diff-files" will show files that don't match 
the index, even if they happen to have the exact content that the index 
points to. It's how I know whether the index is up-to-date or not.

The exact same thing is trye of git-diff-cache. If something isn't 
up-to-date in the cache, you should show it, since certain operations 
depend on the cache being updated.

		Linus
