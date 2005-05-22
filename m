From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sat, 21 May 2005 23:01:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505212253350.2206@ppc970.osdl.org>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> <7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
 <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 07:58:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZjTs-0005tO-FR
	for gcvg-git@gmane.org; Sun, 22 May 2005 07:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVEVF7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 01:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVEVF7m
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 01:59:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:44193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261738AbVEVF7c (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 01:59:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4M5xRjA017985
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 May 2005 22:59:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4M5xL4V030398;
	Sat, 21 May 2005 22:59:25 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 21 May 2005, Junio C Hamano wrote:
>
> Update the diff-raw format as Linus and I discussed, except that
> it does not use sequence of underscore '_' letters to express
> nonexistence.  All '0' mode is used for that purpose instead.

Ok, it all looks very nice, but it looks like -C is still broken ;)

Do 

	git-whatchanged -C -p

and you'll see this hilarious entry as the first "copy" entry:

	diff --git a/Documentation/git-diff-cache.txt b/diffcore-pickaxe.c
	similarity index 0%
	copy from Documentation/git-diff-cache.txt
	copy to diffcore-pickaxe.c
	--- a/Documentation/git-diff-cache.txt
	+++ b/diffcore-pickaxe.c
	@@ -1,150 +1,56 @@
	..

it even says "similarity index 0%", adn that sure is accurate ;)

Doing "-C50" to ask for at least 50% similarity makes it ok (and it finds
the "git-pull-script" -> "git-resolve-script" thing), but there's
something strange going on, becuase -C10 and -C90 don't work, even if -C40
and -C50 _do_ work.

		Linus
