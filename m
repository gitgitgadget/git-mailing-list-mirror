Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D7A2DF132
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186964; cv=none; b=c/jtu/hXiE6xgszVuMVC5Kd01Db6oyErUdqW9mh2ayGoaBntyO+WPEon72GJ4IfFEWpphRURHkOeR9tVYWYHm2FxM9ORabmI0JanrQQHOKLVLYTq9piHSknpgYkiIOgiL5LkbE9H+uYS0O/BP5Ovtq7Bb0BTnKojs1VmKns7Yho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186964; c=relaxed/simple;
	bh=f0eB1Vcvd6s77jv7N5YZq7qTY6F+B0J7yi5m2pS8uXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPcHobOXv0X768GkMQxggSQCBot/kVIZ6o03qIk4xbPpoEyb1yNWHYI6wK+yiJN+aQbfuISvkthnxLqIJYL31m8il2vmDrVirxU35gHlhQ6QckCfRiGmZt1E4G3we8AlBULjz2KEvnJyd0XepRQOUPjEA76mCTnMyDtLacDAcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtHWLHNz; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtHWLHNz"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-121bf277922so4266560c88.0
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 08:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769186961; x=1769791761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQeYfPU0wSMdN9kK4HUcLbvmlzDPElT6ibVsm/yv5f0=;
        b=AtHWLHNzDIi9IgbkfNKDYWlLuKBgm/qBu04cJdBdr1ibpdqX4DthECqTNLTfHZCQBD
         5zYVMRR72yKp0ij0i6rhap/aczQrAPUbQoGp9eADtSnlvkLPD3pavbhBYEZoLGXlt7zz
         kd8LZHPI80oPUJZnWxyk4njoptir++FrP3R/cxcHGNaluU9xvvV+xfefvy/Gb++MDyBW
         DzeRakbZRTB/rSYECXvsqX+0J/SClkncdHtGSlYbl/q+PG05E5xx6IMIV2yHMipBozRT
         6PEZhjlBiVrKcbaqlgernmHM3FwAaSmx1jnIZoFyA0PVojHqxaeOnnvOjWac0v9maiS6
         iPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769186961; x=1769791761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQeYfPU0wSMdN9kK4HUcLbvmlzDPElT6ibVsm/yv5f0=;
        b=abgXTrxPvfoByd7U8fHilmIg+Pqhqz53O0JA/46ADzUDBocjMn267+5Rpa/eJ3iSlm
         H8Zf/t58OQGFKUGwYi5EFCfHaMyrNKgAJK2zha845slZOJj7pymvZnzY9NLg4UPCTzx2
         1LK8l/gVJ6DN5rjcmMqOwwBkv19chTlIgTj0KWfzjVnZObVU59rGDgGFYEp5ub7l2K1E
         2SnXZtCM/wydyS36coVGCDcbTrQ6tZHp48zmPwox3BWc0Dpx7hD2huKwmnSQLsjtfgXp
         ID+nPRclW5p1Iac4LJCYTSL6/Ek6oEgIY3sbY6wJL+B4kGqlvYWqoRzQ5xM/ZDG8MpYq
         w1sw==
X-Gm-Message-State: AOJu0YxmGa74th151aE0Z4gG3rjo5KOLKaY1Vli5YqFalrxJgLyLI383
	KPn4/Sc8PkFt6De3QJSIOxQZtvezIvMvgYGMSP6p81Odl4hn7XQqPkFjRVzbiA==
X-Gm-Gg: AZuq6aKdOrpW7qee6NA0fL+zy0gAzOoJWLHgyVS/qEL6HIreKSQBPJTwWPi1j/yVhVD
	BfjpnqmEFP1xMFom0eYeGicv1sxplEGc8m+8eqzq3OFE+apFplu7pOdsNdVc/WkvNsuYGoTLtg3
	qfaGtz3CR8E+ftUVm7fXQlEObIqUOmkL3E0cKlY8ctf4H/V/DkYyz7W5fhhcifVmxLtFanpsLJg
	62TCaleWrUshVXk5TOUh2pMO+2lSYYax+GAofbftoECY7C9BJS06l6K+Cjhb6HYmo3fNRm7ILAG
	lGngHhirSHUqG+xctuWw25nk2zdu+dIGP7MyenIyTm9Sp+l9W3rnZUaYkzJfc+zqHv/zvbBZYNS
	WA3Rceyhs96SdLj0qNcZqitK6QW/hDEwUkLMfrdsVutwHdV/b5s43bRkIreuboUAyQCO5v2zBHU
	Na6vQpTrKz6m1N/XJKZhekfI+Aos8MOMwJdY2JUBc+ypZsnS3QIIaIen4cmA==
X-Received: by 2002:a05:7022:6ba1:b0:11b:d561:bc16 with SMTP id a92af1059eb24-1247dbc4cd0mr1763886c88.22.1769186961051;
        Fri, 23 Jan 2026 08:49:21 -0800 (PST)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d9a3f22sm5522640c88.13.2026.01.23.08.49.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jan 2026 08:49:20 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v5 2/2] repo: add new flag --keys to git-repo-info
Date: Fri, 23 Jan 2026 13:34:54 -0300
Message-ID: <20260123164900.35092-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260123164900.35092-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260123164900.35092-1-lucasseikioshiro@gmail.com>
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
 Documentation/git-repo.adoc | 11 ++++++++++
 builtin/repo.c              | 32 +++++++++++++++++++++++++++++
 t/t1900-repo.sh             | 40 +++++++++++++++++++++++++++----------
 3 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 693e1bbced..f474274009 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(lines|nul) | -z] [--all | <key>...]
+git repo info --keys [--format=(lines|nul) | -z]
 git repo structure [--format=(table|lines|nul) | -z]
 
 DESCRIPTION
@@ -45,6 +46,16 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`info --keys [--format=(lines|nul) | -z]`::
+	List all the available keys, one per line. The output format can be chosen
+	through the flag `--format`. The following formats are supported:
++
+`lines`:::
+	output the keys one per line. This is the default.
+
+`nul`:::
+	similar to `lines`, but using a _NUL_ character after each value.
+
 `structure [--format=(table|lines|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
diff --git a/builtin/repo.c b/builtin/repo.c
index 4031612bc8..a7d4855f06 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -18,6 +18,7 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
+	"git repo info --keys [--format=(lines|nul) | -z]",
 	"git repo structure [--format=(table|lines|nul) | -z]",
 	NULL
 };
@@ -148,6 +149,29 @@ static int print_all_fields(struct repository *repo,
 	return 0;
 }
 
+static int print_keys(enum output_format format)
+{
+	char sep;
+
+	switch (format) {
+	case FORMAT_LINES:
+		sep = '\n';
+		break;
+	case FORMAT_NUL_TERMINATED:
+		sep = '\0';
+		break;
+	default:
+		die(_("--keys can only be used with --format=lines or --format=nul"));
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
@@ -172,6 +196,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 {
 	enum output_format format = FORMAT_LINES;
 	int all_keys = 0;
+	int show_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -181,11 +206,18 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
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
 	if (format != FORMAT_LINES && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 4155211e5d..a9eb07abe8 100755
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
@@ -131,4 +122,31 @@ test_expect_success 'git repo info --all <key> aborts' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git repo info --keys --format=nul uses nul-terminated output' '
+	git repo info --keys --format=lines >lines &&
+	lf_to_nul <lines >expect &&
+	git repo info --keys --format=nul >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info --keys aborts when using --format other than lines or nul' '
+	echo "fatal: --keys can only be used with --format=lines or --format=nul" >expect &&
+	test_must_fail git repo info --keys --format=table 2>actual &&
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
+	git repo info --keys >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

