Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5821714D9
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720928; cv=none; b=sbCbg2hFCjaKveMdtW/PcsWcoHxAH2g8LNPKD7Io9daH6hT2ehz0f5p7Oqlcpmm+7sIgRPQ4chbein0OyBtXCQIsvOvYQGZoGcYQUm2lmtiBVnUutJwNdBxCBEKJzwYRfdtgPyP8wVEi3X0o+D7BpymH4rbazcW2wUzssYMZPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720928; c=relaxed/simple;
	bh=fL1HQdQuVmc3z7BqSawLrpfPIfS+LB81t/111eGUMUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2lPvRRyXYUbng/rgCuiUef5FbEIw7QS47c1FamaB4I+dZfzHUSd9PSvmYpjxtffrVmDvV5MF0T7vgh0gGE5E4+UT3ycQtZYKT2nc0yWDlZLgctwx4YBNP+C8lK6iUb0jxl7c+/nSOGh/hKZy2vPk7TRqjMCydo4bMDzRcH1tto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=On9cRRdq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O32Bd7cX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="On9cRRdq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O32Bd7cX"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AEB01114FAEB;
	Thu, 15 Aug 2024 05:12:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 Aug 2024 05:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723713171; x=1723799571; bh=acZkjmdiOh
	AGQa7xL2Dsf9FEqKdoKuuk+YdneJDPIJE=; b=On9cRRdqwxPFLkPgNrfM0vJVGV
	fXkf7BBX1wY7pK6ACMhIZ0TVsE143Hg6wVLYOWvcMaQNVkF4l4zkhULDbvtLoFLe
	nsKcWLOcDw/Vkft67xtPdwCGQOpeJYgETLqSzXc6l0tv4cn7agVtleWC38kSUq7x
	31LM5NaknB2VWMqcXB0b9MyBJbAl0TKWkLreFEhBSAKnC9r9H2drDBoKW223ayrb
	/eeEW02J8qdepZFg1hhppNQZFxw0oVwzd1TdHNJdTHz1889k3e+9raKP4BCWW1Cj
	o8zbhbJScsNwaTxF32HZYYP2kSOnw01NTTwoyWzTnsaBUenqgsQcWzuEhxeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723713171; x=1723799571; bh=acZkjmdiOhAGQa7xL2Dsf9FEqKdo
	Kuuk+YdneJDPIJE=; b=O32Bd7cXRxTqDTZlF5JrWIBd36o5NwMB9E7U1lvUoU7t
	DmGN5lgSuUZhuraY9sbbtseau+r/wTPKZoB6jL2y9kL97zbtHqNaWXdBEd+Fo1F3
	UIXsnCJozgc7buOPA2RX9ElFqeXLjYJ1QlarKN6MR8l/ikBsVJC1VYmuX2bBNUvG
	nKPYWxdE4Ht/XjEBvLhmL8H7WWGbsycuCqtrHiyNxa/gWoqiyCgPFsk5VGkZk4lB
	SZO6biMu/jCh0XzInO2oYR4kgP9vuk++zHM5onFOOWyqul/8ixrkYlGRDxEeQ1pt
	6ROUFXBeXtRpSKlxCMLpxLr7Ff6cJk+eVVFeAD/Vyw==
X-ME-Sender: <xms:k8a9ZoMv_MRRDP9WnTs-ldalhADS2m1aJZIjKJN3Y4Vy22nXy311-w>
    <xme:k8a9Zu8IyiBern4n0OwqHOoPu6z8j2P4xOXTDw2Ac55Pz77e2LLanyFEZtuUrKflE
    5_7StyLHao80WHViA>
X-ME-Received: <xmr:k8a9ZvTfwO9cBW6OBpzCYJ_my-L04EhSzH-GzZxMP-WF5XvTlus1BGiD9lNBr3MrnZw3TgL_xbK1qXY5p6c4sVh6_S94LP0j5goC88KPJgsPAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepudeviefffeekjeeghfdtkefgteegveevjeeiffeukedv
    gedukedvvddtveffieefnecuffhomhgrihhnpehinhgtrhgvmhgvnhhtrghlqdhrvghprg
    gtkhdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:k8a9Zgv_J7DN_etrgRg9ZdRkxWIIv1WcethTaCy2LwO8gYpkrucc8w>
    <xmx:k8a9Zgc-k9RMLYmJQbzKo19eroR70fYHzO0uZ8oxxNAMEzZed6UyNw>
    <xmx:k8a9Zk1Pxo0vE7-1GVjtpqhqlGR-heB99wyxj-G6wp9DYFp4wvkrOw>
    <xmx:k8a9Zk-DSNxhcOzA6V5hR_sjzNdB_pNTmPowORImc14g9_L3F8D9Ug>
    <xmx:k8a9Zv6MQ88Fza4XnpImb_xZxtBoYgkJETVJA6k6y9dwGd5Yz9200UwH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:12:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85cb8db9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:12:30 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:12:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>
Subject: [PATCH v2 7/7] run-command: fix detaching when running auto
 maintenance
Message-ID: <6bc170ff05d38845a012ce57e580a0ddd18f1143.1723712608.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723712608.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723712608.git.ps@pks.im>

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

