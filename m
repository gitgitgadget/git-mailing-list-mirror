Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A625363C47
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453607; cv=none; b=KHN0GN0Uub6aJawRTouPCemYISAQ6eLGFRinpoSIEp+aHXLja8gb6yF01D9EXj8HsJ0Y+IDXSLcrg5dps53LuHqzaGGeDcbjNpPf3vhlicp3W1eiqs2UuVR1zau4c7I0D6RScb+DzWhqGhNUQN0Wxy1ZaxEOhstyfK+f1M7go4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453607; c=relaxed/simple;
	bh=ZtfWDv3SGXM2Gy6CKVtTV4xNc56Rlae98A3G9AJnNRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7Q3011j7KKY1ci62Y2mMC+WcukaMnDK0g2mGP3Ofzn4H7rQHjxPeOF+GfPftBNJg2/96P4rDz+L220r4akCBLSEpcaE8Wu1aWxKJwhbjbiM5f7K30yN0V/AEbqZ5jcPp3IwPsz8q4n6RlCjwShVxYMACkX2RYswc/ccA2EqVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N3lQOIpL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u4Cv+udO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N3lQOIpL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u4Cv+udO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAFDD7A0133;
	Mon,  2 Mar 2026 07:13:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 07:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772453605;
	 x=1772540005; bh=kTgHn6o6qiRA6Qeq3kVnnH5CUOnmgrxf8neUkmdCJCU=; b=
	N3lQOIpLqiGaCurKB5PTcx9qdBKl3PamUjXXs9zUc6hZpX8sR0R/WqXpzrGgqHO9
	brL/tSrdJyvyHfkcDlKeM41aL0Vqu8LSQ/xbZjAL5AEXnJRjn/67zKmASeu5Xweo
	LVHsRi5LPAcfWjgG9XkSS+WHtJqy3nmiV3lGQW2V9/4pueV0+DJF54IGk9wsNF4R
	xlZMGd8LD/5Z7qTBINE3sNz4LVwE2hIm3o9bRQDXoldiD5jU+Q5z1jNyjxnozFtJ
	vafIMXlGA/771GxlEkjCWGisiPe/PhYGOFMfT62PO7LRC177tS3ydTE6NBU0fb57
	vpuKp+DfsYKTZFb3AgEyog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772453605; x=
	1772540005; bh=kTgHn6o6qiRA6Qeq3kVnnH5CUOnmgrxf8neUkmdCJCU=; b=u
	4Cv+udO+PPgswaG6eaoMaNjWaicNnsEQw79XS3bmuDGHIR8SfDZCKvWVjcyhLnsC
	nntdqcJPS0QwS9Y88x+hyQY0Vc/hCKsRa1Dllik7QnJ3eAxIU8yyeFE+BnCVCXL3
	lw3Q+4LH8efQval3snpc5TilQXqWj1kNLCaU/o8OcfkY9HjcrVN8k9v4+wnBDCqH
	0srPvbbmnUmbt63ilI05ljSL/4yuF5JJKboEvpNPQkGvmKBjrfwA/mvxx9sFOJ1y
	6LzAi4bXKudj9eriUayIYfXbistnqnlPoHqCx9UdQFOjn2QQvOyFo1KAm38AypVf
	oK8c0qe6dFGk9t81xJUQQ==
X-ME-Sender: <xms:5X6laRGS6px4NlvwZnlRlQYyYnicMoGyjruh-GW8-DPRRAAYQ80jAA>
    <xme:5X6lacUWW83EyyIb-ynH5Ur3FoFW2q6A_W6PyGjy0RL59FhEypO8KH5LGD_SlglTh
    8Z-IWX2XnEPJII5FwXY9UqcvSw9GOokJ1HIz9zQ72dXvHXHdZykUA>
X-ME-Received: <xmr:5X6laQymIk7ILS74NO5eOC1fw8b6eO9iVlDQkyHYTdHBm_5CGZuWT8p-I08pAoxndEm3OHvVGE6WctKOMKBJZ7n_Kq0Eh4X4A5upp0i-nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5X6laSPE2Qg40F0DqOFfWGUvy6wvoJsf8cvx3FHYLsQ5lH3RKki8Xw>
    <xmx:5X6laZ5y-n4sf5cAnMvgBEkK1SDysxVuaIUELE5TPxjPx4RmmCg4nQ>
    <xmx:5X6labOs3F7A0ifXiOCNG_ZVenzFcC7N1z-PS14aOFFC1101_VeKcA>
    <xmx:5X6lafkMt_EVs5ntJygTIP62hLG5Kd3MYHSecU_y0S1jHVfpkflh0w>
    <xmx:5X6laR2G6HE0XtIKu_BjVRB6DJoL-T3g3FoHz7WRs0rv6igAavbaEUGf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 07:13:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65694268 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 12:13:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Mar 2026 13:13:09 +0100
Subject: [PATCH 5/8] add-patch: allow disabling editing of hunks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-pks-history-split-v1-5-444fc987a324@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.3

The "add-patch" mode allows the user to edit hunks to apply custom
changes. This is incompatible with a new `git history split` command
that we're about to introduce in a subsequent commit, so we need a way
to disable this mode.

Add a new flag to disable editing hunks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.c  |  2 +-
 add-patch.c        | 22 ++++++++++++++--------
 add-patch.h        | 11 +++++++++--
 builtin/add.c      |  2 +-
 builtin/checkout.c |  2 +-
 builtin/reset.c    |  2 +-
 builtin/stash.c    |  2 +-
 7 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 152e2a0297..3cf8a1dbf8 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -927,7 +927,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		parse_pathspec(&ps_selected,
 			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 			       PATHSPEC_LITERAL_PATH, "", args.v);
-		res = run_add_p(s->r, ADD_P_ADD, &opts, NULL, &ps_selected);
+		res = run_add_p(s->r, ADD_P_ADD, &opts, NULL, &ps_selected, 0);
 		strvec_clear(&args);
 		clear_pathspec(&ps_selected);
 	}
diff --git a/add-patch.c b/add-patch.c
index b4dc7d2293..4e28e5c187 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1604,7 +1604,9 @@ static bool get_first_undecided(const struct file_diff *file_diff, size_t *idx)
 	return false;
 }
 
-static size_t patch_update_file(struct add_p_state *s, size_t idx)
+static size_t patch_update_file(struct add_p_state *s,
+				size_t idx,
+				unsigned flags)
 {
 	size_t hunk_index = 0;
 	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
@@ -1715,7 +1717,8 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 				permitted |= ALLOW_SPLIT;
 				strbuf_addstr(&s->buf, ",s");
 			}
-			if (hunk_index + 1 > file_diff->mode_change &&
+			if (!(flags & ADD_P_DISALLOW_EDIT) &&
+			    hunk_index + 1 > file_diff->mode_change &&
 			    !file_diff->deleted) {
 				permitted |= ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
@@ -2003,7 +2006,8 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 }
 
 static int run_add_p_common(struct add_p_state *state,
-			    const struct pathspec *ps)
+			    const struct pathspec *ps,
+			    unsigned flags)
 {
 	size_t binary_count = 0;
 	size_t i;
@@ -2017,7 +2021,7 @@ static int run_add_p_common(struct add_p_state *state,
 			i++;
 			continue;
 		}
-		if ((i = patch_update_file(state, i)) == state->file_diff_nr)
+		if ((i = patch_update_file(state, i, flags)) == state->file_diff_nr)
 			break;
 	}
 
@@ -2035,7 +2039,8 @@ static int run_add_p_common(struct add_p_state *state,
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
 	      struct interactive_options *opts, const char *revision,
-	      const struct pathspec *ps)
+	      const struct pathspec *ps,
+	      unsigned flags)
 {
 	struct add_p_state s = {
 		.r = r,
@@ -2084,7 +2089,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		goto out;
 	}
 
-	ret = run_add_p_common(&s, ps);
+	ret = run_add_p_common(&s, ps, flags);
 	if (ret < 0)
 		goto out;
 
@@ -2100,7 +2105,8 @@ int run_add_p_index(struct repository *r,
 		    const char *index_file,
 		    struct interactive_options *opts,
 		    const char *revision,
-		    const struct pathspec *ps)
+		    const struct pathspec *ps,
+		    unsigned flags)
 {
 	struct patch_mode mode = {
 		.apply_args = { "--cached", NULL },
@@ -2156,7 +2162,7 @@ int run_add_p_index(struct repository *r,
 	mode.diff_cmd[1] = "-r";
 	mode.diff_cmd[2] = parent_tree_oid;
 
-	ret = run_add_p_common(&s, ps);
+	ret = run_add_p_common(&s, ps, flags);
 	if (ret < 0)
 		goto out;
 
diff --git a/add-patch.h b/add-patch.h
index cf2a31a40f..fb6d975b68 100644
--- a/add-patch.h
+++ b/add-patch.h
@@ -53,15 +53,22 @@ enum add_p_mode {
 	ADD_P_WORKTREE,
 };
 
+enum add_p_flags {
+	/* Disallow "editing" hunks. */
+	ADD_P_DISALLOW_EDIT = (1 << 0),
+};
+
 int run_add_p(struct repository *r, enum add_p_mode mode,
 	      struct interactive_options *opts, const char *revision,
-	      const struct pathspec *ps);
+	      const struct pathspec *ps,
+	      unsigned flags);
 
 int run_add_p_index(struct repository *r,
 		    struct index_state *index,
 		    const char *index_file,
 		    struct interactive_options *opts,
 		    const char *revision,
-		    const struct pathspec *ps);
+		    const struct pathspec *ps,
+		    unsigned flags);
 
 #endif
diff --git a/builtin/add.c b/builtin/add.c
index 84f9bcb789..eeab779328 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -172,7 +172,7 @@ int interactive_add(struct repository *repo,
 		       prefix, argv);
 
 	if (patch)
-		ret = !!run_add_p(repo, ADD_P_ADD, interactive_opts, NULL, &pathspec);
+		ret = !!run_add_p(repo, ADD_P_ADD, interactive_opts, NULL, &pathspec, 0);
 	else
 		ret = !!run_add_i(repo, &pathspec, interactive_opts);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bebe18c1d9..a8863277f2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -563,7 +563,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 			BUG("either flag must have been set, worktree=%d, index=%d",
 			    opts->checkout_worktree, opts->checkout_index);
 		return !!run_add_p(the_repository, patch_mode, &interactive_opts,
-				   rev, &opts->pathspec);
+				   rev, &opts->pathspec, 0);
 	}
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
diff --git a/builtin/reset.c b/builtin/reset.c
index 4a74a82c0a..3590be57a5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -438,7 +438,7 @@ int cmd_reset(int argc,
 			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
 		trace2_cmd_mode("patch-interactive");
 		update_ref_status = !!run_add_p(the_repository, ADD_P_RESET,
-						&interactive_opts, rev, &pathspec);
+						&interactive_opts, rev, &pathspec, 0);
 		goto cleanup;
 	} else {
 		if (interactive_opts.context != -1)
diff --git a/builtin/stash.c b/builtin/stash.c
index c467c02c7f..7c68a1d7f9 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1331,7 +1331,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-	ret = !!run_add_p(the_repository, ADD_P_STASH, interactive_opts, NULL, ps);
+	ret = !!run_add_p(the_repository, ADD_P_STASH, interactive_opts, NULL, ps, 0);
 
 	the_repository->index_file = old_repo_index_file;
 	if (old_index_env && *old_index_env)

-- 
2.53.0.697.g625c4fb2da.dirty

