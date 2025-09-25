Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AE2EFD89
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842982; cv=none; b=ulY3ebSB2F68498SzRV37RjykV4f+990qmFEG4Csd9+cTcJhKgxfi3dO19Dyz5Py56rSCwGEavKP0hEe348ZxoFEM8/hIvRnkI2CsZEA7dqE2k8YWvws/8j91rvFGWoW4MFS4Fle4Zd5TavGyX4IvvDwFzureSf0+F9sLjIsLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842982; c=relaxed/simple;
	bh=ZCNcEtFJK8MKMFygeuHu27hVOJJ5noJjF6IfVv69NXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixFKArOF4eQErVD83SqRlFIEB6/e5dcIGpfpjjeLU+cTEX7w02hPamHcSSwtMD2iAVgEP3HMR6rrnV61xo3fq80eqW0MwS6sBtY+x4t0ruB8LaaKR6r+D7K+0/UdLZnB+gegTBDr/LOl8UnMG+6RanLXJdF3nSJ0MnorEQXE80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoMTMKoe; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoMTMKoe"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cce8c3afaso1360627fac.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842980; x=1759447780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kslP/ZUNNInHYbCe/94YCGaozirRw1DzxlZgTjHUmv0=;
        b=KoMTMKoeOqi/Hjo1Wd9f8VMUKw8Cnz6RBqOqsU2uyXBnQrgvvMoao/lt1JLtgNLZeg
         lgqQ2h3efmcZmqTvoA1OBvKJom5SvMDjz8jD1/EH3V9zr+GvcVIbT5HMNmJnJisaL0kF
         TMq+VWKzW9M9neVAP/1E7nrs8nI7/QVeDbSF9zWrsbAOQpmDDGp5jYPjP0q7CfIdQ9tA
         PHxbicGQl8uxKgUlldiXBm8aPavx62ShL9zKdfiilPIMVRJP9mf4UVys4zR3iQw3wBpe
         GGWv9vo6Xyk+FZiNx9C25u0pSlIW5ovaA0URc27YcvgZ8wiMkfMVId1eE+rMe/Xco66u
         dA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842980; x=1759447780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kslP/ZUNNInHYbCe/94YCGaozirRw1DzxlZgTjHUmv0=;
        b=aCaY+ybK5fxz1iYH5BwZ8aA4mOKPqAw75g9yjWL37EyEPO4qgGK6PPhb1KbzpykZ9J
         KEC+MKO7/efimfachOw+p9LATm4uX4BgUgfLXye4rNQf6E21hSmEgAq6LjmIJNJIKwE8
         AFusx9YPmAob8sJNbEsOcWzQRVhey6/cbq1EvrCbHIZXSXtcC5xy24kxtnkdRNPsuHOM
         qE47w6jPVMDUJMMabgDIPvDH8aj7dBTQUAlQ7eLb0wW8t6gXsVJ7HbNdGuvKm+T9s6bi
         sf8wjGAJT7v5MP4yffDGtv51SfykxIamoTzYy85gxtMsiA5YdM4WeddKrhA2MwKcCwP/
         /47A==
X-Gm-Message-State: AOJu0Ywf9+23giKzh6xN4xGg2V23d9Z4q6pJeLZhRyshW09GMY6BbwGO
	EDeQ910MPo8soFon9bCR2MXUAMw1oKLRZwAme7zwDWvFYAea+65HOGtzDQCo6w==
X-Gm-Gg: ASbGncvk598WKZT+BjiSdPmce9BqJrv9rMwrFcdXorPovFiKdP1du+QPkew9kV2sPIa
	bOBsEEDJZ2IS6dr/11ipu5pFfj638otfeeV5jMuEgaI0NMG+rXIZNcn+RQLjrza1SJfTJm4xKNj
	+1bvreVu5xZ7AI61ER6PG/b2XtRZzrjOWIDyvbRourJIj+9Bx//vSpkQOjILPIqxdkqszgMktGZ
	xe3P3yUNE3wIQWcii3/3dMYNu47bwSgOnk1qYOt8J4u4NOqBfkfovzuhYax5jecfHInD4HfNxGU
	bi4X5vrlSf2/VzySA23JA4zlDn59c/F+nNEculYjPnUZLU7uj/6FzhF7wI/I3jYpHPpG4BPD5Wh
	wNrq/9+BwzJsWykoHvh7fVktFCVVnCIc=
X-Google-Smtp-Source: AGHT+IEIvR53uR3i8jBcmUoqYBGPmYcn+5vc6iBCBCRo1/ED1NjYjmG19I3Svjsq+11VCp+M9ArGEQ==
X-Received: by 2002:a05:6870:fb88:b0:30b:a20a:8799 with SMTP id 586e51a60fabf-35ee8a3715emr2790879fac.27.1758842979707;
        Thu, 25 Sep 2025 16:29:39 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7a2402e5d70sm674273a34.36.2025.09.25.16.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:29:39 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 5/7] builtin/repo: add object counts in stats output
Date: Thu, 25 Sep 2025 18:29:26 -0500
Message-ID: <20250925232928.3846-6-jltobler@gmail.com>
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

The amount of objects in a repository can provide insight regarding its
shape. To surface this information, use the path-walk API to count the
number of reachable objects in the repository by object type. All
regular references are used to determine the reachable set of objects.
The object counts are appended to the same table containing the
reference information.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              | 96 +++++++++++++++++++++++++++++++++++--
 t/t1901-repo-stats.sh       | 51 +++++++++++++-------
 3 files changed, 126 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index a009bf8cf1..0b8d74ed3e 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -49,6 +49,7 @@ supported:
 	of information are reported:
 +
 * Reference counts categorized by type
+* Reachable object counts categorized by type
 
 +
 The table output format may change and is not intended for machine parsing.
diff --git a/builtin/repo.c b/builtin/repo.c
index 0b7dd636e5..43cd6b1b38 100644
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
@@ -166,6 +168,18 @@ struct ref_stats {
 	size_t others;
 };
 
+struct object_stats {
+	size_t tags;
+	size_t commits;
+	size_t trees;
+	size_t blobs;
+};
+
+struct repo_stats {
+	struct ref_stats refs;
+	struct object_stats objects;
+};
+
 struct stats_table {
 	struct string_list rows;
 
@@ -227,8 +241,16 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 	va_end(ap);
 }
 
-static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
+static inline size_t get_total_object_count(struct object_stats *stats)
 {
+	return stats->tags + stats->commits + stats->trees + stats->blobs;
+}
+
+static void stats_table_setup(struct stats_table *table, struct repo_stats *stats)
+{
+	struct object_stats *objects = &stats->objects;
+	struct ref_stats *refs = &stats->refs;
+	size_t object_total;
 	size_t ref_total;
 
 	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
@@ -238,6 +260,15 @@ static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
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
 
 static inline size_t max_size_t(size_t a, size_t b)
@@ -322,30 +353,87 @@ static void stats_count_references(struct ref_stats *stats, struct ref_array *re
 	}
 }
 
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
+static void stats_count_objects(struct object_stats *stats,
+				struct ref_array *refs, struct rev_info *revs)
+{
+	struct path_walk_info info = PATH_WALK_INFO_INIT;
+
+	info.revs = revs;
+	info.path_fn = count_objects;
+	info.path_fn_data = stats;
+
+	for (int i = 0; i < refs->nr; i++) {
+		struct ref_array_item *ref = refs->items[i];
+
+		switch (ref->kind) {
+		case FILTER_REFS_BRANCHES:
+		case FILTER_REFS_TAGS:
+		case FILTER_REFS_REMOTES:
+		case FILTER_REFS_OTHERS:
+			add_pending_oid(revs, NULL, &ref->objectname, 0);
+			break;
+		default:
+			BUG("unexpected reference type");
+		}
+	}
+
+	walk_objects_by_path(&info);
+	path_walk_info_clear(&info);
+}
+
 static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
-			  struct repository *repo UNUSED)
+			  struct repository *repo)
 {
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
-	struct ref_stats stats = { 0 };
+	struct repo_stats stats = { 0 };
 	struct ref_array refs = { 0 };
+	struct rev_info revs;
 	struct option options[] = { 0 };
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
+	repo_init_revisions(repo, &revs, prefix);
 	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
 		die(_("unable to filter refs"));
 
-	stats_count_references(&stats, &refs);
+	stats_count_references(&stats.refs, &refs);
+	stats_count_objects(&stats.objects, &refs, &revs);
 
 	stats_table_setup(&table, &stats);
 	stats_table_print(&table);
 
 	stats_table_clear(&table);
+	release_revisions(&revs);
 	ref_array_clear(&refs);
 
 	return 0;
diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
index 535ac511dd..315b9e1767 100755
--- a/t/t1901-repo-stats.sh
+++ b/t/t1901-repo-stats.sh
@@ -10,14 +10,21 @@ test_expect_success 'empty repository' '
 	(
 		cd repo &&
 		cat >expect <<-\EOF &&
-		| Repository stats | Value |
-		| ---------------- | ----- |
-		| * References     |       |
-		|   * Count        |     0 |
-		|     * Branches   |     0 |
-		|     * Tags       |     0 |
-		|     * Remotes    |     0 |
-		|     * Others     |     0 |
+		| Repository stats    | Value |
+		| ------------------- | ----- |
+		| * References        |       |
+		|   * Count           |     0 |
+		|     * Branches      |     0 |
+		|     * Tags          |     0 |
+		|     * Remotes       |     0 |
+		|     * Others        |     0 |
+		|                     |       |
+		| * Reachable objects |       |
+		|   * Count           |     0 |
+		|     * Commits       |     0 |
+		|     * Trees         |     0 |
+		|     * Blobs         |     0 |
+		|     * Tags          |     0 |
 		EOF
 
 		git repo stats >out 2>err &&
@@ -27,28 +34,36 @@ test_expect_success 'empty repository' '
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
-		| Repository stats | Value |
-		| ---------------- | ----- |
-		| * References     |       |
-		|   * Count        |     4 |
-		|     * Branches   |     1 |
-		|     * Tags       |     1 |
-		|     * Remotes    |     1 |
-		|     * Others     |     1 |
+		| Repository stats    | Value |
+		| ------------------- | ----- |
+		| * References        |       |
+		|   * Count           |     4 |
+		|     * Branches      |     1 |
+		|     * Tags          |     1 |
+		|     * Remotes       |     1 |
+		|     * Others        |     1 |
+		|                     |       |
+		| * Reachable objects |       |
+		|   * Count           |   130 |
+		|     * Commits       |    43 |
+		|     * Trees         |    43 |
+		|     * Blobs         |    43 |
+		|     * Tags          |     1 |
 		EOF
 
 		git repo stats >out 2>err &&
-- 
2.51.0.193.g4975ec3473b

