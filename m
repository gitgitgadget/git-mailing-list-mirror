Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2D2F7445
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856994; cv=none; b=Nm6geQ3L9r+eaOUOgWX6Q6bkZDKG0h0nSz+YugClL9ciQKXtVwc4TmBpIPBxILQ6SGKm7q5/vt2VySjMNrESS0FXiPQOMteYpUJfsMUyza/gwjTP5QwLpATW+FkfrRhiOHrWzTMDSUdZwY/HSGORsRKjE7wEejPUFEr5uipt29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856994; c=relaxed/simple;
	bh=GYske2NCt0aTJY7E+FbejUs7Gsti/jj/jgvazulOcwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkk7/p0bIb29+rfJtvj/phXLohcyf8lBPYaw0rsueZDK9NHFZN4gp+oIy2V1DpKB7VHZgY1M2IO5n4YRdzHmTFZ+uxuqWK/FW1FdpW1PG+OcbuyG3yux0lx/t6purtwy8HK8wE6Co0spJRa2xf804kE3uJEjPoImstQUwB5EvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfjG9Kbp; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfjG9Kbp"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-123320591a4so4601082c88.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768856990; x=1769461790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw+HapQTAg/izr9rDFTUc9DykOKaZvERhiAV72F/cVk=;
        b=ZfjG9KbpFm73ziFJ1uMQ72oYncK+xV7TwXK9ofz2LQ17YmXBnVkfuYTRpXxjVcVdK/
         TBUyKgo35z2g+1Hj6fPbQq8r5WlgXxRtzpk3Tw7e905dolQSsYiqzFNcklmjzr1BJ53d
         1POX/bCjgXlUwRU51B0DIRtRaEDjiKvYajWwW9+ZC4nNH/LkOPohoAwJxhgeH1AS7aUj
         pmXybPlKXD/NDauDys3Poq3pEdojoTx+Tha5nJVduUVRW8O2O9i7Jy/By2W+ons5lXwi
         Sg3tC7SJHyIM4RG6lnSOUjiKCIlRyGGma9JDrtU9Oqc66u9s+yWIMnbSz/6tS+G6mjGj
         CSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768856990; x=1769461790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lw+HapQTAg/izr9rDFTUc9DykOKaZvERhiAV72F/cVk=;
        b=Ro5BmHZXuKpBBIZUXlbm0fuCmdDdKMLgtoPJFTtZiJiehN3p+rHRdaPSG/hoZ0yEwZ
         +qbm1PbMGd5KWQUi2I92VRNsesYbejMLYU66GDQNv9DpYwi+hXYlHG3W9MXrAGUplKqI
         4n7tqURzVi33Vop36ab9w2vQvfvq84P4myRRqKMfsA8g+02LITMaylDNsH7pLdMeng/g
         iHpF2Brf3c9SQMhBt8v8v59Zd3+IAjL682fdwLnZ9K0W3kvgiFRWxeLK5HoN4cHqntfH
         nkjPJp9CmF9pKj8xQM36Lyy8kJtFPUBkpzaRv6xZMThyR7nblYKUcnfkwTcqhGcVH3be
         PQaw==
X-Gm-Message-State: AOJu0YwdFSWbMi3r+V7+S3XKYAH/bWp9BYfPXqPzOxMMAI9dDHw2AGP/
	Z9uL9QG+X6mWz7PvY8ZqOuD38ZJYPjP0UGXAX3YaROVQ2Qt80nVTWSbwrLLycQ==
X-Gm-Gg: AY/fxX6a4QhpAyRsnvBi2znzxToTzhpvHwlJ4cv++KBlDx9CXyRfBzjDxAfYfpeRYJ7
	vhO/mIvuCqC2VeHG0N1f7oSmDEO7AMqXhLWcLLqTvtQyNKhet72WIxdm37Q3kAReFvTjXIWwYn9
	9kgMu5N5v7F+lTBtMjttVZp9GECxSPFCiQQIEeKH1mZm9y87KeB9qu5RaNLug6sh3FcnWvAKdCf
	zjxYwqH6z6zHuEbF7+yN/hgQ94bu37pbdJc7iB6+zAy2M5DHegS7xkq09rxkiIewa+RoRozrVUi
	DPuAoUCQQmSF8jvqlwJrB6XVHXVNIiGrZUzcPSKmlKBxWTDqTth6UAgRtfAZn5LPBwoJjrFp/2F
	jKNNUKR3lXP75pDJshMtr7F1lx+d8IDzCqxjhfuc/qsMqhUdtSkIs7W1culdGF6GL9ue8Z+WYwg
	kLxisi1UMVDlbWWUBWe8RfL4NjuSgYr6nj0VwkJpHWzkGaXiU=
X-Received: by 2002:a05:7022:6b92:b0:11b:9386:a380 with SMTP id a92af1059eb24-1244a790fa0mr10118588c88.47.1768856990021;
        Mon, 19 Jan 2026 13:09:50 -0800 (PST)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac57fd0sm16935706c88.3.2026.01.19.13.09.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jan 2026 13:09:49 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v4 2/2] repo: add new flag --keys to git-repo-info
Date: Mon, 19 Jan 2026 17:20:20 -0300
Message-ID: <20260119210932.68893-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260119210932.68893-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260119210932.68893-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user wants to find what are the available keys, they need to
either check the documentation or to ask for all the key-value pairs
by using --all.

Add a new flag --keys for listing only the available keys without
listing the values.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 14 +++++++++++++
 builtin/repo.c              | 38 +++++++++++++++++++++++++++++++++
 t/t1900-repo.sh             | 42 +++++++++++++++++++++++++++----------
 3 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index fa0e6600af..2472345a7c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]
+git repo info --keys [--format=(default|lines|nul) | -z]
 git repo structure [--format=(default|table|keyvalue|nul) | -z]
 
 DESCRIPTION
@@ -47,6 +48,19 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`info --keys [--format=(default|lines|nul) | -z]`::
+	List all the available keys, one per line. The output format can be chosen
+	through the flag `--format`. The following formats are supported:
++
+`default`:::
+	synonym for `lines`.
+
+`lines`:::
+	output the keys one per line.
+
+`nul`:::
+	similar to `default`, but using a _NUL_ character after each value.
+
 `structure [--format=(default|table|keyvalue|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
diff --git a/builtin/repo.c b/builtin/repo.c
index 306d3fa2df..2f698c5253 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -18,6 +18,7 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]",
+	"git repo info --keys [--format=(default|lines|nul) | -z]",
 	"git repo structure [--format=(default|table|keyvalue|nul) | -z]",
 	NULL
 };
@@ -29,6 +30,7 @@ enum output_format {
 	FORMAT_TABLE,
 	FORMAT_KEYVALUE,
 	FORMAT_NUL_TERMINATED,
+	FORMAT_LINES
 };
 
 struct field {
@@ -149,6 +151,32 @@ static int print_all_fields(struct repository *repo,
 	return 0;
 }
 
+static int print_keys(enum output_format format)
+{
+	char sep;
+
+	if (format == FORMAT_DEFAULT)
+		format = FORMAT_LINES;
+
+	switch (format) {
+	case FORMAT_LINES:
+		sep = '\n';
+		break;
+	case FORMAT_NUL_TERMINATED:
+		sep = '\0';
+		break;
+	default:
+		die(_("--keys can only be used with --format=default or --format=nul"));
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+		printf("%s%c", field->key, sep);
+	}
+
+	return 0;
+}
+
 static int parse_format_cb(const struct option *opt,
 			   const char *arg, int unset UNUSED)
 {
@@ -162,6 +190,8 @@ static int parse_format_cb(const struct option *opt,
 		*format = FORMAT_KEYVALUE;
 	else if (!strcmp(arg, "table"))
 		*format = FORMAT_TABLE;
+	else if (!strcmp(arg, "lines"))
+		*format = FORMAT_LINES;
 	else if (!strcmp(arg, "default"))
 		*format = FORMAT_DEFAULT;
 	else
@@ -175,6 +205,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 {
 	enum output_format format = FORMAT_DEFAULT;
 	int all_keys = 0;
+	int show_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -184,11 +215,18 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
 		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
+		OPT_BOOL(0, "keys", &show_keys, N_("show keys")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 
+	if (show_keys && (all_keys || argc))
+		die(_("--keys cannot be used with a <key> or --all"));
+
+	if (show_keys)
+		return print_keys(format);
+
 	if (format == FORMAT_DEFAULT)
 		format = FORMAT_KEYVALUE;
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index e6670f0f58..832938e958 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -4,15 +4,6 @@ test_description='test git repo-info'
 
 . ./test-lib.sh
 
-# git-repo-info keys. It must contain the same keys listed in the const
-# repo_info_fields, in lexicographical order.
-REPO_INFO_KEYS='
-	layout.bare
-	layout.shallow
-	object.format
-	references.format
-'
-
 # Test whether a key-value pair is correctly returned
 #
 # Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
@@ -119,8 +110,8 @@ test_expect_success 'git repo info uses the last requested format' '
 	test_cmp expected actual
 '
 
-test_expect_success 'git repo info --all returns all key-value pairs' '
-	git repo info $REPO_INFO_KEYS >expect &&
+test_expect_success 'git repo info --all and git repo info $(git repo info --keys) output the same data' '
+	git repo info $(git repo info --keys) >expect &&
 	git repo info --all >actual &&
 	test_cmp expect actual
 '
@@ -143,4 +134,33 @@ test_expect_success '--format=default resets the format' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git repo info --keys --format=nul uses nul-terminated output' '
+	git repo info --keys --format=default >default &&
+	lf_to_nul <default >expect &&
+	git repo info --keys --format=nul >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info --keys aborts when using --format other than default or nul' '
+	echo "fatal: --keys can only be used with --format=default or --format=nul" >expect &&
+	test_must_fail git repo info --keys --format=keyvalue 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info --keys aborts when requesting keys' '
+	echo "fatal: --keys cannot be used with a <key> or --all" >expect &&
+	test_must_fail git repo info --keys --all 2>actual_all &&
+	test_must_fail git repo info --keys some.key 2>actual_key &&
+	test_cmp expect actual_all &&
+	test_cmp expect actual_key
+'
+
+test_expect_success 'git repo info --keys uses lines as its default output format' '
+	git repo info --keys --format=lines >expect &&
+	git repo info --keys --format=default >actual_explicit &&
+	git repo info --keys >actual_implicit &&
+	test_cmp expect actual_explicit &&
+	test_cmp expect actual_implicit
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

