Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CF1C433E6
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A5D64E1B
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhA3JIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:08:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:41424 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233872AbhA3JHy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:07:54 -0500
Received: (qmail 16613 invoked by uid 109); 30 Jan 2021 08:43:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Jan 2021 08:43:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23259 invoked by uid 111); 30 Jan 2021 08:43:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Jan 2021 03:43:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 Jan 2021 03:43:02 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 07/10] t: prepare for GIT_TEST_WRITE_REV_INDEX
Message-ID: <YBUcFpzhuV+7kRwi@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <7cf16485cccccf365101d30138d9ee8b00d705d0.1611617820.git.me@ttaylorr.com>
 <YBNasXXZc1BEkMxH@coredump.intra.peff.net>
 <YBNjLqOe1NtpziV7@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBNjLqOe1NtpziV7@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 08:21:50PM -0500, Taylor Blau wrote:

> [sane_unset outside of a test]
> 
> I think I probably took this from the trace2 tests? Not sure. I'm glad
> that it's not wrong, strictly speaking.
> 
> This is another instance that I'd be happy to send a follow-up patch to
> get rid of all of these at once, unless you feel strongly that it should
> be changed in this series before applying.

Nope, I don't feel strongly.

> > This one is making the test a bit looser (it would miss a case where we
> > somehow failed to generate the .idx). That seems like an unlikely bug,
> > but I wonder if we can keep the original behavior. I guess:
> >
> >   ls .git/objects/pack/*.pack \
> >      .git/objects/pack/*.idx |
> >      sort >post_packs
> >
> > would work?
> 
> Sure, I see what you're saying. To be honest, I'm skeptical that we'd
> have a bug which failed only this one test, so I'm hesitant to send a
> replacement/reroll for this alone.
> 
> If you feel strongly, though, I'm happy to change it. (But, I'll err on
> the side of leaving it as-is, since you indicated in your response to
> v3's cover letter that you'd be OK if I discarded some or all of your
> suggestions).

Nope, I don't feel strongly. Junio even argued elsewhere that these
tests may be better off just looking for pack files (which is looser
than what they do now, but as we've said, unlikely to matter for any
realistic bug). So I'm happy enough with what you have.

-Peff
