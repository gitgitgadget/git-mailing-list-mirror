X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 15:02:52 -0800
Message-ID: <7vlklsfsgz.fsf@assigned-by-dhcp.cox.net>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>
	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
	<87ejrlvn7r.wl%cworth@cworth.org>
	<7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
	<7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>
	<456EBBE7.8030404@op5.se>
	<Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
	<20061130164046.GB17715@thunk.org>
	<Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
	<Pine.LNX.4.64.0611301229290.9647@xanadu.home>
	<87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611301132350.3513@woody.osdl.org>
	<Pine.LNX.4.64.0611301521320.9647@xanadu.home>
	<7vhcwgiqer.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611301624430.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 23:04:04 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Carl Worth <cworth@cworth.org>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611301624430.9647@xanadu.home> (Nicolas Pitre's
	message of "Thu, 30 Nov 2006 17:21:00 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32830>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpuwa-0003zk-6F for gcvg-git@gmane.org; Fri, 01 Dec
 2006 00:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967949AbWK3XC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 18:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967961AbWK3XC6
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 18:02:58 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:5615 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S967960AbWK3XCx
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 18:02:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130230253.HAHL7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Thu, 30
 Nov 2006 18:02:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tB311V00e1kojtg0000000; Thu, 30 Nov 2006
 18:03:02 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> Wonderful! We might be converging to something then.

Yup.  And it appears that we even agree that "intent to add" is
a bad idea ;-).

>   Here's a twist.  If you do "git commit <file1> <file2> ..." then 
>   only the  changes belonging to those explicitly specified files will 
>   be committed, entirely bypassing the current "added" changes.  Those
>   "added" changes will still remain available for a subsequent commit.
>
>   There is a twist about that twist: if you do "git commit -i <file>..." 
>   then the commit will consider changes to those specified files 
>   _including_ all "added" changes so far.

I sense that you are inviting me to argue for reverting the
other "git commit" braindead which is spelled "--only" (and
worse yet, it is the default).  I am very tempted.

>   But for instance it is best to only remember "git add" + "git 
>   commit" and/or "git commit -a".
>
> Doesn't it sounds nice?  The index is being introduced up front without 
> even mentioning it, and I think the above should be fairly palatable to 
> newbies as well.  Would only lack some enhancements to the commit 
> template and the "nothing to commit" message so the user is cued about 
> the fact that "current changeset is empty -- don't forget to 'git add' 
> modified files, or use 'git commit -a'".
>
> What do you think?

Other than these "twists", I think it makes sense, and that is
what I think.

But making sense to me does not necessarily validate that a
tutorial document is great for its intended audience, since I
lost git virginity long time ago.  I can only endorse that the
description is technically accurate.
