Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD732FA0F5
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321112; cv=none; b=ciuBKKqMbhPBBPLcVUqkH3CMlGpRdBfjaJ0bDpEmbZ9l/ofXrWUpVEbdVTYT1fzGn5czjg1kN82Xc2yFCNcppNKfv4AxLaAnAFHs3z5uYIc/Zcg95F8PS23/ryaT44Alyn1xeLgTHiUaGK6KXeHZw35x8ADdwUvmoHG/vA5bEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321112; c=relaxed/simple;
	bh=jCdkddMuFpe6uyK71OLBea6URAP8Aqeuz7JxdHf4FkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kocasXwUmTrPSzh083aWPCFy0MkMz/hfpoOUk2XXKrRhD80y4ULDLGeYDeZLfFNJYVZxZrDZB2ARev3H6iqxjKvgv3/FyodKV+y8DLY1yQG5bi9uEcumbsyxC6/7DpUZ5xM1sT6RBEB7IA+bRcBBUYDgj/7RkIm9+LSq+1XbfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic79tAQC; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic79tAQC"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-450c9057988so3518025b6e.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 14:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765321109; x=1765925909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prSVo/qCpuTjJmUSn+WABeEjMsIVoL4CKafAzidXNdo=;
        b=ic79tAQCO5Ia94yLZ3S6otlDTlh7p4v7LU2hLPxRFWq9Vseax0ZN1AO8DIT5HAhypG
         kuFEBirXvgBwEKvcLsuOxeUfrxWSwMsgR+RNXOWGqK6Pi3Hdeg7xgSJc8s+Eti9p1DD1
         hl43peKoJRzqcdvcMO4FQ2h9poDofh2f1RGuMAHd2WoePr1Na3JIjS9EjdlQoGhYLMGL
         RYMElu4UMt6UquY4V3hTqggc3q0/K73ZPk75jlXsNdJEyZyAT21mI3hyI6n2WlxSUQFB
         9m8pRuI1BkfJFNd63OB4Ujq11zGYPsDgBFh0of/c+kRJnbP9Aog9MpkITmf6pCdoaBPZ
         AR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765321109; x=1765925909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prSVo/qCpuTjJmUSn+WABeEjMsIVoL4CKafAzidXNdo=;
        b=duUZCjTBYi6eHrr9wYQwaUhsXrP328RsRbl6uyeGgRXH7hb2NBjAiyFKzeVsvovPMl
         WpLl0TDULTf4wc6JY/4MJo73c9rMgVgxJhYD8+qos3O9QLf/uSLr/2+wdtF4f8dkpcWl
         PxLpXU5gUG4HT1XF5J8+mGlrTYf9t3mtIHCQAx/CefL9CrgSmR8xNanUq/rBxA4q1adb
         W1YxS11HQRPgXrYnNNPyvLvEwku36eBOKJ7AKQ98P4it7+m8NzDb2zgQ+LpisOv7wm7W
         BpGHxDm/tjOg9EasePMSzy0U4ZHhKFxPxTeZGJwr5MlIMFSC1YhyXuNQSBbyF73+WRRQ
         3WlQ==
X-Gm-Message-State: AOJu0YwD5CdV3XXU1ubzlSUXEiclZxFaO3xbboxAMRXNSVHMu9q6tre3
	vngdKivwg7uFuArOwfztZ1D7GWU+Tudz9dxRXnCFfY5pSDTZAF1d3w3c7xtjGg==
X-Gm-Gg: ASbGncs+DMKIphsEMHxYERa5TvV8bJL+usNhoAXkvb6yKaIVS7IPMBuvN4+mMBVTk+7
	boQcJs3aZtO7MpSjmII0EioODlaOV+D1hkhL1JU02t9IPv8VIAk3GHpM7PCvB8vbLDJrDO/xDlz
	3vJEOkYzecwDhYy9JEUVBE+duNQs5IXZ3NEvdaZhSncDW3xqlI55fXPk+kyFcQ+67bBLldoyB7j
	cd8cgtnyveMZ9aM+fJ6vp+Y6OHPdGBklHm45j+MjWDYA9SXjRkQ/rHRHjNtvpZ8AWEDNiPdFpa4
	Zy5fRSPhPUIST0RzyekaNxGNlmH3V1px1O0HAf3pWTSa52x8aHWSxJI+dsufZ5w+vg4M6uWJOde
	whnXR9BYA6zwmgC411jBB/1S6SzAdAH1lAL5VRMtHw5i/TABkGp8z8RLrxQVNVRqtCHp3PCJm6p
	n1+Niqyfxka9iaa5XEyyY=
X-Google-Smtp-Source: AGHT+IGnRvN5nZIBt7iXzq9QhkGo5FgyeqbDs+aVoB4kZ1jObSQhfxxoLHR1T1DkUJik0zZH+bHw+g==
X-Received: by 2002:a05:6808:150e:b0:450:4a53:54d4 with SMTP id 5614622812f47-455865feeddmr367402b6e.25.1765321109282;
        Tue, 09 Dec 2025 14:58:29 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f8a02desm8161354b6e.5.2025.12.09.14.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 14:58:28 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/6] builtin/repo: add inflated object info to keyvalue structure output
Date: Tue,  9 Dec 2025 16:58:17 -0600
Message-ID: <20251209225820.2861276-4-jltobler@gmail.com>
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
index 8fb728b3a5..a67215ae31 100644
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
@@ -446,6 +449,15 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
 
+	printf("objects.commits.inflated%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
+	printf("objects.trees.inflated%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.inflated_sizes.trees, value_delim);
+	printf("objects.blobs.inflated%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.inflated_sizes.blobs, value_delim);
+	printf("objects.tags.inflated%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
+
 	fflush(stdout);
 }
 
@@ -509,6 +521,7 @@ static void structure_count_references(struct ref_stats *stats,
 }
 
 struct count_objects_data {
+	struct object_database *odb;
 	struct object_stats *stats;
 	struct progress *progress;
 };
@@ -518,20 +531,39 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
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
+						  OBJECT_INFO_FOR_PREFETCH) < 0)
+			die(_("cannot read object for %s"),
+			    oid_to_hex(&oids->oid[i]));
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
@@ -549,6 +581,7 @@ static void structure_count_objects(struct object_stats *stats,
 {
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	struct count_objects_data data = {
+		.odb = repo->objects,
 		.stats = stats,
 	};
 
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 55fd13ad1b..cf5e252f10 100755
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
+		objects.commits.inflated=9225
+		objects.trees.inflated=28554
+		objects.blobs.inflated=453
+		objects.tags.inflated=132
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

