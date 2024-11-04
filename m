Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C81BE86E
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733115; cv=none; b=EzqC+0eNSwPC3Ga4p32Z9xAOFlsGBlNmtNXrrPvGOO/Eotb0Z6RrRREi0F5gP+25GQ6uWocICPYqA9KvG9JqdZEbjpB9dOm4qzIt9YGj7Qc9J4KJftj747jcvvkLje6TyA+4l8kYeX+emfy5MSvFWEyN2nJzOeYrLdna4MNeYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733115; c=relaxed/simple;
	bh=S9190QOgmbc8swz6IjHqmZdPzGaRT6U1zUYBzIZvyTc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjSyMQ/SThxbGlLe1dnbCjPpSTPx49/JJY+IKDombOFHtKc7/eIqP06gmNMKJtU8NeeKLdzpZozElPFH+VGcB1Ym0W3af9KWaO8UPBqedb49EEZA1aVx4dJ3OMQ+e6pr5TC4rbRwzELapucOJ7OK+hwlIL38nKzx5EWr0RyvWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EXmByHM7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zd02A7db; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EXmByHM7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zd02A7db"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F409138011B
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:11:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 04 Nov 2024 10:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730733112; x=1730819512; bh=cUYcaRbal2
	l4Cjb1AfJZ7vUsgA/qZ0gNKMy2g5O+oPI=; b=EXmByHM73HWbvJsJ801SB14bMq
	aVjJk3ODXCxOxRZdLX3Bxc2AnhzyW0h3IgFpxkqFZNr5eQ0dulWiAgbDwYF4QaJp
	MRp7ju+Htz+QnNPukw4B8W0nS4LXSIa4xfQbOYAiW7hAQ1urOd4/au6XR0bT4TEr
	HT789R4AFI2MCVxhFSw3vHNpJihUQR3tqPH+VcjRcfDx4L+czoZEGZAgoG/FwW9t
	WSYw5DcPp4MlaXHlaFUqVWhb/aaBxJKwGVzlHATmpj7PLLEhtk3cXa7ff2IxVI4m
	AGGj3ZsKHfM+i48In0oi9kj0C6ZvIxGWlpEAERSVEyMsnZTE+WwhG7JJGruQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730733112; x=1730819512; bh=cUYcaRbal2l4Cjb1AfJZ7vUsgA/qZ0gNKMy
	2g5O+oPI=; b=Zd02A7db9YmgBiIjwI6y3dPahvmCQdsFvyg6Ilh0bCGHuNnCluH
	GT1CR7Lo8cbL6i2hnCI9g3InyLqlZLdxA4XbLHVrNZ2Xh4NWZLi4HKbxNQK0EF9G
	YiZ7tG6QgSakJSlXGiM9G/89CwiIDkJG25KnLaZMNBBMGQs4X6Q14BAAgaATZ7TS
	L/iKfiL8U8Gzj/4hQVqi3xCbVU0ar6z5EiqXtJ8x9oAAcVStbHSfBAg8Isp2Np5Z
	QKk8iHKS9YUsDKEqU51QXlzf92YFAm+V+aHAx4DYvE12JYfheOymmFgBqtqUuTie
	sKFoS3tMQQTVtliSSOROIqdRgjYKK9s8HAQ==
X-ME-Sender: <xms:OOQoZ1gf8gsKhAJiPkDLKQeeI5-iryukzWnlkyfdFxIvKCRwB2DYcQ>
    <xme:OOQoZ6CEVhvBdB_MltQW_1VhFbPPAO__75_imJAsP8W9dVspQrg6s7E8DQThNKEwk
    rWeBb7tMyEDnZ4fRw>
X-ME-Received: <xmr:OOQoZ1GQ3llzfcz6a_DXfIwoRMwMcbNCOb8Wp3Rtr60wdSAFcbcs-IlRab3DTdBbtlxlLSf49N336NP-PIKHZ8Gn5zkcRebbDSPeGT2ueXKGhcNXpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OOQoZ6Sk-8bbhcXm_CGS0UefhGCFA42eSMLQncl3K84qMRtRPrpQrg>
    <xmx:OOQoZyw2hArGZkrpofcvTyX4UfK6mQnbNua1CE3g0axA6UXZoHhfLw>
    <xmx:OOQoZw41bdxdReOBpLtUDdtlSkauqruOZxQ31Yzgbukv48jYzNKeWw>
    <xmx:OOQoZ3y8r3e9sppBH6e1OePXJM4ZeZxLvLIsmAOyTlSsGmfmm0HjqQ>
    <xmx:OOQoZ3ogvbQXl5bgwhm_UCBq2aYH7_RBS7_RXSGEXcr6VNppzlnQ7uQq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Nov 2024 10:11:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc1a4375 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Nov 2024 15:11:31 +0000 (UTC)
Date: Mon, 4 Nov 2024 16:11:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/8] refs/reftable: refactor reading symbolic refs to use
 reftable backend
Message-ID: <142081cb0c22702dca018198f2e315109278d3a8.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730732881.git.ps@pks.im>

Refactor the callback function that reads symbolic references in the
reftable backend to use `reftable_backend_read_ref()` instead of
accessing the reftable stack directly. This ensures that the function
will benefit from the new caching layer that we're about to introduce.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 99caa9d5e6..3912431111 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -854,21 +854,18 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "read_symbolic_ref");
-	struct reftable_ref_record ref = {0};
 	struct reftable_backend *be;
+	struct object_id oid;
+	unsigned int type = 0;
 	int ret;
 
 	ret = backend_for(&be, refs, refname, &refname, 1);
 	if (ret)
 		return ret;
 
-	ret = reftable_stack_read_ref(be->stack, refname, &ref);
-	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
-		strbuf_addstr(referent, ref.value.symref);
-	else
+	ret = reftable_backend_read_ref(be, refname, &oid, referent, &type);
+	if (type != REF_ISSYMREF)
 		ret = -1;
-
-	reftable_ref_record_release(&ref);
 	return ret;
 }
 
-- 
2.47.0.229.g8f8d6eee53.dirty

