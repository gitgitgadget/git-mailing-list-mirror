Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E671A4E96
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354900; cv=none; b=iWOTIPFEVZD39Lb7V0DtBrCgpKhbQxz6oEHWqZF4PLkM1Mh/fGp4nGIp36Ufzkr7UghrToW6ouEW6pQ9AElGrbU3a+ersYJZOshCWGohnAuRxQOLkUvxL6kV+OFRuGGPAQ9+Qe+dBV0BEZzoP7Kbb+pzbc5SGtpTlqVAHZeW9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354900; c=relaxed/simple;
	bh=N1iuBAmXm96AHC9Av99fPm2lzo8XJiR8jvzCPunq2JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqGyZGAmljnzvZKXJzYF7BGi2OieZSX6hypcwZomDTber/vXBP5Ak7P7ooEKmWb4gAL9T+rporadc9bHmqGt6fN9/UnR0PQgCMF+ElEJeywV/R7Gnx3JNWnWnLEY8NP6F068BIkMTlFp3ULFHlfVDpZog1610BNocn0W708kxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PSQ90Y3A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1jP+Ibu; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PSQ90Y3A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1jP+Ibu"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B9B81140297;
	Tue,  3 Sep 2024 05:14:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Sep 2024 05:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354898; x=1725441298; bh=Rx2HvSsWxg
	4VXxW0K1EJ+rcAzPv7jAfJYUAhdmtjFdc=; b=PSQ90Y3AmZcpP6xN0xLUeBs9ad
	kl79VhkUOVeuN12S8ZB4nSNqdKxsK8K6cKvRrGITCQyzpjmVfizRROsYjVI485Vx
	6Xl0xT4M1IxSi8/qkZ+HdYPmrpW+RvJIKx9z5HF7FHgXsecwNhtW2Kw4yOz8+HN8
	G71cn+IDzqfqq5KgULpugEZFRHCW+k5PLq99ajovNcbn/zPRnqi6WYJBsrOkFg7g
	o4GKLEfSeJvRfjOvStMvdAKx2uCLVhvxkwWrZ3PD9FmT4C2xOxxG7+LHwjlo6xLD
	AONNKFPExO3EFbvaytZl5qDi755ZXyFARYnj/nWqUVKz0bcIpz8wUKwiS8vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354898; x=1725441298; bh=Rx2HvSsWxg4VXxW0K1EJ+rcAzPv7
	jAfJYUAhdmtjFdc=; b=H1jP+IbuKROYswrs2Q5rQvNEuHmVlhlJ8ZyT79u/TN1+
	ou9tZqlHfIL5nWWFoceErWt8hDFMvPJDEarqF0P5VHIh4g78iezfRDTe7/Nn5ysn
	coKyWUCyPndjTJSFbyu8y10M6ywJ1Zg5HfV/YMLytS7uYuumAM789NdQJgWGcJaJ
	mMnIxBo+77R3RsQEnzIigrC8mv8zy1Z/QS+E+hToV5YVW9iEE8TbEWksxhbskgO3
	EqiP4giqYGhKGdZ4lMg/J6/oyEJGt6OY56fX921s+/+Hrbt0CbygUF2arkvP7WoD
	GFNj7PjtvZ/attPEjz24gPGzj6xPJWDrMGSuMDRsUA==
X-ME-Sender: <xms:ktPWZqX8sP7aVMDv2_qIFJEktcDx9FF_LoR5fVbKfjhjUpmkyuzgew>
    <xme:ktPWZmnsaboZwvuTSJqhQTqI8IIA9E-1z1-1I6Gf-IODKe3VJHWfIdf0jjB3_CjhU
    fHxg3ixCLzPTYUXaA>
X-ME-Received: <xmr:ktPWZuZWrH9IrkQDQoH3zsyy6uz0N0Zyz6ZmndZ8Pb3-9nK0Ak2IC3QWx3BcJVKjgonBV20fgjqc51O31UrEiCMHBvr6yHkXhMOFEfb5HzBJGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehphh
    hilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehlrdhs
    rdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ktPWZhUQXwcZeQc9IqUt6YObS6Sha83GBlR6BKmSAc5hu3XJ0TjxBQ>
    <xmx:ktPWZkl7jNF2ccIWaFolG39gpkjQNlPhvz_vyc7TmO3ZG1aAWPm_-Q>
    <xmx:ktPWZmewxuXeUW2r1IJl8UXZ8gFaDGJmcojuZOelMRQiKZUw8PbExw>
    <xmx:ktPWZmE3p7sXPCgG1h2owoIBPRbaaHk5qg096mHY96uqjh97SEAMGA>
    <xmx:ktPWZhhg3OMfyEJwaMrw840nlHXqjI29G6J4VcT5JTgL3Zvit8mpx-kB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:14:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 35838468 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:14:49 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:14:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 07/14] Makefile: fix sparse dependency on GENERATED_H
Message-ID: <b8f3f16dd2776b889922f7d07ee5d448268fac65.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

The "check" Makefile target is essentially an alias around the "sparse"
target. The one difference though is that it will tell users to instead
run the "test" target in case they do not have sparse(1) installed, as
chances are high that they wanted to execute the test suite rather than
doing semantic checks.

But even though the "check" target ultimately just ends up executing
`make sparse`, it still depends on our generated headers. This does not
make any sense though: they are irrelevant for the "test" target advice,
and if these headers are required for the "sparse" target they must be
declared as a dependency on the aliased target, not the alias.

But even moving the dependency to the "sparse" target is wrong, as
concurrent builds may then end up generating the headers and running
sparse concurrently. Instead, we make them a dependency of the specific
objects. While that is overly broad, it does ensure correct ordering.
The alternative, specifying which file depends on what generated header
explicitly, feels rather unmaintainable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 28742a60964..efd305ab358 100644
--- a/Makefile
+++ b/Makefile
@@ -3254,7 +3254,7 @@ check-sha1:: t/helper/test-tool$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
 
-$(SP_OBJ): %.sp: %.c %.o
+$(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		-Wsparse-error \
 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
@@ -3295,7 +3295,7 @@ style:
 	git clang-format --style file --diff --extensions c,h
 
 .PHONY: check
-check: $(GENERATED_H)
+check:
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
-- 
2.46.0.421.g159f2d50e7.dirty

