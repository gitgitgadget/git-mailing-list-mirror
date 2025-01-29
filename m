Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDA1A2398
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738194824; cv=none; b=cGa1Psp30SQyiUM9sRmFrv9AJniCpOlHIuCv731DDH4mPfpfOWKIN0FQRXLk392PV0Qiyai57IpvKuTN07Z8hc59q/GG9RVqAFcINDnqBoKF2aNDK2PnRlBpp4LjT8MYduS6rbnGkjAfSF6nELlikn+3hn+9uhg3ds/oKVRd+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738194824; c=relaxed/simple;
	bh=Ssxr3CCgDi+oe6XDyT4ZGxV+B/asZm0bUFvi4HJ4XiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lS3pjFCOcclLa/PQVv+VXtxSxltovI8LerN/mH3VlGgkvW1rfn3LC7Hi75OQN+WKYHlWqHXmfPwGXfcswnX67gAAMXBvab9XbMIZlv34yHiY8YM1CSltQTH9n0j/cwPLg91Y5wUvX1YoqThRjqrYPKv5Ahm3Itf9OTWqTQwvGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RVta1sJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X3T0FEhY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RVta1sJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X3T0FEhY"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5706C1140196;
	Wed, 29 Jan 2025 18:53:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 29 Jan 2025 18:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738194821; x=1738281221; bh=Ssxr3CCgDi
	+oe6XDyT4ZGxV+B/asZm0bUFvi4HJ4XiE=; b=RVta1sJrxiLg6ZARiINKaGLAKJ
	7JQgIanxZHSOScq8GvwNLvwP/QHdYo+pIxBiUKJxbfb9//YSyQlvGMR2/JpXQBQX
	CXlD5nqF/iWCN39yKEGMSoJm0fk4DIL0x3/yh6v4XdgzdyxgrOnsWfmVKzeeSmO8
	k92EFl+IGPiIqvMA5nd1NynuI6M1eyypyUf40gSkhrcEzIdBTII/WhrPrRlXXBAP
	qz8yLdcmcqy4OObXuRMVdNyFK04I6OCMCcUBhhu3f58xh1c/WK0uI4G9v6/U9hKr
	AGCGsTZhh3PlUwSKFgiwzrOqYOV7HcvvBhsA2IoPpSbj2PKiAeRe/6f4GX6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738194821; x=1738281221; bh=Ssxr3CCgDi+oe6XDyT4ZGxV+B/asZm0bUFv
	i4HJ4XiE=; b=X3T0FEhYPLw0jWMlD4YIBjoKKUzk5eiJ1knTinY7dKujXbpds2r
	STXBf7d8L84pwhtrcwlxHYw207998KxBIBtwxd1suaZLO/mBlWR3aqpyZkmVElz5
	WwGn2gCrrOzidVXcryok1Erim4kPsZGTYFXUKsznURWuo6tyDMGrlMfiRh93mn6M
	3BinpATR098krY7KmwHxB0SndPPoPMjha9N86CjmFbv8cIZS+9+6FUraZs2BeH3Z
	DgDMMAGlP+qnRuF9dVjnXZyLTXHgZFg5AHZxxxDm3p5zr81Z3ubnsKkeFvyZ2KtT
	FUtdgK0RcZxF76tzKDeKrbOyA5NewxG4kDA==
X-ME-Sender: <xms:hL-aZzCkPzP4-4Dv1L3onm2AXvnWkCWSB6-RgfvPQtqac1h5JCECLA>
    <xme:hL-aZ5gk0kPu_LYQPHR9fVqXnMMSG7fJZ1kFaoWKpB0D0lvUMA2qgdBJ2SFJ1UYbI
    c33hJsHKH-_Pe2Z-g>
X-ME-Received: <xmr:hL-aZ-l82jD4gOQU3aOeiPow0Zyjq8czl7K7P__oM-td9K2xmwZttMh4CvMpPUu76U5HmH9BiY5iUJSxr79qlHWSA5WMCUirQBs1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hb-aZ1zx75K47PrT30AFWNwhtv1cZHpP3kAIu87J8r1ZZSMcv3U_Mw>
    <xmx:hb-aZ4QwFqgfa-lwc4LNmMORkutfz0WX1-Eo46nVh6D7WXz-k1_u4A>
    <xmx:hb-aZ4bcnzP5iTE1AhKCV6rB8iw0P1gzMqwthSEnzB4IijF2P3od6g>
    <xmx:hb-aZ5TaVo0iWjtMjpj1HStuQhaPFEgXYH1qPqZdIKrfxLBjCpxx4w>
    <xmx:hb-aZ-cMmfBwbVK89h6XZhBF2ia8-j_xdJisHWwJ_HgMDIpSjopTJy8Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 18:53:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [BUG] PREFIX environment variable ignored by git config --system
In-Reply-To: <001201db72a8$72719480$5754bd80$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 29 Jan 2025 18:49:28
	-0500")
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>
	<xmqqbjvpk1wo.fsf@gitster.g>
	<008201db726f$6e6990b0$4b3cb210$@nexbridge.com>
	<xmqq5xlxidh6.fsf@gitster.g>
	<009c01db728d$164a60d0$42df2270$@nexbridge.com>
	<xmqqwmedgpkf.fsf@gitster.g>
	<001201db72a8$72719480$5754bd80$@nexbridge.com>
Date: Wed, 29 Jan 2025 15:53:39 -0800
Message-ID: <xmqqfrl1gosc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> Those of us who have written documentation for much of our lives, really
> miss accuracy. There are companies where a wrong bit of documentation
> is considered as high severity defect. Regardless of that...

The association with that "book" and those who hang around here is
that we could contribute corrections to them, as they are open
source and we are friends, but that is about it ;-).

I am reasonably sure that they will appreciate a well researched
pull request (and "well reserached" does not mean "somebody says
this is incorrect" but needs a bit more than that).

THanks.
