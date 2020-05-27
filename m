Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483FEC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2525D2073B
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgE0S5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 14:57:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:57974 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgE0S5B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 14:57:01 -0400
Received: (qmail 23601 invoked by uid 109); 27 May 2020 18:57:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 18:57:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6585 invoked by uid 111); 27 May 2020 18:57:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 14:57:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 14:57:00 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 00/12] upload-pack: use 'struct upload_pack_data'
 thoroughly, part 2
Message-ID: <20200527185700.GJ4020820@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527164742.23067-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 06:47:30PM +0200, Christian Couder wrote:

> This patch series is the second part of an effort to move all static
> variables in 'upload-pack.c' into 'struct upload_pack_data'.
> 
> It is based on 'cc/upload-pack-data' which contains "part 1" of this
> effort. (See also: https://lore.kernel.org/git/20200515100454.14486-1-chriscool@tuxfamily.org/)
> 
> A part 3 will follow with the rest of the patches needed to get rid of
> the static variables left after this patch series.

Thanks again for working on this. It mostly looks good, but I left a few
comments, mostly about commit messages or comments. :)

One thing I think we _could_ do is to switch v2 to only reading the
config once, instead of once per request. And then all of those config
values could remain where they are, as they wouldn't need to be cleared
or reset. But I doubt the cost of parsing config per-request is
noticeable in practice, so I'm happy with it either way.

-Peff
