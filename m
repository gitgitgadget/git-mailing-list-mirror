Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C0A20958
	for <e@80x24.org>; Thu, 30 Mar 2017 03:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbdC3D3K (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 23:29:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:53960 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932365AbdC3D3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 23:29:09 -0400
Received: (qmail 2208 invoked by uid 109); 30 Mar 2017 03:29:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 03:29:01 +0000
Received: (qmail 28282 invoked by uid 111); 30 Mar 2017 03:29:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 23:29:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Mar 2017 23:28:58 -0400
Date:   Wed, 29 Mar 2017 23:28:58 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        David Turner <dturner@twopensource.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 04/11] update-index: add untracked cache notifications
Message-ID: <20170330032858.rdklpoipmvwjov4d@sigill.intra.peff.net>
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
 <1453877887-11586-5-git-send-email-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1453877887-11586-5-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2016 at 07:58:00AM +0100, Christian Couder wrote:

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 62222dd..369c207 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -130,7 +130,7 @@ static int test_if_untracked_cache_is_supported(void)
>  	if (!mkdtemp(mtime_dir.buf))
>  		die_errno("Could not make temporary directory");
>  
> -	fprintf(stderr, _("Testing "));
> +	fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());

Coverity points out that this is a leak (xgetcwd returns an allocated
buffer).

-Peff
