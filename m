Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6812D758
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476342; cv=none; b=ROfMEI+m+hJqXYdOb6yGPwwJDGQwTHBapApRuBC6x7Dk9M+e1xUNDe6FvBns0xb/w8FoSDNCzKx3V/XiffeCY1q1PKuJnDIKXBsn0iZSKH4Ms3zoPFANON6/k/LafcX59F4qwZ0mnXkfG7E9kcA5LbhIBkgWcFvYQCYAA+p+gUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476342; c=relaxed/simple;
	bh=c1wAOTjHeBzp7LhAU4VAP0gFm1HlJ9vVL4bJrj9f/yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2fZ0leIJDnvBvhb9fJnVQgiTcChi5iN5fsiupE4uutFYvPzI4jBpkMdan59ymzZWaQMPkdSm7mck9KR29KhDeowrGZze1Ph6PwHHWFz6CGUDECQWCCLSUsKBXBKlm2YbbJ4uDFBURbShfz3p43JDF6v2f2HOeu5JNCtA7YZSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jrzPsCPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pa4mSdqL; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jrzPsCPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pa4mSdqL"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2FEA31380EAE;
	Tue, 30 Apr 2024 07:25:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 Apr 2024 07:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714476338; x=1714562738; bh=qZpC3oxugQ
	CIdyGYrJ/YU7l0rvW8xtSCJG2PIrvPkb4=; b=jrzPsCPzAr2BF7+T51zrN4UlZa
	bV9FlS9STruzxQVoc5HHpqfuFss0gQOo+V8jo+3n9kJf2N3R0G+N3pc32/xe1Syt
	33Z7sprzHd6HfcntygTA802Ijz0K6y68awDedPYuTSrJOmiIJRRyx8fiOr1Qodnw
	J8wYJKy/fzXL1HKT3OyQC0GAXB3RI+BwSPcELvbZ8QZLWajtqgFwvN8bRTcJRbpm
	VuVbPDq3DddcK/2zf3zWyhxsAsYkJ5wR60jzHM9NJV67uFYVlOpN2NTzMaT/XxQS
	NCmMYrJxLFd+vl1jDoMcRXCB6W707i2ILNuItbKh4Uk4Q7WI699TfV4HYaOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714476338; x=1714562738; bh=qZpC3oxugQCIdyGYrJ/YU7l0rvW8
	xtSCJG2PIrvPkb4=; b=Pa4mSdqLm0GypX4C5m7EUlUUorPWpXGZz40QDIgb5+B/
	3/SUDK4eM8dV1Ygh3daBIcrXBq8c1WxtSYBxdUM0o+XH6vWOXYT/6heNoyVRimRI
	57B/980IXg+PR0DptHQAv7T6nPgqSFgcTgImDEIAuv6ZrOUbPVMQjVSNukGy84Ly
	6plTEwZfOyOZS3f3uLqLL6TidpK4Ojo9sMRaakfM/UHLyqnp7Wczpbujy2hAmmPQ
	cTkISBKKJZpYGou7G37Hr8ycbJUJDB4muXdSIjuryL5AuUTqZn56zCPX1AHB1rlO
	XM7qtAF8E2pPt40nWMUESBD47cBUIFQYruhwOoPD+g==
X-ME-Sender: <xms:MdUwZiT6ejdWZvf8vcFTtRy6WRMu03P-YShExadh0N6o53WDu5v0CA>
    <xme:MdUwZnz1PjX0WMpwDmUmmdD9GorxHOoSENHh_I30qAzR9_fLLujrvt_fyh7Py5jav
    U4KqDGkk00ibHYkrg>
X-ME-Received: <xmr:MdUwZv1FDAoIn_5J6nGMkrK-dsbVbXVEi7vs-FDSGDmWn9Mt8ynmFIlIlBE7fiveSqoKmxxf-PWC-HzIbj4ta4ARtP3dqLRcSAJHUq4vdU1XG2hxX2zG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MdUwZuCGOn5JtzsCqyurOlyV13nSAGBHORPE9uv0_QkPkvRBLCuXiw>
    <xmx:MdUwZrhx3CbtvRf1ArlRFnuYUNK9uyoWVINP9xfdIboPxm4FOiyi7A>
    <xmx:MdUwZqpXjoDgttj5ndAgXXzy62KhWGL4o_vJbXoU3fF5xrP8mE08ig>
    <xmx:MdUwZuigs05qYZ_7Foc_Ucf001ccRR9TxU38W3rBzGEnUSbIYR8hWw>
    <xmx:MtUwZuv9bmHcbu3QUH4J4-NHJfYOpRtvdVFacNRhyHEnNcIxFbdweFSX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 07:25:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 326d118d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 11:25:12 +0000 (UTC)
Date: Tue, 30 Apr 2024 13:25:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] refs: check refnames as fully qualified when
 resolving
Message-ID: <ZjDVLAKA0_4pTAS7@tanuki>
References: <20240429083533.GG233423@coredump.intra.peff.net>
 <ZjB5dPoEoq8D6qzJ@tanuki>
 <20240430104152.GF1279403@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EqaY56Vvb7I9483H"
Content-Disposition: inline
In-Reply-To: <20240430104152.GF1279403@coredump.intra.peff.net>


--EqaY56Vvb7I9483H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 06:41:52AM -0400, Jeff King wrote:
> On Tue, Apr 30, 2024 at 06:54:12AM +0200, Patrick Steinhardt wrote:
>=20
> > > diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> > > index 120e1557d7..5fb780cb08 100755
> > > --- a/t/t1430-bad-ref-name.sh
> > > +++ b/t/t1430-bad-ref-name.sh
> > > @@ -400,4 +400,14 @@ test_expect_success 'update-ref refuses non-unde=
rscore outside of refs/' '
> > >  	test_grep "refusing to update ref with bad name" err
> > >  '
> > > =20
> > > +test_expect_success REFFILES 'rev-parse refuses non-pseudoref outsid=
e of refs/' '
> > > +	git rev-parse HEAD >.git/bad &&
> > > +	test_must_fail git rev-parse --verify bad
> > > +'
> > > +
> > > +test_expect_success REFFILES 'rev-parse recognizes non-pseudoref via=
 worktree' '
> > > +	git rev-parse HEAD >.git/bad &&
> > > +	test_must_fail git rev-parse --verify main-worktree/bad
> > > +'
> >=20
> > Are these really specific to the REFFILES backend? I would expect that
> > the reftable backend sohuld fail to parse those, too. The fact that we
> > write into the repository directly during the test setup doesn't change
> > this, because all this patch is about is that we don't want to parse
> > random files in the Git repo. And that is something we should want to
> > enforce for all backends.
>=20
> So this is where I will show my ignorance of reftables. I assume it
> still has to implement FETCH_HEAD as a file (since it holds extra data).
> But does it do the same for other names outside of "refs/"? I am
> assuming not in the paragraph below.

No, that's why we originally introduced the "special refs" syntax, as
defined in gitglossary(7). There are only two files that behave like
refs, but circumvent the ref backend: FETCH_HEAD and MERGE_HEAD. Both of
these have special syntax and carry additional metadata, and as such
they cannot be stored generically in a ref backend.

All other root refs are stored via the ref backend.

> I would expect the test to succeed after my patches on any ref backend,
> since we'd enforce the syntax outside of the backend-specific code. But
> for a backend which does not look for the root name "foo" directly in
> .git/, it is not an interesting test. The looked-for name does not
> exist for it, so even if we did try the lookup, it would fail. We cannot
> distinguish the two cases from the outcome we see.
>=20
> So I think dropping REFFILES it would still pass, but we are not really
> testing anything that interesting for reftables. That said, I would be
> OK dropping the REFFILES in the name of simplicity and just documenting
> it in the commit message.

Yeah, I'd prefer to drop it. We should only specify the REFFILES prereq
as sparingly as possible to ensure that behaviour is as consistent as
possible across the implementations.

Patrick

--EqaY56Vvb7I9483H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw1SsACgkQVbJhu7ck
PpSi6A//YAllMEWTG0X8SboX3dTUIi3GMx38jLY/kMndo02BKNwcfxS5vm9uINVa
wZb+P8AIpqEgM15wUBOTYws4A9c9CbrvU40zrQdBoTPFO2RA4BI+aelGYOjhBayy
4489KzRiMAGlnKyFfE8k5ei2UZ9XWTThq46xpOYtDePhieEHi4nsjhULv/h2Q/Lz
w55sniDbI72JEv4Gvhe2CEkWGZoP+Wj1cyP0g6DsdHQT/FxALQ9opWvMJDRodV2k
JsrBE2ptdim2hYNn/F5RBG27yJQ5VqP88tm71IbEh9IlnJzbRR4f31odhP6h3w6S
Iv7x0Tv/cY5Ebk2zYSW7SEUUssP9mBbf6BtDiZaxXKh4Sy0toLnKHO2u/9xrMV9w
D60Ml9LToJ4dIUDRKf0vynorpH/N6PiwAagmMjjsBgGKjof/MmTw9Djsy7i7EDCh
F2TyNcoy8ud4hu4T63syrTyyngnS01PXOWJcidQKVUuPtHOyULu1AoAgnOJbcgfR
yP0JiHAwaub2liqMKfh6kl0VL7w9XYPabXiO0Y8yPVq+0NCXG1JiW5MOXy3sTIZq
vO40cOo8lZr34yncaCnKVOz7OentIqqHlURUxeUqo8QSVwgcjxFiPA/7JvpqZ77g
7WD8Ux20ikJOVg7/4cx7+hmDXSGJao1N5wgTxetc//80Seq4+Vw=
=rWZ6
-----END PGP SIGNATURE-----

--EqaY56Vvb7I9483H--
