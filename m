Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338E359712
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900290; cv=none; b=AbdGL0ymKkQa3AY0Qzn60qPaX8mMVejGD+QSGUwEAX9l+jb26GMj7kANyrwUs6FObs06to0rp7jzxy9VfstcwvA4RMMqDs9vLCTLZzZ9383OjpuKTLWifiqp7btaF4foL+kTZ8VFpYSNx+RxP77WrQZV9vdlgJI8Zkp6CzkADpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900290; c=relaxed/simple;
	bh=r+UEUaomsDdDDdbrQNs0FCY3u9RM5/kBrNoHLf+0bNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTOdW8517Nj1MS3tQDyw4b+Iry9gMTjmLUmotTSwWc287zeF7nTyxYq/P9RWyEdaa1IwxRMQ+qcEi8iDNBMPcJrI140fZ+4NrBEoK7EBj+xVQOf3F1L3uh6D7tOjW3pkp0Zhv4kHRAyoTJy2x/Cz+isyHD3i8BzkxICaIUT+cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NbN72pWk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1pX2O3K; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NbN72pWk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1pX2O3K"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDA341400171
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:44:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 12 Feb 2026 07:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770900286;
	 x=1770986686; bh=I0oxOyMQJBMQT4WY5kIuWYOog3YSVDGs8h9chWhyX/I=; b=
	NbN72pWkNkS17yvEIEkh9cydzwfPn65uTWagkYKiSoqI4+ZvDJNhavuUSKJlTtFv
	pUTbF4m32GqT83wYkN/6AKtG9uDZ6dM7d+mP0xUCI9TVKn/7uMIizUwVOEAjfNX9
	BjcT56j0RBmK+pf7PfxoWmUpxx8GVQp4ObwPTUBry60XhaLfT3ZHnekZM15JndVb
	fYZiqmAF89brx7EETdj/besaVlh7naTjw9xdcRRY1HCBBSaZfU35VPYNBrOPnvDX
	X5lQSWCQTLrhH1BCCw+FIiEgdidx8jOAlCLNJgLrBGXwUb8LK2idFDP3SFFxPxdq
	fZgKzrJSWXpL7WgV3ZAUwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770900286; x=
	1770986686; bh=I0oxOyMQJBMQT4WY5kIuWYOog3YSVDGs8h9chWhyX/I=; b=Z
	1pX2O3KFgjQHNAzpTp32hER5Q2G2u4eZ2MO1yWUliEI5kDpjjbwo1qhH51bhMJHp
	+8S52sDtdapHJXFM9ILn/lbpNAbqtTjB2cRqN5gHfsdN/bJfB3jbzJcBQ6QIrXqG
	D2QG59KYVNyhEY0ZahfX9S85j9VeG+LL/i1NyT89mNKTM2z2/8M1PX5QRWa+N5R+
	ItPQKK1AsyxOz4yT5oH3h01FHDQxs3ZSFhBGFekp3H8vzxG1KKgF/mmO+IYXGG6E
	I5VhTBo9jUlyf6WckBBgnMag2lJaZaC7vfOp0RYcWGC5wPIhEXdEPaVXQFkxUOsC
	SnuqR8dtUn1Y3XiOUdMTA==
X-ME-Sender: <xms:PsuNadmmw9ZiyP8egiOlgD5D0JPpe4pTD72hTqaisQT-YMYJC0CnzA>
    <xme:PsuNafwU4d1t_K8k2BkIltoDDpiLJjxcaIR7tP6P0-wHC2_TPRmaNo-Ej25vR-j-o
    fYpIDeYG5PYJu1ZqxNHn9NHImL2vRBbzRDZuI8SzPgvSRnNvRWydA>
X-ME-Received: <xmr:PsuNaZTCIg6ydKnrc8xHo40mWuhaMk4rU6zJYc2VGnku7cooYysn9NG2KtC1JHbUftBZdYPDcbjpenporguWzcpr8VpEKi7n6fHJZzEqqyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:PsuNaStSg2Dj5WNINsNjPcrdl_2_w8iKYFs_QCuvMzFChQyFuXHIvQ>
    <xmx:PsuNabuThb72M2mW-bHJomKy7tdhu2bvqiIQLQiD2b26-O2hXUeavw>
    <xmx:PsuNaYzVqD0b_mbcyYfvwpVh1v4NT5fEOH1tztGblyTMbLzJqu43-Q>
    <xmx:PsuNaRi-zURJYDyvC-I5OUQO6driGOuUmBYueYK-VpUkdtapOAojMg>
    <xmx:PsuNaV2CbEV6mu-w_F_52zCpJrl5nfa3UI7uwmArYhMXt5JMxMDFEMd9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 07:44:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d501307c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 12:44:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Feb 2026 13:44:36 +0100
Subject: [PATCH 3/4] builtin/history: replace "--ref-action=print" with
 "--dry-run"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-b4-pks-history-dry-run-v1-3-1ce03d631c1b@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
In-Reply-To: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
To: git@vger.kernel.org
Cc: 
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  12 ++--
 builtin/history.c              | 150 ++++++++++++++++++++++-------------------
 t/t3451-history-reword.sh      |  12 +++-
 3 files changed, 96 insertions(+), 78 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 154e262b76..33353815cb 100644
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
@@ -60,13 +60,15 @@ The following commands are available to rewrite history in different ways:
 OPTIONS
 -------
 
-`--ref-action=(branches|head|print)`::
+`--dry-run`::
+	Do not update any references, but instead print any ref updates in a
+	format that can be consumed by linkgit:git-update-ref[1].
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
index ca0cdb6a58..40e2925cea 100644
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
 
@@ -287,11 +284,29 @@ static int setup_revwalk(struct repository *repo,
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
@@ -313,82 +328,72 @@ static int handle_reference_updates(struct rev_info *revs,
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
@@ -410,10 +415,13 @@ static int cmd_history_reword(int argc,
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
@@ -450,7 +458,7 @@ static int cmd_history_reword(int argc,
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
2.53.0.295.g64333814d3.dirty

