Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4683CE49E
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184449; cv=none; b=ENC+tX+heYCecw8jUWABBd6uTjUxUPxjO7krU6NEmYMlorIM6N3HIzHbj6nL97uB8xADJMtKQR9ki6t2UvwsWV6AH0BNgWnqNtsVEXfhDZGlSic1A6p3eMXuIyDLEmMuVB5LQr87PZD4n4Iz+UvhZlkMg1J7PkfRIVMbnbJ5qnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184449; c=relaxed/simple;
	bh=r7ozL4HJ2YaoMfqT7mPnaoiQ9QqdTexxfSl3/3YZgUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPKuB2S4D7mZSKuRxSefZ8STt3MuRVa8s0JkHdPiy7237PQUsmaGPfuqVFPXxY5XE/xv6f2U7AC4uCsklJ6Qo/dKlrPBASLSXCkaAqHXxchXms5F4ta8p0UenbOO3SY1gKHt7Wm3SzGfs+kOeTuTuUlEaEGyscaaOueW0NUREYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eG4VHnhD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OdbDyA0P; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eG4VHnhD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OdbDyA0P"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0270214000F0;
	Thu, 11 Jun 2026 09:27:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 09:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781184446;
	 x=1781270846; bh=Z0GgGzWMOfzJvvEHE4od+JErNuFhO9rtQJmreryIs2g=; b=
	eG4VHnhDqbfQabM+1JZrl7KOwpfQvk3dvu4//aMcqAhjWZkwA4iczVh/TI6/hIvV
	ewOB2NyOzGeY6JMzGmAj/fq0vnFWOjIxpb4PXIY6GamEiIwUYXZOSueqIMpTasfo
	/2atlAM0aEPebetodYiWoAtD+RURGYWklgm9IoB28zASU9FuJ7CsfOzJBboh3QJ4
	fj8xwtdSOPPGZI+Xg3ZGYgSAHK6kf9ZQzxOX7jejVSGQl+nF9weOjOZqSoiNWh8M
	NnyGNX1gRTcXltgGL0HJXkTv+r6DyiKXzpvcMEo/m/hqW+trSdmY6o9hGBwas4jy
	7WdIdaTeTRNnfJKovL+P/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781184446; x=
	1781270846; bh=Z0GgGzWMOfzJvvEHE4od+JErNuFhO9rtQJmreryIs2g=; b=O
	dbDyA0PnrdKkAmn/8jk8ZnQRzIfpPZPyyFkWsLDOMok0M6rHZLlMe+KntMXJbWc3
	l0vlZ8YO4931kY+P4eqaI3KXDq6nGnmC4XWnhtj/ZlhDv1ImEnnZy5QMShNf2Ezv
	n0DcsVEWkoEwBuqvsQgLwxKisH7LM4r8ZPCAmAIBHMiMO7G2TefvHgSyOMDs/MkQ
	QeHrGragwgyQxyZEp1frupuoY/FN0i0KSK7oOBPOKohnex7p88nG8v0tDOgIOs8P
	vHClz7IqhNTCCK1OAs2s4cXDZgpyGNd+cb2/cdX3D69vA8xfhCnMdWHiv8+LgMlp
	C1hbLa7JgK8E0ujzH8Gyw==
X-ME-Sender: <xms:vrcqaiOEdlyEoh_S5rRlF_tlREnUNu0PIoWoKWLQzODS8qpf5TCSjw>
    <xme:vrcqaiffEolRtE508ZE3nHVpJejzzKnteftITiGjrL02uJR9JzzUGQmZYATBueBlI
    P-EAsLkdhlPOPE0P01xFnufewKX_e5YVpeKNWOHwpRYTbQLHvLq>
X-ME-Received: <xmr:vrcqapXKjxD7Of7DEy0boaT8zo5bvP8QJZjcQJzoe0_vbUSaxoAEqgzus8ana4kljQQ3FRef4-zlb6qrCNZXTxEWLgBj9hkJE73MvINGv2ZC>
X-ME-Proxy-Cause: dmFkZTGz3U1rdkISvKOMncf5JoE20KMEGlC+e27EMK1ddG9V20+khWNgOpEMY+glmRzOFK
    B8rTeR9sD+v90sony5nwvNBGhj/6icCQWfL8YQMON4zmY5orOdoUD48m/jlXITjVX2lLzE
    DuFVtR2aAnlh/xBmDjayU2t2tD6ibhxoVNo8mZ1cgx9inKK6N0g08vvbkjeaLh04Yqe/bz
    cNMAjsMZ2KAqKIcZ0DBoXWGrOsMFAaPkh1UX1whOsu+jIbeig9kVs2LuvDrlFLb95U43SL
    9vIfklhRQ2V6tcRiOWIfts1NS+wYB8AYXcQeqNm4A1DH1+v7hBpqGHGMBJFq7OZVzHbYPe
    VD26a5b5X4D3t1H/26kx9v/8RtE0cCgxrr21yulV61i94J25H8ah926Bx7bCG2TBjiOkoh
    UOf93wwp9h5V/PnG7BeWrkMo2U+7HSNvDvDXm0Biyj3BxUagdgTQ5Wt78XdacUp7y3Mu3b
    ugnzG4hNk5XHU0mhfHt5wplBhTDHNxsy1hoUN6tJrzXbEZ8TeN2LjbujNr8KaMwX6W4jSm
    jIsBWRT9XxE6v0VvTKQ7tWcZSdrqXfAOcbeP1tr40kWVbRtAEqqpEmP2Ty9GfwoB7y91/v
    XRP0JK5YvItSOnlFDAxFTKFaRgbpUJZ6LnBsRFOP1F8OGXbA60Thr3WMvc6w
X-ME-Proxy: <xmx:vrcqaih5kzj8RDpbETiEn4S5lKEqFmePRs6f-fDhx57kP5zOVD0WUQ>
    <xmx:vrcqag_OvUykafRDUbpi8AOq7Kc5kyUSEzIA3HyotM8QtO0oaGUwzg>
    <xmx:vrcqasZ3NyML-qNrGJLR2XAS6hh0mQA7QgobfcKCvc7nzVjW_H0RtQ>
    <xmx:vrcqav09hTsKHdPlWmfThbjMtNcNipd3ugjF4ie3a2R-2kFrMGcZew>
    <xmx:vrcqasxa_IzWUWvLgbdcPYkqlksbOqwSGRT1EuwI9vin14_sW1njnQMA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:27:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28e9ded4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:27:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 15:27:08 +0200
Subject: [PATCH v5 05/10] reset: introduce dry-run mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-history-drop-v5-5-34d35725559c@pks.im>
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
In-Reply-To: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
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

