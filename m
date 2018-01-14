Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AE171F406
	for <e@80x24.org>; Sun, 14 Jan 2018 11:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeANLKv (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 06:10:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:43590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751287AbeANLKu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 06:10:50 -0500
Received: (qmail 13040 invoked by uid 109); 14 Jan 2018 11:10:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 14 Jan 2018 11:10:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10988 invoked by uid 111); 14 Jan 2018 11:11:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 14 Jan 2018 06:11:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Jan 2018 06:10:48 -0500
Date:   Sun, 14 Jan 2018 06:10:48 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] travis-ci: build Git during the 'script' phase
Message-ID: <20180114111048.GB13643@sigill.intra.peff.net>
References: <20180108172214.23615-1-szeder.dev@gmail.com>
 <xmqqvagc6m42.fsf@gitster.mtv.corp.google.com>
 <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com>
 <CAM0VKjnSzoc+E408ifKCg+qPTaGRNL3e3JVdRN573kdcBSzbHw@mail.gmail.com>
 <20180113103255.GA31117@sigill.intra.peff.net>
 <20180113105407.GA31825@sigill.intra.peff.net>
 <CAM0VKjkmEThnM7KdQ=SJFGK1E_zdjsCFnFas7fsRG97aQmS52g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkmEThnM7KdQ=SJFGK1E_zdjsCFnFas7fsRG97aQmS52g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 14, 2018 at 11:43:05AM +0100, SZEDER Gábor wrote:

> On Sat, Jan 13, 2018 at 11:54 AM, Jeff King <peff@peff.net> wrote:
> > I think there's also a similar feature to include timings for each fold,
> > which might be worth pursuing.
> 
> If you look for 'travis_time' in the raw log, you'll find lines like
> these:
> 
>   travis_time:start:01ccbe40
>   $ some-command
>   ... and its output ...
>   travis_time:end:01ccbe40:start=1515840453305552968,finish=1515840471960386859,duration=18654833891
> 
> So it seems doable, but we'll have to do the timekeeping ourselves.
> Running 'time $cmd' is much easier, but that time won't be displayed
> next to the folds, of course.
> Do we really care that much?

I don't care that much (and I wasn't actually planning to push the fold
stuff into a patch, but would instead leave it to you people who were
already working on improving the ci script output ;) ).

Apparently there are exportable bash functions for all of this:

  http://www.garbers.co.za/2017/11/01/code-folding-and-timing-in-travis-ci/

but they're not part of the official API. So relying on them may be even
more questionable than relying on the travis_fold syntax.

-Peff
