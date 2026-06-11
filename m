Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF1411677
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184451; cv=none; b=UpMcFwufZpOBodOugsBrme5X8UvTY5LBth5zkOsxNzHoH2Kxpkw/Zll16hkolSCZ/Jc0eJeSgm3pIFalDlbzQOdH5LdJPHBXOdQi/kvGc5zJSpQIR75159cqgQ9dJv27Yjc3oeAFjmsDIWnlCecL2suYrkYwWX2QTSW+SGBKhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184451; c=relaxed/simple;
	bh=ewNrSyxqG0y1PtL6YRC/LdzvOsDm29/mSLf0mOHJM9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckROM0snrN/OFGQoPbrO923i4nn7xkSVDkB8XWZ4bz8KWgh4Hw2/EWcFlEnLcraNfLNr1vmwvpuLH+2R4+4A1WdsN1c7PrnJ+GqsBIppus7IdA835elkPcThyBMZkI6cq9zfrk+/lrKiN1fK7F+Djw0ud93vLLUa7tErKYv8vkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L1IePUis; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fKIhHCSb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L1IePUis";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fKIhHCSb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BC8814000E4;
	Thu, 11 Jun 2026 09:27:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 09:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781184449;
	 x=1781270849; bh=+yEdadGx/jjiM+0mwyc2/r1aKbzm9DsBoHCiEIy6Nss=; b=
	L1IePUis/UCKDi09p4PFSFS7/Z5zYPONkCJb+WZUkqZOJdLwBFQEmYitwgwaWdKn
	4vH6CByNuq6n3p9sUVPqrCoplIdrbhmdfEmRwWjdl3ReDuujk1sMJfFTNzA1kPkn
	7Us2EXhYWixSTXRMQ/spCG+bnk1Oc/Z7ynFVO0FdZzsh8Ax7FoJ8XiwYpj0MsEHy
	BZamUeQ9s1tQJ/IyIISwplDdc8rp0xUyyg76EN7dAI0KlEVu/MAlzWeYoc0QX5hI
	zpM6hFd41qZYfYoleNfQpZXxq2BCUf2s4cKOkNPjiZga8LntWcJEQdmLcg2Uh5N/
	PZR3QAfu+JrR+MvwGEFlpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781184449; x=
	1781270849; bh=+yEdadGx/jjiM+0mwyc2/r1aKbzm9DsBoHCiEIy6Nss=; b=f
	KIhHCSbwBArx23bPXJXSm9w2ICRaAflGfKc5stmHFVEQT7nUbIvpGtgsRQpzvZlJ
	dL2ErAs1yDJZC+T1jZ+kLgfb/O6f+v7EvtuGv5gtaHMp2JDEr3uf7cMhAOtXYliv
	jzrT+u/UXB0BMEPSdo7Sa9suLn6gl+kMxrQzaNpTHBxW+2cuA6ErKwlho+kglN3t
	lq19doz1Plqi7KnZKlsy1BkkOO6TUnGgwWN96kS0G9piwrw8TKShA3WtGCmWOLuc
	nYsLt8+yl1adodpMytECcnO+i7vPjbJovFXeYKy2P0AhKRO8mZx9cth0Z9qAt9qi
	gPdV1fihzjtjvnL0/ZRpA==
X-ME-Sender: <xms:wbcqakSCsU-94EghjmvIdtqnNchwuzVQOQlseI4M0uEF1ZrZVgm_dw>
    <xme:wbcqajS57v0st9qwCX-Za9Ek0x7-ilRjTQ_BTw1uu7BjeSuvZ3cCbTMlzYkuYiMg1
    j_Xzgwh4EpG8sio05pwh6MrsKSMqt-DANvDoB5SQWSDogdNPpim>
X-ME-Received: <xmr:wbcqah5QD6LZRv-thqsLmZQqGhjl9dGCg0LP0ZL29yIfZnZ9uR8hMJIVuPtbwRCqER0rQjB1_c8Am_QeFONOvFk2b4s0Jx2j4xiIxfoCcrNo>
X-ME-Proxy-Cause: dmFkZTGTxPIFhuBoiEsDDhB9RSHDCXHbFJ5VnVZDD4bec7nRzrCcE+c/MFsVjwohVHwftl
    cVFao0kG58zAIws/O0Ei+RCSGpQ0XKAQJ897zbTpVEbAIBEUeVlBXzfOFp55wWFPDBC63b
    ++i23VB0mlc+JXzPK3+XAmANc+ZYYAp9T+MNk3HVd/hzScgiy84HRbrCh3vZt+7kXlIWUj
    ICMm9WiiSqqEB0XslkAYhBOOtsaSDKKRXTT8LmcdFGr003K4VIXcWEJk40SYS0wk41aqac
    5QeQLlxVantr78Np3u7bywp17Vc7XJmbCgEqW3Tgiuxa+RRmWIgUhEXLaBmgiHi/rb6RYe
    WzmJMWqY3qbUEYrcCEV8fBTGqrWFQmxLvs1FsDAVI5NnnM7T3nKsVq2/PplMhrAGCqByVe
    vGbp/kM85HQ51eAuEocyO0kxl0u06ccegeMvcrLIExEv3JWrbEZDKhmBn0zOT49anELMZJ
    byXOYSykFTEYEypRXQGyDv+1Z0601hSLNuO7dRLPrzqEvRSXsY2ujS9NJCGM5KNeuuhA+Z
    wz4Of9M6sPeaDUWY/WmLNTut00YbR1LRzr+PtPiJmz68/3PweJTwN695A0dzRX+liXwDbW
    K8Db3OhiRy1cgaimpXFlbKEg90iYd7PChkLMmLCUTOEppFYXW/q0teCsdxkg
X-ME-Proxy: <xmx:wbcqan1qJKabb5eWPhjgTLyQfoET-1roxsd7yGVIAMPnokrcBQmQWw>
    <xmx:wbcqakDtoly4N59FcaD2x3_yam0AHS1O56j6FtnUgPmRgNS0AARGdg>
    <xmx:wbcqaqPF9wAzf1YISN-zA-56X-bqZfl7ZSmn4EhQ1TBOTZiC5p_nNQ>
    <xmx:wbcqahbzFtoe5MM8e9__jZge_Z2lhCs7XYCzjtUvqrRWM4eTbs49UA>
    <xmx:wbcqavHP_vMSw8V_9MuHzbqH0g9zK2fsbiRgwM5qN-WW9mxMS225vn00>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:27:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f107a699 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:27:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 15:27:09 +0200
Subject: [PATCH v5 06/10] reset: introduce ability to skip updating HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-history-drop-v5-6-34d35725559c@pks.im>
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
In-Reply-To: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In a subsequent commit we'll introduce a new caller to
`reset_working_tree()` that really only wants to update the index and
working tree, without updating any references. Introduce a new flag that
makes the caller opt in to updating HEAD and adapt all callers to set
that flag.

Note that in a previous iteration we instead introduced a flag that made
callers opt out of updating any references. This was somewhat awkward
though because we already have the `UPDATE_ORIG_HEAD` flag, so the
result was somewhat inconsistent.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 14 ++++++++++----
 reset.c          |  9 +++++++--
 reset.h          |  9 ++++++---
 sequencer.c      |  4 +++-
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 06dcbaf5e8..10a306310c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -607,7 +607,8 @@ static int move_to_original_branch(struct rebase_options *opts)
 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
 		    opts->reflog_action, opts->head_name);
 	ropts.branch = opts->head_name;
-	ropts.flags = RESET_WORKING_TREE_REFS_ONLY;
+	ropts.flags = RESET_WORKING_TREE_REFS_ONLY |
+		      RESET_WORKING_TREE_UPDATE_HEAD;
 	ropts.branch_msg = branch_reflog.buf;
 	ropts.head_msg = head_reflog.buf;
 	ret = reset_working_tree(the_repository, &ropts);
@@ -693,6 +694,7 @@ static int run_am(struct rebase_options *opts)
 		ropts.oid = &opts->orig_head->object.oid;
 		ropts.branch = opts->head_name;
 		ropts.default_reflog_action = opts->reflog_action;
+		ropts.flags = RESET_WORKING_TREE_UPDATE_HEAD;
 		reset_working_tree(the_repository, &ropts);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
@@ -862,7 +864,8 @@ static int checkout_up_to_date(struct rebase_options *options)
 		    options->reflog_action, options->switch_to);
 	ropts.oid = &options->orig_head->object.oid;
 	ropts.branch = options->head_name;
-	ropts.flags = RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
+	ropts.flags = RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK |
+		      RESET_WORKING_TREE_UPDATE_HEAD;
 	if (!ropts.branch)
 		ropts.flags |=  RESET_WORKING_TREE_DETACH;
 	ropts.head_msg = buf.buf;
@@ -1384,7 +1387,8 @@ int cmd_rebase(int argc,
 
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
-		ropts.flags = RESET_WORKING_TREE_HARD;
+		ropts.flags = RESET_WORKING_TREE_HARD |
+			      RESET_WORKING_TREE_UPDATE_HEAD;
 		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
@@ -1409,7 +1413,8 @@ int cmd_rebase(int argc,
 		ropts.oid = &options.orig_head->object.oid;
 		ropts.head_msg = head_msg.buf;
 		ropts.branch = options.head_name;
-		ropts.flags = RESET_WORKING_TREE_HARD;
+		ropts.flags = RESET_WORKING_TREE_HARD |
+			      RESET_WORKING_TREE_UPDATE_HEAD;
 		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head->object.oid));
@@ -1877,6 +1882,7 @@ int cmd_rebase(int argc,
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid;
 	ropts.flags = RESET_WORKING_TREE_DETACH |
+		      RESET_WORKING_TREE_UPDATE_HEAD |
 		      RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
 		      RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
diff --git a/reset.c b/reset.c
index 99f2c1b012..a744b0f0fc 100644
--- a/reset.c
+++ b/reset.c
@@ -92,6 +92,7 @@ int reset_working_tree(struct repository *r,
 	const char *switch_to_branch = opts->branch;
 	unsigned reset_hard = opts->flags & RESET_WORKING_TREE_HARD;
 	unsigned refs_only = opts->flags & RESET_WORKING_TREE_REFS_ONLY;
+	unsigned update_head = opts->flags & RESET_WORKING_TREE_UPDATE_HEAD;
 	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
 	unsigned dry_run = opts->flags & RESET_WORKING_TREE_DRY_RUN;
 	struct object_id *head = NULL, head_oid;
@@ -113,6 +114,9 @@ int reset_working_tree(struct repository *r,
 	if (opts->branch_msg && !opts->branch)
 		BUG("branch reflog message given without a branch");
 
+	if (update_orig_head && !update_head)
+		BUG("cannot update ORIG_HEAD without updating HEAD" );
+
 	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
@@ -129,7 +133,7 @@ int reset_working_tree(struct repository *r,
 		oid = &head_oid;
 
 	if (refs_only) {
-		if (!dry_run)
+		if (update_head)
 			return update_refs(r, opts, oid, head);
 		return 0;
 	}
@@ -197,7 +201,8 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
-	if (oid != &head_oid || update_orig_head || switch_to_branch)
+	if (update_head &&
+	    (oid != &head_oid || update_orig_head || switch_to_branch))
 		ret = update_refs(r, opts, oid, head);
 
 leave_reset_head:
diff --git a/reset.h b/reset.h
index 898e4a1e95..38b2891b53 100644
--- a/reset.h
+++ b/reset.h
@@ -19,14 +19,17 @@ enum reset_working_tree_flags {
 	/* Only update refs, do not touch the worktree */
 	RESET_WORKING_TREE_REFS_ONLY = (1 << 3),
 
-	/* Update ORIG_HEAD as well as HEAD */
-	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 4),
+	/* Update HEAD */
+	RESET_WORKING_TREE_UPDATE_HEAD = (1 << 4),
+
+	/* Update ORIG_HEAD */
+	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 5),
 
 	/*
 	 * Perform a dry-run by performing the operation without updating
 	 * any user-visible state.
 	 */
-	RESET_WORKING_TREE_DRY_RUN = (1 << 5),
+	RESET_WORKING_TREE_DRY_RUN = (1 << 6),
 };
 
 struct reset_working_tree_options {
diff --git a/sequencer.c b/sequencer.c
index 4efe831178..e905b1b2d9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4678,7 +4678,8 @@ static void create_autostash_internal(struct repository *r,
 	    has_uncommitted_changes(r, 1)) {
 		struct child_process stash = CHILD_PROCESS_INIT;
 		struct reset_working_tree_options ropts = {
-			.flags = RESET_WORKING_TREE_HARD,
+			.flags = RESET_WORKING_TREE_HARD |
+				 RESET_WORKING_TREE_UPDATE_HEAD,
 		};
 		struct object_id oid;
 
@@ -4873,6 +4874,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 		.oid = onto,
 		.orig_head = orig_head,
 		.flags = RESET_WORKING_TREE_DETACH |
+			 RESET_WORKING_TREE_UPDATE_HEAD |
 			 RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
 			 RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK,
 		.head_msg = reflog_message(opts, "start", "checkout %s",

-- 
2.54.0.1189.g8c84645362.dirty

