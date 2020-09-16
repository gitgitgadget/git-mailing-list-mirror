Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4ADC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ABE82087D
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgIPWjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:39:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:59268 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgIPWjv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:39:51 -0400
Received: (qmail 27481 invoked by uid 109); 16 Sep 2020 22:39:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Sep 2020 22:39:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2503 invoked by uid 111); 16 Sep 2020 22:39:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 18:39:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 18:39:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/5] t3200: avoid variations of the `master` branch name
Message-ID: <20200916223950.GA1207950@coredump.intra.peff.net>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
 <2f1d0a2df41f567bc1a8bc446c26e1cb8b6dc36c.1600279853.git.gitgitgadget@gmail.com>
 <20200916211150.GA617237@coredump.intra.peff.net>
 <xmqqft7huzju.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft7huzju.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 03:28:21PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm on the fence on whether this matters. It's a temporary
> > inconsistency, assuming we eventually move to "main" as the default. We
> > _could_ push this change off to that patch, too, but it does make it
> > more noisy.
> 
> Another way to handle this is perhaps to teach test-lib.sh a way to
> tell it that we want to live in the world where the initial default
> branch name is 'main' and use that at the beginning of these select
> test scripts like t3200.  Then we can do three related things in a
> single patch to t3200, which are:
> 
>  - Declare that any "git init" in this test (including the initial
>    one) uses 'main' as the default branch name;
> 
>  - rename 'master' used in the test to 'main'
> 
>  - rename 'master2' used in the test to 'main2'
> 
> and it would eliminate the awkwardness.
> 
> The change to test-lib.sh would likely to use init.defaultBranch
> which also would be a good thing.

Yeah, I'd be perfectly happy with that.

-Peff
