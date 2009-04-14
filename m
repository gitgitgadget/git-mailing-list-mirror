From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 14 Apr 2009 22:30:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904142229280.10279@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.0904052315210.6741@xanadu.home> <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain> <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407142147.GA4413@atjola.homenet> <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
 <20090407181259.GB4413@atjola.homenet> <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:29:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtpFy-0003gI-MS
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 22:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbZDNU1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 16:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbZDNU1k
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 16:27:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:47531 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752302AbZDNU1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 16:27:39 -0400
Received: (qmail invoked by alias); 14 Apr 2009 20:27:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 14 Apr 2009 22:27:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7+nRjrOu7jjR12Vr4f7gDhpJ50OWCNiTSlfM/cE
	cSEl6wy1BaQqpv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116567>

Hi,

On Tue, 14 Apr 2009, Nicolas Pitre wrote:

> On Tue, 14 Apr 2009, Johannes Schindelin wrote:
> 
> > IMO the best we could do under these circumstances [unreliable 
> > network] is to use fsck --lost-found to find those commits which have 
> > a complete history (i.e. no "broken links") -- this probably needs to 
> > be implemented as a special mode of --lost-found -- and store them in 
> > a temporary to-be-removed namespace, say 
> > refs/heads/incomplete-refs/$number, which will be sent to the server 
> > when fetching the next time.  (Might need some iterations to get 
> > everything, though.)
> 
> Well, although this might seem a good idea, this would help only in 
> those cases where there is at least one complete revision available, 
> i.e. no delta needed. This is usually true for the top commit after a 
> repack which objects are all stored at the front of the pack and serve 
> as base objects for deltas from subsequent (older) commits.  Thing is, 
> that first revision is likely to occupy a significant portion of the 
> whole pack, like no less than the size of the equivalent .tar.gz for the 
> content of that commit.  To see what this represents, just try a shallow 
> clone with depth=1.  For the Linux kernel, this is more than 80MB while 
> the whole repo is in the 200MB range.  So if your connection isn't 
> reliable enough to transfer at least that amount then you're screwed 
> anyway.

Good point.

Sorry for not thinking it through,
Dscho
