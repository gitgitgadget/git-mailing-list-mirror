Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97E2E7F21
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984663; cv=none; b=EXYH8uez/E/wnzA+QSufPxuZJBI0SiGeFf8IUwGhOKEX6cw3lPYc81NQ9g02VZ6Lqq506PheemFP1zLVaPGdvwvNAHsALY0sI7A4I0P7fq7Y/9kBGQsOsJII8YpQNQsRzHnhNel7CdX5paIb96GtCKVIHbV0wp84phqJ/njG1MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984663; c=relaxed/simple;
	bh=HYY4xq3tIQiBlJQRJP73+gRI7PskY20L5fZhW1bCTFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1feY0JmyMncmcx5S/iUZFZy/GvMeruYsorILWo9iQoLmNJkJcjfKJttOGQQimFsaBSiDag7XW9toeJtdIOx+wMQen1ts8c0or7DvsCu5/tAojzvfJJGzpNssWPfNKyUp8uU5RsVrHI5fCYks3VeMlpjFowSsN27LmrxlrzgjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeMGYu0A; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeMGYu0A"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3729f8eaa10so534832fac.3
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758984660; x=1759589460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSZ2RkVZ5ZH0gD9pZWigOJJw+wxCFbkjcmBTRbjN8ec=;
        b=TeMGYu0AvlUm38ai4mvM/cR5uxTCGZt1iNIhe5L1V7EIqg06EYPG0vniJDRXUmpVF3
         9PDDixEzcRG3nnmmWnOQnmB+PLARD9fm0nL50S7/0semvfFOMh9Rs7Jc94RYoXcghRKI
         +rJtsMJWsw5hgWVILFqlT2Zg8Sdn4eq4kqg+ckaH4mQfnmvL4MOg7vj/CmR84q+dGs29
         /IOhMmaqIglCfgO5vmtbsltrOzF0jqyr/DShcLHAklx2KuwfdpIQwymHKvxbvE6X/8Q1
         UXbnwL6z2bY/dEmuXqZ8GohRijz2c0ebblvKEs955MoSzOEDCXft1WLiVm58Pf1Bd8Rn
         1/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758984660; x=1759589460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSZ2RkVZ5ZH0gD9pZWigOJJw+wxCFbkjcmBTRbjN8ec=;
        b=qEmnuc5RScemV90/tnSjaH+a7b6JIudqYZmTn7KW+NxtQ9mXzkDWkvemxUuuD0PlnF
         oXOV9BYgj+NjkRydC9paHPntb97hHk9CpF0HfcOJIIIwe/vIbmhDZ+9fyBIeqpApNZKH
         fu3zTqX0BExbcRD9yfAG6gwY69bCsE5ZpaHGPwXnwlub5NmgDyG4/nwvCyJyLzDGjsqM
         TY4rxJPqisk0waTQPDsnH34ZIuIwe9ydQsQNGttEvdactdubMift9MaCCzIds1J209ae
         /DbkCtu7jyBVAHuj+NtohOlogWaE6CKnuzG3oPWJ3ZW2P2VkRpwfUW5O86TUMGXMhIOH
         MoAw==
X-Gm-Message-State: AOJu0YzDKN6nBo0/aB0IrmspTygKqtXXIhYeJaxnS7+i1WVa5iOmGMqp
	21PRkpfDHBKVGWAIJw73AKoWODJyePHN3y/VpvI3ITeZ9hIIYYQuOrxAbYlYbg==
X-Gm-Gg: ASbGncvtFeLq3V5bjtG6xJcp7F6fC5rjlTifAzXOTqH+HDceqQmTDaj2/OoiZ9KbzUC
	a5E0xMpgFywjZ5uYTI3373U0LL+Q4Y+LS9nfEwKfmgaJJadFHcKKj45nxEBFAyLEtsGN+TQcWjK
	014tcSf9jSE4bnuCTepmV9oZMSprwVEUpNKJbY9glTHdVGZFlzVLAoVAStC/7tkMs35tCgqY8SZ
	sMkJXEH5r967/VLKLKi2mtZKGyppPUAbKXKxYlpPlq5XSz2qvZhZiKzaE8P6fzeqIOIWFsv0AmB
	2D6VsgfZNfwPBhtGVcrH2jUuY9t1UOaN9zTKus0I6VCBe87uRLgYSNssgaRZIxgy1YPMUfyI5Vn
	S8gfBq5UjIvWHWmOrorfCRETkIofGWgQ0JDC104UamA==
X-Google-Smtp-Source: AGHT+IHrnVYSoNlYBPjoCRpOs27mn5TlMO3CakP3MGoa0xNDIl/7XQcRxDKaUnMf/QCMX4dUIU32TQ==
X-Received: by 2002:a05:6808:f93:b0:43d:20c9:974f with SMTP id 5614622812f47-43f4cc5898amr5340814b6e.12.1758984659840;
        Sat, 27 Sep 2025 07:50:59 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51258cf1sm1345401b6e.29.2025.09.27.07.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:50:59 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 5/7] builtin/repo: add object counts in stats output
Date: Sat, 27 Sep 2025 09:50:47 -0500
Message-ID: <20250927145049.723341-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250927145049.723341-1-jltobler@gmail.com>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
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
index 889e344f15..3eefbeddba 100644
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
+struct repo_stats {
+	struct ref_stats refs;
+	struct object_stats objects;
+};
+
 struct stats_table {
 	struct string_list rows;
 
@@ -229,8 +243,16 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
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
@@ -240,6 +262,15 @@ static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
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
@@ -324,30 +355,87 @@ static void stats_count_references(struct ref_stats *stats, struct ref_array *re
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

