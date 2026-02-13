Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25F33E36B
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973987; cv=none; b=MmoTDvvVokO4VquExudlHs+z6qkX7/q05k3isaBdE8wmSnklxkaDWakdzbR7ECY7koLPn9sg7coFzYl0r4aXYBl6rDQ2RjSNDL1tyi2tAMg4Stu/4T69bQewib6VL+Dts/v/yHsDUTS2QPgCuH2G9xBPTYdZO5AbTVmNK/4hKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973987; c=relaxed/simple;
	bh=5yWZRg6sJwOfqyw4qXYmr4LUHFguMlQ3ntTCRM8YBYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2Ev33/u1KL3br7VTyynQdsEIq0XsU3eO+5FLl23a2SSsMg122x7TatkWx8J+zVUVhiRG4PkQHJs1uVEUPmkBV2Vyqy9Jt6zsGr0uvsc3qOa2bdg7CPGXg976HCbfwmb/iWAtt5/NFZdYmRh9KzAHoTryHb2t9d6GSHn/Fv2gFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YzM/yfEG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N1J45MA2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YzM/yfEG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1J45MA2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DE06EC0317;
	Fri, 13 Feb 2026 04:13:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Feb 2026 04:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770973985;
	 x=1771060385; bh=KUMlkRqnqZnV42cvKOQ8xGX/GuHUcUvPRs2gd/PSzls=; b=
	YzM/yfEGiMsgFiNJoaYW12E5HnGsXgs17K9wxH00nDHYGR64oQQPkmC4e30GbrCZ
	VFE1g1lfcEkBBWy1UcupoVSDu00ZZiyI0FmI+iERwunr7DjwkjkXkBH05k35R5VL
	zNF4MxDvaOWeEqtoUGDQePyH6no6LWPiq7Eae68Gb9idho6aU5y+U2gSVaWfrMb0
	J4/0uoY3tf8zsk+gxoejCzya2bqJdaeXSVbW3nBWTPBbsiE+Nigr5mwllOCs2KN3
	I0w0kK9neOHDtP9FLptXkUAygh9QV2kv2Iy+IseWRShuhebsb6pW0qgYaJkZwAb7
	FF0ubdq+wDl2EnPMbJut3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770973985; x=
	1771060385; bh=KUMlkRqnqZnV42cvKOQ8xGX/GuHUcUvPRs2gd/PSzls=; b=N
	1J45MA2cW/d5w6VJJx4foIrL+8B6vr7A1dNKfM4NblM06i4kCtaOTKwvYo9mOgm1
	ZPD7vGN0wGpidEyHJRm4VclIQv+7dB0YNLlQKESZW4Ctsv0sbJn9nrzjK9Djd/MA
	1ZqZfHHEnOF51tgi+AiaAVWtbgjUXLfc0TgJVeKJWODncy9c3nZbi1iv5bCFbodg
	gmefetnhnSoEb7FgjH7mioyDkdBh/VG8BZOAfXdEkpWoPbgGTpIThRfrmOZ9EbrL
	Q5VifqrCzcYNXG1vPFy0aqh6bHDVKQb8aHIlB9riqoCWLtGgFQr09buxC2LhfMXB
	lA2eGDwkEKSy+WJOP8MUQ==
X-ME-Sender: <xms:IeuOaf_FbqvFO7gj7PhKaqjfW7dpcWRvU40IEH52030jZ27olrEs3w>
    <xme:IeuOaTJf894Z48EAcsU7NUw0pOG2-wrbTwOC5unm7j5uLtmOqLi8-Vdr-3j2Ti5Nw
    03BMgbjZZZ9-lfKP3HhOYOrp-rcoB6tq_WKxvv3EQ6hDAMCH95MvBg>
X-ME-Received: <xmr:IeuOaaZ8vOfooE3l-I5cqeSndHyZ0RL9jKweLte5vvxcmFn6CdfUhWmtfa1M2cF143LtxvhkuDeq0sR6qr2bJzz-3QTtvH8FPChUIlSeLPmp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:IeuOaVK6EMl6unEn8oSzpw8Qf33LMO97Mn_oX9WN1UeQUGkDgETouQ>
    <xmx:IeuOaYB8fu00rAZehcxeNf8WqOP3PqfzZJK9g51ltp4ZqJYbOSrLRw>
    <xmx:IeuOaaqDR5PHaAB-Lit7TirceF2IYiWJbxL8d8ab8rJQduNS4sXfjA>
    <xmx:IeuOaTjVSDDRUrte0BXmk638pxdq94juHSp0EWfOp9r9vQ7oiqTUag>
    <xmx:IeuOafI765zeH2qmyg70XX3s9qa05WFJAZAKtQX678Aw8mVfZx-Qn9fl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 04:13:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ed9fd0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 09:13:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Feb 2026 10:12:49 +0100
Subject: [PATCH v2 3/5] builtin/history: replace "--ref-action=print" with
 "--dry-run"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-b4-pks-history-dry-run-v2-3-756ac376e9e5@pks.im>
References: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
In-Reply-To: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>
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
could of course introduce "--ref-actoin=print-head", but that would
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

