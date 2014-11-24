From: Jeff King <peff@peff.net>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Mon, 24 Nov 2014 17:54:57 -0500
Message-ID: <20141124225457.GA9942@peff.net>
References: <6997784.RuzRO1AFsK@al>
 <27811375.1kgEM3BV3q@al>
 <20141124222243.GA9055@peff.net>
 <1660121.8PEbpzfRYH@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Mon Nov 24 23:55:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt2X9-00081p-3y
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 23:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbaKXWy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 17:54:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:44418 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750784AbaKXWy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 17:54:58 -0500
Received: (qmail 14878 invoked by uid 102); 24 Nov 2014 22:54:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 16:54:58 -0600
Received: (qmail 23119 invoked by uid 107); 24 Nov 2014 22:54:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 17:54:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 17:54:57 -0500
Content-Disposition: inline
In-Reply-To: <1660121.8PEbpzfRYH@al>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260163>

On Mon, Nov 24, 2014 at 11:47:30PM +0100, Peter Wu wrote:

> > Right. My original complaint was only that "--fetch" is not as
> > orthogonal to "--push" (and an optionless set-url) as it could be. I
> > think the alternatives for going forward are basically:
> > 
> >   1. Name it something besides --fetch (but that's rather clunky).
> 
> It is not orthogonal to --push in the config, but the behavior exposed
> to the user is orthogonal unless I am missing something?

My complaint is that you have three possible options to provide: --push,
--fetch, or no option at all. And "--fetch" sometimes behaves like no
option, and sometimes not. Which is the confusing/non-orthogonal part.

> I can understand that --fetch sounds a bit weird, what about this
> natural translation:
> 
>     "git remote: set the URL (only the fetch one) for NAME to URL"
>     git remote set-url --only=fetch NAME URL
> 
>     "git remote: set the URL (only the push one) for NAME to URL"
>     git remote set-url --only=push NAME URL
>     (obsoletes --push)
> 
>     "git remote: set the URL (both) for NAME to URL"
>     git remote set-url --only=both NAME URL
>     (it would be nice if --only=both (weird!) can be removed in the
>     future such that the option is more natural)
> 
>     "git remote: set the URL for NAME to URL"
>     git remote set-url NAME URL
>     (current behavior: YOU git guru knows what I do right?)

Yeah, I think that addresses my concern (because it explicitly leaves
no-option as a historical curiosity, and not as an implicit version of
"--both").

> >   3. Live with it. Probably address the weirdness in the documentation.
> > 
> >   4. Do nothing, drop the patch.
> > 
> > I think I'd be OK with (3), with an appropriate documentation update.
> 
> I prefer 1 for now as it avoids the extra manual action I have to take
> when changing URLs.

I'm not sure if I was clear on (3), but "live with it" was "live with
your original patch". Which I think you would also be happy with.

-Peff
