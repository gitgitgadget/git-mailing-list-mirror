Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42F7C28CAF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C42D61242
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348343AbhIUCXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:23:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:51360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243656AbhIUCHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:07:15 -0400
Received: (qmail 2944 invoked by uid 109); 21 Sep 2021 02:05:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 02:05:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26695 invoked by uid 111); 21 Sep 2021 02:05:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 22:05:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 22:05:46 -0400
From:   Jeff King <peff@peff.net>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] grep: mark "haystack" buffers as const
Message-ID: <YUk9+p1j3GNwZ1DL@coredump.intra.peff.net>
References: <YUk3zwuse56v76ze@coredump.intra.peff.net>
 <YUk4vnMQHApY99Lb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUk4vnMQHApY99Lb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 09:43:26PM -0400, Jeff King wrote:

> When we're grepping in a buffer, we don't need to modify it. So we can
> take "const char *" buffers, rather than "char *". This can avoid some
> awkward casts in our callers.

Sorry, this patch should have touched strip_timestamp(), too. I had
originally done it in the earlier patch, but because we pass a
pointer-to-pointer, the compiler got mad about the mis-matched type from
the caller. So I reverted it there, but forgot to add it back in here.

At any rate, these are mostly for illustration. They'd need a little
rebasing if not put on top of your patches anyway.

-Peff
