Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F692F1FEA
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758951; cv=none; b=tXv1p+Elcnwz+p8jUgefaZSYmh4IN5LeRAp02iQkXRJwIMvPvKfIQMkiGChbuthd6ukFJNjkdxMvtGY6vVRsELZOQohjRNFdr6lBcK8v9vfYvEkVyrdwAQMAEazDgjL9sVkqfu+x7S8wMCuqfjt3WlTZ6qZt73dfzfFJGs5q8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758951; c=relaxed/simple;
	bh=wL9xauI/Sq0JZ1lmKnkPyWjWZYsoQRt6CppXU7obXDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LRj2TSv8/nCGjXDlQ0k8eSJt+8TrxazhXV2POYdpiF1nOAr8vGp/2MtyS8UN5iKImBYe7e/Vfh8gemhYvWffet0yJmZ5g1oCYbq0gBxCDfbmFcL3Kr8Sp9k/kkqa0LJisBXMymxUtaIrfy4Ng+2RsCByRkKssRg5xkccCow7r3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mp9NHhOx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GzEignd9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mp9NHhOx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GzEignd9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 38505EC03AB;
	Wed,  3 Dec 2025 05:49:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 03 Dec 2025 05:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758949;
	 x=1764845349; bh=K7e1aLiapNkA0YBPZ5JduWHg7Zz5LhkVgAjyZ+XoyLA=; b=
	mp9NHhOxf1KqSCNdw/gRZ2Xhb8XkKkXnTrb91ZuMxWL5uZkpY+YakMoUJ9sXX7ej
	iUAi6hlnctDkF/GWWkVCuLFVsaWVU2RMafM0hTIAlYULGDqQdddTx9a7zrt5b5OR
	xDu8wWOnt7vFDcl3xWrrAFN+IAJGBaMe82t19U1tsNbuCBzXKJwOZrZ+GBkilvet
	LgdaZo90cmBQfojGpA6U8Mx6aKRvm+2zqGDoyvxoSGkWZH1Du/jmWdap1YefmsC8
	cy+XfEtcuT7mzUIgkBGFPOOFHr5FT/Te2Wf0IORNLYq0RR7GCe5YaKKfc+saIgow
	A7erfvNblc1cV53Y5dc6oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758949; x=
	1764845349; bh=K7e1aLiapNkA0YBPZ5JduWHg7Zz5LhkVgAjyZ+XoyLA=; b=G
	zEignd9fecAkvoGkfp27UyFcbzVkO5UIcsmRi582mqbNtUw04XUmOl5Kv5RbeWmP
	9HrpkC4MkFFKwo/9AxZb/38j5i+lL29n66huOGhzer796ma8MU9fi7S8mCVheRkJ
	hojkGVHsyJDD1w/uJ0QHBXygrkWasceWRVo64e6/+WQmi3MiQruQ9dANWYoVB3h5
	StBxf5dXsvfn7EbAf1vDOF6cX1Z91l6k6oAzlhpsNB42uFMNDdTpnCC8hQyvRXmN
	E8sqXy6FPYFsfKz+eMJJ6AEId5GoetF8/YvtrKqauxeVK6nIGQZQ3fzRzxSEtRDG
	NRgrzIP9pe4WIV5W7UGlQ==
X-ME-Sender: <xms:pRUwaRWoTQBVbbGQiZeV9urR4uJrOfMLTQnVRjH0RdTRQF9DaMyX9Q>
    <xme:pRUwaUJPI0IxlO_ni6ZoS3iKjVcXiC3gA9rPIksREZ-FTly6q3TRrzExgrzq0rGTS
    UVAfdeyc0Yj9HOWBmW3526iNl8_iSt2xd3NpfgHlYtji_P9xvczPA>
X-ME-Received: <xmr:pRUwaRDgM7ZKt3IXqeyqx5s6ylbMFK6dgtHH48Uga2aw_BhOgFY_QbYegbDDNFXeCF7L1NpGNZ7YWf7JWKjdZ-nuwEEnq8sdGgCaeHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphht
    thhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:pRUwaUd8sav7wgHNWNFN3DyueGEF2ggp1zi0nFYB1pigko1YR8wXNg>
    <xmx:pRUwaQ3kLTWt3iCtmxnBW6TA-x9plSk_Hka6gSzH5eNw7s7CWZ0iPg>
    <xmx:pRUwabh9C3OMBM9AvewLhuWw96SdkNEjjddyi5SlXRJKBgg4UbC5fg>
    <xmx:pRUwaZnTfo36i9i11BKXXn_fc8Z-tcnqSl_W5GLdnEOT06pdSENx_Q>
    <xmx:pRUwaaCUQGvDTRqmo5sNz3oqXwcECJacPhAmMECWFfggG9LfvP-m0_nH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:49:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c4352183 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:49:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:37 +0100
Subject: [PATCH v7 10/12] add-patch: allow disabling editing of hunks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-10-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The "add-patch" mode allows the user to edit hunks to apply custom
changes. This is incompatible with a new `git history split` command
that we're about to introduce in a subsequent commit, so we need a way
to disable this mode.

Add a new flag to disable editing hunks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.c  |  2 +-
 add-patch.c        | 21 +++++++++++++--------
 add-patch.h        | 11 +++++++++--
 builtin/add.c      |  2 +-
 builtin/checkout.c |  2 +-
 builtin/reset.c    |  2 +-
 builtin/stash.c    |  2 +-
 7 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 05d2e7eefe..d41e039bc3 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -926,7 +926,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		parse_pathspec(&ps_selected,
 			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 			       PATHSPEC_LITERAL_PATH, "", args.v);
-		res = run_add_p(s->r, ADD_P_ADD, &opts, NULL, &ps_selected);
+		res = run_add_p(s->r, ADD_P_ADD, &opts, NULL, &ps_selected, 0);
 		strvec_clear(&args);
 		clear_pathspec(&ps_selected);
 	}
diff --git a/add-patch.c b/add-patch.c
index 31d82a3e22..51a7b371a2 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1565,7 +1565,8 @@ static bool get_first_undecided(const struct file_diff *file_diff, size_t *idx)
 }
 
 static int patch_update_file(struct add_p_state *s,
-			     struct file_diff *file_diff)
+			     struct file_diff *file_diff,
+			     unsigned flags)
 {
 	size_t hunk_index = 0;
 	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
@@ -1666,7 +1667,8 @@ static int patch_update_file(struct add_p_state *s,
 				permitted |= ALLOW_SPLIT;
 				strbuf_addstr(&s->buf, ",s");
 			}
-			if (hunk_index + 1 > file_diff->mode_change &&
+			if (!(flags & ADD_P_DISALLOW_EDIT) &&
+			    hunk_index + 1 > file_diff->mode_change &&
 			    !file_diff->deleted) {
 				permitted |= ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
@@ -1932,7 +1934,8 @@ static int patch_update_file(struct add_p_state *s,
 }
 
 static int run_add_p_common(struct add_p_state *state,
-			    const struct pathspec *ps)
+			    const struct pathspec *ps,
+			    unsigned flags)
 {
 	size_t binary_count = 0;
 
@@ -1942,7 +1945,7 @@ static int run_add_p_common(struct add_p_state *state,
 	for (size_t i = 0; i < state->file_diff_nr; i++) {
 		if (state->file_diff[i].binary && !state->file_diff[i].hunk_nr)
 			binary_count++;
-		else if (patch_update_file(state, state->file_diff + i))
+		else if (patch_update_file(state, state->file_diff + i, flags))
 			break;
 	}
 
@@ -1956,7 +1959,8 @@ static int run_add_p_common(struct add_p_state *state,
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
 	      struct interactive_options *opts, const char *revision,
-	      const struct pathspec *ps)
+	      const struct pathspec *ps,
+	      unsigned flags)
 {
 	struct add_p_state s = {
 		.r = r,
@@ -2005,7 +2009,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		goto out;
 	}
 
-	ret = run_add_p_common(&s, ps);
+	ret = run_add_p_common(&s, ps, flags);
 	if (ret < 0)
 		goto out;
 
@@ -2021,7 +2025,8 @@ int run_add_p_index(struct repository *r,
 		    const char *index_file,
 		    struct interactive_options *opts,
 		    const char *revision,
-		    const struct pathspec *ps)
+		    const struct pathspec *ps,
+		    unsigned flags)
 {
 	struct patch_mode mode = {
 		.apply_args = { "--cached", NULL },
@@ -2079,7 +2084,7 @@ int run_add_p_index(struct repository *r,
 
 	interactive_config_init(&s.cfg, r, opts);
 
-	ret = run_add_p_common(&s, ps);
+	ret = run_add_p_common(&s, ps, flags);
 	if (ret < 0)
 		goto out;
 
diff --git a/add-patch.h b/add-patch.h
index 901c42fd7b..1facf19f96 100644
--- a/add-patch.h
+++ b/add-patch.h
@@ -50,15 +50,22 @@ enum add_p_mode {
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
index 6f1e213052..dfe9636079 100644
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
index 530ae956ad..d325083ff3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -576,7 +576,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 			BUG("either flag must have been set, worktree=%d, index=%d",
 			    opts->checkout_worktree, opts->checkout_index);
 		return !!run_add_p(the_repository, patch_mode, &interactive_opts,
-				   rev, &opts->pathspec);
+				   rev, &opts->pathspec, 0);
 	}
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
diff --git a/builtin/reset.c b/builtin/reset.c
index 088449e120..008929bc7c 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -436,7 +436,7 @@ int cmd_reset(int argc,
 			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
 		trace2_cmd_mode("patch-interactive");
 		update_ref_status = !!run_add_p(the_repository, ADD_P_RESET,
-						&interactive_opts, rev, &pathspec);
+						&interactive_opts, rev, &pathspec, 0);
 		goto cleanup;
 	} else {
 		if (interactive_opts.context != -1)
diff --git a/builtin/stash.c b/builtin/stash.c
index 3b50905233..eb8142565e 100644
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
2.52.0.239.gd5f0c6e74e.dirty

