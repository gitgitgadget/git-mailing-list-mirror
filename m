From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 09:31:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
References: <20050429203959.GC21897@waste.org><20050429203959.GC21897@waste.org>
 <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrea Arcangeli <andrea@suse.de>, Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 18:30:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSdmz-00015g-9T
	for gcvg-git@gmane.org; Mon, 02 May 2005 18:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVEBQdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 12:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVEBQaO
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 12:30:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:61670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261438AbVEBQ3R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 12:29:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j42GT6s4015135
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 09:29:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j42GT5CC003421;
	Mon, 2 May 2005 09:29:05 -0700
To: Bill Davidsen <davidsen@tmr.com>
In-Reply-To: <42764C0C.8030604@tmr.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 2 May 2005, Bill Davidsen wrote:
> > -#!/usr/bin/python
> > +#!/usr/bin/env python

> Could you explain why this is necessary or desirable? I looked at what 
> env does, and I am missing the point of duplicating bash normal 
> behaviour regarding definition of per-process environment entries.

It's not about environment.

It's about the fact that many people have things like python in
/usr/local/bin/python, because they compiled it themselves or similar.

Pretty much the only path you can _really_ depend on for #! stuff is 
/bin/sh.

Any system that doesn't have /bin/sh is so fucked up that it's not worth
worrying about. Anything else can be in /bin, /usr/bin or /usr/local/bin
(and sometimes other strange places).

That said, I think the /usr/bin/env trick is stupid too. It may be more 
portable for various Linux distributions, but if you want _true_ 
portability, you use /bin/sh, and you do something like

	#!/bin/sh
	exec perl perlscript.pl "$@"

instead.
		Linus
