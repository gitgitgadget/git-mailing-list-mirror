Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D52FFFB7
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769372116; cv=none; b=DGXYHd3WPV1vlp6lV5eQdPTLBAK0yB2pThO7PlVQ2AmOF7/YrvzR9mocJhPlO5s4uuh/odEaJJKhJ2fmtODQ8K5Bq38tFYAZ6OwJUtArFcShczfOT8YYxCIbzHEXRThCr9V/5hY+uEZ4MGqV7S6RkbC4PNgfj4viKjgkOUk28dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769372116; c=relaxed/simple;
	bh=5RJc8WUKTMyT1XhzosKWOtJELMA89ZEiFl+9xz3If2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNLti6Ndl+N0GfjFQCog7CO6WYj4A/3KSeF4FMSxyecOb7F50XuoMiUCnJ1TCTZzzuQI4edJV4AJWkzd5aIqYOO0nRDSVIzsEuP1s9JhBYPhPsObRQtniEFcW4t3wx1zrqinAw8+TSvda/Jwm/27CUCSTrc6wBmHaXuTugbwNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCRPEsJ6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCRPEsJ6"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3530f597ea3so1711078a91.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769372113; x=1769976913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15LJ+Acq2RY8hBUmrmo69Opmz5hd7CwrFzkJOKU9u/E=;
        b=cCRPEsJ6Chbm9Dhdvh9t0GRaEdVywBjUCRUsZoPs4L4nV/ujFADaAaDApNikZVPxmZ
         SBoV5ghajGXLQnIMEGTPgQ2FusweX4LHXOYpSDhTlxMuIDMVxJICrgzS2s8C/i4+DLFI
         wG46ixSkp7qwD9uB5FCi1gDYRfQ/hNFVbkzy/n1WnIEX7L2OJ2MnLzYL11L6Vuo1wlzJ
         NazwvKSSDm9xwwS7p3Sg4pXeoeKHbp1D1bZCWj/FjuCmGsErgDNrqI0K7UR7bhkxJS/w
         SfBiHOriHT8Us5iIgTt/c6vcd+WZjxJm/4p1GcEDA1kyO4IuxeBptW3HeYBLe4KIn7VP
         F79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769372113; x=1769976913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=15LJ+Acq2RY8hBUmrmo69Opmz5hd7CwrFzkJOKU9u/E=;
        b=CuVSBn+VdyYOaSBObYADoCuNLIWYb0nMG5ogMbP2mqNAbuPAuqIU6NgMdAWcJNRIAY
         8E6zhkxYFQsSgsj3dqiROeX5x1ee7oPiX83r1OwAbKcRgKnYvdB1h4VWM3/Lrw7M3Gvc
         iXHvEVC2xmG4AIcVwA+gct6g8gCeGHVjo3s+qREfTX9aREbLbf6bpBaVxmerWIopaSN/
         Q+eKh2EidSCjVAx6EuaqJUbr/vb+HTmII4wm8YKqN8DWoCB2Pi74vhjqj9/rJYhMY3yF
         pl0ehGj2XmKRFiaezOi5SK67lf7YD5NUK53DqPTo7zThmUvUlwiekOm7ItMlRsZBVmX4
         3FIg==
X-Forwarded-Encrypted: i=1; AJvYcCUhxEaVZprk4agYIeWDCPf5+phLRWiMpFG/hhUsjzFDmIomMkiaftmpHXMWi0xRS6oDXY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6jPp6V1tg1S4hzd6PMC43HwZw5UQMwb09OdAyrAPZP8ZqkY7
	Suk+zn5uXvwROt1uVK/l5gXL/Hr07U7+QpeECXcWOLDGNUf3A6zpj4vp
X-Gm-Gg: AZuq6aJz5bxzkZ6MwIY7il0nLPecSvsvcbmNkhHF9QeZroAOqBQXDZcR1pdzThcLJH2
	ZKR0SHdZmzKmz6YifwGIgg10P0WwTFjkM0SCpLsc5Yb08gK+fEOoaD9n670lWif6C9+uzjLOLw7
	94IlBFki64gEOCKIOVrOckRLEAYlUq7GpNdMEVibCHqENYWKbB7HLRtjPbClr5X3iOjGU41aZ0p
	yi+oRKH0i++pPuSUCtCyrvtV3j0eTPkmvwvIB0fi1mWafL2ehd/R3ONIhHl7KjGjdIJxyB9spkL
	AXPiBrE8CSyJL/Y3EC2+I0p1GnA8gxH05O3GWW0vPu2kMlBQi03Qo0EYi0+3qw1MFz0qSTNHswR
	1JzGIV5UnF/x0+zjoKZIFcBebpAYWM6TrMmbeh8EusVF8UxLpYu8hoZIKoo0sHX5ZZJ3IkztnQ2
	eHciYUuhN6qWGOxbV9723kkjkNzBPCDfhTUAiswLrET7AVa0Lz/yBIiBLCzub+TglZT4fz
X-Received: by 2002:a17:90b:35cc:b0:349:162d:ae1e with SMTP id 98e67ed59e1d1-353c41bb492mr1956227a91.33.1769372113362;
        Sun, 25 Jan 2026 12:15:13 -0800 (PST)
Received: from localhost.localdomain ([115.98.233.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318663addsm7569844b3a.20.2026.01.25.12.15.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Jan 2026 12:15:12 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: amishhhaaaa@gmail.com
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: [PATCH 1/2] u-string-list: add unit tests for string-list methods
Date: Mon, 26 Jan 2026 01:44:59 +0530
Message-ID: <20260125201500.63904-1-amishhhaaaa@gmail.com>
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
 t/unit-tests/u-string-list.c | 197 +++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index a2457d7b1e..6b4b858330 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -243,6 +243,133 @@ void test_string_list__filter(void)
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
+	for (int i = 0; i < strings_to_insert.nr; i++) {
+		string_list_insert(&list, strings_to_insert.items[i].string);
+	}
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
@@ -304,3 +431,73 @@ void test_string_list__remove_duplicates(void)
 
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

