Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8103AA4F0
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007285; cv=none; b=Y7QwDG88ppZ+P5QeShL3ITOtEiu0yaFFZiVIPkcpL0t2Agan6MvDV3Ptc9uYjzSkF2ijszbGeZElY6L3j3rw2ArQowx8TiVib53VVMdKpWxK4ALjEcCMw0ZyQ2VLewSR1Q8gbGXB3EMUJIK2WF1uQlQis1jUZKuGLa1RBH68KSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007285; c=relaxed/simple;
	bh=0rqZ5KHFF0U1F0wRp72Yk77p0IqpuNf0f5oEv7+S18s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKkhyk6I3damNUlaay5hXCSaKNrMPmMU3N5x+PdOA+GPBgN8aoiwEpUTRirFq5G5lDT22URQijz3U1Nwul7myj5Qyzv6aT6yIRyXD+YhGscNTE+XMduFpvdVZ9HvtmHFOfHDZ8Xm1v/DSnYAND/ZTn+NTsqn6OKsPckgPEbfbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HVMjSCZt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yQVOLN6S; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HVMjSCZt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yQVOLN6S"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29F361400176
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 07:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007283;
	 x=1774093683; bh=DlkfzeVFt8ltgZGQYo8bEtLqo2Jmu+zeeJOw00WwWW0=; b=
	HVMjSCZtcW0c5WMWt1leqDGa6eU3HADvGg6ZLXTyTf9oiSIKiTveuUD6mkpwMzqx
	VI7dstcQn+zBV5ar+7PkMl4zjBosr/g+7OnHdYKDS0vclqQozsOXux38LCUKYDyL
	PjbtRGEElp3D0nnZSLh7vffs+CP35cis+xaA0FvfozHrMZtQEwQF9FieCspJK2g6
	DOYQxYu/Q0qxhQYmEByZnWLOl8axS6/cOAS+3B6K3W1hZ25pp0ErMGshwj2txra/
	jLzePwM+8RngPlPbiSGkdOTkpkbnZ7AXfcM5V9m38E71m5684+XSwDSx2phIMIUl
	V4ybYjHwH7dmmwECCvo8TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007283; x=
	1774093683; bh=DlkfzeVFt8ltgZGQYo8bEtLqo2Jmu+zeeJOw00WwWW0=; b=y
	QVOLN6SEYqyl7yCEvlKb8DfbRKkzzkMUSMhfigfyUMXT/qXkkc0RZ12NuzOCucDE
	mcsze6l9QpGiNJYRdxsAsgkcmfz1bPztJ2OCuhbcpHu+K9ojwRoSGTwPjzV26wAe
	I6T9ESRAKF2uSB2BkDJ+FqUOJEeRVse+5SmHtj+Dnh9d8D+55JFOXtl8s3FkxJG/
	T19uovlKemg3J3pR0Xg6EP6nyfDGJtGW57ifAqs2a/vuhKaQgsiTdSTETx1PYrQC
	0cBbCtKz7G8yBDR0Os/Ngv+pm7Rt1CMSqhPgFXPcI5YM4apHnogfosaHRrPK0UHz
	KLqGI5Wkl86p1GktSYWFw==
X-ME-Sender: <xms:8zO9ab_jynzN7lelTsC3Yv-_otejAq2WJ5pBmm-twEiRz5PR59k5eA>
    <xme:8zO9aeqmtKdaGgLFDHwTQf--DEaOiliFF3G7Pr-KMP9BqG5PJt6FVhnc3_L1fmpO4
    UBrIMxB6RM06lzD4uGGCp4vOOoRkFmAepkg33K1jiBw3fdqO489zw>
X-ME-Received: <xmr:8zO9aeq4u_2JABzXr4SJ4z0Zb_gXjIJ3v6e2u4Hezk8A_f4d8UB2ihqxoJTlI8qMpkA26vQAFOjBlib7Yj5Q9Tpxl5KeOJDP73GIjpspP7OX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:8zO9acl4PX0Q-3kUtu-Wp-WLN9JMRJjlQUi1sqWNPwEGCrFMJtQPaA>
    <xmx:8zO9aQH5Ida9ACk71jvk0kKaFullJLW6ndcQaeTyjyhhOckEinelow>
    <xmx:8zO9aVrYxN6FipZogddkxiRQ1RYr4AlukstT1xsaFJU-L3F_AxGvPQ>
    <xmx:8zO9ac4DKEKdIHhLc-xRWYVuxwQxpQO_AYoCl7lgXr2Gu3mSDSAzcA>
    <xmx:8zO9aXuMlcQ-7vwDCYPSYF4IKmhls5AyHhKYMV7jLdDyebAL5j3wRXcY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35aa6606 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:48:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:12 +0100
Subject: [PATCH 07/14] builtin/fsck: stop using `the_repository` when
 snapshotting refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-7-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We depedn on `the_repository` when snapshotting refs. Refactor this to
use a context-provided repository instead that is injected via the
`struct snapshot_ref_data`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8a52ad02ae..00476bb921 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -532,14 +532,20 @@ struct snapshot {
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
@@ -586,6 +592,10 @@ static void snapshot_refs(struct repository *repo, struct snapshot *snap,
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
@@ -599,7 +609,7 @@ static void snapshot_refs(struct repository *repo, struct snapshot *snap,
 				.oid = &oid,
 			};
 
-			snapshot_ref(&ref, snap);
+			snapshot_ref(&ref, &data);
 			continue;
 		}
 		error(_("invalid parameter: expected sha1, got '%s'"), arg);
@@ -612,7 +622,7 @@ static void snapshot_refs(struct repository *repo, struct snapshot *snap,
 	}
 
 	refs_for_each_ref_ext(get_main_ref_store(repo),
-			      snapshot_ref, snap, &opts);
+			      snapshot_ref, &data, &opts);
 
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
@@ -630,7 +640,7 @@ static void snapshot_refs(struct repository *repo, struct snapshot *snap,
 				.oid = &head_oid,
 			};
 
-			snapshot_ref(&ref, snap);
+			snapshot_ref(&ref, &data);
 		}
 		strbuf_release(&refname);
 

-- 
2.53.0.1055.ga2ffed1127.dirty

