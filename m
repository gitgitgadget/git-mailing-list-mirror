Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008B1D130F
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797941; cv=none; b=YNIUi9FKFkDLVrPUy+WWxuUPyZMOFs+SEhr5gAOEz6E+cKJYXBm7QjT211X2uXcgvkO6PMrMc9r9/7HRndlZz7nB6D9KuBVqmX4rcdyGT2pEzI7znAc3CisZgZHSsmv+fHhzxj0SSLdsCgU8Uq5h33jTBtFVQrJCbX+tSzOstG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797941; c=relaxed/simple;
	bh=UhxvmbkeaJ/ZVJJ6WS0iueKcy8Zd9eElc1vblnpiKzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPuAmQ8CgqMVo+sA4Y5Zhax+rD6ePNVq/yg8kRxrogsz1kkLFt1jMGqY2uxN3UVyF9Zc8SPU/rpStKjXfiYA+dyG127LFIz996fyJHk8qEf4703W2HhazbI1Vbm5XQwQroIhL1K8v1/GICA5D2Npm7d0ovrfJ8PlN2iLK8dEMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ob/7oVhx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n1Abbju2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ob/7oVhx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n1Abbju2"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id BB6541140176;
	Tue,  5 Nov 2024 04:12:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 05 Nov 2024 04:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730797938; x=1730884338; bh=+PA3PSRR7x
	dmt6qh+LPksKQ5BdlRMZH9t7oN0HpQKTM=; b=ob/7oVhxmPwUe/vjipFdBDhffJ
	wnkcMOwbS+xoJB2hA95IDHcF3jLDYcBggUicRo+Lf11SQEz/X5dR5R5R1QibCC19
	nL/eSJ9uJL3WVI2IKXF9dQvPnY14C6f8NzfSC6zNq3hcaisRjrFX5oh3E8QIZDyW
	tmb52hDeMLrFxyYzVGDjMyLDmJzqdt4uEAIRkO1grPQh6Xk9gklv+LVPyFxQVZHN
	B3sPGwhOEbZ3vgFTDA7bqrs+SRk7QMeMVrpMneLH5Vk252dpD3u+oH6XVAl3EFO/
	pztYr1WvNWOH1hJ9ce2pYhPcf6Ee/uBGVz7noLznZ5ay6OhjHf7XFlbZJ0gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730797938; x=1730884338; bh=+PA3PSRR7xdmt6qh+LPksKQ5BdlRMZH9t7o
	N0HpQKTM=; b=n1Abbju22xP7DgSbsW8QqMKQuo9AiVYrFW6an+3oB9eFu95Ay6b
	0bI+ipMgojyjgLvoFvwSjlnoB6d0Us1bK79NHk5aD7FAFeNKE00rbuHFB9Fz1nYY
	qpJ5f67qcpxgmOUEKNbokzlELquNxUsNjUI4/tLZQcyfdWq8q+rl5+e/eInWrCH9
	7RfxzEYHKPkUYQRMxRsLaqwDcqGsTuj8ToMjGCcsZgKABQzk8UAbgbjk+WbB5h04
	Zn89eW0yU4PVrkZ7ZLCqbehFjy2dvw0UeKRgKDQsqs6mJxVg/dwbYbpJ+OF4C15N
	DmsOf4heUkY7rM54snB88egHdMQP6/P7YqA==
X-ME-Sender: <xms:cuEpZ3nvefE2XjRPtukVEX5iAKM8ukB3LruovMsHWUNiYOarjWrKNQ>
    <xme:cuEpZ63Ik1fBeM1nYSHuzH3W6G3cgwT-rBDcDrFeRvrHiVHDzBEacvMI3tJo8oGxc
    BLowWrFGVeYQltzRQ>
X-ME-Received: <xmr:cuEpZ9o3FA39hClseA23MPOft7FpuMMXETwIoVqDrtRDG9L243IyTdZ-iehYxPArKM22Ghn3tTIImRCHVy-LWLk7587xgYOjZJifeYF_1VbUWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:cuEpZ_kPpYkv8_AxFPwOsuaDSGArmGik3gM7gUkcdPHHOemgQY_U-Q>
    <xmx:cuEpZ11HcctNabeWvrpxD9G5ZvXlgFlYju7TOxWMDRkcOBUiFRkhGA>
    <xmx:cuEpZ-uM-1XEAAo5eXl-b-3bo3VgSFoq2pNEPq7OErDNKAkCTinTuA>
    <xmx:cuEpZ5Wz98GMWCX9ub8otRsBI1IKjBG4nQF_yJdSAX3Bl8ZJFcvLyw>
    <xmx:cuEpZzADKWXSTPEu0gTY7IM4M-agowzc3vTJGSeGvhWp3HtNbv_vZo68>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 04:12:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0128a8a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 09:11:55 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:12:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/8] refs/reftable: refactor reading symbolic refs to use
 reftable backend
Message-ID: <0906b04fc6da205cf67cca4d0dedac6f0d0adbc0.1730792627.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <cover.1730792627.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730792627.git.ps@pks.im>

Refactor the callback function that reads symbolic references in the
reftable backend to use `reftable_backend_read_ref()` instead of
accessing the reftable stack directly. This ensures that the function
will benefit from the new caching layer that we're about to introduce.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 230adb690d..dfe94ff969 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -884,21 +884,18 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
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

