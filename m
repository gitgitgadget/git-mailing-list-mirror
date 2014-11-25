From: Jeff King <peff@peff.net>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Tue, 25 Nov 2014 00:01:01 -0500
Message-ID: <20141125050101.GA20805@peff.net>
References: <6997784.RuzRO1AFsK@al>
 <1660121.8PEbpzfRYH@al>
 <20141124225457.GA9942@peff.net>
 <283403992.8FOSVk7RPR@al>
 <20141125040826.GC19301@peff.net>
 <xmqqy4qzubf2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Wu <peter@lekensteyn.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 06:01:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt8FT-0002ez-Kf
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 06:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbaKYFBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 00:01:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:44639 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751886AbaKYFBE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 00:01:04 -0500
Received: (qmail 30587 invoked by uid 102); 25 Nov 2014 05:01:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 23:01:04 -0600
Received: (qmail 26806 invoked by uid 107); 25 Nov 2014 05:01:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 00:01:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2014 00:01:01 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy4qzubf2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260193>

On Mon, Nov 24, 2014 at 08:55:13PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > However, I think what removed the confusion for me in your --only=both
> > proposal was the presence of a "both" option, since it made it more
> > clear that is not what no-option means. So what about just "--push",
> > "--fetch", and "--both"?
> 
> I think that is the set that is most sensible, at least
> syntactically, among the ones I heard so far in this thread.
> 
> However, one thing still makes me wonder....
> 
> After doing "set-url --fetch" and nothing else, because the user
> never said "--both" or "--push", does the user get a configuration
> where "git push" fails?  Or does "set-url --fetch" still gives us
> remote.nick.url and causes "git push" to also go there?

I think the latter. And that makes sense to me. Push falls back to fetch
at runtime. And you never set a push url, so that's what happens.

But it is not symmetric. We do not fall back fetch to push. We _could_,
but that is a separate issue (one for git-fetch, and not git-remote).
And I do not think it is one anybody is particularly asking for.

We could also stop making push fall back to fetch. But I think people
would find that irritating.

I dunno. I think there has always been an implicit "subordinate"
relationship between fetch and push URLs, with fetch being the "main"
one. Maybe that is so ingrained in me at this point that I do not see a
problem with the asymmetry.

-Peff
