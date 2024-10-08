Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A364F1E0095
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396741; cv=none; b=IJibQPtJIW/MDjNtTt0hZG2giP4dInR35HT427smndMWVrVhqF9Vxrtbnb8UtUgemxGn/x+6L8aAj4/HM5+mYNsOEuoomLXgKDfs2xI+ZPi5ahQSuxMl7TPkxSATcWUTJ75l+8+fDC8S9g3vyspo/yi7RHa1H3BjBLMeSGMZL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396741; c=relaxed/simple;
	bh=Nfiu+0AxVx/VRfkIFNR8CJIV9740KXSzsSnAG8rORQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SVvMn2eQPaXoBh5QJ224Qvuw3op3haE2U6j/+lnW8XB4sLdABosVicnUg6B2+Xe7shv5n5YU3m9AlpYiYnH7NFTiHn6FPkm4quTZamuM1+iBcHf1Qi8IOOSCp0cOkxaB+qxM65hSHF0W3qhPMxVFx0zygRq6TF9GugI4g+f5i/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAuUFbzm; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAuUFbzm"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9963e47b69so215757666b.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396738; x=1729001538; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGpXM44rY5FvP9DhPLf2Gor5TEffnwhr5pnOtktibnU=;
        b=SAuUFbzmF05SvLa0pPpXNcyoXeoJ8rwunB12ozmSzmYJrzkutryjkUn7ku3oJGJk32
         gE6cVj9CCIWVS03UbRWC46jXtZ3zeqJxv4pn517MTNBv68LkNbxOe8LFGT0IMZBJG+0k
         un29bYpL/UMQ/Pna1MSGEB4XWPLYmNTl3zzzwhgthej5O9skmCf4Wj/Y1BMKZ3cx7HNU
         lOnMnpfQwcd4Txy4OC1y+cDk7EhH6FNQaHvGM1lO6kgdZJwupWcEcVzezusb8NjPQLgw
         jD/sfsIXSf8Fcv96jFnn1usZpIugI5sD3Rl0ZUYGbyiLvGFcgDSHbMaA4lbcQ/ps6Hmi
         IC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396738; x=1729001538;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGpXM44rY5FvP9DhPLf2Gor5TEffnwhr5pnOtktibnU=;
        b=kZ/Iqe+ByMksKyRFix9GALEzYwyZe8aMKmpxYdG6iOorDxxt58vJVPcRLiTWpoIy3Z
         +QbuZOphG8/wpYue47Jmf8XM1lR/eVy2l1F+qGXMff4hOOQyxpDGgsL++1mMifvvD9zI
         8XznBbO+F5fZTbAlFVH0ypsp6CLkWU3h4jJQ7zQaFkyecj2UKXI8NvNOIWoYV7uRDOrZ
         24aFkP1iT2Zi2YMzNFzIQzJ1c0M2VR5Xk67SgcJMlrV3h0ILK0hDuDFqSRSsgZqIdEud
         FlV3/kka3dkoT4RAnzCu11Oi5RtGYUicSyPZRxNLaAnmLkAVTiExmHYnKQFEO+Hz4eD2
         q3Zw==
X-Gm-Message-State: AOJu0YzMuYVYuQxV1xVqxwjBhm+ArqlMFbtyLpw47u1p8HgBqKhOautG
	fv+i/wQWS3pwk0SNCcIg2F4RVPUOw3AN7ZDOTKpPuoqgW5Iq90zIV25prg==
X-Google-Smtp-Source: AGHT+IGfYN7RQqbEO0kiJQOGST/+JDJmW/VrwSbiR5SSFSxyzKuuLviBcNBjf7E/zIWue1m7MEc4fA==
X-Received: by 2002:a17:907:94c7:b0:a99:446f:1f1a with SMTP id a640c23a62f3a-a99446f1fd0mr1064408366b.35.1728396737511;
        Tue, 08 Oct 2024 07:12:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e625a7dsm510809966b.84.2024.10.08.07.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:17 -0700 (PDT)
Message-Id: <2a9ae02217fe5d1e3abb49e65410ffd7ffe05f24.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:12:00 +0000
Subject: [PATCH 14/17] pack-objects: enable --path-walk via config
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
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

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/feature.txt | 4 ++++
 Documentation/config/pack.txt    | 8 ++++++++
 builtin/pack-objects.c           | 3 +++
 repo-settings.c                  | 3 +++
 repo-settings.h                  | 1 +
 5 files changed, 19 insertions(+)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index f061b64b748..cb49ff2604a 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
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
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index da527377faf..08d06271177 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -155,6 +155,14 @@ pack.useSparse::
 	commits contain certain types of direct renames. Default is
 	`true`.
 
+pack.usePathWalk::
+	When true, git will default to using the '--path-walk' option in
+	'git pack-objects' when the '--revs' option is present. This
+	algorithm groups objects by path to maximize the ability to
+	compute delta chains across historical versions of the same
+	object. This may disable other options, such as using bitmaps to
+	enumerate objects.
+
 pack.preferBitmapTips::
 	When selecting which commits will receive bitmaps, prefer a
 	commit at the tip of any reference that is a suffix of any value
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b97bec5661e..6805a55c60d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4587,6 +4587,9 @@ int cmd_pack_objects(int argc,
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
index 4699b4b3650..d8123b9323d 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -45,11 +45,13 @@ void prepare_repo_settings(struct repository *r)
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
@@ -64,6 +66,7 @@ void prepare_repo_settings(struct repository *r)
 
 	/* Boolean config or default, does not cascade (simple)  */
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
+	repo_cfg_bool(r, "pack.usepathwalk", &r->settings.pack_use_path_walk, 0);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
 	repo_cfg_bool(r, "index.skiphash", &r->settings.index_skip_hash, r->settings.index_skip_hash);
diff --git a/repo-settings.h b/repo-settings.h
index 51d6156a117..ae5c74ba60d 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -53,6 +53,7 @@ struct repo_settings {
 	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
+	int pack_use_path_walk;
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
-- 
gitgitgadget

