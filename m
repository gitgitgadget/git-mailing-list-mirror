Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF66C433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B6D61606
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhEAPmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 11:42:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:42106 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEAPmK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 11:42:10 -0400
Received: (qmail 26619 invoked by uid 109); 1 May 2021 15:41:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 15:41:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10761 invoked by uid 111); 1 May 2021 15:41:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 11:41:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 11:41:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/9] t7415: remove out-dated comment about translation
Message-ID: <YI12n+1rbedpwyfW@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since GETTEXT_POISON does not exist anymore, there is no point warning
people about whether we should use test_i18ngrep. This is doubly
confusing because the comment was describing why it was OK to use grep,
but it got caught up in the mass conversion of 674ba34038 (fsck: mark
strings for translation, 2018-11-10).

Note there are other uses of test_i18ngrep in this script which are now
obsolete; I'll save those for a mass-cleanup. My goal here was just to
fix the confusing comment in code I'm about to refactor.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7415-submodule-names.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index f70368bc2e..fef6561d80 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -151,10 +151,9 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
 		} | git mktree &&
 
 		# Check not only that we fail, but that it is due to the
-		# symlink detector; this grep string comes from the config
-		# variable name and will not be translated.
+		# symlink detector
 		test_must_fail git fsck 2>output &&
-		test_i18ngrep gitmodulesSymlink output
+		grep gitmodulesSymlink output
 	)
 '
 
-- 
2.31.1.875.g5dccece0aa

