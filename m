Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0419C1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfKDTzK (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:55:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:38562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728346AbfKDTzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:55:10 -0500
Received: (qmail 3948 invoked by uid 109); 4 Nov 2019 19:55:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Nov 2019 19:55:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6179 invoked by uid 111); 4 Nov 2019 19:58:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2019 14:58:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Nov 2019 14:55:08 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: add dots directly to strbuf in perf_fmt_prepare()
Message-ID: <20191104195508.GB20900@sigill.intra.peff.net>
References: <c4237b45-6faf-c1fc-eb13-b6c71b7fb6ef@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4237b45-6faf-c1fc-eb13-b6c71b7fb6ef@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 04, 2019 at 08:27:54PM +0100, René Scharfe wrote:

> The initialization function of the Trace2 performance format target sets
> aside a stash of dots for indenting output.  Get rid of it and use
> strbuf_addchars() to provide dots on demand instead.  This shortens the
> code, gets rid of a small heap allocation and is a bit more efficient.

Yeah, the end result is much easier on the eyes. I am scratching my head
at whether there is any advantage to copying the separate buffer, but I
don't see one. The likelihood of having to allocate in the final "buf"
strbuf is the same either way.

-Peff
