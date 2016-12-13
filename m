Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C663920451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbcLMXn6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:43:58 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:56379 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751905AbcLMXn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:43:56 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id E4BE6C3445;
        Wed, 14 Dec 2016 00:31:54 +0100 (CET)
Received: from drbeat.li (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 7DFE6C3453;
        Wed, 14 Dec 2016 00:31:52 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id 12C82216E8; Wed, 14 Dec 2016 00:31:52 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 5/6] update_unicode.sh: remove the plane filter
Date:   Wed, 14 Dec 2016 00:31:43 +0100
Message-Id: <1481671904-1143-6-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
References: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The uniset upstream has accepted my patches that eliminate the Unicode
plane offsets from the output in '--32' mode.

Remove the corresponding filter in update_unicode.sh.

This also fixes the issue that the plane offsets were not removed from
the second uniset call.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 contrib/update-unicode/update_unicode.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/update-unicode/update_unicode.sh b/contrib/update-unicode/update_unicode.sh
index 56871a1..e05db92 100755
--- a/contrib/update-unicode/update_unicode.sh
+++ b/contrib/update-unicode/update_unicode.sh
@@ -25,8 +25,7 @@ fi &&
 UNICODE_DIR=. && export UNICODE_DIR &&
 cat >$UNICODEWIDTH_H <<-EOF
 static const struct interval zero_width[] = {
-	$(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
-	  grep -v plane)
+	$(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD)
 };
 static const struct interval double_width[] = {
 	$(uniset/uniset --32 eaw:F,W)
-- 
2.7.2
