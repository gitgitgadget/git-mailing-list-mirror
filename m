Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05DA288537
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749078; cv=none; b=k5JjzIRYann/C1PKMYP+IcbOC8NROenyUdnffhGyGQu0SB/wfdajyThye75+AaabR5usOWknuITGVfG7uRCM0CUZMtT7tNW1djh98XKRxG9148U2mLzoxTjWh1szEB+rwHzZYMXs8xZR96eNKkw9qMnT8lU/FVhLX0PMfDuZel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749078; c=relaxed/simple;
	bh=ilC/Y0ekGXXKu58EUGugn/TuPmcfgR4tYB3xQ82vcBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyDc2a1hitiIh4Una4EUZlCkHW/NrfN0fHRPWJ56zw9En9sqU8D63RXMA7G93PW74UctBYCK/8kTXszIOIMiLVEQ0Ej5d8KpdN4NJw0PFB3ra3h2gCQGQMCaeb/UcXEsj+J7l9I9Th92P14UW/J02DfbBPfChyQ/+TazW4kVllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIT0AVJg; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIT0AVJg"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-332e66cd8e4so119698fac.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758749075; x=1759353875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaENoxu9RzKdtZzYHLU9O90kvz8VDYebCToSH/mG/aU=;
        b=XIT0AVJgu5+gJS07N3A4ngSBc8vIb/7hi0zoSE+fcJEP1ncW4tmJwuqDVWYr4DGATb
         UKLasfVIRn6WZ+cYM99LpGrHExB6FHP0sWodaHQXSoUI04My7KCruqHSxHZQpBa7iiVE
         XMXYqWApq17RN5u+IObEMhBm33IjD8klzL1Ovvp37fAJQ6GUFKFLLEW6vL79RCd5DsTU
         aQDhumnKnyK/M/Wr0T7ECr9gTqwksp+YiWwuPf85xu3A5LA+V3cpOK5J9ussbPfeAW9w
         XtwDVy/VlMD8EqlpuqhLQDVOs2e1E3GytXXxZOY8IY2lThKWOLgHWi3Zziy8f+mny95M
         Inww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749075; x=1759353875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaENoxu9RzKdtZzYHLU9O90kvz8VDYebCToSH/mG/aU=;
        b=mUAWLcLEroAzXqh5aR838Nf/G8pMWCb3EKDr/Zi5EWusrGQARWUNli+m2SC8Rk5Le/
         IZrppv66p/I5RIuhZethj59RKkJyEb4OahqF6JWMjeaUg+IzuH2EAhJ6pGkTdFPE6360
         wctE4eNAP5p9HiO/LrzZhhJO0SJjbb6qJHrrf1lgQEcqzJg8NoMbwj0WOHNY7vqJ7w04
         KkLCdU9RLB0EmDao+sRrcYIklbPAX9EhEWibwP46HWsiDCUHVfqMqDMjLxapdd6JfNmG
         7dPkXbZ34MBw8UQK0l1dc1ZRGQx6POX7P+JJYSzQPaQ4W4aw6XlxlV7ERA39ZfXbUHAz
         +vew==
X-Gm-Message-State: AOJu0YzqjQRX16A+jKsmJn++OcWANvvxeZYAhKuJ10ksq3IipdGgbQ1w
	lbMSEAyuosTHdCOdKE5YasU7e6+19t//EYjI8HtxpcJ0zX2Y7tDKBY9VnPd/SA==
X-Gm-Gg: ASbGncvMDCZXcBbirAljrUICTscRiPmPg8StiAUbiFoUtsrjgzSk0awXuj5KRiiD5wS
	K231unTCYXsOwrqjIXIqPjm4WLR8QBB7gF0w5zEbKgx1VvJum5APDo4L1VDPRLoXkAXIoQyOguQ
	Ho1EjExzsEiWSn6n0r7BPuwYeMzLtANYWl5/6NKLFjnrdt71XxWksV+TxJeVNdtatbZXOnbiqL/
	R9csX92UdulR/D3mg1+N1wEmCGNWcZUq3CybBEQdZ3OOC9V+6gg8KOnjOJ9JsoNeCkwZNf3RQI/
	/YNrblg4FrdhiSplbUh06bHnVS10uM6LMFSBBoAZw3DVQ9xFqF9BTKhqS1Mvlsoi87qKSWPSyFD
	FBhnQ7Rh3cfq9SDrrZuhhojJjnCQ7Q1Y=
X-Google-Smtp-Source: AGHT+IHBrsaQ4CIv1kfuKS+68AKKzaxWyuY9YBlk2zM+fC/0fCLImN7pupHIGkQiYkcFtFPPRsrEAQ==
X-Received: by 2002:a05:6808:1528:b0:43f:4b90:c4 with SMTP id 5614622812f47-43f4cdec018mr682889b6e.31.1758749075518;
        Wed, 24 Sep 2025 14:24:35 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f46f5dbdcsm400117b6e.12.2025.09.24.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:24:34 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/6] builtin/repo: add keyvalue and nul format for stats
Date: Wed, 24 Sep 2025 16:24:25 -0500
Message-ID: <20250924212426.2930029-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250924212426.2930029-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
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
 Documentation/git-repo.adoc | 25 +++++++++++++--
 builtin/repo.c              | 62 ++++++++++++++++++++++++++++++++++---
 t/t1901-repo-stats.sh       | 33 ++++++++++++++++++++
 3 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 0b8d74ed3e..db21b75522 100644
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
+	Outputs repository stats in a human-friendly table and is used by
+	default. This format may change and is not intended for machine
+	parsing.
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
index 8f130bca66..fe7d43f78e 100644
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
@@ -312,6 +317,33 @@ static void stats_table_clear(struct stats_table *table)
 	string_list_clear(&table->rows, 1);
 }
 
+static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
+				 char value_delim)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "references.branches.count%c%" PRIuMAX "%c",
+		    key_delim, (uintmax_t)stats->refs.branches, value_delim);
+	strbuf_addf(&buf, "references.tags.count%c%" PRIuMAX "%c",
+		    key_delim, (uintmax_t)stats->refs.tags, value_delim);
+	strbuf_addf(&buf, "references.remotes.count%c%" PRIuMAX "%c",
+		    key_delim, (uintmax_t)stats->refs.remotes, value_delim);
+	strbuf_addf(&buf, "references.others.count%c%" PRIuMAX "%c",
+		    key_delim, (uintmax_t)stats->refs.others, value_delim);
+
+	strbuf_addf(&buf, "objects.commits.count%c%" PRIuMAX "%c",
+		    key_delim, (uintmax_t)stats->objects.commits, value_delim);
+	strbuf_addf(&buf, "objects.trees.count%c%" PRIuMAX "%c",
+		    key_delim, (uintmax_t)stats->objects.trees, value_delim);
+	strbuf_addf(&buf, "objects.blobs.count%c%" PRIuMAX "%c",
+		    key_delim, (uintmax_t)stats->objects.blobs, value_delim);
+	strbuf_addf(&buf, "objects.tags.count%c%" PRIuMAX "%c",
+		    key_delim, (uintmax_t)stats->objects.tags, value_delim);
+
+	fwrite(buf.buf, sizeof(char), buf.len, stdout);
+	strbuf_release(&buf);
+}
+
 static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
 {
 	for (int i = 0; i < refs->nr; i++) {
@@ -389,17 +421,25 @@ static void stats_count_objects(struct object_stats *stats,
 	path_walk_info_clear(&info);
 }
 
-static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
-			  const char *prefix, struct repository *repo)
+static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
+			  struct repository *repo)
 {
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
+	enum output_format format = FORMAT_TABLE;
 	struct repo_stats stats = { 0 };
 	struct ref_array refs = { 0 };
 	struct rev_info revs;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "format", &format, N_("format"),
+			       N_("output format"),
+			       PARSE_OPT_NONEG, parse_format_cb),
+		OPT_END()
+	};
 
+	parse_options(argc, argv, prefix, options, repo_usage, 0);
 	repo_init_revisions(repo, &revs, prefix);
 	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
 		die(_("unable to filter refs"));
@@ -407,8 +447,20 @@ static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
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
index 315b9e1767..d2c1b6e307 100755
--- a/t/t1901-repo-stats.sh
+++ b/t/t1901-repo-stats.sh
@@ -73,4 +73,37 @@ test_expect_success 'repository with references and objects' '
 	)
 '
 
+test_expect_success 'repository stats with keyvalue and nul format' '
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
+		tr "\n" "\0" <expect | tr "=" "\n" >expect_null &&
+		git repo stats --format=nul >out 2>err &&
+
+		test_cmp expect_null out &&
+		test_line_count = 0 err
+	)
+'
+
 test_done
-- 
2.51.0.193.g4975ec3473b

