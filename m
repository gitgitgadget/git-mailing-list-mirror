Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A32472BF
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053892; cv=none; b=qF0RSb6LVdYgpVPZCnGza5Fapfi8uxHcG7uYIVpBzL0D2n0bxxdrzp/yQxHVyH/M3Rs2HoyX1u5yhhPfjTcRX6ro9k9JEYZlaHbpzjz4THPC0xfkffzINqZj2BqPRODEkqzrbrHB3zFymcXq5lXACDUBidf9pi46avwEgsPJas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053892; c=relaxed/simple;
	bh=X2GVO9BLW0W/SLvmhu/la+TfWXwAjfI+p0+etxYWvlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VVxjmPRlnxMtvXGt9w5cnSJtqxMd1PosJl0z7ily10AaIAXgH7GPIJ04KnP+5noRzio/wbdBhxTjCFqxnHsuHIWYFgO6OskOUbB6cQTD3+0gNBAb3fZta+byv60g3iEgzqhCVX1L+b/UFbjF+S6U85TUyb274oLSAy6lyjEkNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/21LBqX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/21LBqX"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31efefd2655so1571872a91.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754053889; x=1754658689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OolYEos8gD1WJJN2qCKvCtbSGQB/qOg+TUuDqz043Zk=;
        b=X/21LBqXawRqdgpC+kx3/TWkTgSqLs23wIdIYmfK2Z6eZgHKDcgT0LjcPAWEDt7BPO
         PovZelkvYBcxVEPTyV0Z+LS856mC3Bdii5a+2Pa5AmnKFeAqVRe/TwMiWsk9anejSnYM
         yZHoNEvjMLw3hGB59oLMHGR0N1DyOPzUpzF2IyOLkQWfx0OTm5IwHF7GlHZHa4YR+gC+
         BZW7E8ypwCB8x+y9w9/crM/3Duz5RHge+zHozfB08eN0u9EGXP6R0fsncNFxFhvPHBkf
         ljl7kBpia+dObUDbR8SH/IXMUSd2GRUUETlniBQ4VPiePs8+Dx/Zc0LROwHMAF6bhEYa
         Jkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053889; x=1754658689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OolYEos8gD1WJJN2qCKvCtbSGQB/qOg+TUuDqz043Zk=;
        b=WL+xUbILvQxdSI794gr0vnx9qTX2ZAtBjArxmU0wt+wbm5gcSr3ZOOzGtPq+KTwuiL
         NlPmvZ0W78zgU7lO5JZdjTA4kbuie7rlIaFHBotREuHHuPu+M4K+U59aKrGkyC4ConoV
         pweoMhqo5L6IHvOMatk8Mh+kYsbsxxmbqFTn/S1a+4ox+hLifnSdOPcbpLxtbQ4iO593
         EX5KMrYrx9l42XFgSaeF8wtROaoym5fs1OTjam4qCfYvx+SyRrPsd4/6Q1GhchTsa3S6
         O5vQGvPtmSmeiuot35GCPuOrf3FrCUgx6fk0lQ/teR7c9PPi2yKTq+GSedUWFtvbtr/c
         TG1g==
X-Gm-Message-State: AOJu0YzGNBpqryPsWPJnThCWo1HbrVGtiKfyFjOn/bmP4v0smmqOfwsj
	O+/AEL5jktgMpr8Wrs0COyr2YXWhSJmMhN/4loxVOPxRKclfMnN98QyPjQ2bg3/P
X-Gm-Gg: ASbGncuX3rJcsdpuqMXNBI3i2ECzXjrBj1PHwAh+dqWp92y2QNW4tD9xtdGckIOKrDO
	DgXi+Cj2DDRIjRr6MzvVsHcepjnXZ5KBN4d6MmMC9cDrFz81Kmm2xSLmoKjNOYCg53DwvxX/Ww7
	pI6IQQA6/EEDk0ZqvpqoZljXPolCkdT2zJNGuGXL8dV15L11y2zwVmj2fYf6uVBzAoc0IMtQBXr
	ZpFQAtc68qHEjM02Uw3P/hDg/l9Frcckasr5xsRPf+5thRRdBsMrdVo3CA8FGbgD7BIR6+gMH2B
	NLuK2aE/Beeiw9zXwxmfPI41Rj+cd7U8a/VeizdCnzFYmH7ddzZM694VeVkGik96ShDvRpcu7x+
	2vzsG2pNzKAvRZoZh6bh481KNaH49n55Dn55OZPkXql6owfnyUViTu/DRfiUdDSLeJZ6BFDlmNl
	gJ
X-Google-Smtp-Source: AGHT+IGVqEv0Pj0tBQiI8+tOZJpPTr/n2+mzANayoZW+hF41co4dFWYk6fkt3mRY2LdfGKoobd6tKg==
X-Received: by 2002:a17:90b:1a8d:b0:31f:35f:96a1 with SMTP id 98e67ed59e1d1-320da5e9a19mr8649594a91.15.1754053889193;
        Fri, 01 Aug 2025 06:11:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8c1d:878:ec5d:4583:4785])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7e4fc1sm3542272a12.28.2025.08.01.06.11.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Aug 2025 06:11:28 -0700 (PDT)
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
Subject: [GSoC PATCH v7 2/5] repo: add the field references.format
Date: Fri,  1 Aug 2025 10:11:07 -0300
Message-Id: <20250801131111.8115-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250801131111.8115-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
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
 Documentation/git-repo.adoc | 14 ++++++
 builtin/repo.c              | 90 ++++++++++++++++++++++++++++++++++++-
 t/meson.build               |  1 +
 t/t1900-repo.sh             | 57 +++++++++++++++++++++++
 4 files changed, 160 insertions(+), 2 deletions(-)
 create mode 100755 t/t1900-repo.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 68c706f5a0..2dd130f3dd 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -22,6 +22,20 @@ COMMANDS
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
++
+The returned data is lexicographically sorted by the keys.
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
index fd2a9b4216..6824e50d00 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,17 +1,103 @@
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
+	struct strbuf sb = STRBUF_INIT;
+
+	QSORT(argv, argc, qsort_strcmp);
+
+	for (int i = 0; i < argc; i++) {
+		get_value_fn *get_value;
+		const char *key = argv[i];
+		char *value;
+
+		if (!strcmp(key, last))
+			continue;
+
+		get_value = get_value_fn_for_key(key);
+
+		if (!get_value) {
+			ret = error(_("key '%s' not found"), key);
+			continue;
+		}
+
+		strbuf_reset(&sb);
+		get_value(repo, &sb);
+
+		value = strbuf_detach(&sb, NULL);
+		quote_c_style(value, &sb, NULL, 0);
+		free(value);
+
+		printf("%s=%s\n", key, sb.buf);
+		last = key;
+	}
+
+	strbuf_release(&sb);
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
index 0000000000..9796e36087
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
+#   init command: a command which creates a repository named with its first argument,
+#      accordingly to what is being tested
+#   key: the key of the field that is being tested
+#   expected value: the value that the field should contain
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
+	echo "references.format=files" >expected &&
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

