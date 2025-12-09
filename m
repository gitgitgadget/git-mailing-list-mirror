Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB82F5A13
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321110; cv=none; b=oJA4h7AX3DKFy9tECJJlK329L3cbP4MNs9bhh1pZQW0z443E/Ob5jmfblxRnMO13ei++1g5eVasWmKWx8UZZXJc0lrgpTWjh41T+RvW5AjIMUIZSvJonMCDevmcnDafl4rGxNY7u1Wyi3EIKgG3n24FEooJb7Fvqo9ZFAQSkcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321110; c=relaxed/simple;
	bh=fxdRF0i1f/4Kp0/k0SdtxwOagz2Mqwmkkn1pnd2xdGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzKpr3bX1C161KnkzDN1OS4yxKceC7RsQ18aPzcHdxqpvxBQjk25DZz9zXHUJWB9M/sa3jFeOZhjGhHoChDA0fjrcX+fd/1mzItd5Wpr0I4+3cs52s9Mw2aeJ9FOfBsBhzNnQUFCtXjXejx6fAm2NzOFjxR63EniyeQB2jZccvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYn3PqfP; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYn3PqfP"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45392215f74so1486683b6e.3
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 14:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765321107; x=1765925907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h0FWefyV+RQwHB8kM95WAB2YifbyvJsEyRj9TgMRFY=;
        b=JYn3PqfP4F5y/+JKVXq8pF42a/QE/SreRwGjtdadQ0joor7c+O78VY9fyNkho8r4nt
         T1fXndLKxY52JPTYABUjQdFCEuXNHPycYFvdwXbZJyTOhQfYTJRVWErwr3RxJ87rNmF9
         VLrUx8NtsZ8gOWXxPlwxaEA1nMeTUtCQW2zklbExRKtnroBWXDsJfkzbr3o55g1gvzpA
         myZrcoFRac/hsXFIAY875DxQHp5tOWZydbNCV97oBVVY82OarKsx86gA/sf/wTgjkgCE
         v4oYkiILmtN02tDFOPHJjfI1+gSD0Va9gla2CUjPWuOJ//PX5apyHu/sCr8876D06FQO
         z6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765321107; x=1765925907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5h0FWefyV+RQwHB8kM95WAB2YifbyvJsEyRj9TgMRFY=;
        b=RcMHLTFznF9mWA0nqtZK1qVfDCuaDgmSfH3o4tMN1i/5VwVmEB/iB8ba2g5UqjmPMn
         3YJbNVdSeyMuX+li7/EEGRGcD4HUEaQDwjhXvyhSX7Qbl7/xEmXqRIF4KPLBkdDjR0O2
         YhALxjnsXGWvjajiolxahBJZJxanKq8j3cioGOL1pjzfz0yd0EwcG/z+csvTTaWkyQkQ
         a5jXq4UjsQ+0GvJc5/TCL0AfSzQlS6PVqZiDsl7xnt2u/ZTnp/fT3WFbBGFHrCdzixcm
         o8c+OkGdH1UQjoBxdKCP76rQKB7A4jw5w1ZBsaWJe6qnmF9TQzsvYqGYb7v4VajJZM7R
         S57Q==
X-Gm-Message-State: AOJu0YwcVXNLo0av+0R2WpqLE4Qsaxna2LwY5ctooi/JGBH/CBuPWVWZ
	Vm55fTkmeA5QCFFZmI6jyFLm03erlWQJ93QTjOnrbSNf/w3y4TaKUNR/AXO7Rw==
X-Gm-Gg: ASbGncu4d4NnqDoLeYjxRF+eHMstgh6ScghzgDJqk4WREoyaM1R1/oXmlRcwbJLfOUk
	pE02b7fM44tsT2z5r3b5oKb1RHIUb4TvVPK/6bKu/aLSmfb+S1ZIXcpNLpL2FYmc+LrtjxTg+pi
	c8Jt56rVtz9hWCjfmLsoUdt3s9RX01d40pyHOXn/Pmg+i/cvaaXF0enFWnIhmxvXutoLJJAdUCw
	hK/slOqGWyZUgYYa2sxW5O+Bw7qsPnQRsmagrSkl+617+XXo5OlvweznBLX1UGQorOvLvVxibwl
	nO7PshdbjaSOBs2e9Ec7O+hqSB5jW10nzKL3deFfeHVw86O9WcJ9op9DQDvlcSWqeOmVubexExF
	d+jMk/dEQ86+ip/uJ+8yiFK18WdLBXxSFLYumYKigH6pZ37Q9BvXu4veOYw+UoHhACxdrbvex2O
	50hZL9fdxhQaKIo14PB1U=
X-Google-Smtp-Source: AGHT+IHMSCSOtYQjOHwQGsaCOdvlrka2SwChJ5mJ5CcxNok86u5QULyaT266vcXYZDmViBRfp3nQpA==
X-Received: by 2002:a05:6808:1581:b0:450:cd83:80be with SMTP id 5614622812f47-45586514459mr282491b6e.50.1765321107514;
        Tue, 09 Dec 2025 14:58:27 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f8a02desm8161354b6e.5.2025.12.09.14.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 14:58:27 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/6] builtin/repo: group per-type object values into struct
Date: Tue,  9 Dec 2025 16:58:15 -0600
Message-ID: <20251209225820.2861276-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251209225820.2861276-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
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

