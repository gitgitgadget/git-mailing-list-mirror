From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Why pack+unpack?
Date: Tue, 26 Jul 2005 01:13:27 -0400
Message-ID: <42E5C677.2020403@pobox.com>
References: <42D7F415.30609@pobox.com> <Pine.LNX.4.58.0507252145470.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 07:15:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxHmK-0006au-Nz
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 07:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVGZFOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 01:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVGZFOW
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 01:14:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:7607 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261729AbVGZFNb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 01:13:31 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1DxHkw-0002jB-Iz; Tue, 26 Jul 2005 05:13:31 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507252145470.6074@g5.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> First, make sure you have a recent git, it does better at optimizing the 

I was using vanilla git, as of 10 minutes before I sent the email.  Top 
of tree is 154d3d2dd2656c23ea04e9d1c6dd4e576a7af6de.


> Secondly, what's the problem? Sure, I could special-case the local case, 
> but do you really want to have two _totally_ different code-paths? In 
> other words, it's absolutely NOT a complete waste of time: it's very much 
> a case of trying to have a unified architecture, and the fact that it 
> spends a few seconds doing things in a way that is network-transparent is 
> time well spent.
> 
> Put another way: do you argue that X network transparency is a total waste
> of time? You could certainly optimize X if you always made it be
> local-machine only. Or you could make tons of special cases, and have X 
> have separate code-paths for local clients and for remote clients, rather 
> than just always opening a socket connection.

Poor example...   sure it opens a socket, but X certainly does have a 
special case local path (mit shm), and they're adding more for 3D due 
the massive amount of data involved in 3D.


> We do end up having a special code-path for "clone" (the "-l" flag), which
> does need it, but I seriously doubt you need it for a local pull. The most 
> expensive operation in a local pull tends to be (if the repositories are 
> unpacked and cold-cache) just figuring out the objects to pull, not the 
> packing/unpacking per se.

Well, I'm not overly concerned, mostly curious.  The pack+unpack step 
(a) appears completely redundant and (b) is the step that takes the most 
time here, for local pulls, after the diffstat.

	Jeff
