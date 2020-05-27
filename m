Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3496C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4DE208B8
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgE0SsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 14:48:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57942 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgE0SsB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 14:48:01 -0400
Received: (qmail 23490 invoked by uid 109); 27 May 2020 18:41:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 18:41:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6474 invoked by uid 111); 27 May 2020 18:41:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 14:41:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 14:41:18 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 10/12] upload-pack: move allow_ref_in_want to
 upload_pack_data
Message-ID: <20200527184118.GH4020820@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
 <20200527164742.23067-11-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527164742.23067-11-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 06:47:40PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's move the 'allow_ref_in_want' static
> variable into this struct.
> 
> It is only used by protocol v0 code since protocol v2 assumes
> certain baseline capabilities, but rolling it into
> upload_pack_data and just letting v2 code ignore it as it does
> now is more coherent and cleaner.

I think this is opposite, isn't it? Ref-in-want is a v2-only feature,
and v0 does not support it at all (though it could).

-Peff
