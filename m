Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88382C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4D520657
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEOSFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:05:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:47848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726144AbgEOSFI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:05:08 -0400
Received: (qmail 25716 invoked by uid 109); 15 May 2020 18:05:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 18:05:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13930 invoked by uid 111); 15 May 2020 18:05:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 14:05:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 14:05:06 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 02/13] upload-pack: move {want,have}_obj to
 upload_pack_data
Message-ID: <20200515180506.GB3692649@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200515100454.14486-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515100454.14486-3-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 12:04:43PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's move the want_obj and have_obj object
> arrays into 'struct upload_pack_data'.
> 
> These object arrays are used by both upload_pack() and
> upload_pack_v2(), for example when these functions call
> create_pack_file(). We are going to use
> 'struct upload_pack_data' in upload_pack() in a followup
> commit.

Makes sense. The v2 code path is slightly messier now (having to
dereference "data" more), but this should all pay off later in the
series when we can get rid of v0 globals.

-Peff
