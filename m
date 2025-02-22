Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BB14B95A
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740262682; cv=none; b=mFdPlpB7aEYVJqwzTMF3DtnBZdBRmTdeWs1sXnhDmVLKW4bMT7U+fR94/loK53GoVW4zQpYz/yoFYFocCcKV3Ian/x+aZXy3rYXcSHQVSxvXFQk/cOcaIJFsJB/MdL6tS/J2pXSHaDNRQedriXQpjwXV0x11QGAQd8mLNn+r1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740262682; c=relaxed/simple;
	bh=x9g7CxzRPLV/0DOknZwOwPhjkl5Mr8d/NYATiMM3kPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U7NvqWIPwCHPx/44/aijWKET6nS8EDjkGxzsD4qH82FPfsDX1Lm0W5JW5sRKdw67ST23BwHW9cwteUL00NyXgF71bhu5VVkobmk8eaDRBvXmj/U9Jd4BSvvFVvQEc/km/31raXRlPnfwPmA1fY8P0s31OUgudelKAaxNPRbdI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sp8o7iMr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Htkiwjv2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sp8o7iMr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Htkiwjv2"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F9A3138020F;
	Sat, 22 Feb 2025 17:17:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 22 Feb 2025 17:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740262678; x=1740349078; bh=sDChc2DBgC
	p3wJhsJlGgYM+2MuujY3R5TO/JGlmpieE=; b=sp8o7iMrj8DSN6j2mYitDAjcep
	D357hsFptzXg/2UiSwB7YbQcQ5EZRy1JkK1Lyr7v/cX0FtD4xX/LcCBC67r5VMny
	953XSP+AiMZfgRcBIKCmCV4FiIqsPloGjhm8yxRAcyhu9kFNoZ1+YPTKapzVxyRd
	nZKEQmtdr4afkUl7g2zM5m4Etry3HUSlHoSdI222dbFUDGW86sfAaExvSoypmL2v
	2T6LXyCGEcljo8LPCqNE0pIGUu/X0VNjItv3QcLCQUV5FuGFyOYEsN4OtVU71jSO
	7Awez46xtg8fKweQ2qxLAj4dTPrfp5Beu067GPMS3gicHksBqnA17mQDuGcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740262678; x=1740349078; bh=sDChc2DBgCp3wJhsJlGgYM+2MuujY3R5TO/
	JGlmpieE=; b=Htkiwjv2kdGhmkDqemmHhRmWEwMjPKzEfV5ki6NKruUm57iYTHf
	P67RmNxhj08Kts5BT/FMBrmXwBDxNCgOPBtHKhvyiym+hKyR18MeOM/Lt/SSb4Ub
	3Qp/cdn0QluHhZAzrgA891d12w5YLezb88x7Y3mW1heffdiu4y+Mg5OYmhAyIO+E
	fsJDKYkAJtPW4i7eCv26Bw9cclBxslBZLez+sK4+OpLQgskuNCxP73WFQGoUBt4h
	UHW0tb/td53F02HuEcmfujwZqowsGvLT/taEIC5Khzj2b70umVMTsGGSoi5wcq5D
	FqIIWMtlpAbM1OVFjG9FRwHgZx8rI7zaRfg==
X-ME-Sender: <xms:Fk26Z6JIZpJjajHSXy1P2RVMy30k_8MdVorTY6BF9mn3aCYYTe3i8A>
    <xme:Fk26ZyKVHPRpIXBlY7drnFh9Hcyx1ZZSrYTzgigGa6XByjsI85-D7YxqJZQgtGqR8
    gy3xz3cicIXZjQVIA>
X-ME-Received: <xmr:Fk26Z6tj4IyM3WK7y_4yD2r9tt6NHGi_beDzkgWAQb1odBP7NDkPvmg0r3ULxgQFdluzT3xb1KNAKAWjrO6L9Y3JKYN86SY6rO0nHME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejgeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvih
    hkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrges
    fhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Fk26Z_Z9nQWcNy37D8yr1vYto1uc5MW5HtdTbY17IUROWHPXC5IeRg>
    <xmx:Fk26ZxZqRZKHTi83rZyWxdddeQ3oz05UKoIkQiiH1S4CYl7uPmjpBA>
    <xmx:Fk26Z7CLDAYgKQbRTtd_tPoDeVBfDFDqk6tRQmv7Ok653aSE4sgglA>
    <xmx:Fk26Z3YrtbGwpspW8gEVZI-qGePE3UtdYyml7JurJJI1b9ZsfQyi_Q>
    <xmx:Fk26Z0xt5GDk7bYaAWuTFUUaH0ThFCd3wfMzi2iUurLDUEyh_DnbaN-I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Feb 2025 17:17:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2] merge-strategies.adoc: detail submodule merge
In-Reply-To: <0256f214-795d-42a4-8319-4ba79777face@gmail.com> (Lucas Seiki
	Oshiro's message of "Sat, 22 Feb 2025 16:36:26 -0300")
References: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
	<70b76a89-00a4-4ba6-92f2-4fb46981317d@free.fr>
	<xmqqy0xz9nno.fsf@gitster.g>
	<0256f214-795d-42a4-8319-4ba79777face@gmail.com>
Date: Sat, 22 Feb 2025 14:17:56 -0800
Message-ID: <xmqqa5ad8vzf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> And of course a 6-line paragraph is not large enough to put in a
>> separate file to be included.
>
> I'm a newbie here, so I can't have a strong opinion on what's
> the best solution for managing those files. But, given that:
>
> 1. `ort` will sometime replace `recursive`
> 2. the last change in the content of this document was in
>    f5a3c5e637, three years ago, basically copying the content
>    from `recursive` to `ort`
>
> it looks like to me that creating another file only for this
> paragraph would harder to maintain than that duplication.
>
> I mean, if eventually `recursive` is replaced by `ort`, one
> will need to remember to move this paragraph to
> `merge-strategies`, as it will be used only in the `ort`
> documentation. On the other hand, given that this document
> haven't changed since the introduction of `ort`, this
> duplication doesn't seem to me that will be hard to be
> managed.

A relatively easy way out would be to have the full warning in the
'ort' section, and then only add only something like

	For a path that is a submodule, the same caution as 'ort'
	applies to this strategy.

to the 'recursive' section.
