Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9911E207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424150AbdDUSxs (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:53:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:37878 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424131AbdDUSxo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:53:44 -0400
Received: (qmail 7938 invoked by uid 109); 21 Apr 2017 17:07:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 17:07:03 +0000
Received: (qmail 17668 invoked by uid 111); 21 Apr 2017 17:07:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 13:07:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 13:07:00 -0400
Date:   Fri, 21 Apr 2017 13:07:00 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/15] Handle fopen() errors
Message-ID: <20170421170700.qyjtrvew54u2epue@sigill.intra.peff.net>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <xmqqlgqu7cq8.fsf@gitster.mtv.corp.google.com>
 <xmqqk26e5swj.fsf@gitster.mtv.corp.google.com>
 <20170421062915.he5tlgjqq7kj5h32@sigill.intra.peff.net>
 <CACsJy8D1LuH6qVp15MSkCM_oQphVUUK0r9SeKC5AzX+9Xi2dcw@mail.gmail.com>
 <CAPc5daXPgEFibr28-EZjk9_vYrrO2qt9VLXW6PepmFXUChpk7Q@mail.gmail.com>
 <CACsJy8CCW+gQ6n2VOC4nmRBukHSLyxYizQhowQoNOc8weZzJjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CCW+gQ6n2VOC4nmRBukHSLyxYizQhowQoNOc8weZzJjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 07:27:20PM +0700, Duy Nguyen wrote:

> On Fri, Apr 21, 2017 at 6:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Yes, but (1) we'd need to be careful about --quiet
> 
> Yeah. It's a real pain point for making changes like this. At some
> point we should just have a global (maybe multi-level) quiet flag.

I don't think it's too bad here. Isn't it just:

  FILE *fh = quiet ? fopen(x, y) : fopen_or_warn(x, y);

It is a little annoying to have to repeat "x", though (which is
sometimes a git_path() invocation).

-Peff
