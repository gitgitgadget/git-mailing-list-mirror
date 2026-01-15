Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD8395274
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483032; cv=none; b=hZ7o3iBIWWr0elbvr3OlH65/4cz6uAsSoElWGjhb6Lo021Tn7iC4g9PT9JyCTzZlxqeFTiJN/vkp5kqTtmEPrldUwGJ9dICuu71HHdQDhTL7DpBMLYRFGCLMIRjh8mnWYQ1WlVz6cGUxRDCzjzwmuVHjCdlO8hDuUtyMxBRrQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483032; c=relaxed/simple;
	bh=OaROQ1phhpOkDSspcG57783t5mfNzYz2sIwRLDPNiFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvM3YQj2nUQ0hMt1/4ldKzLzGryszW3yEYiJONLDAZ25VlpzieVwwv1uSbRwC/UjRcCcTVJKx60YXUxh1eET4HXWOJ202Nr27bbpjqWTIzpees63umPZ25ei8fJvCYCR5xOkHhV5oyfjqq90KOigMSuTCJD/RYzNQ7N+nOf6JLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0ud8hbL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0ud8hbL"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801d98cf39so561845e9.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 05:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768483029; x=1769087829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcT+FPe/+VBQ/TS5V24a/XQ1MoWNhGtB/A83gtSBU5A=;
        b=R0ud8hbLcJ4HkxF24MS/18KJPZq8FIM/zcyaAAO2UEXK8ykO3Re+30rfg1qY63EsLg
         GlJklBnt6ACfIFqaqDBpwG9au/JONvzJMI5W6fh+M6fOe1xaXVXZI1/ZGEb3lzRErmMz
         1ESvzRANKjSAzlMpe/WgJKwo4qgM1hHCVHSEhATidPKc2aRbrlSvDXLfX7/L7xg9boT+
         7RQ5hnO4a2vJGEtlybpETjGMsJFZJYdNBdX7cDZxNrBGxFT2DeX8Yp6iZmLfuJGqfrh7
         9ZoOokc2uA+nju10LrTabrr91pLArdR9lb+S8fDpw+1ruoanHq82MbXeNEB4RJrmUEuk
         Q5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768483029; x=1769087829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VcT+FPe/+VBQ/TS5V24a/XQ1MoWNhGtB/A83gtSBU5A=;
        b=d/XbX82Eqr8Vwqk3hQYWX8zAnNDWK7mfddULtsx2EqhcSqhJ+2zKM2fAWiYhA9JvcI
         4YahmYqDuQH+263LzuXRmSGVuLrG2Wc/7dnoSyZI0BAwFf0UkScFwlXyZlIDgh0GbTJi
         Pm1Jx9XcEntBCMXyQctTDm0sTDhogTsBNQ/5d13Q9aLFBY3KmLnJzhiDk4c1d2dbFrUF
         52tZaiCQ/J6YoPTvYqwmA12Ioi/bG25fYid9DvVAMzusyX/P/ilrxgaedvj3YKl6qZtd
         XiOoMN0nCjeRMZFw7wyzw1+U4OrOkKy93gAkZjda04Kv+PDXeB4EMrZZV/d68ysWEtYR
         GSMA==
X-Gm-Message-State: AOJu0YzMpMMPBx8Wo1jyGTLHQUp6l/mg17P0MkoTlScSmbrqL1Oxa1CJ
	cDlcZXmdnfx2/wkh9iRuVf6r4JPpnUbCQaQc9WqU6khX+bbr/ZkwFp4VG5gEOV1T
X-Gm-Gg: AY/fxX49FxGwKNtDbBz1o78BERk+Ujq8WjWErsKR3DUmHjzqullIlM4hRjHAopiNMFv
	bmzOoZcG/6uFvzVUfNDatUG3RifBKNxkY6SCDYwdD9i1PwNYUPuklVaeuXdU9evWHHiVhyVqG7q
	asoxz1sB2tQL6RiAG+MqwlYRR9aZcIloug8txN6K6q+RkKdBWICX12v2EfvOqCGBwGhPIQjtRGS
	OtCLOHGEtPODvIVoCAmBh6DPSU/6FY+vAtmjrFbFVU/2FbGQh8TOfTgv4maGJkIkab6EtusBL30
	mqS80ZRGEo6yL+4DM7u4nOFacXQfsb1HLSBNlpAK7Qg3DxzTrIL6FkD/rxOFzhMw/6uommiFzKN
	BtObhO1wU6gp/ZQY4ua6GKUTr7ful06TlnCFvCQd0uv7PWp7DHQfWQn+0MkNBxKqJj6eWbff0X5
	nAJTFHk/FjyYtKHYddP/5Y35N3+uNMp91ZG2d4zgraHKIegUrZNpY=
X-Received: by 2002:a05:600c:4713:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-47ee33af4camr76280765e9.35.1768483029132;
        Thu, 15 Jan 2026 05:17:09 -0800 (PST)
Received: from localhost.localdomain ([105.113.70.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428f1ba7sm49882495e9.15.2026.01.15.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 05:17:08 -0800 (PST)
From: Seyi Kufoiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH 1/1] oidmap: make entry cleanup explicit in oidmap_clear
Date: Thu, 15 Jan 2026 14:16:34 +0100
Message-ID: <20260115131634.51968-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115131634.51968-1-kuforiji98@gmail.com>
References: <20260115131634.51968-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace oidmap's use of hashmap_clear_() and layout-dependent freeing
with an explicit iteration and optional free callback. This removes
reliance on struct layout assumptions while keeping the existing API
intact.

Add tests for oidmap_clear_with_free behavior.
test_oidmap__clear_with_free_callback verifies that entries are freed
when a callback is provided, while
test_oidmap__clear_without_free_callback verifies that entries are not
freed when no callback is given. These tests ensure the new clear
implementation behaves correctly and preserves ownership semantics.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 oidmap.c                | 23 ++++++++++++++++++++---
 oidmap.h                | 15 +++++++++++++++
 t/unit-tests/u-oidmap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/oidmap.c b/oidmap.c
index 508d6c7dec..a1ef53577f 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -24,11 +24,28 @@ void oidmap_init(struct oidmap *map, size_t initial_size)
 
 void oidmap_clear(struct oidmap *map, int free_entries)
 {
-	if (!map)
+	oidmap_clear_with_free(map,
+		free_entries ? free : NULL);
+}
+
+void oidmap_clear_with_free(struct oidmap *map,
+			    oidmap_free_fn free_fn)
+{
+	struct hashmap_iter iter;
+	struct hashmap_entry *e;
+
+	if (!map || !map->map.cmpfn)
 		return;
 
-	/* TODO: make oidmap itself not depend on struct layouts */
-	hashmap_clear_(&map->map, free_entries ? 0 : -1);
+	hashmap_iter_init(&map->map, &iter);
+	while ((e = hashmap_iter_next(&iter))) {
+		struct oidmap_entry *entry =
+			container_of(e, struct oidmap_entry, internal_entry);
+		if (free_fn)
+			free_fn(entry);
+	}
+
+	hashmap_clear(&map->map);
 }
 
 void *oidmap_get(const struct oidmap *map, const struct object_id *key)
diff --git a/oidmap.h b/oidmap.h
index 67fb32290f..acddcaecdd 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -35,6 +35,21 @@ struct oidmap {
  */
 void oidmap_init(struct oidmap *map, size_t initial_size);
 
+/*
+ * Function type for functions that free oidmap entries.
+ */
+typedef void (*oidmap_free_fn)(void *);
+
+/*
+ * Clear an oidmap, freeing any allocated memory. The map is empty and
+ * can be reused without another explicit init.
+ *
+ * The `free_fn`, if not NULL, is called for each oidmap entry in the map
+ * to free any user data associated with the entry.
+ */
+void oidmap_clear_with_free(struct oidmap *map,
+			    oidmap_free_fn free_fn);
+
 /*
  * Clear an oidmap, freeing any allocated memory. The map is empty and
  * can be reused without another explicit init.
diff --git a/t/unit-tests/u-oidmap.c b/t/unit-tests/u-oidmap.c
index b23af449f6..00481df63f 100644
--- a/t/unit-tests/u-oidmap.c
+++ b/t/unit-tests/u-oidmap.c
@@ -14,6 +14,13 @@ struct test_entry {
 	char name[FLEX_ARRAY];
 };
 
+static int freed;
+
+static void test_free_fn(void *p) {
+	freed++;
+	free(p);
+}
+
 static const char *const key_val[][2] = { { "11", "one" },
 					  { "22", "two" },
 					  { "33", "three" } };
@@ -134,3 +141,37 @@ void test_oidmap__iterate(void)
 	cl_assert_equal_i(count, ARRAY_SIZE(key_val));
 	cl_assert_equal_i(hashmap_get_size(&map.map), ARRAY_SIZE(key_val));
 }
+
+void test_oidmap__clear_without_free_callback(void)
+{
+	struct oidmap local_map = OIDMAP_INIT;
+	struct test_entry *entry;
+
+	freed = 0;
+
+	FLEX_ALLOC_STR(entry, name, "one");
+	cl_parse_any_oid("11", &entry->entry.oid);
+	cl_assert(oidmap_put(&local_map, entry) == NULL);
+
+	oidmap_clear_with_free(&local_map, NULL);
+
+	cl_assert_equal_i(freed, 0);
+
+	free(entry);
+}
+
+void test_oidmap__clear_with_free_callback(void)
+{
+	struct oidmap local_map = OIDMAP_INIT;
+	struct test_entry *entry;
+
+	freed = 0;
+
+	FLEX_ALLOC_STR(entry, name, "one");
+	cl_parse_any_oid("11", &entry->entry.oid);
+	cl_assert(oidmap_put(&local_map, entry) == NULL);
+
+	oidmap_clear_with_free(&local_map, test_free_fn);
+
+	cl_assert_equal_i(freed, 1);
+}
-- 
2.43.0

