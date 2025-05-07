Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9E218EA1
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602511; cv=none; b=mWY4EQav72e0krKtJlSlALdWp+lPuvxHRzpD7zzJG2so3xDHLc2S4uC8epKiIeSLzFSKC6ohR/naVngDjs3khIgaN0rhzl5ThiYdm3ATwbIQSaq/b0AbJM3G8fO4tWfzwzyW1N/N8E9qFzqPcj+kuFxpx3ir/kdZRMyhZ3gja8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602511; c=relaxed/simple;
	bh=G1YnYs22YKL3x9oDMuJWJzOzRVwM+tubh10Mzw+plR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I92XBaWnleUc1TeJLK3aJwckH6xKBN3MrKM16tujc9h4EhN+LKjYgVyIHBo2VTcsi3zm9IJjn7jjgi4j0gJ0fHjtRUL5RowbYO4RTnzeymo0dr1R20V1co/xdzyuxKK1z1VkUmAMVjcg6yb026+fZWE++X+Efj8VR/9DcuLkraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kJpynyVL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ajBAkho6; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kJpynyVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ajBAkho6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B15225400DA;
	Wed,  7 May 2025 03:21:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 03:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746602508;
	 x=1746688908; bh=BAXBSyoIPzn37MTJYxnNL5ggZd20YnEYXfeQ4hfu6Y4=; b=
	kJpynyVLputgW1tmx8bXwUBVocHr8eGWqG7rz57ElByOp+k6dX/5jyOLAIWqIygJ
	JCmAvNjmwN0H39W1iYyFuz1IIhyLmzv5sBAqYdnE9NZBgGNNF4K8ZTXSTK5U8qLU
	xvjQXxVQOZEPVwG4mvVG+mvI/G9cG9fM2wje/BnAGvbjGZVA/s9M/5xBN9Sh+IoT
	bw1wfY6QiqHcFndj3rNEaVfNG59spPl19CBQcABKiVLODdtD0m/6JG1r4JDy1Wp1
	b6FP+oQVBtZ2Y9CF8ocA1EFlao/+2C+t+gXXwLxfnNQnphghg5Xerp4UPDTW9OV8
	aE5KCTcsfYRBP7Jb/aySbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746602508; x=
	1746688908; bh=BAXBSyoIPzn37MTJYxnNL5ggZd20YnEYXfeQ4hfu6Y4=; b=a
	jBAkho6Et+7u88XMc+NG63aCIYOi+7i69sNNn7Z+GR1Izo8a7erM+DUSLxMVsr8Q
	hpC/Qty9jY2wOReF5KxZ+up000+LjbVAIl/jKF8bNFQEdlaQzVqhjeU3ZAaU0LT4
	3TjVkLFaHnCiFUMlAVfSMf1l5wEHYFvIttagluLQXR3ppQxkMU3u8LR0yrOMfENp
	2ENQCGjA3+o18Z2A3gDqKTrA5YFC3Is8Y9mz9Mpbhu/qo/6Ew0hu/NHsJfuuq2fL
	WX5ONbganjwUa3lWx7ZbFRualJMcvYPBLJu7ai5Gad+zf7zbshIDbVAgxTHA6ak6
	AEAc2aOs/euAf+4tIpuTg==
X-ME-Sender: <xms:DAobaKpSaDkuEL_FtY8cCWwnfAxhY_AokET1JLtCadeDVGRFuoGabQ>
    <xme:DAobaIoKXhQ2WqA_0zmJzHPcxeiEl6jn1pLK8r6wINBXJ_2qUedxHCIW38TCXG987
    LDo0Ge-neU_g1pT_w>
X-ME-Received: <xmr:DAobaPPQGoTEhpdTxFXvMXubcR743zdBEk-piLvnNp6m9srWY4k6i2D1tf7kBg8U3a_Agi6lhzTEdKF-ZAFqO6NhJ-V55hCeqqYwN71coPdYqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:DAobaJ61DPYr1T6Y_jOaNzm-IUokne7yOb3M5ja3Da5cx0VUGXXu0A>
    <xmx:DAobaJ4Mgdxlqe7Q9XD6Vi9D5Oezh7vUQuOAYbs_LJzjxMe05ctFFQ>
    <xmx:DAobaJjv1vqNPRnDmDrQwuygZNYzilDMq6uwbnYkehCaN1rSFT1Ugg>
    <xmx:DAobaD4lhAvcy9onCRTJNVtdR5blXxDJuyjjMGNb1r01vaSTOv3dvA>
    <xmx:DAobaJsAusQ37-Yki4ebDDf6tIfKyIcM35csUfHFD6WnYFNmxGDqfuWg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:21:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61f12a54 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:21:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 May 2025 09:21:38 +0200
Subject: [PATCH v5 2/6] builtin/gc: remove global variables where it is
 trivial to do
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-pks-maintenance-missing-tasks-v5-2-aa5fdfb82891@pks.im>
References: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
In-Reply-To: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

We use a couple of global variables to assemble command line arguments
for subprocesses we execute in git-gc(1). All of these variables except
the one for git-repack(1) are only used in a single place though, so
they don't really add anything but confusion.

Remove those variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a73ec22fb18..ada36e210f0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -53,15 +53,9 @@ static const char * const builtin_gc_usage[] = {
 };
 
 static timestamp_t gc_log_expire_time;
-
 static struct strvec repack = STRVEC_INIT;
-static struct strvec prune = STRVEC_INIT;
-static struct strvec prune_worktrees = STRVEC_INIT;
-static struct strvec rerere = STRVEC_INIT;
-
 static struct tempfile *pidfile;
 static struct lock_file log_lock;
-
 static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
 
 static void clean_pack_garbage(void)
@@ -769,9 +763,6 @@ int cmd_gc(int argc,
 					 builtin_gc_usage, builtin_gc_options);
 
 	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
-	strvec_pushl(&prune, "prune", "--expire", NULL);
-	strvec_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
-	strvec_pushl(&rerere, "rerere", "gc", NULL);
 
 	gc_config(&cfg);
 
@@ -897,34 +888,36 @@ int cmd_gc(int argc,
 		if (cfg.prune_expire) {
 			struct child_process prune_cmd = CHILD_PROCESS_INIT;
 
+			strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
 			/* run `git prune` even if using cruft packs */
-			strvec_push(&prune, cfg.prune_expire);
+			strvec_push(&prune_cmd.args, cfg.prune_expire);
 			if (quiet)
-				strvec_push(&prune, "--no-progress");
+				strvec_push(&prune_cmd.args, "--no-progress");
 			if (repo_has_promisor_remote(the_repository))
-				strvec_push(&prune,
+				strvec_push(&prune_cmd.args,
 					    "--exclude-promisor-objects");
 			prune_cmd.git_cmd = 1;
-			strvec_pushv(&prune_cmd.args, prune.v);
+
 			if (run_command(&prune_cmd))
-				die(FAILED_RUN, prune.v[0]);
+				die(FAILED_RUN, prune_cmd.args.v[0]);
 		}
 	}
 
 	if (cfg.prune_worktrees_expire) {
 		struct child_process prune_worktrees_cmd = CHILD_PROCESS_INIT;
 
-		strvec_push(&prune_worktrees, cfg.prune_worktrees_expire);
 		prune_worktrees_cmd.git_cmd = 1;
-		strvec_pushv(&prune_worktrees_cmd.args, prune_worktrees.v);
+		strvec_pushl(&prune_worktrees_cmd.args, "worktree", "prune", "--expire", NULL);
+		strvec_push(&prune_worktrees_cmd.args, cfg.prune_worktrees_expire);
+
 		if (run_command(&prune_worktrees_cmd))
-			die(FAILED_RUN, prune_worktrees.v[0]);
+			die(FAILED_RUN, prune_worktrees_cmd.args.v[0]);
 	}
 
 	rerere_cmd.git_cmd = 1;
-	strvec_pushv(&rerere_cmd.args, rerere.v);
+	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
 	if (run_command(&rerere_cmd))
-		die(FAILED_RUN, rerere.v[0]);
+		die(FAILED_RUN, rerere_cmd.args.v[0]);
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);

-- 
2.49.0.1045.g170613ef41.dirty

