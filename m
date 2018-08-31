Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296E91F404
	for <e@80x24.org>; Fri, 31 Aug 2018 19:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHaX62 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 19:58:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:35650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727248AbeHaX62 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 19:58:28 -0400
Received: (qmail 30023 invoked by uid 109); 31 Aug 2018 19:49:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Aug 2018 19:49:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8234 invoked by uid 111); 31 Aug 2018 19:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 31 Aug 2018 15:49:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2018 15:49:27 -0400
Date:   Fri, 31 Aug 2018 15:49:27 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc-diff: fix non-portable 'man' invocation
Message-ID: <20180831194927.GB5120@sigill.intra.peff.net>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-2-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180831063318.33373-2-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 02:33:16AM -0400, Eric Sunshine wrote:

> doc-diff invokes 'man' with the -l option to force "local" mode,
> however, neither MacOS nor FreeBSD recognize this option. On those
> platforms, if the argument to 'man' contains a slash, it is
> automatically interpreted as a file specification, so a "local"-like
> mode is not needed. And, it turns out, 'man' which does support -l
> falls back to enabling -l automatically if it can't otherwise find a
> manual entry corresponding to the argument. Since doc-diff always
> passes an absolute path of the nroff source file to 'man', the -l
> option kicks in anyhow, despite not being specified explicitly.
> Therefore, make the invocation portable to the various platforms by
> simply dropping -l.

Neat. Today I learned.

Confirmed that this works just fine without "-l" on my system (and that
"./foo.1" is an easy alternative to "man -l" on other systems).

-Peff
