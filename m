Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32D720248
	for <e@80x24.org>; Mon, 18 Mar 2019 23:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCRXme (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 19:42:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:55736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726326AbfCRXme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 19:42:34 -0400
Received: (qmail 17286 invoked by uid 109); 18 Mar 2019 23:42:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 23:42:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24870 invoked by uid 111); 18 Mar 2019 23:42:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 19:42:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 19:42:32 -0400
Date:   Mon, 18 Mar 2019 19:42:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 3/4] gc docs: de-duplicate "OPTIONS" and "CONFIGURATION"
Message-ID: <20190318234231.GJ29661@sigill.intra.peff.net>
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318161502.7979-4-avarab@gmail.com>
 <20190318214905.GG29661@sigill.intra.peff.net>
 <87ef73er3l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ef73er3l.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 11:48:46PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I know this last sentence came from the existing documentation, but I
> > wonder if we should be more vague here. We'd pack with "repack -dl" when
> > we have just loose objects, and "repack -Adl" when we have too many
> > packs. Or "repack -adl" if we're pruning now, and "--unpack-unreachable"
> > otherwise.
> >
> > I think the point of git-gc is that you don't have to care about that
> > stuff. It works magically, and if you are implementing your own custom
> > gc scheme, then you are probably better off reading the output of
> > GIT_TRACE or looking at the source, rather than this documentation.
> 
> Yeah I can just drop it while I'm at it. Was just losslessly trying to
> port the existing docs.

Yeah, I'm sympathetic to that (if you did drop it, you might have gotten
the opposite review). ;) I think it would be OK to just mention it in
the commit message, but I'd also be OK dropping it in a preliminary
patch.

> >>  	marked with `*.keep` file in the repository, `git gc
> >>  	--auto` consolidates them into one larger pack.  The
> >> -	default	value is 50.  Setting this to 0 disables it.
> >> +	default value is 50.  Setting this (or `gc.auto`) to 0
> >> +	disables it. Packs will be consolidated using the `-A` option
> >> +	of `git repack`.
> >
> > If we do revise the "-d -l" bit for the loose limit, we'd probably want
> > to adjust this to match.
> 
> Or not mention it either?

Yes. :)

> > I'm not sure how to read this "or". What's the difference between "0" or
> > the memory heuristic, and when is one used? Or is that what the "if the
> > number of kept packs is more than..." below is trying to say?
> 
> That by default we don't use gc.bigPackThreshold, unless we find that
> you're under memory pressure. I.e. "it's off by default, unless your
> system has too little memory".

OK, I see. It might make sense to write that out more explicitly.

-Peff
