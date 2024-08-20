Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0D192B7F
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162735; cv=none; b=MrmrDy/9922bo0w4pjEJ6aM/A6C+ymx+NECOt7P1VmBpEp6wzDAv6AujMl0N6v8JZ/39UsF+FBrjyRR4J9IgIRffO0fdvGRuJbViRW/H+5B93YvfNldEGwvrwQfB9Welf4/irqbm9BsRLfD4k3bcGdg5oDhgdoLFmsusggleolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162735; c=relaxed/simple;
	bh=frzfgQegaiMTWqYDcpcJFAN6SevmLupG95bK/iyYZMU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVrYFV1UGE59P9I2q1da94Vgu/LM2D3OvZwWOzwhoGkv8SI4uZFmoAcq76EhBlwRV3baIemQqHk8c8vgttYqeb4dZHtTel4gC+rt92KH9dRyjGgF5Fsx6cDWLmNdOPZ1osdRvr165rHncEsG1MKrtdo4q5UMGXCju4aCOCvvW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jzHZgOsg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ng1GFSvk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jzHZgOsg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ng1GFSvk"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 335E11151A82
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 20 Aug 2024 10:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162733; x=1724249133; bh=vXKoifygpu
	jg1nDhlKxsTPXskdygzLtZUauu5641c+8=; b=jzHZgOsgzUMkZ7xsog9RaoET8D
	6iyubOpfaeZfFR+OpI069K7P7u+/WpQyCtL9vamLKmPfsrJ4tC1BZcy3bNDp84UT
	vpuRTx3ZB91RDljGNzL3DgZ5X2G2x/I4n/ONKx1/1Vi/xO/axpwmSaL0unzMWhNx
	SUV3rnTXlbLRon24qLmJAdsN5oIe6am/nNPblA6mUgdq7vSFvDpLfY88fsrhKYxV
	0gwwX9jXMSZGLwLs1SYvQDiFLK/hqg6g+oleu287E97EmCdfrIMhQ817R4U+4aC0
	kBRgcLIc5D27s6treu/EZci/IYY5fNvp1rDgdDl2BiVbvAzINsV1j8ZBRKug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162733; x=1724249133; bh=vXKoifygpujg1nDhlKxsTPXskdyg
	zLtZUauu5641c+8=; b=Ng1GFSvk8dd7+/kjL2XZtiqt+3vNNyiRuVdNEOiJIn9V
	5HPSF/E+tI4wWG4N3okZrlqHi3CG66H44N3bIav5yAsJz/hZdaIp96xe+Qc8/9Vt
	0//ubQ98VC4bTGoJpa5tpBrPPCaK39bnkQ3d5jKYBjaK5ZGfAxyZnhQEjoDI2Kex
	kamaclWuMByHSGayW0OIqIl+jeIxlGJeYqAvVC5eayDRKY+UsPkyaJefNdZTeUVx
	SBV0WykDAfRdI7fCUWJbFmTWnkTjNl8Zyvn7PBRLIStROaiPvfCw23FNE/7Giqjp
	aWNpnNQso6fNmpfbvPWdTeMegYpWdYFdb74jeFM84A==
X-ME-Sender: <xms:raLEZrAcmDrpnAfG9b7eS0IB_KNlNUEhXityL2Yogop09kRAUzSD7g>
    <xme:raLEZhhzwPZFxgFsTpigCvvm_VMhX5anAR0QS9YW7t0d-FNKh7VsiA8ksnpCagVVG
    CgB_HkgGkqW36AWcQ>
X-ME-Received: <xmr:raLEZmnp2NhNC8CIdn-9xBM0FyfGVv2DcDaiDFLT1OxXXf30Mwj4MfbCIpXnHjLQfOiiIF99-IzBeyjiSk7cg8G5V7yvdqw2vAyRjorBDnMh8ASZmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:raLEZtwjv7Vb_X_yRtXPAz1PTbztc7Vp2s8eaHRX5cAO0F9uFNbpwA>
    <xmx:raLEZgSxrS-yJLuqbQS5skaJpcmycv47iGHG5j-MKQT4TClHUg2RKw>
    <xmx:raLEZgaTlIL4xAr7sPiXj6XtHEezv-ocWTvXqbZq2hFHc7jJCa_4KA>
    <xmx:raLEZhSPf0WJ9FbrnSib5P9wl6CkmAMUbDP217FUg27DfI_JXOxUNA>
    <xmx:raLEZrJODBNOMGQuCrtDspUYzGDYrqUk6NkA1ltACGrw-eH7ze-6TlBQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7965b5de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:05:02 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/20] transport: fix leaking OID arrays in git:// transport
 data
Message-ID: <8e12c55536d8de52f5c5a972c739977b69d624ce.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

The transport data for the "git://" protocol contains two OID arrays
that we never free, creating a memory leak. Plug them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5501-fetch-push-alternates.sh | 1 +
 t/t5519-push-alternates.sh       | 1 +
 transport.c                      | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
index 66f19a4ef2b..0c8668a1b8e 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -4,6 +4,7 @@ test_description='fetch/push involving alternates'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 count_objects () {
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index 20ba604dfde..72e97b15fab 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -5,6 +5,7 @@ test_description='push to a repository that borrows from elsewhere'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/transport.c b/transport.c
index 7c4af9f56f2..f0672fdc505 100644
--- a/transport.c
+++ b/transport.c
@@ -946,6 +946,8 @@ static int disconnect_git(struct transport *transport)
 	}
 
 	list_objects_filter_release(&data->options.filter_options);
+	oid_array_clear(&data->extra_have);
+	oid_array_clear(&data->shallow);
 	free(data);
 	return 0;
 }
-- 
2.46.0.164.g477ce5ccd6.dirty

