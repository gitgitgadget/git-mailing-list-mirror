Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6579DA
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883931; cv=none; b=mRalT5Qc04PbMJAyFCLmN4YQs1S/aUlpCP6UIvnqk0Ovqk79Q2bLJ0uKdpORsy0N6o4/dUNLPCKmGXhoqv6qDpMjfUtDN12fyW3VZVC7zQMH4REyvAdJaTAeX2F8pE7c/CkVEfexpscUkI2soiUOEhYY1sDDWdZdeyBwuzaj83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883931; c=relaxed/simple;
	bh=9kSybU9pIXo9fNxohb2vmMYE92XgACMRxfoJtBKEfrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeagOgY9geqveqECCbQ27eEe66P6oDUoeHsw6rOpXN6W2+h6c8uYCdX2qQOj0SqTdkBnTvrA+ZWmcrEcGnT/943oK4PdGXDQtLTYAuQmMvnRd6qfeugYi/MQMuSlNarizAChrMmDgsQ+ERTz6OJZSZd1dqN8X98xO3A5yd9m3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBI7ynmg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBI7ynmg"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31329098ae8so2325951a91.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752883929; x=1753488729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsTgSr/WIMjodysK496Wd9OqSR8LUDZmvTWoq1lzOzo=;
        b=BBI7ynmgycW4AUBfyWAqAD2f7BuDLdu5YrGnE2784/5u0gEOQafl5QeagGkWMT+aNA
         CgRpyZF0i1iKo+zIH+g4Fk6TE56xv2TOLsj6V/2G/6KPUufI1YtdZh2AFH1VOInrpfrZ
         VBlI19zN6XyLvXmj38gOzk+tEGmlih7BDxQPl7JK3Y/mYWd9v5ruM+qotHwrsM4mjuSs
         HgpH4OGvHvnLLvBkAgGAPHjqdX3kztip9yll2B/irOFhqhHX7KEFTyldVe7FgbVpPth+
         qw5tecKbNvJ2uIvV9MZGDJTOrxdDEIgCijHgDxUyJlJFJTyCsJI7w86DI9L7MB7lNpTY
         /cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752883929; x=1753488729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsTgSr/WIMjodysK496Wd9OqSR8LUDZmvTWoq1lzOzo=;
        b=t8O8NjXr7Qs2hk26kzLKZ9jwJ2EMIC64GHD3yBx9Xe1g7ykOwuA/urJkgeKV/wBzrL
         9KUItolQNgsPp2SudRxlpys3Ddkwaw8uMx8PKH/hAFtf7m5/3dfSU7MNgVgjyrT5Gt9M
         W0CrYi/G+Wib/85KFKvslpU/c2JXiwwDgOobiuP3FnDiQmsSs1Y6BwB9ohY+vNLBkoXs
         aEDsHOz4J3cC4VyJRwXOINmQmFPJIV0cWkZdnh49AbA1ViTr90hPjAeLSTMzvKC9wvS6
         dRa24KHuQ1bKa0RDDl4h+tZbTbDSxKiBX7oipfSs10hUHjJNd6qVkYWQybZ0J0FfNa2O
         hwvg==
X-Forwarded-Encrypted: i=1; AJvYcCWSadm6HcCc0oeHedYP3FF4Z+kiwAbAl+ZN3E21zy3YQgReu6FXWbgp/XUqhb5+bmm+uHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71pNMa+0kdNhQwh4c/1p5/mSPmbxxcShWjooHEHc/b+tEu7b8
	qqE5PH+ZuWHiSD0huJWhCy4iox/QdF1Bi2HXve2TbGltL8ovzq9pGy/v
X-Gm-Gg: ASbGncvRn23BihBNWpJ42MHIYFcLGMnLVAhL8GCLPVJHO832IBuZVzS6wHbnDuUYGmt
	7oTgo62qW47wvFJKoX8uD1CRlIcFet4/qerdQlWmjMD95XpFsQyhARpVhLqvbKGbv08r6To81Xc
	M9s7IlsxT3VSNWI4OuT6xHNHUIuFEiQp6pz6VFHUo5zbRNUTXE9UOKFfNkJ6V25DllmrvjB9Zv3
	JYYcRAh4cicmtZTlciG266heycHB/iVTAdXR4vvV/1H/0JM4HpR4Um3WnfkAPNHh/yeqEMWqeZb
	nIoRFkX+fgUwu38mKkiGqXB+6Q+RdtbqbD8mYmddfjNgCpZvj19r3gV6arNXWL72+unbrhRRa5y
	PV5ogp5NnO7hp/RBqjolDfPPUFafmTM+9V24=
X-Google-Smtp-Source: AGHT+IHWPsve8zOes05piqmVhPlY7kgUhqKzqhtD/ewnbyQ0EWCr+8/UzM7hTp1cJkde4USfNGAeIw==
X-Received: by 2002:a17:90b:5203:b0:315:f6d6:d29c with SMTP id 98e67ed59e1d1-31cc045a515mr8813455a91.15.1752883928719;
        Fri, 18 Jul 2025 17:12:08 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3d5e765sm1964268a91.0.2025.07.18.17.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 17:12:08 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	ben.knoble@gmail.com
Subject: [GSOC PATCH v6 3/3] environment: remove the global variable 'sparse_expect_files_outside_of_patterns'
Date: Sat, 19 Jul 2025 05:41:28 +0530
Message-ID: <35137b6814818eb5f13d6c54b8532d551bf33cec.1752882401.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752882401.git.ayu.chandekar@gmail.com>
References: <cover.1752882401.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The setting "sparse.expectFilesOutsideOfPatterns" is stored in the
global variable 'sparse_expect_files_outside_of_patterns' and allows
files marked with the `SKIP_WORKTREE` bit to be present in the worktree.

As this setting is closely related to repository, remove the global
variable and store the setting in the `struct repo_settings` along
with other sparse checkout related settings.

This also allows us to remove the definition '#define
USE_THE_REPOSITORY_VARIABLE' from the file 'sparse-index.c'.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 config.c        | 14 --------------
 environment.c   |  1 -
 environment.h   |  2 --
 repo-settings.c |  1 +
 repo-settings.h |  1 +
 sparse-index.c  |  3 +--
 6 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/config.c b/config.c
index e13f7d8fe8..ea6de843f7 100644
--- a/config.c
+++ b/config.c
@@ -1631,17 +1631,6 @@ static int git_default_core_config(const char *var, const char *value,
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
@@ -1803,9 +1792,6 @@ int git_default_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (starts_with(var, "sparse."))
-		return git_default_sparse_config(var, value);
-
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index cd5ec5c736..cf52fa9617 100644
--- a/environment.c
+++ b/environment.c
@@ -63,7 +63,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int sparse_expect_files_outside_of_patterns;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/environment.h b/environment.h
index 5642156d3d..aaa3025df3 100644
--- a/environment.h
+++ b/environment.h
@@ -159,8 +159,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int sparse_expect_files_outside_of_patterns;
-
 enum rebase_setup_type {
 	AUTOREBASE_NEVER = 0,
 	AUTOREBASE_LOCAL,
diff --git a/repo-settings.c b/repo-settings.c
index 505e402276..5e0ba4ae23 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -86,6 +86,7 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
 	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.sparse_checkout, 0);
 	repo_cfg_bool(r, "core.sparsecheckoutcone", &r->settings.sparse_checkout_cone, 0);
+	repo_cfg_bool(r, "sparse.expectfilesoutsideofpatterns", &r->settings.sparse_expect_files_outside_of_patterns, 0);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repo-settings.h b/repo-settings.h
index 1b43c4029c..695c0fd0ce 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -71,6 +71,7 @@ struct repo_settings {
 
 	int sparse_checkout;
 	int sparse_checkout_cone;
+	int sparse_expect_files_outside_of_patterns;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
diff --git a/sparse-index.c b/sparse-index.c
index 3b51ea46e3..552d26adc1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -669,7 +668,7 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
 	if (!istate->repo->settings.sparse_checkout ||
-	    sparse_expect_files_outside_of_patterns)
+	    istate->repo->settings.sparse_expect_files_outside_of_patterns)
 		return;
 
 	if (clear_skip_worktree_from_present_files_sparse(istate)) {
-- 
2.49.0

