Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF363876A2
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688752; cv=none; b=mOseKaNLsuW0+kE6rZNNC9bzi+VXf2+3DcLGfM/jIGfExr3QpnHe8GxMRaCE+I7mRATohHTsX4uDd0c/3Vt574Xv4mi/k3IUwHzZQBVqi6AvTNaKYuFXE2LZlN6rIRFA64MuVekj5JyrqirtqkUQ4fNpymfndPhejEZGfcsIN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688752; c=relaxed/simple;
	bh=sz+vqA+hAO+U8hsOcsp7mgb/MvXaR79h9yvWi3NSI88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uweTpxCwAW5vUsYlLYF+ArfvKEUtuTkDfRjS+1XD0EztpLtgp1nhj4iKnA/ci3reeM87PYqf7RZ7nR7z3c9UCm1CtJyRI7jl3Dy65kCHplRkF2KlyXnQEHlcCVTxRIkfYr8MO6Sd3cGOINqMZzsCasxMCiPfcCtrZ+lcQDaa518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh4nRWsb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh4nRWsb"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81e93c5961cso759446b3a.0
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 04:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769688750; x=1770293550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxJO7IP0NM/GZGhZGAdc0jLGjyeeGcBgCc3MmsYhspE=;
        b=Eh4nRWsbTZNbqc4cUFYc+7ZURxF/ZoG+LvlNAqAfYU11YRXHlCpEolF4bdcCqGUfta
         FUFQ2mjyQXq/PiQ8loFcvsPbOha9R6BfxXMjIYGddPgUo/DO1EzHAHLDQuW+F2CKPpKA
         cqcS3XEjqtZ9LSKaLM1t0NdPy93X2NO+gZQG4Ck8Y3cM7Ji7rB7aN5BXEfwa//jeE5GA
         m8AKHs2Dx8liW75iZ4bXhsrwt3bSeAgxq2ejwbY75ZcLygFzLF4etwI501c2OfgKgtUr
         011JCwC+NtgffDJoz6ACJKzykZmRyem7zt6++udE6uIm6XJgt7NxfjFtc+3owAeOgq49
         DPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769688750; x=1770293550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bxJO7IP0NM/GZGhZGAdc0jLGjyeeGcBgCc3MmsYhspE=;
        b=Or/pxv995SY/UEXXIYZe6KpdTy5FXwHZd+5IFbFpf8IuKQD8HdXLgGlQKwq082jm7s
         Xkk8AmYYsaICdL9k2scPvPaKpslIbgWY+MZjpljd3SlI8ozcQ+4u/9CH+Gxs0RKKcdNa
         lehdznDLNwOX2MhB7950BruqIbu6IIgyW2drwoEBUGuhXEgYF9j6yhFM4BlDRsY4fZNJ
         99YHuJqYenSDDE2HUV+Je7Q8hBFln73yNQqMIVTjYBsP00iAWrYAHthYGRZBH0HnxvjD
         vDEBb3eNRHoSVdS0M3yNUp5Vf1TWupwHKnGglg7gPsMahj3SS6r2x1oBZCMCA0loczjQ
         hOwQ==
X-Gm-Message-State: AOJu0YxESwCUONIVFq5/mEEyMp89pVcFSIhIgN2nNG8CLXcnsJhdC0QY
	AYg/1HNUVncF9mB03gTclxtsRGtZSm5jbBpwVAof9Z2xkj1LdIM/7b38c5iA5ZJ5
X-Gm-Gg: AZuq6aLJEYXb7D0OInBEiFtX4bXhrkZjnPRi9YQgBCUGk5iNtXbebFIEm5Ft33b609Y
	0c7LYYj73laLGl9+daAHLJ9cUBV0nEb2pEBe9tOOphx2+ROxioREfJmuJdzBKH2YpMyZ7g/g09p
	pO6gm1qortPecy+cEYmqximzHAJ0V7UGuHBeMG1ORvfWO4i2VTY8TZEJUsP2Arc3LlvSmGSvphT
	23LzvJ0X+n6KjO2JLkcYkR58zvL2fZvBNHrFWQCDT8ljxPd0aj2MsDxaXyWUVQykX3h9fMxEjii
	vXbP/aermTLc0/slqrvdY0jY+OfHle/Q//lzKzQaP+ApYsAwuAi0PZraNLSaTulNkqUVgn+8afJ
	FrRZ/jGwqyYfw7p8VioEKCaZz/nAPuP1GcxJK8JGF7LYhmz/n1lpj2sYa9cwQUdOOdSg5uh+uWP
	TOidv+X5HhBuT3Q1g/Aidy4agZyXclt9rSgPU79ghuYbP6tM6cph5qNQ7dJMuqAmO55w==
X-Received: by 2002:a05:6a20:1604:b0:38d:fde5:24af with SMTP id adf61e73a8af0-38ec657daecmr8382367637.64.1769688749651;
        Thu, 29 Jan 2026 04:12:29 -0800 (PST)
Received: from localhost.localdomain ([115.98.234.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6128942sm8088533a91.5.2026.01.29.04.12.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Jan 2026 04:12:28 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: amishhhaaaa@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 1/2] u-string-list: add unit tests for string-list methods
Date: Thu, 29 Jan 2026 17:42:19 +0530
Message-ID: <20260129121220.69267-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125201500.63904-2-amishhhaaaa@gmail.com>
References: <20260125201500.63904-2-amishhhaaaa@gmail.com>
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
 t/unit-tests/u-string-list.c | 209 +++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index a2457d7b1e..d469a06eca 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -243,6 +243,138 @@ void test_string_list__filter(void)
 	t_string_list_clear(&list, 0);
 }
 
+static void t_string_list_has_string(
+	struct string_list *list,
+	const char *string,
+	int expected)
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
+static void t_string_list_remove(
+	struct string_list *expected_strings,
+	struct string_list *list,
+	char const *str)
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
@@ -304,3 +436,80 @@ void test_string_list__remove_duplicates(void)
 
 	t_string_list_clear(&list, 0);
 }
+
+static void t_string_list_remove_empty_items(
+	struct string_list *expected_strings,
+	struct string_list *list)
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
+static void t_string_list_unsorted_string_list_has_string(
+	struct string_list *list,
+	const char *str, int expected)
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
+static void t_string_list_unsorted_string_list_delete_item(
+	struct string_list *expected_list,
+	struct string_list *list,
+	int i)
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
-- 
2.51.0

