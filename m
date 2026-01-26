Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004293EBF0D
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453781; cv=none; b=WgIQ8DX3P1YCcmsq2Sl7bScQpP6Xx1QmNYanTAsQyyuTlFvSpkVM5JEx9SUdQjYt8uwuVPCzpSTP9Aqbjm4yP0jK3HJQRvaA2Bs39FnFOILWGt0fXbniLre2Z68v03o3GvgFe8yFYw0qTcSmQBgZxlj3j0Sqfy0I+iS4Rk7rzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453781; c=relaxed/simple;
	bh=XXuYRge0vcoXsXqX1Og0hoabd2K9qXI5ES/fajW5qXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIyijvO23+RjnCzUg1TCJSVonvSX5HhwhTJxvY29QaRtjRa9h8tM/XL1TPawqAL69eLzL3jeV1Ngpww7UxBY3yEaHiFJloPkwH4zZ9c+Xd+4sPdHzphTQXfvirZSodi+WZQ7sg8pfPpZqr/Hlkr8Tz4pc7uV+HTpr9jmPaBje9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JA88P/TS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA88P/TS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-435903c4040so2969258f8f.3
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 10:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769453778; x=1770058578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiOsP2ulk1NYjyuHO0mvInZQUH787ajZ+7wFQLdLeHs=;
        b=JA88P/TS/CPpk97JtBI+dNDwSlCRUKsaotwiG5xvk9t76wcjgra7XoRKsZsW1cP1Fx
         Nr3zOuogmmEFQH1P6DN+dUq2Eblu6jSKoR0va13HJ80UvrFo895po9Nn4Dc/YjZi91+N
         jLydB3CkOBof7Fo9qEgqGk8kPo5DjnrxH5bMZ1guUBdq+tkMUwHCneR3Q/RvmDtCT3IB
         75YbsF3JhY2mdif50Qw0cT8IOLgqgotMviFRDiOkvauQINBDM0hbJ16AwiiPQscIJ0DD
         W64QX0qRkS7LOTFjyTEDIBuMTu4Y506zsW3z/RKE3uNmz6CHg4VX5A5gzLSiVWwdjPpz
         5MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769453778; x=1770058578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AiOsP2ulk1NYjyuHO0mvInZQUH787ajZ+7wFQLdLeHs=;
        b=p5w/cvl+w5bU9FqanUZeqjeEA10nAvk+zs3VIbZM/O9m17zK50s6i9TwmpLgJFSCIa
         saiuyT97DCnZzKw53cfMMBbuoKO7vkel2mZOWouf4iJ1MNopTHcdJbqFmfIUrOdSSJZ9
         7LHGyw40mpfT/Qmxj6SSEC4099ipyC3rTxE2dM/qtrz1iVe+RdnkK1O1quzPljZx8rOK
         Wa9xAag5nM1TV4e9Hmfvvtelntnou8gbf6S1RDge7rcOy7wl7lnwsLQlOyjAQeIVRe7p
         hScAeiYLfvNDqEJhN1Y+9fISyOPWTFkQJW4cbkiyYGLBopeasbsUhMjP2u6oXX/b5Yw9
         Bt0g==
X-Gm-Message-State: AOJu0YyqUCPXNYzeczSLRfDU8eg2l6OS0YjLxkUfetVXPhLktuSMYKw4
	s9LRgX09dsPXWgg9jgTAdhwAGJIcyaiTFwLuICOxn8KhCq8HT2RLw0nH3Ej+5qbC
X-Gm-Gg: AZuq6aIBIWyfc2E6tzfUREmKPbiKh2WCe84nG0+MmrsZ9l4GTJ88bSs8c6iHBRVCEXZ
	4MRW7u5QacFFWWX65vI+MbzKCxh6Aa5E0k6JCF7+QVPyfYb4i3AaDA4QBs4kwKSvngOwQ+jTDCY
	NKPtpAtKWhF3ZrTnHKuMqwk1OTYRfIMr0pRdHumKNwWAjREC/cUt0IvVL2Nhqdty6LGw4jD3Mvo
	AKbKFv27jDsn6AtkbTqflMcEXqHWtXaPYOpB6nDfv78EQOWsJ4dM3knrlV20kXjK7/lFZUSS0Qj
	vMGxovfLH4tc5dEXgUnHspvAAZnH4QR8336lnSeNgpTQ0yqpbup/FqRDvVcAR2iClVggQZgahUI
	eh4+yyCD/+dCdKE/ft8W/7H5ISL8v+oZp0uAY4HxTtonF1nA07dnzNDgqiHiK+B8yS4iXWJ6OUx
	lhQdXY7NT9cL9Ke/5RZ+02weFwkXd4x39JVg9GqLfbJSdxL82Igxgt48k+Y/t5qNlUjXb3
X-Received: by 2002:a05:6000:2c01:b0:435:975a:131c with SMTP id ffacd0b85a97d-435ca19e67fmr7758650f8f.36.1769453777924;
        Mon, 26 Jan 2026 10:56:17 -0800 (PST)
Received: from localhost.localdomain ([115.98.235.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1b6e2besm32159135f8f.0.2026.01.26.10.56.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Jan 2026 10:56:17 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Amisha Chhajed <amishhhaaaa@gmail.com>
Subject: [PATCH v2 1/2] u-string-list: add unit tests for string-list methods
Date: Tue, 27 Jan 2026 00:26:03 +0530
Message-ID: <20260126185604.90089-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122171523.94234-1-amishhhaaaa@gmail.com>
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unit tests in u-string-list.c does not cover several methods
in string-list, this gap in coverage makes it difficult to
ensure no regressions are introduced in future changes.

Add unit tests for the following methods to enhance coverage:
string_list_remove_empty_items()
unsorted_string_list_has_string()
unsorted_string_list_delete_item()
string_list_has_string()
string_list_insert()
string_list_sort()
string_list_remove()

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 t/unit-tests/u-string-list.c | 196 +++++++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index a2457d7b1e..6b2b16671c 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -243,6 +243,132 @@ void test_string_list__filter(void)
 	t_string_list_clear(&list, 0);
 }
 
+static void t_string_list_has_string(struct string_list *list, const char *string, int expected)
+{
+	int has_string = string_list_has_string(list, string);
+	cl_assert_equal_i(has_string, expected);
+}
+
+void test_string_list__has_string(void)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&list, 0, NULL);
+	t_string_list_has_string(&list, "", 0);
+
+	t_create_string_list_dup(&list, 0, "a", "b", "c", NULL);
+	t_string_list_has_string(&list, "a", 1);
+	t_string_list_has_string(&list, "b", 1);
+	t_string_list_has_string(&list, "c", 1);
+	t_string_list_has_string(&list, "d", 0);
+
+	t_string_list_clear(&list, 0);
+}
+
+static void t_string_list_insert(struct string_list *expected_strings, ...)
+{
+	struct string_list strings_to_insert = STRING_LIST_INIT_DUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	va_list ap;
+
+	va_start(ap, expected_strings);
+	t_vcreate_string_list_dup(&strings_to_insert, 0, ap);
+	va_end(ap);
+
+	for (size_t i = 0; i < strings_to_insert.nr; i++)
+		string_list_insert(&list, strings_to_insert.items[i].string);
+
+	t_string_list_equal(&list, expected_strings);
+
+	string_list_clear(&strings_to_insert, 0);
+	string_list_clear(&list, 0);
+}
+
+void test_string_list__insert(void)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&expected_strings, 0, NULL);
+	t_string_list_insert(&expected_strings, NULL);
+
+	t_create_string_list_dup(&expected_strings, 0, "a", "b", NULL);
+	t_string_list_insert(&expected_strings, "b", "a", "a", "b", NULL);
+
+	t_create_string_list_dup(&expected_strings, 0, "a", "b", "c", NULL);
+	t_string_list_insert(&expected_strings, "c", "b", "a", "c", "b", NULL);
+
+	t_create_string_list_dup(&expected_strings, 0, "", "a", NULL);
+	t_string_list_insert(&expected_strings, "a", "a", "a", "", NULL);
+
+	t_string_list_clear(&expected_strings, 0);
+}
+
+static void t_string_list_sort(struct string_list *list, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	va_list ap;
+
+	va_start(ap, list);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	string_list_sort(list);
+	t_string_list_equal(list, &expected_strings);
+
+	string_list_clear(&expected_strings, 0);
+}
+
+void test_string_list__sort(void)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&list, 0, NULL);
+	t_string_list_sort(&list, NULL);
+
+	t_create_string_list_dup(&list, 0, "b", "", "a", NULL);
+	t_string_list_sort(&list, "", "a", "b", NULL);
+
+	t_create_string_list_dup(&list, 0, "c", "a", "b", "a", NULL);
+	t_string_list_sort(&list, "a", "a", "b", "c", NULL);
+
+	t_string_list_clear(&list, 0);
+}
+
+static void t_string_list_remove(struct string_list *expected_strings, struct string_list *list, char const *str)
+{
+	string_list_remove(list, str, 0);
+	t_string_list_equal(list, expected_strings);
+}
+
+void test_string_list__remove(void)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&expected_strings, 0, NULL);
+	t_create_string_list_dup(&list, 0, NULL);
+	t_string_list_remove(&expected_strings, &list, "");
+
+	t_create_string_list_dup(&expected_strings, 0, "a", NULL);
+	t_create_string_list_dup(&list, 0, "a", "a", NULL);
+	t_string_list_remove(&expected_strings, &list, "a");
+
+	t_create_string_list_dup(&expected_strings, 0, "a", "b", "b", NULL);
+	t_create_string_list_dup(&list, 0, "a", "b", "b", "c", NULL);
+	t_string_list_remove(&expected_strings, &list, "c");
+
+	t_create_string_list_dup(&expected_strings, 0, "a", "b", "d", NULL);
+	t_create_string_list_dup(&list, 0, "a", "b", "c", "d", NULL);
+	t_string_list_remove(&expected_strings, &list, "c");
+
+	t_create_string_list_dup(&expected_strings, 0, "a", "b", "c", "d", NULL);
+	t_create_string_list_dup(&list, 0, "a", "b", "c", "d", NULL);
+	t_string_list_remove(&expected_strings, &list, "e");
+
+	t_string_list_clear(&expected_strings, 0);
+	t_string_list_clear(&list, 0);
+}
+
 static void t_string_list_remove_duplicates(struct string_list *list, ...)
 {
 	struct string_list expected_strings = STRING_LIST_INIT_DUP;
@@ -304,3 +430,73 @@ void test_string_list__remove_duplicates(void)
 
 	t_string_list_clear(&list, 0);
 }
+
+static void t_string_list_remove_empty_items(struct string_list *expected_strings, struct string_list *list)
+{
+	string_list_remove_empty_items(list, 0);
+	t_string_list_equal(list, expected_strings);
+}
+
+void test_string_list__remove_empty_items(void)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&expected_strings, 0, NULL);
+	t_create_string_list_dup(&list, 0, "", "", "", NULL);
+	t_string_list_remove_empty_items(&expected_strings, &list);
+
+	t_create_string_list_dup(&expected_strings, 0, "a", "b", NULL);
+	t_create_string_list_dup(&list, 0, "a", "", "b", "", NULL);
+	t_string_list_remove_empty_items(&expected_strings, &list);
+
+	t_string_list_clear(&expected_strings, 0);
+	t_string_list_clear(&list, 0);
+}
+
+static void t_string_list_unsorted_string_list_has_string(struct string_list *list, const char *str, int expected)
+{
+	int has_string = unsorted_string_list_has_string(list, str);
+	cl_assert_equal_i(has_string, expected);
+}
+
+void test_string_list__unsorted_string_list_has_string(void)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&list, 0, "b", "d", "a", NULL);
+	t_string_list_unsorted_string_list_has_string(&list, "a", 1);
+	t_string_list_unsorted_string_list_has_string(&list, "b", 1);
+	t_string_list_unsorted_string_list_has_string(&list, "c", 0);
+	t_string_list_unsorted_string_list_has_string(&list, "d", 1);
+
+	t_string_list_clear(&list, 0);
+}
+
+static void t_string_list_unsorted_string_list_delete_item(struct string_list *expected_list, struct string_list *list, int i)
+{
+	unsorted_string_list_delete_item(list, i, 0);
+
+	t_string_list_equal(list, expected_list);
+}
+
+void test_string_list__unsorted_string_list_delete_item(void)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&expected_strings, 0, "a", "c", "b", NULL);
+	t_create_string_list_dup(&list, 0, "a", "d", "b", "c", NULL);
+	t_string_list_unsorted_string_list_delete_item(&expected_strings, &list, 1);
+
+	t_create_string_list_dup(&expected_strings, 0, NULL);
+	t_create_string_list_dup(&list, 0, "", NULL);
+	t_string_list_unsorted_string_list_delete_item(&expected_strings, &list, 0);
+
+	t_create_string_list_dup(&expected_strings, 0, "a", "d", "c", "b", NULL);
+	t_create_string_list_dup(&list, 0,  "a", "d", "c", "b", "d", NULL);
+	t_string_list_unsorted_string_list_delete_item(&expected_strings, &list, 4);
+
+	t_string_list_clear(&expected_strings, 0);
+	t_string_list_clear(&list, 0);
+}
\ No newline at end of file
-- 
2.51.0

