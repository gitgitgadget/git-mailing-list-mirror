Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9277239581
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959285; cv=none; b=CXTVMrcCgSSBGLJok2QqDPFoPU3r8ALmmNre6wcqhl4X6Qsz0Jt93UzFkzzaQvagCrkmTKg/N4FK63XT92MrFyMapKXm52VWWfo6yVRkO6TbuKXIbxXzICojJd/wzauxCwwWAiZw8c6PpRd/iAg35xyRjg7CcyJv2EWhwHeRdb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959285; c=relaxed/simple;
	bh=ZxAdrZxoinaIGXPBJuU36AMgf2T5J4e0LWz/vCBimAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MoN8ayAqukcPJ3BrT9jEh6FH8GThZCeu10AxhaY7s0PgmiFNb2g7ytCtaFc2F8Gbq1mlBPnFzWUmk2KvXOQwgcohqUn27d2iE+LAXw33PHlKiWDON1F6tyH73wTFkYMrPOxpOUvcbEAbp8GjxPFfHBxsa99ONQAr54Dn+8otcqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DiGZG0P0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffeFJ09y; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DiGZG0P0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffeFJ09y"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A6DD311400EA;
	Tue,  3 Jun 2025 10:01:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Jun 2025 10:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959281;
	 x=1749045681; bh=pzTZ2yQNnqPm4SaT0MFL7MMCYU6InVZTCVDRTpNvJ7g=; b=
	DiGZG0P0WgiFZ+zYSDzZ2yYv7j0mTLWmM7+qjmo3KT2sc3JWfpFJqLIkPcxTzDUI
	j2OsOyDbIXr9xlkPYD8Q3IABZEzVOUAlYS9WwMYeEFZWA24D97JFWGotTdCirAwJ
	G7RqdCM6UaQPaqOdNMwZ/QknBS+voWBkX2+vs4kkE4gz8hpo8cncTHuSjLvTy8nR
	AufVTkgpvQ6B90YpbSiksJDOAY/Gl90wuqw7S6YQKZLSD5txrtWSgb3kkPaml10u
	5GK1B0QftfijyDrfr4SjHvw4x7EJZe60LliqCUxaWISoSb/f8Y0xbzIdfPYVfWpH
	fNE5fmvL02bdBJmNugNwWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959281; x=
	1749045681; bh=pzTZ2yQNnqPm4SaT0MFL7MMCYU6InVZTCVDRTpNvJ7g=; b=f
	feFJ09yihi7Xjn5EcBqsyVNn88EJv/dYnMi3/y+LLEfzwjTU5emcL1JuKlogyUDX
	puYONhvBJBLjC1Gy9NsQprdWx0LpAhbcInnbU+2EpBKgZb+/lj3xkCPKaekB3GoI
	oUpGSfffbU02AKGrr+w4PXyrV060DYwmsCeDApuZtawugjOJOoMFrq+d+qcbztdl
	45gU+azSkNl1IsYQ/EWH6j8J3Gwy1Ju4b+NcHBB3o4/MreSqkNx5Aio6obOaThzF
	lcW6wkqnjNL1lbgz67RbAQ05znh1x0YEL/3He6/6fvY4iz5kk4YyIXoUPHRhpFyp
	YYJhd6Y/wTiHRhhk3GIgA==
X-ME-Sender: <xms:MQA_aK6vnK29DlljhTb3eSJfBDYTTAVdTbaMM8sw6gy4-RVjeEjewA>
    <xme:MQA_aD4969Fy69NkMgpxgwm8Hfw408SeA_y9y2OMNmFovWSdZsLMf1_RCjebxOqqc
    IO0pyGacR51Eza8eQ>
X-ME-Received: <xmr:MQA_aJcft-qgFXT4FyyqGtkUOXgjTLcTg1D6KQkPl-RVjcGDnaBbJ9P4zjO2hR5K-8vOBcnnvA8yef4gabb5aaTXfGXHRMx4KJiHbNf46w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopeihrhho
    thhhsehprghlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopehrrghmsh
    grhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepsggvnhdr
    khhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MQA_aHKJccwOP6h5h_DNQ4Mmyr3lgyuovpbzeB-Tokxa9ltK7bk1yw>
    <xmx:MQA_aOK1L9vdgkElH52-cHxCoLM0xdzH5gKtLE4YNunrXwxxl--r7w>
    <xmx:MQA_aIwZ-Fm1o1J--VW8XHyhAFC_zbXheGeFcWqOLQk72GHVqaFhxw>
    <xmx:MQA_aCI6RJ3QtlsC4fFI56EwMP6vUxOSi6pY75974cIffeRUlgdj2w>
    <xmx:MQA_aNKv87Xcezjz0qZpzFxbmPa1-NSOm6cmDCzB2A7AHNbD5yfA0OvA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d624fee8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:09 +0200
Subject: [PATCH v4 01/12] builtin/gc: use designated field initializers for
 maintenance tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-1-52f5cf7b7e99@pks.im>
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
2.50.0.rc0.629.g846fc57c9e.dirty

