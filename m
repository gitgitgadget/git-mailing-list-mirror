Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A157346A1A
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994054; cv=none; b=kjJU6iuHMOrEueyW6CxDaKHaXIDTVsjBzlp9NVuupqaXV2iLJGBjniLXKXI7e0QJT94a52fap/wdQEaMu6MaY5qw0MFOI9tW9WXTS9Ec+yaPLZPTr+EJ3C8ZG+12TmBGvY56AxmQ4ZuVszVHWAQmOFGKW9YphShM2Hit38vxbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994054; c=relaxed/simple;
	bh=gmMeCI25VjbPyd84ffBJ7thjPzn41jGaEefMxMnCS6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZcEeHkqqrDHql0rmYMIFZxJtE0VOM7n3AMau6sbB6+Wf8L24geCH79w4xuD2U0BPUQnNEH+5wRZphjlxOI955pHLy9GtJ3+llozbsMnnf0hwvXBHtj3woFog/D+Zc0aN0kzO03EPzNa8H5JNPg1K+oFJwO5NDF7uWoWwfZvMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpj2TAjH; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpj2TAjH"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso4395236fac.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 09:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765994051; x=1766598851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZ4oAN8jFtUkpcKDCF4uWaD+c5NwO0XNxXijdvKnY5Y=;
        b=Mpj2TAjHAvs6Y9NRbOFdBd9Hy3eawjNioxACDcndjsm3qF6mcn9OSFIp04fgZK9Qh9
         8woZ0PUKpLBMa8pciNd9t6hHVfiT7chHz6feK9lHoaTOZ7znKoBNGouUGWslpHu8/PXk
         dX6JQf7hZdi+Y+vLvzfIi57xmoV4xZkMla70nNl3Fmkn1BLyy15MIiLhk1aoBPTZlawJ
         tdwa8AUJFeTe0mz0td3kgUcjzQuvwAN1GeUYY7vcMpm7Y7jPEYBoGxGr4u928NfaDm73
         KfW6vGCGobvz3tYgTUQ85lIzaeP9x3mUoo2EkEC9rjeLr9zYcKpGJaUcFy2EZEcpOkqq
         yT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994051; x=1766598851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZ4oAN8jFtUkpcKDCF4uWaD+c5NwO0XNxXijdvKnY5Y=;
        b=jXaCdB08ezj45TXDWLUG/whBBLB2vTDY3X+Aev5cAnlISt8ylObh9GKlXnH01HkqhP
         NISSvrNMIAYsZQwIpjb7exQZfKpS/1T19OcXXjk+Cd8rmsDP622Q9xRCgmwBb3mP/wm4
         EQ8ymAFhwWO8MLUkYVnAkktiVnA1hfhBoYBg8UtBxoU7Bojfn5ApHkiBQ/pHRR6P2GaG
         b/rPzft8eEL5FJ2INBn4x/LqRUvNbyOiAWq6vuXwVilqi+iTszSQ4GPV4PXydXKKE40b
         ZxELUf+cVZpMf132sI4+5CAtW0b2Z6JJ/uH9ZSUuiYnI40q1BnwjeWPc7La8Tocut31l
         yblQ==
X-Gm-Message-State: AOJu0Yx7Dssq2cJXAcJ5GbnJ62FKNN9p4g3i81jhqRxeFgLAEu/+IO52
	j5FjwvANsL12UuUo4Dd+JO5OYcPOP7et1C1aEQBSbwxRLWr2edUZR87VYnLqQA==
X-Gm-Gg: AY/fxX4d4EbOn9x7Fpfg2oiau8nSWJvnGG/bDLy59RFLOdgmjb58fet2qu0FIelJ/fR
	+S6/zxv1cqrZ7T6KYSjAV+3CBhocuQRMWhXL7XiCECBBCJ7v96jM8u7R6RwIobHw6L+n92bEhvn
	5vrZLPqVywzlMCdS7uirkP/mo15FPXFstOV2aawdD/Ehlb4go7zRq6N38ppENgtkIHNH13y/CRG
	/htSxgKu7orvKi0BlSbK8U5Z29mjQgd0md58nwIj9Jh7ba7o6ZL6UJE9GjHwi+vuA3gwMgMD94r
	yx8qJSwa/0Ymgrqmg3sPvc6axS/ZHRfToUVHfcBOgX9UhR2cpqVGRdAWrqG7Ns+zX0KBNn/R6t+
	AxfW10kQnfaoI5prCmHGY7SPT3nPzqepvxY4Yb04alNQMApOCViDInRcjji4m3fgejJ0Ig3t4vF
	vEKV+1gyqIN/XLV9VtO7vxSobFND1x8Q==
X-Google-Smtp-Source: AGHT+IE67wULonjtBKzfObAaxSRxaRrFEv3WdZ2gBz1nluwpbq9DnUSteY1YbsseHmfbEFuYjZPAZQ==
X-Received: by 2002:a05:6870:d686:b0:3ec:3949:8a20 with SMTP id 586e51a60fabf-3f5f8c476f6mr8525163fac.29.1765994051415;
        Wed, 17 Dec 2025 09:54:11 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17f4b879sm20058fac.14.2025.12.17.09.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:54:11 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 4/7] builtin/repo: add inflated object info to keyvalue structure output
Date: Wed, 17 Dec 2025 11:54:01 -0600
Message-ID: <20251217175404.37963-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251217175404.37963-1-jltobler@gmail.com>
References: <20251216173842.3357832-1-jltobler@gmail.com>
 <20251217175404.37963-1-jltobler@gmail.com>
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
index 9c61bc3e17..8da321a386 100644
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
+						  OBJECT_INFO_QUICK) < 0)
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

