Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D001C32
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739421381; cv=none; b=gtp/bH86XwUVuJ9zlAyx9Yk6RYcH6Oh0480nWkRAuLZUlk/jdtcqgy3j1e/9vqrnQ63dMsGtIP/EJ9mBZLnnaD4Qwt5rn+Jp61oUN1c+9brBvWLgcNBwgSTYx6t0L+YFAW4wVpNWmxPWN+Y3BVJU2eW4Cnr8AN0ypyJ93rwqKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739421381; c=relaxed/simple;
	bh=wLI7YfIp06taYjLTdNZyoxGyGKDiLVYJjESPe93qaKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EEirBy6veQK6yR9xQ9PFLtkmKMixdnR0nvXNZvhKQ53/SkFYJQvDb1JtkbXWb4IF4saD+vvEtrpo/gbG2DywoXw29xbUffj+dDK3qU4/9dYFnRTiUlHPPB67iilph2uqcdB0LYCLkDbx+iOLrxBRipiHUxKdDNxnpufPJTW+Am0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f4+1Tq99; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tuqkhz+p; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f4+1Tq99";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tuqkhz+p"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BD6825401C9;
	Wed, 12 Feb 2025 23:36:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 12 Feb 2025 23:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739421378; x=1739507778; bh=Cc3PaJZ69U
	XQeFHLvXWjSaKZ21jayBtWI5nh0/OG38c=; b=f4+1Tq999w/RGhPvgjrqGUG80B
	SLSyI1FAfFUDa3i0qbiS7jyAjlxQGxHED6B648GwwAIbAUa5pfTwlzxZBK/1/b10
	1sQd72TYHXgZxdV4Qgsr8GvIQJ1qx+V3ED9IrrlKbACJZNcUBqab81UVxKTQSlpH
	ABw148mhNXyjcl/7poyuIvg1TrhXQNFe3lhvN01vcH3DPJdoUriil4Cmk+r5iJsK
	0696/X0eI63Ey3RrrVJhBou9jLnJX62o+hiw6TdxjOxajowOEqpq2ZMDBn+xQNjF
	hTBSg83bslssk89VbAD4G/waIbv1fyYcebAweWHCI4SpkceEIzlfgeUF68OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739421378; x=1739507778; bh=Cc3PaJZ69UXQeFHLvXWjSaKZ21jayBtWI5n
	h0/OG38c=; b=Tuqkhz+pAFIYjzaksHpbVCvSctb8Ge8SUGq/u019uY2UGt0BVzu
	iuZTvXdX7Skr1pTiWwGY2T8kpFHNzwV8YHoZaL7PGgtLQuJVw+pvakiGE8A3tUv9
	wTWfrHcnzWUQw5Hwuo+QQiR3/6Qr7yEwuPokPwzcsNg5q0jR3TwM0kolOf4F681V
	bDrKlelEy9jEbCjXMrMh9EfR3unJdcbtoRfgosjKE/gMnOH6gl0c6yRBcnYi9tHT
	31doWHoHTUvHV23pv5h+PJDUAZNU85PR0WzGgCtMjvqUjNVmmQzMBsPB7T80TZqW
	kctslLneV5+4J6sQfrt1s1ZSGpd74zyHbBg==
X-ME-Sender: <xms:wXatZxLCwRlmLqURvswJ_-M7Wk6NpedTiIshSBH5ioCLF6A1jupyuA>
    <xme:wXatZ9Lpadg51yN9G1lUvq6kXjhZH_4oawFDIBg_JdW992YGAzEbKKNinPAN6aVFr
    RRXH-SjdGvqA1d5Ow>
X-ME-Received: <xmr:wXatZ5uSI-4bsb0zLfCq3x15A8Yy18w5d5n3Fpk6dxQgssIDrVgxxJ0_LSkRuyqaD533BBOZQhmSu5BuHHFw8gZTIXEiKdmo1TdaZy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepihhllhhirgdrsghosgihrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wXatZyYapDDMZA0REQsWceYqNq20dd_LYyXeilpWmBi3CmUTi_re2w>
    <xmx:wXatZ4YKqXApyC6etKgiLmyMlJsonjG29KqiSqPMMebnKSAm6mgqwA>
    <xmx:wXatZ2B73D-texIP0IqT9f9XGSt4B5tOEHCtc5aaRGPwH8jsosi1Pw>
    <xmx:wXatZ2ZZ1rY6lE4AwETZn6R7T1M7k2sBzctxZqui8ZXDusRNKnpdyg>
    <xmx:wnatZwHtlIZHAc8tsWqEs87ov4zf5Bx4tShj9ZEqg84s0EILqZ450nFm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 23:36:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 05/10] docs: gitdiffcore: -G and -S: Use regex/string
 placeholders
In-Reply-To: <20250212032657.1807939-6-illia.bobyr@gmail.com> (Illia Bobyr's
	message of "Tue, 11 Feb 2025 19:26:49 -0800")
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-6-illia.bobyr@gmail.com>
Date: Wed, 12 Feb 2025 20:36:16 -0800
Message-ID: <xmqqtt8ypikf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Illia Bobyr <illia.bobyr@gmail.com> writes:

> In the rest of the documentation (and in the code) we use `regex` and
> `string` as `-G` and `-S` argument placeholders.  While
> `regular-expression` and `block-of-text` are a bit easier to read, it is
> a bit consistent.
>
> And we could assume that everyone who uses git should be able to
> understand that a "string" and a "block-of-text", as well as a "regex"
> and "regular-expression" are the same thing.  So, using a shorter
> version is also more consistent.
> ---
>  Documentation/gitdiffcore.txt | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

I am with one reservation.  <block-of-text> was written to stress
the fact that most of the time the string is expected to be a
multi-line block of text (like a function body) [*1*] that is unique
within the codebase.  I do not think replacing a short-and-sweet
<string> with <block-of-text> is a good idea, but if we are to go
this route, we should mention that to compensate for the diminished
stress on that block-ness of the text, as <string> would imply
something quite short and would fit on a single line.

[Footnote]

*1* Go back to Linus's message I cited earlier;
    https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/
