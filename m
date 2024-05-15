Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6B38394
	for <git@vger.kernel.org>; Wed, 15 May 2024 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746587; cv=none; b=XkPH+QHHCuKQnOEVl3dsjxCIcE6ANbvdKdZ2UJW8ijS9/1BWq7BBN84JkZaFHakqFoOhZCedQIMWo6s9RvPMTzFaXW85pMamEuA1Nkjx/2Bi8NrlM5wv0lUxchF6LCFWgoOQqMX2Zo79WIyQ1W2Hcvcbbb0Svqw7hEqVyrF0r+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746587; c=relaxed/simple;
	bh=T2ffOvu1s20R70QJ4w8dwAU46o0BD2ZhQ1UlryuDpIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5fx0oDe5BCWgJ+sOtcBhZvb+nnhDd5RkY+LyKYZaEG2+AWeJXXycMbqgVYlok27wT3JaFAnGW1kFizKE+55+4EJbC+5XngXPOKoINly75n3OnzdXfKU7OjjMNPNhtGRQfn8r2zB+rlonokjdgTMKKmr/OSaE/1tFUU5YD0A7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ANQFsjIs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JQI3Rr5d; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ANQFsjIs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQI3Rr5d"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CD7B9114009A;
	Wed, 15 May 2024 00:16:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 15 May 2024 00:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715746583; x=1715832983; bh=NZVomFw/Qq
	7mawXWsJ5gsmcTxinTcbIQbnAPWzmsCHw=; b=ANQFsjIsXKKKXwoU8aC6xMORtl
	BwXJ+YlXq5fBYhmgIeU06vNmNFtxH/erwVXIbGwIqQz4lPlOKz7uhMgv0LqQFLiA
	1t2Gw4AIg+udLsy1vUz8x6FxMFFdVYamfhfDiknvW7xyKbEIb3PCbG/VmtyW2cue
	4vNdmDr8wS+8smC+sspJwt0eu3Tl63aSVqlfPfU1sJRX1ZqcNB1QbFch/E0wYwpj
	VAdaKWv++4L2tUluGmeUySfQa4VzGwqTjHIw02wRzN/qW0svwfdB/2SLb/DNVq7Q
	3HdeBhNXl8Ijp3ad6F1qmPGvFgHNBvfUdaXHf6IgwUqN38fMI3IihnlrCyEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715746583; x=1715832983; bh=NZVomFw/Qq7mawXWsJ5gsmcTxinT
	cbIQbnAPWzmsCHw=; b=JQI3Rr5dFbq0ydD8vdPkTaSRZ/MiHq8Gv/fGWjd5R648
	ubGVGVukEXZeqlOKblPBvaTXgfq7569a4RfPgBFtkXzKXewLitXTEkGfb0k8HYv9
	5R1i3wc6916QT0DOoXjzu1I0YITO7RWphN6GDRwFxWdRsi9tVGDKW1MGwcm+uodH
	bHqvZLXqhpfH/WldKjcfoV0OfFbuLhTTw+b/kmceAHs3RCsKtwySMk3fkgfzj/AE
	9VespU1D+/48XWiX2R+LBegusqtJXgyW4TRvyjQ4Ro/YwNWQCul6D4zHdydTH99j
	7+KlNmfwrBzS4PFhdw7xHcDZJicp8n8xiJQwAWYZCg==
X-ME-Sender: <xms:FzdEZoUUvto5sMCrWaoJZ3Lzxkid2IvCjZ_efl2s5aBCpu7i21cxww>
    <xme:FzdEZslW8HFE7bWWgyJOxU2gIopqmgRQwWda-VuuepulLMD5vzy5hHgi1FNle-9ke
    5YHH17do8J4lsSuTg>
X-ME-Received: <xmr:FzdEZsbh-beTg79wKa7ROY_AHfLaYwuW7I5rM_NY15WXRXdosaDtkDBUMldaqcTFDXYVOqAAj1JzRypITdLej2woyZsjyz-7gUj_yWKUq-k4zT4m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FzdEZnVxqPFy6QhVqoj6YcWlBU0A1FkNvDzFGFkgJrhuRv7svjWBoQ>
    <xmx:FzdEZikxx4SrYMmVwGSW8zyiYHInnwzq4PT9RcjPJqkB1f6Wi0mrqQ>
    <xmx:FzdEZsdgrd-8geeEehhXr84v-gcq0KNtVPGl7kSQHzBWsNPK0kdusw>
    <xmx:FzdEZkGQ1j3UdWdoXefyPpBJH5elrMEOTUeycpXtmk596MncVNJtKw>
    <xmx:FzdEZkUlMXQ1U1U0NgEfocrfgRZjWpYu4IiZZK4b077_DcVS6HHvHjTC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 00:16:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a415d340 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 04:15:58 +0000 (UTC)
Date: Wed, 15 May 2024 06:16:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v3 07/10] refs: root refs can be symbolic refs
Message-ID: <ZkQ3EiL1OY10Y2JP@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
 <92a71222e1067ca4ce9ecaaa555d78d0cce0d9d0.1714637671.git.ps@pks.im>
 <20240503181339.GH3631237@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DPdDaPzqitDd85mO"
Content-Disposition: inline
In-Reply-To: <20240503181339.GH3631237@coredump.intra.peff.net>


--DPdDaPzqitDd85mO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 02:13:39PM -0400, Jeff King wrote:
> On Thu, May 02, 2024 at 10:17:42AM +0200, Patrick Steinhardt wrote:
>=20
> > Before this patch series, root refs except for "HEAD" and our special
> > refs were classified as pseudorefs. Furthermore, our terminology
> > clarified that pseudorefs must not be symbolic refs. This restriction
> > is enforced in `is_root_ref()`, which explicitly checks that a supposed
> > root ref resolves to an object ID without recursing.
> >=20
> > This has been extremely confusing right from the start because (in old
> > terminology) a ref name may sometimes be a pseudoref and sometimes not
> > depending on whether it is a symbolic or regular ref. This behaviour
> > does not seem reasonable at all and I very much doubt that it results in
> > anything sane.
> >=20
> > Furthermore, the behaviour is different to `is_headref()`, which only
> > checks for the ref to exist. While that is in line with our glossary,
> > this inconsistency only adds to the confusion.
> >=20
> > Last but not least, the current behaviour can actually lead to a
> > segfault when calling `is_root_ref()` with a reference that either does
> > not exist or that is a symbolic ref because we never initialized `oid`.
> >=20
> > Let's loosen the restrictions in accordance to the new definition of
> > root refs, which are simply plain refs that may as well be a symbolic
> > ref. Consequently, we can just check for the ref to exist instead of
> > requiring it to be a regular ref.
>=20
> It's not clear to me that this existence check is particularly useful.
> Something that fails read_raw_ref() will fail if:
>=20
>   - the file does not exist at all. But then how did somebody find out
>     about it at all to ask is_pseudoref()?
>=20
>   - it does exist, but does not look like a ref. Is this important? If I
>     do "echo foo >.git/CHERRY_PICK_HEAD", does it become not a root ref
>     anymore? Or is it a root ref that is broken? I'd have thought the
>     latter, and the syntax is what distinguishes it.
>=20
> Making the classification purely syntactic based on the name feels
> simpler to me to reason about. You'll never run into confusing cases
> where repo state changes how commands may behave.

I certainly agree and have been complaining about that in the past, too.
I didn't dare to change the semantics this far yet. Let's have a look at
the callers:

  - "ref-filter.c:ref_kind_from_refname()" uses it to classify refs.
    It's clear that the intent is to classify based on the ref name,
    only.

  - "refs/files_backend.c:add_pseudoref_and_head_entries()" uses it to
    determine whether it should add a ref to the root directory. It
    feels fishy that this uses ref existence checks to do that.

  - "refs/reftable_backend.c:reftable_ref_iterator_advance()" uses it to
    filter root refs. Again, using existence checks is pointless here as
    the iterator has just surfaced the ref, so it does exist.

  - "refs.c:is_current_worktree_ref()" uses it. Fishy as well, as the
    call to `is_per_worktree_ref()` also only checks for the refname.

So let's remove these existence checks altogether and make this a check
that purely checks semantics.

> And arguably is_pseudoref_syntax() should be taking into account the
> "_HEAD" restriction and special names anyway. It is a bit weird that
> even if we tighten up the refname checking to use is_pseudoref_syntax(),
> you'd still be able to "git update-ref FOO" but then not see it as a
> root ref!

True, as well. I'm less comfortable with doing that change in this
series though as it does impose a major restriction that did not exist
previously. We probably want some escape hatches so that it would still
be possible to modify those refs when really required, for example to
delete such broken refs.

I would thus like to defer this to a follow up patch series, if you
don't mind.

Patrick

--DPdDaPzqitDd85mO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZENxEACgkQVbJhu7ck
PpTK5A//Uh9EZ860/f4B0g5qP06Q2OH7GVLK1EvrsCZXBvQoXzU70DDQWjCcydUQ
0AXymiQjwXzYfDdBWDFw3ZUDLiaTezhwdCN5OSPlNOkbypraLrbSHpQVETcaLd4l
KNNdALVj8ywM+ZCrmzixmx1O2svCwt/KHyXZoK6maxplf4L2i6uM6/igoxOCyglc
33CaiGQ8u50v0L2GroyIP4edRcM7G1dh4j+CqkMGf3YahTl6ZEM8+89eHq/nHkwh
eOYsNaTWcLQUy6PiWig5gBoZ4Bds97mmkZGKeLKTJrMNbVyGFJlz0X1+PzGxR/nB
PN2jhLTnxYNa67eeEvkbcgD8Ot1YqYYYg0xymitqPRD+xe2Qg3T7Mi5KTM3be+Z6
IV6DWFHqdm2qDvJlQxXJ73rBDg5bVCvpDajaHxJrV3Q/4iMCXyxi+R6TzxpTOq96
jf8ERBvu8iZ++KltDt0ri1ZbEq8ijAzagjViRZfAZorbFrpL1ZUWjVe5d44LkPl+
2j5LO5MfXCOYkqFW2at/NvFa8vPSEvt6mTXqFsIVsBRZZ77//y/acB9lhxsmf1gq
rEbF2BGnuMSG/Dh63mhPgBJct+Hpt1eoNTRorC+sqHWsVkhYwhzHr1irIU6vGIo9
cm6SIzxmsSDgVYX4vqCP3LCMTQWWZmmW5nl/xSIhwwIGz0+hD/E=
=9sRF
-----END PGP SIGNATURE-----

--DPdDaPzqitDd85mO--
