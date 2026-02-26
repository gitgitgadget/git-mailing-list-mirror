Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6E428820
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140499; cv=none; b=Er4GNLtbRYu6xdWlzjWPVKgMjYBud/FF/PahD1JzPbm+5xqrpw/Xb6tQAtNY9246+TC3NKqODhZsY2Ucz+sSKHYOjXMl/w/RJGCINw7Ro7nU1jURUUrkPXykFzlU+mU5drk6noK6n8MW6lkltS1D0PYCYxeuv3CcyBszvKwHH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140499; c=relaxed/simple;
	bh=3mNSFNzwGVhEU4uB7DDownfUkegbhgXzxnUHZRawNV0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sejiB77ifpUwZx04Q8AhLdHpi+zc7VUc5QO1SlOGaXHl9F9cuB8VZJFUqjtjUN6DFJM03mFhCMvzGxP0ug2TAz5m8w8tWBnrUAlSGLj0KnD6Ml/cR17zXFGFE2HKLTZvuH7ZuFMyspqM19X+zmuuSHQ5U/WvFlpKPnhjnMS35vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjtQ6HmR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjtQ6HmR"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb4081e82aso162342885a.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140495; x=1772745295; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch1Ia6FThnu0k+KexTnYjH5MV3p5o+aM8wNryBxDbCY=;
        b=QjtQ6HmR0j3NCc8P362F2knqTX4Iu9zrTgG20tljb46rHvFmU2lKy0dWBekGfPYnqO
         7Xbab5LoS14GsYRmFiSI6kA/pWvzhc74yjVUQq58PO04cprvGP8owDEFpE3HE/1px6vr
         ldLM+uUIDaaZZXB93IMhHoYZRyQE21jcebWZxxACud7CDD32xB80IHfXlUBj78lI4GAg
         qAORorRFL+Eal/mVbvmaR0sNwJ7F6kSYOb6ndJSWR1Djb49NzMTJCU5LjkqRdOTaR47r
         QIfAIzbyUg0auwZM0SwDqziroTJGWzWxVMBYVTgFakuED+Dykmz4XVnk0eF0Jh66rb2i
         pqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140495; x=1772745295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ch1Ia6FThnu0k+KexTnYjH5MV3p5o+aM8wNryBxDbCY=;
        b=IsDFehWI1V22TJq57Mbk9Gw14tuT9/JTss9mYZGg8ZGhqt044vj7BLDltCGdxG9iwU
         F9gIXBawI7UBvxrM3cfdnt98Z58tkWTyOR4465tz9RtAxHAdvOek0kmXQOtV1CNlC5B8
         FvFJl4bE+5HcdEFaX4CbDajkWC2VPXzJ+o+GQbc9HxWldfYyKO653UR36rl9r3W7ljrZ
         X7ljpt1yj+XgDkKqVGa6INiUjxkLHhz6cS9OXIJp+fPvREZ6bsnaNaCakMvojFjjMluf
         W6YV0ACyXDMb2yyzpKSlVrUQAxKfNnrHdpvbCR18p96/EOSRVljv9dIXsfD/YTNH61af
         pSTg==
X-Gm-Message-State: AOJu0YwrA0oNfHZ/s2EGZtU0F8GdfAXWOiFetbExaa6eqSQa3/Ln1zxx
	3tUhWkVd3EWsAo5I6k9MDS4gtk/aP5JSHI0c4En8KeDnon79lejoizttYVZ/ww==
X-Gm-Gg: ATEYQzwF0lRlMsDGC6PxEpbC1kMStTC2fUa9e6TQ553lLY0MK2NhXtWw6G7Ez/gsmTB
	XzdeTtmgjpv4s+ZZkp73oQUbgEn7bp+54x266Lswl5+RIWpdzEJlNHNYt3wJThQNEV9a1SXAxBP
	2OIJVeLWCVHVou4jNdFwpUQRJ6fbwGL9LSDtnHxWCDnNDpG8ETgZKWCKjFHWp+FQQTw6iwJkKV+
	Zkf1z4K1E0BKL1/YcNvmug2DTidrWiLZqLTsJQ1ZCRwsO7fYXGTAZaDgfwIANae1+8h4ZE6J35l
	GtWCl+mkyS6FEFnqU71huQcHxbfcURAQz+qzbviGpRH9xKkVG18lFdNnZCYsiCmRxm7h3dMuLdQ
	kKvYtEOgKQCvQeRN+2toU9iWoUWDUIhMtr3L9TeWYJ09SXVqkBdjw3j5fUImbqbyeuNEfrX/byW
	jFrpNh4525Jt7BUu/UYVAcPj2JCQ==
X-Received: by 2002:a05:620a:3711:b0:8cb:72b2:2a15 with SMTP id af79cd13be357-8cbc8d9cda2mr62526185a.33.1772140494558;
        Thu, 26 Feb 2026 13:14:54 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf677448sm283418585a.19.2026.02.26.13.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:53 -0800 (PST)
Message-Id: <4b502925c9d70d37e0752fadfe061f1cdf692488.1772140487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:42 +0000
Subject: [PATCH v4 05/10] repo: add structure topology and path-depth metrics
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
Cc: eslam reda <eslam.reda.div@gmail.com>,
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

