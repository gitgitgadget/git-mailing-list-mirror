Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBDA3016E7
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562746; cv=none; b=nDkSLUOSRJelpLhQoWc6iCFBinoJa0RroyftulrJO/zHWKK0NwtvYV0C89LXidbuPSexqh6VnW0L89vqjyP5ZURg4qy71wH+jvZctPwvIbc3AZ1kZ8HO6AJtGzCtPcgrrqsnmK7NfRAQdtUMNpcwq9KLElAqctW8JbY+mpdLrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562746; c=relaxed/simple;
	bh=4Wkz6UWGTSGnJbllSwQ9Ns3Kv7xE1GvvUstEk1dFO4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQZNHDBDbksWM1F1Kg6dzcnMhmu2mTa8GW3OsBH1uH4oAnngwVLr1RkHtJZFTzIbkWoPz9pO1RzB+omOAjK69Iw6SRg+oo3guSr4XNU1ViSteeQ0qgd5B7XfG7o8+3o9sSzulLcvdg993zbTjApJffuvgPLhKWc3fndycvCR5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSHF55o3; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSHF55o3"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3c917ea655bso49529fac.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760562743; x=1761167543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR/p7ROQtlvJ+1PPW2/dBq1LitiAGqKM5f5k6evzfzc=;
        b=BSHF55o3Gk7jM6aFOxVzVUW+DDBevWfXQdjKVC6+Mbun0AF9tDJ+edKVAEpW38Eh2w
         Wrv7Ll1YZ5Rf+/7UcEyx1QcE4EnyooEDGzb7rzoFRkLBJ7dG8KbRvvI1LgHd3fLk99bw
         W5Vql4WHEhOMx4nUM2NApG2YpYX1ko92gP7Nj6tjJLYpacayd7ucF3IUR56Mde3CuIya
         5c15kYUv+TBEMRlA0hBs6GAqjReFWW2oAKlW1ax+jUOwSoCjFlwtnwHrlzf+hSmwO/ds
         nr+igJkFBk+MHAZq3vKgJVaUAF4aDJvikimqlki4iRjOvJu178o9GiOqZiNPNNTkQhC7
         IuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562743; x=1761167543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR/p7ROQtlvJ+1PPW2/dBq1LitiAGqKM5f5k6evzfzc=;
        b=Q7SsDjHuzZzII7jY/qoZs74gG/NQXG5WTZqg5p+Vr8/6Yy2PD9t7LXoJt5Lb0RhD56
         FDqg0AtRaCK+gdeiv/903Z+CrbWf5+nXjMg2wuinNlvvy/EcIaDBlFvbfd+rS866Qpow
         ml4TN27q5KJY06d2k4CXT8sjges9rC3ZyC8rxDb0JFTgn/MDeIScDADM1XlsM2Ln0XvJ
         3gp/dCt9cSAYiG6D8DGnOmizBcGJUJg3engZOIFz/oimIZc9h3e8P2TiCAy4RKZd+NNH
         hK2qN+kaBB5P0bykZtf4NrgR2iUzK2cRBSS37LiL2OFxK3buPMbhud3IxRhy8g7TgPwR
         5cgw==
X-Gm-Message-State: AOJu0Yzr6NWWzyaAbZEz59Y7w0AkcKKV1/QfFDQknXhlZiyA5fHN4lCe
	ycfrDu4M/jfrn2dl+kEAKelFUb99rLP3am0K6GdjHyweqCz1YR717u4fDsf54Q==
X-Gm-Gg: ASbGnctmVxJUfPc6TtG9B9GjzDVeR7tOGZOwHHS4Y/5uvXPLDGIzq0RhNa6ZU98l1d1
	x7UogZGWDsOQTkXnTi37km/X+K+P0DmXVMX7wFW/DEu1K0w8YQ2sq471Phbuny9apWI71tZrwJ0
	TreL+SVBX+vF6FectsDPvhcXLK/5sPx8Lc66gel7RhrP+XSBN2/CgLA5CvUV8FotXo/XPxTD0jc
	vhmj41f3tV7rS77CZFeFpWWmukT105ZHy8jaygUnWvw5Rdv6GWwoDf2GzHjGTtRVf+IHQdSQ5Im
	6c1ROxuIVETn2NGqewiembxmia8ZuItSC+UMftuaCEZgeiO92oMzoifcMX5fk/BIfqrkydHt0MG
	yN3wRrkWVAn1fyy1qqvCNL8qpSPPj9CkiEazV9v6bNeyp60gYzMQ6zGqdjPPWTMrQqiXzjGMWA9
	JEOaN2ew9Q
X-Google-Smtp-Source: AGHT+IHvuQNaEq30YFoCBLX2LrvWvwAw8RGZtUIRRqtNesTj/2oqC87tSNrGOV/Y5q1HPiXICwaqRw==
X-Received: by 2002:a05:6871:807:b0:31d:8e95:2f0d with SMTP id 586e51a60fabf-3c0f62f8497mr16278870fac.2.1760562743458;
        Wed, 15 Oct 2025 14:12:23 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8eecb2bsm5806932fac.20.2025.10.15.14.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:12:22 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 5/6] builtin/repo: add keyvalue and nul format for structure stats
Date: Wed, 15 Oct 2025 16:12:12 -0500
Message-ID: <20251015211213.361797-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251015211213.361797-1-jltobler@gmail.com>
References: <20250927145049.723341-1-jltobler@gmail.com>
 <20251015211213.361797-1-jltobler@gmail.com>
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
index 0bc3c1e458..6bf93b6da8 100644
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
@@ -325,6 +330,30 @@ static void stats_table_clear(struct stats_table *table)
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
 static void structure_count_references(struct ref_stats *stats,
 				       struct ref_array *refs)
 {
@@ -411,10 +440,16 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
+	enum output_format format = FORMAT_TABLE;
 	struct repo_structure stats = { 0 };
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
@@ -427,8 +462,20 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	structure_count_references(&stats.refs, &refs);
 	structure_count_objects(&stats.objects, &refs, &revs);
 
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

