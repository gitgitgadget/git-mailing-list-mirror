Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976BD188A0E
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617725; cv=none; b=VD8GIOmlotT7ztGqplfV2+0MgEuX7KuVWQz856PSKc+djXXHWq4DSH8QfHzfG6i7KmNUWLMjz2v9ofRvOqGqGfXqL8J4ZxspCbYZI4EgbCJEGIrgbdiX2NT/yqekC1y8T84NzJ0SadPVVyz5xQyctFQoeqHy2CzgS/M2vXXZJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617725; c=relaxed/simple;
	bh=B48UUhZtJvKYkYwdh0kRXsRhG+U4qangJC2+mCFLUqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TegRbobRvlNv27Mqu+LhMfMcy9FOdh66Z8ulLw2DPHZ1odyjvzQ9x4o0zfm1UHbdSNNlgejVBAw4K5zihuezRebiufUXipnEIgnXf4WnEdWVUd8M9gPk4lFYvjsR0/4YE3CmdDkgQPEgB2Be7bCUGQtTaLExalpUVbgsX+QsK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UjHB64ER; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dVvm5f2s; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UjHB64ER";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dVvm5f2s"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD77F1140111;
	Fri, 30 May 2025 11:08:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 30 May 2025 11:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617722;
	 x=1748704122; bh=SeVQ3kQdgivKnUZmJF7sg5H+U/uJXgq8WyY5DhBLqhQ=; b=
	UjHB64ERhqzxwlY21PCbM7yWkc4D6+xAgj/f339c8tuYrjzd5bnZ8VHCZtTh0uld
	PWhT/ZpqDWEFlMPRNdSaxjg/kRilHX96pELng+7Fgwk1NR6ChtdFWID2u8bV+sRT
	+u+vvsOOYLid4KOJwHmFNljxMV7tIGkU5OwfzK3cxY0+WQdmsfX5V/cG5wJOY3cm
	5/8x7X8VjOfLZgHJ3+ibCobUSL44uoYcpHgjfHaCWIoh6IDtUl4DUkhgfkwwZKNA
	FJlo/xU6ErO775ctTN1d7vj3JAGf0SV7B1uK/i1djoTZ0PIy2GZePwSvi5L8jvO5
	0wm8qVMUx4sg/JyH7vZz4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617722; x=
	1748704122; bh=SeVQ3kQdgivKnUZmJF7sg5H+U/uJXgq8WyY5DhBLqhQ=; b=d
	Vvm5f2sKrGnyJK5Dc6Zvxu8U9ddrB0k8tCQmogDV4B3HnmtclELKo6iGwHbbo0Mt
	RQ2kFCLTgee+ibR5l5BxK/ccJgOHnEwfNb+R3xyw4ufcE5RLZqFnmRuLG5j7n84T
	Uqp7QGhho/+ol/P/isw4KO8BnZWdQFMQmKSNAUOwPX1QsnCaaz6DL0x9lQMoLRSQ
	5mtigMaDib6/4RKBxyR3qs302BjGNMRDSBgmPrcQdBhmWsasLDs459VjJv0ZMhcW
	iPmtI+3P5nKL0W4oWs/yz+oi6e0rZAIhC1vbfoviPPP93wQPQTcTncZGUs6akU4u
	mLOmlDf7dnweMhkVAZ7XA==
X-ME-Sender: <xms:-sk5aKlJ9oO3txnjFpHz3MI6MRJdq99BQ5tTHhoP6zZstDqLOQg_Iw>
    <xme:-sk5aB1PzTNmGDwHjWAnDviVQLCRm61jjWu-aYUL7IaiSj__1tDyz73TkY9oYsVKm
    pc2eQpDHhynsOlBAw>
X-ME-Received: <xmr:-sk5aIoVm4_QFkUwRe_PgkzcnzIjM76qhkXNLpXcYag7NRCnXJNESXOVKGsgieQtKWzWZ8BvZ31ChwFXFccjVoTeMdhzOwiPzP-_9vwtTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeffeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopeihrhhothhhsehp
    rghlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomhdprhgtphhtth
    hopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:-sk5aOmTfUa45Y3PGt8o2DbJoHQW38wQII0GlCSSPguCf2Pgu3zUXA>
    <xmx:-sk5aI0Ua3sFYQt_oIjk3AlqA2D2VvcrrsHSe0AbzHgA2EOLeFZvwg>
    <xmx:-sk5aFsK8XlFetkUENXr__hJ2Nzqr-izFNEc7XqTRPT5YYc_xheI2g>
    <xmx:-sk5aEW8cGOPj3mBR8EPUn_6D-TL-ZJfPCcX3mPSa3za8mAuQzKh2A>
    <xmx:-sk5aELzD4nrn8LOYlPrgNApXvg8zSp36n9MhWJOXsXjXL0iuUEfE95N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab60a1e5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:27 +0200
Subject: [PATCH v2 01/12] builtin/gc: use designated field initializers for
 maintenance tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-1-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

