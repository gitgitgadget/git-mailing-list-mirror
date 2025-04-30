Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930C237194
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008719; cv=none; b=s7jTo2A4cByNuXsPTPnO5XJEmcl/Jq5qfeTvtzP0ORVc43/jDkggXE55HZuRToSPN/LqKZrILUoizBIOzv9zdXzmSCHBEWnL2cdyJo85DMnbY6gInbtRB8KM87AbNqjJkppFNmUVAeppsDXzLmPXgBLozbnWGnewGHdjvmEqpRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008719; c=relaxed/simple;
	bh=PDh664u0KiANV65MIPjfYrNErJaXiHjWjSWHaDa8Nuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgCUpdX2ViWm1pTi316Y8XyozydEzDnbRJb0ftaWWwx0/uKr836mimVp8q7wqRJfVre9693nZqIFWlnyJpb/lOnwapwxcU5gH+tZTBeJ1ABz1LLjQALWWLoyQCO/eiw31J9VFEd+tgPPcyIBLwERJChUxGirpB7UdDqvHpnalOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rJcZOZ02; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frC4SOLC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rJcZOZ02";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frC4SOLC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 872B411401D2;
	Wed, 30 Apr 2025 06:25:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 30 Apr 2025 06:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746008715;
	 x=1746095115; bh=mg4yEuJRUykYeG0GyzLl31cRTFVwK87DKf1CFZfSFSg=; b=
	rJcZOZ024vzlVZY/8BQshPqYlt/agrVNQBsES806bmxsfBnfXTujjmtJPReX7Erd
	eBbc1YTfPbQYE0NwyMeuE9hgv8MqZGsqqNM7JGZzKeI/C1s7N2k65ii2hXiRk44P
	4K/oBFRYKuU/a437tYdpkZx0oL1I3tkd+HNBCBkyQ3Ilr/bVaLcaN2boEq6zUZMR
	/vMAwUwFsh4qCCzFnI2P5MhWDOO9rjPD3G9KEK9ca266lvrYn4mIul0Ftxzh6omk
	qcaBAmZZ/cAgoa/L67uQQgJWiIKf6KMMws8TEx8Ex7YKGD747xGYXJ61VaNpnxDL
	7FhbQF+aMrPCTuIX7DNnXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746008715; x=
	1746095115; bh=mg4yEuJRUykYeG0GyzLl31cRTFVwK87DKf1CFZfSFSg=; b=f
	rC4SOLCyqUNY5GqG4pnCPcMmhihg4rHoAs9xo0Z1j9WW6amXRBZxbA+dL8Gj4qSn
	sJLBbbM2+8PZvEEblxPpTZz9IFm0JUUEJHqS1w2SuU4pv7LPFepkdyIs0XB55tNG
	k0hWvWPcvHqTbG1evrgr6F1fZK/eevK/+mqd3IxYJ0seVGKvXU5rl30N5e3MJGiR
	297e1TrS1K8e6wakzTC5FjTv/bCUYtRQGl3dx+vmJDeccLJ+3uK9AfIngBonQRAI
	zy/SoxLKyyZNIX5UrdRko+XCufJFujVvHVY5VQDMZSJmhkDlFqT2XKnh1NedXHi2
	Yg0PSLCUSYhGra6Rl9Rzw==
X-ME-Sender: <xms:i_oRaOKze4k2i-eiHM4gFl4ImWzewranO75W37ZN54bTHhD7Djg1_A>
    <xme:i_oRaGK_lsX47rePNjq9Ykob1U7LJMN5opxnsugeo38DW2hbFW5h496FBmyYn9Aco
    iPXiiJkUqqh5pxVNg>
X-ME-Received: <xmr:i_oRaOvg2fLIkgZQFt6HmPDsOfZWSC4SQBbKjRkhNowD3d8G0AxfWHVctazEXoiMPxWMgBnx1rWdtG92YzZt9DNrQBfClZY9xfkXAFZjWQtlvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:i_oRaDZSX44XWHVuzPf_Vikibo9fzYjKX7vvh51Po809LfrDamFY9g>
    <xmx:i_oRaFZJfhy3493LzVV5kg8SFVaeJexc41ErQkxh7nzm9pQwyJlOSA>
    <xmx:i_oRaPAZ10eZq8FxkWIwWdfw9PPVNWC_z5uk-i3qicQ4Y4ZPgcKkQw>
    <xmx:i_oRaLY8wVNqM3j2j_vMzMiXQ_-yBdXGwwdoCE3wPS3aPRr0-GccSw>
    <xmx:i_oRaM13PnZsG5YVcKeli1uSv-rtZZnRo1fMATXzmgvLTTwOp0yn6jLZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 06:25:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 636e7b1e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 10:25:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 30 Apr 2025 12:25:06 +0200
Subject: [PATCH v2 2/8] builtin/gc: remove global variables where it
 trivial to do
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-pks-maintenance-missing-tasks-v2-2-2580b7b8ca3a@pks.im>
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
In-Reply-To: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
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
2.49.0.987.g0cc8ee98dc.dirty

