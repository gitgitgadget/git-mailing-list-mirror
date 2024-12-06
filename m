Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2F198A06
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514368; cv=none; b=YeJvnjsS+mw2hFTbfhTpzELJONoKT9Qz0OdxNv/Wy5LbByRshrBWTldMOQQbIFqqO6MGGAAZlHmB1nr9Ysa2cXcmj99EABTQhC++vmgfx/H607wNzjSESjRxELyk7x+4S+AEEPJpskbMqYTQx0XX+5H1GW0BQMTiEMOeqY4wRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514368; c=relaxed/simple;
	bh=AxEmc2eTK5I4gxJZ8UnqpVwkogjpTcccKUe4bZ2aHyA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OxAozO0HmOigkvWgr5E1pUtLpnB33iQ+h7UqrwvhVY0bHQul0CGDnp60m1Y1M7Z+o26q8VEGv05bJSaJkBDYHw7fRK3w89VB06aRld926ETZRlMJFWdDsXAFom9hhNDSxf0+uUaG3kUJQF0nMJMEhaY1dMrgLgXzRHpszju8AWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY6b6zKg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY6b6zKg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349f160d62so17019925e9.2
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 11:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733514364; x=1734119164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/mlE7gohAENwH25tsyvZWFf+T9m6cwxzh9jcqpU9AI=;
        b=TY6b6zKgBkPwRZHAbGHRd35yOlp4KEZ0hb09g2I1mpgarY9BMHiiHosA+y3Ynuu6w7
         bML/9xR4D1g3lAGDahg/Ruv1/H2Z1/4R1BZCtdo7SXwONExcTH3j+/c4zdZ/kJv6EUKe
         z393bSR0OM6CXsqZT2M2QyzTSvrvi8EwbyzC8zfp31/PW3L6qaRe9hA3f4KrlQF2j41j
         pcUw4YbCf95BYNA7Oz8ILF36ZTP38vMUTs9AZrq50tx9zxUloRyHcNk5Kdgy0xy/wfaU
         T5Bj1gFLdbCkKWycoRpaD/wb4404HACZadQwQBxa8bo0XFNlRfK2Wa3jMbVzhY59cfzc
         gCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514364; x=1734119164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/mlE7gohAENwH25tsyvZWFf+T9m6cwxzh9jcqpU9AI=;
        b=e7U7quTIHeXAO0c/kimoiR9/jMOOroOI41fD6EN1WUyal5St5tU1ci2UifX+2dzm9Z
         3DUJeI6m+eQN7KkurXgoFB86I/x3iXiBy58ggZ5L/quK4isOCXajOQnkTVlIjYx5goTO
         9V+fs0o1cfg+47b1pOmaUPdZ+FUP56VEzYryq6wt/VdIhr2Dr2zf1EG/WVNVJU4ANvNi
         2k7vd/CUnDnWFlbGmAbv9PzhZgRp+jYvGvna0XNFLbRlZf8PrRRpAWz/VEhnAjkn+4Xw
         VBpPYO/uQYTbwvIY9jZyl+TcCFjmITHlHdR3NWUoN9rYiY0prns0h/oW6QmWmVOhaUng
         A0Iw==
X-Gm-Message-State: AOJu0YzAFu59TMK5Oc0FWpJ3Zpl506ZSrq69acEqm/7UBvolQ0tTd3R9
	o5PZE4GCVgYTufgRok4FunP+bNkoIQYwlhEkI+14oK8QjuICtlR1G3M2vA==
X-Gm-Gg: ASbGncvZnTEPm8R612g7BTBHz0AGv/g04QIr1P7BRLoDlp0rolGwGv3TdURB9k+uze1
	4EouumuSmG/j29ENbJqZBWBNyTyeIpWbVCKutB51ZLYOyZZWNmVg3jriOZmqE67TqXKZLHC2SeJ
	qr2eLYrNWlOT9SbPSxWtd4DhJhUE/UTAsGtmbV0uQApv7acix8oEIxvcHZEeyYZ1vCZMInFJoPm
	e0L88D9StSmRQUn+bnFU/PxvH2pfpDCw+4GdqwndwaYmlsCQ1Y=
X-Google-Smtp-Source: AGHT+IHFIjY7S7b100YyaLEC4n1ECHGKYZ6igsLMB0R4GM034JHB4K4pnKgtmwe8WKda0GWo2RxvTg==
X-Received: by 2002:a05:600c:45c7:b0:434:a8d8:760e with SMTP id 5b1f17b1804b1-434ddeb9cb4mr35853755e9.19.1733514363764;
        Fri, 06 Dec 2024 11:46:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b131sm104630485e9.7.2024.12.06.11.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:46:03 -0800 (PST)
Message-Id: <54886fcb081601157799d40a6b2e292c0c0a053d.1733514359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
	<pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 19:45:54 +0000
Subject: [PATCH v3 3/7] t6601: add helper for testing path-walk API
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
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add some tests based on the current behavior, doing interesting checks
for different sets of branches, ranges, and the --boundary option. This
sets a baseline for the behavior and we can extend it as new options are
introduced.

Store and output a 'batch_nr' value so we can demonstrate that the paths are
grouped together in a batch and not following some other ordering. This
allows us to test the depth-first behavior of the path-walk API. However, we
purposefully do not test the order of the objects in the batch, so the
output is compared to the expected output through a sort.

It is important to mention that the behavior of the API will change soon as
we start to handle UNINTERESTING objects differently, but these tests will
demonstrate the change in behavior.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |   3 +-
 Makefile                                  |   1 +
 t/helper/test-path-walk.c                 |  84 +++++++++++++++
 t/helper/test-tool.c                      |   1 +
 t/helper/test-tool.h                      |   1 +
 t/t6601-path-walk.sh                      | 120 ++++++++++++++++++++++
 6 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-path-walk.c
 create mode 100755 t/t6601-path-walk.sh

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index c550c77ca30..662162ec70b 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -42,4 +42,5 @@ commits.
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
index 00000000000..def7c81ac4f
--- /dev/null
+++ b/t/helper/test-path-walk.c
@@ -0,0 +1,84 @@
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
+	uintmax_t batch_nr;
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
+	if (type == OBJ_TREE)
+		tdata->tree_nr += oids->nr;
+	else if (type == OBJ_BLOB)
+		tdata->blob_nr += oids->nr;
+	else
+		BUG("we do not understand this type");
+
+	typestr = type_name(type);
+
+	for (size_t i = 0; i < oids->nr; i++)
+		printf("%"PRIuMAX":%s:%s:%s\n",
+		       tdata->batch_nr, typestr, path,
+		       oid_to_hex(&oids->oid[i]));
+
+	tdata->batch_nr++;
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
+	release_revisions(&revs);
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
index 00000000000..4e052c09309
--- /dev/null
+++ b/t/t6601-path-walk.sh
@@ -0,0 +1,120 @@
+#!/bin/sh
+
+TEST_PASSES_SANITIZE_LEAK=true
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
+	0:tree::$(git rev-parse topic^{tree})
+	0:tree::$(git rev-parse base^{tree})
+	0:tree::$(git rev-parse base~1^{tree})
+	0:tree::$(git rev-parse base~2^{tree})
+	1:tree:right/:$(git rev-parse topic:right)
+	1:tree:right/:$(git rev-parse base~1:right)
+	1:tree:right/:$(git rev-parse base~2:right)
+	2:blob:right/d:$(git rev-parse base~1:right/d)
+	3:blob:right/c:$(git rev-parse base~2:right/c)
+	3:blob:right/c:$(git rev-parse topic:right/c)
+	4:tree:left/:$(git rev-parse base:left)
+	4:tree:left/:$(git rev-parse base~2:left)
+	5:blob:left/b:$(git rev-parse base~2:left/b)
+	5:blob:left/b:$(git rev-parse base:left/b)
+	6:blob:a:$(git rev-parse base~2:a)
+	blobs:6
+	trees:9
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic only' '
+	test-tool path-walk -- topic >out &&
+
+	cat >expect <<-EOF &&
+	0:tree::$(git rev-parse topic^{tree})
+	0:tree::$(git rev-parse base~1^{tree})
+	0:tree::$(git rev-parse base~2^{tree})
+	1:tree:right/:$(git rev-parse topic:right)
+	1:tree:right/:$(git rev-parse base~1:right)
+	1:tree:right/:$(git rev-parse base~2:right)
+	2:blob:right/d:$(git rev-parse base~1:right/d)
+	3:blob:right/c:$(git rev-parse base~2:right/c)
+	3:blob:right/c:$(git rev-parse topic:right/c)
+	4:tree:left/:$(git rev-parse base~2:left)
+	5:blob:left/b:$(git rev-parse base~2:left/b)
+	6:blob:a:$(git rev-parse base~2:a)
+	blobs:5
+	trees:7
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic, not base' '
+	test-tool path-walk -- topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	0:tree::$(git rev-parse topic^{tree})
+	1:tree:right/:$(git rev-parse topic:right)
+	2:blob:right/d:$(git rev-parse topic:right/d)
+	3:blob:right/c:$(git rev-parse topic:right/c)
+	4:tree:left/:$(git rev-parse topic:left)
+	5:blob:left/b:$(git rev-parse topic:left/b)
+	6:blob:a:$(git rev-parse topic:a)
+	blobs:4
+	trees:3
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic, not base, boundary' '
+	test-tool path-walk -- --boundary topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	0:tree::$(git rev-parse topic^{tree})
+	0:tree::$(git rev-parse base~1^{tree})
+	1:tree:right/:$(git rev-parse topic:right)
+	1:tree:right/:$(git rev-parse base~1:right)
+	2:blob:right/d:$(git rev-parse base~1:right/d)
+	3:blob:right/c:$(git rev-parse base~1:right/c)
+	3:blob:right/c:$(git rev-parse topic:right/c)
+	4:tree:left/:$(git rev-parse base~1:left)
+	5:blob:left/b:$(git rev-parse base~1:left/b)
+	6:blob:a:$(git rev-parse base~1:a)
+	blobs:5
+	trees:5
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_done
-- 
gitgitgadget

