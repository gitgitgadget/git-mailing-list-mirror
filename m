Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C311FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 19:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbdBNTxN (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 14:53:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:55255 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdBNTxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 14:53:13 -0500
Received: (qmail 15988 invoked by uid 109); 14 Feb 2017 19:53:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 19:53:13 +0000
Received: (qmail 6037 invoked by uid 111); 14 Feb 2017 19:53:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 14:53:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 14:53:10 -0500
Date:   Tue, 14 Feb 2017 14:53:10 -0500
From:   Jeff King <peff@peff.net>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] show-branch: use skip_prefix to drop magic numbers
Message-ID: <20170214195310.hlfke5vks6pnzmma@sigill.intra.peff.net>
References: <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
 <20170214172829.6w3cnnqy6ozxl424@sigill.intra.peff.net>
 <CAFZEwPOYGRGd5PWSfLRd6vMs35TT1ZzUSfr79fwRA4VzVjAWXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFZEwPOYGRGd5PWSfLRd6vMs35TT1ZzUSfr79fwRA4VzVjAWXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 12:23:52AM +0530, Pranit Bauva wrote:

> Did you purposely miss the one in line number 278 of
> builtin/show-branch.c because I think you only touched up the parts
> which were related to "refs/" but didn't explicitly mention it in the
> commit message?
> 
>     if (starts_with(pretty_str, "[PATCH] "))
>         pretty_str += 8;

Not purposely. I was just fixing up the bits that I had noticed in the
earlier patches.

> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index c03d3ec7c..19756595d 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -275,8 +275,7 @@ static void show_one_commit(struct commit *commit, int no_name)
>  		pp_commit_easy(CMIT_FMT_ONELINE, commit, &pretty);
>  		pretty_str = pretty.buf;
>  	}
> -	if (starts_with(pretty_str, "[PATCH] "))
> -		pretty_str += 8;
> +	skip_prefix(pretty_str, "[PATCH] ", &pretty_str);

Yeah, I agree this the same type of fix and is worth including. Thanks!

-Peff
