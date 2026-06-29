Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D664346795
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718492; cv=none; b=Z0f9uU8A+AEYghgYhrIoEQEdRkmcwQ1V0BwWlAcONLMC9MEjrN6hov9bAVtmS40GSl+fb7Va2MsZ7M3dHLi59PHusam6zPR7UOFDLNS2DIhIlo01nxW8hFsu8fKPzP+nzYu6o1Fc9KAh6m2zrMM/QBMcPq8SVwvkG4cinLKVWzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718492; c=relaxed/simple;
	bh=Nrc9t+rKRDHsdv5Iw0+Jhj+LySF3UlYHiV+MD0H163o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V5lApdygytVJQvD4G+9iYEC7R905yxxYbrpFHpBqWPzDSPH+9N4Ms5yn21nZnb/cL0FG1b3aPLUQ4QjmAJD+dg1YqhtavHv86dWtBS8ghKhTCiqgjzDVT2hRzrr6znF8BDi+31redSRUPXmdZOeFVyIN012BhzWjc1jFMI+gKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QQTVz7O1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OY/1i376; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QQTVz7O1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OY/1i376"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B121C1D0008D;
	Mon, 29 Jun 2026 03:34:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 03:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718483;
	 x=1782804883; bh=3xtuHNvWRUsiFURpPX9Jut2+oXf3K57AOPG2bUrehMI=; b=
	QQTVz7O1or78wyysNuoba3jbO1J1ht35wLPAaYpgYIRA0zWQBHcpFo/gchd0fNs/
	Ve8UIEJ+UTZxrNdUie//sn3MxVdDHcspCNwFuKrWQnImKiVUs1gtO+yYx+eGZe5J
	cZ6nz7U/A3pC86EkbSb1tc/qgXckmPM2xLlFGgRYROD3yrvqDdXUEHV/1opN3m5o
	7YFS+3Y4VvPg+Fg+uoCW/9eoQHHE6AqYwsrsiUoLooLkihr7huZIi3jE0trWTV/q
	BXXMlTWbMKivT0LoBqBeaaizr8bFCvjbEEzyNsPC2KXLMZMXiV3yCf0guk7a0ttQ
	BvKUdT/HtC53/Er1TuJrGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718483; x=
	1782804883; bh=3xtuHNvWRUsiFURpPX9Jut2+oXf3K57AOPG2bUrehMI=; b=O
	Y/1i376U4RQ4Na4lTq9JmUenVri6z6AvTXo/9hjxdPwaJjr18OTnnnD2mz7GJhGo
	o2V+Dq3te9pQeKIq0yHzi70qPFk96TW+l65yl+69ItVhdau8VMmVZLh7gSgTPAT5
	P6CNsHErIsE/wzKcqisI1o68tn4K8DuT0wmU3WRs1z7Uj1llD4ZOc8i4gZIv7bqW
	XgHFJaRjLBUjNTtqP1LkUOFNc4+Zs+c945+UsPCdtkzdGptBqToKnH6QN1ySSeRm
	ZwiZM3fVyokZZSEKCIGlWXbILRSVeA5QR3lL9cDAOcdUhnqNNHHLMr3kLKKDp9kk
	zZjfhbBEuET/i1+JCN+tQ==
X-ME-Sender: <xms:EyBCalaiwlMb7Nz3BowoHkskg1ZfEa81frXtkF11PnuoiWP3wNhg-A>
    <xme:EyBCalvS7abvTiDufHI7u4CeeGpy3TXGHbkqIrCVrrq-6PFbWF26qSw8Tv6_8hPsU
    lh7Njm8Q2LE5NlJuiiw_WTD8nN47_BAAngwIOmT4NVLQwsmeDhGig>
X-ME-Received: <xmr:EyBCavMhmvqtvExrLkGCz52wjHHexq0ySo8bafWawVgcd9_v2fZwl0sGr7TxnZb627acCkFiywtcGYY1ZnedH1pw8TQM9wpPOSGlMRxD1GkM>
X-ME-Proxy-Cause: dmFkZTFtwW+jrswXR2sqyckO9gfZ6S1zTRV9x1AzwWISv4S5GQeYD39MCLhCSYQ9JC/y1c
    npLVZAirVrNTDUG1FfT8zRyjFPxjOq0YkCBphiDhd6Zl2+0Va0Ji8672uuvoNsAlkGjsby
    /fpKLxAigNdSSgUGAMPe7yYIrMRwQgGv7NtTZwjz2PJ6yYgwdXm3wmBGV/T77ZZzeNQp0Y
    xjkn2eSgvSZkg2YACzeL7DjzkuCOn39jFCLMTy7TykXuW8I/lMeMnQFpj0UOayI8eLXeRj
    qqFffAyn+OnBbxqYZqQ7RhQj+Dm6PQXec2R+tuZcr19NHYptTidYIpqKU88o0gD9KRksj4
    c7oBdsdNZaY6ttNKnzFDrzAtTuQC130GHPse4oq6lEaPlh458BcS464+EokQ9JegFwEm6B
    5HUbxTnOWRLXwadFL0DafbSfMGhLar4P/Dag77cAswdVU/byc/g7d5VZGD2kEEqwhIGv/6
    X0z4UpXUyPPdzvcF861ql9mXRt+R5YEYmEEgAtEsnGDMZf1JMYc1wVIze+2oCVDEBANq0q
    UXekbnrsgxJ6CPV1bV943xearHvoG6FYm1gdB/Ak1QXg+uc8xJfX69umVHSaMbgWhJpUKX
    8Eo8FOQ+nTjg1cxCalKzbGjVfxMOwdD7hEurb9SGDT/Kkgl/+k0fu0jncMeQ
X-ME-Proxy: <xmx:EyBCak7lVMPFjWWn330BxmfCBbufSU3UV3gOL9goXuGHrAjWdUDiOQ>
    <xmx:EyBCatQsGocmkl12MQZNTLSrhUv5gCNY-jZe7FMnuJYVFhXc7CKGJg>
    <xmx:EyBCapCSqTTRARfy6syfZNX16EiCQXQB95PoFLGrASToA2LXG7OQug>
    <xmx:EyBCalGj5K3nBaRleajnqhVJqfpVDXltCxtrTkVS2ec257SrjDls-w>
    <xmx:EyBCat2193KWKm9o7xASWBBIHG0Qur606ChqVjDx-q3kqPfD1sxDJxVc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5dd10e16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:30 +0200
Subject: [PATCH v7 04/11] reset: modernize flags passed to
 `reset_working_tree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-4-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.rc2.803.g1fd1e6609c.dirty

