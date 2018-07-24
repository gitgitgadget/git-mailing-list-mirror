Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7481F597
	for <e@80x24.org>; Tue, 24 Jul 2018 10:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbeGXLyp (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 07:54:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:57290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388291AbeGXLyp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 07:54:45 -0400
Received: (qmail 10834 invoked by uid 109); 24 Jul 2018 10:48:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 10:48:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26199 invoked by uid 111); 24 Jul 2018 10:48:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 06:48:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 06:48:52 -0400
Date:   Tue, 24 Jul 2018 06:48:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] use size_t in iconv/strbuf
Message-ID: <20180724104852.GA14638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is primarily about the first two patches to convert our
iconv helpers to use size_t consistently. I posted them to the
git-security list a while back, wondering if there was something sneaky
you could do here. But after some discussion, the consensus was no, you
can't.

The other four patches are just semi-related cleanups I saw while poking
around the strbuf code. I doubt any of them fixes a user-visible bug,
but I think they're worth doing (and they don't seem to conflict with
anything on pu).

  [1/6]: reencode_string: use st_add/st_mult helpers
  [2/6]: reencode_string: use size_t for string lengths
  [3/6]: strbuf: use size_t for length in intermediate variables
  [4/6]: strbuf_readlink: use ssize_t
  [5/6]: pass st.st_size as hint for strbuf_readlink()
  [6/6]: strbuf_humanise: use unsigned variables

 builtin/init-db.c    |  3 ++-
 convert.c            |  6 +++---
 pretty.c             |  2 +-
 refs/files-backend.c |  2 +-
 strbuf.c             | 20 ++++++++++----------
 utf8.c               | 10 +++++-----
 utf8.h               | 10 +++++-----
 7 files changed, 27 insertions(+), 26 deletions(-)

-Peff
