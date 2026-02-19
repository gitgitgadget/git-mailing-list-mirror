Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3C31AF2D
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493917; cv=none; b=ETk/BQhncd856dMlZA6/IoWFgM4pUM26i7hi/r3E1SYTotvTudy4ejwkuxdA5K2wERuTSUwvBKZ7xhhnbu8fNB4+451buClP4+BQegNTowgZH4s+yMYzzlqulnrKUcTTBqtmP34X6WlAKTwHthcjpcG0MQGAspUil5Dv3z0a7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493917; c=relaxed/simple;
	bh=RDCWYmggehNtZERUrmElKoluEjuzqSYWuad1R2G6ZTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajPw8/uj9MVAUzHIGdI9U0vSOcqtZi5THNy8psnVymSKzhkPUQf6wnUskqVClzOvEXkeZlycinlyBMSh/4gISN4RwxyCut/p+EQ8DVNx02QzDQ0tjTqXPN5fwTKlDXFWeECi9qT7JGBwoxoGIz5EEggptiCQrK6R2USucVch4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYJP0VJK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYJP0VJK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43626796202so655246f8f.3
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 01:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771493914; x=1772098714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPp1acrbSZL2JF8Kb0GNndHnFDH6dg6+rvzWVZzkels=;
        b=fYJP0VJKiYYE0hMaCW6ZezVm2RCKYl6HdtxsPD0DtNTA+gZInoCF2Cd/KCnb0qQk7v
         P32tdX2F1W1+dkvjWHHr1uINlpBdwm1607WHgg6CHq+n6xGslvxPCUI8Xsf9O+7b1RHf
         ckvWPwC8/iJAg9Ze1k2oCPbLJtEA+yhgL8UlZN3hAhzQmra/sIzjGjxfSo4xkh88F4hA
         Q1UpGCjvS0DGo5dB2wfkiqgUHDjfDo0/lwzlXNSVyPcVtNzv7n8/pirvC6GiepImsFvR
         F/lLwzuwN0rKh3UZGLJpmNnmZxVHtGuOJMoAZdXetGa5MUsrSDZBml+WtCtc6+GIkNS0
         0bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493914; x=1772098714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPp1acrbSZL2JF8Kb0GNndHnFDH6dg6+rvzWVZzkels=;
        b=DENDlUmGvWCpgiuA3EIo8YNnQStwOUsbXrdvArxqlIJgybr6MgK5dDsRoDMQ38ggME
         hZUYAj6X8H/YxwSXo0HPIsiFMRHlUMKOmHcKgcmzzoUs3hNDz1jFhWYOUB0HSmeudsQR
         HSzz3IlYCT7ZsI65YLEkonTSwNTrIc10FV/Fw9kZMGArnBaCYfZ+aflfvcEtZhMf0d5q
         0Vg4ZK5Py3LYMnOCBMMhwi5y/tXRUFiGbLQ0KMdAmmksAPui0C0we7kmbhKUfLJsVS23
         i2kA+6j8Rh7zrwpmPi9znGn7DH/QSU7dM9nHwE26Ww8MNDODK6eNqjLs24BmSJfwr/lp
         FBEQ==
X-Gm-Message-State: AOJu0Yw38XvSFflKL4NoSZA4YaEOyDT+gDAEsjTiGE2jHYbVos+DHtOE
	iT/UjbGfnWA3BbDnmhS6udbI3CGJRhGhJMn9eMcCTNThAZmJwkrw6QmJ
X-Gm-Gg: AZuq6aIYH2+WGEr7THB3vj182hgE4a5AQ03GSUahiiiPo3YBm73ZzIB1O2frebjC8uS
	dWK+HmwW+n+9ybm4+rSdplrtixWoatWCsCBoL+4y6ckK0fqLaBJoKB5cjBwbOMJLBBaKNZP/O91
	u7vQ17LPqcxYAOi/QBu9g2LmZcqsZbQ0jrztuubngT/bYbJ/qVYSrYoGvdKhtIJ+QlnfehQGPhx
	qzWM1Z7UKO5Msp6t54QXxACf2hEUexLB74ZAVr5XD3ITZih5Al5Mppu2UQFgtq+W+5JoR/DnLhH
	4Q8kQvOHabyWokcSfv97nQ6Mm0JwnXuO1ykhap8H1hYajFg0aPsB4AEmskGdjCb9BYamlT7W7m/
	v3g67bPHCYh+HtG7gjYaiverJcGkCaP9/eyn6Htt30SVs4GLnG+ubAgi0r5B8BYvxI7N4tWmLpM
	WormUOFrI1VTCWSL2o2uCPxhfp8ILQVQ==
X-Received: by 2002:a05:600c:8219:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-48398b5d5bbmr79127265e9.22.1771493913701;
        Thu, 19 Feb 2026 01:38:33 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1ea7:2b8f:9148:411a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm694274985e9.7.2026.02.19.01.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 01:38:33 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 19 Feb 2026 10:38:25 +0100
Subject: [PATCH v7 6/6] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260219-kn-alternate-ref-dir-v7-6-16f27860dbdf@gmail.com>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
In-Reply-To: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 toon@iotcl.com, =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=17911;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=RDCWYmggehNtZERUrmElKoluEjuzqSYWuad1R2G6ZTQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmW2hNDb1ePa4CwBcBRqZzVcWIMDbVF4ynp5
 xVxRkWB/xI20okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpltoTAAoJED7VnySO
 Rox/+ysL/0LIWWRaPBRMVrkZav5X9rvnDmbAfiKD9st/fh3tLrvcI4GcXiOuiSW0j2fg8WTcn68
 t6QaJ0ppm6DDntxprDe+ZPeHka981M7DVzGsGtEQarmXQdpz8zmVKG2a0SfAzXF754X7kTaxzjR
 PLWyVK6/fUt7S6Js8KmygtXULGwoosWXOmL+UwNuawcw1XfXvmMpWRzYSLJ2Y0IlZERrNwjZGWI
 /yYwEY5e/Qc213/C4w5Zjmopp6DPKtrly2QaVDhC1iFOlCb/wNKsnQrC/wG0Ra6siis0S0vUn9m
 qZGtW0i3t1Im7y9L0lWofs4Fk/D0+v+kLO+IQW83zYJo+0NAFxUFbtzAzP8inlRCHwpf9RTBWmi
 R9YUZmIHdCDHpErE5qiEGpB378KzmpQnynureN1VOoe065Hki78NAzFOn1U7GcIQTqt/zCYw4qg
 FFkbK+VzdRnKtMXUWiFo7GUwXJBtcOzeuM9VwouCqCDUq6BD7pO7/NlaqvEn6ES8xy1vAbywuw6
 Js=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git allows setting a different object directory via
'GIT_OBJECT_DIRECTORY', but provides no equivalent for references. In
the previous commit we extended the 'extensions.refStorage' config to
also support an URI input for reference backend with location.

Let's also add a new environment variable 'GIT_REFERENCE_BACKEND' that
takes in the same input as the config variable. Having an environment
variable allows us to modify the reference backend and location on the
fly for individual Git commands.

The environment variable also allows usage of alternate reference
directories during 'git-clone(1)' and 'git-init(1)'. Add the config to
the repository when created with the environment variable set.

When initializing the repository with an alternate reference folder,
create the required stubs in the repositories $GIT_DIR. The inverse,
i.e. removal of the ref store doesn't clean up the stubs in the $GIT_DIR
since that would render it unusable. Removal of ref store is only used
when migrating between ref formats and cleanup of the $GIT_DIR doesn't
make sense in such a situation.

Helped-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git.adoc |   5 ++
 environment.h          |   1 +
 refs.c                 |  30 +++++---
 setup.c                |  55 +++++++++++++-
 t/t1423-ref-backend.sh | 189 ++++++++++++++++++++++++++++++++++++++++---------
 5 files changed, 235 insertions(+), 45 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..66442735ea 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -584,6 +584,11 @@ double-quotes and respecting backslash escapes. E.g., the value
 	repositories will be set to this value. The default is "files".
 	See `--ref-format` in linkgit:git-init[1].
 
+`GIT_REFERENCE_BACKEND`::
+    Specify which reference backend to be used along with its URI.
+    See `extensions.refStorage` option in linkgit:git-config[1] for more
+    details. Overrides the config variable when used.
+
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
diff --git a/environment.h b/environment.h
index 27f657af04..540e0a7f6d 100644
--- a/environment.h
+++ b/environment.h
@@ -42,6 +42,7 @@
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
+#define GIT_REFERENCE_BACKEND_ENVIRONMENT "GIT_REFERENCE_BACKEND"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/refs.c b/refs.c
index ef1902e85c..a700a66f08 100644
--- a/refs.c
+++ b/refs.c
@@ -2192,13 +2192,17 @@ int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *e
 {
 	int ret = refs->be->create_on_disk(refs, flags, err);
 
-	if (!ret &&
-	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
-		struct strbuf msg = STRBUF_INIT;
-
-		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
-		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
-		strbuf_release(&msg);
+	if (!ret) {
+		/* Creation of stubs for linked worktrees are handled in the worktree code. */
+		if (!(flags & REF_STORE_CREATE_ON_DISK_IS_WORKTREE) && refs->repo->ref_storage_payload) {
+			refs_create_refdir_stubs(refs->repo, refs->repo->gitdir,
+						 "repository uses alternate refs storage");
+		} else if (ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
+			struct strbuf msg = STRBUF_INIT;
+			strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
+			refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
+			strbuf_release(&msg);
+		}
 	}
 
 	return ret;
@@ -2208,10 +2212,18 @@ int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
 {
 	int ret = refs->be->remove_on_disk(refs, err);
 
-	if (!ret &&
-	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
+	if (!ret) {
+		enum ref_storage_format format = ref_storage_format_by_name(refs->be->name);
 		struct strbuf sb = STRBUF_INIT;
 
+		/* Backends apart from the files backend create stubs. */
+		if (format == REF_STORAGE_FORMAT_FILES)
+			return ret;
+
+		/* Alternate refs backend require stubs in the gitdir. */
+		if (refs->repo->ref_storage_payload)
+			return ret;
+
 		strbuf_addf(&sb, "%s/HEAD", refs->gitdir);
 		if (unlink(sb.buf) < 0) {
 			strbuf_addf(err, "could not delete stub HEAD: %s",
diff --git a/setup.c b/setup.c
index d407f3347b..90cb9be578 100644
--- a/setup.c
+++ b/setup.c
@@ -1838,6 +1838,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	const char *prefix = NULL;
+	const char *ref_backend_uri;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
@@ -1995,6 +1996,25 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
+	/*
+	 * The env variable should override the repository config
+	 * for 'extensions.refStorage'.
+	 */
+	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+	if (ref_backend_uri) {
+		char *backend, *payload;
+		enum ref_storage_format format;
+
+		parse_reference_uri(ref_backend_uri, &backend, &payload);
+		format = ref_storage_format_by_name(backend);
+		if (format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format: '%s'"), backend);
+		repo_set_ref_storage_format(the_repository, format, payload);
+
+		free(backend);
+		free(payload);
+	}
+
 	setup_original_cwd();
 
 	strbuf_release(&dir);
@@ -2337,7 +2357,8 @@ void initialize_repository_version(int hash_algo,
 	 * the remote repository's format.
 	 */
 	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
-	    ref_storage_format != REF_STORAGE_FORMAT_FILES)
+	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
+	    the_repository->ref_storage_payload)
 		target_version = GIT_REPO_VERSION_READ;
 
 	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
@@ -2346,11 +2367,20 @@ void initialize_repository_version(int hash_algo,
 	else if (reinit)
 		repo_config_set_gently(the_repository, "extensions.objectformat", NULL);
 
-	if (ref_storage_format != REF_STORAGE_FORMAT_FILES)
+	if (the_repository->ref_storage_payload) {
+		struct strbuf ref_uri = STRBUF_INIT;
+
+		strbuf_addf(&ref_uri, "%s://%s",
+			    ref_storage_format_to_name(ref_storage_format),
+			    the_repository->ref_storage_payload);
+		repo_config_set(the_repository, "extensions.refstorage", ref_uri.buf);
+		strbuf_release(&ref_uri);
+	} else if (ref_storage_format != REF_STORAGE_FORMAT_FILES) {
 		repo_config_set(the_repository, "extensions.refstorage",
 				ref_storage_format_to_name(ref_storage_format));
-	else if (reinit)
+	} else if (reinit) {
 		repo_config_set_gently(the_repository, "extensions.refstorage", NULL);
+	}
 
 	if (reinit) {
 		struct strbuf config = STRBUF_INIT;
@@ -2623,6 +2653,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		.ignore_repo = 1,
 		.ignore_worktree = 1,
 	};
+	const char *ref_backend_uri;
 	const char *env;
 
 	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
@@ -2668,6 +2699,24 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	} else {
 		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
 	}
+
+
+	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+	if (ref_backend_uri) {
+		char *backend, *payload;
+		enum ref_storage_format format;
+
+		parse_reference_uri(ref_backend_uri, &backend, &payload);
+		format = ref_storage_format_by_name(backend);
+		if (format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format: '%s'"), backend);
+
+		repo_fmt->ref_storage_format = format;
+		repo_fmt->ref_storage_payload = payload;
+
+		free(backend);
+	}
+
 	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format,
 				    repo_fmt->ref_storage_payload);
 }
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index 9912433b8c..d69aea3f7f 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -11,16 +11,25 @@ test_description='Test reference backend URIs'
 #   <backend> is the original ref storage of the repo.
 #   <uri> is the new URI to be set for the ref storage.
 #   <cmd> is the git subcommand to be run in the repository.
+#   <via> if 'config', set the backend via the 'extensions.refStorage' config.
+#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
 run_with_uri() {
 	repo=$1 &&
 	backend=$2 &&
 	uri=$3 &&
 	cmd=$4 &&
+	via=$5 &&
 
-	git -C "$repo" config set core.repositoryformatversion 1
-	git -C "$repo" config set extensions.refStorage "$uri" &&
-	git -C "$repo" $cmd &&
-	git -C "$repo" config set extensions.refStorage "$backend"
+	git -C "$repo" config set core.repositoryformatversion 1 &&
+	if test "$via" = "env"
+	then
+		test_env GIT_REFERENCE_BACKEND="$uri" git -C "$repo" $cmd
+	elif test "$via" = "config"
+	then
+		git -C "$repo" config set extensions.refStorage "$uri" &&
+		git -C "$repo" $cmd &&
+		git -C "$repo" config set extensions.refStorage "$backend"
+	fi
 }
 
 # Test a repository with a given reference storage by running and comparing
@@ -30,44 +39,86 @@ run_with_uri() {
 #   <repo> is the relative path to the repo to run the command in.
 #   <backend> is the original ref storage of the repo.
 #   <uri> is the new URI to be set for the ref storage.
+#   <via> if 'config', set the backend via the 'extensions.refStorage' config.
+#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
 #   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
 test_refs_backend() {
 	repo=$1 &&
 	backend=$2 &&
 	uri=$3 &&
-	err_msg=$4 &&
+	via=$4 &&
+	err_msg=$5 &&
+
 
-	git -C "$repo" config set core.repositoryformatversion 1 &&
 	if test -n "$err_msg";
 	then
-		git -C "$repo" config set extensions.refStorage "$uri" &&
-		test_must_fail git -C "$repo" refs list 2>err &&
-		test_grep "$err_msg" err
+		if test "$via" = "env"
+		then
+			test_env GIT_REFERENCE_BACKEND="$uri" test_must_fail git -C "$repo" refs list 2>err
+		elif test "$via" = "config"
+		then
+			git -C "$repo" config set extensions.refStorage "$uri" &&
+			test_must_fail git -C "$repo" refs list 2>err &&
+			test_grep "$err_msg" err
+		fi
 	else
 		git -C "$repo" refs list >expect &&
-		run_with_uri "$repo" "$backend" "$uri" "refs list" >actual &&
+		run_with_uri "$repo" "$backend" "$uri" "refs list" "$via">actual &&
 		test_cmp expect actual
 	fi
 }
 
-test_expect_success 'URI is invalid' '
+# Verify that the expected files are present in the gitdir and the refsdir.
+# Usage: verify_files_exist <gitdir> <refdir>
+#   <gitdir> is the path for the gitdir.
+#   <refdir> is the path for the refdir.
+verify_files_exist() {
+	gitdir=$1 &&
+	refdir=$2 &&
+
+	# verify that the stubs were added to the $GITDIR.
+	cat $gitdir/refs/heads >actual &&
+	echo "repository uses alternate refs storage" >expect &&
+	test_cmp expect actual &&
+	cat $gitdir/HEAD >actual &&
+	echo "ref: refs/heads/.invalid" >expect &&
+	test_cmp expect actual
+
+	# verify that backend specific files exist.
+	case "$GIT_DEFAULT_REF_FORMAT" in
+	files)
+		test_path_is_dir $refdir/refs/heads &&
+		test_path_is_file $refdir/HEAD;;
+	reftable)
+		test_path_is_dir $refdir/reftable &&
+		test_path_is_file $refdir/reftable/tables.list;;
+	*)
+		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+	esac
+}
+
+methods="config env"
+for method in $methods
+do
+
+test_expect_success "$method: URI is invalid" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	test_refs_backend repo files "reftable@/home/reftable" \
+	test_refs_backend repo files "reftable@/home/reftable" "$method" \
 		"invalid value for ${SQ}extensions.refstorage${SQ}"
 '
 
-test_expect_success 'URI ends with colon' '
+test_expect_success "$method: URI ends with colon" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	test_refs_backend repo files "reftable:" \
+	test_refs_backend repo files "reftable:" "$method" \
 		"invalid value for ${SQ}extensions.refstorage${SQ}"
 '
 
-test_expect_success 'unknown reference backend' '
+test_expect_success "$method: unknown reference backend" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	test_refs_backend repo files "db://.git" \
+	test_refs_backend repo files "db://.git" "$method" \
 		"invalid value for ${SQ}extensions.refstorage${SQ}"
 '
 
@@ -86,7 +137,7 @@ do
 	for dir in "$(pwd)/repo/.git" "."
 	do
 
-		test_expect_success "read from $to_format backend, $dir dir" '
+		test_expect_success "$method: read from $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-format=$from_format repo &&
 			(
@@ -101,7 +152,7 @@ do
 			)
 		'
 
-		test_expect_success "write to $to_format backend, $dir dir" '
+		test_expect_success "$method: write to $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-format=$from_format repo &&
 			(
@@ -113,20 +164,22 @@ do
 				git refs migrate --dry-run --ref-format=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 
-				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" &&
+				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method" &&
 
 				git refs list >expect &&
-				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "tag -d 1" &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"tag -d 1" "$method" &&
 				git refs list >actual &&
 				test_cmp expect actual &&
 
 				git refs list | grep -v "refs/tags/1" >expect &&
-				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "refs list" >actual &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"refs list" "$method" >actual &&
 				test_cmp expect actual
 			)
 		'
 
-		test_expect_success "with worktree and $to_format backend, $dir dir" '
+		test_expect_success "$method: with worktree and $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo wt" &&
 			git init --ref-format=$from_format repo &&
 			(
@@ -138,22 +191,92 @@ do
 				git refs migrate --dry-run --ref-format=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 
-				git config set core.repositoryformatversion 1 &&
-				git config set extensions.refStorage "$to_format://$BACKEND_PATH" &&
-
-				git worktree add ../wt 2
-			) &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"worktree add ../wt 2" "$method" &&
 
-			git -C repo for-each-ref --include-root-refs >expect &&
-			git -C wt for-each-ref --include-root-refs >expect &&
-			! test_cmp expect actual &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"for-each-ref --include-root-refs" "$method" >actual &&
+				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
+					"for-each-ref --include-root-refs" "$method" >expect &&
+				! test_cmp expect actual &&
 
-			git -C wt rev-parse 2 >expect &&
-			git -C wt rev-parse HEAD >actual &&
-			test_cmp expect actual
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"rev-parse 2" "$method" >actual &&
+				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
+					"rev-parse HEAD" "$method" >expect &&
+				test_cmp expect actual
+			)
 		'
 	done # closes dir
+
+	test_expect_success "migrating repository to $to_format with alternate refs directory" '
+		test_when_finished "rm -rf repo refdir" &&
+		mkdir refdir &&
+		GIT_REFERENCE_BACKEND="${from_format}://$(pwd)/refdir" git init repo &&
+		(
+			cd repo &&
+
+			test_commit 1 &&
+			test_commit 2 &&
+			test_commit 3 &&
+
+			git refs migrate --ref-format=$to_format &&
+			git refs list >out &&
+			test_grep "refs/tags/1"	out &&
+			test_grep "refs/tags/2"	out &&
+			test_grep "refs/tags/3"	out
+		)
+	'
+
 done # closes to_format
 done # closes from_format
 
+done # closes method
+
+test_expect_success 'initializing repository with alt ref directory' '
+	test_when_finished "rm -rf repo refdir" &&
+	mkdir refdir &&
+	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
+	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
+	verify_files_exist repo/.git refdir &&
+	(
+		cd repo &&
+
+		git config get extensions.refstorage >expect &&
+		echo $BACKEND >actual &&
+		test_cmp expect actual &&
+
+		test_commit 1 &&
+		test_commit 2 &&
+		test_commit 3 &&
+		git refs list >out &&
+		test_grep "refs/tags/1"	out &&
+		test_grep "refs/tags/2"	out &&
+		test_grep "refs/tags/3"	out
+	)
+'
+
+test_expect_success 'cloning repository with alt ref directory' '
+	test_when_finished "rm -rf source repo refdir" &&
+	mkdir refdir &&
+
+	git init source &&
+	test_commit -C source 1 &&
+	test_commit -C source 2 &&
+	test_commit -C source 3 &&
+
+	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
+	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
+
+	git -C repo config get extensions.refstorage >expect &&
+	echo $BACKEND >actual &&
+	test_cmp expect actual &&
+
+	verify_files_exist repo/.git refdir &&
+
+	git -C source for-each-ref refs/tags/ >expect &&
+	git -C repo for-each-ref refs/tags/ >actual &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.53.GIT

