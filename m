Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C1A1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 02:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeLTCwO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 21:52:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:46478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726604AbeLTCwO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 21:52:14 -0500
Received: (qmail 1195 invoked by uid 109); 20 Dec 2018 02:52:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 02:52:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27435 invoked by uid 111); 20 Dec 2018 02:51:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 21:51:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 21:52:12 -0500
Date:   Wed, 19 Dec 2018 21:52:12 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] setup: drop return value from
 `read_repository_format()`
Message-ID: <20181220025211.GB24002@sigill.intra.peff.net>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-2-martin.agren@gmail.com>
 <20181219152735.GA14802@sigill.intra.peff.net>
 <20181220001752.GA35965@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181220001752.GA35965@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 12:17:53AM +0000, brian m. carlson wrote:

> On Wed, Dec 19, 2018 at 10:27:35AM -0500, Jeff King wrote:
> > I dunno. This is one of those dark corners of the code where we appear
> > to do the wrong thing, but nobody seems to have noticed or cared much,
> > and changing it runs the risk of breaking some obscure cases. I'm not
> > sure if we should bite the bullet and try to address that, or just back
> > away slowly and pretend we never looked at it. ;)
> 
> I will point out that with the SHA-256 work, reading the config file
> becomes essential for SHA-256 repositories, because we need to know the
> object format. Removing the config file leads to things blowing up in a
> bad way (what specific bad way I don't remember).
> 
> That may influence the direction we want to take in this work, or not.

Wouldn't we just treat that the same way we do now? I.e., assume the
default of sha1, just like we assume repositoryformatversion==0?

-Peff
