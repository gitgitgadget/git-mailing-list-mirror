Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC941E3DCF
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423106; cv=none; b=k42FQUHqV8I3AGBY6gG4S5lIqrvIEk0YCT9B09Pildv+kPH6oaA1CJawGey4awD8cvsgrqOVU074BF9UJzRm7Gpj1iADcLYT+nZDFTj4A2LZvqzcXwZZoSQah/C3DeEpePZCf0gVaF76zkZGokMEp2LrgNdw4fHRaf6UxgN3B+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423106; c=relaxed/simple;
	bh=Nrm5cngmJ9UkZAyk2ZwNlMlutj5RVhgXeSlltzQ6z7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qoDElwKdI/1uBoiMpRCaijwI1aN07qEMBWNsjDvK5VfO0aZ1f1jIMHLtdUf0lB9QUkpM9mWQeJm3wQTcGZkdM0FzwRayn/IfoSaeq2Pd9mi/qWFaX2P2B2JVii9/hoVR6h/k5wGhwQ4ajAWMtfpnLsvjtYlHYyaIgq83XMyH3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FRXfhqnX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IN1mzRiV; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FRXfhqnX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IN1mzRiV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 97AFB1D00169;
	Thu,  2 Oct 2025 12:38:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 02 Oct 2025 12:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759423102; x=1759509502; bh=mPeJgBNHoV
	bgIYAWwlPv29XgG4AGqWKg6ljB1Jkrukc=; b=FRXfhqnXAqY9ThH074DxVjkzQ9
	xOCswvWXCEjryttcYPjqyTwnrtwgOpPqG4i/UfrkTBdkq3+uFwv4QHdTNfcTiLlR
	a5TseO6M3syeBJ/hqkGpgsFl91Sfo5euk0vf1ShP90Jkz0SFFOu1dQGw8e31GuDU
	p5j0HWeaVKbzlbIxkp0S3P16jVjt6fS9qclSPDh9fZ2LQadlx4YKdiWQlXi+V0PP
	KEZxD2wtfZDoqBssvobArOszBqxi+adIYpSQ8Ip7yrz7rGWCsJQFfCZ7h8jSHNFd
	nYoTi3HKJnZwCiZwXwAJsix31C1hxyhqxBWZql/e5LtsIsdib043JwtzYbOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759423102; x=1759509502; bh=mPeJgBNHoVbgIYAWwlPv29XgG4AGqWKg6lj
	B1Jkrukc=; b=IN1mzRiV0o6/rXTuIu7il8TJ8mANiTAIsne26jQBQdhvmWSWFVR
	eMSt53hD1ixt3fPN3UEp8KE/nJUBzsnwb1uOoijhAHbzxX3x30Y7VKPOEvLvgLS0
	W6vMpMDzu2ILwSr70u+KHFOD9I2zjL8EQ6487cJzCTeMYp6BZtx/lX/MQu2HoUy+
	6v56lh7p4citEEd5uUUCOuB/pRyeozXcZs5MNKk4WTt/aTOglEnH0RY9wKQXf4XG
	fPxJEdWgBdDIMFGH5oWXjXev8iAMu52nWxPgipxM9RhHIKMae4vIATrDUsJll/QJ
	3tJqHLyk0drjAiZ9aFv30xKOEkkW0T8e9eA==
X-ME-Sender: <xms:fareaAGcuDWjZh4uKQskTMfehPGqk7j8YdApBm6ZmYIeZJJM6aOz2g>
    <xme:fareaH2QNUoamdwJn_9xy-Jl5L5Q0tWnrK65qGSXmJcTsxa5-Zbin8mUP7gZDsKkC
    yCK5KOBPufD851I1JsoXuA03hcr5jhvYY-eM_EPvWsvsKYaJtWqEP0>
X-ME-Received: <xmr:fareaA_v1sda33DRCxPOGtdIjgp4Eyn2meQRHNckQBZxZVyoCIMHORbKZi4AEFiQl0lAaZVOks3Rs_81LnBpUhrB7Ybi7o-3YO1y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieehvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:fareaCGPhWa7vtPY0s8LaHpq4VSMCPhYOshwzHFhCRYXl5jbN_SVTQ>
    <xmx:fareaOjU4AW9HIdnpuLT7wxdu-xSYfxLxf8VGkDK13ykiKBHF6BqrQ>
    <xmx:fareaP-UGzK2KkrvAtZ2Fv6LB85RG5diUBirmTduAC_vxiqtoEtS3g>
    <xmx:fareaGaQXHkNUUAdL541SEBjPLDwR29bQh7JvAJckX7K-a3S8TVW0Q>
    <xmx:fqreaBniLA7cX06IL-_B96Z5pKTxhfQ9hQI7N5dIo3TwEX6dM__To8Qn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 12:38:21 -0400 (EDT)
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
Subject: Re: [PATCH v8 0/9] Introduce Rust and announce that it will become
 mandatory
In-Reply-To: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
	(Patrick Steinhardt's message of "Thu, 02 Oct 2025 09:29:25 +0200")
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
	<20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
Date: Thu, 02 Oct 2025 09:38:19 -0700
Message-ID: <xmqq4ishxnr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

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

Keeping the initial part of the cover letter verbatim is a bit
confusing for those who have forgotten what they read in previous
iterations ;-) I think a more recent iterations did have Makefile
support, and this (hopefully final) one, too.

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

OK.

> Changes in v2:
> ...
> Changes in v3:
> ...
> Changes in v4:
> ...
> Changes in v5:
> ...
> Changes in v6:
> ...
> Changes in v7:
> ...
> Changes in v8:
>   - Some final typo fixes.
>   - Link to v7: https://lore.kernel.org/r/20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im

Indeed.  I have a slight preference to see these "deltas" in reverse
order but it may be just me.  I can read backwards, especially if
each item is small ;-)

Thanks.
