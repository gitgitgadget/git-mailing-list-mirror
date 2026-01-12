Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CED24E4D4
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227434; cv=none; b=tPx4sZ1LXE5YxybXdEySh3eSE2HATEMF9NeIvl6YpeD0nfeeZwCVjNCIWQLhN3rIdHipWAQox/f8wYQKPdEFL367+gs+dxr2EQCMZyGdFA8OIR5lAoVKLBFkW8rLIz5DWnNjwqPnM+Y4gZ0t60YZ1dMeJqJGMUZFh658nwIFZx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227434; c=relaxed/simple;
	bh=juarOFR/CMOMVbcIZtMFe1qX+do1HPoZcKXl/FLtc+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fC03OKQMk99dOd8N8KAcRPsryzMdlvhPMcfV/eIr2sbs4AI8P4ktPPys0S7fAkDbpERVOjQMnJKh31N24IRma6okwUGeLYe1PuCN3SNFYx/Ut4t9NsCgH7cR/NOkDcAg3KvanI2/Qt9AUUZdguk81htx5Xd3wwQygDQPdLOhxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uskqil1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jw0uTVtR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uskqil1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jw0uTVtR"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA25114000C8;
	Mon, 12 Jan 2026 09:17:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 12 Jan 2026 09:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768227427;
	 x=1768313827; bh=Td50VWi0qJeLXS2OPQ3ZLis3M5v92LufM9WRrgGI2Rc=; b=
	Uskqil1HBOKWKyTW1S5dy0aDk0eTPPBHQ7vUYqEs+LiouTZ9tdCUzCFe/MPK85C7
	/6Uq9ITVnTDYTztguyc6xx27rgw2W6a4fTqXUrJ5qbBY6NuXMFZDfu57likRzTUw
	aqB7UOCXyT7TNe924yx0PxqF9mf68og1acD7fwUx+Zsq4ho0R1JuzTF+jklos9nf
	k83P2DE2b6eF2Kd9KxvODMtPK+W9sYC+05erDnLdY7p9T6/reIMjCkj0qGqbX8uh
	vpUGucvyjGr6J9xznH3qE8ECuBlfihUV3fOBl/w30F81LDKC1vDctouOXl4aUlCh
	BeY4FDNYKiW7uiEb/Vtydw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768227427; x=
	1768313827; bh=Td50VWi0qJeLXS2OPQ3ZLis3M5v92LufM9WRrgGI2Rc=; b=J
	w0uTVtR02j2asYV4HUlHFXHXpFkhMYhrRML4JAegrKYYeyFSbMfsm2mpDXCnVszl
	y++E4evglUBVAYM7h9iYKn/IJuY68yt6CEa/slhiMVBNyApV0zmdcCTmBEUeNiXz
	y/yDy7hRVs9E/woAyGE8WNds8e8WHUIqVpqY/+1DSDCNQm0hpDHNJYl1yNhhc37U
	bM57YRQJEwFKdirVUeft/jn9caMeLhCao6m81PjSKjhXbUU8DoZndAKdN+prwbWQ
	xJWEgFWeFVCbLw7dWnFnYwgsB3jkBIZKxcCcbtoFEuZ5Dnt+M8y+J4Z7/hg3XgXf
	PXsu5sNoZ8dxepTGB0l6A==
X-ME-Sender: <xms:YwJlaY7j-yhp61T3OG7TeMPfQov4_lMLWIBKy9hYbURjzv5Tfr46hw>
    <xme:YwJlaVviymlsFENJ8Z_EnGPPgBko2LCCRsIYZSdMf-Kk5-kOQ-L-llqZpm8CVCxfR
    oUuROHKuxZIZ075EBuboxFHdNAp7OyjwDM8aVzhKRRLstQqaFFbpg>
X-ME-Received: <xmr:YwJlaS1c9bA_An1OKpAahLXcCbo6ExcoHCD_d80N3gtJE2EV7VXsnX751S_xHKtpGvMhxNzBnfxSybpF8IlJJkatSESqDKcGiMWk-szG0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghilh
    essggvhigvrhhmrghtthhhihgrshdruggvpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YwJlaWrqcvv_KtiImdDBfFa8CetjmnLiiEr8kPzwq7hvUSGB-bGphg>
    <xmx:YwJlaaKhy5rZ3dfQ9vvkW8PC5okffO2gNlv8DrjSQFy8xW1JR_f-1A>
    <xmx:YwJlaaQvQoSPTCgNe924ni8j0GrrVzQ0KSx6hklXh8aF8MVwThjTzA>
    <xmx:YwJlaaOuxLPi8FQUPY05vlMXNtng1QcQ-IiR3-WpqyFOghmoEpzqeA>
    <xmx:YwJlaa5cxB95lvBCE0y674ynPwd4tysI2VmD3HePq5QzpaXzYCItK9jj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:17:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a1f87fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 14:17:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 15:15:13 +0100
Subject: [PATCH v10 1/8] builtin/replay: extract core logic to replay
 revisions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-history-builtin-v10-1-e3c6aa5b4cec@pks.im>
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
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
 builtin/replay.c | 281 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 170 insertions(+), 111 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 1960bbbee8..df0dc04d02 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -177,8 +177,9 @@ static void set_up_replay_mode(struct repository *repo,
 	if (!rinfo.positive_refexprs)
 		die(_("need some commits to replay"));
 
-	die_for_incompatible_opt2(!!onto_name, "--onto",
-				  !!*advance_name, "--advance");
+	if (!(!!onto_name ^ !!*advance_name))
+		BUG("expected either onto_name or *advance_name in this function");
+
 	if (onto_name) {
 		*onto = peel_committish(repo, onto_name, "--onto");
 		if (rinfo.positive_refexprs <
@@ -253,6 +254,137 @@ static struct commit *pick_regular_commit(struct repository *repo,
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
+
+	bool merge_conflict;
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
+		out->merge_conflict = true;
+		ret = -1;
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
@@ -306,21 +438,11 @@ int cmd_replay(int argc,
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
@@ -333,13 +455,13 @@ int cmd_replay(int argc,
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
@@ -350,19 +472,19 @@ int cmd_replay(int argc,
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
@@ -414,18 +536,19 @@ int cmd_replay(int argc,
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
@@ -438,78 +561,19 @@ int cmd_replay(int argc,
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
@@ -517,24 +581,19 @@ int cmd_replay(int argc,
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
+	replay_result_release(&result);
 	strbuf_release(&transaction_err);
 	strbuf_release(&reflog_msg);
 	release_revisions(&revs);
-	free(advance_name);
 
-	/* Return */
-	if (ret < 0)
-		exit(128);
-	return ret ? 0 : 1;
+	if (ret) {
+		if (result.merge_conflict)
+			return 1;
+		return 128;
+	}
+
+	return 0;
 }

-- 
2.52.0.590.g1f87b77810.dirty

