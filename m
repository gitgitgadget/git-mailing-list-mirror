Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622181F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 06:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbfJQGf4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 02:35:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:50550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729946AbfJQGf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 02:35:56 -0400
Received: (qmail 21478 invoked by uid 109); 17 Oct 2019 06:35:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 06:35:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6311 invoked by uid 111); 17 Oct 2019 06:39:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 02:39:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 02:35:55 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, mh@glandium.org
Subject: Re: [PATCH 6/6] index-pack: make quantum of work smaller
Message-ID: <20191017063554.GG10862@sigill.intra.peff.net>
References: <cover.1570663470.git.jonathantanmy@google.com>
 <505d8e79cd983d5b3dfd56c4f0432ad647132957.1570663470.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <505d8e79cd983d5b3dfd56c4f0432ad647132957.1570663470.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 04:44:22PM -0700, Jonathan Tan wrote:

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/index-pack.c | 267 ++++++++++++++++++++-----------------------
>  1 file changed, 127 insertions(+), 140 deletions(-)

I think this is a good direction to go in. I confess I didn't carefully
go over the implementation details, since you've marked this as RFC and
it sounds like you're mainly asking about direction. It looks pretty
reasonable from a high level, though.

-Peff
