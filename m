Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15627E1DC
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759935; cv=none; b=fBFFwDM8p+89NyffCIxQxwaU25xyJsTOTSEwnjwbeKk6x8bDpD5WTME29DbVABW7T8juQ9P0AN+pu6pm2OGWeknojbu2q8MAwtdiPniDbm1zNU6r2kinlUrSgYOW3yZUqLJyVFPV1KnK33ZKrSfkAx2fcys+j2tMesys0EZXPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759935; c=relaxed/simple;
	bh=Swh+mzyf5Fxc4m6SiKmOWHR63vh4XIo7Z0YLdS/3qno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqU1SN2KPFTYckNaymey7gypIDmjJL5FhzdarSerub1RF+/dkkrGWnccQp4XF4/RzLlEuS/HRGpaJ+og6hvB1loSaDus54nA0t5kq1AvRVTHrx/ACknQr+To2tmvDycd+6DU7B2beYVQUSUG/o9G9y0oYMZf4Y/kXBrKNBs+lSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=laVwS7gD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZqRtwLoZ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="laVwS7gD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZqRtwLoZ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C40814000A2;
	Thu, 21 Aug 2025 03:05:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 21 Aug 2025 03:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755759933; x=1755846333; bh=x0EpIRcUoc
	LyywZh2ZRBJqIwdHTC6TIWGJm7mhjWW94=; b=laVwS7gDiKPYEItiV+DEMaCVBb
	lSIc57bHFHh7h6sTf8Gq5my0oZlCXLEGjB5v9zDU6cBnS0eE6gx00iMgHO6/Re3E
	o1QLjyaXHhkEnyUslVN8e0OpxRW6ke5YvimShu6gvThDEjJA26EcNUXi+shtT6S6
	w35N9JVpemWXv8PtbXgfArRE9IbN9qy4GlZv1OV9Ib+vrLNqcY4GdnOBffb8SPaF
	JnllnxjyAq1w34hnOJjlww5ADtw5337BE1Sh66lQOnVQg2EcTlV1h1pOFkj1gQK+
	EslfJ6nD98DSJ9nod9W0reudLQQyDkD8EZ/WD7ALuZdwVoDoIeFGEeVQYsUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755759933; x=1755846333; bh=x0EpIRcUocLyywZh2ZRBJqIwdHTC6TIWGJm
	7mhjWW94=; b=ZqRtwLoZKU/9+IQEk+L4+52jYUX03N8kqiOCY2a7bEhZdJKX5yE
	FocRm08I9i5zzVVvY2qR4O4Z9ZENn1dcRE+o7HPDCnF2PnliE8XQCty+bR3HM9/S
	ESHH+phS+9Uk7yHF+sOZB4xNwL5NladOA1rRYNqEJLPGjVP3jWki0P++bvA24uGJ
	q2ga3BqNzYfFDVvTrta028TfVkmbSFqDyTRHSXefwzACwMo2EeO1SbiUrdSAdPXA
	rgR2zdWw23ZGXUgFWvAxjvwVsWhDFb/t5HXwjzuUhS/ffFx56JjOmt1k95vjDOg4
	+MSfFfmpY8MHzuN3YTLVZ1rgyOaCEVk13cA==
X-ME-Sender: <xms:PcWmaG7ZMoP5fWzgHBhRwE1kSkteOxOr1pHnmRUZTgvnhgw22XxY-w>
    <xme:PcWmaDJw5ZXCseiWCB1Bu9pK2hN7l__ztKPYdaWXpxlsBgE79E3xyzV4HEEaBPJtT
    emnTzfaYL9OVFqovg>
X-ME-Received: <xmr:PcWmaO40YKhkZF1DoFtETphUcyh46XjPCOlhdlvW8exrZYqjQdzRKWC4lXzoOXypn9VZLCadcpsPA0FOVTqQ4ubTFIh4_nTInHXNkrJB0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheegvdduvdettedvhffgudekleelieetfedvjeeitdekieeigfdtvdffleefvdegnecu
    ffhomhgrihhnpehjuhhsthhinhdrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PcWmaOzYTbrhBC_g4R1F23esm3LVOUkPp1UhymcYsXIedqUHLFJBwQ>
    <xmx:PcWmaKblKvCU_7VXypyK1s-J-CJ2UJKinBTATLfNEbghzqVYvhnu0A>
    <xmx:PcWmaIT1ceN_GMOJO1DI1oPBNlU_3d9_3bZUoo1kHdzGZn2ym42TyQ>
    <xmx:PcWmaMzh-GoRgMF-L65H0tsEr_9zALo2raJ7rerTuIrg-xlLcDU26Q>
    <xmx:PcWmaDxXQz4LMGx8zzhcf9YQpRHPQMoISr_nAaCiiI4pjaoTRNX1Yt8d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:05:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f057c4ab (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:05:30 +0000 (UTC)
Date: Thu, 21 Aug 2025 09:05:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2025, #09; Wed, 20)
Message-ID: <aKbFNq_pLasQGjbc@pks.im>
References: <xmqqo6s97e3t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6s97e3t.fsf@gitster.g>

On Wed, Aug 20, 2025 at 04:44:22PM -0700, Junio C Hamano wrote:
> * ps/reftable-libgit2-cleanup (2025-08-12) 8 commits
>  - refs/reftable: always reload stacks when creating lock
>  - reftable: don't second-guess errors from flock interface
>  - reftable/stack: handle outdated stacks when compacting
>  - reftable/stack: allow passing flags to `reftable_stack_add()`
>  - reftable/stack: fix compiler warning due to missing braces
>  - reftable/stack: reorder code to avoid forward declarations
>  - reftable/writer: drop Git-specific `QSORT()` macro
>  - reftable/writer: fix type used for number of records
> 
>  Code clean-ups.
> 
>  Will merge to 'next'?
>  source: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>

Yeah, let's merge it down. There's been a couple of reviews for previous
versions, all of which only required minor changes, and the current
version was ACK'd by Justin.

> * ps/object-store-midx-dedup-info (2025-08-11) 11 commits
>  - midx: compute paths via their source
>  - midx: stop duplicating info redundant with its owning source
>  - midx: write multi-pack indices via their source
>  - midx: load multi-pack indices via their source
>  - midx: drop redundant `struct repository` parameter
>  - odb: simplify calling `link_alt_odb_entry()`
>  - odb: return newly created in-memory sources
>  - odb: consistently use "dir" to refer to alternate's directory
>  - odb: allow `odb_find_source()` to fail
>  - odb: store locality in object database sources
>  - Merge branch 'ps/object-store-midx' into ps/object-store-midx-dedup-info
> 
>  Further code clean-up for multi-pack-index code paths.
> 
>  Will merge to 'next'?
>  source: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>

There's still an outstanding question for Stolee [1] regarding the
`--object-dir` option of git-multi-pack-index(1). It would be nice to
give him a copule of days more to chime in. I've Cc'd him now.

[1]: <aJUn0qeliNQ/nnWr@nand.local>

Patrick
