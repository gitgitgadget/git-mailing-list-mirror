Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302534AB0B
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718488; cv=none; b=uY41HAW1Hj/Urrb0i4K27pDaKpnIBP4G2ZmBxAlxpy6nr2kpd4/Jbgvc60EoFXbAd50csfEo9GOlhDlqxPbwcxOCSZr81oMZZ+bplwa8cRhiXvvrqj/72ow70SDFaZDlEQuvCKw3LqBG9wULk2ybLHl3pVXXKYCj2WxD+0pHHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718488; c=relaxed/simple;
	bh=YmFWF27AVUMDdJa4P4lfJk0SOXaeV0mlDFVzGm0yRNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sm6LojfM9KqAlDBQRlUBarnqXCI1vF/TpBuRmOpBZ1UBfItyBQODsi8GoWuIoWjoGnAIUh47eWrjQQOTctcfYtVNtQI2r5rdL070ZJ7Yl2CqpSp/PkO0r84KpcHYglBdO4xN/pfmpxSYkvYjXAx0VvTgyYtGwpzpl+9CQJRxYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dvSWCIlT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N3SztUly; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dvSWCIlT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N3SztUly"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F01DD1D000A8;
	Mon, 29 Jun 2026 03:34:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 03:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718480;
	 x=1782804880; bh=EMd+c5ja5A9eMxA7SGncfYlqOp1nlcu0C5T2xGD/1Vo=; b=
	dvSWCIlTd1AWtPru/sbVeRevik2N8Lk1ErEJWkrpRLGHsSEQY3QsXYDggyKzIZCL
	RCW/w0pPHW7blsfjjC8Z75Ss+BdU8Ao0ic9TrXzsL7HuXcvAW9LAxHO2bzo3qM4P
	t0/tfZJUWh7AOZgRPQky0J8x4nYlV/gkAS8PuiblAUsjQL4/63TSbxHIh7UG5XMy
	R6lKJ4eETBnoVJAzZEJMUvicqYEwTRyEBeSr6xG+iwA42K/VTzFp60/kaml5z4Kh
	Xnu4KsvuPieD58umfCPyK05nkHHH2nvY8v6q+CPG3DvBBAhZBhQ1CLo54RbtPVNq
	9IaOrG6W5YAbP6IuBttjXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718480; x=
	1782804880; bh=EMd+c5ja5A9eMxA7SGncfYlqOp1nlcu0C5T2xGD/1Vo=; b=N
	3SztUly65iXfFNfq3P0GvRx9UswxMi2MjSZmEqCm+Z5posVGMEl7YBkixj2ciOZd
	+Ro1X35jJwZ96oV2NVh5Cfd/8/OuLhlTJY7f5Wo1/0/BvgPgaVQVG3OzqjaowvYz
	5cLCsrylM8NZTl1USlBG2Hbl5vwT9C/oOzT9zqNHkHBtPbH1Aln0c/n8HxUIZQfj
	khfa415wCUHhZaLlDqEdP2gkob2+wXQW2I+4AygcCqfuQchM6MUvhRsZiGj3fHPx
	KNzn4WMQkurP99WvMMMQjrFkJOP4a8uGqNY9MqVhyHkPT9jKSAxzm8CwG6+0yR3u
	A2jj/MR0j1xjUQthmUDHg==
X-ME-Sender: <xms:ECBCarCP06oW4vw2SrTum15R3BAYxwARBcFRCRtZJUDKKYm-1taHew>
    <xme:ECBCaq29WclWO4j3bD8WlEOTor1pG25JOOmr9CH-gTLsV9z90MBXLGRALvtvfKOKu
    4QKxpt5LSdV5MO50128dC5rXhZQmTTeZBESgxBj0NjdAL-oYlZYfg>
X-ME-Received: <xmr:ECBCat3_kKNwSbeJt_yQ2czs1E-8pfmgTfEFCqnJEnk_lNPOF7NddbQoAAPbhtHXacCMeqFdcYFiwqeGmCBA3I_VGdK9X4RAyc9go22Yg6Mx>
X-ME-Proxy-Cause: dmFkZTFc4uQ6Qti1Zi9h94m4od3eMpCQCnDSYXEx7QOqzgywygLB3u2mJuU4WGTziEY0sP
    vssB/gclRg1ee6qJz/HkTNvVUAGJRzObGlYhlIWy2H0VizAeVI4Xeth5sjhla/To+149l/
    DnpD73+tyoScl3p4zN9NQkkGKn6ia0XiF6ce1fQg3g/N5exLIvyhMvPBClJO8fJfSQamiA
    fdVPH07ySGubvtRJl5FYb7NHirzBLueiOcGXimA9yqyRycKngriJVEG34RByO5A/F6lB6i
    kYa8uD5/S+7zMXFZ52b65RCnTypiqCWEjwut/seJuRz24f133R4jeJf+/yzbcKsEf0+ePd
    gj8j5LqbvYhrFo6VTyDcu5/wYjvs/ENwAn8dmPAxQKSB9ofH7d1CWkEAxKmHE2MQk+Ilt1
    xxjKm6ZxdCNsgKcTquTPRWAPKlC1ZPCM5qA9Dx49Df9ky0bGhCe6hZbXsdPW6GtQbNimt6
    cPP3KLHHp9e93a94AEkZLvQnAk2RYbz892sz4reZjGsT6AFIn8T90pnMnQGGl7vl7+TqVn
    7WYXqEjfjs+zTWxxyl4nzWgSf8WPaPRe2VLbhvx+j5il3bNYX6XY/ib+XmxwhnVTP19v9x
    Gu1mA6wfaKcGOwok6mPM7+ih4/NWV3rmQLjcVRe1iK51uZTihepknwsGkd7w
X-ME-Proxy: <xmx:ECBCavCdif-_b3uTIEdI1ZfJ7TJzGO-lPRuzWrKzV_3f_4PEhn0ywg>
    <xmx:ECBCas5VxjiLkxAxO9duuDNrf6fF6B9qhGCa9MxCi_Q0s69vdJqpcg>
    <xmx:ECBCagKhPxrQSVvfcPRsP8Z2Z9gPuu8ENJjQddu3qZFbJOaCLTRjJQ>
    <xmx:ECBCats122x78sejTv_oqYy0PMiD_6Lf5APwZxh79Izk0c-s47Fuow>
    <xmx:ECBCaldga6_oWNKzrpwB4L851f5Oli8uGoS785fbSecDyPgze5wSdanU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a93be00e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:29 +0200
Subject: [PATCH v7 03/11] reset: rename `reset_head()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-3-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
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
Signed-off-by: Patrick Steinhardt <ps@pks.im>
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
2.55.0.rc2.803.g1fd1e6609c.dirty

