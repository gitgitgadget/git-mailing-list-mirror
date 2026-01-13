Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141733803FC
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298085; cv=none; b=Y99QjU6TipyIbqow1rcdPRbhitEFWayV63x1s2ks8XQ0uY5tmSkDgsP9se1CWUYjyobvPRNjA1OnEYwpZY3GCktEnW47ZX7dLQ4Jhq26durpFYuD0y0mGR/aM358VjL52BWLjINECU7mg64WDTbtxMl1xnm5tnTfPb5+w6RcQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298085; c=relaxed/simple;
	bh=JaSqfD5yp2Y0ZlAeLsqjDNxCdlSgFMtj1m7S+bAkUWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tzz8ZhR1b3yE58R4YrdVYROxRjaMUDYUGVdy1NEnSSwBgsNyAn+Vxe4AqzBpgitmWWTV6p05mP0ds5zQAxD06ghhnJrmD/j455k/fDt8Tfuqmc+XGTweSkZGJNE/QOHull/oSiEnW/Lb80khIs1mir6miOYLgiCiDIz2KjvOvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XJGXpaEx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xn8iE2Db; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XJGXpaEx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xn8iE2Db"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2AF3B1400174;
	Tue, 13 Jan 2026 04:54:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 13 Jan 2026 04:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768298082;
	 x=1768384482; bh=FmojhXJE+u+i/hJlOYa8x0cY65JB+RErmujoq1JiFHI=; b=
	XJGXpaExHp1VWQc8IFU85UJWCCOL9NmQTlkzYuzKw/1wkjQkeD93pvWprO8WS9Ly
	xwgBUkckTx+3R1Yj238DXPIaScdaFgpv6kPxQ8wDiOVYLSN24X8GSGyyMVN+Y4bL
	vHiVONXr0S6qNMzqyb1n0egCzyC4+vTamb2Wc4YppQ3wfuk/n3YFR06fPWyjWv0a
	I7MYEy39+Us889wYx7hYjYYct2z+Jf9QgVkVWVKJVvwmBU4/8WX/1Hsn3wEd4+VM
	ly1lP9OWxOOCC8mghmst5geqB+zxnIjHNbirlGR2ujsxq++pEzijXC+8m4pXbN8P
	Oct5RJBrE/DbnrekH/KVKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768298082; x=
	1768384482; bh=FmojhXJE+u+i/hJlOYa8x0cY65JB+RErmujoq1JiFHI=; b=X
	n8iE2DbRiVajGzsfgFo3McstWPdt6RfnVzW6rVqa0RLvs8LgzFWVgXEDufRO4Tf9
	bEWEVxVFcsT1OQvgZTq9WnrbCaW41i6+QycTDomvHnGbmOH7qODtngSg8q1uKbSV
	9hRsxvV+9aze7+tiBFkLU8V26mQDOH/Bwzbu1IvanfQ45UAVRAL/lLTGPwFarf6E
	snvAv00RlCndj5BFprf3mIhpxL9qcIOVHXHA3G2Xov6ThZ3gImX+riiJGBT8GBD5
	fdqLMQ79GYsEPg0/oezPGMBd/Ruz2F12hTwKpEV9Fc30SF5yFOSQe/cgJP/lqwl5
	bqHnQpsl8zR559VawfKSg==
X-ME-Sender: <xms:YhZmaQ1QLTPp85UWFEAXu6tsAzEVgkXs5XABjlJySlSxjx6Uu1tVrw>
    <xme:YhZmaW4uZE_KB6XDhbBSbiNfQCDE8fKNIFFqTev2E28LgGeU5CdX61XOZ1h-5UbEG
    OPWifzOAqlKWejThH6m5AEN1Unn4SHhSqODnkEScT_8GoIjFf0KgQ>
X-ME-Received: <xmr:YhZmaUTSF8nmhe3jfcUro6CI4cZ4AVDTav-MsHiy-_NMxgDpXBIbi5fxOXe_J2FSa35Phg4S-z4dn-MOvT0EPZafD-Zmy-lSzpBJFo7DTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddttddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhnii
    esghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YhZmaTXcaweqHJmDJ6s9rK3ETYemV9NvwO2d3d3OKQqjdo7CW2g8Jg>
    <xmx:YhZmaRH3Kk5zIaLddn6uDsdytLcegq742JMTc_V1_HwIkR_nLkydFA>
    <xmx:YhZmaedJ747WDkW65SBJ3P2T2qaMMb7W6fVqJ2v8wk7puDCqHdwugQ>
    <xmx:YhZmaSoP1RQM5Hhcl4_q0er3_1W94cvx6TGmujXDmNw6Mv1dhiGzwA>
    <xmx:YhZmafs1X914-d7UMkw3n218WN_68C6eiQvbgnIe06VJIPi4Ho17iVzK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 04:54:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1a4f138 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 09:54:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Jan 2026 10:54:32 +0100
Subject: [PATCH v11 1/8] builtin/replay: extract core logic to replay
 revisions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-b4-pks-history-builtin-v11-1-e74ebfa2652d@pks.im>
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
In-Reply-To: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
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
 builtin/replay.c | 269 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 162 insertions(+), 107 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 1960bbbee8..daf907668c 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -177,8 +177,9 @@ static void set_up_replay_mode(struct repository *repo,
 	if (!rinfo.positive_refexprs)
 		die(_("need some commits to replay"));
 
-	die_for_incompatible_opt2(!!onto_name, "--onto",
-				  !!*advance_name, "--advance");
+	if (!onto_name == !*advance_name)
+		BUG("one and only one of onto_name and *advance_name must be given");
+
 	if (onto_name) {
 		*onto = peel_committish(repo, onto_name, "--onto");
 		if (rinfo.positive_refexprs <
@@ -253,6 +254,134 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	return create_commit(repo, result->tree, pickme, replayed_base);
 }
 
+struct replay_revisions_options {
+	const char *advance;
+	const char *onto;
+	int contained;
+};
+
+struct replay_result {
+	struct replay_ref_update {
+		char *refname;
+		struct object_id old_oid;
+		struct object_id new_oid;
+	} *updates;
+	size_t updates_nr, updates_alloc;
+};
+
+static void replay_result_release(struct replay_result *result)
+{
+	for (size_t i = 0; i < result->updates_nr; i++)
+		free(result->updates[i].refname);
+	free(result->updates);
+}
+
+static void replay_result_queue_update(struct replay_result *result,
+				       const char *refname,
+				       const struct object_id *old_oid,
+				       const struct object_id *new_oid)
+{
+	ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
+	result->updates[result->updates_nr].refname = xstrdup(refname);
+	result->updates[result->updates_nr].old_oid = *old_oid;
+	result->updates[result->updates_nr].new_oid = *new_oid;
+	result->updates_nr++;
+}
+
+static int replay_revisions(struct rev_info *revs,
+			    struct replay_revisions_options *opts,
+			    struct replay_result *out)
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
+	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto, &advance,
+			   &onto, &update_refs);
+
+	/* FIXME: Should allow replaying commits with the first as a root commit */
+
+	if (prepare_revision_walk(revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	init_basic_merge_options(&merge_opt, revs->repo);
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
+		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
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
+				replay_result_queue_update(out, decoration->name,
+							   &commit->object.oid,
+							   &last_commit->object.oid);
+			}
+			decoration = decoration->next;
+		}
+	}
+
+	if (!result.clean) {
+		ret = 1;
+		goto out;
+	}
+
+	/* In --advance mode, advance the target ref */
+	if (advance)
+		replay_result_queue_update(out, advance,
+					   &onto->object.oid,
+					   &last_commit->object.oid);
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
 static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
 {
 	if (!ref_action || !strcmp(ref_action, "update"))
@@ -306,21 +435,11 @@ int cmd_replay(int argc,
 	       const char *prefix,
 	       struct repository *repo)
 {
-	const char *advance_name_opt = NULL;
-	char *advance_name = NULL;
-	struct commit *onto = NULL;
-	const char *onto_name = NULL;
-	int contained = 0;
+	struct replay_revisions_options opts = { 0 };
+	struct replay_result result = { 0 };
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
@@ -333,13 +452,13 @@ int cmd_replay(int argc,
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
@@ -350,19 +469,19 @@ int cmd_replay(int argc,
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
+	die_for_incompatible_opt2(!!opts.advance, "--advance",
+				  !!opts.onto, "--onto");
 
 	/* Parse ref action mode from command line or config */
 	ref_mode = get_ref_action_mode(repo, ref_action);
 
-	advance_name = xstrdup_or_null(advance_name_opt);
-
 	repo_init_revisions(repo, &revs, prefix);
 
 	/*
@@ -414,18 +533,19 @@ int cmd_replay(int argc,
 		revs.simplify_history = 0;
 	}
 
-	set_up_replay_mode(repo, &revs.cmdline,
-			   onto_name, &advance_name,
-			   &onto, &update_refs);
-
-	/* FIXME: Should allow replaying commits with the first as a root commit */
+	ret = replay_revisions(&revs, &opts, &result);
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
@@ -438,78 +558,19 @@ int cmd_replay(int argc,
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
+	for (size_t i = 0; i < result.updates_nr; i++) {
+		ret = handle_ref_update(ref_mode, transaction, result.updates[i].refname,
+					&result.updates[i].new_oid, &result.updates[i].old_oid,
+					reflog_msg.buf, &transaction_err);
+		if (ret) {
 			ret = error(_("failed to update ref '%s': %s"),
-				    advance_name, transaction_err.buf);
+				    result.updates[i].refname, transaction_err.buf);
 			goto cleanup;
 		}
 	}
 
 	/* Commit the ref transaction if we have one */
-	if (transaction && result.clean == 1) {
+	if (transaction) {
 		if (ref_transaction_commit(transaction, &transaction_err)) {
 			ret = error(_("failed to commit ref transaction: %s"),
 				    transaction_err.buf);
@@ -517,24 +578,18 @@ int cmd_replay(int argc,
 		}
 	}
 
-	merge_finalize(&merge_opt, &result);
-	kh_destroy_oid_map(replayed_commits);
-	if (update_refs) {
-		strset_clear(update_refs);
-		free(update_refs);
-	}
-	ret = result.clean;
+	ret = 0;
 
 cleanup:
 	if (transaction)
 		ref_transaction_free(transaction);
+	replay_result_release(&result);
 	strbuf_release(&transaction_err);
 	strbuf_release(&reflog_msg);
 	release_revisions(&revs);
-	free(advance_name);
 
 	/* Return */
 	if (ret < 0)
 		exit(128);
-	return ret ? 0 : 1;
+	return ret;
 }

-- 
2.52.0.590.g1f87b77810.dirty

