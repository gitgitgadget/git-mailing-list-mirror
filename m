Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5AE1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 16:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755460AbdLTQdE (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 11:33:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:44232 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751672AbdLTQdD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 11:33:03 -0500
Received: (qmail 23113 invoked by uid 109); 20 Dec 2017 16:33:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Dec 2017 16:33:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14333 invoked by uid 111); 20 Dec 2017 16:33:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 20 Dec 2017 11:33:29 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec 2017 11:33:01 -0500
Date:   Wed, 20 Dec 2017 11:33:01 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 4/4] status: support --no-ahead-behind in long status
 format.
Message-ID: <20171220163301.GD31149@sigill.intra.peff.net>
References: <20171220144245.39401-1-git@jeffhostetler.com>
 <20171220144245.39401-5-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171220144245.39401-5-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 02:42:45PM +0000, Jeff Hostetler wrote:

> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index ea029ad..9a2f209 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -120,6 +120,9 @@ configuration variable documented in linkgit:git-config[1].
>  +
>  	In short format with --branch, '[different]' will printed rather
>  	than detailed ahead/behind counts.
> ++
> +	In long (normal) format, a simple out of date message will be
> +	printed rather than detailed ahead/behind counts.

Same asciidoc trickery here as in the first patch (and in the --short
one, too, but I forgot to mention it).

> +	} else if (no_ahead_behind) {
> +		strbuf_addf(sb, _("Your branch is out of date with '%s'.\n"),
> +			    base);
> +
> +		/* TODO Do we need a generic hint here? */
> +

I'm not sure what we'd advise here. I'd consider:

  git log --oneline --graph HEAD..@{upstream}

to see the actual differences, but that's a bit verbose. Is there an
easy way to re-enable it? I guess repeating the command with
"--ahead-behind" should do so.

-Peff
