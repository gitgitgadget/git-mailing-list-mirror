Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0A73D8104
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328645; cv=none; b=DyndKvxcdL/pP7b/h0RI/Rwskqh7Cmsg8qM41E6wf0plKBXp5AnP2k1pSsVq0jK2xG07i/K2PtX42UzmKfdspb6w+vvbwcuMibcSVyLy0kCOcBIBOfV6onB9+jLnGwi9X7GJm9omGCdIZTK26PHqMVsj7P9B5JzrWwyHZSrNwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328645; c=relaxed/simple;
	bh=tf8XiYNvW3xfKV8FctG7UVk1Kf7uZV8HLTCIyxQ6gP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sP3R6+6rkrhH8BGSFaDnabRZ3LgLD/8MeTaGjs2gUXSvIFs8gUWGuPOT5yZhreBsnkx9I2LL/1STARLvAn3WKIYpiNtbBYUpUAn6MaKWpY1OQba/kzUxiXux/+Ib4tENRiRwd/TdnpVAlpiLrL25aahjjqJ9XI6nnWtBbbTSgE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVmzdil4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVmzdil4"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso2763890f8f.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328643; x=1780933443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITUfnTpQJhScuzx0WJslvdLIqgGFtd6IeMFAYHTtAJc=;
        b=LVmzdil4rwQGaO50DZaGeVGYuHtDZIk2LTJdEwX2J9P64EF3Fjb4F5SuQMihg/69r/
         TwmH6t40QzNIuj6Rfs0eJDAZzB17i9+f7iPbiiV0hbIsZ998idTwwg9ENzVszBWwyqP9
         eFQP+758bEV/E14z4mZYXfziETgshKk79sMGI2bzJ67AdLGCmz5kemjlSe+Fyk4BSYud
         Lc3DN/wgZSv3ZJkAmTewqkm5tMkVlqsmm7Rt5VcLb4/brkGI4i0UkOscCxFUKEwNMrz3
         ZgOpuY+7x3TntH9s/sopLb+bzPeZiqBHoOOkiL0G5+gTEZiGXLS3VcL8PmcZW1MqYDk4
         Inlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328643; x=1780933443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITUfnTpQJhScuzx0WJslvdLIqgGFtd6IeMFAYHTtAJc=;
        b=nv8BIgbC02x6NbrrpBDW7IotZQVwwCrKnIEMOhU0+k4/crLBlsILv8Fx3PQLKDOV0z
         m/BR13Gi0IwGxKwVnAi86rrx4Nb1nxGPzlPEf78yN7kZh8vkiM5zJm9f/ROD2UmA09c3
         6emz3Db8yKBOk02Pt1z67LPZs6bhjPnsP3TF9RAWpczpr+NxAHxmXCfGQ0s8stQRhjy+
         2Z03it5s+RyYYJNhnY4aNY7+1mn6BKy5ZfwwXyLxzt4/M350n3pr4LmFaTShYBCBtebZ
         8StwLYfEBV44LgMsCarUjFwyisq+aUwHgq6lTf3sI3B/xfzfo/Hl8ZUqW8MaPLL7lLqp
         DiCg==
X-Gm-Message-State: AOJu0YzJq7U+YnwYl1Mc7/T//cJU4AESjTI9buakvN6pglLP2SIegwEj
	TMr8PlJDDzUhUxFXw/dp8s4B/UE0jUUbG0navs1dHMBLo76jjgAKmAVr7dWv5Mbq
X-Gm-Gg: Acq92OEGipmyIiLwZtUZpr4OdU8odqShgNTpI+qv01yYi+xTLjTBOUX8Cs6BZnnurqQ
	5A9kqGOXVrDrDnYlRchWWZg4ODz0gpbYbEky1a11mpOA1D4haLEhIwk8CqFwxYUr5nZjeeTqQtq
	JMHvTldK5Yf0oqzPSaEmr5yt2tXj7f6kmLj3mKhXDlvFkRjpi/Wo8Bm5lCII2KiBVzScfhZ9RIR
	M9Ra+gTG129CZJVKZQIQd819HLRZ3PBdu6Z/O+epF3RiRNnM2LLB/d0IsNDMuOX0+b20FFxByNE
	igOmHGVw3akBA9vbyPgKMo+F/Pf+cuO0N7nCoLGwLzqCRPLSR7NmkzRLaCz7R1N4ThbyLj/pvG4
	pvqjYG8xOmosBD3NYSuKTZFVD7D2SPh8E7uAn4oC6IYhk66FywhSZ8gh6U+VMtxzYuasIaYnaSN
	BOjojMWehGER1O9j5qyvuqFyhZg9rY5CffLEjrf2XdkSO4ph8j5PJxTuDthC8zcx2DMg==
X-Received: by 2002:a05:600c:4f89:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-490a292c7aamr226021895e9.8.1780328642788;
        Mon, 01 Jun 2026 08:44:02 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e07:e310:19bb:fe0b:a332:fe8a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e81ef4sm350485e9.12.2026.06.01.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:44:02 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 7/8] environment: move "sparse_expect_files_outside_of_patterns" into `repo_config_values`
Date: Mon,  1 Jun 2026 16:42:10 +0100
Message-ID: <20260601154211.82370-8-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260601154211.82370-1-belkid98@gmail.com>
References: <20260423160832.114816-1-belkid98@gmail.com>
 <20260601154211.82370-1-belkid98@gmail.com>
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

