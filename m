Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3202E888A
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553881; cv=none; b=Pz+wqqyOblWYugTSAOk+OrNAKw+MDC/ueqMq9qY4a2qwZWLcxEoiFkyHQFcNsgXzXFLaBK8YM2s925bxLVroJ/a8bRBx/lfm9R7HMojH83sFHfGD6c+2nHJRi3IW0Ifp7fhZ0nGRzPjNXvSxeHRWBfTfutMN4vvCvqdXWyfFRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553881; c=relaxed/simple;
	bh=citOsjkZ6cvn96gtYk4ahMGKPenman9I7ncpjsbkYVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIGz9DIZr9LK+28Doz+kLW42FB1FgGxjviBoA+BBMOauolUs7ZwDpn7PuDnwb8/8Asbbdyjd4AWwZZKjBXsN4FJTMoJB4gDCGYuxtRoJ+6s2naJEjM3J/gEdhOc8bfjrXOmwHkXzBG81bJgQGiThwlb2CpH7KZyO+hSDFYLX3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d2cycN0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AkaRmdM4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d2cycN0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AkaRmdM4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68338140014C;
	Mon, 27 Oct 2025 04:31:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Oct 2025 04:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761553879;
	 x=1761640279; bh=mNnyughJLDp6tMyg4oyEpKZ6uCsIgSCAw2rol0I6oqE=; b=
	d2cycN0LGzBCV4vd8LttaXWTwt5nbHJYME5WjH/Voz6ATGBWn5lP2ZrTl8OJSsTc
	vL9bWGPfL+N1S4xqH8yqX6uhG4/mowQvwMPcHPXPuqI51rEsKidjdwGmKyyxZTt8
	TaxUqbe1yEq72LENywuPvddMJNCGmdDPAH9AkonJq/Bh1uLUWcVwqckhpyyZcuZl
	8aJggcagfsjvSUTCxuI+K9NUH2sEyyTjyvq1fmGFgnvSEPM3RpznaeesBRfMajTs
	rf/fb0Q80ddhMm9ejjkq90nGPRaSfO/lOCZko06DsjBDcKa6kdBgqvKdiz1rlMLx
	pXwIihR5zGhANMXvsIcsEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761553879; x=
	1761640279; bh=mNnyughJLDp6tMyg4oyEpKZ6uCsIgSCAw2rol0I6oqE=; b=A
	kaRmdM4iSvx7NnCXKcNa4FZtC8E2SjFmb1kKS7Sgc29gs+MOHjyUIRy/u99v2g2B
	czv6Vs8PzJJIXnPtRyM2jP+8v0TBUw5iRdm7BkmnRB4SuJ6Zqyb9U6Kp21XWmtcY
	p37frKFkXNbO5iUNSjN9Gt7zSjTeJIvHYk/z9RpYu9Smkh4AFvzWC4t9bb9YjCRt
	9FeMWSMj6tLJ8LaxBt1pK3ZiQT6d0IeFtziW4pjihbOgpoqzGFYC+NQhHRJn8iNQ
	Glzc2rbZXfrLKnKCEgtzw3XvPslHH+AZ0vjpZfMLutpN9OdGrwKxjD6SecoAQru+
	7E2Op1iaR5xYYzo3jY0lg==
X-ME-Sender: <xms:1y3_aHbKbT0qhB1eZNsfF7k5TU6ZhhFYr_Q_rqCSc9cLjnU_p5SswQ>
    <xme:1y3_aNQemt_yWMluXgoAezDVbq0-320ADAT4u-xlk1oSNxRVXtnSq-4tjavJr88d1
    T1N6tkL3D2hLb0W6aGGHy64pnmqBlK4VX201gJTFrLNbxNyUTvdNA>
X-ME-Received: <xmr:1y3_aCQr1JIpKkqzpvtqikgRqDjliRJ9Jm5MuTEwfkrfdC3Pp_Vk9lwwRAvic8cVhNVV2BgmkGwRfIvX6wf7MxeUBdvYCA81MSMcazE6Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1y3_aJTg6aUl_b6AcotXVEqfHh4w8ibjILCKS5fPCLX_GXkAPBeilA>
    <xmx:1y3_aP5T31lXxyK5RKleJUoxOw4ntkTGRl_Tq40-Ow_WfdFmqAeIrg>
    <xmx:1y3_aN1QsZ_iDID_V6armuzSyJPKOO8MEl6fTCXxFuNprnBhtP1hQg>
    <xmx:1y3_aCBEG9XUhzzK2UTbys6YGs8e10lyAG_F2swBf6sr9TE3pS2gEw>
    <xmx:1y3_aNrbkv-B9taZEqfys3cX1FbW8O18Ky4PbFT2P8sDInLLyvhsnjAr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:31:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1091872 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:31:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 09:30:57 +0100
Subject: [PATCH v4 07/10] builtin/maintenance: run maintenance tasks
 depending on type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-pks-maintenance-geometric-strategy-v4-7-18049e4a0adf@pks.im>
References: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
In-Reply-To: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
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

