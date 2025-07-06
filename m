Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68A288C26
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751844017; cv=none; b=YZijJK8MCkNd1JI9XG4lbiUNH+3m0iWOUbI0M6uRJHKNwBQnOqMbPKzJBHokm1OQZNSAByTIAijYAHBzo2FGmH0D06hfR6Vo78b+WKzU72QIIRx5jzg+U3cC4ly3myVAneFV8iZMJLD7tL3pwAPZepvn72mUnU+YiyDj1L0ZWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751844017; c=relaxed/simple;
	bh=cIPCWZ3nC2UCCppHOtEfIm25JEDBlueJGZNClhM0WgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ilDbREULpBokhMB54h/i422bQteQnErI/J/awUlZlONLeDDAi0GEWJQxY2N3pN0oL8RZ+SYQbNjS/FF7fp9Wqe3rkAE5lS+NBVa/QKYB2dUPtK4wshgLwsOu18rtDQlD0shIWqae2yHNxxsp2KyQq1MR2D4JcM6digxfCOwGRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKF1Pa01; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKF1Pa01"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6facc3b9559so45398346d6.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751844015; x=1752448815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCqwh2TrKNqqwvLgHvibVJd0tw4k4fSeQfBqyTUbkZ8=;
        b=KKF1Pa01XR205Yebt/tDZUrR+Du8qs3PCTv0pmNkGqMamC7C02sYhIc6WE+GQKNZBQ
         IXHAcvD5hw208WC8AMmf5AysX+q0RQB78WQJySi4ZW2UDZpvNUInTx5+LYEgSpbagKKx
         WBwgiC3qrcAptRCUhKwsITcBiwrZkD6F7vegqcxAieFJHf4fX/3HhQoC5g75ra/Pbv1C
         YUjERELPDDWA+ab2zQyg84gpFgoBWUZMntuF+XAkd11oeJIMf8jw86XF1qkuxJ+BLTbo
         gboHtrr20Eq5i5/JrywCmpLuDFLgdFK51tX8x4CUSpFMb4WaXxscxyGYgknF/W9qgvDm
         ctXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751844015; x=1752448815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCqwh2TrKNqqwvLgHvibVJd0tw4k4fSeQfBqyTUbkZ8=;
        b=kc98uxp7Vtnq/QCyJurJvcBJprHJZ30SlqdivcFq7gauhthdTWpdPsens02Fy4WSvf
         n1oOsK5dMyKvgJ5dqFJQr7mVoWOjEHIlj/lNmYqoxs7QnmVTaKmH1XTtGDBw8nk8o4KN
         YhFiSikCEv5nuPTuTfXyCU6lVPUGzXHFm874QM9UTwPix+qXDgKL7wOqATCDUDEjhi6Z
         PgL5hVK4/uNJ/gejbTqmF0+N6ADpuLQ+rB6l8uJnS5fD3NX+yj10adMIeLz3x/7VYIuO
         BAS/ItfdFh7kjHuGr6crMbmUPPtDOl/wu2yc+sm722Fj+6hGOKXBmBhhBNC4dOtOIMxD
         LGCQ==
X-Gm-Message-State: AOJu0YwW6MdVRVU7a/4DY+N9blN+3zv/zGkEy/aimJ1a8an2DE+Q/azu
	8nVaJGNeTzUwILxaoDC+dBuEZ9Ji5rab+VSDicJ6dKCxBnd5JZDyfbz7o7TiMw==
X-Gm-Gg: ASbGncuYX9DLZIZZKOqL9IWIw8cSHmRCI5//CD2wb/DhnlPjh19T9KjrGze2W6QOxqa
	8wimfhNmWu0UUHwS6w/EG9+dbrxS6mfN40HAZjA9E8iloUcLzzDZFyYpmBGxTfDVwfkn3k4I/2o
	Dj5PBux6n9GXm3qlNPHWoMSfn34xupjfJrTeqBJhzBegHcQjjHcNLzCGbHOe+MP88Todr0m+grA
	eKkiyg53BpJRZMZg4KvibQpbm8tMKlNUuHQQ1y8RbYYXYqG73umjL5UX6x0M5R7EIq/Zt6/pQv5
	rF7QPbFIp0MVBNqkBzB6Ov6vtlEMjaTycDzPpo7y4bxtOf68+sLTNCzeS9YHAAwckkPCssSLx0a
	yjd5G9tSs5fjBnrTXyBLpZm/pUQ==
X-Google-Smtp-Source: AGHT+IHG0wRUsMbBlyzZoi7Kf2DLfCX/7vIL2lMiJpAFgkY9EoR9u5cB09z2MVs3yAQX63J30qvH2Q==
X-Received: by 2002:a05:6214:2267:b0:6fd:1b17:fb7 with SMTP id 6a1803df08f44-702c6d7ae90mr162340326d6.31.1751844014728;
        Sun, 06 Jul 2025 16:20:14 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:934a:8cb5:107d:e42b:6887])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d50947sm49891716d6.78.2025.07.06.16.20.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Jul 2025 16:20:14 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v3 3/5] repo-info: add the field references.format
Date: Sun,  6 Jul 2025 20:19:36 -0300
Message-Id: <20250706231938.16113-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250706231938.16113-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250706231938.16113-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduce the new command
git-repo-info.

The flag `--show-ref-format` from git-rev-parse is used for retrieving
the reference format (i.e. `files` or `reftable`). This way, it is
used for querying repository information, fitting in the purpose of
git-repo-info.

Then, add a new field `references.format` to the repo-info command
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo-info.adoc |   4 ++
 builtin/repo-info.c              | 105 ++++++++++++++++++++++++++++++-
 t/meson.build                    |   1 +
 t/t1900-repo-info.sh             |  64 +++++++++++++++++++
 4 files changed, 171 insertions(+), 3 deletions(-)
 create mode 100755 t/t1900-repo-info.sh

diff --git a/Documentation/git-repo-info.adoc b/Documentation/git-repo-info.adoc
index bf1d391482..dd221b236e 100644
--- a/Documentation/git-repo-info.adoc
+++ b/Documentation/git-repo-info.adoc
@@ -66,6 +66,10 @@ CATEGORIES AND FIELDS
 The set of data that `git repo-info` can return is divided into
 categories. Each category is composed by one or more fields.
 
+`references`::
+Reference-related data:
+* `format`: the reference storage format, either `files` or `reftable`.
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index cb4785169f..98a0d83d51 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -1,20 +1,39 @@
 #include "builtin.h"
 #include "json-writer.h"
 #include "parse-options.h"
+#include "refs.h"
 
 enum output_format {
 	FORMAT_JSON,
 	FORMAT_NULL_TERMINATED,
 };
 
+enum repo_info_category {
+	CATEGORY_REFERENCES = 1 << 0,
+};
+
+enum repo_info_references_field {
+	FIELD_REFERENCES_FORMAT = 1 << 0,
+};
+
+struct repo_info_field {
+	enum repo_info_category category;
+	union {
+		enum repo_info_references_field references;
+	} u;
+};
+
 struct repo_info {
 	struct repository *repo;
 	enum output_format format;
+	size_t fields_nr;
+	struct repo_info_field *fields;
 };
 
 static void repo_info_init(struct repo_info *repo_info,
 			   struct repository *repo,
-			   const char *format)
+			   const char *format,
+			   int argc, const char **argv)
 {
 	repo_info->repo = repo;
 
@@ -24,15 +43,93 @@ static void repo_info_init(struct repo_info *repo_info,
 		repo_info->format = FORMAT_NULL_TERMINATED;
 	else
 		die("invalid format %s", format);
+
+	repo_info->fields_nr = argc;
+	ALLOC_ARRAY(repo_info->fields, argc);
+
+	for (int i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		struct repo_info_field *field = repo_info->fields + i;
+		if (!strcmp(arg, "references.format")) {
+			field->category = CATEGORY_REFERENCES;
+			field->u.references = FIELD_REFERENCES_FORMAT;
+		} else {
+			die("invalid field '%s'", arg);
+		}
+	}
+}
+
+static void repo_info_release(struct repo_info *repo_info)
+{
+	free(repo_info->fields);
 }
 
-static void repo_info_print_json(struct repo_info *repo_info UNUSED)
+static void append_null_terminated_field(struct strbuf *buf,
+					 struct repo_info *repo_info,
+					 struct repo_info_field *field)
+{
+	struct repository *repo = repo_info->repo;
+
+	switch (field->category) {
+	case CATEGORY_REFERENCES:
+		strbuf_addstr(buf, "references.");
+		switch (field->u.references) {
+		case FIELD_REFERENCES_FORMAT:
+			strbuf_addstr(buf, "format\n");
+			strbuf_addstr(buf, ref_storage_format_to_name(
+						   repo->ref_storage_format));
+			break;
+		}
+		break;
+	}
+
+	strbuf_addch(buf, '\0');
+}
+
+static void repo_info_print_null_terminated(struct repo_info *repo_info)
+{
+	struct strbuf buf;
+
+	strbuf_init(&buf, 256);
+
+	for (size_t i = 0; i < repo_info->fields_nr; i++) {
+		struct repo_info_field *field = &repo_info->fields[i];
+		append_null_terminated_field(&buf, repo_info, field);
+	}
+
+	fwrite(buf.buf, 1, buf.len, stdout);
+	strbuf_release(&buf);
+}
+
+static void repo_info_print_json(struct repo_info *repo_info)
 {
 	struct json_writer jw;
+	unsigned int categories = 0;
+	unsigned int references_fields = 0;
+	struct repository *repo = repo_info->repo;
+
+	for (size_t i = 0; i < repo_info->fields_nr; i++) {
+		struct repo_info_field *field = repo_info->fields + i;
+		categories |= field->category;
+		switch (field->category) {
+		case CATEGORY_REFERENCES:
+			references_fields |= field->u.references;
+			break;
+		}
+	}
 
 	jw_init(&jw);
 
 	jw_object_begin(&jw, 1);
+	if (categories & CATEGORY_REFERENCES) {
+		jw_object_inline_begin_object(&jw, "references");
+		if (references_fields & FIELD_REFERENCES_FORMAT) {
+			const char *format_name = ref_storage_format_to_name(
+				repo->ref_storage_format);
+			jw_object_string(&jw, "format", format_name);
+		}
+		jw_end(&jw);
+	}
 	jw_end(&jw);
 
 	puts(jw.json.buf);
@@ -46,6 +143,7 @@ static void repo_info_print(struct repo_info *repo_info)
 		repo_info_print_json(repo_info);
 		break;
 	case FORMAT_NULL_TERMINATED:
+		repo_info_print_null_terminated(repo_info);
 		break;
 	default:
 		BUG("%d: not a valid repo-info format", repo_info->format);
@@ -71,8 +169,9 @@ int cmd_repo_info(int argc,
 
 	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
 			     0);
-	repo_info_init(&repo_info, repo, format);
+	repo_info_init(&repo_info, repo, format, argc, argv);
 	repo_info_print(&repo_info);
+	repo_info_release(&repo_info);
 
 	return 0;
 }
diff --git a/t/meson.build b/t/meson.build
index 6d7fe6b117..e2c9393189 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -245,6 +245,7 @@ integration_tests = [
   't1700-split-index.sh',
   't1701-racy-split-index.sh',
   't1800-hook.sh',
+  't1900-repo-info.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
   't2003-checkout-cache-mkdir.sh',
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
new file mode 100755
index 0000000000..2af9d1d9c3
--- /dev/null
+++ b/t/t1900-repo-info.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='test git repo-info'
+
+. ./test-lib.sh
+
+parse_json () {
+	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
+}
+
+test_lazy_prereq PERLJSON '
+	perl -MJSON -e "exit 0"
+'
+
+# Test if a field is correctly returned in both null-terminated and json formats.
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
+        label=$1
+        init_command=$2
+        key=$3
+        expected_value=$4
+
+        test_expect_success PERLJSON "json: $label" '
+		test_when_finished "rm -rf repo" &&
+		eval "$init_command" &&
+		echo "$expected_value" >expect &&
+		git -C repo repo-info "$key" >output &&
+		parse_json <output >parsed &&
+		grep -F "row[0].$key" parsed | cut -d " " -f 2 >value &&
+		sed -n -e "/row[0].$key/{
+			s/^[^ ]* //
+			s/^1\$/true/
+			s/^0\$/false/
+			p;
+			}" parsed >actual &&
+		sed "s/^0$/false/" <value| sed "s/^1$/true/" >actual &&
+		test_cmp expect actual
+        '
+
+        test_expect_success "null-terminated: $label" '
+		test_when_finished "rm -rf repo" &&
+		eval "$init_command" &&
+		echo "$expected_value" | lf_to_nul >expect &&
+		git -C repo repo-info --format=null-terminated "$key" >output &&
+		tail -n 1 output >actual &&
+		test_cmp expect actual
+	'
+}
+
+test_repo_info 'ref format files is retrieved correctly' '
+	git init --ref-format=files repo' 'references.format' 'files'
+
+test_repo_info 'ref format reftable is retrieved correctly' '
+	git init --ref-format=reftable repo' 'references.format' 'reftable'
+
+test_done
-- 
2.39.5 (Apple Git-154)

