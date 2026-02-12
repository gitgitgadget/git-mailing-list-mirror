Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634D3596ED
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900285; cv=none; b=uQyQmXXsEpeQMppedIKcpMLS6RGfQvCxfey52NR7URgZp5AGHT6A1XW8390gJLJHdpfLx+2mGnkTWDLW1awzDuOC0vRcR8UZzFK9EHjLD5JGLiS1DMaq/0xKPjHeVJ/x6ZlCvf6+8hfHhPzz9jtRV8rfY29IpQcVeI71rJny3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900285; c=relaxed/simple;
	bh=6VTt/qH1/LFkPJ9EmM3M+jDoScL/XqdLwdD1OFdX9/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4Ss1eXCTNeyZ8icE9X2SoaSh4FmrO0pUo9tz7DIl5jfneV1mZ6SOrR7T0dfOF0QpH1/9UuoN2HiuaQSIEGhWzlvB2roFic+i9K18RxSpV2PL8R0Mt+vSj+lBBK2RVo9L0ZkOkOabFbdxV4t7vRtZxAChdafvLf16sfq5+AahFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BCt5KlzP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hA1SkL7F; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BCt5KlzP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hA1SkL7F"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 48575EC0647
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:44:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 12 Feb 2026 07:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770900282;
	 x=1770986682; bh=ysSK+xg2m1S8vjF87k016BKoEKnsqYtjC7iO4R9cL08=; b=
	BCt5KlzPKp3r+9HHWEOy03/uEvd6MH1VTyNqZ5Efn0+dCZe5FJ+ezFmQ4iXeOrSq
	utVBzgoNvcLcMuTcEKsqFJZOerRKuuC03yjDTRudRF13t40RerFTxICsAeG5bco0
	b+p7awY/q9Gi5MIaZ+FUCankQBAcnLY8RIhfU4iPOTUq69c8gqqL8Hopn4kb3zv/
	q26/0tViFqj5ALexwo2ChRFIHwSLgAzkWbVpC9/fJQiF991GTHw8/3maArN9lH/l
	4Fkzysp4XU4loNbzxLA2k1Sto27uEfGwSIJtw2wcbkasQC83w34YS/oSssPqFmaX
	Kb92QKgC9qq/N2Rdt2GpKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770900282; x=
	1770986682; bh=ysSK+xg2m1S8vjF87k016BKoEKnsqYtjC7iO4R9cL08=; b=h
	A1SkL7F8WdI7xj7zokl4jXs38HMDi0KOQDEar/KceBeaEqd0puiHP/NX5ye6e+EM
	oKjiQrBqEVOub1joafq+wJONuG22CD94jyEZt4RZiEecgJkGCJHRnFHeeAR2/737
	vq6hzCj7AsYB/FSJKA4Rmxk8znxZdh7fN/NBAG9vP7oFgmfGAgLJ+fuV875fTMwa
	qoiy6FCmewxNy1FHx/dgbUZldblYogo1mM1iab2201bqOuRvqMoIomE1QJ7aEuzS
	RE6vQ68qFsb29wqHuwR9sc867lpck4LHkVlIVVELJ2ya6IGl4KKI+YeJibVD9ZJG
	+qoB0kpazxDbHFowry5Yg==
X-ME-Sender: <xms:OsuNaSSqPB0NXwUDaxSmLz6kbU5Gcr2xgRA_Dh_qJGGWKLoauID0uA>
    <xme:OsuNaevdgKsLhs0BfHzxL7PN4A0uoJNhK1B0WAsXlKqzRjJZLdIpVXhpgYMWJ5ZUa
    0PeE19wsrIHRjA0ErALH9Il1U88F3yTujZCY8Rqg-SA-cVmvTS1Ow>
X-ME-Received: <xmr:OsuNaVcKBqj009DDMHBFPsUxxACkt4upTYq8eawqi0FVqd8qVQ472k5SSWzwbyj3EaGexXNK0p6h0bi6vgFBxfEPPPuq5oNFWpYXI0Ubvr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:OsuNaTIShlrp_S7Z_9UnTlV-hNvf3EbRslJanJA2d4LTWY5XaCltDA>
    <xmx:OsuNabagq8KmEs1HVKgo0zFnUIN0zqug2jJmkqZK12wIki959ECeSQ>
    <xmx:OsuNaWve6dLG4gkebZAHlAYS9hr1HOcjR7wt5b4RlPBlv5h5WT_ngQ>
    <xmx:OsuNaQvfCs-jvOoUhT6FrREt6qTqzv6Axkj1e-8LRQL-Tpj86vF-qg>
    <xmx:OsuNaSRSy2inkAV89sqwEnqlJPJ6aX5jIytXlNOgH-JSWCt8KvHsK9at>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 07:44:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52e55d50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 12:44:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Feb 2026 13:44:34 +0100
Subject: [PATCH 1/4] builtin/history: perform revwalk checks before asking
 for user input
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-b4-pks-history-dry-run-v1-1-1ce03d631c1b@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
In-Reply-To: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When setting up the revision walk in git-history(1) we also perform some
verifications whether the request actually looks sane. Unfortunately,
these verifications come _after_ we have already asked the user for the
commit message of the commit that is to be rewritten. So in case any of
the verifications fails, the user will have lost their modifications.

Extract the function to set up the revision walk and call it before we
ask for user input to fix this.

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
2.53.0.295.g64333814d3.dirty

