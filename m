Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC942B2D7
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879560; cv=none; b=m9YVWUGkfNnUeqqDw0zQ6+9woqDLZdltEyaZ+LCX3C1pIvPUJp4HlOeLiAZrqKFQbE376yG1hnYOlUN1NJisykjIQj+Y/eANrsScHQw4dmhXbea/RKTMG7a1wieYIj4+Hm8GAE/sTfvC7n+TAviqpowICWJvZhC0oscQhz9N3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879560; c=relaxed/simple;
	bh=eZsa+1ZZ0/FrPPBMmO0vum7o5KwqIC9Ja+eXOwy5xS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QH/a1C1Feunm7ywbcONvKqNrJRxe3EsRLlL4pBdzL3MCtP3pzlH3ockVSDcI5ecGowU40QKbNm7U8xGnduFZ6hHFZMPX3/MwZsdh6h+tlDhcJ2vDFhY9DebxFIqikhlgC4bmTsGy7FUMSsEbqyllSF+ra+elJmhDqh5OPdpwdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Cis/ni5I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIUQosUu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Cis/ni5I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIUQosUu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D8E3D7A0060;
	Sun, 14 Sep 2025 15:52:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 14 Sep 2025 15:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757879557;
	 x=1757965957; bh=q827zpBv2qB9WWMaRo5oT1NyY0yqxbX+4MNVjfzk6oo=; b=
	Cis/ni5IfFrRPHfVKPHMxxn758DdUK8ll6JpzoC5PxZwtV3zuyvPBVa492+/f4sD
	DObMRPGV1Hcx+kQP6Vd/lmhy1y73xn0osAwPWi357c6ApP9xmA+GLkeYXGk4MCOn
	I2CKGaFV7bRXpsFudkTD4YDqJMJCxShhQ35cYzZIAHdCt/a7kPzJ7hA1PZgEm1KF
	vINx8tKQHdUqt1KLDcsn12G3lsfr2GWic3siWZLUWwzf+bMLYNepCHaKNuYv4qyM
	SNqg+j+t5ydAFKlXOFvwMayPFOlO4BNfNodp+uVk9cCOEtfTbX8Y6wjeRABI8Iy+
	vPVkPKCG6XwgzNb7zCjywQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757879557; x=
	1757965957; bh=q827zpBv2qB9WWMaRo5oT1NyY0yqxbX+4MNVjfzk6oo=; b=e
	IUQosUuSpdp6CNCM4ZCAJ2CMjuGzpJYbq1Y2dt+VOuWn8cnCMO1+0itQhsMn1bri
	bx1mV4aMBu/Cd3nnL6rBv3Dk4aEIiVAyhbn2ClCAToJqmOTjFM37O3MpLnou3Fkm
	R14nAmwNoCrqdkJ25AgtBVNBVoiggQOvdMAlTC1jZAIxd/BGo3aZUbhd7SlpmYmv
	gpGClJSMuoJTYwBscytRrPMTdR1Cjz8JIc/bfyA7xMhscMYKvc80n1upJ9tZqpQS
	kKzCzL7/y3slLMa/TOV0s/5GHZ01uV1duU438oRTfKtj4febwZihNRiO1tUWte6V
	JXICU9pMnxt7DajVFJ/6A==
X-ME-Sender: <xms:BR3HaAsYcY94GVN1GhoWuLCN_2btdf-KUO2w3DvlgyKq1ZV2uSbM9gw>
    <xme:BR3HaF55qKvOg1Kf673wIv9xY4FTRe32M9SlMGt3f1cx0tUSY0qUc6S4riFAkAX2K
    Q7Ks3rc0KPuGokZjA>
X-ME-Received: <xmr:BR3HaMOQW77lekizhMjh3W8fq6nZcHm9alc1dFtV-zeB7EWx5vKAYmI1eEeBNr_mcAsvU4wboopDc8068fIxCsg5A7qwNAHC4cFg07qkW1vR4SZG8w-Cq8kHrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:BR3HaDukRUVZjasFDfu6mnYQMkXD3QDmd45HHXqhc-rpSbK7cd8fiQ>
    <xmx:BR3HaPYNyC8UE1cvqBj0-FNGP-zmxuLEeLALRdWVjduUnsK36ToIgQ>
    <xmx:BR3HaFxsiVVfbr1OW71zYEogBvtqWPPuDKEUQw2mCjkN75J6mJsUpA>
    <xmx:BR3HaHjPe46dD-Rozuv97ESI4xM0zuPvo1aoMwrPX6oF7SXsXkr85w>
    <xmx:BR3HaHHrqxejab4csl6f4urPqqb9h_XknTlW7667XYoJcEVNjN6VF8A4>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:52:35 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 7/8] whatchanged: remove not-even-shorter clause
Date: Sun, 14 Sep 2025 21:49:41 +0200
Message-ID: <b0aabd793f05e55193891b31485e4113e069109d.1757879060.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757879060.git.code@khaugsbakk.name>
References: <cover.1757446619.git.code@khaugsbakk.name> <cover.1757879060.git.code@khaugsbakk.name>
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
2.51.0.16.gcd94ab5bf81

