Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D41227585
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715208; cv=none; b=IYwkgPDq+2DbHrM+xpdRaaCSvFOL9XzyviKAchblzGu3BKSL2SWY0mLnMi+HFzp5D+hcs8PQL85sokuFvnJvi2WMF2Ir3pG1odutqxnhWsEykcn80plxGOgCn0GmHyihwQErQjIN1MS0Hw+T/q7aPJSwF8yVokZaNfYE5YMzSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715208; c=relaxed/simple;
	bh=BgUc/QtagZeA9VpkxvXM6Uanl38sbEI/K9e0rtdzsUQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ok1cluMqEnIebQaSv3Fm+AX6HJ5xEezMpKQUZsmFkOecKYe15NyQ8M74pWV3lB0BNEPcWAcTJvrezHvn5qG+/tVKRupEnXgnHVp/IudD6qNo2bYSjCywiT9d0wowImxNBZQftEHzeTJi5a3uzvDRQ7qX/TFQIQRuPYLp589Lgro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5gpfzXd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5gpfzXd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385eed29d17so1156215f8f.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734715204; x=1735320004; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geY20IR4kiL44kdAD/CIjMF+Nm3xkcAygLBrgaj+bMI=;
        b=h5gpfzXd1x3/kUJE/1fdggTvhMEl0Y8Hq61bIIXB3OEhqLmcQB+d1zMbtoLa4QmsOI
         jP5D81C8n7jn9edL4RJc2FAGraIrfhJFPdwPNCihtMNEYzEwcgmAfzofyaEZQmaOqK/o
         FMHdS8+wLBxOmS5CrfwNiiLR4uT+N4Ww+pDcw6iWqs9eRLB72lTNilEAFeDFks65mJq5
         1tjfsBOydhoF9Cd9L50UpYRjJTlnlnyajufByT6vX7IaaYpDaA3YGsBzzBR5VmIpcX/g
         cPxoLqVIkWgNOAhMwCTB2rPR0herMQgMNNodZ2qRR4g5GN6MQwlTMTv4objotDRnJmwA
         F9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715204; x=1735320004;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geY20IR4kiL44kdAD/CIjMF+Nm3xkcAygLBrgaj+bMI=;
        b=KqkQ5SZniHrhY2vCygwnUSQm9qtntty60y/EmQYJnRA2gqKqY4oE5OikH4rsr7o+On
         UkOmuMdlteM3U7r7s+1Ea1DxYqb05CPGVDnADXqa5/PKXd3/NumGxZFYZaibbeY5Bm5Y
         X82N8rx1j6CD/y6ugODckBOSTy5RF5+TN9ikq1U6tWgKJ+c7Sa7hprj8/1TUqe5M89HL
         IAAnbJ3MnvS1idyOcRxhRhvxYF6PAqg4EfbHOU0XYBO2DetN92itGkUQrqhNISw4RRYA
         yvnZFSom/s0r3ihVY/wxlZq+67hQ+sYPft47l4eSwRrN3CocADQEO0aOEo7Irv3C2Wso
         6TPg==
X-Gm-Message-State: AOJu0YwI3mI4d7lXv1nBLNliZljQcV3NRWfJ4ljAMF485rXow4hYkpSl
	oX82ArIiriPE63vmpRWaAO+aA4mtb4NtvCJ2gcsKEi/rWBxYazsHwPYuoA==
X-Gm-Gg: ASbGnctl+jsJpXcF4QefdNdIypy52RRTVuni+vJ+ZNkSse7GaXF+JCtdBCp1e5wY7i+
	YIqHUWlDGNyERaTOCjsOIXu7vSem5L8ghz8bu75nc7bzhHJ6SlNpnVrTXDEohwV2Ygq7mAvf1T7
	A5Ag8KNgP8XzudpOlDZS/Xl+vkvjqk/rjQGKXC1CItCskLD7HgxBP9GMmpldU3XEs80H5LMEgq7
	7ypvvtEx8jvMHnPUMGoIco7t8OlJxGEi06J21s66l9ZkaldvJgvmsF1ng==
X-Google-Smtp-Source: AGHT+IH/nHt1BWFH2kOxjgyuGlvTX/VvyuzBQUA34KGKXlwGYr5wqtfYr0F7PnuXmIM8hfMPaw+6pQ==
X-Received: by 2002:a5d:5e09:0:b0:385:fc32:1ec6 with SMTP id ffacd0b85a97d-38a223fd786mr3581974f8f.50.1734715204122;
        Fri, 20 Dec 2024 09:20:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8332absm4434175f8f.38.2024.12.20.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:20:03 -0800 (PST)
Message-Id: <e9ce79fa6e770688f3fd14ca1c19bca185a81bbf.1734715194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
	<pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 17:19:52 +0000
Subject: [PATCH v3 6/8] test-tool: add helper for name-hash values
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
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new test-tool helper, name-hash, to output the value of the
name-hash algorithms for the input list of strings, one per line.

Since the name-hash values can be stored in the .bitmap files, it is
important that these hash functions do not change across Git versions.
Add a simple test to t5310-pack-bitmaps.sh to provide some testing of
the current values. Due to how these functions are implemented, it would
be difficult to change them without disturbing these values. The paths
used for this test are carefully selected to demonstrate some of the
behavior differences of the two current name hash versions, including
which conditions will cause them to collide.

Create a performance test that uses test_size to demonstrate how
collisions occur for these hash algorithms. This test helps inform
someone as to the behavior of the name-hash algorithms for their repo
based on the paths at HEAD.

My copy of the Git repository shows modest statistics around the
collisions of the default name-hash algorithm:

Test                               this tree
--------------------------------------------------
5314.1: paths at head                         4.5K
5314.2: distinct hash value: v1               4.1K
5314.3: maximum multiplicity: v1                13
5314.4: distinct hash value: v2               4.2K
5314.5: maximum multiplicity: v2                 9

Here, the maximum collision multiplicity is 13, but around 10% of paths
have a collision with another path.

In a more interesting example, the microsoft/fluentui [1] repo had these
statistics at time of committing:

Test                               this tree
--------------------------------------------------
5314.1: paths at head                        19.5K
5314.2: distinct hash value: v1               8.2K
5314.3: maximum multiplicity: v1               279
5314.4: distinct hash value: v2              17.8K
5314.5: maximum multiplicity: v2                44

[1] https://github.com/microsoft/fluentui

That demonstrates that of the nearly twenty thousand path names, they
are assigned around eight thousand distinct values. 279 paths are
assigned to a single value, leading the packing algorithm to sort
objects from those paths together, by size.

With the v2 name hash function, the maximum multiplicity lowers to 44,
leaving some room for further improvement.

In a more extreme example, an internal monorepo had a much worse
collision rate:

Test                               this tree
--------------------------------------------------
5314.1: paths at head                       227.3K
5314.2: distinct hash value: v1              72.3K
5314.3: maximum multiplicity: v1             14.4K
5314.4: distinct hash value: v2             166.5K
5314.5: maximum multiplicity: v2               138

Here, we can see that the v2 name hash function provides somem
improvements, but there are still a number of collisions that could lead
to repacking problems at this scale.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Makefile                  |  1 +
 t/helper/test-name-hash.c | 23 +++++++++++++++++++++++
 t/helper/test-tool.c      |  1 +
 t/helper/test-tool.h      |  1 +
 t/perf/p5314-name-hash.sh | 31 +++++++++++++++++++++++++++++++
 t/t5310-pack-bitmaps.sh   | 30 ++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+)
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
index 00000000000..af1d52de101
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
+		printf("%10u ", pack_name_hash(line.buf));
+		printf("%10u ", pack_name_hash_v2((unsigned const char *)line.buf));
+		printf("%s\n", line.buf);
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
index 00000000000..4ef0ba77114
--- /dev/null
+++ b/t/perf/p5314-name-hash.sh
@@ -0,0 +1,31 @@
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
+	wc -l <path-list &&
+	test-tool name-hash <path-list >name-hashes
+'
+
+for version in 1 2
+do
+	test_size "distinct hash value: v$version" '
+		awk "{ print \$$version; }" <name-hashes | sort | \
+			uniq -c >name-hash-count &&
+		wc -l <name-hash-count
+	'
+
+	test_size "maximum multiplicity: v$version" '
+		sort -nr <name-hash-count | head -n 1 |	\
+			awk "{ print \$1; }"
+	'
+done
+
+test_done
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index c30522b57fd..871ce01401a 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -27,6 +27,36 @@ has_any () {
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
+	a/one-long-enough-for-collisions
+	b/two-long-enough-for-collisions
+	many/parts/to/this/path/enough/to/collide/in/v2
+	enough/parts/to/this/path/enough/to/collide/in/v2
+	EOF
+
+	test-tool name-hash <names >out &&
+
+	cat >expect <<-\EOF &&
+	2582249472 1763573760 first
+	2289942528 1188134912 second
+	2300837888 1130758144 third
+	2544516325 3963087891 a/one-long-enough-for-collisions
+	2544516325 4013419539 b/two-long-enough-for-collisions
+	1420111091 1709547268 many/parts/to/this/path/enough/to/collide/in/v2
+	1420111091 1709547268 enough/parts/to/this/path/enough/to/collide/in/v2
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

