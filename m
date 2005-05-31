From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ls-tree: remove trailing slashes properly.
Date: Tue, 31 May 2005 15:19:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505311507010.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
 <7vvf4zvzfw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:16:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdF0k-0003aG-HC
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 00:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVEaWR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 18:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVEaWR3
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 18:17:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:44195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261161AbVEaWRP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 18:17:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4VMH9jA009457
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 May 2005 15:17:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4VMH86n015981;
	Tue, 31 May 2005 15:17:08 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf4zvzfw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 31 May 2005, Junio C Hamano wrote:
>
> A typo prevented trailing slashes from being removed properly.

This is still wrong.

> This fixes the problem that "drivers/char" which is a tree was
> not shown when "drivers/char/" is given.

I sent an earlier email pointing out that removing trailing slashes is 
_incorrect_, because it means that "drivers/char/" will match the _file_ 
"drivers/char", which is wrong.

IOW, the trailing slash should not be removed, it's the _test_ that is 
wrong.

I just checked in a fix for this in diffcore-patchspec.c, I'd hope that 
ls-tree could get it right too. Removing trailing slashes is a bandaid 
that hides one bug by making it appear as a different bug.

		Linus
