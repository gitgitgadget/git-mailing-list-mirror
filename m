Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FE33B974
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056032; cv=none; b=YMrEVlyNzK6cxd02okR+plc+uTK/u1nodONQhLF1x3oTAq6CfmkhVnpXREuoP0tfbQiRqUjKH6Ni2Q6P67JxEsGpSv9dHHQqt1JDgjlLYbrZ9U8RgmCvBY8yRsg7K6NU8WL5zZgssE+1Wbg+T7u3dSEdAccU+v+a3YAhC9Qr2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056032; c=relaxed/simple;
	bh=9lFGXQontcARSVtE93/JDTuFbA6HH6o0rGE848r7tlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/6wGwnWG3WLkVp6b75DvNPNyHl2ozkkJNupbHVB3o3Dl+3ikFFBsE7rRwOFZi3YUjfSe3m63wmvtnRTuqwKglNtCluep+XIH3YjNUQfmQ2b/jnbHY1Ekm5qPuCK7ybi2rX4UW3jrzAjFCDyBFb+be85DK1qr7tGHBCi0BSWZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hda3q+60; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlkRCwe9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hda3q+60";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlkRCwe9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AB4CEEC01F4;
	Tue, 21 Oct 2025 10:13:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 10:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056029;
	 x=1761142429; bh=nRdNS7+syMUfUBrscLsaCTfmLh0or3gk3hWLaEDRKoU=; b=
	Hda3q+601WOEBl2x10oV7uYxdodOGHI00I7FjY7zlY+ECM+Uj3hyqxOkPg7kiiW8
	g2xmVgK+1XUGR/M+Tg8c6w9LFkHKwWcoCM0g9UEVJ3SDtjSQtMCqaQyLX50Wtixs
	/MsrPo3Pn3f7GiQxSsBpKHaVCxUddlrI+roCvJxqvQypXGjIAjT+5zd5XUm+iEBC
	8N9qTs7DG3FJcpq9+HePUKAFXD/kJZsZqOnd1fRUg0yZq/KSJ+ux/zn0FQzZrmy7
	FXuDVG1CltFJbDgTUEktw7gjzihM5KwxY/zyAWoM3m1CXVbNDqAXZ4fBqC5zg6zP
	lwtjF/b7pvJn4xiV3CxPQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056029; x=
	1761142429; bh=nRdNS7+syMUfUBrscLsaCTfmLh0or3gk3hWLaEDRKoU=; b=G
	lkRCwe9y92ZZu0jfdYbN/AudN3oA7+SGeZEvnMP+F4D6br9dSgiE1Z6qkVffY70Z
	1S0woRDLs0ISzgUpH0uNSnEN4Ms5+D6jzpPHO2bVLdc5HnxTs9mZWcByZ/bOU3Gy
	8kdqlMyDxV5XPh04LcgNWiv1TWzxhecf6ZCZd7HUoL6Ytib5Im8/F8//PXXPYGyW
	BenLOKw0wfq+QRkbPvliA1Ha232LvU5vmmgcv4/IaNTWdpCZW1J2KiZJ8bzTaZlD
	6qnBcj6peW14iTx+q8bTExjeIyWHTkYhEM0xX2Vfv94eo858UO6YMgsPD8BzAP6w
	Orf5MjvK1pnkziBsykiaQ==
X-ME-Sender: <xms:HZX3aDEKwF10q99uouDAGraaWEHWYG7WOmvnJS3bCoMES0XaQJPrSA>
    <xme:HZX3aHxU6gjD4cOEACB8IrzMlXpPzIErV0n1l_p69s_fYE8ENjVbuJykpRL_loFUf
    xabmeGvIBJA1GPf9DnQgwmoyWox1PROmM74QqjLU4bJ9zraK6AcyDI>
X-ME-Received: <xmr:HZX3aChpe_JHzhaarigfNVm7sZC7XjTWpLqja9j59NHZ2Uib5PmFqylUEbxmjN0eQoXFTn8oPEkMMC-T4-2BaNt-B-9iWnIWPDGphf45Cpos3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HZX3aKw5sKizkWXVYHUqAjiP3vE6GUeLToB_PFGBEK8Vx_X3jRGyiw>
    <xmx:HZX3aNKRyuPwcvMDWZH_G9lsMPAMdynSlgLoaxiYhlpY3UQMRRgUxQ>
    <xmx:HZX3aJRDbJAzigoNWPETpPHG30sBEmU_Xl8mFWkljDHK97-zbqfs_A>
    <xmx:HZX3aNrHEtWQ4H2FRPHMgWsu6VX4XyjeqqoF1vM2YT7DGf0YkTmTjg>
    <xmx:HZX3aAMGscKno2-W2Xs1Ollcpwie2CBSYJmZN5hLCVW6_hmVGpBgWSPC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:13:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20f648f1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:13:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:13:30 +0200
Subject: [PATCH v2 8/9] builtin/maintenance: make "gc" strategy accessible
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-pks-maintenance-geometric-strategy-v2-8-f0d727832b80@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
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
index b7e90a71a3..b2bacdc822 100644
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
index 9c05905b9a..aaff0bae15 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1843,9 +1843,10 @@ struct maintenance_strategy {
 
 static const struct maintenance_strategy none_strategy = { 0 };
 
-static const struct maintenance_strategy default_strategy = {
+static const struct maintenance_strategy gc_strategy = {
 	.tasks = {
-		[TASK_GC].type = MAINTENANCE_TYPE_MANUAL,
+		[TASK_GC].type = MAINTENANCE_TYPE_MANUAL | MAINTENANCE_TYPE_SCHEDULED,
+		[TASK_GC].schedule = SCHEDULE_DAILY,
 	},
 };
 
@@ -1881,6 +1882,8 @@ static struct maintenance_strategy parse_maintenance_strategy(const char *name)
 {
 	if (!strcasecmp(name, "incremental"))
 		return incremental_strategy;
+	if (!strcasecmp(name, "gc"))
+		return gc_strategy;
 	die(_("unknown maintenance strategy: '%s'"), name);
 }
 
@@ -1924,7 +1927,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 		strategy = none_strategy;
 		type = MAINTENANCE_TYPE_SCHEDULED;
 	} else {
-		strategy = default_strategy;
+		strategy = gc_strategy;
 		type = MAINTENANCE_TYPE_MANUAL;
 	}
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 3530895bfb..2770148fd1 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -916,7 +916,7 @@ test_expect_success 'maintenance.strategy is respected' '
 		git gc --quiet --no-detach --skip-foreground-tasks
 		EOF
 
-		test_strategy incremental --schedule=weekly <<-\EOF
+		test_strategy incremental --schedule=weekly <<-\EOF &&
 		git pack-refs --all --prune
 		git prune-packed --quiet
 		git multi-pack-index write --no-progress
@@ -924,6 +924,18 @@ test_expect_success 'maintenance.strategy is respected' '
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
2.51.1.851.g4ebd6896fd.dirty

