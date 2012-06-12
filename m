From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 15:35:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1206121533370.23555@xanadu.home>
References: <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121345500.23555@xanadu.home>
 <20120612175438.GB16522@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121359260.23555@xanadu.home>
 <20120612183702.GD1803@thunk.org>
 <alpine.LFD.2.02.1206121509340.23555@xanadu.home>
 <20120612191929.GA12161@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:35:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWsB-0000ID-1e
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627Ab2FLTfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:35:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15278 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2FLTfW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:35:22 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M5I004SCRQTP6D0@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Jun 2012 15:35:17 -0400 (EDT)
In-reply-to: <20120612191929.GA12161@thunk.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199840>

On Tue, 12 Jun 2012, Ted Ts'o wrote:

> On Tue, Jun 12, 2012 at 03:15:46PM -0400, Nicolas Pitre wrote:
> > > But the old packs are huge; in my case, a full set of packs was around
> > > 16 megabytes.  Right now, git gc *increased* my disk usage by 4.5
> > > megabytes.  If we don't delete the old backs, then git gc would
> > > increase disk usage by 16 megabytes --- which is far, far worse.
> > > 
> > > Writing a 244k cruft pack is a soooooo much preferable.
> > 
> > But as you might have noticed, there are a bunch of semantic problems 
> > with that as well.
> 
> I've proposed something (explicitly labelled cruft packs) which is no
> worse than before.  The one potential problem is that objects in the
> cruft pack might have their lifespan extended by two weeks (or
> whatever the expire timeout might be), but Peff has agreed that it's
> simple enough to ignore that, since the benefits far outweigh the
> potential that some objects in cruft packs will get to live a bit
> longer.
> 
> The race condition you've pointed out exists today, with the git prune
> racing against the git fetch.

Yes, however that race is trivial to fix when loose objects are used.


Nicolas
