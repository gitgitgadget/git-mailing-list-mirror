Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93381732
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751171304; cv=none; b=W+GgEgczLGbJ3mEJ24ujPvHH49GMattf+nC+Ko9KQJ0mI9uZkdOAtzlSF2lmR28nuEiGC4+wk+BJ58I0g2tUzuiqUirW6+Uom1J/0Gro9mCH+oXUwtb+/7RRLfGg16csADbz5QwqToIWmZ840EhKAiFXzDFn115C9aKzsDlYmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751171304; c=relaxed/simple;
	bh=EDgf9O29vJF9OfgCS17mIKGZkSDKr0wY7+YJFWkp9e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs8u9JYz5w9qionEvOZKWCpZRP/Br+nd3hvlclkezeNfRfMbYGJZ7kbCMx3dTpGXWxrYBN4mlF1BLUuAHtWNAHZtYAPJdXxhhv9IlAeUbv+k6QWHkhQmCWmcX0jQZnMRcLuNI4PBBuR59UyUaa2vRqgf5j9dLXdq8moX4CQrZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ/dJllj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ/dJllj"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7426c44e014so3791421b3a.3
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 21:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751171301; x=1751776101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aH+/+xpoRIjeJEmVKbJy2QsgFqhOQCXxkgAjh8B1Uvg=;
        b=PQ/dJlljE6bfj98978L9v63VDCsR1fx0PznGyVZhO3LfQGuNZapCKsVgElP7jJE1BI
         eN4Ua1QQEq6LV7vHgdpAm3Y2fZBMeC21hnwCmiQMCU8z6SVZyLb8WBFznQgMlC4HSA7D
         CO1JTiAsL+IJ/NDtfObTQSj/hkvwyl1vPjj8aOAYRDPQ+oOGWTa2bjI45xTesBQfApKH
         etMQUqdlsK3IJNm8GqWvuixRJH23eoo27rIbJqrh+VUmBwPbgUxCbxOSoksln5+/aWmL
         uAflD+27pnTKn+3weOYbzlsoU+hfnAh168vYDDyuYUIeIUCDqaPiClgvJGT+qjK6MbLp
         S9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751171301; x=1751776101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH+/+xpoRIjeJEmVKbJy2QsgFqhOQCXxkgAjh8B1Uvg=;
        b=XoPi+qT5ZLFbHJXTVFbGRh5/K/o7sGKHn7CccM9StkeCEx5+5ehY3c1p/ykceXg7s/
         5t31Nlwt++7Inqoi3fHeUf+hyxZ4yIqd0h5MT/gA3PgjS+EcrzPJvfqo8Gqk1aIGJoT5
         mT97Yam1YkSSB6gb8JSOPP/dLQLuqOz0aZ2H/256vspn+BoAzFi3eCV+r6OMjQfNNijD
         f8i1x4ER/1H/perxb3PcfyQU1nUMTUv0aurvOrJktvzLYyUoKg5bfz5W+bQzMmKq/Gjj
         3M2oRZ1gQdBzpWmcXW8ScoTyfcB4mjmAPNnqNVNAtByMvRgMOVXz5rLmTpG1QX1t70Yd
         D8Jw==
X-Gm-Message-State: AOJu0YxIlNnXBSNTbQHVOpVJos/29dgl1MXMDvor3WtGThFuvQDFDDaB
	QOLe6GzyFzem0IwaeFvi7XlvEy4P7hjyUJyNtCqgvrE5SolY1lyynb/qJAqWHg==
X-Gm-Gg: ASbGncsWO58dJSSLrSI2lNmG5zWeDT0wSQtmH/VMyb9Y3nGPavovOAy8Mc5p/VVN0mg
	+JZHMsQVIz2W9jBmJwT0g46vXG6HL4mZBfJVrYFnoIVOg9pUHp1eod2sBG7HThbSuepYNv6/pkG
	EZuVvK2k9rgvqr9HXtbP+H8lD//ggB7L9OTDImmmFbh4P631qyCVI2kxxc1fJPEXEwGb9H1jSM0
	p7wGa9YrW4NnsjZTDFA4/EwOaX0I63uGfaVp6m+iwTzvS7izdymYbpEeJBBFWmQLm89eJsAKqkR
	FZ0R94pWXSeeZMmVJiDI4yQC4vBZlLAQHqJlDVL2oHOQnIK7pB2uJFLJyw==
X-Google-Smtp-Source: AGHT+IFLNveCfDSCbRwBvmyKgsKY2Xo898awsZmLZZqXifDTXjD2orpTsQ2uAnJ0KqUi00nZvlw/Rw==
X-Received: by 2002:a05:6a21:8dc5:b0:21f:74b5:e8cf with SMTP id adf61e73a8af0-220a16a12f4mr13239619637.25.1751171301363;
        Sat, 28 Jun 2025 21:28:21 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e31d842fsm4934122a12.51.2025.06.28.21.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 21:28:20 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:28:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 7/8] u-string-list: move "filter string" test to
 "u-string-list.c"
Message-ID: <aGDA8Lnqxa3tP7yH@ArchLinux>
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

We use "test-tool string-list filter" to test the "filter_string_list"
function. As we have introduced the unit test, we'd better remove the
logic from shell script to C program to improve test speed and
readability.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/helper/test-string-list.c  | 21 -----------
 t/t0063-string-list.sh       | 11 ------
 t/unit-tests/u-string-list.c | 73 ++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 8a344347ad..262b28c599 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -31,29 +31,8 @@ static void write_list_compact(const struct string_list *list)
 	}
 }
 
-static int prefix_cb(struct string_list_item *item, void *cb_data)
-{
-	const char *prefix = (const char *)cb_data;
-	return starts_with(item->string, prefix);
-}
-
 int cmd__string_list(int argc, const char **argv)
 {
-	if (argc == 4 && !strcmp(argv[1], "filter")) {
-		/*
-		 * Retain only the items that have the specified prefix.
-		 * Arguments: list|- prefix
-		 */
-		struct string_list list = STRING_LIST_INIT_DUP;
-		const char *prefix = argv[3];
-
-		parse_string_list(&list, argv[2]);
-		filter_string_list(&list, 0, prefix_cb, (void *)prefix);
-		write_list_compact(&list);
-		string_list_clear(&list, 0);
-		return 0;
-	}
-
 	if (argc == 3 && !strcmp(argv[1], "remove_duplicates")) {
 		struct string_list list = STRING_LIST_INIT_DUP;
 
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 1a9cf8bfcf..31fd62bba8 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -7,17 +7,6 @@ test_description='Test string list functionality'
 
 . ./test-lib.sh
 
-test_expect_success "test filter_string_list" '
-	test "x-" = "x$(test-tool string-list filter - y)" &&
-	test "x-" = "x$(test-tool string-list filter no y)" &&
-	test yes = "$(test-tool string-list filter yes y)" &&
-	test yes = "$(test-tool string-list filter no:yes y)" &&
-	test yes = "$(test-tool string-list filter yes:no y)" &&
-	test y1:y2 = "$(test-tool string-list filter y1:y2 y)" &&
-	test y2:y1 = "$(test-tool string-list filter y2:y1 y)" &&
-	test "x-" = "x$(test-tool string-list filter x1:x2 y)"
-'
-
 test_expect_success "test remove_duplicates" '
 	test "x-" = "x$(test-tool string-list remove_duplicates -)" &&
 	test "x" = "x$(test-tool string-list remove_duplicates "")" &&
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index d2761e1f2f..f061a3694b 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -13,6 +13,26 @@ static void t_vcreate_string_list_dup(struct string_list *list,
 		string_list_append(list, arg);
 }
 
+static void t_create_string_list_dup(struct string_list *list, int free_util, ...)
+{
+	va_list ap;
+
+	cl_assert(list->strdup_strings);
+
+	string_list_clear(list, free_util);
+	va_start(ap, free_util);
+	t_vcreate_string_list_dup(list, free_util, ap);
+	va_end(ap);
+}
+
+static void t_string_list_clear(struct string_list *list, int free_util)
+{
+	string_list_clear(list, free_util);
+	cl_assert_equal_p(list->items, NULL);
+	cl_assert_equal_i(list->nr, 0);
+	cl_assert_equal_i(list->alloc, 0);
+}
+
 static void t_string_list_equal(struct string_list *list,
 				struct string_list *expected_strings)
 {
@@ -90,3 +110,56 @@ void test_string_list__split_in_place(void)
 	t_string_list_split_in_place("foo:;:bar:;:", ":;", -1,
 				     "foo", "", "", "bar", "", "", "", NULL);
 }
+
+static int prefix_cb(struct string_list_item *item, void *cb_data)
+{
+	const char *prefix = (const char *)cb_data;
+	return starts_with(item->string, prefix);
+}
+
+static void t_string_list_filter(struct string_list *list, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	const char *prefix = "y";
+	va_list ap;
+
+	va_start(ap, list);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	filter_string_list(list, 0, prefix_cb, (void *)prefix);
+	t_string_list_equal(list, &expected_strings);
+
+	string_list_clear(&expected_strings, 0);
+}
+
+void test_string_list__filter(void)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&list, 0, NULL);
+	t_string_list_filter(&list, NULL);
+
+	t_create_string_list_dup(&list, 0, "no", NULL);
+	t_string_list_filter(&list, NULL);
+
+	t_create_string_list_dup(&list, 0, "yes", NULL);
+	t_string_list_filter(&list, "yes", NULL);
+
+	t_create_string_list_dup(&list, 0, "no", "yes", NULL);
+	t_string_list_filter(&list, "yes", NULL);
+
+	t_create_string_list_dup(&list, 0, "yes", "no", NULL);
+	t_string_list_filter(&list, "yes", NULL);
+
+	t_create_string_list_dup(&list, 0, "y1", "y2", NULL);
+	t_string_list_filter(&list, "y1", "y2", NULL);
+
+	t_create_string_list_dup(&list, 0, "y2", "y1", NULL);
+	t_string_list_filter(&list, "y2", "y1", NULL);
+
+	t_create_string_list_dup(&list, 0, "x1", "x2", NULL);
+	t_string_list_filter(&list, NULL);
+
+	t_string_list_clear(&list, 0);
+}
-- 
2.50.0

