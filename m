Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831901F621
	for <e@80x24.org>; Wed, 27 Jul 2016 20:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929AbcG0UQz (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 16:16:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:50127 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757321AbcG0UQz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 16:16:55 -0400
Received: (qmail 6431 invoked by uid 102); 27 Jul 2016 20:16:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 16:16:55 -0400
Received: (qmail 20689 invoked by uid 107); 27 Jul 2016 20:17:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 16:17:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 16:16:52 -0400
Date:	Wed, 27 Jul 2016 16:16:52 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 5/6] date: document and test "raw-local" mode
Message-ID: <20160727201651.GA26984@sigill.intra.peff.net>
References: <20160722195105.GA19542@sigill.intra.peff.net>
 <20160722195144.GE19648@sigill.intra.peff.net>
 <579343C9.1040902@gmail.com>
 <20160726184746.GA678@sigill.intra.peff.net>
 <5798AA7C.6050107@gmail.com>
 <20160727134441.GB14928@sigill.intra.peff.net>
 <xmqq37mux3mz.fsf@gitster.mtv.corp.google.com>
 <20160727195703.GA8141@sigill.intra.peff.net>
 <xmqqtwfavo21.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwfavo21.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 01:11:34PM -0700, Junio C Hamano wrote:

> -- >8 --
> Subject: [PATCH] date: clarify --date=raw description
> 
> "... in the internal raw Git format `%s %z` format." was clunky in
> repeating "format" twice, and would not have helped those who do not
> know that these are strftime(3) conversion specifiers.
> 
> Explain them with words, and demote the mention of `%s %z` to a
> hint to help those who know them.

Good explanation.

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index fd86ed1..d55e3ae 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -746,7 +746,9 @@ format, often found in email messages.
>  +
>  `--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
>  +
> -`--date=raw` shows the date in the internal raw Git format `%s %z` format.
> +`--date=raw` shows the date as seconds since 1970-01-01 00:00:00 UTC,
> +space, timezone as sign and four digits (i.e. as if the timestamp were
> +formatted with `strftime("%s %z")`).

I do find this by itself a little hard to parse. Maybe:

  `--date=raw` shows the date as seconds since the epoch (1970-01-01
  00:00:00 UTC), followed by a space, and then the timezone as an offset
  from UTC (a `+` or `-` with four digits; the first two are hours, and
  the second two are minutes). I.e., as if the timestamp were formatted
  with `strftime("%s %z")`).

-Peff
