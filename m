Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865613AA2B
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530926; cv=none; b=NAKp5mxO9IMMqz9JMdSpPaV4PYr+2aTzRoAHpmD0PFeKYRgYYbMBMM8tpJ+ozZHR8MBmjJFs59XrlFEQ2z7I4dyOj6IvDN9MVs1cizbDNGIRUDKN/mLEbBk5tA7LaQnD4Oboml5SvIOMfi9k801nEcg3B0MvKqZ/LydwQqp54p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530926; c=relaxed/simple;
	bh=63iXi3RlbcS7LLK+SZnZtPzbuAZ+oqm7Kmw//FFFVyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opt/X9B63QF+FDS9+8h59aLEbF9/aAXhYuhNblMgh2hHJPJOh47Ps5Hsn9j2Bp33RiJp+kV3g4RMZUseW7vG5mKwmqnHMQeWHP2/2az1vXdGYE4xnVdjiwG/HqKVLerTNk+IYVFeGUDbxXhnWI+Y6Kggic8CjnazhIZfWFCWKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NsIEfgKB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KTX+Y6y9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NsIEfgKB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KTX+Y6y9"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38FFC1140265;
	Thu,  5 Sep 2024 06:08:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Sep 2024 06:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530924; x=1725617324; bh=HrD+6UAk08
	MaoGQtpSY8lxshGKKgOVPAawhHHoV51sE=; b=NsIEfgKB/Ks9ZMcWT6FLelq5Q3
	Ep5lHFA+YqtCigd6upaEIFenYpr5Y9Iff0lb/bogC9kH+1PxgCCyQmC9ojLn5XFJ
	7BlMEzwewco9C9h5AI1yj2e8Q4pOw4cQPynGren6BKI7M0AQEQyZEatQ5FbMQBAc
	7r9N8J6aF2uHS0e9VJg4WZ3AwokjATRJqdjsWmfReyhJpoaeJljkIZik3jNYdUAN
	GoYF2cAhQ7OkevruG8akGS4b2UKZ2Qi5qOnAyFt9fZl6PedzEi35T0xTeJjo9aGX
	AJLQswxS68oiiBY8XZ1zRPFl+g5JDNESuJOfFEKQWmp9aOpvNodv1UsPczUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530924; x=1725617324; bh=HrD+6UAk08MaoGQtpSY8lxshGKKg
	OVPAawhHHoV51sE=; b=KTX+Y6y9ra/3f55j1bJ3fqh+xzlkz5lOSUZRPv3c+OWD
	NLMxcB0xVR/FIuF8zJpO7rrT6xUMxiyZqN+2+mgbEC9x97YWUaFmiZolXWrEqimg
	M5aJwPD7ruokFaUF9gmNmCEITSCw3Sg4r1V9GYojc43z+XqQeAR30hKVcSs3+tdz
	N6CmvDMfq87s0X4zcucbVOvcuChhfEr59RKET+lH02Zidb5x2WaJ6/nWm29DzRt/
	X7k56LeWrW3QLDlTaxfp3Ckxpds9SiRmxOcmYMOg+R8cY4n/YFkG9fqhGvG2uLMR
	yinxQhG4OJ0dHg0LI/agmBhyhJ+zgJUAYCx8N3+V8g==
X-ME-Sender: <xms:LIPZZkpA--q3hY2MNP_lzmro0xhWF94CCJ3H5k7w88fS5ivitln9dA>
    <xme:LIPZZqr36oDQLv9LfXCcQZlzlaZK-ZQA5LFn2SYx5v95frCqOlzJBVaGPOOOrxu1s
    v4qbDddNmQkC2evpA>
X-ME-Received: <xmr:LIPZZpOHprKHp238uv4rEilt_lWyNOHXbMGm4stN8HETCj6iEELr2EKJ_pBbQxjq00MOmGJ5DwgrSJz1qf7q3754WqP7pHWWLYS4e0cg2DxiI9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsthgv
    rggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:LIPZZr43HWm1zFqPnaXN6VDtEE_ZPuhDiizt6lb-gwNWV1COaqT0nQ>
    <xmx:LIPZZj408WSZDP3FobRzreVA8BX4m6z7Gfj3blsf4gFeARLrAL8YLg>
    <xmx:LIPZZriOsR19dNAUD_7qVAGUJwAfCKGO6yzaPM58jlCSBIv-MLyH6g>
    <xmx:LIPZZt6lEL-fyNBcd9ZJv-9SWUttd6FKQUaRvR1IqRClpXetwtbGGw>
    <xmx:LIPZZgtMQS0IjdPWuu0b961Dyzg-ccxCdoLtCS0AeAP9C_wQ2sv4bz8u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:08:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a359f351 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:31 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:08:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 02/22] fetch-pack: fix memory leaks on fetch negotiation
Message-ID: <611a29d1ca30759b7c91597a580d93578382955c.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

We leak both the `nt_object_array` and `negotiator` structures in
`negotiate_using_fetch()`. Plug both of these leaks.

These leaks were exposed by t5516, but fixing them is not sufficient to
make the whole test suite leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fetch-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 58b4581ad80..0ed82feda14 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2227,7 +2227,10 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 	trace2_region_leave("fetch-pack", "negotiate_using_fetch", the_repository);
 	trace2_data_intmax("negotiate_using_fetch", the_repository,
 			   "total_rounds", negotiation_round);
+
 	clear_common_flag(acked_commits);
+	object_array_clear(&nt_object_array);
+	negotiator.release(&negotiator);
 	strbuf_release(&req_buf);
 }
 
-- 
2.46.0.519.g2e7b89e038.dirty

