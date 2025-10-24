Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68B288C22
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289067; cv=none; b=JUZhEKOYmvdOcO2MNZ6+TVVku1FU2gsOUglARgGwIn2Zz1F8NAkxzmKT4eUyn4K9ogzsP8IT3P3p2NIE22BtTNtiZw9DtO0AlwThtNywll7tRyQIeP6eYeQLM/CN/xEovr8YbzB7LKGFwJqVxIfPoGOq1x6uTfGtf/4Y8TLGhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289067; c=relaxed/simple;
	bh=5Efy9roOPOcb5wiA2WciCnnVUfmTMSLWrfl61brO4IA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCjMhPon+nlHM7kdozWRfWGyWoHF5gOXvNU4H5qfHf4dsaTnA8yXW++YTzCKh08aR9Je2aUpMa7DhUAoU9xTZrGhxvjgXsrYJLnZEN71CED3hJaH9hZen+XAeAZo9sbfofttN9acY13cyVZfP89xN/NH5KlqS/f3QzqqVC1AICs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=awz4Pwi6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GBam6qwa; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="awz4Pwi6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBam6qwa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A40F1400151;
	Fri, 24 Oct 2025 02:57:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 02:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289065;
	 x=1761375465; bh=ualafvQwj0nyA9FscNs2+U19aFQWE/I2hrRkQD8wA4E=; b=
	awz4Pwi6iXpuakkxcvh8Z48ZyAFsnPNClQ/dwBG5YZ9C+MOvpFMuirXrOJwaDUrQ
	yRWHSYILBag6jLi3hl66+B9fPUp3P+cwYHUMxv30Bz1fjrY5Yp5uvyXPQCMQuVCq
	BwjYCYCE/m+2vKKSOBVmPNKEJmMqCMVB2zLKZog64LX5h+cAZGcosYI4tOZgDV9i
	zfr3lBQnOGNcYv4xZoU80I6xJaEdTu5DUvzVOLHNGAuJu0FrARe/W6e6VU2QhzrL
	imaRV8lw7pnOH3dwOcjnHpy0OeGkzJNVwKcJtBC4mOopy91JahIU0w5P4vxOcYQt
	rX0iOSN2vwIOw2eliWlBgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761289065; x=
	1761375465; bh=ualafvQwj0nyA9FscNs2+U19aFQWE/I2hrRkQD8wA4E=; b=G
	Bam6qwa2/9lkPPuXTDGTsbmfe9LWpBqmqzB0fX47uaOe/bfg3aRPtlle69vjue7n
	7NtOhumDVxqvQFrDHVEfreyMaTlA1gSfUDBDfvay/4ExmGnXCRHD/xnSfS4WT5QZ
	e8LTKojx5Q2D6+FpqyXOWGDyx2te20E5OS5C55YiZ3muSY27BkIrZYv9dfvrundd
	ExIWKYVOZGDt3IA8XPfDFNIsTt3a+hLKOb/EQEwd5YTGegdapEeDKzlHDj+R/izI
	P/gJckFCDtGNRWIKjdMRMv5o0fUf8j/h5NgQwa63zuN9/J8Ywu+5uSY+Fm2/L74C
	WO6GCSNjMCFOXRRvfoK5g==
X-ME-Sender: <xms:aSP7aFNRdclBW3ZZNrInKFo-rUk94Nj9Nc5XP1tn6cAQbAn9KwhCgg>
    <xme:aSP7aO0YtTvhELdXCDnSeFpXxTdYJkk3ENBFU2d6rt8gRRYtU41qz_iReuodbgPDg
    ALB__c94dQI0NeZcLvk2d0xufQVRiZ1IXSsRA557vNcosCyeORLNQ>
X-ME-Received: <xmr:aSP7aMkdD0TSF5T0zFMicBvxwRsOaqLXmLtpdv66qwgTVeNTuBD8beCU1toPItOlMCKcsIHrh12q2whpW5pmUdDV_l1lEtDaQyAw9B6qOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aSP7aNVuH9jBrT5q0EnWm8WfbOi-Zs0ey_4CdFA6daVJ6r6KxC5e8w>
    <xmx:aSP7aKtLZ1q4bn_V_sHDr4j_FEhxBWW298JdtpJkq2RmwXN353vGlg>
    <xmx:aSP7aIYzl1sJek11Ffuu1Y8QCXeOdNASFz7SwIhPLjrnxhBckTqa2Q>
    <xmx:aSP7aBWcbOH7UpSXnQlU1-pqlG4WRGenApdnkwsqpPR-tqcd3xyTTQ>
    <xmx:aSP7aIr3CEoTqWRzzh-txDxEqnFqMsuRGUBu_1Lkcisq29l42oBxrR1z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:57:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 237172b4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:57:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 08:57:21 +0200
Subject: [PATCH v3 08/10] builtin/maintenance: extend
 "maintenance.strategy" to manual maintenance
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pks-maintenance-geometric-strategy-v3-8-9b5b3bdb4387@pks.im>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
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
index 0fb917dd7b7..5219bc17a69 100755
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

