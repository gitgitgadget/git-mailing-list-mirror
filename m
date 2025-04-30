Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D723906A
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008719; cv=none; b=cnJPc7sl8+hK8LMmiIUOx4rqmyUE14KLcEXjxVRjdwxXJpGab6KDaK7TzMUoi6YIbxKOrX41/QdgTOBE1fqxSEPYPcyAKpKzghekMy+LfiChLwGm2TnkGX6PACDwwO3piFhxnwjkBpdOdNs2Vg6hUa2St2jJ+h0/2DSKYj5Ux84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008719; c=relaxed/simple;
	bh=9oWvfp+TBramaFFj0kk39VWXUJ4VV3/G988B2drEOGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIn4EpfTiErvf/zVj2JLo24M/Q5yFAeWwzaOH7e44G+hH+tW/P4CDOR+F5/cp/ARnI4d8gPquPhHkJlh0SksUw0PArBRSGsFtucnQeFPsCqDKhr2+H/pnc87kw4txnBoAjap4MqA8Z6m5rSsTb/3topYWgdE3a602/et738Uets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jc6iAtXr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O+LFRiws; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jc6iAtXr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O+LFRiws"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CC7B1140244;
	Wed, 30 Apr 2025 06:25:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 30 Apr 2025 06:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746008716;
	 x=1746095116; bh=BIYMZc6UX9yanXCqRxUlkcjjzXfm4qWuBRxibz1p8R4=; b=
	jc6iAtXr4eleZKfrtFAZzdBWJEsoAcEM/nlY6gjTNRx+4HQ3q1aHpEC66QMCKbhG
	M6bhVZSXRSJ+cDUV3cCdt+vjiQcDAmCmy2ln0Onua3asl9nvBvwaIibOUey9gFqb
	7jg00D/OvnapxI5oP9+gzPp+aUiqDM4tBOfZLsyg4xWNMnrgqfKKcoQNueeAm7/M
	2totmTqzQhteJwDysYBLxn7dw3pScBCan4J5GNGUohUpXv5aRu5d5XPYTSELyQA1
	WD9fh/ORmVqyNoSB0BU5KWweb6FuB8MIdLsZ1I1G9q3QIJWCSwwnAF/riAQlH+og
	7dgzdHsDTCJYkqFc0DKBTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746008716; x=
	1746095116; bh=BIYMZc6UX9yanXCqRxUlkcjjzXfm4qWuBRxibz1p8R4=; b=O
	+LFRiwsIntbz3HHpGBPoY7O1ca7fLSUjCUo990XJ9A3raBn8w2Aa6+NAVDv9Fe2X
	Ck2ZGG8gVr1LkXhseBpbLXAG2vaLIKfk1KIZyEuzTztiV+qLsUzlUSTXu33Ykj0I
	lf1bQWQ/R6qugj4ManaAVVxMjqnndODQwx7Q6ExOVDXajOFCCyUmZdu5aYJrU7og
	WteYgceJPUGW2/CHWs2X0K24vhxSuUW676MTKAxqj/6Sq/n0FfvUVKK7HtjcYdU+
	DexoqfgmU6F79EaVtDhs1BThvkDyKSH7iHpXx58ZZHoGyswChYEk2i+uAR07XdPY
	qvYFN407rtcIL8Flyncxg==
X-ME-Sender: <xms:jPoRaIGXtB8V4sRJA6AtXUZZ6TcIJ9vjJsM717hhn7mKVL0h0tox5Q>
    <xme:jPoRaBWE5JBBCwOBsMq8t0nbAH3BZEY_wa4S69kouBW2Rxu_1kkl1pnYfM4vyIJon
    sT8jz2jQOMU19VIrA>
X-ME-Received: <xmr:jPoRaCJzs_CHkas34NCAiZN3IBDNRdi2vMxCZwTYp-9hcSVaynBYm3ESgWGZ5heIgrV3XDg7an7eiF8TEG8O_FjFFzp02SJBTFRXSsCAKFsf3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jPoRaKH9E5pMNSg5-f83YAZ5C-C4XSOk6oZhyHVAnP7IH-4y7P6X0A>
    <xmx:jPoRaOVnETvj-pU3JpwoTSMaL01O7_ZeqPK81jf3yP9noaaF2F3xrg>
    <xmx:jPoRaNOWw6fBcd9wD7h3b_kd02woM4LC3QFNdaQ1b7vadiKaByzjvA>
    <xmx:jPoRaF1b6p7K4mr302JmHAbg8UwtsvAFILTVm0XOLIAopsozL5Nd1A>
    <xmx:jPoRaFw9vCp4lWHX3JWJKU6p4-4qNA8Yz6rgyFPMCfNpJ9MfQcSKav6->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 06:25:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4418e3c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 10:25:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 30 Apr 2025 12:25:07 +0200
Subject: [PATCH v2 3/8] builtin/gc: move pruning of worktrees into a
 separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-pks-maintenance-missing-tasks-v2-3-2580b7b8ca3a@pks.im>
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
In-Reply-To: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
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

