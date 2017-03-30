Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA4920958
	for <e@80x24.org>; Thu, 30 Mar 2017 03:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbdC3DMh (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 23:12:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:53938 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753549AbdC3DMh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 23:12:37 -0400
Received: (qmail 1304 invoked by uid 109); 30 Mar 2017 03:12:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 03:12:35 +0000
Received: (qmail 28130 invoked by uid 111); 30 Mar 2017 03:12:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 23:12:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Mar 2017 23:12:32 -0400
Date:   Wed, 29 Mar 2017 23:12:32 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] column: allow for custom printf
Message-ID: <20170330031232.cac2av5v5mk5bz7e@sigill.intra.peff.net>
References: <20170330014238.30032-1-sbeller@google.com>
 <20170330014238.30032-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170330014238.30032-3-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 06:42:37PM -0700, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>

No justification?

I assume it will be used in a future patch.

> diff --git a/column.h b/column.h
> index 0a61917fa7..c44a1525a9 100644
> --- a/column.h
> +++ b/column.h
> @@ -24,6 +24,9 @@ struct column_options {
>  	int padding;
>  	const char *indent;
>  	const char *nl;
> +
> +	/* when non-NULL, use this printing function, fallback to printf */
> +	int (*_printf)(const char *__format, ...);
>  };

Avoid names with leading underscores. They're reserved by the C
standard.

I wonder if gcc is smart enough to let us mark this function pointer
with a "format" attribute so we can get compile-time checking of the
format string.

-Peff
