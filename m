Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA753D0D6
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952417; cv=none; b=jt0POZotJYAF46+bLbdSDrcL99izDlNr8+lNeQ2ln/b7CNTMQUdB/URY8K328P5EsBuYSOmLi7GepjRDP+9tADlqoJmNmp8Q8rar1ko2mGY3k/3J7nHXJ4dLHt52EC4JxIyPzVM68nPyVcuBpinGjaloVY0hCbJ+MN42rbPsSvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952417; c=relaxed/simple;
	bh=wEjrNvmAAu+NdDHRPJHpzagcsIQilBbZbKnZTim8WhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKaugg6k3vG4twTtgGUsHyanl5WkFBQLNyeuE0RrQV1YZI9q1P8KJbjChIvOw5yWGsAw16x9m1rElfq63A/fSRlVuI9bVGZgAhtbeL9boMxSawK1SyXdDrOdKWtikrSAbjFwnr7y3JZLglH6kxdhCJDri9/6I/bCWyDl6p+Tr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N1LS+QLt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovJulRC3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N1LS+QLt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovJulRC3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1384E14000A4;
	Wed,  9 Sep 2026 07:13:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 07:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952409;
	 x=1789038809; bh=DzyfI1gr6pgLHBnah2moU5mFBEnryjIuTCVSH2kL/jk=; b=
	N1LS+QLtZi+posYnA3/000DJYqP7KD6S7cmr6ZF7fiZqxYTJ5oKfogaZN9dH8c63
	eCRWI0pC/d9AGnbOUUgyJ4mWNsN/aPp712yX9aiVC3TakcURwYarx2W///veZOw6
	7xi+PPLdDAggUHx7GlACRBjAcOInNuJZMzvxu5BxyOtKIYLN94rydxAGxRQI8R02
	ssbpP7T1rojR/rlFg0Oupuag2pgAFhbp1F7fnOyP4nIlf/2frSaHNMGCKb9nuiIa
	3y0yo67hp+WQ7xsTX7BDUf2vQBmJRkBkdyqjMNBCMcnhjk26GfuZiBsQdYT7KXFb
	U34xdEzda1nOrDOuwWY2Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952409; x=
	1789038809; bh=DzyfI1gr6pgLHBnah2moU5mFBEnryjIuTCVSH2kL/jk=; b=o
	vJulRC38u6bJVp2V6qKVUbvomjl8PtLT/oia43vzzqJ/jfdRECxIgK+D4bK87YoO
	n22weTXYdu6KfQU357i+NqSImbeuAgJ+I66g3o8sy8OpYFdvh+dF2ZKNvA5zJNwx
	+OtVdYT4WuWHE+9x5EmtsOnA60ChprFavl1gbxMlDLIT5Mf1ay9dHaCH0KCdDQ55
	QCWSQbl55juOPtI10RmdOFtlns/ULY8S9QjN/YdN6p7mtELfrMPwPHBeqG5Vc4+T
	GzoxDAI2a0j7KmFDUqzV+LRyKAK6X3u17f/SM4f2pJ7Hi8dvZBXTbwu2rj90I89I
	jBNY4i9nBppWHIHLq/z+g==
X-ME-Sender: <xms:WT-hatcABsfwO9OstgjDck7MAeJ2BD-9sJPcOlC5a4zlEuMu7xQBsw>
    <xme:WT-haiNGsr20Ds7-BF3it2V-SRV6qGkeIZQvgc1v5BRDWXY16tqNfPd7hLz4xFxCa
    JYbB4AWEaOG8jxluNBzjnePPlhROjCUKuNT_5X5x-61owrinIslBkM>
X-ME-Received: <xmr:WT-harhcGWAr4WqmtJkqyEGJxywfEwJMV6ns9TOm5caaTZVWgQ1jZGZytPHbJUVTwioTzA>
X-ME-Proxy-Cause: dmFkZTFUHPGE3g7CIZBJNRpjwmhMD50iHqRsXgA7aUAoP8pvVMHS5HojomQnG6iOkJ72Lf
    AHe9MjN+g1UL48JlUqa9GeBcaAEW6YSygOrnCBYdSu2tRRudXTHHcVrZS++GVATDknM1Uw
    Gc9TxXpQW2acUr1ffLP3t+SgWL6UqkFNh3rwHrAxjBEWVuQdkSXzX6qiYTyzmuB4Nk6TYm
    vUkapYZ84YrPF3w5KouO9f2z4ukrXYHfOPsVUyhj9mtwMTsmPrkh4/ypSwau54kb9gRLYV
    tKI8JRcRb4HDUA100IOVvHPuybZ0JM6/KH6JEUdfnwk3t+tGvZU0h8OfVU2wYmu+UM0OMz
    suNSMzA+MGvMwa8l2svYnkTR6XRGKus2AseFCXSHpw2oa4Z70aWEQ4/g2mz6JufD6TewqS
    HdroYRuSldRF18pGAuHrbmeNye5aFGHHd3mhK9BVf99yAOOPkGtTZKE5uVJASGRotYZNR1
    AKaQCkvjBu0/YiXBCXpx3atKoNqQ8oSZG+V8jTbK4Mj90pfbUqmN43Lg0UZj4s1SHLdCBc
    3JFwR8RmVx5xEvoJYWiU/FrZlFZ0XrfMZCGbNfbdN6MBJqC0tRC3pMQtO0FH3Stub1EIht
    t9KUX+qOA3XN8S9SjPSILcYU8v9ISP5GaKwqva74uUgfjVAgMtennW/0uA0Q
X-ME-Proxy: <xmx:WT-hal3Y2ZbAKMAPj86jlfchSQpU1nJYEGMIG3D-ydPpH8SCmqKE0g>
    <xmx:WT-haljjIbxAv7_msYTniU_qiS17P5supfxiS6zDzAFCOJWbjbddQQ>
    <xmx:WT-halcqZcATMNQpM52it2_fOkkXh2VrTo8W2UTxtAxUkpdKbXj_qQ>
    <xmx:WT-haolEPNGjav1LWZZiRz2uZVaqAfUhxokZnbKAdLaZpLELaRCn7A>
    <xmx:WT-havCYkpWtd_KhyyN3lxFiBuK1nt0OxC768uUvPCGeLQhDykcOMNVs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0372f4cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:59 +0200
Subject: [PATCH v3 13/13] setup: allow "--ref-storage-format=" to specify a
 payload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-13-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

Reference storage backends can be configured with a payload via the
"extensions.refStorage" config key and the "GIT_REF_STORAGE_FORMAT"
environment variable, both of which accept a URI in the format
"<format>://<payload>". The payload may contain backend-specific
information, for example an alternate refs directory or which database
references should be stored in.

The `--ref-storage-format=` option of git-init(1) and git-clone(1) does
not know about payloads though: its value is parsed as a plain format
name, so backends that require a payload cannot be conveniently set up
at initialization time via the command line.

Teach the option to accept the same URI syntax. Also, document the
optional payloads for both the "files" and "reftable" backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-clone.adoc |  5 ++++-
 Documentation/git-init.adoc  |  5 ++++-
 builtin/clone.c              | 12 ++++++------
 builtin/init-db.c            | 15 ++++-----------
 setup.c                      | 16 +++++++++++-----
 setup.h                      |  2 +-
 t/t0001-init.sh              |  2 +-
 t/t1423-ref-backend.sh       | 30 ++++++++++++++++++++++++++++++
 8 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 27e4d13942..07f7cf1a98 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -350,7 +350,10 @@ or `--mirror` is given)
 
 `--ref-storage-format=<format>`::
 
-Specify the given ref storage format for the repository. The valid values are:
+Specify the given ref storage _<format>_ for the repository. Backends that
+require additional configuration accept a payload in the form
+`<format>://<payload>`, for example a connection string identifying the
+database that shall store the references. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
index 73e1f787cb..b02af22ad1 100644
--- a/Documentation/git-init.adoc
+++ b/Documentation/git-init.adoc
@@ -58,7 +58,10 @@ values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
 include::object-format-disclaimer.adoc[]
 
 `--ref-storage-format=<format>`::
-Specify the given ref storage _<format>_ for the repository. The valid values are:
+Specify the given ref storage _<format>_ for the repository. Backends that
+require additional configuration accept a payload in the form
+`<format>://<payload>`, for example a connection string identifying the
+database that shall store the references. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
diff --git a/builtin/clone.c b/builtin/clone.c
index dd722e4de1..9812aaec8f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -901,7 +901,7 @@ int cmd_clone(int argc,
 	char *option_origin = NULL;
 	struct string_list option_not = STRING_LIST_INIT_NODUP;
 	const char *real_git_dir = NULL;
-	const char *ref_storage_format_str = NULL;
+	const char *ref_storage_format_uri = NULL;
 	const char *option_upload_pack = "git-upload-pack";
 	int option_progress = -1;
 	int option_sparse_checkout = 0;
@@ -981,7 +981,7 @@ int cmd_clone(int argc,
 			 N_("any cloned submodules will be shallow")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
-		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
 		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
@@ -1028,10 +1028,10 @@ int cmd_clone(int argc,
 	if (option_single_branch == -1)
 		option_single_branch = deepen ? 1 : 0;
 
-	if (ref_storage_format_str) {
-		ref_storage_format = ref_storage_format_by_name(ref_storage_format_str);
+	if (ref_storage_format_uri) {
+		ref_storage_format = ref_storage_format_by_uri(ref_storage_format_uri, NULL);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), ref_storage_format_str);
+			die(_("unknown ref storage format '%s'"), ref_storage_format_uri);
 	}
 
 	if (option_mirror) {
@@ -1187,7 +1187,7 @@ int cmd_clone(int argc,
 	 * their on-disk data structures.
 	 */
 	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
-		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
+		GIT_HASH_UNKNOWN, ref_storage_format_uri, NULL,
 		do_not_override_repo_unix_permissions,
 		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 1612413af0..7a65d1673b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -83,10 +83,9 @@ int cmd_init_db(int argc,
 	unsigned int flags = 0;
 	int bare = startup_info->force_bare_repository ? 1 : -1;
 	const char *object_format = NULL;
-	const char *ref_storage_format_str = NULL;
+	const char *ref_storage_format_uri = NULL;
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
-	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
 	int init_shared_repository = -1;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
@@ -109,7 +108,7 @@ int cmd_init_db(int argc,
 			   N_("override the name of the initial branch")),
 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
 			   N_("specify the hash algorithm to use")),
-		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
 		OPT_END()
@@ -174,12 +173,6 @@ int cmd_init_db(int argc,
 			die(_("unknown hash algorithm '%s'"), object_format);
 	}
 
-	if (ref_storage_format_str) {
-		ref_storage_format = ref_storage_format_by_name(ref_storage_format_str);
-		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), ref_storage_format_str);
-	}
-
 	if (init_shared_repository != -1)
 		repo_settings_set_shared_repository(the_repository, init_shared_repository);
 
@@ -250,8 +243,8 @@ int cmd_init_db(int argc,
 
 	flags |= INIT_DB_EXIST_OK;
 	ret = init_db(the_repository, git_dir, real_git_dir, work_tree,
-		      template_dir, hash_algo, ref_storage_format, initial_branch,
-		      init_shared_repository, flags);
+		      template_dir, hash_algo, ref_storage_format_uri,
+		      initial_branch, init_shared_repository, flags);
 
 	free(template_dir_to_free);
 	free(real_git_dir_to_free);
diff --git a/setup.c b/setup.c
index df8cbf196d..13f4a0aba9 100644
--- a/setup.c
+++ b/setup.c
@@ -2727,7 +2727,8 @@ static int read_default_format_config(const char *key, const char *value,
 }
 
 static void repository_format_configure(struct repository_format *repo_fmt,
-					int hash, enum ref_storage_format ref_storage_format)
+					int hash,
+					const char *ref_storage_format_uri)
 {
 	struct default_format_config cfg = {
 		.hash = GIT_HASH_UNKNOWN,
@@ -2738,6 +2739,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		.ignore_repo = 1,
 		.ignore_worktree = 1,
 	};
+	enum ref_storage_format ref_storage_format;
 	char *ref_storage_payload = NULL;
 	const char *env;
 
@@ -2791,8 +2793,12 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 *   7. Otherwise, we fall back to the default ref storage format
 	 *      compiled into Git.
 	 */
-	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
-		/* nothing to do */
+	if (ref_storage_format_uri) {
+		ref_storage_format = ref_storage_format_by_uri(ref_storage_format_uri,
+							       &ref_storage_payload);
+		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format specified via command line: '%s'"),
+			    ref_storage_format_uri);
 	} else if ((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT))) {
 		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
@@ -2845,7 +2851,7 @@ int init_db(struct repository *repo,
 	    const char *real_git_dir,
 	    const char *worktree,
 	    const char *template_dir, int hash,
-	    enum ref_storage_format ref_storage_format,
+	    const char *ref_storage_format_uri,
 	    const char *initial_branch,
 	    int init_shared_repository, unsigned int flags)
 {
@@ -2882,7 +2888,7 @@ int init_db(struct repository *repo,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
-	repository_format_configure(&repo_fmt, hash, ref_storage_format);
+	repository_format_configure(&repo_fmt, hash, ref_storage_format_uri);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 
diff --git a/setup.h b/setup.h
index 763fd384e8..f04d2984b4 100644
--- a/setup.h
+++ b/setup.h
@@ -265,7 +265,7 @@ int init_db(struct repository *repo,
 	    const char *real_git_dir,
 	    const char *worktree,
 	    const char *template_dir, int hash_algo,
-	    enum ref_storage_format ref_storage_format,
+	    const char *ref_storage_format_uri,
 	    const char *initial_branch, int init_shared_repository,
 	    unsigned int flags);
 void initialize_repository_version(struct repository *repo,
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index fe5bc3d3e1..f1d227f271 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -833,7 +833,7 @@ done
 test_expect_success 'init with --ref-storage-format=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
-	fatal: unknown ref storage format ${SQ}garbage${SQ}
+	fatal: unknown ref storage format specified via command line: ${SQ}garbage${SQ}
 	EOF
 	test_must_fail git init --ref-storage-format=garbage refformat 2>err &&
 	test_cmp expect err
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index 525b2a19b4..ee2bb66b99 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -254,6 +254,36 @@ test_expect_success 'initializing repository with alt ref directory' '
 	)
 '
 
+test_expect_success 'initializing repository with --ref-storage-format and payload' '
+	test_when_finished "rm -rf repo refdir" &&
+	mkdir refdir &&
+	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
+	git init --ref-storage-format="$BACKEND" repo &&
+	verify_files_exist repo/.git refdir &&
+
+	git -C repo config get extensions.refstorage >actual &&
+	echo $BACKEND >expect &&
+	test_cmp expect actual &&
+
+	test_commit -C repo 1 &&
+	git -C repo refs list >out &&
+	test_grep "refs/tags/1" out &&
+
+	# Reinitializing the repository is fine when not specifying any format.
+	git -C repo init &&
+	# Reinitializing with the same backend is fine, too.
+	git -C repo init --ref-storage-format="$BACKEND" &&
+	# Reinitializing without a payload should fail.
+	test_must_fail git -C repo init --ref-storage-format="$(test_detect_ref_format)" 2>err &&
+	test_grep "attempt to reinitialize repository with different reference storage payload" err &&
+	# Reinitializing with a different payload should fail, too.
+	test_must_fail git -C repo init --ref-storage-format="$(test_detect_ref_format)://$(pwd)/other" 2>err &&
+	test_grep "attempt to reinitialize repository with different reference storage payload" err &&
+
+	git -C repo config get extensions.refstorage >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cloning repository with alt ref directory' '
 	test_when_finished "rm -rf source repo refdir" &&
 	mkdir refdir &&

-- 
2.55.0.1074.ge7621b4bad.dirty

