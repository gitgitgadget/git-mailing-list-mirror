Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23249C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 06:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E864120721
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 06:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfLIGYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:24:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:41680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726165AbfLIGYu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 01:24:50 -0500
Received: (qmail 17886 invoked by uid 109); 9 Dec 2019 06:24:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Dec 2019 06:24:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18199 invoked by uid 111); 9 Dec 2019 06:29:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Dec 2019 01:29:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Dec 2019 01:24:49 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        James Ramsay <james@jramsay.com.au>
Subject: Re: [PATCH v3 1/9] builtin/pack-objects: report reused packfile
 objects
Message-ID: <20191209062449.GA40570@coredump.intra.peff.net>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-2-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115141541.11149-2-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 03:15:33PM +0100, Christian Couder wrote:

> From: Jeff King <peff@peff.net>
> 
> To see when packfile reuse kicks in or not, it is useful to
> show reused packfile objects statistics in the output of
> upload-pack.

Yep, I think this one makes sense. I would be a bit curious to see how
often reuse actually kicks in for you with the current code. Back when I
worked on this topic in 2015, it was kicking in for us almost-never (at
least for big repos like torvalds/linux that we were interested in
measuring), but that's because we were packing all of the forks together
(and still do). The earlier heuristics made no sense for that case.

I don't know if it's really worth spending a lot of time trying to
collect data, though.

-Peff
