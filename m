Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6A122AE6D
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175453; cv=none; b=vAXyteiMd9B//K6ymlho1T0BfMxc7p6PAY1qWzs+m6zG4oHHeiT6SFUrsLLL7eOfvR63sk3xI6bybtH+3MHBqBwG1DRdX73hxw+xuleXkO1OHgqZ77oTEQdmppk1ZdI5Q1DV12HSuYAsc2IK/Ou6CPIV1oUxk3gyS8uzNctdM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175453; c=relaxed/simple;
	bh=PDh664u0KiANV65MIPjfYrNErJaXiHjWjSWHaDa8Nuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4cKMajrhqW/HsiwrJ2V2dEZ/hB++JlHSK+koF6U3ve4meSxjD2szRfVCBSkh+Xq7tIu8X9WDMxr4gmB6OhSkLimTnyMS3o3jp6iSFpqKgCiEqkJ3yDAYIJwiJzQA+qVBWHSx7DD2SHQd+cIVMdDBV20N6IB5vqbHcGA+zFtUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=15f/5gyx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lOzx7bC/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="15f/5gyx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lOzx7bC/"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 65E941380F2B;
	Fri,  2 May 2025 04:44:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 02 May 2025 04:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746175450;
	 x=1746261850; bh=mg4yEuJRUykYeG0GyzLl31cRTFVwK87DKf1CFZfSFSg=; b=
	15f/5gyx/UIV1+4faNMhX3Rs0m3ntVrAl2nKJDkjVDEHR5bZ732wc469Ggc4BzGY
	MGi54YeZQpZXGrxYBejBEVE+ZIuVd7xlte5JSEnp7A7y0v+osv7FZFJah8Iqm5aF
	8cHHfG0Alc19dAU+LtZIUPYOc7brHxTme+c8S/U9/CveTX/TxVbzoQ9x+II0AQiG
	RCC8dUpNVVCZeDiB7tih0Xw568Wy07doeBglDJjB+xVFtW23ra4hVJ+JNG8IOMbC
	gssJUWLsqs0kSj3D+yQNxZ42Gf0SlBzvi0r3RUVQxmzHQ0lR/T46ZkYv7wn9Wsi7
	cMGr/psH548F7Nutd3v6pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746175450; x=
	1746261850; bh=mg4yEuJRUykYeG0GyzLl31cRTFVwK87DKf1CFZfSFSg=; b=l
	Ozx7bC/y7IUHcgQaS8OzZ+69Imt0mRyFwoLt1kOk4MEqo7xUXoVp7zetBoBIXWD5
	Z9HpbCa97UF9wBRcZWNnKUzeHtSUB3OD7/4SVkNk8rnMfNt1WfmpQgdbjors0JDB
	n6BcOFGsg1aAmwxyH2yV/87VlpXr/NKbjwTEiOJoR/DIAj+tIj0J08m45pnp5ie0
	Aw8RoR6d8k8e6vsW9PTFV62J5Nm4WRYvgqXcf4lf9GGeT/F0M9nPMXRwTV6Pf4YS
	EoFV/sCMcyw80FX8MctLhKp4IlAhkw1pgLCqaYR9sLGkRoHm+Iev0Sjkk3xFBk9m
	Br4e95YS+gcmZnHm/K6WA==
X-ME-Sender: <xms:2oUUaJw-vcOXEhhMBEVjuALD4xGN5XcCD26whr-Fxg40h1F5OmX6EA>
    <xme:2oUUaJTsmaWwtYDQoGXH9PiROZcfotrXYp4thao0nVuzwT8Rb7RtJ-pSw9An2cbU2
    PCPvASI6n0Ec8v6Xg>
X-ME-Received: <xmr:2oUUaDUL5zTsSZmk-SQbu-xp4X6Ll1uuzzRQ4wzvMx50fNG_k0cAsn6y6ZAQ2nSbtyzvtxcSBCtRl1BoXbnpyWkIi27u3EEriYSXr5ADUhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2oUUaLjPMKoR0g189CEzJh1jd4YfYej1zPeamx_bTK3wKwSRb0DVaQ>
    <xmx:2oUUaLCFS5vyx3Rr5bBnclHWaDlxikxBk-_UMy1GVekSD92jPrjxwg>
    <xmx:2oUUaEKoalin7ErUFST8wSKojFP5ZIP5uJmVDOXSLPanwHGwd09eYQ>
    <xmx:2oUUaKCBCkT86bFvHDcLYO35YK9Sa0INY0vP9-4ICmcEfxC7dP545A>
    <xmx:2oUUaE9ZP_1HoQNpXO7Tfi3Z0rOpmE35M-FE31OcqUfQI4NtBq_KKa0F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:44:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f138185 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:44:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 May 2025 10:43:59 +0200
Subject: [PATCH v3 2/7] builtin/gc: remove global variables where it
 trivial to do
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pks-maintenance-missing-tasks-v3-2-13e130d36640@pks.im>
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
In-Reply-To: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

