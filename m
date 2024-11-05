Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94767133987
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775920; cv=none; b=pzsidF4TLA1wscJ5UidjBUXNzDkMtM1sFLwN8BswgZkdAZHRKv6rgRAR0gHwOX/2o/DLjPefwa2CLBW4fXEYB5O8mc5Gy7E1hnDUnKllcOSqAF0o6sh42vgtXq+Dv5OAdXT3ffX4qEIJehFJr5cjO8pevWrdzy/lT1GMmmsgIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775920; c=relaxed/simple;
	bh=wG4nwZPOtJspwpo7tCdfFvLlQ3y2OovuFtfvqNlSV0c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XGfsqCEWlbTldHIL1g0IVyiINxoTqddcTkGgUeT0AheaAfkWO/8tm9svcqgluXFgKwYl2lce7gl9KPQJYOQccGklSLNympnyJldwAZZTqsGTj3vQsuEzbRRJrSMDr6/7VbUZ8rjPs7SnVCXmkyJhoQNqM3TsC36M4vsAmIzwvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7TQzybm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7TQzybm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so4184104f8f.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 19:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730775916; x=1731380716; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6v2WpdksI0kHcvy8pJ4JrV7n8xkcyC0bx5MgJ4Oq6Y=;
        b=H7TQzybmd6cf1curCuuGeFF+wOyYeIFreIw73U//AiPNbPrMpLvUqLQeh2cbJpVmLA
         xvT3PeO2sUPA97X76/7IdVbXXweYTfWQRtOUKHSQeWHDnf4lJMZ3U3qof45ajFQCUtYd
         alIXH3lwYgY4/rRmy1LXWqxlieXfmxncpn3AeP7Oo95ftxFVswDQ0z9Xf59gdPtqYFkk
         Dmda8gQpinGgorRWnT6KwLADfwFqsuAG9dr6bfbkeWjOGDC5BJYbnSFTmEj6lVF6sgNK
         DH8r5kHk0Wu1YJwHncEQNCJUTi2mqoQr7HF1c9xnpT7oKlXKk9cvQzQmMpIm9SFEV7sK
         r7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775916; x=1731380716;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6v2WpdksI0kHcvy8pJ4JrV7n8xkcyC0bx5MgJ4Oq6Y=;
        b=WnIwIffOVGi5woSLDa7xa1bdOomvoNjTki+u+elvGV81LlMD9+JzXUGQmb0Frv0p37
         qxXg8a6H6dU3w7pPErL/PZjBzMBFtbu9oGJdol+0q0/Csadjh/206QCGF5NElN206DSO
         emfSijABukgFY5+Mcel94nnmSCPAf8IQLa9dopssQPjO+CVof3fR+JHheId1uE5HZ9G8
         qvu4Bokg9NjXqKv+SAwyCffWWB/XU9btqOdaBnzZohilm4dfVF+2c3sO6eKGXbCqOT/I
         UALLlc6I/NTN/t1Y5JvftyUnsGRbV/IXmcBn/N+YvuWUiPnaJ4bYMfFnXOHw7KyxREWL
         I0FQ==
X-Gm-Message-State: AOJu0YzJfXVy09k9jEhvgkAN3vV3lnh0twmryawYAVYuAv3D1BLia+Yx
	a/wlPLLK1dbLvDCR4JF/UQU2LINw6Aq0DDqWcGrXMQ4eaXE6+Gw00J4uVw==
X-Google-Smtp-Source: AGHT+IEZHQdttyIaT8b4RGkq/8PDDv+byd8qFCWoxYrPUbNX/NZKyAl/vmqLbb9bTZ0oAhVDh3wAyA==
X-Received: by 2002:a05:6000:18ac:b0:37d:4f69:c9b with SMTP id ffacd0b85a97d-381c7a6ddd1mr15785490f8f.35.1730775916478;
        Mon, 04 Nov 2024 19:05:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4d1fsm14648397f8f.38.2024.11.04.19.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:05:15 -0800 (PST)
Message-Id: <ab341dd0e58f77b3c7c6f5765d9e34cb02bef56f.1730775908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Nov 2024 03:05:07 +0000
Subject: [PATCH 7/7] test-tool: add helper for name-hash values
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
 t/helper/test-name-hash.c | 24 +++++++++++++++++++++++
 t/helper/test-tool.c      |  1 +
 t/helper/test-tool.h      |  1 +
 t/perf/p5314-name-hash.sh | 41 +++++++++++++++++++++++++++++++++++++++
 t/t5310-pack-bitmaps.sh   | 26 +++++++++++++++++++++++++
 6 files changed, 94 insertions(+)
 create mode 100644 t/helper/test-name-hash.c
 create mode 100755 t/perf/p5314-name-hash.sh

diff --git a/Makefile b/Makefile
index 6f5986b66ea..65403f6dd09 100644
--- a/Makefile
+++ b/Makefile
@@ -816,6 +816,7 @@ TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
+TEST_BUILTINS_OBJS += test-name-hash.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
new file mode 100644
index 00000000000..e4ecd159b76
--- /dev/null
+++ b/t/helper/test-name-hash.c
@@ -0,0 +1,24 @@
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
+	strbuf_release(&line);
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
index caa3c125548..965c3abca5f 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -27,6 +27,32 @@ has_any () {
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
