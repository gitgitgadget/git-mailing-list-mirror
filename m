From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Shell quoting
Date: Thu, 15 Sep 2005 12:01:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509151153140.26803@g5.osdl.org>
References: <43290BB8.90501@zytor.com> <7vy85yahjk.fsf@assigned-by-dhcp.cox.net>
 <4329C11A.1040302@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 21:03:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFyz9-0005th-Q2
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 21:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVIOTBZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 15:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVIOTBZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 15:01:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16861 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750889AbVIOTBY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 15:01:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FJ1KBo010042
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 12:01:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FJ1HPG018207;
	Thu, 15 Sep 2005 12:01:18 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4329C11A.1040302@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8626>



On Thu, 15 Sep 2005, H. Peter Anvin wrote:
>
> Okay, I'm trying to put together some rules that should work across shells.

Does anybody really still use tcsh? It's a broken mess.

Junio's "sq_quote()" works wonderfully on any valid shells. The fact that 
tcsh expands ! even inside single quotes is just pure braindamage.

You could expand "sq_quote" to handle '!' and '\' characters the exact
same way it handles the single tick (end single-tick quoting, do \! or \\
and start single-tick quoting again) and that might be good enough for
tcsh.

IOW, the string "a\b'c!d" would become 'a'\\'b'\''c'\!'d' after 
surrounding sq_quote with single-ticks.

Insane?

		Linus
