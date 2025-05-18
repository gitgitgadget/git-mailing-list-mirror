Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0EF4B1E79
	for <git@vger.kernel.org>; Sun, 18 May 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747583894; cv=none; b=RkZKHx9tGPmXOSbbrdiKW68H8i4uAeNQNfgwSPX2I1M5yi3+DD66KHrPEX2Zi5j2i52X2gD+C6yPYKZoW1ss4ZkcpAdzAYFciodCotUPb9EvkAZYhX/K7nQ/1QHYqB0SpgPn0fPJWlozx/kl9j3C+JimmgJdNJ7w/DtwNvW9dPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747583894; c=relaxed/simple;
	bh=ucidvGh1UhnDC7SawXZqdP7LZ9gljIKCYRyNVL48J4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3qGC5veOW3LJaQHYBK0GXT0tZvki8S53/fycwAUb0J5gKcAwyI92jDiMv0DJa4PAuYbI3rBDbLHVRstH1p0gcSMbaeL8pUvzuFhRRbgNc/FmaLZbPb0sK7gJRD3rF+61uj/as/DtFlv8JyeGYiGa+ZQcs9aU9+601qnbIB+Apo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsKJu1Dm; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsKJu1Dm"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b200047a6a5so4139185a12.0
        for <git@vger.kernel.org>; Sun, 18 May 2025 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747583892; x=1748188692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4E4nINHtMCqvY8zcf5HEGGGfIqjuixym4oCa4wdIwQ=;
        b=SsKJu1DmINgo9CcU5QJEQEZkt2HDrF2iNFqzR2a2LBEdLjExOudFk58w6Tso/U6xN9
         PPZjYIU+Wpg7A6sLQjjiJPodU9hDkZmMrxA2gKgSk5ylFa2zWeGO3tNuP+8FeXF5SGID
         OdnjoXI3kne82dFj0IyPmg1Kji8YCoXdRUZDhfHHqVOVER6TQoJCyf+ps0EbeRv6OAWG
         rOBlnEx4AHOXt2Egt068VhaExqRkjGVr+ygNDMevDgHrnWzzajKuTEAXqa25KzI3tSc7
         uaULzgjc1eT+PT1gSar0Q/Q9tbfjvj3xokuDuyBxhTcVpZZetHuqOoaqjvBrmggrjeCg
         SELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747583892; x=1748188692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4E4nINHtMCqvY8zcf5HEGGGfIqjuixym4oCa4wdIwQ=;
        b=CocA1sOgFelfBOUPHzyvlZvHumFDNqFI1XiQwymXZ328A/q59YgxxtGCfBhJnw5fr/
         NJtr6HMp2IAYgdnll3zLaqIaWC9h55qsKtMhqBFLA789x2bEG9wldCmj+PdejLbgMK5n
         FzTUMBAmjoYYk/+ULCaGH8K1iW+q3QetKLcReE56JcMJR9Y/vOXTaqR1KetpWsekhxjO
         80FRQck57dDMp0Ay15XwRSD4pEmZKeuaZBLX2HX+5X5K9bQEal94s3Ar/BeMmW0RF0+c
         xDZjkv7c37L6B5HLgrzwDRANVUEE3fxVoxDQqdw99O+l3ieygaJD66bvQ9faRb0OwlFp
         KrWw==
X-Gm-Message-State: AOJu0Yzh1vT+GTW/RwiK7DJjOCTimfjGlOslL0axAPVHOp3+K0xuDBeS
	7iECh4n1zYjF2S+C+/wVnCERx/uSBpFud79CdKiS9JwAqtBR18t5XbcZRYS+aonO1KE=
X-Gm-Gg: ASbGnct/D4h9BgFFLGbCJh1kETcB5WaBCHvHXjfBDugiw9JlBdPwdsBhmXbZPDCrW99
	lgI/+IMvoFGZaGJWJXkIEYOI4O1s/xdOfaB+rpT+cnE6gMfTWWpHSDBLodj95zBFicpAI/f30f7
	OwJy6T87bdi9Wuy+PvjkFPRO7EUuyNY63p5Es9cwIxy7iYXAT4Oq+4zbdzxRGpBy+Zq9XhKKDWJ
	jwV3PSRFUR19rwJ/W0KQeTeKUyNvgjH/FgMuk6+ZNnODy3WWlo5F4ItzEswXSEpG9+T68thJB2u
	eN7C9ZGrrQgutfVUXVEfGYPx29QglOoNMGwqjuQ8Sq1pc5U=
X-Google-Smtp-Source: AGHT+IEtv/5t/qeJ4NPG/+p62ytpz5PNbG6+o+tRYJ7zsdaTuke8xRJrfSj16wenju+6gRs1/k+nVg==
X-Received: by 2002:a17:902:d2cf:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-231d4ea09cfmr144718445ad.25.1747583891986;
        Sun, 18 May 2025 08:58:11 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ed571esm44880355ad.248.2025.05.18.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 08:58:11 -0700 (PDT)
Date: Sun, 18 May 2025 23:58:09 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 7/8] u-string-list: move "filter string" test to
 "u-string-list.c"
Message-ID: <aCoDkaAyxRGgYMJZ@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDB9P5XV1lHMil@ArchLinux>

We use "test-tool string-list filter" to test the "filter_string_list"
function. As we have introduced the unit test, we'd better remove the
logic from shell script to C program to improve test speed and
readability.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/helper/test-string-list.c  | 21 ------------
 t/t0063-string-list.sh       | 11 ------
 t/unit-tests/u-string-list.c | 66 ++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 32 deletions(-)

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
index e4b8e38fb8..be2bb5f103 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -13,6 +13,18 @@ static void t_vcreate_string_list_dup(struct string_list *list,
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
 static void t_string_list_clear(struct string_list *list, int free_util)
 {
 	string_list_clear(list, free_util);
@@ -103,3 +115,57 @@ void test_string_list__split_in_place(void)
 
 	t_string_list_clear(&list, 0);
 }
+
+static int prefix_cb(struct string_list_item *item, void *cb_data)
+{
+	const char *prefix = (const char *)cb_data;
+	return starts_with(item->string, prefix);
+}
+
+static void t_string_list_filter(struct string_list *list,
+				 string_list_each_func_t want, void *cb_data, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	va_list ap;
+
+	va_start(ap, cb_data);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	filter_string_list(list, 0, want, cb_data);
+	t_string_list_equal(list, &expected_strings);
+
+	string_list_clear(&expected_strings, 0);
+}
+
+void test_string_list__filter(void)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	const char *prefix = "y";
+
+	t_create_string_list_dup(&list, 0, NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, NULL);
+
+	t_create_string_list_dup(&list, 0, "no", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, NULL);
+
+	t_create_string_list_dup(&list, 0, "yes", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, "yes", NULL);
+
+	t_create_string_list_dup(&list, 0, "no", "yes", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, "yes", NULL);
+
+	t_create_string_list_dup(&list, 0, "yes", "no", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, "yes", NULL);
+
+	t_create_string_list_dup(&list, 0, "y1", "y2", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, "y1", "y2", NULL);
+
+	t_create_string_list_dup(&list, 0, "y2", "y1", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, "y2", "y1", NULL);
+
+	t_create_string_list_dup(&list, 0, "x1", "x2", NULL);
+	t_string_list_filter(&list, prefix_cb, (void*)prefix, NULL);
+
+	t_string_list_clear(&list, 0);
+}
-- 
2.49.0

