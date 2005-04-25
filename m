From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 11:50:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251147290.18901@ppc970.osdl.org>
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
 <426D21FE.3040401@tiscali.de> <Pine.LNX.4.58.0504251021280.18901@ppc970.osdl.org>
 <426D33BA.8040604@tiscali.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:44:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ8YX-0002Nc-Ln
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 20:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVDYSsn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 14:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVDYSsn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 14:48:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:18916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262726AbVDYSsk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 14:48:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PImVs4019091
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 11:48:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3PImTpP030184;
	Mon, 25 Apr 2005 11:48:30 -0700
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
In-Reply-To: <426D33BA.8040604@tiscali.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
>
> But this makes, like "register", direct use of processor registers (it
> stores int arguments in eax, ebx, etc.).

No. It make _unlike_ "register", direct use of processor registers.

The "register" keyword does _not_ use processor registers. It's just 
syntactic fluff, and tells the compiler exactly one thing:

 - that the compiler should warn if you take the address of such a thing.

In addition, the compiler may generate code that takes it into account, 
which most likely means _worse_ code than if it didn't take it into 
account.

In contrast regparm() actually says something very relevant: it says that 
the function uses a totally different calling convention.

		Linus
