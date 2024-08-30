Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C536016F0DF
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008997; cv=none; b=lozhcFuVX/MokETgJUBT1u6JSxHd0FdmhzN7ZPu5dTRqFpbflwReXcPrt4ngJxn/RDZdbX+WsZNPNeFkgTVBtD+CiKmpch7fTFjQ/u1+P7v40tQv5LJOWO6yfBdpg6VuG6OQplI+dNPJ4i9Dmcy7ZnMA7iO3Sy6bZFsy4VlLICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008997; c=relaxed/simple;
	bh=9pfP4dcviIUTLnfk7IWbUtC9fvIm7q+MxrO3ZCKDzwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVsrSuFaLBmfGDrYUa19nxcPPOT+aZGqdri0STaSklytXVCk0yW75AsvoJLEFCodheFBd237Q0NdPLqddzh7FHWZBH4+oyBEvT6Cz2j01mdCHrxhuYzYHNIxpTBLfEvUZ2uM1beYx6K1PdRVxz94zQUjvKXzFk+rx9QlpfproHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rtlABMMh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dY4EMz4q; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rtlABMMh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dY4EMz4q"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2CAA01380278;
	Fri, 30 Aug 2024 05:09:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 30 Aug 2024 05:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008995; x=1725095395; bh=CdZY+u5+q7
	F4CgYABKCWSrAOvKXeGRglmGfFH9B1LmM=; b=rtlABMMhqz7BGfVhwzy/jsN2lO
	TKdwJhPkWLN1hmkhLcjZIpESmvkiUI68ZrsC+1j1jccZbbFsQyjLqZzR/Ls2806E
	iogHRbzCNCe1PxnPWlRd/nS/r96obrznfTU6PkRgVeBJzvGzzvW0TGF5zxTTHKdQ
	mPEBifi+G5TzziuT7FgU7l9d/3nEY+r/y10J/jQ7K4UyEraO3zNnFx9lwKohPm2m
	ve2ULwZyLP1wc3kA0vbGLz/ZU1WBDMsN+DzB8EE9ikorgweMzhysffR1srtshHcz
	8t2jEXyZs0Ry9OkB8oj5C8P3WC3u06p72TC9gN8woOrWH9zesmptLMoJpvPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008995; x=1725095395; bh=CdZY+u5+q7F4CgYABKCWSrAOvKXe
	GRglmGfFH9B1LmM=; b=dY4EMz4qrXT7KOfzu8ohoBETwwo5WiRHICQdf9YmV9ub
	72GtUMwD1PLHaSR+NeGsX/YNcNtOG66Bur+xk0KQB3fm4oCAODUVXGXyTIcmYITt
	1D+/m+8cJ3fNaqd9rtkHcrZhlJnGHzzGPaJLp1CFSGuytDfaXLVJ5/ldFVW8WQ6P
	hU7ObaIelV1qGyJbosS56toermon/mEn5V50W0W1OWmVtmpZpJKa6PvBULT7x9qD
	4yx4+ZzHMrxjSJYtFPSE/uiy1tjcHwAPwbjGX9TvghOen8JwriexQfw61qHq8pp5
	4yMjs2aZnp+MNnWT//mN6h/0YMWCCyqWbvCgIdV7xw==
X-ME-Sender: <xms:YozRZhMEEvcfcZokqCvmfSxlYoT-drmLX6UD7pGQUOGe6mIgr0PGzQ>
    <xme:YozRZj_qzuX1k406ZwHtVe0Io1Tnk3iDGiP6E4c90vDPwGwAL9XswGuObrDYXdbFz
    hUdiXtx7kzM4YabWQ>
X-ME-Received: <xmr:YozRZgSvAktsPWF1zhMtKlHa2pIkeRUqf-g6c_Fojiw8SNI4JnUQefrRLJDmw6JX3KHt-Lalg2KCccPhuUiieMJXYMIFaUUT3KNqRlzkhms_fssqtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrlhhv
    ihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:Y4zRZtuI9W2grMQOlIsWvtb1KMSq6AoF5leDzyhsv6ajr9pG-wvocw>
    <xmx:Y4zRZpfLp7oaohFKukZ7RMOv9L3-p2rC9-sh2WEHkQgKybo-HVCAFg>
    <xmx:Y4zRZp31dVzZV4dSkGoyAxKP42Tf54pBI-LkRLmGZdc5jiv4uKn80g>
    <xmx:Y4zRZl8zPl5QUgmrg2NXFaAgwDehb_wPIkWVqvfyN-CuQHnFANP9pQ>
    <xmx:Y4zRZg4vmYqLEag8Dg0Xj-rxDrNC2jkZVxisWR2K_kynBpI763ZSbywW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 876554ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:43 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/21] environment: stop storing "core.logAllRefUpdates"
 globally
Message-ID: <b5ed6928070ca02463bf53d339aba47bbf25e86a.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

The value of "core.logAllRefUpdates" is being stored in the global
variable `log_all_ref_updates`. This design is somewhat aged nowadays,
where it is entirely possible to access multiple repositories in the
same process which all have different values for this setting. So using
a single global variable to track it is plain wrong.

Remove the global variable. Instead, we now provide a new function part
of the repo-settings subsystem that parses the value for a specific
repository. While that may require us to read the value multiple times,
we work around this by reading it once when the ref backends are set up
and caching the value there.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c      |  2 ++
 config.c                | 10 ----------
 environment.c           |  1 -
 environment.h           |  2 --
 refs/files-backend.c    |  4 +++-
 refs/reftable-backend.c | 12 +++++++-----
 repo-settings.c         | 16 ++++++++++++++++
 repo-settings.h         |  3 +++
 setup.c                 |  2 +-
 9 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6db7f39492e..7e18b87c7a4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -951,6 +951,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	const char *old_desc, *reflog_msg;
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
+			enum log_refs_config log_all_ref_updates =
+				repo_settings_get_log_all_ref_updates(the_repository);
 			char *refname;
 
 			refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
diff --git a/config.c b/config.c
index f3066c37477..47101c3e977 100644
--- a/config.c
+++ b/config.c
@@ -1452,16 +1452,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.logallrefupdates")) {
-		if (value && !strcasecmp(value, "always"))
-			log_all_ref_updates = LOG_REFS_ALWAYS;
-		else if (git_config_bool(var, value))
-			log_all_ref_updates = LOG_REFS_NORMAL;
-		else
-			log_all_ref_updates = LOG_REFS_NONE;
-		return 0;
-	}
-
 	if (!strcmp(var, "core.warnambiguousrefs")) {
 		warn_ambiguous_refs = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 64ae13ef240..992d87e0d60 100644
--- a/environment.c
+++ b/environment.c
@@ -77,7 +77,6 @@ int sparse_expect_files_outside_of_patterns;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
-enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
 int max_allowed_tree_depth =
 #ifdef _MSC_VER
 	/*
diff --git a/environment.h b/environment.h
index 0b4e5afc36d..315fd319951 100644
--- a/environment.h
+++ b/environment.h
@@ -181,8 +181,6 @@ extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
-extern enum log_refs_config log_all_ref_updates;
-
 enum rebase_setup_type {
 	AUTOREBASE_NEVER = 0,
 	AUTOREBASE_LOCAL,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f5871abcf75..a536d7d1b57 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -75,6 +75,7 @@ struct files_ref_store {
 	unsigned int store_flags;
 
 	char *gitcommondir;
+	enum log_refs_config log_all_ref_updates;
 
 	struct ref_cache *loose;
 
@@ -107,6 +108,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, refs->gitcommondir, flags);
+	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
@@ -1704,7 +1706,7 @@ static int log_ref_setup(struct files_ref_store *refs,
 			 const char *refname, int force_create,
 			 int *logfd, struct strbuf *err)
 {
-	enum log_refs_config log_refs_cfg = log_all_ref_updates;
+	enum log_refs_config log_refs_cfg = refs->log_all_ref_updates;
 	struct strbuf logfile_sb = STRBUF_INIT;
 	char *logfile;
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index c78186423a1..043e19439f6 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -52,6 +52,7 @@ struct reftable_ref_store {
 	struct reftable_write_options write_options;
 
 	unsigned int store_flags;
+	enum log_refs_config log_all_ref_updates;
 	int err;
 };
 
@@ -157,21 +158,21 @@ static struct reftable_stack *stack_for(struct reftable_ref_store *store,
 	}
 }
 
-static int should_write_log(struct ref_store *refs, const char *refname)
+static int should_write_log(struct reftable_ref_store *refs, const char *refname)
 {
-	enum log_refs_config log_refs_cfg = log_all_ref_updates;
+	enum log_refs_config log_refs_cfg = refs->log_all_ref_updates;
 	if (log_refs_cfg == LOG_REFS_UNSET)
 		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
 	switch (log_refs_cfg) {
 	case LOG_REFS_NONE:
-		return refs_reflog_exists(refs, refname);
+		return refs_reflog_exists(&refs->base, refname);
 	case LOG_REFS_ALWAYS:
 		return 1;
 	case LOG_REFS_NORMAL:
 		if (should_autocreate_reflog(log_refs_cfg, refname))
 			return 1;
-		return refs_reflog_exists(refs, refname);
+		return refs_reflog_exists(&refs->base, refname);
 	default:
 		BUG("unhandled core.logAllRefUpdates value %d", log_refs_cfg);
 	}
@@ -278,6 +279,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
 	strmap_init(&refs->worktree_stacks);
 	refs->store_flags = store_flags;
+	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
 
 	refs->write_options.hash_id = repo->hash_algo->format_id;
 	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
@@ -1220,7 +1222,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		} else if (!(u->flags & REF_SKIP_CREATE_REFLOG) &&
 			   (u->flags & REF_HAVE_NEW) &&
 			   (u->flags & REF_FORCE_CREATE_REFLOG ||
-			    should_write_log(&arg->refs->base, u->refname))) {
+			    should_write_log(arg->refs, u->refname))) {
 			struct reftable_log_record *log;
 			int create_reflog = 1;
 
diff --git a/repo-settings.c b/repo-settings.c
index 3a76ba276c9..1322fd2f972 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -124,3 +124,19 @@ void prepare_repo_settings(struct repository *r)
 	 */
 	r->settings.command_requires_full_index = 1;
 }
+
+enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
+{
+	const char *value;
+
+	if (!repo_config_get_string_tmp(repo, "core.logallrefupdates", &value)) {
+		if (value && !strcasecmp(value, "always"))
+			return LOG_REFS_ALWAYS;
+		else if (git_config_bool("core.logallrefupdates", value))
+			return LOG_REFS_NORMAL;
+		else
+			return LOG_REFS_NONE;
+	}
+
+	return LOG_REFS_UNSET;
+}
diff --git a/repo-settings.h b/repo-settings.h
index d03b6e57f0c..76adb96a669 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -65,4 +65,7 @@ struct repo_settings {
 
 void prepare_repo_settings(struct repository *r);
 
+/* Read the value for "core.logAllRefUpdates". */
+enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo);
+
 #endif /* REPO_SETTINGS_H */
diff --git a/setup.c b/setup.c
index 19cce5afa72..74991914726 100644
--- a/setup.c
+++ b/setup.c
@@ -2354,7 +2354,7 @@ static int create_default_files(const char *template_path,
 	else {
 		git_config_set("core.bare", "false");
 		/* allow template config file to override the default */
-		if (log_all_ref_updates == LOG_REFS_UNSET)
+		if (repo_settings_get_log_all_ref_updates(the_repository) == LOG_REFS_UNSET)
 			git_config_set("core.logallrefupdates", "true");
 		if (needs_work_tree_config(original_git_dir, work_tree))
 			git_config_set("core.worktree", work_tree);
-- 
2.46.0.421.g159f2d50e7.dirty

