Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407EC1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 12:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbfHGMtB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 08:49:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:36660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387802AbfHGMtB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 08:49:01 -0400
Received: (qmail 30084 invoked by uid 109); 7 Aug 2019 12:49:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Aug 2019 12:49:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12429 invoked by uid 111); 7 Aug 2019 12:51:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Aug 2019 08:51:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Aug 2019 08:49:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1-file: release strbuf after use
Message-ID: <20190807124859.GA5384@sigill.intra.peff.net>
References: <fa6ccb9f-11cd-7eec-fdbb-2de6a0bfcecf@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa6ccb9f-11cd-7eec-fdbb-2de6a0bfcecf@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 07, 2019 at 01:15:25PM +0200, René Scharfe wrote:

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Patch generated with --function-context for easier review.
> 
> The plugged leak was added by a10a17877b (for_each_alternate_ref:
> replace transport code with for-each-ref, 2017-02-08) and showed up in
> 709dfa6990 (object-store.h: move for_each_alternate_ref() from
> transport.h, 2019-07-01), where it caught my eye, belatedly.

Thanks, the patch obviously looks good (though I wouldn't be sad for
some of your digging above to go into the commit message).

I had a vague feeling that we had seen this particular leak before (and
presumably the fix fell through the cracks). But I couldn't find it on
the list. I think after a while these strbuf_getline() leaks all start
to look the same. :)

-Peff
