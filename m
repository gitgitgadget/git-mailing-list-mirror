Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD63B5310
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081568; cv=none; b=UHHxR2y/a1dxJhSIuCYXbgkLsAw8AHGmdQKXBgnHJmmftTAFn9NEfDvGTyyzfzf0yhLqfdd2BBkt7HjyZLqZu/j6cUCt+nuM6IeyWPGgCl0iE+fOMUOSjTgp67oLmPxUJQ3eSxv6b8PP6LkEJpaOuzl2/HetWYthKBqwVn7N+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081568; c=relaxed/simple;
	bh=r7ozL4HJ2YaoMfqT7mPnaoiQ9QqdTexxfSl3/3YZgUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KO0DN2HhG4o26d/wHZaM5vGxg0OSi1kZNSlnkvDc1LU75rP7ontdPX8T0rhmYOrBA1MDXQolHRauO07366dBUl1bEkOQkvaCLIre26rwwhq//nvhux06Mdk8MrjrBqmh+5NugeGAYWEfSYDAkBylwYlHJ45ppRGvxSy8XUlMUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OVUH58fO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FN634+JH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OVUH58fO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FN634+JH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 449127A0077;
	Wed, 10 Jun 2026 04:52:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 04:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781081565;
	 x=1781167965; bh=Z0GgGzWMOfzJvvEHE4od+JErNuFhO9rtQJmreryIs2g=; b=
	OVUH58fOyAlbV2VQYqFy5v7aziTrYFQUXbXtjT6HHcvIekN2B3rg0e3JWRG6dEM3
	Ds2sv2OOKHG9pE1+61FiSb8j7ln2Bn/ZJIYdRULmcmhud3Zw0+yvmEiplJsVZbnP
	lBDBLaytU69cOY7xrm511ktohx7qFEJRGW1EbH34R5unX38CDqLa29YEu45L9DJc
	xphhAkvl50Hb20Q2GuamBNNW3TuKyXET0QW8Za5UZ7a1rNYb9H+bbTlFiVhvxftm
	fFQ9QszL6T1smLGRQgtNqVAbDU+X8f0h/FMxGCC/QM1nS0WY9nF5AbjB1IDKjjEM
	0V5a+4zEruUUivci9YEGjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781081565; x=
	1781167965; bh=Z0GgGzWMOfzJvvEHE4od+JErNuFhO9rtQJmreryIs2g=; b=F
	N634+JHz0apzq/z+8CzQW0jflTGRa75DXpJ4pHnGN5bBHJNOKBsb69Ux6RvSmjLk
	IVP+rep41c8/hc5XGnAKgymucmrJ2CNXnVR4cOOOIK1jxJ0Z96RFl9pYHlFXIg2R
	XLvC6Tz/4MA5Re6wbiFSslfDBdszBMLJdndPzindIRIHSsy5UNhZlUVizsBGHIXm
	INrLDGk7w5Ipdqhf3w4LeIx07ZEkNPM5dc3DWtsdoeH1yXbCBm6C+hhLw6RKefRu
	BQLdhNWlUmuIeagLuSd2gBO7WwH5Rd6ro/VhuDsTGMaaigcKMDAnul+tEL8AMV3P
	sS2ij/3hsnlpoGerxGe2g==
X-ME-Sender: <xms:3SUpag_HIp6M-u7GcMkQk-6I5qMRC2gV9XgzP1xbnhK7is9pKDyIiA>
    <xme:3SUpaqNlG50o8C0u7yGkhUgqIxuYPHINpP-g9wQ14dTeYY5tLdUjgrT1qmCG1X0Hr
    hTJYny76N9I4klrZ-1ZdyaYKZn3CwXSrzKx7M7C1H0WoixihzRIGQ>
X-ME-Received: <xmr:3SUpamF1VMMltshMxBwdQhpX6jJIxGI6UHgqHzXxCloSk1WEh2B3UqjIABLJ3xZGae3tAsZ06a_VKaxRybtF_kSNvytPLYjc9h03XLJryA>
X-ME-Proxy-Cause: dmFkZTE5orGA5proHaW7Mu8uqvCVIExIrc2eP/p2P5Lm+ca4fHgckoyg8H1FtO/I7wT2Aj
    nXYeRcsregd1VB/JFKht2uDDid/OrQSlnc1rqHixpgHWdGIhWP17+22VFQ0Y6OwEAagcoj
    j3h3elG5ybg8NK1JUgtfKMcMJO0hc7MBT/fQSZgmzrWwAwK1miB50XcHw7Yhzf8w1O5s6q
    Xg+5TZo5RxXTWuQ2D1I8EFmJPyzn8JA/uapOEANuLON+tT1nzkzucsw85WLhwcl+lLqh9w
    YTaz2KWmNElIawZywr8oaQfhcw0Kc8b74JeCKXq299mQ2+lJrLP2v9dXRRWz063lXrorPY
    px+BFxmNh1zOkZYiEAIMeGqWA76yQU2sKouX1dPm7JJMBM+RKiCYKoeqHnPHysgU811VHF
    6dsQlrsBqzD4r52G19kQT66FcsBHLWHNJeFfZc7VGwBg8evx5UpfnT6rmqzsU3bpJAPvVD
    IEAuuI20zGw7JEiNU39fHq9N74cmJql/XeAiHUEDCxW+tUvtvKOCzpXIWujLW8S/r79CEv
    N9cq9ZpUry1FRji47ksRegAuu2N4iDZFVVE4YctRe/2bKutQrfMjv/x/MUTUR5ThHUNHNZ
    c7wdgVnAedy7Rpod5wxGMctQT6WBOoE9qohl5Xi679LnsN3yFktCQU9bFtVw
X-ME-Proxy: <xmx:3SUpagR602OVP1pDxHhpk2uN0JkFIIOK-FDwbv1MF3f37VNQbYbCaw>
    <xmx:3SUparvTk8pN7bhhufRJAKwi45GzOCbN1IaCfrs3u6Fiw2KdQL0dng>
    <xmx:3SUpagJqAGPbmOJvgiKsmZH7W1QhS22Tb1_ypRPVz0sVTO5BpwO5yw>
    <xmx:3SUpaolJBkX9_dyUQ6Ykx1t3yNMKt0-1DkVuCA7hen5G-_7EXFAsiQ>
    <xmx:3SUpamiHTz_JhUsQuiH_wqndTDsaluegIKbT5lnwu3LRyBYNXt9NdINH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:52:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b31a6001 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:52:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 10:52:25 +0200
Subject: [PATCH v4 05/10] reset: introduce dry-run mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-history-drop-v4-5-70d5f0ae8c25@pks.im>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
In-Reply-To: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
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
2.54.0.1189.g8c84645362.dirty

