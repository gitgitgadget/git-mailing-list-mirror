Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7C31F428
	for <e@80x24.org>; Tue,  2 Jan 2018 21:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbeABVIf (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 16:08:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:51020 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750726AbeABVIe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 16:08:34 -0500
Received: (qmail 11109 invoked by uid 109); 2 Jan 2018 21:08:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Jan 2018 21:08:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19419 invoked by uid 111); 2 Jan 2018 21:09:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 02 Jan 2018 16:09:05 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jan 2018 16:08:33 -0500
Date:   Tue, 2 Jan 2018 16:08:33 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Stephan Janssen <sjanssen@you-get.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 1/4] t5600: fix outdated comment about unborn HEAD
Message-ID: <20180102210832.GA22556@sigill.intra.peff.net>
References: <20180102210753.GA10430@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180102210753.GA10430@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back when this test was written, git-clone could not handle
a repository without any commits. These days it works fine,
and this comment is out of date.

At first glance it seems like we could just drop this code
entirely now, but it's necessary for the final test, which
was added later. That test corrupts the repository by
temporarily removing its objects, which means we need to
have some objects to move.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5600-clone-fail-cleanup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 4435693bb2..f23f92e5a7 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -22,7 +22,7 @@ test_expect_success \
 # Need a repo to clone
 test_create_repo foo
 
-# clone doesn't like it if there is no HEAD. Is that a bug?
+# create some objects so that we can corrupt the repo later
 (cd foo && touch file && git add file && git commit -m 'add file' >/dev/null 2>&1)
 
 # source repository given to git clone should be relative to the
-- 
2.16.0.rc0.384.gc477e89267

