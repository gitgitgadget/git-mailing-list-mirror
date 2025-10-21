Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095D351FC9
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071203; cv=none; b=J3grXkpdABF2EqgVBec3yYeTQxzuVK8I0TaM6L7L+pvJJc18vM7EodF1tPLyQJepqPS6BiInHh0y98wtssxluLsJvFU4SWX8XCDMXfxoLvdNNzmQQiAe9KMeLUKZvogNxlHXKnHD3j96qWzi4B6zNonKWXTqbdXQ/dwp/kriqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071203; c=relaxed/simple;
	bh=RTaDIXzJuL79N/NGS4Tp7iwb6iwRCbNnuMatVjbYtK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgAdrrXlkRsY1ijedrdOHzehTaQqTbX1CRKe4twZg457wZxoMPN+hhPFIvQEg6k5EhMqYo5Nzr2zmLm+5XsqO+Pb1rLuIs/26/wzXSHEszX6w63/dMZrZufvAVgX5gWYy8WdRZMCqn5NfQ8RenxWxIu3juAtyGtmWv1g+E7q3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlZUU6SN; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlZUU6SN"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7827025e548so2457539a34.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071200; x=1761676000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvCghDMnrw50Pnq3Sf3jbRvuytN8AyLQBNVrsnGXu2I=;
        b=TlZUU6SNJg3LU1cGImmAeHRrR5M/XMV+SSm0hAeArWJpY0vzRT3uQagf474URzMSjv
         OLspj7Ylh67coLo/W+oGj7bWYDjnMM+Qk6Eq1Oz1cf8T/WlAUKdzjYcClsGDCWHHpQmH
         5haOFkVQ+BL56QThUMrCxtVKDXIBijKyaw/aegFIgfi5PPM/IUvCRyGq+PIrr3hXw5Bs
         1SmvNwpRj3dOOuQ/C00h1ZxZHj7hhxB18xhY5QFWH3CD3/AbEmakwy8iWWm1JK/UAa/j
         Rtz/Sdl+g6kuV87DmpzwYWMWAQcfSWQy97RDyZ4Q5AjatGqw4gcg2edf4AbCaCWXwxqM
         3gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071200; x=1761676000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvCghDMnrw50Pnq3Sf3jbRvuytN8AyLQBNVrsnGXu2I=;
        b=CwoUH1uet3o65XreBLXmYaEoeaMDV9+6CWpOJy9cd3CIYZLMeB8ElsI4yPIaaU+0qs
         rZH+OYR1EHd1OPRxrpWac1UZwmyakGA9/dydKC0hxwIIiB5HRgi/t3MEWO64RILKLISH
         YamjZK/QBaAbFyopKaxyx6c3tIg4Ug1RcJVGOmFjIsU9NoTXoZXehPK9IodPJnHrl/tv
         bs/Xths68pHzuJOJCusVNLf/CYN/nusmXgf5yVu6VmTpxXtFq+KdMfhx6jLiZWCdkhAl
         6VKJrXWN+niwh4xDy9uZYHLL8hKARHtDpeJsmYSauZTTddvDYOzn43gDmEsnL3qvnAqu
         B7lw==
X-Gm-Message-State: AOJu0Yyk32vUP/7gY1HjSutPzNk+Lr0SfXPiYQIAbCMRhDhwDjB0WrnQ
	2myYi2+sEHin7oRvJv92tZwtMtBijdoJzq7wGpCI1IzoO0kTFJePq5Ey3yiWog==
X-Gm-Gg: ASbGncu0J5WQq9luhyH2IPnCV88fK9ZHql8Qc8N21FrWCzz3tf6MB35F/zIcx4VIkr4
	45eLyo+lYbRTvu4C6d/Nhkgl4IIf9GZNcqYZV8UhJB/1tKlC4Ye9oA2YwCusVpOub8WO3rhwXgD
	BEAbY9EW+T05sglF518q3pFHKQ/nhZgTlJcZGs+KBWBdcY/qH2tqVu75V8/FiGBdXdSe8wQRmRf
	5NgQXEI89DMUuFLQjBucxoe0Kq/G7VBrbyAoqhc4b4Cr8zWLXRaXs5p4ideo1rpcHLQx6rC3bkz
	HC/CqCwxLePfLEXyU+g4XbofpmlzPYQXvoZRKuN5pgVpPMZtclVl5zcVgY+4jkFw+b8h2Za9VIJ
	zyzrrcyodK+FRRhFnBBHNBa7JmXG1frgyxgS2sz9z3q8fhsCXBI0FbK92r88797UHTk45pWVaWz
	+9q3an+Z03
X-Google-Smtp-Source: AGHT+IHJj29EefbWTd6+bKRyUfnNyMGeui1WB9/oYDFPMMd1cmanxITQeYTDrOm4S7MDPNLtf5UYEg==
X-Received: by 2002:a05:6808:1b0d:b0:43f:7287:a5b0 with SMTP id 5614622812f47-443a30d11camr7821666b6e.38.1761071200178;
        Tue, 21 Oct 2025 11:26:40 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df722e5csm2795853b6e.24.2025.10.21.11.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:26:39 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v6 6/7] builtin/repo: add keyvalue and nul format for structure stats
Date: Tue, 21 Oct 2025 13:26:00 -0500
Message-ID: <20251021182601.2687284-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251021182601.2687284-1-jltobler@gmail.com>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All repository structure stats are outputted in a human-friendly table
form. This format is not suitable for machine parsing. Add a --format
option that supports three output modes: `table`, `keyvalue`, and `nul`.
The `table` mode is the default format and prints the same table output
as before.

With the `keyvalue` mode, each line of output contains a key-value pair
of a repository stat. The '=' character is used to delimit between keys
and values. The `nul` mode is similar to `keyvalue`, but key-values are
delimited by a NUL character instead of a newline. Also, instead of a
'=' character to delimit between keys and values, a newline character is
used. This allows stat values to support special characters without
having to cquote them. These two new modes provides output that is more
machine-friendly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc | 25 +++++++++++++++--
 builtin/repo.c              | 55 ++++++++++++++++++++++++++++++++++---
 t/t1901-repo-structure.sh   | 33 ++++++++++++++++++++++
 3 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ae62d2415f..ce43cb19c8 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
-git repo structure
+git repo structure [--format=(table|keyvalue|nul)]
 
 DESCRIPTION
 -----------
@@ -44,7 +44,7 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
-`structure`::
+`structure [--format=(table|keyvalue|nul)]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -52,7 +52,26 @@ supported:
 * Reachable object counts categorized by type
 
 +
-The table output format may change and is not intended for machine parsing.
+The output format can be chosen through the flag `--format`. Three formats are
+supported:
++
+`table`:::
+	Outputs repository stats in a human-friendly table. This format may
+	change and is not intended for machine parsing. This is the default
+	format.
+
+`keyvalue`:::
+	Each line of output contains a key-value pair for a repository stat.
+	The '=' character is used to delimit between the key and the value.
+	Values containing "unusual" characters are quoted as explained for the
+	configuration variable `core.quotePath` (see linkgit:git-config[1]).
+
+`nul`:::
+	Similar to `keyvalue`, but uses a NUL character to delimit between
+	key-value pairs instead of a newline. Also uses a newline character as
+	the delimiter between the key and value instead of '='. Unlike the
+	`keyvalue` format, values containing "unusual" characters are never
+	quoted.
 
 INFO KEYS
 ---------
diff --git a/builtin/repo.c b/builtin/repo.c
index f39f06ee8c..1754cc7e5d 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -15,13 +15,14 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
-	"git repo structure",
+	"git repo structure [--format=(table|keyvalue|nul)]",
 	NULL
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
+	FORMAT_TABLE,
 	FORMAT_KEYVALUE,
 	FORMAT_NUL_TERMINATED,
 };
@@ -136,6 +137,8 @@ static int parse_format_cb(const struct option *opt,
 		*format = FORMAT_NUL_TERMINATED;
 	else if (!strcmp(arg, "keyvalue"))
 		*format = FORMAT_KEYVALUE;
+	else if (!strcmp(arg, "table"))
+		*format = FORMAT_TABLE;
 	else
 		die(_("invalid format '%s'"), arg);
 
@@ -158,6 +161,8 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
+		die(_("unsupported output format"));
 
 	return print_fields(argc, argv, repo, format);
 }
@@ -330,6 +335,30 @@ static void stats_table_clear(struct stats_table *table)
 	string_list_clear(&table->rows, 1);
 }
 
+static void structure_keyvalue_print(struct repo_structure *stats,
+				     char key_delim, char value_delim)
+{
+	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->refs.branches, value_delim);
+	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->refs.tags, value_delim);
+	printf("references.remotes.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->refs.remotes, value_delim);
+	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->refs.others, value_delim);
+
+	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.commits, value_delim);
+	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.trees, value_delim);
+	printf("objects.blobs.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.blobs, value_delim);
+	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.tags, value_delim);
+
+	fflush(stdout);
+}
+
 struct count_references_data {
 	struct ref_stats *stats;
 	struct rev_info *revs;
@@ -426,9 +455,15 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
+	enum output_format format = FORMAT_TABLE;
 	struct repo_structure stats = { 0 };
 	struct rev_info revs;
-	struct option options[] = { 0 };
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "format", &format, N_("format"),
+			       N_("output format"),
+			       PARSE_OPT_NONEG, parse_format_cb),
+		OPT_END()
+	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 	if (argc)
@@ -439,8 +474,20 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	structure_count_references(&stats.refs, &revs, repo);
 	structure_count_objects(&stats.objects, &revs);
 
-	stats_table_setup_structure(&table, &stats);
-	stats_table_print_structure(&table);
+	switch (format) {
+	case FORMAT_TABLE:
+		stats_table_setup_structure(&table, &stats);
+		stats_table_print_structure(&table);
+		break;
+	case FORMAT_KEYVALUE:
+		structure_keyvalue_print(&stats, '=', '\n');
+		break;
+	case FORMAT_NUL_TERMINATED:
+		structure_keyvalue_print(&stats, '\n', '\0');
+		break;
+	default:
+		BUG("invalid output format");
+	}
 
 	stats_table_clear(&table);
 	release_revisions(&revs);
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index c32cf4e239..14bd8aede5 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -73,4 +73,37 @@ test_expect_success 'repository with references and objects' '
 	)
 '
 
+test_expect_success 'keyvalue and nul format' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 42 &&
+		git tag -a foo -m bar &&
+
+		cat >expect <<-\EOF &&
+		references.branches.count=1
+		references.tags.count=1
+		references.remotes.count=0
+		references.others.count=0
+		objects.commits.count=42
+		objects.trees.count=42
+		objects.blobs.count=42
+		objects.tags.count=1
+		EOF
+
+		git repo structure --format=keyvalue >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err &&
+
+		# Replace key and value delimiters for nul format.
+		tr "\n=" "\0\n" <expect >expect_nul &&
+		git repo structure --format=nul >out 2>err &&
+
+		test_cmp expect_nul out &&
+		test_line_count = 0 err
+	)
+'
+
 test_done
-- 
2.51.0.193.g4975ec3473b

