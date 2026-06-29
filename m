Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6634D915
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718496; cv=none; b=rebF83CQ3f4u5ot1scPDammnVGGkgNXMlgEBB01SLqqHfRgneQiQBP57KpdO+1Lubgd2zzsxngLXzXxJ1tWwpbncWHMAUZN9E21eP5FzmlR2tQjzbJYaI43u+vIy4BsP1heWA9GOAhd9SYWB/60uIJ1Y0zDwKvLUhyXfY4Rk/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718496; c=relaxed/simple;
	bh=gYUBTAvCAiFYeEUPaxUI+sVrMtTmPcf+O3JTWKI30ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUi3uDT5shsHy3PuZivs2XqC05S1q2riqlHrqt9oNCBvU+a8wnzC8q/J9NXz+0PGI0WxdGNFONGRqLtC6D3m7dikJkDz/J1WyUB2dkq7xxtwPZx6yUsu40+5Rx6XC5kqiF20xerOV98MsHWOazmMHCivQlgVaxU10YFIRn3zWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QL/1kYnN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V38+vjvV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QL/1kYnN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V38+vjvV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88ABE7A0090;
	Mon, 29 Jun 2026 03:34:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 29 Jun 2026 03:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718486;
	 x=1782804886; bh=ZYIWz/Oj4rXzTt3IKV7w6LY34VdxnnNaNRF3JTjJ0LQ=; b=
	QL/1kYnNMRTnRwNIrjkKBMjPlgXMk9JZLEdpXv08sWdO2+BNNT4TjqKuMayXeLg7
	jpR5nAWWmdyXQJV50hTXjw298SRT6rMvBDUReIX3GkoOKDQarvO6nOMxCQPW4uST
	lieMVG1XApUCBVSqI02T1XKGB4eK0VBt98OQGC5z/63YDdJhuU4SnmkXIhydPqtL
	f3vtdeXr/zLXmb30NiFw7oVjkC6jdnuRWrLEVsDCkOXsBStWtGc4YzN6WMEUZcmA
	ixC7l6AfV8lOI3PKNMUaxrVel5i3/ECO7JVo2Vh2A74n/bK1fzgcBNTH2e8K98Kc
	mt/WXGSoUkEwC5yw3f66Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718486; x=
	1782804886; bh=ZYIWz/Oj4rXzTt3IKV7w6LY34VdxnnNaNRF3JTjJ0LQ=; b=V
	38+vjvV7uCkqoXNkADXUH6IaSmojtPQZLFJh8fYSRXeWBPj/qqyXqPWxaBS2f+d2
	wjE95OqBAA/+1sBSWF0THDcSprQpHM17lf70zGKrvwjR2NH3woyBCL+I4IW0i7Fm
	5DefGSkCjxqq4d4DYuA5kvG0IGbZZZ4jfIQyrYUZuWEQ/CEQeR0dRfvsj+9OPYZe
	BcfzknjWZLTUVRy69JDXKR3fWndUthbFXcCeMCVyhiYOTcufs3wjWT5WrwlXie78
	aMtjSo/keg25w0AsSOYPOV2wNX3qJ33PqvP+jN1NO67dkATgn/pN2r6rxq+qPO5N
	OVsmUD6MCQvKHBXVn8VfA==
X-ME-Sender: <xms:FiBCajPERlCDOH4ChsOtJ1gWweG-FFfatfIsr8jKTRODkVzNcgIsQA>
    <xme:FiBCanTLWL9GbaTKcu3crU7wwQ99KnOHVa3xM0bKSPoaxSOA2BuNFPvEpCuTDDomQ
    UNm3Sndj3FjhCjnebXfPWAxCYHCtnWwARQeX9WOJQHGcAOd5moRgA>
X-ME-Received: <xmr:FiBCapin_swGr_8VXcaLGP_uF5rL13oAJ2nVtIwYBDry7sIukriate_M8c5EoFo_nSOmIWRMKBrUtXEAZIhfU5EC_i9AhGZ8DkrYzvgKendV>
X-ME-Proxy-Cause: dmFkZTFc4uQ6Qti1Zi9h94m4od3eMpCQCnDSYXEx7QOqzgywygLB3u2mJuU4WGTziEY0sP
    vssB/gclRg1ee6qJz/HkTNvVUAGJRzObGlYhlIWy2H0VizAeVI4Xeth5sjhla/To+149l/
    DnpD73+tyoScl3p4zN9NQkkGKn6ia0XiF6ce1fQg3g/N5exLIvyhMvPBClJO8fJfSQamiA
    fdVPH07ySGubvtRJl5FYb7NHirzBLueiOcGXimA9yqyRycKngriJVEG34RByO5A/F6lB6i
    kYa8uD5/S+7zMXFZ52b65RCnTypiqCWEjwut/seJuRz24f133R4jeJf+/yzbcKsEf0+eYE
    A/umf1O5VpMPMlGJkXUnUa+j+qbqFIiR22h5B06XU8gN11SW5oPq1N+kxKpTPTFcIjltnO
    l6BCX0xUVq0upJE3DKDCHcWG026osT4TWyAp3SP73J+JtsEa88O17sHIdaXGyDZs+9RDKh
    CDiyq1zxe7LUQZemVYciypAEHoSVgUcM4MhudE7+kEDnLLvfV9JQ7maZ/qyhYknXoaHikC
    D7NbW38w6UT9rnYXDpmA6YCDtJ2IL9Vixh7FWQECe3YYHrIaeb3Vuqs4nTyEb2lMgaFzJ2
    zOaOnzTCPJQBrs66AEtwT9gF6CBhya0hUg3mSAGwL9hU71bosVS2dnTqpa4Q
X-ME-Proxy: <xmx:FiBCao8KUPLtBBJbBDMxzJEkteZCka1UQAwmnIjoZNFx6MHk5aOgNQ>
    <xmx:FiBCaoFvbeFINgagbx6jyozJUvWLK-Bltqed8zE9RCXgktctyBwnAw>
    <xmx:FiBCajlkgPUjrc-rvEj51x5mLU0B2dnnf6lIH_HgepgBswRiGKwj5A>
    <xmx:FiBCaka-hZ9u1zRCVbTI0o8jmLuv6hyhm0LWf68Ss2C8LhE2TuLcBQ>
    <xmx:FiBCakotFd37HIwKb2-CCGkW-IbkRCLuMAJ1DnNzAi7OkJoUJAacLK49>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61e56df8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:31 +0200
Subject: [PATCH v7 05/11] reset: introduce dry-run mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-5-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.rc2.803.g1fd1e6609c.dirty

