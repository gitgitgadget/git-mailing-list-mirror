From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 10:25:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610221017180.3962@g5.osdl.org>
References: <200610221548.42048.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 19:25:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbh4m-0000bW-8e
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 19:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWJVRZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 13:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWJVRZ2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 13:25:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751321AbWJVRZ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 13:25:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9MHPOaX015146
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 Oct 2006 10:25:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9MHPNQM028304;
	Sun, 22 Oct 2006 10:25:24 -0700
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200610221548.42048.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29767>



On Sun, 22 Oct 2006, Andy Parkins wrote:
> 
> Git's commit-ish is very powerful.  I was wondering however, if there was a 
> shortcut for (for example)?
> 
>  git-diff 3435fdb4c^..3435fdb4c
> 
> That is - the short range of a particular commit's parent to that commit; like
> 
>  git-diff 3435fdb4c!

Umm. That's not actually a very sensible operation. It's only sensible in 
the special case of "diff", and for that special case, what we do is to 
actually just say that the _command_ is special, not the range.

It's called "git show".

So the thing to do is just

	git show 3435fdb4c

and be happy.

Anyway, there's two kinds of commands wrt revision ranges in git:

 - "git diff"
 - everything else

That may sound strange, but it's true. "git diff" doesn't really do 
"revision ranges". It does "two revision endpoints", which is literally 
very different from just about any other git command. All the other 
commands really think of commits as a "set of individual commits" (where 
sometimes the "set" is admittedly just a single commit).

So the reason for you wanting that "3435fdb4c^..3435fdb4c" is not that 
it's a particularly useful thing in _general_, it's that "git diff" wants 
two endpoints, and you want to have that describe a single commit. 

Hopefully this explains why it's the _command_ that is special, and not 
the range. The range makes no sense.

				Linus
