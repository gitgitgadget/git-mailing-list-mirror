Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF83C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433A82053B
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 22:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfLCWSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:18:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:37842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727134AbfLCWSU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 17:18:20 -0500
Received: (qmail 17581 invoked by uid 109); 3 Dec 2019 22:18:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Dec 2019 22:18:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20073 invoked by uid 111); 3 Dec 2019 22:22:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Dec 2019 17:22:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Dec 2019 17:18:19 -0500
From:   Jeff King <peff@peff.net>
To:     Colin Stolley <cstolley@runbox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
Message-ID: <20191203221819.GB28419@sigill.intra.peff.net>
References: <20191127222453.GA3765@owl.colinstolley.com>
 <20191202174035.GJ23183@szeder.dev>
 <20191202194231.GA10707@sigill.intra.peff.net>
 <xmqq7e3d75vk.fsf@gitster-ct.c.googlers.com>
 <20191203173334.GA20027@owl.colinstolley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191203173334.GA20027@owl.colinstolley.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 03, 2019 at 11:33:34AM -0600, Colin Stolley wrote:

> Junio C Hamano wrote:
> 
> > Let me locally squash your fix in and credit you with helped-by
> > footer in the amended log message.  Strictly speaking, this may
> 
> I'm also happy to provide a khash version if that is still desired,
> perhaps as a separate patch.

Personally I'd be OK with it as-is, or with a conversion to khash (as I
said earlier, I prefer khash myself, but it's not like there aren't tons
of other hashmap.c users in the code).

-Peff
