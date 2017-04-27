Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2635C207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 09:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938506AbdD0JEc (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 05:04:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:41155 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933115AbdD0JEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 05:04:31 -0400
Received: (qmail 5784 invoked by uid 109); 27 Apr 2017 09:04:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 09:04:26 +0000
Received: (qmail 8361 invoked by uid 111); 27 Apr 2017 09:04:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 05:04:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 05:04:24 -0400
Date:   Thu, 27 Apr 2017 05:04:24 -0400
From:   Jeff King <peff@peff.net>
To:     Stephen Kent <smkent@smkent.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] status: add color config slots for branch info in
 "--short --branch"
Message-ID: <20170427090423.amjqi7ca4xl7pzax@sigill.intra.peff.net>
References: <201704939828871.4296cfa6a746a5004d28db265800a@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201704939828871.4296cfa6a746a5004d28db265800a@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 10:42:02PM -0700, Stephen Kent wrote:

> Add color config slots to be used in the status short-format when
> displaying local and remote tracking branch information.
> 
> Signed-off-by: Stephen Kent <smkent@smkent.net>

This looks good to me, and I'd be happy if we took it as-is.

But...

> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index fb00e6d..7d42085 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -610,7 +610,8 @@ test_expect_success 'status --porcelain ignores relative paths setting' '
>  test_expect_success 'setup unique colors' '
>  
>  	git config status.color.untracked blue &&
> -	git config status.color.branch green
> +	git config status.color.branch green &&
> +	git config status.color.localBranch yellow
>  
>  '
>  
> @@ -675,7 +676,7 @@ test_expect_success 'status -s with color.status' '
>  '
>  
>  cat >expect <<\EOF
> -## <GREEN>master<RESET>
> +## <YELLOW>master<RESET>

As we discussed elsewhere, it would be nice if this tested remoteBranch,
too. IMHO the simplest thing to is to rebase it on the t7508 update I
just posted.

The other option is to add config for remoteBranch which would do
nothing for now, and then resolve it to check the correct colors when
the two topics are merged (since the test will start failing then).
That seems unnecessarily confusing.

-Peff
