Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AB32E126
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481667; cv=none; b=MWrMxzXiXCvaJ9qPwA/NO6naz9RXJknE67uqV2vlxpeEdNMyi+Cot+J2fgJyvI0oSj/mYPuzomEfq581Y8t1dK5ZuShxFcca1ab2p/MPcBFl57QzSOv5ISQbsEwuA9Mfomslqkubk2qHVQXlP+3pbixSZy6o580G8Jm1HgHeS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481667; c=relaxed/simple;
	bh=7lY6i39gtJ+3cFcmUkUxRAYFASoPVnRe0uWlIbgVEEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQKSl4/hV5nYn2m9eRRd4roZ6OGbIVwozdzD6YA5TyrfmxTzuSe5ACCbre6sdTTwzxV9QOD8fQJRCvI/p1vmYzBQ3pE52VL0eJom7Y4p7GJhLb5CVZIjofnof85ogOq/n44Gkxa/liqVD/X2Ta/fqYtTudXb074a+f446tQqiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUqWWoOO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUqWWoOO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483703e4b08so43199495e9.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 12:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772481664; x=1773086464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhjVihwXwXH+H1aMZRfNz6NYRrWCy6fjycqEgdsuQko=;
        b=DUqWWoOOCFJ2ISYqw1E5DRpkKX/HEBTJQkcUYEccyfdGwCPHlpNneabwwA5ICQ1bJR
         55hVpsR4f5wLMTCoBz0u7k3pTiwt3Nu7yAtzFMp++Ha7bL6dGbRo8BqkbYN3w9NfjVGU
         7D8NXcoHRicUZ12SDLLMzvBpAxJKpRjwuxsvlGIewVE1S4OVaoppsOWXBZt4wsDWYPF9
         hiY1dqSA6QvgQtxv5cGEX7gOfq4nNx0BHnaAyhL1FTBV1T63y7e0lvvaZ6iXNLoTADYy
         u6tNRtLL1QcarGk4XCp7XJhUdEhCL37f+3B2+mFyPfK1Va9U5owB+sd4E9m5D2vRrecI
         faEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481664; x=1773086464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rhjVihwXwXH+H1aMZRfNz6NYRrWCy6fjycqEgdsuQko=;
        b=m/ee0E8PTvpU2CY7pW4iqepDZlzkGqjCJrFZEE1etq+Hy7qwPTPlDCQ8y3cOtZsTff
         u+rfCQZ6qA2hj7P7QAoXpoFm5C6G5LHLddeF59SM5BcNI/BRKZFWptJaadRIYw1nsKRO
         fwGDABePtZ0NuYtESiOfDcUyYcMSKsBo4ZycUsh4Del5yU+Vd0Bk9z2qHZ6ewO8jZhfs
         dnWFJzp14+xvBVDxEdJ1QELDDKHixYD9//t4egUuPOqhDyZIEof9DAixVdLvPDSga9DI
         deSmULtrSsgIWQwaWIWoODYSX07PKHecbh5/mxYCKH4ORaKxgLEYkoT190N3SCpeCpb5
         ub4Q==
X-Gm-Message-State: AOJu0YzUxarPniZwR0/TDdRTftimEQJ4lQcdQT8hLsroP4HCHCO8zDCF
	iFBFV7XnENeBze4kcwOailDXhN3mBpoB89y674Qblb4R/J+BXpjZjDGQVU25O9uQ
X-Gm-Gg: ATEYQzx3HWUeFaswBywEb9MzmRGl1mIuOilBUCebGpIq4tsTm768hDiZDJ2uU2lDJdw
	Nj0To9G2aVSWk3p3P02M0PmJk7Z4hzhgtpGsUYzfn37xYQ6xnflzQjRh5TF1oFzHjJ9Ag8Q7K0d
	vGHYUelR3uTv4S4QCqQm/SjHqox1uB0CLM+Pmf837oaHocwRikHHBZBYZXPHT5gjYF9rcWq9v8I
	zeBIbWSSz0fiiqt4UMkVjya+74An+hXgjoqAVPdV2S5VtmpbMKjT5L3aLtN/IZIfHxhid6IZwO0
	Yya7hjn4aTS8Wgkdki2C4SCtkgluDi5C3cRbER0Zn/XzFRim/cqoAt8HS8TCuRwBaaaW0vL63Og
	XOEpzDr6/gCLpPsXDoF1MVSI/53aDAVMgAXYlXuponYkKSSU/CZwzzRVbtHzVobVZRcE3CoCLJs
	1aXTSCaoo62EzH7P1GjhFufhI2+RyDQMQM1+q5/CsFCwohc7nt6DrmWgYvtUooqsQ/fvFu1U0=
X-Received: by 2002:a05:600c:820c:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-483c9937b2dmr213913155e9.15.1772481663603;
        Mon, 02 Mar 2026 12:01:03 -0800 (PST)
Received: from localhost.localdomain ([105.113.67.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126547absm446875e9.7.2026.03.02.12.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:01:03 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH v2 1/5] oidmap: make entry cleanup explicit in oidmap_clear
Date: Mon,  2 Mar 2026 21:00:13 +0100
Message-ID: <20260302200018.75731-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302200018.75731-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
 <20260302200018.75731-1-kuforiji98@gmail.com>
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

