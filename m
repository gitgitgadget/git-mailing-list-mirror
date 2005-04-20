From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Possible strategy cleanup for git add/remove/diff etc.
Date: Tue, 19 Apr 2005 18:51:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191846290.6467@ppc970.osdl.org>
References: <20050419035107.GB5554@pasky.ji.cz> <7vacnumgot.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 03:45:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO4HS-00088y-0h
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 03:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVDTBtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 21:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDTBtX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 21:49:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:4484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261257AbVDTBtO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 21:49:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3K1n8s4007207
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 18:49:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3K1n7tQ012295;
	Tue, 19 Apr 2005 18:49:08 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacnumgot.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Junio C Hamano wrote:
> 
> Let's for a moment forget what git-pasky currently does, which
> is not to touch .git/index until the user says "Ok, let's
> commit". 

I think git-pasky is wrong.

It's true that we want to often (almost always) diff against the last 
"released" thing, and I actually think git-pasky does what it does because 
I never wrote a tool to diff the current working directory against a 
"tree".

At the same time, I very much worked with a model where you do _not_ have 
a traditional "work file", but the index really _is_ the "work file".

> I'd like to start from a different premise and see what happens:
> 
>  - What .git/index records is *not* the state as the last
>    commit.  It is just an cache Cogito uses to speed up access
>    to the user's working tree.  From the user's point of view,
>    it does not even exist.

Yes. Yes. YES.

That is indeed the whole point of the index file. In my world-view, the
index file does _everything_. It's the staging area ("work file"), it's
the merging area ("merge directory") and it's the cache file ("stat
cache").

I'll immediately write a tool to diff the current working directory 
against a tree object, and hopefully that will just make pasky happy with 
this model too. 

Is there any other reason why git-pasky wants to have a work file?

		Linus
