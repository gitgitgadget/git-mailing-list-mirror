From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 05/10] pkt-line: rename s/packet_read_line/packet_read/
Date: Mon, 18 Feb 2013 05:29:31 -0500
Message-ID: <20130218102931.GP5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092252.GE5096@sigill.intra.peff.net>
 <20130218101915.GE7049@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Nyx-0002an-Q2
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab3BRK3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:29:34 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51785 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab3BRK3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:29:33 -0500
Received: (qmail 18473 invoked by uid 107); 18 Feb 2013 10:31:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 05:31:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 05:29:31 -0500
Content-Disposition: inline
In-Reply-To: <20130218101915.GE7049@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216471>

On Mon, Feb 18, 2013 at 02:19:15AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Originally packets were used just for the line-oriented ref
> > advertisement and negotiation. These days, we also stuff
> > packfiles and sidebands into them, and they do not
> > necessarily represent a line. Drop the "_line" suffix, as it
> > is not informative and makes the function names quite long
> > (especially as we add "_gently" and other variants).
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Again, this is a taste issue. Can be optional.
> 
> In combination with patch 3, this changes the meaning of packet_read()
> without changing its signature, which could make other patches
> cherry-picked on top change behavior in unpredictable ways. :(
> 
> So I'd be all for this if the signature changes (for example to put
> the fd at the end or something), but not so if not.

True. Though packet_read has only existed since last June, only had one
callsite (which would now conflict, since I'm touching it in this
series), and has no new calls in origin..origin/pu. So it's relatively
low risk for such a problem. I don't know how careful we want to be.

-Peff
