Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205F261387
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829783; cv=none; b=aKKtk6FMzLaJ6JBIbQvS4AMdczY+8CgzEriLaLFaA4/fLEjr3N3t1q8Wh7Pgv9XHrQss9UN/J1Ovo+J3HLlnENIMLCrgcID+zt5LSphiKuoxnOae0S06hytN8qYlQ/H3/QUBZLFqYDk02OegHPOHofBwyh8o7Px/frinPXTHRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829783; c=relaxed/simple;
	bh=fvsTW7CATXKcZcnsG6pkEfxPUHR0lbwJxy7EmnYyH8k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DdLCWCiVexn2+dkZwKzrS43lC/UpuOWQwPhOKccb3s6hork4SJF47hR/Cj1jcAT4RxPOezxfgBKQWfc4k6YxB6Xir7EE4J9ymi6izAxHEoE6Q7GtyechfX9Et77mU/3dOzZ1SgcFj7Q1GdA0eZ7h1P9AETNjHCkXRdXAAmV165I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcEWZLKC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcEWZLKC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso45714025e9.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829780; x=1743434580; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0ykdKJIBWGcE8qMDnCJ8K3QLVwZbAQdjO1WA4xszFM=;
        b=ZcEWZLKC/zrIPBbR/ES5Ysot2VAs9K4zzgnVFkx8mQgozOhL3GCO31KMp5trZmEJbM
         aV4GjQH+2WKIoMJknQk+vlC+twKwzEESSadhl1DZu+9s2ZC6zWpysqutFNYpiKmmZpFC
         za35guLjflXFKfaSTIns01Byni51RMNRsof87WWIwREWTlDiQXtDQMo6rkopE8I5yl/6
         dnGwcnqjd7sNF4mIO2Wb03JhWUuCYRpjkn+Zgkx0mguHfEYTVc57sugurKxYhGKn/ki+
         HiVd5nemUqg6CU/Ov1lm7BErcZ3iJktKO4maQL2YVnNeqVAlDrtRJIkQpbVixSbpk//H
         Ez/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829780; x=1743434580;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0ykdKJIBWGcE8qMDnCJ8K3QLVwZbAQdjO1WA4xszFM=;
        b=UYpxdnrnzt3S4DDU/a5wqBJA5mF59DLNldtM21Ftc2zykmKfRCcdwRYYlVXBaosYsS
         GhbYfFEPj2lXhMiMRbHbg01ReCPZye/ROyWKqFqhu+BLsf8xTwKMu+mkfZluD22rKDPE
         37VzsaLypKPjU8dEd+srh6p4USh5zS7wepC1PB5/p1co47bp0lkCIOWTiwASNwdZv4Qd
         WJDYCsXbTAOM6UKu203hoJ+ljUWFAvGyx+6rL1j7ckOqeG8zwQ0Zv/h3SpL+0FoR7Foi
         8Ez8fKlXIv4YxY0VBnR3XC4w+zCiW07Z0G/ARjGNDfOLNMfsIrCQYX9ey9gWof+7O0um
         /epA==
X-Gm-Message-State: AOJu0Yxz1mGXN/dmxoBnJjnj27DF/qU5gGi/Ur9DvQmWh5MuC84dgqiB
	+HGtlLNv1eLJ3ke2bPJIwL4gcpwVDuoBEv1wZ7uzK1YbVL8gMY/ewsOkBw==
X-Gm-Gg: ASbGncsKLggXBuSvAFxpA1hIR1D6LNna0iClUvZrSkPUGCJfvlA40hUEY7URgxy73S6
	NOTdOMfwRHb4w/wLMck0OufETSx57ceesKEoWoEZYQkBWOYAF9W6+W0t/mv3NcOrw0xqGu0EwWH
	5i0eAfWvXgaZDGjWw7kGIBMBxSNRRTrI0UGWZ31xoKqUhe2+UiU1sFw4wOOm+vQgo5byIhav9/4
	cTybllCSmAi/AxUfQPnMpfONC6FKjkQ8GLf5mkMDopJiI9zoI8DVyrU4dhljjm9ZdnA4s+4XTVu
	kMbhrY46BU1awA0Lnq0Tden5AJgehOQ4oDXIPVhybzXycw==
X-Google-Smtp-Source: AGHT+IE8LqBP9GzQm7HFPYKjXnSXVh3kY1BBQTdtZKHP4ycHLPUywz/qWnKR+AHslVtL9uCAcwlBAg==
X-Received: by 2002:a5d:47c1:0:b0:391:13d6:c9f0 with SMTP id ffacd0b85a97d-3997f940829mr12739442f8f.47.1742829779879;
        Mon, 24 Mar 2025 08:22:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39abafed528sm7787831f8f.27.2025.03.24.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:22:59 -0700 (PDT)
Message-Id: <dd66a5b46f2ef52eedea323df891a2e24fcd48c1.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:44 +0000
Subject: [PATCH v2 08/13] pack-objects: enable --path-walk via config
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

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/feature.adoc | 4 ++++
 Documentation/config/pack.adoc    | 8 ++++++++
 builtin/pack-objects.c            | 3 +++
 repo-settings.c                   | 3 +++
 repo-settings.h                   | 1 +
 5 files changed, 19 insertions(+)

diff --git a/Documentation/config/feature.adoc b/Documentation/config/feature.adoc
index f061b64b748..cb49ff2604a 100644
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
index da527377faf..08d06271177 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
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
index a6b8a78d42a..0ea85754c52 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4652,6 +4652,9 @@ int cmd_pack_objects(int argc,
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
index 67e9cfd2e63..9b5595c708e 100644
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
index ddc11967e01..a31decad221 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -56,6 +56,7 @@ struct repo_settings {
 	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
+	int pack_use_path_walk;
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
-- 
gitgitgadget

