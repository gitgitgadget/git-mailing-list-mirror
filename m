From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What broke snapshots now?
Date: Sun, 10 Jul 2005 10:31:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507101026430.17536@g5.osdl.org>
References: <1120907336.8058.293.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0507090908490.17536@g5.osdl.org> 
 <1120952292.23706.49.camel@baythorne.infradead.org> 
 <1121006378.23706.65.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0507100954080.17536@g5.osdl.org> <1121016147.23706.91.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 19:32:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drfek-0002oE-OW
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 19:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVGJRbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 13:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVGJRbs
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 13:31:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261981AbVGJRbs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 13:31:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6AHVhjA032269
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Jul 2005 10:31:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6AHVgUZ024382;
	Sun, 10 Jul 2005 10:31:42 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1121016147.23706.91.camel@baythorne.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 10 Jul 2005, David Woodhouse wrote:
> 
> > Anyway, it's possible that this is a temporary problem: one of the issues 
> > is that since you seem to be using the "rsync:" protocol for updating 
> > things, what happens is that if the mirroring is off a bit, you may have 
> > gotten a new head, but not all the objects. Then you'd get exactly this.
> 
> It's done locally on hera though -- so the mirroring shouldn't be a
> problem.

No it's not, as far as I can tell:

	torvalds@hera:/home/dwmw2/git/mail-2.6(0)$ cat .git/branches/origin
	rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

so your scripts will go out to rsync with www.kernel.org to get the data, 
when you use "cg-update origin".

> More usefully though, if ordering really isn't a problem on your
> repository then I should probably rewrite the script to work directly
> from that instead of from a copy.

It should not be a problem, but you obviously have to be careful about 
ordering, ie you should fetch the references first, and act on them later. 

		Linus
