Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4C1CB510
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692394; cv=none; b=i2ZyboOvoEWNPGKALjMzFE8M0MkANphSjNc0kuty/Jch6CTrZEPrAmPFt0zM7M31pAv+o4lkb/0A6DiQKAM09yyUaooXNjPWtVlgNQbFiH74XEgSyqDO6POMP9xokfzJBRXGsVui/LbXT+25weEAxVaTmiVUgjphQvCk/TlaoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692394; c=relaxed/simple;
	bh=R27FpJHHBzsrBN0d4tGhZ2UbDVIcuAQZ4XqpVehW3Sg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MItGV/k2YrAdtdGIvVDiti9VzWttc6xFAWFkUFCAy2PZdD/hIb0o8wb65uzap1KJouZc0194aDxPOJuVFElzp9o9Or6FATyiSfgseifd7UNsEY2tBkP9PY6VOtvb28Pnjv1SBDvLOn6804RhDA77x4/yfuQBapxB9zpJsQxu3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO5wrzux; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO5wrzux"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so1073931fa.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726692390; x=1727297190; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBTKswv0/Gg8IDmrzA0EKBC1u/4FB0R0gBsu9u4PFvM=;
        b=DO5wrzux74/8lCsMlCx+z89QbH23Ipbgc2DpFOsI3eJSiPX4pkYxwI3AZBqsaekAHU
         JdaBdDktekdI7DUqzOGbKsVhQwCkSFaEWBf6Ico2Wibq45JoHjsfKfZlFcM8p6LxQWPb
         yA438yN8vH8cNTlYyQB3CiOa8nnqYra9YDULPjGJqqwNs1arkoMMYjW7Yp4ZFMW7v6Rv
         JVeZCbs8TKaXWbbpyU+EzJ2xmUg1jjWHzqFdhqJiPDD3ci/JX/lwwVwYchZHK6dspeb3
         gZme0x75hS8CzJg4C7g21oEl/g0GP/L6dOLeHxE9uOb2lONC4QMP0I6tddaJUH3UlxdZ
         70mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692390; x=1727297190;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBTKswv0/Gg8IDmrzA0EKBC1u/4FB0R0gBsu9u4PFvM=;
        b=BEi6szgEUukdRDQRIYCFcT06GX6u/sl9BY+4PENkQl5aazgabc3wJdxtxZ4NF5YNu+
         Ein4IxQzbR48+bqHsJ9PaN6QPlFvQVnKvicvIqLWybj35CNvywG5t7VqM1pbG/PzAPe7
         omO6MnktQLpuP3443xG7+eTIjzPWYigyiRF950BfGVfmpvL5cWX0LEMVebWbbXqOl4dQ
         CwA/2SpwZH/gRVm9g5tUzaROVYyUOvZ9tB146lFkfXeR4+q7+pG9NyyhYKm2sVqPjmXe
         2dITD8eUHo+YpstPWWpe6vWBvfxfuXeVJkpJZfE1zV1Y65O8OKEekl5Xlnl9kOX5j0mO
         h2EA==
X-Gm-Message-State: AOJu0YwE19v8VBQZ5FQyiWmA/lSEF1L9Fdq8KZNbnS7Q5nxFv+bpQfIm
	wPL1MdG7Jx6l7HcfL6AbgqnL9824lQ7nOlf9Pp5hcuiwLn/vTuXXFeCfGw==
X-Google-Smtp-Source: AGHT+IHSuHTwKhFitnqoWgdjC20meG50JQDciLkFYIJn4/HlMhO1y0zFZFuPGVXQDTQCJ7kD8qbDBg==
X-Received: by 2002:ac2:4e06:0:b0:530:d088:233f with SMTP id 2adb3069b0e04-5367ff24b81mr9979733e87.40.1726692389715;
        Wed, 18 Sep 2024 13:46:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f3878sm634098566b.47.2024.09.18.13.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 13:46:29 -0700 (PDT)
Message-Id: <7e47fc8cb53647ad92c86801204c3089a5dfe8e6.1726692382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Sep 2024 20:46:21 +0000
Subject: [PATCH v2 6/6] test-tool: add helper for name-hash values
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new test-tool helper, name-hash, to output the value of the
name-hash algorithms for the input list of strings, one per line.

Since the name-hash values can be stored in the .bitmap files, it is
important that these hash functions do not change across Git versions.
Add a simple test to t5310-pack-bitmaps.sh to provide some testing of
the current values. Due to how these functions are implemented, it would
be difficult to change them without disturbing these values.

Create a performance test that uses test_size to demonstrate how
collisions occur for these hash algorithms. This test helps inform
someone as to the behavior of the name-hash algorithms for their repo
based on the paths at HEAD.

My copy of the Git repository shows modest statistics around the
collisions of the default name-hash algorithm:

Test                                              this tree
-----------------------------------------------------------------
5314.1: paths at head                                        4.5K
5314.2: number of distinct name-hashes                       4.1K
5314.3: number of distinct full-name-hashes                  4.5K
5314.4: maximum multiplicity of name-hashes                    13
5314.5: maximum multiplicity of fullname-hashes                 1

Here, the maximum collision multiplicity is 13, but around 10% of paths
have a collision with another path.

In a more interesting example, the microsoft/fluentui [1] repo had these
statistics at time of committing:

Test                                              this tree
-----------------------------------------------------------------
5314.1: paths at head                                       19.6K
5314.2: number of distinct name-hashes                       8.2K
5314.3: number of distinct full-name-hashes                 19.6K
5314.4: maximum multiplicity of name-hashes                   279
5314.5: maximum multiplicity of fullname-hashes                 1

[1] https://github.com/microsoft/fluentui

That demonstrates that of the nearly twenty thousand path names, they
are assigned around eight thousand distinct values. 279 paths are
assigned to a single value, leading the packing algorithm to sort
objects from those paths together, by size.

In this repository, no collisions occur for the full-name-hash
algorithm.

In a more extreme example, an internal monorepo had a much worse
collision rate:

Test                                              this tree
-----------------------------------------------------------------
5314.1: paths at head                                      221.6K
5314.2: number of distinct name-hashes                      72.0K
5314.3: number of distinct full-name-hashes                221.6K
5314.4: maximum multiplicity of name-hashes                 14.4K
5314.5: maximum multiplicity of fullname-hashes                 2

Even in this repository with many more paths at HEAD, the collision rate
was low and the maximum number of paths being grouped into a single
bucket by the full-path-name algorithm was two.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Makefile                  |  1 +
 t/helper/test-name-hash.c | 23 ++++++++++++++++++++++
 t/helper/test-tool.c      |  1 +
 t/helper/test-tool.h      |  1 +
 t/perf/p5314-name-hash.sh | 41 +++++++++++++++++++++++++++++++++++++++
 t/t5310-pack-bitmaps.sh   | 26 +++++++++++++++++++++++++
 6 files changed, 93 insertions(+)
 create mode 100644 t/helper/test-name-hash.c
 create mode 100755 t/perf/p5314-name-hash.sh

diff --git a/Makefile b/Makefile
index 275a5ee3c9f..50797a4e541 100644
--- a/Makefile
+++ b/Makefile
@@ -812,6 +812,7 @@ TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
+TEST_BUILTINS_OBJS += test-name-hash.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
new file mode 100644
index 00000000000..15fb8f853c1
--- /dev/null
+++ b/t/helper/test-name-hash.c
@@ -0,0 +1,23 @@
+/*
+ * test-name-hash.c: Read a list of paths over stdin and report on their
+ * name-hash and full name-hash.
+ */
+
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "pack-objects.h"
+#include "strbuf.h"
+
+int cmd__name_hash(int argc UNUSED, const char **argv UNUSED)
+{
+	struct strbuf line = STRBUF_INIT;
+
+	while (!strbuf_getline(&line, stdin)) {
+		uint32_t name_hash = pack_name_hash(line.buf);
+		uint32_t full_hash = pack_full_name_hash(line.buf);
+
+		printf("%10"PRIu32"\t%10"PRIu32"\t%s\n", name_hash, full_hash, line.buf);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 1ebb69a5dc4..e794058ab6d 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -44,6 +44,7 @@ static struct test_cmd cmds[] = {
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
+	{ "name-hash", cmd__name_hash },
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 21802ac27da..26ff30a5a9a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -37,6 +37,7 @@ int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
+int cmd__name_hash(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
diff --git a/t/perf/p5314-name-hash.sh b/t/perf/p5314-name-hash.sh
new file mode 100755
index 00000000000..9fe26612fac
--- /dev/null
+++ b/t/perf/p5314-name-hash.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='Tests pack performance using bitmaps'
+. ./perf-lib.sh
+
+GIT_TEST_PASSING_SANITIZE_LEAK=0
+export GIT_TEST_PASSING_SANITIZE_LEAK
+
+test_perf_large_repo
+
+test_size 'paths at head' '
+	git ls-tree -r --name-only HEAD >path-list &&
+	wc -l <path-list
+'
+
+test_size 'number of distinct name-hashes' '
+	cat path-list | test-tool name-hash >name-hashes &&
+	cat name-hashes | awk "{ print \$1; }" | sort -n | uniq -c >name-hash-count &&
+	wc -l <name-hash-count
+'
+
+test_size 'number of distinct full-name-hashes' '
+	cat name-hashes | awk "{ print \$2; }" | sort -n | uniq -c >full-name-hash-count &&
+	wc -l <full-name-hash-count
+'
+
+test_size 'maximum multiplicity of name-hashes' '
+	cat name-hash-count | \
+		sort -nr | \
+		head -n 1 | \
+		awk "{ print \$1; }"
+'
+
+test_size 'maximum multiplicity of fullname-hashes' '
+	cat full-name-hash-count | \
+		sort -nr | \
+		head -n 1 | \
+		awk "{ print \$1; }"
+'
+
+test_done
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a6de7c57643..5759710a2cd 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -26,6 +26,32 @@ has_any () {
 	grep -Ff "$1" "$2"
 }
 
+# Since name-hash values are stored in the .bitmap files, add a test
+# that checks that the name-hash calculations are stable across versions.
+# Not exhaustive, but these hashing algorithms would be hard to change
+# without causing deviations here.
+test_expect_success 'name-hash value stability' '
+	cat >names <<-\EOF &&
+	first
+	second
+	third
+	one-long-enough-for-collisions
+	two-long-enough-for-collisions
+	EOF
+
+	test-tool name-hash <names >out &&
+
+	cat >expect <<-\EOF &&
+	2582249472	3109209818	first
+	2289942528	3781118409	second
+	2300837888	3028707182	third
+	2544516325	3241327563	one-long-enough-for-collisions
+	2544516325	4207880830	two-long-enough-for-collisions
+	EOF
+
+	test_cmp expect out
+'
+
 test_bitmap_cases () {
 	writeLookupTable=false
 	for i in "$@"
-- 
gitgitgadget
