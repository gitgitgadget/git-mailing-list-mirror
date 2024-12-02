Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C091DFDBF
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181694; cv=none; b=m7JpSSKxU491XGNCMke8OvCjSTRU+VNZgg+xr0cj67TGbXrut2rlWj35g0AHg+LQUhtcgXv15zkc7aSEeng9Fdi+/dh99vAAHVy+gz0KJGOqfa82MsaT7u1R2JorciPwcpNqUxBLGCc+XMkQEvfL68IvARiTuI//aQakcgpEnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181694; c=relaxed/simple;
	bh=6CQ9WbSlrwZQWz7rJuBeSEwSbyrsETIdSW2W3s1aktI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gLTDrNKMymJICxJuAnIOd9rnS3/YPXUIjIOv0H8dcJ+Qufx/w2k+BdIXQnhyYy0mz+Uso8u7LNfIvxhQGAq1UEtpHoe3afzsR8kJAWkEfwH0TwCzM4Q2+sQ7OIKwxRaIls/LhX6sCClelOynHYFmtGkiKOPOgF9H16uZfQgbbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zfxtv/pA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfxtv/pA"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so345350366b.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 15:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733181690; x=1733786490; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycgoh9ZNIIRz1trZNkXuxMj6shkIr2PYuvoesPrywnE=;
        b=Zfxtv/pAbwqVuezXLwn2xoXP7LkRfsjWLTCNpYSRAlkLl/+IXIuGxer1s6fXdbc/gI
         SVSk6K/E2gcV1g0jS8Caxn3ITFkdHlZzkSN5mFblymqkwqkYIDzjhZEhhWl/b1pfPzMq
         qcHCdVnixIXxLH0QCTpF7kuX9xTAygRMyQ74bneilOd68BaNOxfV9hDNYnr2NSsci8c6
         5rEPS45jyjfUD8msIb2ECo7JloaYz+W2c+OxNrRScVaQFXCNQ6D7Ke6dfBNEp5RlwVR3
         JKV0R5HyJLgmh8O5nc+QzX8yWHM6uZhkEZNZ9P8o+eSHc69kSRmVK6rNXsT4mGIfd2M+
         ANXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733181690; x=1733786490;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycgoh9ZNIIRz1trZNkXuxMj6shkIr2PYuvoesPrywnE=;
        b=s2nQkEQsqP6lkwKXvTIhiCO/WecW71babo/2fi9j/4//JmvaIaZg0Bdq48UQpArD3m
         CuGdk6jh+gKw+OxwKTvdKT8mSpC20Ab5Iy032InuIp40Oo5kWjWQrVCO5QbjWvlpR3Z9
         s15n3fKhetPUvD27UXwEGA1cl1SywahexJ8kwE/WVB6MBZVz8a2mJk18/HXovO4cpNpH
         5mhp96alMYuERte/XZbn3iEDKXtJ9S0uddF9RE0sNndQITkf6oDjsxgL03QUboUEYMTY
         7Dy8kqNyTikxrO5bqjO6x4btRfkfe5r1VfBXH07khMjW831ppIKG8BglNLuva6bqKZXd
         B4Kg==
X-Gm-Message-State: AOJu0YxKOHRL+ADSoO6gqMiNz/D5QcHjhb1bCeSrb5o9YaTPm5tGkSC2
	28PfjB3LrHmCRsFdjrUR7VrI8dUDmXOTjABNAcoZnsCYx4BY1L0ibUyPKQ==
X-Gm-Gg: ASbGncujeppK2W30zT6N9C8rf4CIZ2NJoZTCVOQAbyFdQI2+eX134glWnNMTYjy78EW
	PHu0K4HfV+jQAp/rhBc2y7R11cttEV/gXBqxTOGGgUHEdcHEY34M7bbk7TJJ/Ub5gAA5hsx87h/
	i2pbVC1E8zBXsvVkjZ/ZFqq64ScyjiK5ge6itDPEFxRY2dkdkElQZO/dNeLMr+Lw2L/VfuICJge
	LSYahZhzDllSeUQmskVRzU1XK0M9u1G3k1OQfzEgKvJN/+4KKc=
X-Google-Smtp-Source: AGHT+IHGJb5iwIiqDz49H+2U2NBhn4SvE0sWWWnVRIRISJLdHgm7vMRFi7NtgzPJgOFOiUOVvBgZeg==
X-Received: by 2002:a05:6402:51ca:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5d10cb56467mr100563a12.11.1733181690258;
        Mon, 02 Dec 2024 15:21:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0f6cf4bbesm1259977a12.43.2024.12.02.15.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 15:21:29 -0800 (PST)
Message-Id: <36f2811e3d917405c16433491353fc9adb2bb1f9.1733181682.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Dec 2024 23:21:20 +0000
Subject: [PATCH v2 6/8] test-tool: add helper for name-hash values
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
index 00000000000..5b402362020
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
+		printf("%10u ", pack_name_hash_v2(line.buf));
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

