Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16965242D77
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187682; cv=none; b=PqvHObKAI0Xu9d9cTjOvQwVcB/x6L1vfJW579VXpRvbU+hax8aFFKntiFYNoLIL1oOwERjpIATgUtmzY03uJBqXvz/3wrHpBflPYkTGkzxo8fXicRCPxnsyF25JFQZdKTqtfBpuY5QXwyxbxE/UQ4jzWeQTAKFo3vNiVJlqF39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187682; c=relaxed/simple;
	bh=bB+8MlXUqQ5V369Operuzo62NZLnj9Z/BY/Iuvwm5A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tl2ZjUHdfKgGYBMWkUcWrfv0+gFCD9aOxzEPsaaM3lGvoG8P1+7va00uUMHfIJaVXJJkQ6XHf57xXfLEQRf3jMOBT6PQjauGEH+oeYcveWxfZIuFpD4eINYXxaUn2E8WrU9OHDMeOiTBHtANx1PMrPUgMUe7AU/zMf2hWsOX3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bLc1VKbf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eaJWMEwl; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bLc1VKbf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eaJWMEwl"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 243FF1D000E3;
	Thu, 10 Jul 2025 18:47:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 10 Jul 2025 18:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752187678; x=1752274078; bh=n3F57O5qO7
	c/oafipAXPsWfQgq0N/p5hHUMdp2I+Gkc=; b=bLc1VKbfn4xAgE++C7PIg3b8GI
	phWjdttzlnt9Ma/ObMQsMXL0f+ae7WKZskUGbK+gPvNdZAqbOzMdxmWYLgt3H93M
	rFBGxOQ0njc1JDYQfTpZrAr9ek/FFIhhNiWa7kOqCe0/Lg7sl9QmxMaBjdbkji33
	vQySUSOAgFwcQ8YqfHOiogmN8cXDpXpFseU+Fjg2U4S4LJwVz2T05NOGbSdtPAEW
	qyfdmbOgNfN0ej6KcOCI+Qo2twWo9Un5PT3MTmOjez73xcgLFmDlqS/JZk+biCbD
	0gcD0fEK13xr7cUvmj54afbLZwLky4ms+rem9rsfQDReiNHSFl6r44RDpnfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752187678; x=1752274078; bh=n3F57O5qO7c/oafipAXPsWfQgq0N/p5hHUM
	dp2I+Gkc=; b=eaJWMEwlLyPqGTwh2X9WcRLYpD6XWaQvTz6u0yjrZQbJl1oFhWz
	AxUMw+9F4WNhTvhYDQSpTlYj4qCVtTSQ+9zv4GNtzlYbwfGzRSYa06uRPIilTCrX
	f3uGdWk5wfE7HuyQofqvYaxHvspZZs5R/edsV58MYbWllx56UjEfRhMtcXxcFhxu
	vpPEJOeBTlfprs6XDeUELLToW1ll5uVBNhpLfly3Nu7p45eHWACp9qOZgSFLBbJx
	nzjUgVhdNeLH87TmKIHeYcs8TGThKaZNB0Gvx2p1OYxF5GTBks1QiWOYA6x5ocyL
	NMCMPsLtQ9pc8QivQl9HIchhlNNx6rXG6jg==
X-ME-Sender: <xms:HkNwaBae1YM4Tz3-mKnWlelC2n0P_cjW8MsNJYr3jGmMicDNQ16dNA>
    <xme:HkNwaD6mVoGxMLAbTixPW4qVJ1ub7_ikVHVweC3Cwu9NIPog9D9AbdSlgwPMQO9N2
    eFdy_7m3AGIcGye4g>
X-ME-Received: <xmr:HkNwaKamCXYaNMzGQUVeeuqMnY_XEOYMfpCUYA9-GaLyyXEL7gTePAjj-EVw-7BEfc7P5sLBCmnUgPaaa2SnMKhPIvXQwbCzvENVDgs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegvuhhnghhjuh
    hnrdihihesnhgrvhgvrhgtohhrphdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:HkNwaKjV8rfQLQ24U2X5R1aqySjlAb2rZAbHzSqI0k5IeAXc4stYEQ>
    <xmx:HkNwaD9CNik4X7KQi_bowuyk5u2Kt5fPJLjPYsxmBXlcfxRRpWGMCA>
    <xmx:HkNwaNoW7FULaG26XOeVUUVwfEO-iBTOkAVxNBW4fUyfQfuGkxH-Tg>
    <xmx:HkNwaDXYdsaPAfQKkEwp_4fPBsEnXSohfjgIT0yxL-BO0fbOlcTtjQ>
    <xmx:HkNwaINkPv_JsMoBpO6EGpSd6IMeyffVacrSr8Rt7drRG6f5hqQxU9PM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 18:47:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>,  Yi EungJun
 <eungjun.yi@navercorp.com>
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
In-Reply-To: <20250710221641.857081-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 10 Jul 2025 22:16:41 +0000")
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
	<20250710221641.857081-2-sandals@crustytoothpaste.net>
Date: Thu, 10 Jul 2025 15:47:56 -0700
Message-ID: <xmqqbjpr4q8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> ...  However, these two values are widely used in the LANGUAGE
> header, are well-known and widely used non-language locales, and have
> been seen in the wild on the server side.

"header" -> "environment variable" I presume?  

