Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37B47ECC8
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667160; cv=none; b=augJCK3DnQqqemF9nORfRmFvPLReOtx1O/4FQu497ikjAZ82Gr57aBgS3DKMNOnSkrmIZiK9hqHVwG9pKlc0HGyqsFndurN1+KQNbP+ZqrEtfiTk02VNSYkd/3gtJSG2ye+TyeLm6xYqDA4mpNdLx7BQYctSQkSVBcdw7nLjBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667160; c=relaxed/simple;
	bh=a0TyAw9K+oLMAvhHsoPp+S/+13G14AB1vNqDo4c8n+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/fdeiCeoR0gcv+Y8a7ECpdJoASieW2k4lmuI7qdO/OxOrI1KjuWAvva5TFVf6Y4tXXrkvcwhGGZsoARMfCc/w+CP3EmtzT5TxHyDpHGcqpjHCiV83+leK32Bc7CzfS1kU0hxYsy7PJYWeqiLQMXq2IbFeaqofWdGAJqggni7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oelwdu6T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J8wpcHlr; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oelwdu6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J8wpcHlr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F75B1D00046
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 25 Aug 2026 10:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787667157;
	 x=1787753557; bh=kCbUGioEPb6XirPP9ypvzfBLuStR+zTOlYr4AVKAIvo=; b=
	oelwdu6TR+oE5nN87zIbvQIgfEF36CGnjn6i3/ESn6IughglZLmzWUvfRNmBCBhD
	udU7oCaTkA7OkhnRQwYr9lHOULRepdLiVTssEFjhINO5MWhQebVtYHuQ2yAQL9yw
	jN0C5beyfynGhJS9fs7U/fNrbyrpt/+6DrjhsZN2mLoeU4vcr+203iq1nXuyqmIv
	Bfvi0EE6FsIrhM46dnySJ6Yb2vQL5b6hyra294chL2JGJvrjdCT3WfBZgJO2V8hU
	EHVRJcLKT6OlbbNQXf9G8M/2KqZHqSEcXonFgMkG9Ybv6vDmsA7657Ljj0yM9fkH
	Xzwk6aBdpfgCQr7ZiBhpYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787667157; x=
	1787753557; bh=kCbUGioEPb6XirPP9ypvzfBLuStR+zTOlYr4AVKAIvo=; b=J
	8wpcHlrBY/SCu4j4SLIL5W6hKir7sCwv3V0gmmMiq8QxjzxsztEsLlgpcHX4uX4b
	0ZlfkKbcsmjtJPhwvdFlsvC7P/HDgMFe1osBLpo1Xo+XIf9qORmfeJAEwZV8uoeX
	/m/c/Vf6oBhj9yQ3IhdCuW2NkuUj7hZsgHaH1aDb4R0sZW0ZeYSefvTTMhsunUfM
	N0FGHhxROnD5LT9a76G0rPPque0CHzhXoYl69/1/pKW+laUKWHRIppys4/Wz9CbU
	nXbjNlElwtwiqPCNzb5eahZiSf2h80nosHSHl5zzR3K5oca9G+XC5flC9tfNOQap
	pqR/PW5f+zYDeVkiGdCEg==
X-ME-Sender: <xms:1aKNaqOp91OQLVdNu09u2w7ZxypLdLWbzx_7Z37aiNyYLXPMXkINDQ>
    <xme:1aKNav7Av6Xrq3_3GKx-RfdaOt0eBPmv2_7x1kLWu9qNGaCX5gs9JvlHdesf1WW0A
    CYuM1elEJ3mGUPFuEeJZnrGKkFqCzdjHAp7DGgC82LCIec2UPEsAKU>
X-ME-Received: <xmr:1aKNam7LU4SHRSsmxnwI2znb1heLnBo8KzePuzQpN6smocxqF0z6UuUeXEXu-7PBCbzf1MSnt8EtjN11c794Y-Iayv6vdQHgUOn-yiidZg>
X-ME-Proxy-Cause: dmFkZTEsXi3aaEhf5NN082pEBCN2IoLit4x4y55COggZ/ldf/Z6KlO3Y+c+xvlMhdzJL9F
    6K5RIkbCT4SQvHLC+gmdx9M8UiE2B6ZxkBKRd0z9oiUi188IUTeKgQ9Z5Rs+RN8yxQU9Qc
    lAKP1FIOQ6GKDPUMxsTD0RwTelpsL8gg5ZKJU0FroW0wfvl7TREjmrracHWBxsuhDw65F7
    fBi4NNfkKdVTwfZEVgSySH5Vs83taVEpd8c3WR5hK+EhZf7PeOLWMTljD1i8QOyRvmnDAm
    q5V8c1wIZXv4PO0Dw/qqtThLyYTCv1b/OPkAyR8Sh0H9xhriwPEWmQ7ZQ6K6O2jxqHM1Q3
    vws8xbUS7vKLQAVjT6ifs2xtuMgyp9yKsGEUZC4PDTEJLr6tuUw3yI6eogxgb9xLrcDKoC
    7Xx+GX+e6uh9xdeHAmoz7IgVV+Kl4K+J0P6mPJL+6S3EH6I+YDWNuVVCKbrEmuQkCnhWSE
    IYK8BfS7H5BMGoqIo9uVWcoPnVYFTujKu9FyL+flygCdPJFtSx2K431N7U7RU9sT3aPUbG
    bHveK+YbwpqvuoCgKLD1Jr99e1oJo5nNOmHKs/DV4qv1p+JfXx4HVIK5YfBs5DI0ITw61k
    arjmRWnvu+3Wn3owalNV0EhGe2br7LurmFDMI2BYcLbznDXOHxCpWBoBwgBA
X-ME-Proxy: <xmx:1aKNav3yT_YUzsq_T9nr0IE7ByO0GKzM7CHWXyAJQQOq_usWSJpjbg>
    <xmx:1aKNaiW5urx7_7-BdJB6TzeEzu_m1qxygGgEAyCITRUBfbRRJ6O4MA>
    <xmx:1aKNaq7_nqOZctnB3_szbHuBZf8oV-Ze6HGiEFLAT3KvHOrXZlUoDQ>
    <xmx:1aKNapI60CuIkp6DB16fB9S_B82-TdNk8Wz_nqPC1pOKLinky-RxZQ>
    <xmx:1aKNaq_7yoa9u880lRqn0myUEQ9mkHrTgIjZArwODvz0ovRyYipdRDMI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a9256a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:12:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:11:50 +0200
Subject: [PATCH 1/8] builtin/clone: defer setup of the object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-write-alternates-at-creation-time-v1-1-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When cloning a repository we defer initialization of the reference
database. This is because we don't yet know all details required for us
to initialize the refdb in the first place. Most importantly, what we
are missing is information about the object hash.

We don't do the same thing for the object database yet, but here we
essentially have the same problem. While the "files" database does not
need any information about the object format at creation time, alternate
backends are likely to require that information so that they can
properly set up their data structures.

Besides this forward-looking future proofing though, we also have a
second use case for deferring initialization of the object database,
namely alternates. When initializing the object database we do not yet
know whether we'll need alternates or not because this depends on the
repository we're about to clone from. If it is a local repository and
the user has passed "--refernce{,-if-able}", then we will end up writing
alternates into the object database.

The ugly part though is that we cannot determine where the repository is
getting cloned from before it has been initialized. While we of course
already have access to the user-provided URI, that URI can be very well
rewritten via "url.<base>.insteadOf". We can of course read the global-
and system-level configuration to resolve it. But we explicitly resolve
the URI a second time after we have initialized the repository because
it can happen that we copy a ".git/config" over from our templates, and
that file may cause us to rewrite the path.

In a subsequent commit though we'll start to write alternates as part of
the repository initialization, so we'll need to have the URI properly
resolved before we can initialize the object database. This is ugly, but
as mentioned above it makes sense for us to defer its initialization
anyway so that we also know about the object hash already.

Introduce a new flag that makes `init_db()` skip initializing the object
database. Expose `create_object_database()` and make use of it after we
have resolved the URI.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 12 ++++++++----
 setup.c         |  8 +++++---
 setup.h         | 15 ++++++++++-----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5b25cca510..0a67492ebd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1184,11 +1184,14 @@ int cmd_clone(int argc,
 	 * database. We do not yet know about the object format of the
 	 * repository, and reference backends may persist that information into
 	 * their on-disk data structures.
+	 *
+	 * Furthermore, we skip initializing the object database so that we can
+	 * first resolve potential alternates before creating it.
 	 */
 	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
 		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
 		do_not_override_repo_unix_permissions,
-		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
+		INIT_DB_QUIET | INIT_DB_SKIP_REFDB | INIT_DB_SKIP_ODB);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1311,9 +1314,6 @@ int cmd_clone(int argc,
 		strbuf_reset(&key);
 	}
 
-	if (option_required_reference.nr || option_optional_reference.nr)
-		setup_reference();
-
 	remote = remote_get_early(remote_name);
 
 	if (!option_rev)
@@ -1342,6 +1342,10 @@ int cmd_clone(int argc,
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
+	create_object_database(the_repository);
+	if (option_required_reference.nr || option_optional_reference.nr)
+		setup_reference();
+
 	transport = transport_get(remote, path ? path : remote->url.v[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;
diff --git a/setup.c b/setup.c
index d90654f584..e654e27d05 100644
--- a/setup.c
+++ b/setup.c
@@ -2647,7 +2647,7 @@ static int create_default_files(struct repository *repo,
 	return reinit;
 }
 
-static void create_object_database(struct repository *repo)
+void create_object_database(struct repository *repo)
 {
 	/*
 	 * Create the "objects" directory in the common directory. This is done
@@ -2829,7 +2829,8 @@ int init_db(struct repository *repo,
 	    const char *template_dir, int hash,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch,
-	    int init_shared_repository, unsigned int flags)
+	    int init_shared_repository,
+	    enum init_db_flags flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -2903,7 +2904,8 @@ int init_db(struct repository *repo,
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
-	create_object_database(repo);
+	if (!(flags & INIT_DB_SKIP_ODB))
+		create_object_database(repo);
 
 	startup_info->have_repository = 1;
 
diff --git a/setup.h b/setup.h
index 763fd384e8..570ebcd150 100644
--- a/setup.h
+++ b/setup.h
@@ -256,9 +256,12 @@ int apply_repository_format(struct repository *repo,
 
 const char *get_template_dir(const char *option_template);
 
-#define INIT_DB_QUIET      (1 << 0)
-#define INIT_DB_EXIST_OK   (1 << 1)
-#define INIT_DB_SKIP_REFDB (1 << 2)
+enum init_db_flags {
+	INIT_DB_QUIET = (1 << 0),
+	INIT_DB_EXIST_OK = (1 << 1),
+	INIT_DB_SKIP_REFDB = (1 << 2),
+	INIT_DB_SKIP_ODB = (1 << 3),
+};
 
 int init_db(struct repository *repo,
 	    const char *git_dir,
@@ -266,13 +269,15 @@ int init_db(struct repository *repo,
 	    const char *worktree,
 	    const char *template_dir, int hash_algo,
 	    enum ref_storage_format ref_storage_format,
-	    const char *initial_branch, int init_shared_repository,
-	    unsigned int flags);
+	    const char *initial_branch,
+	    int init_shared_repository,
+	    enum init_db_flags flags);
 void initialize_repository_version(struct repository *repo,
 				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
 void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
+void create_object_database(struct repository *repo);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.55.0.822.g20453c30eb.dirty

