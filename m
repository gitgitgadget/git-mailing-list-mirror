From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Mon, 13 Mar 2006 00:14:33 -0400
Message-ID: <200603130414.k2D4EXcX011651@laptop11.inf.utfsm.cl>
References: <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 13 16:50:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIpIQ-0007je-AF
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 16:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWCMPtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 10:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWCMPtS
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 10:49:18 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30097 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751451AbWCMPtR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 10:49:17 -0500
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k2DFnDkD025134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 13 Mar 2006 11:49:14 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.5) with ESMTP id k2D4EXcX011651
	for <git@vger.kernel.org>; Mon, 13 Mar 2006 00:14:33 -0400
To: git@vger.kernel.org
In-Reply-To: Message from Jeff King <peff@peff.net> 
   of "Sun, 12 Mar 2006 22:38:05 EST." <20060313033805.GB14601@coredump.intra.peff.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 13 Mar 2006 11:49:14 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17565>

Jeff King <peff@peff.net> wrote:

[...]

> A void pointer is guaranteed to be able to hold any type of pointer
> (either char * or struct foo * or whatever). The declaration of malloc
> indicates a return of void *. On a platform where it matters, the
> compiler generates code so that 
>   struct foo *bar = malloc(100);
> converts the void * pointer into the correct size (in the same way that
> assigning between differently sized integers works).

Right.

> This breaks down with variadic functions, which have no typing
> information. So doing this:
>   execl("foo", "bar", my_struct_foo);
> doesn't give the compiler a chance to do the implicit cast and you get
> subtle breakage (in the same way that you would if you passed a long to
> a variadic function expecting a short).

It just passes 3 "void *"'s, and casts back. What is so strange?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
