Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD8ACE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjIYLVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjIYLUx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:20:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CD6DF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32008e339adso5768117f8f.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695640843; x=1696245643; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTC0H5bMqEvutVYdT1W8jB4c4FKMKzN/kGSamHxn0Nk=;
        b=bDRo0TJWjq9iLivXW2R6osi/4AV20HnnpwU+vpowFBLAHjEXk76HzyoAj7/8sJCFxF
         LgTWs3fS1H6juk044rovshPEzKhdGFdlsuVeupeKN4alZ29EE2nvb3Qt7sJGj0/yzg9U
         q5hVPWlFBmLfXWesNNfZHpHEsyVxb741EBwRoTiOcwx+EjAk65x8viVw8NRIIQCuIdZ5
         3aIp1bJV6OEIi/1lJdA0ahGnl+QNq0Sg/Zbd2pab5jDYiMoULRGPYWjyU1k4WDaduxvZ
         o8j4Bbtt5iGEij0ECP1S/vfECyc0TYngqGpyfj/1NL/yPm52SL9B23+ypSkjK80O994s
         SAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695640843; x=1696245643;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTC0H5bMqEvutVYdT1W8jB4c4FKMKzN/kGSamHxn0Nk=;
        b=Tue8+yBR3Z9lymt7EGG1VMCjdN5oy2M5umVsSwwOU4VxT4prP5vyLIirQkARMcbulB
         UW0ef1U3Qpdj+/OsEJ+9xh2dAcqROR2ik+CaDlPCRDoaMAMJ0Z9+TcfGOAsb5yxbQBs5
         NbeXjRkMtSxvwWrdVsivRC725ycAchxwIRMhfZYCajcInxmo+/V/pkuHMoFIkMF+0YGw
         YU3KtmuKDpzGdh+JFEXRbunVu9b4yKVDYyrMIP1DDS2gMsA8fkX4jwf2IgXmJn5B2tZr
         mQ6G4il1jP/+RtsfFg2Teojs3g3dj4D0YTyqgf7Hc6YTV4QqnOxiwEwP4vrLVe6QgsY/
         QplA==
X-Gm-Message-State: AOJu0Yzn9PxivpSUo0g0/37MYckLR+2lUWH0Lj+6aZFaHtGEgxOLjM6i
        XjdVTA1NYCxehBfkhJYCKsB+q3tCF4A=
X-Google-Smtp-Source: AGHT+IF32RxmpCJA+qMzYsQUs5e3kjf61xrl7BU6vmXPZd6+ll5e1nnE5D80gAdnZ73qZOQvlHgLhA==
X-Received: by 2002:adf:d4d1:0:b0:31f:f9fb:d5bd with SMTP id w17-20020adfd4d1000000b0031ff9fbd5bdmr5826352wrk.68.1695640843481;
        Mon, 25 Sep 2023 04:20:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bo12-20020a056000068c00b00323287186b2sm2593271wrb.29.2023.09.25.04.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:20:43 -0700 (PDT)
Message-ID: <f0b804129e8a21449cbb6f346473d3570182ddfa.1695640837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
References: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
        <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:20:32 +0000
Subject: [PATCH v3 3/7] unit-tests: do show relative file paths
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

