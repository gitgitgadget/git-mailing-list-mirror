From: Jeff King <peff@peff.net>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 06:58:38 -0400
Message-ID: <20080423105838.GA15310@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com> <20080422023918.GA5402@sigill.intra.peff.net> <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com> <20080423080826.GA11935@sigill.intra.peff.net> <alpine.DEB.1.00.0804231110080.4181@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 12:59:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JochB-0005gb-Sy
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 12:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbYDWK6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 06:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbYDWK6j
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 06:58:39 -0400
Received: from peff.net ([208.65.91.99]:3906 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900AbYDWK6j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 06:58:39 -0400
Received: (qmail 15645 invoked by uid 111); 23 Apr 2008 10:58:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 06:58:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 06:58:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804231110080.4181@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80208>

On Wed, Apr 23, 2008 at 11:13:27AM +0100, Johannes Schindelin wrote:

> > It was easy enough to work up the patch below, which allows
> > 
> >   git filter-branch --blob-filter 'tr a-z A-Z'
> > 
> > However, it's _still_ horribly slow.
> 
> You create a quite huge blob-cache, so you are pretty heavy on disk-I/O.  
> Have you tried (as suggested in the man page) to run this on a huge RAM 
> disk?  That should blow you away.

No, I didn't. But the disk I/O is pretty minimal. The blob cache is only
a few megabytes, and it stays entirely in Linux's disk cache. My disk
light only blinks every 5-10 seconds to flush dirty pages to disk.

> I hoped that the rewrite-commits attempt was more than just that: an 
> attempt.  So there is a point you could start from, doing things in C.
>
> But I doubt that you get any joy: either your language is too limited, or 
> you will get the same problems (fork() overhead) again.

Ah, right. I totally forgot about that effort. I will take a peek next
time I need to do some filtering.

> > Anyway, here is the patch. I don't know if it is even worth applying, 
> > since it is still painfully slow.
> 
> I like your patch:
> 
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

I think it could use some documentation updates. Avery, do you want to
try adding a CRLF example to the manpage?

-Peff
