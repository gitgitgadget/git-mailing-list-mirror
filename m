From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Thu, 12 Feb 2009 00:05:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902120002241.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
 <7vprhqnv0c.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de> <20090210165610.GP30949@spearce.org> <7vocxam96s.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902102210140.10279@pacific.mpi-cbg.de>
 <20090211200227.GA27961@coredump.intra.peff.net> <alpine.DEB.1.00.0902112152270.10279@pacific.mpi-cbg.de> <7vljscd695.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 00:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXO9l-0001YN-5A
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 00:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbZBKXEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 18:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755002AbZBKXEq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 18:04:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:46901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752763AbZBKXEp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 18:04:45 -0500
Received: (qmail invoked by alias); 11 Feb 2009 23:04:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 12 Feb 2009 00:04:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19V8hk8cc5VmueOenyo+xWh04+ExDOVMyw+E5SRYt
	gx7ornJK7/8XeZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vljscd695.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109544>

Hi,

On Wed, 11 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Even the merging should not pose any problem at all; we need a custom 
> > merge driver anyway, and there is no reason whatsoever why we should 
> > not just teach the merge driver to remove the slashes before comparing 
> > the filie names.
> 
> Once you start talking about "remove the slashes", you are assuming that 
> the custom merge algorithm must look at *all the paths* in the two trees 
> being merged, and it is a sign that your thinking is so trapped in the 
> inefficient way the current merge-recursive and unpack-trees based merge 
> works, and cannot think about the possibility that there could be more 
> efficient way to do merges.  Not very good.
> 
> If you have a fixed boundary and if most subtrees are the same between 
> two notes during a merge, we can do the same optimization as we do for 
> two input "diff-tree" codepath.  If the top of a subtree matches, we do 
> not even have to look at their subtree.  But that is true only if you do 
> not remove the slashes and allow a random hierarchy.

Well, I think in the case of notes, we have to optimize for random access 
of dozens of blobs rather than for merging.  I was well aware that the 
merging is more expensive when the hierarchy is not defined a priori.

Ciao,
Dscho
