Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065E19CCFA
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805123; cv=none; b=ChvhTz84AjQum/FbbNr/KSqekc9HxTV4IvR/97lIr6BEaU6SnSCeNzhdFSegWg4nRTGEQA4WFEf2OF3G40jNDHkWdGAk93ROheYUjqpqvuCqwUew5MT4G/s6jo7MC8AlDcFdV3q+5MmzjHAwmDwgZ058xzwFTh0e4oeJO//YvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805123; c=relaxed/simple;
	bh=dbrmvS4VnmROPhPGk/ck6RhA+qBaahr3/hKeix3JC/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3pCv9y9kLt9NyAmCncV3Ecf5EnZGoF2ICJdbWqfITc/o4cL4WRXWecRmaoNcn+Gi3ueYKeQtkU240pZ3/kKkGWTBjIhePjYZfmCR4IM9TKyZbgnCI1qJw41SQsa/mADYsjTPP+AS/pw6lwfR5LfcMlojpfGDBVi/rZuQ8P3QAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NcfM3Opw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hSuX3CBU; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NcfM3Opw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hSuX3CBU"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 997DE138FFA0;
	Fri, 16 Aug 2024 06:45:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 16 Aug 2024 06:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723805120; x=1723891520; bh=/3dMGy5TVU
	C7xDyrk7D0BGzHLBdOpms3x2V9CUbjhv4=; b=NcfM3OpwdP7KyJFh+YLSrbMskL
	b03zsC9SHxFQ8f4pLqTnAekVrSynhKWEt9zzN5eEbeYFe7soV3PaQVfjfEQO4Ezr
	fRvrhYQ4RZT290lagSo5oT4KI4pWJ+9OxN1QIjqUFfWsbbI/xK7qiBGcX3snFaJd
	hV0WPun7gQrvGTcOchDYMucmzMLx5CXFpAGcPRTnONktTBewary6EoM95+EPV6BF
	MLDM4JM+ilGsZ8ufnqgSx2RFjFb0O67uW3HJ5nKIJSuw7kbPb0uTzsXmJR4f/Wcd
	sAasgIErulX9JqL6Yb2fOzL+dkZciGv4rHTwcKqijAqhkFqo2Db3+BmWe1wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723805120; x=1723891520; bh=/3dMGy5TVUC7xDyrk7D0BGzHLBdO
	pms3x2V9CUbjhv4=; b=hSuX3CBUZjnG5gwa7+S7+4nkPoK7bpBHZE9ecOH0bwx7
	Dbl6PQhNZMnyvwtTpfFk3ot+abGx4lJ0VW5jARd/VUxXezGBY0hWL2Gpeex3Cu6l
	E9HXAmQYnJvsgJp0EsI2FnPPYVKxsM3W4tT2IEHAm3Mm8Yh2KP3JCmlLJon0pz53
	zB+FUI/My2GSIiGNz/LHf6kfcnAelYGeFrbO2bGWisivIeWJLX5H0bnMU24VUDB8
	d2q60S0MBNQkz7CCq6k1acrSLpJL+7seOvO6n/71dlkZXFGyvShhERKzQPHDA2bn
	Sm3BdWxKfrWRvOvn+2Bso+iFSGG4562EfVgHSX0aQQ==
X-ME-Sender: <xms:wC2_ZmCXTOA4Tp0A9qa-ReLoLbKY8wUV45DRFDui8S9qDVM5fHgbCA>
    <xme:wC2_ZgjQEmXnh7LxU8t09Y3wVvpGtz6FeARv6B1acZnSrY9XSwmtdqfGEY7PElalY
    ey5H-oGPY8qIkL9Iw>
X-ME-Received: <xmr:wC2_Zpkbqp7w-UghEx9fcdUjjSVu_5J0WY0XT0tFrhn_0UfUHwop9PskvgRy-V6LbjkV1D7-KkWozodq2GBOgED6OOsoOksIlSDWfntHZS7sLBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepudeviefffeekjeeghfdtkefgteegveevjeeiffeukedv
    gedukedvvddtveffieefnecuffhomhgrihhnpehinhgtrhgvmhgvnhhtrghlqdhrvghprg
    gtkhdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wC2_ZkyiKMfpst6sCjlh4eAlpf8MpdI5281qZY_ICGMNvvPOl7FQBw>
    <xmx:wC2_ZrQmcRBwjvMeEtvX28Dmv4aZEo_01b3z5ZaSupeAD2trVMer4g>
    <xmx:wC2_ZvbOye_w2GV4H3DDK4tGLfDml8SZVAhv-V8XIPfGAXPQBPSpIQ>
    <xmx:wC2_ZkS0Q_pZqX6DWz7kqoh2hOrRwm0ZEs0U-Dhl5fd7is3hQqYbVw>
    <xmx:wC2_ZqGUjs94H1-N27UE1L1iM3lB4tUezvlDwF6V0tlKTQvxuRaxKznP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 06:45:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 20c9e390 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 10:44:56 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:45:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/7] run-command: fix detaching when running auto
 maintenance
Message-ID: <9befef7c1f7520d58af2b2db17174b8dbc493d56.1723804990.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723804990.git.ps@pks.im>

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
via git-maintenance(1). Instead, git-maintenance(1) now respects a new
config "maintenance.autoDetach", the equivalent of "gc.autoDetach", and
detaches itself into the background when running as part of our auto
maintenance. This should continue to behave the same for all users which
use the git-gc(1) task, only. For others though, it means that we now
properly perform all tasks in the background. The default behaviour of
git-maintenance(1) when executed by the user does not change, it will
remain in the foreground unless they pass the `--detach` option.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/gc.txt          |  3 +-
 Documentation/config/maintenance.txt | 11 +++++++
 builtin/gc.c                         |  1 +
 run-command.c                        | 12 +++++++-
 t/t5616-partial-clone.sh             |  6 ++--
 t/t7900-maintenance.sh               | 43 ++++++++++++++++++++++------
 6 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 664a3c2874..1d4f9470ea 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -40,7 +40,8 @@ use, it'll affect how the auto pack limit works.
 
 gc.autoDetach::
 	Make `git gc --auto` return immediately and run in the background
-	if the system supports it. Default is true.
+	if the system supports it. Default is true. This config variable acts
+	as a fallback in case `maintenance.autoDetach` is not set.
 
 gc.bigPackThreshold::
 	If non-zero, all non-cruft packs larger than this limit are kept
diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index 69a4f05153..72a9d6cf81 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -3,6 +3,17 @@ maintenance.auto::
 	`git maintenance run --auto` after doing their normal work. Defaults
 	to true.
 
+maintenance.autoDetach::
+	Many Git commands trigger automatic maintenance after they have
+	written data into the repository. This boolean config option
+	controls whether this automatic maintenance shall happen in the
+	foreground or whether the maintenance process shall detach and
+	continue to run in the background.
++
+If unset, the value of `gc.autoDetach` is used as a fallback. Defaults
+to true if both are unset, meaning that the maintenance process will
+detach.
+
 maintenance.strategy::
 	This string config option provides a way to specify one of a few
 	recommended schedules for background maintenance. This only affects
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

