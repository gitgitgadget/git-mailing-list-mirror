Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384D40FD86
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184448; cv=none; b=aX+Rnqq4JsOikwBPlHnf/oj28LRsUwzJ57yU8baW2OIJdTwEZCbc69ZdPRSH9Qk5cXUJxQWlwIl0dGKfcpDJrpDihfWe5d0N/+8LU31SUqGAF0QxYgkQlgVh2SEF+jKdtExoSxBELuLV493dY4Aufz249nrIuom8m6FXmIAMhe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184448; c=relaxed/simple;
	bh=bSf8iErqGbiZxw/zxiiYU9fq+L4q39GyxO0iN6s7bu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVOfW5Qs5sXlXku+0cSsxdbxijY+2nsiOrqrXaGCWDzJqHYQ/k/d2T4kIU2eHDNlKqkfuM0oU11d9sh1apXcusKv77LdRmZWOIywXLUdxaYjmVRIAm0DQWcl7TTJq0xUwjwu2noAs2If9OKyKNM1c1tI3H542qII2y34Kn2Ra7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MBHXZwDX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ut9g4H7W; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MBHXZwDX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ut9g4H7W"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id BBDC3EC0188;
	Thu, 11 Jun 2026 09:27:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 11 Jun 2026 09:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781184444;
	 x=1781270844; bh=XqGdYvpgUDtk8V4An2rKol9F75S2p48by6LmYxZ4B0I=; b=
	MBHXZwDXmmDRXD1VF6CfCv3NRfgA738Nm1kaaJRgWNjsUEEXqRULVPi6wrGz7W96
	HwIfCPwce57Vu2mGGDjr0AEN1LycbGp0xJUPVXm7tuXfSTAmNtXjKdMhESgE5MQv
	WcpNiyRHi/ZJ3zDtWpFix4jYWxITVrAuRFQPqdO54q0dvrIyPcY+9Fhap/ke0ByT
	guqKjvGyQ8VJ6LC0+hrO6VAGWyLROM+MIp2/Jz+Gl/DrbqPo0xZmu9KoHlf/G3dC
	T4iHBgEH0rHgxcWTEwo+s4Pkyax3cwVadm436asLiblaUF6wqpqp8k3ekhsSHHnA
	pTQcztQPM3qH7FwYGEbxNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781184444; x=
	1781270844; bh=XqGdYvpgUDtk8V4An2rKol9F75S2p48by6LmYxZ4B0I=; b=U
	t9g4H7Wb9gGDWEk0NB498HYdgKdAp/7lXXba+C5+WDAtwMPH0T7h2R8wOcb/sr4f
	/6eH9xUlns9LB7naPJ3qmxnc/luLeJQUvQnkFo2nleUIrJ2jalm0FWtb5Lsx3+br
	V/RxUf8MEP0l/QVC1OGBHFAbUdwcdMPqGrCghYFDpGt6BpM8eBK5UJ5jzAZWXC7+
	XQDq7vWXvg4A67uHlkhgLDh7SAo9wsZNV3vQbshgJPmURP6ntOTcLxlgboo8vZQk
	nOxdFH3NsfndAcs4ycUy5xxDHPsVmRFyskH0csxH144TZ6VcSOTnCpbSxRU4v6CC
	ewax/LVdv8Hpimq6SB2dw==
X-ME-Sender: <xms:vLcqau-HwgikDyZiJfA3L9WnfKkf0TM1rFG6HLvWh8XX5bEcp579nw>
    <xme:vLcqagPF6ZhSDT6nUy7uNp_RwnYMhRmT-8uH9YoQ6lQed_-pgObQWhFSx2yeeIRwJ
    mS0GVJ3seuCIYcGBxbVNHO5or6ieMcBkR_Cgv-HL6fJOGB-3Vr_>
X-ME-Received: <xmr:vLcqakFRY5CNP8mwx7M60DXV_ipoql_sPyfd-QXbY0i6CmWETCcHxWiJp9loQf54PWUWpcgdpjtVvvs1e33WEAp82zTozV2vxl7w3O9kXBv4>
X-ME-Proxy-Cause: dmFkZTFdsFO8GAZEDRC1v6gPbOieygKG/4Q41eraPWnJ7dB+viqtjRnYn0eg46NKtF0dQx
    ylk/OqABr4Ft6Txj7LPCAcwnzNgcfX8xH3tqetraUHnncBRhLefn5iV7kazuN/nHMJR+8P
    4kY9m64s5n5dno43hqgd485WNQAQeiCGRJkqw8ZYBITcrme8Xw7YdeY3MHDfkETtc4Kbvc
    GjWuQjpVR7Eseg22AGvaCBNR4HvurNk7FsYIZUWYnPpKmRNm1gwlCcdwQpc+GbmCXS+hy7
    qmyiSYSP2ZitAUyKgRTWF59NEyZaAg3geYDTmcwP/pIC9Dhce3ijUB8vu35OqhdsmpvRJU
    IgvItUXgOqYlDnbZtGwNACQmh24yvcTU6UvzOJaIgEgtz+A6yyN2kZqIww+3NJEpUK4mze
    PXQz4g+7Z699e8OoX4IakVCJmbNwSEzIuWt58MlY8C5GOgAgIjkBrgSrNco9wzMga8aT+x
    jwHBIlgMdoOTwov1HQPmNhnDOuRXRFIJ22V5RblrK3U3dLGBCu4iV4CHE8MR95RBnVJPZY
    DZVa+PgltB3mCj7ScVy4IZTkpYLMN/YGnsazR89GXnQD6udK5ZSomYxwfNO+nd1s4DVdAA
    Fr3g4PbTwAGaMciaCEhXZdRkAvbS7HH2uofMoJfk4ZWd2+/tiWPMO/kCiXAw
X-ME-Proxy: <xmx:vLcqamRYMv9vKrHPnvdkKE_MEA5dUnrSp4b8_H67ruqL45lIz-ki9g>
    <xmx:vLcqapvCQm4SRBTq-23yK4bzTfUtG1mBY28kjQ8ZlYF0mZoZIHIIyQ>
    <xmx:vLcqamJfmbWPNP9UCFEyCizdMGSPhbuRV5mLh0-CaVLqLYl_VoPufQ>
    <xmx:vLcqamkDG1EPUFIqmP7y1KaKOd4hQUzBAO4aEyrw5g4GR6MHYpKJIg>
    <xmx:vLcqasj7Jg-B2iSYj6pt201ymUpKKDslGh-7IRDWNkG4_hHMIJMwVxQJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:27:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 070b866f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:27:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 15:27:07 +0200
Subject: [PATCH v5 04/10] reset: modernize flags passed to
 `reset_working_tree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-history-drop-v5-4-34d35725559c@pks.im>
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
In-Reply-To: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

The flags passed to `reset_working_tree()` are declared as defines. This
has fallen a bit out of practice nowadays, where we instead prefer to
use enums. Furthermore, the prefix of those flags does not match the
function name anymore after the rename in the preceding commit.

Adapt the code to follow modern best practices and adapt the flag names.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 15 ++++++++-------
 reset.c          | 12 ++++++------
 reset.h          | 31 +++++++++++++++++++------------
 sequencer.c      |  9 ++++++---
 4 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 22fbba3c62..06dcbaf5e8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -607,7 +607,7 @@ static int move_to_original_branch(struct rebase_options *opts)
 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
 		    opts->reflog_action, opts->head_name);
 	ropts.branch = opts->head_name;
-	ropts.flags = RESET_HEAD_REFS_ONLY;
+	ropts.flags = RESET_WORKING_TREE_REFS_ONLY;
 	ropts.branch_msg = branch_reflog.buf;
 	ropts.head_msg = head_reflog.buf;
 	ret = reset_working_tree(the_repository, &ropts);
@@ -862,9 +862,9 @@ static int checkout_up_to_date(struct rebase_options *options)
 		    options->reflog_action, options->switch_to);
 	ropts.oid = &options->orig_head->object.oid;
 	ropts.branch = options->head_name;
-	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	ropts.flags = RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
 	if (!ropts.branch)
-		ropts.flags |=  RESET_HEAD_DETACH;
+		ropts.flags |=  RESET_WORKING_TREE_DETACH;
 	ropts.head_msg = buf.buf;
 	if (reset_working_tree(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
@@ -1384,7 +1384,7 @@ int cmd_rebase(int argc,
 
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
-		ropts.flags = RESET_HEAD_HARD;
+		ropts.flags = RESET_WORKING_TREE_HARD;
 		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
@@ -1409,7 +1409,7 @@ int cmd_rebase(int argc,
 		ropts.oid = &options.orig_head->object.oid;
 		ropts.head_msg = head_msg.buf;
 		ropts.branch = options.head_name;
-		ropts.flags = RESET_HEAD_HARD;
+		ropts.flags = RESET_WORKING_TREE_HARD;
 		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head->object.oid));
@@ -1876,8 +1876,9 @@ int cmd_rebase(int argc,
 		    options.reflog_action, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid;
-	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
-			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	ropts.flags = RESET_WORKING_TREE_DETACH |
+		      RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
+		      RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
 	ropts.default_reflog_action = options.reflog_action;
 	if (reset_working_tree(the_repository, &ropts)) {
diff --git a/reset.c b/reset.c
index 799596398b..4ca7f23a25 100644
--- a/reset.c
+++ b/reset.c
@@ -16,9 +16,9 @@ static int update_refs(struct repository *repo,
 		       const struct object_id *oid,
 		       const struct object_id *head)
 {
-	unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
-	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
-	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	unsigned detach_head = opts->flags & RESET_WORKING_TREE_DETACH;
+	unsigned run_hook = opts->flags & RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
+	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
 	const struct object_id *orig_head = opts->orig_head;
 	const char *switch_to_branch = opts->branch;
 	const char *reflog_branch = opts->branch_msg;
@@ -90,9 +90,9 @@ int reset_working_tree(struct repository *r,
 {
 	const struct object_id *oid = opts->oid;
 	const char *switch_to_branch = opts->branch;
-	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
-	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
-	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	unsigned reset_hard = opts->flags & RESET_WORKING_TREE_HARD;
+	unsigned refs_only = opts->flags & RESET_WORKING_TREE_REFS_ONLY;
+	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
diff --git a/reset.h b/reset.h
index f130152014..2e5826de99 100644
--- a/reset.h
+++ b/reset.h
@@ -6,16 +6,22 @@
 
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
 
-/* Request a detached checkout */
-#define RESET_HEAD_DETACH (1<<0)
-/* Request a reset rather than a checkout */
-#define RESET_HEAD_HARD (1<<1)
-/* Run the post-checkout hook */
-#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
-/* Only update refs, do not touch the worktree */
-#define RESET_HEAD_REFS_ONLY (1<<3)
-/* Update ORIG_HEAD as well as HEAD */
-#define RESET_ORIG_HEAD (1<<4)
+enum reset_working_tree_flags {
+	/* Request a detached checkout */
+	RESET_WORKING_TREE_DETACH = (1 << 0),
+
+	/* Request a reset rather than a checkout */
+	RESET_WORKING_TREE_HARD = (1 << 1),
+
+	/* Run the post-checkout hook */
+	RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK = (1 << 2),
+
+	/* Only update refs, do not touch the worktree */
+	RESET_WORKING_TREE_REFS_ONLY = (1 << 3),
+
+	/* Update ORIG_HEAD as well as HEAD */
+	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 4),
+};
 
 struct reset_working_tree_options {
 	/*
@@ -33,7 +39,7 @@ struct reset_working_tree_options {
 	/*
 	 * Flags defined above.
 	 */
-	unsigned flags;
+	enum reset_working_tree_flags flags;
 	/*
 	 * Optional reflog message for branch, defaults to head_msg.
 	 */
@@ -45,7 +51,8 @@ struct reset_working_tree_options {
 	const char *head_msg;
 	/*
 	 * Optional reflog message for ORIG_HEAD, if this omitted and flags
-	 * contains RESET_ORIG_HEAD then default_reflog_action must be given.
+	 * contains RESET_WORKING_TREE_UPDATE_ORIG_HEAD then
+	 * default_reflog_action must be given.
 	 */
 	const char *orig_head_msg;
 	/*
diff --git a/sequencer.c b/sequencer.c
index d73ecf0384..4efe831178 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4677,7 +4677,9 @@ static void create_autostash_internal(struct repository *r,
 	if (has_unstaged_changes(r, 1) ||
 	    has_uncommitted_changes(r, 1)) {
 		struct child_process stash = CHILD_PROCESS_INIT;
-		struct reset_working_tree_options ropts = { .flags = RESET_HEAD_HARD };
+		struct reset_working_tree_options ropts = {
+			.flags = RESET_WORKING_TREE_HARD,
+		};
 		struct object_id oid;
 
 		strvec_pushl(&stash.args,
@@ -4870,8 +4872,9 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 	struct reset_working_tree_options ropts = {
 		.oid = onto,
 		.orig_head = orig_head,
-		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
-				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
+		.flags = RESET_WORKING_TREE_DETACH |
+			 RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
+			 RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK,
 		.head_msg = reflog_message(opts, "start", "checkout %s",
 					   onto_name),
 		.default_reflog_action = sequencer_reflog_action(opts)

-- 
2.54.0.1189.g8c84645362.dirty

