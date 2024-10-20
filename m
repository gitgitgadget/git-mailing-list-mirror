Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB6192584
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431819; cv=none; b=PX+DtWqzNK6PitBnN3EZZuTUheO2HLDIRbSIJ/H0ly/pvCfUrIRfOhPAiAjgZYhrlgdZAoHob3kDaPmgNsr/QSq7UG8dAuVsOrPKNhwD3nkYJglWcMQlzn4bKe7UreL45eLc/sk0AHSVQsd7GCJETKqi+waJt12120KVKq3VTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431819; c=relaxed/simple;
	bh=+no2Fsg3ePTOblpujd50sIirScNQ4vEq4mZNIMf11zc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KUMuUYMcELnTfJJybr44zJ9DXKaOsFYSXrjzFCTfqeO8jHPBo9AG7Eb/Uq6VYR2HDldDh0l7sGCRit6LvQcHJYkumCZCTWauWsxaW5HgNJKiqT5gCnT4DIS5XDQfLt0R9NDWcc/44IKyr/Y7c8HgW88Yt0JAmB4hNmXVkcibwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YORDsKmJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YORDsKmJ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99e3b3a411so744316366b.0
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431815; x=1730036615; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8e37B+OfdvykHAq8461cA43BBv4rorwVpoDJOIItyw=;
        b=YORDsKmJo6k5doTaH0h3j8hNOTlNil2/T8sj6BiiFMqtQVTDJ5o7AZEPclqAnPqIfH
         NMUavDSVwgaEpsfoVwGKQbHQp+CidpZKkbkRE2lTP7AnLZ0rjNzOsaH/otvbv+Abm2k7
         CKpeOn83JfpXRB2ilXXg+hdeL6n2oUCTJXGCspWAKUzToo42fS7Fm9tRfe/zSpm0tGt0
         CPfJFrO1e5l/cWpt0jZzZ9xOZtADoVWo9vYsLbBH3BAxKAcEUkaCQZ2UTpjWmnnNAucN
         DNnk7RI8lQG0lTBkgwZW9AqfxeMuehim20ZpDCh3fn54sEgk1NlhSL15cVlNFNSUjVQ4
         4rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431815; x=1730036615;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8e37B+OfdvykHAq8461cA43BBv4rorwVpoDJOIItyw=;
        b=ATIWKWZwprHi2aLcqLlpToOoqkcXc3ACB0KBhxi0tOl1rbPZ7MKo3Im13SZrzFE5C9
         L4Ixy+UvyVauBSbsjG3TzozIwmJAdd46ig2ykzrokm4ZUHuFa+RrmBq+XFNC5CckAwaC
         khxgMOGFm+1+NtxocjuWwB7pWTPjPzyupYflLw5pPvqn92HHMUh09aaZ1HDr8iP/S26j
         aIQKGLe1THZlO4bfjGV5AeldCKMJ58EJPkbBSCxAVHBT2hnL5V2ffbAiR5e+ohBjabZC
         0KyrU1F3dX4y8XbkTTiT7FMF41Rm1c4mDy+bO9rhGKdgKsVXQHGJfHw5YnjP2UrY1/7I
         fE7g==
X-Gm-Message-State: AOJu0Yx8WP4w462BnZE9U/vE31CJnnPrIejV5c6y15TtFoTREC24u4Aj
	qKltUO46gHVpe6CvmzntDiia2+5GsLohjBruvIwkNQKEQFdRAhjIEd42GA==
X-Google-Smtp-Source: AGHT+IFck5nepHknvr4W7GJ8jX15WqZ4OIn9xTd/NIgGIc4c1FUxDsaJ8TE2KUfkChcslyfzxbt2nQ==
X-Received: by 2002:a17:907:2d94:b0:a9a:616c:459e with SMTP id a640c23a62f3a-a9a6a569eadmr989696466b.27.1729431814811;
        Sun, 20 Oct 2024 06:43:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91559a1csm92356266b.125.2024.10.20.06.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:34 -0700 (PDT)
Message-Id: <a00ab0c62c9f9c495981d9e565fdd10303ebe079.1729431810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:15 +0000
Subject: [PATCH v2 02/17] t6601: add helper for testing path-walk API
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

