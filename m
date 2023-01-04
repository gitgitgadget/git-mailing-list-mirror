Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82CFC53210
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 21:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbjADVzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbjADVys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 16:54:48 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF61EAD6
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 13:54:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-434eb7c6fa5so360700847b3.14
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 13:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rZ466JhVR5XM57QkszJq3kGwqA/2fSr9kRJYjghQas=;
        b=RTmjeRr+Uh3+Kre+Afxv1DkO/Gj0KrndnRZIqN50ZIUZsxoTVp8x2yhf0VharQM0Uo
         F9U5OhG1wGB/m+MHBfTuzbQG2qrQ3U4TRQXuYwH9MVVjjGFlpdotg80c2Gl8xzYgIaOW
         98S//4cq/hf+rM4hJdwI7zah19K6Dn/nekfs/Olp6d7rsNZHEuQiasMOZy1u61AEvPOX
         USVVjYlHFOyAyQ1+EPtr55raxrgO+f2XxeAvkZ9SwVEp7Wx4pj9ZLdkElbVhN+6fkWCO
         /4L0hYJkK4Eo9tuTXjNi0AbiryMxFjZ+fsW3LyeahnwhVg6q0n99KwWpDnGBQDmKGmB5
         pBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rZ466JhVR5XM57QkszJq3kGwqA/2fSr9kRJYjghQas=;
        b=bP4K1fpyxBX+w0f+nDLo2HgiWewYPtamRf7rAnb1bWTOnIr8etfydvrs74ajtum7F/
         quipICdwT30j8eTCZX+nRCZLBL0yHzAJfYQqoOUkUnFjuwyNM4A0+BVgRDHMjIoGgx7g
         TlIpsLxp3UnlDn/LY35bttKjJMcM9MSMoc2OXj3X4iscx1hLQrL1AmkrIYxpL/sqrzUF
         wQrdWg2vS9sNLn9/XHXWMfBfpisB1C1lYwFAMiWJebd2+WZmtYALcAbzBoFuy9HLXUma
         ZnV4+PGMhWidYQuqEm9zXXZQkDaU3PFgwIgijcxrqCzjB0qdYcDmc1vI7S4eHDRMZN48
         qjqA==
X-Gm-Message-State: AFqh2kqsELYAU9ACW5Z9MfPhUYqCyzS553+MEqxpdiTwj00GuvVQKYkJ
        sNFr9iHjotQBSB+nF0jvNdnTK+GyWTHkagNfxnBrX/gW2glVAiDqU8GgCCSyGb0AwwDwepaTga/
        0UANhQkVBJkLFtnt3gw8vrW51eP4xZid5k0dglDbGgl7cK3bJQVbgTkA7SGR6DfyCyw==
X-Google-Smtp-Source: AMrXdXvrVpOl6R7fAvYvMK8+zfINGGNin0yyjEEFKM4gJoWqqrQ5fPRxs+RpQzoDXmW0LT3Sf+A5E193HmoL6FU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:690c:444:b0:3fe:dd73:15df with SMTP
 id bj4-20020a05690c044400b003fedd7315dfmr6506213ywb.331.1672869286285; Wed,
 04 Jan 2023 13:54:46 -0800 (PST)
Date:   Wed,  4 Jan 2023 21:54:12 +0000
In-Reply-To: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104215415.1083526-4-calvinwan@google.com>
Subject: [PATCH v5 3/6] submodule: move status parsing into function
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

