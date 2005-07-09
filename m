From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] format-patch: fix skipping of blank-lines
Date: Fri, 8 Jul 2005 18:42:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507081838560.17536@g5.osdl.org>
References: <7vu0j44xi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 03:43:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr4Mz-0000kQ-V2
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 03:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbVGIBm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 21:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVGIBm7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 21:42:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5604 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263043AbVGIBmc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 21:42:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j691gQjA009179
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 8 Jul 2005 18:42:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j691gQpN008595;
	Fri, 8 Jul 2005 18:42:26 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0j44xi4.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 8 Jul 2005, Junio C Hamano wrote:
>
> If it is fed a commit with more than one leading blank lines,
> the sed scripts git-format-patch-script used looped forever.
> This patch fixes it.

How about using "git-stripspace"? That's what it's there for. It strips
whitespace from the end of lines, from the beginning, and from the end. It
also removes multiple consecutive whitespace lines from within the body of
the message - which might turn some people off, but I use that same thing
when I do my automated email commits, so if you don't strip those lines
from the email, they _will_ get stripped at commit time, so..

"git-stripspace" also doesn't get confused by non-empty lines that have 
spaces in them, like your script seems to be (ie /^$/ won't match a line 
that has a space on it).

		Linus
