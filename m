Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1423026B
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566168; cv=none; b=JcZwfU7F7EJtTXN7W+CDRWCca1ZOWAbZtpKVFlDFp05iATPku3V0xrmZZd4Cb5rbU0Mp1lR5vPeQKjB14hIDBPCVJs29j0XnrO/tKCQiBPEQEWi5O05G+8O3AkEqQOVDkKkyZnWWmgcYQ3Y5QeQoi4Twb5EODWS0ltUL7il791Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566168; c=relaxed/simple;
	bh=0WbIQOvm94J2g0eBjUk6+NkYoojmNPy9qi+kbRNVITg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0NOprxs3UTNmvwzHxHOSzcRK4F+w7DTPFy0yRDkjo1c3o95EjkydBPw266f2dyNwjpgZ8RIbfss1xr7JkMXjbuoNgtYoemWyYxfWsCGqJjm6VCtZkOTdzal/pOMmGJSrX5POT0u8nL/iQ4HJRnZ20tL+u7TJJwi3QnDkT5XSJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iYPQ6qS3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LupNb4pA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iYPQ6qS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LupNb4pA"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B80A31140209
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566165;
	 x=1745652565; bh=onTXcgJsxzHPxqEW2v5Czpoq/DZojtHHF6+bAaTJwEA=; b=
	iYPQ6qS3ZplzPUXPCDjmw4P76Ie3Lc8Tg/cZRRE/9CZnO2Wzl5angKh0qyWAZ6Kp
	I092CBRxVOT2twcYnliZir1eOua5zVAtwv60ap2jOtzva6xQfTqsFh8xAFUtsoko
	vH7B/KzDs0qZAN7zMEBYgqSeZs6UZRUWeIxdAz9/9BLC6UHXLfE6XsbROsINHGuM
	J/YHn/lzcZ8AnwIjFPHmRjBm6Jv4RtjblM+o+umuZbFITGBk8mOGdXua/P7DCVvR
	HobUYUYWH1ZdzRIjQ8iOkePfGOzRRq8ONrpttdWSmpwSOeAFfINLuIafuzgEgoSf
	DzefimrdJMOBKT5RL6/tYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566165; x=
	1745652565; bh=onTXcgJsxzHPxqEW2v5Czpoq/DZojtHHF6+bAaTJwEA=; b=L
	upNb4pA/2Eb2gY5KdhpnrK/wvVdeVSxZhK21d+wCmXpXTVaRTg/NQSfsSnM2lL7d
	t+/5zGGd+XsGJ2Tur60wMHgS2j8HZxUON/bkfXt6Yn6joLl6hdlHaykM/N1vyK2v
	04n5o/3Y4cQcRNEz4t03+VeAH59ICAvYnr5NMfdcQbovu0heeoKf91izLd0IDjru
	Ngvdax7YUFD5dwwR4vu5KxsqPeiewYpBZ7z4t25nkf7/MnGd1n3dYHRhNW1aFzdb
	AyB5BXSIz4EvpUsU42QbStSoiIa+4Zaw+53TyCNhJxpErlh0l8Ut/LqW7X4EXZXt
	L+ylbg7Q0EIF1Gx7ibiZg==
X-ME-Sender: <xms:1TkLaGGPIFy7I96WaoDsVVNLkINh7WHg8n-JyczfxfddYJIT4Cu3mA>
    <xme:1TkLaHVOEA6RiWmfxFItSv9mGNLJmBoLWTZZy2b4Yi-pE-E5750sG-6HJ97pYYPcl
    GGxq2BQ7gYeSKpsCA>
X-ME-Received: <xmr:1TkLaALeqmTUhEhN3Q4rkGl5bF_Bxh-DzegXg20KXaDGLVOuJBRLKz-lvMFmoIDEARPm6KkIHG2Rqx3aZz5IR-n50zkIbVJ7qMO57536>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1TkLaAG_8QprcbN18zv12dXZU87Yu376zmOt0HPoZ9WMsYC6byTVvw>
    <xmx:1TkLaMX9uAkN8wV92A0AZkoMHTspb1lU7SHWHMTNuiOwQTi9kx92Qg>
    <xmx:1TkLaDOnRaDNN41O8-GH9xTbcy1Dui1eUssYZisJKL6bd7c0Q_WmaA>
    <xmx:1TkLaD2UgaHbKIwYD12klE4XLchPpqw04OHluagllxWlrCNy_G8Z8Q>
    <xmx:1TkLaASiaLTQOIZQYwNmmY1wScMTq86MdTY6Gmw-OfnreDe8MdhNF3YA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 40e28763 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 25 Apr 2025 07:29:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:29:19 +0200
Subject: [PATCH 3/7] builtin/gc: move pruning of worktrees into a separate
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-maintenance-missing-tasks-v1-3-972ed6ab2c0d@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Move pruning of worktrees into a separate function. This prepares for a
subsequent commit where we introduce a new "worktree-prune" task for
git-maintenance(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ada36e210f0..005ecc3f192 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -334,6 +334,18 @@ static int maintenance_task_reflog_expire(struct maintenance_run_opts *opts UNUS
 	return run_command(&cmd);
 }
 
+static int maintenance_task_worktree_prune(struct maintenance_run_opts *opts UNUSED,
+					   struct gc_config *cfg)
+{
+	struct child_process prune_worktrees_cmd = CHILD_PROCESS_INIT;
+
+	prune_worktrees_cmd.git_cmd = 1;
+	strvec_pushl(&prune_worktrees_cmd.args, "worktree", "prune", "--expire", NULL);
+	strvec_push(&prune_worktrees_cmd.args, cfg->prune_worktrees_expire);
+
+	return run_command(&prune_worktrees_cmd);
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -903,16 +915,9 @@ int cmd_gc(int argc,
 		}
 	}
 
-	if (cfg.prune_worktrees_expire) {
-		struct child_process prune_worktrees_cmd = CHILD_PROCESS_INIT;
-
-		prune_worktrees_cmd.git_cmd = 1;
-		strvec_pushl(&prune_worktrees_cmd.args, "worktree", "prune", "--expire", NULL);
-		strvec_push(&prune_worktrees_cmd.args, cfg.prune_worktrees_expire);
-
-		if (run_command(&prune_worktrees_cmd))
-			die(FAILED_RUN, prune_worktrees_cmd.args.v[0]);
-	}
+	if (cfg.prune_worktrees_expire &&
+	    maintenance_task_worktree_prune(&opts, &cfg))
+		die(FAILED_RUN, "worktree");
 
 	rerere_cmd.git_cmd = 1;
 	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);

-- 
2.49.0.901.g37484f566f.dirty

