Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE27CD13D9
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjIRUym (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjIRUyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:54:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1540C111
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31f737b8b69so4783602f8f.3
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070471; x=1695675271; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTC0H5bMqEvutVYdT1W8jB4c4FKMKzN/kGSamHxn0Nk=;
        b=L17tG0toUsfcLjUvJxHmcFSdGj8LFQ0+FJJSjVHagFPFFAH4tsZz+1hA3mKxXS/5qZ
         /pg34xhMUkf/fL/HBEhbSDfq+VQ/WSS0RCp929TdEIIbf8DX32Vhm7ksB5zdUjoUXaHR
         TqUEU2k5wEzcduMIC8UnqGiHrJ+F03/V3Oju2rE+XzcmCMBsdpoNP/XK0FqJQXdfzX1B
         oOZaCNo5//tUQuhxf5zbmwbkMzerDExo2DOyO8xFrOfvHqn4U/BzWXU9/Peey1HjK46l
         E0ReQ9/k2KLuxGJL1xBCxbeNPVzF/VgRPXi3k8hr71U0frhBgAjv7zUcfsiYH44WW9Lr
         d5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070471; x=1695675271;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTC0H5bMqEvutVYdT1W8jB4c4FKMKzN/kGSamHxn0Nk=;
        b=OVfBCSkBMo7nej+0vUr2y+KoGy1mr8pDnf9MPX3TnrKH+daDo7Com56FUVfl1Ft49N
         SaHsLXDpit5U7dNThFWeYaelUDFieG260BBms45P+xPw7HgER7YkgAAFzyL63s39ueY4
         u6VQN4jVGMrInvtSZ6gY+IgtumSP4e9MMbmuIMn+XKYtlpIHuuRUanQ5y91oh7KUwr7X
         c8J/LWr7ETCcuwb1173r6je+WWOIlJOvkfa9R6wnmhuXzpr7WOj4SzVseIBlrA4yjRSJ
         +gCdvFrTGhbCEk1/WdwBTrift4a+z6flWpr4OQR4qPfVsPDZmdIB26Ak/VIzH/A2cxqV
         IeBg==
X-Gm-Message-State: AOJu0YwrkWobTMdVv2Y+EWzxOB1p0Pl6YBRDTPJjaF/jifm0zPO68F3f
        kyZ+w8PW5cIZn2CzjfB1fDN0vFgabBo=
X-Google-Smtp-Source: AGHT+IFuNOVyY2585d7sNysQvfJ2GFh3ULbe8xWMG3amDwVux4t/oysIbxMbwIH+ZoHTbT43i0iflQ==
X-Received: by 2002:adf:b197:0:b0:320:7272:8fbe with SMTP id q23-20020adfb197000000b0032072728fbemr3556218wra.17.1695070471135;
        Mon, 18 Sep 2023 13:54:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020adfd0c2000000b0030ada01ca78sm2527141wrh.10.2023.09.18.13.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:54:30 -0700 (PDT)
Message-ID: <f0b804129e8a21449cbb6f346473d3570182ddfa.1695070468.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
        <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 20:54:24 +0000
Subject: [PATCH v2 3/7] unit-tests: do show relative file paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Visual C interpolates `__FILE__` with the absolute _Windows_ path of
the source file. GCC interpolates it with the relative path, and the
tests even verify that.

So let's make sure that the unit tests only emit such paths.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/unit-tests/test-lib.c | 52 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 70030d587ff..744e223ee98 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -21,6 +21,46 @@ static struct {
 	.result = RESULT_NONE,
 };
 
+#ifndef _MSC_VER
+#define make_relative(location) location
+#else
+/*
+ * Visual C interpolates the absolute Windows path for `__FILE__`,
+ * but we want to see relative paths, as verified by t0080.
+ */
+#include "dir.h"
+
+static const char *make_relative(const char *location)
+{
+	static char prefix[] = __FILE__, buf[PATH_MAX], *p;
+	static size_t prefix_len;
+
+	if (!prefix_len) {
+		size_t len = strlen(prefix);
+		const char *needle = "\\t\\unit-tests\\test-lib.c";
+		size_t needle_len = strlen(needle);
+
+		if (len < needle_len || strcmp(needle, prefix + len - needle_len))
+			die("unexpected suffix of '%s'", prefix);
+
+		/* let it end in a directory separator */
+		prefix_len = len - needle_len + 1;
+	}
+
+	/* Does it not start with the expected prefix? */
+	if (fspathncmp(location, prefix, prefix_len))
+		return location;
+
+	strlcpy(buf, location + prefix_len, sizeof(buf));
+	/* convert backslashes to forward slashes */
+	for (p = buf; *p; p++)
+		if (*p == '\\')
+			*p = '/';
+
+	return buf;
+}
+#endif
+
 static void msg_with_prefix(const char *prefix, const char *format, va_list ap)
 {
 	fflush(stderr);
@@ -147,7 +187,8 @@ int test__run_end(int was_run UNUSED, const char *location, const char *format,
 			break;
 
 		case RESULT_NONE:
-			test_msg("BUG: test has no checks at %s", location);
+			test_msg("BUG: test has no checks at %s",
+				 make_relative(location));
 			printf("not ok %d", ctx.count);
 			print_description(format, ap);
 			ctx.result = RESULT_FAILURE;
@@ -193,13 +234,15 @@ int test_assert(const char *location, const char *check, int ok)
 	assert(ctx.running);
 
 	if (ctx.result == RESULT_SKIP) {
-		test_msg("skipping check '%s' at %s", check, location);
+		test_msg("skipping check '%s' at %s", check,
+			 make_relative(location));
 		return 0;
 	} else if (!ctx.todo) {
 		if (ok) {
 			test_pass();
 		} else {
-			test_msg("check \"%s\" failed at %s", check, location);
+			test_msg("check \"%s\" failed at %s", check,
+				 make_relative(location));
 			test_fail();
 		}
 	}
@@ -224,7 +267,8 @@ int test__todo_end(const char *location, const char *check, int res)
 	if (ctx.result == RESULT_SKIP)
 		return 0;
 	if (!res) {
-		test_msg("todo check '%s' succeeded at %s", check, location);
+		test_msg("todo check '%s' succeeded at %s", check,
+			 make_relative(location));
 		test_fail();
 	} else {
 		test_todo();
-- 
gitgitgadget

