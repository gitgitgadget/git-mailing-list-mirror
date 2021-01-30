Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACECC433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982C064DE2
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhA3JIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:08:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:41426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhA3JHz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:07:55 -0500
Received: (qmail 16633 invoked by uid 109); 30 Jan 2021 08:46:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Jan 2021 08:46:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23286 invoked by uid 111); 30 Jan 2021 08:46:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Jan 2021 03:46:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 Jan 2021 03:46:07 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 09/10] pack-revindex: ensure that on-disk reverse
 indexes are given precedence
Message-ID: <YBUcz3CY29DjhW/U@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <a66d2f9f7c20eeb813656e66b3ad9d42f2eecf34.1611617820.git.me@ttaylorr.com>
 <YBNcjmn5Jm/EmHwS@coredump.intra.peff.net>
 <YBNkCsshbCkyC0w4@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBNkCsshbCkyC0w4@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 08:25:30PM -0500, Taylor Blau wrote:

> But, getting back to your original comment, I think that I actually
> prefer to have the GIT_TEST_XYZ_DIE stuff in the binary than I do
> relying on the perf suite to catch stuff like this.
> 
> I understand your concern about the binary size. I guess you could
> #ifdef this out and only build it in during the test suite, but then
> you're testing a different binary, and so that calls into question the
> integrity of the test suite itself, etc. etc.

I care less about binary size, and more just that the production binary
people use day-to-day has a bunch of weird test-only behaviors baked
into it. I guess nobody is likely to trigger this by accident, though,
and anybody who can maliciously impact the environment can do a lot
worse.  So it's not the end of the world to keep. It just offends my
sense of cleanliness and simplicity. ;)

> So, I guess that's all to say that I while I do find this to be hack-y
> and gross, I don't think that it's all that bad when you compare it to
> the alternatives.
> 
> As usual, I'm happy to change it if you feel strongly that it should be
> changed.

I agree the alternatives are pretty lousy. I don't feel strongly enough
to complain further. :)

-Peff
