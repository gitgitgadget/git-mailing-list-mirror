Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3537230BFB
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566172; cv=none; b=aYUUnjnEBNThoJFjt/bhcPFMeIOfhPXm/fGLnOA9Osas/9Gn/L+6Vfs/1JcVDxW1+ePGYgs/KsKrJw6BFxRx98bwoeCT4of90dlCkvmkKiVhsAXAF+NTNIDDzc2tlT6V3Par0h/mGZyPS8GqkS1BKgOkmIfYy16QjSmjfQi+2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566172; c=relaxed/simple;
	bh=T3c/5snmX2y8U9Kn4BsaiBzbUk53t5V2GI7XHl/kyIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWzX6OtpOM54J+mAblDlllhNMJWtqXbujocHOVXFbxBC3irARfdM6p2NGEzCrPFN9bQoPcch1+bM7ZgrNl+MgezltRSlQpmUj6Kj331ZQIKO+nziC6Mg0iinBa2B23yPlKHET9alTI/x7ppoVoENFUGP29km0K1/qiopgu3IlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WoH7qfjK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZKrlJf9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WoH7qfjK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZKrlJf9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E479313801E7
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566169;
	 x=1745652569; bh=360FWdDvfi5JHIUMrZj8zsmNOF2I2+loAPIKw5GiCb4=; b=
	WoH7qfjKCDTF6UmF/Zx002ndLIpF7lpM2DQdz9OeJUNMcO1uXqF2OEBneNS99ez6
	VFjnuP0hVF/PI0f97xjw2XbFIkMb8G/Kug03wZ9f3BCDUfYfVkYKGSHudPcKlFjo
	RvCmYkbciSXYbVf0XPqtlyFEsGRo5le6+o425duE6PYAA7wGrlEZLSJsluy5Ayx/
	weTPbwPJO10nzVTJcYQ8Xk/J1LFghubHkZUTNVfU1wnOr6c79sOMWKXZeCqkE6S7
	iVijESu2orOBP5HYhuSgjBsKCODRGESxjQDvvmHq4dlnJ4ihHvFXy9euRSBPTM+C
	xZxd0T0J+zU4MSX/y/ciXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566169; x=
	1745652569; bh=360FWdDvfi5JHIUMrZj8zsmNOF2I2+loAPIKw5GiCb4=; b=l
	ZKrlJf9V2xV57pSRkL1O4B5jGWVB/s1RXlJPE1hKZACaZZtfxKT0OBR1O6BjUZ58
	433uBkOh4sj7+KROmuG55xSI9RzgcEVlMNqIAgWZW7Me3uMsfYub6I/uz+b3vKl/
	ej+kQ8L3WfsZKxuSMjzzGb4p34YEF8BeTqDdslJJa1A2BqbJq9liOdgNTo40ZK4a
	/cAc4MVGr0jD+KO3eeMkVt2kvjj/ktKCJbIVLAbDXCTy/PDl7DymVEXK43+Q+IFv
	cUtjrTmnng+CZSd6tKI6uUrCzFrl9auYiG4VRYYeqy6CP58WYgObhwDx5L+QaDYx
	IO85QoqKPSHgNDpYDnvUQ==
X-ME-Sender: <xms:2TkLaP2TlI1u0tc6zobuo96GLYJ0ZXXMUPDkzShbgmtEvOte1yxqKw>
    <xme:2TkLaOFsauANXiW9lmdqQHu6ba_HtdCCCiM5WWVs6idW3ByL_N-9xtSTuHpqnpu1L
    uhLYQp_XJ2dHJZNrQ>
X-ME-Received: <xmr:2TkLaP7Z7p-YcCVi9t80nczFxtTZK9TQ47WWHoXT3UTWV6rlU0iB0EZQf8ENbtp9nwcYBU8jOeRI_RBgZB2DmYuqAOoXwqDUERzINO6E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2TkLaE1xmC_0rRdV_aKEziglIytFe3HBA_43Hq-CrDOMsSr6Y4ROaA>
    <xmx:2TkLaCEw864X-gnnqYhqcWm-TOI3ueECkHd7KbMTFCEjvBH581xcgQ>
    <xmx:2TkLaF_AG3iJUFV1lu48G7kdLPU_3z80hKjYj2EiFJ3MIFgrFcGoXw>
    <xmx:2TkLaPnT1z7xFwlAhphFKxZjaCmjWZVKv6eDOHGZYvo47OZI_nqyig>
    <xmx:2TkLaFB_kJpsEI8r86K81wEw5wzA_JGXLvKaCHSOrL2TkozOPoz4aA8t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b10afeb2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 25 Apr 2025 07:29:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:29:22 +0200
Subject: [PATCH 6/7] builtin/gc: move rerere garbage collection into
 separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-maintenance-missing-tasks-v1-6-972ed6ab2c0d@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Move garbage collection of cached rerere entries into a separate
function. This prepares us for a subsequent commit where we introduce a
new "rerere-gc" task for git-maintenance(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 46c64c852dc..a0816bcf302 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -375,6 +375,15 @@ static int worktree_prune_condition(struct gc_config *cfg)
 	return should_prune;
 }
 
+static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
+				      struct gc_config *cfg UNUSED)
+{
+	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
+	rerere_cmd.git_cmd = 1;
+	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
+	return run_command(&rerere_cmd);
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -771,7 +780,6 @@ int cmd_gc(int argc,
 	int daemonized = 0;
 	int keep_largest_pack = -1;
 	timestamp_t dummy;
-	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
 	const char *prune_expire_sentinel = "sentinel";
@@ -948,10 +956,8 @@ int cmd_gc(int argc,
 	    maintenance_task_worktree_prune(&opts, &cfg))
 		die(FAILED_RUN, "worktree");
 
-	rerere_cmd.git_cmd = 1;
-	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
-	if (run_command(&rerere_cmd))
-		die(FAILED_RUN, rerere_cmd.args.v[0]);
+	if (maintenance_task_rerere_gc(&opts, &cfg))
+		die(FAILED_RUN, "rerere");
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);

-- 
2.49.0.901.g37484f566f.dirty

