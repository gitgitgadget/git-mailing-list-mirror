X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Mon, 18 Dec 2006 19:13:40 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612181906450.18171@xanadu.home>
References: <86y7p57y05.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
 <8664c896xv.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 19 Dec 2006 00:17:13 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34773>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwSc8-0001r3-34 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 01:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932485AbWLSANn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 19:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWLSANm
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 19:13:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28769 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932485AbWLSANl (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 19:13:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAH00EJKVAS19D0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Mon,
 18 Dec 2006 19:13:40 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Mon, 18 Dec 2006, Linus Torvalds wrote:

> I've heard of other operations being slow on OS X - and two orders of 
> magnitude really isn't unthinkable. I don't think people always seem to 
> really understand how _good_ Linux is, and how much faster it can be. It's 
> not just "Windows XP" sucks. Quite often it's literally "Linux is just 
> damn fast".
> 
> Sadly, that causes problems when the main developers don't even see any 
> issues, just because the Linux kernel environment makes things look really 
> really cheap. Even when it isn't always cheap on other platforms.
> 
> Nico - have you looked at perhaps making the index-pack.c "mmap()" usage 
> do chunking? Or just mmap the whole damn thing once? Linux is fast, but 
> even Linux will be faster if you just mmap it once ;)

Maybe.  However the mmap() may occur on section of the pack file which 
has just been written to in order to write even more, always to the same 
file.  On Linux this is fast because the mmap'd data is likely to still 
be in the cache.

I guess this could be turned into a malloc()/read()/free() with no 
trouble.


