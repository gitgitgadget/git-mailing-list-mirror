Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B867199E89
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769372275; cv=none; b=L6HDhvnpjlkjqS/F/0veQXEVGlVa1Qy/0MNDzAVjPNU/UsR22aqs/S8MUzwBOJ9VPQpgdAP1xBKot1LB5Wqclmlqx7yAmMHcXeboPscq+C5IptjXUOsUsyTwvJeaPeLkE3KrYr7Qn9rMnsYVLa0wpC2/HTTBIXzT+b0n+ulx5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769372275; c=relaxed/simple;
	bh=5RJc8WUKTMyT1XhzosKWOtJELMA89ZEiFl+9xz3If2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPvgSZ+CDjcd4fGr9ppEdRufziYwF6otp49jiK+TMR33gIxS9TYs4/dYnTSnLOsh7kzNbCU+EmZAprJOzyWjISvHfCe7cOVedbImzrDxwiwyK8DJ8585GmWjq1TAm9I3+yy8tcDYRtifsM20dYAAN5jds4VE/XJbV4P0yFt/SYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6gLXO9k; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6gLXO9k"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82307c6902eso1668748b3a.3
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769372273; x=1769977073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15LJ+Acq2RY8hBUmrmo69Opmz5hd7CwrFzkJOKU9u/E=;
        b=B6gLXO9kKBI6hAzD+1QRDObA6nNT9QKS8e+BDAiz7TwHzb/n/PcFcBBPZNaOskVbzQ
         K19Vnta4D65oLxRM/5PEcmkVvmpP2ADXcTt0c+c+PLk6XiPRc5URHh0I5V0r0ljU0Gea
         UfPF53oqJlQg3K0T2IWiTY32hSrVaoFme25xjlS9IuhbA0e/CPEmuIxdIFBYd18o85tI
         tq6C6U41QSwojBLVY8QksI7usrt9Q1zyVOFSO+Qabb0ftibtf/DefhhBI1ThQ47vhjZ0
         OE0qVbgfRBKBdSPF/CEvSYOVJtcgKRWHGDoAgyI2pOgHfyVrXJ6aTNcJ7Yk/cj1z4f0h
         bWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769372273; x=1769977073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=15LJ+Acq2RY8hBUmrmo69Opmz5hd7CwrFzkJOKU9u/E=;
        b=QRunIlpiA/IR+eevl8YQ8f5qXKpSYM7/o4Tv+DiNzGkEO8lodmRnwSMsnnkL0zObcP
         GuRCfmvjjCmcbaxaSNEoHYoMDZbpP2+b2ScR/mJsbD4lwmX8P6tc7bDqO/xycOvZcaCf
         OShkdEdc10I3elxwMxL9MSMQD54r8wqGkMXT0TDyx+Y0eAUBFlzXRm56iJZYrT1kum32
         16hwiM/XJ5FGDMUbxtsyt9uyU7plXuYpgOJOG0m5s+SDzzzW1DL4Ek3K64VRdYL+MT2Y
         LqnEKD3syES6N+NhBukWcU5t3ocAm70orZchcsLaR8qTgS2hBQny3xdSNCFoat/ejSkM
         cX1w==
X-Gm-Message-State: AOJu0YypJWTfIeC4r/3SfD0XJZHoPxvPkGiwst4a87rQlkTML3nhkt7U
	MuS3T5KqITeKoRxCrHmrbIOlaMHMfQoxPvAiHuCs8kO2SHM7mDzHeIaR8sKXRR2b
X-Gm-Gg: AZuq6aIKcJ5MjBVULvxDCsGQFqkVrbULpjVPRUQHTNkaHySPxMPx4tu0B36KaiPqKhl
	nkKnFBcy9iXmCzZx4rs7ZtHJis0EoaN6aen/5pRewnskS9oE+ITvDq66elCAy9ehqu+a8iEkxU7
	iSYiXjhfX1z8ajY/oYefcbJe8THCZGAV0RR5OV99o/60rHE+r3GyJRrswdIT46uqMU7k2vm2wUT
	FjkfS/tS4rnA8OcJAOOG7JJ3T/fiadzjmjtmDL/YAOZGpLo1MmoNRRj3cnfzUyqvdAHv478sDHY
	+9LQnPrlbxIxGxekQETh97eTN+vnAoV7TcjZR14xWZL342tnB6qjNWTXrrFdZodLzgX5hoB5o7+
	ZD8WJLTs24vR3wkyw+ZBNtegOjWMiusHABprl+Ylz4eRcwjZyrD1rUVHlr4Y3955mhoKLz2Zz/o
	juahsSRlT1M7FbfGQnDvtMRyyWpSfarl/OfhoxSpkRKftqQV6Ic9/2aOaxq+PIpxid8XaU
X-Received: by 2002:a05:6a00:909b:b0:81f:37b2:5657 with SMTP id d2e1a72fcca58-82341229662mr1894585b3a.17.1769372272617;
        Sun, 25 Jan 2026 12:17:52 -0800 (PST)
Received: from localhost.localdomain ([115.98.233.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e903sm7524260b3a.51.2026.01.25.12.17.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Jan 2026 12:17:52 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Amisha Chhajed <amishhhaaaa@gmail.com>
Subject: [PATCH 1/2] u-string-list: add unit tests for string-list methods
Date: Mon, 26 Jan 2026 01:47:42 +0530
Message-ID: <20260125201743.64317-1-amishhhaaaa@gmail.com>
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

