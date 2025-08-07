Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DC1758B
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579048; cv=none; b=KunEuHETp4vd9+mCJgdSnISSe7TGLc/5LTbyWbM2V8WsoOq0ObTL+XBeRMrIb5mvGdK5Thi/YoAiLqao7nnTax7jevDNVlWeZdquTZKdb/Id8o9/Ro36BbF7PNYR6SovKhCJ7ZcP2EjVrKrmrwJdf9wTcZTRXU3s39BTjL7Tfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579048; c=relaxed/simple;
	bh=3XsfXHXeukMyb21p10RlweDMoJHgVwBjpWxTrm3cITk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RU6zf/Jy7tAyzeQMrO1QopGp1KMy9ncdb88R6Oo++fNPHC/pahQV6E4fyIOEfXNvIfwDvVZD5U+K74N37o1oQZN37zY98VTekyOAapWrbNb75v0LihLgaGo332+YESVvPmWTy7i5A4ETwRvAY0NRuG2q8iXNZwg7gowUQIRU9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVqFmz20; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVqFmz20"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b422b31b1c0so668551a12.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754579046; x=1755183846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSGJmUE/stGU5wI0J3gzdYD9PMXqbGikbLq5BVChd6s=;
        b=QVqFmz20YP8GaZtLtkDqcas/liSQgFyzT3u6jxvDc7s6PbhUUCRhprXPDESTPuZidk
         Spvqa0HaI1A2y7qNoNalkaA9MMso5ZUwNrjmO/Q1g8dqcPmss7ykdDi6kSdxufLxm42O
         BNAponwq8wrq9Zl538m+4Wnmxw/mmegp1I3/qwM/me3J9c8Mf1grxxhl+xALfsXPSWiJ
         a2/PrXipc1xwDwUTwHQP4OtZKdXgXUsDNxetTfDtGpNg+5uBrSLr1RyCPGmXQXO8l7C1
         74Cw94VCjW3PXkqp+CevORpg/pgQAZD/oBwRLxIIcdzh9L29ppQs/xbzAFPwL0xf/eQG
         6Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579046; x=1755183846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSGJmUE/stGU5wI0J3gzdYD9PMXqbGikbLq5BVChd6s=;
        b=dufpqYj9QxpI0yEHgKok1QShZMWGo61awtcPXha3sZc5wKiXc8lzHrgc75iJfGTeRM
         ZVtUV1XFmefM3EhtVdvEG3VfTnHLHlv19ffilJDAcp1OEZI9m9djx7p2BBQPQocwwxJq
         zIgc9Oak7Ys+p1T2M2AhErpa9QXW69HdgAw/rySTtIsZUKsp+uknkLI3vuFAA1ReAqdE
         TZyEHfL+S/ZmU8YBsn7t043o5rwyQzRkuJaOoVn3lCXGsQVjZGd7pgUq6Jzz+Pzyhlz0
         C0p1SOaqAd9jCYahwnj9PnVIol/9n+0ORDTseLi7+u1HB8Pey3WbOMZJjalmHjYwn9l0
         6dSQ==
X-Gm-Message-State: AOJu0YxF3+j7TnoWcVlMZySLE8+X+Oo/sqTTL/Fmu/ru9XlZHNOE0+U0
	5KsCZrbQVGtcFQL22LBbt2te5iBrLQWbD16R3ZCPMJ0omxPe2bkh/koNKNAWNQ==
X-Gm-Gg: ASbGncscqB8TAPjLF6L56ZY5uqTwBrBuEJ8GuBHI8S4IQNlTmGSDYI60J1R81AW7B8D
	KSwZzTc3VWw9Rw/q2SLua0d8UxuheY8jLWtanD6hyeWSRAvWjXwqjQxqCS50Bit0+e9w0q4wgi2
	SZk+N4kfeIOG4bPZlSAjDsV4Q0ooiR+Kxx+uMcPRt2hBpN40o3MPEQ4pZT1ztEyOnjk8CrDmZrl
	0SZZZyUZ0JgGKrllDXZkd+5kCsvH+YAI432eRMyDtglgneH8U9ohPe25tchceSvXK4hK+UnUOoA
	2+LypzTWiZEIexwc1shuygtf7u0OH6xym7k8cCgQnTAss1ezzCJbxUbldYm2Oo/QGygM6O6YBD5
	9Q0Gh+T8HYjNlp2wxbFbBxx/m/fVYFfFG1m5WB2TY8utUcKiZ8vGdU5sVWuvdGQ==
X-Google-Smtp-Source: AGHT+IGmXTzXeUqyyfCVqK/nc90qTWl1WxKt2sbm4Zh7C+Q0hzfuS5K21nS0CAFG0uTlwT1q8XLH+w==
X-Received: by 2002:a17:903:2a83:b0:240:70d4:85d9 with SMTP id d9443c01a7336-2429edeedc7mr98184955ad.0.1754579043884;
        Thu, 07 Aug 2025 08:04:03 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8359:45d5:14c8:c621:17ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm106617065ad.54.2025.08.07.08.04.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 08:04:03 -0700 (PDT)
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
Subject: [GSoC PATCH v9 2/5] repo: add the field references.format
Date: Thu,  7 Aug 2025 12:02:36 -0300
Message-Id: <20250807150239.6987-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250807150239.6987-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
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
index 0000000000..2b2516dbae
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

