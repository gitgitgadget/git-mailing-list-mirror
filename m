Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51F0520970
	for <e@80x24.org>; Tue, 11 Apr 2017 14:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbdDKO7W (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 10:59:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:60021 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752506AbdDKO7V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 10:59:21 -0400
Received: (qmail 10426 invoked by uid 109); 11 Apr 2017 14:59:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 14:59:19 +0000
Received: (qmail 2840 invoked by uid 111); 11 Apr 2017 14:59:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:59:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 10:59:17 -0400
Date:   Tue, 11 Apr 2017 10:59:17 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http: honnor empty http.proxy option to bypass proxy
Message-ID: <20170411145917.mjhwfgc5vmgwtx5x@sigill.intra.peff.net>
References: <20170411092050.15867-1-ryazanov.s.a@gmail.com>
 <20170411130659.ehit7jdhnk43m23g@sigill.intra.peff.net>
 <CAHNKnsRxNMS4fYTaoHSRgcTmCr+rcjVOGE1kqJGHqLTgBxdC0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHNKnsRxNMS4fYTaoHSRgcTmCr+rcjVOGE1kqJGHqLTgBxdC0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 05:56:56PM +0300, Sergey Ryazanov wrote:

> > I don't know _what_ "https://" should do. It's clearly bogus. But
> > telling curl to use the defaults seems funny. In that sense, your
> > original was much better (we'd feed it to curl, which would be free to
> > complain).
> >
> 
> I thought about this situation too. IMHO the best solution here is to
> check host after credential_from_url() call. If host is NULL then we
> should show warning message and exit. Then user could fix its
> configuration.
> 
> Since I in any case will send v3 with grammar fixes then I could add
> new patch to the series. This new patch will check host for NULL and
> print warning message. Are you Ok with such solution?

Yeah, I think that would be fine. It pretty clearly seems like an error,
so any behavior that isn't "quietly pretend that there is no proxy" is
probably fine.

-Peff
