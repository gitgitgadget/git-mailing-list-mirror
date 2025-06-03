Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1E239570
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959285; cv=none; b=l2AzSyIJ1umTe5Gjl0g5FAVbZipyrmq8/tVIKXv8WhvgDR0Mfvb2nMj3mPgUUPGzWTKQ1u1e0XgAj05gTtJFZDrNSKoDQphDezHroxC289onSoxOAEvuaw5Uli7XIZ9toIre+Q2gMw8SDz4SarpSEaMrCwtAH3Gy5YNwi30I8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959285; c=relaxed/simple;
	bh=ZEauAL/EWMWqID8DOZakWrybmQYpnoqM+Wvdbs6PB14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RvoVHjKr7p8IKBSkZcSmaSL4v9batF628LFx8jmfJx1qZcwiHNOT61vRk4IdOdkUq/EW3lNjk71u7N8FNx67LB/19c8KQY7cg8e+ys+cQKg3EInSul96Zyvk5pDW3OAlAwoHGu/CWCpKqhldCABGZo+vxOqDKtzCJcPoV8qv00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O8tkuogd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZhhgOrv8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O8tkuogd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhhgOrv8"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D47C911400F2;
	Tue,  3 Jun 2025 10:01:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 10:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959282;
	 x=1749045682; bh=oiig2Q+koIRE5cuqva3IUjQ83RoX1Cv7Q39nc9wMuDk=; b=
	O8tkuogdTSa5nGNDiUatPvk2ajlfFHU5RM94ddGfXQJa3jQ1Y/gsagL10IaopMF/
	iEnsTA0yC30537MVd2CPJjfBpDUItsgEl6hb3NSMk/1k+wKUPEraChia0hXTHWJS
	7i3EnMMRUK5yhk9JLhMC2EAlvCjZpjfTRe2RUHyrBNT5xM+cYi+cG622qouZ/wL8
	c1WIW81cv+WfDxvaXkouaEukUT3CUqMQbP2rFKnJ6vjYrkujZ9PXgOc7A0XzFI06
	z2aw/1SjVY1uQxz+HbzwLxmcUx8ObkOy/gRv+S1SAHMh8TIxuMLZV8NufsDssR5C
	YbDpzEVESQI6P4oP2nsYEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959282; x=
	1749045682; bh=oiig2Q+koIRE5cuqva3IUjQ83RoX1Cv7Q39nc9wMuDk=; b=Z
	hhgOrv8Zl9B5QN6gckLSSbnLD+DDEoP6yJ7cunXVk9DDp5je2TanA5oPw3sSkZQ8
	+pFsup5JY+GKjUe1qm55cC5XL9hYa7hu7aJUSRcpjoMcxNlaIcf7NrYvLmgV+dwu
	dNbk0cCgz7yIeW6Irg2ptDr6v5G2VajYj3RnWA8cv+6Lrxi/kcO08d+OrduVyYMF
	acYFME4rQZoN2PEG63EL3vcW5FoIIyPOdnUTP5P27EdOc+RtV5GB7pwCgCUBDPfI
	ZPHWqkFLyiw3kIwC4BtoTKB/NhvzbfSA3hSaBbYJZ0nF9H4BF3jmhWK7rM6nF6b1
	dC7AizS/YZorIew5LpMaw==
X-ME-Sender: <xms:MgA_aIoxK3Unpay5bdT7N8p8m4ikukxaM2Q3mSfCA9mU4TzYROROlA>
    <xme:MgA_aOovFFH_P1WzjwS65-dnveUOcu81Y7zeFJeKaPZYtHQ35QkQOOI5agFXEuYze
    ErfsybkgFndav2AbQ>
X-ME-Received: <xmr:MgA_aNP6vLfXN-Ft0G4nUZ7tCchBuQ11WqSf1Mqtmcy8SJkVjvPAwe2DrPoanqwiDUZIIVYfiHy8C7Vdo6W0Z-ZAXKd3dYw7TUs8ew9voA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepug
    grshhrrghfleesghhmrghilhdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgr
    lhhtohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgoh
    hoghhlvgdrtghomh
X-ME-Proxy: <xmx:MgA_aP7JN35XqUzOCQJim65DWL1LGTPpeQBoLyjardSpJVrUs94lwQ>
    <xmx:MgA_aH75ppPC6UVd8PEwUdxw29qXc3zr8xnsrrLXrh1piZjz7DM-aw>
    <xmx:MgA_aPgKTqeO0XYwiBoSdrMyJtt-jso2DG86IoRWm1_DbomI8104VA>
    <xmx:MgA_aB4NU_kghqsqpyP9rzRh7PjJrhctKB2LNTsBFsu0RK6In5qwBA>
    <xmx:MgA_aG6MLLzCjS_7VQjkTGVVLktdMpqUAWurwS1yeoJkC6HgY9XHwVab>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dda0abf4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:10 +0200
Subject: [PATCH v4 02/12] builtin/gc: drop redundant local variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-2-52f5cf7b7e99@pks.im>
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

We have two different variables that track the quietness for git-gc(1):

  - The local variable `quiet`, which we wire up.

  - The `quiet` field of `struct maintenance_run_opts`.

This leads to confusion which of these variables should be used and what
the respective effect is.

Simplify this logic by dropping the local variable in favor of the
options field.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 54fc7f299a9..7adda8d2d0d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -818,7 +818,6 @@ int cmd_gc(int argc,
 	   struct repository *repo UNUSED)
 {
 	int aggressive = 0;
-	int quiet = 0;
 	int force = 0;
 	const char *name;
 	pid_t pid;
@@ -831,7 +830,7 @@ int cmd_gc(int argc,
 	const char *prune_expire_arg = prune_expire_sentinel;
 	int ret;
 	struct option builtin_gc_options[] = {
-		OPT__QUIET(&quiet, N_("suppress progress reporting")),
+		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		{
 			.type = OPTION_STRING,
 			.long_name = "prune",
@@ -891,7 +890,7 @@ int cmd_gc(int argc,
 		if (cfg.aggressive_window > 0)
 			strvec_pushf(&repack, "--window=%d", cfg.aggressive_window);
 	}
-	if (quiet)
+	if (opts.quiet)
 		strvec_push(&repack, "-q");
 
 	if (opts.auto_flag) {
@@ -906,7 +905,7 @@ int cmd_gc(int argc,
 			goto out;
 		}
 
-		if (!quiet) {
+		if (!opts.quiet) {
 			if (opts.detach > 0)
 				fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
 			else
@@ -991,7 +990,7 @@ int cmd_gc(int argc,
 			strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
 			/* run `git prune` even if using cruft packs */
 			strvec_push(&prune_cmd.args, cfg.prune_expire);
-			if (quiet)
+			if (opts.quiet)
 				strvec_push(&prune_cmd.args, "--no-progress");
 			if (repo_has_promisor_remote(the_repository))
 				strvec_push(&prune_cmd.args,
@@ -1019,7 +1018,7 @@ int cmd_gc(int argc,
 
 	if (the_repository->settings.gc_write_commit_graph == 1)
 		write_commit_graph_reachable(the_repository->objects->odb,
-					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
+					     !opts.quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
 	if (opts.auto_flag && too_many_loose_objects(&cfg))

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

