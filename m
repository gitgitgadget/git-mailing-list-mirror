From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Constness fix for pickaxe option.
Date: Sat, 21 May 2005 15:16:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505211514360.2206@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
 <7voeb4kjda.fsf_-_@assigned-by-dhcp.cox.net> <7v1x80gruc.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 00:13:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZcDQ-0006WR-TR
	for gcvg-git@gmane.org; Sun, 22 May 2005 00:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVEUWOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 18:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVEUWOF
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 18:14:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:28618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261654AbVEUWOB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 18:14:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4LMDujA023319
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 May 2005 15:13:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4LMDtTW015684;
	Sat, 21 May 2005 15:13:56 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x80gruc.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 21 May 2005, Junio C Hamano wrote:
>
> Constness fix for pickaxe option.

Btw, this:

	static const char *pickaxe = 0;

may be legal C, but that doesn't make it less crap.

It's a pointer. If you want to make it a NULL pointer, make it a NULL 
pointer:

	static const char *pickaxe = NULL;

and don't try to stuff an integer into a pointer. Yeah, yeah, the integer 
zero is magic and special, but that's a bug in the C language, and we 
should try to not perpetuate it.

		Linus
