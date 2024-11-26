Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A918FDDC
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603396; cv=none; b=alw8ibN0lLIH1CZQtKtWFQsdguq2EXFeQM5t0Hy3TxeHXaC3RKVpk7bms3d9dE7LjHBlcecLYsDi6q7Q0ZUG9zDRRrmcVKNnIcpTZku2G/a5I4a5jZeh0ASWinLlrK0sVKuaBgkFiXycKuuQsbuvMsh6Pw4BIrOmoShHt/T7a7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603396; c=relaxed/simple;
	bh=HPm24ebYEPF4LM0/oL1T6M14ASdt/4YWdg93+NLSa9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtDJ2kuF3cn8Wh3m3SShPZGk063ACElOWxURV9NqYCGuYlVPtMLebBX+tZk9pzJ9kyd20t0R8Y+sJWwliIU/gV4+2dM4yGLVVhao/ABiqOAs3bCX2YLQ2XsQB7pqeXTYGziBx/+agrfW6C/F6PTf04BXyq5nTNbt4mM4njK+J8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wfmCDdhB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LzvxD+T9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wfmCDdhB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LzvxD+T9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC09211401B8;
	Tue, 26 Nov 2024 01:43:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 01:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603393;
	 x=1732689793; bh=ZdkV5Vp5z8qbHtIBvzfRn87LvMoaBaEagc6vMF77zAQ=; b=
	wfmCDdhB8VJ6zq4wY9ONvMIhfCKNTtutFXor3f5JSYwPR+FkM0zsH0tuuKmv6Ngz
	2Nzp/TFdG/9iD8vr66gyRcUSWMi04SORo/9by03DtbvVd1zMwZARyECOaVsm1qN7
	uOsxebQEIXtPj2WiAp42xug8VCTL4rE6+juISzPtB4L+bvr5RCd1qLHf+inhnpy0
	lShzhKqtsbkvnTzs1pqJwPrUhfHV9oVmR13Axi0Ex9Ob7apfP4yd8zgFEYhtI8fY
	w7/BoTpJOky2TCgrOhUVefoUY778irlh5mB8RhStysQw1Z3Kt07fpQusiaTFV0GG
	xGl8xGbdFmYczvUZ+Vjgig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603393; x=
	1732689793; bh=ZdkV5Vp5z8qbHtIBvzfRn87LvMoaBaEagc6vMF77zAQ=; b=L
	zvxD+T95wtuaF1gb1dveDlAJwfwL3vBuYkU9nU+wE5THtQqsgbE8sO1BnkBpK+0M
	ZPBvgxSTMyuMW4WJ3P5YmchrZ/zk03qcazglKJshy/xipTCWrU/e7EPUWxQIx8w+
	Etvg/sKT/K9G2glTmpeGg3e0WRtpN1PUjSrr+afml6erS/hlxO57CaoaLuHCUbcD
	VAmoSU3WNfybB/4vP3wcV+lP6K3So5KRKb0hepxS7RRHmqHhCv8uG1qe66Nv1Kxr
	fXcXoMxdHJWKIVHi/ALATMRQ/NgdhuR/XKDj5j8CiqWc/Il+ynPOmZSNBqqbdZwN
	no/7P6z4I/2yABOC6ehWA==
X-ME-Sender: <xms:AW5FZzM9kCdJuyKV18faSlNyQVLZWKiBURtXgyavZ3axm5X6egQB3Q>
    <xme:AW5FZ9_8X1wU6_o2iDHUuPOqtwj1hWa1zFkSAQCv--POUPdLMX91Eh3Acj8CPII1L
    y0-Gf_2oVQ_YjEgzg>
X-ME-Received: <xmr:AW5FZyRdAwnViqyBCS7LMAcvLKhkYPZw0v0PjC1rXBu4ZU0efcFj2N7wzuzNo_GncpOWTq40P_EteraYtZ0wH2E4jlMvHoF2qz1Me034k3-zz7Gl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AW5FZ3tsMDY6uXzZwoPj_iVhAGKBXrqeJ7kfY1YRpi04TFGjcDj4Pg>
    <xmx:AW5FZ7d2vHsXZxyxutYu_XNvSqZtri-v7Qgj1WyJsvWKU-D8k-DgxQ>
    <xmx:AW5FZz2SgaVJT-PbjlnSv28_8l0NC2kyquiu16RunFbGZqlFj3QAbA>
    <xmx:AW5FZ3-jZwrXfj4gfJIhdoinrWJnx4RyR4fGlB7xOjViX6F2pmPiBg>
    <xmx:AW5FZ34iAbvUAdehpHS4gmnL4oFwAZ5FgccAHzOpQe3MGwfWz-zqARHz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e286c882 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 Nov 2024 07:42:57 +0100
Subject: [PATCH v4 06/10] refs/reftable: refactor reading symbolic refs to
 use reftable backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-6-b17fd27df126@pks.im>
References: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
In-Reply-To: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor the callback function that reads symbolic references in the
reftable backend to use `reftable_backend_read_ref()` instead of
accessing the reftable stack directly. This ensures that the function
will benefit from the new caching layer that we're about to introduce.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 88910207b87b1fa5bbbedebc8817f8afab937b77..2d06620ac8b1b7f07783cd5873dbe0fe67b84bd6 100644
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
2.47.0.366.gd4f858ca17.dirty

