Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7C23D7CE
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755384401; cv=none; b=Qzj2QmXyXcJo1fJXpB67Z8y7DYH52wnDdO1JdGNjCS0nn+uWfUkk77i6HmHFvO0JCc15Ov+PNgei3906S2svxczrPssChg9AYVlbj5nJAidF89EQS6XvdLmfQLEmSM4kKhVaX2ARD5i7f7dK+LRHg/kMxmbfcN3+nm/joT/nm/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755384401; c=relaxed/simple;
	bh=0VSfnYtwFWENO25ShCI7oG3U5mU+/hLRZOk0erkFkug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TtAH+ULtlOaRRzXlngLcyhcIKqKV8EKU1yB8XI3YOC4KII8aFqVjIMrdjIYWYds0QnndUjSVHdyPh2FKh64hgk4jGjbUylpEoUWrBZpuqvUsey94Md1u5M2/D2ZqkKxHkJQXAiS7GcyMuXpwOE3arcd/gGGHVnzgtUhOTKzzPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFeuRrVU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFeuRrVU"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e60433eso2281013b3a.0
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755384397; x=1755989197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY38uW+ZsF7xyqZlehV4EYriSOfZSwNscD3IGHdEqo0=;
        b=BFeuRrVUeK7Qt62dIQJ9hqkxTsL3iv4Xt75MqAejZz/gRT4CEvmQSpKmb0KvqgRtzW
         ZMrnKdy7fcMIiLQNOFUabFjH+ryqqoyllTwBP4+eULBvoYiN49jPIE+9FO4mlJ4A1KVw
         IMR68FEO7zE7W/tcB3ZFIA5UtM8FUgSfPzcrf6gLX081hNLOXDEtqoHQwZ/0WakuCI5y
         eIo9Ks+OjBL/K+IvEUankKpsStrG3E3WKgwyYlNlyWQP4h7LBVrAgv5/qp9N4Gz2kysr
         bVM16oxM8SvGl+CmmVCJqxEL36qU/p+c8zF7v01GOzxYGdcSdnl06T+5ylQgEfeAKJDO
         EkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755384397; x=1755989197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY38uW+ZsF7xyqZlehV4EYriSOfZSwNscD3IGHdEqo0=;
        b=E1rPo6CgEMnaoSUJr0oERNmUkmff8r515T+LEGcRUjNatGUewgElh4JBt9rr7zF2si
         XpKP9Yhy5ay3m8SSmF4BCdd0QARFtJZuB1ohWCmUVMSzvtLTkqUb0V7IKCkEH/s/9ZDE
         Wjejl1QMcEYN/ohZwEhCqnViUAosRp5jD8nsD5DHwn6nRjrkR6GFvP3JyV1t6LKhoCXH
         DKmM8qYZbJ3XeCVYtsicVna4QKx2Fp59zkxKaHYXD5UOHlEwVK7dPeO8F03FIRVViiZf
         3LLHMLMM2U+MsQ1pKSsJzLq+nzuAgJJjcYSlNs2D7T/OWqAq1Jy5UyS7WxZA36QPNqHt
         bnJw==
X-Gm-Message-State: AOJu0YyledYS3aSDgAGbQffun6f+atbA3ZyT7cBJhnnzmTdNuCR73i8a
	SdjrWcEs9hJr+CbP5QXSLqElW/fiRI0lE/tbeqMvrdSnpMkblnIV26HsT15ZfQ==
X-Gm-Gg: ASbGncsB4u3jThIYjaxRFGaOjnPGxR+RnLd8sbOkFlf97ovoUcxLxt3P9SdsaOc+IGd
	Xf0xJd7EdmQDO29rc4hMwyvgI+eswJsQtjQfscP54ns4bRcM2aHkBEl0LUnvaH+xYwKXRBG23sS
	O2tSs67vEBTEhNcgDOgy1oKfBPUbQzvWjp/z75OA0hmB9y7sWEiQgPq0hRAdBeY7Lm03OhbQA1Q
	u+cJjTseJLC95QzjPxn92qcau52OwEn3uIgTttv43CGmXedW+u97hAo+L5uFZoLGKPEP3soohhL
	PfnhhJr7w3fu06/Q5O9XcF6zMBI7ahjuKTvDkWItnzVjiiEqLkomIbQgrt8cg8HdlLud2ck743w
	C8Nm6mOsT9NNeQz8fkKza16lTlH1mg9Cfj5lOGa+L2xlEs1/kPTYJFwoagnrL2Q==
X-Google-Smtp-Source: AGHT+IF0TCkVsPyu30AnerEJ/xvE/1+bhv0op5oj4SP9kz8G/ZYP4snxVcQcgNxountzZEvP5Beoxg==
X-Received: by 2002:a05:6a21:328d:b0:240:1204:dd2 with SMTP id adf61e73a8af0-240d2ec5696mr9503973637.26.1755384397509;
        Sat, 16 Aug 2025 15:46:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:e855:1cad:1392:e988])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5ad0f7sm4617280a12.2.2025.08.16.15.46.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 16 Aug 2025 15:46:37 -0700 (PDT)
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
	sunshine@sunshineco.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v11 2/5] repo: add the field references.format
Date: Sat, 16 Aug 2025 19:46:00 -0300
Message-Id: <20250816224603.3307-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250816224603.3307-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250816224603.3307-1-lucasseikioshiro@gmail.com>
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
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 20 ++++++++++
 builtin/repo.c              | 74 ++++++++++++++++++++++++++++++++++++-
 t/meson.build               |  1 +
 t/t1900-repo.sh             | 53 ++++++++++++++++++++++++++
 4 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100755 t/t1900-repo.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 68c706f5a0..2779a6d995 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -22,6 +22,26 @@ COMMANDS
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
++
+The values are returned in the same order in which their respective keys were
+requested.
++
+The output format consists of key-value pairs one per line using the `=`
+character as the delimiter between the key and the value. Values containing
+"unusual" characters are quoted as explained for the configuration variable
+`core.quotePath` (see linkgit:git-config[1]).
+
+INFO KEYS
+---------
+
+In order to obtain a set of values from `git repo info`, you should provide
+the keys that identify them. Here's a list of the available keys and the
+values that they return:
+
+`references.format`::
+	The reference storage format. The valid values are:
++
+include::ref-storage-format.adoc[]
 
 SEE ALSO
 --------
diff --git a/builtin/repo.c b/builtin/repo.c
index fd2a9b4216..73d4e27a16 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,17 +1,87 @@
 #include "builtin.h"
 #include "parse-options.h"
+#include "quote.h"
+#include "refs.h"
+#include "strbuf.h"
 
 static const char *const repo_usage[] = {
 	"git repo info [<key>...]",
 	NULL
 };
 
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
 {
+	strbuf_addstr(buf,
+		      ref_storage_format_to_name(repo->ref_storage_format));
 	return 0;
 }
 
+/* repo_info_fields keys must be in lexicographical order */
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
+static int print_fields(int argc, const char **argv, struct repository *repo)
+{
+	int ret = 0;
+	struct strbuf valbuf = STRBUF_INIT;
+	struct strbuf quotbuf = STRBUF_INIT;
+
+	for (int i = 0; i < argc; i++) {
+		get_value_fn *get_value;
+		const char *key = argv[i];
+
+		get_value = get_value_fn_for_key(key);
+
+		if (!get_value) {
+			ret = error(_("key '%s' not found"), key);
+			continue;
+		}
+
+		strbuf_reset(&valbuf);
+		strbuf_reset(&quotbuf);
+
+		get_value(repo, &valbuf);
+		quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
+		printf("%s=%s\n", key, quotbuf.buf);
+	}
+
+	strbuf_release(&valbuf);
+	strbuf_release(&quotbuf);
+	return ret;
+}
+
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
index 983245501c..7555d52917 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -231,6 +231,7 @@ integration_tests = [
   't1700-split-index.sh',
   't1701-racy-split-index.sh',
   't1800-hook.sh',
+  't1900-repo.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
   't2003-checkout-cache-mkdir.sh',
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
new file mode 100755
index 0000000000..be8a4b2499
--- /dev/null
+++ b/t/t1900-repo.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description='test git repo-info'
+
+. ./test-lib.sh
+
+# Test whether a key-value pair is correctly returned
+#
+# Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
+#
+# Arguments:
+#   label: the label of the test
+#   init_command: a command which creates a repository
+#   repo_name: the name of the repository that will be created in init_command
+#   key: the key of the field that is being tested
+#   expected_value: the value that the field should contain
+test_repo_info () {
+	label=$1
+	init_command=$2
+	repo_name=$3
+	key=$4
+	expected_value=$5
+
+	test_expect_success "setup: $label" '
+		eval "$init_command $repo_name"
+	'
+
+	test_expect_success "$label" '
+		echo "$key=$expected_value" >expect &&
+		git -C $repo_name repo info "$key" >actual &&
+		test_cmp expect actual
+	'
+}
+
+test_repo_info 'ref format files is retrieved correctly' \
+	'git init --ref-format=files' 'format-files' 'references.format' 'files'
+
+test_repo_info 'ref format reftable is retrieved correctly' \
+	'git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
+
+test_expect_success 'git-repo-info fails if an invalid key is requested' '
+	echo "error: key ${SQ}foo${SQ} not found" >expect &&
+	test_must_fail git repo info foo 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-repo-info outputs data even if there is an invalid field' '
+	echo "references.format=$(test_detect_ref_format)" >expect &&
+	test_must_fail git repo info foo references.format bar >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.39.5 (Apple Git-154)

