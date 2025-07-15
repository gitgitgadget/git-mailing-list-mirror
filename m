Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56595274FD7
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568005; cv=none; b=UQKUrKZNwNyhvD+VO/tWLxcchcfgbKhnYbHuujSBuEV75AQMFn6vI5avNQssv1nKiQO6SfHTogrWBF/Pj0ebVoRw07qgzkkVF0tSTcfzNAQjMbbxvxnwCJdX0uwRG+xIlCWS3WYCqdoOn0nLztksUhRpiC4iHTOytGdR4qFg8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568005; c=relaxed/simple;
	bh=Xl/uuuGCS7o7meg1tQw3VYv4+NdHsJocSJguMYrrJ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCc41JXXHhAkfy8YWJ3mCWz8+ZEpuTKB9nzrxsSVo6MFp8tBaGBhIDbVTYNnn3vMX0JiCOIIQJEy4/rR844tsmLFuatM+Al5nO4VBxerZQPYlnpY72vdTXujzTCunFi9iEfVis71mljBE1NmjAU/TPm//qrgBj0Ijy0Sl2tdic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X8zuf0LW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HljcyGtm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X8zuf0LW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HljcyGtm"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 28713EC03DA;
	Tue, 15 Jul 2025 04:26:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 15 Jul 2025 04:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752568002; x=1752654402; bh=M04xNUvl6V
	Bhi8R/igoaMUpR5OCC1Y0HCUah5YUsZi8=; b=X8zuf0LWbOJyRF6IU8pDcXZs7+
	y9Sj3bKDOi1OGnoEZqHiqc4QX/qlT5HgBp3udU/DGoBVXJiNGRDiLzn7VASPlP1O
	b1i67IiKKeZuDkypFlxBDTd/X+PgDb+teHbYj+Ncfsu5EPwSzmrlgs0Q/IxSrlde
	0JdY7wXa8r/fFeAxuN2l6hmhDnjOIjR/KWBA83MEsDWT8Li+oyZcfb6HOi4uaWiV
	4FAwbOegLgSZlY4Jk6NzztdExfTITk1pjCWQBxFNgBQMASvhOvoc1TdyBRoe5iGz
	mjv3GXLv8SIOHHyVHydjzkB8qSuPlYsqLhdW5mXAa7FlovY9qSAk8Df4oGrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752568002; x=1752654402; bh=M04xNUvl6VBhi8R/igoaMUpR5OCC1Y0HCUa
	h5YUsZi8=; b=HljcyGtmHJxZAbZoD/MQsT2bWlTU98CxfSUcv+Kebl1RhaR5jb8
	EaFNo3qSsqAAhAcoz/DOml9x2J3X9vzU9Vn1StfqtWW9PVW1RsQ5LFL1TDHACPPQ
	MHaLIDZuuNNrGdhlczKWLZbce1QA6G6ZYTx0VLGqExxvvseeTZSLcsAprxYKEvbj
	lJYyXM1wvSoVTCPWMjnvtM3Gf9+PC63LvGvHcULU/ZAhSs8kE23Hx1eOzGp+fo3V
	FKU415Jclw+9PKcb+q5YJAo4YQWbGnm3sdOKjza1WS9rbJLayXChoedRyRAVnQ7E
	ARJvNnS2Gt+fgDZjUKKmQgLBc6bMApEXxgw==
X-ME-Sender: <xms:wRB2aD2L1QCo7V2cwBP-0N9KgU2UEP5idhNWMtudH4hgUIK0_LPgJA>
    <xme:wRB2aCQNiqw93BAUv0cuPizHZ4Bjhb0Hhag8lPUc1q0dLxisgDZ-7UZNMN55TiiRZ
    PUObvgGbX-MdzA92w>
X-ME-Received: <xmr:wRB2aFs5oPunrsr-6e0oxevt59iBAelDtq54Desx4nsDSBzGZUFW1gm5vYhMWI5jwQFWugwjQJnfolIAwoVi-6JM3hsO1HiS9lFzWsA-i-4k5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:whB2aHaraspfDgSsBaEMhWIyIOadjnSsnSdqQ25rmg3HuDHE2bKPQQ>
    <xmx:whB2aKvw1gfYRdUPn297DKABzIXlS4jxisYRyXDZB5ACNRw761ftGg>
    <xmx:whB2aJHN9nXXH9WbnHbtYOWvTwZ0eiwLEDRSqLLe5YxBvseaXA02nw>
    <xmx:whB2aFzEQ-gIhjS9c4NciEThsmoVY7zxvziHh43-4abV8Jbf2mAKMA>
    <xmx:whB2aJTOC1BoJ70BSzanTGiYL-s_F9qYU96vCsasxVoYdBe7N3_vHmZL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 04:26:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebcc7947 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 08:26:40 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:26:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] midx: start tracking per object database source
Message-ID: <aHYQvSriyxLhuaa7@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-1-f31150d21331@pks.im>
 <aHBISjW/OErOy3Cp@nand.local>
 <aHBKdGfVfn7Xigip@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHBKdGfVfn7Xigip@nand.local>

On Thu, Jul 10, 2025 at 07:19:16PM -0400, Taylor Blau wrote:
> On Thu, Jul 10, 2025 at 07:10:02PM -0400, Taylor Blau wrote:
> > On Wed, Jul 09, 2025 at 09:54:49AM +0200, Patrick Steinhardt wrote:
> > > Multi-pack indices are tracked via `struct multi_pack_index`. This data
> > > structure is stored as a linked list inside `struct object_database`,
> > > which is the global database that spans across all of the object
> > > sources.
> > >
> > > This layout causes two problems:
> > >
> > >   - Multi-pack indices aren't global to an object database, but instead
> > >     there can be one multi-pack index per source. This creates a
> > >     mismatch between the on-disk layout and how things are organized in
> > >     the object database subsystems and makes some parts, like figuring
> > >     out whether a source has an MIDX, quite awkward.
> >
> > This is a little confusing to me. What do we consider to be an "object
> > database", and what do we consider to be a "source"?
> >
> > For instance, if I have a repository with one or more alternates, I
> > would imagine that each alternate is a separate "source", and the
> > sources together comprise the object database. Does that match the way
> > you're thinking about it?
> >
> > If so, that makes sense. But if not (i.e., we consider all alternates to
> > belong to the same object database and share a single source), then I
> > don't know how this will interact with the existing MIDX alternates
> > mechanism.
> >
> > Some clarification here would be helpful, I think.
> 
> Ahh..., after applying part of this series locally, the documentation in
> "struct odb_source" clarifies that (at least as of yet) there is one
> source per alternate, along with a source for the local object database,
> and that these collection of sources comprise the object database.
> 
> Makes sense.

I'll still add a note, as all of this is a rather recent development.
Doesn't hurt to reiterate some of those points.

Patrick
