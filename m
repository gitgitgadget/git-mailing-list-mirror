From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 13:45:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151334350.7211@ppc970.osdl.org>
References: <20050414002902.GU25711@pasky.ji.cz> <20050413212546.GA17236@64m.dyndns.org>
 <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
 <7vr7hbhky9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Christopher Li <git@chrisli.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 22:41:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMXcH-0004kr-1M
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 22:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVDOUoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVDOUoL
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 16:44:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:55974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbVDOUoH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 16:44:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3FKhws4023189
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 13:43:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3FKhvsU014303;
	Fri, 15 Apr 2005 13:43:58 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7hbhky9.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Junio C Hamano wrote:
> 
> I was looking at merge-tree.c last night to add recursive
> behaviour (my favorite these days ;-) to it [*1*].
> 
> But then I started thinking.

Always good.

> LT> ... For each entry in the directory it says either
> LT> 	select <mode> <sha1> path
> LT> or
> LT> 	merge <mode>-><mode>,<mode> <sha1>-><sha1>,<sha1> path
> LT> depending on whether it could directly select the right object or not.
> 
> Given that the case you are primarily interested in is the one
> that affects only small parts of a huge tree (i.e. common kernel
> merge pattern I understand from your previous messages), your
> "hacky version" [*2*], extended for recursive operation, would
> spit out 98% select and 2% merge, and probably the origin of
> these selects are distributed across ancestor=90%, his=4%,
> my=4%, or something similar.  Am I misestimating grossly?

No. That's _exactly_ right. You do not want a recursive merge-tree. 

The "diff-tree" thing is different, exactly because it prunes out all the 
differences early on.

> I am thinking about:
> 
>  - adding recursive behaviour (I am almost done with this);

I think your suggestion sounds perfectly reasonable.

		Linus
