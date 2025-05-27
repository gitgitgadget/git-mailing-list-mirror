Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EF274FCB
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354674; cv=none; b=PBqk55o6DE5THuDOamS4NwCb+WBuqpUs4DU1p0kvg9J2VorjH75yMp24iA/JJ4GgO01Mm2SU/tSqnSqbk9/Sr1DVi+t5sNg4fAsR4RNXS+Xrmo2bFlBzIbd932+9O+YMabJrSxj/nH3a6t5r5xbicdW7aIPtz/dNx6k5KkkR+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354674; c=relaxed/simple;
	bh=gJ8ZMdRNaLln1zFiPgn0DLDYy9eZ+4i01jDXDkGjxDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYZLw8xoASaxy1x3KDngYI9retE+gz3D/fZGlRXq4h5hO0BgJo+AjP0mjV5+7WUNACd4rBsdCWHru60KbMKq75SOSN7MftMdmAB+Xc6c7/x1K7sYajXkltxj5tooocIjzjQl4b05hU2mIImC4J9SWv7oDUPlxNf89dj9nrolAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jGj0Aun+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cEN0DiPL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jGj0Aun+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cEN0DiPL"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA17D1140167;
	Tue, 27 May 2025 10:04:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 27 May 2025 10:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354671;
	 x=1748441071; bh=QwvSM7aBCuoULuG06LhnQGCfwtq4z9UYe63eqtK3N/s=; b=
	jGj0Aun+gfhR9LSNMAZ+z4rZmZQJL3LLyFZy03Fc6eJuZ1db4p+pW53GVNMIBT8B
	QNRxAw6CITaIjSLfrJZohjemsT1wXYfbGmZWXIkztiJ4j89X6kBvGURSpVRBAz1k
	9DZd4uqpwSypmLU+QSZ+AR/yubUyzOUXz1IAuk9Vdlbgh1ZiLecEwEfvhJ+es+v8
	cxSLWW4/c8v/HYJdSHljsEdWWopnXJp2i/WYVP8hdtA73BjfZC+2/qVBMVuxFthr
	f7TRc7mCC8rPMYyigJyx4kjUbJEastLjfxr6XojUR4AGLbQd9cRVics/zWDeqLXS
	HW4SPgjHpuRzzbCdasiEig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354671; x=
	1748441071; bh=QwvSM7aBCuoULuG06LhnQGCfwtq4z9UYe63eqtK3N/s=; b=c
	EN0DiPLdH4MTi9DGnvVX9whtkkyaE8R/bHEVElAiSmE7blZa4sRzYxV7h1fQqQM8
	riTIAm2p+F3dAOR/Vjrq6+p8d4GZ0Qs784cxUaLuZ/dZYWWudsIlWk0SrbclH+oo
	SXGWJX/lZuCZB0xBikMAnXys+vRNdVmNUFlnpSu5yJPDYqmhjTdGN1qHUaIw+/3d
	bEfC72kF6v7UgmR1M0DGXP9QsWsraaar2UbD7ThaJ9Xe1ulusS1L9si2KJCNxiCX
	rfWY0kR3Y41SMzJGinNIkcA4s/pNWn/gukKtPhjvFwMOXFFOU2lo9hktNXjTCjWX
	0RD7yd8up6W2BD1xAL+hg==
X-ME-Sender: <xms:b8Y1aAZP0vYjqNDpHxvGwDcO1vmGB53SzbIQ-zu5yrZl5VqVAKOM9Q>
    <xme:b8Y1aLYlCWA4C2rsTuo8GWg7mVbMYrCQkrDm1O2dXSCDAgrYLdwJ0TzHIVTJiuoU0
    bEfPT7FUvIldaJHEQ>
X-ME-Received: <xmr:b8Y1aK_q7qoNusH4AZW03IViA7zF1F3iVcFgyh1VKoY-drUnMvtE5ytw9z0Uw4DDOs0tgia1dK60gDZ-oU0OQVjggGlPPXSzzo9h3Jap66rpEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfle
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtoh
    hm
X-ME-Proxy: <xmx:b8Y1aKqSys4ygtm8lp1WBtGQGBbvTASO5S75BS2ox2GlRPAfi1n8RQ>
    <xmx:b8Y1aLryAOlet7KpumBFYgBllD48haQ-24IOl9uy3pZlBVHOVkKy5A>
    <xmx:b8Y1aIQR2Z_-l6-lEjbhf4GPeYacJovTPqr1hSx6VCqi-pXoPwPkyw>
    <xmx:b8Y1aLqediVc8MPngI8NyfHGmEvqKkTUEQ7cE_FcXqJb3DYbXbSgOg>
    <xmx:b8Y1aLnxR98kFFTAuzzIpqvs9KbZX9gmZcmpv1AIPA1vlDSWck4ZWKkN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bca3ced (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:27 +0200
Subject: [PATCH 01/11] builtin/gc: use designated field initializers for
 maintenance tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-1-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
X-Mailer: b4 0.14.2

Convert the array of maintenance tasks to use designated field
initializers. This makes it easier to add more fields to the struct
without having to modify all tasks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e33ba946e43..54fc7f299a9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1550,49 +1550,49 @@ enum maintenance_task_label {
 
 static struct maintenance_task tasks[] = {
 	[TASK_PREFETCH] = {
-		"prefetch",
-		maintenance_task_prefetch,
+		.name = "prefetch",
+		.fn = maintenance_task_prefetch,
 	},
 	[TASK_LOOSE_OBJECTS] = {
-		"loose-objects",
-		maintenance_task_loose_objects,
-		loose_object_auto_condition,
+		.name = "loose-objects",
+		.fn = maintenance_task_loose_objects,
+		.auto_condition = loose_object_auto_condition,
 	},
 	[TASK_INCREMENTAL_REPACK] = {
-		"incremental-repack",
-		maintenance_task_incremental_repack,
-		incremental_repack_auto_condition,
+		.name = "incremental-repack",
+		.fn = maintenance_task_incremental_repack,
+		.auto_condition = incremental_repack_auto_condition,
 	},
 	[TASK_GC] = {
-		"gc",
-		maintenance_task_gc,
-		need_to_gc,
-		1,
+		.name = "gc",
+		.fn = maintenance_task_gc,
+		.auto_condition = need_to_gc,
+		.enabled = 1,
 	},
 	[TASK_COMMIT_GRAPH] = {
-		"commit-graph",
-		maintenance_task_commit_graph,
-		should_write_commit_graph,
+		.name = "commit-graph",
+		.fn = maintenance_task_commit_graph,
+		.auto_condition = should_write_commit_graph,
 	},
 	[TASK_PACK_REFS] = {
-		"pack-refs",
-		maintenance_task_pack_refs,
-		pack_refs_condition,
+		.name = "pack-refs",
+		.fn = maintenance_task_pack_refs,
+		.auto_condition = pack_refs_condition,
 	},
 	[TASK_REFLOG_EXPIRE] = {
-		"reflog-expire",
-		maintenance_task_reflog_expire,
-		reflog_expire_condition,
+		.name = "reflog-expire",
+		.fn = maintenance_task_reflog_expire,
+		.auto_condition = reflog_expire_condition,
 	},
 	[TASK_WORKTREE_PRUNE] = {
-		"worktree-prune",
-		maintenance_task_worktree_prune,
-		worktree_prune_condition,
+		.name = "worktree-prune",
+		.fn = maintenance_task_worktree_prune,
+		.auto_condition = worktree_prune_condition,
 	},
 	[TASK_RERERE_GC] = {
-		"rerere-gc",
-		maintenance_task_rerere_gc,
-		rerere_gc_condition,
+		.name = "rerere-gc",
+		.fn = maintenance_task_rerere_gc,
+		.auto_condition = rerere_gc_condition,
 	},
 };
 

-- 
2.49.0.1266.g31b7d2e469.dirty

