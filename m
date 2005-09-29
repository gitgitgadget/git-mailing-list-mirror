From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fetch-pack should not ask for a ref which is already
 there
Date: Thu, 29 Sep 2005 14:07:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0509291403050.5362@g5.osdl.org>
References: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509291120170.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509292058020.8413@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0509292124190.8668@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 23:07:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL5d0-0004QF-TY
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 23:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVI2VHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 17:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbVI2VHk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 17:07:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964891AbVI2VHk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 17:07:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8TL7W4s028189
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Sep 2005 14:07:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8TL7SvL005256;
	Thu, 29 Sep 2005 14:07:30 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509292124190.8668@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9509>



On Thu, 29 Sep 2005, Johannes Schindelin wrote:
>
> Wouldn't it make much more sense to add a flag which repairs an incomplete
> fetch?

No.

We've seen crap. We've _seen_ people use the old git-ssh-pull etc that 
would result in incomplete repositories, and having people use the 
"--recover" flag.

THAT KIND OF CRAP IS UNACCEPTABLE! I had to walk Andrew through a broken 
repository because he had used those unreliable fetch methods. I was 
ashamed of git at that point.

If a ^C results in a repository that needs to be fixed up, the "source 
control management" is BROKEN. It's not source control, it's a buggy mess.

I refuse to use such tools. End of story. We do this right, or we don't do 
it at all. And doing it right means that you only write refs after you've 
downloaded everything, and you only _ever_ depend on refs. You don't 
_ever_ say "if I have this object, I think I have everything".

The thing is, _reliability_ is #1. It's not performance. Performance is 
important, but performance doesn't matter AT ALL if it comes at the 
expense of reliability.

 		Linus
