Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6303B262A6
	for <git@vger.kernel.org>; Sun, 18 May 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747583866; cv=none; b=q9pfoNRf+kY7BxQYEjHrLgyKiP/fteZbAPza07WYWYBBdgN7c/eT0Oq1GVemd2YymDADxMkhb4TxiB3muiFialnm2QKTAEEzNHiw2NSxcij+Au4ZbSJA3DzCYNTzZOvU67XkJenPs+ybmLyAkKaEcsDIol9fsVjiww/PAbcs/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747583866; c=relaxed/simple;
	bh=EUBHGWi8YgIcjBxuh2xq1vZBukqpzRRHtb3Klreiffc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp7ciFzOdEXNj+WKiZwFK3zKKXHWp+sWVn4q3SaDbdOWqIo53r/whhKhtxlg7uAZObRvzF995N8UWD4aouD6e6SUqrER4lOzCv7nT4QNO1Pi6yoJuWQsu6RBVHq4Mu3u9b77GI9rhYNPtAM3wGw7t4susIILX1JbPMbMHJZEnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvafqmFM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvafqmFM"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736c277331eso4115901b3a.1
        for <git@vger.kernel.org>; Sun, 18 May 2025 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747583864; x=1748188664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7BFVstfEa0sC5BMA0Z5tOooM6cvS4iUMs2OSQete2s=;
        b=XvafqmFMy6gPDKd5f+lAMqKbDh1CTamC2vojPyuSMK4nby3XLWsRHkty0fEo9K3sM0
         ozRYPAdCfbvK2TukokrIGagZ/f91w2AaUr+evGJ1IJT0BxXd/XuahrmI736ym3m0uNYZ
         AXGts1VEsTjG9nBLCz1WG3mh0j0gX7OS8y0EeORd1zmvsf3vd/YGWviPZjyaSPMxHmPw
         ufuF1bLLPG4EyyDyNAw7LjSNBlhhiPZ5xHG9JrvtjwUqkkRsJzy+TvHZX51ess2Hwm8p
         PDAuy2yzyTN1Dt5r9su3i+axPDVbQaiJLlST9v4Nwn8EKfTQg4n4zo8ft/qnS5bmLpJN
         sOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747583864; x=1748188664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7BFVstfEa0sC5BMA0Z5tOooM6cvS4iUMs2OSQete2s=;
        b=SzRVQnbgkphl9SCpPOzydqZT2aPrDt//b0XSGIT1PAtur69v+Yb+wZVUbpzi+nFpPx
         IqFGcbOyZJT2K41jwn57QNCjGf2r9se95vI0eX+6iqIAU5uRbn6dK733rt85gidgiSab
         d3QgcO3jWrdxm+0gJXnxsYlmUqU2kRbBVdnxiMap6GRoULwzuB/i+6tzyP1VDxqSSeaa
         T4jYTJml5s8lW+5MoWqkTMwUEe0g9HLyL1wpBonbZ09OzSHJh69sUhttVSFbRwSxm/MA
         yREy5SQ0fHkENokZ1ZiIJ2WWeBm5eZxWRj5E1N2+ScRKniVAul21RgwXLKFoItF/Z0Ht
         qAIQ==
X-Gm-Message-State: AOJu0YxW0SgbSwl8NNRLZqHB6VyAQWvo0saFsW+fKPoLV/Ex3drG+KeB
	RzMSBgswxlJ5N3Q5qbZoCnfNxax9q8ZuH92L59JZNWSrfBTtMyjIqNbGiSSLtVTCeU0=
X-Gm-Gg: ASbGncuM5z9U5IPfrH2mvZNO7a2yZkTWj75XNXPt/55hbwKMwvbJ/msiC5DNM4RXuBR
	/o8Yhwki0b/KnLpBir1JGNdQP0WB9A1NLpE303P5k0Z2fBbCwdzIXVSMJqcI+evHys77me6Th+n
	zrrWrG1mCm74HWxfbk3Kuq+4nbALWhXRTmDZzTL/4jhwiPomatxRR/jgszfa441dPnlPt8kBYzw
	EsLoy3UgbOBjF0b2vTntxyDALBNkLfJRmnc4Zwj70xNooEzgd4s7jaPWvkmc6SwwOWBFY1rFcpX
	OS5XHlj9scBnWUhBc/N61AiEtVQa7UL6mrvpFyAO1+olkcAZtOz45qlpEg==
X-Google-Smtp-Source: AGHT+IFJMdOodhViF4gXTccDOp+vG9RoZyeRs6QL+eFakdFZMisV6yp/pAmqUFwRjNTS0DdLelCgLQ==
X-Received: by 2002:a17:90b:4cc8:b0:30a:204e:fe47 with SMTP id 98e67ed59e1d1-30e7e87e797mr13787179a91.16.1747583864060;
        Sun, 18 May 2025 08:57:44 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30e934930fesm3720914a91.29.2025.05.18.08.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 08:57:43 -0700 (PDT)
Date: Sun, 18 May 2025 23:57:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 6/8] u-string-list: move "test_split_in_place" to
 "u-string-list.c"
Message-ID: <aCoDdf5IS3jkwpjl@ArchLinux>
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

We use "test-tool string-list split_in_place" to test the
"string_list_split_in_place" function. As we have introduced the unit
test, we'd better remove the logic from shell script to C program to
improve test speed and readability.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/helper/test-string-list.c  | 22 ----------------
 t/t0063-string-list.sh       | 51 ------------------------------------
 t/unit-tests/u-string-list.c | 39 +++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 73 deletions(-)

diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 17c18c30f6..8a344347ad 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -18,13 +18,6 @@ static void parse_string_list(struct string_list *list, const char *arg)
 	(void)string_list_split(list, arg, ':', -1);
 }
 
-static void write_list(const struct string_list *list)
-{
-	int i;
-	for (i = 0; i < list->nr; i++)
-		printf("[%d]: \"%s\"\n", i, list->items[i].string);
-}
-
 static void write_list_compact(const struct string_list *list)
 {
 	int i;
@@ -46,21 +39,6 @@ static int prefix_cb(struct string_list_item *item, void *cb_data)
 
 int cmd__string_list(int argc, const char **argv)
 {
-	if (argc == 5 && !strcmp(argv[1], "split_in_place")) {
-		struct string_list list = STRING_LIST_INIT_NODUP;
-		int i;
-		char *s = xstrdup(argv[2]);
-		const char *delim = argv[3];
-		int maxsplit = atoi(argv[4]);
-
-		i = string_list_split_in_place(&list, s, delim, maxsplit);
-		printf("%d\n", i);
-		write_list(&list);
-		string_list_clear(&list, 0);
-		free(s);
-		return 0;
-	}
-
 	if (argc == 4 && !strcmp(argv[1], "filter")) {
 		/*
 		 * Retain only the items that have the specified prefix.
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 6b20ffd206..1a9cf8bfcf 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -7,57 +7,6 @@ test_description='Test string list functionality'
 
 . ./test-lib.sh
 
-test_split_in_place() {
-	cat >expected &&
-	test_expect_success "split (in place) $1 at $2, max $3" "
-		test-tool string-list split_in_place '$1' '$2' '$3' >actual &&
-		test_cmp expected actual
-	"
-}
-
-test_split_in_place "foo:;:bar:;:baz:;:" ":;" "-1" <<EOF
-10
-[0]: "foo"
-[1]: ""
-[2]: ""
-[3]: "bar"
-[4]: ""
-[5]: ""
-[6]: "baz"
-[7]: ""
-[8]: ""
-[9]: ""
-EOF
-
-test_split_in_place "foo:;:bar:;:baz" ":;" "0" <<EOF
-1
-[0]: "foo:;:bar:;:baz"
-EOF
-
-test_split_in_place "foo:;:bar:;:baz" ":;" "1" <<EOF
-2
-[0]: "foo"
-[1]: ";:bar:;:baz"
-EOF
-
-test_split_in_place "foo:;:bar:;:baz" ":;" "2" <<EOF
-3
-[0]: "foo"
-[1]: ""
-[2]: ":bar:;:baz"
-EOF
-
-test_split_in_place "foo:;:bar:;:" ":;" "-1" <<EOF
-7
-[0]: "foo"
-[1]: ""
-[2]: ""
-[3]: "bar"
-[4]: ""
-[5]: ""
-[6]: ""
-EOF
-
 test_expect_success "test filter_string_list" '
 	test "x-" = "x$(test-tool string-list filter - y)" &&
 	test "x-" = "x$(test-tool string-list filter no y)" &&
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index c304934de2..e4b8e38fb8 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -64,3 +64,42 @@ void test_string_list__split(void)
 
 	t_string_list_clear(&list, 0);
 }
+
+static void t_string_list_split_in_place(struct string_list *list, const char *data,
+					 const char *delim, int maxsplit, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	char *string = xstrdup(data);
+	va_list ap;
+	int len;
+
+	va_start(ap, maxsplit);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	string_list_clear(list, 0);
+	len = string_list_split_in_place(list, string, delim, maxsplit);
+	cl_assert_equal_i(len, expected_strings.nr);
+	t_string_list_equal(list, &expected_strings);
+
+	free(string);
+	string_list_clear(&expected_strings, 0);
+}
+
+void test_string_list__split_in_place(void)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+
+	t_string_list_split_in_place(&list, "foo:;:bar:;:baz:;:", ":;", -1,
+				     "foo", "", "", "bar", "", "", "baz", "", "", "", NULL);
+	t_string_list_split_in_place(&list, "foo:;:bar:;:baz", ":;", 0,
+				     "foo:;:bar:;:baz", NULL);
+	t_string_list_split_in_place(&list, "foo:;:bar:;:baz", ":;", 1,
+				     "foo", ";:bar:;:baz", NULL);
+	t_string_list_split_in_place(&list, "foo:;:bar:;:baz", ":;", 2,
+				     "foo", "", ":bar:;:baz", NULL);
+	t_string_list_split_in_place(&list, "foo:;:bar:;:", ":;", -1,
+				     "foo", "", "", "bar", "", "", "", NULL);
+
+	t_string_list_clear(&list, 0);
+}
-- 
2.49.0

