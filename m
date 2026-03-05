Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AED3793C9
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705165; cv=none; b=dA04RDlH1C9LRAt5SOKoQafZ7RaUC6cN3RFuny8uIEjVFT+OzLO+I1CtodP5DSSGb7/cyiL9PgF7lK2uIV242l6r3VWiH4rZSy7NQXWmQYpDBJdPvzJRvnQ1dIpPWU2t6iBDLLJy3sIgjQDQhX+Bxb6I5Hn3T5GEzzYh2tgyobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705165; c=relaxed/simple;
	bh=7lY6i39gtJ+3cFcmUkUxRAYFASoPVnRe0uWlIbgVEEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWWIYEbXNZ/wpN4atYtkJezb7TJZqoQnW5meify5Ay8CP+LSWd3rYlMQwRI+zRvNCK+R4/ZX0Md8hQpFI0HAoh49ltYOdqYW+nFxNujMnrFin3tS1YcTg2hSA0QxbsI5v1WnYmLaKbjXxtGBbYPl3Aomw4+9MVrUtQdJY+ju6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQMezHPn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQMezHPn"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-660fb578f8eso3014366a12.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 02:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772705162; x=1773309962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhjVihwXwXH+H1aMZRfNz6NYRrWCy6fjycqEgdsuQko=;
        b=PQMezHPnLj+C37cjDnwdlX6XPgyUTkOLsry4jUhMguIzJub9Dgtx5c4PZqgj+DeWaV
         4IBB7CdSxI6CToRVxAaZmNQpdQ9iExajb87L1xUHN/1M97g9Mjpq0hxa4yGsdmtKyPE4
         455zGNI3C/UmV85C+Aj+rzE0DdmQKqUTMA4xMipV10HPf/LVEMuyZOKzjU/QQN66aBLP
         pNaHGkdQoQWfBL1n6ajmykNTxMp0rho1FqvZMDWFYHwac21mGdWdaMdhbauFHplxbwGp
         nEs8/KjV27X5wn14p+0hIxzZnIFfNC/0xSEGv3LqOoWAO6TZIW+i9RMBFQbqEprn/A0r
         OBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772705162; x=1773309962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rhjVihwXwXH+H1aMZRfNz6NYRrWCy6fjycqEgdsuQko=;
        b=TX8FqwfJCbR8gchS/NUeXNx9yxMd1MbljFaUyf15ERNdhSkvRCxnWPdK9H20gYVRKP
         Yv9yue71Fhw2gUnBAmeglXKK4FEMFTuVMTci1vw9qFq7We41rZXRpYmGmLqQ4n2bmxFg
         l4MxNDqAYxoTgNFi8Qix/oJrC64oW5RfgYWCLyd9YpykCOegffyL7krQyWK/vj+ZgPhy
         rW8G+aX3giR3Kywf3M4cA93x4Tgpv9nUhrVXiGFtNIC0mkSgXCBbCLZkcTaozweXezVd
         ITaAyGgQ80Wco/kwBr6TUgoZSgD1kjjsOWH9isMvJ9Uzpmc8BiwIYCSslldE8lUkw5Gu
         DTow==
X-Gm-Message-State: AOJu0YyqlIoxkO74C0ozVI45xNG7kEXwFFPJ9gk0aZSx4IX6QS2E+Syy
	3vWej8Ub+gaddbQWizsvi5hrVkwjxfRYHpbYSIoX7g09zjxBrF5kkAUcdL7NGzy+
X-Gm-Gg: ATEYQzz86vjgGZPFGuxurxaCYwetRXmGM7qVnoj/3Gi8mW5eJYYLkbtA0BMWBxEnF9v
	cSE0CENt0I5CrE3A75wMvuBDN0X5BSYZ+zVXflAc11B61LN79zaN7/SgcrO6egStM9C/3hudGdK
	XMZBYVu9rO6P/5JoNkIR1fX/L7Z3kKKfgzW4Z40Zi4C6vhhUms9rh3qwcCuszEIU3Cpddh47qZ8
	T7jzPU9SQYrZmz+BlgU6cfGiRB6fvj5ofEYhBhStgCWcMC6PFiGHc0decJci+VvoQH2BGOJ3LSE
	aLlyWBVvSgL7gurNguMVbFazqU0H7t25kuDPxScIfmC4Ec4N+JU8/5zuRkw4498bdDyh/ZorZ2I
	ndUDxWmhhkBpsu6vX25HwHZB+9kWmVtfVgE6MknH/F4buvV3UGYm2sUIwuC2BkKYlBYKi7l7Lfk
	uSldupJZxwYRbzTTdcViy8cTWZh7lM0+0sEqSJ6wW+b1XRAHf98MhFrw==
X-Received: by 2002:a17:907:c1e:b0:b93:9407:ea59 with SMTP id a640c23a62f3a-b93f1616f00mr346922266b.56.1772705161805;
        Thu, 05 Mar 2026 02:06:01 -0800 (PST)
Received: from localhost.localdomain ([105.113.103.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac513bcsm879815266b.19.2026.03.05.02.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:06:01 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH v3 1/2] oidmap: make entry cleanup explicit in oidmap_clear
Date: Thu,  5 Mar 2026 11:05:25 +0100
Message-ID: <20260305100526.102130-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305100526.102130-1-kuforiji98@gmail.com>
References: <20260302200018.75731-1-kuforiji98@gmail.com>
 <20260305100526.102130-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

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

