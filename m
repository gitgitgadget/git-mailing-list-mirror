Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6781EE7B9
	for <git@vger.kernel.org>; Mon,  5 May 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435115; cv=none; b=lYpKCUxL8405m4GhPQM0Y42YqzxyL6O1vL9Opu8WEWr2qX5o+BCDK0DT4IYH9N1a6aY2QcAVfUHGp1QuYmUxNCbnQaGPCKcGNjHvVPz6OQq945acwwP7Nnq+wY+lbCTQwBDJQNIkxFU0GR7vefWfrvzdYlmAPMxhNF97Y+Ezohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435115; c=relaxed/simple;
	bh=9oWvfp+TBramaFFj0kk39VWXUJ4VV3/G988B2drEOGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/xhT/DV3bDKyQrlhW+aNQ42vmImtp1NUYK4Y51rAP3b2yis9HeRl9cx9LJU1dwPGMdq+h2BP1St2lS7wf8yNM/xqQmLk3cT3D38v0WoHXZ6pYItaEpJ/KxUn1vW66WQqYdMSi7YcyLFCsdN3PTpneSLsxWcKJ60pxnLtjAmu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dFbJt45v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTfidG1u; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dFbJt45v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTfidG1u"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3429254025D;
	Mon,  5 May 2025 04:51:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 05 May 2025 04:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746435112;
	 x=1746521512; bh=BIYMZc6UX9yanXCqRxUlkcjjzXfm4qWuBRxibz1p8R4=; b=
	dFbJt45vTORCUOR2Y9mjGRTKXBhLH3mmP1PwlQLRyYNzvigwmw6HEWvm44iUckex
	loEHWvoqEp2UO2Erp//Z7jHBqvCSqR/KOCwtsaBTE4Vw/LNS/D37nfli9pzWtYeb
	bC8BTbSn/dxmhuzWy/ahyqJqXBghphdqveRTPQAnfblCgbAoBoyTVOp5Fovan/K7
	juInbQGT/n9Wo6AqCqt3yvJCYg/OyZlJ2GoVxryQXGFsTr7GLJhff1Izw3Kxe5zU
	t/6hoS535jIa6ofZKfLzuiAyIjqW0PG0kZGRzpb3D7nndp0YT23ivK0qWNoOl5wD
	5nKN39PBU9Srphrte+MK5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746435112; x=
	1746521512; bh=BIYMZc6UX9yanXCqRxUlkcjjzXfm4qWuBRxibz1p8R4=; b=d
	TfidG1u3puGAnf8crxxwtk8nr/2S88PCrpBh4Fjagel+DnoaZ/7yoAHuweb219S5
	anNszX+V9GNlek3tAsfcCCPIG/stN2onTkh6/d+ushGDd3i1PpiZu55LEiaUeUdc
	DgasY9fKynik4FJaLHarr/hH7mSfl6AnrD/b7YBNWNBiR/jIb8H/7qPUMgWIPZQV
	NBnp4oAC+NMgD/lMwnDJLsAlQoHHUy8GZSkE09y7+TGnoC5Ck+c3DNPwL9sq/Ejz
	iAlxlhRKRKoYiQCiaFNoLHqp1meM8A6ngI+qsLnaCM0UCzfuao/S9yAARbv4UcAG
	wtQM87+SIA2N7KQiUtNzw==
X-ME-Sender: <xms:KHwYaLqFTGn66fGCtI2XhMb1fKs8IwpDfeAQ1TqzGnUcMfYGgS_NOQ>
    <xme:KHwYaFooKHFOZSnpWMLhkLxKtoR_GXt6EVWIp34dnsLULaHqU_uCXAscFn167rTEy
    jVPhzYEK_YMsXlBeg>
X-ME-Received: <xmr:KHwYaINisngRKqXEzS-P7-PnCAQoreY-AY-B4gzRk_dpOclYSuVreJFC67iUt-g5Rereudon356V72NTHujmISI64rVfZ3hCTVjSrYsolI_bCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtieehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:KHwYaO4PHVgLs-izBMTnAQDZTFjokXgMP1Cq3Ggq2EdNqgBcH2lGhA>
    <xmx:KHwYaK5gW_DLCIAbrF04yHoJ8MGEuBNqaKSgzuaEzpiBF1IjGRh-Xg>
    <xmx:KHwYaGgaE_WYeok3ht7FronSJnPDTK8j9_Z7CqfxJk03c8zs3TiaSA>
    <xmx:KHwYaM4_WX2Doj8rRDvVHK0RbWJFR_C8yFNwgFAAHQzPZEBgDFr5hg>
    <xmx:KHwYaJXI_Q688YC4RBHChnhYrD912WtBv9ieI9rd-oR55Jn_Mox-GUJG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 04:51:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec136de7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 08:51:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 May 2025 10:51:43 +0200
Subject: [PATCH v4 3/7] builtin/gc: move pruning of worktrees into a
 separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pks-maintenance-missing-tasks-v4-3-141f4df906a1@pks.im>
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.49.0.987.g0cc8ee98dc.dirty

