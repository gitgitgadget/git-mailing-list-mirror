Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427C5C4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 23:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJKX0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJKX0e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 19:26:34 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C86F27F
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 16:26:33 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q62-20020a17090a17c400b0020d334fbe19so208434pja.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 16:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GBf67QctDHdO8OijIMWU7F0vySW5T0Zas2xcFHPJo7o=;
        b=MZnBaGRS0w5LWAAYQ6QT4fNWso78H6sp45GXO/l6Ozfu3AMjcoLuFSsZP/UKogRpJ1
         PafLdWthNHCUclWUFObqKcH7nVaQASxCZLaZdekSp1EJryAAa9g77Zey7RvC6FFGTv/W
         ds4LzfJToHni0csmFGv29vbvupoPA71+JdN2XD5ncRzqARvpS01LBjDLb1I/bgtNuBki
         5QS0Yp+VP3MuLhye5Gr8rSh7A90duwgPxQN7RL6LyVHEbHGbZbCQWHapQhkkje0UwaRU
         QjR6yT4juZE1KCQygbbgubKUhQhXNX0zuX1jtAl66IgRp5y45doKD5UHI20dekW9tWZW
         r5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBf67QctDHdO8OijIMWU7F0vySW5T0Zas2xcFHPJo7o=;
        b=gpdIZaFJ7YQJxUd7TTnsLfIMY5iSGDKbaYsuC5JyhX/EqIzIpEBqlOjumjDzFqIN+D
         a45RwzBfv+2RgInjpbqa8lGg2ilbS86sWG5QRjTiSoneHVcfkE0q/cqdNR7o3fReWa/r
         Dn2onpHgYLjPsr7zlOFl0Q8Dj0CxX8bD7ynEQ7sRNVsJq4vm3LhVeL2dj5rKVWjU4yS/
         aHomoPNY/cS3qHQcZ2gzP6OqsOLYhprPMY8hhCtxcvBNDJ31QsB2e0fsScDBHgK42sy6
         ve1KN02E08aGnF0aGKg2oPRzQgTkQFMvsB92bYfMcMvAtK3ZzjHqzNdF8GgeKiSzYfyR
         UsxQ==
X-Gm-Message-State: ACrzQf2mHKaXmthvVFRiLGDMxwNUKga9P0oxVPc/ym13IZW1w0w4JgdZ
        qkq/7cL9qhWUVvFWv+iptJjubdy5RSiJGbIzmTvSm9i2RBcjeNXCCJa/e8ykjtUcuU0mchpwozj
        z0eM46OTgGxh1WFuCs6qZfsyLjeTT2Wukpp4r1h/8BGMvJCxKzq0+nba3VWwKP8qOnA==
X-Google-Smtp-Source: AMsMyM6p/JY4ZMW8ElJAvkpA6rWXRcbqyM3NaPNmDxkvKjdjPcRUc0tG7ko/GW0MzIzR6pQ+EGp5r0wsZ2poANk=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:891:b0:565:85a7:a6e with SMTP
 id q17-20020a056a00089100b0056585a70a6emr3042509pfj.21.1665530792985; Tue, 11
 Oct 2022 16:26:32 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:26:02 +0000
In-Reply-To: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011232604.839941-3-calvinwan@google.com>
Subject: [PATCH v2 2/4] submodule: move status parsing into function
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future patch requires the ability to parse the output of git
status --porcelain=2. Move parsing code from is_submodule_modified to
parse_status_porcelain.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 71 +++++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/submodule.c b/submodule.c
index 72b295b87b..a3410ed8f0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1864,6 +1864,43 @@ int fetch_submodules(struct repository *r,
 	return spf.result;
 }
 
+static int parse_status_porcelain(char *buf, unsigned *dirty_submodule, int ignore_untracked)
+{
+	/* regular untracked files */
+	if (buf[0] == '?')
+		*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+	if (buf[0] == 'u' ||
+		buf[0] == '1' ||
+		buf[0] == '2') {
+		/* T = line type, XY = status, SSSS = submodule state */
+		if (strlen(buf) < strlen("T XY SSSS"))
+			BUG("invalid status --porcelain=2 line %s",
+				buf);
+
+		if (buf[5] == 'S' && buf[8] == 'U')
+			/* nested untracked file */
+			*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+		if (buf[0] == 'u' ||
+			buf[0] == '2' ||
+			memcmp(buf + 5, "S..U", 4))
+			/* other change */
+			*dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+	}
+
+	if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+		((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
+		ignore_untracked)) {
+		/*
+		* We're not interested in any further information from
+		* the child any more, neither output nor its exit code.
+		*/
+		return 1;
+	}
+	return 0;
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1900,39 +1937,9 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
-		/* regular untracked files */
-		if (buf.buf[0] == '?')
-			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-		if (buf.buf[0] == 'u' ||
-		    buf.buf[0] == '1' ||
-		    buf.buf[0] == '2') {
-			/* T = line type, XY = status, SSSS = submodule state */
-			if (buf.len < strlen("T XY SSSS"))
-				BUG("invalid status --porcelain=2 line %s",
-				    buf.buf);
-
-			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
-				/* nested untracked file */
-				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-			if (buf.buf[0] == 'u' ||
-			    buf.buf[0] == '2' ||
-			    memcmp(buf.buf + 5, "S..U", 4))
-				/* other change */
-				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-		}
-
-		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
-		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
-		     ignore_untracked)) {
-			/*
-			 * We're not interested in any further information from
-			 * the child any more, neither output nor its exit code.
-			 */
-			ignore_cp_exit_code = 1;
+		ignore_cp_exit_code = parse_status_porcelain(buf.buf, &dirty_submodule, ignore_untracked);
+		if (ignore_cp_exit_code)
 			break;
-		}
 	}
 	fclose(fp);
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

