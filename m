Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC4273D6B
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596231; cv=none; b=Q3SjEDzxDDyZiMjWy+5krWlfzFxNqPXxwYJGJcu/BO41ddp5CPqViv6BJgPlttmT8uyWlF8RHchXL3ou1VmLoBTzwIpx+sqfzlYJk785Bfu7RkBPO8fC/Pv5meNKKXTu0OUP56Xmuaa/tX9C0lsLda2yCUm8QX7ruHDOHpneBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596231; c=relaxed/simple;
	bh=R8AQuVdbGSvkBbEsfe08O1N91s5YUqv0u8iTt5wk21A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joWQUsrUCX/iVnC7x0sGZyWLaA9D849Kb4d5ITh+ZLTTFReoCe1tKYx2g4pJ25YBxk08cETrlNreNIrJtGFKDPT85WzaVmXESXiyOOnuGO4B/buxXqwCr4JgBcySlJoFZR7D7t3vZRTurDYBeTLOCyDzd5zZePBP5cbP+vYx1FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X975kD6b; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X975kD6b"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-34207c1bdaeso697747fac.3
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758596228; x=1759201028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B/UXK0Ol5iNDoG+ollEGtO7DalANRYPSM8hSLtkGoI=;
        b=X975kD6bKxlkC+Rpf55SsruU6GywFCB+DI8WYEuASbCNBO2GSb5Ii3dE8KRULqUNrm
         CAKw/nA5tMjN4Ahvu0i2N6IOXbihisNXRhL6L4N7oLI5lRs+q2SGWthrQ3wgt5LjFfrF
         /yXEABjt1T7oPk6AKKey8bSIkMJwhPfcjUKvhVqrPPev6yWrEPJa1mNljEQJnieImk1a
         xPuYVxHcVhhHVq7k0HjCWpi5l08BhLWVPYFHAB9nL4Wg5+MBhAF1R3hJETN/vqFIQQVh
         +KTnovBYpdgozh7PcOueoWVIN4+ZdZhYzkpiN3Xapz63MliZLowg0LnOK4hfE1ALf7tP
         JWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758596228; x=1759201028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B/UXK0Ol5iNDoG+ollEGtO7DalANRYPSM8hSLtkGoI=;
        b=EaN3dASu8ngyWbPx0tiKWM6lSlnQpap5Z2mhEA0NjVaYDYfmsY49RWCbT4Ztejhlo8
         G5ddqmmy4dpHTdqhbtvEMvC9c1FJ3c/Uup7QL9Kw41f9AMMphuHWnJ/KgXMRlrOTThDP
         TM8Fa48rs1Rk0UBQQ83KwxdmpMx6TojtATGePrxHABsWDsmvETuYlSuhreeJFYM5v2u0
         HTmem+ti0tnXcpEHu4U/qgufL14e4GYYcFWkM01qF14Ty9qvGX+EMTnpSqSTP7t/E7Uj
         viGMTuv9muQyusvte2l7sEYWGU0+HA8GS9KggFaVAJnFpD6w9ZObt6C6Z9woLYXJ/YM6
         V6FA==
X-Gm-Message-State: AOJu0YxHApquRwTt+igOzOPowY1/lj6QfOC+yv4VKYjccphYQjwEaADC
	U/sYK9kn0NeyMaiK1OdGRS/A6hUy/u7YSR7uNjqupJCt5QVywPApc9yRZ8JdSQ==
X-Gm-Gg: ASbGncsD0pBWva5aWldn2wn4Es21Ze0zbZP9cz/TeX960Gs3W5Z7XyYP3rB/XKSG4+z
	4XuEsrhA2ZanbpNGOnqCNfLbYsc16kcshXGf/NkZGOEpgS6Wj64jWYXK/Q6dGCq47a7O1yw+2JC
	tbl17l4E5Xv1KYvsfkjnTQt0bYZ7bdjLNLMasDSUFthywNZ/lU1JTputy60Z8NYNROVZCGC/uS9
	PinUx8q3ypPRpjRzO3oWAvnry7UIH0B1A0avG6tK9oZv4kWln7ccwhHMndnUiK5QZkq8/+2qbF1
	XMbQTkR1/VC+t1oWroRe09F0gVHUHykwYCxSTQdZY5aEtWNUZ5Pu50b4VAsvD43kwRXenUaisa5
	JKBAW+nREfQM2E/uhGxNvt553AMmEVwc=
X-Google-Smtp-Source: AGHT+IHN+znuI2zYjcQow1D7DhAHv6jELOuHn12Rl7WMHKZcv2zaLaU8vKgOY6ChMuPyQW0SNC3buw==
X-Received: by 2002:a05:6870:4209:b0:348:d760:6f0 with SMTP id 586e51a60fabf-34c776685ffmr479572fac.1.1758596228331;
        Mon, 22 Sep 2025 19:57:08 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692936963esm6431664a34.23.2025.09.22.19.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:57:07 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/4] builtin/repo: add keyvalue format for stats
Date: Mon, 22 Sep 2025 21:56:59 -0500
Message-ID: <20250923025700.3046260-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250923025700.3046260-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All repository stats are outputted in a human-friendly table form. This
format is not suitable for machine parsing. Add a --format option that
supports two output modes: `table` and `keyvalue`. The `table` mode is
the default format and prints the same table output as before. With the
`keyvalue` mode, each line of output contains a key-value pair of a
repository stat. The '=' character is used to delimit between keys and
values. This mode provides output that is more machine-friendly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc | 16 ++++++++--
 builtin/repo.c              | 61 ++++++++++++++++++++++++++++++++++---
 t/t1901-repo-stats.sh       | 25 +++++++++++++++
 3 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 2a67abfca8..7d0341e4f1 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
-git repo stats
+git repo stats [--format=(table|keyvalue)]
 
 DESCRIPTION
 -----------
@@ -44,12 +44,22 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
-stats::
+`stats [--format=(table|keyvalue)]`::
 	Retrieve stats about the current repository. All references and
 	reachable objects in the repository are categorized and counted
 	accordingly.
 +
-The table output format may change and is not intended for machine parsing.
+The output format can be chosen through the flag `--format`. Two formats are
+supported:
++
+`table`:::
+	Outputs repository stats in a human-friendly table and is used by
+	default. This format may change and is not intended for machine
+	parsing.
+
+`keyvalue`:::
+	Each line of output contains a key-value pair of a repostiory stat. The
+	'=' character is used to delimit between the key and the value.
 
 INFO KEYS
 ---------
diff --git a/builtin/repo.c b/builtin/repo.c
index a24ea0e66b..4c16a68e4e 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -14,13 +14,14 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
-	"git repo stats",
+	"git repo stats [--format=(table|keyvalue)]",
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
 
@@ -157,6 +160,8 @@ static int repo_info(int argc, const char **argv, const char *prefix,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	if (format == FORMAT_TABLE)
+		die(_("table format not supported"));
 
 	return print_fields(argc, argv, repo, format);
 }
@@ -286,6 +291,32 @@ static void stats_table_print(struct stats_table *table)
 	strbuf_release(&buf);
 }
 
+static void stats_print(struct stats *stats)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "references.branches.count=%" PRIuMAX "\n",
+		    (uintmax_t)stats->refs.branches);
+	strbuf_addf(&buf, "references.tags.count=%" PRIuMAX "\n",
+		    (uintmax_t)stats->refs.tags);
+	strbuf_addf(&buf, "references.remotes.count=%" PRIuMAX "\n",
+		    (uintmax_t)stats->refs.remotes);
+	strbuf_addf(&buf, "references.others.count=%" PRIuMAX "\n",
+		    (uintmax_t)stats->refs.others);
+
+	strbuf_addf(&buf, "objects.commits.count=%" PRIuMAX "\n",
+		    (uintmax_t)stats->objects.commits);
+	strbuf_addf(&buf, "objects.trees.count=%" PRIuMAX "\n",
+		    (uintmax_t)stats->objects.trees);
+	strbuf_addf(&buf, "objects.blobs.count=%" PRIuMAX "\n",
+		    (uintmax_t)stats->objects.blobs);
+	strbuf_addf(&buf, "objects.tags.count=%" PRIuMAX "\n",
+		    (uintmax_t)stats->objects.tags);
+
+	fwrite(buf.buf, sizeof(char), buf.len, stdout);
+	strbuf_release(&buf);
+}
+
 static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
 {
 	for (int i = 0; i < refs->nr; i++) {
@@ -359,9 +390,16 @@ static void stats_count_objects(struct object_stats *stats,
 	path_walk_info_clear(&info);
 }
 
-static int repo_stats(int argc UNUSED, const char **argv UNUSED,
-		      const char *prefix, struct repository *repo)
+static int repo_stats(int argc, const char **argv, const char *prefix,
+		      struct repository *repo)
 {
+	enum output_format format = FORMAT_TABLE;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "format", &format, N_("format"),
+			       N_("output format"),
+			       PARSE_OPT_NONEG, parse_format_cb),
+		OPT_END()
+	};
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct strvec ref_patterns = STRVEC_INIT;
 	struct stats_table table = { 0 };
@@ -369,6 +407,10 @@ static int repo_stats(int argc UNUSED, const char **argv UNUSED,
 	struct stats stats = { 0 };
 	struct rev_info revs;
 
+	parse_options(argc, argv, prefix, options, repo_usage, 0);
+	if (format == FORMAT_NUL_TERMINATED)
+		die(_("nul format not yet supported"));
+
 	repo_init_revisions(repo, &revs, prefix);
 	filter.name_patterns = ref_patterns.v;
 	filter_refs(&refs, &filter, FILTER_REFS_REGULAR);
@@ -376,8 +418,17 @@ static int repo_stats(int argc UNUSED, const char **argv UNUSED,
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
+		stats_print(&stats);
+		break;
+	default:
+		BUG("not a valid output format: %d", format);
+	}
 
 	string_list_clear(&table.rows, 1);
 	strvec_clear(&ref_patterns);
diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
index c6a7f08be5..5bc6d9d5c4 100755
--- a/t/t1901-repo-stats.sh
+++ b/t/t1901-repo-stats.sh
@@ -102,4 +102,29 @@ test_expect_success 'repository stats with objects' '
 	)
 '
 
+test_expect_success 'repository stats with keyvalue format' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 42 &&
+		git tag -a foo -m bar &&
+		git repo stats --format=keyvalue >out 2>err &&
+
+		cat >expect <<-EOF &&
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
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
 test_done
-- 
2.51.0.193.g4975ec3473b

