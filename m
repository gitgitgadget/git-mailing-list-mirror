Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A94C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1E620663
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbhALIvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:51:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:53048 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbhALIvI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:51:08 -0500
Received: (qmail 6054 invoked by uid 109); 12 Jan 2021 08:50:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 08:50:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10801 invoked by uid 111); 12 Jan 2021 08:50:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 03:50:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 03:50:26 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 04/20] write_reused_pack_verbatim(): convert to new
 revindex API
Message-ID: <X/1i0pLQ5fcrlIoj@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <14b35d01a062f2dfdd710718b659064042dc21d6.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14b35d01a062f2dfdd710718b659064042dc21d6.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:16:56PM -0500, Taylor Blau wrote:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ea7df9270f..4341bc27b4 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -948,7 +948,7 @@ static size_t write_reused_pack_verbatim(struct hashfile *out,
>  		off_t to_write;
>  
>  		written = (pos * BITS_IN_EWORD);
> -		to_write = reuse_packfile->revindex[written].offset
> +		to_write = pack_pos_to_offset(reuse_packfile, written)
>  			- sizeof(struct pack_header);

This one is obviously correct.

-Peff
