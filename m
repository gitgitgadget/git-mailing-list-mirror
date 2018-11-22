Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 542731F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407884AbeKWKUW (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 05:20:22 -0500
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net ([68.178.252.231]:49986
        "EHLO p3plsmtpa12-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407880AbeKWKUV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Nov 2018 05:20:21 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id PyYIgDd58mt8MPyYMgmifm; Thu, 22 Nov 2018 16:38:35 -0700
From:   Max Kirillov <max@max630.net>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>, Max Kirillov <max@max630.net>
Subject: [PATCH] t5562: fix perl path
Date:   Fri, 23 Nov 2018 01:38:21 +0200
Message-Id: <20181122233821.17871-1-max@max630.net>
X-Mailer: git-send-email 2.19.0.1202.g68e1e8f04e
In-Reply-To: <20181119213924.GA2318@sigill.intra.peff.net>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfG6A+S24iZEKe5Z+vgXkpYSw0E5JnFbCkv4kIkCxl6e1ad33Z6Fs1G9ysm/5WqbjKHPYlKb0LnognX8QHDXqR2ORa+7qJrJ98cg9G8gL66FIrzEBMbbn
 UPL3MjMkTWHsWMLq7gjgKEE7PIkMyTqt383p2U1MnWIX0C7EkgAs48y3mW3KK1Bys0L1vAjJWWNsflVrR2ER9sRwm+e+rKYZJly4pUnxKUdCFn0BgbYPzev8
 cIyHbVFMCn6t2Y33acR4fQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Some systems do not have perl installed to /usr/bin. Use the variable
from the build settiings, and call perl directly than via shebang.

Signed-off-by: Max Kirillov <max@max630.net>
---
Submitting. Could you sign-off? Also removed shebang from the script as it is not needed
 t/t5562-http-backend-content-length.sh | 1 +
 t/t5562/invoke-with-content-length.pl  | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 mode change 100755 => 100644 t/t5562/invoke-with-content-length.pl

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index b24d8b05a4..90d890d02f 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -31,6 +31,7 @@ test_http_env() {
 		PATH_TRANSLATED="$PWD/.git/git-$handler_type-pack" \
 		GIT_HTTP_EXPORT_ALL=TRUE \
 		REQUEST_METHOD=POST \
+		"$PERL_PATH" \
 		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl \
 		    "$request_body" git http-backend >act.out 2>act.err
 }
diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
old mode 100755
new mode 100644
index 6c2aae7692..0943474af2
--- a/t/t5562/invoke-with-content-length.pl
+++ b/t/t5562/invoke-with-content-length.pl
@@ -1,4 +1,3 @@
-#!/usr/bin/perl
 use 5.008;
 use strict;
 use warnings;
-- 
2.19.0.1202.g68e1e8f04e

