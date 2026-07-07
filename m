Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBC3E3C50
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438389; cv=none; b=tiR4vaUhySYWO58ppca/Cxfsz2ixbglqDYsdmhtIwgZAboxDXdMs9gN/pZUQT8YUnqdOD1cwCqDdRp+Oed+3VLB6YCekMHGIFh6L8RaEfYhGU4xpYuMkZq48vi2NOpRTRVX/X0dUYAM7ED/cH7Dc0nUR7iKWh/cIU7tIBsesSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438389; c=relaxed/simple;
	bh=8HNzWtz/ClAz4s1hnBBIkevU5tJffqGLRH83KXPnR5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPyoef0o/NK0qt6ftvmiWPfxXy745NJm2qZbtUk0qTdRIaQxUmomRgaJIaotpO3iSrI/FE+yVpplnAXACHuYipaEPGsQ3SkrtKdOZ+GGqfy/oUYrg9PuG+FhRtL6ccQpQJ8KkARTOyCrCn2aCWtLywN8AWiAU/FkfUKui2W4bvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GP1gWJva; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XAIX6cd1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GP1gWJva";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XAIX6cd1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A903EC0227
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:33:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 11:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438387;
	 x=1783524787; bh=lfMd5TXD2GT62g8cynFBmMKnlrDrtUjYpRu0+9arEp0=; b=
	GP1gWJvaVUYsXiGL3862HSl1Jj88g7DglQmg2shwhVLBTBPwPcwJtAVFgt0/7wKT
	Y855p+35GshF3SSFFrXfjYUGWRAkuM5SPvF9PW6jtO+zpBHHslF/sQ23hQyAowgs
	MN+zuJPTr9EpgC3eBmOvwxBYl1IMXZxilnPOa8NEfmsoaO/9hhZFqo0nuJLxTOMp
	x520LId9yj26N1G10Fg2bQpCQTk/EyofNDCUT+ODpmey7xv+jwDqMWv/Wf9083XP
	yaUEWNkexJTQFKQPZeblsUWjwsXNTATuu6PNZYAd9N//rfGzYWjRg7E5o55aXz+m
	HacGFjpp3RBBYTNvXt7X7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438387; x=
	1783524787; bh=lfMd5TXD2GT62g8cynFBmMKnlrDrtUjYpRu0+9arEp0=; b=X
	AIX6cd1Sy91VE7eqmLKCEtXL5vG+36zSVHfIoDEMOMK1eTPL0pC9XtOp9w2dl3UL
	TsK7633FXNV/XmogG86cvl8Se7FNep8bZ90I4mteIvp2pne7xW2lAvIj8kOXxv5w
	M5Vm0gNtUgSwUWzhC7ZYcp6nCfRYjNTgvd3mNUyZZsBj7PYNOOrJ8Axd1k1WpdgC
	blY03iuXgVODyngvDmehbJHUn1gYMVT94tde5MHYP+rK/cXhJ+xNQpV9Qzv9ekUe
	i32/FYvz5VUoFAVqbCfzPIUX06w8QSegIPID7P6xV3jfQJ+wu3bAWSacmbStKt4s
	8uIMmuFqcpGvOQ0V2xYKg==
X-ME-Sender: <xms:MxxNarPjz8USIOfodneRZVca_1ILzpT_US0zot_1Qbh8YQmPgGuWww>
    <xme:MxxNas7Zusl4R8NHH14DzVbhSRSvcUhdbwf6qhKPNM1hcco2M6uDC3r3m45OwBiND
    dD1r0TNVmgt-rYvzlcGWGSMT506Ynj6w0MgVsC5Jul06R-hmQaF9A>
X-ME-Received: <xmr:MxxNav47SK4lQE4vTTRm5FFLkCJ3sYeap981goxaY1LazhyNHo73TCms9c4K79-Fwvyw8hS0khaMMOHCZCunnJHXjThePuwgxo0Z55Y1nA>
X-ME-Proxy-Cause: dmFkZTFRDwBZLYQxvD2QNsK0W3qg5znF1IzM8kQJZHsUMhZBRToXBU2+sjid99Q8u4zk5Q
    /7RYSQbkU2bhdWABn0SUButsWxH7Uz0pU2EzWco9FQJZvRBaC6ICqs1hq2Py8DIv269ret
    /zKTIGreSkdKYB7jkHmy9A3p9WrSXLh2h8o7srpK6OSc+G0wVM0sHLEXOblerkQWmtdCkZ
    HnnvdZ7A69J+oiE3Zs7WbE5emwsjhrlw7VCVgdh8LvGqHiqhXJ/q8RQKSG+9Fhgln1ukyX
    5hOyVzG7Inj0DrV+EQDy27dXOOqVAyQga+A1IgSURonY3sqWUjVEAs+WEZagW2JSeJm1fI
    5bmt85JKoYp+mBcgZbPRqAt3Jv3CLpWElyNLcEWbT+5ONyUYMmQI3lbjJ40t3HWFSSalnR
    FIoXeqZIX/epASi0r/1WH/0/Ow+oiAmLzX98i2V+cHUmFcN8kapH/G4SdCtwyC24b13875
    YiXVIoL/1oS9gPTRIL3WkNQ1icwNrat9vIjOJomxiSd8QJ4RthSp4x9EYxDsfWT9hEPQYf
    LMjKMtUdGANt9OBbFU+qE8+ztXpul6tUKxYant6bdIDf93auD+4AMbemNzC6Hu8S2QBbix
    e/0FJMQeByEuR7UgAToT00cdhAOsukrnMPnX92tla0Gf2v3C0UZ0IdheXEVg
X-ME-Proxy: <xmx:MxxNak1ARRX9XJSkhgVhDExNBjQkO7JhjtavX9gSmZHmn9Wnir4Y_A>
    <xmx:MxxNajWEYvRzYh6MnLjMfj0DuWYAPiO-olVY6IhF5OldaBSDQn7kPw>
    <xmx:MxxNan7VQCmqhI6a1rxYSHtDQjA-_NLOZL_RllphPcUWY6o52nk7dw>
    <xmx:MxxNaiIkkfPPGJt5Z37sQ4gh1jX3MImylzHL1XlCxUk5Q2hozgIFGQ>
    <xmx:MxxNav887lUcuI3ZvkrHaoGyxOiQpuZmEsvt6J96Y8GpvpXG1C-FbqvV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:33:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b9db1e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:33:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:35 +0200
Subject: [PATCH 03/11] builtin/gc: extract object database optimizations
 into separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-3-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Extract the object database optimization logic from `cmd_gc()` into a
new `maintenance_task_odb()` helper function. This is a pure refactoring
with no intended functional change.

Note that the message that notifies the user about too many loose
objects is moved into the new function, as well. It is inherently an
implementation detail of how the "files" source works, and as a
consequence we'll move it around in a later commit, as well. This
reordering means that the warning may now be printed at a different
point in time, but it's not expected that this will have any practical
implications.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 79 +++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8f568003ee..2ff98fa727 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -839,6 +839,53 @@ static int gc_foreground_tasks(struct maintenance_run_opts *opts,
 	return 0;
 }
 
+static int maintenance_task_odb(struct maintenance_run_opts *opts,
+				struct gc_config *cfg,
+				struct strvec *repack_args)
+{
+	struct child_process repack_cmd = CHILD_PROCESS_INIT;
+	int ret;
+
+	if (the_repository->repository_format_precious_objects)
+		return 0;
+
+	repack_cmd.git_cmd = 1;
+	repack_cmd.odb_to_close = the_repository->objects;
+	strvec_pushv(&repack_cmd.args, repack_args->v);
+	if (run_command(&repack_cmd)) {
+		ret = error(FAILED_RUN, repack_args->v[0]);
+		goto out;
+	}
+
+	if (cfg->prune_expire) {
+		struct child_process prune_cmd = CHILD_PROCESS_INIT;
+
+		strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
+		/* run `git prune` even if using cruft packs */
+		strvec_push(&prune_cmd.args, cfg->prune_expire);
+		if (opts->quiet)
+			strvec_push(&prune_cmd.args, "--no-progress");
+		if (repo_has_promisor_remote(the_repository))
+			strvec_push(&prune_cmd.args,
+				    "--exclude-promisor-objects");
+		prune_cmd.git_cmd = 1;
+
+		if (run_command(&prune_cmd)) {
+			ret = error(FAILED_RUN, prune_cmd.args.v[0]);
+			goto out;
+		}
+	}
+
+	if (opts->auto_flag && too_many_loose_objects(cfg->gc_auto_threshold))
+		warning(_("There are too many unreachable loose objects; "
+			"run 'git prune' to remove them."));
+
+	ret = 0;
+
+out:
+	return ret;
+}
+
 int cmd_gc(int argc,
 	   const char **argv,
 	   const char *prefix,
@@ -1018,32 +1065,8 @@ int cmd_gc(int argc,
 	if (maintenance_task_rerere_gc(&opts, &cfg))
 		die(FAILED_RUN, "rerere");
 
-	if (!the_repository->repository_format_precious_objects) {
-		struct child_process repack_cmd = CHILD_PROCESS_INIT;
-
-		repack_cmd.git_cmd = 1;
-		repack_cmd.odb_to_close = the_repository->objects;
-		strvec_pushv(&repack_cmd.args, repack_args.v);
-		if (run_command(&repack_cmd))
-			die(FAILED_RUN, repack_args.v[0]);
-
-		if (cfg.prune_expire) {
-			struct child_process prune_cmd = CHILD_PROCESS_INIT;
-
-			strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
-			/* run `git prune` even if using cruft packs */
-			strvec_push(&prune_cmd.args, cfg.prune_expire);
-			if (opts.quiet)
-				strvec_push(&prune_cmd.args, "--no-progress");
-			if (repo_has_promisor_remote(the_repository))
-				strvec_push(&prune_cmd.args,
-					    "--exclude-promisor-objects");
-			prune_cmd.git_cmd = 1;
-
-			if (run_command(&prune_cmd))
-				die(FAILED_RUN, prune_cmd.args.v[0]);
-		}
-	}
+	if (maintenance_task_odb(&opts, &cfg, &repack_args))
+		die(NULL);
 
 	report_garbage = report_pack_garbage;
 	odb_reprepare(the_repository->objects);
@@ -1057,10 +1080,6 @@ int cmd_gc(int argc,
 					     !opts.quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
-	if (opts.auto_flag && too_many_loose_objects(cfg.gc_auto_threshold))
-		warning(_("There are too many unreachable loose objects; "
-			"run 'git prune' to remove them."));
-
 	if (!daemonized) {
 		char *path = repo_git_path(the_repository, "gc.log");
 		unlink(path);

-- 
2.55.0.141.g00534a21ce.dirty

