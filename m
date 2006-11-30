X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 15:47:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home>
 <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org>
 <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
 <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
 <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 30 Nov 2006 20:47:40 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Theodore Tso <tytso@mit.edu>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32797>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpsoX-0007SF-L1 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 21:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967896AbWK3UrW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 15:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967897AbWK3UrW
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 15:47:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57509 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S967896AbWK3UrW (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 15:47:22 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9K009L59QWB1O0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Thu,
 30 Nov 2006 15:47:21 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Thu, 30 Nov 2006, Linus Torvalds wrote:

> What does it mean to "add" something to a project? It has _nothing_ to do 
> with "filenames". Yeah, the filename obviously exists, but it's not 
> something that exists on its own. You add the ONLY thing that git tracks. 
> 
> You add CONTENT.
> 
> When you do "git add file.c" you aren't adding a filename to the list of 
> files that git knows about. Not even CLOSE. No. You are really adding 
> _content_ to the project you are tracking. You haven't bound it to a 
> commit yet, but it's there. It's there both conceptually, and very much in 
> a real technical sense too (you've literally added the git object that 
> that file describes to the object database - the "commit" and "tree" 
> objects to tie it all together is just waiting to be added, but they 
> really just expose it - the actual file object has already been created 
> when you do "git add".)
> 
> So yes, you very much ARE talking about CVS braindamage. The reason why
> 
> 	git add file.c
> 	echo New line >> file.c
> 	git commit
> 
> commits the _old_ content, is very much because git is ALL ABOUT THE 
> CONTENT. It has _never_ been about filenames. And it _shouldn't_ be about 
> filenames, because that would be BUGGY AND BROKEN.

Great.  But let me repeat my last question:

Would it make sense for "git add" to do the same as "git update-index" 
on already tracked files?  Given the explanation above this would make 
100% sense to me.

Even for newbies this might help them understand the power of the index 
with only one command. "You _add_ your changes together before you may 
commit."  That's simple to understand even for newbies.  And then 
they'll start using the power of the index even without realizing it.

But right now, doing "git add" on an already tracked file simply does 
nothing.  This is even worse than erroring out.


