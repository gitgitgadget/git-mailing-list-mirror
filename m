Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE96B258ECA
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906758; cv=none; b=SWnOe3iyeIXn11/qVCDNLYLYPq1Z/A6ixKG+jl+5wlFjbWeQ4UDXNl3vH8J03ChkMsp/YEO4lBXmOV8z4urgSKVgkd/mBQbFXcAiEH//HCjumwv9WSjCzVeel+ceQ+bsd6s0e2BtWQwC6e4oH22lqJ/A2ZNOFw7BE4fZbGITbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906758; c=relaxed/simple;
	bh=fxdRF0i1f/4Kp0/k0SdtxwOagz2Mqwmkkn1pnd2xdGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gx5EE0i63p9Cpu5MzA+61eO4l+IEk43AejvEW65Jk7BgMQM79v+UMYRMWEQfsS0S+BLs1XRt4Bogt1i/ubwfEVJp6MdfQLEKYRLLHN151KNWxLGQVunIJsfNmu/AVdtBFgRAAwsvP9wM39SueBRHQQIG2P0SpF1himyukDkR9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNP9lqmv; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNP9lqmv"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3e3dac349easo4024199fac.2
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765906755; x=1766511555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h0FWefyV+RQwHB8kM95WAB2YifbyvJsEyRj9TgMRFY=;
        b=hNP9lqmvrkjCOVz9bCowj+PJGGaUbp22SwQcmbBM7amuaCUelQt4mcdsfJ8WQGqpjV
         Nyj+RDPYvVTBEfUrAN3WDUtwhZ7sHZlH0HN4Rb2Lnv2FY183brdSMCB6qlRa3IfZL6AC
         NiKZ9bQQ4Uybh5MhT93a8Na8l/S1oC1xrewr8T26yVFD6N5/uSmGJrv3180MbOWGz5qO
         Oz57vkBYPGXhJqexV/GZctGtxNv63aYR9EqJgoUHaQzDHKAOlNOr+xbnc4pKpxfuEfTw
         Ik7FQckA6OFIWYTdoDPCHQDcExKa1EpP9vttXGD+nU0Cg5fEtO3IYmjCO6DEGWTrbTBa
         SoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906755; x=1766511555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5h0FWefyV+RQwHB8kM95WAB2YifbyvJsEyRj9TgMRFY=;
        b=XzrE8Zr4KCClwT6d4PJ+sqpfwXtYPNBvvvS1Sz8OCqTrRcDqpollKc+YqzAAF7HkM+
         gsSU1TpksNwtb5rN/guu5yed35ZVRxUPEhLXrbJekSTKhDQ4VF221DAoAukMuCPsKCbE
         u568ik52cjDxKxU6PYBY5DNDC7vzWWenJ/A9tcjMJMmUOqIIjwWYX9CjCSWGgNoJNWkq
         aUL3exg/0Fl4SB5cdJ/To5T16BImYvY2iXukPqEmImb6qh/+n9ePhL6/AnApZJmS29m9
         RZU5GyRYbYOM5N1IMlsISV1X+UeM+W6hrMmM7r7eny0XBoG4dlrYvN9sb2nabTWnHzuJ
         xDTQ==
X-Gm-Message-State: AOJu0YwlEpUGBcwTxm46hY/YcVTjX4FH5L5XxRs5mSV/O8XYAwZ5Wr6S
	8bc+xxaTzcPc+ZNudIt+O3BzhLldVubpHpIqltUhTYF/7P58/VwAvavFZn6Gng==
X-Gm-Gg: AY/fxX4Xdaefy3Ew/itH4Qc+8455gczCIw08xTNKIubn6rJvpuGDgXQMA8OXmOI3jP+
	6oBidRSjxN4rVzOKDVvg/MxOekv6kBBNwfivt7SAUsMn3NtweoHFiqdTSvZ8hStqBz79XcrfzCV
	QwPxaYXyjcXuuQuD0LvlGRX8iZSYdGpg6AI55Whvy/VP7Dpsc25Qo72rVE3/S//1euH6PbVIJoD
	7rI2VWn1NuEZ0OZveLXM54rzjz70NaVTyZJcWSGIJSHaGzVPs5laKryT8LQTntzHYLnqAC77Wa8
	LpUJTFpUxWd5Lf4aWCDkkFvwZ3RMbH8PquZGu4/pqehWUPodQxMOpMy2llLry7wcnOWyRQBnpXU
	UxIVew+ClWLihHYNiWDsxhJMf77ECvogcbGpLyjuY538j2OTqxOkySXLuBmk1o5MNjqG1wetO8o
	HAcqZKFsa2z2dRXyrLrcM=
X-Google-Smtp-Source: AGHT+IGcpZWC23nJ3HLaDs3j9phed+JkbsPSkbEnRUXo/W6+vB1v9bce1srv1gvQ0H7fekL+0m4iTA==
X-Received: by 2002:a05:6820:198f:b0:659:7f3a:7d55 with SMTP id 006d021491bc7-65b451518b0mr7133993eaf.6.1765906755253;
        Tue, 16 Dec 2025 09:39:15 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm6438462fac.10.2025.12.16.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:39:14 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/7] builtin/repo: group per-type object values into struct
Date: Tue, 16 Dec 2025 11:38:36 -0600
Message-ID: <20251216173842.3357832-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251216173842.3357832-1-jltobler@gmail.com>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `object_stats` structure stores object counts by type. In a
subsequent commit, additional per-type object measurements will also be
stored. Group per-type object values into a new struct to allow better
reuse.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 2a653bd3ea..a69699857a 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -202,13 +202,17 @@ struct ref_stats {
 	size_t others;
 };
 
-struct object_stats {
+struct object_values {
 	size_t tags;
 	size_t commits;
 	size_t trees;
 	size_t blobs;
 };
 
+struct object_stats {
+	struct object_values type_counts;
+};
+
 struct repo_structure {
 	struct ref_stats refs;
 	struct object_stats objects;
@@ -281,9 +285,9 @@ static inline size_t get_total_reference_count(struct ref_stats *stats)
 	return stats->branches + stats->remotes + stats->tags + stats->others;
 }
 
-static inline size_t get_total_object_count(struct object_stats *stats)
+static inline size_t get_total_object_values(struct object_values *values)
 {
-	return stats->tags + stats->commits + stats->trees + stats->blobs;
+	return values->tags + values->commits + values->trees + values->blobs;
 }
 
 static void stats_table_setup_structure(struct stats_table *table,
@@ -302,14 +306,18 @@ static void stats_table_setup_structure(struct stats_table *table,
 	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
 	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
 
-	object_total = get_total_object_count(objects);
+	object_total = get_total_object_values(&objects->type_counts);
 	stats_table_addf(table, "");
 	stats_table_addf(table, "* %s", _("Reachable objects"));
 	stats_table_count_addf(table, object_total, "  * %s", _("Count"));
-	stats_table_count_addf(table, objects->commits, "    * %s", _("Commits"));
-	stats_table_count_addf(table, objects->trees, "    * %s", _("Trees"));
-	stats_table_count_addf(table, objects->blobs, "    * %s", _("Blobs"));
-	stats_table_count_addf(table, objects->tags, "    * %s", _("Tags"));
+	stats_table_count_addf(table, objects->type_counts.commits,
+			       "    * %s", _("Commits"));
+	stats_table_count_addf(table, objects->type_counts.trees,
+			       "    * %s", _("Trees"));
+	stats_table_count_addf(table, objects->type_counts.blobs,
+			       "    * %s", _("Blobs"));
+	stats_table_count_addf(table, objects->type_counts.tags,
+			       "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
@@ -389,13 +397,13 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	       (uintmax_t)stats->refs.others, value_delim);
 
 	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.commits, value_delim);
+	       (uintmax_t)stats->objects.type_counts.commits, value_delim);
 	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.trees, value_delim);
+	       (uintmax_t)stats->objects.type_counts.trees, value_delim);
 	printf("objects.blobs.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.blobs, value_delim);
+	       (uintmax_t)stats->objects.type_counts.blobs, value_delim);
 	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.tags, value_delim);
+	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
 
 	fflush(stdout);
 }
@@ -473,22 +481,22 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 
 	switch (type) {
 	case OBJ_TAG:
-		stats->tags += oids->nr;
+		stats->type_counts.tags += oids->nr;
 		break;
 	case OBJ_COMMIT:
-		stats->commits += oids->nr;
+		stats->type_counts.commits += oids->nr;
 		break;
 	case OBJ_TREE:
-		stats->trees += oids->nr;
+		stats->type_counts.trees += oids->nr;
 		break;
 	case OBJ_BLOB:
-		stats->blobs += oids->nr;
+		stats->type_counts.blobs += oids->nr;
 		break;
 	default:
 		BUG("invalid object type");
 	}
 
-	object_count = get_total_object_count(stats);
+	object_count = get_total_object_values(&stats->type_counts);
 	display_progress(data->progress, object_count);
 
 	return 0;
-- 
2.52.0.209.ge85ae279b0

