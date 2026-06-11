Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211733E7BD0
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184444; cv=none; b=jZvtqa6v/oSdHumTD417UrrrbyVGnRAVW8Ia451fZVzNLJyeuvSPibVP7RAFqJA2DWLDVHznNFrooPC+W50tF0/w3F3+MH24/XUaa7VEz1UYvB4mvt07n71KHXtoC8byezTT0ILvuNwOT3GdKLKUKHe0ymoXeBpHoibE/6d2MCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184444; c=relaxed/simple;
	bh=vl4v0npmAK7aynY7mzbvd1hINV3PVRwQKxAdMku+D70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0jB12a1uyft+q1A91WKTVtHPonaWxfxXhRZohSqWKKfKnfLKl0aZZrloh1iPeOVfZl86tBthmy9tz9jZCOepAdU0HdQHG2ITLST8wfj3LXU2MtL2JMB3rrWQI5WVpO/0oWxs0E2kJZcNfl1eKvXDZXSOIrTKP/uG7ONAr3A+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IU+WFgG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3hLypuH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IU+WFgG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3hLypuH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FC1CEC00CE;
	Thu, 11 Jun 2026 09:27:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 11 Jun 2026 09:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781184442;
	 x=1781270842; bh=5S6CmnefYUHMVfmoviMiuHQJJ0Mlx0fbRPq53F8P/eQ=; b=
	IU+WFgG71L+TWnL4XXtUmdArbEgyYwQJ8fIT/Fe2jNK6mA91i5oTSvFd+i9eJaL3
	eGetORqspj9vPLPF6snMcKjSXOmPXtUGoXorXH2l08rJLGkr+hYiepDxjBRiNT9y
	MEezLQdcvH+9mO9so6S8cCI5MLhSOUqRbgKlne/STObgulx42+sGMvDqJpGVq6hl
	aONa+XZvwV1CjQDZCm99y5Ndc3X6Jqh8ncZnCXUhAxoKEOPBj8yrcfpWklKPs1/O
	RJoHVP+1y6kvCpF1tYxfPq7foOTKkTAi7/fxyGsf8YCHEV3LYuPtMsz47AyHdB0P
	qduzWOULTdLC0GoU4hCmCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781184442; x=
	1781270842; bh=5S6CmnefYUHMVfmoviMiuHQJJ0Mlx0fbRPq53F8P/eQ=; b=i
	3hLypuHCbAlKUVET0n/AXeDOt+JosgkQ6G6UjJ91FG5DDB6HkjQ/RFCCUQt1Ky7i
	7IjL+oCfUFrbiIId4QaNtnSa1OH9gkLe0Va4QMj4s7Gi3gfiCsjeXxXrQ+8zvC35
	IwoTLpMWUC05Ir2n0TYaqZ1r9ViU/C9zYmbe6knLL8GFMaga0+wv7KXMeQ+cJAjU
	DQMIy4XCXaOk2RTUEavpARZDzRdtVKTrOJ5o5DPOfRHSaWUhNT0MLlpFVbXai9vK
	7jUHIjyxp+BEVxFA41zhn/YTMGzyHqjU5hjRCuxHFBEjnwAgnMzRp2I77+/M9BKo
	bsKWXFhcIqJeshK4khYDQ==
X-ME-Sender: <xms:urcqam_x2HTLr6fC0fAA58rZ6FG6RKeRjLMcJEla2MnEp460QN6GlQ>
    <xme:urcqaoOwPQNHrFVPLbLTqb_2kGcPGMXV4bNO_ppY6l_6-bxwXIffSMpLFPSzGi3mp
    uwRmJyAy0GiN8aCyFoatnl6raTuwxNJA_Ty72cBHwJ-2AMhoaYBNA>
X-ME-Received: <xmr:urcqasGWs1WD2sdAwpZO7Rsk1gpcbbwcyswAuh5svyf5tsq2zuugMLFA98YhF9nvWgWQhHBYQ4xpVfhqOaBadUKPU1GxBBhPFTaTulhzm-H9>
X-ME-Proxy-Cause: dmFkZTGTxPIFhuBoiEsDDhB9RSHDCXHbFJ5VnVZDD4bec7nRzrCcE+c/MFsVjwohVHwftl
    cVFao0kG58zAIws/O0Ei+RCSGpQ0XKAQJ897zbTpVEbAIBEUeVlBXzfOFp55wWFPDBC63b
    ++i23VB0mlc+JXzPK3+XAmANc+ZYYAp9T+MNk3HVd/hzScgiy84HRbrCh3vZt+7kXlIWUj
    ICMm9WiiSqqEB0XslkAYhBOOtsaSDKKRXTT8LmcdFGr003K4VIXcWEJk40SYS0wk41aqac
    5QeQLlxVantr78Np3u7bywp17Vc7XJmbCgEqW3Tgiuxa+RRmWIgUhEXLaBmgiHi/rb6RkO
    9JzEVo3PW9XaJnQ0v7ZrgmSr0JQpqTo49TFaPWAyAJ0hwtJpRCij11Ft3An3CeF7ZT5AGV
    EaZwoKx3XsEYDqog/vMzT6CI0OuJwFusSJH65ubPl4D53ychSmAtlsRcanv8a3RE+ElciI
    Gp28EtkMpZEP9ANZsWxLrz+xrFEorgZdIIC0CN10Geo1pnXYGSCdLAE8zo2IW6N8I8XNTm
    QSit5WEHzZS+hFt36+ZhzahBW06fcu3zarz4Wz0/+3UPSVMxUo4gJUgmmQ4GdHpzQgy5VE
    DjEpRJ97EYmksUCIQlV9Ceydmrh95V9VxZiyq2+ce46kXoI8+M5D0r7wWlIA
X-ME-Proxy: <xmx:urcqauTv0DLeKVjhE77JjJjRSUjrxFmIYzf63o8b10R29k12818eZA>
    <xmx:urcqahtE5o4049sJpygCSw-JEGbtOLY8rszwKNluSU1SSejk2MBbIg>
    <xmx:urcqauKCkOPF3WMlkaYhy5uqjGS3mWeYN_1IOSuaiY8djJUqkzklww>
    <xmx:urcqaukgOqfycU3rs3fWiIJlLr9bjkGtYKYCV1piXZL-Ly-DMGji7g>
    <xmx:urcqakjLgNU8FnVpCd23wDntRrjVA5Y-s3vkbV818kf8WwaW5zmJP0og>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:27:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6ad3013 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:27:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 15:27:06 +0200
Subject: [PATCH v5 03/10] reset: rename `reset_head()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-history-drop-v5-3-34d35725559c@pks.im>
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
In-Reply-To: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In a subsequent commit we're about to adapt `reset_head()` so that the
reference update to HEAD is optional, only. At this point the function
starts to feel misnamed, as it doesn't necessarily have anything to do
with the HEAD reference anymore. The gist of the function then is that
we reset the working tree to a specific new commit, updating both the
index and the checked-out files.

Rename it to `reset_working_tree()` to better reflect that.

Note that we don't adjust the flags yet. This will happen in a
subsequent commit.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
---
 builtin/rebase.c | 20 ++++++++++----------
 reset.c          |  5 +++--
 reset.h          |  4 ++--
 sequencer.c      |  8 ++++----
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fa4f5d9306..22fbba3c62 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -592,7 +592,7 @@ static int finish_rebase(struct rebase_options *opts)
 static int move_to_original_branch(struct rebase_options *opts)
 {
 	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
-	struct reset_head_opts ropts = { 0 };
+	struct reset_working_tree_options ropts = { 0 };
 	int ret;
 
 	if (!opts->head_name)
@@ -610,7 +610,7 @@ static int move_to_original_branch(struct rebase_options *opts)
 	ropts.flags = RESET_HEAD_REFS_ONLY;
 	ropts.branch_msg = branch_reflog.buf;
 	ropts.head_msg = head_reflog.buf;
-	ret = reset_head(the_repository, &ropts);
+	ret = reset_working_tree(the_repository, &ropts);
 
 	strbuf_release(&branch_reflog);
 	strbuf_release(&head_reflog);
@@ -685,7 +685,7 @@ static int run_am(struct rebase_options *opts)
 
 	status = run_command(&format_patch);
 	if (status) {
-		struct reset_head_opts ropts = { 0 };
+		struct reset_working_tree_options ropts = { 0 };
 		unlink(rebased_patches);
 		free(rebased_patches);
 		child_process_clear(&am);
@@ -693,7 +693,7 @@ static int run_am(struct rebase_options *opts)
 		ropts.oid = &opts->orig_head->object.oid;
 		ropts.branch = opts->head_name;
 		ropts.default_reflog_action = opts->reflog_action;
-		reset_head(the_repository, &ropts);
+		reset_working_tree(the_repository, &ropts);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
 			"these revisions:\n"
@@ -855,7 +855,7 @@ static int rebase_config(const char *var, const char *value,
 static int checkout_up_to_date(struct rebase_options *options)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct reset_head_opts ropts = { 0 };
+	struct reset_working_tree_options ropts = { 0 };
 	int ret = 0;
 
 	strbuf_addf(&buf, "%s: checkout %s",
@@ -866,7 +866,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 	if (!ropts.branch)
 		ropts.flags |=  RESET_HEAD_DETACH;
 	ropts.head_msg = buf.buf;
-	if (reset_head(the_repository, &ropts) < 0)
+	if (reset_working_tree(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
 	strbuf_release(&buf);
 
@@ -1116,7 +1116,7 @@ int cmd_rebase(int argc,
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
 	int preserve_merges_selected = 0;
-	struct reset_head_opts ropts = { 0 };
+	struct reset_working_tree_options ropts = { 0 };
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -1385,7 +1385,7 @@ int cmd_rebase(int argc,
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 		ropts.flags = RESET_HEAD_HARD;
-		if (reset_head(the_repository, &ropts) < 0)
+		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
 		if (read_basic_state(&options))
@@ -1410,7 +1410,7 @@ int cmd_rebase(int argc,
 		ropts.head_msg = head_msg.buf;
 		ropts.branch = options.head_name;
 		ropts.flags = RESET_HEAD_HARD;
-		if (reset_head(the_repository, &ropts) < 0)
+		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head->object.oid));
 		strbuf_release(&head_msg);
@@ -1880,7 +1880,7 @@ int cmd_rebase(int argc,
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
 	ropts.default_reflog_action = options.reflog_action;
-	if (reset_head(the_repository, &ropts)) {
+	if (reset_working_tree(the_repository, &ropts)) {
 		ret = error(_("Could not detach HEAD"));
 		goto cleanup_autostash;
 	}
diff --git a/reset.c b/reset.c
index 3b3cb74dab..799596398b 100644
--- a/reset.c
+++ b/reset.c
@@ -12,7 +12,7 @@
 #include "hook.h"
 
 static int update_refs(struct repository *repo,
-		       const struct reset_head_opts *opts,
+		       const struct reset_working_tree_options *opts,
 		       const struct object_id *oid,
 		       const struct object_id *head)
 {
@@ -85,7 +85,8 @@ static int update_refs(struct repository *repo,
 	return ret;
 }
 
-int reset_head(struct repository *r, const struct reset_head_opts *opts)
+int reset_working_tree(struct repository *r,
+		       const struct reset_working_tree_options *opts)
 {
 	const struct object_id *oid = opts->oid;
 	const char *switch_to_branch = opts->branch;
diff --git a/reset.h b/reset.h
index a28f81829d..f130152014 100644
--- a/reset.h
+++ b/reset.h
@@ -17,7 +17,7 @@
 /* Update ORIG_HEAD as well as HEAD */
 #define RESET_ORIG_HEAD (1<<4)
 
-struct reset_head_opts {
+struct reset_working_tree_options {
 	/*
 	 * The commit to checkout/reset to. Defaults to HEAD.
 	 */
@@ -55,6 +55,6 @@ struct reset_head_opts {
 	const char *default_reflog_action;
 };
 
-int reset_head(struct repository *r, const struct reset_head_opts *opts);
+int reset_working_tree(struct repository *r, const struct reset_working_tree_options *opts);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index 1ee4b2875b..d73ecf0384 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4677,7 +4677,7 @@ static void create_autostash_internal(struct repository *r,
 	if (has_unstaged_changes(r, 1) ||
 	    has_uncommitted_changes(r, 1)) {
 		struct child_process stash = CHILD_PROCESS_INIT;
-		struct reset_head_opts ropts = { .flags = RESET_HEAD_HARD };
+		struct reset_working_tree_options ropts = { .flags = RESET_HEAD_HARD };
 		struct object_id oid;
 
 		strvec_pushl(&stash.args,
@@ -4707,7 +4707,7 @@ static void create_autostash_internal(struct repository *r,
 
 		if (!silent)
 			printf(_("Created autostash: %s\n"), buf.buf);
-		if (reset_head(r, &ropts) < 0)
+		if (reset_working_tree(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
 		if (repo_read_index(r) < 0)
@@ -4867,7 +4867,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 const char *onto_name, const struct object_id *onto,
 			 const struct object_id *orig_head)
 {
-	struct reset_head_opts ropts = {
+	struct reset_working_tree_options ropts = {
 		.oid = onto,
 		.orig_head = orig_head,
 		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
@@ -4876,7 +4876,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 					   onto_name),
 		.default_reflog_action = sequencer_reflog_action(opts)
 	};
-	if (reset_head(r, &ropts)) {
+	if (reset_working_tree(r, &ropts)) {
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));

-- 
2.54.0.1189.g8c84645362.dirty

