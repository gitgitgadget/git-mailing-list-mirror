Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F43822D780
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566167; cv=none; b=ojspJkxoGEnA9kvNoAFYgng68OFi8u1EtosIoFZfWwrqjlg3caJnqxF+4AdVtTmU/yNDEkdFuvzgDyxxpOHSApc2UGA/L9raV3TFryfJzeVjBT9rWxPLG8iJHc8nPaWKfbhmYkGFXsEDm5yX+Qw5o9eBdUZ2Mw0pqq7PUjl7slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566167; c=relaxed/simple;
	bh=OWH5kt7R5ihIh3QmcR7SFmg/XiKhlvX+YGPJtCpQzuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYkp6Mp3FyHBoYCQIYq3GgO47S4rKWsmbbMeLVTfWsJB1tu0c3762hKLo7uIpgTx0QuB1cbaHigsUiiECBpYp+am2enwg7hrFUQ2t99noDKErBEoqIWCAu98Pn/Xl0g4FA0vXMQfcrMSnjaH9De4hMAZi8MZpwGhzEsDuJLfvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rhdwpngo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qy1Mxbkt; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rhdwpngo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qy1Mxbkt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 04CCD13801E7
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566165;
	 x=1745652565; bh=GRU1WNKMHFOz1azaXIe16bHuwrRx1ItsELng/tV48uY=; b=
	RhdwpngoXOjeZvBoTOh30EClEtqTVjuSIJghGkInJr2o1u7vx44XolHrGGc7IVvr
	thyUo23oxt8WeRPNQhvVTXnb3bYod6TZjSkorTVp5C+C53IsV17zbED50LqqaMj+
	YOZkwf1w7WzV8hUxKYCOO/MiCBzRUINIpGlWqYoS8Fq+Aksi0MYCeCZHbyGJGb4B
	NgDlnb2U5oeMVRfzYhGhkkswOqb9ZMEAwF+NUvKKqRdf70otYcRDRh+KhdbzRFlH
	BiklwjNGU5bPQOc01oUrqUOCV+Pb+kDisdsRHEalDSwTULo+CJEkNEaK1a8Ex3hC
	ahimmf4mcMc8WGEoKlOolg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566165; x=
	1745652565; bh=GRU1WNKMHFOz1azaXIe16bHuwrRx1ItsELng/tV48uY=; b=Q
	y1MxbktEjBtXQ26K7zQLbJg/6PNgPOZxsvDt9qZ3SHHi/x7laOx/kgoF68tEjD+v
	g68TBxL8sGqVFupZDrAAUwg/jZ58Wt4TScikQXIHaEmgleehNeSTZ1nSW2bEIRBK
	YO5i6VRD2Zk9snygxot2201BEUx8hRhfZPpiIbRxWJPxRigqtiWTYrJ1qrric+fu
	SdcqQfPpdSgIxJdxKg83Az4xKa0GHAgN90vxEX0wsRXIWnictJqYF6CpsAEzBNcq
	JP67JXtr8lhGA2vpxtVb7cLnwZ9+d0KiA8orpwFC+zjxl3kHD2jG15pWySSvr/yp
	Umb0s281veg+AjhoXajTQ==
X-ME-Sender: <xms:1DkLaC9lZJ8ipQqi5-7AaLS9JIY3qIBKmlR7ejWXU_wHco9qnKFXOQ>
    <xme:1DkLaCtr8WFO7LW9rMHQbpAOPReqEbSbcSm1x9qeSMLSPI4tojNn0BXBQndfCqcdp
    BEIhQmYpCInDr7w0w>
X-ME-Received: <xmr:1DkLaICbF6ev5Rb9-YNpp_y6XLrbIUqJyDlMMPnua1tzNuS2AvX_mqqPe6n6IPuAb05K9T-nGH2ABleYiEO38fC5szU8qGHJhQ0y3j-r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1DkLaKehpfmbZzjdFu_7gTXpksnDFfznIzkEttxokLkvOmC8IV-ssA>
    <xmx:1DkLaHOi-S44fSsWL5yBMCEfg7Nw4Uc_ul48Y3KSf3qqYooB-dD3cw>
    <xmx:1DkLaEkZKEWOhVpuBnLGrgEmmVLNq_gbd_cmIGfowN60tyClmtprXg>
    <xmx:1DkLaJvrs4hEgdRRc9yTJrHDoGnvcjRPL9YRCkRWanxO1JbUBginsw>
    <xmx:1TkLaCp6EqutukZQ27nvbQwrAL7XtMfUKD6bdRMnmZZlriWuJ2viWqcZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b441832b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 25 Apr 2025 07:29:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:29:18 +0200
Subject: [PATCH 2/7] builtin/gc: remove global variables where it trivial
 to do
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-maintenance-missing-tasks-v1-2-972ed6ab2c0d@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.49.0.901.g37484f566f.dirty

