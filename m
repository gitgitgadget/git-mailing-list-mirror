Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC51BC067
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890219; cv=none; b=GNJ6jbaxobUKJVMu0jJZ5/A84PX6NfjfMaoq6M6icM5HAS7JwIuKFASi8G1icfzc2S/Q7oLOvIkFA6XmOQXD1xxKJhgahBF2554ckYs2vltr3P87lH+86PN93VMm64yenyQVIGXFnWSlLaAWQGH8WQzmXbP1GY9IQOyOdbnrJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890219; c=relaxed/simple;
	bh=LIbYpyg40h8KI84Y7XQIUYsrf6lVnrVw6MeLaiv5Dcs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O0qf64epkdsGBZsRFesFIamN3UTy2n92gTw+WzqDHf1H1Nf64FBhkFfIdA/mRfS2vMaABK9lO/P4VVXWPIQXh/wopDa3b5Veen7BiFpd4NnUlmrCOuatotcztHu9sXqaI4mIpBmdGxN2QEEdQu6SmuJdb3rvhcT0ef0WLk15SKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDIT/kIm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDIT/kIm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d24f98215so260304766b.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725890216; x=1726495016; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=165VGxlrc3YaB/DNDnlGL8IbdWEFSagy6qmMWTpQjNo=;
        b=DDIT/kImChm3eH1s4BlSsPT9E6bS5D4zScCz1t9uBpqgUNmdasQl25l5xiTyZA6HTA
         oj5lQfHzvgCkrXcv0sqJlpdTyvWxOOO0W0A9Jo/SRmwXZupVi+BzPX7bjGu1CFLtrjvt
         QabKlkFUgL2tsrUWk/DTvcPWZrAbu7t8UAasPGh/VcwMbgzjz/3TBz8MfFX3rVOp035h
         lGo6RWR6fY4hhYzlbsn5MViPgE16KvJy62kHJrIIqIfcKi30kj2tFJy50TzqQOuukSTS
         mivUnilx9srI8LSAU+NiEiLBdMJSkl4RYomiZnKOQb8QHvRfCt/qRHjFzG4c7NPlKmRS
         0xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890216; x=1726495016;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=165VGxlrc3YaB/DNDnlGL8IbdWEFSagy6qmMWTpQjNo=;
        b=g3GZn53HVD6rZEBy7h3IaMmxfIq7jNeUG6x7ZoYlB8JSSP/YnIPajeRWutsH9wdZ2O
         4FP9J6gbq5H1X5Xu8f9vWD/vOPo7bGiF3tlOfwUbCutWr42uj/PTBXf9NBTRCmaYEt1W
         dHoWdKhmKeQe2l8j4JDmcV413+xg9KD6G/9+3Kzi/dLeNUvPJ5fa10JaqLJ0dXwWgOuI
         6rnbl5cyye2zyARR+yQB4Va3FpPiMJQA0c9O/cnXCM40/ecFGHeiOQePfnL5qJ4GjE9n
         lkJLnjX0JCHRQCPo0jLzatB3l4dOQnGG1bRwF5A+IUF4QNquOA3vYEgArRpZSlar/M9T
         afbQ==
X-Gm-Message-State: AOJu0Yw8xHbIHk+jJzilpfuR8jybYFk0xTFgiFUC0aD6wnHfuXsE1SJZ
	z20vvrB/vor0/7QvnVmrQuWkf4r+vUkopOsXIJ1HDAHh2jRCst7gZtrTJg==
X-Google-Smtp-Source: AGHT+IFhObGdqiDnjOF2mK9yhS42Pts07tRjnyo2kNnfaSoI/Ereux9GidCcoVs4ULkUgEFeTlFpZw==
X-Received: by 2002:a17:907:6d0b:b0:a8d:25d3:65e4 with SMTP id a640c23a62f3a-a8d25d3ef49mr529034266b.36.1725890215745;
        Mon, 09 Sep 2024 06:56:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a4428fsm345264666b.97.2024.09.09.06.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:56:54 -0700 (PDT)
Message-Id: <5bcbcce66650e0a4addabcc86fe834a6c9b1761c.1725890211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Sep 2024 13:56:50 +0000
Subject: [PATCH 4/4] p5314: add a size test for name-hash collisions
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
 5 files changed, 67 insertions(+)
 create mode 100644 t/helper/test-name-hash.c
 create mode 100755 t/perf/p5314-name-hash.sh

diff --git a/Makefile b/Makefile
index 91f65d7dc57..a5ce284cf4a 100644
--- a/Makefile
+++ b/Makefile
@@ -812,6 +812,7 @@ TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
+TEST_BUILTINS_OBJS += test-name-hash.o
 TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
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
index f8a67df7de9..4a603921002 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -43,6 +43,7 @@ static struct test_cmd cmds[] = {
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
+	{ "name-hash", cmd__name_hash },
 	{ "oid-array", cmd__oid_array },
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-mtimes", cmd__pack_mtimes },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e74bc0ffd41..56a83bf3aac 100644
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
-- 
gitgitgadget
