Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A9F391517
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116934; cv=none; b=VfX36+zfdF+zz+OS0geSBi/M5RMa9M28SEikyeqnNaAm1MWnqBV95dPeJfxeq+8Y+x5J97keREHB0iI8i6HJBIAgFjjhH0oyxyd0EUNl5IzgonZlxsGRxeLSZ/0zIUqTRBO0Efr6vhUPrNE8Cq+43b2gckTPIHxWMr7AcwW1U+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116934; c=relaxed/simple;
	bh=yqpDpCrMKesd0fUoHA48HxqrTvH9IRkNm1WnXJofCsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FVJWsZ2R5z2iLQz3GzSTeIW9qqZFTI3r6Ay5QoUY8fpKGeuwowC9B9kooBlSYTTragZI+2vJajFWxgEQsqDgYr6Thjes3Lr3JHJCVxG1Bi4YzSJ+MrooBWJyhIp+swuq6hMo88qvd+6Y0HhaES7Y8qsDW112uRFe9GUwDqGFOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jvfHqC69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LmKVBJAU; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jvfHqC69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LmKVBJAU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E2BD1D000E7;
	Mon, 22 Jun 2026 04:28:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 22 Jun 2026 04:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782116927;
	 x=1782203327; bh=obqMKndgUr8GjFNjcF8ZAmKf2Urh7Mb3WGUdfcB9WVk=; b=
	jvfHqC69viBb4VJDGaByU7BionpgtqRo31PHsv/0Dh+y2wXOzJ8vFUkdtBzIGsDp
	STIsig2AZV+WKb7vFCXv6thm9McyAVQGAU7R4Phk3APMXPmHBer6yFAp72V73xYQ
	R+k0ofgUObMREP7y19pLKc3IJrqlZ/i0eGRjPSZ2nzQIrPEICyFUcc/H6phJI7PZ
	lazqBq/GnLJdRj2FaSS0DamYPnOSCVxL8rBqunwt83Rj79URwrEKuCpHB3PEESK0
	nRnmTgmxkZdzBsJmiUVCn7tQWQeFc4i30pfrdlIGhTMK2f5Hvw4ar3FIySIafTtn
	k/V+JFghT4lhWincGBDu1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782116927; x=
	1782203327; bh=obqMKndgUr8GjFNjcF8ZAmKf2Urh7Mb3WGUdfcB9WVk=; b=L
	mKVBJAUXfA/ttEcsI9st+o9yoVTq905wLvUYJc8Yl5lgNnFwUBVl0yUittIHJ3Xw
	Ty9iwHLbIu/I8xKbtYcs7ZBeX6JevN/Fy0sZhV3swHTc/yn+APt6Q1f7LT8UkIRi
	rvhQ1tqoeH/LPfRziqFlFCm8GQpKTzI/TaJ3TR5Ia6DZbtYMc2Hnl7rjOWL3sg0l
	rtRzb5Po1KTWvTMVTO+RlvL14b7iVu9/ki9r3gU8PqsW+mmkjsnUiHSQJ1/EDfBI
	oAH8Rkj5buFdg/qiruWJjbjUCY9HU8qB946d5fJm4q51Jvw4+k9ANtJ1PW+B5QEz
	p4qtTHDDzitKPVt1cJEaQ==
X-ME-Sender: <xms:P_I4am4IDgMXga2vb9lS6k5WB-CWCZPyNVlewGVQaGLzOj-jSj4k2w>
    <xme:P_I4am4rI3XMbcXfOdU2JGA2c5dYEJFqj99g52K3blYbhtXn5H47PTBjbaYpG1U3a
    7AfK1t01QpZMZpM-72thA3BDOvH_mEm1YvBE0nvAqs9qUM3QhWmHw>
X-ME-Received: <xmr:P_I4aqdfUFS621A2H-AdthQkieextpyXxH14bj87wssY0U3nEhQw9Ug733-PVTyTQQcIdtkg1swniVmYtAV0ZO3EO0QyZHfPwDOJNYd1Gw>
X-ME-Proxy-Cause: dmFkZTGDn2HnReKTkdFLA50uYQuwxD+JAF0LKkzbGljcmiuXNQprDvOayV4UAEZgereohe
    zNtc9i6fAVcGJPBZzWyQ+d9vUGfhUeavlENOCeCdjbpnd7YXC4iDQrSDmImfxlhHK9Y7WH
    U4QKkfmC/kMqPTeMakchMIEGPHjWXTz7Wd7A6A2QBavdqWfPYLI6z+Vr/xuvEYaehokOwE
    um0rTLC8JUZfREAaHzwKItP6RFdK0fdWqwIjOFUlv8C7M595chWTjixt0pGIZhIeAqf6In
    M0dufP6SxC/2IXsvgDqC3oHElifeqUr45V3zy++6WBsXLjjVPigftNNWs/8Kc8jwECDAdc
    1p5PKCQ1Bc8tG4lKRs2N5DKYZUYVy8/dIGPxw524uTGhCiww97RiZoIdLeu4V21zNJzqkR
    YGLaAHgsn6xk4NJi1IjEI9+8aZ5ElV+9yMKcYsSAtTGY81/Q7w1yLhcZhwBDEs1GtyF5/h
    ATRAjCSd/SpQn3t61t0LJeqXyANAK/VBZyOqwF+vAPJvK33FRX4wZQstJWeRUcbth/47ua
    gJBWcwSV/O7vl02UvXDWXNubG6/frnrCH1NxjlgrmQiCPbjOoBvwF2BZ2E3a2i51CX4SUy
    tY+T4ksBr6Ddftwq4KMFFd6JRJE2UieaGit46OCY7rcCYhYJRzVjYYU8YwcA
X-ME-Proxy: <xmx:P_I4aiDSPPUv5PdIoMbTZ9wDTjL6DNEpt4vlrJPk8h7YQJLFyKgNYQ>
    <xmx:P_I4al9tbzKOLU4AIvzip0QqGPbRbJKx0q5fqeA6h7_FZkFQ1vO5og>
    <xmx:P_I4alI53xnEdLls7vUmFYcuDQzbAx77UKscyXAGEyZ9SuDyNaQnVA>
    <xmx:P_I4amgnDg0XlyvtVKRRa_WsmPfHjFB0osBJHl8vz86Re0E_eCXgmA>
    <xmx:P_I4akjGkgTajx3N1qM1m797FI778N7FLdxAhOO7mam1V7tiULR1bZTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:28:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 717d9161 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:28:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:28:29 +0200
Subject: [PATCH v5 07/11] refs: move parsing of "core.logAllRefUpdates"
 back into ref stores
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-7-018475013dbc@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In cc42c88945 (refs: extract out reflog config to generic layer,
2026-05-04) we have refactored how we parse "core.logAllRefUpdates" so
that it happens in the generic layer. Unfortunately, this has worsened a
preexisting issue where we may recurse when creating the reference store
because of a chicken-and-egg problem between parsing the configuration
and evaluating "onbranch" conditions.

Prepare for a fix by essentially reverting that change so that we handle
this setting in the respective backends again. The backends are already
parsing other configuration anyway, so by moving the logic back in there
we can ensure that all backend configuration is parsed the same way.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c      |  7 +++++--
 refs.c                  | 10 +++++++++-
 refs.h                  |  9 +++++++++
 refs/files-backend.c    | 20 +++++++++++++++++---
 refs/refs-internal.h    |  6 ------
 refs/reftable-backend.c | 20 +++++++++++---------
 repo-settings.c         | 16 ----------------
 repo-settings.h         |  9 ---------
 setup.c                 |  7 ++++++-
 9 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b78b3a1d16..aee84ca897 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -952,10 +952,13 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	const char *old_desc, *reflog_msg;
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
-			enum log_refs_config log_all_ref_updates =
-				repo_settings_get_log_all_ref_updates(the_repository);
+			enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
+			const char *value;
 			char *refname;
 
+			if (!repo_config_get_string_tmp(the_repository, "core.logallrefupdates", &value))
+				log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
+
 			refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
 			if (opts->new_branch_log &&
 			    !should_autocreate_reflog(log_all_ref_updates, refname)) {
diff --git a/refs.c b/refs.c
index d3caa9a633..5b773b1c15 100644
--- a/refs.c
+++ b/refs.c
@@ -1053,6 +1053,15 @@ static char *normalize_reflog_message(const char *msg)
 	return strbuf_detach(&sb, NULL);
 }
 
+enum log_refs_config refs_parse_log_all_ref_updates_config(const char *value)
+{
+	if (value && !strcasecmp(value, "always"))
+		return LOG_REFS_ALWAYS;
+	else if (git_config_bool("core.logallrefupdates", value))
+		return LOG_REFS_NORMAL;
+	return LOG_REFS_NONE;
+}
+
 int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,
 			     const char *refname)
 {
@@ -2327,7 +2336,6 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	struct ref_store *refs;
 	struct ref_store_init_options opts = {
 		.access_flags = flags,
-		.log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo),
 	};
 
 	be = find_ref_storage_backend(format);
diff --git a/refs.h b/refs.h
index 71d5c186d0..a381022c77 100644
--- a/refs.h
+++ b/refs.h
@@ -146,6 +146,15 @@ enum ref_transaction_error refs_verify_refname_available(struct ref_store *refs,
 
 int refs_ref_exists(struct ref_store *refs, const char *refname);
 
+enum log_refs_config {
+	LOG_REFS_UNSET = -1,
+	LOG_REFS_NONE = 0,
+	LOG_REFS_NORMAL,
+	LOG_REFS_ALWAYS
+};
+
+enum log_refs_config refs_parse_log_all_ref_updates_config(const char *value);
+
 int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,
 			     const char *refname);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 296981584b..79fb6735e1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -117,6 +117,21 @@ static void files_ref_store_reparent(const char *name UNUSED,
 	refs->gitcommondir = tmp;
 }
 
+static int files_ref_store_config(const char *var, const char *value,
+				  const struct config_context *ctx UNUSED,
+				  void *payload)
+{
+	struct files_ref_store *refs = payload;
+
+	if (!strcmp(var, "core.prefersymlinkrefs")) {
+		refs->prefer_symlink_refs = git_config_bool(var, value);
+	} else if (!strcmp(var, "core.logallrefupdates")) {
+		refs->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
+	}
+
+	return 0;
+}
+
 /*
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
@@ -141,10 +156,9 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
 	refs->store_flags = opts->access_flags;
-	refs->log_all_ref_updates = opts->log_all_ref_updates;
-
-	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
+	refs->log_all_ref_updates = LOG_REFS_UNSET;
 
+	repo_config(repo, files_ref_store_config, refs);
 	chdir_notify_register(NULL, files_ref_store_reparent, refs);
 
 	strbuf_release(&refdir);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a08d58900e..c3ac7b556f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -406,12 +406,6 @@ struct ref_store;
 struct ref_store_init_options {
 	/* The kind of operations that the ref_store is allowed to perform. */
 	unsigned int access_flags;
-
-	/*
-	 * Denotes under what conditions reflogs should be created when updating
-	 * references.
-	 */
-	enum log_refs_config log_all_ref_updates;
 };
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8c93070677..5115a3f4ce 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -332,34 +332,36 @@ static void fill_reftable_log_record(struct reftable_log_record *log, const stru
 
 static int reftable_be_config(const char *var, const char *value,
 			      const struct config_context *ctx,
-			      void *_opts)
+			      void *payload)
 {
-	struct reftable_write_options *opts = _opts;
+	struct reftable_ref_store *refs = payload;
 
 	if (!strcmp(var, "reftable.blocksize")) {
 		unsigned long block_size = git_config_ulong(var, value, ctx->kvi);
 		if (block_size > 16777215)
 			die("reftable block size cannot exceed 16MB");
-		opts->block_size = block_size;
+		refs->write_options.block_size = block_size;
 	} else if (!strcmp(var, "reftable.restartinterval")) {
 		unsigned long restart_interval = git_config_ulong(var, value, ctx->kvi);
 		if (restart_interval > UINT16_MAX)
 			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
-		opts->restart_interval = restart_interval;
+		refs->write_options.restart_interval = restart_interval;
 	} else if (!strcmp(var, "reftable.indexobjects")) {
-		opts->skip_index_objects = !git_config_bool(var, value);
+		refs->write_options.skip_index_objects = !git_config_bool(var, value);
 	} else if (!strcmp(var, "reftable.geometricfactor")) {
 		unsigned long factor = git_config_ulong(var, value, ctx->kvi);
 		if (factor > UINT8_MAX)
 			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
-		opts->auto_compaction_factor = factor;
+		refs->write_options.auto_compaction_factor = factor;
 	} else if (!strcmp(var, "reftable.locktimeout")) {
 		int64_t lock_timeout = git_config_int64(var, value, ctx->kvi);
 		if (lock_timeout > LONG_MAX)
 			die("reftable lock timeout cannot exceed %"PRIdMAX, (intmax_t)LONG_MAX);
 		if (lock_timeout < 0 && lock_timeout != -1)
 			die("reftable lock timeout does not support negative values other than -1");
-		opts->lock_timeout_ms = lock_timeout;
+		refs->write_options.lock_timeout_ms = lock_timeout;
+	} else if (!strcmp(var, "core.logallrefupdates")) {
+		refs->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
 	}
 
 	return 0;
@@ -398,7 +400,6 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
-	refs->log_all_ref_updates = opts->log_all_ref_updates;
 	refs->store_flags = opts->access_flags;
 
 	switch (repo->hash_algo->format_id) {
@@ -415,8 +416,9 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
 	refs->write_options.lock_timeout_ms = 100;
+	refs->log_all_ref_updates = LOG_REFS_UNSET;
 
-	repo_config(repo, reftable_be_config, &refs->write_options);
+	repo_config(repo, reftable_be_config, refs);
 
 	/*
 	 * It is somewhat unfortunate that we have to mirror the default block
diff --git a/repo-settings.c b/repo-settings.c
index 208e09ff17..f3be3b8c5a 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -177,22 +177,6 @@ void repo_settings_set_big_file_threshold(struct repository *repo, unsigned long
 	repo->settings.big_file_threshold = value;
 }
 
-enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
-{
-	const char *value;
-
-	if (!repo_config_get_string_tmp(repo, "core.logallrefupdates", &value)) {
-		if (value && !strcasecmp(value, "always"))
-			return LOG_REFS_ALWAYS;
-		else if (git_config_bool("core.logallrefupdates", value))
-			return LOG_REFS_NORMAL;
-		else
-			return LOG_REFS_NONE;
-	}
-
-	return LOG_REFS_UNSET;
-}
-
 int repo_settings_get_warn_ambiguous_refs(struct repository *repo)
 {
 	prepare_repo_settings(repo);
diff --git a/repo-settings.h b/repo-settings.h
index cad9c3f0cc..e5253ead02 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -16,13 +16,6 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NOOP,
 };
 
-enum log_refs_config {
-	LOG_REFS_UNSET = -1,
-	LOG_REFS_NONE = 0,
-	LOG_REFS_NORMAL,
-	LOG_REFS_ALWAYS
-};
-
 struct repo_settings {
 	int initialized;
 
@@ -86,8 +79,6 @@ struct repo_settings {
 void prepare_repo_settings(struct repository *r);
 void repo_settings_clear(struct repository *r);
 
-/* Read the value for "core.logAllRefUpdates". */
-enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo);
 /* Read the value for "core.warnAmbiguousRefs". */
 int repo_settings_get_warn_ambiguous_refs(struct repository *repo);
 /* Read the value for "core.hooksPath". */
diff --git a/setup.c b/setup.c
index 79125db565..0c6efb0560 100644
--- a/setup.c
+++ b/setup.c
@@ -2584,10 +2584,15 @@ static int create_default_files(struct repository *repo,
 	if (is_bare_repository())
 		repo_config_set(repo, "core.bare", "true");
 	else {
+		const char *value;
+
 		repo_config_set(repo, "core.bare", "false");
+
 		/* allow template config file to override the default */
-		if (repo_settings_get_log_all_ref_updates(repo) == LOG_REFS_UNSET)
+		if (repo_config_get_string_tmp(repo, "core.logallrefupdates", &value) ||
+		    refs_parse_log_all_ref_updates_config(value) == LOG_REFS_UNSET)
 			repo_config_set(repo, "core.logallrefupdates", "true");
+
 		if (needs_work_tree_config(original_git_dir, work_tree))
 			repo_config_set(repo, "core.worktree", work_tree);
 	}

-- 
2.55.0.rc1.745.g43192e7977.dirty

