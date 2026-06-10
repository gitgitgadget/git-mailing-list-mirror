Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933738238D
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074633; cv=none; b=ouSEaOIq11hgbNDPSdR2y9XcFHml8nA+Z+afAg1HR67awKjj3zKvwq/inhpF6efVzuv57rwJnz7KzxfVwl72o/hjIKtKBJdkJjOnILOTpCdkBacH3qIZ+tkKuRQLy8PcMebhQStaL4EGMYtI55ApbbgKXafawT0VYMFwpaL6KeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074633; c=relaxed/simple;
	bh=zW1RE4vSEkvAw55iFx/9bOW7UgBBfIYuvh3vYw5cuPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWlYSicxcPegDQ0jNUqESmbBa1nJUtEiybyLhVXz+SFrmmG5t7cxymbQS9fXuXk1ITM3f6OnMTiQAVYtv+u6jSHFo9WnciVdnfm9WWNkdlNjyW234kN7x9yf8n7lQDp9T2/95E3os7lqVWaXnQBB/3NP05mLwGf5eCXIB06rIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g7ySA98F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X12RAZEq; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g7ySA98F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X12RAZEq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DB471D00041
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 02:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781074631;
	 x=1781161031; bh=kTIMTOtUVj8P+znCP9siKI/U9ifHNI6qCozMuyRzFzA=; b=
	g7ySA98FjKGfjFTdUWG5nPZte7eupegii+WDGQbhr3jOnHfgsOBB20w6HjWo2EK/
	DUkY38T6ygEeQZm1vLbZ4nWJDdlP/eE3wMDtScIOMpHEfbGOqjbYw0X7b65cwUe/
	Nc3Zjl6OycbbeuYpYnD4oqrDldDBu0XbqYV4jNYuvw6eBE4JOgR5Cx8710GHu9yN
	5KNPWmnxQ/zYGoJU//ob14dSHuYAbpkJB6ppA4w3YYi0yFI8wyH1EH+KFFV76EeV
	t8o8AvEpv/3w/Dj6FaDIbWgc4UOnq6GDcNatyAxPmhLZcc+xwzcniqCWtAEjUahH
	OFFVv+0zWIQ0YiW5JohJyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781074631; x=
	1781161031; bh=kTIMTOtUVj8P+znCP9siKI/U9ifHNI6qCozMuyRzFzA=; b=X
	12RAZEqHaXmdU/K1VQsL86Qq7O6GqR5M4oT7udgHWL4U/KOPHU26ePhUygCt3VMr
	3onIgvIY6tC8gtbPHjsuNS/s7XKSKOaJm9XtsEBiHNwGhYuTImM8JK9qATFGkiAm
	oXGBlQVLzw8yD8+sWvbE2+51ltfuuyxYk0TzZtNbdBdfISYPxJgii8+aq1QZLbKB
	hXtSCn+0QownD+aMVgOjFd5c64e/hw4kt0d8rM105jkUfETpAWcZUhZbMVQSRfey
	vK587uXIIJxHz02WIGzOAdYeTNWwOfRACZFd4tcrl94ComqGG+PIH08u3V5L4Z1w
	jxjQvKFALzXD258y2WEDg==
X-ME-Sender: <xms:xwopaq4Lt9jOA-GWGatz-8uTMf7yj0M4Cp8-CvVx8Lx9vbgs4ibAbA>
    <xme:xwopaq1hdgm85NuTgNU0nb1gcct0nA_O3iZWdaeI3LkWF6kPQdQ8WbiOYJHyrki6t
    Sjqzp-m4MZi-baF38dMmBx1JU4tLfHg6YmPVWwhia3tuQ2wQ19usQ>
X-ME-Received: <xmr:xwopavFvx_B-rvKb7kQFU_ZuJ-vieHzTCYBVOio4HoKTrJAeTJfyHZPd-NxD8YPi7CSm94-EUAA_xxg-jhID_jxQkyqpjJ8-R49rOc1wgA>
X-ME-Proxy-Cause: dmFkZTGPEMb1GCalfv1+f6/Ye7jAEcACTO3ZzeDl5PA/vQd4Vw5wrXUa+WMEzFw5u8+W+l
    QLDQWAoI0ZqjCgjy6jcFkc9184iWsZrXFZmfN4wFAymHsR5wQQ0nKOHBdB9LMEwLZf1Rg5
    w9edMN9phGMZWH3uufqaYRywHoSA4G1CzXEcSxyyW4KjyRCTpaK0+K95NX60BOgBaQDgLV
    Hk9BvHnbwro/ZEMw3FT6nf6EU7N0wkWi2BqZYpF180lot7T2D6Ole0jIlns/obA7l2vaQl
    aY7sP2vRZU1nNQK5p6KkS7lRu8wjqwGXYNSPzFDlrTNXm2zxbjhjvsZqOxoYa7mG74zOCu
    lPT40hr1GJCGAtgXNFfHKy9F4hE9YoMIuk1gS1AglkNt/MrTInD+f00maPgioVo51glSh2
    Jpu5WluO5a4ZN+FRMm82h3i88t/igyx2rCYQv6EiSTWgNFO7c5mnSGpHdMaH7CnahfyIeh
    +BjrJ1iX6TC/m22rdt06LrgIsuEGXDbiclIpyOr9J23PcGdtdzPL1gfD7jtyAaU434/H9L
    Muro5n3Y2s11dd6jGWU0ZRr6/5keEK8BSm8Kvc57vUfCM9CXIRkVK5WsDAj87Z2RPcAhE1
    fQGTf/yR1rDWglZHqzC0wCnpdFJ232vUzUQ8V3+IdpFK6alIe5iFiPQXJh7Q
X-ME-Proxy: <xmx:xwopasSwHkwkYJVlKbvjDu-67gY3dgLDMHPhmR96vUvJqvQfH15VZw>
    <xmx:xwopauBQtomhRX6k7VY7XlZleLlv-GgIm6zMDw1WfhpXxq4GIWngBg>
    <xmx:xwopak2cdP-OcUwpDFrxwaPTTxpdWHrlypXw2yxFR2lJuT-OezJSTQ>
    <xmx:xwopakXEDnUYeDK7V3epOEATRg2HmEM-dsWldAyZv1OT_xh2Gxchbg>
    <xmx:xwopaja58IuemYuoe-CwMeGRP6pyf9cAbOYaWRiTXbeoifM_s9WKl0kh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 490fe256 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 10 Jun 2026 06:57:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 08:56:51 +0200
Subject: [PATCH 6/7] environment: stop using `the_repository` in
 `is_bare_repository()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-setup-drop-global-state-v1-6-5dff3eec8f06@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Refactor `is_bare_repository()` to take in a repository parameter so
that we no longer depend on `the_repository`. Adjust callers
accordingly.

Furthermore, move the function outside of the declarations that are only
available when `USE_THE_REPOSITORY_VARIABLE` is set, as it no longer
depends on that variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 attr.c                  | 4 ++--
 builtin/bisect.c        | 2 +-
 builtin/blame.c         | 2 +-
 builtin/check-attr.c    | 2 +-
 builtin/fetch.c         | 2 +-
 builtin/gc.c            | 2 +-
 builtin/history.c       | 2 +-
 builtin/repack.c        | 2 +-
 builtin/repo.c          | 2 +-
 builtin/reset.c         | 2 +-
 builtin/rev-parse.c     | 2 +-
 environment.c           | 4 ++--
 environment.h           | 4 ++--
 mailmap.c               | 4 ++--
 refs/files-backend.c    | 2 +-
 refs/reftable-backend.c | 2 +-
 setup.c                 | 2 +-
 transport.c             | 4 ++--
 worktree.c              | 2 +-
 19 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/attr.c b/attr.c
index 75369547b3..04cb284954 100644
--- a/attr.c
+++ b/attr.c
@@ -681,7 +681,7 @@ static enum git_attr_direction direction;
 
 void git_attr_set_direction(enum git_attr_direction new_direction)
 {
-	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
+	if (is_bare_repository(the_repository) && new_direction != GIT_ATTR_INDEX)
 		BUG("non-INDEX attr direction in a bare repo");
 
 	if (new_direction != direction)
@@ -848,7 +848,7 @@ static struct attr_stack *read_attr(struct index_state *istate,
 		res = read_attr_from_index(istate, path, flags);
 	} else if (tree_oid) {
 		res = read_attr_from_blob(istate, tree_oid, path, flags);
-	} else if (!is_bare_repository()) {
+	} else if (!is_bare_repository(the_repository)) {
 		if (direction == GIT_ATTR_CHECKOUT) {
 			res = read_attr_from_index(istate, path, flags);
 			if (!res)
diff --git a/builtin/bisect.c b/builtin/bisect.c
index e7c2d2f3bb..798e28f501 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -724,7 +724,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	struct object_id oid;
 	const char *head;
 
-	if (is_bare_repository())
+	if (is_bare_repository(the_repository))
 		no_checkout = 1;
 
 	/*
diff --git a/builtin/blame.c b/builtin/blame.c
index ffbd3ce5c5..553f4cb780 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1163,7 +1163,7 @@ int cmd_blame(int argc,
 
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
-	if (!revs.pending.nr && is_bare_repository()) {
+	if (!revs.pending.nr && is_bare_repository(the_repository)) {
 		struct commit *head_commit;
 		struct object_id head_oid;
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 98f64d5b92..217d83ea7d 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -116,7 +116,7 @@ int cmd_check_attr(int argc,
 	struct object_id initialized_oid;
 	int cnt, i, doubledash, filei;
 
-	if (!is_bare_repository())
+	if (!is_bare_repository(the_repository))
 		setup_work_tree(the_repository);
 
 	repo_config(the_repository, git_default_config, NULL);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c1d7c672f4..44b8c70da1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1764,7 +1764,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 
 	if (!head_name)
 		goto cleanup;
-	baremirror = is_bare_repository() && remote->mirror;
+	baremirror = is_bare_repository(the_repository) && remote->mirror;
 	create_only = follow_remote_head == FOLLOW_REMOTE_ALWAYS ? 0 : !baremirror;
 	if (baremirror) {
 		strbuf_addstr(&b_head, "HEAD");
diff --git a/builtin/gc.c b/builtin/gc.c
index 84a66d3240..61da30de9f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -902,7 +902,7 @@ int cmd_gc(int argc,
 		die(_("failed to parse gc.logExpiry value %s"), cfg.gc_log_expire);
 
 	if (cfg.pack_refs < 0)
-		cfg.pack_refs = !is_bare_repository();
+		cfg.pack_refs = !is_bare_repository(the_repository);
 
 	argc = parse_options(argc, argv, prefix, builtin_gc_options,
 			     builtin_gc_usage, 0);
diff --git a/builtin/history.c b/builtin/history.c
index 091465a59e..fd83de8265 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -525,7 +525,7 @@ static int cmd_history_fixup(int argc,
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
 
-	if (is_bare_repository()) {
+	if (is_bare_repository(repo)) {
 		ret = error(_("cannot run fixup in a bare repository"));
 		goto out;
 	}
diff --git a/builtin/repack.c b/builtin/repack.c
index 1524a9c13a..bbc6f51639 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -265,7 +265,7 @@ int cmd_repack(int argc,
 
 	if (write_bitmaps < 0) {
 		if (write_midx == REPACK_WRITE_MIDX_NONE &&
-		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
+		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository(the_repository)))
 			write_bitmaps = 0;
 	}
 	if (po_args.pack_kept_objects < 0)
diff --git a/builtin/repo.c b/builtin/repo.c
index 71a5c1c29c..34e96514bc 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -58,7 +58,7 @@ struct repo_info_field {
 
 static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
 {
-	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
+	strbuf_addstr(buf, is_bare_repository(the_repository) ? "true" : "false");
 	return 0;
 }
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 3be6bd0121..78e69bd84b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -470,7 +470,7 @@ int cmd_reset(int argc,
 	if (reset_type != SOFT && (reset_type != MIXED || repo_get_work_tree(the_repository)))
 		setup_work_tree(the_repository);
 
-	if (reset_type == MIXED && is_bare_repository())
+	if (reset_type == MIXED && is_bare_repository(the_repository))
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index bb882678fe..090e5cfbb0 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1084,7 +1084,7 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--is-bare-repository")) {
-				printf("%s\n", is_bare_repository() ? "true"
+				printf("%s\n", is_bare_repository(the_repository) ? "true"
 						: "false");
 				continue;
 			}
diff --git a/environment.c b/environment.c
index 9d7c908c55..bf20953415 100644
--- a/environment.c
+++ b/environment.c
@@ -132,10 +132,10 @@ const char *getenv_safe(struct strvec *argv, const char *name)
 	return argv->v[argv->nr - 1];
 }
 
-int is_bare_repository(void)
+int is_bare_repository(struct repository *repo)
 {
 	/* if core.bare is not 'false', let's see if there is a work tree */
-	return the_repository->bare_cfg && !repo_get_work_tree(the_repository);
+	return repo->bare_cfg && !repo_get_work_tree(repo);
 }
 
 int have_git_dir(void)
diff --git a/environment.h b/environment.h
index afb5bcf197..164a55df2c 100644
--- a/environment.h
+++ b/environment.h
@@ -125,6 +125,8 @@ int git_default_core_config(const char *var, const char *value,
 
 void repo_config_values_init(struct repo_config_values *cfg);
 
+int is_bare_repository(struct repository *repo);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
@@ -147,8 +149,6 @@ void repo_config_values_init(struct repo_config_values *cfg);
  */
 int have_git_dir(void);
 
-int is_bare_repository(void);
-
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
diff --git a/mailmap.c b/mailmap.c
index 3b2691781d..7d8590cdd6 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -219,10 +219,10 @@ int read_mailmap(struct repository *repo, struct string_list *map)
 	map->strdup_strings = 1;
 	map->cmp = namemap_cmp;
 
-	if (!mailmap_blob && is_bare_repository())
+	if (!mailmap_blob && is_bare_repository(the_repository))
 		mailmap_blob = xstrdup("HEAD:.mailmap");
 
-	if (!startup_info->have_repository || !is_bare_repository())
+	if (!startup_info->have_repository || !is_bare_repository(the_repository))
 		err |= read_mailmap_file(map, ".mailmap",
 					 startup_info->have_repository ?
 					 MAILMAP_NOFOLLOW : 0);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a4c7858787..2b27091484 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1865,7 +1865,7 @@ static int log_ref_setup(struct files_ref_store *refs,
 	char *logfile;
 
 	if (log_refs_cfg == LOG_REFS_UNSET)
-		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+		log_refs_cfg = is_bare_repository(the_repository) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
 	files_reflog_path(refs, &logfile_sb, refname);
 	logfile = strbuf_detach(&logfile_sb, NULL);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4ae22922de..101ef29ac8 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -288,7 +288,7 @@ static int should_write_log(struct reftable_ref_store *refs, const char *refname
 {
 	enum log_refs_config log_refs_cfg = refs->log_all_ref_updates;
 	if (log_refs_cfg == LOG_REFS_UNSET)
-		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+		log_refs_cfg = is_bare_repository(the_repository) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
 	switch (log_refs_cfg) {
 	case LOG_REFS_NONE:
diff --git a/setup.c b/setup.c
index 2b690da8ca..6b95bf546d 100644
--- a/setup.c
+++ b/setup.c
@@ -2604,7 +2604,7 @@ static int create_default_files(struct repository *repo,
 	}
 	repo_config_set(repo, "core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository())
+	if (is_bare_repository(the_repository))
 		repo_config_set(repo, "core.bare", "true");
 	else {
 		repo_config_set(repo, "core.bare", "false");
diff --git a/transport.c b/transport.c
index 0f5ec30247..fc144f0aed 100644
--- a/transport.c
+++ b/transport.c
@@ -1482,7 +1482,7 @@ int transport_push(struct repository *r,
 
 	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
-	    !is_bare_repository()) {
+	    !is_bare_repository(the_repository)) {
 		struct ref *ref = remote_refs;
 		struct oid_array commits = OID_ARRAY_INIT;
 
@@ -1509,7 +1509,7 @@ int transport_push(struct repository *r,
 	if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
 	     ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 			TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
-	      !pretend)) && !is_bare_repository()) {
+	      !pretend)) && !is_bare_repository(the_repository)) {
 		struct ref *ref = remote_refs;
 		struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 		struct oid_array commits = OID_ARRAY_INIT;
diff --git a/worktree.c b/worktree.c
index 7d70f2c1da..30125827fd 100644
--- a/worktree.c
+++ b/worktree.c
@@ -124,7 +124,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->is_current = is_current_worktree(worktree);
 	worktree->is_bare = (the_repository->bare_cfg == 1) ||
-		is_bare_repository() ||
+		is_bare_repository(the_repository) ||
 		/*
 		 * When in a secondary worktree we have to also verify if the main
 		 * worktree is bare in $commondir/config.worktree.

-- 
2.54.0.1189.g8c84645362.dirty

