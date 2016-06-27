Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29782018A
	for <e@80x24.org>; Mon, 27 Jun 2016 19:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbcF0TEZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:04:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:33588 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751832AbcF0TEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 15:04:25 -0400
Received: (qmail 2913 invoked by uid 102); 27 Jun 2016 19:04:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:04:24 -0400
Received: (qmail 12400 invoked by uid 107); 27 Jun 2016 19:04:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:04:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 15:04:22 -0400
Date:	Mon, 27 Jun 2016 15:04:22 -0400
From:	Jeff King <peff@peff.net>
To:	Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:	gitster@pobox.com, git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/6] doc: typeset long command-line options as literal
Message-ID: <20160627190422.GC9594@sigill.intra.peff.net>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
 <20160627174623.11084-2-Matthieu.Moy@imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160627174623.11084-2-Matthieu.Moy@imag.fr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 07:46:19PM +0200, Matthieu Moy wrote:

> Similarly to the previous commit, use backquotes instead of
> forward-quotes, for long options.
> 
> This was obtained with:
> 
>   perl -pi -e "s/'(--[a-z][a-z=<>-]*)'/\`\$1\`/g" *.txt
> 
> and manual tweak to remove false positive in ascii-art (o'--o'--o' to
> describe rewritten history).

These mostly looked good, but:

>  grep.extendedRegexp::
> -	If set to true, enable '--extended-regexp' option by default. This
> -	option is ignored when the `grep.patternType` option is set to a value
> +	If set to true, enable `--extended-regexp` option by default. This
> +	option is ignored when the 'grep.patternType' option is set to a value

What's going on in the second line here? We remove the backticks from
grep.patternType (which is not even a thing that should be touched by
your pattern).

> @@ -1916,7 +1916,7 @@ log.decorate::
>  	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
>  	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
>  	specified, the full ref name (including prefix) will be printed.
> -	This is the same as the log commands '--decorate' option.
> +	This is the same as the log commands `--decorate` option.

This one conflicts applying on top of master, but the resolution is
fairly straightforward.

-Peff
