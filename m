Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393BF22FF4D
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886992; cv=none; b=FEO5Rni+3e8AlmILkEVTlPEtDlrSrKNns1v0mbAHqToS5xhje+q/GBFS6okBF66W9iaST4wyFiVg1SkaIo2KGiNEZWyR0xJrCYLQWMeBeO2NMVpFjXiybrq8wdmNJ2ux9PmlIdldrtCv00eHhmjhTCd/zi6iNmA+l0lO4xU9xTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886992; c=relaxed/simple;
	bh=NNjWR8Ep5kQZRFu3QKpVFVlRuLGsxBlAUVce4KV1Pig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u64TjYjKGcFi6/iNU53Rtdcjt3tBfy2Lf9/i8uplr7IXR7gQZd4meiXMcOZO5fGbt1TSsBoaGCQqWint4y0EUV8MlwNZPQPp8jB2Da02hrWC6ejjqnZmLt2F5LwY4UnhbMi+fk3V5dNb2nnUrHkgbOAxa4fPdvsBUKLxyFFkn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MxunD57o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xn2/Khkk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MxunD57o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xn2/Khkk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1DDCE25401CE;
	Thu, 17 Apr 2025 06:49:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 17 Apr 2025 06:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744886988;
	 x=1744973388; bh=WOv37vpHN6idJRD7C067Y6VGLmukg1DfzlkVZu6qpIs=; b=
	MxunD57ogEhwyIJCKL4vPz+fWxhBjZqALeW4qirRgeltTUaHK+9IzK3QCWyVFrPP
	UVvuiyoC8k7Bt3n4M65TZXGCXsnYrJtxQ5f6bQSWcu77/lvDDrRyay8WNhqAJ3vv
	i7lS3lXASYJ2mUHozB0H23grwAlVkQ04rvL6VYRiomTfa7Dg3YSWpNwvuPRlQzsY
	A2a6/Nr4Ep78CJ07C1R3HO+NKSM0GBN+98OGGUQkg/xm08MernUxpNixy6wriEuM
	PQBtbvevKNYCQGx3hEPg3ras6TWX/zxBAujvBKNDK4dnM1aXkT0Mjhf14YAd60Uv
	c3TZTSsAl3NhFivEKwxxcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744886988; x=
	1744973388; bh=WOv37vpHN6idJRD7C067Y6VGLmukg1DfzlkVZu6qpIs=; b=x
	n2/KhkkIkBT50HjBBwSBfg/oBXGepgC+rQ69eLLbx6hvl5hfJKip1esSEjf64qbb
	G5l5TLvjyrdzA8mFiaSVsKTxR1cOy+pkgobE6U/Bef5oe/ccJzjuBeozUMqN5gk8
	ivMBVVVOx8156pl/uvUzSaA4svMH1pUGCU0e46sEOkfJx0HiOm8tL2DJvAl2sEeZ
	hQklFZqEDQo7rNBIgt9eHUefieWO71iBdcuXH3qcYV3qc8C5ENj2zfygwY/lqgG7
	8O2mU/1Ffkdpo0Le3Axo1T2VNb5FgAiKrTcNrYNwuFbd82ZEmJJ8zX7CPa/5ThZR
	yCcirndido3Bhz6RQ0Daw==
X-ME-Sender: <xms:zNwAaIiOdE_mnGIlhm9OJVZlvXrnpJI9wv2VixRRyaJNRViszaLkyw>
    <xme:zNwAaBD8BCovKVyPq0zYjIKbsMk35Ii_GLF0lGnewE_ZkZJkx2apFV2beLI6bsoke
    OT0jcn0SKEsEYtqbw>
X-ME-Received: <xmr:zNwAaAELtpQNlH-4zerPFbIQLhGoB-R0DURFJ2TY7i7YwKP7ZQkM3XhUlxWNDqPmpK5lwMhg1RmZSkc1OcZE_WV0qMfVKj8UDmYiLmFXO6kyhVGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehpoh
    gsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtg
    hpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zNwAaJQBNSc8M0x4wOAJ258OG0mRAnF0DeyhXlcFQrZmINSBIMCNgg>
    <xmx:zNwAaFxosFkKF9bcDGFY5X4wboRtJoisG10mhzhF_4usXDHZEK_PyA>
    <xmx:zNwAaH6zlSsVVMDP3qm2gcMZVskxvcJ57skc7H5oNLImFBBAAmN5KA>
    <xmx:zNwAaCwyxjwV7Urtkp3_ra-jJhiFwHLJTK2xzXuDMuo3EDK82-1LSQ>
    <xmx:zNwAaGGUxr78O_KdYnGBZg091117SVWwthsy8IrJ0Fm03gA8YmYyl8cC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 06:49:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c726afca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Apr 2025 10:49:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Apr 2025 12:49:36 +0200
Subject: [PATCH v4 1/7] parse: fix off-by-one for minimum signed values
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-b4-pks-parse-options-integers-v4-1-9cbc76b61cfe@pks.im>
References: <20250417-b4-pks-parse-options-integers-v4-0-9cbc76b61cfe@pks.im>
In-Reply-To: <20250417-b4-pks-parse-options-integers-v4-0-9cbc76b61cfe@pks.im>
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

We accept a maximum value in `git_parse_signed()` that restricts the
range of accepted integers. As the intent is to pass `INT*_MAX` values
here, this maximum doesn't only act as the upper bound, but also as the
implicit lower bound of the accepted range.

This lower bound is calculated by negating the maximum. But given that
the maximum value of a signed integer with N bits is `2^(N-1)-1` whereas
the minimum value is `-2^(N-1)` we have an off-by-one error in the lower
bound.

Fix this off-by-one error by using `-max - 1` as lower bound instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 7a60a4f816c..3c47448ca67 100644
--- a/parse.c
+++ b/parse.c
@@ -38,7 +38,7 @@ int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 			errno = EINVAL;
 			return 0;
 		}
-		if ((val < 0 && -max / factor > val) ||
+		if ((val < 0 && (-max - 1) / factor > val) ||
 		    (val > 0 && max / factor < val)) {
 			errno = ERANGE;
 			return 0;

-- 
2.49.0.805.g082f7c87e0.dirty

