Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9F471FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 19:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbcFWTES (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 15:04:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:59276 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751355AbcFWTER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 15:04:17 -0400
Received: (qmail 1300 invoked by uid 102); 23 Jun 2016 19:04:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 15:04:17 -0400
Received: (qmail 13830 invoked by uid 107); 23 Jun 2016 19:04:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 15:04:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 15:04:14 -0400
Date:	Thu, 23 Jun 2016 15:04:14 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Simon Courtois <scourtois@cubyx.fr>
Subject: Re: [PATCH v2 7/7] color: support strike-through attribute
Message-ID: <20160623190414.GA568@sigill.intra.peff.net>
References: <20160623173048.GA19923@sigill.intra.peff.net>
 <20160623174015.GG15774@sigill.intra.peff.net>
 <xmqqpor7iwgo.fsf@gitster.mtv.corp.google.com>
 <20160623183907.GA32368@sigill.intra.peff.net>
 <xmqqlh1vivp8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlh1vivp8.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 11:52:51AM -0700, Junio C Hamano wrote:

> >> It indeed is fun and it even makes sense in this context:
> >> 
> >>     $ ./git -c diff.color.old='red strike' show
> >
> > Ooh, I hadn't thought of that. It's a bit noisy for my tastes in a
> > line-oriented diff, but with --color-words, it actually helps quite a
> > bit (try it on the documentation patch from this series, for example).
> 
> What I usually use is diff.color.old='red reverse' because I cannot
> easily tell between black and dark red in small font on my white
> background.  s/reverse/strike/ makes it much less noisy.

You may find "bold red" a little easier, as it often uses a brighter
variant.  We also support 8-bit and 24-bit color these days. So you can
probably do something like diff.color.old='#ff0000'. That's all old,
though, so I imagine you might have played with it long ago.

I have a black background myself, and save "reverse" for diff-highlight.

> What is sad for me is that I usually work in GNU screen, displaying on
> either xterm or gnome-terminal.  Without screen, strike shows but
> inside it I cannot seem to be able to get strike-thru in effect.

Hmm. I see the same thing screen and with tmux, as well (though I don't
usually use either myself). I suspect they have to filter ANSI codes
because they're using the codes themselves (so anything that moves the
cursor is going to be a definite problem), and strike-through probably
just isn't common enough to have been added to the whitelist.

It does work with dtach, but that is probably because that program only
does the remote-socket parts of screen/tmux, and so wouldn't need any
filtering at all.

-Peff
