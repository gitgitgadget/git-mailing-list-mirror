Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E41C433E2
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B39F2065D
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgENWME (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 18:12:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:46958 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726046AbgENWME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 18:12:04 -0400
Received: (qmail 17831 invoked by uid 109); 14 May 2020 22:12:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 May 2020 22:12:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5109 invoked by uid 111); 14 May 2020 22:12:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 May 2020 18:12:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 May 2020 18:12:02 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com, cbailey32@bloomberg.net,
        l.s.r@web.de
Subject: Re: [PATCH] compat: remove gmtime
Message-ID: <20200514221202.GB3074610@coredump.intra.peff.net>
References: <20200514191854.55231-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200514191854.55231-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 12:18:54PM -0700, Carlo Marcelo Arenas Belón wrote:

> ccd469450a (date.c: switch to reentrant {gm,local}time_r, 2019-11-28)
> removes the only gmtime() call we had and moves to gmtime_r() which
> doesn't have the same portability problems.
> 
> Remove the compat gmtime code since it is no longer needed, and confirm
> by successfull running t4212 in FreeBSD 9.3 amd64 (the oldest I could
> get a hold off).

So gmtime_r() behaves differently than gmtime() on those systems in the
face of an overflowing time_t? That seems like an odd implementation
choice, but OK. If the test isn't failing, I'm just as happy to get rid
of this compat cruft.

-Peff
