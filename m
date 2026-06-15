Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE33F5BF4
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531709; cv=none; b=C7nquIz2QAeTRXk218qp5o+eIGJhFvBM1jVEPG1bKmVyq+piEK7NV/y7bItqvH+lfSd/N4WWba6Wend4Ynpu1G3ZfGyI4NoSl/gNcf41KOH7sqGvvPpjIhFTPQQMoQzGOjqE79d2b2uFUwtyAr9XKnjIP497eQIzK2knc+Doh08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531709; c=relaxed/simple;
	bh=5ux9aIT4cZBL8NMkbufnL8AeJEhhGfeuyJenLSc74Wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bt7KMP8aTBy38IJfwGJMlmI4NpwNR9YBK7n8K6QM/TXkwoPk5snboXpDlDlNmziSZcVCRqPYfCj+YY8TQyOYv3q+a3fKucmz6UnoQ0QSuwN7jgzE59yP9G86LflD8SLiqMbP7P8lVvNGoT2IRVaxCq0RIPiiBSkbMVzQHmbrZ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vjD1d8MA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P3U+jNvF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vjD1d8MA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P3U+jNvF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 20029EC0287;
	Mon, 15 Jun 2026 09:55:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 09:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531707;
	 x=1781618107; bh=Nu4BRU0/89jB0Yo/4wpj8SHnQMzrqsr6kuzlrF3unLA=; b=
	vjD1d8MAcB0AomWIKzg4YNX0oh5M6+9U7TMgHiqv0h2UDnQ/McwYlKkrUGSrmaN7
	TZThMqQ3XQm4PSTHHKJOpzKrYAiKMY6szZkggR6IT+s3g8J7RMGuAysZaFDttVSx
	qL/uEC6W+HqzzydkqJXj0ai8Co5v4dRKNpgEQdOqkPreObyg2BToQpQjxk1+aNiM
	/6h3AwwqIHu93lf8dvGM8Egx7Whusw0zAY4wxSF191EtcsKtr7IB5X2nS3/X3JcO
	mSHSW+0QB1944DHwMz9YbKaGjqvTEx33EIFltTAIqX/JaGutb3z9DGcTxHwc561z
	eKRqS53MjxTZFMXc9CR3rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531707; x=
	1781618107; bh=Nu4BRU0/89jB0Yo/4wpj8SHnQMzrqsr6kuzlrF3unLA=; b=P
	3U+jNvFld+a6ewHEM38qZnjQB6+OY9KyO+dEkrv+T+PIaXe41Legb8guMI4TUT8R
	tS0K0NMEK4UYRJoFiOkL22wF6N1O0mdxP5zrPQaI+uRV4satiOlyImicewMKOtSm
	eb2NRADxEv2CUe5CPa0nXNVylJW9sNKj9LoWzczrWlChJPTweKjsKPv3bTcbjTrj
	DcbcooQRQVHg3I1eDRKuMur9TiD0Cn0jClpzro1OXD1jncrZSOdLm854IngrMlf5
	KoWgkTSzHipNEMuNxvhM5qMQPMKlPNp8UCgTl3yWPFxfvDjoqoSbbWVpPNpgTFa4
	8oyevlcy1ZeqxwL/mfhQQ==
X-ME-Sender: <xms:OwQwapqvr01y2sub9FVyiVw_OsCtBekuYF0DKoPQDs9_B_9ZlKBSfA>
    <xme:OwQwatJKK9_mSHS9ANRLWRQgrdkCuEX3tGJz-ctTNa8vmL_uCXZAPkX8hwTwn6vXZ
    wOLVBCvW0SpgWAmwljrzGJtFXr3p6dqA5HI3DIXWDdHfwL1ZNnQ5Q>
X-ME-Received: <xmr:OwQwamREVTU6vL-xcFuO1-r0JwS7dEq7FjfjjHFszJmnl3aJPrltin4AiPHSuSUzVJlOcb-7tsNeJeZuCdusxMUUsw4GSLOcWMqCjnmQRA>
X-ME-Proxy-Cause: dmFkZTFlS4azb0/DtaDSvRJ1bBp7yaFpq/8YUBwjPmeEt0A8m+eT9JYYkp9PEfV4icmtRZ
    otT0+W8NS5xcQJZPWNcCfe8EqDEM1xZEw/Z8vUf2vr0DH1dYbdj5vaI8FWJcuWDo7aQ6ZE
    MLQFzF52yiykqII+w+YwAEk6KBaA71EXclvuXc5cPzBHs3YCHLYIs0rbe4a9mVGN0TtenL
    9GBl4ktG+6Gb/A2TB2vaCc5cRb0VTovmf/+/g7gCn2ngs105DXVSLXTRK4nRCklkWYUHZn
    gpGXpFXHmgLBJTUvIh+q8MM5sNbrxuDKrPSvDBDK/eEgCWSYPzUzTRIwjp6Wv1wUmgfVTo
    xI9VA/3myLIeQBB1thRMrMlzJ4tlqH8iSua12zww12WuJoHBZLTE/3ze49NeKErVJlu37V
    n4d57tpO05jU0weDsbVJZDvmdZESROYVqUAJ1eCh5qrMhl5VJ7Zh5A/AD6QLRQAjKKrU1D
    TG4CAzC6+S635eIxsO+FSJWT/FyDNjmXTmr2OdYnRMUIQo+tG4r0nsSTFHoySN5bDqm2H5
    OXql0e+HVWQNeIdHFo+JeY6a7aFudHEla4n1Olt2t0b0QW1zQIAxRpm7QBUnN68awgls2s
    IOjihFa4o1juL5ee4/lgtgbmOsiVyVgDWRZ99aWohlgP09/SdRE3N4n5U5pA
X-ME-Proxy: <xmx:OwQwaktQ7BitnRaQibUp3Yf40ikIcxyloEvv8qDwyFfx1NQX1BIKww>
    <xmx:OwQwavbZHlLdj7OfkuVAqcioONVnQqOjxu9lZGFwsR5SCBKz9QHxnw>
    <xmx:OwQwaiETL-k5QnzAd82Z1jUyLueliFC0E6RXrl4kL2zr7fYHohvMMA>
    <xmx:OwQwarwlah1xRpYsmhJWwNl7uapU4zJnZFxMI7VPiDLL34lvtE_RzA>
    <xmx:OwQwap_RyHaV1Jfk3U4lucwuPz62OAYw2cGI3800sC_wuIIMWcoFssGC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:55:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36a94bca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:55:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:54:54 +0200
Subject: [PATCH v6 04/10] reset: modernize flags passed to
 `reset_working_tree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-history-drop-v6-4-2e329e536d78@pks.im>
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
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
2.55.0.rc0.738.g0c8ab3ebcc.dirty

