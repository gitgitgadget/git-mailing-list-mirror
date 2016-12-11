Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B161FF40
	for <e@80x24.org>; Sun, 11 Dec 2016 23:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbcLKXej (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 18:34:39 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:51980 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753944AbcLKXei (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 18:34:38 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id B526EC3445;
        Mon, 12 Dec 2016 00:34:34 +0100 (CET)
Received: from drbeat.li (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 93871C3442;
        Mon, 12 Dec 2016 00:34:34 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id 568F120A78; Mon, 12 Dec 2016 00:34:34 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 2/3] update_unicode.sh: remove the plane filters
Date:   Mon, 12 Dec 2016 00:34:24 +0100
Message-Id: <1481499265-18361-2-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
References: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The uniset upstream has accepted my patches that eliminate the Unicode
plane offsets from the output in '--32' mode.

Remove the corresponding filter in update_unicode.sh.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 update_unicode.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/update_unicode.sh b/update_unicode.sh
index 9ca7d8b..e595bf8 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -31,11 +31,10 @@ fi &&
 	UNICODE_DIR=. && export UNICODE_DIR &&
 	cat >$UNICODEWIDTH_H <<-EOF
 	static const struct interval zero_width[] = {
-		$(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
-		  grep -v plane)
+		$(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD)
 	};
 	static const struct interval double_width[] = {
-		$(uniset/uniset --32 eaw:F,W | grep -v plane)
+		$(uniset/uniset --32 eaw:F,W)
 	};
 	EOF
 )
-- 
2.7.2
