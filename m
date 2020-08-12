Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E95C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BBD20781
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHLPKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:10:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:56444 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgHLPKk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 11:10:40 -0400
Received: (qmail 9591 invoked by uid 109); 12 Aug 2020 15:10:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2020 15:10:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32208 invoked by uid 111); 12 Aug 2020 15:10:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2020 11:10:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Aug 2020 11:10:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/11] renaming argv_array
Message-ID: <20200812151038.GB33189@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
 <20200812150611.GA33189@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812150611.GA33189@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 11:06:11AM -0400, Jeff King wrote:

> Debian unstable now ships coccinelle 1.0.8, and it's unbelievably slow
> compared to 1.0.4. Running "make coccicheck" is currently at 80 minutes
> of CPU time running each script in parallel, with none of them down.
> They're also all consuming 6GB of RAM each, so I'm killing them all.

This seems to be related to setting SPATCH_BATCH_SIZE to "0". It used to make
things go much faster (if you had enough memory), but now seems to just
consume tons of CPU. Setting it to "1" finishes the whole thing in ~13
minutes of CPU (~2m wall-clock).

So that's at least a path forward, but in general I have been frustrated
with operational aspects of coccinelle like this.

-Peff
