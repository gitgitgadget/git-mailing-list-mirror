Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99AF1F51C
	for <e@80x24.org>; Fri, 18 May 2018 22:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeERWZK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 18:25:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:46036 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751009AbeERWZK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 18:25:10 -0400
Received: (qmail 31127 invoked by uid 109); 18 May 2018 22:25:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 May 2018 22:25:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14970 invoked by uid 111); 18 May 2018 22:25:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 18:25:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 15:25:06 -0700
Date:   Fri, 18 May 2018 15:25:06 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] fix a segfault in get_main_ref_store()
Message-ID: <20180518222506.GA9527@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I stumbled across a BUG() today. But interestingly, in the current tip
of master it actually segfaults instead! This fixes the segfault (back
into a BUG(), and then fixes the caller to avoid the BUG() in the first
place).

  [1/2]: get_main_ref_store: BUG() when outside a repository
  [2/2]: config: die when --blob is used outside a repository

 builtin/config.c       | 3 +++
 refs.c                 | 3 +++
 t/t1307-config-blob.sh | 4 ++++
 3 files changed, 10 insertions(+)

-Peff
