Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7560920FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 08:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbcGAIGc (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 04:06:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:38860 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752003AbcGAIG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 04:06:28 -0400
Received: (qmail 29000 invoked by uid 102); 1 Jul 2016 07:59:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 03:59:49 -0400
Received: (qmail 14611 invoked by uid 107); 1 Jul 2016 08:00:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 04:00:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 03:59:44 -0400
Date:	Fri, 1 Jul 2016 03:59:44 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH] Makefile: use VCSSVN_LIB to refer to svn library
Message-ID: <20160701075944.GA20736@sigill.intra.peff.net>
References: <20160701075651.GA20653@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160701075651.GA20653@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We have an abstracted variable; let's use it consistently.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of the cleanup earlier in the thread.

I actually wonder if we should drop the vcs-svn code entirely. The last
update that wasn't just part of a "I'm grepping the whole code base to
change this interface" patch was almost 4 years ago, and AFAICT it never
reached a shippable point (we _do_ actually install git-remote-testsvn,
but given the name, I sort of assume nobody is using it).

But I don't want to step on the toes of anybody who actually is using
it, or is planning to work on it more.

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 22815a2..4579eab 100644
--- a/Makefile
+++ b/Makefile
@@ -2225,9 +2225,9 @@ perf: all
 
 .PHONY: test perf
 
-t/helper/test-line-buffer$X: vcs-svn/lib.a
+t/helper/test-line-buffer$X: $(VCSSVN_LIB)
 
-t/helper/test-svn-fe$X: vcs-svn/lib.a
+t/helper/test-svn-fe$X: $(VCSSVN_LIB)
 
 .PRECIOUS: $(TEST_OBJS)
 
-- 
2.9.0.317.g65b4e7c
