From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Smart fetch via HTTP?
Date: Tue, 15 May 2007 19:29:47 -0400
Message-ID: <20070515232946.GR3141@spearce.org>
References: <20070515201006.GD3653@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 16 01:30:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho6St-0003jK-30
	for gcvg-git@gmane.org; Wed, 16 May 2007 01:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759170AbXEOX3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 19:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759108AbXEOX3x
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 19:29:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35801 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758944AbXEOX3v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 19:29:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Ho6SY-0006B7-Vb; Tue, 15 May 2007 19:29:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B937120FBAE; Tue, 15 May 2007 19:29:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070515201006.GD3653@efreet.light.src>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47390>

Jan Hudec <bulb@ucw.cz> wrote:
> Did anyone already think about fetching over HTTP working similarly to the
> native git protocol?

No work has been done on this (that I know of) but I've discussed
it to some extent with Simon 'corecode' Schubert on #git, and I
think he also brought it up on the mailing list not too long after.

I've certainly thought about adding some sort of pack-objects
frontend into gitweb.cgi for this exact purpose.  It is really
quite easy, except for the negotation of what the client has.  ;-)
 
> Than a question is how to implement it. The current protocol is stateful on
> both sides, but the stateless nature of HTTP more or less requires the
> protocol to be stateless on the server.
> 
> I think it would be possible to use basically the same protocol as now, but
> make it stateless for server. That is server first sends it's heads and than
> client repeatedly sends all it's wants and some haves until the server acks
> all of them and sends the pack.

I think Simon was talking about doubling the number of haves the
client sends in each request.  So the client POSTs initially all
of its current refs; then current refs and their parents; then 4
commits back, then 8, etc.  The server replies to each POST request
with either a "send more please" or the packfile.

-- 
Shawn.
