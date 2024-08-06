Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E941BC06E
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925583; cv=none; b=WhJB8GkD1NZtCWy3SnYj8xa8QkkUrxEOrcI5qiggLU+QgINT/xRJFXav/q0b7W0XeK084hPwLwzmCe2+OxyR88oxKl7K1yPw6L6RYkWiHVxM7ia6tHDAKtuRBBQ2DrzZZaNc6ICBmG00jzSN0MGph6AhheK+HHhR7IMVKhcYlOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925583; c=relaxed/simple;
	bh=TPVujQ5ZQF5jqIGjsaKt/FnKJKgJb8ujUJFKkYPBZm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYJkInJlQKGGEP0vukGze1sy6fgrCBz70YiSzdNckuHHHNYRjG05iu6Ne7YiKquzROsVR8o00qyjITvDqyojNMEzEHRKIIRa6zV6pAq6aLF3OizgIq1BQIRjk4zO48C2aq8b8rFdAp8Tkjma89vsPKkFZdOW3Q8pB1HUpY9Hb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=npBrNub3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jpdSgPyy; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="npBrNub3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpdSgPyy"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D98281151AA0;
	Tue,  6 Aug 2024 02:26:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Aug 2024 02:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722925580; x=1723011980; bh=qmDP7YHmdV
	9gFZ1BbolA1nrOf2mSlCtBQoLl5HB3J1s=; b=npBrNub3PMlpSSdxtbRbGSYthB
	LK7BwR/+3yjCGgUw63dmc7PmBwmI9Ais/nr7Ks0L81N0Mqvd58Ez6F6xb8R3Pa7V
	bMwAUMj00cc8WBbqtj6FVDoxSLc+3etpwbaTDIaex0VVIi5Tl/90EmS5Wj3xznuD
	+2Sb0xCtXcR0gpZF0Sh0AWl/sHwpbxY86AMP1/mVQB6z4w7lqxUCJV4yrqS2ZHKV
	3I6SQlOf5A4oX8632ddtF0YzWswYbNJfod/YYRYxMzIc5VNWROvh8RkafppHY7tf
	F5kGsh3uCw5XgLcsgLVVudO6tk1Foka+MavrUTWDiZfiYH3UBRHgDn35byGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722925580; x=1723011980; bh=qmDP7YHmdV9gFZ1BbolA1nrOf2mS
	lCtBQoLl5HB3J1s=; b=jpdSgPyyb9KUXAe7cBSe+4/CtI2l5R9VOVojApYGbA+k
	ZlsuZbWg5ch5WabQbxyHQYpT3rqUPJ6i/xZEUuk6ar0YTcGdpor+GBtA/Cq/tFy0
	uQbDqs+B1UwrlxqSA2bORaaAa1PDVZFgL549hNr7LqK1Ju4tMfpLQf4CNmEHlZlr
	/92fp+PiUG8DUkz5i46I8dmOsN/8iQIUgxGnSW3IgjnsZl0EVzhCxjVKCzojLaAF
	eQDdMBfVZsi3sUJsv0QmYsHBNYChn42nRLn0KNXO8jvtx1ec0vv/XQolG96HFAS8
	r4h67lwAwR22eukr/iAHVOTA5ZgCWA1hsR9T6kn0NA==
X-ME-Sender: <xms:DMKxZve33O8Iamp20Do4hQynZuxxo2-Hy7LDLvE4__wZTdQsAQxq0w>
    <xme:DMKxZlNa7H9Kx9j1XpbsnPooHNwcaNJmtcv0g509JEhgx_Z_fpWOlPcAsf_NARsve
    -x-A0wWL-8chXQZqg>
X-ME-Received: <xmr:DMKxZohfrQabH019BCobqI3-Fhbgl7iwGYIXwmfcnWRQrlHKr2JvlH8NIctPZdi1OclN_h2hwq9hXN52SJbtLSvuliawIG1lE-KOuCgIF8N->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdeuteeukefgvdfhvddtudejiefhffeggeeiffdtudfhleeijeelkeffhedtheeu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    pedt
X-ME-Proxy: <xmx:DMKxZg9J6eEMnu8rduvYbwxerwpkE1um3XWxVfNClM-hOK6o16xJJQ>
    <xmx:DMKxZrtZD2D0pqmQ7ciq4VtkmY4dcnGVc4JnwYm0APG6oU9LN6PlIQ>
    <xmx:DMKxZvHScRQApj2EqfMi-GfOr6SoO-GG3oFWvaSCxAEXZr4RDOEMkQ>
    <xmx:DMKxZiPoxN6_E4VU9dvyIFZAV41K7claRXbb3sQZnR3509QioSmz3w>
    <xmx:DMKxZhWd4gV2msYFImXrRooTE_EfW1W8i3RH8zBER2zHyahJL_mOVYJH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 02:26:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d5a36bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 06:26:16 +0000 (UTC)
Date: Tue, 6 Aug 2024 08:26:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 2/3] strbuf: set errno to 0 after strbuf_getcwd
Message-ID: <ZrHCCBXXWZPzAcQb@tanuki>
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
 <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
 <0ed09e9abb85e73a80d044c1ddaed303517752ac.1722632287.git.gitgitgadget@gmail.com>
 <xmqqv80ia9wf.fsf@gitster.g>
 <CAPig+cTmzk7AN2x8-WCK_T5-_G7Wd-akB2++_4HFEbT67Rnc8A@mail.gmail.com>
 <xmqqv80f3r3d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m2xlZhODW+ecSZx5"
Content-Disposition: inline
In-Reply-To: <xmqqv80f3r3d.fsf@gitster.g>


--m2xlZhODW+ecSZx5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 08:51:50AM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> > On Fri, Aug 2, 2024 at 5:32=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >> > [...]
> >> > Set `errno =3D 0;` prior to exiting from `strbuf_getcwd` successfull=
y.
> >> > This matches the behavior in functions like `run_transaction_hook`
> >> > (refs.c:2176) and `read_ref_internal` (refs/files-backend.c:564).
> >>
> >> I am still uneasy to see this unconditional clearing, which looks
> >> more like spreading the bad practice from two places you identified
> >> than following good behaviour modelled after these two places.
> >>
> >> But I'll let it pass.
> >>
> >> As long as our programmers understand that across strbuf_getcwd(),
> >> errno will *not* be preserved, even if the function returns success,
> >> it would be OK.  As the usual convention around errno is that a
> >> successful call would leave errno intact, not clear it to 0, it
> >> would make it a bit harder to learn our API for newcomers, though.
> >
> > For what it's worth, I share your misgivings about this change and
> > consider the suggestion[*] to make it save/restore `errno` upon
> > success more sensible. It would also be a welcome change to see the
> > function documentation in strbuf.h updated to mention that it follows
> > the usual convention of leaving `errno` untouched upon success and
> > clobbered upon error.
> >
> > [*]: https://lore.kernel.org/git/xmqqv80jeza5.fsf@gitster.g/
>=20
> Yup, of course save/restore would be safer, and probably easier to
> reason about for many people.

Is it really all that reasonable? We're essentially partitioning our set
of APIs into two sets, where one set knows to keep `errno` intact
whereas another set doesn't. In such a world, you have to be very
careful about which APIs you are calling in a function that wants to
keep `errno` intact, which to me sounds like a maintenance headache.

I'd claim that most callers never care about `errno` at all. For the
callers that do, I feel it is way more fragile to rely on whether or not
a called function leaves `errno` intact or not. For one, it's fragile
because that may easily change due to a bug. Second, it is fragile
because the dependency on `errno` is not explicitly documented via code,
but rather an implicit dependency.

So isn't it more reasonable to rather make the few callers that do
require `errno` to be left intact to save it? It makes the dependency
explicit, avoids splitting our functions into two sets and allows us to
just ignore this issue for the majority of functions that couldn't care
less about `errno`.

Patrick

--m2xlZhODW+ecSZx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaxwgcACgkQVbJhu7ck
PpQMTRAAkIMCvCvHGn37G1PnC1R6iJE/VBED+ctnieN91m7i1VIgO2SJVIBkHOSR
x6j7u2ViMu87GG1OpIRFmH6sfhVPiz4bKVY2j8JQw7660FRFcTFd9rRrJgS/Cpu8
Xv7mo80Rfi51rEDAPEfIzZ2LEOtGW6B88TyoTQi1m5R+Py0skCrpK5ppP8pWtyVz
257meMRCocw6zt0n2oTgnmsZfA1QCw9XkRI/ZD98g3D9u9uMJB3TZUKdM0tRxCAE
pwF2lcAt2W65moAjbFLci6sMlNqtWDleL0/peW3eMbA2boqB71vGEt7jMfxRZLD1
4ZePrkNwsfhc+ZuqfF7qCwUqvJSvuM7mbjavWibzlkJGd/ZPi7dfHRNGDTnSluen
pfoitoAlaSOw5kXgdEsEpuIDno2h10q2DbjVCuPSUgClWKEzh9jOnNjh85MnoRZr
EsbKcLc53bHvlB8K9z4RwkDHFzzNZ3laIEH0AMC0dmfR1RVqo2S+8zghnuc3kv7y
Qj1qrnOQJHoUlDRVXdkupyrABh64gY4zf1KLFCKdsSvI5sy3VtPalKkSgpxOAkkT
OHSmtYdDXHjqBn15OCwib1DM6Xd+Rbdd9FPgyGdW0gQTsu/2fSoSpJQvLKQyXi+j
ZUoguQZwX2RGjuv1lJ86vl1kVs+fG0kcJvF/XDUD9mD+DPEZiDo=
=jlro
-----END PGP SIGNATURE-----

--m2xlZhODW+ecSZx5--
