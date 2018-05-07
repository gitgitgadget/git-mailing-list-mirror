Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B67991F42E
	for <e@80x24.org>; Mon,  7 May 2018 07:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeEGHhj (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 03:37:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:58416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750716AbeEGHhj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 03:37:39 -0400
Received: (qmail 30038 invoked by uid 109); 7 May 2018 07:37:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 May 2018 07:37:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24344 invoked by uid 111); 7 May 2018 07:37:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 May 2018 03:37:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2018 03:37:37 -0400
Date:   Mon, 7 May 2018 03:37:37 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 13/18] color: provide inverted colors, too
Message-ID: <20180507073736.GA31170@sigill.intra.peff.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <1ebbe359547689d32aa27564929d733a26bb8054.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182922.GD17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805060001230.77@tvgsbejvaqbjf.bet>
 <20180506063543.GA3418@sigill.intra.peff.net>
 <20180506064104.GB3418@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805062119051.77@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1805062119051.77@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 06, 2018 at 09:20:46PM -0400, Johannes Schindelin wrote:

> > Heh, of course you knew that already, as I just noticed your patch is
> > using the reverse attribute internally (I had thought at first glance
> > you were just specifying the background independently).
> > 
> > So really, I guess all I am arguing for is having GIT_COLOR_INV (or
> > REVERSE) as a constant, and then teaching the code to combine it with
> > the existing "new" color. It's perfectly OK to have:
> > 
> >   \x1b[7m\x1b[36m
> > 
> > instead of:
> > 
> >   \x1b[7;36m
> > 
> > It's two extra bytes, but I doubt anybody cares.
> 
> Yep, I agree that it is a small price to pay for the benefit of simply
> using the reverse of diff.color.old (and .new).
> 
> While at it, I also changed the hunk header colors: they are *also* simply
> the same ones, with the outer one having background and foreground
> reversed.

That sound sane.

If we ever did want to care about the number of bytes we output, I
suspect we could "compress" our ANSI terminal outputs by collapsing
adjacent colors into a single one. But IMHO it's not even worth worrying
about that optimization at this point.

-Peff
