Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38CF279334
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419153; cv=none; b=bWVC6rU4iXkL5FGGw5BGtxajGVHBSIK7Q0fIF4fkas4Cf66ArBKLbUFB9cZF6AP4NjjSgXNjlMflGS/Qm59wR++3OCgIZQgym0w9gcD7WcNeuxlCD7bPI2nsQEY0769d2xlenQeQWUCiATVBAFvYhqiOOKr8QweDcAIh/Qs5epA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419153; c=relaxed/simple;
	bh=iy4bqEfmcE6f+20Zyp66iSW1zqpyXBBSbfYno0/5Zfs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PSJYbe59FyhitjVVfzkZBMfd6Sxe/ZISWID/ROch8JxDeEow6ggX7874WiSN6Wtyn5cA9wAj39SnzKHo7btvQl4albBSkrYcrJgiN20BPiOVh0oFsssjIMovBp8+LhHStK52+v3T6rT29gdH2FYRyt+iQQftXz6rkr/34faUQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZxjd7Im; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZxjd7Im"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf257158fso17481375e9.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419149; x=1748023949; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eibB/W76p0D+v3cjJVOHkJYTdhG+ew5bx1u09qGqV4o=;
        b=TZxjd7Imvj3pQ3Rp8IrYKRsJcb8JEzRnANr4P5ZHwGGd2j+dekphItGEKxAsp2ZceF
         /uzgYFpPbOZVmmdmWLm8ZWxUnGY5/YhwCJuaOyQGHFxwRTxsae/rWFY4TPMKbCmJit0D
         fbT4XVr/FXgZzy8jfTatZ0gDILr2FUQNwHY9dhXBXe3dbo+hlP/KHbbd/D6mK3MFQ6za
         5wCNd4AffpwhjijUcp8Bnwm9lpEV264MB8m6sAZrTJ6menqhjojSUAI9L2V3EsLuFYQ+
         5fA+eYpaNT7F05dXzVB6LjvSsXHHYyhJyRqBtQyVQ+zE11+fhJT4pc16LEzjaYb5pGUi
         6kQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419149; x=1748023949;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eibB/W76p0D+v3cjJVOHkJYTdhG+ew5bx1u09qGqV4o=;
        b=RboAni7tJK7xku9k0ioQNdYGW6GNwwXAoG8qUH8CNJVV/YdIfodeAAcveBHY3VBBJ3
         nCdRggetHzX8dMpLoLr6EDtJQANkqvzK+WOtVc9YzNeWhFFtWFQKEzCM+VgclPbYbhs7
         qMQMUYAuZLG1y39mgLdAgHk+9Zwm/0Pb8ei6857iR/qE0Pn+KpN8YcNtBuxNHYGepHN4
         KiMvSb2MADOoRJ3GvRI92xiBv4hOFlmnNuOoLp6JdWsJu4TEkCBLpLXqM7qqB6mW7IOU
         nqPJWuF9pM0fFHzalAKrG0dGU+ZoW2h5qMsFq6P32xXRhbHdkoA0ZE1+YNs+lL1Eh/sK
         eHyA==
X-Gm-Message-State: AOJu0YwZIRafoapH7YfCz39mlUqO3LiwTILgQ4Om2BugDxVZSZ0OC7yi
	Zwbzt/W8af7iSmVYyAbZeSY3O6npRnxMZ0ccbNk8L8ELomM6OxxKkrLAi6F17w==
X-Gm-Gg: ASbGncvInOUWsf5z043oJJhUYq5fBKw7QfsE1TwJ2drDHKb/1qMGcYgYUiMjlsjezkO
	cVfWek5QC0zgC8/aDDXwJizQfdDuL5jxNyOQc2FQ84w1qdk/U/Pi5cY2qEMCFDnv5/7IZUis/8q
	xOp4C2L3+p8o3h5y3TcEB5KO2bpHf7tg/WwualJ4qq5QmS241zu+W6v2irLSjBk6FwzYTGjmfYU
	aeCmc2WP83XazaMXude2NboxDXzXN9qVyV537WGE58XZE4jPNEGn8oGjtC1HvZTrFSfMWTeYAWL
	WuAqsNeWWet/FD+xUWVv54RcYfeokCqGqxy8qO0mrL/BBJbjj5hH
X-Google-Smtp-Source: AGHT+IEN1DX4q5ql9AD+4Ch5SKcyQRPqxQQrrhMx9ftOJOHh8cFanqpzAG9gW8toWl5HtT2/y+nDGQ==
X-Received: by 2002:a05:600c:8115:b0:441:b3eb:570a with SMTP id 5b1f17b1804b1-442fefdab8bmr37850605e9.2.1747419149503;
        Fri, 16 May 2025 11:12:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd59704esm42011515e9.36.2025.05.16.11.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:28 -0700 (PDT)
Message-Id: <b98e71d6d549d916f3d827e1eb3da6ac7391392b.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:11:58 +0000
Subject: [PATCH v3 08/13] pack-objects: enable --path-walk via config
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Users may want to enable the --path-walk option for 'git pack-objects' by
default, especially underneath commands like 'git push' or 'git repack'.

This should be limited to client repositories, since the --path-walk option
disables bitmap walks, so would be bad to include in Git servers when
serving fetches and clones. There is potential that it may be helpful to
consider when repacking the repository, to take advantage of improved deltas
across historical versions of the same files.

Much like how "pack.useSparse" was introduced and included in
"feature.experimental" before being enabled by default, use the repository
settings infrastructure to make the new "pack.usePathWalk" config enabled by
"feature.experimental" and "feature.manyFiles".

In order to test that this config works, add a new trace2 region around
the path walk code that can be checked by a 'git push' command.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/feature.adoc |  4 ++++
 Documentation/config/pack.adoc    |  4 ++++
 builtin/pack-objects.c            | 11 ++++++++++-
 repo-settings.c                   |  3 +++
 repo-settings.h                   |  1 +
 t/t5516-fetch-push.sh             | 10 ++++++++++
 6 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/feature.adoc b/Documentation/config/feature.adoc
index f061b64b7484..cb49ff2604a6 100644
--- a/Documentation/config/feature.adoc
+++ b/Documentation/config/feature.adoc
@@ -20,6 +20,10 @@ walking fewer objects.
 +
 * `pack.allowPackReuse=multi` may improve the time it takes to create a pack by
 reusing objects from multiple packs instead of just one.
++
+* `pack.usePathWalk` may speed up packfile creation and make the packfiles be
+significantly smaller in the presence of certain filename collisions with Git's
+default name-hash.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
index da527377fafc..75402d5579d4 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
@@ -155,6 +155,10 @@ pack.useSparse::
 	commits contain certain types of direct renames. Default is
 	`true`.
 
+pack.usePathWalk::
+	Enable the `--path-walk` option by default for `git pack-objects`
+	processes. See linkgit:git-pack-objects[1] for full details.
+
 pack.preferBitmapTips::
 	When selecting which commits will receive bitmaps, prefer a
 	commit at the tip of any reference that is a suffix of any value
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4fd88476dd29..bdd20c074a9b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -44,6 +44,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "path-walk.h"
+#include "trace2.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
@@ -4283,6 +4284,7 @@ static void get_object_list_path_walk(struct rev_info *revs)
 {
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	unsigned int processed = 0;
+	int result;
 
 	info.revs = revs;
 	info.path_fn = add_objects_by_path;
@@ -4296,7 +4298,11 @@ static void get_object_list_path_walk(struct rev_info *revs)
 	 */
 	info.prune_all_uninteresting = sparse;
 
-	if (walk_objects_by_path(&info))
+	trace2_region_enter("pack-objects", "path-walk", revs->repo);
+	result = walk_objects_by_path(&info);
+	trace2_region_leave("pack-objects", "path-walk", revs->repo);
+
+	if (result)
 		die(_("failed to pack objects via path-walk"));
 }
 
@@ -4652,6 +4658,9 @@ int cmd_pack_objects(int argc,
 		if (use_bitmap_index > 0 ||
 		    !use_internal_rev_list)
 			path_walk = 0;
+		else if (the_repository->gitdir &&
+			 the_repository->settings.pack_use_path_walk)
+			path_walk = 1;
 		else
 			path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
 	}
diff --git a/repo-settings.c b/repo-settings.c
index 67e9cfd2e63d..9b5595c708e6 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -47,11 +47,13 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
 		r->settings.pack_use_bitmap_boundary_traversal = 1;
 		r->settings.pack_use_multi_pack_reuse = 1;
+		r->settings.pack_use_path_walk = 1;
 	}
 	if (manyfiles) {
 		r->settings.index_version = 4;
 		r->settings.index_skip_hash = 1;
 		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
+		r->settings.pack_use_path_walk = 1;
 	}
 
 	/* Commit graph config or default, does not cascade (simple) */
@@ -66,6 +68,7 @@ void prepare_repo_settings(struct repository *r)
 
 	/* Boolean config or default, does not cascade (simple)  */
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
+	repo_cfg_bool(r, "pack.usepathwalk", &r->settings.pack_use_path_walk, 0);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
 	repo_cfg_bool(r, "index.skiphash", &r->settings.index_skip_hash, r->settings.index_skip_hash);
diff --git a/repo-settings.h b/repo-settings.h
index ddc11967e015..a31decad2211 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -56,6 +56,7 @@ struct repo_settings {
 	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
+	int pack_use_path_walk;
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 85ed049627d2..33cd186cd7ca 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1907,4 +1907,14 @@ test_expect_success 'push with config push.useBitmaps' '
 		--thin --delta-base-offset -q --no-use-bitmap-index <false
 '
 
+test_expect_success 'push with config pack.usePathWalk=true' '
+	mk_test testrepo heads/main &&
+	git checkout main &&
+	test_config pack.usePathWalk true &&
+	GIT_TRACE2_EVENT="$(pwd)/path-walk.txt" \
+	git push --quiet testrepo main:test &&
+
+	test_region pack-objects path-walk path-walk.txt
+'
+
 test_done
-- 
gitgitgadget

