Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64382F618F
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017190; cv=none; b=PIgtZDj0+IPvGYtm0/gHAveOOosLduLO5U1UgyHaUzMEtGmZ+oHqKBNXAtNU8XvusGro/gSgzxDnG/QNxl2F8djm8irj9phszz4RASmADgFTX2EB2b2T/vUNtKO771Y0GwMwmg2gwu9Cq37n6WPgO+65a0KTtvwBfQ+IvXiDlKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017190; c=relaxed/simple;
	bh=rbTe9dF85f4F1l2iI2kvWW4lb/nJdX0Xuhs2+be5TVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRekWZJ09jq8W8h4XVlxuNLSoHc6SHVckAi+xE0qDzsiFPY6B4n2gU9zFwGF1rqyQB2exKKNM/VoK63U+8KS56V81zlqww2c56vZ22R4Alslt4lKzSRYkQ+Psr1NiMDLZNj7D9LlW/fb17B2A+7S1hKfpfbREtxx+uv1c4N9rkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HDLnA5KD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYsFawvV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HDLnA5KD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYsFawvV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8704F7A01D8;
	Tue, 16 Sep 2025 06:06:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 16 Sep 2025 06:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758017186; x=1758103586; bh=QNQXj3Ueeq
	hmDj6P5AFZ4rmeMo06tg6KOLIEPopTDtQ=; b=HDLnA5KDc6y5gXeldr62qc9X1E
	EUUo9xeklUcZs4EvZvZwp2a3Xo5R/bouEmXjAGBw7tI8iCuExv1TXjlhHmqhgpW0
	tlR/L9m3Cw1eYbZ/DbKV59VRz7KaStQhIi5/GLS2E98a1V98p/aNEw+8O+rNCj7u
	FaWJuGSuWXBL3EVOtg5W4KjslbUnbcjUZC4+CnlDgJ6LTrVYjRoNm3cXVlAaLSVB
	O6S3/2P3EtjBdK47/HR21oHf7xTOhWW8lbijcM6s0Zg0xFkoweSvFn/KvB+fMxez
	x4wXkqfmaRejEZ7KmMwcGg2HNKXIPJdzxijZgpkf+g0NIMw8V3Zr1VYl+Alw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758017186; x=1758103586; bh=QNQXj3UeeqhmDj6P5AFZ4rmeMo06tg6KOLI
	EPopTDtQ=; b=QYsFawvVbf32rzmMd9YTJfpQjcxhf4wxk8d4LMhMFOQJh0pSF9R
	PZfflzxbsKcSBAODc88p300uZ0LSvqqQWimanL4y14rvv7lnC0qUKoE4OcBeHCTC
	SsRyExz8UWyjtezlOd9kn0oHgXm1CPobmlrpqx3vfGXDSpe99IbWtGpUwTmzdo/d
	40SJZkkbaN5YKDK/EyRSTXH5fNSC/PURHFbv3FgZ9f1aghiL1becIGy9IKsF91wi
	AQnj5kXWz+Cbx9GSybojHfG4MtSFthK4xnlEGJBQP3ZXxYHV8z7bC+RPQG5xiZYp
	JW8mwgDAvCgpbpXWY9/+UUaC5Z8kHo5XYZA==
X-ME-Sender: <xms:oTbJaPK0e74MK5urfW2m0Pz40LRaGe1XrHghj38-_X6h--j_AlS10w>
    <xme:oTbJaKtG50AIjBpUXed47TdqR6bP0c9F9A5mO7BP1dgbaDshJrdFNBUpVN0b-uR8L
    xftg33_ezk7bswwgA>
X-ME-Received: <xmr:oTbJaHXDRfbFhQzJxjcAlbCVT7Rg_PnmdMqKEQylmes9ohmrROr8fwpOvLfro_d-pJHKnbBp8pd9GK2PKiX3_3OB1qUObn5MPvEufXguY40>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhg
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghonhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepphhivghr
    rhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpth
    htohepshgrmhesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:oTbJaFK23uImQ-t9mRLBm_NeuB-UZNunL3TVwa-cvqzPxTdQ3H-Png>
    <xmx:oTbJaM_UivSvDCqUCf8PgwrpE4ffAFEd4eEc3NWolPvdt9gU5UE2Lw>
    <xmx:oTbJaDPUqGqLnaAmg3BKmvDR32M2RfGiT5_3OHHACAfO1Aa78mkVPw>
    <xmx:oTbJaI1HiGcLFRVdPhbqMaRORELSLwhK9J3vmzMAvqK_y7wYP0MuPA>
    <xmx:ojbJaFe-xKEBIxetObdJ03J22soCiXVFU8vXMiZ3UGvlRzCFRSByimVp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 06:06:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 828199b0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 16 Sep 2025 10:06:22 +0000 (UTC)
Date: Tue, 16 Sep 2025 12:06:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 0/9] Introduce Rust and announce that it will become
 mandatory
Message-ID: <aMk2mo5OHPNQi0PW@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <CAH=ZcbB0Qv=b-hdB2EVW-D-dob4NnzyWDYGEThYZm94S0V7OGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=ZcbB0Qv=b-hdB2EVW-D-dob4NnzyWDYGEThYZm94S0V7OGg@mail.gmail.com>

On Mon, Sep 15, 2025 at 08:03:29PM -0600, Ezekiel Newren wrote:
> I am currently working on a patch series that makes Rust optional and
> addresses several concerns that this series does not:
>   * Rust calling C: Makefile has no way to build or run Rust so it
> would have to call cargo test, but that doesn't work unless build.rs
> tells cargo where libgit.a is (among other things).
>   * Build tooling alignment: My build_rust.sh is called by make and
> meson which eliminates defining how to build Rust in 2 places.
>   * Cargo vs Meson: Meson is adding support for Rust and it's getting
> better, but Cargo is the canonical build system for Rust. cargo is
> released in lockstep with rustc, and we _have_ to use cargo when
> building with make because Meson won't be available in that case.
>   * Crates: Patrick's series assumes the Git codebase is _the_ crate
>     * cbindgen: Cbindgen outputs a single header file for each crate,
> with only 1 we'll have an unmanageably large auto generated header
> file.
>     * Modularity: Using multiple crates makes Git more modular. Elijah
> told me that there was some desire to make Git more modular.
>     * Cargo Dependencies: Patrick wrote his series with Meson first in
> mind which doesn't address how we'll be able to use crates from
> crates.io
>   * CI:
>     * Sparse coverage: I think there's only one target that tests his changes.
>     * With vs Without Rust: I don't see anywhere that he covers
> building with vs without Rust in CI
>   * Build integration: Meson has to have every .rs file specified
> where as the default layout of a Rust project allows Cargo to just
> know where to look for .rs files

Yeah, as I mentioned my patch series here really aims at getting an
minimum viable user of Rust into the Git codebase so that we can focus
the discussion more on the roadmap towards Rust rather than the actual
Rust infrastructure. The whole infra is very simplistic because of that,
but that is intentional for now.

Once we have agreed on the roadmap I very much expect that we will
iterate on it to allow for more complex use cases. My next step would
have been to pick patches from your series that make all of this work
on Windows. But of course I don't have to be the (only) one to iterate
on the initial simple infrasturcture, this should ideally be an effort
by the whole community.

And yes, many of the points you mention above are things we'll have to
address over time to make Rust a viable alternative to implement
anything more complex than the trivial "varint.c" thing. I think that
iteration is key here: let's start simple and then gradually build out
the infrastructure.

Patrick
