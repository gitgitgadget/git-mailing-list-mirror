Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4D472F7A
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518204; cv=none; b=FcAkH4YFeg7kXqewJXuQxuEP1Wf+HvU92BVO4D2oDGUIlXS4hebQS6GrCpVXLs6BEhHWcPgXADgtsUv/z58LUzRf+MmvMrVnWz1A+yMOd1sDzPWds7yhtgxQ8eqYCAYRar7qcwFX70kXPI78tN8lNMws475eC20d80GBQhuokOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518204; c=relaxed/simple;
	bh=YcY/UC5eQ5/qCx1r1lMVyZO42h9YSQTmBydqevDoJGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eRtol9o7Pv0RPskg5azf3ZTih8lP69ekI6wbb2C3GKx4XOD74PB/0axy+iVujLo8hZVfzfJs5sg3IOt7qGF71rLCNXaEhYcFVX07PbKxdeQoMu/5ez4TeLLuBSw2Jp5gbZo3bZBi7ImTJa+uVmDnpwQwTtPOtoFQOXtVXLMZJq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VoiMjqVm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iny6rUll; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VoiMjqVm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iny6rUll"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D412B7A0121;
	Fri,  4 Sep 2026 06:36:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 06:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518201;
	 x=1788604601; bh=GsIBVOeUsFnZYpOM+sMFygcIvr5eWwJGWzRfCL23tJw=; b=
	VoiMjqVmh+1Hg05OxvBfhQPOZaxCfXiLpxA23+BJrayEoHpKe1vNypx6QLEejOAj
	g3VJXHXAMAQISigi5Ycdp5nmZVgNnPb1YMjFlYmfP7L09Hm+BPAfaTG6vQvwpogB
	2cqgHEIVeeh3NHDLF2cLvForkEuBfBnrpbsHw4a1iZuLWQoXerPYBVcpMT/teos/
	7QyTto/rXyDNcbezZe4pOdJ6xot8dSXS5GIGlW6DetndYjis7IcrbyFYgPj0MLEm
	yMCzIzHDBvDavtNekj3/UjKfF6JW217vVWFQ2KWlD4jURHKo/B6hkp1s1fZUwb/j
	7uZbeyGlF1RZX54GqILnHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518201; x=
	1788604601; bh=GsIBVOeUsFnZYpOM+sMFygcIvr5eWwJGWzRfCL23tJw=; b=I
	ny6rUll5LErOJ4TCCaUmCavozlsaqnaZgsHP+jnwkK09qoaPzbLiP/sh68EzoptW
	R8jHu4iz+5W6aST6T6+nqnCV+lHoVpGuBJ7pX4Y/afpA8B7dFX1exAAKSiZ+K3Sc
	bMFdQTFGA4DYZzqqKTpaZwEewYE2AAD5n8WQRdx4FbuXsvowCz81zEYg6i5dfKts
	oNITuQEBzSKPw3+7MOTsXH+ZhKr0B1borewwuxOeooK82hpuNGFxdMfJJCU+X9jr
	+sceWOQjEY3hPb8w7uoDtRONBwIvbF458iwPqWTcAB1QEw6uw2prSqg8R/pb9cp6
	dtYe+5VWabFjNniAFg6JQ==
X-ME-Sender: <xms:OZ-aatfKIGlk-4CXXHx2-d7F5JdBkC-nZbVVy4_ewdfId4qdSd6FrA>
    <xme:OZ-aahMn-4HHH8icMQbpwxMINmXUf0YflvWb1_8lwjKN7aXBSoLjUFxPKLjYZn2sS
    yWxhiH2eHY5o74mDZEJbQPg8Yt9-IFmc7U8hHieXfWra5nFhk3golo>
X-ME-Received: <xmr:OZ-aakKr17Djw0NJufGEvDhLbkkWgn6RtLvGJW7sEo4ovXEjZ2h9fwC6T6Y6AOJSDR7b9Q>
X-ME-Proxy-Cause: dmFkZTElBvVE6E5RNyDOXHnK2tbZa/mM28PH2HbCaSAgpB78c1GLA7C/P1/2DKwXqgqWjF
    iP69FDnnoqzNzOTaOXEfIMrk+AkOMCCReVH7eSyIA7NG3ldKX6iFnGFfHTvY9eSyaIi61x
    Cn0jvycE2KOFF7DS7MhENVb3qqRk6FL5x0TGVhmg1yqL439kJwLMwvwM5QLyiRdVIoJBEs
    Hj6h+4Cz+Aalivrc2tTVfRTn8PQkYLgXBi9t5TEiOA6bN0QEEGE2g6l/okGEl4OfXNujSh
    Z+GIqKPnvkfvfg0HdKj1CmAkAnuQcFltCQeINqobqkRKId/ntUQ0eOxU6X+Wt0WwvuP5i+
    DDzZhtMqUvWi2E9Gx39vy3lvWSYkAhBdj6vW7otEOSnpP53Tjpg/ey0iJlvt402bOsPnJ2
    Z4/IoSRzxONO536ARIbHVeZ+7VWf9Fne9EKdp7DJccJeKCbWbX7AhqcrwhalbRXh2/Uyu/
    pdzpcrT/87T8PYyslQuD/82+VPFRk3gmKzVeH4TC9V5agkxr1cXMygbBSNBs5gVtqwjBtl
    pXQwPBiRIAs5Dl/CqfDXbHAPT4+Kr9Q3hqHclEh7uhYYoOJog4ZooVVt+gxq5R3SB71ccP
    1+mxCD3GQ1WCrH9SVnsOJQOvUv4Pq+6U3UdFiS4HYoD/8wXyqQDVr4+D2G1g
X-ME-Proxy: <xmx:OZ-aaiGAY1QR9NrmDzHeoaAVWMCmW0-4ZZ3c2TbYgit0QyEzn2EZoA>
    <xmx:OZ-aasSxrfnOlqrtSX83r22TzSjpfQLXb6xSJDJDtXQ6K8i3bvpzJA>
    <xmx:OZ-aauGz8tIqCnRF1IfrVa7Rc4mPMhSyvvHE7EuRILfvcxx_WXch9w>
    <xmx:OZ-aao9v86tcJSf8eA95agFo171_NvUuPS7abjZxvTwLm2eJuf83Xg>
    <xmx:OZ-aakNbNk6QSCks5XNsw61FFlKhvo-KlpAczKMrZOXfyPift0Id2frO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f18632fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:12 +0200
Subject: [PATCH 11/11] setup: allow "git init --ref-storage=" to specify a
 payload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-11-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Reference storage backends can be configured with a payload via the
"extensions.refStorage" config key and the "GIT_REF_STORAGE" environment
variable, both of which accept a URI in the format
"<format>://<payload>". The payload may contain backend-specific
information, for example an alternate refs directory or which database
references should be stored in.

The `--ref-storage=` option of git-init(1) and git-clone(1) does not
know about payloads though: its value is parsed as a plain format name,
so backends that require a payload cannot be conveniently set up at
initialization time via the command line.

Teach the option to accept the same URI syntax. Also, document the
optional payloads for both the "files" and "reftable" backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-init.adoc           |  5 ++++-
 Documentation/ref-storage-format.adoc |  8 ++++++--
 builtin/clone.c                       |  4 ++--
 builtin/init-db.c                     |  9 +--------
 setup.c                               | 14 +++++++++-----
 setup.h                               |  2 +-
 t/t0001-init.sh                       |  2 +-
 t/t1423-ref-backend.sh                | 30 ++++++++++++++++++++++++++++++
 8 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
index 54cff89dfe..182fc7c203 100644
--- a/Documentation/git-init.adoc
+++ b/Documentation/git-init.adoc
@@ -58,7 +58,10 @@ values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
 include::object-format-disclaimer.adoc[]
 
 `--ref-storage=<format>`::
-Specify the given ref storage _<format>_ for the repository. The valid values are:
+Specify the given ref storage _<format>_ for the repository. Backends that
+require additional configuration accept a payload in the form
+`<format>://<payload>`, for example a connection string identifying the
+database that shall store the references. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
diff --git a/Documentation/ref-storage-format.adoc b/Documentation/ref-storage-format.adoc
index c5e29ec831..21d62557b7 100644
--- a/Documentation/ref-storage-format.adoc
+++ b/Documentation/ref-storage-format.adoc
@@ -1,8 +1,12 @@
-`files`;; for loose files with packed-refs.
+`files[://<path>]`;; for loose files with packed-refs. The optional payload can
+be specified to change the root directory where references are created. A
+relative path will be resolved relative to the repository's common directory.
 ifndef::with-breaking-changes[]
 	This is the default.
 endif::with-breaking-changes[]
-`reftable`;; for the reftable format.
+`reftable[://<path>]`;; for the reftable format. The optional payload can
+be specified to change the root directory where references are created. A
+relative path will be resolved relative to the repository's common directory.
 ifdef::with-breaking-changes[]
 	This is the default.
 endif::with-breaking-changes[]
diff --git a/builtin/clone.c b/builtin/clone.c
index c4f9dc7472..ce54088c51 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1030,7 +1030,7 @@ int cmd_clone(int argc,
 		option_single_branch = deepen ? 1 : 0;
 
 	if (ref_storage) {
-		ref_storage_format = ref_storage_format_by_name(ref_storage);
+		ref_storage_format = ref_storage_format_by_uri(ref_storage, NULL);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), ref_storage);
 	}
@@ -1188,7 +1188,7 @@ int cmd_clone(int argc,
 	 * their on-disk data structures.
 	 */
 	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
-		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
+		GIT_HASH_UNKNOWN, ref_storage, NULL,
 		do_not_override_repo_unix_permissions,
 		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 763ee47d21..e30da2936a 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -86,7 +86,6 @@ int cmd_init_db(int argc,
 	const char *ref_storage = NULL;
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
-	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
 	int init_shared_repository = -1;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
@@ -175,12 +174,6 @@ int cmd_init_db(int argc,
 			die(_("unknown hash algorithm '%s'"), object_format);
 	}
 
-	if (ref_storage) {
-		ref_storage_format = ref_storage_format_by_name(ref_storage);
-		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), ref_storage);
-	}
-
 	if (init_shared_repository != -1)
 		repo_settings_set_shared_repository(the_repository, init_shared_repository);
 
@@ -251,7 +244,7 @@ int cmd_init_db(int argc,
 
 	flags |= INIT_DB_EXIST_OK;
 	ret = init_db(the_repository, git_dir, real_git_dir, work_tree,
-		      template_dir, hash_algo, ref_storage_format, initial_branch,
+		      template_dir, hash_algo, ref_storage, initial_branch,
 		      init_shared_repository, flags);
 
 	free(template_dir_to_free);
diff --git a/setup.c b/setup.c
index b81d4f134a..20a2fbb292 100644
--- a/setup.c
+++ b/setup.c
@@ -2727,7 +2727,7 @@ static int read_default_format_config(const char *key, const char *value,
 }
 
 static void repository_format_configure(struct repository_format *repo_fmt,
-					int hash, enum ref_storage_format ref_storage_format)
+					int hash, const char *ref_storage_uri)
 {
 	struct default_format_config cfg = {
 		.hash = GIT_HASH_UNKNOWN,
@@ -2738,6 +2738,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		.ignore_repo = 1,
 		.ignore_worktree = 1,
 	};
+	enum ref_storage_format ref_storage_format;
 	char *ref_storage_payload = NULL;
 	const char *env;
 
@@ -2788,8 +2789,11 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 *   6. Otherwise, we fall back to the default ref storage format
 	 *      compiled into Git.
 	 */
-	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
-		/* nothing to do */
+	if (ref_storage_uri) {
+		ref_storage_format = ref_storage_format_by_uri(ref_storage_uri, &ref_storage_payload);
+		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown reference storage format specified via command line: '%s'"),
+			    ref_storage_uri);
 	} else if (((env = getenv(GIT_REF_STORAGE_ENVIRONMENT)) ||
 		    (env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT)))) {
 		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
@@ -2834,7 +2838,7 @@ int init_db(struct repository *repo,
 	    const char *real_git_dir,
 	    const char *worktree,
 	    const char *template_dir, int hash,
-	    enum ref_storage_format ref_storage_format,
+	    const char *ref_storage_uri,
 	    const char *initial_branch,
 	    int init_shared_repository, unsigned int flags)
 {
@@ -2871,7 +2875,7 @@ int init_db(struct repository *repo,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
-	repository_format_configure(&repo_fmt, hash, ref_storage_format);
+	repository_format_configure(&repo_fmt, hash, ref_storage_uri);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 
diff --git a/setup.h b/setup.h
index 763fd384e8..79e0640743 100644
--- a/setup.h
+++ b/setup.h
@@ -265,7 +265,7 @@ int init_db(struct repository *repo,
 	    const char *real_git_dir,
 	    const char *worktree,
 	    const char *template_dir, int hash_algo,
-	    enum ref_storage_format ref_storage_format,
+	    const char *ref_storage_uri,
 	    const char *initial_branch, int init_shared_repository,
 	    unsigned int flags);
 void initialize_repository_version(struct repository *repo,
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index b481d763ff..7cdebc8ff3 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -833,7 +833,7 @@ done
 test_expect_success 'init with --ref-storage=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
-	fatal: unknown ref storage format ${SQ}garbage${SQ}
+	fatal: unknown reference storage format specified via command line: ${SQ}garbage${SQ}
 	EOF
 	test_must_fail git init --ref-storage=garbage refformat 2>err &&
 	test_cmp expect err
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index e8285548ca..dc43e1c438 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -254,6 +254,36 @@ test_expect_success 'initializing repository with alt ref directory' '
 	)
 '
 
+test_expect_success 'initializing repository with --ref-storage and payload' '
+	test_when_finished "rm -rf repo refdir" &&
+	mkdir refdir &&
+	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
+	git init --ref-storage="$BACKEND" repo &&
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
+	git -C repo init --ref-storage="$BACKEND" &&
+	# Reinitializing without a payload should fail.
+	test_must_fail git -C repo init --ref-storage="$(test_detect_ref_format)" 2>err &&
+	test_grep "attempt to reinitialize repository with different reference storage payload" err &&
+	# Reinitializing with a different payload should fail, too.
+	test_must_fail git -C repo init --ref-storage="$(test_detect_ref_format)://$(pwd)/other" 2>err &&
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
2.55.0.1007.g17ff1f9808.dirty

