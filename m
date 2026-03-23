Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81D242D70
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278206; cv=none; b=kRMrcgkoKMAGqnU+/Ut3cDKCReN1U4vjjRV9IOa885CGnEMoqMfuSEkOHBK1AqZNog06ct+BeUiVMgcMyRaaZERhTTBub4E1TMMSh9p9QcXXsmfdpdhisXxWAIbf7tNd1EWKM5UM2voKVyGJjnOBnt/8OkPjm5zMWJ127e9J1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278206; c=relaxed/simple;
	bh=Dw0imWS2nrYmm3Dax2JwPBpRrhgo02+rcRRfboLrzAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAh0kK3AQkhwHAeug2FZZ1U0zS+ielZ/Q2lEFyUYbdLHn5ZvcX/vKf7b4Ggu+ky3xDIcX64+lmRy+W8fxVtKwYsFsM2xAA8xrZ5ic+LM/VcyT/UV8KCEuAEJ29kE/qq/lYpNDmrGWa5pxfpaqj9n0Agqw8SBBc6WFS/D549kDqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oimq7Rzl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRJOGOA2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oimq7Rzl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRJOGOA2"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 13E5A1D001B6;
	Mon, 23 Mar 2026 11:03:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 23 Mar 2026 11:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278204;
	 x=1774364604; bh=IQM3ZiTs8vvWADe1LShdBz/mkrMW1Plzi2c5MoQmqIQ=; b=
	Oimq7RzlOPCPsdJNqishXZz2Tp88xkRB13+I/aFKLlUCNFdfPuUi87iz8jhxrdsm
	yMhbLdFfYVZFTIKyppK5mbyEi/XM9kQw7d5yZBK/E4ANmVop6NZNwtZmvqW0L5Mz
	uQhn6GlY5L2uksRNKCPOMvUTDVD+NQ6HdQLCrPei4cObWf5ZNj3FiZkQUEk1bSkQ
	XcA2jY9i04iH/vmTQUm3VvDRzG1iJc5NKa/Ni3BT0xsNLOrCyiWU7DfwHN/MLEic
	bgkoeyVkpoUID0GjliSIeJO4UONFeu3x4QZj+33z/AvV4zfCz8SU26qz7FLpgISM
	4komnsDrs5IWs2Nvsj8+3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278204; x=
	1774364604; bh=IQM3ZiTs8vvWADe1LShdBz/mkrMW1Plzi2c5MoQmqIQ=; b=j
	RJOGOA2/+EP+ZAO/pWfkKGxTrZy9bLQiQBQ7cYnQAE9ikrqelMn4+iZAc4Dh5KmH
	4thBpJegAv+/K9pDuDtwvcQnH2CO6QjHWBFtBTvsR9DiyN95tNvRcvGT/JNXEEN1
	PROlc2a+X5a9PA7HLyYYAwwQub2wuVlqA6hqzAAqxAoTZqqtBle4fjs7shazI6oD
	X3S/Gg8fQsi18dSM8yYCJ7swBq3WKxAQN1KQAU+1nFdr9Y5CYkkTZPpYCGPHOnVy
	AeQo1ZkYh4uksNs3KLNAiAl1RC+UaU53fx/sXEHs4zra1jRZSOdXLIDQXVrotJvn
	qsEhIVVpABRxL9RDf9yTw==
X-ME-Sender: <xms:PFbBaSdb2bYjSjQYEeXyIL9wSm15yCq2VP0r76FLW7_RaQHyHeAGIg>
    <xme:PFbBaSN5-NRuas3MOVI_VwWyL086dTUp8dt_xTKgT-Y0zlXzfTbzLDaocqekArTZK
    hS-7pJ3nC8tumdBiD_xkikr73PZBvUH5pr7UmmlWGnwDwTljUVjiw>
X-ME-Received: <xmr:PFbBaRL8LSXOL5GYN0t7HMZUpDAHznPioY36ON7zPJrOFvmUGj4FfPaykjNA_g57lIwMrhXM_xZm92yvE23LYBspFDX_8eAdN3nUGrXiFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PFbBabHIfkmzNQXcyP42dj9pVIDFQHIuZKxI9UU2ODdi7cQ3hlkPBQ>
    <xmx:PFbBaRT3PJ7mM2yBdF2CpovKQFgVEfmmh8uj6mH_a3J9HIrTOa2cwg>
    <xmx:PFbBafEW-eGoaqRdX5IW9VYE5XWeo3BLExdUA1mT3b87ctq18HtVoQ>
    <xmx:PFbBaV_9awEdvDx6p2lc53Rg_o7ddxwSCKr9m7MNlavjfoF1yeQv6w>
    <xmx:PFbBad0IFu4iAdU_B8ZpElaUVOb4bwU5VYQsFkCFJss5KvxmxojM21j0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21d24dcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:02:57 +0100
Subject: [PATCH v2 06/12] builtin/fsck: stop using `the_repository` when
 snapshotting refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-6-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We depedn on `the_repository` when snapshotting refs. Refactor this to
use a context-provided repository instead that is injected via the
`struct snapshot_ref_data`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 59680e6daf..edbff16add 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -533,14 +533,20 @@ struct snapshot {
 	/* TODO: Consider also snapshotting the index of each worktree. */
 };
 
+struct snapshot_ref_data {
+	struct repository *repo;
+	struct snapshot *snap;
+};
+
 static int snapshot_ref(const struct reference *ref, void *cb_data)
 {
-	struct snapshot *snap = cb_data;
+	struct snapshot_ref_data *data = cb_data;
+	struct snapshot *snap = data->snap;
 	struct object *obj;
 
-	obj = parse_object(the_repository, ref->oid);
+	obj = parse_object(data->repo, ref->oid);
 	if (!obj) {
-		if (is_promisor_object(the_repository, ref->oid)) {
+		if (is_promisor_object(data->repo, ref->oid)) {
 			/*
 			 * Increment default_refs anyway, because this is a
 			 * valid ref.
@@ -581,11 +587,16 @@ static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
 	return 0;
 }
 
-static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
+static void snapshot_refs(struct repository *repo,
+			  struct snapshot *snap, int argc, const char **argv)
 {
 	struct refs_for_each_ref_options opts = {
 		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
 	};
+	struct snapshot_ref_data data = {
+		.repo = repo,
+		.snap = snap,
+	};
 	struct worktree **worktrees, **p;
 	const char *head_points_at;
 	struct object_id head_oid;
@@ -593,13 +604,13 @@ static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 	for (int i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		struct object_id oid;
-		if (!repo_get_oid(the_repository, arg, &oid)) {
+		if (!repo_get_oid(repo, arg, &oid)) {
 			struct reference ref = {
 				.name = arg,
 				.oid = &oid,
 			};
 
-			snapshot_ref(&ref, snap);
+			snapshot_ref(&ref, &data);
 			continue;
 		}
 		error(_("invalid parameter: expected sha1, got '%s'"), arg);
@@ -611,8 +622,8 @@ static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 		return;
 	}
 
-	refs_for_each_ref_ext(get_main_ref_store(the_repository),
-			      snapshot_ref, snap, &opts);
+	refs_for_each_ref_ext(get_main_ref_store(repo),
+			      snapshot_ref, &data, &opts);
 
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
@@ -621,7 +632,7 @@ static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 
 		strbuf_worktree_ref(wt, &refname, "HEAD");
 
-		head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+		head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(repo),
 							 refname.buf, 0, &head_oid, NULL);
 
 		if (head_points_at && !is_null_oid(&head_oid)) {
@@ -630,7 +641,7 @@ static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 				.oid = &head_oid,
 			};
 
-			snapshot_ref(&ref, snap);
+			snapshot_ref(&ref, &data);
 		}
 		strbuf_release(&refname);
 
@@ -1039,7 +1050,7 @@ int cmd_fsck(int argc,
 	 * objects. We can still walk over new objects that are added during the
 	 * execution of fsck but won't miss any objects that were reachable.
 	 */
-	snapshot_refs(&snap, argc, argv);
+	snapshot_refs(repo, &snap, argc, argv);
 
 	/* Ensure we get a "fresh" view of the odb */
 	odb_reprepare(repo->objects);

-- 
2.53.0.1118.gaef5881109.dirty

