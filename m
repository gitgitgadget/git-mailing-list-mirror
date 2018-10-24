Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5A71F453
	for <e@80x24.org>; Wed, 24 Oct 2018 07:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeJXQDe (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:03:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:52418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729690AbeJXQDd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:03:33 -0400
Received: (qmail 7375 invoked by uid 109); 24 Oct 2018 07:36:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Oct 2018 07:36:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2178 invoked by uid 111); 24 Oct 2018 07:35:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Oct 2018 03:35:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2018 03:36:37 -0400
Date:   Wed, 24 Oct 2018 03:36:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] run-command: fix Unix PATH lookup
Message-ID: <20181024073637.GA31069@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a bug where run-command.c accidentally runs commands
from the current directory when they are not found in the $PATH.

The second patch is the interesting one. The first one is just a
necessary cleanup. Possibly this should be split into two topics: the
second patch slated for maint, and then the first one as an independent
fixup on tb/filter-alternate-refs (which is in master).

  [1/2]: t5410: use longer path for sample script
  [2/2]: run-command: mark path lookup errors with ENOENT

 run-command.c                      | 20 ++++++++++++++++----
 t/t0061-run-command.sh             | 13 ++++++++++++-
 t/t5410-receive-pack-alternates.sh |  2 +-
 3 files changed, 29 insertions(+), 6 deletions(-)

-Peff
