Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF13148DB
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780623; cv=none; b=HnBubGx0kwh6uKMwExvbUjGPMfL21PxB/4yLc9njPHcHXGJt6ExIH5xNV9JxMU2RvwblyQZZrvqQUye4s2XWi2oENCNuIbEX0en9cgLCNqKksSzcmkTz8rTSr+2gRw1fZLX/Oyiklnqg8zTUsrF5dw1SZnVRcixNlxahIOrLrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780623; c=relaxed/simple;
	bh=5lIAxlFMOBDCrzWE1K3FfNvZFEYlsomjnhJ02c2z86c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLfKpQAsF9n6UettfLsfatr4PTAi7HlI6nwxvQO7f04NA8torjEgd6IssH0ieVwBIW1ukL/tghNLtQTxkKDy0EvUrIAuNVWpOPzid3wvJXRH7JBzJEjTp5JyEVCyqGNKM6Je9Fvs97+IYRlgdaStW8jjBPMQr7hC/MNwCVdIfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TY1UWKHr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W3eyOiaD; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TY1UWKHr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W3eyOiaD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEFF81400173;
	Wed,  7 Jan 2026 05:10:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 07 Jan 2026 05:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767780619;
	 x=1767867019; bh=q0aY6FbNxKW3g3HdwmbRoA555uO3/vCSon8iIg9moZE=; b=
	TY1UWKHrsJuyCeTz21wB8iH/94jCBLpXx4J9klS2BsvsMD3cYLWMHFmqN2vSOpuV
	k8eljVo7GpZl2+OpLajOOjhj2zzzHvz7oAlrKkrQygHtB09xDKbiS8niaptmiZyx
	/JyplCeeM5TnBNHTp21j4+a7hL8piHdRFFw/BeJP6QM1QowzDOQydk3uYH46uG2X
	1wdXbUtObBmV3psMWXBtP1IY/HUHK/3Ber7qEJDrZgvIUb4lpiGqiINuoovmH0wd
	IwJiLThZn8ajo9K26lxinpJp0CD2Mom9q/mB8mBWHATSls01PkB/mLgAIa0Xe418
	sAh7JEXMfRfmS61GRjOhQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767780619; x=
	1767867019; bh=q0aY6FbNxKW3g3HdwmbRoA555uO3/vCSon8iIg9moZE=; b=W
	3eyOiaDwYwiTsYefez9yGpVl68ZPDtTNWxX+TqEGesDwi7Y+E6nhJ8qumX9hzfSx
	40dGTcrzGa4h9G2MFvATOSJJcsL88IAfjAOJ+Dwc+1JaMEAqw3nF28oAVYzK36pY
	i47MsGJltzMNrBajssuekZCQCvukF57EbOeNOyo2WcRNbO97I4GjmeUQ1VObYLQU
	eNkvQUW+yRMAEr8s7dnl0tc9GpZvohZNFCk1gBIT8qpj/vgMTp9hZ4/hrv0A+d2M
	cWvPqEK+m2w0vSlNZSx6R5W4SLPLHUpvqEFWv8Wg1vbV5YjfW2ZsoBMuAruTd7rX
	5NhbtMaQ3QJ6jErjpmEqw==
X-ME-Sender: <xms:CzFeaUwhW33HphxwM7EGppFdnvLB5JKlsa1_BlkYAS2nLAKxZP7qaw>
    <xme:CzFeaUHg-Jb8ox84TVrHF67tlJvlcgKsn6wEZCiczoFx-ra43deqCVVDpnhvy3fPa
    Bwm8VXcaWV_VCsLD26y3ddyCHu6bRxHLNRcxJB1tjHGen7YE0J-zQ>
X-ME-Received: <xmr:CzFeaRsbr8NEAc_IGRYpZPSE4POigV5p57saYv1gdPN4CkTMsQYpC0QAkaoIN2BSAuexRhPEAGiLnYFWDMdsYRp0GM8KcSnPCg2xDlA96eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtth
    hopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrihhlsegsvgihvghrmh
    grthhthhhirghsrdguvg
X-ME-Proxy: <xmx:CzFeacAJez1kR3ST6VZZHdZwhIVCKXcutmhnQy3lYsRRg2Vw65hoZg>
    <xmx:CzFeaUA9sHv2sMF-1ain8-5hPOR5jTMIOxkwThQnN_7K7KcKTRmwXg>
    <xmx:CzFeaeplECMNnP4s7dIXy3-z6YLeys2jPF1gKWgUZqgJzCFhHA-Sng>
    <xmx:CzFeaXGu3FJ4bQtlQI28PecpSxpPCjvjsfNPYzXlnEMiRN1-wC8E9Q>
    <xmx:CzFeaQwjloClWpsNtyHAdXhSqKf17muaSrwACYpxSQokkA72y0yJ2qoL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:10:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e50d157 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:10:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 11:10:09 +0100
Subject: [PATCH v8 1/7] builtin/replay: extract core logic to replay
 revisions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-history-builtin-v8-1-18e9779e3a26@pks.im>
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

We're about to move the core logic used to replay revisions onto a new
base into the "libgit.a" library. Prepare for this by pulling out the
logic into a new function `replay_revisions()` that:

  1. Takes a set of revisions to replay and some options that tell it how
     it ought to replay the revisions.

  2. Replays the commits.

  3. Records any reference updates that would be caused by replaying the
     commits in a structure that is owned by the caller.

The logic itself will be moved into a separate file in the next commit.
This change is not expected to cause user-visible change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/replay.c | 258 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 149 insertions(+), 109 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 1960bbbee8..d7523fdbc2 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -278,6 +278,127 @@ static enum ref_action_mode get_ref_action_mode(struct repository *repo, const c
 	return REF_ACTION_UPDATE;
 }
 
+struct replay_revisions_options {
+	const char *advance;
+	const char *onto;
+	int contained;
+};
+
+struct replay_ref_updates {
+	struct replay_ref_update {
+		char *refname;
+		struct object_id old_oid;
+		struct object_id new_oid;
+	} *items;
+	size_t nr, alloc;
+};
+
+static void replay_ref_updates_release(struct replay_ref_updates *updates)
+{
+	for (size_t i = 0; i < updates->nr; i++)
+		free(updates->items[i].refname);
+	free(updates->items);
+}
+
+static int replay_revisions(struct repository *repo, struct rev_info *revs,
+			    struct replay_revisions_options *opts,
+			    struct replay_ref_updates *updates)
+{
+	kh_oid_map_t *replayed_commits = NULL;
+	struct strset *update_refs = NULL;
+	struct commit *last_commit = NULL;
+	struct commit *commit;
+	struct commit *onto = NULL;
+	struct merge_options merge_opt;
+	struct merge_result result;
+	char *advance;
+	int ret;
+
+	advance = xstrdup_or_null(opts->advance);
+	set_up_replay_mode(repo, &revs->cmdline, opts->onto, &advance,
+			   &onto, &update_refs);
+
+	/* FIXME: Should allow replaying commits with the first as a root commit */
+
+	if (prepare_revision_walk(revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	init_basic_merge_options(&merge_opt, repo);
+	memset(&result, 0, sizeof(result));
+	merge_opt.show_rename_progress = 0;
+	last_commit = onto;
+	replayed_commits = kh_init_oid_map();
+	while ((commit = get_revision(revs))) {
+		const struct name_decoration *decoration;
+		khint_t pos;
+		int hr;
+
+		if (!commit->parents)
+			die(_("replaying down from root commit is not supported yet!"));
+		if (commit->parents->next)
+			die(_("replaying merge commits is not supported yet!"));
+
+		last_commit = pick_regular_commit(repo, commit, replayed_commits,
+						  onto, &merge_opt, &result);
+		if (!last_commit)
+			break;
+
+		/* Record commit -> last_commit mapping */
+		pos = kh_put_oid_map(replayed_commits, commit->object.oid, &hr);
+		if (hr == 0)
+			BUG("Duplicate rewritten commit: %s\n",
+			    oid_to_hex(&commit->object.oid));
+		kh_value(replayed_commits, pos) = last_commit;
+
+		/* Update any necessary branches */
+		if (advance)
+			continue;
+		decoration = get_name_decoration(&commit->object);
+		if (!decoration)
+			continue;
+		while (decoration) {
+			if (decoration->type == DECORATION_REF_LOCAL &&
+			    (opts->contained || strset_contains(update_refs,
+								decoration->name))) {
+				ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
+				updates->items[updates->nr].refname = xstrdup(decoration->name);
+				updates->items[updates->nr].old_oid = commit->object.oid;
+				updates->items[updates->nr].new_oid = last_commit->object.oid;
+				updates->nr++;
+			}
+			decoration = decoration->next;
+		}
+	}
+
+	if (!result.clean) {
+		ret = -1;
+		goto out;
+	}
+
+	/* In --advance mode, advance the target ref */
+	if (advance) {
+		ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
+		updates->items[updates->nr].refname = xstrdup(advance);
+		updates->items[updates->nr].old_oid = onto->object.oid;
+		updates->items[updates->nr].new_oid = last_commit->object.oid;
+		updates->nr++;
+	}
+
+	ret = 0;
+
+out:
+	if (update_refs) {
+		strset_clear(update_refs);
+		free(update_refs);
+	}
+	kh_destroy_oid_map(replayed_commits);
+	merge_finalize(&merge_opt, &result);
+	free(advance);
+	return ret;
+}
+
 static int handle_ref_update(enum ref_action_mode mode,
 			     struct ref_transaction *transaction,
 			     const char *refname,
@@ -306,21 +427,11 @@ int cmd_replay(int argc,
 	       const char *prefix,
 	       struct repository *repo)
 {
-	const char *advance_name_opt = NULL;
-	char *advance_name = NULL;
-	struct commit *onto = NULL;
-	const char *onto_name = NULL;
-	int contained = 0;
+	struct replay_revisions_options opts = { 0 };
+	struct replay_ref_updates updates = { 0 };
 	const char *ref_action = NULL;
 	enum ref_action_mode ref_mode;
-
 	struct rev_info revs;
-	struct commit *last_commit = NULL;
-	struct commit *commit;
-	struct merge_options merge_opt;
-	struct merge_result result;
-	struct strset *update_refs = NULL;
-	kh_oid_map_t *replayed_commits;
 	struct ref_transaction *transaction = NULL;
 	struct strbuf transaction_err = STRBUF_INIT;
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -333,13 +444,13 @@ int cmd_replay(int argc,
 		NULL
 	};
 	struct option replay_options[] = {
-		OPT_STRING(0, "advance", &advance_name_opt,
+		OPT_STRING(0, "advance", &opts.advance,
 			   N_("branch"),
 			   N_("make replay advance given branch")),
-		OPT_STRING(0, "onto", &onto_name,
+		OPT_STRING(0, "onto", &opts.onto,
 			   N_("revision"),
 			   N_("replay onto given commit")),
-		OPT_BOOL(0, "contained", &contained,
+		OPT_BOOL(0, "contained", &opts.contained,
 			 N_("update all branches that point at commits in <revision-range>")),
 		OPT_STRING(0, "ref-action", &ref_action,
 			   N_("mode"),
@@ -350,19 +461,17 @@ int cmd_replay(int argc,
 	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
-	if (!onto_name && !advance_name_opt) {
+	if (!opts.onto && !opts.advance) {
 		error(_("option --onto or --advance is mandatory"));
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
-				  contained, "--contained");
+	die_for_incompatible_opt2(!!opts.advance, "--advance",
+				  opts.contained, "--contained");
 
 	/* Parse ref action mode from command line or config */
 	ref_mode = get_ref_action_mode(repo, ref_action);
 
-	advance_name = xstrdup_or_null(advance_name_opt);
-
 	repo_init_revisions(repo, &revs, prefix);
 
 	/*
@@ -414,18 +523,19 @@ int cmd_replay(int argc,
 		revs.simplify_history = 0;
 	}
 
-	set_up_replay_mode(repo, &revs.cmdline,
-			   onto_name, &advance_name,
-			   &onto, &update_refs);
-
-	/* FIXME: Should allow replaying commits with the first as a root commit */
+	ret = replay_revisions(repo, &revs, &opts, &updates);
+	if (ret)
+		goto cleanup;
 
 	/* Build reflog message */
-	if (advance_name_opt)
-		strbuf_addf(&reflog_msg, "replay --advance %s", advance_name_opt);
-	else
-		strbuf_addf(&reflog_msg, "replay --onto %s",
-			    oid_to_hex(&onto->object.oid));
+	if (opts.advance) {
+		strbuf_addf(&reflog_msg, "replay --advance %s", opts.advance);
+	} else {
+		struct object_id oid;
+		if (repo_get_oid_committish(repo, opts.onto, &oid))
+			BUG("--onto commit should have been resolved beforehand already");
+		strbuf_addf(&reflog_msg, "replay --onto %s", oid_to_hex(&oid));
+	}
 
 	/* Initialize ref transaction if using update mode */
 	if (ref_mode == REF_ACTION_UPDATE) {
@@ -438,78 +548,19 @@ int cmd_replay(int argc,
 		}
 	}
 
-	if (prepare_revision_walk(&revs) < 0) {
-		ret = error(_("error preparing revisions"));
-		goto cleanup;
-	}
-
-	init_basic_merge_options(&merge_opt, repo);
-	memset(&result, 0, sizeof(result));
-	merge_opt.show_rename_progress = 0;
-	last_commit = onto;
-	replayed_commits = kh_init_oid_map();
-	while ((commit = get_revision(&revs))) {
-		const struct name_decoration *decoration;
-		khint_t pos;
-		int hr;
-
-		if (!commit->parents)
-			die(_("replaying down from root commit is not supported yet!"));
-		if (commit->parents->next)
-			die(_("replaying merge commits is not supported yet!"));
-
-		last_commit = pick_regular_commit(repo, commit, replayed_commits,
-						  onto, &merge_opt, &result);
-		if (!last_commit)
-			break;
-
-		/* Record commit -> last_commit mapping */
-		pos = kh_put_oid_map(replayed_commits, commit->object.oid, &hr);
-		if (hr == 0)
-			BUG("Duplicate rewritten commit: %s\n",
-			    oid_to_hex(&commit->object.oid));
-		kh_value(replayed_commits, pos) = last_commit;
-
-		/* Update any necessary branches */
-		if (advance_name)
-			continue;
-		decoration = get_name_decoration(&commit->object);
-		if (!decoration)
-			continue;
-		while (decoration) {
-			if (decoration->type == DECORATION_REF_LOCAL &&
-			    (contained || strset_contains(update_refs,
-							  decoration->name))) {
-				if (handle_ref_update(ref_mode, transaction,
-						      decoration->name,
-						      &last_commit->object.oid,
-						      &commit->object.oid,
-						      reflog_msg.buf,
-						      &transaction_err) < 0) {
-					ret = error(_("failed to update ref '%s': %s"),
-						    decoration->name, transaction_err.buf);
-					goto cleanup;
-				}
-			}
-			decoration = decoration->next;
-		}
-	}
-
-	/* In --advance mode, advance the target ref */
-	if (result.clean == 1 && advance_name) {
-		if (handle_ref_update(ref_mode, transaction, advance_name,
-				      &last_commit->object.oid,
-				      &onto->object.oid,
-				      reflog_msg.buf,
-				      &transaction_err) < 0) {
+	for (size_t i = 0; i < updates.nr; i++) {
+		ret = handle_ref_update(ref_mode, transaction, updates.items[i].refname,
+					&updates.items[i].new_oid, &updates.items[i].old_oid,
+					reflog_msg.buf, &transaction_err);
+		if (ret) {
 			ret = error(_("failed to update ref '%s': %s"),
-				    advance_name, transaction_err.buf);
+				    updates.items[i].refname, transaction_err.buf);
 			goto cleanup;
 		}
 	}
 
 	/* Commit the ref transaction if we have one */
-	if (transaction && result.clean == 1) {
+	if (transaction) {
 		if (ref_transaction_commit(transaction, &transaction_err)) {
 			ret = error(_("failed to commit ref transaction: %s"),
 				    transaction_err.buf);
@@ -517,24 +568,13 @@ int cmd_replay(int argc,
 		}
 	}
 
-	merge_finalize(&merge_opt, &result);
-	kh_destroy_oid_map(replayed_commits);
-	if (update_refs) {
-		strset_clear(update_refs);
-		free(update_refs);
-	}
-	ret = result.clean;
-
 cleanup:
 	if (transaction)
 		ref_transaction_free(transaction);
+	replay_ref_updates_release(&updates);
 	strbuf_release(&transaction_err);
 	strbuf_release(&reflog_msg);
 	release_revisions(&revs);
-	free(advance_name);
 
-	/* Return */
-	if (ret < 0)
-		exit(128);
-	return ret ? 0 : 1;
+	return ret ? 1 : 0;
 }

-- 
2.52.0.542.g9473a8513b.dirty

