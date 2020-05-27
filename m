Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9264C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF03E2075A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389242AbgE0SH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 14:07:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:57784 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387696AbgE0SH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 14:07:28 -0400
Received: (qmail 23234 invoked by uid 109); 27 May 2020 18:07:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 18:07:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6212 invoked by uid 111); 27 May 2020 18:07:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 14:07:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 14:07:27 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 03/12] upload-pack: move use_sideband to upload_pack_data
Message-ID: <20200527180727.GB4020820@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
 <20200527164742.23067-4-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527164742.23067-4-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 06:47:33PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's move the 'use_sideband' static variable
> into this struct.
> 
> This variable is used by both v0 and v2 protocols.
> 
> While at it, let's update the comment near the variable
> definition.

Yep, looks good. I was surprised for a moment by "used by v2", which
always does sideband. But of course we still _use_ the variable, we just
set it unconditionally in the v2 code-path.

-Peff
