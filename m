Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4A1C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 06:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD723206C3
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 06:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBG7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:59:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:33970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFBG7C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 02:59:02 -0400
Received: (qmail 3083 invoked by uid 109); 2 Jun 2020 06:59:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jun 2020 06:59:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17381 invoked by uid 111); 2 Jun 2020 06:59:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jun 2020 02:59:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Jun 2020 02:59:01 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 03/13] upload-pack: move static vars to
 upload_pack_data
Message-ID: <20200602065901.GA4005274@coredump.intra.peff.net>
References: <20200527164742.23067-1-chriscool@tuxfamily.org>
 <20200602041657.7132-1-chriscool@tuxfamily.org>
 <20200602041657.7132-4-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200602041657.7132-4-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 02, 2020 at 06:16:47AM +0200, Christian Couder wrote:

> -static int no_done;
> -static int daemon_mode;
> [...]
> +	unsigned no_done : 1;					/* v0 only */
> +	unsigned daemon_mode : 1;				/* v0 only */

These ones go from int to bitfield. It looks like we only ever assign
0/1 to them. Looks good.

-Peff
