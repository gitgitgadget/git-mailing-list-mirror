Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355313A87C
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533484; cv=none; b=oZj39JtIaQO7yHwU6fo/+rMfhZHZJ+XFysvCVYa2kY6ap7FeQ+fRQGCyPkESBfiA2AsVrCw7wdhaO7B6q2Wg7s21spy1FSKfnCZsowQmPRsia8H4ZSMfh8w0FTVZhU9CxaUNeP0nGqBZfrRy9t7xW9mlnYf20g7Ofw0WBJH++Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533484; c=relaxed/simple;
	bh=hH8v+XrFYJ8shE6JuQys0BSAJEfTI8dWFc6b9joM0Hk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IucokmznpbjYM7BemzjoJelM5L2JMePHyDuSmw6j/pfgjwIWJvNPImLjt9FZ5JyAfeqaKzzp7rqDBUDuIH9OVoNQ5wJ+31vkbb0C9t9dTSdTM5tf/v3DL7Ll+kiJESLeAQd+OwhOXm4hBVlbSv9Pey7qfJnpkd5bWYtRq87QQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lwuK3NQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YiKVAOWI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lwuK3NQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YiKVAOWI"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 284C51151B09
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:18:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 03:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723533482; x=1723619882; bh=m33tx27fd0
	VRzBk+T/X5Qkye2nKHSN/yLcbqdxmtm3M=; b=lwuK3NQXL3CP5e6pBFISWf3Gty
	BALyt1XopcBxdIEBc+26PfH4Pv71VpUP2DgIYtp+0vLm4zVR1ZG+z3vZFFuil1uO
	NwdKYgwYi2Dh71gz/Fce6zX406N34Vqj75dYadx36FhehYMNPCXuz6leyPzakdj6
	ES4fCE5TjFUW+ZLxAGus1hd5JwRzO2Roap1qu7/Wo9qXmuL+gRRwKzN4auWy/C/T
	IIPeGpKyYNjRpr6uk1CvL/EKLwRU7EUgqmjTu9NKIqSKHSH1oqmZ5+zdSKhVfNKP
	hcYCPkzUIsIA4Sd9RpbqeHBTn4XWwryj/BLD1Auu09oLMe6m0Ju7biAmEgvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723533482; x=1723619882; bh=m33tx27fd0VRzBk+T/X5Qkye2nKH
	SN/yLcbqdxmtm3M=; b=YiKVAOWIYvG2iDiwOCTiANU0MP/FI+Kvh131E+Dg9pV+
	yi+kWLw/MMQ4RQJFTSDIx2Ias67wzdq1dy8mKBcsb4WIrM5eSDxY+wL4Y7ZMA6Ur
	c0dySNfgs4aUTQISa2k4hyCTzEdqW8tZOqESfLO7Oj1CTw2cKFnqIYRSSlnM6SF3
	WoFsShl4KLOPn8TrUwPHsgKWYnldrV6PcB+nEed/o7J+gFuv1/MzpXa4SjuZyRWt
	Xj2Oqc/ItRyDT6Lc3kIoM/L0+tGWmsNv88R6PoEVXztOJNy6WmmsYtv/fnkxy/ER
	q6w66Rh268bPxtq1uDK5yIx49ffG5ctL91E/PTgHqQ==
X-ME-Sender: <xms:qgi7ZlMreitMaRfB5mUP-BI4nIfF2LUFugq8zkURmIwkgEYM9nMi3Q>
    <xme:qgi7Zn8ga3hIdTx9o2GEdpDWSZloHEYn-4S4cwoWkG0DbgAtyL82MkFzVMNAu4LI2
    F9NQt4xh5JehOzvaw>
X-ME-Received: <xmr:qgi7ZkRIQ5Mms1RFC9QnZXuWuXanSY1hDQUip7CrOODLlYq62kHLfyRWxd_Dbtm7Dsm2CsBB13lSfT1NYms2_j8_vz7QneRhgajIQ2x1y5hILw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeegudegueffvd
    efuefhlefftdeiieehffeivefhveetgfdtfeegjeduvdehkedtleenucffohhmrghinhep
    ihhntghrvghmvghnthgrlhdqrhgvphgrtghkrdgruhhtohenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qgi7ZhtJJgLSHIT8cPDcbMrQprqZ7wni3wpI_yTSIB_7wDVvX4n_dw>
    <xmx:qgi7ZtcmI1tOppIBBVQMs94DSK9AJpKl_73_bcCKNP_2AkbSvhTH2g>
    <xmx:qgi7Zt1P9yN-kozRm7qpQyNB1pYqSOl1BeP0L6W5LI-aTWGpiAm9yw>
    <xmx:qgi7Zp8gZzpd72Y-5dOwdI9xSNCKwwn1i_i5VrF6YNx4tO1gKIJDHg>
    <xmx:qgi7ZtE8lX_qRDwCg-SUebrNzdfEc3XdfSGJDxZztm1wd1zd0Iz-bhgE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 03:18:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d23ebed9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 07:17:45 +0000 (UTC)
Date: Tue, 13 Aug 2024 09:18:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/7] builtin/maintenance: fix auto-detach with non-standard
 tasks
Message-ID: <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723533091.git.ps@pks.im>

In the past, we used to execute `git gc --auto` as part of our automatic
housekeeping routines. As git-gc(1) may require quite some time to
perform the housekeeping, it knows to detach itself and run in the
background so that the user can continue their work.

Eventually, we refactored our automatic housekeeping to instead use the
more flexible git-maintenance(1) command. The upside of this new infra
is that the user can configure which maintenance tasks are performed, at
least to a certain degree. So while it continues to run git-gc(1) by
default, it can also be adapted to e.g. use git-multi-pack-index(1) for
maintenance of the object database.

The auto-detach of the new infra is somewhat broken though once the user
configures non-standard tasks. The problem is essentially that we detach
at the wrong level in the process hierarchy: git-maintenance(1) never
detaches itself, but instead it continues to be git-gc(1) which does.

When configured to only run the git-gc(1) maintenance task, then the
result is basically the same as before. But when configured to run other
tasks, then git-maintenance(1) will wait for these to run to completion.
Even worse, it may be that git-gc(1) runs concurrently with other
housekeeping tasks, stomping on each others feet.

Fix this bug by asking git-gc(1) to not detach when it is being invoked
via git-maintenance(1). Instead, the latter command now respects a new
config "maintenance.autoDetach", the equivalent of "gc.autoDetach", and
detaches itself into the background if not told otherwise. This should
continue to behave the same for all users which use the git-gc(1) task,
only. For others though, it means that we now properly perform all tasks
in the background.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c             |  1 +
 run-command.c            | 12 ++++++++++-
 t/t5616-partial-clone.sh |  6 +++---
 t/t7900-maintenance.sh   | 43 +++++++++++++++++++++++++++++++---------
 4 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 63106e2028..bafee330a2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1063,6 +1063,7 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts,
 		strvec_push(&child.args, "--quiet");
 	else
 		strvec_push(&child.args, "--no-quiet");
+	strvec_push(&child.args, "--no-detach");
 
 	return run_command(&child);
 }
diff --git a/run-command.c b/run-command.c
index 45ba544932..94f2f3079f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1808,16 +1808,26 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 
 int prepare_auto_maintenance(int quiet, struct child_process *maint)
 {
-	int enabled;
+	int enabled, auto_detach;
 
 	if (!git_config_get_bool("maintenance.auto", &enabled) &&
 	    !enabled)
 		return 0;
 
+	/*
+	 * When `maintenance.autoDetach` isn't set, then we fall back to
+	 * honoring `gc.autoDetach`. This is somewhat weird, but required to
+	 * retain behaviour from when we used to run git-gc(1) here.
+	 */
+	if (git_config_get_bool("maintenance.autodetach", &auto_detach) &&
+	    git_config_get_bool("gc.autodetach", &auto_detach))
+		auto_detach = 1;
+
 	maint->git_cmd = 1;
 	maint->close_object_store = 1;
 	strvec_pushl(&maint->args, "maintenance", "run", "--auto", NULL);
 	strvec_push(&maint->args, quiet ? "--quiet" : "--no-quiet");
+	strvec_push(&maint->args, auto_detach ? "--detach" : "--no-detach");
 
 	return 1;
 }
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 2da7291e37..8415884754 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -229,7 +229,7 @@ test_expect_success 'fetch --refetch triggers repacking' '
 
 	GIT_TRACE2_EVENT="$PWD/trace1.event" \
 	git -C pc1 fetch --refetch origin &&
-	test_subcommand git maintenance run --auto --no-quiet <trace1.event &&
+	test_subcommand git maintenance run --auto --no-quiet --detach <trace1.event &&
 	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace1.event &&
 	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace1.event &&
 
@@ -238,7 +238,7 @@ test_expect_success 'fetch --refetch triggers repacking' '
 		-c gc.autoPackLimit=0 \
 		-c maintenance.incremental-repack.auto=1234 \
 		-C pc1 fetch --refetch origin &&
-	test_subcommand git maintenance run --auto --no-quiet <trace2.event &&
+	test_subcommand git maintenance run --auto --no-quiet --detach <trace2.event &&
 	grep \"param\":\"gc.autopacklimit\",\"value\":\"0\" trace2.event &&
 	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace2.event &&
 
@@ -247,7 +247,7 @@ test_expect_success 'fetch --refetch triggers repacking' '
 		-c gc.autoPackLimit=1234 \
 		-c maintenance.incremental-repack.auto=0 \
 		-C pc1 fetch --refetch origin &&
-	test_subcommand git maintenance run --auto --no-quiet <trace3.event &&
+	test_subcommand git maintenance run --auto --no-quiet --detach <trace3.event &&
 	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace3.event &&
 	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"0\" trace3.event
 '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 771525aa4b..06ab43cfb5 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -49,22 +49,47 @@ test_expect_success 'run [--auto|--quiet]' '
 		git maintenance run --auto 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
 		git maintenance run --no-quiet 2>/dev/null &&
-	test_subcommand git gc --quiet <run-no-auto.txt &&
-	test_subcommand ! git gc --auto --quiet <run-auto.txt &&
-	test_subcommand git gc --no-quiet <run-no-quiet.txt
+	test_subcommand git gc --quiet --no-detach <run-no-auto.txt &&
+	test_subcommand ! git gc --auto --quiet --no-detach <run-auto.txt &&
+	test_subcommand git gc --no-quiet --no-detach <run-no-quiet.txt
 '
 
 test_expect_success 'maintenance.auto config option' '
 	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
-	test_subcommand git maintenance run --auto --quiet <default &&
+	test_subcommand git maintenance run --auto --quiet --detach <default &&
 	GIT_TRACE2_EVENT="$(pwd)/true" \
 		git -c maintenance.auto=true \
 		commit --quiet --allow-empty -m 2 &&
-	test_subcommand git maintenance run --auto --quiet  <true &&
+	test_subcommand git maintenance run --auto --quiet --detach <true &&
 	GIT_TRACE2_EVENT="$(pwd)/false" \
 		git -c maintenance.auto=false \
 		commit --quiet --allow-empty -m 3 &&
-	test_subcommand ! git maintenance run --auto --quiet  <false
+	test_subcommand ! git maintenance run --auto --quiet --detach <false
+'
+
+for cfg in maintenance.autoDetach gc.autoDetach
+do
+	test_expect_success "$cfg=true config option" '
+		test_when_finished "rm -f trace" &&
+		test_config $cfg true &&
+		GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
+		test_subcommand git maintenance run --auto --quiet --detach <trace
+	'
+
+	test_expect_success "$cfg=false config option" '
+		test_when_finished "rm -f trace" &&
+		test_config $cfg false &&
+		GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
+		test_subcommand git maintenance run --auto --quiet --no-detach <trace
+	'
+done
+
+test_expect_success "maintenance.autoDetach overrides gc.autoDetach" '
+	test_when_finished "rm -f trace" &&
+	test_config maintenance.autoDetach false &&
+	test_config gc.autoDetach true &&
+	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
+	test_subcommand git maintenance run --auto --quiet --no-detach <trace
 '
 
 test_expect_success 'register uses XDG_CONFIG_HOME config if it exists' '
@@ -129,9 +154,9 @@ test_expect_success 'run --task=<task>' '
 		git maintenance run --task=commit-graph 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-both.txt" \
 		git maintenance run --task=commit-graph --task=gc 2>/dev/null &&
-	test_subcommand ! git gc --quiet <run-commit-graph.txt &&
-	test_subcommand git gc --quiet <run-gc.txt &&
-	test_subcommand git gc --quiet <run-both.txt &&
+	test_subcommand ! git gc --quiet --no-detach <run-commit-graph.txt &&
+	test_subcommand git gc --quiet --no-detach <run-gc.txt &&
+	test_subcommand git gc --quiet --no-detach <run-both.txt &&
 	test_subcommand git commit-graph write --split --reachable --no-progress <run-commit-graph.txt &&
 	test_subcommand ! git commit-graph write --split --reachable --no-progress <run-gc.txt &&
 	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt
-- 
2.46.0.46.g406f326d27.dirty

