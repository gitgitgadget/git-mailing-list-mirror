Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80187BAF5
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519631; cv=none; b=FUJW2jyAANEzXhIPa2B9rZ2aPJ2E5TDRA3t35G5O6v1UsWhNBI/Mb0YWkdUfrl/vLQgqQklneV7Ay66uXJtFA/icj1yQEwWplRQW2IO6NeaGztINob3L1AlNVEVNWtVvDUylgnNd3oWNe97LDhBOQKInXIVAGWqi5qTzWloITA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519631; c=relaxed/simple;
	bh=hfTYSYe/qufOl5raEIvWlR3Wo/bz0FA/5e48hAiNQ/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbIfe+H9KXHmDBiOftL4QB09qV2Z9Se/bSsp+cxy8W+K3k6Fic6rXzMLXWfS379m0F++8A2ZIM25UgFTv+0ykSm3Si6w2CBM5fO91f8JhGgf5KrAFz0bEyZTp8Oatx8/kQ6Cy64fKE2Wipx7yN4a1mXqLmDU0h6n8gIQjtMFIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bhVedXHw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTs3UEy2; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bhVedXHw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTs3UEy2"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 8C0301C000D0;
	Fri, 19 Apr 2024 05:40:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 Apr 2024 05:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713519628; x=1713606028; bh=PQOt2f3TV7
	tMquw1iQ5SaWsjMBkNgWR1cuLg5KZi5+E=; b=bhVedXHwHL29Qp/mqUsG6J9G81
	BFt1mETA2M06tasi1o4qQ2AEO7aaYhlmMF/6VAhvOATCFj/HW9epf3h8dzYQzvpd
	zxGr9BZ1DbFSOEeDfJP6DN7VnzMq8GLykpRtMHPk2sJjBt3Q77x1+UJtEO24g95w
	h2ohVQOQ0rPUlgh8X/NI4oBuXkOfojtsNbOwe19jcgT89insjKYevQb7r2FSpH3Y
	/pZr4nkkOph4TDPZ9HFEnaglMJ8B31K/EvueIsQLCeTts/BR48bUvmvgunaRPRye
	K+XI5SJEXYDxBZcEESHGaynOjwlZ0j7hdlVbQtSAGli+ZegQw6lHaC4jR5CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713519628; x=1713606028; bh=PQOt2f3TV7tMquw1iQ5SaWsjMBkN
	gWR1cuLg5KZi5+E=; b=ZTs3UEy2GJT50/ABLS6nl9Vg42Q6OSJ1FS7tTP3B3mKS
	MBrE3mncxUuAdkYExHHF3+VeAn+krDPtQ4xPTwTOTHG1FeBJxqIjRs+8KIrlGLex
	xncOUTGVWkfh5SErh6jMfS0JjI5jvbRmMh79lOcIE6a2pZoLgOohwZ6lpUxBi11T
	TnYax6HXUoYG2SHy5bP78kyuOgG9RGxNfCXfF13tS1BXzhx+PsBXxtr9JrG/nYWB
	rwamegssIR3suWGR75fpQoOTw1C4rd9jrHUsV1Xz1+vfGis33yKi1vIpZrqaB7lx
	7hifq2Nn6ORADmKekdheKFH8WMnRzX747ZIgwugr+A==
X-ME-Sender: <xms:CzwiZuYJqrXchdBt5DgezfCL9nEoqdUAN5HIMorGR1zAWmE0v-aq3w>
    <xme:CzwiZhb3SPphu3oiE1FivBAElpYkYwYjQpFudjLLDqB6Tf3RXrk794Q_y6ub-RMWq
    x5oBE2ibfo57VZWdQ>
X-ME-Received: <xmr:CzwiZo9Qt_LOjN6DZrzv0G8cSosrI2TOFFS8JzS2kKzRQ6H0K6_rY6UrUbxary_k90KT59agdySjLGT55Gb2iPP0MDwg61C9W1lQk1s7zJMDZJ2Dfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:CzwiZgozJZVLUm4QGj5px2XFIT4tnz_RK_2oI9HYZbX4REnrTO5phQ>
    <xmx:CzwiZpp7LeKbxzewt-kfCD6npH9qn8Vc37oqynVfRcrVoyWmfLchrg>
    <xmx:CzwiZuSYSCkHUL1pvw2j_q29vxn-LnHA11Oax9R8vJh8jp5hhSlLzg>
    <xmx:CzwiZpqCE-qh8skbYHORhhE1vBA4cYQUVr8eDx8tS9Y60kxbvQXACA>
    <xmx:DDwiZiBWXhlSIncHKZMczsWaElGOnLbe65fEdwfPnc7J66wK_hsCjius>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 05:40:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 211755e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 09:39:59 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:40:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Karthik Nayak <karthik.188@gmail.com>, chris.torek@gmail.com,
	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
Message-ID: <ZiI8B4VOL3agHBgK@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-2-knayak@gitlab.com>
 <c182c68c-77f6-422a-81ed-f6199c6b8a6b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GCCrKpzp8UN+c51n"
Content-Disposition: inline
In-Reply-To: <c182c68c-77f6-422a-81ed-f6199c6b8a6b@gmail.com>


--GCCrKpzp8UN+c51n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 04:08:00PM +0100, Phillip Wood wrote:
[snip]
> > diff --git a/refs.h b/refs.h
> > index d278775e08..645fe9fdb8 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -696,13 +696,19 @@ struct ref_transaction *ref_transaction_begin(str=
uct strbuf *err);
> >    */
> >   #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
> > +/*
> > + * The reference update is considered to be done on a symbolic referen=
ce. This
> > + * ensures that we verify, delete, create and update the ref correspon=
dingly.
> > + */
> > +#define REF_SYMREF_UPDATE (1 << 12)
>=20
> I'm confused as to why we need this as I assumed that we could use the
> presence of old_ref/new_ref to determine that the caller wants to update
> symbolic ref. Having this flag means that there are more possibilities to
> misuse the new API setting this flag but providing NULL for old_ref and
> new_ref.

In my opinion the same comment applies to `REF_HAVE_NEW` and
`REF_HAVE_OLD`, which I found to be redundant, as well. Those may make
sense in the internals when the object IDs are stored as non-pointers,
but queueing ref updates only accepts pointers anyway.

Patrick

--GCCrKpzp8UN+c51n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPAYACgkQVbJhu7ck
PpTA9BAAjy+VbjwjZTyGHCVynDzBYw57SCX0QL6/cA5A98K4BtNTyLxIyrNxExe8
+tqzBIdmpl1ThhhA2cIBjbPcF1qReNZvgxGX2Qf0JsKNiYZPiZndLOUdviNAcv8m
gWPj3a9oWzTUIoOVvbr2doLgS1hnpQSvBhytK2v1nsLAATbYuVzatuUvKe3k76ri
rE9fo8AVzfgjLoR0hs/fZJhwT7JujaJbfb8R/WmK4keCD0Cu20hX7EdWdeBbt5PQ
xp3lJP/m/fttdpIxBfAn7gXexe5AX1KG+xLgSt10zJAKt0WHoOuuSB6BzIxFHieh
43A8bZi6J1GSzxXxWmVcYn70GlfZYO+SkjGF2cA4j43FaNWvNxMYV7+SK/Vk5gwv
sXeF6Wpkm2mkqKUfjnSMrlCAIYpLCHJOeXOTOfil2w0U1/ybK3iqTKzhFnLC7OMt
B4lUiqUD0+j5DrJyYHD/vUDZ/X/jZKTo0FMJboWHDp+3nO5AAbhe2q0PYpM13U8a
fDoWgaKiSFJ03mZz2Ek14RBtAYI/rRysw+lfYYrqfgFKAPIFscf1gzsDfRPucK3H
+cFHgQY4ElkinUUg/hHWd4eTom8qaij4k1QOV2zktv0ubyWCY/ZMcOQDXE+dRSR4
F8eUzoMake/tjgFQgLqfqOy8oJgXYEnNA2kcjFYM2vUpIqbH/uo=
=zdyn
-----END PGP SIGNATURE-----

--GCCrKpzp8UN+c51n--
