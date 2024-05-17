Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F27A20B3D
	for <git@vger.kernel.org>; Fri, 17 May 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715931136; cv=none; b=LI1Xu3m3likGdzVC8JAC4z6o4SMKSKvcPxon+11TCn6dDI1nQwCoA1SXfC+yU8YQPJgAr8fL7JB2ZAjtsu/0YiK31t2aukLEwm3mUXW1Fv//PbCDKw0xWO8M2wU1sZSFIfOsuNiEGh72/9ZvS6oorh2+D8Yr3GZG628zX5C0eHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715931136; c=relaxed/simple;
	bh=QbZpbprAD11GR+Hy/PlsA9l4vgkZ8ecyzrPnDIFby3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQSTM5lIrgFWY37B93282kQskxe+QI5MDPpDP6KZNlxFhMUyCzU+moNh915D2FvebHDFX08glt7DsOkBnG0DIZUaXYMWVBYTf/8NS9+6fB4bX33sVpvYH7DhXwVEWm0XjnP24KQdd01NQ7J5z31erQtQwB0j8pGTH+Y4G0W3x+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g8Wi/NiM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FD1n9vig; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g8Wi/NiM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FD1n9vig"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 457C318000FE;
	Fri, 17 May 2024 03:32:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 17 May 2024 03:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715931133; x=1716017533; bh=cOwHBB2v0a
	jyyp2y0pzWcII5v/f8ge6h2wCDeHtZCt0=; b=g8Wi/NiMrfC4HUm4bMwuygvrJJ
	ce68qUdC8mIUZn/ix2Geg+pc4DTuThcEYK4LJH3qJd0GXnIM6WOi2R0i5J1G3wJB
	f2D9eSg7F1mmkhTix8bmY1EW15Evh1kPRaiu9fL+aqyIVtSa0woISG/COP7hvcSn
	ZPbR7p+vgnQ8NtKzEnUna++GXaHE6SMav2AUUenMgS84hQh7zqz6t4MWLnU+wFxr
	0hRwu0eCpRPU/uXVzqyUOvgeMnnbAfHTJhTVFUkrOvc+Wx9heKf6iTbqlDXXHsOk
	gssE7D5EfyArXfblmcJVyut/gbMx+ECvLo0zuq6kk9pcssu5Hwqdm8+ItG7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715931133; x=1716017533; bh=cOwHBB2v0ajyyp2y0pzWcII5v/f8
	ge6h2wCDeHtZCt0=; b=FD1n9vigELpewJNJ0tpynHh6ZPGi/RjYaXUV98ojUx5o
	CmpPz+1/lfe8aOnfDDPvRIXvHhqNB325B8x83TcAWaTv1q+jT1kLmJ2XTwBYnFhA
	pGP3xdVtqxnXgU1W0C3ra/y3j8ketqUQy2F2C7XOZvFQJXUpIQxYWhDtIvK4jhtH
	oAUTFHBzZ4cmba83MtafgCiQl5TPnrgX9vrd75pMc9ZEITsjNzi//8DOxbIAEfLv
	Sp26j591/VIPjw2ksa4PHHszhQSEUL/eC7zhayMLG9TRUz9ZPi9jGiBJA2T0CgBl
	N+1bKMreoqGygUBObSJuzNla2u3O7N6ZBGwa8zOamA==
X-ME-Sender: <xms:_QdHZnp_llEPJnailkQrC3L-9TB2kYvffNYKZ_xAVBR78Pqns5QeVg>
    <xme:_QdHZhr_CYzpzRYInNz8byLUzvKluTinDXpwcoK9Y8nUOJjBPAL0Z_6LPUEE6mqEn
    tb5NWkh-ByRSwqc7A>
X-ME-Received: <xmr:_QdHZkNSy0puGF80qoPLAFNrrsHhNAs9Y0r-lNK8Y7O2Qcl7iPpLQROoZLL1YmsmfOfRj8BrqVKb1iLwxIAAvcQuT0BYzgp-a06VkdHisfx_SaVygA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_QdHZq6kIbmXuZ2poCRih_t9asxhzk5eN9snsR4XviAMJSisd-G0zA>
    <xmx:_QdHZm428_3Jem4d2htCcjcf1PlhQwpaDGlhENG9sLguPzxakD8XgA>
    <xmx:_QdHZiidw7Xopt-Qus0YB1lc5uJPZi9EVCESevcI22DYUOWSnP1M4Q>
    <xmx:_QdHZo5r-Sbwqyy6w9ueNTKGnFx59sqQlr5Wkh3O5IUT9Bcnb0L9zw>
    <xmx:_QdHZsl_Q2FxjhV_WnfU8cHU7ba_pwR9hqiFajeM19gqy5-f36MNXL0x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 03:32:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a39f4fce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 07:31:43 +0000 (UTC)
Date: Fri, 17 May 2024 09:32:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: [Q] rebase -i: turn "pick" to "edit", make no change, what
 should happen?
Message-ID: <ZkcH-LAkLkf_wvfq@tanuki>
References: <xmqqy189o94c.fsf@gitster.g>
 <m0seyhs8o2.fsf@epic96565.epic.com>
 <xmqqmsoonccd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CmE3bFYaHgG2j80B"
Content-Disposition: inline
In-Reply-To: <xmqqmsoonccd.fsf@gitster.g>


--CmE3bFYaHgG2j80B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 12:09:54AM -0700, Junio C Hamano wrote:
> Sean Allred <allred.sean@gmail.com> writes:
>=20
> > Setting aside the obvious reality that an actual change here could have
> > pretty serious UX considerations for folks with muscle-memory, what in
> > your opinion would be the right thing to do? Why? Are rebase commands
> > 'shortcuts' or are they intended to be orthogonal? Do they have designed
> > purposes?
> >
> > I'm wondering if you can tease out what the 'ideal' state looks like to
> > you, then you can identify what if anything there is to be done about
> > it.
>=20
> Oh, it would be very simple.
>=20
> If I say "edit", whether I made a tree change or not, I want to get
> an editor when I said "rebase --continue".  If I say "reword", I
> want to get an editor _without_ having a chance to muck with the
> tree status.  That would be the "ideal" behaviour, iow, the "mental
> model" is just "edit" gives the users a chance to edit both trees
> (by first giving control back to a shell prompt) and the log message
> (by opening the editor upon "--continue"), while "reword" is only
> about the message so does not give shell prompt back to the user
> (unless absolutely necessary, that is.  If the "reword" were to
> conflict due to tree changes in earlier steps, it would need to give
> control back to a shell prompt to ask the user's help to resolve the
> conflict.  It is just that when there is no need to edit the tree
> otherwise, that is skipped).

I quite frequently use "edit" just to inspect commits, stop at random
points in the history, run tests and whatnot. So this would be a UX
regression for me because I do not want to change commit messages and
don't want to be bothered.

With the introduction of the "break" command you can certainly argue
that "edit" is the wrong command to use in my case. Muscle memory is
hard to retrain though :)

One could potentially make the behaviour configurable so that you get to
choose how "edit" behaves.

Patrick

--CmE3bFYaHgG2j80B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHB/cACgkQVbJhu7ck
PpRFtg/+Ml6+oCqjK+ZMYFjKJWCa+EEkDvpIpwmQnsy8kUoJxI99NjRgpFCh11p9
C6sDFzXocesj+4lX4GXgYp7oAshnaz0/afxZNYAqM/1ZpwGZiUpuclDS5SF9NcuY
QSEBTH7O4X+pvwrfZQ95ySWF8WtuIuh3RFoLzjYboQYi61xxGtAMC+HQc5yG/IjI
7OZihSq/vV/nf9fUmVCfJz6H4G7Kv706a8P72dKdoG2J6skrA7eGT4xYrETui07s
Nx6huEZ8jv6VmVLzxH/dchLfFCeYzmSNt+dZHRIDxquV6eNrEh3xzYzdy6BrVjzX
MQtRdvw6x3qzajgXlm/FR969B7OtQkX4Vp/kgO3PfLBQ25p7FP+z8p56c03Gr1tc
PInU+oitZ4GHLXV8BpCiDdhBrw9RHgxmErNa+5W0Jc9oG5SOggU6EYisQgYDrXeD
sSLS3OcIPD3+FfjycbVJjE1VKihgKj361ZQTIhl4vJSWebCcOTNyU8RbM1UyUVGn
ahSzVyyodzkXbhF5PQBSP/srXn8pMj49Uel4EvgmrNTdRbByFGrG2WtrOqjfg+Wy
xkZ4OXnVLjdUbHVPGN6FID8bxzr8oDRjVZMjLOjW3UEEN/qIlySN+cAoODT0zdO3
MqOS3RrzTq4rF0dE/3Lgy3vEZG7T6uTT1T/shDYg9oLhbUtP2rk=
=Nqvy
-----END PGP SIGNATURE-----

--CmE3bFYaHgG2j80B--
