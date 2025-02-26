Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAD224891
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583484; cv=none; b=RYYDmVyG0hOwVbmxl9Lqf6SU2e9nKn3sM7VnMESccmobt/p16TjAvVhBiocLymo38RFh9y6yCZNHl0IPqwD9/VLO7vehvytha5v8+gxcT3hTpkMeEMp1RFGeVpRGMtVOTTbidCcc3f3PLJ1QmIzhY57fBwwBpnnFsqXVainjWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583484; c=relaxed/simple;
	bh=zbYC69MYpCrmXqp1VsSYSpL4SExrzX9xKP0M7ZghGoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHDcURXVAkKnvLrdA+xY+09Z0Eie4M8gnyuIc30LMIYFwwhKygqo1YxICLKQvwt6wS6N1/AfmZ1fioRY3OknJgjseV/pr//EB1mPLU8VeB9W/9IWmmHvOog8dRFDWI0+zN7CmnhzglHsviSlF/VvZJ2fi4SJBkFyFdH4El9X64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BDMjSypD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3q9nLlHa; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BDMjSypD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3q9nLlHa"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 49A9111401F7;
	Wed, 26 Feb 2025 10:24:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 26 Feb 2025 10:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740583481;
	 x=1740669881; bh=MKPp4OYuAWr/o7JqQUDt5Gvy49j89tE0a76wPKr9aKU=; b=
	BDMjSypDLe9L8HwXj6nlDg501QtQTUeOwLe+oBRclNGgZLLUHakXQJnonGR5z0ka
	oFvv+h/g+q3d8L2PnyhCKQityZWwB3S0mUUiXF5vgLPq0Tg35RflCT0iSjRy6lmn
	qm72k5+FW3QRU1lpBZJKlh5J6pH1XS6noHayS05ZqN1dVQvEiX9nfL5NLCOAKOWa
	IyGe/EOO0O+0/nzqOcNsdyxGpGt2eC2SMi7I3rTSXc48bQ+V/2UdbwJ9AgCIVBvB
	LNT5PibVUgQbFutop8Tkq5GXWa5apd6YrYkG0SRyzLDdSW9l8gvXHrfRu+DqB/G0
	EgVeMhMQ1foZG0Zg42G1fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740583481; x=
	1740669881; bh=MKPp4OYuAWr/o7JqQUDt5Gvy49j89tE0a76wPKr9aKU=; b=3
	q9nLlHaqqcloUU/ng27E757Ii1S5XbmUKDkcIQ6vPzMqG5ON55Y5brNGKi3Oh0R0
	fKSvZ4RTkl85xJq1ZzF7iA0zdJSdldgdZDPVRCKJ3h0KHNU4cZ3Z717Z/zZOPTpf
	s01U57KcZkoBO0vDsExVfR4ujEApjz9Sr+6MeKM5AkV9jgnjNSGYcrrNHxJtN5NA
	FYRXGZfB2Na4kK7QNYXDqkBgbTYcZWCRJOIY6kfNzj0zTADXLorlNHG49ffQDFIF
	OZ2a9w9XxeCCDlSbjNTGb5hd+U3H+F4QsY1olwsFCvBqFej5G3aw3vOYg3M93oSi
	r+3hOKZ93wK6EAvdJxmLg==
X-ME-Sender: <xms:ODK_Z0EbPd4KHPTP8iGVkp33JiQLxA_8YZwIIrTsMvSICOYc1nYHqA>
    <xme:ODK_Z9UcY0y5vMqBNkOkgqWdfT6Bcjbbxq03d0_6v9iLOtrUq8K9UDtUNjSOxLnG7
    0izqUQtg6LC6qtdJw>
X-ME-Received: <xmr:ODK_Z-L81tOJhKZcFg_QRGFlhHvFubymJ87y8X8-rViwNBVRpHSgYRKX3h4VkVX40dLY79XnfHc586wgvBJTeM7XTmq-pOvC8pq5CaOQTWAOEFZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvddtvdehsehugihprdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ODK_Z2Ek-LpHuPTqkxwb-hJghGk009EnmFwzDKZDBlZBmNPrBvfOaQ>
    <xmx:ODK_Z6VnBnCBvz_-v5npSPXJXJL9V_wE0VN8n4pe_BX9KMRg0a2NGg>
    <xmx:ODK_Z5P72pYfkFpMb3PyEvfmTh_tOYl9Yjch1oL-9CheqzB2f_8ZEw>
    <xmx:ODK_Zx3BZNEngOK2_ImMiZoxLOZHPjUOQZh6VtldRsIBI_zvs1Ukew>
    <xmx:OTK_Z4x2ENOFa2Pomy_TQY5LCxliKyuGf0n-X-NJBuvVY40eoLcvBJTn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 10:24:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c08ac0b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 15:24:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 16:24:30 +0100
Subject: [PATCH 5/6] builtin/gc: split out function to expire reflog
 entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-pks-maintenance-reflog-expire-v1-5-a1204a814952@pks.im>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
In-Reply-To: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.2

We're about to introduce a new task for git-maintenance(1) that knows to
expire reflog entries. The logic will be shared with git-gc(1), which
already knows how to do this.

Pull out the common logic into a separate function so that we can share
the implementation between both builtins.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 409d454a4b7..e8f5705dc59 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -53,7 +53,6 @@ static const char * const builtin_gc_usage[] = {
 
 static timestamp_t gc_log_expire_time;
 
-static struct strvec reflog = STRVEC_INIT;
 static struct strvec repack = STRVEC_INIT;
 static struct strvec prune = STRVEC_INIT;
 static struct strvec prune_worktrees = STRVEC_INIT;
@@ -286,6 +285,15 @@ static int maintenance_task_pack_refs(struct maintenance_run_opts *opts,
 	return run_command(&cmd);
 }
 
+static int maintenance_task_reflog_expire(struct maintenance_run_opts *opts UNUSED,
+					  struct gc_config *cfg UNUSED)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	cmd.git_cmd = 1;
+	strvec_pushl(&cmd.args, "reflog", "expire", "--all", NULL);
+	return run_command(&cmd);
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -662,15 +670,8 @@ static void gc_before_repack(struct maintenance_run_opts *opts,
 
 	if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
 		die(FAILED_RUN, "pack-refs");
-
-	if (cfg->prune_reflogs) {
-		struct child_process cmd = CHILD_PROCESS_INIT;
-
-		cmd.git_cmd = 1;
-		strvec_pushv(&cmd.args, reflog.v);
-		if (run_command(&cmd))
-			die(FAILED_RUN, reflog.v[0]);
-	}
+	if (cfg->prune_reflogs && maintenance_task_reflog_expire(opts, cfg))
+		die(FAILED_RUN, "reflog");
 }
 
 int cmd_gc(int argc,
@@ -718,7 +719,6 @@ struct repository *repo UNUSED)
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_gc_usage, builtin_gc_options);
 
-	strvec_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
 	strvec_pushl(&prune, "prune", "--expire", NULL);
 	strvec_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);

-- 
2.48.1.741.g8a9f3a5cdc.dirty

