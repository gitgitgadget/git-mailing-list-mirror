From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 19:18:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151913180.7211@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504152029410.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 04:13:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMcoa-0003vS-8n
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 04:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVDPCRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 22:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVDPCRI
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 22:17:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:16800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262573AbVDPCRD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 22:17:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3G2Grs4027506
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 19:16:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3G2Gqeq029128;
	Fri, 15 Apr 2005 19:16:53 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504152029410.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Daniel Barkalow wrote:
> 
> Is there some reason you don't commit before merging? All of the current
> merge theory seems to want to merge two commits, using the information git
> keeps about them.

Note that the 3-way merge would _only_ merge the committed state. The 
thing is, 99% of all merges end up touching files that I never touch 
myself (ie other architectures), so me being able to merge them even when 
_I_ am in the middle of something is a good thing.

So even when I have dirty state, the "merge" would only merge the clean
state. And then before the merge information is put back into my working
directory, I'd do a "check-files" on the result, making sure that nothing
that got changed by the merge isn't up-to-date.

> How much do you care about the situation where there is no best common
> ancestor

I care. Even if the best common parent is 3 months ago, I care. I'd much 
rather get a big explicit conflict than a "clean merge" that ends up being 
debatable because people played games with per-file merging or something 
questionable like that.

> I think that the time spent on I/O will be overwhelmed by the time spent
> issuing the command at that rate.

There is no time at all spent on IO.

All my email is local, and if this all ends up working out well, I can 
track the other peoples object trees in local subdirectories with some 
daily rsyncs. And I have enough memory in my machines that there is 
basically no disk IO - the only tree I normally touch is the kernel trees, 
they all stay in cache.

		Linus
