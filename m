Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA53C4165
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101200; cv=none; b=tgJLm1wr1UrpcYwFfEjPBTHnEhVF80rCgi1Z1R/sVUdAvbhOCkRF/W0jdg3G/Rv2DX6/m2B0C8QHq2Epj9MyydNbSweHGn8ZiPdj5wH2WWYfvqWxBoZWD0jITe6OqiKOyuiYzisridQPAcvSzcJ+IjaOon8pCotMPGgFw+eBZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101200; c=relaxed/simple;
	bh=AmIESPRhmUuU7iJ/kqF36OEAV1kPzNwuE6kAWUm0c9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LK2+63oNx54aHyjVWCe+5tjY/2EV1mm/cdrd7YwuXclIqrCLIY8dZ9pXnsvEqAp1d/d9oKSYex2lE/cY46KeXHZbe5nkmnhwHEJlsJ3sRiCh+HtRFn6a1nwxuVTbTzWzkga9teL5AbkdPwC2hCL4DMe424bu+pQIIK+vY5UU3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M5ONo5en; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EklBl/dU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M5ONo5en";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EklBl/dU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CABA97A0144;
	Wed, 15 Jul 2026 03:39:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 15 Jul 2026 03:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784101194;
	 x=1784187594; bh=uHbdF+xKL57G2TDhnZht9V/ULAieFSGXE39hJ9NnpUA=; b=
	M5ONo5enOM1U1Jqo35QpSeg0l636LSt9XC65V8Ei7rKg6kyRr63BzcFzxy99VBy7
	Em6eka6RC/gblzwK28mt34LYvRD5oVtdT1DEmtprDs7iJK8ksK/Es8waNmXxqdUP
	jPxqKPOxia4KZ/q4t2czosdsVsTehJGn0fXYVcFpNtwyXi9Gq4VG8ysO0M+jNOMx
	yZ/mkdivj7Jb5goFhdVm6nYVXK8Sv1FAphr5LF6FPpaZvAwWot3hW8XdtcJjlLA7
	akeaZKm181vCwih0klQbbYwwG7L3Dh+E6nIL4jBwp/HFKSgJ3hsbDk8NgczCZXQj
	nVBInR2/beJqBzvismyUPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784101194; x=
	1784187594; bh=uHbdF+xKL57G2TDhnZht9V/ULAieFSGXE39hJ9NnpUA=; b=E
	klBl/dURqsbm6e0VgfAEF+kiSFSDAuHTHm3JHGe5cFGUTGad7SQF6Q5lm0QLIt0n
	XE+sMpadHdG+NCPnCm4vqNr/Iqc0NZhXrTO3FC8w5cPFGHdpioDNeEA51qAvQGfG
	Fa/UNBMlaZf+DS+lsGmlzyXJQnjiUIGNj4CWYVPS3NYMa12nUf+pNzkizcyA2hs5
	+C+8UnOJvkI8/d5Ve41STFAORIHLrxOTCDxq/mB7VWbZ10zzpIiZh50diWvmvxga
	qjgQe0Fxjb1QY7OdcxdJKKfC8Bay1EG9dltVW3soQDLDY+cRlGaVaruFWssl2Wbn
	E28uxJaLvXsymBy0dCSow==
X-ME-Sender: <xms:SjlXanNKmm0LLbtm_qIYS4JFPv5dgrZXeZMfebav2z5scpiEtdn7Ew>
    <xme:SjlXan-kLH587jz5c0KL4qgFYXNms-DBq7ex-SoGVXVvkEOA4YKyZaA60cFpKudli
    nPgtCrHHsZlEVlxur3CihERk6-qA3_tG2srwUJHdzTh-SJMipOVow>
X-ME-Received: <xmr:SjlXaj4aKdCFe9XfQAkE3aQABv_cMQVvULFZCatVnYjSjt4ul1CT3zXtS7YrPZmMTxpXzQihivRSyNoCAZQrpGsCFJc4j3llphVMuI_eZ6g>
X-ME-Proxy-Cause: dmFkZTGtlESBpqxWx5VDCyzSHAFjLID+d3o017L+9t0hzoZ/HFdnZMksWAjQUpKe5mkcm2
    aeEPvI7S+GobeeC2BCcOlybP5AT8PUeK9DTyPOP4REeP/YXAf67SwpLL5/2tbBDgAB73I1
    65VyLIFoE16n9whYuM6847ToVuC6bk1LcBJvA5RtCpU1MgT4tzfJrvG4L/8v4k1G8If1CZ
    VYA0705qsr4QILUnrEU9UXR+Pte/Mn8XSZAMTzTNDXCdTNYP/5KxqorrepV1dVq41xtfLc
    rznFo3RqnfVCv9dkk95mAtSvNO4y5cQBzEbxS5nDDVudfZsteVxXo9jWe3soYdkzqZZeXU
    dzh+ZVR7iIc0XvC9hnI8wm6GB7MifV93CZYWbbIVZgrMmPeT0STvD5kb09pC5SyKtsrOYK
    ICjcZszQfVbaUBhLMig10ZRcOgPpzeAopo6KBqVfdiD9HBeElEtFIxt9bjB9phJdJCW9hR
    KBh56MvUVeKERt8VQ7J1MM7Qi3uURCPWPKL+AywQsUg/dsSDcOpDO1h1f+EBJxoBzKrEM/
    eb2OpuaJqd7E+GWPVCTGEytN2qDwbxU2RHwHjFg0nKGjX4LT5ayDIF9rCni9GcAa6+Jwu8
    EitxGcgILHxtWCJZBV3sgH+38xaMmHGdQN7GRDbTUEjD3oU8VO7qhOkK3fcQ
X-ME-Proxy: <xmx:SjlXam0pFqx2gRpwjoe_1TK-_F4Xr8GADGukUuZpLDL2upmJ2jFwbA>
    <xmx:SjlXaiAP6s5wR6xUNdmxAEQXXmiUPM5yYT8P_25Tm7RkQB--3_QlDA>
    <xmx:SjlXag0cV7KZ0iPqHAJBRCp5s7KRy0uFcNt2d1Qep3xguMYG8KnqHw>
    <xmx:SjlXaktS2y9ulI8Wz_9PahDSdJ6WVw07HPNSx64xqq28Q8gq5OSklg>
    <xmx:SjlXaimOXJlgEI-UGEaFcljDiWw_jW-VvyUZleUEw1vFHq8OavKHuC35>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 03:39:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1874cbaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 07:39:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 09:39:39 +0200
Subject: [PATCH v2 6/7] worktree: pass repository to public functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-refs-wo-the-repository-v2-6-d00d364f5a3e@pks.im>
References: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
In-Reply-To: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Refactor remaining public functions that still depend on
`the_repository` to instead receive a repository as parameter. This
allows us to get rid of `USE_THE_REPOSITORY_VARIABLE`.

Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c                  |   4 +-
 builtin/branch.c          |   2 +-
 builtin/config.c          |   2 +-
 builtin/fsck.c            |   6 +--
 builtin/gc.c              |   2 +-
 builtin/notes.c           |   2 +-
 builtin/receive-pack.c    |   2 +-
 builtin/reflog.c          |   4 +-
 builtin/refs.c            |   2 +-
 builtin/worktree.c        |  24 +++++-----
 reachable.c               |   4 +-
 ref-filter.c              |   2 +-
 refs.c                    |   2 +-
 revision.c                |   6 +--
 setup.c                   |   7 +--
 submodule.c               |   2 +-
 t/helper/test-ref-store.c |   2 +-
 worktree.c                | 115 ++++++++++++++++++++++++++--------------------
 worktree.h                |  27 +++++++----
 19 files changed, 120 insertions(+), 97 deletions(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..b2ac403b19 100644
--- a/branch.c
+++ b/branch.c
@@ -394,7 +394,7 @@ static void prepare_checked_out_branches(void)
 		return;
 	initialized_checked_out_branches = 1;
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(the_repository);
 
 	while (worktrees[i]) {
 		char *old, *wt_gitdir;
@@ -846,7 +846,7 @@ void remove_branch_state(struct repository *r, int verbose)
 
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
 {
-	struct worktree **worktrees = get_worktrees();
+	struct worktree **worktrees = get_worktrees(the_repository);
 
 	for (int i = 0; worktrees[i]; i++) {
 		if (worktrees[i]->is_current && ignore_current_worktree)
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..c8fddf7f94 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -579,7 +579,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	const char *interpreted_oldname = NULL;
 	const char *interpreted_newname = NULL;
 	int recovery = 0, oldref_usage = 0;
-	struct worktree **worktrees = get_worktrees();
+	struct worktree **worktrees = get_worktrees(the_repository);
 
 	if (check_branch_ref(&oldref, oldname)) {
 		/*
diff --git a/builtin/config.c b/builtin/config.c
index 8d8ec0beea..0882899c3f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -974,7 +974,7 @@ static void location_options_init(struct config_location_options *opts,
 		opts->source.file = opts->file_to_free = repo_git_path(the_repository, "config");
 		opts->source.scope = CONFIG_SCOPE_LOCAL;
 	} else if (opts->use_worktree_config) {
-		struct worktree **worktrees = get_worktrees();
+		struct worktree **worktrees = get_worktrees(the_repository);
 		if (the_repository->repository_format_worktree_config)
 			opts->source.file = opts->file_to_free =
 				repo_git_path(the_repository, "config.worktree");
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 76b723f36d..a6c054e45b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -632,7 +632,7 @@ static void snapshot_refs(struct repository *repo,
 	refs_for_each_ref_ext(get_main_ref_store(repo),
 			      snapshot_ref, &data, &opts);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(repo);
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct strbuf refname = STRBUF_INIT;
@@ -685,7 +685,7 @@ static void process_refs(struct repository *repo, struct snapshot *snap)
 	}
 
 	if (include_reflogs) {
-		worktrees = get_worktrees();
+		worktrees = get_worktrees(repo);
 		for (p = worktrees; *p; p++) {
 			struct worktree *wt = *p;
 
@@ -1121,7 +1121,7 @@ int cmd_fsck(int argc,
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
 
-		worktrees = get_worktrees();
+		worktrees = get_worktrees(repo);
 		for (p = worktrees; *p; p++) {
 			struct worktree *wt = *p;
 			struct index_state istate =
diff --git a/builtin/gc.c b/builtin/gc.c
index d32af422af..46999a99ab 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -412,7 +412,7 @@ static int worktree_prune_condition(struct gc_config *cfg)
 	while (limit && (d = readdir_skip_dot_and_dotdot(dir))) {
 		char *wtpath;
 		strbuf_reset(&buf);
-		if (should_prune_worktree(d->d_name, &buf, &wtpath, expiry_date))
+		if (should_prune_worktree(the_repository, d->d_name, &buf, &wtpath, expiry_date))
 			limit--;
 		free(wtpath);
 	}
diff --git a/builtin/notes.c b/builtin/notes.c
index 962df867c8..9f1f0ec840 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -989,7 +989,7 @@ static int merge(int argc, const char **argv, const char *prefix,
 				"NOTES_MERGE_PARTIAL", &result_oid, NULL,
 				0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
-		worktrees = get_worktrees();
+		worktrees = get_worktrees(the_repository);
 		wt = find_shared_symref(worktrees, "NOTES_MERGE_REF",
 					notes_ref);
 		if (wt)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 19eb6a1b61..b246c1ccae 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1503,7 +1503,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	struct object_id *old_oid = &cmd->old_oid;
 	struct object_id *new_oid = &cmd->new_oid;
 	int do_update_worktree = 0;
-	struct worktree **worktrees = get_worktrees();
+	struct worktree **worktrees = get_worktrees(the_repository);
 	const struct worktree *worktree =
 		find_shared_symref(worktrees, "HEAD", name);
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index dcbfe89339..1211c58fa4 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -250,7 +250,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 		struct string_list_item *item;
 		struct worktree **worktrees, **p;
 
-		worktrees = get_worktrees();
+		worktrees = get_worktrees(the_repository);
 		for (p = worktrees; *p; p++) {
 			if (single_worktree && !(*p)->is_current)
 				continue;
@@ -374,7 +374,7 @@ static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
 		struct string_list_item *item;
 		struct worktree **worktrees, **p;
 
-		worktrees = get_worktrees();
+		worktrees = get_worktrees(the_repository);
 		for (p = worktrees; *p; p++) {
 			if (single_worktree && !(*p)->is_current)
 				continue;
diff --git a/builtin/refs.c b/builtin/refs.c
index a9ca2058ee..5cd21c25fe 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -113,7 +113,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	repo_config(repo, git_fsck_config, &fsck_refs_options);
 	prepare_repo_settings(repo);
 
-	worktrees = get_worktrees_without_reading_head();
+	worktrees = get_worktrees_without_reading_head(repo);
 	for (size_t i = 0; worktrees[i]; i++)
 		ret |= refs_fsck(get_worktree_ref_store(worktrees[i]),
 				 &fsck_refs_options, worktrees[i]);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d21c43fde3..0689b3d3e0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -226,7 +226,7 @@ static void prune_worktrees(void)
 	while ((d = readdir_skip_dot_and_dotdot(dir)) != NULL) {
 		char *path;
 		strbuf_reset(&reason);
-		if (should_prune_worktree(d->d_name, &reason, &path, expire))
+		if (should_prune_worktree(the_repository, d->d_name, &reason, &path, expire))
 			prune_worktree(d->d_name, reason.buf);
 		else if (path)
 			string_list_append_nodup(&kept, path)->util = xstrdup(d->d_name);
@@ -475,7 +475,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct ref_store *wt_refs;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(the_repository);
 	check_candidate_path(path, opts->force, worktrees, "add");
 	free_worktrees(worktrees);
 	worktrees = NULL;
@@ -539,7 +539,8 @@ static int add_worktree(const char *path, const char *refname,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-	write_worktree_linking_files(sb_git.buf, sb.buf, opts->relative_paths);
+	write_worktree_linking_files(the_repository, sb_git.buf,
+				     sb.buf, opts->relative_paths);
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
@@ -547,7 +548,7 @@ static int add_worktree(const char *path, const char *refname,
 	/*
 	 * Set up the ref store of the worktree and create the HEAD reference.
 	 */
-	wt = get_linked_worktree(name, 1);
+	wt = get_linked_worktree(the_repository, name, 1);
 	if (!wt) {
 		ret = error(_("could not find created worktree '%s'"), name);
 		goto done;
@@ -1103,7 +1104,7 @@ static int list(int ac, const char **av, const char *prefix,
 	else if (!line_terminator && !porcelain)
 		die(_("the option '%s' requires '%s'"), "-z", "--porcelain");
 	else {
-		struct worktree **worktrees = get_worktrees();
+		struct worktree **worktrees = get_worktrees(the_repository);
 		int path_maxwidth = 0, abbrev = DEFAULT_ABBREV, i;
 		struct worktree_display *display = NULL;
 
@@ -1146,7 +1147,7 @@ static int lock_worktree(int ac, const char **av, const char *prefix,
 	if (ac != 1)
 		usage_with_options(git_worktree_lock_usage, options);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(the_repository);
 	wt = find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
 		die(_("'%s' is not a working tree"), av[0]);
@@ -1183,7 +1184,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix,
 	if (ac != 1)
 		usage_with_options(git_worktree_unlock_usage, options);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(the_repository);
 	wt = find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
 		die(_("'%s' is not a working tree"), av[0]);
@@ -1269,7 +1270,7 @@ static int move_worktree(int ac, const char **av, const char *prefix,
 	strbuf_addstr(&dst, path);
 	free(path);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(the_repository);
 	wt = find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
 		die(_("'%s' is not a working tree"), av[0]);
@@ -1394,7 +1395,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix,
 	if (ac != 1)
 		usage_with_options(git_worktree_remove_usage, options);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(the_repository);
 	wt = find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
 		die(_("'%s' is not a working tree"), av[0]);
@@ -1456,8 +1457,9 @@ static int repair(int ac, const char **av, const char *prefix,
 	ac = parse_options(ac, av, prefix, options, git_worktree_repair_usage, 0);
 	p = ac > 0 ? av : self;
 	for (; *p; p++)
-		repair_worktree_at_path(*p, report_repair, &rc, use_relative_paths);
-	repair_worktrees(report_repair, &rc, use_relative_paths);
+		repair_worktree_at_path(the_repository, *p, report_repair,
+					&rc, use_relative_paths);
+	repair_worktrees(the_repository, report_repair, &rc, use_relative_paths);
 	return rc;
 }
 
diff --git a/reachable.c b/reachable.c
index 101cfc2727..be87f487d8 100644
--- a/reachable.c
+++ b/reachable.c
@@ -62,7 +62,7 @@ static void add_rebase_files(struct rev_info *revs)
 		"rebase-merge/autostash",
 		"rebase-merge/orig-head",
 	};
-	struct worktree **worktrees = get_worktrees();
+	struct worktree **worktrees = get_worktrees(the_repository);
 
 	for (struct worktree **wt = worktrees; *wt; wt++) {
 		char *wt_gitdir = get_worktree_git_dir(*wt);
@@ -319,7 +319,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 
 	/* detached HEAD is not included in the list above */
 	refs_head_ref(get_main_ref_store(the_repository), add_one_ref, revs);
-	other_head_refs(add_one_ref, revs);
+	other_head_refs(the_repository, add_one_ref, revs);
 
 	/* rebase autostash and orig-head */
 	add_rebase_files(revs);
diff --git a/ref-filter.c b/ref-filter.c
index 284796c49b..29aca08ce7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2402,7 +2402,7 @@ static void lazy_init_worktree_map(void)
 	if (ref_to_worktree_map.worktrees)
 		return;
 
-	ref_to_worktree_map.worktrees = get_worktrees();
+	ref_to_worktree_map.worktrees = get_worktrees(the_repository);
 	hashmap_init(&(ref_to_worktree_map.map), ref_to_worktree_map_cmpfnc, NULL, 0);
 	populate_worktree_map(&(ref_to_worktree_map.map), ref_to_worktree_map.worktrees);
 }
diff --git a/refs.c b/refs.c
index 1d24637891..d9957a266c 100644
--- a/refs.c
+++ b/refs.c
@@ -3328,7 +3328,7 @@ static int move_files(const char *from_path, const char *to_path, struct strbuf
 
 static int has_worktrees(void)
 {
-	struct worktree **worktrees = get_worktrees();
+	struct worktree **worktrees = get_worktrees(the_repository);
 	int ret = 0;
 	size_t i;
 
diff --git a/revision.c b/revision.c
index 0c95edef59..7dd40a31d3 100644
--- a/revision.c
+++ b/revision.c
@@ -1711,7 +1711,7 @@ static void add_other_reflogs_to_pending(struct all_refs_cb *cb)
 {
 	struct worktree **worktrees, **p;
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(the_repository);
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 
@@ -1837,7 +1837,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	if (revs->single_worktree)
 		return;
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(the_repository);
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct index_state istate = INDEX_STATE_INIT(revs->repo);
@@ -2813,7 +2813,7 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 			struct all_refs_cb cb;
 
 			init_all_refs_cb(&cb, revs, *flags);
-			other_head_refs(handle_one_ref, &cb);
+			other_head_refs(the_repository, handle_one_ref, &cb);
 		}
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
diff --git a/setup.c b/setup.c
index 0de56a074f..505e8d7bf2 100644
--- a/setup.c
+++ b/setup.c
@@ -2650,7 +2650,8 @@ static void create_object_directory(struct repository *repo)
 	strbuf_release(&path);
 }
 
-static void separate_git_dir(const char *git_dir, const char *git_link)
+static void separate_git_dir(struct repository *repo,
+			     const char *git_dir, const char *git_link)
 {
 	struct stat st;
 
@@ -2666,7 +2667,7 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 
 		if (rename(src, git_dir))
 			die_errno(_("unable to move %s to %s"), src, git_dir);
-		repair_worktrees_after_gitdir_move(src);
+		repair_worktrees_after_gitdir_move(repo, src);
 	}
 
 	write_file(git_link, "gitdir: %s", git_dir);
@@ -2823,7 +2824,7 @@ int init_db(struct repository *repo,
 
 		set_git_dir(repo, real_git_dir, 1);
 		git_dir = repo_get_git_dir(repo);
-		separate_git_dir(git_dir, original_git_dir);
+		separate_git_dir(repo, git_dir, original_git_dir);
 	}
 	else {
 		set_git_dir(repo, git_dir, 1);
diff --git a/submodule.c b/submodule.c
index 93d0361072..c6dda4d156 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2494,7 +2494,7 @@ static void relocate_single_git_dir_into_superproject(const char *path,
 	if (validate_submodule_path(path) < 0)
 		exit(128);
 
-	if (submodule_uses_worktrees(path))
+	if (submodule_uses_worktrees(the_repository, path))
 		die(_("relocate_gitdir for submodule '%s' with "
 		      "more than one worktree not supported"), path);
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 3866d0aca4..5a9a3053d9 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -84,7 +84,7 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 
 		*refs = repo_get_submodule_ref_store(the_repository, gitdir);
 	} else if (skip_prefix(argv[0], "worktree:", &gitdir)) {
-		struct worktree **p, **worktrees = get_worktrees();
+		struct worktree **p, **worktrees = get_worktrees(the_repository);
 
 		for (p = worktrees; *p; p++) {
 			struct worktree *wt = *p;
diff --git a/worktree.c b/worktree.c
index ebbf9e27e9..cbf95328a3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -139,7 +138,8 @@ static struct worktree *get_main_worktree(struct repository *repo,
 	return worktree;
 }
 
-struct worktree *get_linked_worktree(const char *id,
+struct worktree *get_linked_worktree(struct repository *repo,
+				     const char *id,
 				     int skip_reading_head)
 {
 	struct worktree *worktree = NULL;
@@ -149,7 +149,7 @@ struct worktree *get_linked_worktree(const char *id,
 	if (!id)
 		die("Missing linked worktree name");
 
-	repo_common_path_append(the_repository, &path, "worktrees/%s/gitdir", id);
+	repo_common_path_append(repo, &path, "worktrees/%s/gitdir", id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
 		/* invalid gitdir file */
 		goto done;
@@ -163,7 +163,7 @@ struct worktree *get_linked_worktree(const char *id,
 	}
 
 	CALLOC_ARRAY(worktree, 1);
-	worktree->repo = the_repository;
+	worktree->repo = repo;
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->id = xstrdup(id);
 	worktree->is_current = is_current_worktree(worktree);
@@ -203,7 +203,7 @@ static struct worktree **get_worktrees_internal(struct repository *repo,
 		while ((d = readdir_skip_dot_and_dotdot(dir)) != NULL) {
 			struct worktree *linked = NULL;
 
-			if ((linked = get_linked_worktree(d->d_name, skip_reading_head))) {
+			if ((linked = get_linked_worktree(repo, d->d_name, skip_reading_head))) {
 				ALLOC_GROW(list, counter + 1, alloc);
 				list[counter++] = linked;
 			}
@@ -216,14 +216,14 @@ static struct worktree **get_worktrees_internal(struct repository *repo,
 	return list;
 }
 
-struct worktree **get_worktrees(void)
+struct worktree **get_worktrees(struct repository *repo)
 {
-	return get_worktrees_internal(the_repository, 0);
+	return get_worktrees_internal(repo, 0);
 }
 
-struct worktree **get_worktrees_without_reading_head(void)
+struct worktree **get_worktrees_without_reading_head(struct repository *repo)
 {
-	return get_worktrees_internal(the_repository, 1);
+	return get_worktrees_internal(repo, 1);
 }
 
 char *get_worktree_git_dir(const struct worktree *wt)
@@ -336,7 +336,7 @@ const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
 	if (wt->prune_reason_valid)
 		return wt->prune_reason;
 
-	if (should_prune_worktree(wt->id, &reason, &path, expire))
+	if (should_prune_worktree(wt->repo, wt->id, &reason, &path, expire))
 		wt->prune_reason = strbuf_detach(&reason, NULL);
 	wt->prune_reason_valid = 1;
 
@@ -447,7 +447,8 @@ void update_worktree_location(struct worktree *wt, const char *path_,
 	strbuf_realpath(&path, path_, 1);
 	strbuf_addf(&dotgit, "%s/.git", path.buf);
 	if (fspathcmp(wt->path, path.buf)) {
-		write_worktree_linking_files(dotgit.buf, gitdir.buf, use_relative_paths);
+		write_worktree_linking_files(wt->repo, dotgit.buf,
+					     gitdir.buf, use_relative_paths);
 
 		free(wt->path);
 		wt->path = strbuf_detach(&path, NULL);
@@ -535,7 +536,8 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
 	return NULL;
 }
 
-int submodule_uses_worktrees(const char *path)
+int submodule_uses_worktrees(struct repository *repo,
+			     const char *path)
 {
 	char *submodule_gitdir;
 	struct strbuf sb = STRBUF_INIT, err = STRBUF_INIT;
@@ -544,7 +546,7 @@ int submodule_uses_worktrees(const char *path)
 	int ret = 0;
 	struct repository_format format = REPOSITORY_FORMAT_INIT;
 
-	submodule_gitdir = repo_submodule_path(the_repository,
+	submodule_gitdir = repo_submodule_path(repo,
 					       path, "%s", "");
 	if (!submodule_gitdir)
 		return 0;
@@ -597,13 +599,14 @@ void strbuf_worktree_ref(const struct worktree *wt,
 	strbuf_addstr(sb, refname);
 }
 
-int other_head_refs(refs_for_each_cb fn, void *cb_data)
+int other_head_refs(struct repository *repo,
+		    refs_for_each_cb fn, void *cb_data)
 {
 	struct worktree **worktrees, **p;
 	struct strbuf refname = STRBUF_INIT;
 	int ret = 0;
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(repo);
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct object_id oid;
@@ -614,7 +617,7 @@ int other_head_refs(refs_for_each_cb fn, void *cb_data)
 
 		strbuf_reset(&refname);
 		strbuf_worktree_ref(wt, &refname, "HEAD");
-		if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+		if (refs_resolve_ref_unsafe(get_main_ref_store(repo),
 					    refname.buf,
 					    RESOLVE_REF_READING,
 					    &oid, &flag)) {
@@ -687,7 +690,8 @@ static void repair_gitfile(struct worktree *wt,
 
 	if (repair) {
 		fn(0, wt->path, repair, cb_data);
-		write_worktree_linking_files(dotgit.buf, gitdir.buf, use_relative_paths);
+		write_worktree_linking_files(wt->repo, dotgit.buf,
+					     gitdir.buf, use_relative_paths);
 	}
 
 done:
@@ -707,9 +711,10 @@ static void repair_noop(int iserr UNUSED,
 	/* nothing */
 }
 
-void repair_worktrees(worktree_repair_fn fn, void *cb_data, int use_relative_paths)
+void repair_worktrees(struct repository *repo, worktree_repair_fn fn,
+		      void *cb_data, int use_relative_paths)
 {
-	struct worktree **worktrees = get_worktrees_internal(the_repository, 1);
+	struct worktree **worktrees = get_worktrees_internal(repo, 1);
 	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
 
 	if (!fn)
@@ -745,16 +750,17 @@ void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path
 	if (!file_exists(dotgit.buf))
 		goto done;
 
-	write_worktree_linking_files(dotgit.buf, gitdir.buf, is_relative_path);
+	write_worktree_linking_files(wt->repo, dotgit.buf,
+				     gitdir.buf, is_relative_path);
 done:
 	strbuf_release(&gitdir);
 	strbuf_release(&dotgit);
 	free(path);
 }
 
-void repair_worktrees_after_gitdir_move(const char *old_path)
+void repair_worktrees_after_gitdir_move(struct repository *repo, const char *old_path)
 {
-	struct worktree **worktrees = get_worktrees_internal(the_repository, 1);
+	struct worktree **worktrees = get_worktrees_internal(repo, 1);
 	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
 
 	for (; *wt; wt++)
@@ -762,7 +768,7 @@ void repair_worktrees_after_gitdir_move(const char *old_path)
 	free_worktrees(worktrees);
 }
 
-static int is_main_worktree_path(const char *path)
+static int is_main_worktree_path(struct repository *repo, const char *path)
 {
 	struct strbuf target = STRBUF_INIT;
 	struct strbuf maindir = STRBUF_INIT;
@@ -770,7 +776,7 @@ static int is_main_worktree_path(const char *path)
 
 	strbuf_add_real_path(&target, path);
 	strbuf_strip_suffix(&target, "/.git");
-	strbuf_add_real_path(&maindir, repo_get_common_dir(the_repository));
+	strbuf_add_real_path(&maindir, repo_get_common_dir(repo));
 	strbuf_strip_suffix(&maindir, "/.git");
 	cmp = fspathcmp(maindir.buf, target.buf);
 
@@ -821,7 +827,8 @@ static ssize_t infer_backlink(struct repository *repo,
  * Repair <repo>/worktrees/<id>/gitdir if missing, corrupt, or not pointing at
  * the worktree's path.
  */
-void repair_worktree_at_path(const char *path,
+void repair_worktree_at_path(struct repository *repo,
+			     const char *path,
 			     worktree_repair_fn fn, void *cb_data,
 			     int use_relative_paths)
 {
@@ -837,7 +844,7 @@ void repair_worktree_at_path(const char *path,
 	if (!fn)
 		fn = repair_noop;
 
-	if (is_main_worktree_path(path))
+	if (is_main_worktree_path(repo, path))
 		goto done;
 
 	strbuf_addf(&dotgit, "%s/.git", path);
@@ -846,7 +853,7 @@ void repair_worktree_at_path(const char *path,
 		goto done;
 	}
 
-	infer_backlink(the_repository, dotgit.buf, &inferred_backlink);
+	infer_backlink(repo, dotgit.buf, &inferred_backlink);
 	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
 	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
 	if (dotgit_contents) {
@@ -919,7 +926,8 @@ void repair_worktree_at_path(const char *path,
 
 	if (repair) {
 		fn(0, gitdir.buf, repair, cb_data);
-		write_worktree_linking_files(dotgit.buf, gitdir.buf, use_relative_paths);
+		write_worktree_linking_files(repo, dotgit.buf,
+					     gitdir.buf, use_relative_paths);
 	}
 done:
 	free(dotgit_contents);
@@ -930,12 +938,16 @@ void repair_worktree_at_path(const char *path,
 	strbuf_release(&dotgit);
 }
 
-int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath, timestamp_t expire)
+int should_prune_worktree(struct repository *repo,
+			  const char *id,
+			  struct strbuf *reason,
+			  char **wtpath,
+			  timestamp_t expire)
 {
 	struct stat st;
 	struct strbuf dotgit = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
-	struct strbuf repo = STRBUF_INIT;
+	struct strbuf repo_path = STRBUF_INIT;
 	struct strbuf file = STRBUF_INIT;
 	char *path = NULL;
 	int rc = 0;
@@ -945,17 +957,17 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 
 	*wtpath = NULL;
 
-	path = repo_common_path(the_repository, "worktrees/%s", id);
-	strbuf_realpath(&repo, path, 1);
+	path = repo_common_path(repo, "worktrees/%s", id);
+	strbuf_realpath(&repo_path, path, 1);
 	FREE_AND_NULL(path);
 
-	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
-	if (!is_directory(repo.buf)) {
+	strbuf_addf(&gitdir, "%s/gitdir", repo_path.buf);
+	if (!is_directory(repo_path.buf)) {
 		strbuf_addstr(reason, _("not a valid directory"));
 		rc = 1;
 		goto done;
 	}
-	strbuf_addf(&file, "%s/locked", repo.buf);
+	strbuf_addf(&file, "%s/locked", repo_path.buf);
 	if (file_exists(file.buf)) {
 		goto done;
 	}
@@ -999,12 +1011,12 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 	if (is_absolute_path(path)) {
 		strbuf_addstr(&dotgit, path);
 	} else {
-		strbuf_addf(&dotgit, "%s/%s", repo.buf, path);
+		strbuf_addf(&dotgit, "%s/%s", repo_path.buf, path);
 		strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
 	}
 	if (!file_exists(dotgit.buf)) {
 		strbuf_reset(&file);
-		strbuf_addf(&file, "%s/index", repo.buf);
+		strbuf_addf(&file, "%s/index", repo_path.buf);
 		if (stat(file.buf, &st) || st.st_mtime <= expire) {
 			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
 			rc = 1;
@@ -1016,7 +1028,7 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 	free(path);
 	strbuf_release(&dotgit);
 	strbuf_release(&gitdir);
-	strbuf_release(&repo);
+	strbuf_release(&repo_path);
 	strbuf_release(&file);
 	return rc;
 }
@@ -1094,37 +1106,38 @@ int init_worktree_config(struct repository *r)
 	return res;
 }
 
-void write_worktree_linking_files(const char *dotgit, const char *gitdir,
+void write_worktree_linking_files(struct repository *repo,
+				  const char *dotgit, const char *gitdir,
 				  int use_relative_paths)
 {
 	struct strbuf path = STRBUF_INIT;
-	struct strbuf repo = STRBUF_INIT;
+	struct strbuf repo_path = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 
 	strbuf_addstr(&path, dotgit);
 	strbuf_strip_suffix(&path, "/.git");
 	strbuf_realpath(&path, path.buf, 1);
-	strbuf_addstr(&repo, gitdir);
-	strbuf_strip_suffix(&repo, "/gitdir");
-	strbuf_realpath(&repo, repo.buf, 1);
+	strbuf_addstr(&repo_path, gitdir);
+	strbuf_strip_suffix(&repo_path, "/gitdir");
+	strbuf_realpath(&repo_path, repo_path.buf, 1);
 
-	if (use_relative_paths && !the_repository->repository_format_relative_worktrees) {
-		if (upgrade_repository_format(the_repository, 1) < 0)
+	if (use_relative_paths && !repo->repository_format_relative_worktrees) {
+		if (upgrade_repository_format(repo, 1) < 0)
 			die(_("unable to upgrade repository format to support relative worktrees"));
-		if (repo_config_set_gently(the_repository, "extensions.relativeWorktrees", "true"))
+		if (repo_config_set_gently(repo, "extensions.relativeWorktrees", "true"))
 			die(_("unable to set extensions.relativeWorktrees setting"));
-		the_repository->repository_format_relative_worktrees = 1;
+		repo->repository_format_relative_worktrees = 1;
 	}
 
 	if (use_relative_paths) {
-		write_file(gitdir, "%s/.git", relative_path(path.buf, repo.buf, &tmp));
-		write_file(dotgit, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
+		write_file(gitdir, "%s/.git", relative_path(path.buf, repo_path.buf, &tmp));
+		write_file(dotgit, "gitdir: %s", relative_path(repo_path.buf, path.buf, &tmp));
 	} else {
 		write_file(gitdir, "%s/.git", path.buf);
-		write_file(dotgit, "gitdir: %s", repo.buf);
+		write_file(dotgit, "gitdir: %s", repo_path.buf);
 	}
 
 	strbuf_release(&path);
-	strbuf_release(&repo);
+	strbuf_release(&repo_path);
 	strbuf_release(&tmp);
 }
diff --git a/worktree.h b/worktree.h
index 1075409f9a..fbb2757f5b 100644
--- a/worktree.h
+++ b/worktree.h
@@ -28,7 +28,7 @@ struct worktree {
  * The caller is responsible for freeing the memory from the returned
  * worktrees by calling free_worktrees().
  */
-struct worktree **get_worktrees(void);
+struct worktree **get_worktrees(struct repository *repo);
 
 /*
  * Like `get_worktrees`, but does not read HEAD. Skip reading HEAD allows to
@@ -36,7 +36,7 @@ struct worktree **get_worktrees(void);
  * the HEAD ref. This is useful in contexts where it is assumed that the
  * refdb may not be in a consistent state.
  */
-struct worktree **get_worktrees_without_reading_head(void);
+struct worktree **get_worktrees_without_reading_head(struct repository *repo);
 
 /*
  * Construct a struct worktree corresponding to repo->gitdir and
@@ -47,7 +47,7 @@ struct worktree *get_current_worktree(struct repository *repo);
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */
-int submodule_uses_worktrees(const char *path);
+int submodule_uses_worktrees(struct repository *repo, const char *path);
 
 /*
  * Return git dir of the worktree. Note that the path may be relative.
@@ -76,7 +76,8 @@ struct worktree *find_worktree(struct worktree **list,
  * Look up the worktree corresponding to `id`, or NULL of no such worktree
  * exists.
  */
-struct worktree *get_linked_worktree(const char *id,
+struct worktree *get_linked_worktree(struct repository *repo,
+				     const char *id,
 				     int skip_reading_head);
 
 /*
@@ -112,7 +113,8 @@ const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire);
  * `expire` defines a grace period to prune the worktree when its path
  * does not exist.
  */
-int should_prune_worktree(const char *id,
+int should_prune_worktree(struct repository *repo,
+			  const char *id,
 			  struct strbuf *reason,
 			  char **wtpath,
 			  timestamp_t expire);
@@ -142,12 +144,14 @@ typedef void (* worktree_repair_fn)(int iserr, const char *path,
  * function, if non-NULL, is called with the path of the worktree and a
  * description of the repair or error, along with the callback user-data.
  */
-void repair_worktrees(worktree_repair_fn, void *cb_data, int use_relative_paths);
+void repair_worktrees(struct repository *repo, worktree_repair_fn,
+		      void *cb_data, int use_relative_paths);
 
 /*
  * Repair the linked worktrees after the gitdir has been moved.
  */
-void repair_worktrees_after_gitdir_move(const char *old_path);
+void repair_worktrees_after_gitdir_move(struct repository *repo,
+					const char *old_path);
 
 /*
  * Repair the linked worktree after the gitdir has been moved.
@@ -164,7 +168,9 @@ void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path
  * worktree and a description of the repair or error, along with the callback
  * user-data.
  */
-void repair_worktree_at_path(const char *, worktree_repair_fn,
+void repair_worktree_at_path(struct repository *repo,
+			     const char *path,
+			     worktree_repair_fn fn,
 			     void *cb_data, int use_relative_paths);
 
 /*
@@ -196,7 +202,7 @@ int is_shared_symref(const struct worktree *wt,
  * Similar to head_ref() for all HEADs _except_ one from the current
  * worktree, which is covered by head_ref().
  */
-int other_head_refs(refs_for_each_cb fn, void *cb_data);
+int other_head_refs(struct repository *repo, refs_for_each_cb fn, void *cb_data);
 
 int is_worktree_being_rebased(const struct worktree *wt, const char *target);
 int is_worktree_being_bisected(const struct worktree *wt, const char *target);
@@ -239,7 +245,8 @@ int init_worktree_config(struct repository *r);
  *  dotgit: "/path/to/foo/.git"
  *  gitdir: "/path/to/repo/worktrees/foo/gitdir"
  */
-void write_worktree_linking_files(const char *dotgit, const char *gitdir,
+void write_worktree_linking_files(struct repository *repo,
+				  const char *dotgit, const char *gitdir,
 				  int use_relative_paths);
 
 #endif

-- 
2.55.0.313.g8d093f411d.dirty

