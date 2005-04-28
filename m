From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 09:29:15 +0100
Message-ID: <1114676955.12012.346.camel@baythorne.infradead.org>
References: <42703E79.8050808@zytor.com>
	 <1114673723.12012.324.camel@baythorne.infradead.org>
	 <20050428081005.GG8612@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 10:24:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR4Jm-00017K-D6
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 10:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVD1I3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 04:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVD1I3e
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 04:29:34 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:25510 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261784AbVD1I3R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 04:29:17 -0400
Received: from localhost.localdomain ([127.0.0.1])
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DR4OZ-0008CS-Dl; Thu, 28 Apr 2005 09:29:15 +0100
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050428081005.GG8612@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 10:10 +0200, Petr Baudis wrote:
>   Linus                     ASM (Anonymous Subsystem Maintainer)
> 
>     |------------------------.
>    A|                        |B
>     |                        |
>     |                        \-------------\
>     |                        :             |
>     \------------------------\             |E
>    C|                        |D            |
>     |                        /-------------/
>     |                        |F
>     /------------------------/
> 
> How would you show that? F E D C B A? F D C A E B?

Let us assume that C and A were already in Linus' tree (and on our web
page) yesterday. Thus, they should be last. The newly-pulled stuff
should be first -- FEDBCA.

I'd say "depth-first, remote parent first" but that would actually show
show 'A' (as a parent of D) long before it shows C. Walking of remote
parents should stop as soon as we hit a commit which was accessible
through a more local parent, rather than as soon as we hit a commit
which we've already printed. Maybe it should be something like depth-
first, local parent first, but _reversed_?

The latter is what the mailing list feeder does, but that has the
advantage of being about to use 'rev-tree $today ^$yesterday' so we
_know_ we're excluding the ones people have already seen. Hence I
haven't really paid that much attention to getting the order strictly
correct.

(Yes, I know that strictly speaking, git has no concept of 'remote' or
'local' parents. But the ordering of the two parents in a Cogito merge
or pull hasn't changed, has it?)

-- 
dwmw2


