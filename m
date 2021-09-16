Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808EFC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C70E61185
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbhIPWjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:39:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:49560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234419AbhIPWjj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:39:39 -0400
Received: (qmail 8743 invoked by uid 109); 16 Sep 2021 22:38:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Sep 2021 22:38:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9994 invoked by uid 111); 16 Sep 2021 22:38:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Sep 2021 18:38:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Sep 2021 18:38:17 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 5/7] p5326: don't set core.multiPackIndex unnecessarily
Message-ID: <YUPHWRDXNBM3W3z/@coredump.intra.peff.net>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
 <191922c8f28c338ab3aa4faa57d75770a9eccd02.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <191922c8f28c338ab3aa4faa57d75770a9eccd02.1631657157.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 06:06:11PM -0400, Taylor Blau wrote:

> When this performance test was originally written, `core.multiPackIndex`
> was not the default and thus had to be enabled. But now that we have
> 18e449f86b (midx: enable core.multiPackIndex by default, 2020-09-25), we
> no longer need this.
> 
> Drop the unnecessary setup (even though it's not hurting anything, it is
> unnecessary at best and confusing at worst).

Makes sense. Sometimes it is worthwhile to carry extra code in the perf
tests for older versions, so that we can test performance across a wider
span. But there were no midx bitmaps at all when 18e449f86b happened, so
there is little point in worrying about going back that far for this
test.

-Peff
