Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD31337B8A
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906760; cv=none; b=Tc1lHBDNb4WSqd8WawMWB8E49IFyIV1MOi3+8BpWVyxbqJHaU/T3jiIkhgzjhsjVlyCA+KuySM/lugbdFABOHeyzMiD9YOAcEhKT0pLRNjdToe464bXeb2pmkJvtDrpFbAP3ndTKef/qUJzfuqFi14So4PEMvrTcuPu8GxdTnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906760; c=relaxed/simple;
	bh=e9YNG14BUfccShT31euavsas5GbXrTjzgFqaA/qQffU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4/trZhDz4tH9YGQ7Gi4RxExRQKZS3S4FBbFilWy4pY5qQkZ0lAbCdGXRIozPnhbVvU2Hx1UjsndG/VX3lsVf4TTYRyFI5/9vX4tNNMdAyPPN+y7vB+NBDNjFx8C32lpBXsbaNQOvrDYm+uHuGU7+Z9fftRj42ampNcMHq+V77s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b++EoxF1; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b++EoxF1"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso3520687fac.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765906758; x=1766511558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzew6FcOJmkiOmaGfiZ+yde79lsvoOifOvOQGGCyVz4=;
        b=b++EoxF1BHcOMybpzm2Zk6sfE0z8pjm2OFSdgKVi9jZFHgYei6y8enbrjZdiLQdtla
         3GfvzBsGcr3CT7GZvVyu//BPYj5uk+iWnpVUpttTIPf+2FCZZoLrYeYi1JC5Qxuk1IdC
         vpF+GQQHC3DmiBaz91n1a8QUg5WSaPCkUzKotbNYF5PV8quqSjajr0tz635A79GfG+qF
         507xL0tWOe/gZNzhe7xFLTqZ3avahkl6Kmd5kTga6W57gShIRgZQ6pDu8yJmqvOPHbh8
         ol1WrpZchjtZDrYftGLbPQXkpeskzolxOT4LtrPoS5ZIsdgowPiE56D+Nw4Oh/PkVmon
         VUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906758; x=1766511558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pzew6FcOJmkiOmaGfiZ+yde79lsvoOifOvOQGGCyVz4=;
        b=DKMi8KLVmrrbFMljWe3gyjgHm7N0tp7x4kE+yU3KfTrIkFkD3ZTXOhirx87AMR3dUB
         tpWovpXdVp2hY+QhA7exrmXAVa+NavLQzRjIG51bE4ueNMKwDQoWRVNwe9B6Jkbc3n7L
         Fe3lI+03/Y6uYCMjUkSMcheHAuVDhUJiogxnspyPC3K4e7vT5Fe6aV66MUJsV4jZ6FdB
         3aF2Y2GI+5b9CZOIorlY45xerSsNEsIeljiB2RRgwFktTL0Ve4vqcVA1y6iZ+uDNhJmC
         r2iJom7CtbGEYjrV2YC/SocxNJwHsqZPfAClO9OYCzRbwnfJNUNuEapstt5I5iIdt1x0
         BVwg==
X-Gm-Message-State: AOJu0YyqmYD5TlxMhzGbcVlVtb/8M6ltsmYHDbW3oBs/PRjRHFNIoK7u
	BXzlWK0ZeBPgjWRJXqsVJhYM9pT2Cb7EL1gzzn8d/mGwDkdxGBodMKNu68pg2Q==
X-Gm-Gg: AY/fxX6HkuCHHCJNaAojtgGFXfJc7ATVVBMGd6Ka2cy/g/NdkfZL64dp2OWhFWiBjj2
	s54aHNOSx7GlJVzLCIVC+e4devFh5l4ea1YOr8TX6zKP0NsBE/XGHm9CmsOY+fAiuLZf+QCzLT6
	p6Ru+6wTqVs8NPlpxUAw07/a+ZOSgz0UWWH0F0Nr+0IUsKjEKBP1mXinVqE5b1Ip80AVMHFUkxJ
	aFL0rrMQGMv/BQE1dHb9PYMo9eL9ijaxFmRCxKEJcRHub/WJnW+puWB+KA0lx4Z9hkjw/+Vrrn6
	JkS1ITn5x6UIoRZ0QgbCYdudmehWG7h7NKNZdfIYCBohJohjQExOy9OGN5o9cqWmd1dkrX9b+8N
	D0zmnaTrLLlGKqeGG7KTQ7V/HEeiDgYNYoXQmBLSMZQixmMMrcQPjoHBFUaThS5DG9moREZXw1u
	kWLxk+Rx2aF0a/KaCpU/g=
X-Google-Smtp-Source: AGHT+IEEYXZjrWK1HUN9gdtfFIYOFqpYIH91Av/bvCeGgHxEaXJ/84L/u9O3R5QgJ35XArhSAqldNA==
X-Received: by 2002:a05:6870:1587:b0:3f5:4172:19 with SMTP id 586e51a60fabf-3f5f8d1f8c0mr7605753fac.58.1765906757387;
        Tue, 16 Dec 2025 09:39:17 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm6438462fac.10.2025.12.16.09.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:39:17 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 4/7] builtin/repo: add inflated object info to keyvalue structure output
Date: Tue, 16 Dec 2025 11:38:39 -0600
Message-ID: <20251216173842.3357832-5-jltobler@gmail.com>
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

