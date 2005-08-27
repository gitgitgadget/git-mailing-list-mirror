From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC, PATCH] A new merge algorithm (EXPERIMENTAL)
Date: Fri, 26 Aug 2005 17:38:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508261730480.3317@g5.osdl.org>
References: <20050826184731.GA13629@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 02:39:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8oiK-0004YF-UR
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 02:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbVH0Ai0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 20:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbVH0Ai0
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 20:38:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965176AbVH0AiZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 20:38:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7R0cMjA023055
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 26 Aug 2005 17:38:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7R0cL1J006067;
	Fri, 26 Aug 2005 17:38:21 -0700
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050826184731.GA13629@c165.ib.student.liu.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7829>



On Fri, 26 Aug 2005, Fredrik Kuivinen wrote:
>
> In real numbers it is as follows: In Linus' kernel tree there are
> 5996 commits. 400 of those have more than one parent. Of those 400
> merge commits 4 have more than one shared head.

Ok, that's already interesting in itself. I was wanting to re-run all the 
merges with the new "git-merge-base -a" to see which merges might have had 
different merge bases, and you've actually done that. Interesting to see 
the numbers.

> * Is it worth it? That is, is the added complexity in the merge logic
>   worth the advantages of correctly handling some strange (but real
>   life) merge cases?

I am of two minds on this. I hate the notion of a more complex merge. But
at the same time, it clearly is a very interesting case when we do have
multiple possible shared parents, and I think that at the very least we
should warn the user. And using a more complex merge algorithm when it
happens seems to be a very valid thing to do.

Also, it's possible that other developers see more of the criss-crossing
merges than I do - iow, they're probably more likely to happen in the
throw-away trees than in some of the main trees. Neither of the two cases
we've seen and had issues were merges I did, for example. Which means that
your "1% of all merges" number is probably low. Of course, it's quite
likely that in most cases, the "pick either one" approach will give the
exact same result as the more complex merge.

Using python, which people have less exposure to, sounds like an 
additional thorny issue..

		Linus
