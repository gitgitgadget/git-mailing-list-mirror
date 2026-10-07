Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F64B8296
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381066; cv=none; b=enCb7UcRGC8KqHz5G7fvDwOM/7k5mjOpnrLyEVeCT8biv+as17RkTkZsWobTt6BiYvVmz6lO4ostoVUoHnuKGQaN2q9R6urhZGYlUIaFCBQFfnBRZl6G4/N2XQipQUWz/9ISWn6ZSWoWeEMZ8PCtMdAl+JcBPL1ynKEDZ1GHCPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381066; c=relaxed/simple;
	bh=Zp8GPPADbVPtb4Jch+0KsFda9xnjhoIqCiKe+kHQ2jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMs9/XVsqT2qfgdhwCtO/zBvzeOuMFfy9tczmrCUItjbPjrcjHpMrf0OVWFXJcZOUPSyH+tX7avs+4HUfsadsnLMT5E1UX2NZOyb7ZTRl1/ZmL6RAViK1zk/3vMdODebNxrK4MGp6LN9BDNFNdfr35ytDzDjMwpyZ0REcjzVOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSrKBhIJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSrKBhIJ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso983298a12.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791381053; x=1791985853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5+Rn58n7Hs8Ya1Mdu4WswJ+OMAqCPJ+PkHeemGtfOAg=;
        b=TSrKBhIJdw4MEIV0o569IWf7wfAj/tZ06bF0YgCUi/3mYrrGKkzcfOqX5p6NF3l9sQ
         MImHNP4QKtN0kju2SagMhhTnJBfiXYI9kSq7BN2BBrlabrw8oKS1DQOs+2FNdZWSViqa
         jOURoSYSZ8uLExRAlVDnkk1CrL5o0vw8ynhT7mSgwObGqtN4TGCFRdP7iMc36N5RpGGv
         /IAVIxglLb6MQRjppcBMc2YARl30Eb4INyXRV9LE+1ABPhGMIS/9c+rdjZ4xkkR3tiGX
         AJB0/A5dlWrIQYEEVmnh91g39ZF+VcvPhpvzLRgKhDQmf6sL4fWv9C1t+GTLaTpoIWfP
         rjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791381053; x=1791985853;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+Rn58n7Hs8Ya1Mdu4WswJ+OMAqCPJ+PkHeemGtfOAg=;
        b=UFtCWCl09617ecqmsaTucCtrkiznbMfr0tT9Ci39fp531o/PMaVZO9808Fm4s2a9zy
         8+LBx9QCj9+eoTYfgVl+o69RaLfyirUUsPwYyuarqIgyc2EVTDrRb5wG7TCgT4TM/iEH
         MHJ/n+Zt2Gw1/4/7uMsVqVYtQSeI6VNqSryPA7ngfOCu0UmOf73ToylkeDF1y+W88NMi
         YOiJbmpV8QfjmhdrFgZqwgabQUIDtmLrQIeA0nLODWp5Fmg5gNI4ogrR123DkbJzioIM
         c3VKP/UJkoPzbUOM2CKMZXB4v6EhNRAwHr9a9Sw5upMlhO32S2bHJPiBz3hPX4xqsffU
         WfiA==
X-Gm-Message-State: AFq9FYINeTBpCptUe+JeQGDEIzZzJJmo2YzGPcStWZ7LVwWW0GBqHAXa
	wZn4JBxNTvcwa2uSC5WU+MsDoMHF5A28mUY6FF6Ef/UpfthEznyNuZlmsjaQylhP6dEhxw==
X-Gm-Gg: AYBFou1IE6cfWP1QhkoKmMm67Nq0Zs+aNokzVNTGKavl+gaVZo4JWV6R0PxcehQB6ot
	EbRecsQZRvXe+MdnHJauuWcC17oElCv8e9ybNkr/xeS2B62PynFOAYqtBEV0biPApLh94hv+8Vt
	pBfNCtdeR62dUX0d1DE0pyodupns8synIQ7GTbgSEu4rH7hdDuiKQs9W/F/LAcZtAgOLLtodqQx
	1Og4f5dp3wVsj3OyUvempaDR+dw0kg6xhdtQEaOoru5GsaQDXtIF/UYup7VtKIGMvIAHVgpcBts
	YQag8hgaaM/+DTR7dIyBReaumZ2MoApzNTBuUWHPKHy7G3uYP63LIIP1Lp0ehG1oSE79pqH6bis
	zPnVawn5BWry8Wh6A7Z+4ia1W3FgvDAAP9cJZbG2UHng5Jj7q0JbB5FaiRKuQINxBEX5r06cUEq
	a0TEeepc6sX2ZC7Ax4kLl23i0OMCxGyc1dxAEaUSqZ7WfVra5ZQ/ZFsVNdKJPtup6FNz0VjHW68
	Cg/TVc=
X-Received: by 2002:a17:90b:518e:b0:3a4:b8f2:7686 with SMTP id 98e67ed59e1d1-3a8a192c4c8mr2056799a91.12.1791381052491;
        Wed, 07 Oct 2026 06:50:52 -0700 (PDT)
Received: from archlinux ([2409:40f4:314a:a1e2:9855:ada9:1db7:a1fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533abe0asm10577916a91.1.2026.10.07.06.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:50:51 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v2 2/3] mergesort: move sorting tests to the unit-test framework
Date: Wed,  7 Oct 2026 19:20:24 +0530
Message-ID: <0429552774367ddcc3c2fda78e09a83650ccfa02.1791365181.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791365181.git.dilsheddilu123@gmail.com>
References: <20261007034205.32619-1-dilsheddilu123@gmail.com> <cover.1791365181.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mergesort certification checks exercise C code directly, so they do
not need a shell test and test-tool command. Move their distributions and
transformations to Clar, retaining the sorted-value, stability and list
length checks. Add small cases for both list sort macros and debug hooks.

Keep node storage available to the cleanup fixture and bound validation
so a failed assertion can release it without walking a broken list.
Remove the unused generate command along with the old test command,
leaving sort available for the sorting benchmark.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 Makefile                   |   1 +
 t/helper/test-mergesort.c  | 345 +---------------------------------
 t/meson.build              |   2 +-
 t/t0071-sort.sh            |  18 --
 t/unit-tests/u-mergesort.c | 369 +++++++++++++++++++++++++++++++++++++
 5 files changed, 372 insertions(+), 363 deletions(-)
 delete mode 100755 t/t0071-sort.sh
 create mode 100644 t/unit-tests/u-mergesort.c

diff --git a/Makefile b/Makefile
index a96be506b5..cac535ba19 100644
--- a/Makefile
+++ b/Makefile
@@ -1541,6 +1541,7 @@ CLAR_TEST_SUITES += u-hash
 CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-list-objects-filter-options
 CLAR_TEST_SUITES += u-mem-pool
+CLAR_TEST_SUITES += u-mergesort
 CLAR_TEST_SUITES += u-odb-inmemory
 CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-oidmap
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 3b8c428b14..e8b8de239b 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -1,16 +1,8 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "mem-pool.h"
 #include "mergesort.h"
 #include "strbuf.h"
 
-static uint32_t minstd_rand(uint32_t *state)
-{
-	*state = (uint64_t)*state * 48271 % 2147483647;
-	return *state;
-}
-
 struct line {
 	char *text;
 	struct line *next;
@@ -66,345 +58,10 @@ static int sort_stdin(void)
 	return 0;
 }
 
-static void dist_sawtooth(int *arr, int n, int m)
-{
-	int i;
-	for (i = 0; i < n; i++)
-		arr[i] = i % m;
-}
-
-static void dist_rand(int *arr, int n, int m)
-{
-	int i;
-	uint32_t seed = 1;
-	for (i = 0; i < n; i++)
-		arr[i] = minstd_rand(&seed) % m;
-}
-
-static void dist_stagger(int *arr, int n, int m)
-{
-	int i;
-	for (i = 0; i < n; i++)
-		arr[i] = (i * m + i) % n;
-}
-
-static void dist_plateau(int *arr, int n, int m)
-{
-	int i;
-	for (i = 0; i < n; i++)
-		arr[i] = (i < m) ? i : m;
-}
-
-static void dist_shuffle(int *arr, int n, int m)
-{
-	int i, j, k;
-	uint32_t seed = 1;
-	for (i = j = 0, k = 1; i < n; i++)
-		arr[i] = minstd_rand(&seed) % m ? (j += 2) : (k += 2);
-}
-
-#define DIST(name) { #name, dist_##name }
-
-static struct dist {
-	const char *name;
-	void (*fn)(int *arr, int n, int m);
-} dist[] = {
-	DIST(sawtooth),
-	DIST(rand),
-	DIST(stagger),
-	DIST(plateau),
-	DIST(shuffle),
-};
-
-static const struct dist *get_dist_by_name(const char *name)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(dist); i++) {
-	       if (!strcmp(dist[i].name, name))
-		       return &dist[i];
-	}
-	return NULL;
-}
-
-static void mode_copy(int *arr UNUSED, int n UNUSED)
-{
-	/* nothing */
-}
-
-static void mode_reverse(int *arr, int n)
-{
-	int i, j;
-	for (i = 0, j = n - 1; i < j; i++, j--)
-		SWAP(arr[i], arr[j]);
-}
-
-static void mode_reverse_1st_half(int *arr, int n)
-{
-	mode_reverse(arr, n / 2);
-}
-
-static void mode_reverse_2nd_half(int *arr, int n)
-{
-	int half = n / 2;
-	mode_reverse(arr + half, n - half);
-}
-
-static int compare_ints(const void *av, const void *bv)
-{
-	const int *ap = av, *bp = bv;
-	int a = *ap, b = *bp;
-	return (a > b) - (a < b);
-}
-
-static void mode_sort(int *arr, int n)
-{
-	QSORT(arr, n, compare_ints);
-}
-
-static void mode_dither(int *arr, int n)
-{
-	int i;
-	for (i = 0; i < n; i++)
-		arr[i] += i % 5;
-}
-
-static void unriffle(int *arr, int n, int *tmp)
-{
-	int i, j;
-	COPY_ARRAY(tmp, arr, n);
-	for (i = j = 0; i < n; i += 2)
-		arr[j++] = tmp[i];
-	for (i = 1; i < n; i += 2)
-		arr[j++] = tmp[i];
-}
-
-static void unriffle_recursively(int *arr, int n, int *tmp)
-{
-	if (n > 1) {
-		int half = n / 2;
-		unriffle(arr, n, tmp);
-		unriffle_recursively(arr, half, tmp);
-		unriffle_recursively(arr + half, n - half, tmp);
-	}
-}
-
-static void mode_unriffle(int *arr, int n)
-{
-	int *tmp;
-	ALLOC_ARRAY(tmp, n);
-	unriffle_recursively(arr, n, tmp);
-	free(tmp);
-}
-
-static unsigned int prev_pow2(unsigned int n)
-{
-	unsigned int pow2 = 1;
-	while (pow2 * 2 < n)
-		pow2 *= 2;
-	return pow2;
-}
-
-static void unriffle_recursively_skewed(int *arr, int n, int *tmp)
-{
-	if (n > 1) {
-		int pow2 = prev_pow2(n);
-		int rest = n - pow2;
-		unriffle(arr + pow2 - rest, rest * 2, tmp);
-		unriffle_recursively_skewed(arr, pow2, tmp);
-		unriffle_recursively_skewed(arr + pow2, rest, tmp);
-	}
-}
-
-static void mode_unriffle_skewed(int *arr, int n)
-{
-	int *tmp;
-	ALLOC_ARRAY(tmp, n);
-	unriffle_recursively_skewed(arr, n, tmp);
-	free(tmp);
-}
-
-#define MODE(name) { #name, mode_##name }
-
-static struct mode {
-	const char *name;
-	void (*fn)(int *arr, int n);
-} mode[] = {
-	MODE(copy),
-	MODE(reverse),
-	MODE(reverse_1st_half),
-	MODE(reverse_2nd_half),
-	MODE(sort),
-	MODE(dither),
-	MODE(unriffle),
-	MODE(unriffle_skewed),
-};
-
-static const struct mode *get_mode_by_name(const char *name)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(mode); i++) {
-	       if (!strcmp(mode[i].name, name))
-		       return &mode[i];
-	}
-	return NULL;
-}
-
-static int generate(int argc, const char **argv)
-{
-	const struct dist *dist = NULL;
-	const struct mode *mode = NULL;
-	int i, n, m, *arr;
-
-	if (argc != 4)
-		return 1;
-
-	dist = get_dist_by_name(argv[0]);
-	mode = get_mode_by_name(argv[1]);
-	n = strtol(argv[2], NULL, 10);
-	m = strtol(argv[3], NULL, 10);
-	if (!dist || !mode)
-		return 1;
-
-	ALLOC_ARRAY(arr, n);
-	dist->fn(arr, n, m);
-	mode->fn(arr, n);
-	for (i = 0; i < n; i++)
-		printf("%08x\n", arr[i]);
-	free(arr);
-	return 0;
-}
-
-static struct stats {
-	int get_next, set_next, compare;
-} stats;
-
-struct number {
-	int value, rank;
-	struct number *next;
-};
-
-DEFINE_LIST_SORT_DEBUG(static, sort_numbers, struct number, next,
-		       stats.get_next++, stats.set_next++);
-
-static int compare_numbers(const struct number *an, const struct number *bn)
-{
-	int a = an->value, b = bn->value;
-	stats.compare++;
-	return (a > b) - (a < b);
-}
-
-static void clear_numbers(struct number *list)
-{
-	while (list) {
-		struct number *next = list->next;
-		free(list);
-		list = next;
-	}
-}
-
-static int test(const struct dist *dist, const struct mode *mode, int n, int m)
-{
-	int *arr;
-	size_t i;
-	struct number *curr, *list, **tail;
-	int is_sorted = 1;
-	int is_stable = 1;
-	const char *verdict;
-	int result = -1;
-
-	ALLOC_ARRAY(arr, n);
-	dist->fn(arr, n, m);
-	mode->fn(arr, n);
-	for (i = 0, tail = &list; i < n; i++) {
-		curr = xmalloc(sizeof(*curr));
-		curr->value = arr[i];
-		curr->rank = i;
-		*tail = curr;
-		tail = &curr->next;
-	}
-	*tail = NULL;
-
-	stats.get_next = stats.set_next = stats.compare = 0;
-	sort_numbers(&list, compare_numbers);
-
-	QSORT(arr, n, compare_ints);
-	for (i = 0, curr = list; i < n && curr; i++, curr = curr->next) {
-		if (arr[i] != curr->value)
-			is_sorted = 0;
-		if (curr->next && curr->value == curr->next->value &&
-		    curr->rank >= curr->next->rank)
-			is_stable = 0;
-	}
-	if (i < n) {
-		verdict = "too short";
-	} else if (curr) {
-		verdict = "too long";
-	} else if (!is_sorted) {
-		verdict = "not sorted";
-	} else if (!is_stable) {
-		verdict = "unstable";
-	} else {
-		verdict = "OK";
-		result = 0;
-	}
-
-	printf("%-9s %-16s %8d %8d %8d %8d %8d %s\n",
-	       dist->name, mode->name, n, m, stats.get_next, stats.set_next,
-	       stats.compare, verdict);
-
-	clear_numbers(list);
-	free(arr);
-
-	return result;
-}
-
-/*
- * A version of the qsort certification program from "Engineering a Sort
- * Function" by Bentley and McIlroy, Software—Practice and Experience,
- * Volume 23, Issue 11, 1249–1265 (November 1993).
- */
-static int run_tests(int argc, const char **argv)
-{
-	const char *argv_default[] = { "100", "1023", "1024", "1025" };
-	if (!argc)
-		return run_tests(ARRAY_SIZE(argv_default), argv_default);
-	printf("%-9s %-16s %8s %8s %8s %8s %8s %s\n",
-	       "distribut", "mode", "n", "m", "get_next", "set_next",
-	       "compare", "verdict");
-	while (argc--) {
-		int i, j, m, n = strtol(*argv++, NULL, 10);
-		for (i = 0; i < ARRAY_SIZE(dist); i++) {
-			for (j = 0; j < ARRAY_SIZE(mode); j++) {
-				for (m = 1; m < 2 * n; m *= 2) {
-					if (test(&dist[i], &mode[j], n, m))
-						return 1;
-				}
-			}
-		}
-	}
-	return 0;
-}
-
 int cmd__mergesort(int argc, const char **argv)
 {
-	int i;
-	const char *sep;
-
-	if (argc == 6 && !strcmp(argv[1], "generate"))
-		return generate(argc - 2, argv + 2);
 	if (argc == 2 && !strcmp(argv[1], "sort"))
 		return sort_stdin();
-	if (argc > 1 && !strcmp(argv[1], "test"))
-		return run_tests(argc - 2, argv + 2);
-	fprintf(stderr, "usage: test-tool mergesort generate <distribution> <mode> <n> <m>\n");
-	fprintf(stderr, "   or: test-tool mergesort sort\n");
-	fprintf(stderr, "   or: test-tool mergesort test [<n>...]\n");
-	fprintf(stderr, "\n");
-	for (i = 0, sep = "distributions: "; i < ARRAY_SIZE(dist); i++, sep = ", ")
-		fprintf(stderr, "%s%s", sep, dist[i].name);
-	fprintf(stderr, "\n");
-	for (i = 0, sep = "modes: "; i < ARRAY_SIZE(mode); i++, sep = ", ")
-		fprintf(stderr, "%s%s", sep, mode[i].name);
-	fprintf(stderr, "\n");
+	fprintf(stderr, "usage: test-tool mergesort sort\n");
 	return 129;
 }
diff --git a/t/meson.build b/t/meson.build
index f65eb04684..2752321e0d 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -6,6 +6,7 @@ clar_test_suites = [
   'unit-tests/u-hashmap.c',
   'unit-tests/u-list-objects-filter-options.c',
   'unit-tests/u-mem-pool.c',
+  'unit-tests/u-mergesort.c',
   'unit-tests/u-odb-inmemory.c',
   'unit-tests/u-oid-array.c',
   'unit-tests/u-oidmap.c',
@@ -119,7 +120,6 @@ integration_tests = [
   't0067-parse_pathspec_file.sh',
   't0068-for-each-repo.sh',
   't0070-fundamental.sh',
-  't0071-sort.sh',
   't0080-unit-test-output.sh',
   't0081-find-pack.sh',
   't0090-cache-tree.sh',
diff --git a/t/t0071-sort.sh b/t/t0071-sort.sh
deleted file mode 100755
index 97890da29f..0000000000
--- a/t/t0071-sort.sh
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-
-test_description='verify sort functions'
-
-. ./test-lib.sh
-
-test_expect_success 'DEFINE_LIST_SORT_DEBUG' '
-	test-tool mergesort test
-'
-
-test_expect_success 'sort stdin' '
-	printf "%s\n" c a b >input &&
-	printf "%s\n" a b c >expect &&
-	test-tool mergesort sort <input >actual &&
-	test_cmp expect actual
-'
-
-test_done
diff --git a/t/unit-tests/u-mergesort.c b/t/unit-tests/u-mergesort.c
new file mode 100644
index 0000000000..e621c9ec21
--- /dev/null
+++ b/t/unit-tests/u-mergesort.c
@@ -0,0 +1,369 @@
+#include "unit-test.h"
+#include "mergesort.h"
+
+static uint32_t minstd_rand(uint32_t *state)
+{
+	*state = (uint64_t)*state * 48271 % 2147483647;
+	return *state;
+}
+
+static void dist_sawtooth(int *arr, int n, int m)
+{
+	int i;
+	for (i = 0; i < n; i++)
+		arr[i] = i % m;
+}
+
+static void dist_rand(int *arr, int n, int m)
+{
+	int i;
+	uint32_t seed = 1;
+	for (i = 0; i < n; i++)
+		arr[i] = minstd_rand(&seed) % m;
+}
+
+static void dist_stagger(int *arr, int n, int m)
+{
+	int i;
+	for (i = 0; i < n; i++)
+		arr[i] = (i * m + i) % n;
+}
+
+static void dist_plateau(int *arr, int n, int m)
+{
+	int i;
+	for (i = 0; i < n; i++)
+		arr[i] = (i < m) ? i : m;
+}
+
+static void dist_shuffle(int *arr, int n, int m)
+{
+	int i, j, k;
+	uint32_t seed = 1;
+	for (i = j = 0, k = 1; i < n; i++)
+		arr[i] = minstd_rand(&seed) % m ? (j += 2) : (k += 2);
+}
+
+#define DIST(name) { #name, dist_##name }
+
+static struct dist {
+	const char *name;
+	void (*fn)(int *arr, int n, int m);
+} dist[] = {
+	DIST(sawtooth),
+	DIST(rand),
+	DIST(stagger),
+	DIST(plateau),
+	DIST(shuffle),
+};
+
+static void mode_copy(int *arr UNUSED, int n UNUSED)
+{
+	/* nothing */
+}
+
+static void mode_reverse(int *arr, int n)
+{
+	int i, j;
+	for (i = 0, j = n - 1; i < j; i++, j--)
+		SWAP(arr[i], arr[j]);
+}
+
+static void mode_reverse_1st_half(int *arr, int n)
+{
+	mode_reverse(arr, n / 2);
+}
+
+static void mode_reverse_2nd_half(int *arr, int n)
+{
+	int half = n / 2;
+	mode_reverse(arr + half, n - half);
+}
+
+static int compare_ints(const void *av, const void *bv)
+{
+	const int *ap = av, *bp = bv;
+	int a = *ap, b = *bp;
+	return (a > b) - (a < b);
+}
+
+static void mode_sort(int *arr, int n)
+{
+	QSORT(arr, n, compare_ints);
+}
+
+static void mode_dither(int *arr, int n)
+{
+	int i;
+	for (i = 0; i < n; i++)
+		arr[i] += i % 5;
+}
+
+static void unriffle(int *arr, int n, int *tmp)
+{
+	int i, j;
+	COPY_ARRAY(tmp, arr, n);
+	for (i = j = 0; i < n; i += 2)
+		arr[j++] = tmp[i];
+	for (i = 1; i < n; i += 2)
+		arr[j++] = tmp[i];
+}
+
+static void unriffle_recursively(int *arr, int n, int *tmp)
+{
+	if (n > 1) {
+		int half = n / 2;
+		unriffle(arr, n, tmp);
+		unriffle_recursively(arr, half, tmp);
+		unriffle_recursively(arr + half, n - half, tmp);
+	}
+}
+
+static void mode_unriffle(int *arr, int n)
+{
+	int *tmp;
+	ALLOC_ARRAY(tmp, n);
+	unriffle_recursively(arr, n, tmp);
+	free(tmp);
+}
+
+static unsigned int prev_pow2(unsigned int n)
+{
+	unsigned int pow2 = 1;
+	while (pow2 * 2 < n)
+		pow2 *= 2;
+	return pow2;
+}
+
+static void unriffle_recursively_skewed(int *arr, int n, int *tmp)
+{
+	if (n > 1) {
+		int pow2 = prev_pow2(n);
+		int rest = n - pow2;
+		unriffle(arr + pow2 - rest, rest * 2, tmp);
+		unriffle_recursively_skewed(arr, pow2, tmp);
+		unriffle_recursively_skewed(arr + pow2, rest, tmp);
+	}
+}
+
+static void mode_unriffle_skewed(int *arr, int n)
+{
+	int *tmp;
+	ALLOC_ARRAY(tmp, n);
+	unriffle_recursively_skewed(arr, n, tmp);
+	free(tmp);
+}
+
+#define MODE(name) { #name, mode_##name }
+
+static struct mode {
+	const char *name;
+	void (*fn)(int *arr, int n);
+} mode[] = {
+	MODE(copy),
+	MODE(reverse),
+	MODE(reverse_1st_half),
+	MODE(reverse_2nd_half),
+	MODE(sort),
+	MODE(dither),
+	MODE(unriffle),
+	MODE(unriffle_skewed),
+};
+
+static struct stats {
+	int get_next, set_next;
+} stats;
+
+struct number {
+	int value, rank;
+	struct number *next;
+};
+
+DEFINE_LIST_SORT_DEBUG(static, sort_numbers_debug, struct number, next,
+		       stats.get_next++, stats.set_next++);
+DEFINE_LIST_SORT(static, sort_numbers, struct number, next);
+
+static int compare_numbers(const struct number *an, const struct number *bn)
+{
+	int a = an->value, b = bn->value;
+	return (a > b) - (a < b);
+}
+
+/* Free the storage directly, even if an assertion fails on a broken list. */
+static int *values;
+static struct number *numbers;
+
+void test_mergesort__cleanup(void)
+{
+	FREE_AND_NULL(values);
+	FREE_AND_NULL(numbers);
+}
+
+static struct number *prepare_list(const int *arr, int n)
+{
+	int i;
+
+	ALLOC_ARRAY(numbers, n);
+	for (i = 0; i < n; i++) {
+		numbers[i].value = arr[i];
+		numbers[i].rank = i;
+		numbers[i].next = i + 1 < n ? &numbers[i + 1] : NULL;
+	}
+	stats.get_next = stats.set_next = 0;
+	return n ? numbers : NULL;
+}
+
+static void check_list(struct number *list, const int *expected,
+		       const int *ranks, int n, const char *context)
+{
+	struct number *previous = NULL;
+	int i;
+
+	/* Bound traversal so a cycle is reported as an overlong list. */
+	for (i = 0; i < n; i++) {
+		cl_assert_(list, context);
+		cl_assert_equal_i_(list->value, expected[i], "%s: index %d",
+				   context, i);
+		if (previous && previous->value == list->value)
+			cl_assert_lt_i_(previous->rank, list->rank,
+					"%s: stability at index %d", context, i);
+		if (ranks)
+			cl_assert_equal_i_(list->rank, ranks[i],
+					   "%s: rank at index %d", context, i);
+		previous = list;
+		list = list->next;
+	}
+	cl_assert_(list == NULL, context);
+}
+
+/*
+ * A version of the qsort certification program from "Engineering a Sort
+ * Function" by Bentley and McIlroy, Software—Practice and Experience,
+ * Volume 23, Issue 11, 1249–1265 (November 1993).
+ */
+static void certify(const struct dist *distribution)
+{
+	static const int sizes[] = { 100, 1023, 1024, 1025 };
+	size_t i, j;
+	int m;
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		int n = sizes[i];
+
+		for (j = 0; j < ARRAY_SIZE(mode); j++) {
+			for (m = 1; m < 2 * n; m *= 2) {
+				struct number *list;
+				char context[128];
+
+				xsnprintf(context, sizeof(context),
+					  "%s %s n=%d m=%d",
+					  distribution->name, mode[j].name, n, m);
+				ALLOC_ARRAY(values, n);
+				distribution->fn(values, n, m);
+				mode[j].fn(values, n);
+				list = prepare_list(values, n);
+				sort_numbers_debug(&list, compare_numbers);
+				QSORT(values, n, compare_ints);
+				check_list(list, values, NULL, n, context);
+				test_mergesort__cleanup();
+			}
+		}
+	}
+}
+
+void test_mergesort__sawtooth(void)
+{
+	certify(&dist[0]);
+}
+
+void test_mergesort__rand(void)
+{
+	certify(&dist[1]);
+}
+
+void test_mergesort__stagger(void)
+{
+	certify(&dist[2]);
+}
+
+void test_mergesort__plateau(void)
+{
+	certify(&dist[3]);
+}
+
+void test_mergesort__shuffle(void)
+{
+	certify(&dist[4]);
+}
+
+static void check_small(const int *input, const int *expected,
+			const int *ranks, int n, const char *name)
+{
+	int debug;
+
+	for (debug = 0; debug < 2; debug++) {
+		struct number *list = prepare_list(input, n);
+		char context[128];
+
+		xsnprintf(context, sizeof(context), "%s %s n=%d",
+			  debug ? "debug" : "normal", name, n);
+		if (debug)
+			sort_numbers_debug(&list, compare_numbers);
+		else
+			sort_numbers(&list, compare_numbers);
+		check_list(list, expected, ranks, n, context);
+		test_mergesort__cleanup();
+	}
+}
+
+void test_mergesort__empty(void)
+{
+	check_small(NULL, NULL, NULL, 0, "empty");
+}
+
+void test_mergesort__singleton(void)
+{
+	const int input[] = { 42 };
+	const int ranks[] = { 0 };
+
+	check_small(input, input, ranks, ARRAY_SIZE(input), "singleton");
+}
+
+void test_mergesort__reversed_pair(void)
+{
+	const int input[] = { 2, 1 };
+	const int expected[] = { 1, 2 };
+	const int ranks[] = { 1, 0 };
+
+	check_small(input, expected, ranks, ARRAY_SIZE(input), "reversed pair");
+}
+
+void test_mergesort__equal_pair(void)
+{
+	const int input[] = { 1, 1 };
+	const int ranks[] = { 0, 1 };
+
+	check_small(input, input, ranks, ARRAY_SIZE(input), "equal pair");
+}
+
+void test_mergesort__mixed_values(void)
+{
+	const int input[] = { INT_MAX, -1, 0, INT_MIN, -1, INT_MAX, 0 };
+	const int expected[] = { INT_MIN, -1, -1, 0, 0, INT_MAX, INT_MAX };
+	const int ranks[] = { 3, 1, 4, 2, 6, 0, 5 };
+
+	check_small(input, expected, ranks, ARRAY_SIZE(input), "mixed values");
+}
+
+void test_mergesort__debug_hooks(void)
+{
+	const int input[] = { 2, 1 };
+	const int expected[] = { 1, 2 };
+	const int ranks[] = { 1, 0 };
+	struct number *list = prepare_list(input, ARRAY_SIZE(input));
+
+	sort_numbers_debug(&list, compare_numbers);
+	check_list(list, expected, ranks, ARRAY_SIZE(input), "debug hooks");
+	cl_assert_gt_i(stats.get_next, 0);
+	cl_assert_gt_i(stats.set_next, 0);
+}
-- 
2.55.0
