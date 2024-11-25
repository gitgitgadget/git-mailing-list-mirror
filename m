Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA6188CCA
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520330; cv=none; b=FDO3Dfputzx5VOcD65mYxilNiWST//wLd9v5uSIGoli2klBJnkcW8YzqWo09bC7Rvj7dljioSKngPig9gHqrG9sQYoQclQWYcMZdCWt8eYy9PU64rNXzL6MOuPPvGEPUOsxpQQFWn1j1sRdbTEVh5jP09iNIc+dTJCKO51enfE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520330; c=relaxed/simple;
	bh=M6aJcj4kFvfAsTo0npLzgkF8AJ5eOitwn3rM2JHssdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u43C1NBFOuS8NWbtY6ZJKSV+ZstYJf4TZJjcpGxBZSmdmfDp9NZT3wdySUvXPFxDqQMEphojNXi/Wp3rsMWQ96nAEQBMg04ibXmHiSFKe6ZZNFJsZVSdGlJrtNuMDWBAP1Fac3J0O7P5u0eUTxR3k36yJj7oP3J+FJcJiy5av/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V+48pYiq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBQS/v8E; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+48pYiq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBQS/v8E"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 041332540175;
	Mon, 25 Nov 2024 02:38:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 02:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520327;
	 x=1732606727; bh=WiGssL56dwrzpnEExMIP/xfZluIHa7DItOGEEB9CE24=; b=
	V+48pYiq5nruBhtwH1TK8AEKsmukONyvs4gESsqX44sPWbi41eMTRBXSVRyFn4kB
	QLbMe02ySHOX2SeZsJ9gxVVZ9c7bJ40/sowclhgPDiOBYCVkNgsw6Nq4GYaTSHNP
	SmU/DcNaW8o6XpsEYjwDgw0zSIV+DueNjgQ/OowqpjZ+fqdOGGKeTAYPKTZQlEuV
	ZDaFMLUhVmfoL8jw1qjLaMtC/j7AtAhpabx8/Od4yACgegSJc1ZbirMrgFyCwhzz
	xO4NbVgQxJukKmm9Xc6ZYnYwNvtMfB/EdT3fbB6d8SY8YcK+jOAe4Clc1Ol/iHCR
	KDh3cviqQjHsWTN/I/JB3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520327; x=
	1732606727; bh=WiGssL56dwrzpnEExMIP/xfZluIHa7DItOGEEB9CE24=; b=j
	BQS/v8Ec7rgj+hm+uqsSCXHIJhRk0TRwblVn/njp4rDfi5LBfi2q//fRYCrAP+Xa
	u1UsLgZpM7qFS72ul+i/7ZKnq9VX2leg0+u7FTb62GcQIFUXFr2xioCc0suJNq/F
	F6+jz+S3bnaw0W6l3shCkaPR8l6arLC7fYQbS/eJEc3E6DBJ0YZ1V0RaRBg5qq2c
	sO/osjP5zV6k4rO12UW66whT4gRx/qdYIg2wpBJapBwZT5FLVVQMGlvkOabdeVWq
	i0cD/DlGEjkdQvAUiT9zzd50o7iZIpQNQzJM8kjrIa2DryGPM1/LOK0gizyANyi+
	lE1xkfw19Jto8dbzyCCNA==
X-ME-Sender: <xms:hylEZ8jV7I5TMelhe2kgA3hsA0rZSTbGuRsh6SH_vMu2S7jDM86nLg>
    <xme:hylEZ1DSPm-vewZaUQuQChxSe69w78jMNvYfsEfanOiYQ4Zwvp9XZ_A6h0N_I-uL8
    U3Xceqfex_WOKb-Og>
X-ME-Received: <xmr:hylEZ0HE0wforXuyntwwIHiMBmCR_U_RfiwNLS5ELn-20JYTt_BavfwTmxxRr2OPsidhIQLTk_6eMBPhafo_sNW_6KJ2rjlnHQM7ku8SrjgF_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hylEZ9RhTCbZomq5CK16m2mXHZCr6-XF15TOP-8eqo76ZQIfbO6CJw>
    <xmx:hylEZ5zjHTJGGDtiYF0xizmn7fD2vkXd7KmiusL3VJuyaS6X7DGbzA>
    <xmx:hylEZ76t7s3lhgL5-KHyyPFMq3sm2t23IND96Rr5kEPpCJ-2dgQ6uw>
    <xmx:hylEZ2w_foDEUCJ__z6402yBEpuR0jmmnzeKsR2Lm2RY_GX266rdBA>
    <xmx:hylEZx_Ny83jdP_2s6jk4f4dErUPPXxac6iV3t0LFEJdjNXkplKXqIDi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:38:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c9b69f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:37:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 08:38:28 +0100
Subject: [PATCH v3 6/9] refs/reftable: refactor reflog expiry to use
 reftable backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-reftable-backend-reuse-iter-v3-6-1d7b658e3e9e@pks.im>
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor the callback function that expires reflog entries in the
reftable backend to use `reftable_backend_read_ref()` instead of
accessing the reftable stack directly. This ensures that the function
will benefit from the new caching layer that we're about to introduce.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 498bc9f932673e6089bd3b27e1bb7ed8d0e36a4c..ff49c27a6a0f4cb1e5b3bfaa3d34d3302c1bdb2e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2444,14 +2444,15 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
 	struct reftable_log_record *logs = NULL;
 	struct reftable_log_record *rewritten = NULL;
-	struct reftable_ref_record ref_record = {0};
 	struct reftable_iterator it = {0};
 	struct reftable_addition *add = NULL;
 	struct reflog_expiry_arg arg = {0};
 	struct reftable_backend *be;
 	struct object_id oid = {0};
+	struct strbuf referent = STRBUF_INIT;
 	uint8_t *last_hash = NULL;
 	size_t logs_nr = 0, logs_alloc = 0, i;
+	unsigned int type = 0;
 	int ret;
 
 	if (refs->err < 0)
@@ -2473,12 +2474,9 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_read_ref(be->stack, refname, &ref_record);
+	ret = reftable_backend_read_ref(be, refname, &oid, &referent, &type);
 	if (ret < 0)
 		goto done;
-	if (reftable_ref_record_val1(&ref_record))
-		oidread(&oid, reftable_ref_record_val1(&ref_record),
-			ref_store->repo->hash_algo);
 	prepare_fn(refname, &oid, policy_cb_data);
 
 	while (1) {
@@ -2545,8 +2543,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash &&
-	    reftable_ref_record_val1(&ref_record))
+	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid))
 		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
 
 	arg.refs = refs;
@@ -2571,11 +2568,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		cleanup_fn(policy_cb_data);
 	assert(ret != REFTABLE_API_ERROR);
 
-	reftable_ref_record_release(&ref_record);
 	reftable_iterator_destroy(&it);
 	reftable_addition_destroy(add);
 	for (i = 0; i < logs_nr; i++)
 		reftable_log_record_release(&logs[i]);
+	strbuf_release(&referent);
 	free(logs);
 	free(rewritten);
 	return ret;

-- 
2.47.0.274.g962d0b743d.dirty

