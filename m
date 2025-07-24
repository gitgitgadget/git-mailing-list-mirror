Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BF2737E7
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344012; cv=none; b=CJW/ZfvehmqbMC5hSNhzWlFa08dxK0n0Du3nzpNqSvLeEH3rfQ1sGcQn7AZIUo9V56UErOV2CgP8CILaCMyqhxlDMksgQNSsE7PzVfZKgfGDJ2hCz4nbab0AHioZL9y8WlvfIfmU72xsDb0jGdC0jhgjVT6VSPpxOGjfHILkn6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344012; c=relaxed/simple;
	bh=n57NuMcqqd9j3WvEhtKpNXCl720TeMoarPASayXjosk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwRdfFvoDcmqT8P8gY1UlymG3M4iXnn9lqydW5KgOt9fw2aJUk1ks11QSh+LUtW0dZTCTJ1gwBO75UnZNufuotYAyjFD8rthr9sI282+i0bNsTSKnx2imFOjZ+lGd5ZaoUwNiFKqPPgDHz1VNPRFVHQW3CN54BoNZFnq7SlMQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kDAaDN1f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h8adMLYk; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kDAaDN1f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h8adMLYk"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 46C421D00140;
	Thu, 24 Jul 2025 04:00:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 24 Jul 2025 04:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753344008; x=1753430408; bh=VICR63mO8+
	/XuWomTbQI0vEFLpyeA8gjvp38sKS4AgQ=; b=kDAaDN1ftO+z122p3TLjTpr9j1
	FjCIlZgWT6gX+hByd+e/yvFGFOsxau/slI/JnAITTdweWKJ9+zVsWHxaakCzk0rl
	PECVXELpZmUSJLX07lcQQgezesz9FcMi0HeQuu9J/W5ItuinD2BerY+Ru6jVAfRb
	575MkVPV1qVJ1kOVr2JiGwLzyLJpcf313oGSBJlWsEoG8waUz2BbaVjdI1qelBE5
	QZGTDPb7lodJsoqOMXGkLLSEOsGht6D64Qf7pq0CPwPA99buEdip/NYaKAk6n4yZ
	0rPS0UEztoHg3J+TUf3Ef1TNFBcWwsxyeU/Nrz6TqvPvtMUyLsmyY7S9bn9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753344008; x=1753430408; bh=VICR63mO8+/XuWomTbQI0vEFLpyeA8gjvp3
	8sKS4AgQ=; b=h8adMLYkUxSzbWE7+nj7A5ICBHlHBUvnBFBBUxnZri1Al6U3h7I
	Q5L+sbL4iCeF0M7Bb1Dd97vr201z3EjnyJfp2WFiuCzHhGgm5wT7vZtO4bP4sizW
	s+Ljm4hhONdnGSK35N764eo2y3Lt/enA4CjluUas0K4+0BjumfQk3NF/5lSgWa3y
	Itirv6Y8moFPhea25NAZ92WqRF9vlg6/MBPcJsDR2qwbLlNQL+MNFGRcqtk2bLzf
	EDW6U6Neizt7vHw6oTjxa0uWabSl6k1TgjpWhT7NKap7YS6zlT7nlQCB0LbtYod6
	yqDUdeH79G2BijpSPb7+caceiyqVn2HHx8g==
X-ME-Sender: <xms:B-iBaLUKSChHdN4qk9FuLSHX-orf6cIz9PrG2KVZ62c0xib4t_LIIA>
    <xme:B-iBaOI6ESNYQVJE4UUMgY25JvrLU6WQ2Ud0_Elv-YI_ZAAUYm15iUhz4XP6yX14n
    kIT37mZfzXf8WAwFw>
X-ME-Received: <xmr:B-iBaD8stYaC_xP59L6JTsQ7y-pHm3Guuk0fvpfSyPuvrUw8G1_e2_8AXptPJOpVHp0HnJ5nVswEJVsD0TN_7Wq13H3aunZyJ3rdpklMoiU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejvedugefgffffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomh
X-ME-Proxy: <xmx:B-iBaJKmOToV0VHA7fvqA53NgDwLAy10CMPydbH7dOnQYBiUepNmyA>
    <xmx:B-iBaAlmYQ8KUZ1aAgpUf9LJBYbL7h9UfQm3sePy403KXXbI_l3j3Q>
    <xmx:B-iBaFObW3RqIFPvZIkArVOZWvXgkNYV4H0R5cDDPklJdJdxNxxSUw>
    <xmx:B-iBaO2aPh7dWiTasQ6CIRe8QZ_bDCZFvY8yc_YgaJt6Vw5fpURF1g>
    <xmx:COiBaK4Vd2Z85lP5geQEHZvh3oKGYXM60WrnDi8gOJWQ-xHSY8iujn80>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 04:00:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7af8e01c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 08:00:05 +0000 (UTC)
Date: Thu, 24 Jul 2025 10:00:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/7] odb: track multi-pack-indices via their object
 sources
Message-ID: <aIHoAiakZr5i2psM@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
 <xmqqa54umwlb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa54umwlb.fsf@gitster.g>

On Wed, Jul 23, 2025 at 02:22:08PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Changes in v2:
> >   - Changed the base of this series. It is now built on top of
> >     a30f80fde92 (The eighth batch, 2025-07-08) with "ps/object-store" at
> >     841a03b4046 (odb: rename `read_object_with_reference()`, 2025-07-01)
> >     and "tb/midx-avoid-cruft-packs" at 5ee86c273bf (repack: exclude
> >     cruft pack(s) from the MIDX where possible, 2025-06-23) merged into
> >     it.
> >   - Re-explain the split between object databases and object sources
> >     to help readers out a bit, given that this is a rather recent
> >     change.
> >   - Rename `struct odb_source::multi_pack_index` to `struct
> >     odb_source::midx`.
> >   - Fix some overly long lines when looping through the individual
> >     sources.
> >   - Drop the patch that guards re-loading MIDXs, as we already have the
> >     guard via `packed_git_initialized`.
> >   - Remove some while-at-it changes to make the diffs easier to read.
> >   - Link to v1: https://lore.kernel.org/r/20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im
> 
> Shall we mark the topic for 'next' now?
> 
> We haven't seen any comments on this iteration.

Almost all of the comments on the previous version were about style, so
nothing significant has changed in this version except for a couple of
renames and style fixes. Which means that I'm fine with the comments I
got for v1, but I wouldn't mind waiting two or three more days until
this gets merged down.

Patrick
