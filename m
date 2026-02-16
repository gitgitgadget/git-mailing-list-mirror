Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DF332911
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258723; cv=none; b=mHb8Kx6IytOi9awXmbf/i/KzJ0Nn45B2TGKEg9vDnVJeA3dw05XzrgowWrYLGDaNoiw6+gUUFYTxTebS4vOQMXOgw+ImwRTu9QMIhC6AIH93tnPCDXKW2RfrUvLqNPFV49/46UfU0oubf0Szxf+BGwfRHFPOGRVIuHUI4+tZ/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258723; c=relaxed/simple;
	bh=mF4N1uJCBscep2tLlnbE0W2T8WZOIC6P2pSOW3k+TxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6k8e/F+bCP1C6lqJX1mfJ7d5gSQ8iEhCU+PsgpkGMasp082V6rmOkV+dxaDBWxWGmUU9M8nLWI4R5M78wCJBbIBfcaeLawVYuUe31DlWGic7/L3DB0NIBMeB/hn8zhFo+hX9tMOB36erLN//ekp+21/jcrl6XiCHSTUcynzbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDUf6kFd; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDUf6kFd"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43591b55727so3810451f8f.3
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 08:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771258720; x=1771863520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azV08lKoDCRkIAOnoP7nqogMEvyhyhNnvV7fWKrCCxo=;
        b=MDUf6kFd53CFOWL3DQVg4GZXcXLz7AF2bJ+YAB3RLHGKcSOvDoUdSBvalsQBYkyYno
         x0UNITtBOJFjKXYnJPbrQv6sJkes1VxQOGvAfrIoYvhlAjlDuh9/ZBf7IRuHaJ1lVkqL
         r/s0ce9vYuv2PUwxhJxYc8kEjKD42mKXhabHE+iGTF3J9sh8z4Faa83tCVvER6VlGU+P
         VMF4KSMY8rR4Uw00+58D23DWcanzXytUPDkrDGFu3vaoAazNot0rSiL4rwKqJpbPbTL7
         CXxQIR2FeUfo/nhZBexxKlTRWw52Ns+DLfViqq6x3wOZ/hh6tBhbZ/lwUzSy1Scd0bJN
         Zg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771258720; x=1771863520;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azV08lKoDCRkIAOnoP7nqogMEvyhyhNnvV7fWKrCCxo=;
        b=l2j/427p3o7Qus+SuK7O2IArmJXrp+xWslCxsPcokEQR6zCzkRyelBt76ijrNXnz2n
         cbVU/OrCkinJPu2f1o/qvpEMvZ+IO+lgc6mIJ5vEJ6nsSEurm5tlU4sJhsfVdFTVjHsL
         tczzMCWKj2z6d+rayZFHqib4kZn9uxJyUrwRhZwqtyF82BGYJiV0AHLiygQkpW3JpCC0
         oERYRxAzG3y/mglvl4SXezjM/uMwqZT/Nb34BJcyfFH6WoooW6j+F2XszmZceD4kh7UW
         l0O4loqi60JiUkKEOlqN1Asbp+XFtVV7bJM3aaoR4XwhQpfSuRuLoCrs+D1vImkGOH5U
         ODxw==
X-Gm-Message-State: AOJu0Yw4+EhYDgoU7N7kFUpKxcpNuKlr27jvghcgWbwScaPa/IjoS49z
	wdBCJLt9VBWelwjJGGoDL0gjiPAl9xH9w0ymUIw7nAtSK3HFDaeZIJHnCTn6PB8t
X-Gm-Gg: AZuq6aJfri4K68/cP7KRUxQZGdhpFRw8xNfwTgi1gnIeQhWukDHUUr1KXM+uBDOI0Fy
	vYLoA2yjfsum3R8MRThpXP3E5VP2/v3UyzCQuZt9TijLYw12yacvtcnyPBVIhXftpaS8k84qPBX
	ZMSckUeKAucQAU9gRnu601v6RrI31ld2Bjmp4TnSghIMC3UkoELAenNaLHXz4U9+6IqSa4En8GQ
	NPcrwUClxmYPILBpG3zPgGwIc1CaMfI0KvzKq/sjPVkGaI0o4zB1sb+ttSI7W4uXCvRbPjxcBmk
	k+8mQRCuMx+A/B2ygpxrGoCPc7LOGO8IiBLfb3w2LdE+P6Jt3kXMJZBHAd85gLOTbcMiwsfezD6
	bdpMKEu/WZ89YHvd5ZG1wU0MbnVVjc/HfjmLwyg/CC5G0iiDeYw8nXu7Cb8bgtP8V6zeBneLgrG
	Uq945dys1+mUPO4jomOUuO6lLzR/E=
X-Received: by 2002:a05:6000:402b:b0:437:6e6e:6f95 with SMTP id ffacd0b85a97d-4379db70171mr15867456f8f.27.1771258719696;
        Mon, 16 Feb 2026 08:18:39 -0800 (PST)
Received: from berwick ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc8b1sm29396714f8f.23.2026.02.16.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:18:39 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/2] wt-status: avoid passing NULL worktree
Date: Mon, 16 Feb 2026 16:18:09 +0000
Message-ID: <409871a7d521b76c9eb811d3c49747e04de8defc.1771258688.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com> <cover.1771258688.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In preparation for removing the repository argument from
worktree_git_path() add a function to construct a "struct worktree"
from a "struct repository" and use that to avoid passing a NULL
worktree to wt_status_check_bisect() and wt_status_check_rebase().

wt_status_check_bisect() and wt_status_check_rebase() have the following
callers:

 - branch.c:prepare_checked_out_branches() which loops over all
   worktrees.

 - worktree.c:is_worktree_being_rebased() which is called from
   builtin/branch.c:reject_rebase_or_bisect_branch() that loops over all
   worktrees and worktree.c:is_shared_symref() which dereferences wt
   earlier in the function.

 - wt-status:wt_status_get_state() which is updated to avoid passing a
   NULL worktree by this patch.

This updates the only callers that pass a NULL worktree to
worktree_git_path().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 worktree.c  | 20 ++++++++++++++++++++
 worktree.h  |  5 ++++-
 wt-status.c | 15 ++++++++++++---
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/worktree.c b/worktree.c
index 9308389cb6f..fd182c319b7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -66,6 +66,26 @@ static int is_current_worktree(struct worktree *wt)
 	return is_current;
 }
 
+struct worktree *get_worktree_from_repository(struct repository *repo)
+{
+	struct worktree *wt = xcalloc(1, sizeof(*wt));
+	char *gitdir = absolute_pathdup(repo->gitdir);
+	char *commondir = absolute_pathdup(repo->commondir);
+
+	wt->repo = repo;
+	if (repo->worktree)
+		wt->path = absolute_pathdup(repo->worktree);
+	wt->is_bare = !!repo->worktree;
+	if (fspathcmp(gitdir, commondir))
+		wt->id = xstrdup(find_last_dir_sep(commondir) + 1);
+	wt->is_current = is_current_worktree(wt);
+	add_head_info(wt);
+
+	free(gitdir);
+	free(commondir);
+	return wt;
+}
+
 /*
 * When in a secondary worktree, and when extensions.worktreeConfig
 * is true, only $commondir/config and $commondir/worktrees/<id>/
diff --git a/worktree.h b/worktree.h
index e4bcccdc0ae..b162bbabd50 100644
--- a/worktree.h
+++ b/worktree.h
@@ -38,7 +38,10 @@ struct worktree **get_worktrees(void);
  */
 struct worktree **get_worktrees_without_reading_head(void);
 
-/*
+/* Construct a struct worktree from a struct repository */
+struct worktree *get_worktree_from_repository(struct repository *repo);
+
+ /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */
 int submodule_uses_worktrees(const char *path);
diff --git a/wt-status.c b/wt-status.c
index 95942399f8c..2debda534c1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1747,6 +1747,9 @@ int wt_status_check_rebase(const struct worktree *wt,
 {
 	struct stat st;
 
+	if (!wt)
+		BUG("wt_status_check_rebase() called with NULL worktree");
+
 	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
 		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
 			state->am_in_progress = 1;
@@ -1774,6 +1777,9 @@ int wt_status_check_bisect(const struct worktree *wt,
 {
 	struct stat st;
 
+	if (!wt)
+		BUG("wt_status_check_bisect() called with NULL worktree");
+
 	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
 		state->bisecting_from = get_branch(wt, "BISECT_START");
@@ -1819,18 +1825,19 @@ void wt_status_get_state(struct repository *r,
 	struct stat st;
 	struct object_id oid;
 	enum replay_action action;
+	struct worktree *wt = get_worktree_from_repository(r);
 
 	if (!stat(git_path_merge_head(r), &st)) {
-		wt_status_check_rebase(NULL, state);
+		wt_status_check_rebase(wt, state);
 		state->merge_in_progress = 1;
-	} else if (wt_status_check_rebase(NULL, state)) {
+	} else if (wt_status_check_rebase(wt, state)) {
 		;		/* all set */
 	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 		   !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
-	wt_status_check_bisect(NULL, state);
+	wt_status_check_bisect(wt, state);
 	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
 	    !repo_get_oid(r, "REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
@@ -1848,6 +1855,8 @@ void wt_status_get_state(struct repository *r,
 	if (get_detached_from)
 		wt_status_get_detached_from(r, state);
 	wt_status_check_sparse_checkout(r, state);
+
+	free_worktree(wt);
 }
 
 static void wt_longstatus_print_state(struct wt_status *s)
-- 
2.52.0.362.g884e03848a9

