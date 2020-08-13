Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEA6C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 09:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B1420781
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 09:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgHMJQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:16:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:57472 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMJQo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 05:16:44 -0400
Received: (qmail 17293 invoked by uid 109); 13 Aug 2020 09:16:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 09:16:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11614 invoked by uid 111); 13 Aug 2020 09:16:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 05:16:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 05:16:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] connected: use buffered I/O to talk to rev-list
Message-ID: <20200813091643.GE3092220@coredump.intra.peff.net>
References: <2e2907ac-3be9-c0ed-830a-f8aa28b471aa@web.de>
 <2e3ac6f7-77c2-4792-d6df-891ede6318ce@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e3ac6f7-77c2-4792-d6df-891ede6318ce@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 06:52:49PM +0200, René Scharfe wrote:

> Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
> 2016-06-08), significantly reduce the number of system calls and
> simplify the code for sending object IDs to rev-list by using stdio's
> buffering.
> 
> Take care to handle errors immediately to get the correct error code,
> and to flush the buffer explicitly before closing the stream in order to
> catch any write errors for these last bytes.

FWIW, the error handling in this patch and the other stdio conversions
you sent all look good to me. Thanks (and to Chris and Johannes for
great review on v1).

-Peff
