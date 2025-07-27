Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A2221DBA
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638710; cv=none; b=Xrk8Mem3piXDEMq2M63eLnPylztSuC7cJzjTOVgQrrbn/TKjhQ0ZbbedCmYd9GMc1Cq4ZMx283zr5RHpzVfHU4Piyq7V/RKEzKmF5kWl0xicPgSPSrhSvcOLOIgo1Yke6ufRwLH+Z+jIdw09TGHNc/lqq04ZdKr8vU0VMZS6Lys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638710; c=relaxed/simple;
	bh=9ZJI4vc/z+QmAFlwPHYSYH3mcxQiSa1C02P7Q5Cngvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UzMbd+2obKFYciTN5PdS4zBe7hIcwLTSeB4NCLVFlSRijxeX2RkhZpsnRwIj3l6B32XDgCCMo0/De4ng339jAiuDhCwjMnvMKnfcPYBcVBkzRSZIy19/hB8n6M4ekyCFug2NegSBBe3W2MKMyA5FzsSKCh2Nyj+94wJ31DG34mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzlQxw/L; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzlQxw/L"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31efefd2655so16103a91.0
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753638708; x=1754243508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4i4V8uknGz34o+Hq1DeWNP/O8fKGoK4kW2C7w9UouRg=;
        b=CzlQxw/LDWdsXbMA/AEoXJQdP9s0PtDCNxXSHuTCHV0aKUzjbqGW++AEKdfxHdXO6H
         wSFuobnr1iTZvJ+T7SbY3DI192ur8+WfN9dm9XgP2fTI2M5VPMD52D1MVbnIjT5lwI9f
         LNK1qs1O1N7awZ27ARfKlOQlCObzAXfKxLNALeD4kwJr1XQF2/jmP0hefBlk8XdwOoQw
         twDTD6WojmgVyC4Zegn+UJs9mdLa7c6hVwWTw7KCQcx6RUgbAuhq/cCjFGLgKkVAJv+v
         xA1YJ/Ud+XQFp+Eatt83JzQSp+yWhhF/6+329Sm65OEuglv7GupLnXlgK+UIJEpan7ov
         ugJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638708; x=1754243508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4i4V8uknGz34o+Hq1DeWNP/O8fKGoK4kW2C7w9UouRg=;
        b=pzi3zh+71Zxa3C4ZAAuvaJFtNMehUmMj1jsZXbIlFVeHOxrJJGk6IF/np1elSUvFuV
         Srn2oPciBYosFcMBuFJKYZPMy1NgjDB86+l+qHs//Lf+YAx3/bxw3tE33L7iAT1d63C7
         zNqOiq6Fa/jTkLxKqQ1wzZTviW91lbZ+Oc/scoSdv6FeuHOxUAU/MK1BOXFhLlIBepdl
         X8oVGEHzHj2oTjcX4am2Xmt/ChUZOb8MpGBpplnr6PNSWaCtapEK1gYifpvmN+V3kCYv
         6wQEQ5uezehjCB5e+4pAW0l3u991j/WX1hffLBWC1T4eNLwkMu95bORqSwhuVRNTH4gI
         MtUg==
X-Gm-Message-State: AOJu0YwxEqcpzGBf7nm69wF45vDOLeF73JARCeUgm0fhCRZuvtBhnBVy
	7Fuzb4XqFQRBFBTRhuJnmOfUJ3dQyAI2S6jJ6MRgLZrZn5QHMI54covDOWANFw==
X-Gm-Gg: ASbGncuX6HHbi8RkD4wS2GOC/3S3I93ZBIKgwYKsMy70hUn8DQKMq+rhueZhhK5xhj1
	uymSuXt10A0vZTBcGmG6TYVOEIVyJsvEjlA8jI5VhgmCbx2YRgEAu0rP5JSO0Qz5piiidiH2b0m
	X/cle8DmtknBcAm5QP3FLyyaF4EXUJD53TS6ESCn36k+4qLTCz2wGM42th+VyaNbXJUMxEE+40m
	zhvnYmTosCT/5TM57wrgSHH8JagebFffjdoH1ioYtvtsIHsP+uFLccC6bIBTQjz7I4Lf52D8c23
	nXzlbC0VEkDngvyLky/D1CgjuSt9EKIUO/kPOXt/kzPWk/95+d/m3s+CTRl2OYQIfws3fWCQouq
	TrE4PHe6peDroihcY2DJXQFnPTt41I0XwRonswRSbwMghk3cZxsMhhW5I/GpIbISeRtNzflqEmt
	/GOWQhuZpLQjBriBU+Fbj3uw==
X-Google-Smtp-Source: AGHT+IFHi5aO10ZD3O27l8Gy1i1CuCrnL8jgLL5ceJndR69t7zIVPIY0bt0O8jS3rbQo0/N7ppwlOQ==
X-Received: by 2002:a17:90a:dfc3:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-31e76693629mr13577716a91.13.1753638707711;
        Sun, 27 Jul 2025 10:51:47 -0700 (PDT)
Received: from localhost.localdomain (201-1-210-243.dsl.telesp.net.br. [201.1.210.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58bec0sm3392488a12.17.2025.07.27.10.51.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 10:51:47 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	jn.avila@free.fr,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v5 2/5] repo: add the field references.format
Date: Sun, 27 Jul 2025 14:51:07 -0300
Message-Id: <20250727175110.84770-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250727175110.84770-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduces the new subcommand
git-repo-info.

The flag `--show-ref-format` from git-rev-parse is used for retrieving
the reference format (i.e. `files` or `reftable`). This way, it is
used for querying repository metadata, fitting in the purpose of
git-repo-info.

Add a new field `references.format` to the repo-info subcommand
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  4 ++
 builtin/repo.c              | 82 ++++++++++++++++++++++++++++++++++++-
 t/meson.build               |  1 +
 t/t1900-repo.sh             | 57 ++++++++++++++++++++++++++
 4 files changed, 142 insertions(+), 2 deletions(-)
 create mode 100755 t/t1900-repo.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index aca76b131b..ac2578299f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -29,6 +29,10 @@ INFO KEYS
 The set of data that `git repo` can return is grouped into the following
 categories:
 
+`references`::
+Reference-related data:
+* `format`: the reference storage format
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index d4f01e35e2..02d5821c77 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,12 +1,90 @@
 #include "builtin.h"
 #include "parse-options.h"
+#include "refs.h"
+#include "strbuf.h"
 
-static int repo_info(int argc UNUSED, const char **argv UNUSED,
-		     const char *prefix UNUSED, struct repository *repo UNUSED)
+typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
+
+struct field {
+	const char *key;
+	get_value_fn *get_value;
+};
+
+static int get_references_format(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf,
+		      ref_storage_format_to_name(repo->ref_storage_format));
+	return 0;
+}
+
+/* repo_info_fields keys should be in lexicographical order */
+static const struct field repo_info_fields[] = {
+	{ "references.format", get_references_format },
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
+static get_value_fn *get_value_fn_for_key(const char *key)
+{
+	const struct field search_key = { key, NULL };
+	const struct field *found = bsearch(&search_key, repo_info_fields,
+					    ARRAY_SIZE(repo_info_fields),
+					    sizeof(*found),
+					    repo_info_fields_cmp);
+	return found ? found->get_value : NULL;
+}
+
+static int qsort_strcmp(const void *va, const void *vb)
 {
+	const char *a = *(const char **)va;
+	const char *b = *(const char **)vb;
+
+	return strcmp(a, b);
+}
+
+static int print_fields(int argc, const char **argv, struct repository *repo)
+{
+	const char *last = "";
+
+	QSORT(argv, argc, qsort_strcmp);
+
+	for (int i = 0; i < argc; i++) {
+		get_value_fn *get_value;
+		const char *key = argv[i];
+		struct strbuf value;
+
+		if (!strcmp(key, last))
+			continue;
+
+		strbuf_init(&value, 64);
+		get_value = get_value_fn_for_key(key);
+
+		if (!get_value) {
+			strbuf_release(&value);
+			return error(_("key '%s' not found"), key);
+		}
+
+		get_value(repo, &value);
+		printf("%s=%s\n", key, value.buf);
+		last = key;
+		strbuf_release(&value);
+	}
+
 	return 0;
 }
 
+static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
+		     struct repository *repo)
+{
+	return print_fields(argc - 1, argv + 1, repo);
+}
+
 int cmd_repo(int argc, const char **argv, const char *prefix,
 	     struct repository *repo)
 {
diff --git a/t/meson.build b/t/meson.build
index 660d780dcc..5de9c3c7e9 100644
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
index 0000000000..cc54b0644d
--- /dev/null
+++ b/t/t1900-repo.sh
@@ -0,0 +1,57 @@
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
+		echo "$expected_value" >expected &&
+		git -C repo repo info "$key" >output &&
+		cut -d "=" -f 2 <output >actual &&
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
+test_expect_success 'git-repo-info aborts if an invalid key is requested' '
+	test_when_finished "rm -rf expected err" &&
+	echo "error: key '\'foo\'' not found" >expected &&
+	test_must_fail git repo info foo 2>err &&
+	test_cmp expected err
+'
+
+test_expect_success "only one value is returned if the same key is requested twice" '
+	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
+	echo "references.format" >expected_key &&
+	git rev-parse --show-ref-format >expected_value &&
+	git repo info references.format references.format >output &&
+	cut -d "=" -f 1 <output >actual_key &&
+	cut -d "=" -f 2 <output >actual_value &&
+        test_cmp expected_key actual_key &&
+        test_cmp expected_value actual_value
+'
+
+test_done
-- 
2.39.5 (Apple Git-154)

