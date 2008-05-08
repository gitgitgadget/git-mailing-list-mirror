From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 17:31:07 -0400
Message-ID: <20080508213107.GA1016@sigill.intra.peff.net>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de> <48235D99.2040407@nrlssc.navy.mil> <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de> <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net> <48236F69.2060900@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 08 23:35:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDiY-0007au-3D
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYEHVbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYEHVbI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:31:08 -0400
Received: from peff.net ([208.65.91.99]:1333 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbYEHVbG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 17:31:06 -0400
Received: (qmail 25050 invoked by uid 111); 8 May 2008 21:31:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 17:31:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 17:31:07 -0400
Content-Disposition: inline
In-Reply-To: <48236F69.2060900@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81570>

On Thu, May 08, 2008 at 04:23:53PM -0500, Brandon Casey wrote:

> > I thought that -A would eventually put them all into a single pack,
> > killing off the old packs.
> 
> '-a' puts everything in a single pack and kills off old packs. Anything that
> was unreachable is not repacked in the new pack.
> 
> '-A' does the same thing but it also repacks the unreachable objects that were
> previously packed.

Ah, indeed. I hadn't looked closely at the -A behavior before. So yes,
we are never killing off prunable packed objects. Probably we could use
the same solution as "git prune --expire"; perhaps a
"--keep-unreachable=2.weeks.ago"?

-Peff
