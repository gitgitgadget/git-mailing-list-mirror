Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE919F42D
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181282; cv=none; b=X12w3OuzHXy3xpDxwwkIVj9qzrwym1u6Ch/PbWkDg+cj/GXRURSMRPkaUCszLMpF/O2U2BHQQgzQeGShxpTH8/U3XGP0WV0aGdx9HsqBTooE45gdoba+wE3tz3Jw1wnqZ9oJNoCDeRAR4lhr9KboZyRcHH+nzyCIYrlzBRA2cJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181282; c=relaxed/simple;
	bh=ksri1waB8msAZNJ7PyAU6eXMnMt/53jnzU91S+ZCy/s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mp4Sx/eB3GfkgZJeOCuycn4dK6Z3TkhnJ/C81hN1hLd1cgIz967onQ5Gf14mVAhBHoXYJRfVvP4yjBXF6ZHU9RTgy8CGDWVbJpE4FXssCzl5KY6gPoN4yIUjDR2vYihj1PGGCXnXupoceyXfJl0DttNqorVAJjghoDekKUfuBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIzUVyF/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIzUVyF/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so30706285e9.1
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 11:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731181279; x=1731786079; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlkg3gPgxdWk/eRaM0IJ1iIi228RquXppMhVxQOldzQ=;
        b=CIzUVyF/l/QFG/dwNs7+PYPRop+QFKYLfawzVE36YYoYXOVYxp0KUXQ/fJVKQ9aGAs
         GJh+i+XbYF6DQnV+DXXSnT33h4E4pbTGZut/u4Bc1IkFZFa6naywCFpnXG/MIyV45I/F
         pIl5CfxVzjihZfsEkT6KRI5JWigVrMkNi7yldO+/dbdYgZMTDqluQTFLM9qbAlm35xaV
         MN2twI/JBFzj49y4pFCbaD+d6B9l+lki6qnG7ll7Yn8Vpc6yWr/+EZN1REmipsbKYiwG
         J6OkEdpwFJXV3aC0oZx8vufo3WzzHax5vxybCpg97ddMLcLx0b8q3vZfSdqCKJ+WzEQX
         B81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731181279; x=1731786079;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlkg3gPgxdWk/eRaM0IJ1iIi228RquXppMhVxQOldzQ=;
        b=BKxFz5CQancxm8I8QJRS7JqVfyyKL5oxOtjIU3U2vD8u1O109AHBvAF33xcCpra8u2
         rh+hqRNTn0DDnnqJse6B8L9zIzFDaNocffXC+KNs2z1NuZUb7wjkYFOISDbBXvCJtzQy
         FXTtFdlcM3amW3uCe7tlppHIxOdRGya4ILW0ur2lVDlQFvHRjPdr/43luf2SzHNZkign
         uV7JTtntWza3p/D/lw+9A+kGaf643PTRslbnJPoLaThK516LfSpA3elzgffrCwsXtaMB
         E1a6IdK9a3mZ1KTMbmC5sJB7KpCMNpYQdQNo6uPeJlCwDPbMBqW9gx0wjSjPDO58ThrV
         da2A==
X-Gm-Message-State: AOJu0YyyGOEI16jJlTfYjSZb3I91RN8uKbL4s9MsErBWAmoaQjZAii2a
	ah5DCJuCULvS36gzYPEFIUbj/G+1Mg/ohGAOabbrpQ83wJn8PJAMCdNntA==
X-Google-Smtp-Source: AGHT+IHJ/HgqB+IzBGSOuN1EeIT8Tw/PTtCXxrem1GKG0WSpXV/CAOeAW8GlBNCDWRSuqzGe2Th6lQ==
X-Received: by 2002:a05:600c:501e:b0:430:52ec:1e2b with SMTP id 5b1f17b1804b1-432b751c1d8mr63745745e9.29.1731181278443;
        Sat, 09 Nov 2024 11:41:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c26e3sm118928125e9.33.2024.11.09.11.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 11:41:17 -0800 (PST)
Message-Id: <a3c754d93cc3ecfcb4d2764930873af0b611eda9.1731181273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
	<pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Nov 2024 19:41:09 +0000
Subject: [PATCH v2 3/6] t6601: add helper for testing path-walk API
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
 t/helper/test-path-walk.c                 |  90 ++++++++++++++++
 t/helper/test-tool.c                      |   1 +
 t/helper/test-tool.h                      |   1 +
 t/t6601-path-walk.sh                      | 120 ++++++++++++++++++++++
 6 files changed, 215 insertions(+), 1 deletion(-)
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
index 00000000000..aa468871079
--- /dev/null
+++ b/t/helper/test-path-walk.c
@@ -0,0 +1,90 @@
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
index 00000000000..a3da55933f4
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
+	0:TREE::$(git rev-parse topic^{tree})
+	0:TREE::$(git rev-parse base^{tree})
+	0:TREE::$(git rev-parse base~1^{tree})
+	0:TREE::$(git rev-parse base~2^{tree})
+	1:TREE:right/:$(git rev-parse topic:right)
+	1:TREE:right/:$(git rev-parse base~1:right)
+	1:TREE:right/:$(git rev-parse base~2:right)
+	2:BLOB:right/d:$(git rev-parse base~1:right/d)
+	3:BLOB:right/c:$(git rev-parse base~2:right/c)
+	3:BLOB:right/c:$(git rev-parse topic:right/c)
+	4:TREE:left/:$(git rev-parse base:left)
+	4:TREE:left/:$(git rev-parse base~2:left)
+	5:BLOB:left/b:$(git rev-parse base~2:left/b)
+	5:BLOB:left/b:$(git rev-parse base:left/b)
+	6:BLOB:a:$(git rev-parse base~2:a)
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
+	0:TREE::$(git rev-parse topic^{tree})
+	0:TREE::$(git rev-parse base~1^{tree})
+	0:TREE::$(git rev-parse base~2^{tree})
+	1:TREE:right/:$(git rev-parse topic:right)
+	1:TREE:right/:$(git rev-parse base~1:right)
+	1:TREE:right/:$(git rev-parse base~2:right)
+	2:BLOB:right/d:$(git rev-parse base~1:right/d)
+	3:BLOB:right/c:$(git rev-parse base~2:right/c)
+	3:BLOB:right/c:$(git rev-parse topic:right/c)
+	4:TREE:left/:$(git rev-parse base~2:left)
+	5:BLOB:left/b:$(git rev-parse base~2:left/b)
+	6:BLOB:a:$(git rev-parse base~2:a)
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
+	0:TREE::$(git rev-parse topic^{tree})
+	1:TREE:right/:$(git rev-parse topic:right)
+	2:BLOB:right/d:$(git rev-parse topic:right/d)
+	3:BLOB:right/c:$(git rev-parse topic:right/c)
+	4:TREE:left/:$(git rev-parse topic:left)
+	5:BLOB:left/b:$(git rev-parse topic:left/b)
+	6:BLOB:a:$(git rev-parse topic:a)
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
+	0:TREE::$(git rev-parse topic^{tree})
+	0:TREE::$(git rev-parse base~1^{tree})
+	1:TREE:right/:$(git rev-parse topic:right)
+	1:TREE:right/:$(git rev-parse base~1:right)
+	2:BLOB:right/d:$(git rev-parse base~1:right/d)
+	3:BLOB:right/c:$(git rev-parse base~1:right/c)
+	3:BLOB:right/c:$(git rev-parse topic:right/c)
+	4:TREE:left/:$(git rev-parse base~1:left)
+	5:BLOB:left/b:$(git rev-parse base~1:left/b)
+	6:BLOB:a:$(git rev-parse base~1:a)
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

