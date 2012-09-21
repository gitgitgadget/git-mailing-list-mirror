From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] receive-pack: send pack-processing stderr over
 sideband
Date: Fri, 21 Sep 2012 13:40:00 -0400
Message-ID: <20120921174000.GA20896@sigill.intra.peff.net>
References: <20120921053057.GA9768@sigill.intra.peff.net>
 <20120921053455.GB9863@sigill.intra.peff.net>
 <7v7grn8gnv.fsf@alter.siamese.dyndns.org>
 <20120921170539.GA19707@sigill.intra.peff.net>
 <7vtxur70fv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:40:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF7D4-0004l8-BI
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 19:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268Ab2IURkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 13:40:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53504 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932122Ab2IURkC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 13:40:02 -0400
Received: (qmail 4499 invoked by uid 107); 21 Sep 2012 17:40:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 13:40:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 13:40:00 -0400
Content-Disposition: inline
In-Reply-To: <7vtxur70fv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206142>

On Fri, Sep 21, 2012 at 10:25:24AM -0700, Junio C Hamano wrote:

> > However, this does make things more consistent with upload-pack, which
> > connects the stderr of pack-objects to sideband (which it must to handle
> > progress). Furthermore, many of the messages from receive-pack are
> > handled by rp_error, which sends to the sideband. So if you were
> > monitoring your git purely by trying to capture stderr, you were already
> > only getting a fraction of the real data.
> 
> The comments were not meant as a rejection notice ;-) Just to see if
> some server operators have input on the matter.

I know.  But your comment made me second-guess a little whether
anybody would be inadvertently hurt, but thinking it through and writing
it out helped convince myself that it's the right thing to do.

One of the hardest parts of working on a mature software project is not
just thinking about what you want to do, but thinking about what
everyone else wants to do (or is doing). So it never hurts to
double-check your assumptions in such a case, and I don't mind working
through these "what ifs" even if they end in us doing the original
thing. I hope you do not mind reading them too much. :)

> I personally do not think tee-ing the error output is worth it; it
> would be reasonably simple to arrange, and the server operators who
> want it can ask later if that is need.

Agreed.

-Peff
