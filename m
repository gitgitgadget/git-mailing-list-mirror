Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B22E88BD
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553885; cv=none; b=swa/VXa4Tg0FrjFPFX90GIEmWZl2vCmFIbzQpZqOIQJtFZoJKQeplvnwVlxyAIDvs/kQoFqPLIbYP3GfwZO7D1szDGK+ouBoBlCnGO5NIT3V2XAY+if98xFWkNuJl8Nj/yNeuehHN6x7q4Q/R8NEkt3GI1DcmtTUkEavJopQiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553885; c=relaxed/simple;
	bh=LwOQeLQrcfjyXIP/6ZLW+CSpQ59JGiyoC2QVEQSRxqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+sGZsWTzo6GHn/IJHy1JbZc42eyVUoZTPHad0zZVCDo3NOlJuh5YmUPQ/L8E04WnQy1nUNMlaTf8VedNnzzvkTL2+JYM32x1OwGw65W8S5/CCF9QHaWmBkjB7yKyfpvi7KmR8O3S/H0uA1ZNO61dQf9OaPn/fKnlKz2qsAKd3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AhsDrwci; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cF2IUSYe; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AhsDrwci";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cF2IUSYe"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA7F0140014C;
	Mon, 27 Oct 2025 04:31:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 27 Oct 2025 04:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761553882;
	 x=1761640282; bh=t3pjtDhizqs3+6UnJkZ2Z2uZv1eRg4Enl1bcPTafZJQ=; b=
	AhsDrwciAz55hylfdD6VZ/cRgPK6U7rhcqW5S53FN5RN85rZhxMKe4tokNzFitPl
	WK22OH1WBLWdVLAMIHFFPJpBFIlFI3zDhaTziyIwjoEh/3E7Xr1xgdgeGb+Wnx+j
	WBnh3CwpNeBqCjUwfwN95BGvrsV8td9BmwzEx9mlODOXjdvrD1k/2X6O1tr5qrRy
	P1zP8nuY1gimujClzpTlIYKCfy21kYrLiVS/e6H+8pGzxueT4eye+3PmRa647En0
	+kbcAwXAYrzbkZcQckg1H1m2e2FyIVpe7XH795MkCCHjELJYcZ1tHTT2evnrZxjC
	QRrtp26HKQcotU2buN1eSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761553882; x=
	1761640282; bh=t3pjtDhizqs3+6UnJkZ2Z2uZv1eRg4Enl1bcPTafZJQ=; b=c
	F2IUSYeset7ujiFRo+Lw4pLgQaUSJ3bshEKmOLzs2nfPB0bXScUIutFsZEBCnmyc
	UxTyVFW7RV9KHELlfrNMz3O/mvKCb6myKWk5oE61ctah4EvbYC0HloaAo5gxKvOp
	LBxnWTtzoaUZ6JA5ZpDcAUjP7dUg2nu/etsaiJS3XEf4cO4UuwmTupbmXH8NEEGJ
	K7q4ljyu8y3qMAf9Kr1H+G3DsuzcoUVebHypZvGjSV0ynTT6oExmd4L1dG/lhMr/
	oKvVwzW4z2IgSxXg7fE5d8thy7IejCKbR/pUtX1mkD532+q/t8X3OpuRLoyPgCPM
	Cad0HYVKNsDY5RqdvgRcw==
X-ME-Sender: <xms:2i3_aNl7jz0aMzblhwaLKa-7tKU7RRGF1MOhtlWx7pyI3FHjLFS9Eg>
    <xme:2i3_aPuXlZQs6S-Z91Gae__yT_G7sSNdA9VfNh-9GonsHYEtBexE66yfXtrzmtviG
    yn48Z8oO0rJ2FSwqMnZNpkYrea4kETbk7nnsfV0PiQizH9zWGLuzA>
X-ME-Received: <xmr:2i3_aL_KsxJq2oYwep1KV0whj0xLmS2-bzZZPy8jXwZMKcQkgnY9E4aIk75aydJNVemUxmbTTfpWgL9WiBKD9bz4lzEQdHfI4-KFCGijmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepsh
    htohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2i3_aJMXao6dNkF_qXyaZXXqor0_F5x5N9kSuLDOAlgqBAaVptK1tg>
    <xmx:2i3_aJHY815fPGzTxsSW_V3TcVbi6UAHA1GtT_jzHHuule6UJlTC5w>
    <xmx:2i3_aHTVDer-EJvH9DYHPCYIC1BYElvC0ym6koDGXLGpsj3AKgpwHg>
    <xmx:2i3_aGti08pYjyG5cpeXfqvG5WmdFdbbW2_l6tFARY2lt6xkTKydOA>
    <xmx:2i3_aPn78Ljqck7tOUEDKtQAd9BWCrn2i2XqGvUwmpcQwhoCGnmkzSQI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:31:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff315273 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:31:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 09:30:58 +0100
Subject: [PATCH v4 08/10] builtin/maintenance: extend
 "maintenance.strategy" to manual maintenance
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-pks-maintenance-geometric-strategy-v4-8-18049e4a0adf@pks.im>
References: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
In-Reply-To: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

The "maintenance.strategy" configuration allows users to configure how
Git is supposed to perform repository maintenance. The idea is that we
provide a set of high-level strategies that may be useful in different
contexts, like for example when handling a large monorepo. Furthermore,
the strategy can be tweaked by the user by overriding specific tasks.

In its current form though, the strategy only applies to scheduled
maintenance. This creates something of a gap, as scheduled and manual
maintenance will now use _different_ strategies as the latter would
continue to use git-gc(1) by default. This makes the strategies way less
useful than they could be on the one hand. But even more importantly,
the two different strategies might clash with one another, where one of
the strategies performs maintenance in such a way that it discards
benefits from the other strategy.

So ideally, it should be possible to pick one strategy that then applies
globally to all the different ways that we perform maintenance. This
doesn't necessarily mean that the strategy always does the _same_ thing
for every maintenance type. But it means that the strategy can configure
the different types to work in tandem with each other.

Change the meaning of "maintenance.strategy" accordingly so that the
strategy is applied to both types, manual and scheduled. As preceding
commits have introduced logic to run maintenance tasks depending on this
type we can tweak strategies so that they perform those tasks depending
on the context.

Note that this raises the question of backwards compatibility: when the
user has configured the "incremental" strategy we would have ignored
that strategy beforehand. Instead, repository maintenance would have
continued to use git-gc(1) by default.

But luckily, we can match that behaviour by:

  - Keeping all current tasks of the incremental strategy as
    `MAINTENANCE_TYPE_SCHEDULED`. This ensures that those tasks will not
    run during manual maintenance.

  - Configuring the "gc" task so that it is invoked during manual
    maintenance.

Like this, the user shouldn't observe any difference in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc | 22 ++++++++++++-------
 builtin/gc.c                          | 25 +++++++++++++++++-----
 t/t7900-maintenance.sh                | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index 45fdafc2c63..b7e90a71a3d 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -16,19 +16,25 @@ detach.
 
 maintenance.strategy::
 	This string config option provides a way to specify one of a few
-	recommended schedules for background maintenance. This only affects
-	which tasks are run during `git maintenance run --schedule=X`
-	commands, provided no `--task=<task>` arguments are provided.
-	Further, if a `maintenance.<task>.schedule` config value is set,
-	then that value is used instead of the one provided by
-	`maintenance.strategy`. The possible strategy strings are:
+	recommended strategies for repository maintenance. This affects
+	which tasks are run during `git maintenance run`, provided no
+	`--task=<task>` arguments are provided. This setting impacts manual
+	maintenance, auto-maintenance as well as scheduled maintenance. The
+	tasks that run may be different depending on the maintenance type.
 +
-* `none`: This default setting implies no tasks are run at any schedule.
+The maintenance strategy can be further tweaked by setting
+`maintenance.<task>.enabled` and `maintenance.<task>.schedule`. If set, these
+values are used instead of the defaults provided by `maintenance.strategy`.
++
+The possible strategies are:
++
+* `none`: This strategy implies no tasks are run at all. This is the default
+  strategy for scheduled maintenance.
 * `incremental`: This setting optimizes for performing small maintenance
   activities that do not delete any data. This does not schedule the `gc`
   task, but runs the `prefetch` and `commit-graph` tasks hourly, the
   `loose-objects` and `incremental-repack` tasks daily, and the `pack-refs`
-  task weekly.
+  task weekly. Manual repository maintenance uses the `gc` task.
 
 maintenance.<task>.enabled::
 	This boolean config option controls whether the maintenance task
diff --git a/builtin/gc.c b/builtin/gc.c
index 6cc4f98c7aa..3c0a9a2e5df 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1873,6 +1873,20 @@ static const struct maintenance_strategy incremental_strategy = {
 			.type = MAINTENANCE_TYPE_SCHEDULED,
 			.schedule = SCHEDULE_WEEKLY,
 		},
+		/*
+		 * Historically, the "incremental" strategy was only available
+		 * in the context of scheduled maintenance when set up via
+		 * "maintenance.strategy". We have later expanded that config
+		 * to also cover manual maintenance.
+		 *
+		 * To retain backwards compatibility with the previous status
+		 * quo we thus run git-gc(1) in case manual maintenance was
+		 * requested. This is the same as the default strategy, which
+		 * would have been in use beforehand.
+		 */
+		[TASK_GC] = {
+			.type = MAINTENANCE_TYPE_MANUAL,
+		},
 	},
 };
 
@@ -1916,19 +1930,20 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 	 *   - Unscheduled maintenance uses our default strategy.
 	 *
 	 * Both of these are affected by the gitconfig though, which may
-	 * override specific aspects of our strategy.
+	 * override specific aspects of our strategy. Furthermore, both
+	 * strategies can be overridden by setting "maintenance.strategy".
 	 */
 	if (opts->schedule) {
-		if (!repo_config_get_string_tmp(the_repository, "maintenance.strategy", &config_str))
-			strategy = parse_maintenance_strategy(config_str);
-		else
-			strategy = none_strategy;
+		strategy = none_strategy;
 		type = MAINTENANCE_TYPE_SCHEDULED;
 	} else {
 		strategy = default_strategy;
 		type = MAINTENANCE_TYPE_MANUAL;
 	}
 
+	if (!repo_config_get_string_tmp(the_repository, "maintenance.strategy", &config_str))
+		strategy = parse_maintenance_strategy(config_str);
+
 	for (size_t i = 0; i < TASK__COUNT; i++) {
 		int config_value;
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 211350bf54e..a791a38916e 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -886,6 +886,46 @@ test_expect_success 'maintenance.strategy inheritance' '
 		<modified-daily.txt
 '
 
+test_strategy () {
+	STRATEGY="$1"
+	shift
+
+	cat >expect &&
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git -c maintenance.strategy=$STRATEGY maintenance run --quiet "$@" &&
+	sed -n 's/{"event":"child_start","sid":"[^/"]*",.*,"argv":\["\(.*\)\"]}/\1/p' <trace2.txt |
+		sed 's/","/ /g'  >actual
+	test_cmp expect actual
+}
+
+test_expect_success 'maintenance.strategy is respected' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+
+		test_must_fail git -c maintenance.strategy=unknown maintenance run 2>err &&
+		test_grep "unknown maintenance strategy: .unknown." err &&
+
+		test_strategy incremental <<-\EOF &&
+		git pack-refs --all --prune
+		git reflog expire --all
+		git gc --quiet --no-detach --skip-foreground-tasks
+		EOF
+
+		test_strategy incremental --schedule=weekly <<-\EOF
+		git pack-refs --all --prune
+		git prune-packed --quiet
+		git multi-pack-index write --no-progress
+		git multi-pack-index expire --no-progress
+		git multi-pack-index repack --no-progress --batch-size=1
+		git commit-graph write --split --reachable --no-progress
+		EOF
+	)
+'
+
 test_expect_success 'register and unregister' '
 	test_when_finished git config --global --unset-all maintenance.repo &&
 

-- 
2.51.1.930.gacf6e81ea2.dirty

