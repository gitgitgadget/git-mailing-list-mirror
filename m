Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3B25F7AB
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093350; cv=none; b=RSGl4EzpbaLj8EsM3sjLSPCjmm4AJBD6ULrpsGCgldNHw4uLmFqvDIE4/lfTwn2Xlk2a29wcGPprBuvTegdd1mb9+YqihjyswOQzrzDgXlDEHODx8u0/4oJEUHz0Hb+7yUysAjiT2qUVIOdb69ut1B/4sFX7mIgixnENQlNd5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093350; c=relaxed/simple;
	bh=79zwg/pEG4V36CKJMgi735L5rkaPuwPsyC73rPKZyNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxHonEpKb/dKCBXbrPQqut42KrGAWDDMr3gBLFxRLAxebT8Eug4qttv6wT3GV0/mVfk9U0PUhaTRbGgx2wV2okUuXqQ5ukx0saLZBA1mvoj/atCcIlX8LKsfVK4lqRXoQ99w8mPSOYKzxlafnD73p4lCcIzjIAMR8bOfGrvw8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EsX5LU39; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/uC5BBs; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EsX5LU39";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/uC5BBs"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 311361140115;
	Tue,  8 Apr 2025 02:22:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 08 Apr 2025 02:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744093347;
	 x=1744179747; bh=8hArgY7rqo+fNLB2T/qnwzSTH48/BMY+XzRPRMvIfcU=; b=
	EsX5LU39Z7s9copZmRaCPDU63CF2Ak+iZIyLO4yOtWKDuhDUs3gm+dGjhx5cPKpg
	qg99KwaycHgduQy8+WEtWOKkOUP0AeZkHv0TMgePzxITbotKlF3XAQYltJJr8+yh
	s7PHzcKx+Xne1fUleqhyVgSDWdRCV+rEM1p236Zz3d/GxIflnrE99wSBwzIgwvgN
	zzoOOXdqDcVl1y5MYDxFaDw1sq1E0kUC4C2bs3Jfmg969uEJruIWUhNYA5eehFqf
	QFrspJaXYFotTgdWIUW6Q86jmylIom1bqWcqOuwl2E6wothbUJI19aBvue9FWt14
	7vhVILpn4xCg2GHsZNHaGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744093347; x=
	1744179747; bh=8hArgY7rqo+fNLB2T/qnwzSTH48/BMY+XzRPRMvIfcU=; b=j
	/uC5BBs2hWge4+4W1s70EHMZZRVskvfnnx/MRn1UL7vZU49tp5oGLngt+hkEilys
	lgNavkU9dmUSowA8EMmWtUDEug9wYLS/+ZtFqn6carw/fGKdIf7SP+vTqwZqPGAu
	R6mW2ePVs9b+9YSfoUduUR8HYiVCCeSJaciKioUpcyD5wFVGKoMErg/Oft4cSD4N
	T6dBhk6shqcbsF7fR1cNccDxjVuPjPuf6eeHBTux0/j3suC05Emh7y3Jt1XRBmor
	8TikHfwXm20UPa6O3k7/cMaMRiXkWzRh6t4QLtEUMLkDUynzQJLSF/Rlp85U8Z/C
	/gN7sTKpizE/eJ+D1AXoQ==
X-ME-Sender: <xms:o8D0Z5XhtHGAD4S9eSMgVF40J5-4dVgI2VBqMr5jRHLEnrtpmTTYWw>
    <xme:o8D0Z5kGAmCyk6WhLB_bgujK0CHWaYuQZ8xXWYKPqYBVAgAW0ywwrIRVRuVHKMhf8
    uhLEmVqjlJkiYV5ig>
X-ME-Received: <xmr:o8D0Z1adNm3oAJv9khOlNkSMz4TS6KVbjHPUbIhfs9Ybf6nrKfr5SL38FPIgGZWR_dEkjHl6rQ8s0uj8BNhyeolhejhiVY8rUXh7weIC5RZXmB0czQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvd
    dtvdehsehugihprdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:o8D0Z8Wtx3VgC5GFV1yAL78qBqpDpWznPQsgrHswR3_OaTiEPRpMdw>
    <xmx:o8D0Zzm_A9BAEicj5yvarrm4OcnQ7ipynZ5HJoBUIKy7_f04wpOg7w>
    <xmx:o8D0Z5c92CapSHDF6-eC10EP8HCvvaKrMU0jvyoiBDJZNgnWkiMybw>
    <xmx:o8D0Z9F0Of0vxX5z3v0clM8bu6VtpsV2Gm2WQ375gzsqSMN3A75Y8Q>
    <xmx:o8D0Z3y3JeTcN9rNyF4NVSDjHTRT7U4NmCOKAKCyxt_7WGxGLMZMgCSn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 02:22:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b1660988 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Apr 2025 06:22:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 08:22:16 +0200
Subject: [PATCH v2 5/6] builtin/gc: split out function to expire reflog
 entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-maintenance-reflog-expire-v2-5-1ad8634798b7@pks.im>
References: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
In-Reply-To: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>
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
2.49.0.682.gc9b6a7b2b0.dirty

