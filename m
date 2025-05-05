Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0EA1F463F
	for <git@vger.kernel.org>; Mon,  5 May 2025 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435116; cv=none; b=RUt/p4Wro+Y/s8UsDTK0+bR+bLDFHfCItWz7yz0c+8pBWGTm77b38W1AFAr6Wi64L4dmIv9YE5ThvchTOWTTa72Iht9eUW61AvvZChNyCxeFX/9/YjJmOQ1zBKT9/kKa+67CLolhP+wQdZwTZt2bBRxH/9ra/wb21ez+TWdFPuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435116; c=relaxed/simple;
	bh=ZCE37KZIKfwqDy1+ewJJRE0wpy0DfGKIVSBYRyZoQuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FumvU4yNVt3HjK4f5J98i/1bGJkxTt+/MXTemEqXvIUH/5/vfaMTZT3NZ4T9Ci78qyOitMkU125BoN43sQiN8V/oN8BEiOeCHchbqhKVGotn76jPC0LtaP3hzoMhxKe1b961XxVCGa2WjUsPzjRjWYPDSCh0YwabJ7a+0AYNQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=06fc39B7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cm+TDloq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="06fc39B7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cm+TDloq"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 064FD2540254;
	Mon,  5 May 2025 04:51:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 05 May 2025 04:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746435113;
	 x=1746521513; bh=X8kv3tFVyHvQxEtGxGzjtiGoIk3mQdY5oT69IcWZPHc=; b=
	06fc39B7LK4EgdtTyfPjwwEmmNDcxB08tDXW2nH+F5zS8QBWbYTLGkCjFFz8BsO6
	sM/I/CDAvtUeGDDz4P/JEHs/tR+yEhVvaeBNGWNz0BgBfT3U6+rs3HYFsQ4fas00
	W+tVpd4Ujs4XPTi9e1C4Mc4QhXEjrSRgL1QM05zKtB09vzQRrUWzaJAgJ9IOGkPA
	qkD7i4pkUcWTIJtw70i6i9VOjtOKvfq2iJZX6W3DTFW1Lt99ERC2EGJyzNK0AmIl
	Cze/Y7MVR+AcKS4kv/gX+o4KWumfJNS9a5SsDrLLuLoiWCb/OPtepskpqVSqfGIE
	PR7xRv51iI3iX5DcjLa+mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746435113; x=
	1746521513; bh=X8kv3tFVyHvQxEtGxGzjtiGoIk3mQdY5oT69IcWZPHc=; b=C
	m+TDloqhUxlHpb7PVuQ6l/SYvza3UQaDk/Tb3rsLHCEfwTxoKo3RQXAoBbzaIXOh
	3d7sJIjPgkQbLKWZXQvQRKQUQNitO9t9/8Pkal31DR234i33k76/OBy8ppgUcBA2
	x10zGCWO2fvIPSSjYFpENkAOEW55w4f/f4nGsq4VwJclviQ0sTikyU4UZQrBedUq
	IMUvhuSweTVB4ypOlwFXuGxpjcRHrFI0nHTgqwWHhmSYpcjWVRoFUl/9AKEeXdAO
	1ZD9jTITwOwwgvpAPI8TsVxDnM1sFA5CCWenxWPqaVm+3iXlGhjdRhjctKBXzHkb
	/kiA5+M/KSSL4M16Luu4w==
X-ME-Sender: <xms:KXwYaMg50vCUZaaPNN0kcKgQUpNWl9EOVFnKZdAOhgifKBcEetpenw>
    <xme:KXwYaFBmwmUKUzIsLRYB6NroJO6X47xE7UTNX61YN8AuGLCxiP91QrjLsYXQgXEm3
    ksLXDpOYtU8HIrsBQ>
X-ME-Received: <xmr:KXwYaEHI0aS5aWserOeSEulNqVxK5vCgsFyV1FGumi9GD5F5t-0-OiYm8LgEGzsZuOOnUVC1dPKh5JVZ4bK_Msp1jE7UYpHDXJ5EuHfMHG74pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KXwYaNQVDObwfZLw2S1hbGtwFTnEvn6wO6d7j1MvJcc0DvaSaJyU3Q>
    <xmx:KXwYaJyHdQIH0K3WmZaH-tnx0xaCIJ4kL9bidrTd4Hgv-iHmgb3ZcA>
    <xmx:KXwYaL6Bl3DGx-hGqw21O-T-3QAw-sfutTMlUIRx8VNLXLH7bjMqTA>
    <xmx:KXwYaGyD2ODYbXO8NfyaQ-GYMEDTov2x6Ca2DC4kYiia4yAr3iHhQg>
    <xmx:KXwYaAvW3s8pSPJB4ZVPSW25VrvCflsQ2rlcj8yraPr168nK19w0KdLx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 04:51:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12bf816f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 08:51:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 May 2025 10:51:46 +0200
Subject: [PATCH v4 6/7] builtin/gc: move rerere garbage collection into
 separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pks-maintenance-missing-tasks-v4-6-141f4df906a1@pks.im>
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

