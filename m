Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA763BE4A6
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116918; cv=none; b=N7hOEWZxQ6XW0boWxTpjibEsVgU4ZUt3TIiuYmlb8G4v2ukiQAi7poeuadmMv9PRDKHVzz8Dv5yp6J6PD+PoJ+mtp8JwYAxCbun3Emvs3zx3TyFtQXI9JEUB9uJCiO0r5iIXjFiHeafz8aMa/1ACKuS3cMszo8bxOKr0Zxi/GiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116918; c=relaxed/simple;
	bh=Ojtx9GZCvZDU1L8nz1EnpE1Et3b6GzJerUDNgZNA89c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f8hby0C9jw+A0G/un0ycWFMGsULDDSYOxETRIVOVgTsReDSXBh5nwatwip7EYGUQgwkg6WVibxf3MK40mXO6T0jFWU5KxLX3uHluqBbua5GLRM3mMJWUXpuy7vAvnMzYK+68PLn6Wm/KPN3DJqXdPvLauQS8thf4mgE+hROZw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NxEG/L3J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EwZGU6cJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NxEG/L3J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EwZGU6cJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 440D91400D17;
	Thu, 22 Jan 2026 16:21:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 22 Jan 2026 16:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769116907; x=1769203307; bh=suVhvX0rPM
	buHU1gwraXsCJpPZLig5X0A4oUVf2+lxs=; b=NxEG/L3J6ZrQ6Mmheu67tfVJSp
	iIyQ8Q+d7aPMwyZO83XZUpiSyNrQ9xSLmOlFJvtxXkrDGrzpcsfXIAKR+g5CD90x
	1DMY3Hw2aakKRVaSem/Px9oBjDc4/qPw3LW9fBvrALoEdVPOswwP9X0dAm8Yds4u
	JGJj9eBMjfc0VMl1IQz+b5u0zsYJ8VspIVInaJ5mj+I4Gu/5f0ZloChq/hjsq3us
	GESSvZRWbGFYB9+SAgNZeuYPFqBnhWoNIRIPT+KlUHM9HUaPeET82h9UBuUD+odU
	l/piWbkqRia/9cPlrdNSDHp1UG93R9lLKD3lrWiPMOjAXy6msOijT/+o1YZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769116907; x=1769203307; bh=suVhvX0rPMbuHU1gwraXsCJpPZLig5X0A4o
	UVf2+lxs=; b=EwZGU6cJ9gEmbQ88N3Mpe+jAGP9Kt4zfti3ZjL1J/b7U1cL4ZGh
	BdsICLHXlLy0gedWqCvjZWtqUaoem0cgbaMK1/QBDjwIJIN4Xbl7KLyH/2ujExZ5
	Io40mokUs5DrYZYDuW+YRzDsC7GK+P2/GyyDoj21dD2TSBkS9eJNX3FXeUp+JJKc
	Qm1om08ZG7BNF2cJJOp8A6XfSNvnAeRzG5SeaObMcO1vx5x9oin7VaWt9PVOEjT2
	h0WqPU2KpacfR4vaIfltxPPR+82EcNnkLd8Q3c2Uj6CGH/GPXSjy7mDjkMvfcV0x
	R0L7KOGyXOGhzCCLSdeYnGcQ0zsA6P2BFMg==
X-ME-Sender: <xms:6pRyaSwUBUsbCvNj8glWgXmiQOjpMnV5TqIT6z-rqEiwjTuiIJH7Gg>
    <xme:6pRyaXmOxiXTe9oa7ca-gYtjPjK3nY4PfzmY4DhIBx5p86UE3So8C1XzZ9nCgJolO
    EhOfLwtCGBBegCByJdtQpk5sLJqVVk2SLQvWuSyjYERU8O-Z6ZLNA>
X-ME-Received: <xmr:6pRyabkujSUJtPrhT33XvZswRot6z-8CzwJWRjiZFu8lxL34cUbVgrDe6y_hvKhdk2-X0NTI-6jA461vqzWSP2ivkWzjLkRTmzZeJPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgrshhsvghrrdhgrhgrihhnrgifihesohhsshdrqh
    hurghltghomhhmrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6pRyaZw50-S8-GZhYJG52HfvMhZkg4uHRNKyV2pvIaVwTQi6nkB1pg>
    <xmx:6pRyaQomiqXCv1N1sQutMaPJ6nmx9T-adw9uyryvzIfyIA2hhu-87g>
    <xmx:6pRyaY4yBVY0hRpYhsZVpEm8VJy7pCjSB0iFUyp5Z37dByZNerbi4Q>
    <xmx:6pRyaXf2zfVryQhcbZqLRwDQEMGd_9GCNMr1zMnF7hc7kOMJkzH-TA>
    <xmx:65RyaX3wvgC2pnLsJvg78Yzd5W0krEyAFsJOEL0pnxWQx1MJA7udVvdd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 16:21:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
In-Reply-To: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
	(Nasser Grainawi's message of "Thu, 22 Jan 2026 07:27:22 -0800")
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
	<20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 13:21:45 -0800
Message-ID: <xmqqsebxl4wm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:

>  t/t7425-submodule-get-default-remote.sh | 186 ++++++++++++++++++++++++

One thing I forgot to notice is that t7425 is already taken by
another topic in flight in 'seen'.  Perhaps move it to t7426 or
something, perhaps?

