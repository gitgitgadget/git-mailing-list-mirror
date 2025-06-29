Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F01F92A
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751171295; cv=none; b=RCyDM7hWVIs8c3YGAcguNMcWIR53Z/LoJRfdPxzuVbL2McGS7Goqe5RXQyMG42kvVoRT2G+qOG0EMzu0DAFNXSUFq5zbwFkr2DgViSyjZCCFQbMoAfRlppX0DTkY8RlnA7qJ9p0bpvW3OTBTZ6FkReJIN/2hcnfns04A5RMOask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751171295; c=relaxed/simple;
	bh=mi/ZVgY++wOXJ/4OghSQ4sKOg/A8ylDK9Kc2UcMS3go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPg85yYbjO5j7R5iYcvqHKjWeD2zLsAgFq3xzYLzQqo2/os8sJaqou/PMH8CHp/rUek2KlHuNA60ydTQy6ULsVExphDnXGcznIAJ+vGFCyI9KdBvGFWLuSBh+K/acRLu4y+zimMg5WtPxGgOE1OL41ahBUn3vl1p6NW7RhsUpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep3+u7DD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep3+u7DD"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso1132103b3a.0
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 21:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751171292; x=1751776092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHDGK5r/E/NFr45pnXYvyh9B1tsHD0b8l+hUePu6d98=;
        b=Ep3+u7DDgy0gwn4qFGzRla3I9A1uKaQ/oH5rFo7tj/bV5bhz5R0Agrqbp7Fqw9QZeh
         2HAVF+vGMZLJo10YH3hW2sNBkh4rOqeiMX2DZdWsXmH+WoFpqKCaJStq6ghjGB2Z1vSZ
         0VzbvdTeWM1IMrb1iVath8Mz6zjAv36xk0L1OPS3jr4GztVzGMcGUiw+HP/zUilAp7ud
         vcBlt+PTuHdREyJdFup006/t8sPq1LL2NF/mcNPiYTfpRCCmnnfbLsbUK/vLj/XRkBlT
         44h/odi1DXUuX0EFYjWChiVgjv4QS4f6uVWyfTOX9lQoAuMuf9DmmqhzGFUNSwCniGKT
         iuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751171292; x=1751776092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHDGK5r/E/NFr45pnXYvyh9B1tsHD0b8l+hUePu6d98=;
        b=xMIz4AKhFuRgqegG20dLDyCy+K7SIdrYk1oA7tgzS25/FWDe45C8T63E85AS1G5zup
         GTgRMBO69B84nz+aYR5ETVbnKU5p6gmYZCeRn3+ZrnedhOinnISkI1QC+lbKdiqvQirO
         hLXd/vKkEg2M6UumqchXSza/mEHbA4rJAqt1VLZvG1bs1Rp4Lj0y3U6smYT/48fBxqx/
         726bhQAHe4xETCnUoUfMExrZ7egJ9dFSdfE/vq+nLypAZiVjXmlKyGtCO/aK1qfN8CDe
         /GyRlR6QWPU6WQAVS5/Ak6SfUnNJ3zi9xQyyhNJnXWWKJtFqicN6Fq9lGe6vT/oC3UZS
         Sg3g==
X-Gm-Message-State: AOJu0YyJ6oOGzpcTFEmucrbLifyVVNcnlsg3DSgDAk79qU5TR8F95A28
	+MISVPPECP0M3qL/1NrLlgZxANS+Q3MRSwkJnOPV6ZZ5GrLtP/o0b6rUXVL9Iw==
X-Gm-Gg: ASbGncvA3k4jth86wfLbnN/mGX49g5SUFHPlVWl4e2TkyAp8jRcXG1Djb7k5Nip1I5x
	4Urcb4z2MRvostn3RujpSSzzvCJGTMjvUXAYpnYoCar7vQoFVHq1ZgLpTYN7tPwAplypB/1UWE1
	00FPclmZQLj9ePXFx5ypMHCqhxzb6BzxqdL1jg4lGD0GUYyQ+bqL8R+la1v9VaTi6wbBg9h89KG
	I5NPN98qtf6jvSP8adcUkCV8OAYUzvd0mcL1AOib5NY8isMeL1ndE6KtJfhN45y72u976HkZib0
	idm/iCbozqP1fE17MJhhrk91khoBp13LnawY+MfDx8Qu1CmsRabQLsLxPA==
X-Google-Smtp-Source: AGHT+IGNhY2ay5xyEUdZYs7VSEgWITqeNSjF+tDR+utUsrDiGC4C5domuRrdAhCW1sz2+kLJTf3VHg==
X-Received: by 2002:a05:6a00:399e:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-74af6fe14d5mr12205534b3a.16.1751171292222;
        Sat, 28 Jun 2025 21:28:12 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af5409d62sm5525393b3a.27.2025.06.28.21.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 21:28:11 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:28:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 6/8] u-string-list: move "test_split_in_place" to
 "u-string-list.c"
Message-ID: <aGDA59ywwEMXsKlg@ArchLinux>
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

We use "test-tool string-list split_in_place" to test the
"string_list_split_in_place" function. As we have introduced the unit
test, we'd better remove the logic from shell script to C program to
improve test speed and readability.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/helper/test-string-list.c  | 22 ----------------
 t/t0063-string-list.sh       | 51 ------------------------------------
 t/unit-tests/u-string-list.c | 37 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 73 deletions(-)

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
index 881720ed6e..d2761e1f2f 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -53,3 +53,40 @@ void test_string_list__split(void)
 	t_string_list_split("", ':', -1, "", NULL);
 	t_string_list_split(":", ':', -1, "", "", NULL);
 }
+
+static void t_string_list_split_in_place(const char *data, const char *delim,
+					 int maxsplit, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	char *string = xstrdup(data);
+	va_list ap;
+	int len;
+
+	va_start(ap, maxsplit);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	string_list_clear(&list, 0);
+	len = string_list_split_in_place(&list, string, delim, maxsplit);
+	cl_assert_equal_i(len, expected_strings.nr);
+	t_string_list_equal(&list, &expected_strings);
+
+	free(string);
+	string_list_clear(&expected_strings, 0);
+	string_list_clear(&list, 0);
+}
+
+void test_string_list__split_in_place(void)
+{
+	t_string_list_split_in_place("foo:;:bar:;:baz:;:", ":;", -1,
+				     "foo", "", "", "bar", "", "", "baz", "", "", "", NULL);
+	t_string_list_split_in_place("foo:;:bar:;:baz", ":;", 0,
+				     "foo:;:bar:;:baz", NULL);
+	t_string_list_split_in_place("foo:;:bar:;:baz", ":;", 1,
+				     "foo", ";:bar:;:baz", NULL);
+	t_string_list_split_in_place("foo:;:bar:;:baz", ":;", 2,
+				     "foo", "", ":bar:;:baz", NULL);
+	t_string_list_split_in_place("foo:;:bar:;:", ":;", -1,
+				     "foo", "", "", "bar", "", "", "", NULL);
+}
-- 
2.50.0

