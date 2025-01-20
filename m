Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA31E5710
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389851; cv=none; b=ds9hhsjNtc/4o9yuAhGS+k70Un+UBG9gsd4bDnZ9Xg19azg1NQEZHGn1lp6yzz5bjFKdneACQUKglXLpMBE01i8p1Hjoa14E7sx6vo6U/8RTWdlxjlsbDJrEa47uy1QS8u/tBWh9HoAoRos1PFk9jb+ph8qQp4SGHKUnGjqE0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389851; c=relaxed/simple;
	bh=MWlPFfiBpAzkeR0o6hnl8YcAi49g/OO8o5/uZf3PM+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UeIwAOwKFdYV8LAb8msswmEY2FYWoFXoYB7C24TG2atYTLu/KL+WfBl4G1XIQDKjQkmpeGq5ZGeI/rNWuYBiPGwBoxp0i9O+dagbJJ7m7Rz1we7FVaRZqHEJHygb6W+LnfWWeV0ptld5fafK8Uv0CWZkKuF0FqiB9K5OStdBFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fDsjlmtZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NnJpkzKD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fDsjlmtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NnJpkzKD"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51C10114021B;
	Mon, 20 Jan 2025 11:17:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jan 2025 11:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389848;
	 x=1737476248; bh=G8HxpO2ahXyXxrAWidSkaMlkET8k8/rI1blBbt+aKKM=; b=
	fDsjlmtZP5Bp6UDUvj/H5qRAKC2tQdjTCRPx+CL9NJ7MZy2vxzspro2F+t22Wepu
	YtgMPMg5xDyyUogteZeHqCiySvOa3UMdZBPwy63B2Vic7Mp6S55dNAETFnQcA6I9
	WmtM8sAqkbvjTYj8GfZx71DvH5Jc9AeZC3wsijp6Osq8OE9w0rM1dMkQJAP6RLU0
	BcKkCjQDCIn6+IFOEZawZwWG/hgvBbu8xT2FSNM9GgYRyDXXU9lY/IsY5f5nDgx6
	blaBe59/7YKC/ae3gG9iprFCaeUIBDpX+rFa+INaJ3Sy+ksYBtRKXLv+zxqnFGTZ
	iE8lkx1Rli2CKNdcklVewg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389848; x=
	1737476248; bh=G8HxpO2ahXyXxrAWidSkaMlkET8k8/rI1blBbt+aKKM=; b=N
	nJpkzKDS4sG9UX0JIbJqM9uPwZZyddOtESXDeZq7jCmEUA5nD0q8msYM+PpU/3zL
	FYaQo+Axm7nI6oi48L2dVuLtBuo1HgrLlB7hfyND0CIu0no4APSy37GXcin3gOYF
	qayiPPlZzI7QFi6LauDegTyN6Z3u6R6dxWN1sDgWHwtdHM465RBjaYlUYng9ssS2
	3tzb29SDCTXKfjxMmiOTTDkR/ouhedDPktHGO8boLqj0QBjH/26s1h8ekhfDReP1
	r1rFgbSglcX5EgvUImOe6q1O8/y4k0zVRg+5V2DEUVyFFdqtMtG3oYpPM5H2S9bL
	bE8iaiC1ACfopB1n1v1gQ==
X-ME-Sender: <xms:GHeOZxmwcrKahFj0Wk-_mvh5X7aZSTVokdXYSgRucq25BmINO251xQ>
    <xme:GHeOZ82MDVJEPFi2IcCxhaxs5636iGHXQR_odhiy-rSl4MAdzXkCirIR2U_yVGCDV
    ytuB0yq1VySPRzwXw>
X-ME-Received: <xmr:GHeOZ3p5oaYuCYB6TLA-VFWExkhcVDV72Q93sFz7xd4_uUHk2GWGf2UWzfahsjpP4QjaCYzE64ANsYkz6gyKeg4v_TUkBLncOh5hQivvy5aqJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedtueekgfehtdegleeukedvkefgtdfhfedvudeiueel
    heelgeeujeetvdfgteevteenucffohhmrghinhepmhgrkhdruggvvhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GHeOZxnBPxO4PY3kw8Q8FfaLMgjt2F1BjVyd6JDyL3jts19ZhINwGw>
    <xmx:GHeOZ_1x8WZkwH7rjQDhGpH9wFaoVkoTTPyb7Y9aPFPelZN8_iX3bQ>
    <xmx:GHeOZwtzWb0nAQq1JIVh_K1or2Nd3jJpjktj4d4GClG3imUGHrid7g>
    <xmx:GHeOZzVvMwfNo7snL8U7_3gSRFpmVyl0CdeI7FS1BaC02JwS_nuPYQ>
    <xmx:GHeOZ9DhR5R-MfLxBiFGmaz6A_e8dwu4aV6AD6p9X07EPswKobcvqi4Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56ba4d5a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 17:17:19 +0100
Subject: [PATCH v2 01/10] meson: stop disabling -Wsign-compare
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-1-b4566d02e4a5@pks.im>
References: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
In-Reply-To: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

In 4f9264b0cd (config.mak.dev: drop `-Wno-sign-compare`, 2024-12-06) we
have started an effort to make our codebase compile with -Wsign-compare.
But while we removed the -Wno-sign-compare flag from "config.mak.dev",
we didn't adjust the Meson build instructions in the same way.

Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0064eb64f5..07744c73b1 100644
--- a/meson.build
+++ b/meson.build
@@ -708,7 +708,6 @@ if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argum
     # These are disabled because we have these all over the place.
     '-Wno-empty-body',
     '-Wno-missing-field-initializers',
-    '-Wno-sign-compare',
   ]
     if compiler.has_argument(cflag)
       libgit_c_args += cflag

-- 
2.48.0.257.gd3603152ad.dirty

