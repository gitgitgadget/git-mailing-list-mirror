Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF693F4841
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531707; cv=none; b=HPLRGnUjSBDNP0ea5rscmqjHgsfGbb96ovKOtKYSu8m+NGRDAPEISEjLdcpbM+L9Fgwe6oa/76KCiLBTalmTeNYWTlmMajDzHAbCkzBP5PGefW2qh+NO0N3ikbWb8MpCV4nly6O62GfDnT3wUtd0jOgX4PIFVNrkFOKuPJmZ0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531707; c=relaxed/simple;
	bh=X0ww+1kKGnvZQ6wougSi57Tvd0ua1Q383cbjqsoXLB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vim/fcAXUiKhrL5U6/eWPdcp8wsunVAVk0srsqsKAI1X8pJPetDCR3PfBrXy2AAtL3Pk45Wm4ttkC8l+/nTZi+1RdQkdwidADtQ1urqpod0TCkLut9oUMW+eqEGy6Ao1AZUgyLairaRlZYbwspjvJ69vfFjAFSJEQyS3h47hQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JZFSiser; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3Tsm86w; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JZFSiser";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3Tsm86w"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAA25140009B;
	Mon, 15 Jun 2026 09:55:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 09:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531704;
	 x=1781618104; bh=R12cJSgy1yxqXBUrXCN5GNR8D5bFlwe+nAWfLMsP31c=; b=
	JZFSiserN6ZclJq90Rvey/wJ3kQBbDJrUZrPmBiJ92Xccy4HCYCs74k/eWN54gNT
	ffrnpvGZH9+P+6PaTbBYM5KiXsPDIwjpzaYBqRUri2SPfnaZ64LsUgcqLuZaTDlG
	pJmO0g6ovbM1rxbkjW0bO2xSA/jaGYqFcpX+MlX2FlkXExwY2a7nyIxRUpA3Iny1
	xPZhU9klgc0ajhKKNupUUFbhPwk/ROvF6hRZB6RAJz8N3XHMOf/wpUS+U2iACVhA
	IgR5F8XnM9J56OYPd9Trspzdl3MdjFfgt56tUKVbM4ec8EtgPAvg/WGbqGTvDt78
	EH4ZFcmRh1Gu1SQlI4Y3vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531704; x=
	1781618104; bh=R12cJSgy1yxqXBUrXCN5GNR8D5bFlwe+nAWfLMsP31c=; b=e
	3Tsm86wfQegOao1yxyBgAMVlLkGGHGLq55g+/4AkwGCcYTmCSspB0C7nb0WO2c6l
	mfVEb6rHKoX5hgO99razKePLcw8edU0ftwCAwHI4xqLltWFIaLk9+4fssngy4N9y
	t+oLcRwjgSGp/6IN9KaIERHSnri5XLYF74q/OPJ9wd06uSXGpZPHq4rH0AgRFvB/
	oKK7sF9vF2W3+rj/BmykIxJx0Uu2LUmPC1FPHlG1HPxqsFr67aE3jX7YbC2Vj5w3
	zl86rlo3zjhG30fUmJzyrwZ9py54i7OKyVS6BoFMXOoKkPTKIX5StC+Fv+C5Qxvj
	OBh0txbaVAuHaUQi4p5Bg==
X-ME-Sender: <xms:OAQwanygL7qjw_HAnhOdsy9i9husNmG8LujC5eiiBwTkMXEzt8ildg>
    <xme:OAQwagznZxAYmbYxsYxaPqMI3saworO711BM4Gvkp3ELbJS28EdPUdgxkcKeJjAZj
    nefre5c2vxBXGUlFQ_3va1mgmKYaqdKueBSceB9XIz-ijbvVN5D_w>
X-ME-Received: <xmr:OAQwahbl9_FvMm50ORfux8If2Z9IIpHpWgL5CKmJHUUwxlgrSByfaKFxRM_oPbC03htJbFdZt0nkRywyttDT6JEigioFSqt_O2-q8cgl7w>
X-ME-Proxy-Cause: dmFkZTFlS4azb0/DtaDSvRJ1bBp7yaFpq/8YUBwjPmeEt0A8m+eT9JYYkp9PEfV4icmtRZ
    otT0+W8NS5xcQJZPWNcCfe8EqDEM1xZEw/Z8vUf2vr0DH1dYbdj5vaI8FWJcuWDo7aQ6ZE
    MLQFzF52yiykqII+w+YwAEk6KBaA71EXclvuXc5cPzBHs3YCHLYIs0rbe4a9mVGN0TtenL
    9GBl4ktG+6Gb/A2TB2vaCc5cRb0VTovmf/+/g7gCn2ngs105DXVSLXTRK4nRCklkWYUHZn
    gpGXpFXHmgLBJTUvIh+q8MM5sNbrxuDKrPSvDBDK/eEgCWSYPzUzTRIwjp6Wv1wUmgfVk9
    GHxswcrDn+qPVtLfBO8ZzMOxJDcccmXfB6c0jNnqDAg81ThF6TEbaS8z5YdjFowwLAhtz5
    L+Ja7VlHct9ke6RahAXsx5ha0PyI8hHpuME1ZpAPJQaFi65EfT76/TDop143VvMk74UMQ0
    Xz2aX8FH4dHDpewyBQl2a+72gX3Kerk9ZVMv4QdC9k8L0iErZVFTKL6K/IA+u252glbdDQ
    mGaaVCJmvbRLmZGFIXMZgh1EemadZudoaBdM/gt01zTOyLjtAuU4J72WcVnYOdOeQeQVz4
    tuAvHzxQQBSHHVIC62Y+UVu6DCgEfdReDfUq78eMYNOOOYiLrFDBJD5LbhIg
X-ME-Proxy: <xmx:OAQwahWoogaDvcoE-K9FefKaQpHX1R-Ng4qbbnIq8s58nq91_gpWBw>
    <xmx:OAQwavi22XVDujfJX7xOg-LMFeb7qh7bdN4JUleUiIqEJLJZmmkeaA>
    <xmx:OAQwavv4JnxENdk7dnnHePY3rsHQo4X9codGifxXRn9WZlnWiJBweA>
    <xmx:OAQwao7fcFqHSMlViMvDDGmgGErK-4JvPv_kR0ZbE3LgDX82OlQFjg>
    <xmx:OAQwagmTflEzesJgRs84RIPzcaViY-2OtAhfxFe_S9TaMK-qkYv-O4cq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:55:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d55915d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:55:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:54:53 +0200
Subject: [PATCH v6 03/10] reset: rename `reset_head()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-history-drop-v6-3-2e329e536d78@pks.im>
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
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
2.55.0.rc0.738.g0c8ab3ebcc.dirty

