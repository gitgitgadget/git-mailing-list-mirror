Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18D2877E7
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289064; cv=none; b=IRmQ1/xn7yfTxJNqd264TF42ZK0Trj5FZfhtJTI5Nc9xIusBWZub0m39dXLIXdNwBKbJDm1NR5aYzbktChpgzEIhS1VmJCspPfnHTsUgIco3Yx7qQAVItqwSL2ubVfvfbYhL5IFUVRHsaDv7R54q760jC1hKFzo0anivAHcqIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289064; c=relaxed/simple;
	bh=citOsjkZ6cvn96gtYk4ahMGKPenman9I7ncpjsbkYVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TXgnue0OflzOLzUsuuliyCh1zo6UYEat6Xtk1FrXpKF/zVIEAAK4vVn5lJhzDzK3dr9KwAZi1dniXwjdoKNmI4wd2dMRXDgLQ0nec9dAWve+UDpjkjRwRs+v0dcuTXUvZPJwHjxk3b5b1YVwpyR9YtrEX1Yf5EQxtFEt5Ioiayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qc/LweY1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PaUhUbwK; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qc/LweY1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PaUhUbwK"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14D321400157;
	Fri, 24 Oct 2025 02:57:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 24 Oct 2025 02:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289062;
	 x=1761375462; bh=mNnyughJLDp6tMyg4oyEpKZ6uCsIgSCAw2rol0I6oqE=; b=
	Qc/LweY1pj56x9smPcgUQZr+RS3eC33o2h/Qo5KIk33N2X+XXNlQocN0KhZZvh4E
	bAPJUns5OGRbXSIqvxPcJoz+x0m7uD0nco/kdPlBqZGah/DBDPgsEu6tRXWc+SAC
	s0w6x3bk7gsbHVfruUdJC7d9J6QQonMVDSi15Pbf6qZw700gKDR5Z88Y1sNn8V7p
	sjgvLvCpTpXcf5zrxUcmtkHk5N8+bgRKkVR3BNDCKw2YXs2p+trv8x1nZjR5Cm0J
	oT7JCRkZUaDpYDgSMAu/4JbN9V6YPZ7rZ35lgbOL3gsb8DF9HbHR3n4S8otw+m6W
	p0YFYiW8tI7fg+q5v2loiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761289062; x=
	1761375462; bh=mNnyughJLDp6tMyg4oyEpKZ6uCsIgSCAw2rol0I6oqE=; b=P
	aUhUbwKM6qqWrwNBA/Q0e1I93o4aRRPhIrMlRz/SQD9zYyRSEjQ/fpC/EJyOh8mh
	6xnDKhnGK6jSxnm0RSxW12nCFSVJLBGqg7QMB1mRm89WWjsoaM0hHYx7iXeMqV09
	1Yqyrp/cvXm+3wB74MoBcT0ktIAn12E0z3sR/E/hpYcxR7hotIj5OoATmFgzxwdC
	NbRaqv1DlaaHREk22SmGtreFCSVXWWFF7kj4kc8lqFc54koq8O+Cc0okO91zf1Y7
	SzfziFwRvyPbrP5j5ito96ad4DcdVK5SMrBWmbVz3134tFpA5zv1+zPL584KNAbs
	/IsI/Fxq2x3+IWQSbJEqQ==
X-ME-Sender: <xms:ZSP7aKe9_BrOvon5QSiRmmAo6mvauQvitEVcCAw5EsQmSkeRi6oSEw>
    <xme:ZSP7aLGwIVOBcIZMejDFGuoXbriFU2tiK60cF3-cKC1obUfqIm7rn_tFpvitdMne3
    aDmqVnvy7oI9kbw0og26uJMmwuTxPFiH594Bi-zpi3iFJnRORw>
X-ME-Received: <xmr:ZSP7aD3UVa4w47qxqICwHjglD55jxQDWXiWcdNXSjP2-h_2Jo5OYaTuxid-fxwCCWhLqGN-zDKYsl1uQTXSou6UHG6z4IoO5QZOZr6fXmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsh
    htohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZSP7aDlWF2s2fIdMJGw4YTWXURXXsY21gIydIrZx_EUHbm-8MBJcrA>
    <xmx:ZSP7aD-pCLCbT_AZM55YHcRXPtQo_L232dCqpP_mjL6nZXwa9niOiQ>
    <xmx:ZSP7aIoDz2fpuycSyHqZD5P7Lb3GVMdc_8vBfGtoyfwZMPax83qI3w>
    <xmx:ZSP7aMnFw3Xz8zWvqu4f4RannPR3BBxI6zC03ytYafWbL8gdomlLzg>
    <xmx:ZiP7aN8PdO1lJpnYmed45XsoiVy_-VkYvxw8tVDn-FgGd9Ebg8tnozNS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:57:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69038751 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:57:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 08:57:20 +0200
Subject: [PATCH v3 07/10] builtin/maintenance: run maintenance tasks
 depending on type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pks-maintenance-geometric-strategy-v3-7-9b5b3bdb4387@pks.im>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We basically have three different ways to execute repository
maintenance:

  1. Manual maintenance via `git maintenance run`.

  2. Automatic maintenance via `git maintenance run --auto`.

  3. Scheduled maintenance via `git maintenance run --schedule=`.

At the moment, maintenance strategies only have an effect for the last
type of maintenance. This is about to change in subsequent commits, but
to do so we need to be able to skip some tasks depending on how exactly
maintenance was invoked.

Introduce a new maintenance type that discern between manual (1 & 2) and
scheduled (3) maintenance. Convert the `enabled` field into a bitset so
that it becomes possible to specifiy which tasks exactly should run in a
specific context.

The types picked for existing strategies match the status quo:

  - The default strategy is only ever executed as part of a manual
    maintenance run. It is not possible to use it for scheduled
    maintenance.

  - The incremental strategy is only ever executed as part of a
    scheduled maintenance run. It is not possible to use it for manual
    maintenance.

The strategies will be tweaked in subsequent commits to make use of this
new infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 0ba6e59de1..6cc4f98c7a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1827,9 +1827,16 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	return result;
 }
 
+enum maintenance_type {
+	/* As invoked via `git maintenance run --schedule=`. */
+	MAINTENANCE_TYPE_SCHEDULED = (1 << 0),
+	/* As invoked via `git maintenance run` and with `--auto`. */
+	MAINTENANCE_TYPE_MANUAL    = (1 << 1),
+};
+
 struct maintenance_strategy {
 	struct {
-		int enabled;
+		unsigned type;
 		enum schedule_priority schedule;
 	} tasks[TASK__COUNT];
 };
@@ -1839,7 +1846,7 @@ static const struct maintenance_strategy none_strategy = { 0 };
 static const struct maintenance_strategy default_strategy = {
 	.tasks = {
 		[TASK_GC] = {
-			.enabled = 1,
+			.type = MAINTENANCE_TYPE_MANUAL,
 		},
 	},
 };
@@ -1847,23 +1854,23 @@ static const struct maintenance_strategy default_strategy = {
 static const struct maintenance_strategy incremental_strategy = {
 	.tasks = {
 		[TASK_COMMIT_GRAPH] = {
-			.enabled = 1,
+			.type = MAINTENANCE_TYPE_SCHEDULED,
 			.schedule = SCHEDULE_HOURLY,
 		},
 		[TASK_PREFETCH] = {
-			.enabled = 1,
+			.type = MAINTENANCE_TYPE_SCHEDULED,
 			.schedule = SCHEDULE_HOURLY,
 		},
 		[TASK_INCREMENTAL_REPACK] = {
-			.enabled = 1,
+			.type = MAINTENANCE_TYPE_SCHEDULED,
 			.schedule = SCHEDULE_DAILY,
 		},
 		[TASK_LOOSE_OBJECTS] = {
-			.enabled = 1,
+			.type = MAINTENANCE_TYPE_SCHEDULED,
 			.schedule = SCHEDULE_DAILY,
 		},
 		[TASK_PACK_REFS] = {
-			.enabled = 1,
+			.type = MAINTENANCE_TYPE_SCHEDULED,
 			.schedule = SCHEDULE_WEEKLY,
 		},
 	},
@@ -1881,6 +1888,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 {
 	struct strbuf config_name = STRBUF_INIT;
 	struct maintenance_strategy strategy;
+	enum maintenance_type type;
 	const char *config_str;
 
 	/*
@@ -1915,8 +1923,10 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 			strategy = parse_maintenance_strategy(config_str);
 		else
 			strategy = none_strategy;
+		type = MAINTENANCE_TYPE_SCHEDULED;
 	} else {
 		strategy = default_strategy;
+		type = MAINTENANCE_TYPE_MANUAL;
 	}
 
 	for (size_t i = 0; i < TASK__COUNT; i++) {
@@ -1926,8 +1936,8 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 		strbuf_addf(&config_name, "maintenance.%s.enabled",
 			    tasks[i].name);
 		if (!repo_config_get_bool(the_repository, config_name.buf, &config_value))
-			strategy.tasks[i].enabled = config_value;
-		if (!strategy.tasks[i].enabled)
+			strategy.tasks[i].type = config_value ? type : 0;
+		if (!(strategy.tasks[i].type & type))
 			continue;
 
 		if (opts->schedule) {

-- 
2.51.1.930.gacf6e81ea2.dirty

