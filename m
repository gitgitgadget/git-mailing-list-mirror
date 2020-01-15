Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D342BC32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 22:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6AC2053B
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 22:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbgAOWp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:45:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:37392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729162AbgAOWp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 17:45:56 -0500
Received: (qmail 19833 invoked by uid 109); 15 Jan 2020 22:45:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Jan 2020 22:45:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 987 invoked by uid 111); 15 Jan 2020 22:52:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2020 17:52:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jan 2020 17:45:55 -0500
From:   Jeff King <peff@peff.net>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] color.c: Alias RGB colors 8-15 to aixterm colors
Message-ID: <20200115224555.GC4117117@coredump.intra.peff.net>
References: <20200110111516.GA474613@coredump.intra.peff.net>
 <20200110150547.221314-1-shawarmakarma@gmail.com>
 <20200110150547.221314-3-shawarmakarma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110150547.221314-3-shawarmakarma@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 10, 2020 at 10:05:47AM -0500, Eyal Soha wrote:

> Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>

Some rationale might be helpful for people who find this commit later
(especially if it ends up being a regression for people with 256-color
support but not 16-color). Maybe:

  This results in shorter output, and is _probably_ more portable. There
  is at least one environment (GitHub Actions) which supports 16-color
  mode but not 256-color mode. It's possible there are environments
  which go the other way, but it seems unlikely.

>  color.c          | 7 ++++++-
>  t/t4026-color.sh | 4 ++++

The code itself looks good. We don't currently document the magic of
0-7, so we don't need to change the documentation there (though perhaps
we ought to).

-Peff
