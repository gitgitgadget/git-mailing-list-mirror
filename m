Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6153B7B99
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914224; cv=none; b=BPgLKSWZVjJEd6a9Gp3xZfwmjb3Loby0uUONt1YhCO6UTEophbh7V7rSsoi/uMRfDcXzLK+8LSRDp7HArnu7BYkOCmjDDOJS6l9jd0/1x7IxFxLfJ6jAURjBiYd0yrcSe6TkfuVIdecqmyjQKjsL5HbnETVIx3CUjFeL9Ny6JIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914224; c=relaxed/simple;
	bh=qbsqBV3mfseWls6kKvgoBNmjLbA7saqYyaXwDGY6ULU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kv+LPWhvOHXkCawu65pTH3TlkwMeTq35PxCNzcM3qgZ58iDFpJ3WNgQmyklBR1dykm83nMOrXAUxJECAbImvKaPqTw37G38TJw+Z3W18kvoTqncBADv4tANSiKLd6Rs7ywdYJ3m+8alG1pvtExnWLf2A3xmD4p74iw6xGWnbA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=am0XaP09; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JK34TVWF; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="am0XaP09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JK34TVWF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C9BB1D0007F;
	Mon,  8 Jun 2026 06:23:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 08 Jun 2026 06:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780914222;
	 x=1781000622; bh=A00oPDF4YTZQxMxBkzlu1XNMldO+nLfCHUS3ZprOH8E=; b=
	am0XaP09fzhJu+RmEigfMmelz1ZyyZwYsAfyAYEEtjWI0NV56EKxekUQ5PUlpqIZ
	duFL8ukBBZ9sRQZbZKatuwbjPuhNdfH6lvxq+/UPE9GeOCZXFSj3J0myh7+GK69I
	51XF0Dqf8T1l6bZjUw3yn51uUt6RnXqcTMffMh4o1XwU3chm8qq/uGp+P9gYtaP3
	aWyOLG+mW45o9DZfvQqxGbGC4cVjw7lRgeM7LkmMTQqs+pz7oa1sSTJZV+wC0hHX
	2L3yXlOCI4yqcMZ4xVNnpMZwLdd+2/KpzTb+qeU6yg2rvR1zKa8LXlGbMt2SuhZ0
	iQSuKCjFU9b+2PEuI8+LXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780914222; x=
	1781000622; bh=A00oPDF4YTZQxMxBkzlu1XNMldO+nLfCHUS3ZprOH8E=; b=J
	K34TVWFKBXpbuGM4J0l6CfMBvycP3K17Ob5buRmZLOK1NgqsC2Okznd8m4ydeFXl
	uRTVmqKUrxEL5hNJaspnTdfqG+FFMgBo8uovhecTb8lQ3l97dlYUUEyyC9S9MfdH
	ciLXDaeL3vWBI16M7dLRN3Xi9sJBXfHHZ54MLl4OWjDiu+HlxPrsJV8Tn0kbuaKp
	Lry8dearR1rIg+AGVTk8BsIpEGlWqoYHNMYPRPVOJ+6AjTQW5m1EnbwbeSP8G/dV
	8s+qBmnsNC5/+MKb+ZV1EYddKXRy2AaOCMgNfqUZI3Ib4ancQnI3Ir2fa8MSR+Nw
	7m4COH7AtSmDcdQxRhFFQ==
X-ME-Sender: <xms:LpgmatwoPhm826bZwf0kUn3ai7kPZIjEXjypbG7daAIIJiwsQRSPaA>
    <xme:Lpgmauw3npCcjUd-An5t5v_KR-kTpcFG3QYfcJEGJGY5z0BilY9FN3eqShqfv8YkO
    PZyWgWwEZJT-nvZEzc-NAkN12Gce_qZnJyB2gJRA-h_NkDEXJOA>
X-ME-Received: <xmr:LpgmanaUQSTbgAw8gwNQQSbfZDqb2rMnHFJsfmrUBbHIXTNf-IXbVnVOKQUx4Z2H1ov-JjdB965wdX88xldcoRUxBPVE1BubCGYA-9ByPA>
X-ME-Proxy-Cause: dmFkZTF/E0B6+8HbVI0EuzBQ3dK8cHD9k7zZhvtR4eGQVqhd3W4HTcOnifeC1qzKI3nsbE
    Nr9VNWSWcSFtS/UIV6gQwbKHmcbCLZQ5dEmWkSWzkCkUK8vkxjfNEdIFScQfFAYP5zawV8
    kuJkxbizX3zEJsOqszq2+IudRIc8Uq86mQ36+9qMWm2f62cSt69oypV8UuhbQr8RL6FlHi
    jgxr7RInSbFRodGxO7WuQWF/WG7dKUmnfBX95+D9IjM+5QwCHTGkAMls42CUbLZrRvniUT
    3lub+E8UcsLzA9W1abr8Tskkr7igIbaHvXdizdHbApsrCDDZaJOZp69gRz16mo276cOst2
    Q2E+A7OzcThg3xowAnXSOcCag+r4Q+uuXE3hAD5TpNHI7AZ//rOuB7jSNS0zcgr2Imaxs1
    66ChQpYq0Bt66V2rZsmXzZ3fvjrzc+dvMi0xEPoBxw/q4K/wjVFCQeAkXKDHCHVn9SGEJS
    jBwG8FfHZjjO0ctMFe4T+3enYJWNEGoQuhsPtuNIwZfWEvnYlAIF2XGP1+pfBMQlas0OJ3
    UEWv+5vwHYbDvMCNEuSpv2UJXZa8dbWV0k4GZ0SZNJNrabYQ3NxTAT6Ph0DlGtkSCVPtWU
    QTPP4Dozz1AO/CHvfYj0ehSYqKQgZHL4MjfuKefwPhIREyWmJE72tAV9BH/A
X-ME-Proxy: <xmx:LpgmavWTEpBdI8jfgY1OuAyQUd1J0Bp0DDKA0GXcWKKGvHz-OLzQxg>
    <xmx:Lpgmalhl7DooYvySD-g_7EQZ2fMfvQXWhPzjMtN6bUJaeHwmBRIrEQ>
    <xmx:Lpgmatt3RS6lo_OCr2H913Smi0cyCh_CRBIEfEUmg_xCECBLnPMLYQ>
    <xmx:Lpgmau4k6s3TsBFRzTpeitbsOrmKh8mmN9AEKygKldBZG42hg4so1g>
    <xmx:LpgmaumsfMk11COcLH9MiDuFQf-B0WQrHaGNb7-gMkBh5Li-dgI2kdMS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 06:23:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f85aa8b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 10:23:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 12:23:28 +0200
Subject: [PATCH v3 4/9] reset: introduce dry-run mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-pks-history-drop-v3-4-84ca8e43e937@pks.im>
References: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
In-Reply-To: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In a subsequent commit we'll add another caller to `reset_head()` that
wants to perform a dry-run check of whether it would be possible to
update the index and working tree when moving to a new commit. Introduce
a new flag that lets the caller perform this operation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 44 +++++++++++++++++++++++++++++++++-----------
 reset.h |  6 ++++++
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/reset.c b/reset.c
index 228cad5f42..8fb39d4c51 100644
--- a/reset.c
+++ b/reset.c
@@ -92,11 +92,14 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
 	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
 	unsigned update_orig_head = opts->flags & RESET_HEAD_UPDATE_ORIG_HEAD;
+	unsigned dry_run = opts->flags & RESET_HEAD_DRY_RUN;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts = { 0 };
 	struct tree *tree;
+	struct index_state scratch_index = INDEX_STATE_INIT(r);
+	struct index_state *istate;
 	const char *action;
 	int ret = 0, nr = 0;
 
@@ -109,7 +112,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (opts->branch_msg && !opts->branch)
 		BUG("branch reflog message given without a branch");
 
-	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
+	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
 	}
@@ -124,16 +127,36 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (!oid)
 		oid = &head_oid;
 
-	if (refs_only)
-		return update_refs(r, opts, oid, head);
+	if (refs_only) {
+		if (!dry_run)
+			return update_refs(r, opts, oid, head);
+		return 0;
+	}
+
+	if (dry_run) {
+		if (read_index_from(&scratch_index, r->index_file, r->gitdir) < 0 ||
+		    index_state_unmerged_to_stage0(&scratch_index) < 0) {
+			ret = error(_("could not read index"));
+			goto leave_reset_head;
+		}
+
+		istate = &scratch_index;
+	} else {
+		if (repo_read_index_unmerged(r) < 0) {
+			ret = error(_("could not read index"));
+			goto leave_reset_head;
+		}
+		istate = r->index;
+	}
 
 	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
-	unpack_tree_opts.src_index = r->index;
-	unpack_tree_opts.dst_index = r->index;
+	unpack_tree_opts.src_index = istate;
+	unpack_tree_opts.dst_index = istate;
 	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
-	unpack_tree_opts.update = 1;
+	unpack_tree_opts.update = !dry_run;
+	unpack_tree_opts.dry_run = dry_run;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	unpack_tree_opts.skip_cache_tree_update = 1;
@@ -141,11 +164,6 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (reset_hard)
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
 
-	if (repo_read_index_unmerged(r) < 0) {
-		ret = error(_("could not read index"));
-		goto leave_reset_head;
-	}
-
 	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
 		ret = error(_("failed to find tree of %s"),
 			    oid_to_hex(&head_oid));
@@ -162,6 +180,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
+	if (dry_run)
+		goto leave_reset_head;
+
 	tree = repo_parse_tree_indirect(r, oid);
 	if (!tree) {
 		ret = error(_("unable to read tree (%s)"), oid_to_hex(oid));
@@ -181,6 +202,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 leave_reset_head:
 	rollback_lock_file(&lock);
 	clear_unpack_trees_porcelain(&unpack_tree_opts);
+	release_index(&scratch_index);
 	while (nr)
 		free((void *)desc[--nr].buffer);
 	return ret;
diff --git a/reset.h b/reset.h
index 0bf25c51de..cc9fd4378a 100644
--- a/reset.h
+++ b/reset.h
@@ -21,6 +21,12 @@ enum reset_head_flags {
 
 	/* Update ORIG_HEAD as well as HEAD */
 	RESET_HEAD_UPDATE_ORIG_HEAD = (1 << 4),
+
+	/*
+	 * Perform a dry-run by performing the operation without updating
+	 * any user-visible state.
+	 */
+	RESET_HEAD_DRY_RUN = (1 << 5),
 };
 
 struct reset_head_opts {

-- 
2.54.0.1136.gdb2ca164c4.dirty

