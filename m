From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Newton-Raphson, was Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 02:43:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907240241430.8306@pacific.mpi-cbg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221959330.21520@localhost.localdomain> <alpine.LFD.2.01.0907222009340.21520@localhost.localdomain> <alpine.LSU.2.00.0907231846190.30197@hermes-2.csi.cam.ac.uk> <alpine.LFD.2.01.0907231153010.21520@localhost.localdomain>
 <alpine.LSU.2.00.0907232310220.22113@hermes-2.csi.cam.ac.uk> <alpine.DEB.1.00.0907240114410.8306@pacific.mpi-cbg.de> <alpine.LSU.2.00.0907240031470.12180@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Fri Jul 24 02:44:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU8tO-0004Ia-7B
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 02:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbZGXAoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 20:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbZGXAoA
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 20:44:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:41448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751002AbZGXAn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 20:43:59 -0400
Received: (qmail invoked by alias); 24 Jul 2009 00:43:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 24 Jul 2009 02:43:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lUTZThSClPUHQR1DU6rJbJ9f7iKrmVbHWrweSfK
	nYLW+3GMzeoXsJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LSU.2.00.0907240031470.12180@hermes-2.csi.cam.ac.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123898>

Hi,

On Fri, 24 Jul 2009, Tony Finch wrote:

> On Fri, 24 Jul 2009, Johannes Schindelin wrote:
> >
> > Think about it, absent any further information than "it is a hash, i.e.
> > distributed pretty equally in _any_ byte", even subsets of a sorted list
> > will me more or less linear.  And assuming that they are linear is _still_
> > your best bet.
> 
> The even distribution of the lower-order bytes is irrelevant.

I was not talking about lower-order bytes.  All bytes are pretty much 
evenly distributed.  That's why SHA-1 is a good hash.

> We're looking at the top 20-ish bits for a pack with a million-ish 
> objects. The more you zoom in the less linear a sorted list of hashes 
> will be, so assuming linearity at all scales is wrong. It's a bit like 
> fractal mountains.

If you really find irregularities like that, then SHA-1 is really a lousy 
hash.  Irregularities like this are typically exploitable.

If you know of such an irregularity, you might want to write a paper that 
SHA-1 is broken and get famous.

> > There is no way to achieve [O(1) seeks], best thing you can hope for 
> > is _expected_ O(1) (e.g. with a hashmap, with exponential worst case).
> 
> Of course it's expected. However the worst case is nowhere near
> exponential: it's linear because the second-order search is a linear
> pagewise scan. But I think in practice, the larger the pack the more that
> the randomization of the hash function will smooth out performance
> oddities. (Sorry, I don't know enough statistics to be able to say what
> the expected error of the linear interpolation is, though I expect it's a
> fairly simple formula.) For small packs the number of seeks is 1 anyway.

I will believe it when I see it.

Ciao,
Dscho
