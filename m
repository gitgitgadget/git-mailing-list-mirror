Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C881732
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 04:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751171313; cv=none; b=RVQHbr0Ibh5BJk+4iW/uC5srrF64rOi4hT5MGc+c++sTjkPh1ghZnfHv0yZEvtzlsX85K6XDd4cBKjhXM9uComTrLxbbk/gfX1NS0KFQsxDZ15OjmrtQYtHihnjzv1CJvxJx+vPUQfuTf1ZhtxBjIPR2F4v3QMvcmGkICXFLbEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751171313; c=relaxed/simple;
	bh=wl+j+E1t8r5zg8cm6SoyXmpAGC0gJDWT9829u1Ssxcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpIXL7P+uiVmKvAMt43JcF9NedtZeFRw2SP982JTVcsEnV0AABxChK5JkdIcNhDMdUjDb06SKPF5JM2JF4FEunawIidRw17oqy4kry1CuC73/mNG88GJUSLRcziEVWy44tJjC8+wZEamOkEgWAto9axRUrI48JnN6GxHva99n3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4zbfGBX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4zbfGBX"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74931666cbcso3660930b3a.0
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 21:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751171310; x=1751776110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJJnMKHNbxCFrDcYaNG8TsQjaey2b5tMqxZcFdyxqRY=;
        b=B4zbfGBX7ZVKAjuYV6IbB6u4lVgwSf16Uke1h7t6xgRuyngU/gNVqUEeMLC8FThLB7
         mPlCMdZH0Q9u9MleRpiONuh85qpGjacauPNLZtxmaaqkTIv2QR6IkzLGb9oBfQfCWRM+
         PSMUq77enk6l1SH0pRyznyJCBjYfQVlXNWCpyB9E3BJCU5Pxg/IQXK9eswU9QHmgttc9
         6dLmQWPKn59v9AojMpah2TMtnd1IIwjKrfKgPT1gvju1bqBkQYYHjINA9OJxAcJlGy7E
         RElCFoft0OjQYyD0snVCyVsZkaNyTfRFdeYISqX+ryzgKFlGqZGKOIrN6dXNPS1wDPB8
         pb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751171310; x=1751776110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJJnMKHNbxCFrDcYaNG8TsQjaey2b5tMqxZcFdyxqRY=;
        b=B/4PfWavN+iHvv4c6nPmGUdHothxieBmDQvvzWbo0TM48dHT1W7JM4gamgsT64Nym3
         rUv03ziAi2cjGD7tdtWeajahrYIFnltSbPBHBeM7CSbG5PFlmRx6YjnveJaxXocE4BrN
         d0iYlgT1SXMxqW8b2Ds6+pT6lRORFxjojCJcK/ZAN3EltnlvebI7/A/yt/ePRjzm3Gni
         nWRh4SxABZCvsu6SjgESZE2IdYZ6CFPAYw75n7xqVgbCFWEOGTHDdPcbgJQ9YmBkKZhh
         58elCKt+Qd71WTXWRMe+VNQ5xdmXWuLCpjTEu4R23GlmISACTPSI5xy4UOnC9JK6FSVk
         YHSg==
X-Gm-Message-State: AOJu0YxZrkeURpjvI02pOXPemc7JjCVPh4CRCK5z5eNJHxQ4SCbVymP6
	fTykYWsiL1TvyLUKUyCYoQbJPQZUfPJ+0ZKuyDei26TigecUiN+AVx+xdnyy9Q==
X-Gm-Gg: ASbGnctin+esYnjJRZVqwij7IpFHctqrV/2FAswtGbOFqkH21Kx+A8Oq6qZaQ6OY9jC
	JoBvKsQnQgd+3xiR2xaeLD2GUXb1JsOUrpb6lhh6GYLTM5Q5hEfxNpi/pLYwg51N3LjRyTT2KlL
	PY4dQvxlMO7bBGw6Oqrzcb1P/uqdd9o86XdoGHtDBi/SYlHoSZv+SB1+1EOV/QLR5LBqQbbI8RC
	YR7vs86Ao+ZWTcfWFK7cr6K+qzya8vvjGVVeNua5ytEhyUa3wteYdx9asMVx0oeJj+CBZHYN42F
	CjVUlpt7HNHeQtTrAr6pH4C4RzimnUWXt8XWL1fp0reGrkR+DEChGsCOY4ryY2rpEILT
X-Google-Smtp-Source: AGHT+IFfcgZQRF1dcqB6d/DRQZkJcAMgA0412rcwEskozwWOJAK/2MRXROLIs62ymGdwNich8202cg==
X-Received: by 2002:a05:6a00:2d18:b0:746:227c:a808 with SMTP id d2e1a72fcca58-74af6fcf673mr14064147b3a.24.1751171310025;
        Sat, 28 Jun 2025 21:28:30 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af57e38a5sm5963198b3a.133.2025.06.28.21.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 21:28:29 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:28:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 8/8] u-string-list: move "remove duplicates" test to
 "u-string-list.c"
Message-ID: <aGDA-V45RVBUUbrg@ArchLinux>
References: <aGDAZ6a0-PyXXGmK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGDAZ6a0-PyXXGmK@ArchLinux>

We use "test-tool string-list remove_duplicates" to test the
"string_list_remove_duplicates" function. As we have introduced the unit
test, we'd better remove the logic from shell script to C program to
improve test speed and readability.

As all the tests in shell script are removed, let's just delete the
"t0063-string-list.sh" and update the "meson.build" file to align with
this change.

Also we could simply remove "DISABLE_SIGN_COMPARE_WARNINGS" due to we
have already deleted related code.

Unfortunately, we cannot totally remove "test-string-list.c" due to that
we would test the performance of sorting about string list by executing
"test-tool string-list sort" in "p0071-sort.sh".

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/helper/test-string-list.c  | 39 -----------------------
 t/meson.build                |  1 -
 t/t0063-string-list.sh       | 27 ----------------
 t/unit-tests/u-string-list.c | 62 ++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 67 deletions(-)
 delete mode 100755 t/t0063-string-list.sh

diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 262b28c599..6be0cdb8e2 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -1,48 +1,9 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "strbuf.h"
 #include "string-list.h"
 
-/*
- * Parse an argument into a string list.  arg should either be a
- * ':'-separated list of strings, or "-" to indicate an empty string
- * list (as opposed to "", which indicates a string list containing a
- * single empty string).  list->strdup_strings must be set.
- */
-static void parse_string_list(struct string_list *list, const char *arg)
-{
-	if (!strcmp(arg, "-"))
-		return;
-
-	(void)string_list_split(list, arg, ':', -1);
-}
-
-static void write_list_compact(const struct string_list *list)
-{
-	int i;
-	if (!list->nr)
-		printf("-\n");
-	else {
-		printf("%s", list->items[0].string);
-		for (i = 1; i < list->nr; i++)
-			printf(":%s", list->items[i].string);
-		printf("\n");
-	}
-}
-
 int cmd__string_list(int argc, const char **argv)
 {
-	if (argc == 3 && !strcmp(argv[1], "remove_duplicates")) {
-		struct string_list list = STRING_LIST_INIT_DUP;
-
-		parse_string_list(&list, argv[2]);
-		string_list_remove_duplicates(&list, 0);
-		write_list_compact(&list);
-		string_list_clear(&list, 0);
-		return 0;
-	}
-
 	if (argc == 2 && !strcmp(argv[1], "sort")) {
 		struct string_list list = STRING_LIST_INIT_NODUP;
 		struct strbuf sb = STRBUF_INIT;
diff --git a/t/meson.build b/t/meson.build
index d3b3916580..276133a3d2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -124,7 +124,6 @@ integration_tests = [
   't0060-path-utils.sh',
   't0061-run-command.sh',
   't0062-revision-walking.sh',
-  't0063-string-list.sh',
   't0066-dir-iterator.sh',
   't0067-parse_pathspec_file.sh',
   't0068-for-each-repo.sh',
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
deleted file mode 100755
index 31fd62bba8..0000000000
--- a/t/t0063-string-list.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2012 Michael Haggerty
-#
-
-test_description='Test string list functionality'
-
-. ./test-lib.sh
-
-test_expect_success "test remove_duplicates" '
-	test "x-" = "x$(test-tool string-list remove_duplicates -)" &&
-	test "x" = "x$(test-tool string-list remove_duplicates "")" &&
-	test a = "$(test-tool string-list remove_duplicates a)" &&
-	test a = "$(test-tool string-list remove_duplicates a:a)" &&
-	test a = "$(test-tool string-list remove_duplicates a:a:a:a:a)" &&
-	test a:b = "$(test-tool string-list remove_duplicates a:b)" &&
-	test a:b = "$(test-tool string-list remove_duplicates a:a:b)" &&
-	test a:b = "$(test-tool string-list remove_duplicates a:b:b)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:b:c)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:a:b:c)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:b:b:c)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:b:c:c)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:a:b:b:c:c)" &&
-	test a:b:c = "$(test-tool string-list remove_duplicates a:a:a:b:b:b:c:c:c)"
-'
-
-test_done
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index f061a3694b..d4ba5f9fa5 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -163,3 +163,65 @@ void test_string_list__filter(void)
 
 	t_string_list_clear(&list, 0);
 }
+
+static void t_string_list_remove_duplicates(struct string_list *list, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	va_list ap;
+
+	va_start(ap, list);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	string_list_remove_duplicates(list, 0);
+	t_string_list_equal(list, &expected_strings);
+
+	string_list_clear(&expected_strings, 0);
+}
+
+void test_string_list__remove_duplicates(void)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&list, 0, NULL);
+	t_string_list_remove_duplicates(&list, NULL);
+
+	t_create_string_list_dup(&list, 0, "", NULL);
+	t_string_list_remove_duplicates(&list, "", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", NULL);
+	t_string_list_remove_duplicates(&list, "a", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", NULL);
+	t_string_list_remove_duplicates(&list, "a", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "a", NULL);
+	t_string_list_remove_duplicates(&list, "a", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "b", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "b", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "b", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "b", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "c", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "b", "b", "c", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "a", "b", "b", "b",
+				 "c", "c", "c", NULL);
+	t_string_list_remove_duplicates(&list, "a", "b", "c", NULL);
+
+	t_string_list_clear(&list, 0);
+}
-- 
2.50.0

