Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983938E134
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094631; cv=none; b=qTUe8KkmUuRkQEkNXz7TyKZ8B7akNzk+6z2CeovQeA5dMnFOa4cE6LgAisFrsmFR2YascOMv6KSI5J4Q2O4/xKD9aFs7NjBdnm87Zr9X99d4ym+MXR9hdASA3UlByspgETcq53HIHYa+sCdsBA7HlKsNtn/+UcA//lMuc1dGpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094631; c=relaxed/simple;
	bh=+grwfisPPOsP5eBHowrgkZgaYBwSTt1KvBxHuqjlfS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JkiJOPDJtjoxQgLQkTYZOnjlDkwxXA0ZIRkmx/jye1x1ynpHbPjqURvU7EY1HRod4o2NbBr7uaCpdFB2Yl/dR97Wts9salL3OpQtY5kzUI5BZ/tko8iKGoRghskKem+kpH+uLr+4OnSAVKhAPChCSjckhEVC17iPWemJqWBQauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HAZpd0n9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PaBrrlwb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HAZpd0n9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PaBrrlwb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55B9A14001B6;
	Mon,  9 Mar 2026 18:17:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 18:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773094629; x=1773181029; bh=K/uQtTI0eu
	d131BSGpbzYRJFOwyN+JPnKWxu6BjaaZ4=; b=HAZpd0n9AMk37YEVg6jQtZqEEV
	yGVSVLJY1hfTjxE5GdqRT7CZoOphxqAG9uPHLyOJy4WrK1+9vMCxwQfyGLoTRJzM
	Uej9z/PAHjJaRuSJ7F/G0/NTxd5fgncum9+xU60eZiM0ESSGWwt75E8ky4Ornzoy
	YFmi4jZr6AKU522AHpAKivNmCWC8FG7znMyTZaXLbxAX/Nax2eW/vXH0eWdxXiN3
	9z2Zb96KlRprFbALLNk4vRIV38NdMe92RevEeXzTVOecneL6b20NvTZfgxSKvBo7
	fxd7kWArgUUVpSq4SpiB1rQvBj8RYt370HUDqhpOLo1p+/EYu/k1EW43do7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773094629; x=1773181029; bh=K/uQtTI0eud131BSGpbzYRJFOwyN+JPnKWx
	u6BjaaZ4=; b=PaBrrlwbQn1Y/DJ6e/OCbTgncnq7NEQ+iGxTgbJaXgYx/p/pGn6
	Fhu4f/KXI/6hTqrPng5Ci/veC01TTeXpPbB0Hwn5NPDc3khHYe1yjAwcF2LncAFH
	eKHUj5yHw9URCIMN3N2OVUIcK5I0zYH/UOI5EuvtWO02qDwhEqGISGbMxlhya02s
	cv2F1+7GBTYxRWYXsZsePfyZOZSEqsv5isdZTMrR9US+i0Rx1mTmKwvfaFDSQH1u
	x1Hq8/2quTKbV8aO1q76vhsKlIBZfXtSiI4rItVnoVIcRwtPmR2VysKjIg994RNi
	CwnmAxzu9YUp/NRmCcaLosZ2Zx4aTveRhlw==
X-ME-Sender: <xms:5UavabA-OvZdaoelBF32j-4OWj4KFNAxqr2ACvQ13AAUe24G8z2KBg>
    <xme:5UavaY_IMEcuhLTl8JW6P-ol_GMVqfXnqyxEMj4Tsf8stOy6NZiWs25TsQr9uRB8l
    XTt7ooZDQPIP9EDudZowt9JkMFReuud_y3nPthcGfyy6Vx9OV_bww>
X-ME-Received: <xmr:5UavaT_nRz7S46U5PWm76qm46XI1ng6hYGYb8C6vgr7s3mohngOCIAquwJcd6gbO6VA5tMoUheMyKXTHeDZcf2QwWLsr6du-wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtsehm
    rghlohhnrdguvghvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5UavaXeTPtfbpD-3ZGr3iXit9AgfFLyUtJsAI5tn_-cCU1fpBZuAhw>
    <xmx:5UavaUEvN2waAUTwE3XWIX53MyozYuGlBmvvjmIjrk-5mG0J5W4e7Q>
    <xmx:5UavadcFcaDXIx-Cboa2jS2yvzdrM6lst7EtMX4niBDqd4VKW0MGRg>
    <xmx:5UavaWGwZR06l3QLixCCfDX3ES38N4pWkm4UDqYiE1Kv_jauvutzpA>
    <xmx:5UavaVKD7pxRRboBaScReojA8NdNmnh_Gn9pqThS91DcwN7UZ_bwFkIm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 18:17:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1] diff: document -U without <n> as using default context
In-Reply-To: <20260309172719.125419-1-cat@malon.dev> (Tian Yuchen's message of
	"Tue, 10 Mar 2026 01:27:19 +0800")
References: <xmqqh5qswo45.fsf@gitster.g>
	<20260309172719.125419-1-cat@malon.dev>
Date: Mon, 09 Mar 2026 15:17:07 -0700
Message-ID: <xmqqwlzk1wd8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> The documentation for '-U<n>' implies that the numeric value '<n>' is
> mandatory. However, the command line parser has historically accepted
> '-U' without a number.
>
> Strictly requiring a number for '-U' would break existing tests
> (e.g., in 't4013') and likely disrupt user scripts relying on this
> undocumented behavior.
>
> Since we are retaining this fallback behavior for backward compatibility,
> update the documentation to explicitly state that '<n>' can be omitted
> for the short option '-U'.
>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  Documentation/diff-context-options.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I am moderately nagative.

It is not like we are _encouraging_ users to omit <n> from -U<n>,
but it is not errored out only due to a bug.  Who would the new text
help?  Users would wonder why <n> is not optional in --unified=<n>,
the other way to spell the same thing.

If we want to be explicit, we should probably do this instead:

    `-U<n>`::
    `--unified=<n>`::
            Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
            or 3 if the config option is unset (`-U` without '<n>' is accepted
            as a silent synonym for `-p` due to a historical accident).

which would tell readers what happens when '<n>' is omitted and why
we allow such an inconsistency.

