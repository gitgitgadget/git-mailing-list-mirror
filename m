Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC32DCC1B
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359629; cv=none; b=tQlKQNyh/SAdoBpHHBJ69mLaTcBAUQXzRRu1IGwhbcTakSzkYphxu6hEfi8mvLP3Es60o3HcgENcVtstKgUj24LC8TyQFPSJ+YBJVlu9OQw4WyVrfSDHFZxKSK8hy1yU1ufzzpYT/MMRjyP0bbCJpeKKkY/0dYmfjHuZV1PgWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359629; c=relaxed/simple;
	bh=5P7UUH9P0BZgKnYEhWz0Z4ch3WQiZT6Pj+cDNoc/KwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faod3j1cp/PDbh1UOr8Pt2fuffnsVxiDik4xa4L5Ym/pQys/vcojw7lQ54/rZmlvCdqxeRa41UY14gd7nRXb1KffgHMR7IHQyyTGvlYdnWLflqmtpkGMozdWypAGZY2MhTrKR5Nh3/azN4NYFkt7GoJ9/v+5fXxkLCXOTemrfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CMnqVCN4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aWWbwFvS; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CMnqVCN4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aWWbwFvS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F0497A016F;
	Wed, 10 Dec 2025 04:40:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Dec 2025 04:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765359626; x=1765446026; bh=Z2SN1qvY+O
	IrJbOIB/4ynBRI1w0tQDR9Ox+Gq5PsnQw=; b=CMnqVCN4pt22oTEZTaHNXcyCep
	klQsJqUI+c9eIim7JGbJ+8PbjvigoixNqt+4Wi8GcXzVd49XVZcRKYFCoiq41wQu
	iJUzee+mWQzXWTQIWlX/AsDFinYPd+wJHKAb0/P8MAVf4i6+Q5QF2BiHt28uGpjc
	WCr6phs4ngEGl0y38v7+D+7V7NOaBcd0Uli6jGyPXs1YgWq0OpJu3eSOWjd4grjb
	A6+J1LlKkAdubePkt6d11gfjsrUk2dgQwHywZZxRpJRUEiDN3oHFafp6Y1wXa0X1
	H1Q5qOm7ZlWPCR50N+0nrp2zmPoXtofr3ha1q5EbAY2m8hZQWsimVN0009pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765359626; x=1765446026; bh=Z2SN1qvY+OIrJbOIB/4ynBRI1w0tQDR9Ox+
	Gq5PsnQw=; b=aWWbwFvSA4/fXgHgj44J2eSZtSAQJ5jxsVGDDQ2Mv8Pwf3ri6lg
	N6mtXeZJ3ogSZXagQUxBNQ7bh9OL0dW4sYmur5OdIGWLz2Gln8KjvuJqXD9na4yi
	0qPzXDNTGvbFMJNLhnAfuQCteWDm/3taqktVfxveZ+bMq4T3jAKNnx9YiGoBEGK+
	D740hbkqEAMbPXMPy5lA6n13Kr9nw+EXf5XsuLU4oxxnwOj9sEEoc29YOB+OTCoM
	3tIdc3xazQACK0ZIqi2xAtE0A03V4IoA6hX7u6N4S2j0LlmYO3wOjtif+wDoKkQn
	V1peg6R8VuwSH6Q8TU1EsErGzhsZw0wTFMw==
X-ME-Sender: <xms:CkA5ae-4pqL96iycptveAPS5xrXg0zJy9ShusMgpZtl29GxQklD-rQ>
    <xme:CkA5aWJvSXtJ6sjmFLVHT3_kz0Qh-21_MRJrkgFpLt3xMOK9qZOuueKBjh0FjR8r9
    q85pqG4ljXDs9u4FfvPvN7-pRTac1diYOecODDpnnAKCKJzD3ukDg>
X-ME-Received: <xmr:CkA5aRaBLFdzGp22QvvIoO_3BiMZPiSnvEQENQnGT-zKeMzZFlLNmkGeEUDZr76vgcn8KzUfqVkrhSKBfAatSza_256pTLx5J0AwIP9VVXkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiud
    elueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CkA5aQI-_xaDG03FEdDeAbD-MqtXVI-ATnqJc2QGUbf0Dwl6JVzv9w>
    <xmx:CkA5aXCunGwzVqZW1pwWoCO_qBetFy8qlYc5bED8rmEahldk8V8a4w>
    <xmx:CkA5adpmQP2REpTveAx45DBqyEdP1alKGpzyKOpoTEZlICEf3w6TIA>
    <xmx:CkA5aaiwnvsIg-dPeChbpDrvUdF2tfmeRdhP8kHPE913hX7qOmdcGQ>
    <xmx:CkA5acntSYHxUO9plVI0mF42vt8XhjmP0c0C48KATU5KEcyn6awb6yD5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 04:40:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd56611c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 09:40:24 +0000 (UTC)
Date: Wed, 10 Dec 2025 10:40:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin/repack: don't regenerate MIDX unless needed
Message-ID: <aTlABTCWRPNvUEGc@pks.im>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
 <20251208-pks-skip-noop-rewrite-v1-2-430d52dba9f0@pks.im>
 <aTjfj45uFl/f3b4K@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTjfj45uFl/f3b4K@nand.local>

On Tue, Dec 09, 2025 at 09:48:47PM -0500, Taylor Blau wrote:
> On Mon, Dec 08, 2025 at 07:27:15PM +0100, Patrick Steinhardt wrote:
> > Address this issue by introducing a new function that determines whether
> > a rewrite of the MIDX would cause any user-visible changes. This covers
> > the following cases:
> >
> >   - No multi-pack index exists at all.
> >
> >   - The user asked us to write a bitmap, and we don't have any.
> >
> >   - The request preferred pack is different than the one that we have.
> >
> >   - The packfiles covered by the MIDX are changing.
> 
> I can't think of any cases beyond the ones you listed here that would
> require us to regenerate the MIDX. One kind-of-exception here would be:
> 
>     $ git repack [...] --write-midx --write-bitmap-index
>     $ git repack [...] --write-midx
> 
> where the second repack would generate an identical MIDX, but does not
> want to retain a bitmap. That case is already handled in the MIDX
> writing code if you search for "want_bitmap".
> 
> That makes me wonder whether the repack layer is the most appropriate
> one to handle this logic. It seems like write_midx_internal() would
> reasonably be able to detect whether or not the MIDX we have already is
> up-to-date with respect to the given input.

One upside of having it in git-repack(1) is that we need to care about
less situations in general as we are operating on a higher level. And
because of that we can make more assumptions.

That being said, putting it into `write_midx_internal()` has the benefit
that we're of course covering more potential cases where we can avoid a
needless rewrite of the MIDX, and that we have better information to
decide whether it would be needed or not.

> I think that makes some things about your patch easier and other things
> a little harder ;-).
> 
>  - On the "easier" front: while both the MIDX code and the portion of
>    the repack code that drives it receive the same set of packs to
>    include, the MIDX code already has the packs it would compare
>    in a standard format. That would avoid you having to handle ends_with
>    ends_with(include_name, ".idx") and ends_with(existing_name, ".pack")
>    as special cases, which would be nice.
> 
>  - On the "harder" front: when driving MIDX generation with the
>    '--stdin-packs' option, we *don't* load an existing MIDX ever since
>    0c5a62f14bc (midx-write.c: do not read existing MIDX with
>    `packs_to_include`, 2024-06-11).
> 
> I don't think that "harder" one is a show-stopper, though. Commit
> t0c5a62f14bc has enough gory details around how we generate pack IDs and
> various subtle assumptions about how and when we load packs that I am
> very hesitant to recommend changing it given its fragility (though we
> should examine and harden any fragilities within midx-write.c, maybe
> just separately ;-)).
> 
> So I don't think that we should make that change ahead of this patch.
> While you can't rely on being able to read 'ctx.m', I think you could
> load the MIDX belonging to "source" ad-hoc after we have computed the
> packs to fill from the MIDX's perspective, which is right around where
> that want_bitmap code lives.

Yeah, we're already loading the MIDX on-demand because in git-repack(1)
as we have closed the object database at the point in time where we're
about to write the MIDX. So overall the change is rather easy to make.

Also, now that I see that we already have some short-circuiting
conditions in git-multi-pack-index(1) I guess it makes sense to extend
those checks. They explicitly don't cover `--stdin-packs` rewrites right
now, so adding that check is an obvious improvement.

One thing I'm a bit torn on is whether or not to handle preferred packs
in the adjusted logic. We don't do so right now either, so I think I'll
drop this for now. I can see an argument that us not handling a changed
preferred pack is a bug though, in which case I'm happy to iterate.

Thanks for your feedback!

Patrick
