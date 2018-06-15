Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567A51F403
	for <e@80x24.org>; Fri, 15 Jun 2018 17:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936266AbeFORVY (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 13:21:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:45954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934312AbeFORVY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 13:21:24 -0400
Received: (qmail 21886 invoked by uid 109); 15 Jun 2018 17:21:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 17:21:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23147 invoked by uid 111); 15 Jun 2018 17:21:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 13:21:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 13:21:22 -0400
Date:   Fri, 15 Jun 2018 13:21:22 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Luat Nguyen <root@l4w.io>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
Message-ID: <20180615172121.GA3067@sigill.intra.peff.net>
References: <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615033112.GA20390@sigill.intra.peff.net>
 <20180615091432.7155-1-szeder.dev@gmail.com>
 <xmqq602k2f9o.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjnZXfaNskiba9VsFWwwOx_kvGxZDY_AiyQv8L6gCPX4Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjnZXfaNskiba9VsFWwwOx_kvGxZDY_AiyQv8L6gCPX4Fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 07:10:28PM +0200, SZEDER Gábor wrote:

> > I said "yuck" because the original does not work if there happen to
> > be more than (or for that matter, less than) one '.bitmap' file
> > there.  But at least as long as there is one, it should work ;-)
> 
> Well, the test starts with 'git repack -ad', so there can be only one
> bitmap file.  (Unless something is broken, of course, but the second
> test would catch that much earlier.)

Right. I almost put "head -1" in there, but we know that we just created
a single bitmap. And my thought was that if we don't, the test would
blow up horribly, which is exactly what you want.

-Peff
