From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-log segfault on 00 graft
Date: Wed, 5 Mar 2008 13:43:31 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803051335440.4448@racer.site>
References: <Pine.LNX.4.64.0803041954320.7660@fbirervta.pbzchgretzou.qr> <alpine.LSU.1.00.0803041908210.22527@racer.site> <20080305050630.GX8410@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Engelhardt <jengelh@computergmbh.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 13:44:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWsyn-0006EJ-Vd
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 13:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757974AbYCEMnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 07:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757944AbYCEMnk
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 07:43:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:39403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757339AbYCEMni (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 07:43:38 -0500
Received: (qmail invoked by alias); 05 Mar 2008 12:43:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 05 Mar 2008 13:43:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2J94fmL/2m8dDNnzaF8VfAkHnUAKSr9tk2D/5NX
	J7LTwHnFYxJpMU
X-X-Sender: gene099@racer.site
In-Reply-To: <20080305050630.GX8410@spearce.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76213>

Hi,

On Wed, 5 Mar 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 4 Mar 2008, Jan Engelhardt wrote:
> > 
> > > I was playing a bit with grafts, and actually did this:
> > > 
> > >   echo '839affa3313011da783b5b8074a5c9805ee8503a 
> > > 0000000000000000000000000000000000000000' >.git/info/grafts
> > > 
> > > running `git log --topo-order` causes a segfault. Yes, I probably 
> > > "should not be doing that", but I think it at least should not 
> > > segfault.
> > 
> > Well, I agree with the first, but not the latter.  grafts are a really 
> > core and plumbing thing, and if you set it to something nonsensical, I 
> > think you should expect something like a segmentation fault.
> 
> I'm sorry, I don't know where you learned to program Dscho, but my 
> mentors always taught me that user input should be handled with care, 
> and SIGSEGV / SIGBUS / SIGILL is not handling with care!

I agree.

> We tell users to popuate the .git/info/grafts file.  By hand.
> Its user input.  We shouldn't segfault over a malformed entry.

Well, I disagree about the user input.  .git/info/grafts can break tons of 
things, just by _existing_.  So you definitely need to know what you are 
doing.

Just inserting random strings into the grafts file is not an option. It is 
not something that we should take pains to catch... just like a Unix 
system does not prevent "rm -rf /" as root.

So again, I do think that a segmentation fault is not good.  But I 
disagree that you have to go to great lengths to prevent a segmentation 
fault when a user is fiddling with internals without even knowing what 
could happen.

IOW in this case, the _user input_ would have better been crafted with 
care, and it was clearly not.

But as has been pointed out, the segfault has been already fixed (most 
likely by one of Martin's patches), so the discussion about this 
particular problem is moot.

Ciao,
Dscho

