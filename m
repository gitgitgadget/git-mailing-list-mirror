From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-log produces no output
Date: Fri, 21 Apr 2006 11:11:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604211102000.3701@g5.osdl.org>
References: <20060421172001.44441.qmail@web60325.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 21 20:11:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX06G-0005c7-4q
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 20:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWDUSLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 14:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWDUSLV
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 14:11:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932344AbWDUSLU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Apr 2006 14:11:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3LIBItH009936
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Apr 2006 11:11:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3LIBHLX009209;
	Fri, 21 Apr 2006 11:11:18 -0700
To: Bob Portmann <bportmann@yahoo.com>
In-Reply-To: <20060421172001.44441.qmail@web60325.mail.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19023>



On Fri, 21 Apr 2006, Bob Portmann wrote:
>
>  I cannot get any output out of it and am wondering if I am using it
> correctly or it is broken.

You're using it correctly, but it isn't broken for me. 

> As I understand it, git-log should just print out the log messages but 
> not the changes, whereas git-whatchanged will print out both.

Well, in 1.3.0, "git log" can actually do both, and you can get the 
whatchanged output by just saying "git log -p".

But yes, without the "-p", you should get just the log.

And that's exactly what I get, both with current HEAD git, and with a 
v1.3.0 checkout.

> test-log> git log
> test-log> 
> 
> As you can see git log produces no output.  I've tried it with other
> options with the same result.

Very strange indeed. Can you do

	git log > file

to see if that changes (and see if the file contains anything)? The reason 
I mention that is that by default "git log" will start a pager for you, 
and if you somehow have a broken PAGER setup, I could imagine exactly the 
behaviour you see (although I don't see why "git whatchanged" would work 
either, in that case).

Finally, if that doesn't output anything either, please do (for just that 
small repository, so that the trace is also small)

	strace -o git-trace git log > /dev/null

and send out the result. Again, for PAGER reasons, that "> /dev/null" is 
actually important, because we don't want to trigger the pager code.

		Linus
