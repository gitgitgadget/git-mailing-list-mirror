Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E02FB610
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599623; cv=none; b=KEeMlbhyfaiaUsiDG9oyhgIONUO8hDH3NYW9WX+lQAKwpUmI4DuJgOakcRsQ7FRjy7NWXiLWLrY25U6id2zODu/+jbxFVv/PT3VtAkfHICRa0qXrWg693PsIGgAYv0ke8tK9WOQOOrR2kUWxW9Kco3Cl2A1fOsXEKDOyMEAByfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599623; c=relaxed/simple;
	bh=0yTNoj8exPLejbHZdlsRtBjgTFVjaW/pKkwfXOOd2Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HE4nFiDu4kzTrGUXXVFuem+V13Iva3SJVEuc3JuwygTdWwur95DabITS3lqdIA2BmyVM9zbl13CgipWz/epuWxZmOdGUE1mBZjZm9wMu2LIg+elZjPFNWouxIZZp4M4nPZoDsjmN7K65YepKanoIf4UYVrYPkpez9w2xI+fNEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n8RS4yh3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cs+zsyd5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n8RS4yh3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cs+zsyd5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 31789EC00D9;
	Thu, 16 Oct 2025 03:27:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 03:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760599621;
	 x=1760686021; bh=MAs6UTFGh2QoNQLsmoJ59+r2xiBIF3/1Uhw3ne0/KNk=; b=
	n8RS4yh36NAmwnVOgqL0Twid0L0Li717+ZZZVbaahZAZMM5coSMP7uaiJ4FFezZ6
	OmQjE8/JPOm/5cPCJ32ePC/zA/eP46y4vcUbA5DVOu2c/OVdVyi+RDKAc6R5U1jY
	UslVGplGn57AECiqezfFfXuooUew2c6YLManKIo4d+wYaX4gfUlATATa/a3jdZPD
	6nsGATB3cmL1ebht30BelE0Ha2ve8FBwsIu0hilJ24qmj3BvaM2HZhzSkSwUb08s
	5Q1lpSkY7CJSciB6vzFplpnty3riODe4lmyeCnB5YIZI/9cD0yTvtpCOrdOrfe64
	GaPv5ilgR7Z/AUMbjdt0Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760599621; x=
	1760686021; bh=MAs6UTFGh2QoNQLsmoJ59+r2xiBIF3/1Uhw3ne0/KNk=; b=c
	s+zsyd5sTL9Fo6P1OdZpIyurJvdMERVWCOIAQWAGOeE8U0OtwxyuoS/Vv+lFP2Dm
	krp71FR/ROzsUdxJLxou+MGb6tlFyVqPlsEnjOdG46JmS9bPr7owVDSpu2awodEi
	OIDRTl+Ri5e9tgk1NWrpot3mH5oDfdmXiDpPHcWuf0H5ZyHgo4EM+1evhRRzuLYY
	3WKLX4en8Z1INDN5B5ekJFUQzxZvyY6ioEraVm8rxom1FhaJc7mIelnJCeeLb9fR
	wqMG5OmWtrq0P1n1rNKF00hibfNVL7Ri/ISq4ycy0VusHtPY/MrtsfswKmc1g8LP
	409tihz6P9QpgkmFu6OHA==
X-ME-Sender: <xms:RJ7waFWAeOh5yvsWT3e81j75ZkGCy2JKF3LcwviVvpBZdeiKyEK8Nw>
    <xme:RJ7waND5yPTlGAMxusVthYdfuFKODy3t0UoDsH3AcIjUPoHNzgE4M3ZkZNE-gbOvg
    RH1VRAgIfaiquheY6eF3cL609z86m4Kni35HNHkfR3HCHvRPC-gHw>
X-ME-Received: <xmr:RJ7waOxFQaoY2XSaOWytA18IDQtpuEl-a9XA-Q7F7AuwvHndO3o5LaCTqMNqYBGAST76SAJNTReZCRCYjts7EyZNbYub4JpvBII4wj6HHLmjGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:RJ7waCBR9yi1wJaOfBXNFrdRpujiZKoLz3HJJPvHSw9A3bmSK17Scw>
    <xmx:RJ7waDbGEZjeCFWPYWotWfnQjcPZGAJ_Ee9EhELbow_dvj3oaukOFQ>
    <xmx:RJ7waChq_095AmdjoZ27cDVgwSGLSRF32ANyrdhvByX3SzvWgM34aw>
    <xmx:RJ7waN4s04Nf2bi4StJkTXQoLLqiZlogrtG7ZPnH6JVdXzxaRNADtg>
    <xmx:RZ7waBc51pxClkO4yue13ChHR3j6ZoADG0YtXTWiZZ9NK262W6fPTlic>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 03:27:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 895c7b72 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 07:26:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Oct 2025 09:26:36 +0200
Subject: [PATCH 5/8] builtin/maintenance: run maintenance tasks depending
 on type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pks-maintenance-geometric-strategy-v1-5-18943d474203@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
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
 builtin/gc.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e358e8d13b4..4f70650e7ac 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1820,30 +1820,39 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
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
 
 static const struct maintenance_strategy none_strategy = { 0 };
+
 static const struct maintenance_strategy default_strategy = {
 	.tasks = {
-		[TASK_GC].enabled = 1,
+		[TASK_GC].type = MAINTENANCE_TYPE_MANUAL,
 	},
 };
+
 static const struct maintenance_strategy incremental_strategy = {
 	.tasks = {
-		[TASK_COMMIT_GRAPH].enabled = 1,
+		[TASK_COMMIT_GRAPH].type = MAINTENANCE_TYPE_SCHEDULED,
 		[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY,
-		[TASK_PREFETCH].enabled = 1,
+		[TASK_PREFETCH].type = MAINTENANCE_TYPE_SCHEDULED,
 		[TASK_PREFETCH].schedule = SCHEDULE_HOURLY,
-		[TASK_INCREMENTAL_REPACK].enabled = 1,
+		[TASK_INCREMENTAL_REPACK].type = MAINTENANCE_TYPE_SCHEDULED,
 		[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY,
-		[TASK_LOOSE_OBJECTS].enabled = 1,
+		[TASK_LOOSE_OBJECTS].type = MAINTENANCE_TYPE_SCHEDULED,
 		[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY,
-		[TASK_PACK_REFS].enabled = 1,
+		[TASK_PACK_REFS].type = MAINTENANCE_TYPE_SCHEDULED,
 		[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY,
 	},
 };
@@ -1860,6 +1869,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 {
 	struct strbuf config_name = STRBUF_INIT;
 	struct maintenance_strategy strategy;
+	enum maintenance_type type;
 	const char *config_str;
 
 	/*
@@ -1894,8 +1904,10 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 			strategy = parse_maintenance_strategy(config_str);
 		else
 			strategy = none_strategy;
+		type = MAINTENANCE_TYPE_SCHEDULED;
 	} else {
 		strategy = default_strategy;
+		type = MAINTENANCE_TYPE_MANUAL;
 	}
 
 	for (size_t i = 0; i < TASK__COUNT; i++) {
@@ -1905,8 +1917,8 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
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
2.51.0.869.ge66316f041.dirty

