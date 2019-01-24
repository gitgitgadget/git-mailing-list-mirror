Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981DC1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 12:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAXM0F (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 07:26:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:47080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726014AbfAXM0F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 07:26:05 -0500
Received: (qmail 25473 invoked by uid 109); 24 Jan 2019 12:26:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 12:26:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27878 invoked by uid 111); 24 Jan 2019 12:26:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 07:26:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 07:26:03 -0500
Date:   Thu, 24 Jan 2019 07:26:03 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/6] some diff --cc --stat fixes
Message-ID: <20190124122603.GA10415@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started as a follow-up to my "something like this" bug-fix from
last July:

 https://public-inbox.org/git/20180710203438.GB6886@sigill.intra.peff.net/

(better late than never). But in the course of that, I discovered
another really weird and interesting bug with --color-moved. This fixes
both, along with some related cases.

-Peff

  [1/6]: t4006: resurrect commented-out tests
  [2/6]: diff: clear emitted_symbols flag after use
  [3/6]: combine-diff: factor out stat-format mask
  [4/6]: combine-diff: treat --shortstat like --stat
  [5/6]: combine-diff: treat --summary like --stat
  [6/6]: combine-diff: treat --dirstat like --stat

 combine-diff.c                                | 17 ++--
 diff.c                                        |  4 +-
 t/t4006-diff-mode.sh                          | 55 +++++++------
 t/t4013-diff-various.sh                       |  9 +++
 .../diff.diff-tree_--cc_--shortstat_master    |  4 +
 t/t4013/diff.diff-tree_--cc_--summary_REVERSE |  6 ++
 .../diff.diff_--dirstat_--cc_master~1_master  |  3 +
 t/t4066-diff-emit-delay.sh                    | 79 +++++++++++++++++++
 8 files changed, 147 insertions(+), 30 deletions(-)
 create mode 100644 t/t4013/diff.diff-tree_--cc_--shortstat_master
 create mode 100644 t/t4013/diff.diff-tree_--cc_--summary_REVERSE
 create mode 100644 t/t4013/diff.diff_--dirstat_--cc_master~1_master
 create mode 100755 t/t4066-diff-emit-delay.sh
