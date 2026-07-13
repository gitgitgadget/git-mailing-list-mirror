Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849083612E7
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921949; cv=none; b=sIxmCKYc/Y+qU6nzwgCV5WF2v9EpGs6mayOM5187uGkFqa+fGzKDqj7Xbazt0n4oR7tvz+I038YqZB/uiwAh7K3omwjAdRBuE2BxH+bZUgLETvCxZK1QL821u8/4IEx7rnDQSYb7rvewGQ9TBVkGBBBtz3O3dO9woSZ2WhGMHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921949; c=relaxed/simple;
	bh=Y/tLzbz6MKDIIy2qBOCfgvHVsx5Z2ud+FcIERBCJlu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DebA2u3i+2R0EzG6pER5iVdziaB/bpDGUBO47Gjo4IjM72/GRXAKV8gQXQbnU+5oNU3tCRlCnTUUt9HwaZIa8PceLHQ+4pCqZF4CUtGU94i2gpGZLAi7gGjCb8yIyVtnFbAxHH+GazHYeHcsU4pv1sP7+hJowUWrIJ/zICPFOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I7/cKbhU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nu399Ebz; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I7/cKbhU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nu399Ebz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 35998EC012C;
	Mon, 13 Jul 2026 01:52:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jul 2026 01:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921946;
	 x=1784008346; bh=RHL5P92TonUdHFdY/GrU3nDlLPtWh0+lN06Sl8BgHwY=; b=
	I7/cKbhUc8dF8ydWHhJrI/J+3K5av7UjuAhEI2125aEEv0zIYKgguB/SlG+ewHT3
	xoMOtG17HdDb5C/SrD1dQYgv1A1UXbwuceFcKnC7f++i4JVOBOaiZ7A7Nigqx6MM
	31KoJwM7TQNHmra5ueRVybyGfqzY74rxuFyZRVKXYPLaw+ib2iBKdIVFuL9a5Nm+
	J5E80FITdopUfFRPuz8K79Lf8j+r6oY1CkRcoIpwXs1hvOJZzSnQse6hn++jwJ0l
	kgR6YSgsZ2dtCBGTM9zTvVKcLiX2c9+I1D8wB6IJ1BBbSRaASAsxTI6V0NnTqb0I
	Ym6vp4bCjEMlt6LKXA+JcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921946; x=
	1784008346; bh=RHL5P92TonUdHFdY/GrU3nDlLPtWh0+lN06Sl8BgHwY=; b=n
	u399Ebzw2qkLQJ83yQp7TAuXZPo+2DwvFPdiquEQED3f3qI/J74uDA5jCVyK2R6Y
	83EkgAJXYeJtX9TCCM30gMjQ4cdswZc5++ecsicGEvqVWTesBp7mZXWJhOXSAvGB
	sNjvpQHY9a5BfHoG3YY2EuDpdF1Ne97zgi++tbxq9sg4dL5ykZKXf1k3Y/Ssv0FK
	n2qv9WJdFhbh/nSBuURXMlbkK49AqTjrxEEja+beD7CPcPxrMP5EX0dlRaajA+Np
	RaIaHiEnfQ6TQDSZYRHlf64i6NmhYtwYoU6QSk2ochmEFZ5S6gmw9XuBueaxh3Ah
	X60GBZjPr1vF4UNiMjwTQ==
X-ME-Sender: <xms:Gn1UagtnEBj8BND7Uy9avXDTKWAcuAgnjnJwoLCZgF0f3KZCLvALGw>
    <xme:Gn1UajdhR1xuVNmUZnCL-UliGO8uUPebcNAHFGhcdrc4JSVhpR16DxMQtnH_g6qZE
    1w1_F1v2G3KgCTK_j6Iqn8_0d0B23OpnprJRZZ91f_GWKwpSyvUcg>
X-ME-Received: <xmr:Gn1UapbEuPCBpvUQT0CQ62oE0YPrdezs9pBOpRC_zIb0w3H0NNsu-6_k_CePMUWSKUUYJIL9UC2ZoskTjHDTHqeTP_bhtWtjf9gE-APT>
X-ME-Proxy-Cause: dmFkZTEqjf9jNhQri3q9+05nQWl8s5qs7RhcNOu4KUGgqh5NCi1BB8/euFsIlW4AR7+XMm
    Zd/17b8WRI1F5UpjYBfFbu8cBp3ZdjdfO9+wCw9QQJwFP1tZiH9DpMxRY7ctCSUiHy2Lld
    FwoPTpQ8JLAU7nKeaPnEspZboNDFL4wywA6OqAG+h2MRkCTnSrf7/plQL+fftvX6a89xiA
    szg3rE5/ukBWR6VxnzDt36q6kW5wC2pKDN5pBBX6Etjkh9WO2OoWLp/mxiwhmbOCqvADm0
    marfkI3/w/sRqi/f5P2nC/y1ai8WEkevS26XKg6sd2DQxP9RbOS6yOdHuws/xMMraMqqNr
    UvdtH7Ztbsr6ST36kUuxA3Pl0ff8knZa6f66gUWUmJqlosJsvFUhXWr3N83c5knLwQMGF+
    uVzWhwHX0jcvfGkZ9lUJr8j7yR3m3q/3uOOB+nGGXBkybCELV6pXRsnbhjn5Bbz5L1yrl2
    KuECQNwhUsdkSzqFeDSLlW5WPlRdKppPCd7A4IznP3A+uq28lEKJwUjOY5JU9BzDvQ2gzK
    WPmnuG8a2hBbnTuvrKjGfS/3iq6OonihYC9O8vOm3nPCM7cjq0mSLQeWQakr0kmGKGpSsn
    xu2V0kuii6scoPExJ0qFz00p8mP22k0StoAs86zVOuCPX09zs5fYPG/b8HHA
X-ME-Proxy: <xmx:Gn1UauXAbPVE6rnQE76nFlnWoUulZ95zMielOCogpRd5USz-QAOMBw>
    <xmx:Gn1Uajhdfof5OQIBMSBeD8ApNg7CFuk1OJLYAPulgVF9qN_6VJzlNg>
    <xmx:Gn1UakXsxVU0zo3tdnAIXmpw9kg6UTIL3TE9NXh-xKKvITX6Z0a0Ow>
    <xmx:Gn1UaiNKvNjirjW0skyXtV8u6VjPLHbs70nFV-j-bN8cA-3mg5EfmQ>
    <xmx:Gn1UasHW1CGzy5KCPbUnejDFSzUveXlvSloiYhlTXErHnrI-6iaMy32R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8e5db78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:07 +0200
Subject: [PATCH v2 04/12] builtin/gc: extract object database optimizations
 into separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-4-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.313.g8d093f411d.dirty

