Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355648094B
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905751; cv=none; b=IRz1OwIAjtnRcGC8KbVGiN43sRG7UMz+cIIE00bCgXuIyoxN5s7Swl7NHV34dtkatrgOVIsY3jy8Pky/15/rnY2zefKFgryIQEN6Ohg7opFUwqMh0E7PPP5vupnXo11Isy6o/WF+oeazDTp8IH7ht1M5cqe3izgQ04mYXrqZ9og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905751; c=relaxed/simple;
	bh=oD3Z8N7RqGTObN2h7bYO9STA1awtsyDOtLdCtOHEjko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dSmx7kTo0j9c4wZa2N89QJMSP5I0uolSRa8Gy+v2g3nmvMS2knraRizm0W86u0OXoMyGBhTG+fg1WONCi+3GNAyPJr2rZlaDgO9BDsXCBa+QPTcZ59qv3x+pnLm3zaA3xXOqZ3wUZxMjzLpnXICN3cJE9m7PbaC5BPuePH2mUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sj4X0UiC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzAvlvUk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sj4X0UiC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VzAvlvUk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 483F4EC0113;
	Wed,  1 Jul 2026 07:35:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 07:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905749;
	 x=1782992149; bh=QO9iAVZRudlgMmg+fUqFlLGZZm8Sl04hR/obmlkeTy4=; b=
	sj4X0UiCXA35xFbS8laDWALF2/PLP4z0W2KoRWH4gYJC5EUIC+/Zs8Cj4FBpET2U
	rL2Zvv09FYOPLjPpzaImgC71qzAI3SGaLfm+0CgSpq4zvD9wuomwcNWwTYfZiRuS
	Fak0cZBxJe2ZnLtRxKUMcf4D4cTiZ6AxltTe/XC5GZNZAkHhDddjAFHEAk6ybV35
	yfHHR2hCTtiaPnOTbkUlpUK9blKGz+BtlKPaxMudrzT6RycpoucIzA5tiEdXUv5j
	yLaEI8rsZPqlOwcrXsjALJ5gGpLqy+3Iz3tdiM9kW13lW4T2EH17fEImco1yVNAy
	0QZtQTv2vQk+Gb4wozKLfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905749; x=
	1782992149; bh=QO9iAVZRudlgMmg+fUqFlLGZZm8Sl04hR/obmlkeTy4=; b=V
	zAvlvUkOpiEKiUFoGeTzKhSLv6zi3NAPiH8B7UI2pLfA8+Pr4jINx7a4MF90do1X
	FYkdoWj9I09V9Etmw6Z45/khHpCwoMH43rxhcjVONYsugiQuP6vB4FmpVANCvmXZ
	wklr0nhOKdZsQHAYl5IAqxJ/kwwgc1tZI8h5Um3mrL+QOjiFB0hnrp/uH3pbjUJG
	O3XPu3UvU8BK7EgS6D56TUYlGeSLKD/cTmtXZ1pTDJgvvVcD7bxK8IebL0WtQbIQ
	GX8hxz127eUfeAXLlhzskJ2PnOMI/RQKRbbb7sZ2b3YlbCuUQTyIbFRPS7h68KgG
	dZO9cpNOsMyQ/MXViEvbg==
X-ME-Sender: <xms:lftEand6MU3XTehKypowDRVMM9b4ML0v_YMzUwGfGvhd36JOT1PkrA>
    <xme:lftEamh-uU2hVkG2CS-AXn3HVHH6BeRZnS4ODf6qdYtasD-83_OaBZ7XgqvMPayiD
    hFcjzNd9HzapynldCkgztLAeWtqR7yazfRb-AsocKV4c1VtoGs8kBg>
X-ME-Received: <xmr:lftEanwR4t3xBDmmjae6nR7SFyXUrnlOK4i3z8E-1XoFU6FzLMAryZF6t_W586L8rUpfm1MG3cTw_LQOamrUcwC_GZytFmXYa5bLisCYb6E>
X-ME-Proxy-Cause: dmFkZTEo8ZZHEmZJrYDFbUzcKrTBWt5qTuoxbO1aOxYxA3DYPvrzR23lWBcR7jXqOxzD98
    o3z+qAe0QCn9j0IS5sJhiERCedRGEOsiP3ZFDurmq72DBHYhIijNlzIcMKv7/oQHD2fAI6
    a2YJ3iio/ewW3qzpdfr/ZyfoiGsqTRhEuI/PQ1QQ1ozMTJKkioXe3ov6ZmhTYTkehKJ4Tz
    Muaap+SlwiohuWguopspR179G0mcemhvJiII58WbJUfwhMfpL0kERvqXJu4VfajmyJWXmi
    ovh8MCh8s7BmgTwTYXpmSmr5e6X+bOB6iAA+Nffgaj812s8+epjEmeIAUw+pkWoGKlmLhX
    ofgH1vOb9PJuF6lYWqv9YQ7MgLRtMkwHrFN8fAjokCitXH3RplR5bkyzIYsepNAiBkfWtQ
    sg1yL+WVYwU/8HPUafxzwVtJXAVkcNiWcIiQBbaOvk6l8408N5nhjvr1NpejpSAffLHphE
    um1vkypRGciSFFeqceCdE7Wwwvp+iEnwOlrh0+VPW+ZmVKghryzrm8MHuF4wayonq/rUdi
    vIm/SOgYJui7+M7JOII2iI/Xw8WBlh470Rgi4qh/aE8ZPzZ548Ck4G0HXL7dAWzGYYQc3r
    MFV4x2aGr4fe7y8pOqn4E+4sII8xdzgi42pAKMPPG6yin3L9M7QLw8luzy4A
X-ME-Proxy: <xmx:lftEaqP4dsoJt35Rt5ZXzH7rlyYJoJJgjk61M_rnasxo8FL2zCCEug>
    <xmx:lftEagXGVrb0v83FzWgqMa0L1XjZeykDw6eufGv5wR8mFDW2Dl_Sgw>
    <xmx:lftEam3SRHot6sXqcyH03WUYFaXKp3tnpcSGhto4GzDqeiuSqZB5hg>
    <xmx:lftEampiG1LzMtn6Awb2CYLzHBQMx7hYOMgNOOjGtkxSK--inMWVNA>
    <xmx:lftEapU3muaiTyOfHXvKM9NZqRdKpsOgsjeZFh_l5Vmeh4VkYcfLb0Hf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:35:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b429aa86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:35:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 13:35:31 +0200
Subject: [PATCH v8 04/11] reset: modernize flags passed to
 `reset_working_tree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-pks-history-drop-v8-4-19b5cdf1facd@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
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
2.55.0.795.g602f6c329a.dirty

