Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804B36C5B9
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157119; cv=none; b=NofU0HJd3x9h8KVMGgVrtC7CXx/tO2QPx/8x98ppYNSfov0su8lzohYITwLhqvd1rF70HACorYjhkzhp/XrrNpCsyQJdfAYA53OPFRtSY7jmg7S72CWL/rK1TQIriEu1yYWLH6fcIVTnm70667oj3OSlF1WhlUQPIiy9mWjjtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157119; c=relaxed/simple;
	bh=jGH4K3DnO7EwoSXde6NtvVlN1nV1TO6+yn8df+5nrJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsQzPn5zXSI3VWFigrv84JknaVnrX+R3b3ZwNA3skcH+gRqLZdHLHBf2aFr3ALRzb0zDFh1bpRITFI53DqiXUUtxlHd1kCHHLVXFI4B8MVpstO/yZjZsPVQSRUJzZzOe72tUruYEoAIjiWwvCc5ftS2XdiuJ5rZIDlAaX105dWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdC8uJOj; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdC8uJOj"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40959ad00f2so4276553fac.3
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770157116; x=1770761916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvrmB9NNX+5ES7hJl/0JtXYNvWiYAQ//2C3JeRpec3Y=;
        b=RdC8uJOj6RDeRrtfVoBd8VKx4WDf03uvo+UcB92GlCrvQ2l8Hh+PXTV3f154ezVP89
         ebW7jRuENgB1X9QxRzk1VfRSmKCG/S9KRigz7r9pQsuGwO5jtA8hlZxPEqPwnN/TZc9V
         vlAUpQatgZGX7N67BoSNz0UegR7JDVot88+b3AQnQMT1i9mPMxSR3CPVWp6qfZOzhHED
         baEqRY5krlqpAfM6OYNcc7YTbza2UpP9h4Lw+qM99MhKhQbVI2JPlkx4RaNwvoq67bJr
         F831kpD62MpQR3AHwRp/mcN1JeECXDDK6Fgam7v+rPoHoMyZ1pJJG825voKtQDcc2qxe
         dbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770157116; x=1770761916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xvrmB9NNX+5ES7hJl/0JtXYNvWiYAQ//2C3JeRpec3Y=;
        b=W8rGINASogGD+QcnHzWawpt24XXkrxDu71t6P4pXGa0zqTrZlvPNFxxbpJpx9ZmTEc
         KuyGh2AmZAcU7lbbr7FszTBzHBXT0chuFqPXmelit28NsyKzUGB8BkOwQ0GuwguE1DjD
         CGIy1553CUGuyM8UUcYLDnl39BJ8em16V+3pUA/wJNcuYLLarwKpocK04IArdQrfQPpi
         5ww7Rr4cKQahbZBNuPYCrYz2h6CtZu/YH0T6xorL41o4vXaQOoSfexrn9jtrRyoGZtYu
         uyilYU4Yqm1PFClxDDuQ+uG7HHWf8nesmZClP1SCAQpSrQd2zRhOCRRfULUYwtjn/0+j
         WzOw==
X-Gm-Message-State: AOJu0YwyhgA5oYVTPRvTfSeHQ2b896Zb5ix4pvEq/PDyaGiL6AgH07Yn
	qtc6zMKkauuVdXIM71sIUfsHAkCm6/olVzMu2GYH4WUriPWQt73NWXq32/pnjA==
X-Gm-Gg: AZuq6aIE6PyL3WOCfxraeWZbGN9dR3yWa8yGpXXgYcWDoMb1OYoNpjDoaEN+otqria5
	627ooDmgJ2iXTzbg2xfgvlYlpP9MC3DvHN0p/GU+tUjF2FSI1c4y+mEsn/HKhOlLgBU41F4hpK9
	tRzveCU3Ue6SWlRd0Nt+eTmWY6iZKeAWs6BppuSld5k38Lna10rJySsSCVPhr5/7mzdk8xWdXki
	oBQZ98/6cTXYcyEbeRlfrOBK2r+UUUtALJ9x4aAgaiEzLB2pFzI2ACq7zhP0Hs5Yxh8VtFMJljk
	K8xdXSZSRG5jWuQlgjCUdj+wH2dVKseGLgZE4i6KRDi9gx7fBUYILpeVrSLRdibn587rgVhM+tG
	N0L8FNcsp1+x6ocOCI64f2qE8KGAZAHw6UXFF35n/+G3w2iXxwCgjfieLbFFKnShPJuF47OH0oE
	+PfUR6S7y6KAnd84aAKRw=
X-Received: by 2002:a05:6870:f209:b0:409:8bfb:c7ba with SMTP id 586e51a60fabf-40a53ef1800mr486892fac.37.1770157116277;
        Tue, 03 Feb 2026 14:18:36 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a53c3c4dasm479042fac.0.2026.02.03.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 14:18:35 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/5] builtin/repo: find commit with most parents
Date: Tue,  3 Feb 2026 16:17:57 -0600
Message-ID: <20260203221758.1164434-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203221758.1164434-1-jltobler@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complex merge events may produce an octopus merge where the resulting
merge commit has more than two parents. While iterating through objects
in the repository for git-repo-structure, identify the commit with the
most parents and display it in the output.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            |  47 ++++++++++++
 t/t1901-repo-structure.sh | 151 ++++++++++++++++++++------------------
 2 files changed, 125 insertions(+), 73 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 6fc2d9db12..dc1ac7ad3b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "commit.h"
 #include "environment.h"
 #include "hash.h"
 #include "hex.h"
@@ -208,6 +209,8 @@ struct largest_objects {
 	struct object_data commit_size;
 	struct object_data tree_size;
 	struct object_data blob_size;
+
+	struct object_data parent_count;
 };
 
 struct ref_stats {
@@ -318,6 +321,27 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 	va_end(ap);
 }
 
+static void stats_table_object_count_addf(struct stats_table *table,
+					  struct object_id *oid, size_t value,
+					  const char *format, ...)
+{
+	struct stats_table_entry *entry;
+	va_list ap;
+
+	CALLOC_ARRAY(entry, 1);
+	humanise_count(value, &entry->value, &entry->unit);
+
+	/*
+	 * A NULL OID should not have a table annotation.
+	 */
+	if (!is_null_oid(oid))
+		entry->oid = oid;
+
+	va_start(ap, format);
+	stats_table_vaddf(table, entry, format, ap);
+	va_end(ap);
+}
+
 static void stats_table_size_addf(struct stats_table *table, size_t value,
 				  const char *format, ...)
 {
@@ -425,6 +449,10 @@ static void stats_table_setup_structure(struct stats_table *table,
 				     &objects->largest.commit_size.oid,
 				     objects->largest.commit_size.value,
 				     "    * %s", _("Maximum size"));
+	stats_table_object_count_addf(table,
+				      &objects->largest.parent_count.oid,
+				      objects->largest.parent_count.value,
+				      "    * %s", _("Maximum parents"));
 	stats_table_addf(table, "  * %s", _("Trees"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.tree_size.oid,
@@ -587,6 +615,11 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.max_size_oid%c%s%c", key_delim,
 	       oid_to_hex(&stats->objects.largest.tag_size.oid), value_delim);
 
+	printf("objects.commits.max_parents%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.largest.parent_count.value, value_delim);
+	printf("objects.commits.max_parents_oid%c%s%c", key_delim,
+	       oid_to_hex(&stats->objects.largest.parent_count.oid), value_delim);
+
 	fflush(stdout);
 }
 
@@ -674,16 +707,24 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 	for (size_t i = 0; i < oids->nr; i++) {
 		struct object_info oi = OBJECT_INFO_INIT;
 		unsigned long inflated;
+		struct commit *commit;
+		struct object *obj;
+		void *content;
 		off_t disk;
+		int eaten;
 
 		oi.sizep = &inflated;
 		oi.disk_sizep = &disk;
+		oi.contentp = &content;
 
 		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
 						  OBJECT_INFO_QUICK) < 0)
 			continue;
 
+		obj = parse_object_buffer(the_repository, &oids->oid[i], type,
+					  inflated, content, &eaten);
+
 		switch (type) {
 		case OBJ_TAG:
 			stats->type_counts.tags++;
@@ -693,11 +734,14 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 				      inflated);
 			break;
 		case OBJ_COMMIT:
+			commit = object_as_type(obj, OBJ_COMMIT, 0);
 			stats->type_counts.commits++;
 			stats->inflated_sizes.commits += inflated;
 			stats->disk_sizes.commits += disk;
 			check_largest(&stats->largest.commit_size, &oids->oid[i],
 				      inflated);
+			check_largest(&stats->largest.parent_count, &oids->oid[i],
+				      commit_list_count(commit->parents));
 			break;
 		case OBJ_TREE:
 			stats->type_counts.trees++;
@@ -716,6 +760,9 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		default:
 			BUG("invalid object type");
 		}
+
+		if (!eaten)
+			free(content);
 	}
 
 	object_count = get_total_object_values(&stats->type_counts);
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 918af7269f..d003d64a8e 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -27,41 +27,42 @@ test_expect_success 'empty repository' '
 	(
 		cd repo &&
 		cat >expect <<-\EOF &&
-		| Repository structure     | Value  |
-		| ------------------------ | ------ |
-		| * References             |        |
-		|   * Count                |    0   |
-		|     * Branches           |    0   |
-		|     * Tags               |    0   |
-		|     * Remotes            |    0   |
-		|     * Others             |    0   |
-		|                          |        |
-		| * Reachable objects      |        |
-		|   * Count                |    0   |
-		|     * Commits            |    0   |
-		|     * Trees              |    0   |
-		|     * Blobs              |    0   |
-		|     * Tags               |    0   |
-		|   * Inflated size        |    0 B |
-		|     * Commits            |    0 B |
-		|     * Trees              |    0 B |
-		|     * Blobs              |    0 B |
-		|     * Tags               |    0 B |
-		|   * Disk size            |    0 B |
-		|     * Commits            |    0 B |
-		|     * Trees              |    0 B |
-		|     * Blobs              |    0 B |
-		|     * Tags               |    0 B |
-		|                          |        |
-		| * Largest objects        |        |
-		|   * Commits              |        |
-		|     * Maximum size       |    0 B |
-		|   * Trees                |        |
-		|     * Maximum size       |    0 B |
-		|   * Blobs                |        |
-		|     * Maximum size       |    0 B |
-		|   * Tags                 |        |
-		|     * Maximum size       |    0 B |
+		| Repository structure      | Value  |
+		| ------------------------- | ------ |
+		| * References              |        |
+		|   * Count                 |    0   |
+		|     * Branches            |    0   |
+		|     * Tags                |    0   |
+		|     * Remotes             |    0   |
+		|     * Others              |    0   |
+		|                           |        |
+		| * Reachable objects       |        |
+		|   * Count                 |    0   |
+		|     * Commits             |    0   |
+		|     * Trees               |    0   |
+		|     * Blobs               |    0   |
+		|     * Tags                |    0   |
+		|   * Inflated size         |    0 B |
+		|     * Commits             |    0 B |
+		|     * Trees               |    0 B |
+		|     * Blobs               |    0 B |
+		|     * Tags                |    0 B |
+		|   * Disk size             |    0 B |
+		|     * Commits             |    0 B |
+		|     * Trees               |    0 B |
+		|     * Blobs               |    0 B |
+		|     * Tags                |    0 B |
+		|                           |        |
+		| * Largest objects         |        |
+		|   * Commits               |        |
+		|     * Maximum size        |    0 B |
+		|     * Maximum parents     |    0   |
+		|   * Trees                 |        |
+		|     * Maximum size        |    0 B |
+		|   * Blobs                 |        |
+		|     * Maximum size        |    0 B |
+		|   * Tags                  |        |
+		|     * Maximum size        |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -89,46 +90,48 @@ test_expect_success SHA1 'repository with references and objects' '
 		# git-rev-list(1) --disk-usage=human option printing the full
 		# "byte/bytes" unit string instead of just "B".
 		cat >expect <<-EOF &&
-		| Repository structure     | Value      |
-		| ------------------------ | ---------- |
-		| * References             |            |
-		|   * Count                |      4     |
-		|     * Branches           |      1     |
-		|     * Tags               |      1     |
-		|     * Remotes            |      1     |
-		|     * Others             |      1     |
-		|                          |            |
-		| * Reachable objects      |            |
-		|   * Count                |   3.02 k   |
-		|     * Commits            |   1.01 k   |
-		|     * Trees              |   1.01 k   |
-		|     * Blobs              |   1.01 k   |
-		|     * Tags               |      1     |
-		|   * Inflated size        |  16.03 MiB |
-		|     * Commits            | 217.92 KiB |
-		|     * Trees              |  15.81 MiB |
-		|     * Blobs              |  11.68 KiB |
-		|     * Tags               |    132 B   |
-		|   * Disk size            | $(object_type_disk_usage all true) |
-		|     * Commits            | $(object_type_disk_usage commit true) |
-		|     * Trees              | $(object_type_disk_usage tree true) |
-		|     * Blobs              |  $(object_type_disk_usage blob true) |
-		|     * Tags               |    $(object_type_disk_usage tag) B   |
-		|                          |            |
-		| * Largest objects        |            |
-		|   * Commits              |            |
-		|     * Maximum size   [1] |    223 B   |
-		|   * Trees                |            |
-		|     * Maximum size   [2] |  32.29 KiB |
-		|   * Blobs                |            |
-		|     * Maximum size   [3] |     13 B   |
-		|   * Tags                 |            |
-		|     * Maximum size   [4] |    132 B   |
+		| Repository structure      | Value      |
+		| ------------------------- | ---------- |
+		| * References              |            |
+		|   * Count                 |      4     |
+		|     * Branches            |      1     |
+		|     * Tags                |      1     |
+		|     * Remotes             |      1     |
+		|     * Others              |      1     |
+		|                           |            |
+		| * Reachable objects       |            |
+		|   * Count                 |   3.02 k   |
+		|     * Commits             |   1.01 k   |
+		|     * Trees               |   1.01 k   |
+		|     * Blobs               |   1.01 k   |
+		|     * Tags                |      1     |
+		|   * Inflated size         |  16.03 MiB |
+		|     * Commits             | 217.92 KiB |
+		|     * Trees               |  15.81 MiB |
+		|     * Blobs               |  11.68 KiB |
+		|     * Tags                |    132 B   |
+		|   * Disk size             | $(object_type_disk_usage all true) |
+		|     * Commits             | $(object_type_disk_usage commit true) |
+		|     * Trees               | $(object_type_disk_usage tree true) |
+		|     * Blobs               |  $(object_type_disk_usage blob true) |
+		|     * Tags                |    $(object_type_disk_usage tag) B   |
+		|                           |            |
+		| * Largest objects         |            |
+		|   * Commits               |            |
+		|     * Maximum size    [1] |    223 B   |
+		|     * Maximum parents [2] |      1     |
+		|   * Trees                 |            |
+		|     * Maximum size    [3] |  32.29 KiB |
+		|   * Blobs                 |            |
+		|     * Maximum size    [4] |     13 B   |
+		|   * Tags                  |            |
+		|     * Maximum size    [5] |    132 B   |
 
 		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
-		[2] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
-		[3] 97d808e45116bf02103490294d3d46dad7a2ac62
-		[4] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[4] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[5] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
 		EOF
 
 		git repo structure >out 2>err &&
@@ -171,6 +174,8 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.blobs.max_size_oid=eaeeedced46482bd4281fda5a5f05ce24854151f
 		objects.tags.max_size=132
 		objects.tags.max_size_oid=1ee0f2b16ea37d895dbe9dbd76cd2ac70446176c
+		objects.commits.max_parents=1
+		objects.commits.max_parents_oid=de3508174b5c2ace6993da67cae9be9069e2df39
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.53.0

