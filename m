Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FFD242909
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008720; cv=none; b=TQNy/777jTJ8QTuJHzkn2/eBQYIRJlFyrSzifI9xulAdUUoM3Cplr3XxIq6krhR6AcJwH3CHj9bR5+/eCWowhv3ZH5BD77/vsgT1+Elevblwf78JQwfykmifhxefZfEdNIG1KhObA3Fd5qUfr5DDL+Dxe+EvLreZnrzNf8DhrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008720; c=relaxed/simple;
	bh=ZCE37KZIKfwqDy1+ewJJRE0wpy0DfGKIVSBYRyZoQuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RomrY70iIvsUOhlAEo2aInQNMs74Zk4bHZQYIvjg365FklBRy6EnZugC0mAEffu9M+70MV0lRe3pe6s1CyKKDbUZOX7R+p++g4RVHD/M0VN+DwW4G4MQTsfWWh3yK9bMvTUKQdTfqHU7hqeU//2Rku2v2manp6/OgAdWQVDbV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rwaiDXDI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DfhysHQT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rwaiDXDI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DfhysHQT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47112254021A;
	Wed, 30 Apr 2025 06:25:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 30 Apr 2025 06:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746008718;
	 x=1746095118; bh=X8kv3tFVyHvQxEtGxGzjtiGoIk3mQdY5oT69IcWZPHc=; b=
	rwaiDXDIigw6nhfdWoDhAfN5fTTePBxUisdCi5tvC4x6RkY125NeK5SWRA1bIezO
	+WX1Ij5ErYZ0M3zBxjaGRIp07lMYFEaOuylEWNsTnR94yofc++xoz6PCbQZuhwGr
	b1wap7R2aUizkfYJqxJ8nuAniCBS63ZDVIxDjGLtIk7GDL/F+tPOgM9BpUQVN7ie
	jkDBpRadQCWiOzAGcRLYNOksZMntS8B9lG8n6KPcjTU/FP5US5lT6JNF9yXfOKQ2
	wqMq4nlSutFturepKIFJ4byimiqZ3tgFArnk7GRwrPA0NFYQTS96AbC3Ta5zmv1l
	HfF3j1I3Rzqzh4vXGCqebA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746008718; x=
	1746095118; bh=X8kv3tFVyHvQxEtGxGzjtiGoIk3mQdY5oT69IcWZPHc=; b=D
	fhysHQTbECaDz1ukThFWNQBJIhgtlvm025j0LnR/si+cV7qzyUqpdipfOo/hbmQS
	N5lOVQo/X8Bc54xuo8/ACQ326/CY0ZmnD6XnsKamMe9C4y3TVJXtnl6qyA2E7Sre
	KV5CwOoyTXB/3AMY1Q9I0T3/9+MRJSqktXQCWJBxJVhaTsxu5X/tAMHrVbz7SuBi
	0XXn3VAUXZHoua/33OG5ocfPLRlgkq9q1qfKiy/RMfxbCgOgNR15bMK4uGoyApFo
	L/vuKWotjCvDAzSOIUWHiOPBM0JlgLOZ9PfYjDZSwzAYQgzo1XbY9+EljtpuBThw
	7j8EBWUgAFGwWgxzuX59A==
X-ME-Sender: <xms:jvoRaBTLevqyuiXRSWxSExxFcw8Wm7YtZw9FlvuX-kuSe5FHmeGiYA>
    <xme:jvoRaKyLIs8QqQCPooZX62jycngdST5Xo4SG6pXewbHiOKcQ1169LRp9DQspR24rP
    xv4KsshsYt1JTLc_Q>
X-ME-Received: <xmr:jvoRaG1YIh0YH0FzZz2RZzbbhAmQaOxcZDEr5JVM0o8Orj3t8uoTZ44kbjmPQf6SAMtNccA6CkrolSGCXpCVYO19IsX_D1jGG9XqEYaztY_FdQ>
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
X-ME-Proxy: <xmx:jvoRaJAAcZJ95MBjsoNsyD-HXc-2zj13C8eJxJUDRhhGqiZXMHiPKw>
    <xmx:jvoRaKhhooEFmz3cVkBQHQjSUPGWkdRW0SMpxre3YOc1OxFFW99suw>
    <xmx:jvoRaNogp03TgU8r6smXBtvrnCkNrVsrcHeyg-sHYq5JG6kaGAA-hA>
    <xmx:jvoRaFhqQv_uGEdKRkuDl0fazFiPiXGtVjhd_9MbZPh1ptxePgjFRA>
    <xmx:jvoRaB8yuHlFUmi1h_iRg-lViRt4sXUacxbPxmNnqZdxTR7p168m5omM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 06:25:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id efb946a1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 10:25:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 30 Apr 2025 12:25:11 +0200
Subject: [PATCH v2 7/8] builtin/gc: move rerere garbage collection into
 separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-pks-maintenance-missing-tasks-v2-7-2580b7b8ca3a@pks.im>
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
In-Reply-To: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.2

Move garbage collection of cached rerere entries into a separate
function. This prepares us for a subsequent commit where we introduce a
new "rerere-gc" task for git-maintenance(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 93a8c856dbc..3dd1d07cca4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -386,6 +386,15 @@ static int worktree_prune_condition(struct gc_config *cfg)
 	return should_prune;
 }
 
+static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
+				      struct gc_config *cfg UNUSED)
+{
+	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
+	rerere_cmd.git_cmd = 1;
+	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
+	return run_command(&rerere_cmd);
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -782,7 +791,6 @@ int cmd_gc(int argc,
 	int daemonized = 0;
 	int keep_largest_pack = -1;
 	timestamp_t dummy;
-	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
 	const char *prune_expire_sentinel = "sentinel";
@@ -959,10 +967,8 @@ int cmd_gc(int argc,
 	    maintenance_task_worktree_prune(&opts, &cfg))
 		die(FAILED_RUN, "worktree");
 
-	rerere_cmd.git_cmd = 1;
-	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
-	if (run_command(&rerere_cmd))
-		die(FAILED_RUN, rerere_cmd.args.v[0]);
+	if (maintenance_task_rerere_gc(&opts, &cfg))
+		die(FAILED_RUN, "rerere");
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);

-- 
2.49.0.987.g0cc8ee98dc.dirty

