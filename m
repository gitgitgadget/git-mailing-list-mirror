From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb.cgi history not shown
Date: Sun, 11 Jun 2006 09:54:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606110948090.5498@g5.osdl.org>
References: <e5bfff550606102231o756f6d11lc46fecdad29568c0@mail.gmail.com> 
 <Pine.LNX.4.64.0606102248360.5498@g5.osdl.org>
 <e5bfff550606102332v6afb7d51m43ad5d74ba226cf0@mail.gmail.com>
 <Pine.LNX.4.64.0606110902090.5498@g5.osdl.org> <Pine.LNX.4.64.0606110933040.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 11 18:54:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpTCm-0002QF-DZ
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 18:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWFKQy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 12:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWFKQy0
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 12:54:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751044AbWFKQyZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 12:54:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5BGsKgt022982
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Jun 2006 09:54:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5BGsJJN026399;
	Sun, 11 Jun 2006 09:54:19 -0700
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0606110933040.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21663>


I just like talking to myself.

On Sun, 11 Jun 2006, Linus Torvalds wrote:
> 
> 	git-rev-list --all | git-diff-tree -p -- <filename>

That obviously wants a "--stdin" argument to git-diff-tree, and I might as 
well point out that it has a few other differences to doing this with the 
"--no-simplify-history" flag:

 - git-diff-tree obviously doesn't show merges normally, and when it does, 
   it would show only merges that change the file. In contrast, the "git 
   log" approach would show all merges that are part of the resulting 
   history (which, since you don't simplify merges, is _all_ of them).

 - the extra flag to "git log" approach allows "--parents" to work, ie the 
   stretches of commits in between merges would have their parents 
   rewritten, so that the history would be a unified whole, and you can 
   use qgit/gitk to show the result. The above pipeline obviously cannot 
   do that, since doing the filename limiter in git-diff-tree means that 
   it doesn't ever even _see_ the "history" part, it's just doing it one 
   commit at a time.

That concludes my monologue on the matter, I hope. If somebody wants to 
condense the issue of "show all history" vs "show how we got to this 
state" and add it to the Wiki FAQ thing, that would probably be good.

		Linus
