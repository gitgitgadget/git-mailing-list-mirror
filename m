From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 11:13:27 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804231110080.4181@eeepc-johanness>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com> <20080422023918.GA5402@sigill.intra.peff.net>
 <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com> <20080423080826.GA11935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 12:14:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JobzZ-0000Eo-5i
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 12:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbYDWKNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 06:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbYDWKNd
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 06:13:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:52768 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751286AbYDWKNd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 06:13:33 -0400
Received: (qmail invoked by alias); 23 Apr 2008 10:13:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp050) with SMTP; 23 Apr 2008 12:13:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vWC5gZpJv6HNc3LZEtYdeasBiVfNo2MznFmy8EQ
	MxuKAP7Pd5tHXF
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080423080826.GA11935@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80207>

Hi,

On Wed, 23 Apr 2008, Jeff King wrote:

> On Tue, Apr 22, 2008 at 12:51:14PM -0400, Avery Pennarun wrote:
> 
> > Do you think git would benefit from having a generalized version of 
> > this script?  Basically, the user provides a "munge" script on the 
> > command line, and there's a git-filter-branch mode for auto-munging 
> > (with a cache) every file in every checkin.  Even if it's *only* ever 
> > used for CRLF, I can imagine this being useful to a lot of people.
> 
> It was easy enough to work up the patch below, which allows
> 
>   git filter-branch --blob-filter 'tr a-z A-Z'
> 
> However, it's _still_ horribly slow.

You create a quite huge blob-cache, so you are pretty heavy on disk-I/O.  
Have you tried (as suggested in the man page) to run this on a huge RAM 
disk?  That should blow you away.

> Shell script is nice and flexible, but running a tight loop like this is 
> just painful. I suspect filter-branch in something like perl would be a 
> lot faster and just as flexible (you could even do it in C, but you'd 
> probably have to invent a little domain-specific scripting language).

I hoped that the rewrite-commits attempt was more than just that: an 
attempt.  So there is a point you could start from, doing things in C.

But I doubt that you get any joy: either your language is too limited, or 
you will get the same problems (fork() overhead) again.

> Anyway, here is the patch. I don't know if it is even worth applying, 
> since it is still painfully slow.

I like your patch:

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho
