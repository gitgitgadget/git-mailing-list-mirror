From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bad git pull
Date: Fri, 16 Dec 2005 17:05:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512161701400.3698@g5.osdl.org>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com> 
 <7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>  <7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
  <118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com> 
 <7vfyoshmp6.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0512161347490.3698@g5.osdl.org>
 <118833cc0512161637v1d180f9fh66a7dc6d3fe11d2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Don Zickus <dzickus@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 02:06:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnQWH-0005mg-LX
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 02:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVLQBFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 20:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVLQBFu
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 20:05:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750962AbVLQBFu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2005 20:05:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBH15gDZ015293
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Dec 2005 17:05:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBH15fZa021064;
	Fri, 16 Dec 2005 17:05:42 -0800
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0512161637v1d180f9fh66a7dc6d3fe11d2b@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13765>



On Fri, 16 Dec 2005, Morten Welinder wrote:
> 
> It would be outright peachy if Documentation/git-commit.txt and
> Documentation/git-pull.txt mentioned these.  That is certainly
> where I would look first to answer the "what if I screwed up?"
> question.

It might be even better to have some of the "safe" versions around. Ie 
something that refuses to "undo" a merge (you want to "unpull" it or 
"unmerge" it), and refuses to "undo" when there's a ORIG_HEAD around that 
implies that the last commit was a "pull" (in which case again "undo" may 
be the wrong thing to do, since it will only undo _one_ commit, even 
though the pull might have fast-forwarded a _lot_ of commits).

Of course, if we do that, we should also make sure that "git commit" 
removes ORIG_HEAD. 

Or maybe "git commit" should always _write_ ORIG_HEAD with the old head, 
so that we can always do an "undo" by doing "git reset --hard ORIG_HEAD" 
regardless of whether the last thing was a "git commit" or a "git pull".

Hmm?

		Linus
