Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A312BF3CA
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767371582; cv=none; b=jDilRj2Igke1y02rssPvK44KqU4OSJLpQs37UfTjHf3Zi3b5fPXDFli2obb5wVENKBxBV1b+IiJldeTCYjyGYC6Ff1521IbYVpE+e1FzCs+auYDKPxjVQ+6ptJFnuCnqHufTH4//YaqqwDm29e0sTjCJMk0xBHBDvQHIa+zN+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767371582; c=relaxed/simple;
	bh=2Pr5heAbwU7gMEgBXwhA8J4LRmjI7K65Dr50elIQ9NU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jhsw9szfD2xSZm8CcVHtYcE171opowAzBpkBsuC+97YwTJysq+94nGfdYD6Vwz1Lv5i/0/KEVd03sOmsZXu/FwBrcY3jPWyFUTbW9kJd1uVgryvWqIOG/jSGmY1UNpJ0SXjJj+j11sQaK3bmGy+FXGWHnmjsv0kxCEVUzaN6cRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyGQfsjo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyGQfsjo"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so7210547f8f.3
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 08:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767371579; x=1767976379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w07oOyGOImBzXDLI1FQJowtyl4JmLbx8p1Igh4p7qH4=;
        b=FyGQfsjoYe+p5fpWft+snw6UdpQJ8u27mj5aMGYRy4PDgDwQ8KRzGHohk9uUw+V3az
         70JzFduBafK3o5Ni7yPrjBCbo1MHXC9DtDPkp01aZn0WcAkAmkD/zyPN3nrKQphkvR4e
         GduVt1uupgjcLFnITevOkq8Hsk1aADZ77QmhYrPsPVWL261edKtsiVkHTocbhQ+VjX22
         QAxXS2ca5dzXs4SYbMn12cgt+HhznukgkKisS24c/X5k5TZqwV4kGTvOz+DZqWL/mHiF
         5Gw2mjib0s/Ps1b2W677CNdqweK8G2WzsllPLwpwDThlQnYCPUDXsfNjQjsOhC4jbTHa
         iicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767371579; x=1767976379;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w07oOyGOImBzXDLI1FQJowtyl4JmLbx8p1Igh4p7qH4=;
        b=UJiYZPCkN2bjdEg0KchDaaPwYAmadVQZxV0MCnLI0MjfnZ4l8/fJWvslIuo+/dv1CF
         1UHwzrArdwYu1PmHTeGK19SDiv7BVzwLvngjRgwJjF/j8DMkxO3YNOuGpVhOD3mi9UcG
         MZXDPEhkYkFXNFCJVv9ddnwcizD/5e8QDizHDFtJs/7sKbXJ8JJ0HdhbkCHn1BhZsCGx
         Y/YeZGH7Ze0jf0JoHhxxYWWAPtN6RDNmq+SGtFku1o5vFjkCTH5yZ8OAwg7NSi7BfU+r
         KpDnM8FqKZ4JGwOlbO+E9TeBhMAYWla66vn2lrgv3mVpy+TDg5R8SWaGKK8Dk2lfoPCU
         +j7g==
X-Gm-Message-State: AOJu0YxFpIrlbU5oHubwCg2VSFF5MGFpzq+18UKJzBFXsMlFLtAzdkHd
	mqprw4ewo7eebJjpT+FZBcHYLt4XHBKObArQw2ssJyidXUSq+7eAM/CP
X-Gm-Gg: AY/fxX5Y3C05DgWyRoKuVFRZrhUdxyxAUSi1HtH7RoQP5CR0vZ+TreqKn41ZQfu0vSl
	ANzcb8BLJ0WwA1i1bpEULVioaDGHvXekitjgFtl41/sTX/OKa1VzjK89Stl8+CAqkDuXW8+gI22
	eh5/N2EFt4vw5c0rj6xieMGBjbCLyUJShafiB//OjYItkjnqv7SdJUmxyhN26aGjeBWIskomuI1
	OwJrA8zNZ6wK5URRE9fFR4pe4k6XDjPZCfRlKTeCywmi5bshr6K5kEI1RqktxSDmwI9YOt1mC/t
	7T41HlxdVTgi1GXrrkEXpKi2k7u7bzLphTVq2ddrE2p9D4T8jNX2jla6aR1OK1K5o2ICsLxaruh
	nG9y4reTQungvM291iOSLY5sivak55Ciu5DCFidwUeLl9Ayn+SfKdc9LpY76jPqChiPGFc1lgh5
	zbiMA=
X-Google-Smtp-Source: AGHT+IEJUhlb72ZgJ4OURfNXXTS5tM8micdZT4j1oiBzEH487GzaOH+6mv0qjynXVtfmTQy7aBtwOA==
X-Received: by 2002:a05:6000:178c:b0:431:104:6daf with SMTP id ffacd0b85a97d-4324e709ab3mr63001440f8f.54.1767371579008;
        Fri, 02 Jan 2026 08:32:59 -0800 (PST)
Received: from ubuntu ([105.117.2.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm84752489f8f.3.2026.01.02.08.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 08:32:58 -0800 (PST)
Date: Fri, 2 Jan 2026 16:32:50 +0000
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, Christian Couder <christian.couder@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [Outreachy PATCH v2] environment: move "core.attributesFile" into
 repo-setting
Message-ID: <aVfzMsN2ouY3UBFG@ubuntu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUO7jQQAERTe5xYc@ubuntu>

When handling multiple repositories within the same process, relying on
global state for accessing the "core.attributesFile" configuration can
lead to incorrect values being used. It also makes it harder to isolate
repositories and hinders the libification of git.
The functions `bootstrap_attr_stack()` and `git_attr_val_system()`
retrieve "core.attributesFile" via `git_attr_global_file()`
which reads from global state `git_attributes_file`.

Move the "core.attributesFile" configuration into the
`struct repo_settings` instead of relying on the global state.
A new function `repo_settings_get_attributesfile_path()` is added
and used to retrieve this setting in a repository-scoped manner.
The functions to retrieve "core.attributesFile" are replaced with
the new accessor function `repo_settings_get_attributesfile_path()`
This improves multi-repository behaviour and aligns with the goal of
libifying of Git.

Note that in `bootstrap_attr_stack()`, the `index_state` is used only
if it exists, else we default to `the_repository`.

Based-on-patch-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
The link to the GitHub CI is provided below
https://github.com/git/git/actions/runs/20661817110

Changes in v2:
--------------
- Renamed the variable in the repo-settings struct to `attributes_file_path`
- Modified the comment section of the accessor function declaration to
  indicate the core.attributesFile is read via repo config.

Range diff vs v1:
-----------------
1:  4975f77cde ! 1:  fc1dbec892 environment: move "core.attributesfile" into repo-setting
    @@ Commit message
         Note that in `bootstrap_attr_stack()`, the `index_state` is used only
         if it exists, else we default to `the_repository`.
     
    -    Reported-by: Ayush Chandekar <ayu.chandekar@gmail.com>
    +    Based-on-patch-by: Ayush Chandekar <ayu.chandekar@gmail.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
         Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
    @@ attr.c: static void bootstrap_attr_stack(struct index_state *istate,
      	if (*stack)
      		return;
     @@ attr.c: static void bootstrap_attr_stack(struct index_state *istate,
    - 		push_stack(stack, e, NULL, 0);
      	}
      
    --	/* home directory */
    + 	/* home directory */
     -	if (git_attr_global_file()) {
     -		e = read_attr_from_file(git_attr_global_file(), flags);
     +	if (istate && istate->repo)
    @@ repo-settings.c: void repo_settings_clear(struct repository *r)
      	struct repo_settings empty = REPO_SETTINGS_INIT;
      	FREE_AND_NULL(r->settings.fsmonitor);
      	FREE_AND_NULL(r->settings.hooks_path);
    -+	FREE_AND_NULL(r->settings.git_attributes_file);
    ++	FREE_AND_NULL(r->settings.attributes_file_path);
      	r->settings = empty;
      }
      
    @@ repo-settings.c: void repo_settings_reset_shared_repository(struct repository *r
      }
     +const char *repo_settings_get_attributesfile_path(struct repository *repo)
     +{
    -+	if (!repo->settings.git_attributes_file) {
    -+		if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.git_attributes_file))
    -+			repo->settings.git_attributes_file = xdg_config_home("attributes");
    ++	if (!repo->settings.attributes_file_path) {
    ++		if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.attributes_file_path))
    ++			repo->settings.attributes_file_path = xdg_config_home("attributes");
     +	}
    -+	return repo->settings.git_attributes_file;
    ++	return repo->settings.attributes_file_path;
     +}
     
      ## repo-settings.h ##
    @@ repo-settings.h: struct repo_settings {
      	unsigned long big_file_threshold;
      
      	char *hooks_path;
    -+	char *git_attributes_file;
    ++	char *attributes_file_path;
      };
      #define REPO_SETTINGS_INIT { \
      	.shared_repository = -1, \
    @@ repo-settings.h: int repo_settings_get_shared_repository(struct repository *repo
     +/*
     + * Read the value for "core.attributesfile".
     + * Defaults to xdg_config_home("attributes") if the core.attributesfile
    -+ * isn't available.
    ++ * which is set via repo config isn't available.
     + */
     +const char *repo_settings_get_attributesfile_path(struct repository *repo);
     +

 attr.c          | 19 +++++++++----------
 attr.h          |  3 ---
 builtin/var.c   |  2 +-
 environment.c   |  6 ------
 environment.h   |  1 -
 repo-settings.c | 10 ++++++++++
 repo-settings.h |  8 ++++++++
 7 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/attr.c b/attr.c
index 4999b7e09d..b081400c18 100644
--- a/attr.c
+++ b/attr.c
@@ -879,14 +879,6 @@ const char *git_attr_system_file(void)
 	return system_wide;
 }
 
-const char *git_attr_global_file(void)
-{
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
-
-	return git_attributes_file;
-}
-
 int git_attr_system_is_enabled(void)
 {
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
@@ -912,6 +904,8 @@ static void bootstrap_attr_stack(struct index_state *istate,
 {
 	struct attr_stack *e;
 	unsigned flags = READ_ATTR_MACRO_OK;
+	const char *attributes_file_path;
+	struct repository *repo;
 
 	if (*stack)
 		return;
@@ -927,8 +921,13 @@ static void bootstrap_attr_stack(struct index_state *istate,
 	}
 
 	/* home directory */
-	if (git_attr_global_file()) {
-		e = read_attr_from_file(git_attr_global_file(), flags);
+	if (istate && istate->repo)
+		repo = istate->repo;
+	else
+		repo = the_repository;
+	attributes_file_path = repo_settings_get_attributesfile_path(repo);
+	if (attributes_file_path) {
+		e = read_attr_from_file(attributes_file_path, flags);
 		push_stack(stack, e, NULL, 0);
 	}
 
diff --git a/attr.h b/attr.h
index a04a521092..956ce6ba62 100644
--- a/attr.h
+++ b/attr.h
@@ -232,9 +232,6 @@ void attr_start(void);
 /* Return the system gitattributes file. */
 const char *git_attr_system_file(void);
 
-/* Return the global gitattributes file, if any. */
-const char *git_attr_global_file(void);
-
 /* Return whether the system gitattributes file is enabled and should be used. */
 int git_attr_system_is_enabled(void);
 
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..fd577f2930 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -72,7 +72,7 @@ static char *git_attr_val_system(int ident_flag UNUSED)
 
 static char *git_attr_val_global(int ident_flag UNUSED)
 {
-	char *file = xstrdup_or_null(git_attr_global_file());
+	char *file = xstrdup_or_null(repo_settings_get_attributesfile_path(the_repository));
 	if (file) {
 		normalize_path_copy(file, file);
 		return file;
diff --git a/environment.c b/environment.c
index a770b5921d..ed7d8f42d9 100644
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
@@ -363,11 +362,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.attributesfile")) {
-		FREE_AND_NULL(git_attributes_file);
-		return git_config_pathname(&git_attributes_file, var, value);
-	}
-
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
 		return 0;
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
diff --git a/repo-settings.c b/repo-settings.c
index 195c24e9c0..cc53a3cd3b 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -5,6 +5,7 @@
 #include "midx.h"
 #include "pack-objects.h"
 #include "setup.h"
+#include "path.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
@@ -158,6 +159,7 @@ void repo_settings_clear(struct repository *r)
 	struct repo_settings empty = REPO_SETTINGS_INIT;
 	FREE_AND_NULL(r->settings.fsmonitor);
 	FREE_AND_NULL(r->settings.hooks_path);
+	FREE_AND_NULL(r->settings.attributes_file_path);
 	r->settings = empty;
 }
 
@@ -230,3 +232,11 @@ void repo_settings_reset_shared_repository(struct repository *repo)
 {
 	repo->settings.shared_repository_initialized = 0;
 }
+const char *repo_settings_get_attributesfile_path(struct repository *repo)
+{
+	if (!repo->settings.attributes_file_path) {
+		if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.attributes_file_path))
+			repo->settings.attributes_file_path = xdg_config_home("attributes");
+	}
+	return repo->settings.attributes_file_path;
+}
diff --git a/repo-settings.h b/repo-settings.h
index d477885561..1209e1db83 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -68,6 +68,7 @@ struct repo_settings {
 	unsigned long big_file_threshold;
 
 	char *hooks_path;
+	char *attributes_file_path;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
@@ -99,4 +100,11 @@ int repo_settings_get_shared_repository(struct repository *repo);
 void repo_settings_set_shared_repository(struct repository *repo, int value);
 void repo_settings_reset_shared_repository(struct repository *repo);
 
+/*
+ * Read the value for "core.attributesfile".
+ * Defaults to xdg_config_home("attributes") if the core.attributesfile
+ * which is set via repo config isn't available.
+ */
+const char *repo_settings_get_attributesfile_path(struct repository *repo);
+
 #endif /* REPO_SETTINGS_H */
-- 
2.52.0.210.g7f9f2609ac.dirty

