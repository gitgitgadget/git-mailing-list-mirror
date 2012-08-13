From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] fetch-pack: mention server version with verbose
 output
Date: Mon, 13 Aug 2012 17:11:10 -0400
Message-ID: <20120813211109.GA32688@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
 <7v393uif9g.fsf@alter.siamese.dyndns.org>
 <7vboieehrf.fsf@alter.siamese.dyndns.org>
 <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org>
 <20120813205423.GA31630@sigill.intra.peff.net>
 <7v628mcxdf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:11:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T11uw-0003in-Rp
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 23:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab2HMVLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 17:11:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36550 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545Ab2HMVLM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 17:11:12 -0400
Received: (qmail 30740 invoked by uid 107); 13 Aug 2012 21:11:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Aug 2012 17:11:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2012 17:11:10 -0400
Content-Disposition: inline
In-Reply-To: <7v628mcxdf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203368>

On Mon, Aug 13, 2012 at 02:09:32PM -0700, Junio C Hamano wrote:

> >> +	if ((agent_feature = server_feature("agent", &agent_len)) != NULL &&
> >> +	    5 < agent_len && agent_feature[5] == '=') {
> >>  		agent_supported = 1;
> >> +		if (args.verbose) {
> >> +			fprintf(stderr, "Server version is %.*s\n",
> >> +				agent_len - 6, agent_feature + 6);
> >> +		}
> >> +	}
> >
> > Yeah, this is exactly the kind of ugliness I was trying to avoid with my
> > allocating wrapper. Still, there is only one call site, so I do not care
> > overly much (and I as I've already said, I'm lukewarm on the final two
> > patches, anyway).
> 
> Actually, the above is vastly superiour compared to the allocating
> kind.  Be honest and think about it.  If the caller wants to
> allocate, it could, and it does not even have to count.  If the
> caller does not want to allocate, it does not have to pay the price.

My point is that the run-time allocation price is quite small, but the
readability cost of that ugly conditional with the magic "5" is
non-trivial. But they are apples and oranges, so it is hard to compare
their amounts directly.

-Peff
