Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33C3A8729
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007287; cv=none; b=HLvPOsEDiGmC83rda41EVHanAQiEfneCQfyBDjXrQNLkVVDC1uiTBKNRe9M141HP1PxkD1m/VprEjoT/mVS5P+xMS3TiNIXHed4MeU0X9yIx24Rm62utMGEW3URoOOBmpa6PNUPCcglunwkHAHv2Sgyo+yoNG7w1auybbHzcmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007287; c=relaxed/simple;
	bh=oZwf8QccPzGPOQmd+mD9L7s1UpiLCaqsxxDYB1QY09U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2CyCLZ8koOqXtbrdqckb/0C7w0UNDF4yoMsxkn7lDTI7nuSK1OVlz5Vt4Qo+770XYj58o8kr1YJwFsly0kt63VAQlSFGAo+LMDB3ACwxpnGZ5ceqqgvoM3eSL0My4QHQlOrUn/O3vBVqql+ZCluvCAGym0Yd6FelyuQtx82kmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ggpOveXy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yFQAQlYR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ggpOveXy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yFQAQlYR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E13531400176
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 07:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007285;
	 x=1774093685; bh=sBe2hUHVRhiT/yTKLj3pX7K7Q0DFO/zC1HXGpmvv0N4=; b=
	ggpOveXyfGBcPIbBjulkYdIqgw+CPkvjOoPlRtLnRFEuEXsVs5lY+564bnl72oJr
	aA/QjYDEVVAy0clv6z+9UR7rHcG3r+fem2CroCFCtY9NEdDdeZOfchvBfTeaiGH7
	+FXo6aYTwBkQibbPn6NC1XRQk9beBTYLZMADZDbwe5itXUMDNg73Slw6SRfxxRP2
	tDmLAw6Zdh4WEtYvWMRvZ0YhKgysUs9jfeCKI23Kf8Ro6e9RCQeE0gqWz1yAjsqT
	ScpG2uhN8+KisEotqZzuhjLyMy/AOTwbB4JC9xSwjkFQ0Z60xql/BPwT1A4JyxC0
	XYec+PykEzJ0na3U/wXXPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007285; x=
	1774093685; bh=sBe2hUHVRhiT/yTKLj3pX7K7Q0DFO/zC1HXGpmvv0N4=; b=y
	FQAQlYRv0T2nAtwKV+bHtjndD44OrdVSVsAnMUK3NpOGNvAZngNNio6XYYrVSPnj
	S1y2as0YmrQiJHw9p6X3OhYJj+vi59eY7WZW6nomnkoJxXEDicBtrMeawxcZpMKx
	xLXJ5YAeO2bgbOh1SMJw+CtbNJxLNsGqQGHkypip3ehfVqU1vlCRGHqiIKmnFjMN
	v9lw5efSK2GPCWwdmra2msLVdUUQN+DPq1CDlu9ftVXPLCDOQfzgDCuucyD9BL8l
	mMxHxS6sq7vT89qapXX/l8or1G0E0wwkQvpuysnEyRwv0FJZY0NrFTu6xBQrW8vv
	mOSpRXESlO/2XShT7aS9A==
X-ME-Sender: <xms:9TO9aZw8n-em72HX2qmmQIzunXXqyTyAgAqcZirmR5qHUZBYX3hNNw>
    <xme:9TO9aQMLsX1oyC-19jnzMcRv6gN9_u8c0GX2-JbsGqZlLrIAPz6Kj5ca6-wUd6t2D
    PdOiX0P_dnx04WrGP_9WNvGjBCRBCtbCYv3k7qt90FwL4nb5GSszw>
X-ME-Received: <xmr:9TO9aY_NLNEJ9yvuv4bgJequLYvk76ISrcOPVxVkCre6sW-nIIAItXlyN-w7W0wGuJK9hHx6rQCmmfivcEyDxXz96bEBucEhx47GIP_Vtvry>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:9TO9aQqBCzt_MC927Co4liGx9Nr_auofPipo65zsOr1_pvj5a_lkkw>
    <xmx:9TO9aa7iMbyjTavPLpuHby75MDevqpSjK_kM2ihAnL0gsSqnyOwp1A>
    <xmx:9TO9aQPF-JD4ynL7DJV0tZ6jBXeFbzIjY3pGxn8I1p7EoAan09X0qQ>
    <xmx:9TO9acOdr4KzNxG-yEihDVsRDAvn9XXgDk6Rq5MEv7XID8zvE1sojw>
    <xmx:9TO9afwmaq_aDvZLf3T7xUrt_9Xsv6We1TgVHUuXQRDYc4bH1rMRyFZY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5418df7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:48:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:13 +0100
Subject: [PATCH 08/14] builtin/fsck: stop using `the_repository` when
 checking refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-8-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We implicitly rely on `the_repository` when checking refs. Refactor this
to instead inject the repository via the callback payload.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 00476bb921..63cd58e58b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -573,11 +573,12 @@ static int snapshot_ref(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
+static int fsck_handle_ref(const struct reference *ref, void *cb_data)
 {
+	struct repository *repo = cb_data;
 	struct object *obj;
 
-	obj = parse_object(the_repository, ref->oid);
+	obj = parse_object(repo, ref->oid);
 	obj->flags |= USED;
 	fsck_put_object_name(&fsck_walk_options,
 			     ref->oid, "%s", ref->name);
@@ -664,7 +665,7 @@ static void free_snapshot_refs(struct snapshot *snap)
 	free(snap->ref);
 }
 
-static void process_refs(struct snapshot *snap)
+static void process_refs(struct repository *repo, struct snapshot *snap)
 {
 	struct worktree **worktrees, **p;
 
@@ -673,7 +674,7 @@ static void process_refs(struct snapshot *snap)
 			.name = snap->ref[i].refname,
 			.oid = &snap->ref[i].oid,
 		};
-		fsck_handle_ref(&ref, NULL);
+		fsck_handle_ref(&ref, repo);
 	}
 
 	if (include_reflogs) {
@@ -1092,7 +1093,7 @@ int cmd_fsck(int argc,
 	}
 
 	/* Process the snapshotted refs and the reflogs. */
-	process_refs(&snap);
+	process_refs(repo, &snap);
 
 	/* If not given any explicit objects, process index files too. */
 	if (!argc)

-- 
2.53.0.1055.ga2ffed1127.dirty

