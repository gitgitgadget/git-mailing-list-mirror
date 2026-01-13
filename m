Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7C3803FA
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298095; cv=none; b=OHMiftEfz/gRYpxNn76d9n/gIX1Tie2shMhgMDvP9hakIWuuke/YihQBVAXqKN+brDT5ovyQ7S9O7q0r/jwFeWQafEhvqeR5sI9w+UpoQXf5Pk3pqEt0O6wYX4RpLnxz2tr6i3soNWhB5UTLNE9nWcLepEKsW8KadsWFK2etGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298095; c=relaxed/simple;
	bh=T6gZ4T6fjlrKIvtZbj1dBaiuPFXhfZPomTpC0eIkRDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PE5Am7anzrNBdW2UzyJS1/jLMqNFSaMFlLI6CjaoeVFmNU5uGidmt0owuopydcxaAmIePuH3YQd1q8n9fUXbwcdxqkGA3z0NeUYbA4iPNv1nn4raq/Ua+b4CyMHg6cXhqUlI4ruQ8+BGnW5kc/G5u/xK8Y3D4khOMPGcVepsnjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GxiAud+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IARR3U1S; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GxiAud+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IARR3U1S"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 536B4EC0231;
	Tue, 13 Jan 2026 04:54:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Jan 2026 04:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768298093;
	 x=1768384493; bh=aHoPTF6qCwBN6WBPszpV5A2QWJoqKp99j1SjtDdYylQ=; b=
	GxiAud+BMAYUuuM2srQzRXyKl8QxpHCqe6HWQOotegetC1gnaeJLPlonjEKb7nio
	r6Lwb3UCsd97gv9PfIZj3pWPqhBjsgDMMIprs9J4urEpiMSLqkHslPzN3+Za5OkJ
	p+1jTpI7XNyzzsJ3nfA+K+wS7v4mMUxT//PM99SJb/2TWYlXrmwOQI+aSYuoRwoC
	sFAfaDh3atGdtcQ3g+vlYzOccRexDB6JsntHYxF3s7fktnXUkk1iKZXaWyfnqQ8B
	X0JeoxFN7qAZeuYaZEd+SgzyJ1VZLsNzW5Jin/lvbdQPCyLlKltF8YSuAoIqNJpZ
	38fC20ryU+Pk8puVYyqK7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768298093; x=
	1768384493; bh=aHoPTF6qCwBN6WBPszpV5A2QWJoqKp99j1SjtDdYylQ=; b=I
	ARR3U1SvvKFoUKzJJ3wYzUp2Ap1X6paz+LhIUpDViMLTSwuK72e4M3vLfLuTp4PS
	17IExz81nO1TEdbtFeGIb9OV6Z58ubUmxE/G94WdWf1sGcUM9Rp/UDzCDz9G/xZX
	6dJzbFFF3xI6xIJ++dXaL8k+Von5YnPO6gmoIl/deYHVMGYSeMTJKLs99wy0YuF+
	lxDpRt+lPORU1wPmnC+z2k/hNL9qiesVgqEXMrfbLTWU88+XDT5Uvby1ep+bSxxB
	FE6gE/zY/PZVZK92OZ1OPY1cmCH9F75dgyevLmOWIyGEE7Ug0PU2GLYioyLRkO1v
	g+rRLDHGq+pC5kJg8Obww==
X-ME-Sender: <xms:bRZmaRbfiMsTPVvB2bkRfIxNk4gFoGRh1DTcUpLNlKaqqbq6b9IEWQ>
    <xme:bRZmaUMrLhuQRgfkcRz4qLpALryQ1FfwAf9GbKSF8eu0V9x5b4LttXiauJ8mR6Efh
    Da8ynb5c6fC7VDZX_UyqQX9t-KbqCFXN7ZTuV0zbjpnOPk6bt5JFw>
X-ME-Received: <xmr:bRZmafXWm9F4m6N4yJUnm3xbKbsV3TAe5eNk025aMIb_gw6GyPgZeSyOqyx59BNHGkBC1DZraXrlm8wgQPRSXpDnuxLFM4F6TOCcukPLxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bRZmaZLhBBVdr8DDsDSpdkGNVKQetYU_60w025cjiTS-bOjWl81xYw>
    <xmx:bRZmaarN3yr6tMWjDCXluN9GQPNrREjwgnDFzU8zSypR1gCcTp5Hkw>
    <xmx:bRZmaQwfyIPbs9jffAwhstXO_VuPwEjnpFjG9h4Vac8rXV0jVd7UTA>
    <xmx:bRZmaesNw7iHikW9seYHyrlQ5Paj8mKII8OLtPWxE61h1IaU-G1vBA>
    <xmx:bRZmabZt4s4J_NaQllC5q6TsIhkwDKCagZPUYcGj1CES2IWkMJP67LnR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 04:54:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44daf021 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 09:54:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Jan 2026 10:54:36 +0100
Subject: [PATCH v11 5/8] replay: support updating detached HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-b4-pks-history-builtin-v11-5-e74ebfa2652d@pks.im>
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

In a subsequent commit we're about to introduce a new git-history(1)
command, which will by default work on all local branches and HEAD. This
is already well-supported by the replay machinery for most of the part:
updating branches is one of its prime use cases, and the HEAD ref is
also updated in case it points to any of the branches.

However, what's not supported yet is to update HEAD in case it is not a
symbolic ref. We determine the refs that need to be updated by iterating
through the decorations of the original commit, but we only update those
refs that are `DECORATION_REF_LOCAL`, which covers local branches.

Address this gap by also handling `DECORATION_REF_HEAD`. Note though
that this needs to only happen in case we're working on a detached HEAD.
If HEAD is pointing to a branch, then we'd already update that branch
via `DECORATION_REF_LOCAL`.

Refactor the loop that iterates through the decorations a bit to make
the individual conditions easier to understand.

Based-on-patch-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c                 | 47 +++++++++++++++++++++++++++++++++--------------
 t/t3650-replay-basics.sh |  9 +++++++++
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/replay.c b/replay.c
index 6680d50bd7..94fb76384b 100644
--- a/replay.c
+++ b/replay.c
@@ -150,11 +150,17 @@ static void get_ref_information(struct repository *repo,
 static void set_up_replay_mode(struct repository *repo,
 			       struct rev_cmdline_info *cmd_info,
 			       const char *onto_name,
+			       bool *detached_head,
 			       char **advance_name,
 			       struct commit **onto,
 			       struct strset **update_refs)
 {
 	struct ref_info rinfo;
+	int head_flags = 0;
+
+	refs_read_ref_full(get_main_ref_store(repo), "HEAD",
+			   RESOLVE_REF_NO_RECURSE, NULL, &head_flags);
+	*detached_head = !(head_flags & REF_ISSYMREF);
 
 	get_ref_information(repo, cmd_info, &rinfo);
 	if (!rinfo.positive_refexprs)
@@ -269,12 +275,13 @@ int replay_revisions(struct rev_info *revs,
 	struct merge_result result = {
 		.clean = 1,
 	};
+	bool detached_head;
 	char *advance;
 	int ret;
 
 	advance = xstrdup_or_null(opts->advance);
-	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto, &advance,
-			   &onto, &update_refs);
+	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
+			   &detached_head, &advance, &onto, &update_refs);
 
 	/* FIXME: Should allow replaying commits with the first as a root commit */
 
@@ -312,18 +319,30 @@ int replay_revisions(struct rev_info *revs,
 		/* Update any necessary branches */
 		if (advance)
 			continue;
-		decoration = get_name_decoration(&commit->object);
-		if (!decoration)
-			continue;
-		while (decoration) {
-			if (decoration->type == DECORATION_REF_LOCAL &&
-			    (opts->contained || strset_contains(update_refs,
-								decoration->name))) {
-				replay_result_queue_update(out, decoration->name,
-							   &commit->object.oid,
-							   &last_commit->object.oid);
-			}
-			decoration = decoration->next;
+
+		for (decoration = get_name_decoration(&commit->object);
+		     decoration;
+		     decoration = decoration->next)
+		{
+			if (decoration->type != DECORATION_REF_LOCAL &&
+			    decoration->type != DECORATION_REF_HEAD)
+				continue;
+
+			/*
+			 * We only need to update HEAD separately in case it's
+			 * detached. If it's not we'd already update the branch
+			 * it is pointing to.
+			 */
+			if (decoration->type == DECORATION_REF_HEAD && !detached_head)
+				continue;
+
+			if (!opts->contained &&
+			    !strset_contains(update_refs, decoration->name))
+				continue;
+
+			replay_result_queue_update(out, decoration->name,
+						   &commit->object.oid,
+						   &last_commit->object.oid);
 		}
 	}
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 307101eeb9..c862aa39f3 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -249,6 +249,15 @@ test_expect_success 'using replay on bare repo to rebase multiple divergent bran
 	done
 '
 
+test_expect_success 'using replay to update detached HEAD' '
+	current_head=$(git branch --show-current) &&
+	test_when_finished git switch "$current_head" &&
+	git switch --detach &&
+	test_commit something &&
+	git replay --ref-action=print --onto HEAD~2 --ref-action=print HEAD~..HEAD >updates &&
+	test_grep "update HEAD " updates
+'
+
 test_expect_success 'merge.directoryRenames=false' '
 	# create a test case that stress-tests the rename caching
 	git switch -c rename-onto &&

-- 
2.52.0.590.g1f87b77810.dirty

