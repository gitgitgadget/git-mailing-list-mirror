From: Tom Lord <lord@emf.net>
Subject: Re: on when to checksum
Date: Mon, 2 May 2005 12:21:50 -0700 (PDT)
Message-ID: <200505021921.MAA26977@emf.net>
References: <Pine.LNX.4.58.0504201601130.6467@ppc970.osdl.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 21:18:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSgQ6-0005bU-1z
	for gcvg-git@gmane.org; Mon, 02 May 2005 21:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVEBTXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 15:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEBTXQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 15:23:16 -0400
Received: from emf.emf.net ([205.149.0.19]:52485 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S261721AbVEBTVx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 15:21:53 -0400
Received: (from lord@localhost) by emf.net (K/K) id MAA26977; Mon, 2 May 2005 12:21:50 -0700 (PDT)
To: torvalds@osdl.org
In-reply-to: <Pine.LNX.4.58.0504201601130.6467@ppc970.osdl.org> (message from Linus Torvalds on Wed, 20 Apr 2005 16:07:11 -0700 (PDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


  The thing is, I don't "trickle" things in. That would be horribly 
  inefficient for me. So I go over the patches, make a mbox, and do them all 
  in one go. And then they need to happen _fast_. If it takes 20 minutes, I 
  go away for coffee or something, and then if something didn't apply 
  half-way through, I will have lost my "context".

  That's why I want things instant. Not because I have huge daily throughput 
  issues, but I have huge _latency_ issues. 

I'm curious about what is the value of the "batch" nature of that
proces?

Presumably most patches apply cleanly and most or orthogonal (order
independent).   I'm sure that there are frequently interesting exceptions
but am I generally right about "most" here?

So, if I understand, you review each change before stuffing it in a
mailbox, then you apply all the patches in that mailbox in batch.
In the majority of cases, the buffering of changes in the mailbox
adds nothing.

Why isn't that more automated: when you approve a change, it could be
applied at once, in the background.  If conflictless, it can be committed,
tested, whatever.  If conflicting, *then* the change can be buffered
up for you to look at.   Explicit declarations from programmers or 
text-based computations about dependencies among the patches can help
improve the queue management in more complicated cases.

In other words, a more asynchronous process might save you time *and*
pay off by reserving more of your attention for areas where it's 
really needed.

-t

