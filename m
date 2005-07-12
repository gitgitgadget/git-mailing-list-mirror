From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 21:59:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507112149290.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
 <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
 <20050712021004.GA27576@buici.com> <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org>
 <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org> <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org>
 <20050712044352.GA9919@buici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 07:03:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsCvZ-0001E5-Cg
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 07:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVGLFDB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 01:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVGLFAi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 01:00:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48801 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262364AbVGLE7c (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 00:59:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C4xQjA023266
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 21:59:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C4xP0x022803;
	Mon, 11 Jul 2005 21:59:25 -0700
To: Marc Singer <elf@buici.com>
In-Reply-To: <20050712044352.GA9919@buici.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Marc Singer wrote:
> 
> Does it make sense to think about this branch as an flow of commits?
> Or is it just a starting point for a line of development?

It's really a flow of commits. Nothing will ever really remember what the 
starting point was at some later date if you have done commits, and the 
branch will always follow the _head_ of development on that branch.

So if you need to remember the starting point as a _static_ entity, you
need to create a tag pointing to that place. You can do that at any point,
very much including after you've already done development (but before you
forget what to tag ;)

> If I make a branch, check it out, commit changes to it, and then clobber
> the working directory, can I later resume that branch of development
> without creating a new branch?

Absolutely. You can create a branch, commit to it, switch to another 
branch, commit to that one, switch back to the branch you created, and 
just go on. A branch will always follow the development.

> Do I need to set a tag to mark the last commit on that branch?

No, but as mentioned, _if_ you care about remembering where you _started_ 
the branch, you may want to tag that.

Of course, most of the time you really really don't care. It will be
largely obvious from the global commit history, which you can trivially
visualize with "gitk --all". You'll see where your branch "split off" the
main branch, and the only case where that is ambiguous is if you started
your branch at the tip of another branch, and no other development has
gone on in that other branch - then you don't see a "fork".

Of course, the other reason you usually don't care where you started is
that you simply don't care.  When you use CVS, you usually need to know
where the branch was started (and each point it was merged at) just so
that you can sanely merge it by doing diffs etc. With git, since we have
all the proper history, that's not necessary at all.

So I _suspect_ that most of the time when you create a branch, you don't 
need to tag where you started. Others will see what is your development 
simply by virtue of it being in your tree and not in other peoples tree, 
whether you created a branch for that or not ;)

		Linus
