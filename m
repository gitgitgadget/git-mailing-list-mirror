Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BDB33CEAE
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056030; cv=none; b=c397Jf2skXobY2F6o8eBIX0Zo9MSKa/RhVzQcQt58vnuCuxKRSI3lxSEXMDPHwCKjpWDLQK0/CbojdXqgwkxSuv/OPNvnN0nNqHjHs5UB9MqT8b2+EcKDty79KB2P1sFkYFCth0AkjPiusQEO5RQ71yrP+KYLJcJmXTci+HBjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056030; c=relaxed/simple;
	bh=mluxtyEfJBij4XTFfFw+O/08W+d9917VtzUOvudUoMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NU1CKN7mwRanhv4oqaK0AzWIhaCsr9B6ie6nVMgI7doY0EuZaWKulswcc7KghtcAAXs01qlwJknE+IdvWa0hj+4Ck64q0Nia/DxedRzW10k13O9Y3RILIIP6tQDaJ73MevljZts/yfHzMCcGtM80qBtgAhvBkPQCOX/sKGIW2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MgqpGoEG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iwFvBocC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MgqpGoEG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iwFvBocC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A18DAEC01C4;
	Tue, 21 Oct 2025 10:13:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Oct 2025 10:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056027;
	 x=1761142427; bh=+rvOti1LgCoRVHt2WYnSbMvtYPtGzj37oXNnInffpEw=; b=
	MgqpGoEGhAAzKLWfmYlMOaaMIPGLhf8/2PmJ63VR9tUHHZ3VkwMNmPl+QSycAe90
	e0sAT92CO8E0nKEt626jumYWINnZHCOEyLHhq4pOUrfCPlb75nLGPXNVRHiyOG1u
	AVKgWjMiteP7iIsKkg62xgPo4uREmaStLwxKJWIRrdqhPC6MhjEnThMUxVYyFIKY
	HPRq1X6RTdHMi6cRObMQt6di11W8yYPV5ozSOH3fz9dv5U982ER6Ew6cnrBG56XO
	/HvHaLrGJD/OK0sLTGNX77X/py9cxZEGm8ITlVE1hXXA9gZ530qmjBKiRbDejWIQ
	JqO2vjHVlJdG2MoDB+vI1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056027; x=
	1761142427; bh=+rvOti1LgCoRVHt2WYnSbMvtYPtGzj37oXNnInffpEw=; b=i
	wFvBocC3K9ImKkFQtkdkpgZlXjRvv/O/I5kT6iSft6irU9nKjbXqkdwlnMqfsjxY
	W3VvVm9k7rjkxNW17Fccnz0hSlCVPhCeG0v5xFewh5dC2JE2ohhto02Hfa8MBeXF
	deAPI8ooqm6Pm/4dM3KqDRPxJftdaoWC7qN9uhUEjRJIyMwyGWU9HfPkekvlhuLE
	y/0oYwKwU2LFq8w3ZPGwZyqtV5Z773Bq7NCyC/xOqvGsjhRxe9PcAVHv78tGuZhU
	PdpTyUSdF+TUSBkuoRzoI2WJCQk8HfEHfWTBwaTc7Z01Gvd7VqDv5v9vdoRX992J
	GG9Jl/L3DmIBSJ3uH0U4g==
X-ME-Sender: <xms:G5X3aNNzhwFKWDSkzZukh4KAsfqha5_K3dH9FlPsMGY4yVseTFrSPw>
    <xme:G5X3aHbaEcsW0z8mXd89QHkWC82XB3ZAy0pU3KHrW_qVAWjYgCfMnPD6zQfZeFfXg
    NZMi-_NX6oqay3UErZ17RmElpfjXE12Q4lSymWXQoblO6ex_vWpRL8>
X-ME-Received: <xmr:G5X3aJoQJm5oZwtQRNYIN_0I6k5msLY20lB2JXZWxkfQO81ZY16Xsp9v4a_NNgHvUM6Sfd7-pynGANseBqes3bFn3r-WOPdzjTstkVrcC52iSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:G5X3aDbx4dsDHkVCx8EYYybEtwPlciszu47ClX0GGANQzWucPQqN9A>
    <xmx:G5X3aJSzEzqS-NHZx2V3Roa2KIoSLh8tdZQSgLWQBARLMpAOiMVESA>
    <xmx:G5X3aC7vu1xK3kmtKtbS7qrgUPvdN8ROaKEQn2mUOcNovl90RcQ9zQ>
    <xmx:G5X3aGw0IyWvtVGC20KL3ubpscDuxfzXcuUxC29DoGZIho-YkWIv5g>
    <xmx:G5X3aN2p6OT0itSEThWOCrbIHqo-WxTItMLPgHfAFN4NkW8XequYtoFV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:13:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 59f44853 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:13:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:13:29 +0200
Subject: [PATCH v2 7/9] builtin/maintenance: extend "maintenance.strategy"
 to manual maintenance
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-pks-maintenance-geometric-strategy-v2-7-f0d727832b80@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
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
index 45fdafc2c6..b7e90a71a3 100644
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
index eff4e4886a..9c05905b9a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1861,6 +1861,19 @@ static const struct maintenance_strategy incremental_strategy = {
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
 
@@ -1904,19 +1917,20 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
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
index 69fb6e9ee2..3530895bfb 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -887,6 +887,46 @@ test_expect_success 'maintenance.strategy inheritance' '
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
2.51.1.851.g4ebd6896fd.dirty

