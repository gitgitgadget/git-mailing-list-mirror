Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E1D3CAA3B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400183; cv=none; b=f4I+DWIMVsF1wnUO9anqNd3HUq9r33x7yxurcqtnPFZnrgmHQyxGO7YgS943nNUkGcG3x7JTJQkfsEFDUc64SvSYu/y5jzt4J63y8Gs58v/Uw7KXISpiBi52DGq1lEfTvsNRvRkMXNHOUob9hYAxxoUkWWpEYm8jLpY6ExLbsY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400183; c=relaxed/simple;
	bh=wAhpihSBcGrSj2NVjaa2433eOEqfzy3zk4Xj7TQoU+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PnuCV+y9obw4JG4zbWlGvkSORLprCsF7IA1WYOQPHM3Dz4Cktsc7xuuQuXnuXSZMorlcBhvwZm3nYFvSzsYtppPP8Jc2LWz3EkGrDGKoRf2B2Mznqmvuqddi6SFrrQ/LLcgTuaSfEB4mWyDydAd3UyVhYAQO0fdNiIXSv66Xk2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K2n+bU6e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPFnzI8F; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K2n+bU6e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPFnzI8F"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E6351D000C7
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 04:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792400180;
	 x=1792486580; bh=DcAWWNbFFHUy2wM/wxDNHq8dx+in0mLHgHrWrqksfE0=; b=
	K2n+bU6egG/HRb1HWTLcIsP9t8Pkwj/52lvqbXq0PyzAZgwah8om/Pp4hGOQXeU9
	+gENGtPhbgv2+RWGeaABkx8H0rGEPGnG6KRKmXAzMId9XnIMe2kCW/PNUxWVXnth
	LTCA6zp4u+ggBOx2XKCej4BMA0f+Nvd5MPNyaAMzhB9F13nHSOHVq60Gs1XMa+Zk
	tQ9AcDo/K647R+ywwj5Lc/Dy7z73N7SajKa5puvHP5AE5wsmiGEn4cso37dVWjup
	cXYzaSWZfD/rHeM8Jr4avw7lZ7JbBhSt9gzZj1aN2o7ov+j5ILZiR0vOPONv/Crt
	lnMIxUIQY5djFko1ZEMzHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792400180; x=
	1792486580; bh=DcAWWNbFFHUy2wM/wxDNHq8dx+in0mLHgHrWrqksfE0=; b=J
	PFnzI8FkkZizivSH9dvExsBd1fdvqhAk+CJkYOFFNdpoJCvdAmn3mfT+3TTTCgMe
	3j8oR+KdghvyifKWjX+g3f6PTm93Fz9WAtG3FmJernseQjy3etfjIltmwVNaOV2s
	IkObmuTi8J+tbnQHFJCH9xdXCiCrwNkNoEqWKenMRIVL6cLbXxU0HgkKSeLnj3mW
	KMHU9Brc9iigD1dzMcJj91fhdpN1H7gGUteOL6HZNkyEMIu1WnHf1EjLTIE6Eyke
	rbMCBJZ0ED7+GFmxJ+YfbhDUkKoTLdxTfS3F7oon1VaK7RQmSyMXKlWCkqXPCmQX
	ffdn4iZ7KBcKzzemQ5b7A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792400180; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:c5JBFLD37G49CnF2HPfZOamwOJr+V+nXbmMMlYcKKn9ld50
	E1Apl1c764zvsT9qqzKM/VLiKkrfpr+Tcm8GCtJJNl6PLNDEpw8fynl6jisZKYBP
	Q2AC4gKzN8UiwSjlmrOq8CqQ8j35mUHWvT727OG5sNlzg+ydQAN+JmjbD3esCsMA
	QakH3WtXSmnojW4gKLBO4gyq5UmtZu6NoF8Vgq44UkwIi8tQfqUUdOAO+B61Yzuy
	Apv44U7jTxfXAXdbygQgxq30XfKZrp0K1+aKrCwuRkVcg3U9iff65GHJqCcSQx53
	xwyQ8mBgjCuPHx6MYq3hI2Yai6MpPP9q6Yrui9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sOMK7CbqArNP8GptqXhdQN79qLmtT669Y1zu9vMGvWI=:wAhpihSBcGrSj2NVjaa2433eOEqfzy3zk4Xj7TQoU+E=;
X-ME-Sender: <xms:NNvVamk9R3nZq5Aip4Y-BKE07Qj-vnExuGngIx-iykEu6mnk4P9Stg>
    <xme:NNvVakyQ7fVNEXnANRANsY9xmuWoJ4XMpYkNaSMPNCFiBBdXujz-ZCV6zQqxMtO05
    gfvC1O9r1f76V4cJXUErIBhg1Fxc8ylPE3S55f9hugHV_4Wdwur>
X-ME-Received: <xmr:NNvVaqQj_Y8ZYln66UMmOgUiLObxivMeVxmMso42bYjJukLPYEEOHg>
X-ME-Proxy-Cause: dmFkZTGfTCDl6lUtR0YpWppdo23ln4jv3lH0xKWlUu7G6uFe8srcOriVaetMCFdYOyxqQh
    Hr8AcU1kgjJzkfBWAOsoOESOtAb6ToxqQo/glcL1RFxoi5HEY8NDh7o7yWVsMpg/4SJbyC
    Ee0RhLv5Z/LClTYB7Klx1zd81O5uXk7VQIM3x8R/zpf1qi5h0olmBbLQVoqqjdF2fHErUn
    GgQdFMkHZ2ZQUVX73yj3kmRnsZLrofdcFxVHcsVRe4zNV0HDojJqm8rLcDtzr7pnXN6rh5
    ETfI5C+vnxrskwXB7vMXv16EL/70ckpLtMvpMfgxUof+XnNLnkpbov+eAsWoepxKSY3zTx
    r7MAEVzYKqsaaPA1AGKisR9KHXgsIOrl0kaXZDDA7ZLH0sAq0go2dyHYzVKeY5Wyzx1Z5v
    H0lRePEmEbuetcK0OZLKHksxjgA0E9jK3560xVkFcdKndInCE2NvULYmHLd2pvtqKpWPQF
    uDvccIz2WdOCPbAPHhqboff1UcASTWFt1dPDU2R3d9YxFhgmgGEJpEaps2p2fZk3qTFerx
    pFOi1QjV1AiH0M/hJSKoSGm7m+lOwmAzvsexnTsnYW3ptS3f6WeUsP+KMQsl5BteDk4+pv
    i3hPj/IxY8lfwRKAc4lP4UUCfww8oLt21+CvmMy6FP9LE77dh6P3CRwIsJ7g
X-ME-Proxy: <xmx:NNvVavsFczhJm5sc2cxitlZdHAv_fKwmynLinOgjrNfFDJap09TNCw>
    <xmx:NNvVaksD4i5Z-V_mAZUTkMBDjMTXlNxh06lAs5H8UZwAUl_rnQfD6A>
    <xmx:NNvVaty1_9nCt1f8jce0CCPNYAwm-cugGS9Tae9I2H-D2gwvJEKEdw>
    <xmx:NNvVaiggEw1MCtIRcF4qQy_I7ca2MdDj2kL4_sPtfedeakqlqKvhuw>
    <xmx:NNvVai3K8HL1dCrtqrEdqYHIPXrn2dxKiEB04PtRCxY2ISNhqPS_j_3f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ffb112a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Oct 2026 08:56:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 19 Oct 2026 10:56:00 +0200
Subject: [PATCH 5/7] builtin/init: introduce handling of object storage
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-pks-odb-extension-v1-5-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

While the object storage format extension can already be configured
manually via git-config(1), this isn't exactly an ergonomic way of doing
so. For the reference storage format extension, users have a host of
options available to them.

Introduce the equivalent options for the object storage format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/init.adoc |   5 ++
 Documentation/git-init.adoc    |  10 ++-
 Documentation/git.adoc         |   5 ++
 builtin/clone.c                |   2 +-
 builtin/init-db.c              |   7 +-
 setup.c                        |  89 +++++++++++++++++++++-
 setup.h                        |   1 +
 t/t0001-init.sh                | 162 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 273 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index e45bd692db..dbd9c663ee 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -20,6 +20,11 @@ endif::[]
 	precedence over this config.
 `init.defaultRefFormat`::
 	Deprecated alias of `init.defaultRefStorageFormat`.
+`init.defaultObjectStorageFormat`::
+	Allows overriding the default object storage format for new
+	repositories. See `--object-storage-format=` in linkgit:git-init[1].
+	Both the command line option and the `GIT_DEFAULT_OBJECT_STORAGE_FORMAT`
+	environment variable take precedence over this config.
 
 init.defaultSubmodulePathConfig::
 	A boolean that specifies if `git init` and `git clone` should
diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
index b02af22ad1..9e022a7ba8 100644
--- a/Documentation/git-init.adoc
+++ b/Documentation/git-init.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 [synopsis]
 git init [-q | --quiet] [--bare] [--template=<template-directory>]
 	 [--separate-git-dir <git-dir>] [--object-format=<format>]
-	 [--ref-storage-format=<format>]
+	 [--ref-storage-format=<format>] [--object-storage-format=<format>]
 	 [-b <branch-name> | --initial-branch=<branch-name>]
 	 [--shared[=<permissions>]] [<directory>]
 
@@ -68,6 +68,14 @@ include::ref-storage-format.adoc[]
 `--ref-format=<format>`::
 Deprecated alias of `--ref-storage-format=<format>`.
 
+`--object-storage-format=<format>`::
+Specify the given object storage _<format>_ for the repository. Backends that
+require additional configuration accept a payload in the form
+`<format>://<payload>`, for example a path or a connection string identifying
+the database that shall store the objects. The valid values are:
++
+include::object-storage-format.adoc[]
+
 `--template=<template-directory>`::
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 34812131bb..67de5646f0 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -609,6 +609,11 @@ double-quotes and respecting backslash escapes. E.g., the value
 `GIT_REFERENCE_BACKEND`::
 	Deprecated alias of `GIT_REF_STORAGE_FORMAT`.
 
+`GIT_DEFAULT_OBJECT_STORAGE_FORMAT`::
+	If this variable is set, the default object storage format for new
+	repositories will be set to this value. The default is "files".
+	See `--object-storage-format` in linkgit:git-init[1].
+
 `GIT_OBJECT_STORAGE_FORMAT`::
 	Specify which object storage format to use along with its URI.
 	See `extensions.objectStorage` option in linkgit:git-config[1] for more
diff --git a/builtin/clone.c b/builtin/clone.c
index 6047501dfc..ba4fc16def 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1214,7 +1214,7 @@ int cmd_clone(int argc,
 	 */
 	create_repository(the_repository, git_dir, real_git_dir, work_tree,
 			  option_template, GIT_HASH_UNKNOWN, ref_storage_format_uri,
-			  do_not_override_repo_unix_permissions, NULL);
+			  NULL, do_not_override_repo_unix_permissions, NULL);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0abdbca8e9..71b748f2f2 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -57,7 +57,7 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 static const char *const init_db_usage[] = {
 	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>]\n"
 	   "         [--separate-git-dir <git-dir>] [--object-format=<format>]\n"
-	   "         [--ref-storage-format=<format>]\n"
+	   "         [--ref-storage-format=<format>] [--object-storage-format=<format>]\n"
 	   "         [-b <branch-name> | --initial-branch=<branch-name>]\n"
 	   "         [--shared[=<permissions>]] [<directory>]"),
 	NULL
@@ -84,6 +84,7 @@ int cmd_init_db(int argc,
 	int bare = startup_info->force_bare_repository ? 1 : -1;
 	const char *object_format = NULL;
 	const char *ref_storage_format_uri = NULL;
+	const char *object_storage_format_uri = NULL;
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
 	int init_shared_repository = -1;
@@ -111,6 +112,8 @@ int cmd_init_db(int argc,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &object_storage_format_uri, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_END()
 	};
 	int reinit;
@@ -232,7 +235,7 @@ int cmd_init_db(int argc,
 
 	create_repository(the_repository, git_dir, real_git_dir, work_tree,
 			  template_dir, hash_algo, ref_storage_format_uri,
-			  init_shared_repository, &reinit);
+			  object_storage_format_uri, init_shared_repository, &reinit);
 	create_reference_database(the_repository, initial_branch, quiet);
 	create_object_database(the_repository, NULL);
 
diff --git a/setup.c b/setup.c
index 98140a7641..7117336b13 100644
--- a/setup.c
+++ b/setup.c
@@ -2466,7 +2466,8 @@ void initialize_repository_version(struct repository *repo,
 	 */
 	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
 	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
-	    repo->ref_storage_payload)
+	    repo->ref_storage_payload ||
+	    repo->object_storage_format)
 		target_version = GIT_REPO_VERSION_READ;
 
 	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
@@ -2490,6 +2491,12 @@ void initialize_repository_version(struct repository *repo,
 		repo_config_set_gently(repo, "extensions.refstorage", NULL);
 	}
 
+	if (repo->object_storage_format)
+		repo_config_set(repo, "extensions.objectstorage",
+				repo->object_storage_format);
+	else if (reinit)
+		repo_config_set_gently(repo, "extensions.objectstorage", NULL);
+
 	if (reinit) {
 		struct strbuf config = STRBUF_INIT;
 		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
@@ -2726,6 +2733,7 @@ static void separate_git_dir(struct repository *repo,
 struct default_format_config {
 	int hash;
 	enum ref_storage_format ref_storage_format;
+	char *object_storage_format;
 };
 
 static int read_default_format_config(const char *key, const char *value,
@@ -2757,6 +2765,20 @@ static int read_default_format_config(const char *key, const char *value,
 		goto out;
 	}
 
+	if (!strcmp(key, "init.defaultobjectstorageformat")) {
+		ret = git_config_string(&str, key, value);
+		if (ret)
+			goto out;
+		if (odb_source_type_by_uri(str, NULL) == ODB_SOURCE_UNKNOWN) {
+			warning(_("unknown object storage format '%s'"), str);
+			goto out;
+		}
+		free(cfg->object_storage_format);
+		cfg->object_storage_format = str;
+		str = NULL;
+		goto out;
+	}
+
 	/*
 	 * Enable the reftable format when "features.experimental" is enabled.
 	 * "init.defaultRefStorageFormat" takes precedence over this setting.
@@ -2777,7 +2799,8 @@ static int read_default_format_config(const char *key, const char *value,
 
 static void repository_format_configure(struct repository_format *repo_fmt,
 					int hash,
-					const char *ref_storage_format_uri)
+					const char *ref_storage_format_uri,
+					const char *object_storage_uri)
 {
 	struct default_format_config cfg = {
 		.hash = GIT_HASH_UNKNOWN,
@@ -2790,6 +2813,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	};
 	enum ref_storage_format ref_storage_format;
 	char *ref_storage_payload = NULL;
+	char *object_storage = NULL;
 	const char *env;
 
 	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
@@ -2877,9 +2901,58 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
 	}
 
+	/*
+	 * Determine the object storage format, with the same precedence as
+	 * for the ref storage format:
+	 *
+	 *   1. The format specified via the command line.
+	 *
+	 *   2. The format specified via "GIT_OBJECT_STORAGE_FORMAT".
+	 *
+	 *   3. The format of a preexisting repository when reinitializing.
+	 *
+	 *   4. The default format for new repositories as configured via
+	 *      "GIT_DEFAULT_OBJECT_STORAGE_FORMAT".
+	 *
+	 *   5. The default format for new repositories as configured via
+	 *      "init.defaultObjectStorageFormat".
+	 *
+	 *   6. The "files" format.
+	 */
+	if (object_storage_uri) {
+		if (odb_source_type_by_uri(object_storage_uri, NULL) == ODB_SOURCE_UNKNOWN)
+			die(_("unknown object storage format '%s'"), object_storage_uri);
+		object_storage = xstrdup(object_storage_uri);
+	} else if ((env = getenv(GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT))) {
+		if (odb_source_type_by_uri(env, NULL) == ODB_SOURCE_UNKNOWN)
+			die(_("unknown object storage format specified via %s: '%s'"),
+			    GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT, env);
+		object_storage = xstrdup(env);
+	} else if (repo_fmt->version >= 0) {
+		object_storage = xstrdup_or_null(repo_fmt->object_storage);
+	} else if ((env = getenv("GIT_DEFAULT_OBJECT_STORAGE_FORMAT"))) {
+		if (odb_source_type_by_uri(env, NULL) == ODB_SOURCE_UNKNOWN)
+			die(_("unknown object storage format specified via %s: '%s'"),
+			    "GIT_DEFAULT_OBJECT_STORAGE_FORMAT", env);
+		object_storage = xstrdup(env);
+	} else {
+		object_storage = xstrdup_or_null(cfg.object_storage_format);
+	}
+
+	/*
+	 * The "files" format without a payload is the default and thus doesn't
+	 * need to be recorded as an extension.
+	 */
+	if (object_storage) {
+		char *payload = NULL;
+		if (odb_source_type_by_uri(object_storage, &payload) == ODB_SOURCE_FILES && !payload)
+			FREE_AND_NULL(object_storage);
+		free(payload);
+	}
+
 	/*
 	 * If we have a preexisting repository we need to verify that its
-	 * current ref storage format does not change.
+	 * current storage formats do not change.
 	 */
 	if (repo_fmt->version >= 0) {
 		if (ref_storage_format != repo_fmt->ref_storage_format)
@@ -2888,11 +2961,18 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		    strcmp(ref_storage_payload ? ref_storage_payload : "",
 			   repo_fmt->ref_storage_payload ? repo_fmt->ref_storage_payload : ""))
 			die(_("attempt to reinitialize repository with different reference storage payload"));
+		if (strcmp(object_storage ? object_storage : "",
+			   repo_fmt->object_storage ? repo_fmt->object_storage : ""))
+			die(_("attempt to reinitialize repository with different object storage format"));
 	}
 
 	free(repo_fmt->ref_storage_payload);
 	repo_fmt->ref_storage_format = ref_storage_format;
 	repo_fmt->ref_storage_payload = ref_storage_payload;
+
+	free(repo_fmt->object_storage);
+	repo_fmt->object_storage = object_storage;
+	free(cfg.object_storage_format);
 }
 
 void create_repository(struct repository *repo,
@@ -2902,6 +2982,7 @@ void create_repository(struct repository *repo,
 		       const char *template_dir,
 		       int hash,
 		       const char *ref_storage_format_uri,
+		       const char *object_storage_format_uri,
 		       int init_shared_repository,
 		       int *reinit_ok)
 {
@@ -2940,7 +3021,7 @@ void create_repository(struct repository *repo,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
-	repository_format_configure(&repo_fmt, hash, ref_storage_format_uri);
+	repository_format_configure(&repo_fmt, hash, ref_storage_format_uri, object_storage_format_uri);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 
diff --git a/setup.h b/setup.h
index 9145aacc5f..4e1737ade9 100644
--- a/setup.h
+++ b/setup.h
@@ -275,6 +275,7 @@ void create_repository(struct repository *repo,
 		       const char *template_dir,
 		       int hash_algo,
 		       const char *ref_storage_format_uri,
+		       const char *object_storage_format_uri,
 		       int init_shared_repository,
 		       int *reinit_ok);
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index d080ab04a8..0da14e8f70 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -898,6 +898,168 @@ test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FORMAT overrides ext
 	)
 '
 
+test_expect_success 'init with --object-storage-format=files does not set extension' '
+	test_when_finished "rm -rf objformat" &&
+	git init --object-storage-format=files objformat &&
+	test_must_fail git -C objformat config get extensions.objectstorage &&
+	echo files >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual &&
+	if test_have_prereq DEFAULT_REPO_FORMAT
+	then
+		echo 0 >expect &&
+		git -C objformat config get core.repositoryformatversion >actual &&
+		test_cmp expect actual
+	fi
+'
+
+test_expect_success 'init with --object-storage-format=files:// does not set extension' '
+	test_when_finished "rm -rf objformat" &&
+	git init --object-storage-format=files:// objformat &&
+	test_must_fail git -C objformat config get extensions.objectstorage &&
+	echo files >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init with --object-storage-format=files://<relative-path>' '
+	test_when_finished "rm -rf objformat" &&
+	git init --object-storage-format=files://objs objformat &&
+	echo files://objs >expect &&
+	git -C objformat config get extensions.objectstorage >actual &&
+	test_cmp expect actual &&
+	echo 1 >expect &&
+	git -C objformat config get core.repositoryformatversion >actual &&
+	test_cmp expect actual &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	echo files://objs >expect &&
+	test_cmp expect actual &&
+	test_path_is_dir objformat/.git/objects &&
+	test_path_is_dir objformat/.git/objs &&
+	test_commit -C objformat A &&
+	git -C objformat rev-parse --verify HEAD &&
+	test_path_is_missing objformat/.git/objects/pack &&
+	test_path_is_dir objformat/.git/objs/pack
+'
+
+test_expect_success 'init with --object-storage-format=files://<absolute-path>' '
+	test_when_finished "rm -rf objformat objdir" &&
+	git init --object-storage-format=files://"$(pwd)/objdir" objformat &&
+	echo "files://$(pwd)/objdir" >expect &&
+	git -C objformat config get extensions.objectstorage >actual &&
+	test_cmp expect actual &&
+	test_commit -C objformat A &&
+	git -C objformat rev-parse --verify HEAD &&
+	test_path_is_dir objdir/pack
+'
+
+test_expect_success 'GIT_OBJECT_DIRECTORY takes precedence over extensions.objectStorage payload' '
+	test_when_finished "rm -rf objformat objdir" &&
+	git init --object-storage-format=files://objs objformat &&
+	test_commit -C objformat A &&
+	mkdir objdir &&
+	test_must_fail env GIT_DIR="$PWD/objformat/.git" GIT_OBJECT_DIRECTORY="$PWD/objdir" \
+		git cat-file -e HEAD &&
+	GIT_DIR="$PWD/objformat/.git" GIT_OBJECT_DIRECTORY="$PWD/objdir" \
+		git hash-object -w objformat/A.t >oid &&
+	test_path_is_file objdir/$(test_oid_to_path "$(cat oid)")
+'
+
+test_expect_success 'init with --object-storage-format=garbage' '
+	test_when_finished "rm -rf objformat" &&
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format ${SQ}garbage${SQ}
+	EOF
+	test_must_fail git init --object-storage-format=garbage objformat 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'init with GIT_DEFAULT_OBJECT_STORAGE_FORMAT=garbage' '
+	test_when_finished "rm -rf objformat" &&
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format specified via GIT_DEFAULT_OBJECT_STORAGE_FORMAT: ${SQ}garbage${SQ}
+	EOF
+	test_must_fail env GIT_DEFAULT_OBJECT_STORAGE_FORMAT=garbage git init objformat 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'init with GIT_DEFAULT_OBJECT_STORAGE_FORMAT=files://objs' '
+	test_when_finished "rm -rf objformat" &&
+	GIT_DEFAULT_OBJECT_STORAGE_FORMAT=files://objs git init objformat &&
+	echo files://objs >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init with GIT_OBJECT_STORAGE_FORMAT=garbage' '
+	test_when_finished "rm -rf objformat" &&
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format specified via GIT_OBJECT_STORAGE_FORMAT: ${SQ}garbage${SQ}
+	EOF
+	test_must_fail env GIT_OBJECT_STORAGE_FORMAT=garbage git init objformat 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'GIT_OBJECT_STORAGE_FORMAT takes precedence over default' '
+	test_when_finished "rm -rf objformat" &&
+	GIT_DEFAULT_OBJECT_STORAGE_FORMAT=files://default \
+	GIT_OBJECT_STORAGE_FORMAT=files://explicit git init objformat &&
+	echo files://explicit >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--object-storage-format= takes precedence over environment' '
+	test_when_finished "rm -rf objformat" &&
+	GIT_OBJECT_STORAGE_FORMAT=files://explicit \
+	git init --object-storage-format=files://cmdline objformat &&
+	echo files://cmdline >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 're-init refuses with different storage format' '
+	test_when_finished "rm -rf objformat" &&
+	git init --object-storage-format=files objformat &&
+	cat >expect <<-EOF &&
+	fatal: attempt to reinitialize repository with different object storage format
+	EOF
+	test_must_fail env GIT_OBJECT_STORAGE_FORMAT=files://objs git init objformat 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 're-init with same object storage format' '
+	test_when_finished "rm -rf objformat" &&
+	git init --object-storage-format=files://objs objformat &&
+	git init --object-storage-format=files://objs objformat &&
+	git init objformat &&
+	echo files://objs >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init warns about invalid init.defaultObjectStorageFormat' '
+	test_when_finished "rm -rf objformat" &&
+	test_config_global init.defaultObjectStorageFormat garbage &&
+	echo "warning: unknown object storage format ${SQ}garbage${SQ}" >expect &&
+	git init objformat 2>err &&
+	test_cmp expect err &&
+	echo files >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init with init.defaultObjectStorageFormat' '
+	test_when_finished "rm -rf objformat" &&
+	test_config_global init.defaultObjectStorageFormat files://objs &&
+	git init objformat &&
+	echo files://objs >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual &&
+	test_commit -C objformat A &&
+	test_path_is_dir objformat/.git/objs/pack
+'
+
 test_expect_success MINGW 'core.hidedotfiles = false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&

-- 
2.56.0.269.g68944adf51.dirty

