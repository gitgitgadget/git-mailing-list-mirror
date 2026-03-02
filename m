Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E1390999
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487938; cv=none; b=dY8gBfHPyQ7++hPoZlPLeURrB2h3kNgDdGsD7DYx9RnNjBAgfsONEjYNe4+MVcw+9zONdXlu0FYaWRjYIHH4Qt5HRS4zK1Vd3auVZrUFKYQECHi/usbLRYcJkJlNjvR4s8i2eBQXJA6z70Aem0h/fu7HeXOAzhSLO/74K10xEFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487938; c=relaxed/simple;
	bh=dczEgcstXM1XA2mT64cvseEflCU/q7kllnEosX703ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wal9jVixWt7CKWAJdOX8mxsAvwLSB99iDgQgPndwZFHn+NR38Y4WKH+qkZiPQETn9y5u87ZMXg298rvjtP0jSHsFNMsvBqqMwiM4iuZW7xs+jS4Sp/C1F0YYShp6wu6dgoKKu428EscE2wmTMzWRYfnoCdWusc8AobGzcwMGh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTXkmM/1; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTXkmM/1"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-66f3e7d9eccso3460192eaf.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487936; x=1773092736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K10PdhkKwY94stb06GwmAZpXDVZ+ceUUpHs8oQp5H50=;
        b=VTXkmM/1FjRjSIhGnLPeXcVp6sJ8lSTuwKzvjo2KPf56htVeyk8URXGwUI4P8M2n0Z
         BcdKoRkKB1l1ZYStzbHpB0vG4L00o8dHGNXMC4CHILi6JqdpKb7t32TKPMoMnMKFjlw7
         dLoSGH5Hxcvmz851J4JCxytWrmqZ/h/IEKatHX2UmVDBb+zbXDYr0yjC0XqUPtDOhSKV
         ost68aUWdfJHhlbe+sqaNJp3sPTyft5GGtmlcSDL/pBnIKbJR0SyX9F4UkheCWiT6ZOk
         krGgdt35ahGA5EuRIF38ZdAC2V/OSLB7+nlijniE5phjVHFem5f1lNjvm177qkesBtNW
         loJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487936; x=1773092736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K10PdhkKwY94stb06GwmAZpXDVZ+ceUUpHs8oQp5H50=;
        b=i9+6pwD8OQQk3d+NvxazYiHtJkohhjkvM+D8rpfG3BbB52jwodtkFXXwI6744h0D2s
         CRD+JWdxrmayMGhtE6iOHtOsUfNyv0tYRgeiVLjLqj5Mcfiepqd9ewA21k0bBpdVDV0z
         iY6klbspGqr9RWM/C5dfLdwZ1QtFpHXsOUb+bktn+WFY/zS0kErGj6fID6cK0Nakx2WN
         Oleqgh36MWShYOg9E7Z8wL1Nqt9aNl9Qr7xd7QeBxa6HivrOYQlcxPXRwOC0FJoay/6t
         7EIUDGXXZbXuSQ4eI96zt8wTA9JQLc7gLJBb8+cFTjwfnqlF1Pf1LvCDeFDgYJae/oU6
         rUPg==
X-Gm-Message-State: AOJu0YzXJr9YLoqZbIs0R1Cx82TVRYH1tBFXE/+wTdZ6ZxkdjUZOLkxV
	NwF1B86TIBatataAKj+3/oqajxWegf9FKkpCU/wbprJdXDo73iY0wP9nXdU4qQ==
X-Gm-Gg: ATEYQzwMb/zTmkNev4nVK249NZTPe9LHINKMzfNTNZYRqsrg41UMp+HAgPp7uHK/4du
	/7dCxRsqKKGk/zwI2Y+lrXO38mOkXA3k2JY9sBTQC+R2IC6QYN2vuD6z60k9LHyHuCiX1qFg/X4
	dJ9z35SuhSDdWYAFfU69+47kFfc6XqmO+FFGKYkcxkLDEhNU9D4H7xr7zYZJe3EUvkprEJADIB6
	8nrmtZ5vBq2IUTCE4GDaAfNFWIIjXFvU8Pg6jPHLO+AKybE9AuR5Jehdt7cpj8qExyTLJfTJR+w
	sUfbh9rzeYd6U/PBgvFEWjlN0WPNSSHF+/2+NM5Hw7syEkL7VXMekj6A+gYEsO/Ih7J8RdjoULx
	P9zjynDFt0rqAOEISBjY9REyxUPSRcmB7e+YsqZmFW7yUo35u9b4AnQMRjTcaPOSoU0PgM08syi
	HasmxwvDfK05Lv8rFY3t/a8RXxEfVXEgS/rkWXFDK0Jg==
X-Received: by 2002:a05:6820:4cc6:b0:660:ff15:24e7 with SMTP id 006d021491bc7-679fadb8171mr7690507eaf.12.1772487935813;
        Mon, 02 Mar 2026 13:45:35 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm9775877eaf.9.2026.03.02.13.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:45:35 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	lucasseikioshiro@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 5/6] builtin/repo: find commit with most parents
Date: Mon,  2 Mar 2026 15:45:25 -0600
Message-ID: <20260302214526.2034279-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302214526.2034279-1-jltobler@gmail.com>
References: <20260223174120.2356504-1-jltobler@gmail.com>
 <20260302214526.2034279-1-jltobler@gmail.com>
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
 builtin/repo.c            |  45 ++++++++++++
 t/t1901-repo-structure.sh | 151 ++++++++++++++++++++------------------
 2 files changed, 123 insertions(+), 73 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index ea7f5acd3e..047f5e098d 100644
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
@@ -595,6 +623,9 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	print_object_data("objects.tags.max_size", key_delim,
 			  &stats->objects.largest.tag_size, value_delim);
 
+	print_object_data("objects.commits.max_parents", key_delim,
+			  &stats->objects.largest.parent_count, value_delim);
+
 	fflush(stdout);
 }
 
@@ -682,16 +713,24 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
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
@@ -701,11 +740,14 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
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
@@ -724,6 +766,9 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
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

