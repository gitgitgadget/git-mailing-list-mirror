Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE92367AC
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617733; cv=none; b=OkFfhmB/L3+aeEcTZYHOv51eK+tPhXdYKtAJZlB+nusE3mz8pvezYWTeyTTzzO/+6qCLN5vSzoRDTPz11SrbGNxPNGQzeo7edIe5xZfj6O38RjBdM2txIn8xHE5I+JIPdurSIqRprFhmAFnB5N0GTWaZ2jtGYs3Q0tGEhL12vmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617733; c=relaxed/simple;
	bh=Mk2E4ACYYcEN4iTqGHGvh8tNYtKDM5QNmYUsVUo37Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjup8NHRgabBGPtFrtmcYsRsbcJJHLGQSfuS5mrx9OVggM4iNwyCgO8cLKivBVFZSn2fORyhC55gwUMkLXBV8d5Aa4XZTSZXTNWJlZQAFck6LAki/3NwCVApxfUjv4scD1h7f2wU9SMNzaTAKizmCPRlZyk+g1UogtHMm7DjHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DIwxkDGW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTP4iYDS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DIwxkDGW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTP4iYDS"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C1791140111;
	Fri, 30 May 2025 11:08:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 30 May 2025 11:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617731;
	 x=1748704131; bh=XjmGLFjlEjdqN8Pp/AE6iz4fco0M0AIEjEd4qSlCCbY=; b=
	DIwxkDGWfwkf8du2C2qSiLgdbqH6b8dg01cLT5YMyXsLhi8PWXgBT+rASD9tS90/
	cPJRq3KirfG0I9qGVLAYyInp719LOBzOcp357c7C6PWH3Ex0MjXfKdPMA+mpKc6K
	KmO8EmyaZ9SxLh4aEvGU0q6I2/3nOGygXE/L2ryWsOlUL9sYlNrl6Zy8d3WBc9Uv
	3ZIW6krwyxPNhpOSB6+xbPsWZ/FxBq5HYvdTPp9hoULkiUwd8h+vA1g7Xw3AtuHO
	xRoLzfcRw21J7a2xm9UCXwv0NoNI3SwVg4o5j/j3svhsRiFpb5Z9w58Wv0QizLm2
	1ymlHRdvM3En34tGGelJlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617731; x=
	1748704131; bh=XjmGLFjlEjdqN8Pp/AE6iz4fco0M0AIEjEd4qSlCCbY=; b=R
	TP4iYDSxczAcsp5UGrfdbnYw+xs2HZc6P0DMIIcyr6LkSnFXfA1X/Z+hfFI5aM43
	sB2Ol42iiMTx9gUp66dncQjaGoangvFElSlKFG7kNPORj9V+mDoc/OgLYgDO65ys
	WxSqyh7+yzjn/Yg34DOL23WtTqmw1b9WNkJAHjAsqutFob4aUbRn1Fr68XShZ4gP
	Lo0HZW5Y6XlL2c1iq0AgJ0Z+EIc0I99b8IDwnKTstSaJ3Vq129uMP10QllkgEh9Q
	Z8B9QSstDa890GZcDqyeGYmxFZ509Plk5ietcZmbPgU4X0l5atXxhgHTDfBopwCg
	UJb5/h5NM753P8aS7B4nQ==
X-ME-Sender: <xms:A8o5aFSq6B5mUY5Pj916P2STdXMUfrstO4D9T9BlVR6D1Yv7Ybirlw>
    <xme:A8o5aOwZfldziPX8dPpPxSG-bkA38evmk_vQtAZXirbzpYrEV_UXy2GWaCIdUS0Kr
    g2BPP2a4WiixGdnWg>
X-ME-Received: <xmr:A8o5aK1p6xB0-3JMt8tEKowSXGCRZZ2OnAAmyGM5PsruRck0Bd1OrEt13uoEs7kH3UlUjwmUKc3dWTW0gnty8XzFAYeIGowgiE4VHWX8AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeffeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfle
    esghhmrghilhdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhnvght
    fihorhhkshdrtghomhdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmsh
    grhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:A8o5aNDYjGuJv_H5YYMZeLrnZkn8_yiSIeu27VpL8vSX9Ngm3in_yQ>
    <xmx:A8o5aOj0xtHl1YTIIpw5NTrlbP-fbmaT5BC9u4RDrArIaM4RT-O3Hg>
    <xmx:A8o5aBpThYjFBOtNQcHUjqp5amROYuwh1CA_D0KpDDeRFSgEmFthvg>
    <xmx:A8o5aJhPA4RZoeGJ4cyaHCiPwoTbAbEXRvVkGUUeVwygptXKpXTnfw>
    <xmx:A8o5aBU37qzZILQ6A45S9SxEAuh8LwCD2bHyIgdQuYLvaVRJo_hxvwTX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 607d8828 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:38 +0200
Subject: [PATCH v2 12/12] builtin/maintenance: fix locking race when
 handling "gc" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-12-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
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
index e910a99e033..dfbf20491e3 100644
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
-			die(NULL);
-		delete_tempfile(&pidfile);
+			if (gc_before_detach(&opts, &cfg) < 0)
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

