Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6C2F12BB
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771224363; cv=none; b=G+BrmSaSugX5Ir68GAtJy2HpP3NfgnSGMmgFEo35mQXq5o0Ehj+YjJwN/L0+0p1yEIZpKf02h/rQg6giGU133AUQnLZLGaTeztss740jerOtHDcMeqvslXzprjicBq+UAFFysyiHfBphOTkIrReEWNl5HRkrfaGv4A3pr9kx6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771224363; c=relaxed/simple;
	bh=eK3Tp7kfQeISNRgRGecKaox9eFkxrjKZcNRsrnEgNKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRGaBBHz1WMo1VXLnAQSXe+qht9A8gj089viipNWWhUPRkiBVdVz6+bTK28i/35wPxExb7HnH1Dk5JsemZufp3Q5FrekcLP4FvmUxDFwWJv93SSxiQhrqfdqaJ2qwVSjjgnxCQ0VafU3D0MZgPRdZqZtYkUAJDAegxmY7Xs8LtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I0T91gOu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VaIDJ/NP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I0T91gOu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VaIDJ/NP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF0AD7A010C;
	Mon, 16 Feb 2026 01:46:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Feb 2026 01:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771224361;
	 x=1771310761; bh=/mQf383nwhlPMzNN+CUSbNwUuwR1K19Ax0oHmPJ+Iko=; b=
	I0T91gOudkbwLt94CQxuNo7VUJUBon+PkJVOti3hOxYgHEg7sAZ13yT8gXRLQlRA
	yrvJekNuoNqOBD9nevcM5Azzy1ZZSUYXpO1LBfTAuss5OP/qrfqrAoD/ef4fRgsU
	Vc0LzggSYk+Yo3WYoyw8MtaOJE2LIx3KdA86GxcFtViN24UjtOPUX9DcewS0Nn88
	KpY94YMQjkLUEpBT1MhUL2Gh2KyB2mNdRvWvaaPo4GsYg5IkwsgVum7YiaGUw0MK
	W3uSNCafdzB2vAMlBbu/hQ1R9Ro8hbW8Rb7ueCk/1GQvPUA5wmAlhWzu1KxFI21Z
	F3mHaLsRwX0hH3+sW9KAyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771224361; x=
	1771310761; bh=/mQf383nwhlPMzNN+CUSbNwUuwR1K19Ax0oHmPJ+Iko=; b=V
	aIDJ/NPi2novTwb58K2WEm8j5dzBciEw5PrTG0Rbsn7pK8Gejt60D747Qd9ifVtF
	Mo23m8vqD7nAu+S3ExCLq1MhGFZAphANk7LCy7dwy9Rk0lqoSyDyv3qLviQoDUML
	gXylSELttKAR33HKqsy5tm2aToW27PFCWEzMv4pz8Ne/NujCp3qs1d/wMacnkNaS
	0qaXVuzComTEkLHHy6m4PtNFB514beQlXK8W2gjB/JnYu56rguUsVn59jToEVbVR
	MsHXNmfDy/2642JFbOXJG+PGxBV2/D1mdzHGPYQcpQofGnZqBTXumVWqBUL96PGT
	tDD6jtLCwvcjfphStCHiQ==
X-ME-Sender: <xms:Kb2SadJNT03Vnfqk4gf-_hVtamagwFx7ymlYkDONHNxZ6iS7hxZr0Q>
    <xme:Kb2SaQKPdWeJ7QIrmFCdInQ1A7ii8jYyHq4JD056pqPKhpH5yQy6q6H_etsyhXY_W
    goDT6crBUa3ugaQg9WGJM72DYAzUubomAYnI2Z5tGEq8QDxN8VPqA>
X-ME-Received: <xmr:Kb2Saau9S6sFc7H9sR7HNVSZxYPdhXwLv-UxIFVDN4hH3jMUI0cK-LRRW4sOooYf_2fAdkhGCA2aF2ia-4PgI1JFBhYuXPN2jPyAg2_gig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Kb2SadRxa_jE4Ekf44d48QEdUBaLPA0SbTXNW_v49Kny7so-9_lSlg>
    <xmx:Kb2SaQMltcItFe-ETlev4GmZykaqbIcOyOPSyIzh7KD2BJNgbEOQKQ>
    <xmx:Kb2SaSbCu60_jzoIPHtVfTp4d2ywGS_VQWDGyP8hLk_ow7p2kjl_Wg>
    <xmx:Kb2SaazhUiCUkZGr_5N47wZysw3mTWuDscA-JgUJgv-OlTI2zvcbUw>
    <xmx:Kb2SaaOHWfRos9tPQ_W5O_183bpU9nX0iD5QHhrkktkns9zTtlwbvd9E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 01:46:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7330b194 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 06:45:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Feb 2026 07:45:46 +0100
Subject: [PATCH v3 3/5] builtin/history: replace "--ref-action=print" with
 "--dry-run"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-b4-pks-history-dry-run-v3-3-c4db58a651fc@pks.im>
References: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
In-Reply-To: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

The git-history(1) command has the ability to perform a dry-run
that will not end up modifying any references. Instead, we'll only print
any ref updates that would happen as a consequence of performing the
operation.

This mode is somewhat hidden though behind the "--ref-action=print"
option. This command line option has its origin in git-replay(1), where
it's probably an okayish interface as this command is sitting more on
the plumbing side of tools. But git-history(1) is a user-facing tool,
and this way of achieving a dry-run is way too technical and thus not
very discoverable.

Besides usability issues, it also has another issue: the dry-run mode
will always operate as if the user wanted to rewrite all branches. But
in fact, the user also has the option to only update the HEAD reference,
and they might want to perform a dry-run of such an operation, too. We
could of course introduce "--ref-action=print-head", but that would
become even less ergonomic.

Replace "--ref-action=print" with a new "--dry-run" toggle. This new
toggle works with both "--ref-action={head,branches}" and is way more
discoverable.

Add a test to verify that both "--ref-action=" values behave as
expected.

This patch is best viewed with "--ignore-space-change".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  14 ++--
 builtin/history.c              | 150 ++++++++++++++++++++++-------------------
 t/t3451-history-reword.sh      |  12 +++-
 3 files changed, 98 insertions(+), 78 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 154e262b76..df2900ac2f 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
-git history reword <commit> [--ref-action=(branches|head|print)]
+git history reword <commit> [--dry-run] [--ref-action=(branches|head)]
 
 DESCRIPTION
 -----------
@@ -60,13 +60,17 @@ The following commands are available to rewrite history in different ways:
 OPTIONS
 -------
 
-`--ref-action=(branches|head|print)`::
+`--dry-run`::
+	Do not update any references, but instead print any ref updates in a
+	format that can be consumed by linkgit:git-update-ref[1]. Necessary new
+	objects will be written into the repository, so applying these printed
+	ref updates is generally safe.
+
+`--ref-action=(branches|head)`::
 	Control which references will be updated by the command, if any. With
 	`branches`, all local branches that point to commits which are
 	descendants of the original commit will be rewritten. With `head`, only
-	the current `HEAD` reference will be rewritten. With `print`, all
-	updates as they would be performed with `branches` are printed in a
-	format that can be consumed by linkgit:git-update-ref[1].
+	the current `HEAD` reference will be rewritten.
 
 GIT
 ---
diff --git a/builtin/history.c b/builtin/history.c
index ff90e93d6e..c135361c67 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -18,7 +18,7 @@
 #include "wt-status.h"
 
 #define GIT_HISTORY_REWORD_USAGE \
-	N_("git history reword <commit> [--ref-action=(branches|head|print)]")
+	N_("git history reword <commit> [--dry-run] [--ref-action=(branches|head)]")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -155,7 +155,6 @@ enum ref_action {
 	REF_ACTION_DEFAULT,
 	REF_ACTION_BRANCHES,
 	REF_ACTION_HEAD,
-	REF_ACTION_PRINT,
 };
 
 static int parse_ref_action(const struct option *opt, const char *value, int unset)
@@ -167,10 +166,8 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
 		*action = REF_ACTION_BRANCHES;
 	} else if (!strcmp(value, "head")) {
 		*action = REF_ACTION_HEAD;
-	} else if (!strcmp(value, "print")) {
-		*action = REF_ACTION_PRINT;
 	} else {
-		return error(_("%s expects one of 'branches', 'head' or 'print'"),
+		return error(_("%s expects one of 'branches' or 'head'"),
 			     opt->long_name);
 	}
 
@@ -286,11 +283,29 @@ static int setup_revwalk(struct repository *repo,
 	return ret;
 }
 
+static int handle_ref_update(struct ref_transaction *transaction,
+			     const char *refname,
+			     const struct object_id *new_oid,
+			     const struct object_id *old_oid,
+			     const char *reflog_msg,
+			     struct strbuf *err)
+{
+	if (!transaction) {
+		printf("update %s %s %s\n",
+		       refname, oid_to_hex(new_oid), oid_to_hex(old_oid));
+		return 0;
+	}
+
+	return ref_transaction_update(transaction, refname, new_oid, old_oid,
+				      NULL, NULL, 0, reflog_msg, err);
+}
+
 static int handle_reference_updates(struct rev_info *revs,
 				    enum ref_action action,
 				    struct commit *original,
 				    struct commit *rewritten,
-				    const char *reflog_msg)
+				    const char *reflog_msg,
+				    int dry_run)
 {
 	const struct name_decoration *decoration;
 	struct replay_revisions_options opts = { 0 };
@@ -312,82 +327,72 @@ static int handle_reference_updates(struct rev_info *revs,
 	if (ret)
 		goto out;
 
-	switch (action) {
-	case REF_ACTION_BRANCHES:
-	case REF_ACTION_HEAD:
+	if (action != REF_ACTION_BRANCHES && action != REF_ACTION_HEAD)
+		BUG("unsupported ref action %d", action);
+
+	if (!dry_run) {
 		transaction = ref_store_transaction_begin(get_main_ref_store(revs->repo), 0, &err);
 		if (!transaction) {
 			ret = error(_("failed to begin ref transaction: %s"), err.buf);
 			goto out;
 		}
+	}
 
-		for (size_t i = 0; i < result.updates_nr; i++) {
-			ret = ref_transaction_update(transaction,
-						     result.updates[i].refname,
-						     &result.updates[i].new_oid,
-						     &result.updates[i].old_oid,
-						     NULL, NULL, 0, reflog_msg, &err);
-			if (ret) {
-				ret = error(_("failed to update ref '%s': %s"),
-					    result.updates[i].refname, err.buf);
-				goto out;
-			}
+	for (size_t i = 0; i < result.updates_nr; i++) {
+		ret = handle_ref_update(transaction,
+					result.updates[i].refname,
+					&result.updates[i].new_oid,
+					&result.updates[i].old_oid,
+					reflog_msg, &err);
+		if (ret) {
+			ret = error(_("failed to update ref '%s': %s"),
+				    result.updates[i].refname, err.buf);
+			goto out;
 		}
+	}
+
+	/*
+	 * `replay_revisions()` only updates references that are
+	 * ancestors of `rewritten`, so we need to manually
+	 * handle updating references that point to `original`.
+	 */
+	for (decoration = get_name_decoration(&original->object);
+	     decoration;
+	     decoration = decoration->next)
+	{
+		if (decoration->type != DECORATION_REF_LOCAL &&
+		    decoration->type != DECORATION_REF_HEAD)
+			continue;
+
+		if (action == REF_ACTION_HEAD &&
+		    decoration->type != DECORATION_REF_HEAD)
+			continue;
 
 		/*
-		 * `replay_revisions()` only updates references that are
-		 * ancestors of `rewritten`, so we need to manually
-		 * handle updating references that point to `original`.
+		 * We only need to update HEAD separately in case it's
+		 * detached. If it's not we'd already update the branch
+		 * it is pointing to.
 		 */
-		for (decoration = get_name_decoration(&original->object);
-		     decoration;
-		     decoration = decoration->next)
-		{
-			if (decoration->type != DECORATION_REF_LOCAL &&
-			    decoration->type != DECORATION_REF_HEAD)
-				continue;
-
-			if (action == REF_ACTION_HEAD &&
-			    decoration->type != DECORATION_REF_HEAD)
-				continue;
-
-			/*
-			 * We only need to update HEAD separately in case it's
-			 * detached. If it's not we'd already update the branch
-			 * it is pointing to.
-			 */
-			if (action == REF_ACTION_BRANCHES &&
-			    decoration->type == DECORATION_REF_HEAD &&
-			    !detached_head)
-				continue;
-
-			ret = ref_transaction_update(transaction,
-						     decoration->name,
-						     &rewritten->object.oid,
-						     &original->object.oid,
-						     NULL, NULL, 0, reflog_msg, &err);
-			if (ret) {
-				ret = error(_("failed to update ref '%s': %s"),
-					    decoration->name, err.buf);
-				goto out;
-			}
-		}
-
-		if (ref_transaction_commit(transaction, &err)) {
-			ret = error(_("failed to commit ref transaction: %s"), err.buf);
+		if (action == REF_ACTION_BRANCHES &&
+		    decoration->type == DECORATION_REF_HEAD &&
+		    !detached_head)
+			continue;
+
+		ret = handle_ref_update(transaction,
+					decoration->name,
+					&rewritten->object.oid,
+					&original->object.oid,
+					reflog_msg, &err);
+		if (ret) {
+			ret = error(_("failed to update ref '%s': %s"),
+				    decoration->name, err.buf);
 			goto out;
 		}
+	}
 
-		break;
-	case REF_ACTION_PRINT:
-		for (size_t i = 0; i < result.updates_nr; i++)
-			printf("update %s %s %s\n",
-			       result.updates[i].refname,
-			       oid_to_hex(&result.updates[i].new_oid),
-			       oid_to_hex(&result.updates[i].old_oid));
-		break;
-	default:
-		BUG("unsupported ref action %d", action);
+	if (transaction && ref_transaction_commit(transaction, &err)) {
+		ret = error(_("failed to commit ref transaction: %s"), err.buf);
+		goto out;
 	}
 
 	ret = 0;
@@ -409,10 +414,13 @@ static int cmd_history_reword(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "ref-action", &action, N_("<action>"),
-			       N_("control ref update behavior (branches|head|print)"),
+			       N_("control ref update behavior (branches|head)"),
 			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_BOOL('n', "dry-run", &dry_run,
+			 N_("perform a dry-run without updating any refs")),
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -449,7 +457,7 @@ static int cmd_history_reword(int argc,
 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf);
+				       reflog_msg.buf, dry_run);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 12a9a7d051..702d40dc06 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -221,7 +221,7 @@ test_expect_success 'can reword a merge commit' '
 	)
 '
 
-test_expect_success '--ref-action=print prints ref updates without modifying repo' '
+test_expect_success '--dry-run prints ref updates without modifying repo' '
 	test_when_finished "rm -rf repo" &&
 	git init repo --initial-branch=main &&
 	(
@@ -233,7 +233,15 @@ test_expect_success '--ref-action=print prints ref updates without modifying rep
 		test_commit theirs &&
 
 		git refs list >refs-expect &&
-		reword_with_message --ref-action=print base >updates <<-\EOF &&
+		reword_with_message --dry-run --ref-action=head base >updates <<-\EOF &&
+		reworded commit
+		EOF
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual &&
+		test_grep "update refs/heads/branch" updates &&
+		test_grep ! "update refs/heads/main" updates &&
+
+		reword_with_message --dry-run base >updates <<-\EOF &&
 		reworded commit
 		EOF
 		git refs list >refs-actual &&

-- 
2.53.0.352.gd1286b26eb.dirty

