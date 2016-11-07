Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09D7E2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 17:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932705AbcKGR0V (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 12:26:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:39686 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932314AbcKGR0U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 12:26:20 -0500
Received: (qmail 30421 invoked by uid 109); 7 Nov 2016 17:26:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 17:26:19 +0000
Received: (qmail 13552 invoked by uid 111); 7 Nov 2016 17:26:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 12:26:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2016 12:26:17 -0500
Date:   Mon, 7 Nov 2016 12:26:17 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, tboegi@web.de, gitster@pobox.com
Subject: Re: [PATCH v1 1/2] config.mak.in: set NO_OPENSSL and
 APPLE_COMMON_CRYPTO for macOS >10.11
Message-ID: <20161107172617.tlcrpwbjy2w7aoyc@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-2-larsxschneider@gmail.com>
 <20161017095002.bbqyp2hkbuyau66t@sigill.intra.peff.net>
 <8C67FF53-C26F-4993-908F-A5183C5E48D9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8C67FF53-C26F-4993-908F-A5183C5E48D9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 06, 2016 at 08:35:04PM +0100, Lars Schneider wrote:

> Good point. I think I found an even easier way to achieve the same.
> What do you think about the patch below?
>
> [...]
>
> diff --git a/Makefile b/Makefile
> index 9d6c245..f53fcc9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1047,6 +1047,7 @@ ifeq ($(uname_S),Darwin)
>  		endif
>  	endif
>  	ifndef NO_APPLE_COMMON_CRYPTO
> +		NO_OPENSSL = YesPlease
>  		APPLE_COMMON_CRYPTO = YesPlease
>  		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
>  	endif

That is much simpler.

I have in the back of my mind a fear that it is harder to unset a make
variable than it is to override it with a new value (which is what you'd
want to do here to turn openssl back on), but I can't seem to come up
with a case that doesn't work. So I am probably misremembering, or just
thinking of something that used to be a problem long ago.

-Peff
