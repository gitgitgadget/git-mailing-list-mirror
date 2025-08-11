Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B62D47E9
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927799; cv=none; b=J1svDK2nbLG/sHrut41slz6dmRRDYq0mehvwXaIGR+I+9qKA/H3TL7oHCgrr9LxSBhQrmlDBKDy61J7QvY2p661e8epEIVj2SFtWzDobU4YTDyiDQQ5XRxnZOQ4TyWNcrFXzHVz6GkyEie0nzmBCgF0v2rVsnetAIrc63WVJzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927799; c=relaxed/simple;
	bh=CObwfjEmq5CUvt5fcIRIBnc59gXh20Q4nt1BaEJyfbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wu2WTibcAM0KtqOGOnTG15WeuwkvePjsHvlPwz5goXdQOWRjR9OLNdvo/27pHeoHAtWC+Tz2LmeRQEapwGyryZ7esr8jlICjSvkXbxP5q8bk7n6JIzdhDsL8SRGsFGZ5+e6TDNJqCGjFOyIOn2JAbuCLPBU3gRP2Kkr84WVk/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f/yOKg2x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PDS1y4+h; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f/yOKg2x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PDS1y4+h"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C60E7A00C4;
	Mon, 11 Aug 2025 11:56:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 11 Aug 2025 11:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754927796; x=1755014196; bh=EikRbYXhR8
	R58arYBWUkrOCPVuYVIeQsO+eqyOWp6ts=; b=f/yOKg2x/H04jPfHw+oyc/G2MJ
	zDGSARP+FVUd6+NX4YdNKDYxVhZthjMP02oDjAfBwlDMI6cYrX/EHD+t+eLylTpD
	DV4LwIxO9QIzndC6+ObEXTYdNFI498Xz9dfr3mmHQHlV0uNMLoA4TNRhy3+ANZdr
	8EO41SYMsfo4hBU5l774YDECJmqCwVUUw+a5T2FFdJ8AhUnW4ujzADV3piKEb9L/
	WMdEzxJYi3Oj9Rjm0aBsPEUgGpKEq8pzHuS3CEPfvvxK9iZNZFEXUQxxlIQ0GNHc
	03MAiadCDxdDfO9O7qihIAN5px3CrG1jlZxCJ0rFp25s/BLbTARJCDoGLCIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754927796; x=1755014196; bh=EikRbYXhR8R58arYBWUkrOCPVuYVIeQsO+e
	qyOWp6ts=; b=PDS1y4+hZubEyrn4jY6UySXL5bvD0Qya33oNyP3BbbdcgOW0UGV
	Qsn916NABt+1xGLf47u2sKgVMltMQRp0vkuDhOfvkrrz5woN39uPXw7xTF0Xy8Pk
	na1sC7nAkhMiBjqf5m+b50MzzmhdoadGLo1kZ5+aDcocXotToDIvegNU+z06ZmxZ
	XunYqcQNGUa2Y0ESzIPhhUNbEZ5dtrEI5ewEJaSdGVfuLhgFZn6pw5TxXvOM+OTX
	Qr74z2grdnEdpxP0HmeXLDhB/ipbw3TMCOWtmYBBNEQOV96SofYh74uWSOq8UMMb
	8nwU7OzYJcG9eSAocWblnvPdpq+Qi/ig0FA==
X-ME-Sender: <xms:tBKaaCwk3gYzv-pNBRWKg8A2jQIzBsNLYGDsUpMl9HAGhdFWGEKbcA>
    <xme:tBKaaJyBt6TuSfy80kbtUds4tTKeejN8ursLaU1JcU3AxPiuaP33HXPAyodKy-kgN
    kqx7LFtONGt_LQcSA>
X-ME-Received: <xmr:tBKaaKyBBUrMfJMsvKOz1rtkItf8Ce34Ah1phFJuWK4sIxnZK6mT_YDXqRcDWgbKKCo9imIyviDM1E6GGJmYPkYxNtzuxcg2SB9XBNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihlhguhhho
    mhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepthhtrgihlhhorhhrsehgihhthhhusgdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tBKaaDZ7fl4JNN2k5zbO3l_eC3aEgSapKcBsPWbFVkFbnJ803JsKAA>
    <xmx:tBKaaLVTUUxqduswAgrHsW4vg6RaYtkXb5JjOHLCoJuwnda-3HgyWA>
    <xmx:tBKaaBiK6gYw4-szj35vYz7EXmvvUElnQwa1GgyCcpTwPSe0zChGJw>
    <xmx:tBKaaJudf7_uuod4SM7Wq97Dr2Ha_K3JSF8i4ZV1HeGLgV6DVPhZxA>
    <xmx:tBKaaGmJvAyghXXHaSneiXimtzB9EtsHNnpPvhvZ-2EWxU1foT7Zki3d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 11:56:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  ttaylorr@github.com
Subject: Re: [PATCH v5] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
In-Reply-To: <20250811060137.75135-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Mon, 11 Aug 2025 14:01:37 +0800")
References: <20250809042236.72695-1-yldhome2d2@gmail.com>
	<20250811060137.75135-1-yldhome2d2@gmail.com>
Date: Mon, 11 Aug 2025 08:56:35 -0700
Message-ID: <xmqqy0rp3l8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
> [jc: avoid allocating zero length path in
> convert_pathspec_to_bloom_keyvec()]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Instead just do

        Helped-by: Junio C Hamano <gitster@pobox.com>
        Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>

here.  [who: comment] followed by a sign-off from that person is
done by the person who is signing off the tweak, not by the original
author.

No need to resend; I'll fix it up locally.

Thanks.
