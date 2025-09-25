Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F82ED15A
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842983; cv=none; b=jBnfmZbSwSd5q+S1OS1DUsr0lhMCBhMqdjhiFo5oXFJG+R05B4ErovLgAvLDzgqaHdd/Fgm5GMEqvvblhgIfN08PuTHHM7+snh5XKjhbS0WWDs+ZTuG73fbgBfI2S3bKufeaxWa8hq87wCUPnRaN8Xw+210+L+70H1uwuTvpZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842983; c=relaxed/simple;
	bh=lUkoXMlGtBjwd1v9Gh4ZJF8RQLNfLB0fPqnAKyzN5io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQW1TA2XtDybbVwkLom94vt5PxdQzpfwz9uv/N+BOu+zRpZ0YB7EEBUo9SKahsezsyi3t0fBmnIXxQVOB82HRUXIZiKWpSrU+0EUDuM8yrCI0MYT1MG52fA5QFafPsQb1n+NRjFQOKhkGPFj+Zt1ZwpwFhVa1u+dWzDnveeFYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsPEpxfD; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsPEpxfD"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7a76561c291so504936a34.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842981; x=1759447781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7Pc2udgJOGk2i5JruhwTxL17mNCjftVx55ZPEHS10k=;
        b=EsPEpxfDHsAR2uY2QqoG0cd4qFB6Lbfu6iDYyUbXFJ/ToaZbhq+vx2nJ/4C69SAvoD
         wFWZjEDj96z1xG1D08wu0nMxMf1Nqj81gUjDekkwN/rabc5juh2ZZIGznrEEM/wlpbhY
         254brElpxklktoiuAhEsZ31xY50Ix0DLGFfthNL+IkJplbQd4IOlJ7OvaqNK9uGU7QEd
         adqVBz7CsSy4uGOu9fLisE72OoRf7MC61SHl7GZfzSGF++L+rLLe0YrRUOKFb7dLzS2y
         NXmZ7HaHaUsrLeJK2NNXc62HAjCjKacOAPVN4xTTeArw2Kn/UmAfV1VG4t/JC47ev+/0
         cqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842981; x=1759447781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7Pc2udgJOGk2i5JruhwTxL17mNCjftVx55ZPEHS10k=;
        b=u0c/B0ppm6tW+nUpRwlD9+P+wkIsn8TVla9lXUVdXykFlnd1zbqA9xc77mAbHhiSz7
         2XLsdL8KswiWQsOJEeq3+m3gal1ZBrGNk6324N0f4MexVSTlwtd4D4Ns7RPUG+U+5lL5
         M2Os6vEs7Tdde5kfdOgkrGLMuCP+o9pGZOzXrAJNeoVG3Evl5Z/lHVCgSm97iuzJcgSO
         AGo8GDUnF23OvYH6m6tQLcLeLzYgBpJ64emfQveDjWpPK4kFKVTVlO3SbbcoL6zEWzCn
         sGpwMOf8Ymq3cQUh7qgqi6psIeRINHAXF4HFHKk2wY4lY/T+irIt2Dtoysmk+Uq4gpnd
         tOpg==
X-Gm-Message-State: AOJu0YwOzXmHFCagAIFFpEHT9TqRvE7Cl1GIb7hgebJD+etxt37fRYQ+
	ffuhBMpbmIYIT+bXl6FokjPOBb+M8l5GSN45Me6S3fhSJZEoJep0RWyJx+gedw==
X-Gm-Gg: ASbGnctNizuQvXIj5AO4tqEGHBIRCZ6/tIvhDSGT8T7nicxX878PF+qCpMyJJ2yw0ux
	JDjdZZSAxsZcNPXkq0RFRMCqNE4JdT0aIKdB/wvE7HRXBJic/BAAEFJi/DdlTuvOAVKZ2PlYer2
	jZkxXsvH4Z7Nh43IcDJW6lXE59LRfoKN5Gra/cX494ZLrurpvLgjtL7wROCT/LReTyv3iZWXyou
	Wjui6a6goUOEkeXsfrgL5CJhEyMcelTw+6f4dLXK9FY6GKNfTqWaJXngaR2MyCqpAuzMo/xI/eG
	S96lnhDoLqa5X3AZ52dm8FtkaM18vcEFZf4U8g+67RUc6mOGUYJAhiOabMDzaHvPEaPGl3Dd8rZ
	oXoAsERD5MwxM71GVE1Yp0LPeUuAaze97wJIq5gOw6Q==
X-Google-Smtp-Source: AGHT+IFsmuXl4pDp5+My9PJlK4hWcHJN1/8AftBzHdXtx3xZhpsEJcTHxHBlmE3SbNfx77BHTt/Ruw==
X-Received: by 2002:a05:6830:82da:b0:757:5bc5:3f5c with SMTP id 46e09a7af769-7a04a5db6c1mr3071124a34.33.1758842980701;
        Thu, 25 Sep 2025 16:29:40 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7a2402e5d70sm674273a34.36.2025.09.25.16.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:29:40 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 6/7] builtin/repo: add keyvalue and nul format for stats
Date: Thu, 25 Sep 2025 18:29:27 -0500
Message-ID: <20250925232928.3846-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250925232928.3846-1-jltobler@gmail.com>
References: <20250924212426.2930029-1-jltobler@gmail.com>
 <20250925232928.3846-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All repository stats are outputted in a human-friendly table form. This
format is not suitable for machine parsing. Add a --format option that
supports three output modes: `table`, `keyvalue`, and `nul`. The `table`
mode is the default format and prints the same table output as before.

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
 t/t1901-repo-stats.sh       | 33 ++++++++++++++++++++++
 3 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 0b8d74ed3e..3fbce0b88c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
-git repo stats
+git repo stats [--format=(table|keyvalue|nul)]
 
 DESCRIPTION
 -----------
@@ -44,7 +44,7 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
-`stats`::
+`stats [--format=(table|keyvalue|nul)]`::
 	Retrieve statistics about the current repository. The following kinds
 	of information are reported:
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
index 43cd6b1b38..e8a02c950b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -14,13 +14,14 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
-	"git repo stats",
+	"git repo stats [--format=(table|keyvalue|nul)]",
 	NULL
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
+	FORMAT_TABLE,
 	FORMAT_KEYVALUE,
 	FORMAT_NUL_TERMINATED,
 };
@@ -135,6 +136,8 @@ static int parse_format_cb(const struct option *opt,
 		*format = FORMAT_NUL_TERMINATED;
 	else if (!strcmp(arg, "keyvalue"))
 		*format = FORMAT_KEYVALUE;
+	else if (!strcmp(arg, "table"))
+		*format = FORMAT_TABLE;
 	else
 		die(_("invalid format '%s'"), arg);
 
@@ -157,6 +160,8 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
+		die(_("unsupported output format"));
 
 	return print_fields(argc, argv, repo, format);
 }
@@ -329,6 +334,30 @@ static void stats_table_clear(struct stats_table *table)
 	string_list_clear(&table->rows, 1);
 }
 
+static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
+				 char value_delim)
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
 static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
 {
 	for (int i = 0; i < refs->nr; i++) {
@@ -413,10 +442,16 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
+	enum output_format format = FORMAT_TABLE;
 	struct repo_stats stats = { 0 };
 	struct ref_array refs = { 0 };
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
@@ -429,8 +464,20 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
 	stats_count_references(&stats.refs, &refs);
 	stats_count_objects(&stats.objects, &refs, &revs);
 
-	stats_table_setup(&table, &stats);
-	stats_table_print(&table);
+	switch (format) {
+	case FORMAT_TABLE:
+		stats_table_setup(&table, &stats);
+		stats_table_print(&table);
+		break;
+	case FORMAT_KEYVALUE:
+		stats_keyvalue_print(&stats, '=', '\n');
+		break;
+	case FORMAT_NUL_TERMINATED:
+		stats_keyvalue_print(&stats, '\n', '\0');
+		break;
+	default:
+		BUG("invalid output format");
+	}
 
 	stats_table_clear(&table);
 	release_revisions(&revs);
diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
index 315b9e1767..2409edae4f 100755
--- a/t/t1901-repo-stats.sh
+++ b/t/t1901-repo-stats.sh
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
+		git repo stats --format=keyvalue >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err &&
+
+		# Replace key and value delimiters for nul format.
+		tr "\n=" "\0\n" <expect >expect_nul &&
+		git repo stats --format=nul >out 2>err &&
+
+		test_cmp expect_nul out &&
+		test_line_count = 0 err
+	)
+'
+
 test_done
-- 
2.51.0.193.g4975ec3473b

