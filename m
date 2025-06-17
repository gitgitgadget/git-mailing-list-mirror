Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071112E06EF
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162086; cv=none; b=EElTrLD0CUIoSELBh73nGlp2suI0YQtK/Su+I96pKtXAmdVxXMOPawRnIO5in6HQKY8xrWTxW0qPkaB+6xJ6Pp7XyO3Nk/t0LgZLW2rbY4zK3cw564uBI+1gri/Y1mzZwGT7L4bioRbZA4uobgW7PJfk0N238dC61YlgpMLuGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162086; c=relaxed/simple;
	bh=tWHndeBhO4PHCPKYBuB2cskdd+C1spKndFh1YfanB0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MImgB/TyPH26p2fRll2npFZZGWw0CshPJWv+7v0x4p84bS0yUOJydsSBSgWmkXXUzdY00Lajm+korcz7l4WVwNgLXwQ9xQZAggsXBCd2bSXwTpFwguJ7qrcRrfZhCDhvuiXAliqM+V/srNURBRCHJH2l3Ct5FM8PuVWSnpZThmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACUAqIKZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACUAqIKZ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7426c44e014so4647599b3a.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750162084; x=1750766884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdH3kPMbgFPyxB4glTNR3nzvi4wkIkgJpsdoFqi8r98=;
        b=ACUAqIKZFYcFDBIFCV21Tlq/RcsOxGFRyGATHJR6LIzWmmffphLZ7+nfzQXhc05NzX
         v+01j3eCapR+m+549t56PqweRl6n3IiyP9yhVILuLt7gRLcRhkX0rxc6aQhNwUzjg+PF
         fg7Xpn/c/wO8PhbY0YX9nAQqPGEl0UOMYZR5suw7UgiiuBnPztU9hPUVqbQ42sZhjSr/
         k+DYQXkPAPy0uWVaLNBbLTN0/5BxwZTFwvJz4IL2MUvlm08bZ7W/oXF+va0l26K1RoxH
         jGXjGm+A+oNSakWPi7QM3L0WExD8oOqDu4luWYBHTM5cx2atJaUldejS4U8NUR0yLArE
         yuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750162084; x=1750766884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdH3kPMbgFPyxB4glTNR3nzvi4wkIkgJpsdoFqi8r98=;
        b=ZUWAwYhWpScUWx8KCVGdYAsm4kqJYQBLqGz+HJ3JAVs8GqxgopZ9frru2ImZORRWDB
         OfwcSDAUmaY/pElMhk5MmCsjg4gvzgC2M1IDhTOiOXClJuiDi/xlBsGg3vYT0FZlpbCc
         sXfHmGWAV5VZpcPm4qeSho095SLcNTpJPD+fuAeO1VwWkIbNsafNB0QZOXhEfRaWsRhT
         R5YagL/w83rbXEbwi+wUn50cqrxfNO8iYDA6h4vT19FY3nXoXE0XQbeK4NE4OZX9LwEA
         M9+OyO++KiA1DKXOWJyeZsBY2QTmoPzWEMQAZhz5TuxxCd3lBWIf7q0pF1a0CcRk9FQ6
         8cyw==
X-Forwarded-Encrypted: i=1; AJvYcCVsuyJ0DUKizv4LUkLo7vxA3YZC1yieQzxl4trLygJsBvAOQ43A8tNMMOsX89sWBpykOrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7IZfnHkRyQQ13nkKna2+SgvfuCsLVHs9bVsSxhTXtR12FG28
	1ayXM/W8qkelP6CqRxvQYj65FpWsA5XZjmxa0BhOy04zSEuYXP8+QW7h
X-Gm-Gg: ASbGncvYI1d/iIFNNa7HrxGB2gNuWD9fkwXTLiYzMUeOFaCZb09YzLoStK4z8ZnLa/I
	oBVWUREKuVH+b8KnSBv77YkfZVLJfCWIPayWBL8dwV79z8TQRlIPnJ77bX2+eKmlt6rG/kEUed3
	SPqafkMQq4QVgLmyNxsC27bJguBy1ozPvDw7NuB8/94jJKk0ZWB1cny54EtroH/Bskbeo2Bj2fa
	tdmvpa2pPvC68kkVCHXAbrigMRinF47vnofziekLlgFR0N0kiqJC+0z7DmHhoppkWl41c656x08
	G0UN2dWL4kut9+lvKWEpHPQEC3vWlPqeT7J3whSylR3jcUxRm+0YCUXUVb8suru2HZ5r7D9ZZdQ
	2kyOT
X-Google-Smtp-Source: AGHT+IEyGs649yQyElvbFaOXOwaWaU/BYmozHlJWsw0uJ1JWl8lrRc+Wj66OpMCemgrvr63UTxi8Zg==
X-Received: by 2002:a05:6a00:3c8f:b0:746:2c7f:b271 with SMTP id d2e1a72fcca58-7489ce0d374mr15567831b3a.9.1750162083805;
        Tue, 17 Jun 2025 05:08:03 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c96:a38d:5480:e4eb:2835:b445])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffed0c2sm8623333b3a.22.2025.06.17.05.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:08:03 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v4 3/3] environment: remove the global variable 'sparse_expect_files_outside_of_patterns'
Date: Tue, 17 Jun 2025 17:36:36 +0530
Message-ID: <a9e1e23685c476b106b3bdb0d37b4ac5dd98ee3a.1750157825.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750157825.git.ayu.chandekar@gmail.com>
References: <cover.1750157825.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable 'sparse_expect_files_outside_of_patterns' is used in
a single function named 'clear_skip_worktree_from_present_files()' in
sparse-index.c. Move its declaration inside that function, removing
unnecessary global state.

This also allows us to remove the definition '#define
USE_THE_REPOSITORY_VARIABLE' from the file 'sparse-index.c'.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 config.c       | 14 --------------
 environment.c  |  1 -
 environment.h  |  2 --
 sparse-index.c |  4 +++-
 4 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/config.c b/config.c
index 707fe0707a..d212329799 100644
--- a/config.c
+++ b/config.c
@@ -1636,17 +1636,6 @@ static int git_default_core_config(const char *var, const char *value,
 	return platform_core_config(var, value, ctx, cb);
 }
 
-static int git_default_sparse_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "sparse.expectfilesoutsideofpatterns")) {
-		sparse_expect_files_outside_of_patterns = git_config_bool(var, value);
-		return 0;
-	}
-
-	/* Add other config variables here and to Documentation/config/sparse.adoc. */
-	return 0;
-}
-
 static int git_default_i18n_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "i18n.commitencoding")) {
@@ -1808,9 +1797,6 @@ int git_default_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (starts_with(var, "sparse."))
-		return git_default_sparse_config(var, value);
-
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 7d46b80711..d51e0a14aa 100644
--- a/environment.c
+++ b/environment.c
@@ -64,7 +64,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int sparse_expect_files_outside_of_patterns;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/environment.h b/environment.h
index 00a5b332a0..5121a28d3f 100644
--- a/environment.h
+++ b/environment.h
@@ -160,8 +160,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int sparse_expect_files_outside_of_patterns;
-
 enum rebase_setup_type {
 	AUTOREBASE_NEVER = 0,
 	AUTOREBASE_LOCAL,
diff --git a/sparse-index.c b/sparse-index.c
index 444da8a753..5d87fc65c0 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -668,6 +667,9 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
+	int sparse_expect_files_outside_of_patterns = 0;
+	repo_config_get_bool(istate->repo, "sparse.expectfilesoutsideofpatterns", 
+		&sparse_expect_files_outside_of_patterns);
 	if (!istate->repo->settings.sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
-- 
2.49.0

