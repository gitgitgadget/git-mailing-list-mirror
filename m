Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486B18FDC5
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924367; cv=none; b=EuxV8JNPJBAcpak/kG2GKQHOb5GGMpgY6jnv8Xq8eVvLT4TLoFJV3lh3OxnBRo8qArQTBwuBdS5fHqCs1WJYrTb25le22QenJ1zzwDR1jSYt7xC3VR1v5M66o7ETRl1gRb/hlPm/wrV5zYxM+0I1DYgbj4n+aHIl4IgrH827EGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924367; c=relaxed/simple;
	bh=vFyjcGoh5HDlkIro+NqtwKY+IGL1yij0QuZ0cz60pfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGejwxvmSBLNShUyi5L8XYAb65K8WirbuWsbwC6ja8dzZyorozYKena+PfjFAsBhaGqWkE7tpCRiWPNVRbJ371e4YB/rOrWoGhSmDMC44/J8m42HxOqrECUU3UQ7WVjffp5h5uRKYKglacf6vB8GAQGbkLKgGK38cUZIcG1cYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e85ETykW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qIWKEBup; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e85ETykW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qIWKEBup"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 333111151AB9;
	Thu, 29 Aug 2024 05:39:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 29 Aug 2024 05:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924365; x=1725010765; bh=wj+mxw2cA9
	x0EHxgij7SOhJAZxcM7/4jCuPYMsiaPak=; b=e85ETykWdFyrcpVyoCyyhXBMp7
	pBTDDKBHOHkhBIhbIkf4kT5WiY/TIN/TYWLH3H+8ga0l4etAcwtua4/8bNQsB++8
	Ck3B0e6ylJnCOZjUEr1KIyTl+EJyTIXaZaUEly14yOokLmT28qCSJoz3Osg3k6r9
	IMKxvDvbtoN8oAn7KWeG0bOyNBE4u/7CuQcw342V8/IZ2pRkQ5wcwgcJzi9z6xxw
	RVVuVIUcvzc07+8G2psBJoMJtGvJ+5T+kYudSVbZkOHxtiwQNDETcpeMi92Cn3Xr
	d/ytNg10rRvxgCX6bCvLNv5lri+lhFULgRt4EA/HfPX8qWVoBw63jwsTP6Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924365; x=1725010765; bh=wj+mxw2cA9x0EHxgij7SOhJAZxcM
	7/4jCuPYMsiaPak=; b=qIWKEBups3xgon+JwFhUx3dI5zFnq13oE590h4waNnUd
	oMslmDskNAgv58CLxG3eQUE7P57KAnOPKVBOXd0lAMSByxaJRtyYQwzfeXntiOD4
	8pPsdSAmB+b6jYOhQoaDQpT8M/+5/XorkbGjuuK53dnIFzqXsPwSQ+avn/Ao3Us4
	EngR6KxpGMp6salXaUQQW6TKnRST9GzAZZZIDVj2wMGVzBS1MoX/3AR/+4qAX1Pa
	FH0l540ZWgFd/rAK38ytjwCuzuY9We+QunmkL88mSPMN9mzFwrs9q7A2UyrDAb3y
	yT7pAsWgTZVTXanmJLvl1bmLTwyIXA7oZYnGWaxVUg==
X-ME-Sender: <xms:zUHQZi_WMJ25RXWqwO_ZfQlJwqr58e7MQV6okNcd0iPXrtwY9OMXNA>
    <xme:zUHQZiuIg0uXn8NGsaG-3zs1yH2SlJ4G1Yi0wcm0D9iZP6NwVQVEiXWyEJqk0NAcw
    UpIaps2EUdmaUdrEg>
X-ME-Received: <xmr:zUHQZoD0WxyDPfNccJJDMftZ0NDByuVoQjl9-BoxWbMi12Ui2p7xuDkYZBBdpeIaszefo1C2aca4RbwtXS9jsXpNBsRJNFwbXE82gyf26pFhyk0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:zUHQZqeGtVtk8idfx8z0L0MlMGyhqRo3Mi0gbMYut4f2mcCY_mHhGA>
    <xmx:zUHQZnMjfFMyFcwTywC4l2YaVL6R49DVFpXOdcFJFuD3dURoHyET3Q>
    <xmx:zUHQZkkGn_whm9OBtSzuhzFcTM94Jo2nU-I3U9_OHQdGpmVw4ek_Ww>
    <xmx:zUHQZpvURPs-1vlYR8KNw2i9yEHyoOtzs0W3GjEUw_bHa3GwQbeMSQ>
    <xmx:zUHQZgYMbyY9T45_VTeDth6S-fM29tcKHpFN04SVlfcswbWfWz0Mljxb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:39:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0cd4474 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:39:15 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:39:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 18/21] environment: stop storing "core.logAllRefUpdates"
 globally
Message-ID: <b6a9eb981eed22298edaf37df01f30d2aeac8685.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

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
index a0214486471..84a2dbeee79 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -950,6 +950,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
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
index c143cde8aa4..6ad495744b0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -74,6 +74,7 @@ struct files_ref_store {
 	unsigned int store_flags;
 
 	char *gitcommondir;
+	enum log_refs_config log_all_ref_updates;
 
 	struct ref_cache *loose;
 
@@ -106,6 +107,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, refs->gitcommondir, flags);
+	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
@@ -1703,7 +1705,7 @@ static int log_ref_setup(struct files_ref_store *refs,
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
index a4a9fbb3a2a..c37dc4f7c48 100644
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

