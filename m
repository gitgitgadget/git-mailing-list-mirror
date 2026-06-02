Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5473F7884
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420266; cv=none; b=P7JmV9hPSzGs++T+dmimS3YQjcygs1WwphBO97jJnmcaVlFWmsR6s7a8FTwCRJlbaGv6GlVC1JYiTD/CrIG9B8vkIgE5xSGoghmIjNcEbYG2xCzZjtH3FDz9m2VmfVZsi7vHfeAqMuD9Kn/IM/HVd3ssDH7xsnq5fSh9thZiq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420266; c=relaxed/simple;
	bh=tf8XiYNvW3xfKV8FctG7UVk1Kf7uZV8HLTCIyxQ6gP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B974cGMWo1FJ6jSi5lvwagUeV3YdHAmruGGMQWVR46zaAwLOaxjzOAiHVU9jqlBz2UCyIU9OU5dDaQuhk+0tKYLjNeNhQE+PW8wG3x2QX5cZPOYKs1tLkHazP7v65xtZhB/ioZMe9XUFmQ+pJEwbrbqvmXoRJhrBUfWHBNHS3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7l8Rq9M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7l8Rq9M"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4905529b933so91685645e9.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780420263; x=1781025063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITUfnTpQJhScuzx0WJslvdLIqgGFtd6IeMFAYHTtAJc=;
        b=A7l8Rq9MYCijT+Tl5H6xG3EDeogdXGx87LwrqrG8gdGVomeocDKcAR1wnZjljswzAY
         UDvjUr6jwNL5DZu6xoqqbEohEpuYh7W4/DrEXy8zKmhANU3kr5DUPJ43z8pYi1L9rONm
         HlSWhBXXh/4pwYSRBhFY7EsTsLT6gvgcHc/UcSm65Z7jwhw8CZvrGrjVwzuJVcKkpe4k
         3GGoP8+oGfNdx9dxRGM6zn1caOGgA4JQ1z36rRuftidVHEL1X7c4A94GwrssiAGZZR+h
         mIKoEMJTd0HsAaai4bUbkqyBRHsia8FjPIr7bxMt+YqW+KeJSp0jQ/BlT4tCtNiYCocH
         VXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420263; x=1781025063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITUfnTpQJhScuzx0WJslvdLIqgGFtd6IeMFAYHTtAJc=;
        b=nDoTWqafKJtFPN7F6lrB2aTUdDYbyJTT7FFLAcvK7EZsFjm72mMWD78DIrX08GeOZM
         Xy4Ser/VKzJg3RV/W9zhkjDy+oII5EXrZHIrvXDjjMe3POtbDxFe4Yv4/1CsVxWzZc+N
         VABQxfvJCtihQ+RBFIx5I8RyZ5LDAcUrZ7TEjq/bRhCtu+b2/FKIAvvSWgXybITFdvKw
         SE9QpnfSDdMH6rpfdkBhmRluxUAgLqvgV+flaSGn7B+uad07QwQ9eS66DaqOsDfAtk/N
         KzZ9p1yYL0SRWG4VY2bTzI4z0/ODD6vefJnqyHA1Q3kreoGjb5KkFz0lBLZibY6cx77A
         KdiQ==
X-Gm-Message-State: AOJu0Yw4mJ/e9t2fjROgq+/0WuO25MpxQDXAknc58RbtMXYN5puZUgnm
	bRJMRiA23avYvcrbp7hshUPOB1fjMuzJPk4aU61chAxy2rQx77L3SRYQZCeGgSNn
X-Gm-Gg: Acq92OF52ErM90kAXjbXth3Duf41aKCAFm6oUpUsJvn63OKge8OhTWdE9GpmWK+1xqi
	rezNNYc4DEr2UrY8gSnPP7Gb/0hYwciSAJjOpw9/XZO90OS7BjhER0Ovxo+MtZQiwv+KSJwyi8k
	ZWPahoP8V5pb6kuqBEFO8q/qaWibzI1WCziga4grdqo97hIA8P2e+PpfE2fTEQSY2FYbLYiUQlG
	oXXQ2VZilOgIiNDs+O17dnhNjRXmTulvODvmVmCwVWoJ4GKUWVeAPI5Wfy8myailDFPmkno3GmU
	AEoEIBXfMqyUjCLnQg3r74wdU3ZoSHQvVh/cu2K6ri0LR2v/t8/sxeZ1p0IkmSq9vL0RLaQp+uA
	9/O77DjBYGiAzhTFXXZK3f2KPYAyf6oqpnu7F2UWHcGba7BSS+3M0X6JHTxUL9Q0i1pASYz8iHP
	hqBx1Lr3IKwiNw49/LwObg9zX20a2tMt09PCSR7oOKF7dppSy3hCovn5fAuMtOkG7s+ZmxUji5z
	mdb6bFEEQ==
X-Received: by 2002:a05:600c:4fd5:b0:490:9dc3:3473 with SMTP id 5b1f17b1804b1-490b503ecddmr10645385e9.2.1780420263098;
        Tue, 02 Jun 2026 10:11:03 -0700 (PDT)
Received: from pop-os.localdomain ([102.91.81.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e239f4sm122904265e9.7.2026.06.02.10.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:11:02 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 7/8] environment: move "sparse_expect_files_outside_of_patterns" into `struct repo_config_values`
Date: Tue,  2 Jun 2026 18:09:20 +0100
Message-ID: <20260602170921.35869-8-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260602170921.35869-1-belkid98@gmail.com>
References: <20260601154211.82370-1-belkid98@gmail.com>
 <20260602170921.35869-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `core.sparseCheckoutExpectFilesOutsideOfPatterns` configuration was
previously stored in a global `int` variable, making it shared across
repository instances and risking cross‑repository state leakage.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. This option is parsed eagerly because
it controls how sparse‑checkout paths are interpreted – a fundamental
behavior that many commands rely on; a lazy parse could cause
inconsistent sparse‑checkout handling and complicate libification.
This preserves the existing behavior while tying the value to the
repository from which it was read, avoiding cross‑repository state
leakage and continuing the effort to reduce reliance on global
configuration state.

Update all references to use `repo_config_values()`.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 environment.c  | 6 ++++--
 environment.h  | 5 +++--
 sparse-index.c | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index b0e873e9f5..57587ede56 100644
--- a/environment.c
+++ b/environment.c
@@ -70,7 +70,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int sparse_expect_files_outside_of_patterns;
 unsigned long pack_size_limit_cfg;
 
 #ifndef PROTECT_HFS_DEFAULT
@@ -550,8 +549,10 @@ int git_default_core_config(const char *var, const char *value,
 
 static int git_default_sparse_config(const char *var, const char *value)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	if (!strcmp(var, "sparse.expectfilesoutsideofpatterns")) {
-		sparse_expect_files_outside_of_patterns = git_config_bool(var, value);
+		cfg->sparse_expect_files_outside_of_patterns = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -723,4 +724,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 	cfg->core_sparse_checkout_cone = 0;
+	cfg->sparse_expect_files_outside_of_patterns = 0;
 }
diff --git a/environment.h b/environment.h
index befad9a388..609cdaa07f 100644
--- a/environment.h
+++ b/environment.h
@@ -98,6 +98,9 @@ struct repo_config_values {
 	int precomposed_unicode;
 	int core_sparse_checkout_cone;
 
+	/* section "sparse" config values */
+	int sparse_expect_files_outside_of_patterns;
+
 	/* section "branch" config values */
 	enum branch_track branch_track;
 };
@@ -179,8 +182,6 @@ extern unsigned long pack_size_limit_cfg;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int sparse_expect_files_outside_of_patterns;
-
 enum rebase_setup_type {
 	AUTOREBASE_NEVER = 0,
 	AUTOREBASE_LOCAL,
diff --git a/sparse-index.c b/sparse-index.c
index 53cb8d64fc..1ed769b78d 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -675,7 +675,7 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (!cfg->apply_sparse_checkout ||
-	    sparse_expect_files_outside_of_patterns)
+	    cfg->sparse_expect_files_outside_of_patterns)
 		return;
 
 	if (clear_skip_worktree_from_present_files_sparse(istate)) {
-- 
2.53.0.155.g9f36b15afa

