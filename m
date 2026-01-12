Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4943587B1
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222783; cv=none; b=V0ia5vDFYoXe2CgjTOQde/FIGlepHNUbsGxA6KVAHUTBmYxZSuJWeCfF3JVbjMS85HhIOMF6ysUEkDRF2kOSZTZqt1eb67HaErCfvSCftNKvBvb+O2nbE1HPYo8sWYRBdWiBnDAa0Tonr+2H0m3k/GcXd7yahr+/kv59hxbD204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222783; c=relaxed/simple;
	bh=zMIq0+vvS8VdwFyGxT83g1tQeuAIElBvggBO2eEsm3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fjOcox88koLwvIAIbqNxKHjdcy9/G/3MgL/WKnnBkfQbQOCLcUJ7pTgzJNHdnP0ExVTEUZpfVIdBF3RVGzvN/2REX0ApIpGHNGHLbLhah498duvjaKG6uk7DsAvTjOO9hn0s/NuQBu1aoYgvU06lxRfOQHCzX81MomZhySt+Fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+3qlgNT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+3qlgNT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so36651795e9.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 04:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768222779; x=1768827579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtcTgTi1UFPGePmUfbj7UceCV9g4opTa27dOH4D/JSU=;
        b=Y+3qlgNTgppKd6Uo0cWuJfedhmtrYC/SNficrXDIJJPvKjejR9j3WQ4vpgsVK8unad
         DdSd475+JLH+3q0dCByxudzJA8Ymlu6XB2oSeppiX42ikoGNrDlopgKy3AvOalzSQNvv
         WATEw2jIdUcXaAhEE8cFkO4c/6HNm+FtCAIkvids0s553OS8kk5DLYxyf8S8EkyFQu88
         Q0T2mT0jrNWZjx1FYjajn3XUlbSx0Yqee1583yVRB5T7kPqblOqvR9JIec7wDtv+K6Cc
         +lyvPMY3NeJyFMpvfVfTQ4KY+U/pnwlOvX6nLuU24NaaB3HwhF8ZjzDjytyHWoQ+obDb
         OUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222779; x=1768827579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TtcTgTi1UFPGePmUfbj7UceCV9g4opTa27dOH4D/JSU=;
        b=cFtMJ5uxo8yiK3DSXoP2TKfAkpfUvHFNis7vETmofjji8hWsVgzVdoB58G/fdXpQyM
         1ZOs47AIcG63hhoGbFMDi25CrPVjS4pDb6TnPeiHVBJ27QHU5NtTEelLdVNyeqpVDfUs
         v2UcHw3OioDFNluPPj6kVw66ebU5G+a6AwnSk8CMxPfrcxNFbCUE73nrWCs7phP2gJ2s
         hNGdeYrx3EmE+jFd0Z1S4yIHZiWGKvghug9LPgTUjdNSvuvWHtw5Gv7ehyThR5FVdMjf
         bUZvf6crulsgW+Uwuw31KP63rO6OZLEZYHxQET5Dh+MsUJVXzgMAmcEZ6mo+HGxCV9kr
         85Tw==
X-Gm-Message-State: AOJu0YzhXBKP50PlwVjFovh4Hkr3NL33z8kyEJBean6hVUG0yzPzp4V4
	98Rwohw1Ml2pjlBEVtWAH+njPKdPTeTR3nReCwvRuBUKEXYIyIx40GIe
X-Gm-Gg: AY/fxX6haDuwB6FzKW1EQ4w3ZHC3WZf5V3U3SOOR9/KK2Sr7IAwFIGELza+NsKzqwho
	/OxKkN+qGagOgKdo5Zln4ymVB95iHb+8F9srtueWQoqPood7Zel39jByT+XUR4wjf2TrvN0gfCx
	ofL5Q2epnNYgZwHwEEM/zL+kygGdYgQN4SrYraEGWczkSySBnDQdM85oJbVcatvFbWF2BEGzspj
	YMIoDrH/QoQ+UsOXPVNI5d02df/IH8FHrtQh/P3yAuKBUftpp47zamweOkuuuR/McXsb/O3+GYO
	xxd025B9OGSsaZvWsGMx4sXtIg3yf2K0QQ48/VYv1B2R5ASLus8aU5doVvSMHj2WGSRoFou4XDn
	H2hkgrlZnqRNBaVvHY7gJuobMBEX6EpbeQuQeWZvLUqAI9ga53oYJhqMmEf+jc1Prm2P3sv1Jic
	0hH+dV
X-Google-Smtp-Source: AGHT+IHTIzox0eDw01hLVOmtlA6r6e2cZ86qdVkjYXEz4I+oHJMc0EyISkulQEEyDjdDKFIGw5XSzw==
X-Received: by 2002:a05:600c:470c:b0:477:7768:8da4 with SMTP id 5b1f17b1804b1-47d84b0af8dmr185384915e9.7.1768222779360;
        Mon, 12 Jan 2026 04:59:39 -0800 (PST)
Received: from ubuntu ([102.91.81.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86372c92sm143424985e9.0.2026.01.12.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:59:38 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [Outreachy PATCH RFC 1/3] environment: stop storing `core.attributesFile` globally
Date: Mon, 12 Jan 2026 13:59:23 +0100
Message-Id: <abbfe2531158e9bc99ddb903b60a77c26beb0c9c.1768217572.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768217572.git.belkid98@gmail.com>
References: <cover.1768217572.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config value parsed in git_default_core_config() is loaded eagerly
and stored in the global variable `git_attributes_file`.
Storing this value in a global variable can lead to unexpected
behaviours when more than one Git repository run in the same Git process.

Move this value into a `struct config_values` which holds all the values
parsed by `git_default_config()` and can be accessed per
repository via `git_default_config()`. This will prevent us from
moving any code from git_default_core_config(), ensuring the current
behaviour remains the same while also enabling the libification of Git.

It is important to note that `git_default_config()` is a wrapper to other
`git_default_*_config()` such as `git_default_core_config()`.
Therefore to access and modify this global variable,
the change has to be made in the function which parses and
stores the value in the global variable.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 attr.c        | 8 +++++---
 config.c      | 5 +++++
 config.h      | 8 ++++++++
 environment.c | 7 ++++---
 environment.h | 1 -
 repository.c  | 6 ++++++
 repository.h  | 4 ++++
 7 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 4999b7e09d..eb7b82707d 100644
--- a/attr.c
+++ b/attr.c
@@ -881,10 +881,12 @@ const char *git_attr_system_file(void)
 
 const char *git_attr_global_file(void)
 {
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
+	struct config_values *cfg = the_repository->cfg_values;
 
-	return git_attributes_file;
+	if (!cfg->attributes_file_path)
+		cfg->attributes_file_path = xdg_config_home("attributes");
+
+	return cfg->attributes_file_path;
 }
 
 int git_attr_system_is_enabled(void)
diff --git a/config.c b/config.c
index 7f6d53b473..8b882f64ae 100644
--- a/config.c
+++ b/config.c
@@ -1761,6 +1761,11 @@ static int config_set_element_cmp(const void *cmp_data UNUSED,
 	return strcmp(e1->key, e2->key);
 }
 
+void config_values_clear(struct config_values *cfg)
+{
+	free(cfg->attributes_file_path);
+}
+
 void git_configset_init(struct config_set *set)
 {
 	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
diff --git a/config.h b/config.h
index ba426a960a..1652d315e2 100644
--- a/config.h
+++ b/config.h
@@ -135,6 +135,13 @@ struct config_context {
 	/* Config source metadata for key and value. */
 	const struct key_value_info *kvi;
 };
+
+/* Holds values parsed by git_default_config() */
+struct config_values {
+	/* core config values */
+	char *attributes_file_path;
+
+};
 #define CONFIG_CONTEXT_INIT { 0 }
 
 /**
@@ -187,6 +194,7 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
 int git_config_from_parameters(config_fn_t fn, void *data);
+void config_values_clear(struct config_values *cfg);
 
 /*
  * Read config when the Git directory has not yet been set up. In case
diff --git a/environment.c b/environment.c
index a770b5921d..d633b0405b 100644
--- a/environment.c
+++ b/environment.c
@@ -53,7 +53,6 @@ char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
-char *git_attributes_file;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
@@ -327,6 +326,8 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
 static int git_default_core_config(const char *var, const char *value,
 				   const struct config_context *ctx, void *cb)
 {
+	struct config_values *cfg = the_repository->cfg_values;
+
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
 		trust_executable_bit = git_config_bool(var, value);
@@ -364,8 +365,8 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.attributesfile")) {
-		FREE_AND_NULL(git_attributes_file);
-		return git_config_pathname(&git_attributes_file, var, value);
+		FREE_AND_NULL(cfg->attributes_file_path);
+		return git_config_pathname(&cfg->attributes_file_path, var, value);
 	}
 
 	if (!strcmp(var, "core.bare")) {
diff --git a/environment.h b/environment.h
index 51898c99cd..3512a7072e 100644
--- a/environment.h
+++ b/environment.h
@@ -152,7 +152,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern char *git_attributes_file;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
diff --git a/repository.c b/repository.c
index c7e75215ac..3ad944e71c 100644
--- a/repository.c
+++ b/repository.c
@@ -55,6 +55,7 @@ void initialize_repository(struct repository *repo)
 	repo->remote_state = remote_state_new();
 	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
+	CALLOC_ARRAY(repo->cfg_values, 1);
 	index_state_init(repo->index, repo);
 	repo->check_deprecated_config = true;
 
@@ -403,6 +404,11 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->remote_state);
 	}
 
+	if (repo->cfg_values) {
+		config_values_clear(repo->cfg_values);
+		FREE_AND_NULL(repo->cfg_values);
+	}
+
 	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
 		ref_store_release(e->value);
 	strmap_clear(&repo->submodule_ref_stores, 1);
diff --git a/repository.h b/repository.h
index 6063c4b846..5fb825f799 100644
--- a/repository.h
+++ b/repository.h
@@ -13,6 +13,7 @@ struct object_database;
 struct submodule_cache;
 struct promisor_remote_config;
 struct remote_state;
+struct config_values;
 
 enum ref_storage_format {
 	REF_STORAGE_FORMAT_UNKNOWN,
@@ -171,6 +172,9 @@ struct repository {
 
 	/* Should repo_config() check for deprecated settings */
 	bool check_deprecated_config;
+
+	/* Repository's config values parsed by git_default_config() */
+	struct config_values *cfg_values;
 };
 
 #ifdef USE_THE_REPOSITORY_VARIABLE
-- 
2.34.1

