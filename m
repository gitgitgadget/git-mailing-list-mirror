Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215651F404
	for <e@80x24.org>; Thu, 15 Feb 2018 16:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423807AbeBOQxD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 11:53:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:54056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1426468AbeBOQwV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 11:52:21 -0500
Received: (qmail 4275 invoked by uid 109); 15 Feb 2018 16:52:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 16:52:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11871 invoked by uid 111); 15 Feb 2018 16:53:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 11:53:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 11:52:18 -0500
Date:   Thu, 15 Feb 2018 11:52:18 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] t6300-for-each-ref: fix "more than one quoting style"
 tests
Message-ID: <20180215165218.GA7635@sigill.intra.peff.net>
References: <20180213003601.7396-1-szeder.dev@gmail.com>
 <20180213222247.GA18401@sigill.intra.peff.net>
 <CAM0VKj=YPkS=YLtEz93RWS2=cvyy6LcyrBsCyBCg14ihxuKzjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=YPkS=YLtEz93RWS2=cvyy6LcyrBsCyBCg14ihxuKzjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 05:39:28PM +0100, SZEDER Gábor wrote:

> On Tue, Feb 13, 2018 at 11:22 PM, Jeff King <peff@peff.net> wrote:
> 
> >>  for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
> >>       test_expect_success "more than one quoting style: $i" "
> >> -             git for-each-ref $i 2>&1 | (read line &&
> >> -             case \$line in
> >> -             \"error: more than one quoting style\"*) : happy;;
> >> -             *) false
> >> -             esac)
> >> +             test_must_fail git for-each-ref $i 2>err &&
> >> +             grep '^error: more than one quoting style' err
> >
> > I suspect in the long run this ought to be test_i18ngrep, but since it's
> > not localized yet, it makes sense to stop here with this patch.
> 
> I thought 'git for-each-ref' is plumbing and that means that it
> shouldn't be localized.

I always assumed stderr was mostly fair game, even for plumbing. At any
rate, I'm willing to ignore the issue until somebody actually proposes a
patch to translate it.

-Peff
