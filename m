From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fetch/pull: support Cogito-style remote branch information.
Date: Fri, 15 Jul 2005 15:42:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507151529590.19183@g5.osdl.org>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net> <7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
 <7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 00:44:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtYti-0003d2-8Q
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 00:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVGOWnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 18:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVGOWnA
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 18:43:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261718AbVGOWm7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2005 18:42:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6FMgojA004103
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Jul 2005 15:42:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6FMghXj005686;
	Fri, 15 Jul 2005 15:42:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Hmm..

This patch actually brings up two different issues

 - I actually prefer code and documentation to be separated. Finding the 
   actual changes to code in this patch is made much harder by the fact
   that most of the changes are documentation updates. In many ways it 
   would have been nicer to separate the two out - first the actual 
   change, then the docs updates.

   Maybe that's just me.

 - I'd much rather have a generic "address rewriting layer" than a "-b" 
   flag.

   I don't mind the shorthand at all, but I don't think it should be that
   special. It's not "worthy" of a flag - if you have a shorthand that 
   says "linus == rsync://kernel.org/pub/scm/git/git.git", then I think it 
   should just work, and 

	git pull linus

   should end up not needing a "-b" flag. It's not like there is any 
   real ambiguity.

Now, I'd like the address rewriting to actually be fairly capable, so it 
should be a script of its own.

And it's not necessarily just the branch handling, but more of a generic
shorthand: I'd love to be able to mix something like

	git pull jgarzik/misc-2.6 upstream

and "jgarzik" would be expanded (through something like .git/branches) to 
"master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/"), resulting in the 
_full_ path being expanded to

	master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6 upstream

which I have to write out in full (or, more commonly, cut-and-paste) right
now.

Hmm?

		Linus
