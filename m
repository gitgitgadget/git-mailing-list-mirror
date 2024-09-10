Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C318A95B
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935364; cv=none; b=pr8C/PYJrRoFyVnwMTN9Bh6ha3e8ZH8dXlt/a2Jl4svr9or9vpk1iJeELOCim6Ob5aZ6kTDOYS2JkTWwb6/PI7Pf0EtLJHqItph3ggVxxuUG3g4jccorGysqjtiZtqD6TznZhYUt49EaGaWBL2QWR5OAlC+5VnEcnxaw21xhzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935364; c=relaxed/simple;
	bh=35AKWIL9mvOnLvhQBUnekstnxUMHfQZ1FpDoQc0fKBs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=osrmDbpGE4fmB3fgXcrehiuQL5L0ZLHEjE30MfB02VqHipFfti1ccXBFpc7Md4SfcXLrVE4l2AUjAHPCS4/TXbZ/N028ZCknmPnyzWk6gBiGU6/a583m0AHyrDJZp/HiMKkSypkUTrqnlE47r0CRcgan3XVVIt1lVADsVciYjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8giCAoR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8giCAoR"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so9234529a12.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935361; x=1726540161; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxYwP1Fn/4Uu0YYO0qKr6oF88g/DMHt71Jrq/P+mPwk=;
        b=m8giCAoRFYUpXrAKC/iB7UEhXDb1VwWW4KFj7r06LyQrlhBsbU+mrktVk7ZKqxhFCI
         tIIlUukM6welmocPmKjGDK9ICv1JuLYdR/iSDLdzCBfQplFBNZEb8qefARl2NOkfmDn0
         c7coo8xTeRpd1n4jDfxzNok/GVPskR8gUzmkPUP/NtdlyFQfrt0UHBIFtR3djAyDU9wI
         VsK5E6dEX5a66HNfWKxg7zVqvY0cT4toGW43pBr40T4n2ulTjiDSejEpnTuaakqyrDf1
         j0ZJhfevvXMUdy07kdieENiV0NStQo5CVyOzx9uK1Qur1HI67vHtmu1gB7zyr6IIMd8j
         5oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935361; x=1726540161;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxYwP1Fn/4Uu0YYO0qKr6oF88g/DMHt71Jrq/P+mPwk=;
        b=vXMWpLjoJ96sRrjl4tquJBgzMKnSRIZIRnBDwCjGemReOw4g8mHZ8PCt98YAA+gGgM
         v6CCbi0hsGwTq3Rd5z3lP9Z60LKLi2/EQpFDXm3EIPDK/Tcb27qsrBDCegBeyuPl5eeb
         ytQR1aVwSvn7iAJPXBhSksS4mMU+DzM2YwfJCo34uoX6LeCzjbnoUwPnl1vmKV9OEsXu
         JOTPzKGmjy7zHwaZtxHaPR6PTfY7VElEmfjrkbVk72FFl/fhjuY+d2yIcg9Px1PiOHQx
         vw05LE46/M4HSSg1s8ThnYvP8rhWHMJ1NkkoDS3W9tz8vccpGUytSn1AoA8Br5YjpZDT
         AICw==
X-Gm-Message-State: AOJu0Yy76wWoVd+qaS5wI6y6hBEHs+HAjTKz3VwnXgKlC33MDd0NAdsk
	RenSdUlVg0o7gX8B/3YvpASOd3i2BCDrcxoNjvgpAN/0DzDTVPmRBS/Eiw==
X-Google-Smtp-Source: AGHT+IHCpQe6Sl8xG3/I6n8Hu7qX8BgDKSm1QI8JF+dgLJCd2Q/hnNs6VTrOaPA0osGFSo+0DUlkwA==
X-Received: by 2002:a05:6402:3596:b0:5c0:c559:ad6 with SMTP id 4fb4d7f45d1cf-5c4015df1d1mr1538135a12.6.1725935360746;
        Mon, 09 Sep 2024 19:29:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8c4c6sm3650172a12.86.2024.09.09.19.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:20 -0700 (PDT)
Message-Id: <1942f7d03622f2740d83e766fca65938cb590f6a.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:50 +0000
Subject: [PATCH 25/30] pack-objects: enable --path-walk via config
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
 Documentation/config/pack.txt | 8 ++++++++
 builtin/pack-objects.c        | 4 +++-
 repo-settings.c               | 3 +++
 repository.h                  | 1 +
 4 files changed, 15 insertions(+), 1 deletion(-)

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
index b9fe1b1fbd5..e7a9d0349c3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4534,12 +4534,14 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	disable_replace_refs();
 
-	path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
+	path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", -1);
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
 		if (sparse < 0)
 			sparse = the_repository->settings.pack_use_sparse;
+		if (path_walk < 0)
+			path_walk = the_repository->settings.pack_use_path_walk;
 		if (the_repository->settings.pack_use_multi_pack_reuse)
 			allow_pack_reuse = MULTI_PACK_REUSE;
 	}
diff --git a/repo-settings.c b/repo-settings.c
index 2b4e68731be..d9597d84556 100644
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
diff --git a/repository.h b/repository.h
index af6ea0a62cd..2ae9c2b1741 100644
--- a/repository.h
+++ b/repository.h
@@ -62,6 +62,7 @@ struct repo_settings {
 	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
+	int pack_use_path_walk;
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
-- 
gitgitgadget

