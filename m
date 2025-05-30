Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1B23505A
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617726; cv=none; b=idDifY6pSaJ74UCDb47zIqwLAILXSl8l6bDkZ+iDTUtCTVH+rxCYSDysX7q1Oiy/YSgZjnhK0VAhMlHMofXrFBJ4kQW8WqkTiSD6CkIpkpowZBAQf8oag1W2hHOACvS10i0y/UzQzazy9sfpARBy1Q+zniCVEw6ugON2bFV3e1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617726; c=relaxed/simple;
	bh=4drG+1VelgOp3BVKlJ3G0XtOtn7P4tlxWcbbllEeF6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4G+7pauwnLPl4FjrH9sNdum4NLx/SRxsXOkAJ3CgAwPH5bqHGBSybIdNO+73FGOD/Q1A6ZKk+/vZo7odQf9hdpqTrg844Xx8M5rL7OQZsAbpO20u8D/ixeJJChnN/89czPfPNZ8r/0rxYyKdFQiKNuCrJ/XyXuRAfaPK9e6SbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GFXnMbah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WsF3924i; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GFXnMbah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WsF3924i"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id B5C9B1380185;
	Fri, 30 May 2025 11:08:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 30 May 2025 11:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617722;
	 x=1748704122; bh=cm4zvllI1XSa/QJUvdC6XNazEpSgWNjQsF/M6H8uS80=; b=
	GFXnMbahKNrJcNdNfzVkjhLT2Ki3MmLcgY1XCVTBhC4O+sjv//VZIZzW9udHrTqn
	6XCBZ00aFSsJonvbz0PAT9jO0RWlGbnx0/9jEIVP13v8GatI25MOukwkTBhz945J
	u7TBHsF8sApoyLk8uEmhk8oZ5Frgap1DiZMTCvihErzUpHMCjmiup1ROcCrbuIQ+
	ig4D8WEYXId9kZ/LxnmfD0zof1WXEDEaop95neAgtO1cnWn2F8vtR78+TVTwSfmw
	h8qFhJLhd2tJNYedvtbYAWTttzcLeposmQ7wa2S9EC3YhUGkkN1gJNArRbPida73
	zLJ88khn4KmjDaWc1eiG1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617722; x=
	1748704122; bh=cm4zvllI1XSa/QJUvdC6XNazEpSgWNjQsF/M6H8uS80=; b=W
	sF3924iiZHnbUQ6z1PYHhmx7jsC093/fNY0ZgP3naG+pXCINbaY44FgDjYwQu4ax
	teuklb1PInyk6UYxQOSRVyESXYUmYKDVd0wokD6TTIvExfRtDcU/ph7ZtpF9DNWu
	rQtUUsx1exe8V1x9qeHXc4Ksl2SNE2mnRG2taAhcwpnJbe7MWhF5bjqKRLbeqdNQ
	usc+VKBhfXPEsJBD8AL+L/PHXrQ9fuu4SJ0X3XvU0/0EhRbs1Y3wy9JAZQ41ffxt
	ViPekWnqxQCRfT4EK4orsivKNsRkG+GGmt0v6gAlFPgdbKAAh9Hc9we5brullbaW
	V5koUJE7i1OQQ6uQbSXTQ==
X-ME-Sender: <xms:-sk5aDRCHODArd2lxBSfvsg3_iP5Z7Lxf84RaZUKF-K3AbGQB9_YtQ>
    <xme:-sk5aEwEaTe-W0-a_NZqleAw9HBtfb32nlnzfyJhVLuGjJgViiKkr8zgTqcm7bK_y
    iCEyLJkeLGGrA-y1g>
X-ME-Received: <xmr:-sk5aI10A8fLH3BnJZT7zernmmam9j3ruvIbVyyniL_1y_NQcNqf7c95bC_zWfFYxhFkXkrKF4HiuSZTfnHBJ7J6gui4CAaB4rSFxU95qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleefgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihrohhthhesph
    grlhhorghlthhonhgvthifohhrkhhsrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehr
    rghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehnrghsrghmuhhffh
    hinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-sk5aDC6DtQksGOPCY0zcUx5tX8aJgAWyx8Z8Ahvp8_XAXWbW-FXoQ>
    <xmx:-sk5aMgqEAYnxrvxbdvWQutN4ABcA5GpB-m6-Wz2B2FwMYJ29cF6gA>
    <xmx:-sk5aHqDmHwIIJbm1qtKbksLDWiCKr-Km3SH60X7tUtOH4LEolHeqw>
    <xmx:-sk5aHgoJYZOwJl9pUS8ymCIF0ZmVkUsOmDdR7KXVkSWThM_o7Qrqw>
    <xmx:-sk5aDYBYE3-HWU7k3QqhfpUSu1DltT3MF_Qz5cDL-rxhMgNn5wJOtm_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c346c1b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:28 +0200
Subject: [PATCH v2 02/12] builtin/gc: drop redundant local variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-2-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

