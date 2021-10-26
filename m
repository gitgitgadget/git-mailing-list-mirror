Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76995C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E83560ED4
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhJZBGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 21:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhJZBGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 21:06:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA29C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 18:03:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so425964wmz.2
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 18:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NlV+ScU01TU00QqwqArai/GP1+nu+af5ZDzy8gmO3vA=;
        b=pSeqLy9wMi3WqNx/NmxqcTi7f1Rp9kW8YZrYEvkLgK0RgUpyHScspvytebAd6dkVRL
         AscAUV/HQZNSpV/SZZJIvVzebCFW1Gl16yB9woBL90hzQs9UW4abQbKVRWhyyYV3ruxJ
         oJNuJhVHMLgsq4bsJ+bc2e1mVPtyEJ/KXkzMI8cJxtoVt9O7c4QdoctuX+FPDhK3W3zR
         P3BLNcZymjKSwiTq67f5c1jx/MuPSSeEJM8m1SHzlWP/oFj8jhCEVYkmfWSpmcC8C64M
         Kc4BEre5BzvKD6NI363xlr5movrhJeVHm2mq1VQHAEpuTB13TQSW8eAPliR/wkO3tYZK
         1MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NlV+ScU01TU00QqwqArai/GP1+nu+af5ZDzy8gmO3vA=;
        b=8MM3AKJCiIfwW6+msJXC0jiaN8/3/DP7h26gNaGTirChRdXTFBCtt0G8LgDYDwDWue
         hzYTHLNOlm607a4pTgCFrDF82APXWLjRI8EGKWmKM3izoilz4cDdm3M8+ZiroNVdqzUK
         JRZCkI47FB4NqYSggzu3DKEqiD89K/6abeyzXyoUuMOdYpsjNaXzfqXKG+PlILgk07Fr
         s9okWKm42RoAsOlf+9k6a/sjwhkAP9cbPxTitaotdA4Z9Fu4740RDyyqJZy0ItV7hKcV
         NHjzoo+GZI6rWuJkK0n54Zp6n8v/OcaXFiRHoSxDIsqGHqrzPLh39dt3IhVcnfaMO3ED
         t0Jw==
X-Gm-Message-State: AOAM530clEZKhatwLsuIZdTm1hVQ8aFR2SGoMfTwUjXmL+z4Felp0Fe9
        4k64027kppEp8iA1cOsOpPYz3cbcTzg=
X-Google-Smtp-Source: ABdhPJwgVGx14wr6Zl00GWBWbkJFLQoX3efEO3z3exnmp8ARVu7bDlI2BOybc6LxKtttyBWkrGIwfw==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr9162460wmj.34.1635210228768;
        Mon, 25 Oct 2021 18:03:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm596559wmj.22.2021.10.25.18.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 18:03:48 -0700 (PDT)
Message-Id: <pull.1117.git.git.1635210227532.gitgitgadget@gmail.com>
From:   "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Oct 2021 01:03:47 +0000
Subject: [PATCH] color: allow colors to be prefixed with "reset"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Estelle <robertestelle@gmail.com>

"reset" was previously treated as a standalone special color name
representing `\e[m`. Now, it can apply to other color properties,
allowing exact specifications without implicit attribute inheritance.

For example, "reset green" now renders `\e[;32m`, which is interpreted
as "reset everything; then set foreground to green". This means the
background and other attributes are also reset to their defaults.

Previously, this was impossible to represent in a single color:
"reset" could be specified alone, or a color with attributes, but some
thing like clearing a background color were impossible.

There is a separate change that introduces the "default" color name to
assist with that, but even then, the above could only to be represented
by explicitly disabling each of the attributes:
  green default no-bold no-dim no-italic no-ul no-blink no-reverse no-strike

Signed-off-by: Robert Estelle <robertestelle@gmail.com>
---
    color: allow color specs to be prefixed by "reset"
    
    The pseudo-attribute "reset", which was previously treated as a
    standalone special color name, can now be combined with other color
    properties.
    
    This allows specification of an "entire" text style without implicitly
    inheriting existing properties (colors, bold/italic/etc) nor requiring a
    comprehensive clearing of each of them.
    
    For example, "reset green" now renders \e[;32m, which is interpreted as
    "default properties; then set foreground to green".
    
    Previously, it was not possible to represent this in a single color due
    to inability to clear the foreground or background (at best, they could
    be overridden to a some explicit value). There is a complementary
    proposed change (color: support "default" to restore fg/bg color,
    https://lore.kernel.org/git/pull.1116.git.git.1635201156.gitgitgadget@gmail.com/,
    https://github.com/git/git/pull/1116) which introduces the "default"
    color name to facilitate that, but even then, the above would still
    require disabling each of the attributes explicitly: green default
    no-bold no-dim no-italic no-ul no-blink no-reverse no-strike
    
    This is useful in scenarios that the "reset" word or any of the "no-"
    attribute modifiers might have been used before, e.g.
    colors.diff-highlight.newReset.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1117%2Frwe%2Freset-color-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1117/rwe/reset-color-v1
Pull-Request: https://github.com/git/git/pull/1117

 Documentation/config.txt |  5 +++++
 color.c                  | 18 +++++++++++-------
 color.h                  |  1 +
 t/t4026-color.sh         |  4 ++++
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf82766a6a2..b1423b6ce8b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -280,6 +280,11 @@ The position of any attributes with respect to the colors
 be turned off by prefixing them with `no` or `no-` (e.g., `noreverse`,
 `no-ul`, etc).
 +
+The pseudo-attribute `reset` resets all colors and attributes before
+applying the specified coloring. For example, `reset green` will result
+in a green foreground and default background without any active
+attributes.
++
 An empty color string produces no color effect at all. This can be used
 to avoid coloring specific elements without disabling color entirely.
 +
diff --git a/color.c b/color.c
index 64f52a4f93a..29ac83b2d6e 100644
--- a/color.c
+++ b/color.c
@@ -234,6 +234,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	const char *ptr = value;
 	int len = value_len;
 	char *end = dst + COLOR_MAXLEN;
+	unsigned int has_reset = 0;
 	unsigned int attr = 0;
 	struct color fg = { COLOR_UNSPECIFIED };
 	struct color bg = { COLOR_UNSPECIFIED };
@@ -248,12 +249,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 		return 0;
 	}
 
-	if (!strncasecmp(ptr, "reset", len)) {
-		xsnprintf(dst, end - dst, GIT_COLOR_RESET);
-		return 0;
-	}
-
-	/* [fg [bg]] [attr]... */
+	/* [reset] [fg [bg]] [attr]... */
 	while (len > 0) {
 		const char *word = ptr;
 		struct color c = { COLOR_UNSPECIFIED };
@@ -270,6 +266,11 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			len--;
 		}
 
+		if (match_word(word, wordlen, "reset")) {
+			has_reset = 1;
+			continue;
+		}
+
 		if (!parse_color(&c, word, wordlen)) {
 			if (fg.type == COLOR_UNSPECIFIED) {
 				fg = c;
@@ -295,13 +296,16 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	*dst++ = (x); \
 } while(0)
 
-	if (attr || !color_empty(&fg) || !color_empty(&bg)) {
+	if (has_reset || attr || !color_empty(&fg) || !color_empty(&bg)) {
 		int sep = 0;
 		int i;
 
 		OUT('\033');
 		OUT('[');
 
+		if (has_reset)
+			sep++;
+
 		for (i = 0; attr; i++) {
 			unsigned bit = (1 << i);
 			if (!(attr & bit))
diff --git a/color.h b/color.h
index 98894d6a175..684dbd3bceb 100644
--- a/color.h
+++ b/color.h
@@ -6,6 +6,7 @@ struct strbuf;
 /*
  * The maximum length of ANSI color sequence we would generate:
  * - leading ESC '['            2
+ * - reset ';' .................1
  * - attr + ';'                 2 * num_attr (e.g. "1;")
  * - no-attr + ';'              3 * num_attr (e.g. "22;")
  * - fg color + ';'             17 (e.g. "38;2;255;255;255;")
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index c0b642c1ab0..5ef2ff28c48 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -58,6 +58,10 @@ test_expect_success 'fg bg attr...' '
 	color "blue bold dim ul blink reverse" "[1;2;4;5;7;34m"
 '
 
+test_expect_success 'reset fg bg attr...' '
+	color "reset blue bold dim ul blink reverse" "[;1;2;4;5;7;34m"
+'
+
 # note that nobold and nodim are the same code (22)
 test_expect_success 'attr negation' '
 	color "nobold nodim noul noblink noreverse" "[22;24;25;27m"

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
gitgitgadget
