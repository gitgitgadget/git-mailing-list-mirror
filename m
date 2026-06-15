Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EAA3F65FB
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531712; cv=none; b=VA7GQfE/mApAOxEMnhdYMkLnQr2l2AV4mEwbPBVWu6WAidAtUQO5eyJyznptqBqms2ln3bUtBfLACe+d8ebYBZhQ6WJzgXZ9fkYA6zCLkhDayfD4fAx1442HPtALvrl39VcnT3dPXoMenV2QQmXPkGPgm+wlagRN1Yx3W97XuHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531712; c=relaxed/simple;
	bh=lUtrdVNF6zOJeGfsMf/rpaw3uzwFhKvHHsHGObbQOkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJ5IWLUo9E8cEsWBygaCa43u5mzAX6aETcKEP2/hAqPkecvcihir8AbAVd7FSd+645IryL/OkRLOjYe5qMYLoCE2JmuvQI2669X7Mu+Y6BHGP63QAxyxYK9GTyE+KYbc5ORiX4E4SX7/Hphu7g/XAyyyHqnMJ1zojySHejBFmtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q3+tX+Eb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JpAyocPN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q3+tX+Eb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JpAyocPN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5255D1400079;
	Mon, 15 Jun 2026 09:55:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 09:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531709;
	 x=1781618109; bh=m31oFcsDEXRl8TrmPbYAZDz16ucuUOX9e8Sh5NhM3lM=; b=
	Q3+tX+EbEsKg2Sn4Yr1qtV4d+c/vKVOcVZusqaTznHGQiatXXqfEWOPA2cJn/Vkb
	yNUYbax5twMZnj7YatFfHj0w/ptRZnR8ytKkg5uGFGjRar1gjhm8kerkKyt9NEUX
	wBWH+OnZ6eagtMSCY1W2nj0U7F1DDsqsc7kaADbH/49vEBe+FXtDaEyOLo7bM7/T
	K/sg/jOmO+ubehVHuxrerSr51UzdnmNXygMTpek6GVKrQ2zvBamDKhQGwhJ2rP2U
	EPmFQmrxz3MWEleP07YF3ru21WrMJRSYyvsIi85MMBpHwG8pTc/Uq4LsPN7vgDKd
	7rsvTwjCPjokh/PJ7+Pb1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531709; x=
	1781618109; bh=m31oFcsDEXRl8TrmPbYAZDz16ucuUOX9e8Sh5NhM3lM=; b=J
	pAyocPNhx/8qn468JQ31LsD1u2RyTEWldTowLEnT1/puDTwjx+GALiwPQud8yBje
	7vuVSA/7e5aMgwzFPAMSgg5dQ1wQhkvCiXpcLZ6UwjWsapBaI1XcymJHlGj1fI/1
	9/P7QAxMU6oUMyDIoaIwa5QAFaYM0Cmne0tzquAy9LQLWa3OnfvaQEfHKq+yoM5Z
	hDYvfETyfmwj/+LcWo85hmXhAVLnEaDuUiYmfrqk5RWbGRu5uj0FT2KtIZjcPB4O
	gi+be4zpv+jUFOt2DK6DiN/oZeMCyxWFexw/Mh8a0nSGFZrONO+a2qXnsqTTU3UQ
	i8pI/Gvk2lfrGcnjTVxhA==
X-ME-Sender: <xms:PQQwamD5x-7JF3dqByoofeECxcyxcxm6lEhfk24zZhepvRLXHUa8fQ>
    <xme:PQQwaiCYUv9JXO9xNuxeTL81asmjGbCsm6MpzoFAdURXxNnb8FKNIHdocf1Dkmtbf
    z11oWmoLHOAi8Bk8x9jj5q_3-1UWgN5fyIgVaicR3AWO01eQFRB68M>
X-ME-Received: <xmr:PQQwappCbR26zAr9LZjZ43M_CfU7Cwvz8608ieDLzFzXW6i9guYIXtO6qoUjMl_fdEKorJDonK31oK4TxTC6kRicwh1e7EFPtd4wlSxhtg>
X-ME-Proxy-Cause: dmFkZTE4BmMp7rYmDnwTf2XcWeoBf+E4JRNt1DSW/p/9VjngQGpU4YoU6hciCKKeMuY06K
    e1SfmzD2R3DjsHIVPldl166OfNNrxXJpzoEEh2bVMa84J5Zi5jl1EluHCYy6HbD8rbcVpP
    ZSEvSVd20XmKBpa6k8S3q1Cf7d2bnlVSFU9MGOj6nNFqWuchW9WtMo+Ctznz7F8NBqFJw1
    lxrJa2KrOntbmg1TIph9LQSw8J+pmXIy5ynbqxhgL0LEuadTOIOUyUWoIlv0Cv5q1M1kKE
    ocHQ8TUYd+eenL/R2a45OCu4CdR7Maz0C3EAKSMSqhMDDhkhgbrIhmz/E1FmJnzYP2xoT4
    p/MdWHXyQJbAuty4D49yG2/3US308iqfGKn6QpASDfEzj7AsN/lM+BaRwvqr+JEuvB7Col
    Lma5DBuEOEVwcxsCLkLGU9AQ7R1crVToZ9fSoHMSpyWVTptB/Cansx7TwOjLxp1MfSzDol
    Yh6ve2lmWxOqG7OC2FMeHaCCclFqoaykQWzPr0/EFUAANvcPDY9AQHK4MzH7LOQAIJg4Ym
    Dx3HZ7Pg4+OaJ7zuVvWbG3MGuadB2+dwIlVYSt0EEedK2dGeu1agModDqR7jSLvoLNb2LK
    e9Wn1whS2Z+2QqUZazfkCXtuSmZX7+yg2EWxFjNZU7Gt9QXiZs5DEC9wpS3w
X-ME-Proxy: <xmx:PQQwakkRUKffYlQc2LGEjvTp1QAWEB830x-koJDB2xAe7G0-TCtZTQ>
    <xmx:PQQwahw6JMCfiAMndsKmI1mBuQzygTDf6DKmp8iChvNTlHhRPoW93Q>
    <xmx:PQQwak8n4yy_TTiZqtEm94lxwm_hTPYGar9EuoeqS2UG7YN6pmAwhw>
    <xmx:PQQwalIRoDnzkdWa2uZWXoZ-iI89E85816S_ChjDzKecKTlNG5XbAQ>
    <xmx:PQQwan25V9jUIt1lZrALuWle2_4compqYPygyj6FCoSiW5MbO_t5H0LB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:55:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 109fd2ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:55:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:54:55 +0200
Subject: [PATCH v6 05/10] reset: introduce dry-run mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-history-drop-v6-5-2e329e536d78@pks.im>
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In a subsequent commit we'll add another caller to `reset_working_tree()`
that wants to perform a dry-run check of whether it would be possible to
update the index and working tree when moving to a new commit. Introduce
a new flag that lets the caller perform this operation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 44 +++++++++++++++++++++++++++++++++-----------
 reset.h |  6 ++++++
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/reset.c b/reset.c
index 4ca7f23a25..99f2c1b012 100644
--- a/reset.c
+++ b/reset.c
@@ -93,11 +93,14 @@ int reset_working_tree(struct repository *r,
 	unsigned reset_hard = opts->flags & RESET_WORKING_TREE_HARD;
 	unsigned refs_only = opts->flags & RESET_WORKING_TREE_REFS_ONLY;
 	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
+	unsigned dry_run = opts->flags & RESET_WORKING_TREE_DRY_RUN;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts = { 0 };
 	struct tree *tree;
+	struct index_state scratch_index = INDEX_STATE_INIT(r);
+	struct index_state *istate;
 	const char *action;
 	int ret = 0, nr = 0;
 
@@ -110,7 +113,7 @@ int reset_working_tree(struct repository *r,
 	if (opts->branch_msg && !opts->branch)
 		BUG("branch reflog message given without a branch");
 
-	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
+	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
 	}
@@ -125,16 +128,36 @@ int reset_working_tree(struct repository *r,
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
@@ -142,11 +165,6 @@ int reset_working_tree(struct repository *r,
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
@@ -163,6 +181,9 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
+	if (dry_run)
+		goto leave_reset_head;
+
 	tree = repo_parse_tree_indirect(r, oid);
 	if (!tree) {
 		ret = error(_("unable to read tree (%s)"), oid_to_hex(oid));
@@ -182,6 +203,7 @@ int reset_working_tree(struct repository *r,
 leave_reset_head:
 	rollback_lock_file(&lock);
 	clear_unpack_trees_porcelain(&unpack_tree_opts);
+	release_index(&scratch_index);
 	while (nr)
 		free((void *)desc[--nr].buffer);
 	return ret;
diff --git a/reset.h b/reset.h
index 2e5826de99..898e4a1e95 100644
--- a/reset.h
+++ b/reset.h
@@ -21,6 +21,12 @@ enum reset_working_tree_flags {
 
 	/* Update ORIG_HEAD as well as HEAD */
 	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 4),
+
+	/*
+	 * Perform a dry-run by performing the operation without updating
+	 * any user-visible state.
+	 */
+	RESET_WORKING_TREE_DRY_RUN = (1 << 5),
 };
 
 struct reset_working_tree_options {

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

