Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4AA20A93
	for <e@80x24.org>; Mon,  9 Jan 2017 05:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935267AbdAIFev (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 00:34:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:36795 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932110AbdAIFeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 00:34:50 -0500
Received: (qmail 16844 invoked by uid 109); 9 Jan 2017 05:34:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 05:34:49 +0000
Received: (qmail 1050 invoked by uid 111); 9 Jan 2017 05:35:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 00:35:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2017 00:34:46 -0500
Date:   Mon, 9 Jan 2017 00:34:46 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] log --graph: customize the graph lines with config
 log.graphColors
Message-ID: <20170109053446.2vg3y37ck5ahhyxg@sigill.intra.peff.net>
References: <xmqqzijjd34j.fsf@gitster.mtv.corp.google.com>
 <20170108101333.26221-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170108101333.26221-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 08, 2017 at 05:13:33PM +0700, Nguyễn Thái Ngọc Duy wrote:

> If you have a 256 colors terminal (or one with true color support), then
> the predefined 12 colors seem limited. On the other hand, you don't want
> to draw graph lines with every single color in this mode because the two
> colors could look extremely similar. This option allows you to hand pick
> the colors you want.
> 
> Even with standard terminal, if your background color is neither black
> or white, then the graph line may match your background and become
> hidden. You can exclude your background color (or simply the colors you
> hate) with this.

I like this approach much more than the 256-color option.

>  * I'm not going with the cumulative behavior because I think that's
>    just harder to manage colors, and we would need a way to remove
>    colors from the config too.

Yeah, figuring out the list semantics would be a pain. This makes it
hard to exclude a single color, but I think it's more likely somebody
would want to replace the whole set with something that works well
against their background.

> +test_expect_success 'log --graph with merge with log.graphColors' '
> +	test_config log.graphColors " blue , cyan , red " &&

This funny syntax isn't required, right? It should work with the more
natural:

    test_config log.graphColors "blue, cyan, red"

-Peff
