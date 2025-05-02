Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133A22B8C8
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175454; cv=none; b=Wu5M6G+Qfl6+4ouARyyeBObsn6d9icCC63dodkWYgpioeCj8IshCAp2si/HJjv3NZooD6iWJngBT4JHE2AEBt7iwt20do+oH5cHLCwM8lRcXUtZV2HGknvQmqCsXKkm59Bdd/XrbgBd98KYRrEJs9Nf7NdZ35T8dHrm1j9we4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175454; c=relaxed/simple;
	bh=9oWvfp+TBramaFFj0kk39VWXUJ4VV3/G988B2drEOGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwLmwl2BSpMH6gae3kpyDfrEcrJcwudtJyjx7p2hccsaUMci5QQoaEW7G/g4nNR7lSK822rjNUaq26+HltFVKS4gK6n4fHcXOs52XHp3EUhIr9wZ3pzjTS6eQ/gS/oBn+hwXINB8N+ccP66h0yxr48iZ4d5gCMM7FpygB4fxBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2lHryB72; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8O+ppGF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2lHryB72";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8O+ppGF"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7AFA011401DD;
	Fri,  2 May 2025 04:44:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 02 May 2025 04:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746175451;
	 x=1746261851; bh=BIYMZc6UX9yanXCqRxUlkcjjzXfm4qWuBRxibz1p8R4=; b=
	2lHryB72RiGn7GNN9lsI717iqWuPJqoHBv2MCzUJVE9RdEjMJDxm5C6VflGeA6cv
	g2QbZaq7XV/aIBvW9rejbofrhsrXw3CK15aouBUk62A75d18wuHp1l/uVZWHk1xQ
	nRAMXDQtZPMLbSaWU0a6wBUiFk4IQObBPDI0MbCn+eZiCTIQ4kU9UY/7SZ736XjK
	qHlCOYO5d6Oh6ygw2w10GPcUFloGOReJVxpOD1GB6kMPBp/bbh9NJ+gff08u6r9J
	NNU8e2lrg9g56dhQ8A/Hu5PRrlMnm9fzmxDUfcTkQrAiPdSzWm3TMbbeLgVq4ie6
	0+ghOto2CqZcj1vUJd9Obw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746175451; x=
	1746261851; bh=BIYMZc6UX9yanXCqRxUlkcjjzXfm4qWuBRxibz1p8R4=; b=F
	8O+ppGFgTD7etuzIBwQxsaQ3RDW9paFfqL5N5s0TiwbdAwhhtWmpvcEjKUspdCLm
	sYMrACUp5vDfM8a6bN7L9lCrThgf9ebe0iylO7SiG/GJNSlciH+Z0+qaF/UiONsf
	EVfNYtrDy4ts/1/V5ofr/EZ78dagFcFNGErDUcf7BZLDIQN94f0QR3RtfXRPAx4q
	fBP9EqdrQTO8wWyYyblk+k2+CRcogoIJOjvg/M1V7CurI9YSSq4XzxAIx3OpB9KX
	pY9PuL32NAZ/vjUdxGIfNSRu5BCNsX03FYZS0sWgTFr+nX0HdmCfOxw4E023gKdH
	KRbxuuDLSyLAGOZZWsw8w==
X-ME-Sender: <xms:24UUaFK60uP1drwWqaXDfF4sF9upBihrr8b7ygf2sIFjafIOJdbXCg>
    <xme:24UUaBIdrXttbNiphR5ldDvftdbs0OctWKcu1eyQyvW0Ir7xE_IgK5bxne9I3nn7j
    cKmqrOWaUBFU6jkhA>
X-ME-Received: <xmr:24UUaNvky5AKMCJlAKMKT22ZxTkqN4D-SLJDW36l7kRzPZCOHs2t0-CoMKIX0Dmz4juWUi8BAwiqeWWBkI2_LfRhSLS54k_9GXGZtUX6WFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:24UUaGafNP_Fp7e5YJ5VepMnXK884ip4W_Be8BYAowSGQbVqUKjI2A>
    <xmx:24UUaMZG6ZKX-mfiy3dJLjY81F2To4hLMgAMAokeDE7sN0aobm9oew>
    <xmx:24UUaKCiV5aeQjMAB_MMdqs3yTlcVOSe5sHGEN_KODBLRRd6seKyrA>
    <xmx:24UUaKaPid2-Vo9t7qg1D8an7Yb4PQecsX-TG9WKjlhmjQcnWtQCYw>
    <xmx:24UUaE3Txj3bVsnsSnElzKBsjqt69o_VJrJOjccx6HDQCZPgSOc1aAXd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:44:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c150968 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:44:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 May 2025 10:44:00 +0200
Subject: [PATCH v3 3/7] builtin/gc: move pruning of worktrees into a
 separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pks-maintenance-missing-tasks-v3-3-13e130d36640@pks.im>
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
In-Reply-To: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
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

