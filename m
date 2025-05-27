Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF936276057
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354675; cv=none; b=FmDR/ut4K4Oa/jcsnVWJz5AkFLoRvYW1q6b2XtmvD+S7p8EfnZff8qfqzeHFPEdQxXpjX+PAdWbjJ7jXDQiE5tMW/WbC2mfbMp3Z4QtDBq0Y4JwrQFRqCFGWRr4ZWTNy9x6PA6Qb/+b6cqhsp+x22Ua8SiAY2cfy2HvCNKKqGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354675; c=relaxed/simple;
	bh=iMyFYGkbR/9RzZtziu+9Z4wzHoYNnfTqhJvHWjK94hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXdxgTjddLARjazKrpJ0SuP7jcM2wEFHjKPKGE9Voy8mXzVdCLb7s6HRkU5luVGl2E06l1PRX7XucQ6bpUb6fqRg2CjZ5FSgFRnL7jehvTKz8uzqmQ05lQ9hxt2Cus7dt1q9RaGRCXH3f4/82gstt7Fs/KzlNxs33DT6Dqxw4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G1t5KJyh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJp20Eow; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G1t5KJyh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJp20Eow"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E350B1383AB0;
	Tue, 27 May 2025 10:04:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 27 May 2025 10:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354672;
	 x=1748441072; bh=WKmIczJLuab1VapDA27UQvuKwwXxdUWrSjTjZAEUn24=; b=
	G1t5KJyhz1lPg3/95wzT8Wa1jPHN1h392Enw8SgkcVAKR7inydQoytEiUo8xjLMM
	+Tlbw7aQ3mt+MNu2oIhxQi5f/EV6+oDRkbrni0EDys10hAAvu9ubXgJXF8FwHCpx
	2AgtJmNEoTjUSek653JzSwJA+tWzgPkSVp7A1rjd5YvFz/zaGA5VkBMwH/ip0wer
	DdYS9Vnbf2whwsumf5SKprJ02M1EE3sQi7pyt58MIvcDRpS/FabNadBy2KPMqBhz
	2NTlj7IiosD4ccHNc0G+jq13EKsXn0HLCIcmhKPwr77T3wp6N+rgq09Y+VFuk1Q5
	1huDLRBfJQfUeLdpodzDOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354672; x=
	1748441072; bh=WKmIczJLuab1VapDA27UQvuKwwXxdUWrSjTjZAEUn24=; b=X
	Jp20EowR6D55SLJtALJt9pfC2IbTaxyNW7Rf1ABUqBpsBc/VENrwpRW0O8OviwCN
	vH5XeroYBk34qaYtW5EdfiZazExm8IQqc8MAPmkqbBdNOBLBHKXrfUtdZZ+6A9ys
	uN/dpWzTnlGYjw+32trJ2gNVN6nvt/G740ipIqAtsiCPXbeofU5tE9RuOePbH0PD
	rsHIks3+LGGpNZ3r9SoDtEIMYVo8XzoMsQe/Cl05YdMpNzvN7XM79ot8Uq9zG5vU
	TZ6czzyigaOLA0kqdPIXycm9fhlHN8TYqVmQc5J0Hosc5UVUTXz4JfDejKeUFDZJ
	7mpxVofge/25tNqAtWbJA==
X-ME-Sender: <xms:cMY1aNdeUt2A6oGxIAhyKsHCBNzJSBEjH90lUraywniTyh3rYVPgqA>
    <xme:cMY1aLOncWV_3WTY33GWjkhIdf2Aw9Z7WzQ9_GV324S0vu7wA3j2uBBb9NFXJ2oKe
    OOXsqRZhmMmqkV7Pg>
X-ME-Received: <xmr:cMY1aGiRcxguMDKokqi4gWPqi09a_0DUeZGnE2RfRDaM3DnGI_9w9OrvJ4-y9Av6JzSZ7ymU913bSANQrVibTi-vTnQkMVr91i0EG7qGCsTWyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihrohhthhesph
    grlhhorghlthhonhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepuggrshhrrghflees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:cMY1aG_Fm77-QoQAf8djRh49c1PUcPBg3of4D3Yl6TqE3sIq1afZng>
    <xmx:cMY1aJuOTJz-YCokmOO9i_jinO5DZE4cnmZAnwTPLlRFPUvLEx2LLA>
    <xmx:cMY1aFGWgrZUu5jjZwxUrhVrEfjdDLVff3WPihGLf5zgJDS7OK8D3g>
    <xmx:cMY1aANY8EtDhgJ1USJ0St3-cbIHN3FDiSigJ_IQHL5ZHJ1pSpogkw>
    <xmx:cMY1aMaYTVizENwO66zh_9UIr5BdwM1WibS4C2IEIeuQ4wgUvGBClreW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b23f6b2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:28 +0200
Subject: [PATCH 02/11] builtin/gc: drop redundant local variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-2-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
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
2.49.0.1266.g31b7d2e469.dirty

