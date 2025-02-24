Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75984264A76
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416489; cv=none; b=R4DXdxAmEJfcz/CREWjKmxQX4J+YJhR70D9Cb3/bQTM1iG6mVSH3xPTBEgK+E1p1eduvWThgMT2RcYIAjAGCY62dQQQh5Puxh9RqGFRUPq0i8cMLau05nqARUuV4PW1KmUuark/WWd2BlC93kvwOFC1l5IWdohjGdPN5GhBkTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416489; c=relaxed/simple;
	bh=kJxNOSHgVYHp1OSfG/twea8qBm/grMDj1qzZz1B4GIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z5qy/uKcCTYHaAnlTyYdewhYYr/QlSPjyWfbmJ28Gz2yw3NH+yA3pRAtEareiMkyfrY9NxF+Gj2rbYsIfG5yC7HBjjZx1kuFnKhNppgdUYrKj7Cf7eNiUFyNk2Bn4KPsGzbwTeG4IX1AncdItuJwn1GAKhSliY+/YRRyThlBTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XOMKuTLW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xGyZhrrO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XOMKuTLW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xGyZhrrO"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 511011380F0D;
	Mon, 24 Feb 2025 12:01:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 24 Feb 2025 12:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740416486; x=1740502886; bh=KK7a7PsrTa
	nvV08qxvpvSBB0wolp9y580+Wk7zDhK1U=; b=XOMKuTLWuty57q4+YY5otKCfcM
	kk9Kp64PHeMv7XD3PyTAWnUdTvAvQTMzxYRCSZtuBbwQ5LaPHDJnUIY24nxPz8hX
	JPXssfofezT1//7X0YB9YhTt7ldzP62tpWHATlPhirx7XbeZXNh4tP5uDpn2FjLY
	h2sMXRgPtws2rLSXi+SxV1IInvLa2RMJHS9PXtwJGVdKIl+Yr3qs3Kdus6LM1m8g
	9F+2AE3wyRONeH26ZY5LByWCEpSp6EaURLHbPa+8bSvei1uOxB4ljM5h1ewELQSL
	4NKoXs+iy+fMHbmNSHWo7eb3BoSg4HWxgIe7ggVu4ChWzuv9qupb10JIOc9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740416486; x=1740502886; bh=KK7a7PsrTanvV08qxvpvSBB0wolp9y580+W
	k7zDhK1U=; b=xGyZhrrOdw6Osg57qU8TCdKrrODqyqlGqKn/BGTUCSkCzUUvBTd
	ufJCHVT02vzaTHy39/Dh882d/XcSFAk9zAcKx9FVBrUuezkMPOcCHG5WVJ49c8OY
	Qjx22OendBRvUT6tSMEmO3ZVnjAlsJafTjftsLqkvISS1gTJXbExqJ2Z/sExKz87
	dms8DUFObupGUjQi6oHYGRUxadQHcwogXVLYfKYUea5lLJw+N6RCBOlPblTD8zMT
	f5I9zmuKnVhhpVn5g1Ex8ZsopNaa0kr7+pZcgsRRYdW0do2ZZWBuw2NE853lxpFO
	bK/AZUn9UKEr6beiDTySGQa4rTeVqLDDuJw==
X-ME-Sender: <xms:5aW8ZwFjeolIuZiTS3YaeJmRdNlDdPMihyV1uASisHtj1LUj90VKGw>
    <xme:5aW8Z5Up8egc0F2wvdYPTRtX0jtl3QIcKaqwbRMjxmDJxT5OPQZBhcSBqiBi7epAL
    xaA-ulC51PTqqiFbQ>
X-ME-Received: <xmr:5aW8Z6LqxlzzzWIGanSEwnsvnk-S0A64E8oDNza8sCW8LcfDS1Bkoiqp8yFlupBF2tr_p5I7tjBgzVU083UdpHysqpSra3Bhq6nwQsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    eplhhukhgvshhhuheslhhukhgvshhhuhdrtghomhdprhgtphhtthhopehnvgifrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:5aW8ZyHfukWcVVPUm-UINCjDgf0OTkn9CooHx5Ru3aGCByMYj71mbg>
    <xmx:5aW8Z2VruCGdTT95JU9wG2CZqlgOneOalHP456dfdIPlNnMB_W_Eww>
    <xmx:5aW8Z1MUBSTLWX8DD1xf1lMO5VtaC6j-mrRo27AkNnFffCM9iqP_0Q>
    <xmx:5aW8Z93KjQ9VFHqefJOpmR2d3NwzrjG0yFMwwTyXgQxzAm1Y5gXWlQ>
    <xmx:5qW8Z9PhpMPJZKLANnBTSkiSDSkRLxWuOMc8mlPnasCHRVM4LYT-YFlH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 12:01:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Luke Shumaker
 <lukeshu@lukeshu.com>,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Taylor Blau <me@ttaylorr.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/6] fast-export, fast-import: add support for
 signed-commits
In-Reply-To: <20250224142744.279643-1-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 24 Feb 2025 15:27:38 +0100")
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
	<20250224142744.279643-1-christian.couder@gmail.com>
Date: Mon, 24 Feb 2025 09:01:23 -0800
Message-ID: <xmqq1pvn6zvg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Luke Shumaker sent the first 4 versions of this series in April 2021,
> but it looks like he stopped before it got merged. Let's finish
> polishing it.

Nice to see an old topic resurrected.

> fast-export has an existing --signed-tags= option that controls how to
> handle tag signatures.  However, there is no equivalent for commit
> signatures; it just silently strips the signature out of the commit
> (analogously to --signed-tags=strip).
>
> So implement a --signed-commits= flag in fast-export, and implement
> the receiving side of it in fast-import.

Nice.

I haven't thought about this topic obviously for a looooong time,
but I wonder we may want to have an option, which is independent
from these --signed-tags/--signed-commits options addressed here,
that allows the person who performed the import to attest to the
result by adding their own signature on tags and commits, whether
these tags and commits were originally signed or not.

Obviously totally independent, orthogonal, and outside of the scope
of this topic.

Thanks.
