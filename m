Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070144315F
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271802; cv=none; b=Uw7QY8vWol5MDQ51VRQX1YRFPOeMJV5dwVQ7zEoSkYfPiZ7NGNNROr1zq8JA1tmDj//2U8djVwgQr9POcDu/lzD5SQyooM5vGonNnFOjroYxS4gysf/qds0n42YYf/K+e8vW3D+mrZ+xuQv/NwpibRtn079DeQ02Xda5KtYKDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271802; c=relaxed/simple;
	bh=g8ANBicDfYXs8DDvMjDJjTb168DZiask86tA9xjTUJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4PCpaYkxMlUT/EbnGwiCfq32Qza118w5JpvDc5TBdPdU16p/iG1CazMB90jsiBezUZdq284RpwVxxWYWCaxA5qQEImGMvqv2qRPvlZW4qqHn5mXm19CSX5zQ5ca+VvciRaSMimTeceGYdyLc53XlwqqkZMPxBl1+IvXwzERy/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXDqnZm3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXDqnZm3"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e5c0d4fso1685755b3a.0
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271800; x=1755876600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZ4YyZh/O5ntiB70qBtJzIYGYPTSP/Y7Fb1aZpM3zRs=;
        b=JXDqnZm3VNtPvkPMq3MnbCgXQDhs1eQwzp3ogIEwUultlmm0wLX5yEwFG1k7u3I3ee
         qaUQNCPgl6kXFGksBqwM/VU5j3E5J93BPYF+mYYJa9HiRLtUeAEmDJT3/LxkN11Jg0uU
         qycoSjfwdKxyxZGz9du8V1jNVjV09LdINuiHS5Pbo2zX5rVswPVegUt8EqTN7bocNaTc
         e/6akQNO5+W3sqHwOvm0Hx9u/aqFPqIBk0n/NAlEkAot1DBWehZuDCjJWsGkbz4ZDJhf
         iHd4unkbHFn14QfRH593WgdSHRzXEmHf3hCrSxyT0qivONjmOY39/vhRufi+u6c+naPw
         z5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271800; x=1755876600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZ4YyZh/O5ntiB70qBtJzIYGYPTSP/Y7Fb1aZpM3zRs=;
        b=k95/F8SSzdr8iY0HvfVdf9iI9keh2tp/v3s+cwb4MCDZOtZKFUTHMPa9W1a+XUyzCs
         icWiiTJ7wk9KhwmD56W6QEZzD+CsPK/jvnYj6NquOLm6pJYpe20BgVX1rplCfrNn+pGL
         jK2E8/yDF1u4Nev2O6VsBAWAvkNMy8/bgdEwLKlv5hmteoHOQq/1PEHp3T86ng25nisH
         dFHGvyfVPOmzEVVinHIVTpSbLnhbXJIeexlmpupVQtS6nZtV8EggsSNq6jb1S9+6GYhv
         JIyNR9Fm4IOw1sqReYitkkejPXVUabeGVW83eybCr9KIAPx3goWZ9+nOmyjDm0vgsW/q
         hzYg==
X-Gm-Message-State: AOJu0YzfY9xjE5pMGdnrMQD9+N0fzC6NPtLeGYooauePx6farxVmgJTD
	9pz67V+00W9yWGd9qzxar0HCqWcNpeyjSu5HHFVOrwrwBmYefo9RTtXhEPQ8kw==
X-Gm-Gg: ASbGncuujbLA9m1U37Cx6tgCADAVUSxj5JEYSrVRTUZQvYre1DNipcPi+8o5IznIn8j
	5XGqbEdF5cVyo8wMqqOwbkaJV7hOgBMx1Qix6tbpGwpqtIX3R1QVvtRO8oKT10SnuKdIpuD8YMj
	kSp+6Rg4XcTiScMwXQB9iOGsTGAGV6Y1kD9IcIvkWEwG5jxdWcwcsjkT8Fv7E1zouc61KiFG4df
	78qxr1LjrPpxrj5IGQVCS5UX6sqn5sorc3epZjAfEzsXJSSpDsKE67fAFYPUp2BkiWR0sR3gjQ4
	ehusME1qjyZDDBK119yDa1Ye6qLQkZfSaoJg86KB54yiDh7zC2IF/1I2bky4vwFSXcqd9qdKDg+
	WcWoHNHpBX1jXJDipHuiOh8JFfSvt5uIFZPO9JrtWKLYt94/Sq8qK2xG6VjFfsg==
X-Google-Smtp-Source: AGHT+IF+EAQIv19LDqVlPh3SoDWU78H3xYns1EaExxIjSAvmz54k9yyNvIs38e3dSmvtUPjbNethuA==
X-Received: by 2002:a05:6a21:9994:b0:23d:ded5:12b9 with SMTP id adf61e73a8af0-240d2f28032mr4463509637.32.1755271800004;
        Fri, 15 Aug 2025 08:30:00 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:7089:f932:3359:f50e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452666besm1393260b3a.1.2025.08.15.08.29.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Aug 2025 08:29:59 -0700 (PDT)
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
Subject: [GSoC PATCH v10 2/5] repo: add the field references.format
Date: Fri, 15 Aug 2025 10:55:18 -0300
Message-Id: <20250815135521.44044-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250815135521.44044-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250815135521.44044-1-lucasseikioshiro@gmail.com>
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
 t/t1900-repo.sh             | 50 +++++++++++++++++++++++++
 4 files changed, 143 insertions(+), 2 deletions(-)
 create mode 100755 t/t1900-repo.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 68c706f5a0..a708c70a3d 100644
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
+The reference storage format. The valid values are:
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
index 0000000000..dca4023a00
--- /dev/null
+++ b/t/t1900-repo.sh
@@ -0,0 +1,50 @@
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
+	test_expect_success "$label" '
+		eval "$init_command $repo_name" &&
+		echo "$key=$expected_value" >expected &&
+		git -C $repo_name repo info "$key" >actual &&
+		test_cmp expected actual
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
+	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
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
+test_done
-- 
2.39.5 (Apple Git-154)

