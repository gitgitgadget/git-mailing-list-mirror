Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A784F1E2
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741952; cv=none; b=Ul4sVGtL0MD/TQ5y2NKcNCteCGFF/s4TmvQFkmkPHRSqTOnM0wNV7Bv+0In7jq44ngqWb0GQ3CY60VO1S8M2E5dA09NXk+xnSpzLmxBdSEyAnuH654Zlsgyl3qw784aBHSaX/B3tAvKDHqFYnkNUpxm32Bv4i+nkZuDzCPzj5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741952; c=relaxed/simple;
	bh=qRAtMpCfs/VogZZ937CNW2OeKMUpmSF1JVVFX9u0cmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AanCpHGDAZqIRWJK0+oFTZKSLjYrd9BPYCVu+nE0vhK9RoJUyCzOJaeMoouPdU1sQipIqq/QpWnIqXwLjA1PiC2HpVNfVWZhKSDvJe2NKF+QRK9gHdZ39nFeRV6HXX8x6btLHUn4u39hP8iQR+x1rsMnR8gnCnhiSKR7xfhR+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP1XaU7L; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP1XaU7L"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-37613975e20so6343375ab.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720741948; x=1721346748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dK36+++idxFxiBr7De/ThWoTv5NaStK007jx0D3AY8k=;
        b=YP1XaU7LfNOs/JM0hRi64Ygc3M4xyF3lMfTORtgf4D9qJ6ydoIdPextMhc2DYa8ABQ
         tc8xnVdH7qYuwymtHcxYI/xHu9wWE5g8H4Z4ATPQC5p5+l8EKZ8ostcsERMcl9u4xbpF
         PUgFj9keN0bxLd9LZSntLA4AHYYSzZNALBq9TgfCrHxZWs5CvdCFl4llg+bsltSPrMIQ
         UibOPdd5ONsx1Nt5SX5Vw417P5OPAalygJUk8j8sPpDJl+lBTJ+LwXUTVetFbO9Xogp3
         cWHg2zI3tKffXQEVI/ngoECamOqyp9jzR4oUMmLsZJPY/Hip+s2SxEm1xKM7PNGhaRgd
         +Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741948; x=1721346748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dK36+++idxFxiBr7De/ThWoTv5NaStK007jx0D3AY8k=;
        b=kAfz3TmA13rLGa/NarAzWXBuqQw7X8uwTgTZyYXfVK8VagF8tSMHTayr4NautPDyxL
         jdcPzALhM/43abFPfWpG4VHtNI8mPk04TAdKzug5k4Dxv45SMxdajJ2KCEnp9Yt3P3wt
         FrizY0fAWrp23dnxQ4v5FGKS0Dtnt/NmvJQcKpoFO8rE5P5iBH/CbknqfAqGYdjQJJDk
         p6HBOBTioUGGp2/9O4CDfzxYSglqOOl5MEHAKtp/9wn0zqqM4YWPhsHyQCLDlby+uUr2
         LMNNmtfpSnaKZfidRswqL5McQmcaCNrOh6dODH4pzrscLwrRvdvdSxD8zbGa6dr+Lude
         xuPg==
X-Gm-Message-State: AOJu0Yz12L5RR80yMzC08L09tmoSFNsvNurbeQnJV1CmaczauwWgCDA6
	QHI0efwTwM9hmCenO/nw+jJiMTYY4Wr07895A9GPfs/12QoaSIDrl/AAj+wT
X-Google-Smtp-Source: AGHT+IHfpEQBFV2KnMh4nag8Jcq/W8EeLJfLZKLJxrG0YT7Km9MGigzg977Z8XbWso3OUNybM4mdpw==
X-Received: by 2002:a05:6e02:194c:b0:375:da94:e46b with SMTP id e9e14a558f8ab-38a56f062a1mr118519985ab.5.1720741948279;
        Thu, 11 Jul 2024 16:52:28 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43898de8sm6255216b3a.27.2024.07.11.16.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:52:27 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [GSoC][PATCH v3] t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
Date: Fri, 12 Jul 2024 05:21:42 +0530
Message-ID: <20240711235159.5320-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708161641.10335-2-shyamthakkar001@gmail.com>
References: <20240708161641.10335-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

helper/test-hashmap.c along with t0011-hashmap.sh test the hashmap.h
library. Migrate them to the unit testing framework for better
debugging, runtime performance and concise code.

Along with the migration, make 'add' tests from the shellscript order
agnostic in unit tests, since they iterate over entries with the same
keys and we do not guarantee the order.

The helper/test-hashmap.c is still not removed because it contains a
performance test meant to be run by the user directly (not used in
t/perf). And it makes sense for such a utility to be a helper.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Josh Steadmon <steadmon@google.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
Range-diff against v2:
1:  bbb4f2f23e ! 1:  03ba77665e t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
    @@ Commit message
     
         helper/test-hashmap.c along with t0011-hashmap.sh test the hashmap.h
         library. Migrate them to the unit testing framework for better
    -    debugging, runtime performance and consice code.
    +    debugging, runtime performance and concise code.
     
         Along with the migration, make 'add' tests from the shellscript order
         agnostic in unit tests, since they iterate over entries with the same
    @@ Commit message
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    +    Helped-by: Josh Steadmon <steadmon@google.com>
    +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
     
      ## Makefile ##
    @@ t/unit-tests/t-hashmap.c (new)
     +		struct test_entry, ent);
     +}
     +
    -+static int key_val_contains(const char *key_val[][3], size_t n,
    ++static int key_val_contains(const char *key_val[][2], char seen[], size_t n,
     +			    struct test_entry *entry)
     +{
     +	for (size_t i = 0; i < n; i++) {
     +		if (!strcmp(entry->key, key_val[i][0]) &&
     +		    !strcmp(get_value(entry), key_val[i][1])) {
    -+			if (!strcmp(key_val[i][2], "USED"))
    ++			if (seen[i])
     +				return 2;
    -+			key_val[i][2] = "USED";
    ++			seen[i] = 1;
     +			return 0;
     +		}
     +	}
    @@ t/unit-tests/t-hashmap.c (new)
     +	hashmap_clear_and_free(&map, struct test_entry, ent);
     +}
     +
    -+static void t_put(struct hashmap *map, int ignore_case)
    -+{
    -+	struct test_entry *entry;
    -+	const char *key_val[][2] = { { "key1", "value1" },
    -+				     { "key2", "value2" },
    -+				     { "fooBarFrotz", "value3" } };
    -+
    -+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
    -+		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
    -+		check(hashmap_put_entry(map, entry, ent) == NULL);
    -+	}
    -+
    -+	entry = alloc_test_entry(ignore_case, "foobarfrotz", "value4");
    -+	entry = hashmap_put_entry(map, entry, ent);
    -+	check(ignore_case ? entry != NULL : entry == NULL);
    -+	free(entry);
    -+
    -+	check_int(map->tablesize, ==, 64);
    -+	check_int(hashmap_get_size(map), ==,
    -+		  ignore_case ? ARRAY_SIZE(key_val) : ARRAY_SIZE(key_val) + 1);
    -+}
    -+
     +static void t_replace(struct hashmap *map, int ignore_case)
     +{
     +	struct test_entry *entry;
     +
     +	entry = alloc_test_entry(ignore_case, "key1", "value1");
    -+	check(hashmap_put_entry(map, entry, ent) == NULL);
    ++	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
     +
     +	entry = alloc_test_entry(ignore_case, ignore_case ? "Key1" : "key1",
     +				 "value2");
    @@ t/unit-tests/t-hashmap.c (new)
     +	free(entry);
     +
     +	entry = alloc_test_entry(ignore_case, "fooBarFrotz", "value3");
    -+	check(hashmap_put_entry(map, entry, ent) == NULL);
    ++	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
     +
     +	entry = alloc_test_entry(ignore_case,
     +				 ignore_case ? "foobarfrotz" : "fooBarFrotz",
    @@ t/unit-tests/t-hashmap.c (new)
     +
     +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
     +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
    -+		check(hashmap_put_entry(map, entry, ent) == NULL);
    ++		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
     +	}
     +
     +	for (size_t i = 0; i < ARRAY_SIZE(query); i++) {
     +		entry = get_test_entry(map, ignore_case, query[i][0]);
     +		if (check(entry != NULL))
     +			check_str(get_value(entry), query[i][1]);
    ++		else
    ++			test_msg("query key: %s", query[i][0]);
     +	}
     +
    -+	check(get_test_entry(map, ignore_case, "notInMap") == NULL);
    ++	check_pointer_eq(get_test_entry(map, ignore_case, "notInMap"), NULL);
    ++	check_int(map->tablesize, ==, 64);
    ++	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
     +}
     +
     +static void t_add(struct hashmap *map, int ignore_case)
     +{
     +	struct test_entry *entry;
    -+	const char *key_val[][3] = {
    -+		{ "key1", "value1", "UNUSED" },
    -+		{ ignore_case ? "Key1" : "key1", "value2", "UNUSED" },
    -+		{ "fooBarFrotz", "value3", "UNUSED" },
    -+		{ ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4", "UNUSED" }
    ++	const char *key_val[][2] = {
    ++		{ "key1", "value1" },
    ++		{ ignore_case ? "Key1" : "key1", "value2" },
    ++		{ "fooBarFrotz", "value3" },
    ++		{ ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4" }
     +	};
     +	const char *queries[] = { "key1",
     +				  ignore_case ? "Foobarfrotz" : "fooBarFrotz" };
    ++	char seen[ARRAY_SIZE(key_val)] = { 0 };
     +
     +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
     +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
    @@ t/unit-tests/t-hashmap.c (new)
     +		{
     +			int ret;
     +			if (!check_int((ret = key_val_contains(
    -+						key_val, ARRAY_SIZE(key_val),
    -+						entry)), ==, 0)) {
    ++						key_val, seen,
    ++						ARRAY_SIZE(key_val), entry)),
    ++				       ==, 0)) {
     +				switch (ret) {
     +				case 1:
     +					test_msg("found entry was not given in the input\n"
    @@ t/unit-tests/t-hashmap.c (new)
     +		}
     +		check_int(count, ==, 2);
     +	}
    ++
    ++	for (size_t i = 0; i < ARRAY_SIZE(seen); i++) {
    ++		if (!check_int(seen[i], ==, 1))
    ++			test_msg("following key-val pair was not iterated over:\n"
    ++				 "    key: %s\n  value: %s",
    ++				 key_val[i][0], key_val[i][1]);
    ++	}
    ++
     +	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
    -+	check(get_test_entry(map, ignore_case, "notInMap") == NULL);
    ++	check_pointer_eq(get_test_entry(map, ignore_case, "notInMap"), NULL);
     +}
     +
     +static void t_remove(struct hashmap *map, int ignore_case)
    @@ t/unit-tests/t-hashmap.c (new)
     +
     +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
     +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
    -+		check(hashmap_put_entry(map, entry, ent) == NULL);
    ++		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
     +	}
     +
     +	for (size_t i = 0; i < ARRAY_SIZE(remove); i++) {
    @@ t/unit-tests/t-hashmap.c (new)
     +	}
     +
     +	entry = alloc_test_entry(ignore_case, "notInMap", "");
    -+	check(hashmap_remove_entry(map, entry, ent, "notInMap") == NULL);
    ++	check_pointer_eq(hashmap_remove_entry(map, entry, ent, "notInMap"), NULL);
     +	free(entry);
    ++
    ++	check_int(map->tablesize, ==, 64);
    ++	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val) - ARRAY_SIZE(remove));
     +}
     +
     +static void t_iterate(struct hashmap *map, int ignore_case)
     +{
     +	struct test_entry *entry;
     +	struct hashmap_iter iter;
    -+	const char *key_val[][3] = { { "key1", "value1", "UNUSED" },
    -+				     { "key2", "value2", "UNUSED" },
    -+				     { "fooBarFrotz", "value3", "UNUSED" } };
    -+	int count = 0;
    ++	const char *key_val[][2] = { { "key1", "value1" },
    ++				     { "key2", "value2" },
    ++				     { "fooBarFrotz", "value3" } };
    ++	char seen[ARRAY_SIZE(key_val)] = { 0 };
     +
     +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
     +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
    -+		check(hashmap_put_entry(map, entry, ent) == NULL);
    ++		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
     +	}
     +
     +	hashmap_for_each_entry(map, &iter, entry, ent /* member name */)
     +	{
     +		int ret;
    -+		if (!check_int((ret = key_val_contains(key_val, ARRAY_SIZE(key_val),
    ++		if (!check_int((ret = key_val_contains(key_val, seen,
    ++						       ARRAY_SIZE(key_val),
     +						       entry)), ==, 0)) {
     +			switch (ret) {
     +			case 1:
    @@ t/unit-tests/t-hashmap.c (new)
     +					 entry->key, get_value(entry));
     +				break;
     +			}
    -+		} else {
    -+			count++;
     +		}
     +	}
    -+	check_int(count, ==, ARRAY_SIZE(key_val));
    ++
    ++	for (size_t i = 0; i < ARRAY_SIZE(seen); i++) {
    ++		if (!check_int(seen[i], ==, 1))
    ++			test_msg("following key-val pair was not iterated over:\n"
    ++				 "    key: %s\n  value: %s",
    ++				 key_val[i][0], key_val[i][1]);
    ++	}
    ++
     +	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
     +}
     +
    @@ t/unit-tests/t-hashmap.c (new)
     +		char *key = xstrfmt("key%d", i);
     +		char *value = xstrfmt("value%d", i);
     +		entry = alloc_test_entry(ignore_case, key, value);
    -+		check(hashmap_put_entry(map, entry, ent) == NULL);
    ++		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
     +		free(key);
     +		free(value);
     +	}
    @@ t/unit-tests/t-hashmap.c (new)
     +	check_int(hashmap_get_size(map), ==, 51);
     +
     +	entry = alloc_test_entry(ignore_case, "key52", "value52");
    -+	check(hashmap_put_entry(map, entry, ent) == NULL);
    ++	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
     +	check_int(map->tablesize, ==, 256);
     +	check_int(hashmap_get_size(map), ==, 52);
     +
    @@ t/unit-tests/t-hashmap.c (new)
     +		else if (!check(i1 != values[i]))
     +			test_msg("strintern(%s) returns input pointer\n",
     +				 values[i]);
    -+		else if (!check(i1 == i2))
    ++		else if (!check_pointer_eq(i1, i2))
     +			test_msg("address('%s') != address('%s'), so strintern('%s') != strintern('%s')",
     +				 i1, i2, values[i], values[i]);
     +		else
    @@ t/unit-tests/t-hashmap.c (new)
     +
     +int cmd_main(int argc UNUSED, const char **argv UNUSED)
     +{
    -+	TEST(setup(t_put, 0), "put works");
    -+	TEST(setup(t_put, 1), "put (case insensitive) works");
     +	TEST(setup(t_replace, 0), "replace works");
     +	TEST(setup(t_replace, 1), "replace (case insensitive) works");
     +	TEST(setup(t_get, 0), "get works");

 Makefile                 |   1 +
 t/helper/test-hashmap.c  | 100 +----------
 t/t0011-hashmap.sh       | 260 ----------------------------
 t/unit-tests/t-hashmap.c | 358 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 361 insertions(+), 358 deletions(-)
 delete mode 100755 t/t0011-hashmap.sh
 create mode 100644 t/unit-tests/t-hashmap.c

diff --git a/Makefile b/Makefile
index 3eab701b10..74bb026610 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,6 +1336,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
+UNIT_TEST_PROGRAMS += t-hashmap
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 2912899558..7b854a7030 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -12,11 +12,6 @@ struct test_entry
 	char key[FLEX_ARRAY];
 };
 
-static const char *get_value(const struct test_entry *e)
-{
-	return e->key + strlen(e->key) + 1;
-}
-
 static int test_entry_cmp(const void *cmp_data,
 			  const struct hashmap_entry *eptr,
 			  const struct hashmap_entry *entry_or_key,
@@ -141,30 +136,16 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 /*
  * Read stdin line by line and print result of commands to stdout:
  *
- * hash key -> strhash(key) memhash(key) strihash(key) memihash(key)
- * put key value -> NULL / old value
- * get key -> NULL / value
- * remove key -> NULL / old value
- * iterate -> key1 value1\nkey2 value2\n...
- * size -> tablesize numentries
- *
  * perfhashmap method rounds -> test hashmap.[ch] performance
  */
 int cmd__hashmap(int argc, const char **argv)
 {
 	struct string_list parts = STRING_LIST_INIT_NODUP;
 	struct strbuf line = STRBUF_INIT;
-	int icase;
-	struct hashmap map = HASHMAP_INIT(test_entry_cmp, &icase);
-
-	/* init hash map */
-	icase = argc > 1 && !strcmp("ignorecase", argv[1]);
 
 	/* process commands from stdin */
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *cmd, *p1, *p2;
-		unsigned int hash = 0;
-		struct test_entry *entry;
 
 		/* break line into command and up to two parameters */
 		string_list_setlen(&parts, 0);
@@ -180,84 +161,8 @@ int cmd__hashmap(int argc, const char **argv)
 		cmd = parts.items[0].string;
 		p1 = parts.nr >= 1 ? parts.items[1].string : NULL;
 		p2 = parts.nr >= 2 ? parts.items[2].string : NULL;
-		if (p1)
-			hash = icase ? strihash(p1) : strhash(p1);
-
-		if (!strcmp("add", cmd) && p1 && p2) {
-
-			/* create entry with key = p1, value = p2 */
-			entry = alloc_test_entry(hash, p1, p2);
-
-			/* add to hashmap */
-			hashmap_add(&map, &entry->ent);
-
-		} else if (!strcmp("put", cmd) && p1 && p2) {
-
-			/* create entry with key = p1, value = p2 */
-			entry = alloc_test_entry(hash, p1, p2);
-
-			/* add / replace entry */
-			entry = hashmap_put_entry(&map, entry, ent);
-
-			/* print and free replaced entry, if any */
-			puts(entry ? get_value(entry) : "NULL");
-			free(entry);
-
-		} else if (!strcmp("get", cmd) && p1) {
-			/* lookup entry in hashmap */
-			entry = hashmap_get_entry_from_hash(&map, hash, p1,
-							struct test_entry, ent);
-
-			/* print result */
-			if (!entry)
-				puts("NULL");
-			hashmap_for_each_entry_from(&map, entry, ent)
-				puts(get_value(entry));
-
-		} else if (!strcmp("remove", cmd) && p1) {
-
-			/* setup static key */
-			struct hashmap_entry key;
-			struct hashmap_entry *rm;
-			hashmap_entry_init(&key, hash);
-
-			/* remove entry from hashmap */
-			rm = hashmap_remove(&map, &key, p1);
-			entry = rm ? container_of(rm, struct test_entry, ent)
-					: NULL;
-
-			/* print result and free entry*/
-			puts(entry ? get_value(entry) : "NULL");
-			free(entry);
-
-		} else if (!strcmp("iterate", cmd)) {
-			struct hashmap_iter iter;
-
-			hashmap_for_each_entry(&map, &iter, entry,
-						ent /* member name */)
-				printf("%s %s\n", entry->key, get_value(entry));
-
-		} else if (!strcmp("size", cmd)) {
-
-			/* print table sizes */
-			printf("%u %u\n", map.tablesize,
-			       hashmap_get_size(&map));
-
-		} else if (!strcmp("intern", cmd) && p1) {
-
-			/* test that strintern works */
-			const char *i1 = strintern(p1);
-			const char *i2 = strintern(p1);
-			if (strcmp(i1, p1))
-				printf("strintern(%s) returns %s\n", p1, i1);
-			else if (i1 == p1)
-				printf("strintern(%s) returns input pointer\n", p1);
-			else if (i1 != i2)
-				printf("strintern(%s) != strintern(%s)", i1, i2);
-			else
-				printf("%s\n", i1);
-
-		} else if (!strcmp("perfhashmap", cmd) && p1 && p2) {
+	
+		if (!strcmp("perfhashmap", cmd) && p1 && p2) {
 
 			perf_hashmap(atoi(p1), atoi(p2));
 
@@ -270,6 +175,5 @@ int cmd__hashmap(int argc, const char **argv)
 
 	string_list_clear(&parts, 0);
 	strbuf_release(&line);
-	hashmap_clear_and_free(&map, struct test_entry, ent);
 	return 0;
 }
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
deleted file mode 100755
index 46e74ad107..0000000000
--- a/t/t0011-hashmap.sh
+++ /dev/null
@@ -1,260 +0,0 @@
-#!/bin/sh
-
-test_description='test hashmap and string hash functions'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-test_hashmap() {
-	echo "$1" | test-tool hashmap $3 > actual &&
-	echo "$2" > expect &&
-	test_cmp expect actual
-}
-
-test_expect_success 'put' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-put foobarfrotz value4
-size" "NULL
-NULL
-NULL
-NULL
-64 4"
-
-'
-
-test_expect_success 'put (case insensitive)' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-size" "NULL
-NULL
-NULL
-64 3" ignorecase
-
-'
-
-test_expect_success 'replace' '
-
-test_hashmap "put key1 value1
-put key1 value2
-put fooBarFrotz value3
-put fooBarFrotz value4
-size" "NULL
-value1
-NULL
-value3
-64 2"
-
-'
-
-test_expect_success 'replace (case insensitive)' '
-
-test_hashmap "put key1 value1
-put Key1 value2
-put fooBarFrotz value3
-put foobarfrotz value4
-size" "NULL
-value1
-NULL
-value3
-64 2" ignorecase
-
-'
-
-test_expect_success 'get' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-put foobarfrotz value4
-get key1
-get key2
-get fooBarFrotz
-get notInMap" "NULL
-NULL
-NULL
-NULL
-value1
-value2
-value3
-NULL"
-
-'
-
-test_expect_success 'get (case insensitive)' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-get Key1
-get keY2
-get foobarfrotz
-get notInMap" "NULL
-NULL
-NULL
-value1
-value2
-value3
-NULL" ignorecase
-
-'
-
-test_expect_success 'add' '
-
-test_hashmap "add key1 value1
-add key1 value2
-add fooBarFrotz value3
-add fooBarFrotz value4
-get key1
-get fooBarFrotz
-get notInMap" "value2
-value1
-value4
-value3
-NULL"
-
-'
-
-test_expect_success 'add (case insensitive)' '
-
-test_hashmap "add key1 value1
-add Key1 value2
-add fooBarFrotz value3
-add foobarfrotz value4
-get key1
-get Foobarfrotz
-get notInMap" "value2
-value1
-value4
-value3
-NULL" ignorecase
-
-'
-
-test_expect_success 'remove' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-remove key1
-remove key2
-remove notInMap
-size" "NULL
-NULL
-NULL
-value1
-value2
-NULL
-64 1"
-
-'
-
-test_expect_success 'remove (case insensitive)' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-remove Key1
-remove keY2
-remove notInMap
-size" "NULL
-NULL
-NULL
-value1
-value2
-NULL
-64 1" ignorecase
-
-'
-
-test_expect_success 'iterate' '
-	test-tool hashmap >actual.raw <<-\EOF &&
-	put key1 value1
-	put key2 value2
-	put fooBarFrotz value3
-	iterate
-	EOF
-
-	cat >expect <<-\EOF &&
-	NULL
-	NULL
-	NULL
-	fooBarFrotz value3
-	key1 value1
-	key2 value2
-	EOF
-
-	sort <actual.raw >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'iterate (case insensitive)' '
-	test-tool hashmap ignorecase >actual.raw <<-\EOF &&
-	put key1 value1
-	put key2 value2
-	put fooBarFrotz value3
-	iterate
-	EOF
-
-	cat >expect <<-\EOF &&
-	NULL
-	NULL
-	NULL
-	fooBarFrotz value3
-	key1 value1
-	key2 value2
-	EOF
-
-	sort <actual.raw >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'grow / shrink' '
-
-	rm -f in &&
-	rm -f expect &&
-	for n in $(test_seq 51)
-	do
-		echo put key$n value$n >> in &&
-		echo NULL >> expect || return 1
-	done &&
-	echo size >> in &&
-	echo 64 51 >> expect &&
-	echo put key52 value52 >> in &&
-	echo NULL >> expect &&
-	echo size >> in &&
-	echo 256 52 >> expect &&
-	for n in $(test_seq 12)
-	do
-		echo remove key$n >> in &&
-		echo value$n >> expect || return 1
-	done &&
-	echo size >> in &&
-	echo 256 40 >> expect &&
-	echo remove key40 >> in &&
-	echo value40 >> expect &&
-	echo size >> in &&
-	echo 64 39 >> expect &&
-	test-tool hashmap <in >out &&
-	test_cmp expect out
-
-'
-
-test_expect_success 'string interning' '
-
-test_hashmap "intern value1
-intern Value1
-intern value2
-intern value2
-" "value1
-Value1
-value2
-value2"
-
-'
-
-test_done
diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/t-hashmap.c
new file mode 100644
index 0000000000..3112b10b33
--- /dev/null
+++ b/t/unit-tests/t-hashmap.c
@@ -0,0 +1,358 @@
+#include "test-lib.h"
+#include "hashmap.h"
+#include "strbuf.h"
+
+struct test_entry {
+	int padding; /* hashmap entry no longer needs to be the first member */
+	struct hashmap_entry ent;
+	/* key and value as two \0-terminated strings */
+	char key[FLEX_ARRAY];
+};
+
+static int test_entry_cmp(const void *cmp_data,
+			  const struct hashmap_entry *eptr,
+			  const struct hashmap_entry *entry_or_key,
+			  const void *keydata)
+{
+	const int ignore_case = cmp_data ? *((int *)cmp_data) : 0;
+	const struct test_entry *e1, *e2;
+	const char *key = keydata;
+
+	e1 = container_of(eptr, const struct test_entry, ent);
+	e2 = container_of(entry_or_key, const struct test_entry, ent);
+
+	if (ignore_case)
+		return strcasecmp(e1->key, key ? key : e2->key);
+	else
+		return strcmp(e1->key, key ? key : e2->key);
+}
+
+static const char *get_value(const struct test_entry *e)
+{
+	return e->key + strlen(e->key) + 1;
+}
+
+static struct test_entry *alloc_test_entry(unsigned int ignore_case,
+					   const char *key, const char *value)
+{
+	size_t klen = strlen(key);
+	size_t vlen = strlen(value);
+	unsigned int hash = ignore_case ? strihash(key) : strhash(key);
+	struct test_entry *entry = xmalloc(st_add4(sizeof(*entry), klen, vlen, 2));
+
+	hashmap_entry_init(&entry->ent, hash);
+	memcpy(entry->key, key, klen + 1);
+	memcpy(entry->key + klen + 1, value, vlen + 1);
+	return entry;
+}
+
+static struct test_entry *get_test_entry(struct hashmap *map,
+					 unsigned int ignore_case, const char *key)
+{
+	return hashmap_get_entry_from_hash(
+		map, ignore_case ? strihash(key) : strhash(key), key,
+		struct test_entry, ent);
+}
+
+static int key_val_contains(const char *key_val[][2], char seen[], size_t n,
+			    struct test_entry *entry)
+{
+	for (size_t i = 0; i < n; i++) {
+		if (!strcmp(entry->key, key_val[i][0]) &&
+		    !strcmp(get_value(entry), key_val[i][1])) {
+			if (seen[i])
+				return 2;
+			seen[i] = 1;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static void setup(void (*f)(struct hashmap *map, int ignore_case),
+		  int ignore_case)
+{
+	struct hashmap map = HASHMAP_INIT(test_entry_cmp, &ignore_case);
+
+	f(&map, ignore_case);
+	hashmap_clear_and_free(&map, struct test_entry, ent);
+}
+
+static void t_replace(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry;
+
+	entry = alloc_test_entry(ignore_case, "key1", "value1");
+	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+
+	entry = alloc_test_entry(ignore_case, ignore_case ? "Key1" : "key1",
+				 "value2");
+	entry = hashmap_put_entry(map, entry, ent);
+	if (check(entry != NULL))
+		check_str(get_value(entry), "value1");
+	free(entry);
+
+	entry = alloc_test_entry(ignore_case, "fooBarFrotz", "value3");
+	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+
+	entry = alloc_test_entry(ignore_case,
+				 ignore_case ? "foobarfrotz" : "fooBarFrotz",
+				 "value4");
+	entry = hashmap_put_entry(map, entry, ent);
+	if (check(entry != NULL))
+		check_str(get_value(entry), "value3");
+	free(entry);
+}
+
+static void t_get(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry;
+	const char *key_val[][2] = { { "key1", "value1" },
+				     { "key2", "value2" },
+				     { "fooBarFrotz", "value3" },
+				     { ignore_case ? "key4" : "foobarfrotz", "value4" } };
+	const char *query[][2] = {
+		{ ignore_case ? "Key1" : "key1", "value1" },
+		{ ignore_case ? "keY2" : "key2", "value2" },
+		{ ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3" }
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
+		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(query); i++) {
+		entry = get_test_entry(map, ignore_case, query[i][0]);
+		if (check(entry != NULL))
+			check_str(get_value(entry), query[i][1]);
+		else
+			test_msg("query key: %s", query[i][0]);
+	}
+
+	check_pointer_eq(get_test_entry(map, ignore_case, "notInMap"), NULL);
+	check_int(map->tablesize, ==, 64);
+	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
+}
+
+static void t_add(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry;
+	const char *key_val[][2] = {
+		{ "key1", "value1" },
+		{ ignore_case ? "Key1" : "key1", "value2" },
+		{ "fooBarFrotz", "value3" },
+		{ ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4" }
+	};
+	const char *queries[] = { "key1",
+				  ignore_case ? "Foobarfrotz" : "fooBarFrotz" };
+	char seen[ARRAY_SIZE(key_val)] = { 0 };
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
+		hashmap_add(map, &entry->ent);
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(queries); i++) {
+		int count = 0;
+		entry = hashmap_get_entry_from_hash(map,
+			ignore_case ? strihash(queries[i]) :
+				      strhash(queries[i]),
+			queries[i], struct test_entry, ent);
+
+		hashmap_for_each_entry_from(map, entry, ent)
+		{
+			int ret;
+			if (!check_int((ret = key_val_contains(
+						key_val, seen,
+						ARRAY_SIZE(key_val), entry)),
+				       ==, 0)) {
+				switch (ret) {
+				case 1:
+					test_msg("found entry was not given in the input\n"
+						 "    key: %s\n  value: %s",
+						 entry->key, get_value(entry));
+					break;
+				case 2:
+					test_msg("duplicate entry detected\n"
+						 "    key: %s\n  value: %s",
+						 entry->key, get_value(entry));
+					break;
+				}
+			} else {
+				count++;
+			}
+		}
+		check_int(count, ==, 2);
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(seen); i++) {
+		if (!check_int(seen[i], ==, 1))
+			test_msg("following key-val pair was not iterated over:\n"
+				 "    key: %s\n  value: %s",
+				 key_val[i][0], key_val[i][1]);
+	}
+
+	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
+	check_pointer_eq(get_test_entry(map, ignore_case, "notInMap"), NULL);
+}
+
+static void t_remove(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry, *removed;
+	const char *key_val[][2] = { { "key1", "value1" },
+				     { "key2", "value2" },
+				     { "fooBarFrotz", "value3" } };
+	const char *remove[][2] = { { ignore_case ? "Key1" : "key1", "value1" },
+				    { ignore_case ? "keY2" : "key2", "value2" } };
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
+		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(remove); i++) {
+		entry = alloc_test_entry(ignore_case, remove[i][0], "");
+		removed = hashmap_remove_entry(map, entry, ent, remove[i][0]);
+		if (check(removed != NULL))
+			check_str(get_value(removed), remove[i][1]);
+		free(entry);
+		free(removed);
+	}
+
+	entry = alloc_test_entry(ignore_case, "notInMap", "");
+	check_pointer_eq(hashmap_remove_entry(map, entry, ent, "notInMap"), NULL);
+	free(entry);
+
+	check_int(map->tablesize, ==, 64);
+	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val) - ARRAY_SIZE(remove));
+}
+
+static void t_iterate(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry;
+	struct hashmap_iter iter;
+	const char *key_val[][2] = { { "key1", "value1" },
+				     { "key2", "value2" },
+				     { "fooBarFrotz", "value3" } };
+	char seen[ARRAY_SIZE(key_val)] = { 0 };
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
+		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+	}
+
+	hashmap_for_each_entry(map, &iter, entry, ent /* member name */)
+	{
+		int ret;
+		if (!check_int((ret = key_val_contains(key_val, seen,
+						       ARRAY_SIZE(key_val),
+						       entry)), ==, 0)) {
+			switch (ret) {
+			case 1:
+				test_msg("found entry was not given in the input\n"
+					 "    key: %s\n  value: %s",
+					 entry->key, get_value(entry));
+				break;
+			case 2:
+				test_msg("duplicate entry detected\n"
+					 "    key: %s\n  value: %s",
+					 entry->key, get_value(entry));
+				break;
+			}
+		}
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(seen); i++) {
+		if (!check_int(seen[i], ==, 1))
+			test_msg("following key-val pair was not iterated over:\n"
+				 "    key: %s\n  value: %s",
+				 key_val[i][0], key_val[i][1]);
+	}
+
+	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
+}
+
+static void t_alloc(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry, *removed;
+
+	for (int i = 1; i <= 51; i++) {
+		char *key = xstrfmt("key%d", i);
+		char *value = xstrfmt("value%d", i);
+		entry = alloc_test_entry(ignore_case, key, value);
+		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+		free(key);
+		free(value);
+	}
+	check_int(map->tablesize, ==, 64);
+	check_int(hashmap_get_size(map), ==, 51);
+
+	entry = alloc_test_entry(ignore_case, "key52", "value52");
+	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+	check_int(map->tablesize, ==, 256);
+	check_int(hashmap_get_size(map), ==, 52);
+
+	for (int i = 1; i <= 12; i++) {
+		char *key = xstrfmt("key%d", i);
+		char *value = xstrfmt("value%d", i);
+
+		entry = alloc_test_entry(ignore_case, key, "");
+		removed = hashmap_remove_entry(map, entry, ent, key);
+		if (check(removed != NULL))
+			check_str(value, get_value(removed));
+		free(key);
+		free(value);
+		free(entry);
+		free(removed);
+	}
+	check_int(map->tablesize, ==, 256);
+	check_int(hashmap_get_size(map), ==, 40);
+
+	entry = alloc_test_entry(ignore_case, "key40", "");
+	removed = hashmap_remove_entry(map, entry, ent, "key40");
+	if (check(removed != NULL))
+		check_str("value40", get_value(removed));
+	check_int(map->tablesize, ==, 64);
+	check_int(hashmap_get_size(map), ==, 39);
+	free(entry);
+	free(removed);
+}
+
+static void t_intern(struct hashmap *map, int ignore_case)
+{
+	const char *values[] = { "value1", "Value1", "value2", "value2" };
+
+	for (size_t i = 0; i < ARRAY_SIZE(values); i++) {
+		const char *i1 = strintern(values[i]);
+		const char *i2 = strintern(values[i]);
+
+		if (!check(!strcmp(i1, values[i])))
+			test_msg("strintern(%s) returns %s\n", values[i], i1);
+		else if (!check(i1 != values[i]))
+			test_msg("strintern(%s) returns input pointer\n",
+				 values[i]);
+		else if (!check_pointer_eq(i1, i2))
+			test_msg("address('%s') != address('%s'), so strintern('%s') != strintern('%s')",
+				 i1, i2, values[i], values[i]);
+		else
+			check_str(i1, values[i]);
+	}
+}
+
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
+{
+	TEST(setup(t_replace, 0), "replace works");
+	TEST(setup(t_replace, 1), "replace (case insensitive) works");
+	TEST(setup(t_get, 0), "get works");
+	TEST(setup(t_get, 1), "get (case insensitive) works");
+	TEST(setup(t_add, 0), "add works");
+	TEST(setup(t_add, 1), "add (case insensitive) works");
+	TEST(setup(t_remove, 0), "remove works");
+	TEST(setup(t_remove, 1), "remove (case insensitive) works");
+	TEST(setup(t_iterate, 0), "iterate works");
+	TEST(setup(t_iterate, 1), "iterate (case insensitive) works");
+	TEST(setup(t_alloc, 0), "grow / shrink works");
+	TEST(setup(t_intern, 0), "string interning works");
+	return test_done();
+}
-- 
2.45.2

