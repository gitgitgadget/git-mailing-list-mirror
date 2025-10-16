Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E542FE055
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599626; cv=none; b=dBGG/7eU1s7MGiLVdUypNng1Bf198ujZsya/vc5Qaz+vYI1M0eWzlG53EG5qSpB8+JNCewckw4BnH1nBejXJMCSC5VGdNIM6PPAgejf1eqYvnmAnRX7IkHQQVVSheZpDCgy9zyOMKLJBXfnux+f5fcwzr2TZJCWCv1rrXDg40jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599626; c=relaxed/simple;
	bh=kvBfRr+/P6O7pVN/+8t7wOpZymUb6kIKEa+DycXX73E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/pPl/PhiH3GfbMWORRVdue+C3KKr7q68MB8M/rsQ+ZTzqdBO6QjNEhwHMLVjX4Dxl90UdSxmMxzo3ghiFb8kTyfw+E123nBbfT1FlDcJuXkmdn4f8pasNuupC4q8MhVld2d8bIC6LhwFiSHmqwim7rlCvvnpr/KoynkpdDzr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CNMjw2eS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ufWCSEXc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CNMjw2eS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ufWCSEXc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 359F5EC00D9;
	Thu, 16 Oct 2025 03:27:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Oct 2025 03:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760599624;
	 x=1760686024; bh=G40DXWwDE3ytZgIGkPGLzhWl2BYvwoUR0tnjPSTd6j0=; b=
	CNMjw2eSI/P05wMOK0zVwCkOyels5SqLuqDUBnHYfH1SiXn9Ls+BYXeFNMHMUfuD
	jaCvw9Rik72Ez/2GMQA0plX0+gdWZMITXiOgBDFt5hsZBF7CHHyxeT9kM9cI8RwV
	hq4Th4jWTW+m19ZrO/zNmU37YmP6HoWd2zetImbf5QOp8OEAMprd3g1uAty7Fhqz
	tm/nUmZJWqAi061ZD0RwtcfPO5cUwsw8qty0IMWYNTI3degs4dveAQZ8nqn7mbLJ
	llWhcgX+yfBtmvgHLF4cUu1r3azvKNPtftpa4W5paNNG8kckY4slRh5oc0rjIobv
	4NZpz2KokKd0KGANAP75ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760599624; x=
	1760686024; bh=G40DXWwDE3ytZgIGkPGLzhWl2BYvwoUR0tnjPSTd6j0=; b=u
	fWCSEXcr68c5K4KRx57aCDVJyFPdbxoKt+/zm6Hj3QJ5bu8kfayNOWXsBWHFBPZ0
	6EIwJdSUWa8tDOH8GPgGaMEUsxaQH55LrUPSeONFOSoB4F90/a9wue5VN5726+SE
	S2U3bd7X5qCFhSZcJ679zVm6agyaBlNa191lcORg+bEKONiKPlHNOpq3hhGTtCa0
	+Ed4vwmG4IK7ia/XLTT7vk77XyHRbuDuFlKpuHykS0hjqn06tv9GZQ54/RQk0J+k
	8XpQWuocz0qTMNZ3Qg7GjzUHtLcn1o9SDy/P2iakFcpfEgeERsM2WtK9g065WwH1
	c8OYt8kLrMK8kU9LqMiow==
X-ME-Sender: <xms:SJ7waEhdkKOKjbk_qxZ1EJdzPimu9Ra6VDNHJJ6uzzphmjT5ggg8Sg>
    <xme:SJ7waEdfeHh_rtmbjO-fFyvKj9h9opXio1JTufCkZWJO1W21NBoIZHgK7sS3cbkpN
    XesfO3wkK5_LIainvUCCHUjEYLBFbuMkpL1iM-2QSs0sNNomYLjfw>
X-ME-Received: <xmr:SJ7waJdjzAws0289ULCa1NlUPq7EQtWNC4KKFht_-Xc-UecJDZqC_ElzPtnF-O47CHtbISgLmKp7tBGtaBc8Ktna0EpR_oZDo-izpJh1HfaXiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:SJ7waO-Ufr74tixZ3c8xLG3_ObhjzO7qj-uiZtofIo9SuyZlkOa3PQ>
    <xmx:SJ7waFmfac56KQoE5rteuzAAdb0BHK6-E8yN5LUSQB_JYIjpGG8gZQ>
    <xmx:SJ7waA9QwOYxwLwarvprVni5o9kgRibDkPiZx9CA130hUpa2re1CYg>
    <xmx:SJ7waDmadkWaZBR6OvYhxFqW-FeNCoFpwBKdw5cmoyAycCx3AK938g>
    <xmx:SJ7waF7j599OczlRGvBxAcsgCr9oKy3H9M_ojc6uKXRhwJqHFpypsOdG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 03:27:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b7990e6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 07:27:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Oct 2025 09:26:37 +0200
Subject: [PATCH 6/8] builtin/maintenance: extend "maintenance.strategy" to
 manual maintenance
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pks-maintenance-geometric-strategy-v1-6-18943d474203@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
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
 builtin/gc.c                          | 24 ++++++++++++++++-----
 t/t7900-maintenance.sh                | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index 26dc5de423f..dc6fd9b7fda 100644
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
index 4f70650e7ac..971d557d370 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1854,6 +1854,19 @@ static const struct maintenance_strategy incremental_strategy = {
 		[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY,
 		[TASK_PACK_REFS].type = MAINTENANCE_TYPE_SCHEDULED,
 		[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY,
+
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
+		[TASK_GC].type = MAINTENANCE_TYPE_MANUAL,
 	},
 };
 
@@ -1897,19 +1910,20 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
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
index 45334f7ad3a..439f1bfba0c 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -853,6 +853,46 @@ test_expect_success 'maintenance.strategy inheritance' '
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
2.51.0.869.ge66316f041.dirty

