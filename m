Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A341DDF0
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580706; cv=none; b=up0ap8DRtF2MhYzqwidN24/oo2y8qp3BI4CD5U+f8RyTb7T4OZvO0V/ehGqdu2IiYsMnUBE5E4IyL/hxNCqHyF+s3Ipx9vkTzDTaoOtY/bYYxSmwaKiHcWqpYkVk44r6zIi0atYpKulSoAiXR/BrfDj/RYdpJM+jjiv50tFVuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580706; c=relaxed/simple;
	bh=k1IptOeRt34VwWakP/5Y6z4Atm9yQ1f06YMKPM2Nlzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QOlU5kQoOdl6125L3B1kEfgb0QvK37lZdli6kfCn1pfrZItfCqiyiifRSeJPVMavqlAABoJa8XcVvlG0VHodQChaq4eJuMSgS/mIJK/LwrUeA+8+vMYVVJZLuY2MqwkjsHQUv7QWIf63o+bcmpsoe8nHnhdkUtFyssXJcFGIAes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mRMXwCy+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y1GEP8+3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mRMXwCy+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y1GEP8+3"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A651EEC016D;
	Mon, 24 Aug 2026 10:11:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 24 Aug 2026 10:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787580703;
	 x=1787667103; bh=LDb6w6uy1BUcT0z9NXbpn5vlkif4Lq1SMQ1ZX1qaDp0=; b=
	mRMXwCy+AK5wFBbVoz0kCb4zh2NMy6fcYqsCH0s40SKQQR1WENH7kym+zTgcd8Gd
	fQwYTilHBwuyB4jM+sFWSnkhIV1RX1cqpz/cntndH/9DpXI1SS8eLSKxC7CHgzfE
	f6T4d4MZgd+JyvetcDthoeTck0cXbdi4fKIXpv5TQaaDiIXHmZyE6/GslvgxKPOe
	VSI1luYg6IA9n4HR0cS9kEhKAbrMUKeu4DsFHq+uBPf8U5qhqTQFu7NqpW7KvQLb
	k0fBVvheUHgz9iKy2/+yCrBnHsmaquxLySS5gxFmj68dpyFr4LKuMyv5XZaC2+/O
	fcuJk2w1F0Cix1JDjAtDWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787580703; x=
	1787667103; bh=LDb6w6uy1BUcT0z9NXbpn5vlkif4Lq1SMQ1ZX1qaDp0=; b=Y
	1GEP8+3V049HHCBcgh1EPHZJB2sIyczuWm6qUH2WiufTYCd+/s+AzMvl5EUwXTao
	SEHGeC2E4CQhMVamv+VVAuQYpnVSWWEeMPbmDQk97FHPrtLHmYWiRVcs0HxhOMKF
	c5el/ACKltPfWYnXo267Cxf65qc39VrCXDCVD3qadU5du9jC5mi26fjjQuLfiA2b
	XtmUZOTywXWnnCry6+XnkyT/CpNzmOIDexloxE1zD+aPSNje66dq20y5KGkxd7rE
	m9GEJBc08xKaYrUhza+i3vgyCNutfCitSAViDv/V9o3VflSq+lOIgDKlqsuF2Bv2
	oFPx8iiU3Dl0J67VIkY1Q==
X-ME-Sender: <xms:H1GManvLLl3GDbFHizLdpG1QNlv7M2r7eXms566G9Vno_bcfXBdRiQ>
    <xme:H1GMaqsp7_XYeZ1edobRZfY6BRYoo60iDKH3syvAd2FAHHjDVF3bBtGN8Jn4PBqqb
    EcFDViL2oSOVANm0OPGrhnhtwqYB0D1Uhw0-MGzgKSlaIhilWzXsbI>
X-ME-Received: <xmr:H1GMatA7LDWwByOCMEC0_ZUtJ4j1M1HxPOy4muDu6rG28L-sIP7xCqe2k_TBmeNj_lnC1ied7-5O4osmfE9czvvbZhF-ZtiOmA>
X-ME-Proxy-Cause: dmFkZTEzu7lWAbp2iXuVaIXRopVh81CAYVayMSomYAvjvHOGmzwZac+u09J1/f1mvQEP6I
    Mw4So/eFROrM/hguumZBHYINBF5ABsJWIcGNxVDzWeoI8JvVfrbOGfIBnqzkqbLaXwTNqM
    yD9jZG4oSyyeo1qnHTV8mfawZLw939ZzPvsmktr6pJsRBgxr/JDOgcq5p67HsElXCobP9u
    /77CA/lGRw0omyEAX8l+c6NxdSxOpdkySCpuqg+50s6ThfHv49xsDqtigFv73xmnDPWHYG
    TX82AFYTFDVeWnCbisAQhkVrZBkDVz7UyXgF0KfPdPbaw6R1WrtwmixQjSGGZEI4ppdBVp
    VSNbHJ9B5r+c18EI74YP29z3LZBgox6alyqKID3L3eBQwvgll3psLHxZa7spYRxzoQ+0Qi
    +UU1b9QAB7V3xkWj9C0yxnVItkMxtLtnNid4XkGRy9bLNgAtEkrJyWxvFgUPAT58Vb5RGD
    Lid2Q1NGbs2lkdZ58H5NVbkrG2Xkq9TG7ZnPvPFcgS34i7o+VQjq6RViwfrLdEmUoCOCmb
    uS+iOTZG/JUjrF2VaSxUtYab3CJe1IzYUHYgOEgwZhiD/bnIxCmP5iqZDRzkvWRYi5ciJV
    fBsxlHulc5viUIR4/gBYJcJ69M4/siPbeJ1E1ESdRSsw2OFzaupFIRlqUGiA
X-ME-Proxy: <xmx:H1GMasPFAXSDU_wbcQ0SUomhZHHd-Wwq6y2voFj5aKKUBBXn9QNj6Q>
    <xmx:H1GMamw6563IdJycUYypNdJXulyItRgDGV32KfNi-IKjCEzSdZ_mng>
    <xmx:H1GMasVHzp8SxtD5vnOGzJ3h9_roHAQ8VpPeo-6KHQMJbfm5iNM1Hg>
    <xmx:H1GMaoPoxdIR1x2R34k6HcvekMdEl-P-PUjeHhnWTSj4usrtGr2lDA>
    <xmx:H1GMaiWZgcyhJjaH2A9bRPP0OkWbDATzRBYQFkHZD1Th6hnl0tHXxZLQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 10:11:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Artur Bieniek <abieniek@antmicro.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Koji Nakamaru <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Artur Bieniek <ar2rekb@gmail.com>
Subject: Re: [PATCH] pull: add --hard mode
In-Reply-To: <248fc3ca-7907-4720-ab71-1cf5926b82a0@antmicro.com> (Artur
	Bieniek's message of "Mon, 24 Aug 2026 12:55:08 +0200")
References: <pull.2384.git.git.1787052873141.gitgitgadget@gmail.com>
	<xmqqwltn1o4e.fsf@gitster.g>
	<0c2607e2-16da-4efd-879f-82ef2c2aa127@gmail.com>
	<xmqqo6ewsrzd.fsf@gitster.g>
	<2b9cc581-7c8e-4cb3-9524-2b466209ac7e@antmicro.com>
	<fa62cf90-61ae-4352-b823-455ccffe403a@app.fastmail.com>
	<248fc3ca-7907-4720-ab71-1cf5926b82a0@antmicro.com>
Date: Mon, 24 Aug 2026 07:11:41 -0700
Message-ID: <xmqq1pbntxpe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Artur Bieniek <abieniek@antmicro.com> writes:

> If resetting does not belong under pull, would the inverse design be 
> more appropriate, e.g. git reset --pull --hard, meaning “fetch the 
> configured upstream and reset to it”? Or would making reset perform 
> network I/O be undesirable for the same reason?

Very true.  I wonder if the feature of git you should be looking at
for doing things like this is not "pull", "fetch", or "reset" but is
"alias"?



