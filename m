Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1119C352025
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718499; cv=none; b=Um+Cd9b3/xxWSD70CDyjWadd3HY75spxmuXh1Waof0TlI+12h+BE37kbOAhvWFwB6vtUK+X0Qb96pBXdll+Q4cHfNsCOKDWgeYiSfC4vYVBTN2u5x5Jc8WEJD/Eq0QU7JWDNFik6BqPkDs+cBOURIfKQ/wfbXORB0o6S4xzMDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718499; c=relaxed/simple;
	bh=oS85xjAPXCGLOZAMjBA9HbjciVflwjH3pgR8BBkus48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMaheUJ6yWvJvA7pyATGQJNkofdUSnNIV7JOzvf8NlH+7XQre9BPmUdRpjWg2NbLYjZY3VZiK0o3yNgap0FLUQhe4BVYAJOFE65I0o0bqllJyDAA/Eh2KEDNp2M5xKkYF/1dVwJ/Bti4y+BqOThtw8hJitlVa4binRd7jCgZarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aM28yHyE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMDXKWOP; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aM28yHyE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMDXKWOP"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 96F9F1D000B6;
	Mon, 29 Jun 2026 03:34:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 29 Jun 2026 03:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718489;
	 x=1782804889; bh=qoBq09xAe0WsCk5IV5hQ+qdQ5kTT8kqtDL0RAn52V4M=; b=
	aM28yHyESNJ16CvSYoKpbOAk7FGpawvZ3RZKN7JbTmn9w4wKrmmfIsEvY67RXRcA
	ZCITtLIjYgVwVfsO3nI95Zcp2EZb4rr/5JETLLr+2kjw/nIqurjOlhe7/CXCYib/
	HW+L0j7dVLTLcdqCrVze82XyAqEnZMSfiRHCOUMoHoyMfmgy9+Lcb6loQ4yOLDpy
	AO8q66xaw3COiwmWby7J+oHNt1F7D7gQ7w4/h1Mp5aEm2VVAW2hXGCTGiafEq6nD
	43/7zm3xQvMZxunZV0QqEvnbIL7+G5begO4rMFLVBPDH8t0tC0gkxhpMJM59i8BT
	h1dR2CsMjMySaMqoG/tc7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718489; x=
	1782804889; bh=qoBq09xAe0WsCk5IV5hQ+qdQ5kTT8kqtDL0RAn52V4M=; b=X
	MDXKWOPQHGmwIEe60o93FYGrfdsubpBYNVcGZZciGWsEEAQ6QPWPz8hFozG/2z+Z
	mzoXWIsH2ZxhNSy09MxPNjL7pkfSSdEdYKbqbzVhOhS102yd7dlU8EO5De5fQEOo
	b3N97TH090PUy+LTcqfffmE1FBJljgtdmWyZZlIyf5s4UILQisELUyNF/4vN98tM
	wUAjTsBv42HSR1heOFnfQ3wNDsDtXmKEHCA7mY2dlq8ZkTleFRQRWz8dQx2NDYFs
	lW+TGRv8Jz0ZYpmaD46AYJlh8/eT0t0xsDx75px+3pcPbftwynXEflrhRcUVtfZs
	tDgvXT6mOvJQUMfQ61XhA==
X-ME-Sender: <xms:GSBCag4ZEBjtnwENJO2Y-jP5Tfz5CRDsYjX1uN23_8sa3RuV6XkXWw>
    <xme:GSBCarOuMta_3_k45on8tq07guzOcIjh8AJkv6XZdad5GyUCOPJi7Y6IFzE1M9Mlb
    nsTRD432UMsqhrLogr-81aJmARWHT2Bjz1xxi9wginCii9FN2yx-g>
X-ME-Received: <xmr:GSBCamsDA2ogjtPPPlL4F37hFM-WOJSNPPGINVqZOzViemizIUKoGCczb8niIy5CxTqcKN2sQf0c12ooSYFtLVdWKMkqewuEhW9nIuLxWSyS>
X-ME-Proxy-Cause: dmFkZTFc4uQ6Qti1Zi9h94m4od3eMpCQCnDSYXEx7QOqzgywygLB3u2mJuU4WGTziEY0sP
    vssB/gclRg1ee6qJz/HkTNvVUAGJRzObGlYhlIWy2H0VizAeVI4Xeth5sjhla/To+149l/
    DnpD73+tyoScl3p4zN9NQkkGKn6ia0XiF6ce1fQg3g/N5exLIvyhMvPBClJO8fJfSQamiA
    fdVPH07ySGubvtRJl5FYb7NHirzBLueiOcGXimA9yqyRycKngriJVEG34RByO5A/F6lB6i
    kYa8uD5/S+7zMXFZ52b65RCnTypiqCWEjwut/seJuRz24f133R4jeJf+/yzbcKsEf0+enA
    YNMlgZXL78zfFEH1D89sCiKOxTxz0/0JgTw5BbdjAuklLeOQq1KgluerbkeVDJPQHzBhSQ
    eV4SoqGua+3xdmMrcOLDjlk6tGVbXCgyeRrG59DOdvd4Cj6qjnmx/5Lcep0kfXnfs4wLas
    rqqn3kSTUR946XelhpdelTsgjA1rtqsWh9HZ/7GWDQfn3wKIR3pnIE80HxrGspWeR3yIYr
    x3xacZKh/Kd4nJm/j+PNsY8od63Q8ZKFkuOp36Ji6u64Op3EjYtvN4IGm6fGvJJKIa+870
    NXBc8m9/r5B/mYYDU+na9NAFaLCzMCLTRpY2UPrkyWRt/4ZkLa0xK+anEFZg
X-ME-Proxy: <xmx:GSBCama1Llj4jPfAg9XPzqA0cFULzwJwsulgdAjmjpC3kMvyBpP5fg>
    <xmx:GSBCagxX7T6Llnv8TBAAZ_iPu8vIFFKvz0p_7MjZLfNw2_pn_mwgZw>
    <xmx:GSBCamjcIK1ZIHM6V0L6n7HuSWrwP4CxFy18kDAaXA6RoznIZfUbuQ>
    <xmx:GSBCakkkJ4iqURLQmVUyQ67K9zSLtYspt5vtnXHdKx-wkGKfWkNJ2g>
    <xmx:GSBCahVSRdCRc2s-mZnHS6maT8W3GwvYj5_cTV13tyz-5vJrSm72AfoB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ae7b213 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:32 +0200
Subject: [PATCH v7 06/11] reset: introduce ability to skip updating HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-6-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index 99f2c1b012..4bde5d8dc6 100644
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
+		if (!dry_run && update_head)
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
2.55.0.rc2.803.g1fd1e6609c.dirty

