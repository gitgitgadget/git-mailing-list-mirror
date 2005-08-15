From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate object pool mechanism updates.
Date: Sun, 14 Aug 2005 17:29:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508141726390.3553@g5.osdl.org>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net> <20050813120815.GC5608@pasky.ji.cz>
 <7v1x4wcca0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 02:29:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4Sqq-0003UJ-RM
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 02:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVHOA3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 20:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbVHOA3N
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 20:29:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932598AbVHOA3N (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 20:29:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7F0T6jA007960
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 Aug 2005 17:29:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7F0T5E1024105;
	Sun, 14 Aug 2005 17:29:05 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x4wcca0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 14 Aug 2005, Junio C Hamano wrote:
> 
> Ok, so the one in the proposed updates branch says
> info/alternates.
> 
> With this, your recent cg-clone -l can be made to still use
> individual .git/object/??/ hierarchy to keep objects newly
> created in each repository while sharing the inherited objects
> from the parent repository, which would probably alleviate the
> multi-user environment worries you express in the comments for
> the option.  The git-clone-script in the proposed updates branch
> has such a change.

I think this is great - especially for places like kernel.org, where a lot 
of repos end up being related to each other, yet independent.

However, exactly for places like kernel.org it would _also_ be nice if
there was some way to prune objects that have been merged back into the
parent. In other words, imagine that people start using my kernel tree as
their source of "alternate" objects, which works wonderfully well, but
then as I pull from them, nothing ever removes the objects that are now
duplicate.

We've got a "git prune-packed", it would be good to have a "git
prune-alternate" or something equivalent.

			Linus
