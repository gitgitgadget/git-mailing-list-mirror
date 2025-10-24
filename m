Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14D2797B5
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289071; cv=none; b=i/06XRWGuNeHYliahyW1GIYvQGOqSQCdFB6Btf/T4gBILFkLt7jyKHWIJHvEil2zTriSqm8+dqvr2QnaZUSgXa8VPFidnkE5udoTS+AoA6AozaF+YE5yKz/JfAmjeGoGYC1ymEXXpyVT10o/BlkoMty4w/YG3B/Nv0cmOiuoc0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289071; c=relaxed/simple;
	bh=RGU/S3X33S+MU+74zslBN05OBc3x31pufwnWpeGK0mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0wfsYPhvUXcPUMdaSNFGLAjZm7oeHFZfmq3IlQtMHLFaXkoLLCf91HdlnJE3nR0ubbygmozU/aVFIV+6jpf7KMyBICOWmG3Hpi2lIDsIBEd43244Wh5gkV0Kd4fpYST67rDvXukkL4XKbfLI+f27qSBYTmmcxQiUGRi1Ci4ZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=djByJqC2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HhhfQAwu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="djByJqC2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HhhfQAwu"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1AD41400157;
	Fri, 24 Oct 2025 02:57:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 24 Oct 2025 02:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289068;
	 x=1761375468; bh=D42Alpf5d+OEbhnmQtmPNg5arDz8T2fDBikIh5XTxjI=; b=
	djByJqC2wqHmUeo04Hk/TfYvyAfq8IaC++gUFZD42Cfj4KXKpsV8zvAWYwTeK+L7
	tt4sahgkHr2PuIhbyq5GDZlgeLpqE04w48zqeY8KlkXqmYsCr+xNQ47t+q5403v5
	zZEb+MtdOnQuNtNgA2UPA1a9LTa9iiflwnASxFrgUXOZG9tIznMjg1xSbVCdDJpA
	zRwpiJjS/KuP8i8xmG9FkGdRXYoH/2uxOIpSxnCilsUFKbyV3lT3xTP6bYL6QNup
	rKjmCzHkn+MiG2UeNVf9flpZ6EH158Vmrq6TbMeBjQZaAlMaM0rUPO54Ut6MoJTT
	I3mB6w/3/gfNxbQ9PF6LZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761289068; x=
	1761375468; bh=D42Alpf5d+OEbhnmQtmPNg5arDz8T2fDBikIh5XTxjI=; b=H
	hhfQAwuLXQOV2kJPtYhXZkyDsI9gs0jZEPBuGvWmGFALLA5oKMfTXK0kdLHcK0Zg
	Kp3vY96r/Rcw8ORlUXySrEVmJjCs9f7kcIaSI4U1/AqDd6XKFuIpNSFdhe+gTvGS
	JOwVMr6Ia5cz7ucm1vfd3PGAIWTxTlc6rd7PCbecNZJj1hFgiEwAAJVFZbDfxhX4
	sell4ppKtjiAsK1+8XIJOE6OSbaoGNFios3Flzl9z/hwTeGFczTt3zox8kIUMraY
	xyp7br1u1Aj57gB0qphJyiYVWtL/eTvhUdu81XHNciYNfFYi+ndU9FbbYOq57XeD
	dMUQfF3o1RCKsJq8PB2iA==
X-ME-Sender: <xms:bCP7aLBBDrIobYUVmN_SawW-fLZo6zf1eZCCJo__AJRPI2A7QZemvw>
    <xme:bCP7aIb-guhSQTmE9VRFfX_Uae0N-mhmeQOKGjf9v-F1dXymY8_Lb46E_iFDxT7ie
    k_JxD-Mv61BQf5Hk3D3aj0xA8_wzfJcgmvrlwj8vmfPOEY8m5g>
X-ME-Received: <xmr:bCP7aO5VDSsx9bSKRR0tqJD3gsPLvOxyy015-w3P9Ar5pDWUO41KNeKolPY28RWx7ZkUZrcPUmA2FDveubghVjb016_T9XwDaqE3anNPrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    htohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bCP7aJaU6nCAJRQEe1gA-W2p2HyNSSLT30ASAh79BUdPSwMViByOlg>
    <xmx:bCP7aNjEvRh9Dj6eYtyRHJ7uxeon9_4AtBcrKdu9_afa42iQUX8xpg>
    <xmx:bCP7aK85w9IuULkx6k0EoRw6imkIQXgOcv15hH4nEuL6Gnpmrzd7Dg>
    <xmx:bCP7aIoRgGhlVIdcJqsI_UwgPTlkWmEa7ztI2TVnS7it4vd6opoaMQ>
    <xmx:bCP7aJx9AT843R3KLPvxQ9sugp8iI_0z5rlhRtiX4uu-3AeqN7JmoaEf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:57:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb6cf73f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:57:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 08:57:22 +0200
Subject: [PATCH v3 09/10] builtin/maintenance: make "gc" strategy
 accessible
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pks-maintenance-geometric-strategy-v3-9-9b5b3bdb4387@pks.im>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

While the user can pick the "incremental" maintenance strategy, it is
not possible to explicitly use the "gc" strategy. This has two
downsides:

  - It is impossible to use the default "gc" strategy for a specific
    repository when the strategy was globally set to a different strategy.

  - It is not possible to use git-gc(1) for scheduled maintenance.

Address these issues by making making the "gc" strategy configurable.
Furthermore, extend the strategy so that git-gc(1) runs for both manual
and scheduled maintenance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  2 ++
 builtin/gc.c                          |  9 ++++++---
 t/t7900-maintenance.sh                | 14 +++++++++++++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index b7e90a71a3d..b2bacdc8220 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -30,6 +30,8 @@ The possible strategies are:
 +
 * `none`: This strategy implies no tasks are run at all. This is the default
   strategy for scheduled maintenance.
+* `gc`: This strategy runs the `gc` task. This is the default strategy for
+  manual maintenance.
 * `incremental`: This setting optimizes for performing small maintenance
   activities that do not delete any data. This does not schedule the `gc`
   task, but runs the `prefetch` and `commit-graph` tasks hourly, the
diff --git a/builtin/gc.c b/builtin/gc.c
index 3c0a9a2e5df..8cab1450095 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1843,10 +1843,11 @@ struct maintenance_strategy {
 
 static const struct maintenance_strategy none_strategy = { 0 };
 
-static const struct maintenance_strategy default_strategy = {
+static const struct maintenance_strategy gc_strategy = {
 	.tasks = {
 		[TASK_GC] = {
-			.type = MAINTENANCE_TYPE_MANUAL,
+			.type = MAINTENANCE_TYPE_MANUAL | MAINTENANCE_TYPE_SCHEDULED,
+			.schedule = SCHEDULE_DAILY,
 		},
 	},
 };
@@ -1894,6 +1895,8 @@ static struct maintenance_strategy parse_maintenance_strategy(const char *name)
 {
 	if (!strcasecmp(name, "incremental"))
 		return incremental_strategy;
+	if (!strcasecmp(name, "gc"))
+		return gc_strategy;
 	die(_("unknown maintenance strategy: '%s'"), name);
 }
 
@@ -1937,7 +1940,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 		strategy = none_strategy;
 		type = MAINTENANCE_TYPE_SCHEDULED;
 	} else {
-		strategy = default_strategy;
+		strategy = gc_strategy;
 		type = MAINTENANCE_TYPE_MANUAL;
 	}
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 5219bc17a69..85e0cea4d96 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -915,7 +915,7 @@ test_expect_success 'maintenance.strategy is respected' '
 		git gc --quiet --no-detach --skip-foreground-tasks
 		EOF
 
-		test_strategy incremental --schedule=weekly <<-\EOF
+		test_strategy incremental --schedule=weekly <<-\EOF &&
 		git pack-refs --all --prune
 		git prune-packed --quiet
 		git multi-pack-index write --no-progress
@@ -923,6 +923,18 @@ test_expect_success 'maintenance.strategy is respected' '
 		git multi-pack-index repack --no-progress --batch-size=1
 		git commit-graph write --split --reachable --no-progress
 		EOF
+
+		test_strategy gc <<-\EOF &&
+		git pack-refs --all --prune
+		git reflog expire --all
+		git gc --quiet --no-detach --skip-foreground-tasks
+		EOF
+
+		test_strategy gc --schedule=weekly <<-\EOF
+		git pack-refs --all --prune
+		git reflog expire --all
+		git gc --quiet --no-detach --skip-foreground-tasks
+		EOF
 	)
 '
 

-- 
2.51.1.930.gacf6e81ea2.dirty

