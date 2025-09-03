Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675B217F33
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756937451; cv=none; b=YS7f+df/GNxCoIJWVOZpMxuulvVaNYWEjsOJipqAuD4mwuaDxDt+eJ95D6RQAmY5z1CsfhhFmvwQOsp9x0iM5WcB2uP4BxmEHxzlHvrx2dSZgV5+2bjAse79lEaRKyA6B2UJ63I944xMWz5sHT3oIKqgm3msJU/gYpzo59VBfUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756937451; c=relaxed/simple;
	bh=+64M0ueCQz850qwZK87rSLwEdNGVIq8MtTABc7jJFUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jzehDl1Yf7ytGXZHHdbeoX+eZEQ2solqk0XwKuqGKrz6CD+xkf+r2Nxzg/3po4JpsWUs701rJ6wxokrmVcX5ydr+2bbl4TuOTgEECTVE9atME7YJTS0ESEr3BtM8zGGmJTUb9G3jOIYXEJlhD2n3dLxvgmLeg1JPcNVibLzGdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AJhxjRpJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1bOOYX3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AJhxjRpJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1bOOYX3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F0A11400554;
	Wed,  3 Sep 2025 18:10:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 18:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756937448; x=1757023848; bh=GtiRj0zIVm
	0Qep57MYcr5CjmqsJQmByouqyus26Pe/U=; b=AJhxjRpJkNMP0RcmkYWO/2vWDU
	sRoNcEXNfeEpCcSE45g+1PXZQz7PBG0l8MCek7ZDR9GvhJxt0sf8KWR9wcSZzJTt
	eKxtCqk7uW+MZb2ZwaDUT1/+r27Onk9OCd6d29GGpd+mcEueQIDhVYOOT3czwP43
	2cSK6xh+LfY62gkdL5uStpUkab88G/WWRjZ3M5nLS1bCrvR4owTwL0NkQB1e/OGQ
	+KNdkZT/ox42Om0BOGui+W8Cwx0djtsnARtPeZskxbjOZXhsA96wrqi6ROfaHUGa
	Q+3LCud/806nsCBJvRMh0I2GwbdhFx/5l9GkYe6GcPYH/wM/7zg9MMuCoZ9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756937448; x=1757023848; bh=GtiRj0zIVm0Qep57MYcr5CjmqsJQmByouqy
	us26Pe/U=; b=R1bOOYX3fdzxJSFMpPJxKTTYCkBcgIerxKv4tFPpwpWCSKmzl4O
	pgHIktrLo7A2nk7cqkTP2QgOZWl5BcBf0DxbQ6KJrihPxdGbFFFXrFDDbIQt5RKI
	pddXxalBiu0KsxqorqveSVQC10UCYRejM1TMNRkR1fQJkMHUMVBLsNc6yiAsNYua
	iS0B+k5acUAEss0TkD9VZk5kbYBNBcJHQC5DrNakfhWc8pmhDg4bCZ1WrLcZpo2w
	BMvSRfwvIqNyVRKYJfz8NOwQ+RuhYa4GLODwgdByAg4Xtbiz7PCBStkzbXovxzj1
	n9xcJ99kC6f/YE+2eAEXE0MaqZECPSsrMvg==
X-ME-Sender: <xms:5ry4aFXGfZRgLgQuh2gwLHNMhZ8uB419Gptbh9T7C558PIcffttevw>
    <xme:5ry4aAXhRR69oYiuda0deb3FwvXHOsRmqXE_hYAmvOgW_NigakP9VTNjslCv6N0Jz
    B6MxmX8tENWTPpeEg>
X-ME-Received: <xmr:5ry4aAQdKn8btYwP3oKm3KyZg-OaKaWoikguGBE2k4_e1N7-HhbhgKLMraiUjJCTBOJoNpfAVCI0x34yQ4zYccGFMVa-8A-KWpyOMss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiug
    hgvgdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggssedvhe
    eisghithdrohhrgh
X-ME-Proxy: <xmx:5ry4aPFL-M61LLsTg0eY-YXMcZr9C_Oi4vr4WqzyjZ4SCjJJRd5SUA>
    <xmx:5ry4aAQjSQJU5cW_Wu20GPShSLicxnjcSYu1AmKKtPdPb_wJbGywtA>
    <xmx:5ry4aJrABrcav4cJ-_6l_8pkQ_X28Pphpoy0oJ9y0c0B9S9AnLl2KA>
    <xmx:5ry4aGpuvooEDiVKIz3LTR1cQwr5YCfN-We82Po0y6REgTaa8UNqsQ>
    <xmx:6Ly4aJkGakaTsBq0YkzsNOejBw8w8J5v8VDe7uVvvRe3PjOwbPcovZEN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 18:10:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Taylor Blau
 <me@ttaylorr.com>,  rsbecker@nexbridge.com,  'Elijah Newren'
 <newren@gmail.com>,  'Kristoffer Haugsbakk'
 <kristofferhaugsbakk@fastmail.com>,  'Josh Soref'
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  'Christian Brabandt'
 <cb@256bit.org>,  'Phillip Wood' <phillip.wood123@gmail.com>,  'Eli
 Schwartz' <eschwartz@gentoo.org>,  "'Haelwenn (lanodan) Monnier'"
 <contact@hacktivis.me>,  'Johannes Schindelin'
 <Johannes.Schindelin@gmx.de>,  'Matthias =?utf-8?Q?A=C3=9Fhauer'?=
 <mha1993@live.de>,  'Sam
 James' <sam@gentoo.org>,  'Collin Funk' <collin.funk1@gmail.com>,  'Mike
 Hommey' <mh@glandium.org>,  'Pierre-Emmanuel Patry'
 <pierre-emmanuel.patry@embecosm.com>,  "'D. Ben Knoble'"
 <ben.knoble@gmail.com>,  'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
  'Ezekiel Newren' <ezekielnewren@gmail.com>,  'Josh Steadmon'
 <steadmon@google.com>,  'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
In-Reply-To: <aLfU5sEa-RE3X4G2@pks.im> (Patrick Steinhardt's message of "Wed,
	3 Sep 2025 07:40:54 +0200")
References: <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
	<031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
	<CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aK5mJI1NfVQDmDXN@nand.local>
	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
	<xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
	<xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
	<aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
	<aLfU5sEa-RE3X4G2@pks.im>
Date: Wed, 03 Sep 2025 15:10:44 -0700
Message-ID: <xmqqms7bchln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I still think we need to be mindful around the community though. I
> understand that we want to have Rust in the codebase, and as I said I'm
> in favor of adopting it. But we also have a certain responsibility with
> Git given that it's used by almost every single developer out there.
>
> A compromise could be to ease into Rust: we adopt Rust, but before Git
> 3.0 it is entirely optional. So Git will continue to work alright even
> if there is no Rust compiler available. On the one hand this plays
> nicely with platforms that do not have Rust. On the other hand it also
> allows us to slowly iterate on the build infra for Rust, because I'm
> very sure that there's going to be issues there initially.
>
> With that we can:
>
>   - Build confidence in our Rust tooling.
>
>   - Figure out things as we go.
>
>   - Give distributions and other platforms enough time to prepare for
>     Rust becoming mandatory.
>
> I think adopting Rust as a mandatory dependency out of nowhere would not
> be playing nice. It may require significant effort from distros to adapt
> to the new reality, so we should give them time to do so.

Not just distros on exotic platforms, but also for users who cannot
afford to see regressions.  

> Note that I'm not saying that we need to have both a C and Rust
> implementation for everything written in Rust. I don't think that's
> sustainable in any way. But any feature written in Rust should be a
> _new_ feature that can be disabled and that users can live without for
> the time being.

Yes, if we can find such modular niche, it would be ideal.  But how
many areas that we can cleanly plug an optional thing in without
disrupting existing codebase are there?  Offhand, all I'd think of
are a new merge backend, a new rebase backend, a transport helper,
or perhaps a new diff-algorithm?

> It would be a shame, but right now it's a risky bet to build anything on
> top of Rust given that we don't officially accept it in Git yet. We need
> to first make the decision whether or not we want to have it right now,
> and if so how that's supposed to look like.

One more thing that I noticed.  What are our plans for the two
directories in contrib/libgit-{sys,rs}/?  IIRC, the new stuff from
Ezekiel did not interact with them at all, but it did not remove
them either, so I am a bit lost.

Thanks.

