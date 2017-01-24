Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB9C1F437
	for <e@80x24.org>; Tue, 24 Jan 2017 20:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750797AbdAXUOT (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 15:14:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:44029 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdAXUOS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 15:14:18 -0500
Received: (qmail 1593 invoked by uid 109); 24 Jan 2017 20:14:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 20:14:18 +0000
Received: (qmail 4780 invoked by uid 111); 24 Jan 2017 20:14:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 15:14:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2017 15:14:15 -0500
Date:   Tue, 24 Jan 2017 15:14:15 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Documentation/stash: remove mention of git reset
 --hard
Message-ID: <20170124201415.zzyg4vt35vflwjnb@sigill.intra.peff.net>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170121200804.19009-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170121200804.19009-2-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2017 at 08:08:02PM +0000, Thomas Gummerer wrote:

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 2e9cef06e6..0ad5335a3e 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -47,8 +47,9 @@ OPTIONS
>  
>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>  
> -	Save your local modifications to a new 'stash', and run `git reset
> -	--hard` to revert them.  The <message> part is optional and gives
> +	Save your local modifications to a new 'stash', and revert the
> +	the changes in the working tree to match the index.
> +	The <message> part is optional and gives

Hrm. "git reset --hard" doesn't just make the working tree match the
index. It also resets the index to HEAD.  So either the original or your
new description is wrong.

I think it's the latter. We really do reset the index unless
--keep-index is specified.

I also wondered if it was worth avoiding the word "revert", as "git
revert" has a much different meaning (as opposed to "svn revert", which
does what you're talking about here). But I see that "git add -i"
already uses the word revert in this way (and there are probably
others).

So it may not be worth worrying about, but "set" or "reset" probably
serves the same purpose.

-Peff
