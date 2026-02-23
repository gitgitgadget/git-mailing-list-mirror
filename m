Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674CF1EE7D5
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856479; cv=none; b=NF/FmUPqyy+wZHwqXCK8Zs5FSGYyJrENK9O88YSFl5t327AU8zWucXZXqdHx4APdECh5bab5bWWCg1C0q+GVjtg3lwODKuzm9LaxLLrPCMjndEf4+RIHxWTqsrLJGDnQxTppQGoAdDicoKeDRH8PoU94MxfQTmo4m5LZP0Q+SbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856479; c=relaxed/simple;
	bh=3mNSFNzwGVhEU4uB7DDownfUkegbhgXzxnUHZRawNV0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M5xIzx+uA1hRLzk7nsvNz69F+F6/cRirN10Ki5LD46d5jgjY7hFUEPxI7GYIUH+DSCRfWjNFc9Slh3JoF2kRHgANNgpCBbEK4duTMM+v/1i0XIpmkCBTFsHH4czYR79tRw1smyMPP91YKIsVe4VurFwHXBUPg2mEH6CawerR2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6n6yhAI; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6n6yhAI"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-896f82e5961so65470106d6.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856477; x=1772461277; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch1Ia6FThnu0k+KexTnYjH5MV3p5o+aM8wNryBxDbCY=;
        b=f6n6yhAIMUF+0XuuWfw2FpcnPYVZ7JXlBnce2qQjxutlHCmfiOWNFF2tBiIzWLjHCh
         OhZ9gW96bD3IHT89ELEjGE+u0JDYJQ6Ax7EbLd+aNyBSz854DkrASvddTLezx3DPFk31
         s7jl7Zgo3WMKr4ln7agbDXSkqh1vree6PYeRH8N7/Y7g1zdyIEZ2YxA7/UFZgO7haz2J
         VWeEReFOeBs/2yAnPEgDYIBAnUL/s7m8iutGRuo0HI9WKICmYl0lzIUVoST4rJ1gp8L5
         e9/E9A28xVKjXP5My1xE4cL3wvVMMMSyx5xhcnfKzl6+Q8Llsc6T4Oncg9qfBPWWFu8f
         MH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856477; x=1772461277;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ch1Ia6FThnu0k+KexTnYjH5MV3p5o+aM8wNryBxDbCY=;
        b=e5/dbB+JzxqtQnDH1D8aJbkG+ks046VGr3SFGrZ5JOPcEAIlNBYzRXtgGlB+5Y5pZL
         xm3vwhmdRjGcLMnNuryix9q8/xamqbaReAMvdCuviPxwwImDOKw0ce88PfJ/BGLibXHQ
         jmiJzoyf7CQ9zGApFxJrwTDjE5YWgFKhwk0frwAihR2KnzHQvYKPac49Y2xzhgMdBUAI
         4bWuqvImIRiGSte87Te8JPsCgFZ0JCdSUd0ZKsJ29BNYDvUYPVWoZ/s80Xvlfpwsq7a5
         7B6vUjn0uk8ULhSL4nsBoPs/nigW9NYbfY//Z8Sdq1qHyLzm7e+d1PyngUJ9jyuaNjvK
         E7yA==
X-Gm-Message-State: AOJu0YyVMN4bMpdRmoQXKl0FRsDNdAstrrzEBbzRaHUfqLOdMpeWPHJG
	OV7cG1DKLAEWecXV+thQVJ9chw+X+svE0aqRsEt36LSbjJzvqtbnhtKjl/q58nZU
X-Gm-Gg: ATEYQzwcnEbIogH5ujMJZdoIT1J2IYixTMFIp0ClG7rUooRoMM+32c726CcEtm8PqF1
	vHRBw/BgZGXmQzy7H2D+lZ5pKBQkOp/jZnyZ9US6b8l5m/w/qTnJHk7XzIz7KtpBh9me4GGv2/U
	YPlYKlPZc57x4TZM/D/AkY0P9SH8x+CrDc25efLmWSdGa2n9dMU1lzMHsNfWB1AU+TmBZkPd5FW
	j9oJHO7ex7FhO1Bp8Sf7hbkvXvwDfX1Q+zaSfSOsScfUDpHLYQLiiQkRFtELa0UtdPhg4y1ySB1
	+VoRPtuhKNl//IyDjGsTk9wyc5lNMH6Uf3glDg48v3UIUslynzK6kSglLurDyxbCg89lY6FRDVv
	sHwqxg2LImM0xkgnEAqc/AMP30eEe0Ipmnk3vJhzQlfB11k8TBizlI8KXtAzduqLmtsXm1FHKC2
	+ikkcIZHWY0sFYmfg1xOqwuPs=
X-Received: by 2002:a05:6214:1c4a:b0:880:51f0:5ba7 with SMTP id 6a1803df08f44-89979d4d05amr129042416d6.42.1771856476720;
        Mon, 23 Feb 2026 06:21:16 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e242fadsm69766926d6.34.2026.02.23.06.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:21:15 -0800 (PST)
Message-Id: <4b502925c9d70d37e0752fadfe061f1cdf692488.1771856469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
	<pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:21:05 +0000
Subject: [PATCH v2 5/9] repo: add structure topology and path-depth metrics
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
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

