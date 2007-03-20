From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Tue, 20 Mar 2007 00:18:43 -0400
Message-ID: <20070320041843.GA29288@spearce.org>
References: <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org> <alpine.LFD.0.83.0703172200060.18328@xanadu.home> <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org> <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org> <Pine.LNX.4.63.0703200400230.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070320032947.GA29145@spearce.org> <20070320034020.GB29145@spearce.org> <Pine.LNX.4.64.0703192052380.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 05:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTVoc-0006YO-V3
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 05:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933973AbXCTES7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 00:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933975AbXCTES7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 00:18:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36293 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933973AbXCTES6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 00:18:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTVo5-0004LI-Ff; Tue, 20 Mar 2007 00:18:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 82A9C20FBAE; Tue, 20 Mar 2007 00:18:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703192052380.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42701>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 19 Mar 2007, Shawn O. Pearce wrote:
> >
> > DrNick suggested on #git to try flipping the isspace test around.
> > This is a smaller change and generated the same ~3.60 seconds run
> > as Dscho's patch.  I like DrNick's version better.  ;-)
> 
> For me, the result seems to be in the noise.
> 
> It may be due to running on Core 2. It's not very sensitive to 
> micro-optimizations like this. It definitely makes sense to test the 
> *stable* test first, since that will help branch prediction (the 
> "isspace()" test is *not* very predictable), so I don't disagree with the 
> patch, but I suspect it depends a lot on the microarchitecture just how 
> much it matters.
> 
> Do you perhaps have a P4? It has a very bad branch mispredict penalty, so 
> putting the predictable branch first could explain the big difference you 
> see..

I tested both patches on a PowerPC G4.  (Apple PowerBook, 1.5 GHz)
Running on Mac OS X 10.4.8.

Might be more of a Linux<->Darwin thing; perhaps my isspace is
significantly slower than yours is...  after all my mmap runs
like a PC from the 1980s...  ;-)

-- 
Shawn.
