Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9F4503B
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769257294; cv=none; b=cJ+j5ENXNoI3rNar6dOyY47zmrJqQgSbEOVJ6r3p1l4Kl78swuCvA00WQuaRZEoXEo49w3bYeZJsZua3s8o13cGeuOtldWcf4aFbQgmfNHtBg2RhUXDZLw+G5lRvcJyYswdo6wcH/CH+49AOg/J7xN9nJbMAgZiTNOyexQCpHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769257294; c=relaxed/simple;
	bh=UR73UeSpEcBz1+DWLtuStQRx6/F6Sm28Ub/EIYu6II8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJIXARrCmW49KbY+83komlEEpeGS+NbtQSYfo/FIA8WwNnNds/R10C3Kjjzk/tbTuxq/KuTuD992QLKd0P2UYMdFgk9wRbC0X0z3xtM85EuFTWpV7d17U0voUbmi5efDPsC3MkPbk776CMXqZtY+Qzx+vU/IN7vVDcbA0b+781I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSGGK/7p; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSGGK/7p"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43246af170aso1734871f8f.0
        for <git@vger.kernel.org>; Sat, 24 Jan 2026 04:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769257291; x=1769862091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJiaJKf2xERWUn1ePAo5r2aLr0YUfSomHUl7p8mGBFw=;
        b=iSGGK/7pHDJrr7A1eGFXueZaEL5X73t2KujR9RwYcZAUlbovZXi+NdF/hKVqPuyjRt
         G2g5ISu8UsHIMCOj/EAkqTBR/fRHXgcPk2r+iPL4tZ1Xjm2sHuQfEuiVy+Ccf9u06THX
         F+f5cnlHYFwZuznETMxq20xLOSI5N0srbCjsJc+rUgRICNvhDxPteFh8HiXYmslBiXu9
         hMqSQOP0wPJQgF6re11YLGWOI/pNmZsPWavTmXzv29+AtPfViGUr8jGj+L90J0PYR/jb
         s5bSc/XflS598P7H7V8Mq4WWRCgvx+wpDJs/vU/xb50Z6cdtCyAn4uVuBjsvGHOaofPd
         10aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769257291; x=1769862091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJiaJKf2xERWUn1ePAo5r2aLr0YUfSomHUl7p8mGBFw=;
        b=SiDMyI2WKHZTlan/IiIJkSLoVq57LTeZ64DsRmpjG35FzwYI0PnCEZ/H4sAz8g6+2+
         62pFKtccO4SVlZF6wRhfLROsVP58spwl5lsKWEAT29/0pqDHHVzffQzPLCz/O7PLvfA2
         iUqCDtM4po3wh7YJHsyds8Gsf5VZbqSrdfYqRHk8RSizFexKgFxx7LFf87YypaY9H1kg
         i9YShIFGJKxcdXsUaJM8qAO58T3ufInBM/d27OtnKNr7abvBau8FIjDc5513YusdGRp5
         CNiye3pqErm9di7+wZehUcfNU9VpCEMfBu4MQS7RofR75Pq04FeHzy5xjjaEkLUYs4Gn
         k3KA==
X-Gm-Message-State: AOJu0YwPGzKYEGy6P4cQTChlsIQyZVAXQ2sgEm3lNDEzqCwxUry0i0h/
	ebNbhgQyHGO5y8+cx6x+y9BrTx6V1G5BKmiEt2NAvv3sc4DSKhtzjnnYsbdyEkHb
X-Gm-Gg: AZuq6aJ+A2DCdZF1lS5woAlEcpllW9EXwcN/bNlCyR3DdznFqYHwVJQ5fRn3svLVJKS
	MHmpbohyR4zMCzcJoC3brqpJs4VQJ2LTIlDlOn3cNUa99NkOWxdshZd7P3y2EuRrInBH8jRTB/q
	BrM37d0tZzJvd/ihQhAS6SRTNpSlSN+ZYsYuCm7Ue2u9A68NDtqOMkcFdtfd6CJNeGlwmfVwFZN
	zmwm8TTpj3SDH97HMqNnSVH2rdmpiE+NjzXQTp1dQn8FNDLiP+ElS4TICinN+nfNBbUE6dY0urn
	GkzrcZY9CTmg0xBkiFsAc5Gg+S3avErD/zp4MdmEO2djHGdfd5PVsIL0EwnISK1Af4v3Nn/kvSw
	EeNyryWLN7jCU/8f95VnjheqS7E6MK0tcCd2XMHoTwW6M8KDGitOwTaNS5MNVP1qnmICpAPtfWZ
	4tSB8=
X-Received: by 2002:a05:6000:400e:b0:432:5b18:2cc3 with SMTP id ffacd0b85a97d-435a5f5cf42mr16939288f8f.4.1769257291218;
        Sat, 24 Jan 2026 04:21:31 -0800 (PST)
Received: from ubuntu ([102.88.77.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745dbsm14840382f8f.34.2026.01.24.04.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 04:21:30 -0800 (PST)
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
Subject: [Outreachy PATCH v5 1/3] environment: stop storing `core.attributesFile` globally
Date: Sat, 24 Jan 2026 13:21:11 +0100
Message-Id: <d28850bcdb5677ad0c81cf4bfa51ae1c056aabd3.1769256839.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1769256839.git.belkid98@gmail.com>
References: <cover.1769256839.git.belkid98@gmail.com>
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
For now the value can be accessed via the_repository in
`git_default_config()`.
This will ensure the current behaviour remains the same while also
enabling the libification of Git.

It is important to note that `git_default_config()` is a wrapper to other
`git_default_*_config()` functions such as `git_default_core_config()`.
Therefore to access and modify this global variable,
the change has to be made `git_default_core_config()`.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 attr.c        |  7 ++++---
 environment.c | 12 +++++++++---
 environment.h |  8 +++++++-
 repository.c  |  1 +
 repository.h  |  4 ++++
 5 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 4999b7e09d..b8b70e6dce 100644
--- a/attr.c
+++ b/attr.c
@@ -881,10 +881,11 @@ const char *git_attr_system_file(void)
 
 const char *git_attr_global_file(void)
 {
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
+	struct repo_config_values *cfg = &the_repository->config_values;
+	if (!cfg->attributes_file)
+		cfg->attributes_file = xdg_config_home("attributes");
 
-	return git_attributes_file;
+	return cfg->attributes_file;
 }
 
 int git_attr_system_is_enabled(void)
diff --git a/environment.c b/environment.c
index a770b5921d..72735d9e4b 100644
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
+	struct repo_config_values *cfg = &the_repository->config_values;
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
index 51898c99cd..0c0dcc6847 100644
--- a/environment.h
+++ b/environment.h
@@ -84,6 +84,11 @@ extern const char * const local_repo_env[];
 
 struct strvec;
 
+struct repo_config_values {
+	/* section "core" config values */
+	char *attributes_file;
+};
+
 /*
  * Wrapper of getenv() that returns a strdup value. This value is kept
  * in argv to be freed later.
@@ -107,6 +112,8 @@ const char *strip_namespace(const char *namespaced_ref);
 int git_default_config(const char *, const char *,
 		       const struct config_context *, void *);
 
+void repo_config_values_init(struct repo_config_values *cfg);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
@@ -152,7 +159,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern char *git_attributes_file;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
diff --git a/repository.c b/repository.c
index c7e75215ac..d308cd78bf 100644
--- a/repository.c
+++ b/repository.c
@@ -57,6 +57,7 @@ void initialize_repository(struct repository *repo)
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
 	repo->check_deprecated_config = true;
+	repo_config_values_init(&repo->config_values);
 
 	/*
 	 * When a command runs inside a repository, it learns what
diff --git a/repository.h b/repository.h
index 6063c4b846..638a142577 100644
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
+	struct repo_config_values config_values;
+
 	/* Repository's reference storage format, as serialized on disk. */
 	enum ref_storage_format ref_storage_format;
 
-- 
2.34.1

