Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F904779AC
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140498; cv=none; b=qEs9xTIXjkw84LzW4fAa9xU3dNHjR8wBcR+6ykBxySLvAsze3WqOBsZ97g5NNLhUQ/72R04zus3NkbyssEEYxtM3UiNwoQwyaEfeXv6aU/U0GhB8+Y3+AEq4mftyMcGJhLWWIxk4BtKU0Ymgq6I6dXx12g+5r64dCDk8LuSa5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140498; c=relaxed/simple;
	bh=7bx2v4e6RPXfmbbAPY5QCvFqSG+0DW69/a2Ht6ZKnjs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E/hNg39MGJQv9CmRZQVuxJfXUdIJ6mghVRXt02KOAP0ZgXClC3jlWZHN8ZuudatY7zPxSD8xglSX14UJH141aLBxgs1fBOpwp0j0dW83ucx2PcbgHWiF0NgGOPoLEp9fAwYHYCrd37rn2CH0WOPA9xq41pFTVpBJjFa28V+mQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKJrqSyh; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKJrqSyh"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899b95707afso17527866d6.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140493; x=1772745293; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjluXTqmBa8AdSwvdn27q9HFFxB5bjD/3wfeVCTNVlU=;
        b=lKJrqSyh2wkdRxSmtxH3SjUcF4KRq2PIKXchAMWVYc+jaBVYvGc85RO6wKMJUUUMlD
         J8b1FF0EoMT0LlcsvoQwGNqM0IKeyBSLYFnJ2j8BUI1Dg33KBP5x4tMH/Limb7zqxhPL
         FqOo6NTr51gJ+j4IVtbZv5/JkpXPqzyJOp6n/5MjRNjf78peoebgj2PQaRKfYK+vpAop
         5xQJmQIxFVcERu/AYYHIawFQVWMWgNnf+R+azhZ+ksBHzNV3rJKr7MJMph5kazBN0TYU
         YkvwAnxdjn/IsR593YdUslsBf6UlnZUYSgUC5FCWw7qKBVTQzEVsI2ATKZCxE/FeraBG
         Q23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140493; x=1772745293;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjluXTqmBa8AdSwvdn27q9HFFxB5bjD/3wfeVCTNVlU=;
        b=jfL3CUwV4nMsmWAOJxDMXLj0v/IC7UY+k9pnvR33pUIlGcHdEIWWs9bJK8WVfYDGg/
         UDSAzKAaZdF0G4Iv0HAlpQ7dK45S85ngrIRRNYskBjYRZNzlYuBxzf80FzJ2+s6ipNGQ
         8Ihku8Wedo5IzW5SfedO/qK7bwZbQKoINzvnZb8jxN2M6Kt/knG9wVISU7BCiNC0Q/0z
         OHBFbtuFb64MGrhUuQcMjiXbGsZkmVMOMy/PzBqkwaUSaEwequHr5Lb6Yay6Mx6v2cVQ
         lCOCtsouIPMRDx1csubC/d6RuK1xvgRToC2JJRXHu5epwr2LgNpfM6TYZu3HY3IYbtPY
         7r/Q==
X-Gm-Message-State: AOJu0YxA/7OPluibkcbJDV97Jxfv5/7aZ/JihQSUde/I44lGFoGjzwUu
	5Nvmq8FXTSqy/SFzSgTS0GVgIMcWiBsrVoAuAxrGIEKmYUschUQGx4Uu7I5ZTg==
X-Gm-Gg: ATEYQzxu9bUHBV2e9aBMPekQrdIkiLK8saYnuK0tlQ5rRtTfFFFYQ3/5wluJeJmnl/G
	Hp6cfggBac664kWeNFira8h1e4k+pUb5cZj/vz2hx9Xo+V4qme1SHOTmxu3bew8pPXgXR4LDgUJ
	5hHtMqr933mHQDPpXtFea6yhTnZPnWLl8oyluPiAb2FjW07o3V11jPExQuxsqGUd28DRC7Kz570
	q6wXcCYGOOFnSyYkfyveQ+TPIUkYehFnfeS2KcZsfvdhGJgrFeF0tPWK6JuF0CgHDxbMA+Ywcx7
	4fTw+BJBPma3/jkDLvEmJVIa2bTKmJzbirfuifHij5RkZ55QDMEU25Igh+DGnKXn0sazp3qD10e
	Mra7P4UsgBvMtgU6PODBTgVVbciUeNyX0in2a4svFGFJ7LoTtAGeFyKDLT8KBcZ4f6CenjCBTOc
	VbslYGp2mj0rcHOv2QLDxNCHXvx6tY2S3HmGXv
X-Received: by 2002:a05:6214:f2b:b0:895:4b79:83a3 with SMTP id 6a1803df08f44-899d1de4769mr8601606d6.8.1772140493455;
        Thu, 26 Feb 2026 13:14:53 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6592desm294662685a.2.2026.02.26.13.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:52 -0800 (PST)
Message-Id: <504d9cf7a0dbd663ea88c75217e1564504a60937.1772140487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:41 +0000
Subject: [PATCH v4 04/10] repo: add structure max object size metrics
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

Extend git repo structure with maximum inflated and on-disk object
sizes, both per type and overall max values.

This complements existing totals by highlighting outliers that
often drive repository bloat analysis.

The implementation updates object counting to track per-type maxima
while walking reachable objects.

It exposes those values in both table and keyvalue formats for
scripts and human output.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index e5078e5459..a2fc3fd8cc 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -426,7 +426,9 @@ struct object_values {
 struct object_stats {
 	struct object_values type_counts;
 	struct object_values inflated_sizes;
+	struct object_values max_inflated_sizes;
 	struct object_values disk_sizes;
+	struct object_values max_disk_sizes;
 };
 
 struct repo_structure {
@@ -529,6 +531,20 @@ static inline size_t get_total_object_values(struct object_values *values)
 	return values->tags + values->commits + values->trees + values->blobs;
 }
 
+static inline size_t get_max_object_value(struct object_values *values)
+{
+	size_t max = values->commits;
+
+	if (values->trees > max)
+		max = values->trees;
+	if (values->blobs > max)
+		max = values->blobs;
+	if (values->tags > max)
+		max = values->tags;
+
+	return max;
+}
+
 static void stats_table_setup_structure(struct stats_table *table,
 					struct repo_structure *stats)
 {
@@ -583,6 +599,26 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->disk_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	stats_table_size_addf(table, objects->max_inflated_sizes.commits,
+			      "  * %s", _("Largest commit"));
+	stats_table_size_addf(table, objects->max_inflated_sizes.trees,
+			      "  * %s", _("Largest tree"));
+	stats_table_size_addf(table, objects->max_inflated_sizes.blobs,
+			      "  * %s", _("Largest blob"));
+	stats_table_size_addf(table, objects->max_inflated_sizes.tags,
+			      "  * %s", _("Largest tag"));
+
+	stats_table_size_addf(table, get_max_object_value(&objects->max_disk_sizes),
+			      "  * %s", _("Largest disk size"));
+	stats_table_size_addf(table, objects->max_disk_sizes.commits,
+			      "    * %s", _("Commits"));
+	stats_table_size_addf(table, objects->max_disk_sizes.trees,
+			      "    * %s", _("Trees"));
+	stats_table_size_addf(table, objects->max_disk_sizes.blobs,
+			      "    * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->max_disk_sizes.tags,
+			      "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
@@ -661,6 +697,9 @@ static void stats_table_clear(struct stats_table *table)
 static void structure_keyvalue_print(struct repo_structure *stats,
 				     char key_delim, char value_delim)
 {
+	size_t max_inflated_size = get_max_object_value(&stats->objects.max_inflated_sizes);
+	size_t max_disk_size = get_max_object_value(&stats->objects.max_disk_sizes);
+
 	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->refs.branches, value_delim);
 	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
@@ -688,6 +727,28 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
 
+	printf("objects.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)max_inflated_size, value_delim);
+	printf("objects.commits.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.commits, value_delim);
+	printf("objects.trees.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.trees, value_delim);
+	printf("objects.blobs.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.blobs, value_delim);
+	printf("objects.tags.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.tags, value_delim);
+
+	printf("objects.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)max_disk_size, value_delim);
+	printf("objects.commits.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.commits, value_delim);
+	printf("objects.trees.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.trees, value_delim);
+	printf("objects.blobs.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.blobs, value_delim);
+	printf("objects.tags.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.tags, value_delim);
+
 	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
 	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
@@ -772,6 +833,8 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 	struct object_stats *stats = data->stats;
 	size_t inflated_total = 0;
 	size_t disk_total = 0;
+	size_t max_inflated = 0;
+	size_t max_disk = 0;
 	size_t object_count;
 
 	for (size_t i = 0; i < oids->nr; i++) {
@@ -786,31 +849,53 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
 						  OBJECT_INFO_QUICK) < 0)
 			continue;
+		if (disk < 0)
+			continue;
 
 		inflated_total += inflated;
-		disk_total += disk;
+		disk_total += (size_t)disk;
+		if (inflated > max_inflated)
+			max_inflated = inflated;
+		if ((size_t)disk > max_disk)
+			max_disk = (size_t)disk;
 	}
 
 	switch (type) {
 	case OBJ_TAG:
 		stats->type_counts.tags += oids->nr;
 		stats->inflated_sizes.tags += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.tags)
+			stats->max_inflated_sizes.tags = max_inflated;
 		stats->disk_sizes.tags += disk_total;
+		if (max_disk > stats->max_disk_sizes.tags)
+			stats->max_disk_sizes.tags = max_disk;
 		break;
 	case OBJ_COMMIT:
 		stats->type_counts.commits += oids->nr;
 		stats->inflated_sizes.commits += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.commits)
+			stats->max_inflated_sizes.commits = max_inflated;
 		stats->disk_sizes.commits += disk_total;
+		if (max_disk > stats->max_disk_sizes.commits)
+			stats->max_disk_sizes.commits = max_disk;
 		break;
 	case OBJ_TREE:
 		stats->type_counts.trees += oids->nr;
 		stats->inflated_sizes.trees += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.trees)
+			stats->max_inflated_sizes.trees = max_inflated;
 		stats->disk_sizes.trees += disk_total;
+		if (max_disk > stats->max_disk_sizes.trees)
+			stats->max_disk_sizes.trees = max_disk;
 		break;
 	case OBJ_BLOB:
 		stats->type_counts.blobs += oids->nr;
 		stats->inflated_sizes.blobs += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.blobs)
+			stats->max_inflated_sizes.blobs = max_inflated;
 		stats->disk_sizes.blobs += disk_total;
+		if (max_disk > stats->max_disk_sizes.blobs)
+			stats->max_disk_sizes.blobs = max_disk;
 		break;
 	default:
 		BUG("invalid object type");
-- 
gitgitgadget

