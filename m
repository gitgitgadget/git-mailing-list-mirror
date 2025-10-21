Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA55351FBB
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071202; cv=none; b=hHG/rECjxSwu/l/nviBfpciB6BkwJq7EUer7QwZYlzSRDAikRN2v15trdAehVP43Uk/rn77NKXWfOtb0GVK7FWDgpp8Xem6VRs/jvzmUk0F4ADbqzUdPLlxAiLbv5a2vuCw7YKGNFrDKHaGWC5zKzBIZjr0KXTYf404V5TVKtGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071202; c=relaxed/simple;
	bh=K7J6D8az0LOm8BOp0MMj40ZRsRpuwHzTCumHs5vWEnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKWyIT/GA73UCpscUGgSjXfvNWwZo+6Ud9fTk9e/3M5ThFGSToz8rGA56C4reDiHRgO8pCO9os0cTVXCWY+0N7VeMZXvS1aup3J+QGKulRuc9opl/qQtYpaKgbu8MyMH3bCMt/8a+4h/NfwUk1SUJ+UNmtLu9dcvSEWnUimhePM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn/s1fzo; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn/s1fzo"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-44181f9e5b4so3543683b6e.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071199; x=1761675999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djMj2YnLDhbcieUhCXvPEBXZ2DD3CkZEyQTurcbSYCw=;
        b=bn/s1fzoDhnf1sj4NwGZlzYw1pQtpw0t93hNZaN/qW6CX+dzhT/XUh0uTVQRIejG38
         bRnLRKdhDioAHlmYm/OWDYs6fG5a72pc8GWjRqOQT5Qq7QBG9EMRdMxBhd8bcS3c8VVk
         uFFVvby7fXbVOSMR44tGbXJiPckxV4MlWyO8bZmLbCEGdot5LS4r7GO7I9dWN5zu+j6a
         2a/X8EjbBY1DS8l4jFQc1613p1BeX5xqPCIOLeRzDFQxqp8gzEA2VDMUkwVrDanxBY2K
         m1ZxWFRg4j9zht/USrIcCmYuRgzWsWn9furjNtVAcqGUZ2HnQZGo0SbzXdIwqlyenIVU
         xogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071199; x=1761675999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djMj2YnLDhbcieUhCXvPEBXZ2DD3CkZEyQTurcbSYCw=;
        b=UeY8xPxa1wpYBj5P4roQzOP0jPawDfQmMaJVWSvza4WbkFRcWxUHb633y4x89ZpRr8
         k3e4NUxrQoLhT8BesA1mm0+mgWS37qVKTQIWkbreo//GA3AX76q/CxftoWG0Ti/5qXS3
         U4UIFi7kbXguYO3KCnjj/DneJVhHxELdreWywKYgGDpDutunLMaBtC61OMpmPDGzkhr8
         vd61GcjY4vr4mVylXGYrrCW3RCWLicFJeKGDO7d2wDcqAPG5HxenDNBiXvsARekrJ15x
         +3vP+Ts9szWcJBb3I5iC81y0kfvZANZx8KlsoBT8PyYSd2WXbMD1XTzUhRTYUVYFquLF
         6JlQ==
X-Gm-Message-State: AOJu0YzIH+EpGkPeXBxcWYXDbM22JnwAA0hDWcKXze4CbGKYeXa3GQ6X
	5i9vRnCDnjrfJvlrMGub0wdZVwPu14mo2B4wAy+ESm+PpBegNHCbVZEXppic6A==
X-Gm-Gg: ASbGnctTF+Hs3rHScknyE33/xaO3K9X/pJlcU7z3QQDiL8XHobqYSA4Oky7347OgoRW
	pM4CGrrWByawd7LaYR17ZFFEkuHoLXfFkKjIBgdNEh67OkdfQUbN3Vzyb7sBipleI9dkB6tEp4+
	tvHoyWF/J6XwpUMMdPU8YE3oOok249wpaz9X52Lsu5IaYKtOCKobi8caCCTv4iD4k4FLXv/+k5w
	4ZL4FolAoBf8wCGqqJ7Rvkh7UaPWHG/Az+679Hza56AUiu8Mz0nhLMa4+a5WdHA3iD40TJ1UW77
	/YFiYpfxMD519LuxQs2vkaKXjfYOkyEWGRi+7atKYK1l4BGtzJRqj2STxw3BqsoffmJltAjqMod
	EcXdKeoKAFwP0N0wJ089k0SRwJDBmrnDkBrsjf0EpJIoFHHATteXC3PRjZAcjEUEG79CdyD0wdc
	LwCBnCiWxX
X-Google-Smtp-Source: AGHT+IGeR4YsIS2a1HwU3wTUi36XNNE+97Nxk5YJtTXKtEX3JxtFOPjOs56mHWtVkKKK8toN+2UV8w==
X-Received: by 2002:a05:6808:7090:b0:443:a2bc:1cef with SMTP id 5614622812f47-443a2ef8527mr5374224b6e.22.1761071198982;
        Tue, 21 Oct 2025 11:26:38 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df722e5csm2795853b6e.24.2025.10.21.11.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:26:38 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v6 5/7] builtin/repo: add object counts in structure output
Date: Tue, 21 Oct 2025 13:25:59 -0500
Message-ID: <20251021182601.2687284-6-jltobler@gmail.com>
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

The amount of objects in a repository can provide insight regarding its
shape. To surface this information, use the path-walk API to count the
number of reachable objects in the repository by object type. All
regular references are used to determine the reachable set of objects.
The object counts are appended to the same table containing the
reference information.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |   1 +
 builtin/repo.c              | 105 +++++++++++++++++++++++++++++++++---
 t/t1901-repo-structure.sh   |  19 ++++++-
 3 files changed, 117 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 8193298dd5..ae62d2415f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -49,6 +49,7 @@ supported:
 	following kinds of information are reported:
 +
 * Reference counts categorized by type
+* Reachable object counts categorized by type
 
 +
 The table output format may change and is not intended for machine parsing.
diff --git a/builtin/repo.c b/builtin/repo.c
index e77e8db563..f39f06ee8c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -3,9 +3,11 @@
 #include "builtin.h"
 #include "environment.h"
 #include "parse-options.h"
+#include "path-walk.h"
 #include "quote.h"
 #include "ref-filter.h"
 #include "refs.h"
+#include "revision.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
@@ -167,6 +169,18 @@ struct ref_stats {
 	size_t others;
 };
 
+struct object_stats {
+	size_t tags;
+	size_t commits;
+	size_t trees;
+	size_t blobs;
+};
+
+struct repo_structure {
+	struct ref_stats refs;
+	struct object_stats objects;
+};
+
 struct stats_table {
 	struct string_list rows;
 
@@ -234,9 +248,17 @@ static inline size_t get_total_reference_count(struct ref_stats *stats)
 	return stats->branches + stats->remotes + stats->tags + stats->others;
 }
 
+static inline size_t get_total_object_count(struct object_stats *stats)
+{
+	return stats->tags + stats->commits + stats->trees + stats->blobs;
+}
+
 static void stats_table_setup_structure(struct stats_table *table,
-					struct ref_stats *refs)
+					struct repo_structure *stats)
 {
+	struct object_stats *objects = &stats->objects;
+	struct ref_stats *refs = &stats->refs;
+	size_t object_total;
 	size_t ref_total;
 
 	ref_total = get_total_reference_count(refs);
@@ -246,6 +268,15 @@ static void stats_table_setup_structure(struct stats_table *table,
 	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
 	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
 	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
+
+	object_total = get_total_object_count(objects);
+	stats_table_addf(table, "");
+	stats_table_addf(table, "* %s", _("Reachable objects"));
+	stats_table_count_addf(table, object_total, "  * %s", _("Count"));
+	stats_table_count_addf(table, objects->commits, "    * %s", _("Commits"));
+	stats_table_count_addf(table, objects->trees, "    * %s", _("Trees"));
+	stats_table_count_addf(table, objects->blobs, "    * %s", _("Blobs"));
+	stats_table_count_addf(table, objects->tags, "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
@@ -299,12 +330,18 @@ static void stats_table_clear(struct stats_table *table)
 	string_list_clear(&table->rows, 1);
 }
 
+struct count_references_data {
+	struct ref_stats *stats;
+	struct rev_info *revs;
+};
+
 static int count_references(const char *refname,
 			    const char *referent UNUSED,
-			    const struct object_id *oid UNUSED,
+			    const struct object_id *oid,
 			    int flags UNUSED, void *cb_data)
 {
-	struct ref_stats *stats = cb_data;
+	struct count_references_data *data = cb_data;
+	struct ref_stats *stats = data->stats;
 
 	switch (ref_kind_from_refname(refname)) {
 	case FILTER_REFS_BRANCHES:
@@ -323,13 +360,64 @@ static int count_references(const char *refname,
 		BUG("unexpected reference type");
 	}
 
+	/*
+	 * While iterating through references for counting, also add OIDs in
+	 * preparation for the path walk.
+	 */
+	add_pending_oid(data->revs, NULL, oid, 0);
+
 	return 0;
 }
 
 static void structure_count_references(struct ref_stats *stats,
+				       struct rev_info *revs,
 				       struct repository *repo)
 {
-	refs_for_each_ref(get_main_ref_store(repo), count_references, &stats);
+	struct count_references_data data = {
+		.stats = stats,
+		.revs = revs,
+	};
+
+	refs_for_each_ref(get_main_ref_store(repo), count_references, &data);
+}
+
+
+static int count_objects(const char *path UNUSED, struct oid_array *oids,
+			 enum object_type type, void *cb_data)
+{
+	struct object_stats *stats = cb_data;
+
+	switch (type) {
+	case OBJ_TAG:
+		stats->tags += oids->nr;
+		break;
+	case OBJ_COMMIT:
+		stats->commits += oids->nr;
+		break;
+	case OBJ_TREE:
+		stats->trees += oids->nr;
+		break;
+	case OBJ_BLOB:
+		stats->blobs += oids->nr;
+		break;
+	default:
+		BUG("invalid object type");
+	}
+
+	return 0;
+}
+
+static void structure_count_objects(struct object_stats *stats,
+				    struct rev_info *revs)
+{
+	struct path_walk_info info = PATH_WALK_INFO_INIT;
+
+	info.revs = revs;
+	info.path_fn = count_objects;
+	info.path_fn_data = stats;
+
+	walk_objects_by_path(&info);
+	path_walk_info_clear(&info);
 }
 
 static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
@@ -338,19 +426,24 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
-	struct ref_stats stats = { 0 };
+	struct repo_structure stats = { 0 };
+	struct rev_info revs;
 	struct option options[] = { 0 };
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
-	structure_count_references(&stats, repo);
+	repo_init_revisions(repo, &revs, prefix);
+
+	structure_count_references(&stats.refs, &revs, repo);
+	structure_count_objects(&stats.objects, &revs);
 
 	stats_table_setup_structure(&table, &stats);
 	stats_table_print_structure(&table);
 
 	stats_table_clear(&table);
+	release_revisions(&revs);
 
 	return 0;
 }
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index e592eea0eb..c32cf4e239 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -18,6 +18,13 @@ test_expect_success 'empty repository' '
 		|     * Tags           |     0 |
 		|     * Remotes        |     0 |
 		|     * Others         |     0 |
+		|                      |       |
+		| * Reachable objects  |       |
+		|   * Count            |     0 |
+		|     * Commits        |     0 |
+		|     * Trees          |     0 |
+		|     * Blobs          |     0 |
+		|     * Tags           |     0 |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -27,17 +34,18 @@ test_expect_success 'empty repository' '
 	)
 '
 
-test_expect_success 'repository with references' '
+test_expect_success 'repository with references and objects' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
 		cd repo &&
-		git commit --allow-empty -m init &&
+		test_commit_bulk 42 &&
 		git tag -a foo -m bar &&
 
 		oid="$(git rev-parse HEAD)" &&
 		git update-ref refs/remotes/origin/foo "$oid" &&
 
+		# Also creates a commit, tree, and blob.
 		git notes add -m foo &&
 
 		cat >expect <<-\EOF &&
@@ -49,6 +57,13 @@ test_expect_success 'repository with references' '
 		|     * Tags           |     1 |
 		|     * Remotes        |     1 |
 		|     * Others         |     1 |
+		|                      |       |
+		| * Reachable objects  |       |
+		|   * Count            |   130 |
+		|     * Commits        |    43 |
+		|     * Trees          |    43 |
+		|     * Blobs          |    43 |
+		|     * Tags           |     1 |
 		EOF
 
 		git repo structure >out 2>err &&
-- 
2.51.0.193.g4975ec3473b

