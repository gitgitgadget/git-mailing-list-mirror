From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Wed, 17 Aug 2005 08:38:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508170830050.3553@g5.osdl.org>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
 <7vek8t7bva.fsf@assigned-by-dhcp.cox.net> <7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 17:38:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Q03-00021h-Nx
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 17:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVHQPie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 11:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVHQPie
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 11:38:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751151AbVHQPie (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 11:38:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7HFcTjA009438
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 Aug 2005 08:38:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7HFcSIm024850;
	Wed, 17 Aug 2005 08:38:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 16 Aug 2005, Junio C Hamano wrote:
>
> This is a companion patch to the previous format-patch fix.
> With "-k", format-patch can be told not to remove the [PATCH] in
> the original commit, nor to add the [PATCH] on its own.

I think this might be the point in time to just make the "[PATCH]" prefix 
go away.

It made much more sense with BK than it does with git: since git keeps 
track of "author" and "committer" separately, you can always see when the 
committer wasn't the author of the change, which is what the "[PATCH]" 
thing was all about. 

In other words, at least for the kernel, [PATCH] was a marker that said 
"the author didn't commit this directly". Git already has that information 
explicitly in the git data.

(Also, with proper "Signed-off-by:" lines it's also always clear that 
there were other people involved, and that the author of the patch is 
different from the person who applied it).

So I would personally not mind if we just made the "[PATCH]" prefix go 
away entirely, or perhaps had a separate flag to "git-applymbox" that told 
it to prepend a specific prefix to the Subject: line (which might not be 
"[PATCH] " at all) defaulting to "no prefix".

			Linus

PS. Another historical reason for marking patches explicitly was that
people were worried that introducing BK would somehow make the old
patch-based submissions be "second-class citizens". It was easy to make
statistics and show that at least half the real changes (as opposed to
merges) were still patch-based. So again, the "PATCH" marker had some 
historical relevance, but I don't think it matters any more.
