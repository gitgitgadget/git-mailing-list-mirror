Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4BB3090CA
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996067; cv=none; b=nVoOr2jkcw4xtseFsJPGzSRK9P7X/IFu3cCwP7XRwm8oQvIKAMATXCZkKSGCyqyvWYGwwOxOAJb1REtOU9AH6+vEGsT8JUHWu95FonVgUy7cTUA6ezxtTixQnUMdJvqxwiRHoIOb+St8DKhfDJLZUHtUoAHB3bK3yZZCnh783h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996067; c=relaxed/simple;
	bh=463Reczs1WX9UBMtUNSF+tDQKBrhDFd/jDqBGZnmosI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oU6NyOg7kmIKTIyl4i8e18ixAtkOuLdekQrVIt26t8dHwkHpoKvD7WrSHfFrIr67RWKoPY01U1qOyVbR7oCZkImkH4N7hpwgLX6Hlnp3kU3AS8QarwTEFvssBUI6uEwD+INOUn+jd4VUvH/gdIJq72bGvA24S8PvaE6eBtAi7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fWfCbMfN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lSBDDe46; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fWfCbMfN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lSBDDe46"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CDB91D00275;
	Thu,  4 Sep 2025 10:27:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 10:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996064;
	 x=1757082464; bh=cCIzI6fT1v8xdrOGv1SOJIWVY64nIBRfKdszzJv6ZQI=; b=
	fWfCbMfN0fR+2TOYCSbVK5U3scguJBhE9SxYt7K4a2t7ndxg2yzxkPbsX8mcigis
	06/eXZrBLCCslxYNnl1tWAHDjmUs6V3quA1U1de8Qm3lOAaGibSUI1bB1gcpLdfn
	6154GuRqp+AA1PpvYHSPqTqNw61fR+t5f10gfma3bKcSV7pq6FpehAsiWnPbcuxP
	P5aDmtp+nUw0nur9LfAMTTl9mdC8dclI6l40qU3qWtY7up21OChKKUzqF+JU5gHG
	6FDSN+bS8Vr5aF7bQtCeqKH6efbuiY3Lp/PkZOXIhYLmGERc8Etwt8YfTuNuUl+3
	cVToq9cXQTUy1JWQggYQ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996064; x=
	1757082464; bh=cCIzI6fT1v8xdrOGv1SOJIWVY64nIBRfKdszzJv6ZQI=; b=l
	SBDDe46+EmUuZgonfJgkbt4mQQ65bcshbU5XEOKE4Ze+ExeGjCFHZEUh8Hh7MP2Q
	aEvd+LLyyigOne8CNxoQjU4QN/JV+hKRCLgyWc78QGe7SWGK91N6CclP8EuJz/83
	rdMW5gP+/Gk4OkS1aBfO8MCiy0zNdTiPA/SsStqXVuWHTdN2mQ4tnviSr+nWgV9U
	GHWyTBho0eOGpM4fkA1u2N9fawCMgW6HDTnKrKY4Cg35Jv8tEA32ovcFmuX/Oc6I
	/G8+sLfGgUPA+6sPmWB3kct8l0eM7td9zVaULioEQFVumSFlTN8KvTpMG/7fiemX
	xXJxolkT8NTcfiFltLxcQ==
X-ME-Sender: <xms:4KG5aAhUbCmLi2tpr0AfmFpsIR-Qt0xG6po91oYfNfFHSwJQFmZtyQ>
    <xme:4KG5aGnTQkkRELEU-s0NVGLUwaHg8UGC22E8axIdJ4dMXM4WL39QAK2qB4COm8jxB
    PaM6qdsIzw1e2eMBg>
X-ME-Received: <xmr:4KG5aOjH37zvoOtuZPBWyYJvwQ4whZTzxlEjoltJaxlnoLUxpV8mmdjBM4wOR_w7nE_wdvaRo5hJXy-3RAvMKFrsbB_S8ho2__LcVwtaSSIyhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhope
    hmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhho
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:4KG5aC1idzo58e4ohgHAi3PnS3N5tXJ9uI8OClCzoPDCh3aQf_YYsA>
    <xmx:4KG5aPKa0gAYDnDL-KQDqOxbLoUGtS8zHw3TKMgaoRNxc_noSBvq1g>
    <xmx:4KG5aKzA07dlWHj_Yab0BKt_e9zi8CQuTP4N-is2b2Ga4euNwpsYbw>
    <xmx:4KG5aFWMPNm_15c7-3pwqa6PAza3xLMiWGsKOjD_cSbeX0Jtty7yCg>
    <xmx:4KG5aLby1NkMYmhBJUerMpxkFFPiKoxHFy6ITygKZwwk4IPhlpDPLkG0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e64f9258 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:32 +0200
Subject: [PATCH RFC v3 02/18] sequencer: add option to rewind HEAD after
 picking commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-2-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

While the sequencer infrastructure knows to rewind "HEAD" to whatever it
was pointing to before a rebase, it doesn't do the same for non-rebase
operations like cherry-picks. This is because the expectation is that
the user directly picks commits on top of whatever "HEAD" points to, and
we advance the reference pointed to by "HEAD" instead of updating it
directly.

We're about to introduce a new command though that needs to detach
"HEAD" while being more similar to git-cherry-pick(1) rathen than to
git-rebase(1). As such, we'll want to restore "HEAD" to point to the
branch that we started on while not using the more heavy-weight rebase
machinery.

Introduce a new option `restore_head_target` to do so. Persist the
option into the sequencer configuration so that it persists across
different processes, e.g. when we need to stop due to a merge conflict.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 27 ++++++++++++++++++++++++++-
 sequencer.h |  3 +++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 7066cdc939..bff181df76 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -413,6 +413,7 @@ void replay_opts_release(struct replay_opts *opts)
 	struct replay_ctx *ctx = opts->ctx;
 
 	free(opts->gpg_sign);
+	free(opts->restore_head_target);
 	free(opts->reflog_action);
 	free(opts->default_strategy);
 	free(opts->strategy);
@@ -3142,6 +3143,8 @@ static int populate_opts_cb(const char *key, const char *value,
 	} else if (!strcmp(key, "options.skip-commit-summary")) {
 		opts->skip_commit_summary =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
+	} else if (!strcmp(key, "options.restore-head-target")) {
+		git_config_string_dup(&opts->restore_head_target, key, value);
 	} else {
 		return error(_("invalid key: %s"), key);
 	}
@@ -3709,6 +3712,10 @@ static int save_opts(struct replay_opts *opts)
 	if (opts->skip_commit_summary)
 		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.skip-commit-summary", NULL, "true");
+	if (opts->restore_head_target)
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
+				"options.restore-head-target", NULL, opts->restore_head_target);
+
 	return res;
 }
 
@@ -5177,6 +5184,23 @@ static int pick_commits(struct repository *r,
 			return -1;
 	}
 
+	if (opts->restore_head_target) {
+		struct reset_head_opts reset_opts = { 0 };
+		const char *msg;
+
+		msg = reflog_message(opts, "finish", "returning to %s", opts->restore_head_target);
+
+		reset_opts.branch = opts->restore_head_target;
+		reset_opts.flags = RESET_HEAD_REFS_ONLY;
+		reset_opts.branch_msg = msg;
+		reset_opts.head_msg = msg;
+
+		if (reset_head(r, &reset_opts)) {
+			error(_("could not switch HEAD back to %s"), opts->restore_head_target);
+			return -1;
+		}
+	}
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -5533,7 +5557,8 @@ int sequencer_pick_revisions(struct repository *r,
 	if (opts->revs->cmdline.nr == 1 &&
 	    opts->revs->cmdline.rev->whence == REV_CMD_REV &&
 	    opts->revs->no_walk &&
-	    !opts->revs->cmdline.rev->flags) {
+	    !opts->revs->cmdline.rev->flags &&
+	    !opts->restore_head_target) {
 		struct commit *cmit;
 
 		if (prepare_revision_walk(opts->revs)) {
diff --git a/sequencer.h b/sequencer.h
index 1767fd737e..a905f6afc7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -72,6 +72,9 @@ struct replay_opts {
 	/* Reflog */
 	char *reflog_action;
 
+	/* Reference to which HEAD shall be reset to after the operation. */
+	char *restore_head_target;
+
 	/* placeholder commit for -i --root */
 	struct object_id squash_onto;
 	int have_squash_onto;

-- 
2.51.0.417.g1ba7204a04.dirty

