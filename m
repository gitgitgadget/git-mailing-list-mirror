Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22A01F453
	for <e@80x24.org>; Tue, 22 Jan 2019 07:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfAVH3s (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 02:29:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:43632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726423AbfAVH3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 02:29:48 -0500
Received: (qmail 6652 invoked by uid 109); 22 Jan 2019 07:29:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Jan 2019 07:29:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3646 invoked by uid 111); 22 Jan 2019 07:29:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 22 Jan 2019 02:29:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2019 02:29:46 -0500
Date:   Tue, 22 Jan 2019 02:29:46 -0500
From:   Jeff King <peff@peff.net>
To:     Alex Netkachov <alex.netkachov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Potential bug in pack-objects.c
Message-ID: <20190122072946.GB28975@sigill.intra.peff.net>
References: <CAGAu0HVeQFA_O8_hsZbzRi9X35fF3DAeUaSd993JF=NTwaZP1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGAu0HVeQFA_O8_hsZbzRi9X35fF3DAeUaSd993JF=NTwaZP1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 21, 2019 at 10:10:16PM +0000, Alex Netkachov wrote:

> On the location builtin/pack-objects.c:1996 the code tries to set
> read_lock (pthread_mutex_lock(&read_mutex)) and fails. I suspect that
> read_mutex is not initialised yet. It is initialised in
> init_threaded_search, which is called later in prepare_pack (through
> ll_find_deltas).

This sounds like the same bug being discussed in:

  http://public-inbox.org/git/20190118022736.36832-1-phogg@novamoon.net/

-Peff
