Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B8471D1A
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518201; cv=none; b=Z86A6dmE/T4joyt2LrgYn1nHFSf2F/C3jRpelkmQRhUOZcZlUsYGEfvjs/iGvJwCw40vNe4uQ9aJSy/bSIxrEZlAi9o99tWRaYx3W2PN187pPi8m9IMxjakKr5v0ocZ2krz4iAoBpQT3hQh/Znz8bfUoltIye4VRsC3v55nHkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518201; c=relaxed/simple;
	bh=LxZ2a+Af3KdeWwFc6F5M8P4HN2ZO9xXChLMSqAA7yCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXjmFg1UzUQB7qdriT2SZDC+HGZJBZ5mrBYrF+hTOuCqcKHXz4kTkYdACnXoIEKxirbyLN67nn9UudJpXwK19NpNH9GbOWycLW9ihgg/314cDaGCHuip9/tKhiC1r60O+HP8OPFjthb5FDrqGX3ne4sZVgPfYyv5Az6kvnUr1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kokg/Qqn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F+bZZQoG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kokg/Qqn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F+bZZQoG"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id D52FAEC0128;
	Fri,  4 Sep 2026 06:36:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 04 Sep 2026 06:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518196;
	 x=1788604596; bh=KCd1uKD8wHGYemIzWGdEs8ytfEyZt5iyTvg5P4GQwa0=; b=
	kokg/Qqngy8nZl6vbJMnQdU0um+ARSxgcDSalUjlC4t3dLG6G+D5KKhCRTo1tP8d
	Nunw80TevD8oz15jBOoAy6iGmR3evhp2MroZM73XX0fs4QyDHPGLL7maOX83Rf58
	HlJJPm+Ms43xt+cMQufaMq5GZSXXZ1NM9kUTrUQMBN/6GBZMQh+P993EeYd9BCb8
	YijSG0fd0s+xfiG86xFjTpnBOG66PbdrGTrfdcjNyRcTC8u/k5JRRLFCB+woOcKo
	1CDBBADoOm/TnZnoitAf6xUYSRpZzMhAPEgwOC0APKyzuxrkiC9McTxAJ0rrvdPp
	qjTwrB4ML1MGmz5jTDj1hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518196; x=
	1788604596; bh=KCd1uKD8wHGYemIzWGdEs8ytfEyZt5iyTvg5P4GQwa0=; b=F
	+bZZQoGTXydfCEwi6E4kVGydZD7Pr3X4lylpD8lcqvUR6s9LYNQq1WedqVEDiJFc
	zlzVySxl7Kkyw2WD12GzV/NGFMCu6dWCyh4QNunu0anysTtBKf+IKRnwQu1bR5H1
	Ksbtt32Ia7IaRzo+cH0v2H4OfOmmv8kpXri8arr4qmC6NRqAzEI7uuA/AWZgN+eI
	dKUHsUg2S6MZO95LIAJjfu+uZRdB4Tuh5vYN2AIBDvU5UhU78UqLULKVGn6oopvm
	lF1crPu2UTG8fdNQGhAJZUN4AOapRf9dbSWb3rDeK7W0ObOJr0hcLv6N5EHniZet
	wBbR2Gkn/6cJUeUtx99hA==
X-ME-Sender: <xms:NJ-aagtdB38Mzop_v0WzVz-6wVLOO030ers_VJDXAAPmIBCLxcXWRw>
    <xme:NJ-aajcfctyShvUmh_xejT9RupvAg9H_hu_h2bGhi9lxWgbDcTXw5c7B4lvdtkWhx
    pZCZbLfxE2PSfsE73Sqpti3hbCDJNxrflj651FGDUbxOrwze0ggxF8>
X-ME-Received: <xmr:NJ-aapaqnxEdug6NcEyv89cMgfBfu8YcR_FECwGmnY7vtqyQYBtng-PgySm6TgtPl09JFA>
X-ME-Proxy-Cause: dmFkZTGLtbgOWMqJ+BFPzvk4lwNKiSmzFarybhFKtGzShDwxIBw+CMwIV4fcNH+gWfinUs
    mzHC8PvWI8KTibDbh/2geRLAqYK3gLwa4ZAWmLXVG+AQbYudxnI8TKpoDW3NzqR9BKTYAz
    mF/sN44lZkOa+3MC5OOwJhUAWukCIcu9WvATFmgd9/CHSUgOU6Rs689v9XbKrpaaPAgQKT
    uk4Jn1GzHZfVY9bJQUJQixTUM2xm+zQ1j4wzvoRBkL+GqSvrrLuIy7jxpdbbPMmmTJ2WLS
    3a/lsVEE6pL93VCXUZfmTQYTllu+2r6IhgBFK1DpZcpwl2DlfBrgwrrk4ggYTTUB+ZXqXo
    cTPyiS1XUZhI0tHqYU6QI+U3YPCWKzlWFUYTHqTL01nsdQ6DkIuaEkKGU1a/yMzQk0KJU6
    tApkwgrvT0EKsLHdYFCivPn6NmFjAVxvWvrT6AQhPdhkbmnNdQMJLV72oO8B0A1aFZqh0n
    6gk6hD8jKrGlsaMNcMIqk+dFsvYj3113fxSsNYhoU3VQiiSEYbiM0oxPbbcsYxBwXKQXB0
    BoFVm1qZhlTWFRFwWzLK+mFMGeZxpH8JaD1Es5mdsfXJDXRYV+sr67Wcy7B70D5yMfizyd
    Y0g/DLavxuT66Fe+8ZNP08zsaR5XNIeOLQ117w0P7dltMKq6WhsskmqKLeeA
X-ME-Proxy: <xmx:NJ-aauWuYHJ5EpZkMu69YuPvkc4sqNEJSiJZZSg0FpIuGfDLcPLE_A>
    <xmx:NJ-aajizLkuvkK4QgL22gsW4iV43GyLU9svQ4-XoFQ1H1c_747uIiw>
    <xmx:NJ-aakWKHl2Gq-ApHy3JAwAPhO669MojlwzGnnPbVzzHjAJFPpExkQ>
    <xmx:NJ-aaiOQaz9CSYgAecHAAClCmeq54XACf05d8MWwQGJvZFetg_179w>
    <xmx:NJ-aajzuSmkEQcdJd37rYUo5ANM69oxDwCWWU1Hdq7SlH27W5sczPHfm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 89f54dce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:10 +0200
Subject: [PATCH 09/11] setup: rename ref storage format environment
 variables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-9-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename the environment
variables GIT_REFERENCE_BACKEND and GIT_DEFAULT_REF_FORMAT to
GIT_REF_STORAGE and GIT_DEFAULT_REF_STORAGE, respectively. The old names
are kept as an alias to retain compatibility.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/init.adoc         |  2 +-
 Documentation/git.adoc                 |  6 ++--
 environment.h                          |  1 +
 setup.c                                | 21 ++++++++------
 t/t0001-init.sh                        | 50 +++++++++++++++++-----------------
 t/t1419-exclude-refs.sh                | 16 +++++------
 t/t1423-ref-backend.sh                 | 18 ++++++------
 t/t7424-submodule-mixed-ref-formats.sh | 14 +++++-----
 t/test-lib.sh                          |  8 +++---
 9 files changed, 71 insertions(+), 65 deletions(-)

diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index 9c78440192..3098e033ac 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -16,7 +16,7 @@ endif::[]
 `init.defaultRefFormat`::
 	Allows overriding the default ref storage format for new repositories.
 	See `--ref-storage=` in linkgit:git-init[1]. Both the command line
-	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
+	option and the `GIT_DEFAULT_REF_STORAGE` environment variable take
 	precedence over this config.
 
 init.defaultSubmodulePathConfig::
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index e3260fde68..e34c74d995 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -590,13 +590,13 @@ double-quotes and respecting backslash escapes. E.g., the value
 	is always used. The default is "sha1".
 	See `--object-format` in linkgit:git-init[1].
 
-`GIT_DEFAULT_REF_FORMAT`::
+`GIT_DEFAULT_REF_STORAGE`::
 	If this variable is set, the default reference backend format for new
 	repositories will be set to this value. The default is "files".
 	See `--ref-storage` in linkgit:git-init[1].
 
-`GIT_REFERENCE_BACKEND`::
-    Specify which reference backend to be used along with its URI.
+`GIT_REF_STORAGE`::
+    Specify which ref storage to be used along with its URI.
     See `extensions.refStorage` option in linkgit:git-config[1] for more
     details. Overrides the config variable when used.
 
diff --git a/environment.h b/environment.h
index e7ec5b0437..e6b933f8db 100644
--- a/environment.h
+++ b/environment.h
@@ -44,6 +44,7 @@
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
 #define GIT_REFERENCE_BACKEND_ENVIRONMENT "GIT_REFERENCE_BACKEND"
+#define GIT_REF_STORAGE_ENVIRONMENT "GIT_REF_STORAGE"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/setup.c b/setup.c
index d6e28dd675..5de2aa0d2f 100644
--- a/setup.c
+++ b/setup.c
@@ -2049,7 +2049,9 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			 * The env variable should override the repository config
 			 * for 'extensions.refStorage'.
 			 */
-			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+			ref_backend_uri = getenv(GIT_REF_STORAGE_ENVIRONMENT);
+			if (!ref_backend_uri)
+				ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
 			if (ref_backend_uri) {
 				FREE_AND_NULL(discovery.format.ref_storage_payload);
 				discovery.format.ref_storage_format =
@@ -2768,14 +2770,15 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 *   1. Explicit override via the command line, like in `git init
 	 *      --ref-storage=`.
 	 *
-	 *   2. Explicit override via the environment with
-	 *      GIT_REFERENCE_BACKEND.
+	 *   2. Explicit override via the environment with "GIT_REF_STORAGE" or
+	 *      its deprecated equivalent "GIT_REFERENCE_BACKEND".
 	 *
 	 *   3. Existing repository format. All the subsequent sources only
 	 *      kick in when there is no repository yet.
 	 *
 	 *   4. The default ref storage format for new repositories as
-	 *      configured via "GIT_DEFAULT_REF_FORMAT".
+	 *      configured via "GIT_DEFAULT_REF_STORAGE" or its deprecated
+	 *      equivalent "GIT_DEFAULT_REF_FORMAT".
 	 *
 	 *   5. The default ref storage format for new repositories as
 	 *      configured via "init.defaultRefFormat"
@@ -2785,19 +2788,21 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 */
 	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
 		/* nothing to do */
-	} else if ((env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT))) {
+	} else if (((env = getenv(GIT_REF_STORAGE_ENVIRONMENT)) ||
+		    (env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT)))) {
 		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown reference storage format specified via %s: '%s'"),
-			    GIT_REFERENCE_BACKEND_ENVIRONMENT, env);
+			    GIT_REF_STORAGE_ENVIRONMENT, env);
 	} else if (repo_fmt->version >= 0) {
 		ref_storage_format = repo_fmt->ref_storage_format;
 		ref_storage_payload = xstrdup_or_null(repo_fmt->ref_storage_payload);
-	} else if ((env = getenv("GIT_DEFAULT_REF_FORMAT"))) {
+	} else if (((env = getenv("GIT_DEFAULT_REF_STORAGE")) ||
+		    (env = getenv("GIT_DEFAULT_REF_FORMAT")))) {
 		ref_storage_format = ref_storage_format_by_name(env);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown reference storage format specified via %s: '%s'"),
-			    "GIT_DEFAULT_REF_FORMAT", env);
+			    "GIT_DEFAULT_REF_STORAGE", env);
 	} else if (cfg.ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
 		ref_storage_format = cfg.ref_storage_format;
 	} else {
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index d7e592d8a5..e4b9fae8bd 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -640,22 +640,22 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with unknown back
 	test_grep "invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}garbage${SQ}" err
 '
 
-test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
+test_expect_success 'init with GIT_DEFAULT_REF_STORAGE=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
-	fatal: unknown reference storage format specified via GIT_DEFAULT_REF_FORMAT: ${SQ}garbage${SQ}
+	fatal: unknown reference storage format specified via GIT_DEFAULT_REF_STORAGE: ${SQ}garbage${SQ}
 	EOF
-	test_must_fail env GIT_DEFAULT_REF_FORMAT=garbage git init refformat 2>err &&
+	test_must_fail env GIT_DEFAULT_REF_STORAGE=garbage git init refformat 2>err &&
 	test_cmp expect err
 '
 
-test_expect_success 'GIT_REFERENCE_BACKEND refuses to reinitialize with different storage format' '
+test_expect_success 'GIT_REF_STORAGE refuses to reinitialize with different storage format' '
 	test_when_finished "rm -rf refbackend" &&
 	git init --ref-storage=files refbackend &&
 	cat >expect <<-EOF &&
 	fatal: attempt to reinitialize repository with different reference storage format
 	EOF
-	test_must_fail env GIT_REFERENCE_BACKEND=reftable git init refbackend 2>err &&
+	test_must_fail env GIT_REF_STORAGE=reftable git init refbackend 2>err &&
 	test_cmp expect err
 '
 
@@ -668,14 +668,14 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
 	test_cmp expect err &&
 
 	git -C repo rev-parse --show-ref-storage >actual &&
-	echo $GIT_DEFAULT_REF_FORMAT >expected &&
+	echo $GIT_DEFAULT_REF_STORAGE >expected &&
 	test_cmp expected actual
 '
 
 test_expect_success 'default ref format' '
 	test_when_finished "rm -rf refformat" &&
 	(
-		sane_unset GIT_DEFAULT_REF_FORMAT &&
+		sane_unset GIT_DEFAULT_REF_STORAGE &&
 		git init refformat
 	) &&
 	git version --build-options | sed -ne "s/^default-ref-storage: //p" >expect &&
@@ -686,9 +686,9 @@ test_expect_success 'default ref format' '
 backends="files reftable"
 for format in $backends
 do
-	test_expect_success DEFAULT_REPO_FORMAT "init with GIT_DEFAULT_REF_FORMAT=$format" '
+	test_expect_success DEFAULT_REPO_FORMAT "init with GIT_DEFAULT_REF_STORAGE=$format" '
 		test_when_finished "rm -rf refformat" &&
-		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
+		GIT_DEFAULT_REF_STORAGE=$format git init refformat &&
 
 		if test $format = files
 		then
@@ -718,7 +718,7 @@ do
 		test_when_finished "rm -rf refformat" &&
 		test_config_global init.defaultRefFormat $format &&
 		(
-			sane_unset GIT_DEFAULT_REF_FORMAT &&
+			sane_unset GIT_DEFAULT_REF_STORAGE &&
 			git init refformat
 		) &&
 
@@ -727,37 +727,37 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "--ref-storage=$format overrides GIT_DEFAULT_REF_FORMAT" '
+	test_expect_success "--ref-storage=$format overrides GIT_DEFAULT_REF_STORAGE" '
 		test_when_finished "rm -rf refformat" &&
-		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage=$format refformat &&
+		GIT_DEFAULT_REF_STORAGE=garbage git init --ref-storage=$format refformat &&
 		echo $format >expect &&
 		git -C refformat rev-parse --show-ref-storage >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "reinit repository with GIT_DEFAULT_REF_FORMAT=$format does not change format" '
+	test_expect_success "reinit repository with GIT_DEFAULT_REF_STORAGE=$format does not change format" '
 		test_when_finished "rm -rf refformat" &&
 		git init refformat &&
 		git -C refformat rev-parse --show-ref-storage >expect &&
-		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
+		GIT_DEFAULT_REF_STORAGE=$format git init refformat &&
 		git -C refformat rev-parse --show-ref-storage >actual &&
 		test_cmp expect actual
 	'
 done
 
-test_expect_success "--ref-storage= overrides GIT_DEFAULT_REF_FORMAT" '
+test_expect_success "--ref-storage= overrides GIT_DEFAULT_REF_STORAGE" '
 	test_when_finished "rm -rf refformat" &&
-	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage=reftable refformat &&
+	GIT_DEFAULT_REF_STORAGE=files git init --ref-storage=reftable refformat &&
 	echo reftable >expect &&
 	git -C refformat rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides init.defaultRefFormat" '
+test_expect_success "GIT_DEFAULT_REF_STORAGE= overrides init.defaultRefFormat" '
 	test_when_finished "rm -rf refformat" &&
 	test_config_global init.defaultRefFormat files &&
 
-	GIT_DEFAULT_REF_FORMAT=reftable git init refformat &&
+	GIT_DEFAULT_REF_STORAGE=reftable git init refformat &&
 	echo reftable >expect &&
 	git -C refformat rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
@@ -767,7 +767,7 @@ test_expect_success "init with feature.experimental=true" '
 	test_when_finished "rm -rf refformat" &&
 	test_config_global feature.experimental true &&
 	(
-		sane_unset GIT_DEFAULT_REF_FORMAT &&
+		sane_unset GIT_DEFAULT_REF_STORAGE &&
 		git init refformat
 	) &&
 	echo reftable >expect &&
@@ -780,7 +780,7 @@ test_expect_success "init.defaultRefFormat overrides feature.experimental=true"
 	test_config_global feature.experimental true &&
 	test_config_global init.defaultRefFormat files &&
 	(
-		sane_unset GIT_DEFAULT_REF_FORMAT &&
+		sane_unset GIT_DEFAULT_REF_STORAGE &&
 		git init refformat
 	) &&
 	echo files >expect &&
@@ -788,10 +788,10 @@ test_expect_success "init.defaultRefFormat overrides feature.experimental=true"
 	test_cmp expect actual
 '
 
-test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides feature.experimental=true" '
+test_expect_success "GIT_DEFAULT_REF_STORAGE= overrides feature.experimental=true" '
 	test_when_finished "rm -rf refformat" &&
 	test_config_global feature.experimental true &&
-	GIT_DEFAULT_REF_FORMAT=files git init refformat &&
+	GIT_DEFAULT_REF_STORAGE=files git init refformat &&
 	echo files >expect &&
 	git -C refformat rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
@@ -942,7 +942,7 @@ test_expect_success 'branch -m with the initial branch' '
 test_expect_success 'init with includeIf.onbranch condition' '
 	test_when_finished "rm -rf repo" &&
 	git -c includeIf.onbranch:main.path=nonexistent init repo &&
-	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	echo $GIT_DEFAULT_REF_STORAGE >expect &&
 	git -C repo rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
@@ -951,7 +951,7 @@ test_expect_success 'init with includeIf.onbranch condition with existing direct
 	test_when_finished "rm -rf repo" &&
 	mkdir repo &&
 	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
-	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	echo $GIT_DEFAULT_REF_STORAGE >expect &&
 	git -C repo rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
@@ -960,7 +960,7 @@ test_expect_success 're-init with includeIf.onbranch condition' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
-	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	echo $GIT_DEFAULT_REF_STORAGE >expect &&
 	git -C repo rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index 04797aee59..8f54bb9e27 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -21,13 +21,13 @@ assert_jumps () {
 	local nr="$1"
 	local trace="$2"
 
-	case "$GIT_DEFAULT_REF_FORMAT" in
+	case "$GIT_DEFAULT_REF_STORAGE" in
 	files)
 		grep -q "name:jumps_made value:$nr$" $trace;;
 	reftable)
 		grep -q "name:reseeks_made value:$nr$" $trace;;
 	*)
-		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+		BUG "unhandled ref format $GIT_DEFAULT_REF_STORAGE";;
 	esac
 }
 
@@ -93,13 +93,13 @@ test_expect_success 'adjacent, non-overlapping excluded regions' '
 	for_each_ref refs/heads/foo refs/heads/quux >expect &&
 
 	test_cmp expect actual &&
-	case "$GIT_DEFAULT_REF_FORMAT" in
+	case "$GIT_DEFAULT_REF_STORAGE" in
 	files)
 		assert_jumps 1 perf;;
 	reftable)
 		assert_jumps 2 perf;;
 	*)
-		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+		BUG "unhandled ref format $GIT_DEFAULT_REF_STORAGE";;
 	esac
 '
 
@@ -125,13 +125,13 @@ test_expect_success 'several overlapping excluded regions' '
 	for_each_ref refs/heads/quux >expect &&
 
 	test_cmp expect actual &&
-	case "$GIT_DEFAULT_REF_FORMAT" in
+	case "$GIT_DEFAULT_REF_STORAGE" in
 	files)
 		assert_jumps 1 perf;;
 	reftable)
 		assert_jumps 3 perf;;
 	*)
-		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+		BUG "unhandled ref format $GIT_DEFAULT_REF_STORAGE";;
 	esac
 '
 
@@ -141,13 +141,13 @@ test_expect_success 'unordered excludes' '
 	for_each_ref refs/heads/bar refs/heads/quux >expect &&
 
 	test_cmp expect actual &&
-	case "$GIT_DEFAULT_REF_FORMAT" in
+	case "$GIT_DEFAULT_REF_STORAGE" in
 	files)
 		assert_jumps 1 perf;;
 	reftable)
 		assert_jumps 2 perf;;
 	*)
-		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+		BUG "unhandled ref format $GIT_DEFAULT_REF_STORAGE";;
 	esac
 '
 
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index 20545d9db8..e8285548ca 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -12,7 +12,7 @@ test_description='Test reference backend URIs'
 #   <uri> is the new URI to be set for the ref storage.
 #   <cmd> is the git subcommand to be run in the repository.
 #   <via> if 'config', set the backend via the 'extensions.refStorage' config.
-#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
+#         if 'env', set the backend via the 'GIT_REF_STORAGE' env.
 run_with_uri () {
 	repo=$1 &&
 	backend=$2 &&
@@ -23,7 +23,7 @@ run_with_uri () {
 	git -C "$repo" config set core.repositoryformatversion 1 &&
 	if test "$via" = "env"
 	then
-		test_env GIT_REFERENCE_BACKEND="$uri" git -C "$repo" $cmd
+		test_env GIT_REF_STORAGE="$uri" git -C "$repo" $cmd
 	elif test "$via" = "config"
 	then
 		git -C "$repo" config set extensions.refStorage "$uri" &&
@@ -40,7 +40,7 @@ run_with_uri () {
 #   <backend> is the original ref storage of the repo.
 #   <uri> is the new URI to be set for the ref storage.
 #   <via> if 'config', set the backend via the 'extensions.refStorage' config.
-#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
+#         if 'env', set the backend via the 'GIT_REF_STORAGE' env.
 #   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
 test_refs_backend () {
 	repo=$1 &&
@@ -54,7 +54,7 @@ test_refs_backend () {
 	then
 		if test "$via" = "env"
 		then
-			test_env GIT_REFERENCE_BACKEND="$uri" test_must_fail git -C "$repo" refs list 2>err
+			test_env GIT_REF_STORAGE="$uri" test_must_fail git -C "$repo" refs list 2>err
 		elif test "$via" = "config"
 		then
 			git -C "$repo" config set extensions.refStorage "$uri" &&
@@ -83,7 +83,7 @@ verify_files_exist () {
 	test_cmp expect $gitdir/HEAD
 
 	# verify that backend specific files exist.
-	case "$GIT_DEFAULT_REF_FORMAT" in
+	case "$GIT_DEFAULT_REF_STORAGE" in
 	files)
 		test_path_is_dir $refdir/refs/heads &&
 		test_path_is_file $refdir/HEAD;;
@@ -91,7 +91,7 @@ verify_files_exist () {
 		test_path_is_dir $refdir/reftable &&
 		test_path_is_file $refdir/reftable/tables.list;;
 	*)
-		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+		BUG "unhandled ref format $GIT_DEFAULT_REF_STORAGE";;
 	esac
 }
 
@@ -210,7 +210,7 @@ do
 	test_expect_success "migrating repository to $to_format with alternate refs directory" '
 		test_when_finished "rm -rf repo refdir" &&
 		mkdir refdir &&
-		GIT_REFERENCE_BACKEND="${from_format}://$(pwd)/refdir" git init repo &&
+		GIT_REF_STORAGE="${from_format}://$(pwd)/refdir" git init repo &&
 		(
 			cd repo &&
 
@@ -235,7 +235,7 @@ test_expect_success 'initializing repository with alt ref directory' '
 	test_when_finished "rm -rf repo refdir" &&
 	mkdir refdir &&
 	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
-	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
+	GIT_REF_STORAGE=$BACKEND git init repo &&
 	verify_files_exist repo/.git refdir &&
 	(
 		cd repo &&
@@ -264,7 +264,7 @@ test_expect_success 'cloning repository with alt ref directory' '
 	test_commit -C source 3 &&
 
 	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
-	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
+	GIT_REF_STORAGE=$BACKEND git clone source repo &&
 
 	git -C repo config get extensions.refstorage >actual &&
 	echo $BACKEND >expect &&
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index 4d03b71243..50bcde2544 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -12,7 +12,7 @@ test_ref_format () {
 
 for OTHER_FORMAT in files reftable
 do
-	if test "$OTHER_FORMAT" = "$GIT_DEFAULT_REF_FORMAT"
+	if test "$OTHER_FORMAT" = "$GIT_DEFAULT_REF_STORAGE"
 	then
 		continue
 	fi
@@ -43,7 +43,7 @@ test_expect_success 'add submodules with different ref storage format' '
 	git init submodule &&
 	test_commit -C submodule submodule-initial &&
 	git init upstream &&
-	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format upstream "$GIT_DEFAULT_REF_STORAGE" &&
 	git -C upstream submodule add --ref-storage="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
 	test_ref_format upstream/submodule "$OTHER_FORMAT"
 '
@@ -59,8 +59,8 @@ test_expect_success 'recursive clone propagates ref storage format' '
 
 	# The upstream repository and its submodule should be using the default
 	# ref format.
-	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
-	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format upstream "$GIT_DEFAULT_REF_STORAGE" &&
+	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_STORAGE" &&
 
 	# The cloned repositories should use the other ref format that we have
 	# specified via `--ref-storage`. The option should propagate to cloned
@@ -81,7 +81,7 @@ test_expect_success 'clone submodules with different ref storage format' '
 	git -C upstream commit -m "upstream submodule" &&
 
 	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
-	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format downstream "$GIT_DEFAULT_REF_STORAGE" &&
 	git -C downstream submodule update --init --ref-storage=$OTHER_FORMAT &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT"
 '
@@ -98,7 +98,7 @@ test_expect_success 'status with mixed submodule ref storages' '
 
 	# The main repository should use the default ref format now, whereas
 	# the submodule should use the other format.
-	test_ref_format main "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format main "$GIT_DEFAULT_REF_STORAGE" &&
 	test_ref_format main/submodule "$OTHER_FORMAT" &&
 
 	cat >expect <<-EOF &&
@@ -123,7 +123,7 @@ test_expect_success 'recursive pull with mixed formats' '
 	# submodules have different formats.
 	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
 	git -C downstream submodule update --init --ref-storage=$OTHER_FORMAT &&
-	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format downstream "$GIT_DEFAULT_REF_STORAGE" &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT" &&
 
 	# Update the upstream submodule as well as the owning repository such
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1f0505e412..3a8b5ef167 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -575,8 +575,8 @@ export EDITOR
 GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
 GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
 export GIT_DEFAULT_HASH
-GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
-export GIT_DEFAULT_REF_FORMAT
+GIT_DEFAULT_REF_STORAGE="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
+export GIT_DEFAULT_REF_STORAGE
 
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
 GIT_TRACE_BARE=1
@@ -1752,13 +1752,13 @@ parisc* | hppa*)
 	;;
 esac
 
-case "$GIT_DEFAULT_REF_FORMAT" in
+case "$GIT_DEFAULT_REF_STORAGE" in
 files)
 	test_set_prereq REFFILES;;
 reftable)
 	test_set_prereq REFTABLE;;
 *)
-	echo 2>&1 "error: unknown ref format $GIT_DEFAULT_REF_FORMAT"
+	echo 2>&1 "error: unknown ref format $GIT_DEFAULT_REF_STORAGE"
 	exit 1
 	;;
 esac

-- 
2.55.0.1007.g17ff1f9808.dirty

