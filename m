Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C0C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BE964E24
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhBCFXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 00:23:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:45688 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhBCFWp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 00:22:45 -0500
Received: (qmail 17647 invoked by uid 109); 3 Feb 2021 05:22:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Feb 2021 05:22:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12335 invoked by uid 111); 3 Feb 2021 05:22:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Feb 2021 00:22:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Feb 2021 00:22:04 -0500
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] annotate-tests: quote variable expansions containing
 path names
Message-ID: <YBoy/F3tS3JtyhDX@coredump.intra.peff.net>
References: <cec4f442-03ea-e846-2613-f390b1e4d31b@kdbg.org>
 <762b6a24-15ef-7578-6064-eb82832699a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <762b6a24-15ef-7578-6064-eb82832699a4@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 12:14:56PM -0500, Philippe Blain wrote:

> Apart from that, maybe we could set up one of the CI jobs to
> clone git.git into a path with spaces, to try to avoid these
> kind of errors in the future ?

We put a space in the temporary trash directory created by the test
suite for exactly this purpose. So I was curious why it didn't detect
this problem.

It looks like it's because the issue is with $TEST_DIRECTORY, which is
outside the trash directory.

-Peff
