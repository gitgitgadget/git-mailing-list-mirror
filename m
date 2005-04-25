From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 13:51:14 -0400
Message-ID: <200504251751.j3PHpE7T004422@laptop11.inf.utfsm.cl>
References: <matthias.christian@tiscali.de>
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:47:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ7fO-0002MS-EB
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 19:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVDYRvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVDYRvn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:51:43 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48305 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262666AbVDYRvj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 13:51:39 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j3PHo5rL013538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Apr 2005 13:50:05 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j3PHpFPN004425;
	Mon, 25 Apr 2005 13:51:15 -0400
Received: from laptop11.inf.utfsm.cl (vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.4/8.13.4/Submit) with ESMTP id j3PHpE7T004422;
	Mon, 25 Apr 2005 13:51:15 -0400
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
In-Reply-To: Message from Matthias-Christian Ott <matthias.christian@tiscali.de> 
   of "Mon, 25 Apr 2005 13:18:09 +0200." <426CD1F1.2010101@tiscali.de> 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 25 Apr 2005 13:50:05 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias-Christian Ott <matthias.christian@tiscali.de> said:
> [Proposed patch adding "register" snipped]

Somebody a long while ago told me there are 3 kinds of C compilers with
respect "register": Dumb ones (they don't even consider it, just do
business as usual, as they don't know any better), normal ones (they
consider "register" and honor it if they can), and bright ones (they don't
even consider it, as they do a much better job using registers than any
programmer could direct them to by wiring a value into a register). GCC
definitely falls on the brighter side, at least if you tell it to
optimize. I think "register" should be marked deprecated in C (and there
are few good texts that even mention the word today, so it is deprecated in
practice).

Better compare the code produced (with -S instead of -c you'll get
assembler output in .s, not object code in .o) before any optimization
proposal. But also consider that large real gains come from higher-level
changes (better data structures, more efficient algorithms) and not from
low-level changes (In any case, today's compilers are usually smart enough
to make low-level changes on their own, so you can (thankfully) concentrate
on writing clear, correct code; and let the compiler make it fast. Sure,
where it is in a stretch of hot code, executed hundereds of times a second
on millions of machines worldwide, extra loving care is warranted, but that
is another kettle of fish.).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
