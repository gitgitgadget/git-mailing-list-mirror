Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE02749E4
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140871; cv=none; b=khHzZ6+XK+khOYVaOnuSVFc6SuOYg91NfLjJLiTWO3/aA3A6OO0z0FtFZ6qb7DWJYoQ+4vVeErYTNCi/K6In9vegamTadlOsON3II82+3hjpwTPkBWqSMygasf/evQ+7jf3Z4340fUfXztX4mtxezqSuKg16agt2RGn5FS6OIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140871; c=relaxed/simple;
	bh=QH7Tc+f94aPjTl/HATmfka8mUkOCzVkoHhjH4gO0FIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezHXcNxsxB8+2Ti/FcY71EMKFjOWwifxquGpD+Y9MqGN1bzHyrcQvTrVEb4R3OG31A++zJ+RC2xTZwyMgEbL48Szql+cs0U71gAtXdoz9F3WRA67gLJGcf6O+bZcxk/yUjGKAX49qQai2ViMZ6SjQgDgAkxUmWEk5bbTZHoG7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=g0dw7FUj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GfDWao/A; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="g0dw7FUj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GfDWao/A"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B5098EC00E3;
	Wed, 17 Sep 2025 16:27:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 17 Sep 2025 16:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758140868;
	 x=1758227268; bh=tn7f5ds64FumKijQYdQrXI6U0bRN/jxMN+ChDOAJMGE=; b=
	g0dw7FUjUSu5ZZZSqSOlBYmuHKv1dbmsXNLpmsoNJvq1CnzyHv2UHRkm5LkMeVwb
	dWV7wCZoB3CnLVkh17IUzqd0mDHVGC0eiKSIj4gjp/6cmd7jHYv0U5laoqH1kkxY
	g9kRF4k7B/egHXJcUMWSsiOsxzi86PslVskkH/RepX59llfE+BVEcR+8nkk+r8Sg
	lfp+X2WMUDqqf5BvX8h5MhKEPRPY3Qx8jEAy3VnDgHK/OFjFegrLCzPsQRAxffhJ
	x0z6flDyY3+y2oVRW5vSOm7TJM9Ad5YU4kMJqXVyWDOH245CjY27xAL0I1l/QSV7
	TW9efnyX+4HOM8rfX34qXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758140868; x=
	1758227268; bh=tn7f5ds64FumKijQYdQrXI6U0bRN/jxMN+ChDOAJMGE=; b=G
	fDWao/AbLOaGLh5yGjGPNogfe0gV4DfQnCQCOnCEB8zxhCvlioKV1sno1cyOl+/u
	LR8AzO425BJCmWOZUZ9fKSSDGGNjWW2wfZsAg+QLyiMqDuLIuTOw6UkykhYwaiFw
	+2jY8iGWa488VLJdy1mWwUu3ajmke8Q53HAVgSk/QEtdrUI8IJzx/95anUe5V+G1
	Txp5TelOKqYtCQSvhVTx+5gCwrFDpbW0eVKAkUumKnYMNusREBybf2SpTR44ZEOQ
	so5fxIM5W1XDSZi2kOYvRxJBqI1fZsQphMFNYuwzaLOiaTza7ylDrd+3LSzIYw1p
	t44XMY1B2mwzhwRyBLnRg==
X-ME-Sender: <xms:xBnLaEyvlej21Q2WwBH3orfR7-OzNUby8XWPMF6_uQHfYpWMmMFX3vA>
    <xme:xBnLaAtGDU57Qn_Z1_VJrb-kL1cRe3nBe6sLM8JK9SwbzHgZ2fuhC-T6i-VtKyD4c
    JLFx46h2PmxUl_Pvw>
X-ME-Received: <xmr:xBnLaGwkpii2exXYfO8Iy9xsm81Pf6YUogXRUJ0TFvamSKuwLncpQlJVqxHuF3IdxFoRh4-2T9KUsXlE0ZPz6fWSogdKFzVVZGvwBa_Z9iuSrY_izWnnBlQFhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:xBnLaDBZfDXd1VR9dK9KwAYS2EKItLVDmZNoEypsvDItN3uqJF-Oeg>
    <xmx:xBnLaEc4g-WkvGrKuBoXSmWuk0mdznbMfzklOHPNWLWlG1MECvhKjA>
    <xmx:xBnLaNk26x5Vt_2g44UGUs2NNe-XRj5ItcgVFxo3quzvTesXBBLi9Q>
    <xmx:xBnLaLFURzrUWq8db8PUKP2-WyUsY6n0dlcR4zOhj2W-BpsyA-4WPA>
    <xmx:xBnLaJIIeFzyBK3_yPoirBixAjruoum8LxHUv-vjOLEOL0We_OhRrHCV>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:27:47 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 8/9] whatchanged: remove not-even-shorter clause
Date: Wed, 17 Sep 2025 22:24:18 +0200
Message-ID: <2f281.1758139856.short.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.274.gdcb64e51a0f
In-Reply-To: <cover.1758139856.short.code@khaugsbakk.name>
References: <cover.1757879060.git.code@khaugsbakk.name> <cover.1758139856.short.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The closest equivalent is `git log --raw --no-merges`.

Also change to “defaults” (implicit plural).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-whatchanged.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-whatchanged.adoc b/Documentation/git-whatchanged.adoc
index e71d2aa2d27..436e219b7d0 100644
--- a/Documentation/git-whatchanged.adoc
+++ b/Documentation/git-whatchanged.adoc
@@ -15,7 +15,7 @@ WARNING
 -------
 `git whatchanged` has been deprecated and is scheduled for removal in
 a future version of Git, as it is merely `git log` with different
-default; `whatchanged` is not even shorter to type than `log --raw`.
+defaults.
 
 DESCRIPTION
 -----------
-- 
2.51.0.274.gdcb64e51a0f

