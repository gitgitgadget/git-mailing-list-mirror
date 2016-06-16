Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15DD520179
	for <e@80x24.org>; Thu, 16 Jun 2016 23:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbcFPXkr (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 19:40:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:55983 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754312AbcFPXkq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 19:40:46 -0400
Received: (qmail 12998 invoked by uid 102); 16 Jun 2016 23:40:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 19:40:46 -0400
Received: (qmail 21851 invoked by uid 107); 16 Jun 2016 23:40:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 19:40:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 19:40:43 -0400
Date:	Thu, 16 Jun 2016 19:40:43 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Alex =?utf-8?B?UHJlbmfDqHJl?= <alexprengere@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] add--interactive: respect diff.compactionHeuristic
Message-ID: <20160616234043.GC15013@sigill.intra.peff.net>
References: <CAEtHF9Na7yppEzuutp5=98KjLucgq=7Xv9GPidhaYEuC0oeqQQ@mail.gmail.com>
 <20160614214211.GB21560@sigill.intra.peff.net>
 <xmqq37of8mx4.fsf@gitster.mtv.corp.google.com>
 <CAEtHF9Ne7a25cOF_6L=ZXRnmR4NbnUBDFR+6V-PryjtK8yNO8g@mail.gmail.com>
 <20160616122729.GC15988@sigill.intra.peff.net>
 <CAGZ79kaPVFT=yeSAkmf55+qXcCgMkwpgkC8jXhuZvqj5mWtgLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaPVFT=yeSAkmf55+qXcCgMkwpgkC8jXhuZvqj5mWtgLw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 09:50:45AM -0700, Stefan Beller wrote:

> > -- >8 --
> > Subject: add--interactive: respect diff.compactionHeuristic
> >
> > We use plumbing to generate the diff, so it doesn't
> > automatically pick up UI config like compactionHeuristic.
> > Let's forward it on, since interactive adding is porcelain.
> >
> > Note that we only need to handle the "true" case. There's no
> > point in passing --no-compaction-heuristic when the variable
> > is false, since nothing else could have turned it on.
> 
> because we don't want to implement --[no-]compaction-heuristic
> as a command line switch to git-add?
> Fine with me.

We could, but I don't think it is worth the effort (and anyway, it would
override the config :) ).

> Stepping back and looking how the compaction heuristic turned out,
> I think this is what we did not want to see, i.e. the need to bring it in
> every command, but rather enable and release it. But we backed off
> of the default-on, and now people may ask for the  --no-compaction-heuristic
> in interactive add eventually, when they run into a corner case.

Yeah, I'm not excited to be plumbing it through, especially if we just
end up flipping it on by default. But perhaps people would still want to
be able to do the opposite (turning it off for a specific case via the
config). I dunno.

> For now:
> Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks.

-Peff
