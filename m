Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9B2F7AD2
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856990; cv=none; b=Wi7NUXm4Zof54l/HsPSfiXUUg1ZUoXfPOquBQxp9fbyo/BSDlG9zgdjb9itkvMZ1lY3VkTKjwgIOuMDTSRSI24xG/bHX8Ztjy+mOVw54G12SFiiY/00Nn3rp4E7PRfLMMmgwIiMk5l4QKHmxY95jpOImtLLJDD78U8ZmV6dNffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856990; c=relaxed/simple;
	bh=TYsM34z8qvrnaGSzkOngQSxmJa6kkM51DVufZi68zm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZtPIiDKqwdNU32yKYaXzNaPIEH0K4XJEhwNrYA6FYmttRECdvxqSdiX2DzLCxFz7xzrz1Nxa/J1KHU9Xg9XYcvVKVwuxJl3pd4/7oSJ4QBHfZ4qkRSWiCAf2fhHVKdZQ0oZFKryJL+OFvoy+JzzfLUYo8XMdcee6V1q1B2j89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpiFwo4o; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpiFwo4o"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1220154725fso3634111c88.0
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 13:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768856987; x=1769461787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fmhqsdERzyOHmKvJLKzNHd0atlIu8Wm2gnVhM5BwHQ=;
        b=QpiFwo4ooMB1r/LEQwfWMUHMZwZerqqPOMWjn4HgnVLfqzduVoCC/ZgHDkhb50aLMh
         m5MsHEkOQPW4fl+o64fno2CyKGPRsgyifc9mk1NcstPrRqO5saRKfO4vCDBUYbnsO7uc
         NoWv3I2EVezDUm1k2GJwu3S/Lre/4V4cWxxmQCyeIqciUCsr+rwUEIEmOdfAtpkU5p0g
         bSqFA9nj97dOzDO43/nNGqwOOgYn6xIN+GKSvRrvdoMPFmSw5kut3t2Gs+597sFfcGgl
         1omzPgRfp4isDbnFz+2ec7nRa7pQQQpyj1GHfJgOe4QFalKhVdsyUJjgwS+zyHSaWRHD
         XrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768856987; x=1769461787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fmhqsdERzyOHmKvJLKzNHd0atlIu8Wm2gnVhM5BwHQ=;
        b=vVT8yLwlNhkotqpesXnswHVcjJaq9kbJvA2KECvGhgHCtQad0WQT806Ai4/MJuorY5
         c4YagslixFxkEaKMJc78i7yZuVY+VON7f0D0ZPTpHsICnt9FceckpQGjSCRb237cGGll
         dB2DdMfUgv78m98ZXZmWsefJNFwXegMSDdYJsH5FN4NpKlK3Fi+l7g4Qe5QFJHOUkWcE
         54JXS7jNiuqTDqn7n9F6HjjZJsdQITaVvjoujZJeUO2X2RwTkMquXGrIin6z8KnFi3ec
         0LFCWuTlbjvlvs7rZKHcFTjG0uomHp9XNWHszfwfUwfMH938N3eAW3cEPJxza3TTcAp2
         uQ7g==
X-Gm-Message-State: AOJu0YxIgEU6G+nd7zvtwfAZ5ZEeLa2SERFYy1HSCvd9lnE0mM3RTL0K
	/R1uOVN7INiI+4YEJREFFphs+cOonVIe5zqk8lgARCTPEUUvkCyPjdPafJ18Bg==
X-Gm-Gg: AY/fxX4VD7JgSOnt7SdHhqHRIoa8cC2voeR8n0KsEbFQp8pUJipe+6Pnv9hVm/vJ1A9
	D1ErYfP8QQs2ulk08Jn1YQZftZ0T8nEbhT0GOC1r0kXYI8JnAqdv+diESG6/jQBGyFqYqOLD3HX
	LEiBfrUENFnxCVcOLW7FnHLahOvy+B7jlpaFb84dpombNcbA5ND4JHF8vjB6pXboJOMkjc4xjRC
	NbphGplENhBMQvdRfUbWX464RnQGxC1DoweTRRaxc/KirW5tf9IQmiNcSCz6djT9Oy2XOh9UmUy
	Mw/CchrtawjMteTao/xPar9wUu8HpRjAXTyhaQFQGVtjfHaOSeVQ5ozPE6u4IzFWQYNJ0esNUsO
	opcS1zYijctj5EJIW976ME+Idl8pd0SG0IfzYzZTuCzseFkU+Dy254n53RRhe6XQQZqJMuYTd81
	iMB0pL4JcjNfan1nob/lWLOealcqFM6NuzBmSNb4X7mAIUdP8=
X-Received: by 2002:a05:7022:910:b0:11e:4fc:9b33 with SMTP id a92af1059eb24-1233cfac8c6mr12294427c88.1.1768856987280;
        Mon, 19 Jan 2026 13:09:47 -0800 (PST)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac57fd0sm16935706c88.3.2026.01.19.13.09.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jan 2026 13:09:46 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v4 1/2] repo: add a default output format to enum output_format
Date: Mon, 19 Jan 2026 17:20:19 -0300
Message-ID: <20260119210932.68893-2-lucasseikioshiro@gmail.com>
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

Add "default" as an option for --format in both git-repo-info and
git-repo-structure. Using `--format=default` makes those commands use
their default output format.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 19 ++++++++++++-------
 builtin/repo.c              | 18 ++++++++++++++----
 t/t1900-repo.sh             | 12 ++++++++++++
 t/t1901-repo-structure.sh   | 22 ++++++++++++++++++++++
 4 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7d70270dfa..fa0e6600af 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,8 +8,8 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
-git repo structure [--format=(table|keyvalue|nul) | -z]
+git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]
+git repo structure [--format=(default|table|keyvalue|nul) | -z]
 
 DESCRIPTION
 -----------
@@ -19,7 +19,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(keyvalue|nul) | -z] [--all | <key>...]`::
+`info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
@@ -30,11 +30,14 @@ requested. The `--all` flag requests the values for all the available keys.
 The output format can be chosen through the flag `--format`. Two formats are
 supported:
 +
+`default`:::
+	synonym for `keyvalue`.
+
 `keyvalue`:::
 	output key-value pairs one per line using the `=` character as
 	the delimiter between the key and the value. Values containing "unusual"
 	characters are quoted as explained for the configuration variable
-	`core.quotePath` (see linkgit:git-config[1]). This is the default.
+	`core.quotePath` (see linkgit:git-config[1]).
 
 `nul`:::
 	similar to `keyvalue`, but using a newline character as the delimiter
@@ -44,7 +47,7 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
-`structure [--format=(table|keyvalue|nul) | -z]`::
+`structure [--format=(default|table|keyvalue|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -56,10 +59,12 @@ supported:
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
 +
+`default`:::
+	synonym for `table`.
+
 `table`:::
 	Outputs repository stats in a human-friendly table. This format may
-	change and is not intended for machine parsing. This is the default
-	format.
+	change and is not intended for machine parsing.
 
 `keyvalue`:::
 	Each line of output contains a key-value pair for a repository stat.
diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..306d3fa2df 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -17,14 +17,15 @@
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
-	"git repo structure [--format=(table|keyvalue|nul) | -z]",
+	"git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]",
+	"git repo structure [--format=(default|table|keyvalue|nul) | -z]",
 	NULL
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
+	FORMAT_DEFAULT,
 	FORMAT_TABLE,
 	FORMAT_KEYVALUE,
 	FORMAT_NUL_TERMINATED,
@@ -161,6 +162,8 @@ static int parse_format_cb(const struct option *opt,
 		*format = FORMAT_KEYVALUE;
 	else if (!strcmp(arg, "table"))
 		*format = FORMAT_TABLE;
+	else if (!strcmp(arg, "default"))
+		*format = FORMAT_DEFAULT;
 	else
 		die(_("invalid format '%s'"), arg);
 
@@ -170,7 +173,7 @@ static int parse_format_cb(const struct option *opt,
 static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
-	enum output_format format = FORMAT_KEYVALUE;
+	enum output_format format = FORMAT_DEFAULT;
 	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
@@ -185,6 +188,10 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+
+	if (format == FORMAT_DEFAULT)
+		format = FORMAT_KEYVALUE;
+
 	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
@@ -638,7 +645,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
-	enum output_format format = FORMAT_TABLE;
+	enum output_format format = FORMAT_DEFAULT;
 	struct repo_structure stats = { 0 };
 	struct rev_info revs;
 	int show_progress = -1;
@@ -658,6 +665,9 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	if (argc)
 		usage(_("too many arguments"));
 
+	if (format == FORMAT_DEFAULT)
+		format = FORMAT_TABLE;
+
 	repo_init_revisions(repo, &revs, prefix);
 
 	if (show_progress < 0)
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 51d55f11a5..e6670f0f58 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -131,4 +131,16 @@ test_expect_success 'git repo info --all <key> aborts' '
 	test_cmp expect actual
 '
 
+test_expect_success '--format=default is a synonym for --format=keyvalue' '
+	git repo info --all --format=keyvalue >expect &&
+	git repo info --all --format=default >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--format=default resets the format' '
+	git repo info --all >expect &&
+	git repo info --all --format=nul --format=default >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 17ff164b05..9c5054c8db 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -181,4 +181,26 @@ test_expect_success 'progress meter option' '
 	)
 '
 
+test_expect_success '--format=default is a synonym for --format=table' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git repo structure --format=table >expect &&
+		git repo structure --format=default >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--format=default resets the format' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git repo structure >expect &&
+		git repo structure --format=nul --format=default >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

