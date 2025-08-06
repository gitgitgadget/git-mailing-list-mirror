Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1F2BE037
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510168; cv=none; b=ru5ucwYPLoodUrnc57sHJBpA42QUzHt0nljXcn1hfsvPkKLPt6q2ND//DTI3s4QpgTyPRINSE4mUJlIL6MKaT+xGIUCQ8VWo53zIYksVC5OLAbXwOo8Vazh1RMK8hoief3xD9HssBIbmGij26xnrQl/Rsrj3vLyFNtDZRKC4D2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510168; c=relaxed/simple;
	bh=jRkoxic1rZegnN8kD1uLAeC/RRJNNX4GfAz5Gia+i2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MlW4efcP9hj/LlfpGMaPwvVWNdSPwc6pOJiTyvnMXArob4XN+DR0qqS9bCFS8WYePqB6bdqO2HX0/WB9oCmGGWK8O92t1kOKrpyHo10N7NQJAb23lVhzq1FLnjmLiteKGFaRNHuR42C6DFvdLFyt3idcDbyXXSUJOSaU/VB5wn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8dUzG+T; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8dUzG+T"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so363520b3a.2
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754510165; x=1755114965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY97eml95rACRSPeLk37JKqZ2d+6wHVN9Ufs8NsJF+k=;
        b=V8dUzG+Trasfa6EJFRKSGo+Bz7odE2cP/KOSrKRcM6UlG8IFh23VVAhJoY76O9xFhJ
         f4EY7DjkuxGaQqaV5oF9yyJzubBvVg5HmhB61haDnLAHJ6gpM6REk3U8qxRJ6G3bTtzC
         oAGyysLKkRvAnwEb6S5Wl+2TO1Y7f9JI+FBQLFzG1dUqMYxJFrRzOELx266/5Q51VxxP
         fO1bDRHR7PNxZFpB8ewvGjpSU455K37tjP2OXW223HasKj0rZFAUOvzUwDZ91m+5WwAt
         BbW69w6elPL5GkTwQiNfvvKB6MpKrnqAKJVs0JvrhPlcwscityGEQZxnbSBWk5FAz7fZ
         VwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510165; x=1755114965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XY97eml95rACRSPeLk37JKqZ2d+6wHVN9Ufs8NsJF+k=;
        b=osvKYJCbSmh9A4nzKFG+4+jpn6jURWQy0viLW68VHK2mR5MFN6jeuUP2ts3gA/4aRK
         /iDBm4x2fge7DblSyk0RvS7TiCWON/205+U8tL04z1+kogaltcRA3GyerE/Zp324HuUg
         q87vaEFm3J3/d+RQM4dMtZZe2FLr4UPaYxsIgW8jSJDHT8BA79Iw6ozM5DBmAIUexYAJ
         CgIykDcuXYWUjIBSGqZkgfNoUMDRVAuyancAjA4jWaaRqSekuPk8ojaKxugXxGUJDUUz
         a6VKDtP6PNPDUDMg2C+uTjITeMmXGM50xVrPuHyhl/1JKK2dRhhsdvPiYTkncVT9BCtR
         TLuw==
X-Gm-Message-State: AOJu0YyPNUvjdYwdlP6tSFEVFkEbb1/pSoyfJ+6spOQ/F50Vil0vbeld
	bMEKlSvriaMPbWQSvMe0hLV/IY8jNTOlM45Bu10A2GWaMzmSe+EK+YA2qxFogDZ7
X-Gm-Gg: ASbGncvXgkK/8Plqi2MtnkvQOretosoRpX4E10agPKoMaqq6Gch8yZqY4mpFZmq5hK/
	P+E5TXDBwb9FoMLlPv8535gsWXYewrVUtiKJaWEcwYOI/CxUBpY9ZmmCmq7cz8ulNa2MGR2TxGS
	UA/7HEmP0o5FcWH4Pm2Qc7NlguJcx7Swg/iB+lxUIxmfDFZz2U1igRlMGvuG5m74nDkmZnbounW
	50DfLlpmRkne94oFL9eyjfSoFeTC2yJ/Cl4iiAIqAgH1GMBCM3q/YuSbI/CvCbqoDEZEhRmlCXg
	WT8N/Q8LKXWIG0iUuUCQcD4qYwgZQoYpz+td5rISGdHjZqgr5pmbEqR9pxWYNuczVZzbQGNXRkV
	8jGjF6e12OAlZVmsXVcIiOPhdxPxmRv4bZ1meN+NC9bf2UdlLjl8cDcQxWB+OumY=
X-Google-Smtp-Source: AGHT+IG36yjvRp9GXq2VdcooKyC/a+vZawAYs2M4vl+TTcl1pxItFgMQrh9FFf4pPPJmRZya3XE6lg==
X-Received: by 2002:a05:6a20:7fa5:b0:23d:d13d:8a6 with SMTP id adf61e73a8af0-240315111a6mr6691866637.24.1754510165293;
        Wed, 06 Aug 2025 12:56:05 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd026dsm16212400b3a.95.2025.08.06.12.56.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 12:56:04 -0700 (PDT)
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
Subject: [GSoC PATCH v8 2/5] repo: add the field references.format
Date: Wed,  6 Aug 2025 16:55:34 -0300
Message-Id: <20250806195537.93302-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250806195537.93302-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250806195537.93302-1-lucasseikioshiro@gmail.com>
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
 Documentation/git-repo.adoc | 19 ++++++++
 builtin/repo.c              | 89 ++++++++++++++++++++++++++++++++++++-
 t/meson.build               |  1 +
 t/t1900-repo.sh             | 57 ++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 2 deletions(-)
 create mode 100755 t/t1900-repo.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 68c706f5a0..0ee783abc2 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -22,6 +22,25 @@ COMMANDS
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
++
+The returned data is lexicographically sorted by the keys.
++
+The output format consists of key-value pairs one per line using the `=`
+character as the delimiter between the key and the value. Values containing
+"unusual" characters are quoted as explained for the configuration variable
+`core.quotePath` (see linkgit:git-config[1]). This is the default.
+
+INFO KEYS
+---------
+
+In order to obtain a set of values from `git repo info`, you should provide
+the keys that identify them. Here's a list of the available keys and the
+values that they return:
+
+`references.format`::
+The reference storage format. The valid values are:
++
+include::ref-storage-format.adoc[]
 
 SEE ALSO
 --------
diff --git a/builtin/repo.c b/builtin/repo.c
index fd2a9b4216..2b7ab5875e 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,17 +1,102 @@
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
+{
+	const char *a = *(const char **)va;
+	const char *b = *(const char **)vb;
+
+	return strcmp(a, b);
+}
+
+static int print_fields(int argc, const char **argv, struct repository *repo)
+{
+	int ret = 0;
+	const char *last = "";
+	struct strbuf valbuf = STRBUF_INIT;
+	struct strbuf quotbuf = STRBUF_INIT;
+
+	QSORT(argv, argc, qsort_strcmp);
+
+	for (int i = 0; i < argc; i++) {
+		get_value_fn *get_value;
+		const char *key = argv[i];
+
+		strbuf_reset(&valbuf);
+		strbuf_reset(&quotbuf);
+
+		if (!strcmp(key, last))
+			continue;
+
+		last = key;
+		get_value = get_value_fn_for_key(key);
+
+		if (!get_value) {
+			ret = error(_("key '%s' not found"), key);
+			continue;
+		}
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
index bbeba1a8d5..252dbbc031 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -230,6 +230,7 @@ integration_tests = [
   't1700-split-index.sh',
   't1701-racy-split-index.sh',
   't1800-hook.sh',
+  't1900-repo.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
   't2003-checkout-cache-mkdir.sh',
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
new file mode 100755
index 0000000000..ce02b394da
--- /dev/null
+++ b/t/t1900-repo.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+test_description='test git repo-info'
+
+. ./test-lib.sh
+
+# Test whether a key-value pair is correctly returned
+#
+# Usage: test_repo_info <label> <init command> <key> <expected value>
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
+	test_expect_success "$label" '
+		eval "$init_command $repo_name" &&
+		echo "$key=$expected_value" >expected &&
+		git -C $repo_name repo info "$key" >actual &&
+		test_cmp expected actual
+	'
+}
+
+test_repo_info 'ref format files is retrieved correctly' '
+	git init --ref-format=files' 'format-files' 'references.format' 'files'
+
+test_repo_info 'ref format reftable is retrieved correctly' '
+	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
+
+test_expect_success 'git-repo-info fails if an invalid key is requested' '
+	echo "error: key '\'foo\'' not found" >expected_err &&
+	test_must_fail git repo info foo 2>actual_err &&
+	test_cmp expected_err actual_err
+'
+
+test_expect_success 'git-repo-info outputs data even if there is an invalid field' '
+	echo "references.format=$(test_detect_ref_format)" >expected &&
+	test_must_fail git repo info foo references.format bar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'only one value is returned if the same key is requested twice' '
+	val=$(git rev-parse --show-ref-format) &&
+	echo "references.format=$val" >expect &&
+	git repo info references.format references.format >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.39.5 (Apple Git-154)

