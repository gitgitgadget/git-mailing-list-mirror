Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2D34D90E
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817863; cv=none; b=BaXdsvCabiVElGdC04EzWPJ5SxDC/D0Nr+M/Fr+C82tEe3BY5bE/btddHN1W8qOFeFNst25agM2ZOBjN8ql1HeQNVvsNqVbtCHHmDmEitsnG4NnX3AfcuHOGLAgSrUdHQjDY2xV2YszgsskC68vYxouV4E5X9FGBlXRjXXja3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817863; c=relaxed/simple;
	bh=oY6+go+rh/vYBljRwQQv4gou5W9YgSdGTHZ4FbUfkwk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNxsLGElYnS0jHm/VtT3OO3iT+KW+IOEcKOPgG3hGjI79Ni+D9SsE3L15twUyFf3tgzTRvqmOI4qB5SyfdcJAKJHn3cSJJLSkhZVW0ifWnaKB0WSMp3t0iWjoBqIVv6hDn7ISw7gUoj3YwQ0fmJVdYBALM30AIHaxSSRJEHsjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SNXsdUQu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rgk0fMvS; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SNXsdUQu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rgk0fMvS"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B4225EC011A;
	Thu, 30 Oct 2025 05:50:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 30 Oct 2025 05:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761817859;
	 x=1761904259; bh=WPnkCR8kO4G9xx93ItWPl2LCvfum6rzying+4M9TmXo=; b=
	SNXsdUQu8VIeRzEb/yWjobIKug04Ke5b1oiXGGNnVcdUPsSUnDtYOhOgXv0akeu0
	7VH3tfuonvbyGPvO+3DOO+P9J0kT/yByHCpJ2yDp4zbo/DgY6vnSAsRky3GmgD3U
	Yf7ax50/7Nhgkinlp4u9HtMaqBo7lIOAaX5bvkN3YbdQQxfIcE4UnBOP0s7Zt0+o
	Q4wlk1SQAdVPKWcdkhd4x8An2PRffupaULvF7RR/+Bzxnc5bUgZxOJGwSGF8BppC
	lMg5NsDK4Vk2X06kon6W48QHIN5nu23TZgdJyxizE4TEluwFgexAee8JSHYI0Hsf
	6O9VX/f6XAnjsLugXf+PhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761817859; x=1761904259; bh=W
	PnkCR8kO4G9xx93ItWPl2LCvfum6rzying+4M9TmXo=; b=Rgk0fMvSkqa7pd5Yr
	5btcTaC9LjVIKBtL1uoveaq6FamlSNLQhG6wSX+JUwv5bBpRi8gLN93g8+jHAlsI
	/pCgVF3H6pXUaVIM7MCHLk5gzsRQlnHFveV2UDkMkWVM+/GlpyM6RrqT9H+kiMwY
	U9FI2EGCRaoeB8SzEkAZayazWq0b0lL/imw2lvBnu8EVw529+z7m1jTYASECZZgN
	BRi+qnXqsRNVpaBXymAVp5ymcK3rRqnQAgjjav7vvYebc6RzDcI0Q32uHF7V3erN
	dd95ff0o0pqphh9JLmzi4GT2Yic6CDr6fo3uO21zahOSJjCAeurF/gqEDmNMLgi7
	iTsrA==
X-ME-Sender: <xms:AzUDaYzvHRc_Syde6MCedgeulYvLERhCkbN3wM5lLUtDDCcugiWJkQ>
    <xme:AzUDaTu-2KtnUjfyAycFduxEqJWgawwV7euxMm1BSuUMRCG-ncME6yoxWbIKw3J4F
    6bCNCyywj8E9sB4q-UlVYp81hXWgK2rYeHZBhLILLl0zpX0JTJbsPU>
X-ME-Received: <xmr:AzUDaXsJFKOjpXDRqi6AEEF7Vfknu_0zv0-ehm91phD7YJYesjUNynunfaHJsWLvmpY01UCVMi1DcbFjHbIqyd5tEPNGOqVn3iqjVVkMzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeivdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epleehfffggeeiueefheeitefhgeevjedvvdejtdeuudevvddvtdektdfggeejffeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhi
    vghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AzUDaQMPO8CSELYF1znXqudc2nsJi_-fB3kJfzMZAh1tryyy9DqjeQ>
    <xmx:AzUDad2Rx8NR1077gpThR3sRJ1qWNlrF4Ptk3QZxLnQyK1rBtVsb3Q>
    <xmx:AzUDaUMqU9GSlggUoG9FPdIKrhlMMQ4RpPcovBWz0vZqIoG97gq6-A>
    <xmx:AzUDaV06-FW9zFNpETt9ljn25ErnHxahBGNC5BQCl9ydgDIHnV4ApQ>
    <xmx:AzUDadaDrG3qswjXPEmcvsLkhckDc24XZfXOd0Xa5v-ZdeyfGofRJmGo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 05:50:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b789af92 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 09:50:58 +0000 (UTC)
Date: Thu, 30 Oct 2025 10:50:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
Message-ID: <aQM0_6uRZcQYfO8R@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
 <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
 <aPsepOtUf92fqDL-@pks.im>
 <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
 <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net>

On Mon, Oct 27, 2025 at 09:14:51PM +0000, brian m. carlson wrote:
> On 2025-10-27 at 20:35:59, Ezekiel Newren wrote:
> > On Fri, Oct 24, 2025 at 12:37 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > > cbindgen is a Rust crate and it should be specified in the Cargo.toml
> > > > under [build-dependencies] block.
> > >
> > > What is the benefit for us? The generated code is not a dependency of
> > > the Rust code, and neither do we use it via "build.rs". And if we use
> > > cbindgen via "Cargo.toml" we'd be forced to build it first, which slows
> > > down our CI jobs.
> > >
> > > Please let me know in case I miss any reasons to have it in our build
> > > dependencies instead.
> > 
> > You're targeting a very old version of Rust (1.49). I'm not even sure
> > that cbindgen will work with a version that old, but if it does then
> > we should use it in build.rs to make sure we're not using any features
> > of cbindgen that aren't available until later versions. If we use
> > cbindgen that is packaged with the platform then we can't precisely
> > control which version of cbindgen is being used. This is a matter of
> > reproducibility. There may be platforms that can compile Rust, but
> > can't generate C header files via cbindgen because cbindgen hard codes
> > that a certain minimum Rust version is required in its own Cargo.toml
> > file.
> 
> Yes, I agree with this.  Not all systems have cbindgen and it's not
> guaranteed that the system's cbindgen will work with the version of Rust
> that you want to target or that's being used to compile.

Okay. In that case the question to me is how to drive cbindgen from our
Makefile and from Meson if it's going to be invoked via "build.rs". It
doesn't make much sense from my PoV to make generation of the C headers
depend on building the complete Rust library. Doubly so because we'd now
have a chicken-and-egg problem:

  1. To build libgit.a we need to have the C interop header.

  2. To build the C interop header we need to build the Rust library.

  3. The Rust library depends on libgit.a.

So am I missing anything obvious here for how to declare cbindgen in our
"Cargo.toml" file and invoke it directly from our other build systems?

Thanks!

Patrick
