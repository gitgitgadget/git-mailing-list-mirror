Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D44F4207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbcJCUsz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:48:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:51486 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754155AbcJCUsy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:48:54 -0400
Received: (qmail 18352 invoked by uid 109); 3 Oct 2016 20:48:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:48:53 +0000
Received: (qmail 30016 invoked by uid 111); 3 Oct 2016 20:49:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:49:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:48:51 -0400
Date:   Mon, 3 Oct 2016 16:48:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v2 0/5] receive-pack: quarantine pushed objects
Message-ID: <20161003204851.klwspo6agykx6s3q@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a v2; the original was at:

  http://public-inbox.org/git/20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net/

which contains the rationale.  The required alternate-objects patches
(both the "allow recursive relative" one, and the helper to add an
internal alt-odb) have been pushed into their own series, that I posted
here:

  http://public-inbox.org/git/20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net/

This needs to be applied on top.

Other than that, v2 just fixes the minor issues raised on the list
(missing "static", and some clarifying comments).

  [1/5]: check_connected: accept an env argument
  [2/5]: tmp-objdir: introduce API for temporary object directories
  [3/5]: receive-pack: quarantine objects until pre-receive accepts
  [4/5]: tmp-objdir: put quarantine information in the environment
  [5/5]: tmp-objdir: do not migrate files starting with '.'

 Makefile                   |   1 +
 builtin/receive-pack.c     |  41 ++++++-
 cache.h                    |   1 +
 connected.c                |   1 +
 connected.h                |   5 +
 t/t5547-push-quarantine.sh |  36 ++++++
 tmp-objdir.c               | 275 +++++++++++++++++++++++++++++++++++++++++++++
 tmp-objdir.h               |  54 +++++++++
 8 files changed, 413 insertions(+), 1 deletion(-)
 create mode 100755 t/t5547-push-quarantine.sh
 create mode 100644 tmp-objdir.c
 create mode 100644 tmp-objdir.h

