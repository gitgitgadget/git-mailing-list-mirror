From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 10:04:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
References: <20050416131528.GB19908@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 18:59:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMqdO-0003hC-2l
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 18:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVDPRCn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 13:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVDPRCn
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 13:02:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:19586 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262701AbVDPRCj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 13:02:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3GH2Ys4028007
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 10:02:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3GH2XuE020570;
	Sat, 16 Apr 2005 10:02:34 -0700
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050416131528.GB19908@elte.hu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Ingo Molnar wrote:
> 
> i've converted the Linux kernel CVS tree into 'flat patchset' format, 
> which gave a series of 28237 separate patches. (Each patch represents a 
> changeset, in the order they were applied. I've used the cvsps utility.)
> 
> the history data starts at 2.4.0 and ends at 2.6.12-rc2. I've included a 
> script that will apply all the patches in order and will create a 
> pristine 2.6.12-rc2 tree.

Hey, that's great. I got the CVS repo too, and I was looking at it, but 
the more I looked at it, the more I felt that the main reason I want to 
import it into git ends up being to validate that my size estimates are at 
all realistic.

I see that Thomas Gleixner seems to have done that already, and come to a 
figure of 3.2GB for the last three years, which I'm very happy with, 
mainly because it seems to match my estimates to a tee. Which means that I 
just feel that much more confident about git actually being able to handle 
the kernel long-term, and not just as a stop-gap measure.

But I wonder if we actually want to actually populate the whole history.. 
Now that my size estimates have been verified, I have little actual real 
reason to put the history into git. There are no visualization tools done 
for git yet, and no helpers to actually find problems, and by the time 
there will be, we'll have new history.

So I'd _almost_ suggest just starting from a clean slate after all.  
Keeping the old history around, of course, but not necessarily putting it
into git now. It would just force everybody who is getting used to git in 
the first place to work with a 3GB archive from day one, rather than 
getting into it a bit more gradually.

What do people think? I'm not so much worried about the data itself: the
git architecture is _so_ damn simple that now that the size estimate has
been confirmed, that I don't think it would be a problem per se to put
3.2GB into the archive. But it will bog down "rsync" horribly, so it will
actually hurt synchronization untill somebody writes the rev-tree-like
stuff to communicate changes more efficiently..

IOW, it smells to me like we don't have the infrastructure to really work 
with 3GB archives, and that if we start from scratch (2.6.12-rc2), we can 
build up the infrastructure in parallell with starting to really need it.

But it's _great_ to have the history in this format, especially since 
looking at CVS just reminded me how much I hated it.

Comments?

		Linus
