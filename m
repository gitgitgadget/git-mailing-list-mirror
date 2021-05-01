Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28B3C433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8D5614A7
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEAPnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 11:43:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:42124 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhEAPnA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 11:43:00 -0400
Received: (qmail 26639 invoked by uid 109); 1 May 2021 15:42:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 15:42:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10816 invoked by uid 111); 1 May 2021 15:42:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 11:42:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 11:42:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/9] t7415: rename to expand scope
Message-ID: <YI120ELAX6EZ4NgI@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script has already expanded beyond its original intent of ".. in
submodule names" to include other malicious submodule bits. Let's update
the name and description to reflect that, as well as the fact that we'll
soon be adding similar tests for other dotfiles (.gitattributes, etc).
We'll also renumber it to move it out of the group of submodule-specific
tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 ...submodule-names.sh => t7450-bad-git-dotfiles.sh} | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)
 rename t/{t7415-submodule-names.sh => t7450-bad-git-dotfiles.sh} (95%)

diff --git a/t/t7415-submodule-names.sh b/t/t7450-bad-git-dotfiles.sh
similarity index 95%
rename from t/t7415-submodule-names.sh
rename to t/t7450-bad-git-dotfiles.sh
index 6a8cf3f47b..34d4dc6def 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -1,9 +1,16 @@
 #!/bin/sh
 
-test_description='check handling of .. in submodule names
+test_description='check broken or malicious patterns in .git* files
 
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
2.31.1.875.g5dccece0aa

