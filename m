Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5D5C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJTX0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJTXZz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:25:55 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C5123469
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:53 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id l185-20020a6388c2000000b004610d11faddso442027pgd.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2hotPdrGrYF4F+VcmnLcsvSNqVOiwHxa9vMAL4jhHk=;
        b=GhTiT3D+CApSwbc6GqfiaCDRTJTZT84BCqWdVOb/2ObtB9gTDC/F/T95Yr8bNQQJ+U
         A7krETtP61FHjKqkpL8McQ/CzDTyRB6MEzzBEjD2uD88V2SLwkyG366uptv29OmhSCTc
         GD4biI8Uy6gPGUHW5maOmAo6vtwFfJaii/xv/1cALcG3Ny12atw2LnGdYIasP3x+5eZD
         R8kLbGhMkHrJjxqcJRlpRHki1BDCl636aSegPfT2CAMs+BFfDGtKMXbGZkm4kWGjiNRj
         qRlP9tLMaXisVmyWgW54DuXzbZmgkV4w5PPU66nsboLIpcDWIkt8P37PhgqwROhpUhwN
         ZkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2hotPdrGrYF4F+VcmnLcsvSNqVOiwHxa9vMAL4jhHk=;
        b=VcbOLYYALqkq+M3hvTh8X+Tm1Ca/8v5aTkOlXIIOQYBneED52F4UBb9g+Z9EZpaKCw
         bOMPmyd81BCN7KJyQ/m9fk5QD0O6YNotc41jiAc7U097Dua8/+ZdVUbGhDoRzihK3SPk
         tQC4Gi5r+aIjW0b1Y4xgAYE3r2i3le1rsiK3gn6P4sD5E2lRpS23JrXsupzxVkUgpE7e
         10DXNPTDnreqPSh7ISrA2P0HK7eEwBibnT1Dexlg0/imiQoeErMMrTXWOu6s7yGZTQcc
         l8gImc0duimi2YDRk9e52Rad9uki9K78vDvaN+CKUW3+ENTn0H0a+794AsVCyaasPXSu
         qzFw==
X-Gm-Message-State: ACrzQf1w8WvldUB2YD8rrc+G6hvJWqgyKUtdNMzT1TNQp2Y82gvri4Rl
        JW0keCV82Yb7AvHTB7ZlROvSFQ/h5GqZHEO6QTFV3GhXm8p9BChz4U2lQkzwueYzXIRAgaTMQsi
        qntIzN2fxqqMuvSF0qvIHV1M++rcdiLPTwI1VBfHkRPz03hwcaDRZtHBOHOj/6f0aig==
X-Google-Smtp-Source: AMsMyM7POoLZgJ0iiyxp/rYwBN3R1eYgx9f8suId/16Nl5Lyg69rR7OW+hG4CEaIJbxGDgW92rplx25KtrXqOX8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:1596:b0:563:9a1a:b5b0 with SMTP
 id u22-20020a056a00159600b005639a1ab5b0mr15755486pfk.38.1666308353072; Thu,
 20 Oct 2022 16:25:53 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:25:29 +0000
In-Reply-To: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221020232532.1128326-4-calvinwan@google.com>
Subject: [PATCH v3 3/6] submodule: strbuf variable rename
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A prepatory change for a future patch that moves the status parsing
logic to a separate function.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index f7c71f1f4b..ac214f250d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1900,25 +1900,28 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
+		char *str = buf.buf;
+		const size_t len = buf.len;
+
 		/* regular untracked files */
-		if (buf.buf[0] == '?')
+		if (str[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-		if (buf.buf[0] == 'u' ||
-		    buf.buf[0] == '1' ||
-		    buf.buf[0] == '2') {
+		if (str[0] == 'u' ||
+		    str[0] == '1' ||
+		    str[0] == '2') {
 			/* T = line type, XY = status, SSSS = submodule state */
-			if (buf.len < strlen("T XY SSSS"))
+			if (len < strlen("T XY SSSS"))
 				BUG("invalid status --porcelain=2 line %s",
-				    buf.buf);
+				    str);
 
-			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+			if (str[5] == 'S' && str[8] == 'U')
 				/* nested untracked file */
 				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-			if (buf.buf[0] == 'u' ||
-			    buf.buf[0] == '2' ||
-			    memcmp(buf.buf + 5, "S..U", 4))
+			if (str[0] == 'u' ||
+			    str[0] == '2' ||
+			    memcmp(str + 5, "S..U", 4))
 				/* other change */
 				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
-- 
2.38.0.135.g90850a2211-goog

