Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F023D297
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057370; cv=none; b=OCjhsBin3LaUiwoNJE3oQtbdTIzMDV+V4cKUkzivwy5OKfZNBOg6Mfq4Zvr+6rIVWdY2ftuZ7PLaPAD4IQhVJtAp5KLpadx4YsqNVdJjzNtY1cGWji6nnHOPJwX++Hi/mafcyHD1jbXRsr0IjdDdAVS0T5xn/citKwS/YQCPfCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057370; c=relaxed/simple;
	bh=f2vkbSqRG/45v/1RkVf9ssBFQ4peOQ421TGtQXEz9vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7BKhu71iblI8iT/eLnnMM5It1ys2hJEPBgv9SMSUtCuzkorfS7DuEm5OiUM/e7csmA80LQEUlFFPYkRnYBm2jAGXSE9CYr9zs4bfg78LGz3M9cd3/DnJHJwwIngr2gw1ID4nnN5QlCAeKW3xCphyhci/KloUgUFgD4syH3flt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AVueNJnv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HfWbAOlh; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AVueNJnv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HfWbAOlh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BDDBB1D000AE;
	Sun, 24 Aug 2025 13:42:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 24 Aug 2025 13:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057367;
	 x=1756143767; bh=tp45Gr1DV66eHvOLgb5UICdIRo74ZSC8tGEcLmCXZmU=; b=
	AVueNJnvhOtE2pu8oHR23BwPKEbuxS73zapfE9VasxaSU7zytqd6AKiAw4ZYUQjs
	ZqblHx1FOwrG9BFMIUYvF52ZyhResx+SIkTvgff+l4nLzXj2DkcVPz5Ukfm2kN7e
	9xNlMrWut+PyMpXgovNoWXRTZU0tEB4v7aIZQqXxEgdK6Mm8YyxmqPbjWwpVNRjY
	WL+cvJNJo3D913gFHRFf5n1Wash/3kM9zgMXTl3YZyAhJaMpC+VI3JwrsfteGC3V
	fjdbCoF5xq8QE96/5JTp2FBpzuJ+gnWXtXsMqHcl4reLz6oGCodVQfpRI2iNIJa6
	qvtBRwUDzBecw1POMHCnvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057367; x=
	1756143767; bh=tp45Gr1DV66eHvOLgb5UICdIRo74ZSC8tGEcLmCXZmU=; b=H
	fWbAOlhnyVmUgG2Ztub7l7GPoJ8KQU8XuvxfmKw2+wUEiX2CBu+kb28tb19BaoX1
	ODL5VFBb8hYHncmO/Y5yzI710GzggspG+JKOixVekP7jiZNXD2Z1+qHv9er25va9
	RW+AOUtBimm2T+Y0R0MhKapZZC4kXz13KUeWLQlMpYjh+sXR3AB2eeQovxHE6dSx
	fpl2hT0MSUKBIYFFN269yChDNFBsU/3FWImCn2zpD4C+0dvPsQx5PKEE6nXyAjts
	7IK4Olrg9cK0QF09pyUKHMHrybVLeQG7JgBS6WJJr5S88lsNXPZIqn/RDCG110Pf
	FjFKsvxxp2SIOMXyuYTPQ==
X-ME-Sender: <xms:F0-raHBC4_WKRuCZkiXcUtQh6YRF-VWprY4k5H0-3shsVphVihN1ow>
    <xme:F0-raONXY83otbd8WCL-lU3WEOdCX4pMxLb6c-k84Pn6v4WiG8vFUNskRfYMZifOf
    V6JIB-ZLhYaK5xjTA>
X-ME-Received: <xmr:F0-raAwyO9t_y2uMVBC9z0tbOA-NR8Pba5pH4VqSHf-l69Xn5QHQ_ha1LAPDiD7NSO9rPJSCXdBYS1sV1WTRMnoKY4gIdQa1gkAi36r6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:F0-raOV2iGRY8i2Yz5oAPL2g5QxNtem5cd7WKpeZAzOorjevmgc3VQ>
    <xmx:F0-raCO54g0cP8DyBhjFPXnlkTAk20-9q1RPDMIKUeUzIdje62Toqw>
    <xmx:F0-raABBizA4fBG4B4lXLavrdefk7eYlp3u1O7gEhf-HgBe_CkVaDw>
    <xmx:F0-raPdqPUcftEokfkbiQ97vUoGpgGKvIVRluODyvOi1lFf19ja4Iw>
    <xmx:F0-raDGPTIbcArzsMRGj13KSdANy03BA6uWEbb7qA9le2hlynMKmOHP5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:42:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52b458d3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:42:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:15 +0200
Subject: [PATCH RFC v2 02/16] sequencer: add option to rewind HEAD after
 picking commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-2-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
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
2.51.0.308.g032396e0da.dirty

