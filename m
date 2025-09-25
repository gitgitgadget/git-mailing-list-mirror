Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B02DE719
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818148; cv=none; b=tqat+jmAaJl+xZAXUAJ9tDF0hrzs8yOTFVNkzW15oNbtRMOU3JOqbWGBZJE0OiLWG92sa+tfdyGTng7alW6G0yhmBqAHL5qHh9MAMjv5HSbShKJVgJVJAEgleT9caKRQphY8HGCgmSbu2ynjQEAhwmnbTdimqCx9MryAUBuxEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818148; c=relaxed/simple;
	bh=HobmRMoe/5Skd6AHx/rcTcR0YCEV9ico1LJGETP1PJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y542t0tkOv/sEWIP3vucm7+3kaZ2r/kWa5usLccr5ZIz4ZrZF5apt4jXK37rpY7L3KwvlqQsZxde3qB3s8wIlYaPxy8aWwTCqF7qPpFpt7tx/jMPj7jLz5IfQ4efeAl058KR2XPsSh4wQd8L1dpu/ZCrxuLsATkg4O/9Dkgfq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jgG72c3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYCSCAcg; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jgG72c3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYCSCAcg"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 251EA1D000F8;
	Thu, 25 Sep 2025 12:35:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 25 Sep 2025 12:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758818143; x=1758904543; bh=CsZVVGriN9
	/7yLjxsy2jw+i+N95e6DDec0tSWzV6Y/Q=; b=jgG72c3/ZB/tw3w83ojiMui2tH
	i2U/wse6oTl6R7AWa4XvpeQT5kwyoVVDHZdE/xAQu2QlG+HvQzfuWjDQWwHZVNK4
	xG7wWXMAalD0XwhmoUAjtldzuT98chEaBN0wZiLBY+leVP6fWsSSBtSDXGM8/oxX
	nF5Xn8mx0kDo+J9DgeSloHXrsbLdca3enRXNGOTH8Q9TZ+UYpYUHY8laEJQP1WGj
	g1puumf7BYZYLU7+XlU3V+Ixm1UefMCCRUjWh9036gmYU2+rdHvgQkId1CZEal1s
	quV5iU4OnY87bmyF4r4MLG5QQCln66AluG40yv0FFrGGEf55DRChe/KusTxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758818143; x=1758904543; bh=CsZVVGriN9/7yLjxsy2jw+i+N95e6DDec0t
	SWzV6Y/Q=; b=eYCSCAcgiqyJ9z1Or/Sn28NRgWuYv/ydSF+Vwjmi0olsk5NcajT
	yVRoStK9ugj6PGnprWqujZPdNXuqlW5g+v7Ezel52AdLTaLA9Uh3MztYY/pDAIxM
	r5mbhN4hrw8Q74slTIiivRrZ77uYfi/DsYcxfFVlaqV5qjCcu8A0TVf7UQrMltXf
	FE7SvhPpK7mpi2Hk1B6UYAQbMCMn2iIkdHbh3u0YVqSKGv48IlzjluEOS65TffEH
	Q9hUzbcZDmfK2GE1bMXhfmd1sbNbODdwjwlIh+rGkU1CjRW+rGU8u8IklOAf+PPU
	QGRfwrVBwtyAoDgqlU0ylPoFwJgy4S2dtiA==
X-ME-Sender: <xms:Xm_VaJ-Obpm2OzTRQ2jsKQ93_RD935lGZ0-GM9WEHyfk4mo3_zdHnw>
    <xme:Xm_VaMPRT-RzLo54D4pVna5hVL7PiT12yjtYydbAtMViWSvxymN16ODui1h90GAXi
    9_vQ9tOrZXKZuTcY6jmZ2QfbriCnFSY0gDtn1VvVGjlGHaUOPkELA>
X-ME-Received: <xmr:Xm_VaN2dMdyv41KKtI_7kBkYMqmS4mfTuGy-9m_XMRjlAY17VG7TQyTwYbh5Vau-eXHfjKvKUrb4mr_94LaGtWBSUJZ-pos6510D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvdehie
    gsihhtrdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Xm_VaNcQF1R5fNF6fA5oicKaB42kH-7_VeghiWl9DmzwD96bxY8_fg>
    <xmx:Xm_VaGaTJk_-Ojpba84OSAoUSBV36FfBTNJD2C6lzdXboNnDP-kZhQ>
    <xmx:Xm_VaKXkGu5vio5YhlRPdNuJ45UoSiBlv2iAQFtIZc04ovv0PpSu1A>
    <xmx:Xm_VaBSeqEdf_Pjxms5XmJg3gDHmXaquwD1pOHFhaEVlXVf-qU4l1A>
    <xmx:X2_VaEvYSpbJQS6qTi-jDuHbt6O1lKfH80a29hrry3cF8PKU2OcCpzqq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 12:35:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 0/9] Introduce Rust and announce that it will become
 mandatory
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
	(Patrick Steinhardt's message of "Thu, 25 Sep 2025 08:30:02 +0200")
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
	<20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
Date: Thu, 25 Sep 2025 09:35:41 -0700
Message-ID: <xmqqikh6h4ma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series introduces Rust into the core of Git. This patch
> series is designed as a test balloon, similar to how we introduced test
> balloons for C99 features in the past. The goal is threefold:
>
>   - Give us some time to experiment with Rust and introduce proper build
>     infrastructure.
>
>   - Give distributors time to ease into the new toolchain requirements.
>     Introducing Rust is impossible for some platforms and hard for
>     others.
>
>   - Announce that Git 3.0 will make Rust a mandatory part of our build
>     infrastructure.
>
> The test balloon itself is quite uninteresting: I've chosen to convert
> the "varint.c" subsystem, mostly because it is trivial and does not have
> any dependencies. But it does allow us to verify that C to Rust interop
> works as expected, and to play around with tooling. All tests pass with
> the "varint.rs" implementation.
>
> For now, the series only contains support for Meson. If we agree to go
> down this route I'll also introduce support for Rust into our Makefiles
> at a later point in time.
>
> Furthermore missing is additional tooling:
>
>   - At least one CI job to verify that Rust builds and works as
>     expected.
>
>   - Tooling and CI jobs to ensure that we have consistent formatting via
>     `cargo format`.
>
> And probably lots more. As said, the entire goal is for us to have an
> easy playground that we can experiment on and develop the infrastructure
> incrementally without yet having to commit to anything.
>
> I'm mostly splitting out the topic of introducing Rust from the larger
> series that introduce it into xdiff so that we can focus more on the
> actual process of introducing Rust into Git and less on the potential
> features that we want to build on top of it.
> ...
> Changes in v7:
>   - Rename "git" crate to "gitcore".
>   - Some word smithing for the breaking changes doc.
>   - Punt on the exact details of how we hand over maintenance of the LTS
>     release to the community. This is something we can decide on in the
>     future.
>   - Link to v6: https://lore.kernel.org/r/20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im

OK, I see that this is with minimum changes relative to earlier
editions (like clarifying in BreakingChanges the release number in
which we started toying with Rust, and renamibng <libgit> to
<libgitcore>).  Hopefully we are getting at the end of the tunnel?

If I recall the coordination discussion correctly, when people are
happy with this series, Ezekiel's stuff (not the "xdiff clean-up"
that is to improve/adjust code that is purely in C without any Rust
component, which can independently advance without waiting for any
of these) will be rebuilt on top.

Will replace; I am hoping to hear positive reactions as well as
"here we want to improve it this way" comments.

Thanks.
