Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2DED20958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755585AbdCUBvp (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:51:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:48338 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754656AbdCUBvp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:51:45 -0400
Received: (qmail 12581 invoked by uid 109); 21 Mar 2017 01:51:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:51:13 +0000
Received: (qmail 10079 invoked by uid 111); 21 Mar 2017 01:51:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:51:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:51:08 -0400
Date:   Mon, 20 Mar 2017 21:51:08 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] t1400: use test_path_is_* helpers
Message-ID: <20170321015108.h62cba36qrxtxpj7@sigill.intra.peff.net>
References: <20170321005616.31324-1-kyle@kyleam.com>
 <20170321005616.31324-4-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321005616.31324-4-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 08:56:14PM -0400, Kyle Meyer wrote:

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index be8b113b1..c5c8e95fc 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -49,7 +49,7 @@ test_expect_success "fail to delete $m with stale ref" '
>  '
>  test_expect_success "delete $m" '
>  	git update-ref -d $m $B &&
> -	! test -f .git/$m
> +	test_path_is_missing .git/$m
>  '

I think this is an improvement for now. I suspect that all of these will
have to become "test_must_fail git rev-parse --verify $m" in the long
run, when we want to run the test suite against an alternate ref
backend. That can wait, though.

-Peff
