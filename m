Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC2157A55
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848657; cv=none; b=LKpiQP/hWKD04UpgHWJSlMncrludDIjkybJPQu/SwK1X8Vh8R7sPkvgsDZBuwGxTNUEYQtP2cewBSHSTW3wZdPeKAV5m5+M71qrNc3vbTwx6nEQFCal2xcfVFc2vFUHaRP+FG5jjVhQsxrkLrFU14i7u3inE7yFjT67/jW42+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848657; c=relaxed/simple;
	bh=ZEauAL/EWMWqID8DOZakWrybmQYpnoqM+Wvdbs6PB14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHJ6WKhMP45hcOchJDhUwPLkw9oYD6ZkGMlhJoSihEI7/Mup5aOBvkl1LK2aH+5Vr+/n9JLstj9DWVrs4mYa526o52a32Poj2jfoBx/lOm2GAIhPvZF/6c2adL39xLJ9M2Op1qSSa5CCVvILpzV/WtN0j3ZljhruhZKVGb/c32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AVzz05Q2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMrEuUaN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AVzz05Q2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DMrEuUaN"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A5D1D1140111;
	Mon,  2 Jun 2025 03:17:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 02 Jun 2025 03:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848654;
	 x=1748935054; bh=oiig2Q+koIRE5cuqva3IUjQ83RoX1Cv7Q39nc9wMuDk=; b=
	AVzz05Q2rnjwZ8vzYZJnsKLmI0P8iXXrJshcgUgEUZD1CXsYuN6tPCKJ2VDz248X
	I8ySf1NywmUReHswpDlZs2jxAVPNjG/RWLuvzU5R/ujuGvkpyUYo4x1GbaGsgm+A
	/wVMflP6p2CO4DHOcwWOmuprefnr8E57iLonXnNVZuzfZII8nC/HauUqDOrsKG+U
	NFDDU4uv0Y+jsYUXPAWph7dpBFFLKjx7QOUgiZmm+sBWVOG5vMcNgl8x5sA4TOMs
	+I4713NrtmO9uho5EYhKxsa6Vm6y9mDtWV8AN5bVLDJ/6R/mXwI8mFxpJZMQ/AXC
	sp8JSd9pL9BnxWc1KlX+TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848654; x=
	1748935054; bh=oiig2Q+koIRE5cuqva3IUjQ83RoX1Cv7Q39nc9wMuDk=; b=D
	MrEuUaNvrSvefxEIc/nJhSLm3XMeFBHeAZ6pi/6mDBjpikzQaxJm5zoZ2KL4XIzt
	k1/rfEItEMPG3aNtK+J/ZYI6p6FnZs4FygFEOp1bRgNtNUWVNX9FM3dvo42NXdTb
	OC3GbCWnwxsw9q1pxCNVJJuknsoPtALHc98TzhXgUJYEZ3PLIMROfPjVaK/PaqyC
	wr8ZjtdLc550ifkP6+MzZdg9nd3OGaXR2ckiK1cEpLcqQCPbpF6uC/J5zMmIH9Pr
	TmD22y8PRP6VaC7O29nR6j00y8cBkXWiH0U0/7hnLM+718F4SK7U/gOXCsB9pwae
	ARHDk/5f7JSwhWN37mpKQ==
X-ME-Sender: <xms:DlA9aMdJVBJakc_B8lAZtI4rNhpMoxJKXZ1SWcxVmoTAGOmUDx_N-w>
    <xme:DlA9aONPlmXMLPEBLIWQKJTrj7vxb-Bwyrnf7mMcHbZSLYWQi0cEPdJL7zLpYAE9Y
    gJUPoPouWXIVcadLA>
X-ME-Received: <xmr:DlA9aNhNasNTqdV-CPi-Q0MENRnUVMu4DNQS6oZ9N_qkst4g-C3d7_zz-jmmXoBYa-8q_nO7SAhA7tvjB0KJ1nf2Y9Yy9woTt_Y6EzcTHI9-Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihrohhthhesph
    grlhhorghlthhonhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhf
    ihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjh
    honhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdr
    tghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DlA9aB-hNg7HDyKZ3q3wnB0yJUqmettEsAJoLb_nhJq0-rW5ossAoQ>
    <xmx:DlA9aIs43Mgzvbot4MQLx1d_NeL0XxTOdtKVMsFHI8TSsY2JDYPx0w>
    <xmx:DlA9aIGRm4tNiDlOrvdw_EERddgwUB-UXXzpUXS9tHaRjlEsJm58sA>
    <xmx:DlA9aHNrgKlOPrm-yx70v44Jn5VW099-mds4NxHhEtqJ6AAB9B5tPA>
    <xmx:DlA9aHCvAXT_dd-BATMwZ_DCywChiL2fmlgEO2cH2UlWt1sKOWr2MPNn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2200d754 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:28 +0200
Subject: [PATCH v3 02/12] builtin/gc: drop redundant local variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-2-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
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

