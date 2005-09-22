From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 15:05:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509221500150.2553@g5.osdl.org>
References: <E1EIWUv-0004HR-F6@jdl.com> <Pine.LNX.4.58.0509221413400.2553@g5.osdl.org>
 <Pine.LNX.4.58.0509221427520.2553@g5.osdl.org> <Pine.LNX.4.63.0509221747340.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 00:07:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIZBy-0004dQ-RX
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 00:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVIVWFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 18:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVIVWFT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 18:05:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751307AbVIVWFS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 18:05:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8MM59Bo018475
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Sep 2005 15:05:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8MM527h023203;
	Thu, 22 Sep 2005 15:05:04 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509221747340.23242@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9149>



On Thu, 22 Sep 2005, Daniel Barkalow wrote:
> 
> Would it be worthwhile to have a flag to make git-read-tree abort rather 
> than making a mess if you have any dirty state and the merge isn't 
> completely automatic? It's certainly easy enough to write.

I don't think it would be wrong, necessarily.

On the other hand, it might be easier to just instead do a 

	git diff HEAD > .git/pre-merge-diff

and let it go at that. If the merge ends up being nasty, you can then just 
do

	git reset --hard
	git-apply .git/pre-merge-diff

or something.

I dunno. This is not something that has caused me a lot of headache. I 
certainly _hope_ that people generally don't keep a lot of dirty state 
around: I do it for truly small stuff that I don't care about.

Let's face it - if I cared about it, I'd have committed it (possibly to
another branch). It's not like that's hard. So the dirty stuff really does 
tend to be only trivial things.

		Linus
