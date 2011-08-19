From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/10] support pager.* for aliases
Date: Thu, 18 Aug 2011 21:40:14 -0700
Message-ID: <20110819044013.GA2163@sigill.intra.peff.net>
References: <20110818215820.GA7767@sigill.intra.peff.net>
 <20110818215909.GA7799@sigill.intra.peff.net>
 <7v8vqq72kp.fsf@alter.siamese.dyndns.org>
 <20110819033733.GB2993@sigill.intra.peff.net>
 <7vliuq5906.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 06:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuGsa-0008Ly-BD
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 06:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab1HSEkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 00:40:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33510
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab1HSEkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 00:40:18 -0400
Received: (qmail 28656 invoked by uid 107); 19 Aug 2011 04:40:57 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Aug 2011 00:40:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2011 21:40:14 -0700
Content-Disposition: inline
In-Reply-To: <7vliuq5906.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179673>

On Thu, Aug 18, 2011 at 09:18:49PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> > Until this patch, doing something like:
> >> >
> >> >   git config alias.foo log
> >> >   git config pager.foo /some/specific/pager
> >> >
> >> > would not respect pager.foo at all.
> >> 
> >> Is it a good thing? Looks too confusing and I am having a hard time to
> >> decide if this is "just because we could" or "because we need to be able
> >> to do this for such and such reasons".
> >
> > I don't have a particular use for it myself. However, I don't see what's
> > confusing about it. Would would you expect the above commands to do with
> > respect to paging?
> 
> The reason I found it confusing was that I expected the "log" command that
> is run as the expansion of the alias to be oblivious to the fact that the
> end user called it "foo", and ignore anything specific to "foo", including
> "pager.foo".

I think of it this way:

If the user thinks of the alias as just another form of "log", then we
do the right thing: we use log's pager config by default, and respect
pager.log. They never set pager.foo, because that is nonsensical in
their mental model.

If the user thinks of the alias as its own command, then they would
expect pager.foo to work. And it does what they expect.

But like I said, I don't personally plan on using this. It was just the
only semantics that really made sense to me, and I noticed it because of
working on externals. And clearly it's not a lot of code.

-Peff
