Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1BFC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50BB613E8
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGAQxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:53:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:38958 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhGAQxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:53:46 -0400
Received: (qmail 28423 invoked by uid 109); 1 Jul 2021 16:51:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 16:51:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17558 invoked by uid 111); 1 Jul 2021 16:51:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 12:51:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 12:51:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
Message-ID: <YN3ygh98zikMmd1S@coredump.intra.peff.net>
References: <xmqq4kdft122.fsf@gitster.g>
 <87o8bmcd9a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8bmcd9a.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 01, 2021 at 04:00:01PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > * ab/serve-cleanup (2021-06-28) 8 commits
> >  - upload-pack.c: convert to new serve.c "startup" config cb
> >  - serve: add support for a "startup" git_config() callback
> >  - serve.c: add trace2 regions for advertise & command
> >  - serve.c: add call_{advertise,command}() indirection
> >  - serve: use designated initializers
> >  - transport: use designated initializers
> >  - transport: rename "fetch" in transport_vtable to "fetch_refs"
> >  - serve: mark has_capability() as static
> >
> >  Code clean-up around "git serve".
> 
> Jeff, what do you think about this version & the upload-pack.c changes?

I left some comments on the config-callback patches. I think it's an OK
direction.

I didn't read the final patch carefully. And I do think it needs to be
gone over very carefully to make sure there are not any subtleties,
given the problems we've had with config-reading there in the past.  I'm
not enthused about doing so for what I consider to be a pretty
unexciting outcome. I.e., it feels a bit like high-risk churn for low
reward.

-Peff
