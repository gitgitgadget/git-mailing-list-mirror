From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: (cogito) Branch offf from older commit?
Date: Sun, 14 Aug 2005 10:03:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508140950270.3553@g5.osdl.org>
References: <20050814155005.6492A353BBF@atlas.denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 19:04:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4Ltj-00042t-O1
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 19:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVHNRDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 13:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVHNRDj
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 13:03:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932568AbVHNRDj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 13:03:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7EH3ZjA014653
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 Aug 2005 10:03:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7EH3Y02008637;
	Sun, 14 Aug 2005 10:03:34 -0700
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050814155005.6492A353BBF@atlas.denx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 14 Aug 2005, Wolfgang Denk wrote:
>
> Is there (in cogito) a way to  start  a  branch  off  from  an  older
> commit?

You should be able to just use the git commands, and cogito should be 
perfectly happy.

IOW, if you do

	git checkout -b newbranch <starting-point-sha1>

you'll switch to a "newbranch" that was created at the starting point, and
as far as I can tell, this is all very cogito-friendly indeed. So now you
can work in that "newbranch" - commit things, do anything you want, and
all with cogito (ie it's only this one raw git command you need to set
things up, after that you're back in cogito-land).

You can switch back with "git checkout master" (again, I don't think
cogito does the local git branches yet, but once you've switched back
you're golden), and if you're in the "master" branch, you can merge with 
your new-branch with


	git resolve master newbranch "Merge my work on xyz"

or similar.

And always remember "gitk --all", since that's a very useful thing to 
visualize where you are.

> 	-> cg-seek 024447b186cca55c2d803ab96b4c8f8674363b86

No, cg-seek doesn't start a new branch, so the result is "locked". You 
can't commit on top of the seek-point, because the branch you are in 
already _has_ a child of that point.

(Actually, these days cg-seek does use a fixed local git branch for the
seek target, so that's not _technically_ true any more. I suspect Pasky is 
working on exposing the general local branch interfaces)

		Linus
