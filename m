Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB18C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjAQVGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjAQVFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:05:16 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F8E442CB
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:24 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k5-20020a170902c40500b001947b539123so7030380plk.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rZ466JhVR5XM57QkszJq3kGwqA/2fSr9kRJYjghQas=;
        b=YVXG8kAI1kbyCxFzWy42ptmGXIAt8GjT7xCzHQP7s81Ya6G4I1ZWe/PNz4r+ZEmHob
         sWPOfEPOiGf/pxEIU5yxTWPZXvuBG0weg3HwrHS48BGBnRq9Y2NyRHVQXjrKndZz9Prb
         nOdfl2KLmkyBjQPGTZPIMwToceBsMoZlMum9CJ20vnMXz6HZD7EEXdX1h2CeMyCagBIz
         OAprnQoD/XQqN3kqZDfrbZm2bp59F9ajeklzMnQXqZPfmQRt83yRvG1JFd/9xP5tAwbu
         FtbR9/TMDCqqvXaj16FA3ajHkUPvIQPDoC3EnOzxewNpyJ3m5TUqgy05UTdnYseFZySP
         czwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rZ466JhVR5XM57QkszJq3kGwqA/2fSr9kRJYjghQas=;
        b=v9vKU79tiCBTEczyuJONdfak/ucoh2OhaSIzfTl6YUjT+PwlywxYx8fL26z2nUWbeU
         ekLGn34gm8C0ZpsTaY8IEWA1qMx77YO6zsrvdKwDBmdaVnDgRDggiufwOhIEvywyB44h
         VOF3cIx4Zp9qB6ezFARhs0HBEiwAoxiz42OR9VT8wc+gV2Wff8nhbJj6OVNEpdl8zqfo
         9vQslxjygZeY7qjczT/saeg2+aDfMv2mAfzH8TjityYZGNkLIL8B49ffADluZlW/qJOp
         Hm+2D/+mkCHVyCShk5kwI42vOueoO32145C+gZJ6i+kT0W9tg3aL9buLAIehWaXAs51P
         ujRQ==
X-Gm-Message-State: AFqh2kqOQmS/nlRp3/Kepl+eiqdsZVN18Xfz4AOGXJ1HmYSvgK2PU+31
        S5HXoeYVGD0q9FKSK5vhY91j8zc+kVYDHc9gOUZXzKeMbES3vS10NmMrO/N3kmbq1Y5R22cwK4V
        anrAn6+mE4bqiUNfY8cueT90xqIn4O9hFDEtzwxdXG/YO6+mO70k7j+o0FlsBuc6ZHw==
X-Google-Smtp-Source: AMrXdXvEUcf5eAHNDR/2h4yrMTTtLPw3nas8aZHn1hkyuDP1U/Z3N6ecNiTjxycyFsn85I1osrSE6z7sI9RpXHw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:2a04:b0:57f:ef13:63aa with SMTP
 id ce4-20020a056a002a0400b0057fef1363aamr372389pfb.42.1673983883703; Tue, 17
 Jan 2023 11:31:23 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:30:38 +0000
In-Reply-To: <20230104215415.1083526-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230117193041.708692-4-calvinwan@google.com>
Subject: [PATCH v6 3/6] submodule: move status parsing into function
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future patch requires the ability to parse the output of git
status --porcelain=2. Move parsing code from is_submodule_modified to
parse_status_porcelain.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 74 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/submodule.c b/submodule.c
index faf37c1101..768d4b4cd7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1870,6 +1870,45 @@ int fetch_submodules(struct repository *r,
 	return spf.result;
 }
 
+static int parse_status_porcelain(char *str, size_t len,
+				  unsigned *dirty_submodule,
+				  int ignore_untracked)
+{
+	/* regular untracked files */
+	if (str[0] == '?')
+		*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+	if (str[0] == 'u' ||
+	    str[0] == '1' ||
+	    str[0] == '2') {
+		/* T = line type, XY = status, SSSS = submodule state */
+		if (len < strlen("T XY SSSS"))
+			BUG("invalid status --porcelain=2 line %s",
+			    str);
+
+		if (str[5] == 'S' && str[8] == 'U')
+			/* nested untracked file */
+			*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+		if (str[0] == 'u' ||
+		    str[0] == '2' ||
+		    memcmp(str + 5, "S..U", 4))
+			/* other change */
+			*dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+	}
+
+	if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+	    ((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
+	     ignore_untracked)) {
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
@@ -1909,39 +1948,10 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		char *str = buf.buf;
 		const size_t len = buf.len;
 
-		/* regular untracked files */
-		if (str[0] == '?')
-			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-		if (str[0] == 'u' ||
-		    str[0] == '1' ||
-		    str[0] == '2') {
-			/* T = line type, XY = status, SSSS = submodule state */
-			if (len < strlen("T XY SSSS"))
-				BUG("invalid status --porcelain=2 line %s",
-				    str);
-
-			if (str[5] == 'S' && str[8] == 'U')
-				/* nested untracked file */
-				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-			if (str[0] == 'u' ||
-			    str[0] == '2' ||
-			    memcmp(str + 5, "S..U", 4))
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
+		ignore_cp_exit_code = parse_status_porcelain(str, len, &dirty_submodule,
+							     ignore_untracked);
+		if (ignore_cp_exit_code)
 			break;
-		}
 	}
 	fclose(fp);
 
-- 
2.39.0.314.g84b9a713c41-goog

