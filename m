Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5378C1F4C0
	for <e@80x24.org>; Mon, 11 Nov 2019 04:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfKKEJk (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 23:09:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:44128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726756AbfKKEJk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 23:09:40 -0500
Received: (qmail 14927 invoked by uid 109); 11 Nov 2019 04:09:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 04:09:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1549 invoked by uid 111); 11 Nov 2019 04:13:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 10 Nov 2019 23:13:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 10 Nov 2019 23:09:38 -0500
From:   Jeff King <peff@peff.net>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] bundle-verify: add --quiet
Message-ID: <20191111040938.GC6379@sigill.intra.peff.net>
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
 <20191110204126.30553-1-robbat2@gentoo.org>
 <20191110204126.30553-3-robbat2@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191110204126.30553-3-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 10, 2019 at 12:41:26PM -0800, Robin H. Johnson wrote:

> @@ -97,8 +97,11 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
>  static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
>  	struct bundle_header header;
>  	int bundle_fd = -1;
> +	int quiet = 0;
>  
>  	struct option options[] = {
> +		OPT_BOOL('q', "quiet", &quiet,
> +			    N_("do not show bundle details")),
>  		OPT_END()
>  	};

This --quiet makes much more sense to me (compared to the last patch) as
distinct from "--no-progress", because it is about quieting non-progress
chatter.

There's an OPT__QUIET() macro; should we be using that here?

-Peff
