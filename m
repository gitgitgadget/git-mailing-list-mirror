Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841B279782
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354681; cv=none; b=OC8nIIExoW47koGPxGKLIREXk6Hnz9XFN+5fMClt/B8i5u6M8DtPn2WDY8pzN3ATPm8/WiW+rQ9hz8IOmPp4jdSybj5k6s8DyAzT5enB5Ilcz2bS9ZSdbKh4CZoikeoIqfJK8zyKcmgd709nluofFfNAPjVhj0MFxrLLac/i8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354681; c=relaxed/simple;
	bh=BAM+f9Xq2QxaOIljoCpPkbcy1VfDlmiSQc6kJUqhcSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lb75ILt15RqMFKe4CfqERwnQtN2UyILYL9ORgWnSK2FjBDDWBpqpPQxlQoinDrLrzMRxc3PMfJy56QvKU7uFEXjIfnvISq8AZy/Ei6Z2oRXKdErSmDI3zyqzWXGT8wvf5a7XTnyDZTOEwi5T9CrakhuNkzBIqw38p7QQNRYn2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VtiE/6ZH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0oONZMg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VtiE/6ZH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0oONZMg"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EF8D1383AB3;
	Tue, 27 May 2025 10:04:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 27 May 2025 10:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354679;
	 x=1748441079; bh=1LuOKylJth/aSrM2VhRAP7p8JD74kEveV3hd1pXb0xE=; b=
	VtiE/6ZHcPq9uDZM0W5Dt/PG/fCkvFDW2YJhGtsRQLQ33qX5eoeSxk5RAjZ+RYHU
	bPUbajGRqb9lXuwcEdV4jIzYRk18P6QZWWAGvyafDG08nnrutGLMTxrEHF1nTP3g
	l9qc/gFLviZNe3PKbceoNJwtvNWybm96QjhE3mxyV5TIgtbCTfXFvfAbKivgT7X8
	A3JHdtOEzO3/7MnfYn26KvI4Bg2eqXpby54QvTyzo92wp3Va1gaOUzyEHyvylscE
	gkGYzpc+lCxu5KfYPCLgz5OrZqwDQCnp2kzDVX8yqs921vVsQkorDLYu5RlzAGeL
	m1yMf2yJeb1Si7OgULUoHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354679; x=
	1748441079; bh=1LuOKylJth/aSrM2VhRAP7p8JD74kEveV3hd1pXb0xE=; b=W
	0oONZMgBgxjjWF72HlffTrp2Sqv6xWINKtcK+kHK6cSURhaFD5nE1WU3GfeejHVB
	jlRSO7jB0mMPaMnSTk1df+LAACdPhpizxEZ/aYwj+GyiiBBDjpdET3/CVTucgA0t
	lKEEUWK22APghWxhZPE40RV+O3hekfa+k8IcucjhvkSN5adxuzv4bL5eAD6e7zie
	HuJ5Ps5tEPGpWDkZZ97Bai8W+XoBKnRphfJjCEpTGheg/fqr6gR4Di+GRwx84CI2
	As9keRfsiStjC6E3wx8LR+q9a0tCwrMjZaIbcvjAr1XkaXAgJ4LWPFkhkDAa/e2t
	1l4u4O8B/bDZAZyzAWlrA==
X-ME-Sender: <xms:d8Y1aAHsOxjfA7uALxlQL17ecXBEyVxK2TcE3s-UKf1YNRMuUDjweQ>
    <xme:d8Y1aJV-bt5eGE_rnZCfzY0QG0wDpxY7VtobKGK0zS0eA_8ie7IKRJB2GhZGo-cpc
    py4ft8oMLQfTzre6g>
X-ME-Received: <xmr:d8Y1aKIbgtlF2g24xlkxpRvWN4qvocyabPgzhbBt2l5hWOy1Fyt21lFX_X5qF1l_8No-0NEoAQyMgFaeFh7WgIhKYECeUayJqiT3gtQHDus_vw>
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
X-ME-Proxy: <xmx:d8Y1aCG8dLs9C4gnFKN-EKQCaYYLblzK-0YayWy_LDhUhQPNU8o_Yw>
    <xmx:d8Y1aGWEafpTEYCJGRt10nvP3lHmpMNjXVj4agyqiXd-4SGfHbZbfw>
    <xmx:d8Y1aFO54o9DUWdmmG-OFFYSg2LiuEd9gWWHhn1jSk7Fpp0_v-05Iw>
    <xmx:d8Y1aN0LKzveaaejU1ZsHqDuerdnqt3Bmz6LWjiyOVXnkpjGuzk-fA>
    <xmx:d8Y1aEvwL4ZwghuWwiHU9b5W5wNP7gX3ZATnOp74Kr3MNZNNR9CWQx4f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id afe9a6c2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:34 +0200
Subject: [PATCH 08/11] builtin/maintenance: let tasks do maintenance before
 and after detach
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-8-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
X-Mailer: b4 0.14.2

Both git-gc(1) and git-maintenance(1) have logic to daemonize so that
the maintenance tasks are performed in the background. git-gc(1) has
some special logic though to not perform _all_ housekeeping tasks in the
background: both references and reflogs are still handled synchronously
ni the foreground.

This split exists because otherwise it may easily happen that git-gc(1)
keeps for the "packed-refs" file locked for an extended amount of time,
where the next Git command that wants to modify any reference could now
fail. This was especially important in the past, where git-gc(1) was
still executed directly as part of our automatic maintenance: git-gc(1)
was invoked via `git gc --auto --detach`, so we knew to handle most of
the maintenance tasks in the background while doing those parts that may
cause locking issues in the foreground.

We have since moved to git-maintenance(1), which is a more flexible
replacement for git-gc(1). By default this command runs git-gc(1), only,
but it can be configured to run different tasks, as well. This command
does not know about the split between maintenance tasks that should run
before and after detach though, and this has led to several bug reports
about spurious locking errors for the "packed-refs" file.

Prepare for a fix by introducing this split for maintenance tasks. Note
that this commit does not yet change any of the tasks, so there should
not (yet) be a change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 447e5800846..57f3bbf5344 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1545,53 +1545,54 @@ typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
 
 struct maintenance_task {
 	const char *name;
-	maintenance_task_fn fn;
+	maintenance_task_fn before_detach;
+	maintenance_task_fn after_detach;
 	maintenance_auto_fn auto_condition;
 };
 
 static const struct maintenance_task tasks[] = {
 	[TASK_PREFETCH] = {
 		.name = "prefetch",
-		.fn = maintenance_task_prefetch,
+		.after_detach = maintenance_task_prefetch,
 	},
 	[TASK_LOOSE_OBJECTS] = {
 		.name = "loose-objects",
-		.fn = maintenance_task_loose_objects,
+		.after_detach = maintenance_task_loose_objects,
 		.auto_condition = loose_object_auto_condition,
 	},
 	[TASK_INCREMENTAL_REPACK] = {
 		.name = "incremental-repack",
-		.fn = maintenance_task_incremental_repack,
+		.after_detach = maintenance_task_incremental_repack,
 		.auto_condition = incremental_repack_auto_condition,
 	},
 	[TASK_GC] = {
 		.name = "gc",
-		.fn = maintenance_task_gc,
+		.after_detach = maintenance_task_gc,
 		.auto_condition = need_to_gc,
 	},
 	[TASK_COMMIT_GRAPH] = {
 		.name = "commit-graph",
-		.fn = maintenance_task_commit_graph,
+		.after_detach = maintenance_task_commit_graph,
 		.auto_condition = should_write_commit_graph,
 	},
 	[TASK_PACK_REFS] = {
 		.name = "pack-refs",
-		.fn = maintenance_task_pack_refs,
+		.after_detach = maintenance_task_pack_refs,
 		.auto_condition = pack_refs_condition,
 	},
 	[TASK_REFLOG_EXPIRE] = {
 		.name = "reflog-expire",
-		.fn = maintenance_task_reflog_expire,
+		.after_detach = maintenance_task_reflog_expire,
 		.auto_condition = reflog_expire_condition,
 	},
 	[TASK_WORKTREE_PRUNE] = {
 		.name = "worktree-prune",
-		.fn = maintenance_task_worktree_prune,
+		.after_detach = maintenance_task_worktree_prune,
 		.auto_condition = worktree_prune_condition,
 	},
 	[TASK_RERERE_GC] = {
 		.name = "rerere-gc",
-		.fn = maintenance_task_rerere_gc,
+		.after_detach = maintenance_task_rerere_gc,
 		.auto_condition = rerere_gc_condition,
 	},
 };
@@ -1599,20 +1600,25 @@ static const struct maintenance_task tasks[] = {
 static int maybe_run_task(const struct maintenance_task *task,
 			  struct repository *repo,
 			  struct maintenance_run_opts *opts,
-			  struct gc_config *cfg)
+			  struct gc_config *cfg,
+			  int before)
 {
+	maintenance_task_fn fn = before ? task->before_detach : task->after_detach;
+	const char *region = before ? "maintenance before" : "maintenance";
 	int ret = 0;
 
+	if (!fn)
+		return 0;
 	if (opts->auto_flag &&
 	    (!task->auto_condition || !task->auto_condition(cfg)))
 		return 0;
 
-	trace2_region_enter("maintenance", task->name, repo);
-	if (task->fn(opts, cfg)) {
+	trace2_region_enter(region, task->name, repo);
+	if (fn(opts, cfg)) {
 		error(_("task '%s' failed"), task->name);
 		ret = 1;
 	}
-	trace2_region_leave("maintenance", task->name, repo);
+	trace2_region_leave(region, task->name, repo);
 
 	return ret;
 }
@@ -1641,6 +1647,10 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	}
 	free(lock_path);
 
+	for (size_t i = 0; i < opts->tasks_nr; i++)
+		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg, 1))
+			result = 1;
+
 	/* Failure to daemonize is ok, we'll continue in foreground. */
 	if (opts->detach > 0) {
 		trace2_region_enter("maintenance", "detach", the_repository);
@@ -1649,7 +1659,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	}
 
 	for (size_t i = 0; i < opts->tasks_nr; i++)
-		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg))
+		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg, 0))
 			result = 1;
 
 	rollback_lock_file(&lk);

-- 
2.49.0.1266.g31b7d2e469.dirty

