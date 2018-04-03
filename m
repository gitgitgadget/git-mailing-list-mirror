Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E61E1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 14:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeDCOA5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 10:00:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:51846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751281AbeDCOA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 10:00:57 -0400
Received: (qmail 32407 invoked by uid 109); 3 Apr 2018 14:00:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 14:00:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25601 invoked by uid 111); 3 Apr 2018 14:01:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 10:01:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 10:00:55 -0400
Date:   Tue, 3 Apr 2018 10:00:55 -0400
From:   Jeff King <peff@peff.net>
To:     Jens =?utf-8?Q?Kr=C3=BCger?= <Jens.Krueger@frm2.tum.de>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 0/2] t5561 fails without curl installed
Message-ID: <20180403140055.GA29556@sigill.intra.peff.net>
References: <66ac8aec-3e4c-43be-83d1-7bd823ec2b20@frm2.tum.de>
 <20180403131447.GB18824@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403131447.GB18824@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 09:14:47AM -0400, Jeff King wrote:

> As far as code changes in Git, perhaps (assuming my guess is right):
> 
>   - drop the redirect of stderr here; the test suite already handles
>     hiding stderr from the user (without "-v"), and in "-v" mode you
>     probably would have gotten a useful error like "curl: not found"
> 
>   - it's rare but possible to have libcurl installed (which is needed
>     for the server side, and what we key on for running the httpd tests)
>     but not the curl binary. This test probably should check for the
>     existence of the curl binary as a prerequisite.

So let's do this before we forget.

  [1/2]: t5561: drop curl stderr redirects
  [2/2]: t5561: skip tests if curl is not available

 t/t5561-http-backend.sh | 10 ++++++++--
 t/test-lib.sh           |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

-Peff
