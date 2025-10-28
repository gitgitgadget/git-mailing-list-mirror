Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695C2AD32
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761624957; cv=none; b=psR5djTsGiOVTMNM5k9zb554MpaMwxGfB/nRxKtdx5JT/g7t8vWYnsKp67ThULoi7OlUu5a+jKcbHfcURQ86uF8AdZSyk2woFXst1O4+IBFpyngCUR2AcUmpfZGLB9hgWrDoS0ApqZ5uWzb7Ot7OKNqOvyzIup2NJ/iNQ3nQTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761624957; c=relaxed/simple;
	bh=KNjwr6mbza6PsEt6cjftONBiIpL9MM3hV4ujG2Dh8l0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmLvfKQnni2IvIieGBUVqYBQF4RlKU58dMof8yA9E94M9ft0n/rCA1QQw4Gt8zGarpWFZCaH2iqCZbSArH2Bwi8WcWsqlyj6KsB+NIHtWFDao5aDRR7OOhq0QvtU4JCM5s/6DBWH0p21ID1DW8rVVl/O1XTuhOBj+zpyuQYjWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lzICqUiq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wrnL+QxW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lzICqUiq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wrnL+QxW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7FF4140022F;
	Tue, 28 Oct 2025 00:15:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 00:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761624953;
	 x=1761711353; bh=P402tN+q0zrrGLLrWcS/BtZEXurYkyheG3a6DyteZGk=; b=
	lzICqUiqENfydiebmkEJjLh40QQ0izvIi1p5TUiXAoHgZ5pHvW1U9cAU/kt44TyK
	ixyueh22KRQBDp2170+RLKjaOysZ8n8shg36ORlhzDHrtOzbAzteVP7pQrsz+r8O
	iZecWZ8eZf7wjY+E75ixQtwPUyC1ECgNTGSv5xTVbZErnrF8iKoqXSq9tWARfU8X
	+6/AIvaKyybmW2Ajh28rqEj4i6Nj9VzyEIASfzIWeX+GEeyt63UixtofB/s+l4OX
	JhmaZBMVi95sKZJQRL/sYyBUPl8beFGzyYB+VYloW8tOL5WlgcfSoTYQhow3uiDF
	wW/ximxzN8/N35Zg/XY+6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761624953; x=
	1761711353; bh=P402tN+q0zrrGLLrWcS/BtZEXurYkyheG3a6DyteZGk=; b=w
	rnL+QxW3NThPUz5uwjfi5YhCfy3gwkoeSX5DT9TNEtceifjLjXCQ8LNZqGYfJdKj
	CbI/8quujerO4j4038UoVlQvmpoOEALemX0Y4ogQynbgEebwYs9o++y13OBPC3BA
	2DVerRyAEWFS+bs0Jmh/n374fXLX6/SGcdkglT0AQTyV9mG0HE8UAgh4YSOs3uus
	Z+BdBv9O+3AvZCCFdOm9hrwwqq1tcgHjX4pfYZ0389WGl4zCItKYIZ3fNctrQQLf
	D7hYftnTGHkD2qrCvx+cXEVd77EIt38NmNURbmcpc0QE8a8fRPRLXfwu033/Ty2f
	VXkNlipGVjwcA0NMUwAUw==
X-ME-Sender: <xms:eUMAaWex_NN41MzI-nD2ZVBCZ65sgg2BjGWAOsC50ESANDwlJwuOzg>
    <xme:eUMAaXH5GkL-J2aICkrdspkKbbWIkpr9XvAIxuS-rLnWiwwnrm9gh0sRaJ8P3dEws
    LhKUp5eydhYME7kzda0xAcpavqC5i-QgVY6TjHjH_dfuLn0Z7df>
X-ME-Received: <xmr:eUMAaf1N1va9vs0Csg0dXvnf8j24dmcW0oZC21Vzhon939EZFDfCEOvVUK5pGF9dbT6gtEM8c9gqYo9QwBjDCqw61MEVuoZgc-Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheelkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    vgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eUMAafmsLXTG6pv2ACYgu9E6pcFUZdfr1gYsntwGaffW4BMlzSyTKQ>
    <xmx:eUMAaf8YfBlP4q0rad-PkMoT6at9osLqSmi7ubWvfNWkmTmKviFSBQ>
    <xmx:eUMAaUoYXIkmKTFkdIa4qycjC3mrf3Zn0wVbgqB7qnquugQyNibfzA>
    <xmx:eUMAaYkbeiCklpP_WQNmkZReCb9FVmb_FCc6J0JUFo1MBAir4N7J1Q>
    <xmx:eUMAaSVKZs9geAZtP2_HIHShKwh-bYk0RKuw81TXWOj0ogOWLNnjGsDr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 00:15:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
In-Reply-To: <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 27 Oct 2025 21:14:51 +0000")
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
	<20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
	<CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
	<aPsepOtUf92fqDL-@pks.im>
	<CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
	<aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net>
Date: Mon, 27 Oct 2025 21:15:51 -0700
Message-ID: <xmqq8qgvfyq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-10-27 at 20:35:59, Ezekiel Newren wrote:
>> On Fri, Oct 24, 2025 at 12:37 AM Patrick Steinhardt <ps@pks.im> wrote:
>> > > cbindgen is a Rust crate and it should be specified in the Cargo.toml
>> > > under [build-dependencies] block.
>> >
>> > What is the benefit for us? The generated code is not a dependency of
>> > the Rust code, and neither do we use it via "build.rs". And if we use
>> > cbindgen via "Cargo.toml" we'd be forced to build it first, which slows
>> > down our CI jobs.
>> >
>> > Please let me know in case I miss any reasons to have it in our build
>> > dependencies instead.
>> 
>> You're targeting a very old version of Rust (1.49). I'm not even sure
>> that cbindgen will work with a version that old, but if it does then
>> we should use it in build.rs to make sure we're not using any features
>> of cbindgen that aren't available until later versions.
> ...
> For instance, I'm using Debian unstable with a system cbindgen 0.27.0.
> This requires Rust 1.70 or newer. If I use rustup to test my code on
> Rust 1.49, then the code won't compile for me.

Have we even agreed on which Rust version we would aim for?  With
BreakingChanges.adoc We have agreed to make some version of Rust
mandatory by the time we hit Git 3.0 but IIRC, there isn't anything
written down except for an old message from you

  https://lore.kernel.org/git/ZZ9K1CVBKdij4tG0@tapette.crustytoothpaste.net/

that expressed your preference to support the version of Rust in the
latest Debian stable plus the version in Debian's oldstable until
the latest stable has been out for a year, which nobody responded
to, so we cannot quite say that is the consensus of the community,
yet.

Given that the stable/trixie was released on August 9th, 2025, we
still need to go by oldstable/bookworm, which has Rust 1.63, if
people agree that your rule to decide the floor version is sensible
(which I would say is OK).



