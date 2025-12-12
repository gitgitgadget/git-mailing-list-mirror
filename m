Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5B2877E9
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579015; cv=none; b=ZPkVmlWqfR8qdEMr1I/7CiwOk0H0KQ5WdAo64DEoZhb9wsJaOjN2lIB+Ne3aJwQEjGYp97mHWXpE3TTytvCSoCmB6R4SkoEcvzeb4IESaU/xIDZcYA7XULufHxqAOfecu20tUFfbuZws3SiFE0GI4NSoGCzedfwFzkX+gyaP6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579015; c=relaxed/simple;
	bh=M7U/rpTPSqc62tC/vJ6oz4TuV4mClNWT7laQ0idUIG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFI/9efWJ4Qd1NX6YK3P92A4IWHYlTATiQWlniIpvMb7ARQvlbjyDB3IYr5SU16nNEi0dv9I9neTti/2eaxe7ybiXFpW6/CNNrInGHBTAkHhxCDXhhS6+WV2ELN/Rc2lcAkOToLzMlWwE8E2Rp6GtV2P8cBA8mUcxJF0fvQheCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBMUm4e9; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBMUm4e9"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-450c65f3510so1065950b6e.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765579012; x=1766183812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iTeW9hkLwmL0/BojI6ScJgvbdq+1/86u3uFFcXABRc=;
        b=SBMUm4e92Un1B6pNOB6+Ghy4jRgjTf++n/f1nQeDCl1cPzPKfOuh4OVpdJOl5Un+OA
         4VFd+FeGvyzhcquOXd7W9sb4sWaA6se7xlxdLvqfYgOCw5usiWDots+l7IaFdUSR5yA7
         6xRKFKJ46228wl8kvgdoWoaQ5Hc7MJ//43m593bKFwftZba5t99WqyVNJ6Fy/vGqjTwQ
         EPADOM8/DesOBcaZnCqnsmzwYydm8OjR7RYFb3uT1CAt3SyRehcURos2EWj694De08Pr
         gLqn99DOhiU4XpP9q2isDkEtM9xJmikaZSnT6cfGS6uOQyizWdBgLIDDDdt/JZA3rM82
         jhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765579012; x=1766183812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4iTeW9hkLwmL0/BojI6ScJgvbdq+1/86u3uFFcXABRc=;
        b=mE1ch5lI1AfqvWt76ZititAt32dFG+A/oyDCGi1HiLSGX+EjRMzxyv2538yUFlnJc6
         +PeEBC5cVyJP0v5grgeb0LB6f2qKPuRRNAkTBaFpstT4nitwpBjjqLzXoOi6Lq6rwbSQ
         DQsjLic9tgUGuS84fyxTCSpCKTN2he4NxG8TD/4lx3vA/EdYVaSlLUgj5n4D580sriGf
         3JBOleg7/e42or572hyAcvlr5H7DOt3WtjWj63eqT+kBvd00fdmWzMADE4B35w6kpmn8
         QeJbO1wsPpgR50T3AeaBQFSA4NbOzbvFei2mH+oQ4/DEwPl3QZ4rYJXwNeN5lf5/eR1T
         ltrQ==
X-Gm-Message-State: AOJu0Yz3vLK45gv6lM14tnRY5FPaHHFg5xf5Bhxh20FgyjCHYpBeEsyd
	/LmrTDEwxEaB1ShZ0wPhu86/eMYFOdoawtN8G+bFyL78PbRe3w3SDhuelKlK9Q==
X-Gm-Gg: AY/fxX5GhqwTDlBb6AyY3fnElL7Xh3xReZ8HTPTLKtTET6hrN1jjwRBPT+qjvptyJqW
	4cMnPjeYWU9kymfP/FL2sQvFgRTgrYRqyf2cSK+B1qwrn0hUia0bno9xIQ2aYAQP3BTxW7e2wDt
	3VPe+2m4w4lJnxS2Ic9l9UmEVq+wKqo9I2xz5vkx/wgkXr2UxTbl4NVI107TFf1dmkTVpAY8gnE
	mAEoOoFC6Xe5EAAakdPWoUz0OQ6ASFLagtG4vtkygVUzEziy+EwZCuLjODhgEExAdv13dtEXj5A
	gnD2lu4HoVW/r2JhsqvgH5KITVaJMf3WTP6TETTNjDqCUE01SOffGoxZmEclVZD0FIkPSwtqbJy
	nJCi7ilk8hMhGt2c1aLLqPj0Z5qAsHT2ucnHKnkeAWqoqQLe9qJIHXMCcS/xdi7momTio8KS3ur
	bamRCULsjpwphn8ofdRnk=
X-Google-Smtp-Source: AGHT+IH9501Kj/zVe1PyeytiQWQdepqvIj41YqWo/a9U/RrV1C5+sM0CgF5pnM+PQyTjfIpHbePvbA==
X-Received: by 2002:a05:6808:10ce:b0:453:7cad:6356 with SMTP id 5614622812f47-455ac935080mr1844827b6e.44.1765579012070;
        Fri, 12 Dec 2025 14:36:52 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm173998fac.10.2025.12.12.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:36:51 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/7] builtin/repo: add inflated object info to keyvalue structure output
Date: Fri, 12 Dec 2025 16:36:41 -0600
Message-ID: <20251212223644.3090879-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251212223644.3090879-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
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
 builtin/repo.c              | 32 ++++++++++++++++++++++++++++++++
 t/t1901-repo-structure.sh   |  6 +++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

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
index d3dfe416d0..3a2d15cec4 100644
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
@@ -428,6 +431,15 @@ static void structure_keyvalue_print(struct repo_structure *stats,
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
 
@@ -491,6 +503,7 @@ static void structure_count_references(struct ref_stats *stats,
 }
 
 struct count_objects_data {
+	struct object_database *odb;
 	struct object_stats *stats;
 	struct progress *progress;
 };
@@ -500,20 +513,38 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
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
@@ -531,6 +562,7 @@ static void structure_count_objects(struct object_stats *stats,
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

