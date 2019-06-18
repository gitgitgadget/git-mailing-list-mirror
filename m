Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699871F462
	for <e@80x24.org>; Tue, 18 Jun 2019 15:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfFRPyW (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 11:54:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:58144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729209AbfFRPyW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 11:54:22 -0400
Received: (qmail 6853 invoked by uid 109); 18 Jun 2019 15:54:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Jun 2019 15:54:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6158 invoked by uid 111); 18 Jun 2019 15:55:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Jun 2019 11:55:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2019 11:54:19 -0400
Date:   Tue, 18 Jun 2019 11:54:19 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] wt-status.h: drop stdio.h include
Message-ID: <20190618155419.GB13431@sigill.intra.peff.net>
References: <20190618155326.GA4014@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190618155326.GA4014@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We started including stdio.h to pick up the declaration of "FILE" in
f26a001226 (Enable wt-status output to a given FILE pointer.,
2007-09-17). But there's no need, since headers can assume that
git-compat-util.h has been included, which covers stdio.

This should just be redundant, and not hurting anything (like pulling in
includes out of order) because C files are supposed to always include
git-compat-util.h first. But it's worth cleaning up to model good
behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/wt-status.h b/wt-status.h
index 64f1ddc9fd..8849768e92 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -1,7 +1,6 @@
 #ifndef STATUS_H
 #define STATUS_H
 
-#include <stdio.h>
 #include "string-list.h"
 #include "color.h"
 #include "pathspec.h"
-- 
2.22.0.rc3.685.g5185838c9a
