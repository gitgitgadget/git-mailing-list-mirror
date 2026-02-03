Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEBF3AE707
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133359; cv=none; b=hjocRgMUzU7sPUzac24a5oRqaEeV8tjL295LN8lFWDaTLNC01uY7sqmdJHooyrBXRsUBdFcxus/AfOVQpcxXGMPrnswWTJl8ryWiPs1nAfoBXvEr8I021gwelvMFsd7BkmCvaICrgtAwzWTUjeUK9rEal8Yjt3hRnN5zfA9Qdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133359; c=relaxed/simple;
	bh=u9hb9r44UBS/zM0JrcORFGTVk/WUOGEvzCx2y6U2KCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNPYNXlU7mlYXDvFDS/QShrNGTdUOijB0tBGNM3nikVng4WEXnNLVLmvR1GvtCs+lUh5PNcKLnt9PZke54ib7N4TDbME+ve0wQFhnbSOzcsMIRA7l5v+uLNAUlN457+W4/A5ocsNjwRVJv3zCB9DGL+ZpGUAKcQF6wNAF1KaBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKmSr0+h; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKmSr0+h"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so4980215f8f.3
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 07:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770133356; x=1770738156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhNYaUVxjDFa/vfkiV9RCnc3EKwXDLqXC/M1tqzgENo=;
        b=TKmSr0+ha5MJ6Hb08lRcG5veIKPoXJtKi3XzffyA/mONTO59WJuevH12gocAar80W3
         /q/R9k/i08Etiwkp7WLO8lc8X8U2noHJ9K4P/ONqeWEV/hgByv7M9Zm3ZDR+QMIiBAlB
         LbtLPkDv+gZBp+uDlYis21rObiGXmnZ9xilqWlrH4f8Gyam/40CTzOGy5ICeT+iDJG3J
         O+zicnbaFmLz7MN1WSz/N0qyIqIeiKhT9RxGg34Z05gyNOZ9OQR2BFw9rr1z31DFAQ0L
         sJzQqxFE0mtHVS/qhXg2f+W3HjzYK2uRqXb70rlo+z97sEi2fnBq4N+0l4bBS89aK9m0
         fo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770133356; x=1770738156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NhNYaUVxjDFa/vfkiV9RCnc3EKwXDLqXC/M1tqzgENo=;
        b=gy2ew7x9SpE87m47JhuBIPr7dKsnuBK9yiVtRRNO9ffLOqZVBibrrJk6t62c0ylsww
         fzy3R3a69DO1mUao2879YFJqaKOhleNtuvluF6GqJOEwajemJyF4CULoiKqWQlP7fdyX
         fhr2MLVYYSR4MWeflr4/aujYArlq8+OL1G6woEV0kniRtFNvzzgKfA0Fx2Yp4e8hIrdS
         6nJPlgVtrzsqqxHCUkOelZQ5n2qGdpEN4PpsmafclveFKe1JeHDGKfoYQ3kT4Wqk0D1X
         wnzLdBtTkQqJQm8AIMib6wQApiiv3jb1qbOSm81Uje2BldIN6vrKQhz6gu6TDlSjur4y
         pxmA==
X-Gm-Message-State: AOJu0YyDtsW1wji5me47a7TimEfk7YqvPEPxCTBwSkMDLuHsIsMjLlyw
	TAPECXF0GPCsMEkUTmHVR2I6f1GAm/5zNs1F++umZ8WMxT0rM+2Rbg8p
X-Gm-Gg: AZuq6aII7mhmU0tPvMINZ5SHwUzdFTgwo6TuhIHiqQwFKsFvoX8iyCar9Z63OyfzrDY
	JZhFXylfVDsTHaR2musaDb7X8ZfHnGXaYykd0G/P1YWceR3qnVEprfAIm0pcecmM5rRzCiz/fbx
	cqjVNmDJ8WDW41iKuR9uxqICPpMdRtijZzy47A3b1v0cV8xYTsr+UJcbazocrg9vIWKvq4cKg4A
	AgYVTE7XZIg1lH0JzwmUQ3exu0W6F7KXTumfG0H6dcdSvgtkJgG0XFL2ggV2pLZTzN957AFRrTw
	9w2+rq7H3pzQ+gcQjJYUionPoCFPWz8StLYFJm0kdGnEjK0Kj+hPWmwBwQJudyXfKc9/RSeLz+S
	7oZsnNabkBdSGC1x71FH7qE0xXs8mteVM2PL34s05yCeha4Fuz6gfSoS6a2f83lkVPu51musN0D
	oibQ6vRXIzaJeI
X-Received: by 2002:a05:6000:2c01:b0:435:e460:235b with SMTP id ffacd0b85a97d-435f3ab32acmr21385835f8f.59.1770133355806;
        Tue, 03 Feb 2026 07:42:35 -0800 (PST)
Received: from ubuntu ([102.88.77.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4824sm55030131f8f.1.2026.02.03.07.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 07:42:35 -0800 (PST)
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
Subject: [Outreachy PATCH v6 1/3] environment: stop storing `core.attributesFile` globally
Date: Tue,  3 Feb 2026 16:42:09 +0100
Message-Id: <7e3082125df08d3e5fb2195d73698c4c28c6645e.1770127568.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1770127568.git.belkid98@gmail.com>
References: <cover.1770127568.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `core.attributeFile` config value is parsed in
git_default_core_config(), loaded eagerly and stored in the global
variable `git_attributes_file`. Storing this value in a global variable
can lead to it being overwritten by another repository when more than one
Git repository run in the same Git process.

Create a new struct `repo_config_values` to hold this value and
other repository dependent values parsed by `git_default_config()`.
This will ensure the current behaviour remains the same while also
enabling the libification of Git.

An accessor function 'repo_config_values()' is created and used to access
the new struct member of the repository struct.
This is to ensure that we detect if the struct repository has been
initialized and also prevent double initialization of the repository.

It is important to note that `git_default_config()` is a wrapper to other
`git_default_*_config()` functions such as `git_default_core_config()`.
Therefore to access and modify this global variable,
the change has to be made `git_default_core_config()`.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 attr.c        |  7 ++++---
 environment.c | 12 +++++++++---
 environment.h | 11 ++++++++++-
 repository.c  | 12 ++++++++++++
 repository.h  |  7 +++++++
 5 files changed, 42 insertions(+), 7 deletions(-)

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
diff --git a/repository.c b/repository.c
index c7e75215ac..a9b727540f 100644
--- a/repository.c
+++ b/repository.c
@@ -50,13 +50,25 @@ static void set_default_hash_algo(struct repository *repo)
 	repo_set_hash_algo(repo, algo);
 }
 
+struct repo_config_values *repo_config_values(struct repository *repo)
+{
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
+	repo_config_values_init(repo_config_values(repo));
 
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

