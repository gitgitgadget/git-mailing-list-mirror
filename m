Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F42233CEA4
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056027; cv=none; b=X9npUqjSls2rC+8pncL+wG4ZofSbaFk6HdDSTiQjNuU8iO18/ubEfTgDocAxGi1ytTfkBkPIFob0rRVBXyP+TWmnsb5HBWOYEHvsBBjX9uiEXPhO9RXYs8nEWJnEEU9AyuB6I6+3AaQLT9Mjlaaalh+Ke0gk8JU1iASK9TBgn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056027; c=relaxed/simple;
	bh=owdqnGb0z+2VKESVECSkX2tLCU0K+wmL8VtYIYoyud0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDa3v1FkTBqTkp+1x2HNv3lEcisCp4G9BAGINnk+WaMyvlJpxuo0SsUY+dKDpSVGyF4oWYYdzmWbtBMxdDpAx2NLohiWY5479P1XO1YuONuiq+8DIIIr5X4Iajk7u54ehixqvnK6ThJuBUAuJHuqnx6ymZkQCUUbLANcpDPhgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=raar2M+P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIowIB6c; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="raar2M+P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIowIB6c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8671BEC00DD;
	Tue, 21 Oct 2025 10:13:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 10:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056024;
	 x=1761142424; bh=o+7dMZCQ5CQX8h69OPJr9Q15OZPccYulhsbXELIXXJU=; b=
	raar2M+PQ7iY7+WvX9GpVCpJzOy215f1EawFD626wDa1x31nteIa13N7vMtjfocA
	ssJfQ5JbwkI8TgOiJMuny/C66CcX1TGFsGeE2CIa6EkYrYQttbXfyFJLbFUOUVlz
	9mDCQdCBZ2LkYv2vd2w4Nap/f6691xx0/aHt6EKu/4weK8eZr4gI+bLEzIS05rS/
	Rqk030WfXIxMkJyZ3bdHYkPTN1d6DW5w3Nu7VX4sytKSndZz0X/BmTVyUOaTddRv
	x2T4mPO+ZRNEgz7KVObth2HC8IcbtFvUQSLaG+xu0q35d/dVefJDgrXF1/YiIDKn
	zMQWj1IsLyQ9gHa03Hhmag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056024; x=
	1761142424; bh=o+7dMZCQ5CQX8h69OPJr9Q15OZPccYulhsbXELIXXJU=; b=U
	IowIB6cyuvr7jj3BJMJNs46CUa5nwXqsdOUZDppRuoDNj5LuWcyyJQlamLAzA0fO
	oGlU8wv/rFhKpo75Xz8OmFS0bIBi3Mn7JsrR++nJGhzs3pwpa5olw2X6/MS6JUnF
	qcsbXcGcawcoAILnf4FhxaX6Zyx1W7W6bSfVEQq1Is5OANC5nHXZvI0fcD7r1Jo8
	HAXLCSEienEewm5zqPt8Eu7dY4ezVLcaoiMPud3fvmxywmc3ZxyXFp98UlWJCSSu
	Q2c9vjJ0+7CKburRlMpQpBb5qFG765zYwADqBX/xiINg9WY4DF+Yf/eZLyOypvaX
	M86LCnY0dZ8WRTUqTliKA==
X-ME-Sender: <xms:GJX3aEzUkXm-ReshN7OaAOIcZENpWmEA81vTp_PLI_BvpuQEN9w16g>
    <xme:GJX3aLi0YZr2UiKjwAvT14YOUMzQBYJ1qqHhCY6EZ1rOzqkdhfyh8Rnf2pP79nunP
    39K2cEpkUYhcwNv0r3FTtVO4T3-CUIBYgoaq35PO4mLh1JkxdBFJA>
X-ME-Received: <xmr:GJX3aPzFYZYeC4WQq1uPs-AF8Lesmouae3HHxLSmeQS4SFCB9i7zZLjUWzLMLWi06JNY0BAs6ZDPW6q6ByF6IUR0EjqLmyO13VCySzqFXOzWbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:GJX3aOIvM1Z6K5rZNYRYOvHzVQ0j1OawZ0s3NWo6iosX2pSIdDy35Q>
    <xmx:GJX3aGTwudtdaFCdKOfi3f0aFMGH6YBZUWC8GaQjZb_ULCHg6Ep-6Q>
    <xmx:GJX3aGo8KF562ITuy_M_ZOBwYJDU4gk0duGwY1lsvpnpEJjzzep7Nw>
    <xmx:GJX3aLq1Tz6pLW2ELHrm90sJPL2GugjLRZ0Fb3d8il_nQW7Ku3UMgA>
    <xmx:GJX3aNo2L9bJ1nX9YDBL-zJtdSZ9vy6L4062pbhB89mh2uz-t5z136ca>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:13:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ece2d895 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:13:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:13:28 +0200
Subject: [PATCH v2 6/9] builtin/maintenance: run maintenance tasks
 depending on type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-pks-maintenance-geometric-strategy-v2-6-f0d727832b80@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
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
index 726d944d3b..eff4e4886a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1827,30 +1827,39 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
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
@@ -1867,6 +1876,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 {
 	struct strbuf config_name = STRBUF_INIT;
 	struct maintenance_strategy strategy;
+	enum maintenance_type type;
 	const char *config_str;
 
 	/*
@@ -1901,8 +1911,10 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 			strategy = parse_maintenance_strategy(config_str);
 		else
 			strategy = none_strategy;
+		type = MAINTENANCE_TYPE_SCHEDULED;
 	} else {
 		strategy = default_strategy;
+		type = MAINTENANCE_TYPE_MANUAL;
 	}
 
 	for (size_t i = 0; i < TASK__COUNT; i++) {
@@ -1912,8 +1924,8 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
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
2.51.1.851.g4ebd6896fd.dirty

