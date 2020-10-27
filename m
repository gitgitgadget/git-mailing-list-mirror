Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83AFC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB7122264
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507692AbgJ0HaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:30:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:38308 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507689AbgJ0HaB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 03:30:01 -0400
Received: (qmail 14372 invoked by uid 109); 27 Oct 2020 07:30:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 07:30:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15127 invoked by uid 111); 27 Oct 2020 07:30:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 03:30:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 03:30:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] fix error handling in checkout-index
Message-ID: <20201027073000.GA3651896@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on another topic, I noticed that "git checkout-index --
path" does not propagate errors through its exit code. It has been that
way for so long that I almost wondered if it is intentional, but I'm
pretty sure it's not. A bit scary, though. :)

  [1/2]: checkout-index: drop error message from empty --stage=all
  [2/2]: checkout-index: propagate errors to exit code

 builtin/checkout-index.c        | 16 ++++++++++++++--
 t/t2004-checkout-cache-temp.sh  | 10 +++++++++-
 t/t2006-checkout-index-basic.sh | 11 +++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

-Peff
