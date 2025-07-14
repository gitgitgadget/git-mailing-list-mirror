Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB827990D
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537168; cv=none; b=r52quJHz+3iZtuj6QvXMoDRHv5m6qDT5r+y1yfUG284AQmzvIJpLYMpumsaNrXf3edEiDNB0hUihWMEU38ZcnwuGCT1fa7Y7BAFWLWvDRRKBV1sd1di6eM/Hku9rQlztJC0IQw12O0Vx/hN5BPOTw+bnF2Y8YA9s1HekpIKFcTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537168; c=relaxed/simple;
	bh=CvpTfTk5wn2qEzGctB5rPAsuNDaeaMvJehcDfyLtjiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tI/0SWaBqzNcA3RHDmfTAk0zdnfAhjIYL4xwgeSUt7AGVutZKL0+HbsnbK+2BTB9ZEuw2iiYqkzZ5mNRo+kcFkfpZGo2t/fgH8xxtFflbCRkAZnALYvnGjCOJ0d2ftH63eInbhCwYYY6HzIL9KA0hAnBUQEmdq+m/DgB6zVhYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvdVdHc3; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvdVdHc3"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5316a5e4c6cso2079153e0c.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752537166; x=1753141966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kuTn90i3WTOIk00aXX5gSxU5DcsSqVMtG3uGaTYQ74=;
        b=OvdVdHc38WDEhDaGmB4OW4YV4J8HWSHFPJE42aJTEe5HwvnzJ8SODVXsFhPN2sFdT7
         5cBsIS+QuwNYcg3tsCPQ6orOgONndNSTSnmOxX82jUr/sjIJXtHKMJ/gzrO2PYsYLaLn
         CLxWn81W+yx23Ub79y6Rpv2++EDwT0VMNsHQ20b8COU0nAu8J8TXJn7dFy6VCKl1muSy
         nZZTkstJYDW+L9ZvpSNiFO2/Lg2IV0397Jc7Ia4r9RQ/sjtLczAm56QzECmkK6Huq+o5
         ZU1Axyi4bsG2Caf5FUkvS41OmKOKUMlK1WmSjGIsqpzBBOY5YMHjjNAtPi7JCntQxK4A
         KUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752537166; x=1753141966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kuTn90i3WTOIk00aXX5gSxU5DcsSqVMtG3uGaTYQ74=;
        b=guoEDft+A8zPphyYj/noxRV8Dt3t42/S8OEqpnjIwRfgHY2p2w7TTapRw6yJacFQ5Y
         3HgqiTbdQhmvoUYFMe4/ts/S8tzOhvHk8zVhavCspo8OqesvLJ8NNrmJe9qxi7zu+IDj
         HfxUutKBNFleE8iJNds74I+POFXVWkXPwzUWFYRtiFCb6z6k1GxBX2MT6yyFcXeEEenf
         wfENBpxJ5ol7LP7JP6FMJ/Yjq1g6609xQ9NSra7xu8WSpAxBqE5rBxa7fOMA/oWmn7yg
         yO8USXHHwfjbA9kG1DSrWUhQfo51VKg8rwpbB2l8kTFmOM+xPSc89o3pf3+Dal/pdLUm
         H/6A==
X-Gm-Message-State: AOJu0YxiGwzXSe+MVhbe8jCy9iHXW1GaM7A/dIMthNjQbTqmqAF2saDO
	5r6IlSX1Hc9JMFmJT6bpoAV9RK+gzHhtCVRo8Vux0+deQltj11HQn8cqa/W3HTYp
X-Gm-Gg: ASbGncv6HogadQSTqvI1fk2iWEZM2F/B015518lipw5ft8aFyaVlOdL7dUbcbQEPY83
	naP/wxsKaKNgOiz73A9aAPpGZT7tjP9CBH0JmI0pPlnDZNm0UFOHfJHbbK7ezsJcU933I58EPZr
	lko0lmxvF+fldNux4FJvwmZeiko56BWFtbBHlnSgFoEVh/+YYX+Ws4XDnVhy9bq+kQFNxd5OeUK
	Q8XrkkhOYOd0hRcrF1EQQ7N+6wDyDOIldAnI/2xTTKonsZ1Ecb5gjvFaTN4mK6yFH489CGsMnm+
	E8RSeofjfWuCXqY5PE01eumB1yMvb5CeF1RvDkDT2+MKs+3LVpN7u4h4vuHRNMbHEUP4TlS3sYB
	IMSBZPhzHks2M+luGSG6oHnfm2kheqM6Z88lbZdtxgplOcaGPknC74GaNrW+NR6c=
X-Google-Smtp-Source: AGHT+IHtt/3y+HWy1rGBaY47bjDAdz1DovxTIfiIXjLoQZgUcOpkbAM0imY/Cg+FcwuflGlCGm5Txw==
X-Received: by 2002:a05:6102:6885:b0:4e5:a398:b6fa with SMTP id ada2fe7eead31-4f6412109eemr9320355137.3.1752537165637;
        Mon, 14 Jul 2025 16:52:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:fc3:f915:3491:9732:5741])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-535e73de3c8sm1999201e0c.48.2025.07.14.16.52.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Jul 2025 16:52:45 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
Date: Mon, 14 Jul 2025 20:52:29 -0300
Message-Id: <20250714235231.10137-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714235231.10137-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduce the new subcommand
git-repo-info.

The flag `--show-ref-format` from git-rev-parse is used for retrieving
the reference format (i.e. `files` or `reftable`). This way, it is
used for querying repository metadata, fitting in the purpose of
git-repo-info.

Then, add a new field `references.format` to the repo-info subcommand
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  4 ++
 builtin/repo.c              | 92 +++++++++++++++++++++++++++++++++++--
 t/meson.build               |  1 +
 t/t1900-repo.sh             | 47 +++++++++++++++++++
 4 files changed, 140 insertions(+), 4 deletions(-)
 create mode 100755 t/t1900-repo.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 6f8fe3f6ea..b7af6f45a4 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -45,6 +45,10 @@ INFO KEYS
 The set of data that `git repo` can return is grouped into the following
 categories:
 
+`references`::
+Reference-related data:
+* `format`: the reference storage format, either `files` or `reftable`.
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index a1787a3cc5..dcda0d6d61 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,11 +1,95 @@
 #include "builtin.h"
 #include "parse-options.h"
+#include "strbuf.h"
+#include "refs.h"
 
-static int repo_info(int argc UNUSED,
-		     const char **argv UNUSED,
+typedef void add_field_fn(struct strbuf *buf, struct repository *repo);
+
+struct field {
+	const char *key;
+	add_field_fn *add_field_callback;
+};
+
+static void add_string(struct strbuf *buf,
+		       const char *key, const char *value)
+{
+	strbuf_addf(buf, "%s\n%s%c", key, value, '\0');
+}
+
+static void add_references_format(struct strbuf *buf,
+				  struct repository *repo)
+{
+	add_string(buf, "references.format",
+		   ref_storage_format_to_name(repo->ref_storage_format));
+}
+
+// repo_info_fields keys should be in lexicographical order
+static const struct field repo_info_fields[] = {
+	{"references.format", add_references_format},
+};
+
+static int repo_info_fields_cmp(const void *va, const void *vb)
+{
+	const struct field *a = va;
+	const struct field *b = vb;
+
+	return strcmp(a->key, b->key);
+}
+
+static add_field_fn *get_append_callback(const char *key) {
+	const struct field search_key = {key, NULL};
+	const struct field *found = bsearch(&search_key, repo_info_fields,
+					    ARRAY_SIZE(repo_info_fields),
+					    sizeof(struct field),
+					    repo_info_fields_cmp);
+	return found ? found->add_field_callback : NULL;
+}
+
+static int qsort_strcmp(const void *va, const void *vb)
+{
+	const char *a = *(const char **)va;
+	const char *b = *(const char **)vb;
+
+	return strcmp(a, b);
+}
+
+static void print_fields(int argc, const char **argv, struct repository *repo) {
+	const char *last = "";
+	struct strbuf buf;
+	strbuf_init(&buf, 256);
+
+	QSORT(argv, argc, qsort_strcmp);
+
+	for (int i = 0; i < argc; i++) {
+		add_field_fn *callback;
+		const char *key = argv[i];
+
+		if (!strcmp(key, last))
+			continue;
+
+		callback = get_append_callback(key);
+
+		if (!callback) {
+			error("key %s not found", key);
+			strbuf_release(&buf);
+			exit(1);
+		}
+
+		callback(&buf, repo);
+		last = key;
+	}
+
+	fwrite(buf.buf, 1, buf.len, stdout);
+	strbuf_release(&buf);
+}
+
+static int repo_info(int argc,
+		     const char **argv,
 		     const char *prefix UNUSED,
-		     struct repository *repo UNUSED)
+		     struct repository *repo)
 {
+
+	print_fields(argc - 1 , argv + 1, repo);
 	return 0;
 }
 
@@ -16,7 +100,7 @@ int cmd_repo(int argc,
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	const char *const repo_usage[] = {
-		"git repo info",
+		"git repo info [<key>...]",
 		NULL
 	};
 	struct option options[] = {
diff --git a/t/meson.build b/t/meson.build
index 1af289425d..8693e6abc4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -245,6 +245,7 @@ integration_tests = [
   't1700-split-index.sh',
   't1701-racy-split-index.sh',
   't1800-hook.sh',
+  't1900-repo.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
   't2003-checkout-cache-mkdir.sh',
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
new file mode 100755
index 0000000000..b80fc6b78b
--- /dev/null
+++ b/t/t1900-repo.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='test git repo-info'
+
+. ./test-lib.sh
+
+# Test if a field is correctly returned in the null-terminated format
+#
+# Usage: test_repo_info <label> <init command> <key> <expected value>
+#
+# Arguments:
+#   label: the label of the test
+#   init command: a command that creates a repository called 'repo', configured
+#      accordingly to what is being tested
+#   key: the key of the field that is being tested
+#   expected value: the value that the field should contain
+test_repo_info () {
+	label=$1
+	init_command=$2
+	key=$3
+	expected_value=$4
+
+	test_expect_success "$label" '
+		test_when_finished "rm -rf repo" &&
+		eval "$init_command" &&
+		echo "$expected_value" | lf_to_nul >expected &&
+		git -C repo repo info "$key" >output &&
+		tail -n 1 output >actual &&
+		test_cmp expected actual
+	'
+}
+
+test_repo_info 'ref format files is retrieved correctly' '
+	git init --ref-format=files repo' 'references.format' 'files'
+
+test_repo_info 'ref format reftable is retrieved correctly' '
+	git init --ref-format=reftable repo' 'references.format' 'reftable'
+
+test_expect_success "only one value is returned if the same key is requested twice" '
+	echo "references.format" > expected &&
+	git rev-parse --show-ref-format > ref-format &&
+	lf_to_nul <ref-format >>expected &&
+	git repo info references.format references.format > actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
2.39.5 (Apple Git-154)

