Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03451259CBD
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771224358; cv=none; b=GkM2oLMRXoJ9s1ClyHKAhGD23RAEqRJ1lSDLE3PobTMR9HXm+sycA3qmj68qDLDlV3onb3KZZhzlpGEle/A5tDOgqMvkbgnx7Ts6ote34HJIKMsSH0ayQrFbNs/P23UoY5x1ICgRz+1u9VAijB6d8yVYrSx0J/ce8lZeckk36F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771224358; c=relaxed/simple;
	bh=13dNhh3Kk/S1eOdnQ7mBgiL+VJwf7FzlkqPkSX514JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QudayIC9Qkzz+WhnHhvN2ukvdjfhmsMD2dAZOBYHSnb73otl6sp8saRUD3D3QvkV5J/6cBC5BY6ffYYGjAc6/BqTDBVswTar902QBVcDtB2QQnAydWrAJtXZnB4OSPANKLUYXH3E33jUu2RM3ROa/pUtYdKbOMnYxlGJblbFSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oNd3Du5R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2TxHx8r; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oNd3Du5R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2TxHx8r"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A0C21D00221;
	Mon, 16 Feb 2026 01:45:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 16 Feb 2026 01:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771224356;
	 x=1771310756; bh=deh3epuz58yf1W5YaI8OipNDj5QLBPc/zHkZN3+oRBc=; b=
	oNd3Du5RPCjvTkutB51/lebzUBBnyAv3zSrxdIbHlkojxYddWYjfC3xP8dP6qAhM
	Oaxmb7rjs4yaCIvj0hHqPlpZ5dR1AUYtdTghoiLILlmD+Wg2tXNFLwigxdJoX5TB
	icENlPDCe53XoejzXz4Dogx/GME3GQdHHSukX6uGorVud/WG85Cdnq2b1XpZQnUS
	BMTTHC+TFWtzwW8anPPKQaj4Y7/5G3oSysi3GM0y67AcPza7sDZQJRYqmZdPX6e9
	zAMO4BiZtiFSQdUvm8TCzP5y0KZbhPggVGbDoBYlZPUJl8IrXIjHPeL3Ge1mcl14
	OqmU/niPC+6egmHT6OOWFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771224356; x=
	1771310756; bh=deh3epuz58yf1W5YaI8OipNDj5QLBPc/zHkZN3+oRBc=; b=T
	2TxHx8rbJGXan/IUHUSUxohzc85Md/ZcxczURkPQOUxSfs1I9XIQJFuhiNi6G5pm
	mDa4QusHRuwSHEV8aF5m63BanhX9QG/O2LDg99tVETcNiwSRe1PQ1eDmWQE9M2V1
	Ut2QqZJcHx6rslVoKU3fL/YDMFNXz9/uNvOnievXWteUzQoqJgwLTmmllvD6vEnP
	C5muhWnW0fUyA8r9DbIefVYIW9sgk0igYRL6+p5dmCfT74B4hEKPV+WLiWvEi4Ef
	5BehsyuS3fILIgFYRybWA7zG/iNcVRdNWnLKSAAFySiLYaD8wOkhRuSKt+aP4sTf
	XNbxbMN+jRp0xoOqnz8ew==
X-ME-Sender: <xms:JL2SabXdUEFUTANozi5FNYHjYpHKrZw-gNogjYL2lZLQkl-bAZ2DeQ>
    <xme:JL2SaanEqTIFXfcdIiAyw_KGiAq1S3N8LDQQRN6E_oGfrnkSI_w_yFTtNttBnm6OM
    r3PEx_2T2YENg8HHLzFhLl5HNTvoaHpmgZWiyhDSms1JzTS6P18>
X-ME-Received: <xmr:JL2SacafrmA-2navR55FcocG_Bfdgwrd-c8AMyTA2VAmOxZesBPXrirNDztZ27RSigMhQ8BvqIVL54MltSfMQLCSCria4RnUlOpxZI-ggg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:JL2SaVP5jeW04jX9zpEgJP_vM8nlZA_3-vxtSYwskP0mFOBg34VUhQ>
    <xmx:JL2SaRbwOMt8Qr-DUc7MXpr_qZaYSRA787RiOqQynSRJF6Q225hq7A>
    <xmx:JL2SaT1L0GVpsXIpjrCZjpyGwBM_kpJ7yyJBGAHlRoczShPCcFABpw>
    <xmx:JL2SaXfqb0fs7U4wzLYSqO0gxsPEB_lrxt6bPB_tqD1J3D9iofnMMg>
    <xmx:JL2SaX75ZqS0j8eMIvizQrtZV2UV_aBQOjzGEezWxotzx4QOwN0GL9f6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 01:45:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0bde34c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 06:45:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Feb 2026 07:45:44 +0100
Subject: [PATCH v3 1/5] builtin/history: perform revwalk checks before
 asking for user input
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-b4-pks-history-dry-run-v3-1-c4db58a651fc@pks.im>
References: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
In-Reply-To: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

When setting up the revision walk in git-history(1) we also perform some
verifications whether the request actually looks sane. Unfortunately,
these verifications come _after_ we have already asked the user for the
commit message of the commit that is to be rewritten. So in case any of
the verifications fails, the user will have lost their modifications.

Extract the function to set up the revision walk and call it before we
ask for user input to fix this.

Adapt one of the tests that is expected to fail because of this check
to use false(1) as editor. If the editor had been executed by Git, it
would fail with the error message "Aborting commit as launching the
editor failed."

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/history.c         | 69 +++++++++++++++++++++++++++++------------------
 t/t3451-history-reword.sh |  2 +-
 2 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 8dcb9a6046..1de51372ea 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -177,30 +177,15 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
 	return 0;
 }
 
-static int handle_reference_updates(enum ref_action action,
-				    struct repository *repo,
-				    struct commit *original,
-				    struct commit *rewritten,
-				    const char *reflog_msg)
+static int setup_revwalk(struct repository *repo,
+			 enum ref_action action,
+			 struct commit *original,
+			 struct rev_info *revs)
 {
-	const struct name_decoration *decoration;
-	struct replay_revisions_options opts = { 0 };
-	struct replay_result result = { 0 };
-	struct ref_transaction *transaction = NULL;
 	struct strvec args = STRVEC_INIT;
-	struct strbuf err = STRBUF_INIT;
-	struct commit *head = NULL;
-	struct rev_info revs;
-	char hex[GIT_MAX_HEXSZ + 1];
-	bool detached_head;
-	int head_flags = 0;
 	int ret;
 
-	refs_read_ref_full(get_main_ref_store(repo), "HEAD",
-			   RESOLVE_REF_NO_RECURSE, NULL, &head_flags);
-	detached_head = !(head_flags & REF_ISSYMREF);
-
-	repo_init_revisions(repo, &revs, NULL);
+	repo_init_revisions(repo, revs, NULL);
 	strvec_push(&args, "ignored");
 	strvec_push(&args, "--reverse");
 	strvec_push(&args, "--topo-order");
@@ -224,6 +209,7 @@ static int handle_reference_updates(enum ref_action action,
 	 */
 	if (action == REF_ACTION_HEAD) {
 		struct commit_list *from_list = NULL;
+		struct commit *head;
 
 		head = lookup_commit_reference_by_name("HEAD");
 		if (!head) {
@@ -250,20 +236,47 @@ static int handle_reference_updates(enum ref_action action,
 		strvec_push(&args, "HEAD");
 	}
 
-	setup_revisions_from_strvec(&args, &revs, NULL);
+	setup_revisions_from_strvec(&args, revs, NULL);
 	if (args.nr != 1)
 		BUG("revisions were set up with invalid argument");
 
+	ret = 0;
+
+out:
+	strvec_clear(&args);
+	return ret;
+}
+
+static int handle_reference_updates(struct rev_info *revs,
+				    enum ref_action action,
+				    struct commit *original,
+				    struct commit *rewritten,
+				    const char *reflog_msg)
+{
+	const struct name_decoration *decoration;
+	struct replay_revisions_options opts = { 0 };
+	struct replay_result result = { 0 };
+	struct ref_transaction *transaction = NULL;
+	struct strbuf err = STRBUF_INIT;
+	char hex[GIT_MAX_HEXSZ + 1];
+	bool detached_head;
+	int head_flags = 0;
+	int ret;
+
+	refs_read_ref_full(get_main_ref_store(revs->repo), "HEAD",
+			   RESOLVE_REF_NO_RECURSE, NULL, &head_flags);
+	detached_head = !(head_flags & REF_ISSYMREF);
+
 	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
 
-	ret = replay_revisions(&revs, &opts, &result);
+	ret = replay_revisions(revs, &opts, &result);
 	if (ret)
 		goto out;
 
 	switch (action) {
 	case REF_ACTION_BRANCHES:
 	case REF_ACTION_HEAD:
-		transaction = ref_store_transaction_begin(get_main_ref_store(repo), 0, &err);
+		transaction = ref_store_transaction_begin(get_main_ref_store(revs->repo), 0, &err);
 		if (!transaction) {
 			ret = error(_("failed to begin ref transaction: %s"), err.buf);
 			goto out;
@@ -343,9 +356,7 @@ static int handle_reference_updates(enum ref_action action,
 out:
 	ref_transaction_free(transaction);
 	replay_result_release(&result);
-	release_revisions(&revs);
 	strbuf_release(&err);
-	strvec_clear(&args);
 	return ret;
 }
 
@@ -367,6 +378,7 @@ static int cmd_history_reword(int argc,
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct commit *original, *rewritten;
+	struct rev_info revs;
 	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
@@ -385,6 +397,10 @@ static int cmd_history_reword(int argc,
 		goto out;
 	}
 
+	ret = setup_revwalk(repo, action, original, &revs);
+	if (ret)
+		goto out;
+
 	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
 	if (ret < 0) {
 		ret = error(_("failed writing reworded commit"));
@@ -393,7 +409,7 @@ static int cmd_history_reword(int argc,
 
 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
 
-	ret = handle_reference_updates(action, repo, original, rewritten,
+	ret = handle_reference_updates(&revs, action, original, rewritten,
 				       reflog_msg.buf);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
@@ -404,6 +420,7 @@ static int cmd_history_reword(int argc,
 
 out:
 	strbuf_release(&reflog_msg);
+	release_revisions(&revs);
 	return ret;
 }
 
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 3594421b68..6775ed62f9 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -263,7 +263,7 @@ test_expect_success '--ref-action=head updates only HEAD' '
 
 		# When told to update HEAD, only, the command will refuse to
 		# rewrite commits that are not an ancestor of HEAD.
-		test_must_fail git history reword --ref-action=head theirs 2>err &&
+		test_must_fail git -c core.editor=false history reword --ref-action=head theirs 2>err &&
 		test_grep "rewritten commit must be an ancestor of HEAD" err &&
 
 		reword_with_message --ref-action=head base >updates <<-\EOF &&

-- 
2.53.0.352.gd1286b26eb.dirty

