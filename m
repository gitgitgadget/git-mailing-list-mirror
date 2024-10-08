Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC4E1DF971
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396731; cv=none; b=Qu6Onzlt4sq5f00UPj1eBvYguKs7P8im74YV70Sgk5pE1jYh1/dQf1G0rzDc1YPejn++gDqeeZ4iF3LjS8jae1mixNu4XMSdOQv4jkqfsY07Y2NaD4gSwvFnRsQ6Anl7jFDPtNll8NjptcjSc1LjBf61JzxhFvA2AJklKZAOoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396731; c=relaxed/simple;
	bh=+no2Fsg3ePTOblpujd50sIirScNQ4vEq4mZNIMf11zc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ewUnHAreR9WWBcm1ffVqmbJtOe5Zk9iSHtm47q/S2sV878wTOfHEga1lK+hnWLsdmIULCLXNs+LR8DU10Vf3t0ViFv8XL0+hj+Nxst/nsUzN6Douc4JXJNX90cef9VHVLrqLutZ4Na8LRwk8ig9By0Ci0z7RVSmWGu87WNaDhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwlKMmhu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwlKMmhu"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so7679588a12.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396728; x=1729001528; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8e37B+OfdvykHAq8461cA43BBv4rorwVpoDJOIItyw=;
        b=lwlKMmhu7DsH3OqXowNZ4o+6WboEudLz/4gGxTqi7bRCwFtytPkXzDBxcYycHfhO/s
         LovC+0KB5PdC4eg5ecyWwBKAOiVfB4ONlOoHsnbyyCsJn8pRXD17M1EWP9sJ04+9VGdl
         ge4eNmSqbbq3rwGbM1jIoc/lbDUNLq2bV62Gk6anzyi8IFj5I17tFotylPNK3O1cYYyM
         ADfN36je4lSSlzZ/RennwljbWZ1sHF0Gtz9HW/ISQYI/Jzb/l0UJl++1FVN1k1GJW+Wc
         1LU0AW7KNFG4ECjWQTvKQRU8AEzojxCVag372vK6qPed6o1DBplRSb9/bKCQIgGmtex3
         WoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396728; x=1729001528;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8e37B+OfdvykHAq8461cA43BBv4rorwVpoDJOIItyw=;
        b=adybQAKZyWwRGPDmBL0jTZQgoXNj5YAggZOk0KmHQ0+x3aidgmFH3AiY9JjfUKwyWa
         KaVP0ebVnX8aphZsu8viDOCaRvpGK0Ed5QOPt3/3QUm8MebNpFamW/1QTavP6C6EGQ8p
         R66rGLjP+CZy9qRIifhE+pL8JGVwb1oF//rWKQfykS3fWP2T7XqMmHBKSUhcom18cCmA
         s2OmFTTFFuuIAFfm5yeXzZfpZy6vpEU9SXBu9NF7ZNC85QCkqwHiWvJKMstf46o4+KGb
         050n562fifKtgfRbanrLbeuZ5tTrwvUM1JFg9mPp3zjOT3Vq2ImXnkD75ddTRu1TR19/
         5NoQ==
X-Gm-Message-State: AOJu0Yx1jwXXJMBNqeD3g7DjeSt7kci10VPivOgczWf/YGqmko22eob2
	zzSt3qAudmH3xY1qZpQ4ghyC8Pl/CKQJKr1EeqOLzE/0UedpTyb+tYA9wA==
X-Google-Smtp-Source: AGHT+IG00+ISIcjYgxbAaUp7K82/EE47P5755JKOCm11xYug3v7NUZG3iC4phSuMggoNREkZEIc05g==
X-Received: by 2002:a05:6402:354f:b0:5c8:8626:e41 with SMTP id 4fb4d7f45d1cf-5c8d2d005c6mr10709526a12.4.1728396727366;
        Tue, 08 Oct 2024 07:12:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c911978839sm384908a12.46.2024.10.08.07.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:06 -0700 (PDT)
Message-Id: <a00ab0c62c9f9c495981d9e565fdd10303ebe079.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:48 +0000
Subject: [PATCH 02/17] t6601: add helper for testing path-walk API
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
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add some tests based on the current behavior, doing interesting checks
for different sets of branches, ranges, and the --boundary option. This
sets a baseline for the behavior and we can extend it as new options are
introduced.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |   3 +-
 Makefile                                  |   1 +
 t/helper/test-path-walk.c                 |  86 ++++++++++++++
 t/helper/test-tool.c                      |   1 +
 t/helper/test-tool.h                      |   1 +
 t/t6601-path-walk.sh                      | 130 ++++++++++++++++++++++
 6 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-path-walk.c
 create mode 100755 t/t6601-path-walk.sh

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index 6472222ae6d..e588897ab8d 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -51,4 +51,5 @@ commits are emitted.
 Examples
 --------
 
-See example usages in future changes.
+See example usages in:
+	`t/helper/test-path-walk.c`
diff --git a/Makefile b/Makefile
index d0d8d6888e3..50413d96492 100644
--- a/Makefile
+++ b/Makefile
@@ -818,6 +818,7 @@ TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-partial-clone.o
 TEST_BUILTINS_OBJS += test-path-utils.o
+TEST_BUILTINS_OBJS += test-path-walk.o
 TEST_BUILTINS_OBJS += test-pcre2-config.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-proc-receive.o
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
new file mode 100644
index 00000000000..3c48f017fa0
--- /dev/null
+++ b/t/helper/test-path-walk.c
@@ -0,0 +1,86 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "environment.h"
+#include "hex.h"
+#include "object-name.h"
+#include "object.h"
+#include "pretty.h"
+#include "revision.h"
+#include "setup.h"
+#include "parse-options.h"
+#include "path-walk.h"
+#include "oid-array.h"
+
+static const char * const path_walk_usage[] = {
+	N_("test-tool path-walk <options> -- <revision-options>"),
+	NULL
+};
+
+struct path_walk_test_data {
+	uintmax_t tree_nr;
+	uintmax_t blob_nr;
+};
+
+static int emit_block(const char *path, struct oid_array *oids,
+		      enum object_type type, void *data)
+{
+	struct path_walk_test_data *tdata = data;
+	const char *typestr;
+
+	switch (type) {
+	case OBJ_TREE:
+		typestr = "TREE";
+		tdata->tree_nr += oids->nr;
+		break;
+
+	case OBJ_BLOB:
+		typestr = "BLOB";
+		tdata->blob_nr += oids->nr;
+		break;
+
+	default:
+		BUG("we do not understand this type");
+	}
+
+	for (size_t i = 0; i < oids->nr; i++)
+		printf("%s:%s:%s\n", typestr, path, oid_to_hex(&oids->oid[i]));
+
+	return 0;
+}
+
+int cmd__path_walk(int argc, const char **argv)
+{
+	int res;
+	struct rev_info revs = REV_INFO_INIT;
+	struct path_walk_info info = PATH_WALK_INFO_INIT;
+	struct path_walk_test_data data = { 0 };
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	initialize_repository(the_repository);
+	setup_git_directory();
+	revs.repo = the_repository;
+
+	argc = parse_options(argc, argv, NULL,
+			     options, path_walk_usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
+
+	if (argc > 1)
+		setup_revisions(argc, argv, &revs, NULL);
+	else
+		usage(path_walk_usage[0]);
+
+	info.revs = &revs;
+	info.path_fn = emit_block;
+	info.path_fn_data = &data;
+
+	res = walk_objects_by_path(&info);
+
+	printf("trees:%" PRIuMAX "\n"
+	       "blobs:%" PRIuMAX "\n",
+	       data.tree_nr, data.blob_nr);
+
+	return res;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 1ebb69a5dc4..43676e7b93a 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -52,6 +52,7 @@ static struct test_cmd cmds[] = {
 	{ "parse-subcommand", cmd__parse_subcommand },
 	{ "partial-clone", cmd__partial_clone },
 	{ "path-utils", cmd__path_utils },
+	{ "path-walk", cmd__path_walk },
 	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
 	{ "proc-receive", cmd__proc_receive },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 21802ac27da..9cfc5da6e57 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -45,6 +45,7 @@ int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__parse_subcommand(int argc, const char **argv);
 int cmd__partial_clone(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
+int cmd__path_walk(int argc, const char **argv);
 int cmd__pcre2_config(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__proc_receive(int argc, const char **argv);
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
new file mode 100755
index 00000000000..ca18b61c3f1
--- /dev/null
+++ b/t/t6601-path-walk.sh
@@ -0,0 +1,130 @@
+#!/bin/sh
+
+test_description='direct path-walk API tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup test repository' '
+	git checkout -b base &&
+
+	mkdir left &&
+	mkdir right &&
+	echo a >a &&
+	echo b >left/b &&
+	echo c >right/c &&
+	git add . &&
+	git commit -m "first" &&
+
+	echo d >right/d &&
+	git add right &&
+	git commit -m "second" &&
+
+	echo bb >left/b &&
+	git commit -a -m "third" &&
+
+	git checkout -b topic HEAD~1 &&
+	echo cc >right/c &&
+	git commit -a -m "topic"
+'
+
+test_expect_success 'all' '
+	test-tool path-walk -- --all >out &&
+
+	cat >expect <<-EOF &&
+	TREE::$(git rev-parse topic^{tree})
+	TREE::$(git rev-parse base^{tree})
+	TREE::$(git rev-parse base~1^{tree})
+	TREE::$(git rev-parse base~2^{tree})
+	TREE:left/:$(git rev-parse base:left)
+	TREE:left/:$(git rev-parse base~2:left)
+	TREE:right/:$(git rev-parse topic:right)
+	TREE:right/:$(git rev-parse base~1:right)
+	TREE:right/:$(git rev-parse base~2:right)
+	trees:9
+	BLOB:a:$(git rev-parse base~2:a)
+	BLOB:left/b:$(git rev-parse base~2:left/b)
+	BLOB:left/b:$(git rev-parse base:left/b)
+	BLOB:right/c:$(git rev-parse base~2:right/c)
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse base~1:right/d)
+	blobs:6
+	EOF
+
+	sort expect >expect.sorted &&
+	sort out >out.sorted &&
+
+	test_cmp expect.sorted out.sorted
+'
+
+test_expect_success 'topic only' '
+	test-tool path-walk -- topic >out &&
+
+	cat >expect <<-EOF &&
+	TREE::$(git rev-parse topic^{tree})
+	TREE::$(git rev-parse base~1^{tree})
+	TREE::$(git rev-parse base~2^{tree})
+	TREE:left/:$(git rev-parse base~2:left)
+	TREE:right/:$(git rev-parse topic:right)
+	TREE:right/:$(git rev-parse base~1:right)
+	TREE:right/:$(git rev-parse base~2:right)
+	trees:7
+	BLOB:a:$(git rev-parse base~2:a)
+	BLOB:left/b:$(git rev-parse base~2:left/b)
+	BLOB:right/c:$(git rev-parse base~2:right/c)
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse base~1:right/d)
+	blobs:5
+	EOF
+
+	sort expect >expect.sorted &&
+	sort out >out.sorted &&
+
+	test_cmp expect.sorted out.sorted
+'
+
+test_expect_success 'topic, not base' '
+	test-tool path-walk -- topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	TREE::$(git rev-parse topic^{tree})
+	TREE:left/:$(git rev-parse topic:left)
+	TREE:right/:$(git rev-parse topic:right)
+	trees:3
+	BLOB:a:$(git rev-parse topic:a)
+	BLOB:left/b:$(git rev-parse topic:left/b)
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse topic:right/d)
+	blobs:4
+	EOF
+
+	sort expect >expect.sorted &&
+	sort out >out.sorted &&
+
+	test_cmp expect.sorted out.sorted
+'
+
+test_expect_success 'topic, not base, boundary' '
+	test-tool path-walk -- --boundary topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	TREE::$(git rev-parse topic^{tree})
+	TREE::$(git rev-parse base~1^{tree})
+	TREE:left/:$(git rev-parse base~1:left)
+	TREE:right/:$(git rev-parse topic:right)
+	TREE:right/:$(git rev-parse base~1:right)
+	trees:5
+	BLOB:a:$(git rev-parse base~1:a)
+	BLOB:left/b:$(git rev-parse base~1:left/b)
+	BLOB:right/c:$(git rev-parse base~1:right/c)
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse base~1:right/d)
+	blobs:5
+	EOF
+
+	sort expect >expect.sorted &&
+	sort out >out.sorted &&
+
+	test_cmp expect.sorted out.sorted
+'
+
+test_done
-- 
gitgitgadget

