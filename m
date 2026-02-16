Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94F318EFC
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259941; cv=none; b=nkbZ/sz1dwxlaqqExDkxbBHQvtJ8VF6bhl2NcZmVlM+fpMiXW3cvvjC0FgJsSd9wpJ5PCWtwlg59gjusKSI7d2HlsTbfaWvcmZwoWj/esRbE7ZSDxuFy5VTJqaKlyjMjosM5EYprSjGOewBSdVbwD6C5cDFYxkTwfAJf9Xop8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259941; c=relaxed/simple;
	bh=/ntGcfkfK8Qp9uGBkZAm8CuaNo78fWdD6E1pC456+iI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8XGrFzUBvJN8vMh1sz0n+kmuC7QOw4Mha7be10qrS9PHFYLnxzLgPCJvR6RjrIPVAmjYM7rhpng2Kr/5bqwQGmvEWZD2/dsyfe/GNSM+rNCw88pAQdEjazd5IeSW6tfkpPGfpe9RIZmx5Ztal4Za94HY3vBbnThR5xPB+14D14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKiBvkBs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKiBvkBs"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso20770665e9.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 08:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771259938; x=1771864738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HxUdIBBVWbsyoiO02dxJcDP9hFI9EXzy0vCioa11dE=;
        b=EKiBvkBsgCCiyuZOgKr/8PM0932mY75jfOrzGuESvJZv/DBqCw2S2LqaSGIFR1SsZ0
         vs7K2J+xims8Mc6Y+664scx5o8M8P+yQd0YbOk2yLoUwIVX+Bhd6BftzPMcR7pyrEBBV
         oLqJVkdR8roR2HtF+C5Ewm+cSsu67g8PDnMePQeCVDSmvm/XM6/7QkUX+FZoafwoc/pu
         73m3yzG+F2dN7Qtxkl4PkK98BxIhbSUHhcti4Nl5ljyq8BDUuLd7z+X82fTK0fgk7+xd
         e+IjCOA8TwS/PTWalgR79hzQpGlauXc1BNc4eEKoKSfX0D0b3+bVb79plND4AdKqKcyo
         B7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771259938; x=1771864738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/HxUdIBBVWbsyoiO02dxJcDP9hFI9EXzy0vCioa11dE=;
        b=n8vJAbf6LgFpM3QQtgEuF6k1wcmn1Iq2J2aP6uIGzA0MnnVlqv80aq0wmF26EI85AR
         6WSo0FTVCqZc7/H7Bl0RWw3YUrKH8252axXadvsL/I07ZEnwn70ZWYD7gs15b4NThHH8
         Jo/O2sMJ40JDFc4CLPGGXZ1WMtWAXkXgHWzw2Nc5oJ4O0cPSJpAUux4COj95QjLaJ0NW
         kSRgBUdMtQcO0neGpIN1kIQeePVbqiVt96B49K93LngqaKBhxZjHw8TC9NHmj/leKVjw
         +/GS/UhHYE0bGIoQbxxd37lhFIb0Zw7eOYEd1Vu08CB66xtF0/qg5tnLOuw4QX5/XUM+
         XiTA==
X-Gm-Message-State: AOJu0YxF1ZyU6mC/WtEcVJPrw1VeJ4MR8O+KVL/qm51jABUVusYMHfov
	bA/uqiKL8vh2Td3lbMuDVaXQkvjtljUmDZzJpKf00E9lefq2c2jjxIWK
X-Gm-Gg: AZuq6aLjSVn2tAX9u/Ydplcs1xLflZRtvQg/KPMh1UXp5gSoxbSqwFkJGCRdjQpveki
	Cqx+sGtsmPRTlbMbwU4mYOGeZ2dp4y7rNrhbP38drTmqz3azPHCy7j/neOK/MNIt1KnfCugdvWN
	E5nl0yQ0NwRMJpXDr8B48CByBC9z58TDuAFINPWc8ymJQUNA+UGmNHA5kvsJvBfHOgqoxkhfYbo
	0MDKHmAvRb5qnMvk2No5NBTlvM93kzMwx2+5b8qf0EzkbGoQA62ESOK7TF9iskGW8sOHZ9CK821
	zJrK5aeP3TjFxz9bgzQ5f6eOjFnQcm5qQYyUaJRWw1WgdD3XTza1h8i/w/jLZY3pkKxoKeLnV5Y
	AXCXpRPTIHqdk5MLDz+NvhvYL3Q9/2VUa93Kfq6kncNnQFIo1cFqQ3RZ8yeDtQI4GMoYJ3B2pFt
	vJ4m8jJ8kjVHpC9ZnTQwEHfUjE
X-Received: by 2002:a05:600c:4eca:b0:480:1c1c:47d6 with SMTP id 5b1f17b1804b1-48378d6a4c5mr174901985e9.6.1771259937737;
        Mon, 16 Feb 2026 08:38:57 -0800 (PST)
Received: from ubuntu ([102.88.77.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e11f5sm478414665e9.4.2026.02.16.08.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:38:57 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v7 1/3] environment: stop storing `core.attributesFile` globally
Date: Mon, 16 Feb 2026 17:38:25 +0100
Message-Id: <48821a3848bef25c13038be8377ad73e7c17a924.1771258573.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1771258573.git.belkid98@gmail.com>
References: <cover.1771258573.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `core.attributeFile` config value is parsed in
git_default_core_config(), loaded eagerly and stored in the global
variable `git_attributes_file`. Storing this value in a global
variable can lead to it being overwritten by another repository when
more than one Git repository run in the same Git process.

Create a new struct `repo_config_values` to hold this value and
other repository dependent values parsed by `git_default_config()`.
This will ensure the current behaviour remains the same while also
enabling the libification of Git.

An accessor function 'repo_config_values()' s created to ensure
that we do not access an uninitialized repository, or an instance
of a different repository than the current one.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 attr.c                       |  7 ++++---
 environment.c                | 12 +++++++++---
 environment.h                | 11 ++++++++++-
 oss-fuzz/fuzz-commit-graph.c |  1 +
 repository.c                 | 14 ++++++++++++++
 repository.h                 |  7 +++++++
 6 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 4999b7e09d..75369547b3 100644
--- a/attr.c
+++ b/attr.c
@@ -881,10 +881,11 @@ const char *git_attr_system_file(void)
 
 const char *git_attr_global_file(void)
 {
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+	if (!cfg->attributes_file)
+		cfg->attributes_file = xdg_config_home("attributes");
 
-	return git_attributes_file;
+	return cfg->attributes_file;
 }
 
 int git_attr_system_is_enabled(void)
diff --git a/environment.c b/environment.c
index a770b5921d..4b5c701e80 100644
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
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
 		trust_executable_bit = git_config_bool(var, value);
@@ -364,8 +365,8 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.attributesfile")) {
-		FREE_AND_NULL(git_attributes_file);
-		return git_config_pathname(&git_attributes_file, var, value);
+		FREE_AND_NULL(cfg->attributes_file);
+		return git_config_pathname(&cfg->attributes_file, var, value);
 	}
 
 	if (!strcmp(var, "core.bare")) {
@@ -756,3 +757,8 @@ int git_default_config(const char *var, const char *value,
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
+
+void repo_config_values_init(struct repo_config_values *cfg)
+{
+	cfg->attributes_file = NULL;
+}
diff --git a/environment.h b/environment.h
index 51898c99cd..dfc31b794d 100644
--- a/environment.h
+++ b/environment.h
@@ -84,6 +84,14 @@ extern const char * const local_repo_env[];
 
 struct strvec;
 
+struct repository;
+struct repo_config_values {
+	/* section "core" config values */
+	char *attributes_file;
+};
+
+struct repo_config_values *repo_config_values(struct repository *repo);
+
 /*
  * Wrapper of getenv() that returns a strdup value. This value is kept
  * in argv to be freed later.
@@ -107,6 +115,8 @@ const char *strip_namespace(const char *namespaced_ref);
 int git_default_config(const char *, const char *,
 		       const struct config_context *, void *);
 
+void repo_config_values_init(struct repo_config_values *cfg);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
@@ -152,7 +162,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern char *git_attributes_file;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index fb8b8787a4..59bbb849d1 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -10,6 +10,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
 	struct commit_graph *g;
 
+	memset(the_repository, 0, sizeof(*the_repository));
 	initialize_repository(the_repository);
 
 	/*
diff --git a/repository.c b/repository.c
index c7e75215ac..4bbbe6b3ba 100644
--- a/repository.c
+++ b/repository.c
@@ -50,13 +50,27 @@ static void set_default_hash_algo(struct repository *repo)
 	repo_set_hash_algo(repo, algo);
 }
 
+struct repo_config_values *repo_config_values(struct repository *repo)
+{
+	if (repo != the_repository)
+		BUG("trying to read config from wrong repository instance");
+	if(!repo->initialized)
+		BUG("config values from uninitialized repository");
+	return &repo->config_values_private_;
+}
+
 void initialize_repository(struct repository *repo)
 {
+	if (repo->initialized)
+		BUG("repository initialized already");
+	repo->initialized = true;
+
 	repo->remote_state = remote_state_new();
 	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
 	repo->check_deprecated_config = true;
+	repo_config_values_init(&repo->config_values_private_);
 
 	/*
 	 * When a command runs inside a repository, it learns what
diff --git a/repository.h b/repository.h
index 6063c4b846..9717e45000 100644
--- a/repository.h
+++ b/repository.h
@@ -3,6 +3,7 @@
 
 #include "strmap.h"
 #include "repo-settings.h"
+#include "environment.h"
 
 struct config_set;
 struct git_hash_algo;
@@ -148,6 +149,9 @@ struct repository {
 	/* Repository's compatibility hash algorithm. */
 	const struct git_hash_algo *compat_hash_algo;
 
+	/* Repository's config values parsed by git_default_config() */
+	struct repo_config_values config_values_private_;
+
 	/* Repository's reference storage format, as serialized on disk. */
 	enum ref_storage_format ref_storage_format;
 
@@ -171,6 +175,9 @@ struct repository {
 
 	/* Should repo_config() check for deprecated settings */
 	bool check_deprecated_config;
+
+	/* Has this repository instance been initialized? */
+	bool initialized;
 };
 
 #ifdef USE_THE_REPOSITORY_VARIABLE
-- 
2.34.1

