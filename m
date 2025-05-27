Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408F2798E2
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354683; cv=none; b=GphLOD7KE4I6hPjJJ1MiEXk7Oq6L7vUvncMPFMl9qm8wpQdH0mBvXzDDoCW699S0rENSDYsmoGOuS+qh+jN/+m7cVcT2PJH6wh4/2Lj4tIadfEI8vWdSyRSDTMFm9K0AD9jKKHRD/U/kvvEIf9IiWudKuTPcOvC8kRcnBBEtJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354683; c=relaxed/simple;
	bh=+2mIXniSye9hw0Px0ocoCNJHV98Qf089Y0gYmDqs6Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5MY1YzcVeZEY7QBXdkj4OVv/xywPgYmb8N6/kJuCVQ35m1sRxzQxYD7BMdmAvmL46IomRt5V7rIC42lVtPcuJjEBi7bGvBkdNnc8MHgUx8C6wU6IbAsaZfKbDH3u0OJNkpUMJ6uExGsFNjS+e2nIS5UToQQdhAaoJikxbErIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a7ONgoEs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTz2gUtR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a7ONgoEs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTz2gUtR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 99E5B1383ABE;
	Tue, 27 May 2025 10:04:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 May 2025 10:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354681;
	 x=1748441081; bh=ZyeQqjreNPNsAUOxrLJz/QLUs2cGnT13Ja3ZA77E640=; b=
	a7ONgoEszzVyMhtPZLmDXnt4H6sUk1yq5vv8CC5vYan629VxbrAaB//DFyYuGglG
	GaOdfNWQnn6bKQJnxYKo8YoOipYT/8iZ+CRjcoykxe6XGTlRA4XQv9TVkWeEHt2W
	n4f/qGNqa4mZKEuvtwZ1ls1EOaf/cwjwd0RNk4cUzN51KuU70BlZrQr9Mw4m12QT
	Zu0L126rAN/1oJ7fETYsFe5GifLK65wVNsH5ar1dF+Ej1F03hM0JUSFbWG2JXgIf
	YKEG6m49di5yEwbGiRtcAoHGB55+n4kQYrFrcZfL5bihL6aBAfCzHMzGAi7tO0SN
	UxwPg+NIednurMWEzWPtzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354681; x=
	1748441081; bh=ZyeQqjreNPNsAUOxrLJz/QLUs2cGnT13Ja3ZA77E640=; b=o
	Tz2gUtRr3GClYvozeiyKF2h7VlnzZzg1KmvrRRYR7ju8saVDWkPt0xRa4NcqITzp
	4rUHveOl303rlq0vEaJYI2KLaOGQc/utLMIxkqxhythFj1tv3cEPZYMHtIcZzz4C
	GG/LGEMp2Cjad2xwz4wZBXIBLdYszVpn3Npy+poWHq/Le4zU+N7T2LU12wITRNnu
	o6758/bhCvAJdHvFX+WDiMZ1LDAV5djXbMTkYdRbExH/SheE8H9ebqFGKDxT1fFe
	XS/bHcH37xExqlDs8p2MKHg5T2TrVuVX06C5QWntgN9SCfVUnZsQL65FbW4jVcfu
	AOy/Dp2YJV38QY8I64CIw==
X-ME-Sender: <xms:ecY1aJqASOjAHLx-C-z0wyguZbcFwNgnTwmGuiR0PgwoQ1ChMux9Fg>
    <xme:ecY1aLo5V2zBg_8kKMGb7q5NbjdcelS8zic3RmgI7Szjync0eEVYW-QoLf3RrQbgD
    APnS4QPDYYVPSp7lg>
X-ME-Received: <xmr:ecY1aGMI2fmx2K3anf2ODckpljy21SUQ7iYZfw2rFqxbd6HGHOZRJyKFx1V-vdfiKifwk1cTimnrFF2B2PFLaJOC6NaF6Zhw3df98cL5lIdUHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfle
    esghhmrghilhdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhnvght
    fihorhhkshdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:ecY1aE7wGDlU6pMLR5NMyYkFOhuLCMZHG8ZRifkPBWNUitTmPex-0A>
    <xmx:ecY1aI4psB9kqckDROvoAg3pMeHzkImw9l162g1endLtd77gDhCbDw>
    <xmx:ecY1aMjhJbfnV2OZ7KNEHlzGKqH-FvVmGLMIHK6InIb7FbD0XrIW_A>
    <xmx:ecY1aK5j-Ao4oZume5LVtAjlW3hbw3Oyx8nZNr1GAQnvTUhWOWNwXA>
    <xmx:ecY1aP0-3kU_95hw2tqdYZSma_1G20v7YHJWqlKshrPsIybgRpOc24KR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6fa32fc6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:37 +0200
Subject: [PATCH 11/11] builtin/maintenance: fix locking race when handling
 "gc" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-11-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
X-Mailer: b4 0.14.2

The "gc" task has a similar locking race as the one that we have fixed
for the "pack-refs" and "reflog-expire" tasks in preceding commits. Fix
this by splitting up the logic of the "gc" task:

  - Before detaching we execute `gc_before_repack()`, which contains the
    logic that git-gc(1) itself would execute before detaching.

  - After detaching we spawn git-gc(1), but with a new hidden flag that
    suppresses calling `gc_before_repack()`.

Like this we have roughly the same logic as git-gc(1) itself and know to
repack refs and reflogs before detaching, thus fixing the race.

Note that `gc_before_repack()` is renamed to `gc_before_detach()` to
better reflect what this function does.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           | 39 ++++++++++++++++++++++++++-------------
 t/t7900-maintenance.sh | 12 ++++++------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 174357b9c25..2cf61efcee9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -816,7 +816,7 @@ static int report_last_gc_error(void)
 	return ret;
 }
 
-static int gc_before_repack(struct maintenance_run_opts *opts,
+static int gc_before_detach(struct maintenance_run_opts *opts,
 			    struct gc_config *cfg)
 {
 	if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
@@ -837,6 +837,7 @@ int cmd_gc(int argc,
 	pid_t pid;
 	int daemonized = 0;
 	int keep_largest_pack = -1;
+	int skip_maintenance_before_detach = 0;
 	timestamp_t dummy;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
@@ -869,6 +870,8 @@ int cmd_gc(int argc,
 			 N_("repack all other packs except the largest pack")),
 		OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
+		OPT_HIDDEN_BOOL(0, "skip-maintenance-before-detach", &skip_maintenance_before_detach,
+			   N_("skip maintenance steps typically done before detaching")),
 		OPT_END()
 	};
 
@@ -952,14 +955,16 @@ int cmd_gc(int argc,
 			goto out;
 		}
 
-		if (lock_repo_for_gc(force, &pid)) {
-			ret = 0;
-			goto out;
-		}
+		if (!skip_maintenance_before_detach) {
+			if (lock_repo_for_gc(force, &pid)) {
+				ret = 0;
+				goto out;
+			}
 
-		if (gc_before_repack(&opts, &cfg) < 0)
-			exit(127);
-		delete_tempfile(&pidfile);
+			if (gc_before_detach(&opts, &cfg) < 0)
+				exit(127);
+			delete_tempfile(&pidfile);
+		}
 
 		/*
 		 * failure to daemonize is ok, we'll continue
@@ -988,8 +993,8 @@ int cmd_gc(int argc,
 		free(path);
 	}
 
-	if (opts.detach <= 0)
-		gc_before_repack(&opts, &cfg);
+	if (opts.detach <= 0 && !skip_maintenance_before_detach)
+		gc_before_detach(&opts, &cfg);
 
 	if (!repository_format_precious_objects) {
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;
@@ -1225,8 +1230,14 @@ static int maintenance_task_prefetch(struct maintenance_run_opts *opts,
 	return 0;
 }
 
-static int maintenance_task_gc(struct maintenance_run_opts *opts,
-			       struct gc_config *cfg UNUSED)
+static int maintenance_task_gc_before_detach(struct maintenance_run_opts *opts,
+					     struct gc_config *cfg)
+{
+	return gc_before_detach(opts, cfg);
+}
+
+static int maintenance_task_gc_after_detach(struct maintenance_run_opts *opts,
+					    struct gc_config *cfg UNUSED)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
@@ -1240,6 +1251,7 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts,
 	else
 		strvec_push(&child.args, "--no-quiet");
 	strvec_push(&child.args, "--no-detach");
+	strvec_push(&child.args, "--skip-maintenance-before-detach");
 
 	return run_command(&child);
 }
@@ -1561,7 +1573,8 @@ static const struct maintenance_task tasks[] = {
 	},
 	[TASK_GC] = {
 		.name = "gc",
-		.after_detach = maintenance_task_gc,
+		.before_detach = maintenance_task_gc_before_detach,
+		.after_detach = maintenance_task_gc_after_detach,
 		.auto_condition = need_to_gc,
 	},
 	[TASK_COMMIT_GRAPH] = {
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 1ada5246606..e09a36ab021 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -49,9 +49,9 @@ test_expect_success 'run [--auto|--quiet]' '
 		git maintenance run --auto 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
 		git maintenance run --no-quiet 2>/dev/null &&
-	test_subcommand git gc --quiet --no-detach <run-no-auto.txt &&
-	test_subcommand ! git gc --auto --quiet --no-detach <run-auto.txt &&
-	test_subcommand git gc --no-quiet --no-detach <run-no-quiet.txt
+	test_subcommand git gc --quiet --no-detach --skip-maintenance-before-detach <run-no-auto.txt &&
+	test_subcommand ! git gc --auto --quiet --no-detach --skip-maintenance-before-detach <run-auto.txt &&
+	test_subcommand git gc --no-quiet --no-detach --skip-maintenance-before-detach <run-no-quiet.txt
 '
 
 test_expect_success 'maintenance.auto config option' '
@@ -154,9 +154,9 @@ test_expect_success 'run --task=<task>' '
 		git maintenance run --task=commit-graph 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-both.txt" \
 		git maintenance run --task=commit-graph --task=gc 2>/dev/null &&
-	test_subcommand ! git gc --quiet --no-detach <run-commit-graph.txt &&
-	test_subcommand git gc --quiet --no-detach <run-gc.txt &&
-	test_subcommand git gc --quiet --no-detach <run-both.txt &&
+	test_subcommand ! git gc --quiet --no-detach --skip-maintenance-before-detach <run-commit-graph.txt &&
+	test_subcommand git gc --quiet --no-detach --skip-maintenance-before-detach <run-gc.txt &&
+	test_subcommand git gc --quiet --no-detach --skip-maintenance-before-detach <run-both.txt &&
 	test_subcommand git commit-graph write --split --reachable --no-progress <run-commit-graph.txt &&
 	test_subcommand ! git commit-graph write --split --reachable --no-progress <run-gc.txt &&
 	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt

-- 
2.49.0.1266.g31b7d2e469.dirty

