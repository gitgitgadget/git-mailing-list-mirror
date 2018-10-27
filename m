Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5581F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeJ0QEu (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:04:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:57002 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726610AbeJ0QEu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:04:50 -0400
Received: (qmail 25555 invoked by uid 109); 27 Oct 2018 07:24:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 07:24:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4609 invoked by uid 111); 27 Oct 2018 07:24:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 03:24:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 03:24:47 -0400
Date:   Sat, 27 Oct 2018 03:24:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 00/10] Reduce #ifdef NO_PTHREADS
Message-ID: <20181027072447.GA26685@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181027071003.1347-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 09:09:53AM +0200, Nguyễn Thái Ngọc Duy wrote:

> People seemed to support the idea of removing these #ifdef NO_PTHREADS [1]
> so this is a complete series. I left the #ifdef in run-command.c and
> transport-helper.c because those code looked complicated so perhaps we
> could clean them up later. Even these updated files could be updated
> more, I think, to reduce some code duplication, but I tried to keep
> the change here minimal.

Some of the bits in run-command.c can probably be converted, but all of
the "struct async" bits can't ever be. Because there the fallback is not
"OK, let's just run a single thread" but a whole separate forking
mechanism.

-Peff
