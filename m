Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC933B97C
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056016; cv=none; b=JX24JbfyQDPswGGE9Q8BvUOaW3XQCvsc0OOBk2/6J5qRdx5ApmNl2BxcKMhHjHhthRies3TXmlCX8AjnBAiuyj8d7lRpyyg3IbFWTlSJIcrr0mP+qsK47aeOYyYfUd28N+/BT04Vm/HRHFYuTx/EqYH0947JBJsZjTfXv3v2ohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056016; c=relaxed/simple;
	bh=H8PwpoTpcJ2Hd8r5WjAyT6sKGBy9cg/2eJ8l296kkrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwP/p1u0o1xQdDumgPojsgJBSz8SQhgjezxXuU/VzdzfO/QSTA3wAnysynNyjOfvUW+gc7WFkRX9Km3N7Ux7Cm06+ivqGeN/ffaOzColAArEKy/ZN8e1M5JaqPCdR5YxIfo5FzoQXh6mI2jCKCf97Z7B4gnyCzgThdkEnuAuxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dNQOquCD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a9EORR9Z; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dNQOquCD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a9EORR9Z"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 006BDEC01CA;
	Tue, 21 Oct 2025 10:13:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 10:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056013;
	 x=1761142413; bh=yhWjJcaGbJG78TXh/d2+QPA2k2pZRbpfdzDyz+cx9DQ=; b=
	dNQOquCDkLDzdxV1SRfvoyWnqI9BHHHhxP0hPwRNGwgdH0QiU/3lQih4nByS5nro
	anAdD2laH4VQNlSBpnMt5/4t0hBrRf74c0A2Zysk9u0dLak2t6AVBHqI2zejBy9g
	o9aZa03YlsGNPqBcrqkdA4+vHZPgLQBTKrgER1JWDcJ3VF0WT5+MZXUQt9snFaOt
	6phirddrfB8YLmy2+VIEty3cCkAIkI7o3yh5XpnoAs0ii1B3OGSZkWEDp3LoTDeA
	sd5UmRnllhNuFVq8lK8Hd9O5r10FsTYD1MVkbCJXJ86Xvg/APZhtx6iMTPKYwCPv
	aXfVwaM49bkrGoHRklVKag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056013; x=
	1761142413; bh=yhWjJcaGbJG78TXh/d2+QPA2k2pZRbpfdzDyz+cx9DQ=; b=a
	9EORR9Zrs4WaKbytDQHWPd7O0Ei3sLIx974VE5d+AI3aSK1io/fO7d50F3UrHBce
	83Lw3pdQD4Q+uU8+7vsfog+HgwGKSQ/FUm/NZTIC6LZCELEsDru4J8Q3mF+E9dbt
	xfP3TsBYUhNNulj4YlXt+3V+IHAn+u7ewT/lLR+I5PRIOkzLdb7HTpRU2Lixzf7a
	OSTtfDlhw0ikSg8zDKMTjm0FE85f18tQAy9IVWbwZYZKVEPRPby8487Dja2NN0Kg
	sKHLPOGrC5B+2bPeDNe8xcf5a9vqsGwIsIXdTlqK11mTVej3hiYmNOrKJq3l4Nvc
	NBHtLQCpAffypgPs4ibdA==
X-ME-Sender: <xms:DZX3aL8B69AuPxSWKfJ_zFLr-3xSQqaJj0qW8aZ83GHeeVRBAlJhpA>
    <xme:DZX3aPJPhwevq8fBGPAi9Fl_jcP-STDvtHldAQGMbWa8YwK4mYsiEkbV7EaL09Vnf
    9orqUZpXFSA39Yglwe5Ozr4K7VSLNMAvj_e7Uhx76TrKxIdjyD3>
X-ME-Received: <xmr:DZX3aGZ-Bor2St_JypxqoVkEGLuk6rpKcYZN2qwPf82MA5olbPglbFk-1FLyK7FQGs2rMhyejlI7ChG2jf8DS0xgfY0OWEtvY3k6gwh8YPzNeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DZX3aBL5JX3sKIcIr_5bqM9I9dNrOsfdHu6GArjJrCEj2AFjr1l0IQ>
    <xmx:DZX3aEC06gkfglH-5ryB4bpyJrMiIPBSZ7qQgQK6lHCksNfQsg3tLA>
    <xmx:DZX3aGrAccyecz49tn3ONj5Pr5bJM27xv27mGBCBv6KFuMw9N4VSZQ>
    <xmx:DZX3aPgy2frKmlQp8BKrk4493_BcR1VgVOWm7fqeFR8tl5YZpt_0Wg>
    <xmx:DZX3aJkQEfEL579gjvMghx8nCa9EpzCwN0jgPqdWbNuZwPq9QAv_PUEl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:13:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9d0b1b3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:13:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:13:24 +0200
Subject: [PATCH v2 2/9] builtin/gc: make `too_many_loose_objects()`
 reusable without GC config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-pks-maintenance-geometric-strategy-v2-2-f0d727832b80@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

To decide whether or not a repository needs to be repacked we estimate
the number of loose objects. If the number exceeds a certain threshold
we perform the repack, otherwise we don't.

This is done via `too_many_loose_objects()`, which takes as parameter
the `struct gc_config`. This configuration is only used to determine the
threshold. In a subsequent commit we'll add another caller of this
function that wants to pass a different limit than the one stored in
that structure.

Refactor the function accordingly so that we only take the limit as
parameter instead of the whole structure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e9772eb3a30..026d3a1d714 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -447,7 +447,7 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
 	return should_gc;
 }
 
-static int too_many_loose_objects(struct gc_config *cfg)
+static int too_many_loose_objects(int limit)
 {
 	/*
 	 * Quickly check if a "gc" is needed, by estimating how
@@ -469,7 +469,7 @@ static int too_many_loose_objects(struct gc_config *cfg)
 	if (!dir)
 		return 0;
 
-	auto_threshold = DIV_ROUND_UP(cfg->gc_auto_threshold, 256);
+	auto_threshold = DIV_ROUND_UP(limit, 256);
 	while ((ent = readdir(dir)) != NULL) {
 		if (strspn(ent->d_name, "0123456789abcdef") != hexsz_loose ||
 		    ent->d_name[hexsz_loose] != '\0')
@@ -703,7 +703,7 @@ static int need_to_gc(struct gc_config *cfg, struct strvec *repack_args)
 
 		add_repack_all_option(cfg, &keep_pack, repack_args);
 		string_list_clear(&keep_pack, 0);
-	} else if (too_many_loose_objects(cfg))
+	} else if (too_many_loose_objects(cfg->gc_auto_threshold))
 		add_repack_incremental_option(repack_args);
 	else
 		return 0;
@@ -1057,7 +1057,7 @@ int cmd_gc(int argc,
 					     !opts.quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
-	if (opts.auto_flag && too_many_loose_objects(&cfg))
+	if (opts.auto_flag && too_many_loose_objects(cfg.gc_auto_threshold))
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 

-- 
2.51.1.851.g4ebd6896fd.dirty

