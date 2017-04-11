Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E64D20970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdDKRh1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:37:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:60142 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751812AbdDKRh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:37:26 -0400
Received: (qmail 22163 invoked by uid 109); 11 Apr 2017 17:37:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 17:37:25 +0000
Received: (qmail 4710 invoked by uid 111); 11 Apr 2017 17:37:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 13:37:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 13:37:22 -0400
Date:   Tue, 11 Apr 2017 13:37:22 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Knut Franke <k.franke@science-computing.de>
Subject: Re: [PATCH v3 2/2] http: fix the silent ignoring of proxy
 misconfiguraion
Message-ID: <20170411173722.asjrkpbbm4p6k6ov@sigill.intra.peff.net>
References: <20170411171750.18624-1-ryazanov.s.a@gmail.com>
 <20170411171750.18624-3-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170411171750.18624-3-ryazanov.s.a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 08:17:50PM +0300, Sergey Ryazanov wrote:

> Earlier, the whole http.proxy option string was passed to curl without
> any preprocessing so curl could complain about the invalid proxy
> configuration.
> 
> After the commit 372370f167 ("http: use credential API to handle proxy
> authentication", 2016-01-26), if the user specified an invalid HTTP
> proxy option in the configuration, then the option parsing is silently
> fails and NULL will be passed to curl as a proxy. This forces curl to

s/is silently/silently/

> fall back to detecting the proxy configuration from the environment,
> causing the http.proxy option ignoring.
> 
> Fix this issue by checking the proxy option parsing result. If parsing
> failed then print error message and die. Such behaviour allows user to
> quickly figure the proxy misconfiguration and correct it.

Two minor grammos:

s/error/an error/;
s/user/the user/;

In the earlier discussion you mentioned a warning, but I like this die()
much better.

Both patches look very clean, and nicely explained. Thanks for working
on this.

-Peff
