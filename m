Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5212676D5
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394510; cv=none; b=AeMGCPO0joBFN4l7eLVKjuFlqnlByuBMM3BWvP2mSb1YqmoUXBl4BNxKu67cLGZPelSD/NE3debaAF//jDE7d890s+1ptmWOqmUccV3khUxdbcjhj+69I/tmwWWdn8FDA9AQ/4Wi9QjdwzkhXIVwxNm7HDO60DhteUvtVraREt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394510; c=relaxed/simple;
	bh=MowmkSgeFc7r6kl7TS2lvWeMMTRYbvRLLJhG1BJSpPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CM/Bf945nK3VmB5fl/ibkevOPUjFPAI1uD4dP9e4f/ESa/PCQPWwJ3YPtvPdPqkEmYLk7aLfrva0Jpy6ExLETmn2E/ux62WGE8/n2f1rnnfU0QUbxPtWCecuceC4pDeixEiQlhxmwuOU9znt65A8sLejPn21xGFuDFhyCizztds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pAirmFWC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jms5ewVr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pAirmFWC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jms5ewVr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3874A11402CD
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 23 Apr 2025 03:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394508;
	 x=1745480908; bh=5OQ/tKuOMagpv+XWI7Uj/aXXXcRjZ/hyW0aDT1xN2uk=; b=
	pAirmFWCsKpxV8kC7RFItdciqQiqBcxLsD3YlgRX17uFJJno5T6FZOGRC3U8OO+s
	aanFYfUT59Qiks98NFm1SuOkNuFq+pPMiahyd44xOJDg4gJQU68rr8gEz8yGFu5U
	ta3f1dVoF3DAIXVjnkjtoTOevKe6nWV1Ah/k0bIVXqdCuSzHRTErcEiulvgodWcb
	u5yQ/pPBGutTPicYSJE4leZfZrv0fWVAE0ZcYmYPFsVl14bGRFzXODjPTvWUpopU
	ltmCNOU9G9BQJnleXJ1Q5lOscbaU98R818JERa0gyElk6TRrrtuqclkpXQCx6nF8
	p/u3bkWX72d3rKaqIXv+Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394508; x=
	1745480908; bh=5OQ/tKuOMagpv+XWI7Uj/aXXXcRjZ/hyW0aDT1xN2uk=; b=J
	ms5ewVrqRPhx5+WGn2imrt0+NL0Ab79Ip3DH2W1Z0kdm7iv0miuzhTteCMQO8jCt
	6Sw7Yxge1zC9mwMa9djQpYP81v9fb9v1Zkq7kq6FkZYaN9dmJKSZm5jtslCm8ue7
	W7frVkfNrBsvLazKk/bEIlcDQ6wNgAObtTZikVLBgLaV7qvasZVO7ChUwOBqbJqE
	HniYE4ge5Q1U4zDOwM+v4C8KM0AN5mKenokf/sbzHgTeQpUWSUSqbGt1E+pAG63D
	VAjRvPPz5lqZc/JVIc8tbO8nA5Qdz65Pq/jurZg+HrU+zPHsaK96/ClOaBtkyZjP
	kSN3wHlvNFtrxoVdHpqsw==
X-ME-Sender: <xms:TJsIaNhjTDwW3vALZDYAUciYXfx_Zjp-tYHkgO1KnQJqhIPGLVfUHA>
    <xme:TJsIaCCvUPGZVbqhXFn91OgzDO6rD7SpzcOaGqeYyHi81SghDbVtJJCc9kOpAXGIh
    1bvUJYuDT2mJj1iUQ>
X-ME-Received: <xmr:TJsIaNGokWVVdJ6yBx56WPqfaS3vMOCEvohWgu7ADtflqT058074vNxcIFX9cNUEidyNue_Z3do1O8v79nasXcl44oE_UaYoz2Sc5iSYYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TJsIaCQTQECi0FlukbMyvYIS5Bd-lOi3f8b-1ZbzvS_2vlWEPIBWfg>
    <xmx:TJsIaKxC7gXqQ3J_UG2xOQNA3AVMKkHwAKVYjWoDo1MHZjsTjDHiqw>
    <xmx:TJsIaI6Hz7UAC9w92ODSKBYr2TrLTa3S1ps1k0Z73YmX2tNuo_zLAg>
    <xmx:TJsIaPzcq2ppXXmlY5mA5EvGUWXYs_-lmGbYsO8gE85qHBVKLkBgPg>
    <xmx:TJsIaOdE0BkbDBXPyt2OD9Uw86RSjnGAsJTX_rsx4b64ley6pcu6FDNc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7fd48a43 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:15 +0200
Subject: [PATCH 05/13] object-store: allow fetching objects via
 `has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-5-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We're about to fully remove `repo_has_object_file()` in favor of
`has_object()` given that the latter has better defaults: it neither
reloads packfiles by default nor does it fetch any promised objects in
case they are missing.

The latter usecase keeps us from converting a couple of callsites that
currently do fetch objects though. It is not really clear whether _all_
of those callsites should be fetching objects, but for a subset of them
it is the desired behaviour indeed.

Introduce a new flag `HAS_OBJECT_FETCH_PROMISOR` that causes the
function to optionally fetch missing objects which are part of a
promisor pack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-store.c |  9 ++++++---
 object-store.h | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/object-store.c b/object-store.c
index 0cbad5a19a0..0d873868a6d 100644
--- a/object-store.c
+++ b/object-store.c
@@ -937,12 +937,15 @@ void *read_object_with_reference(struct repository *r,
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags)
 {
-	int quick = !(flags & HAS_OBJECT_RECHECK_PACKED);
-	unsigned object_info_flags = OBJECT_INFO_SKIP_FETCH_OBJECT |
-		(quick ? OBJECT_INFO_QUICK : 0);
+	unsigned object_info_flags = 0;
 
 	if (!startup_info->have_repository)
 		return 0;
+	if (!(flags & HAS_OBJECT_RECHECK_PACKED))
+		object_info_flags |= OBJECT_INFO_QUICK;
+	if (!(flags & HAS_OBJECT_FETCH_PROMISOR))
+		object_info_flags |= OBJECT_INFO_SKIP_FETCH_OBJECT;
+
 	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
 }
 
diff --git a/object-store.h b/object-store.h
index 5bbdaba92d1..c6055376f49 100644
--- a/object-store.h
+++ b/object-store.h
@@ -266,12 +266,16 @@ int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
 			     struct object_info *, unsigned flags);
 
-/* Retry packed storage after checking packed and loose storage */
-#define HAS_OBJECT_RECHECK_PACKED 1
+enum {
+	/* Retry packed storage after checking packed and loose storage */
+	HAS_OBJECT_RECHECK_PACKED = (1 << 0),
+	/* Allow fetching the object in case the repository has a promisor remote. */
+	HAS_OBJECT_FETCH_PROMISOR = (1 << 1),
+};
 
 /*
  * Returns 1 if the object exists. This function will not lazily fetch objects
- * in a partial clone.
+ * in a partial clone by default.
  */
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags);

-- 
2.49.0.901.g37484f566f.dirty

