Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905E1328261
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765832219; cv=none; b=ZXF937+VHy6+j8POur4sbiuPfYApSbzOubEBH75OndnlF9mOM7B9jSiNcHBzvktjy3Vjmq+eLXjliPWHgUD4k32FF9pBmEgtxR8k9zmbZnTxYQYW7CIBB0S3t9+9xtCTynYU8u7fL7jj8tx5aAxVZGM8vm9pfN6C1OtDTA4JXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765832219; c=relaxed/simple;
	bh=e9YNG14BUfccShT31euavsas5GbXrTjzgFqaA/qQffU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHiQBUNQIsgEuA+p9KxR4RInNziErj6dsA3Qr8aLTKfh7uQ8iD6yS/l95+f0GHqa07Tm2vZbHJva49QkflQurg6p48PIGEyHiI9p/ZaElni5U421AvRZHmC3Fzj1G5qqyecjHK8aKqsAKkKvNZZVYnfcJh4GfLH5UbvU2DTFLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJlM3qa0; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJlM3qa0"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6597cf49101so2294715eaf.2
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765832216; x=1766437016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzew6FcOJmkiOmaGfiZ+yde79lsvoOifOvOQGGCyVz4=;
        b=nJlM3qa0kdpshEqCur/tbZ9lIVp99OLSCpI88UX9iQMO+seR+3bfhcDFG7knk5DuNm
         fZUV628N6+iAzyQOi1kepCHXxto7swBRGeSEg+jv30l4KuWDtsmTsfwPeddWcc7seGmO
         7i7b/4yzSryDP17einLYbAtVNbFiEBqbR4Q7pXdwwfTkSi+XjDY6BaQ+O6lHbMPK1Cjk
         X1tkdHzWcSGadtXoOYL5+g0+m6coR8ALrHjZ2CmSOAfZJnVaw2Z+1X3x6QS+4HxPxEUH
         heczVy+38lpNU0xTRPJCsYGgex4o1m10T9ghkSXpYvCmsJDmjCFKyMfaG0FDTPV+wuCH
         hQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765832216; x=1766437016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pzew6FcOJmkiOmaGfiZ+yde79lsvoOifOvOQGGCyVz4=;
        b=TOoVrndWVnzPp7ZGdqn8R/c6cqf+9k9JlkTqM7AsKHM2A7YEi3QJj5JofRxbIprfQ1
         q37+Bzbwv9L+hpzCt6xFFPMMlPHhJHfMe7+HfHvH2O0zIR/eZZP6KxLg56RbUlG3IwVe
         hqJ4pDeMZnfgD+BV/XM0h5TFydgXJkf5dW2+CAlnoYywmrbekE6nfn0kh3et97lRcZT2
         IHlDf+w1w8DHhf34sjw95iAUz1kTNpDya6C0V0EBb1OGpn9oIXzFoH1wN5VLD21KZpZz
         jfBJ8S0X2pLjLUhTd9KeoEAr1oijCpxN9EwaHjU5irXw/LQFDtT60LLVJWoUGCl3AjQN
         Xs7w==
X-Gm-Message-State: AOJu0Yzw/KJAH/jkkYOzfKAwYeefe3GiPNETHVfJSr6CzZ7CYGogfS/B
	q4PjXHpVE47uTH7UKVUg9iZKYZL0ymPWOaV2w8v4Iur8M6k5EGTZwIXJ39BYLQ==
X-Gm-Gg: AY/fxX6Kt2uozUrlrmY6IqDLmWJa5ATwFr4E//BoaqlnCwLJUZW+2PUm90SdP7n+rUs
	oP5esuXSFLrYUFb9Z23W6H7QJoVs0W6bemJ5muiOpFZnCEUBFsX6wr0nmwV1kfzylemg3pz7/gI
	jpQ5qTNWk4U6Kbl1uIfXIOuBKAo/hSap8h11N92EM7eoHStVYvaDR7ACWpsZgNfDMrFIfLK1uTx
	tmS2wZHwm/XvIKYNiStqZsoPNw7OLRoogSLLD4Ods543NkTjqZPrLEO0aaJEG3IJMmRl0x8F766
	AvgDm3dU2SMBNcHhEthu6/suG5eQiFAtSZDFfuWwZMawAfdl2ag5K2LQckDE09taCICbwooijEw
	/Wh3HTgFWuLLRhNaQyVVlbdzZ8K6Q/ITHUqY9H15dZlGq3dSxLvLoePvTFiV5tvFH2ABQFIjxAN
	RgCnuc/m6qS8ZE4zVmZ8E=
X-Google-Smtp-Source: AGHT+IHJr+9iP0T3cOSGEBoCQStA7SkqXDMEkS3XoelEJ840Nz1abibADf8A/M8zY7aPUszcJYf/8Q==
X-Received: by 2002:a05:6820:820:b0:659:9a49:8e90 with SMTP id 006d021491bc7-65b45186e2dmr5021488eaf.20.1765832216055;
        Mon, 15 Dec 2025 12:56:56 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360f0f4fsm8778898eaf.14.2025.12.15.12.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:56:55 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 4/7] builtin/repo: add inflated object info to keyvalue structure output
Date: Mon, 15 Dec 2025 14:56:36 -0600
Message-ID: <20251215205639.2700270-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251215205639.2700270-1-jltobler@gmail.com>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The structure subcommand for git-repo(1) outputs basic count information
for objects and references. Extend this output to also provide
information regarding total size of inflated objects by object type.

For now, object size by object type info is only added to the keyvalue
and nul output formats. In a subsequent commit, this info is also added
to the table format.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              | 33 +++++++++++++++++++++++++++++++++
 t/t1901-repo-structure.sh   |  6 +++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 70f0a6d2e4..287eee4b93 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -50,6 +50,7 @@ supported:
 +
 * Reference counts categorized by type
 * Reachable object counts categorized by type
+* Total inflated size of reachable objects by type
 
 +
 The output format can be chosen through the flag `--format`. Three formats are
diff --git a/builtin/repo.c b/builtin/repo.c
index 9c61bc3e17..e207108346 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -2,6 +2,8 @@
 
 #include "builtin.h"
 #include "environment.h"
+#include "hex.h"
+#include "odb.h"
 #include "parse-options.h"
 #include "path-walk.h"
 #include "progress.h"
@@ -211,6 +213,7 @@ struct object_values {
 
 struct object_stats {
 	struct object_values type_counts;
+	struct object_values inflated_sizes;
 };
 
 struct repo_structure {
@@ -423,6 +426,15 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
 
+	printf("objects.commits.inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
+	printf("objects.trees.inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.inflated_sizes.trees, value_delim);
+	printf("objects.blobs.inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.inflated_sizes.blobs, value_delim);
+	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
+
 	fflush(stdout);
 }
 
@@ -486,6 +498,7 @@ static void structure_count_references(struct ref_stats *stats,
 }
 
 struct count_objects_data {
+	struct object_database *odb;
 	struct object_stats *stats;
 	struct progress *progress;
 };
@@ -495,20 +508,39 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 {
 	struct count_objects_data *data = cb_data;
 	struct object_stats *stats = data->stats;
+	size_t inflated_total = 0;
 	size_t object_count;
 
+	for (size_t i = 0; i < oids->nr; i++) {
+		struct object_info oi = OBJECT_INFO_INIT;
+		unsigned long inflated;
+
+		oi.sizep = &inflated;
+
+		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
+						  OBJECT_INFO_SKIP_FETCH_OBJECT |
+							  OBJECT_INFO_QUICK) < 0)
+			continue;
+
+		inflated_total += inflated;
+	}
+
 	switch (type) {
 	case OBJ_TAG:
 		stats->type_counts.tags += oids->nr;
+		stats->inflated_sizes.tags += inflated_total;
 		break;
 	case OBJ_COMMIT:
 		stats->type_counts.commits += oids->nr;
+		stats->inflated_sizes.commits += inflated_total;
 		break;
 	case OBJ_TREE:
 		stats->type_counts.trees += oids->nr;
+		stats->inflated_sizes.trees += inflated_total;
 		break;
 	case OBJ_BLOB:
 		stats->type_counts.blobs += oids->nr;
+		stats->inflated_sizes.blobs += inflated_total;
 		break;
 	default:
 		BUG("invalid object type");
@@ -526,6 +558,7 @@ static void structure_count_objects(struct object_stats *stats,
 {
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	struct count_objects_data data = {
+		.odb = repo->objects,
 		.stats = stats,
 	};
 
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 55fd13ad1b..33237822fd 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -73,7 +73,7 @@ test_expect_success 'repository with references and objects' '
 	)
 '
 
-test_expect_success 'keyvalue and nul format' '
+test_expect_success SHA1 'keyvalue and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -90,6 +90,10 @@ test_expect_success 'keyvalue and nul format' '
 		objects.trees.count=42
 		objects.blobs.count=42
 		objects.tags.count=1
+		objects.commits.inflated_size=9225
+		objects.trees.inflated_size=28554
+		objects.blobs.inflated_size=453
+		objects.tags.inflated_size=132
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

