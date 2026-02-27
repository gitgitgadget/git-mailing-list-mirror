Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E345BD51
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220652; cv=none; b=njPKgOzckrCFU9qO0SjrF73Lwb1q0t7gLPTjCJmYFJh+oY2pgCZaFZixHeiEzLxdraikthC0fwSECq91DUMJ88RnVHBj60Pvxwv50pZcuhlVgPR1hOsu0JTUBQE9ph0iVTyno3ZiM/PI9MEw6NLdTDnfpVvEGasDHVZfiEoTb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220652; c=relaxed/simple;
	bh=3mNSFNzwGVhEU4uB7DDownfUkegbhgXzxnUHZRawNV0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t8oUkycBVRKY4/4ad2rRXLHl/tRgFGYDa1IRySeoL/ChY/1kwZ/zrr91scfoJptu0yz0Y6QSuzYFXpCiZWXQotUYkmQmKOU0VeqxtMfLmNh5aWE/Lio5PrqkH9ObqKVV87XGHGMrVH3Cd51yX1cCzb2l14Fi4EbBQW8wd5x+Af4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEWb0MYY; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEWb0MYY"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-126ea4b77adso3300495c88.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220649; x=1772825449; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch1Ia6FThnu0k+KexTnYjH5MV3p5o+aM8wNryBxDbCY=;
        b=aEWb0MYYcy6P5y9qCwrHi46l7ck0SoUq+KWuUc2B8Qj6nFk9ur3hGWsR5y85chfngj
         EhK1oRmlknXNJu0poEpBMk6eeMKGq43jOGis3cvz5IOaVoPFyFDBtQhiwjj9leKma30d
         H6a5ziOCK0bg1r1pkHUkGUNgp4eqQiGaxXa+0QBUaJU/f6bLUR2AGSFaNv9EhSdySb5v
         6u/wJHRBRDENRqyDLhcGY9NWgSCM6DFOFEAtDJzl5E7jq3Z7gypkWljrNz59Eu07+jJy
         7KtXC14dZIJrnPdkVVpPPWWToM04GlNfr5jZOA7aRTerdraq0DlpHBh0Ixha2ABSQkGL
         wpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220649; x=1772825449;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ch1Ia6FThnu0k+KexTnYjH5MV3p5o+aM8wNryBxDbCY=;
        b=YYEvFi2wEfw6YyuAdIQpF9UZYcrzH4T9oagJZxA2LWH8BIP83WHxLCJ5TsS/hR9pSW
         6fju2JkL6GCtlTiTddMgrfbICmnAi60UI2JOhVJ3ABPekoH6/F8r8dXFipOW3FbKcOqw
         nqridFycMXisTKZEThd4yLi8CoMPRKFudMYLY3cAju67J0rQ8gIFqNo00pkRkQwgk7qf
         9hfkJrcHQinvqLV9kE2N64L8SZPHIXWm4U57OA8070VGoYIVh6wfCnr1Jd5f0p3qO4yR
         WQb5Bxu9HM137tS092As9UwyCQZUqgPZ4kzEvpRyKbWGFWYBUozdqnauk2ZI95QXmlpc
         dO4g==
X-Gm-Message-State: AOJu0YwE61UJwiuKtlAYkmdBYAKnIXCOG7mDUPMS2HoWWGwBu3axgRB6
	CeOS0ZlBXlOOnx18fPQFeRWoxjaI4LiXGAJTy75mCl3j8fRH++S5HkxD3boBdQ==
X-Gm-Gg: ATEYQzwINIg8weFq78zGGbjo8YoyyyawKtRLrnrn3Vo4CXOey4g6b85XGsdDLIL0VY6
	zqgJtvgX04WWPa2oZiajYSulxgYqE0saN/E1HBLQnTPZnDyxTVTrS372OL9TT9y+9A7gMJNbKLk
	CjJ//vimm+ePtgkw1UyE8Z4KkORKPuGrU3bDwdQQbc6yebItqyUW9LZSYFBevkybSxa337Tv7ib
	v/cGL8nsX80YhML9pHPk4aUpfWNkyweSSVcBbLxyEq9lA1IxSjFmPT9wXJUfD5bXzjDSVI8alnv
	FB4x57K7JHnH93fizt+JeXJ9AEzBS7FWOIzFOqfSpu0wx5v97BA96xbzPvXdxG51qTko6tPj2KM
	fZW0SkE96vEBa68p1GnkL0iWb1L5UPfepC0qafQ8YNTcnsihjLJLi1Fo7yeqEg0rW3AKpzMpHLA
	OL5LkpTSUVxjeVaVFcs0BLEnIUqjZ95Ha4FdwGBA==
X-Received: by 2002:a05:7022:6981:b0:124:9fd8:4b99 with SMTP id a92af1059eb24-1278fb8f776mr1967272c88.14.1772220649164;
        Fri, 27 Feb 2026 11:30:49 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1bce276sm4390047eec.3.2026.02.27.11.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:48 -0800 (PST)
Message-Id: <4b502925c9d70d37e0752fadfe061f1cdf692488.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:34 +0000
Subject: [PATCH v5 05/11] repo: add structure topology and path-depth metrics
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Track additional structure-oriented maxima that are useful when
diagnosing unusually complex histories.

These include commit parent fanout, tree entry count, blob path
length/depth, and annotated tag chain depth.

The counters are gathered while traversing reachable objects and
are reported in both table and keyvalue output.

This lets both humans and scripts consume the same topology
signals.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 171 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 170 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index a2fc3fd8cc..f92c209469 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -17,6 +17,7 @@
 #include "string-list.h"
 #include "shallow.h"
 #include "submodule.h"
+#include "tree-walk.h"
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
@@ -429,6 +430,11 @@ struct object_stats {
 	struct object_values max_inflated_sizes;
 	struct object_values disk_sizes;
 	struct object_values max_disk_sizes;
+	size_t max_commit_parent_count;
+	size_t max_tree_entry_count;
+	size_t max_blob_path_length;
+	size_t max_blob_path_depth;
+	size_t max_tag_chain_depth;
 };
 
 struct repo_structure {
@@ -545,6 +551,116 @@ static inline size_t get_max_object_value(struct object_values *values)
 	return max;
 }
 
+static size_t get_commit_parent_count(struct repository *repo,
+				      const struct object_id *oid)
+{
+	unsigned long size = 0;
+	const char *cur;
+	const char *end;
+	void *buf;
+	size_t count = 0;
+
+	buf = odb_read_object_peeled(repo->objects, oid, OBJ_COMMIT, &size, NULL);
+	if (!buf)
+		return 0;
+
+	cur = buf;
+	end = cur + size;
+	while (cur < end) {
+		const char *newline = memchr(cur, '\n', end - cur);
+		size_t line_len;
+
+		if (!newline)
+			break;
+		line_len = newline - cur;
+		if (!line_len)
+			break;
+
+		if (line_len > 7 && !memcmp(cur, "parent ", 7))
+			count++;
+
+		cur = newline + 1;
+	}
+
+	free(buf);
+	return count;
+}
+
+static size_t get_tree_entry_count(struct repository *repo,
+				   const struct object_id *oid)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	unsigned long size = 0;
+	void *buf;
+	size_t count = 0;
+
+	buf = odb_read_object_peeled(repo->objects, oid, OBJ_TREE, &size, NULL);
+	if (!buf)
+		return 0;
+
+	init_tree_desc(&desc, oid, buf, size);
+	while (tree_entry(&desc, &entry))
+		count++;
+
+	free(buf);
+	return count;
+}
+
+static size_t get_path_depth(const char *path)
+{
+	size_t depth = 0;
+
+	if (!path || !*path)
+		return 0;
+
+	depth = 1;
+	for (const char *cur = path; *cur; cur++)
+		if (*cur == '/')
+			depth++;
+
+	return depth;
+}
+
+static size_t get_tag_chain_depth(struct repository *repo,
+				  const struct object_id *oid)
+{
+	struct object_id current = *oid;
+	size_t depth = 0;
+
+	while (1) {
+		enum object_type type;
+		unsigned long size = 0;
+		struct object_id next;
+		const char *p, *end;
+		void *buf = odb_read_object(repo->objects, &current, &type, &size);
+
+		if (!buf)
+			break;
+		if (type != OBJ_TAG) {
+			free(buf);
+			break;
+		}
+
+		p = buf;
+		if (!skip_prefix(p, "object ", &p) ||
+		    parse_oid_hex_algop(p, &next, &end, repo->hash_algo) ||
+		    *end != '\n') {
+			free(buf);
+			break;
+		}
+
+		depth++;
+		free(buf);
+
+		if (oideq(&next, &current))
+			break;
+		oidcpy(&current, &next);
+	}
+
+	return depth;
+}
+
 static void stats_table_setup_structure(struct stats_table *table,
 					struct repo_structure *stats)
 {
@@ -619,6 +735,17 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->max_disk_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	stats_table_count_addf(table, objects->max_commit_parent_count,
+			       "  * %s", _("Largest parent count"));
+	stats_table_count_addf(table, objects->max_tree_entry_count,
+			       "  * %s", _("Largest tree entries"));
+	stats_table_count_addf(table, objects->max_blob_path_length,
+			       "  * %s", _("Longest blob path"));
+	stats_table_count_addf(table, objects->max_blob_path_depth,
+			       "  * %s", _("Deepest blob path"));
+	stats_table_count_addf(table, objects->max_tag_chain_depth,
+			       "  * %s", _("Deepest tag chain"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
@@ -749,6 +876,17 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.max_disk_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.max_disk_sizes.tags, value_delim);
 
+	printf("objects.commits.max_parent_count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_commit_parent_count, value_delim);
+	printf("objects.trees.max_entry_count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_tree_entry_count, value_delim);
+	printf("objects.blobs.max_path_length%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_blob_path_length, value_delim);
+	printf("objects.blobs.max_path_depth%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_blob_path_depth, value_delim);
+	printf("objects.tags.max_chain_depth%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_tag_chain_depth, value_delim);
+
 	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
 	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
@@ -826,7 +964,7 @@ struct count_objects_data {
 	struct progress *progress;
 };
 
-static int count_objects(const char *path UNUSED, struct oid_array *oids,
+static int count_objects(const char *path, struct oid_array *oids,
 			 enum object_type type, void *cb_data)
 {
 	struct count_objects_data *data = cb_data;
@@ -862,6 +1000,13 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 
 	switch (type) {
 	case OBJ_TAG:
+		for (size_t i = 0; i < oids->nr; i++) {
+			size_t tag_chain_depth = get_tag_chain_depth(data->odb->repo,
+							     &oids->oid[i]);
+			if (tag_chain_depth > stats->max_tag_chain_depth)
+				stats->max_tag_chain_depth = tag_chain_depth;
+		}
+
 		stats->type_counts.tags += oids->nr;
 		stats->inflated_sizes.tags += inflated_total;
 		if (max_inflated > stats->max_inflated_sizes.tags)
@@ -871,6 +1016,13 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			stats->max_disk_sizes.tags = max_disk;
 		break;
 	case OBJ_COMMIT:
+		for (size_t i = 0; i < oids->nr; i++) {
+			size_t parent_count = get_commit_parent_count(data->odb->repo,
+							     &oids->oid[i]);
+			if (parent_count > stats->max_commit_parent_count)
+				stats->max_commit_parent_count = parent_count;
+		}
+
 		stats->type_counts.commits += oids->nr;
 		stats->inflated_sizes.commits += inflated_total;
 		if (max_inflated > stats->max_inflated_sizes.commits)
@@ -880,6 +1032,13 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			stats->max_disk_sizes.commits = max_disk;
 		break;
 	case OBJ_TREE:
+		for (size_t i = 0; i < oids->nr; i++) {
+			size_t entry_count = get_tree_entry_count(data->odb->repo,
+							    &oids->oid[i]);
+			if (entry_count > stats->max_tree_entry_count)
+				stats->max_tree_entry_count = entry_count;
+		}
+
 		stats->type_counts.trees += oids->nr;
 		stats->inflated_sizes.trees += inflated_total;
 		if (max_inflated > stats->max_inflated_sizes.trees)
@@ -889,6 +1048,16 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			stats->max_disk_sizes.trees = max_disk;
 		break;
 	case OBJ_BLOB:
+		if (path && *path) {
+			size_t path_len = strlen(path);
+			size_t path_depth = get_path_depth(path);
+
+			if (path_len > stats->max_blob_path_length)
+				stats->max_blob_path_length = path_len;
+			if (path_depth > stats->max_blob_path_depth)
+				stats->max_blob_path_depth = path_depth;
+		}
+
 		stats->type_counts.blobs += oids->nr;
 		stats->inflated_sizes.blobs += inflated_total;
 		if (max_inflated > stats->max_inflated_sizes.blobs)
-- 
gitgitgadget

