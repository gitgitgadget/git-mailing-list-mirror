Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D523956A
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959294; cv=none; b=ErzeWJnwIfAGRpJpOMgO3MMD6xHoTV/5epohTu+v4HVXbY/7MD7yyj4D6bYLloi6c1cSb9J9jupWJ271nnmuKynK7V2sumM/yDl6rQ1WqsQkafc2Hlq+0rjrWc+2dgUFM/qjLy1q3UcDeFjRYGtGNmOKnw9HQncW1T+IuLRJmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959294; c=relaxed/simple;
	bh=7CPWCWwglhvoL+0H6I1sFTqh8myG3TOMsehwcpJcqDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YvU5WLBelFwHXWEcZ+1KsdPgKVl6xV2ykPFgrveKB096kL0D3xdk6SqcX0bbqZ8Ne/6v/HzU99hDUd6o4h3TQimzBHI34qPBOySa6NbgZIGMXNx0skvQpubMkbbHiKoPSJDPYwLs5B87bFTwoIu9hJw6BF80cmAs7+jvxY/Ld0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KFs/3/mr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FGYXyxM2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KFs/3/mr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FGYXyxM2"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9340B25400FF;
	Tue,  3 Jun 2025 10:01:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Jun 2025 10:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959290;
	 x=1749045690; bh=k6VP387egON4tQZP+JuDiz0bGDhY5gTqQ08J2p/Dpb0=; b=
	KFs/3/mr1MbUUU7MFc1U1DFFeMHGkujOJ66QDQoWi0s8iBW2mUK1rHjgaazdK1ex
	oHlV1M0WafRsR2cQckCSXMjM8cwu2mRQ3mMTtEnB6/zb0bEtVJPAHWnHBvj4A9IF
	+y/t7dSVBlEFabj96mzej6aFLPlcJwl73eMMfIMMqVuAo2Oam22EKTUQzpkoA4WJ
	9NlnQ08QXXbXinGpGkktayMs+x+bvS7QDXRh2XYAlAG04JxUUWEVmNAwq3tbUR9q
	gEZ62GRIT/E9qbOp2j7FaH1wpYX+zBCyR11c0mBXHtTZk6SLRCgfODIhwj3QPow/
	qHhmQOTX1+EqB08W0ntF7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959290; x=
	1749045690; bh=k6VP387egON4tQZP+JuDiz0bGDhY5gTqQ08J2p/Dpb0=; b=F
	GYXyxM2LgxbWGxOVAl2xpTMatWGe2XXT2tt9fb508wCH3MQql7AfNHNUjx+edAVN
	ILLfEvNl03HG10zl2kdaxoodHB0FyZpwx/BCkWNmLjCg7nhjaVX64yAnHZwlypmB
	Dx97nwWR/Kd2Q2JZG3QhTzwjrbJ6dGoby0zJsh8/Uur/DxIUOfHEVuww9ICE3FUP
	yoow9Hr8lyIQGzqfw105blbO0CwqIXFbjA/5jpGBqEVzNENl9t2LQ2zlYGQgbf46
	VErCBcDJQaS6QCG+K+raPbZ1BTnpL2DkTzixptGygF/f7g86HtbXiDtvSPZZO1+G
	iI8omHn3i3XwcNgOb7bmw==
X-ME-Sender: <xms:OgA_aMVPKbu95Net_G5V8q0inIT8nRvDtjc93dfVRXB4PcE_92U3rQ>
    <xme:OgA_aAkR1HVqIKqdoOP6uoSTTF8gH7yCn63oxkLtLN2G7UtHXy_YnhARSO0V34QcU
    DJfHvWWerOcu5kj2w>
X-ME-Received: <xmr:OgA_aAavRSw2t87zZRSbU9i4yXFq4FDCOIpuK57uMTl2aOjExSIECtubgI_Q4MMwJPmm6_4r5GK3CSbGvsEW4s-MASIyjUU0YiilORTnrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhnvghtfihorhhkshdrtghomhdp
    rhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpd
    hrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtth
    hopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehnrghsrghm
    uhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OgA_aLVVVkfgV2dD9GIuTbJrms45we-rtINg8md563d8xy5gjuQqlg>
    <xmx:OgA_aGng4iUCH6K6XjCbx4rF61pEl_Mthgm9PFZWRej6Th-19WDVaQ>
    <xmx:OgA_aAd_6mZ0I7HgKosQZhFEEp_9u3NBB8L-_-BJzgJxMBhlV9cAOA>
    <xmx:OgA_aIHxCR9NDZedpTGZNNlUNELO2pJZj8as_bhI8YBGgJBvcd5obQ>
    <xmx:OgA_aJnYnKtezVf8RMrskg4l5KqsQEDnSz4tmzMaZxXWDF7j7J-EXk5E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19f3d7ae (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:20 +0200
Subject: [PATCH v4 12/12] builtin/maintenance: fix locking race when
 handling "gc" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-12-52f5cf7b7e99@pks.im>
References: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
In-Reply-To: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The "gc" task has a similar locking race as the one that we have fixed
for the "pack-refs" and "reflog-expire" tasks in preceding commits. Fix
this by splitting up the logic of the "gc" task:

  - We execute `gc_before_repack()` in the foreground, which contains
    the logic that git-gc(1) itself would execute in the foreground, as
    well.

  - We spawn git-gc(1) after detaching, but with a new hidden flag that
    suppresses calling `gc_before_repack()`.

Like this we have roughly the same logic as git-gc(1) itself and know to
repack refs and reflogs before detaching, thus fixing the race.

Note that `gc_before_repack()` is renamed to `gc_foreground_tasks()` to
better reflect what this function does.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           | 41 +++++++++++++++++++++++++++--------------
 t/t7900-maintenance.sh | 12 ++++++------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4a5c4b20442..b5e6519d597 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -816,8 +816,8 @@ static int report_last_gc_error(void)
 	return ret;
 }
 
-static int gc_before_repack(struct maintenance_run_opts *opts,
-			    struct gc_config *cfg)
+static int gc_foreground_tasks(struct maintenance_run_opts *opts,
+			       struct gc_config *cfg)
 {
 	if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
 		return error(FAILED_RUN, "pack-refs");
@@ -837,6 +837,7 @@ int cmd_gc(int argc,
 	pid_t pid;
 	int daemonized = 0;
 	int keep_largest_pack = -1;
+	int skip_foreground_tasks = 0;
 	timestamp_t dummy;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
@@ -869,6 +870,8 @@ int cmd_gc(int argc,
 			 N_("repack all other packs except the largest pack")),
 		OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
+		OPT_HIDDEN_BOOL(0, "skip-foreground-tasks", &skip_foreground_tasks,
+			   N_("skip maintenance tasks typically done in the foreground")),
 		OPT_END()
 	};
 
@@ -952,14 +955,16 @@ int cmd_gc(int argc,
 			goto out;
 		}
 
-		if (lock_repo_for_gc(force, &pid)) {
-			ret = 0;
-			goto out;
-		}
+		if (!skip_foreground_tasks) {
+			if (lock_repo_for_gc(force, &pid)) {
+				ret = 0;
+				goto out;
+			}
 
-		if (gc_before_repack(&opts, &cfg) < 0)
-			die(NULL);
-		delete_tempfile(&pidfile);
+			if (gc_foreground_tasks(&opts, &cfg) < 0)
+				die(NULL);
+			delete_tempfile(&pidfile);
+		}
 
 		/*
 		 * failure to daemonize is ok, we'll continue
@@ -988,8 +993,8 @@ int cmd_gc(int argc,
 		free(path);
 	}
 
-	if (opts.detach <= 0)
-		gc_before_repack(&opts, &cfg);
+	if (opts.detach <= 0 && !skip_foreground_tasks)
+		gc_foreground_tasks(&opts, &cfg);
 
 	if (!repository_format_precious_objects) {
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;
@@ -1225,8 +1230,14 @@ static int maintenance_task_prefetch(struct maintenance_run_opts *opts,
 	return 0;
 }
 
-static int maintenance_task_gc(struct maintenance_run_opts *opts,
-			       struct gc_config *cfg UNUSED)
+static int maintenance_task_gc_foreground(struct maintenance_run_opts *opts,
+					  struct gc_config *cfg)
+{
+	return gc_foreground_tasks(opts, cfg);
+}
+
+static int maintenance_task_gc_background(struct maintenance_run_opts *opts,
+					  struct gc_config *cfg UNUSED)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
@@ -1240,6 +1251,7 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts,
 	else
 		strvec_push(&child.args, "--no-quiet");
 	strvec_push(&child.args, "--no-detach");
+	strvec_push(&child.args, "--skip-foreground-tasks");
 
 	return run_command(&child);
 }
@@ -1571,7 +1583,8 @@ static const struct maintenance_task tasks[] = {
 	},
 	[TASK_GC] = {
 		.name = "gc",
-		.background = maintenance_task_gc,
+		.foreground = maintenance_task_gc_foreground,
+		.background = maintenance_task_gc_background,
 		.auto_condition = need_to_gc,
 	},
 	[TASK_COMMIT_GRAPH] = {
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 1ada5246606..ddd273d8dc2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -49,9 +49,9 @@ test_expect_success 'run [--auto|--quiet]' '
 		git maintenance run --auto 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
 		git maintenance run --no-quiet 2>/dev/null &&
-	test_subcommand git gc --quiet --no-detach <run-no-auto.txt &&
-	test_subcommand ! git gc --auto --quiet --no-detach <run-auto.txt &&
-	test_subcommand git gc --no-quiet --no-detach <run-no-quiet.txt
+	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-no-auto.txt &&
+	test_subcommand ! git gc --auto --quiet --no-detach --skip-foreground-tasks <run-auto.txt &&
+	test_subcommand git gc --no-quiet --no-detach --skip-foreground-tasks <run-no-quiet.txt
 '
 
 test_expect_success 'maintenance.auto config option' '
@@ -154,9 +154,9 @@ test_expect_success 'run --task=<task>' '
 		git maintenance run --task=commit-graph 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-both.txt" \
 		git maintenance run --task=commit-graph --task=gc 2>/dev/null &&
-	test_subcommand ! git gc --quiet --no-detach <run-commit-graph.txt &&
-	test_subcommand git gc --quiet --no-detach <run-gc.txt &&
-	test_subcommand git gc --quiet --no-detach <run-both.txt &&
+	test_subcommand ! git gc --quiet --no-detach --skip-foreground-tasks <run-commit-graph.txt &&
+	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-gc.txt &&
+	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-both.txt &&
 	test_subcommand git commit-graph write --split --reachable --no-progress <run-commit-graph.txt &&
 	test_subcommand ! git commit-graph write --split --reachable --no-progress <run-gc.txt &&
 	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

