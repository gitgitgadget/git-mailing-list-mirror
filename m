Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97373C4363D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619982085B
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJEMQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:16:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:49582 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgJEMQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:16:36 -0400
Received: (qmail 32242 invoked by uid 109); 5 Oct 2020 12:16:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 12:16:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19030 invoked by uid 111); 5 Oct 2020 12:16:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 08:16:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 08:16:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 3/8] t7415: rename to expand scope
Message-ID: <20201005121634.GC2907394@coredump.intra.peff.net>
References: <20201005121609.GA2907272@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005121609.GA2907272@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script has already expanded beyond its original intent of ".. in
submodule names" to include other malicious submodule bits. Let's update
the name and description to reflect that, as well as the fact that we'll
soon be adding similar tests for other meta-files (.gitattributes, etc).
We'll also renumber it to move it out of the group of submodule-specific
tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 ...ubmodule-names.sh => t7450-bad-dotgitx-files.sh} | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)
 rename t/{t7415-submodule-names.sh => t7450-bad-dotgitx-files.sh} (95%)

diff --git a/t/t7415-submodule-names.sh b/t/t7450-bad-dotgitx-files.sh
similarity index 95%
rename from t/t7415-submodule-names.sh
rename to t/t7450-bad-dotgitx-files.sh
index d1781ef10c..fb28539948 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7450-bad-dotgitx-files.sh
@@ -1,9 +1,16 @@
 #!/bin/sh
 
-test_description='check handling of .. in submodule names
+test_description='check forbidden or malicious patterns in .git* files
 
-Exercise the name-checking function on a variety of names, and then give a
-real-world setup that confirms we catch this in practice.
+Such as:
+
+  - presence of .. in submodule names;
+    Exercise the name-checking function on a variety of names, and then give a
+    real-world setup that confirms we catch this in practice.
+
+  - nested submodule names
+
+  - symlinked .gitmodules, etc
 '
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
-- 
2.28.0.1295.gf70bcb366f

