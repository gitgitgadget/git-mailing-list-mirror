Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576F9C83F29
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbjHaGPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245498AbjHaGPl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:15:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE871B1
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:15:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c8321c48fso1014271f8f.1
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693462537; x=1694067337; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCpO5pAarNmiyuSK1OM1qsJ+J6eOpqRcws5AlytjMls=;
        b=ZgIivmNiGQNQrjKzlCAB63EENp+/XWUC+nRoiv1Yk22+m7PVapRoMcbsv5Tq4UzN/U
         kcGBIR8hGRX4FWpamdR+b9n38axC7kb/d+fl492kktP3y/b6RxLj85dvYgwdrgk6YkWK
         9QscoUSdXgy78UPxJ/pbQ40BrAFlz97HZE/8lkNT4INAxBVM4B4QV7foiUz1Ma0Ibavc
         HaeNfSmJe6xiVJRssA1c4vCeisz5vFaAThEm+zKxYzhgmZc51NO8GErpnRr56R5CN9Bi
         OF4zVeLR7bU+rZ9ZBXhqoYC8et4cy5YoiUcpfye5CNF+dypSHNSem+MiIZP6dT3Py208
         4Z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693462537; x=1694067337;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCpO5pAarNmiyuSK1OM1qsJ+J6eOpqRcws5AlytjMls=;
        b=Udhi0NAUAKqXa0ZHhtdQWwFMAnrsmjapbXllzLaGtOspsU79a7wFSp6sfw/VozsgzD
         nS7Mw4EdJSFlYhbmaGVSJ/L7zjn3Ma83pwsFolHILRNt4s1CpH21GZiisQUNsXijdlgu
         qjehfsszUckIPIAVNui4gZvBzCMnxvM2WHtJdNNQkSQTHuNrV61QogosNMZJQkovnQcH
         EoI5VUMBqccXS/9U/w3lQ74s0VxqcQAoNtKqQ5hEihlSeOYXoxwRwF9pnh6ftI2/e7JG
         IssAHArT9lLrpUDWSOAtFalC25mgIEgBtQ1ao/k5GWkls+UmVvGL7dobYK61GQyk6CPT
         KokQ==
X-Gm-Message-State: AOJu0YwvVgJmJbLRLMUMWtnjBqQpyxbZT6lLs+C1RJjDQR1Sj1CZ3vRN
        wzXSv6TrlOSZQtSUQDjvJTP1S5oz9ao=
X-Google-Smtp-Source: AGHT+IH3kDN+XPYX2V8OCBRtxI6lSX1UfwU/7QxWsSZgve75AvZxl78UZrCrJJpoV6qtVPUvPQ+Bog==
X-Received: by 2002:a5d:4746:0:b0:317:dadc:4a63 with SMTP id o6-20020a5d4746000000b00317dadc4a63mr1135050wrs.8.1693462536910;
        Wed, 30 Aug 2023 23:15:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fe1fe56202sm908486wmi.33.2023.08.30.23.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 23:15:36 -0700 (PDT)
Message-ID: <2b4e36c05c9e01b1e489100531fd01515b0786ab.1693462532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Aug 2023 06:15:31 +0000
Subject: [PATCH 3/4] unit-tests: do show relative file paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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
 t/unit-tests/test-lib.c | 48 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 70030d587ff..bd94079af61 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -21,6 +21,42 @@ static struct {
 	.result = RESULT_NONE,
 };
 
+#ifndef _MSC_VER
+#define make_relative(location) location
+#else
+/*
+ * Visual C interpolates the absolute Windows path for `__FILE__`,
+ * but we want to see relative paths, as verified by t0080.
+ */
+#include "strbuf.h"
+#include "dir.h"
+
+static const char *make_relative(const char *location)
+{
+	static const char *prefix;
+	static size_t prefix_len;
+	static struct strbuf buf = STRBUF_INIT;
+
+	if (!prefix) {
+		strbuf_addstr(&buf, __FILE__);
+		if (!strbuf_strip_suffix(&buf, "\\t\\unit-tests\\test-lib.c"))
+			die("unexpected suffix of '%s'");
+		strbuf_complete(&buf, '\\');
+		prefix = strbuf_detach(&buf, &prefix_len);
+	}
+
+	/* Does it not start with the expected prefix? */
+	if (fspathncmp(location, prefix, prefix_len))
+		return location;
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, location + prefix_len);
+	convert_slashes(buf.buf);
+
+	return buf.buf;
+}
+#endif
+
 static void msg_with_prefix(const char *prefix, const char *format, va_list ap)
 {
 	fflush(stderr);
@@ -147,7 +183,8 @@ int test__run_end(int was_run UNUSED, const char *location, const char *format,
 			break;
 
 		case RESULT_NONE:
-			test_msg("BUG: test has no checks at %s", location);
+			test_msg("BUG: test has no checks at %s",
+				 make_relative(location));
 			printf("not ok %d", ctx.count);
 			print_description(format, ap);
 			ctx.result = RESULT_FAILURE;
@@ -193,13 +230,15 @@ int test_assert(const char *location, const char *check, int ok)
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
@@ -224,7 +263,8 @@ int test__todo_end(const char *location, const char *check, int res)
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

