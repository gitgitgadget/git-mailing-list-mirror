Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEF728F93E
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333720; cv=none; b=EISycxhQPKhwMGqqBfMfQYBQj20mOly8CIgzasHMqj30iHzJHb3kk/P0/U+aAWq/RnFCm7CKPmrW4DKSfhRF/T4JJI54lIg/TqjDQRQjFAXu3QmpSuIwekSCsMm5OBX2wU1wu+TAgEsQ7yotuqjp+z1klqaZ06X4DJ6yMpRsIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333720; c=relaxed/simple;
	bh=fhiuW+AibUD8fPdhBqtNnav3U9hWqqkAxOxFsC5O1Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqr2IdQmV1q+X0CAe7lyK6Ux22ORfaIi4DBlP3glvIknE4/JO5BTxBGF6Ks2YXn00eRfbUXP+qvV/R5pcRZ1pjyW1IkeYTOAz8J+CoEUqgiC44j8wYj9ZbTJ49QX2bz7709JWf00byGPZ2rKcJ4oZI1TjL+kz22AluBqgFwJRZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRUnAY5v; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRUnAY5v"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224171d6826so74132185ad.3
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745333717; x=1745938517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTYqsHcmq9SB3hXVY/jvQjzl7QwfZSyPO0u1Y7+LMMo=;
        b=fRUnAY5v26lIEmyDBRBcBCJmRT45uslddnwirOkzKYZpTRt/ipWLzRD+TPcMW8yS/X
         zZ+hJJeA3w3LFvVs7FFuqkTiDVkZzEeLpIJApgk5LvnJlA49cUFq6ku3/GWzKzBFcjKL
         fSOIxzIh8PHshLIEODBG2NK0kWZQduDpshC02c/Uft4E6RHQYIS08TeoFIYAJBXvMTkh
         H4apIqcfiErZwU0qRx7hLY443R4kIcUKxqdFsJz5wDDMdSAtAllgutGQeLefx1O+Sn/N
         XaoJIGJDTxw1Gpc6zRlB1LJO/gGB+d1dLGg8Vlzq10nJH7DTztd/jVIXEmXfFdC16eob
         GbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333717; x=1745938517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTYqsHcmq9SB3hXVY/jvQjzl7QwfZSyPO0u1Y7+LMMo=;
        b=dj7soMQvK9+sjsJe+WRj7eMv4fX1XLprr7DnhpHvdFMRqZ0WCVlkiFcr3uh52YskBe
         LzqrpS0e9AXnkQf4CqOm9EtB2EIwnSQTEB2/yDnCnUf3J7WNB43bp1AiIfzvmqmfmTVx
         X/xhIPscxH2Y7WMIY5Mq4ufS0FtFEy8QwBbVe1jL72CXtBWdumXm9MV9KozbF9HJzCQy
         yACeP52ZAH101iUX+DRJ9lt97w3dBGN1eCMcdz2AIT6SFbyY1cxGs2UeLN58MaQI7qkM
         B80deJRHH78Tz+E0Qiodv5Lnw9kfJMqogTqLpKGRE43bcR5rXmS8SNCEGMvASWTmF12U
         3LfQ==
X-Gm-Message-State: AOJu0YwsATOxT9gqmKUhZ3sjWyvNxLFR0IzeP8v7VnWmIAXpWYHb9Nwi
	ZNCqKLbQqMrRIJebjWkMmUiL6H2YNDsu10I4T4O2UVD5VmrfnxGwvF7KYnjK
X-Gm-Gg: ASbGncsD8dZcUhZ0r545HH6hhlfQdkDTXSeCBe7ANQcbDO94Mcvw0UpokJR/afbsWiq
	YyN6E/ee3VT+UxIuAvazs31RfurFETSDasoT/gmh47gLIf/j0VjuHO6CZzDCoM0HoG3ERB3C/yY
	ASAD0jErl7hF5wx+QgchatsyEG5EQsMsm32QW1//gNJ05xqvZ6cM7dqoQoR7SzxoOJMfOLBDoAo
	4++UMvYFXzj7US+tk7/73tD2R29fJBdhj9H+6cG6d8QAOy5ChkBLviBxQ5n0FF5I11WeMFk05xY
	O2g8I7xH9GSqUW5hGA9BsXFLYQ85UlSFpGEa
X-Google-Smtp-Source: AGHT+IF4h/W6JJisVQ0rfPgfvGB1Jt6ivoGfhO9db4TXU5CZfHSwAyMNCbkcokXmp7iKCNF4B7ieJQ==
X-Received: by 2002:a17:903:2c8:b0:223:5c33:56a8 with SMTP id d9443c01a7336-22c536042b9mr269545735ad.35.1745333716684;
        Tue, 22 Apr 2025 07:55:16 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50bda4d3sm86346785ad.47.2025.04.22.07.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:55:15 -0700 (PDT)
Date: Tue, 22 Apr 2025 22:55:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 5/5] u-string-list: move "remove duplicates" test to
 "u-string-list.c"
Message-ID: <aAet23peGs2OZUcn@ArchLinux>
References: <aAetW0dan8S3Fljq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAetW0dan8S3Fljq@ArchLinux>

We use "test-tool string-list remove_duplicates" to test the
"string_list_remove_duplicates" function. As we have introduced the unit
test, we'd better remove the logic from shell script to C program to
improve test speed and readability.

As all the tests in shell script are removed, let's just delete the
"t0063-string-list.sh" and update the "meson.build" file to align with
this change.

Also we could simply remove "DISABLE_SIGN_COMPARE_WARNINGS" due to we
have already deleted related code.

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
index 424e7e445f..25af09a8d4 100644
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
index e02a15ac04..a9fe5ade15 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -174,3 +174,65 @@ void test_string_list__filter(void)
 	t_string_list_clear(&list, 0);
 	t_string_list_clear(&expected_strings, 0);
 }
+
+static void t_string_list_remove_duplicates(struct string_list *list,
+					    struct string_list *expected_strings)
+{
+	string_list_remove_duplicates(list, 0);
+	t_check_string_list(list, expected_strings);
+}
+
+void test_string_list__remove_duplicates(void)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "", NULL);
+	t_create_string_list_dup(&expected_strings, 0, "", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "a", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "a", "a", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "a", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "a", "b", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "b", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "b", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&expected_strings, 0, "a", "b", "c", NULL);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "c", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "b", "c", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "b", "c", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "c", "c", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "b", "b", "c", "c", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_create_string_list_dup(&list, 0, "a", "a", "a", "b", "b", "b",
+				 "c", "c", "c", NULL);
+	t_string_list_remove_duplicates(&list, &expected_strings);
+
+	t_string_list_clear(&list, 0);
+	t_string_list_clear(&expected_strings, 0);
+}
-- 
2.49.0

