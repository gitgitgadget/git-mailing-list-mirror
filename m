Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764D12B87
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263511; cv=none; b=kl0za2PdTBde/FaRPcA0LlRZz5FtHLbYIK4mLXDfKymOCCotlBLAeA0bUS0PchF4hl8wu9JQzO5iuGOkqg0lTTZ9HSnWmEU2yNhdEWWiniGWXcCp/T7DmLy9OaF1P0EvpXzqQDduoBaL8eqW9K3CViN6dIGU1mhpNQTzZQ1/CCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263511; c=relaxed/simple;
	bh=czAtMdHHKf3Co43YV7+kiYiFIlQ1GK4ur1dR06DqVT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmBCfJQTJJC30zEsC1Tmka6rha1q2hLy6F1nGS9lyCYjiKOyAeveN1AhpsfT/4QTtnTs1Mqk0QSjhYao4CJxFA5MttHdSj09CauNAYmMs/tLx2/wPwE2rhG7DemvL5n3ne3h+lSjcJ8XDxt62FPPMLPxtfWEUoDuRi2MLBWWdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=llwPYSr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GX6fWdRE; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="llwPYSr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GX6fWdRE"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 6AAA85C019F;
	Fri, 26 Jan 2024 05:05:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 26 Jan 2024 05:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706263507; x=1706349907; bh=UNuXAmoBgO
	IEx2agczlbSVoTMGhpPNHW+NQ/Jk2z3qw=; b=llwPYSr/tEE6bwOCSBoKtsNiJN
	ChDUSyyiSsw0OVNDNUGs92Ru80Bwz/e1iQ/0Uo8HSCUKkhAJsCojsqcXh2iEpQJ4
	Xekh+/U0m3du7cWbULRLtTdgvu59OyncuuTU1LNHAAasdi1HIPM3LsXO7tC23+mE
	NrVp20R5QZi3fGmURGpVOGe5KWu11Ep7bSiPL7WCwrX4tD5I+5dqBr4TNRcshjLV
	4co61djJ3dDdOBUaUUAOiqDXFKvlE3wX3wTt5wfN8su8iuaEQ+yoPUKrqn7L2fQR
	1vb0uBvHTTs4z0pOX3pWvzPQsdSZOmBfzNjyQ/u78S/rAg9Q04HNDEG6N0Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706263507; x=1706349907; bh=UNuXAmoBgOIEx2agczlbSVoTMGhp
	PNHW+NQ/Jk2z3qw=; b=GX6fWdREo8CbiPhd5nZr4j7OmkMAEBlH3V3WQTs2mgh/
	T+NQG8a/KcwzGPn+vKICJQOF4KMycdD6Rqi5kKOEoeujDGmxB2KtyyyKh2x7AdkG
	w6sj7z4HT+ve1V210XA/Pwi4D/8xEZN0uM3S5+Dq+cJeues4y5kROh34gIObo/md
	09UO6x/RWNdaLlMU3vF/6NH9Mgyz39Vrh8MoXMDPuoEBafggCYt13mLUvBsPYhKH
	irE/qd7s+Gqs5DcztI0M/GDpykbZAX5q850ltH746YFt9zdkX3w+lrl4BFzscnq8
	VGMbjD7cCaws6uq5Vz0z1L1773WSqZxiFLX5FkfS2g==
X-ME-Sender: <xms:04OzZXGzQGLSqWn7b0toDcBT_6jxeMkRmhKEFQDALQaeQxac9XgjUw>
    <xme:04OzZUUJ5qhd0diJifpsXyz0IdVO-lJzceLC9qL7G0oytrE-vFKJLCFz13QZsAsmQ
    fUOEJv9yKYD3wwx5g>
X-ME-Received: <xmr:04OzZZJIQu-YKq-dG6VJXCIhfLDo6RyHkC-LpAHgdnPFiIjwyRThJfL3ZRuOvpgINe12OrLN2aCTsefkwdp3XcvRgiyRqzIeSxv2j-VRIKj6ugz7Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:04OzZVF-5zOOu-xRM3JEABsQqVrcZvmmaKeX3DC80TBrqrH522IXnQ>
    <xmx:04OzZdVS_QEuKpb8VLgxvJr4NUAjEx0de3dSAjKXSzoDpDLE460ESg>
    <xmx:04OzZQM_igT9J6P5gV6MdkkH5BSIDa3q4s9GchtGzgDPzIGN9SUfMA>
    <xmx:04OzZeclBVZvZiksISJAlRWxN4Rbzdpv_JkTk7cVRw42yb4rHWytYA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jan 2024 05:05:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3b8bdf05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Jan 2024 10:01:54 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:05:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] reftable/stack: adjust permissions of compacted tables
Message-ID: <ZbODzwjpMjdYpOh3@tanuki>
References: <cover.1706099090.git.ps@pks.im>
 <b2fb6f5ad0c558527341bd8040544d6b0ae5d8a2.1706100744.git.ps@pks.im>
 <CAGAWz+7hQGMbnc8c9iCzyWQgS=wkaEXXbC7-Biqw2i7oc6rneQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VezmMCg0AwJZxLWP"
Content-Disposition: inline
In-Reply-To: <CAGAWz+7hQGMbnc8c9iCzyWQgS=wkaEXXbC7-Biqw2i7oc6rneQ@mail.gmail.com>


--VezmMCg0AwJZxLWP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:02:15AM -0600, Justin Tobler wrote:
> On Wed, Jan 24, 2024 at 7:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >
> > diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> > index 289e902146..2e7d1768b7 100644
> > --- a/reftable/stack_test.c
> > +++ b/reftable/stack_test.c
> > @@ -443,15 +443,16 @@ static void test_reftable_stack_add(void)
> >         int err =3D 0;
> >         struct reftable_write_options cfg =3D {
> >                 .exact_log_message =3D 1,
> > +               .default_permissions =3D 0660,
> >         };
> >         struct reftable_stack *st =3D NULL;
> >         char *dir =3D get_tmp_dir(__LINE__);
> > -
> >         struct reftable_ref_record refs[2] =3D { { NULL } };
> >         struct reftable_log_record logs[2] =3D { { NULL } };
> > +       struct strbuf scratch =3D STRBUF_INIT;
>=20
> The variable name `scratch` seems rather vague to me as opposed to someth=
ing
> like `path`. After a quick search though, `scratch` appears to be a fairly
> common name used in similar scenarios. So probably not a big deal, but
> something
> I thought I'd mention.

Yeah. I basically copied the below checks from another test where we
already had the permission checks, and also adopted the name of the
`scratch` variable. I agree though that `path` would be a better name,
so let me change it.

> > +       struct stat stat_result;
> >         int N =3D ARRAY_SIZE(refs);
> >
> > -
> >         err =3D reftable_new_stack(&st, dir, cfg);
> >         EXPECT_ERR(err);
> >         st->disable_auto_compact =3D 1;
> > @@ -509,12 +510,32 @@ static void test_reftable_stack_add(void)
> >                 reftable_log_record_release(&dest);
> >         }
> >
> > +#ifndef GIT_WINDOWS_NATIVE
> > +       strbuf_addstr(&scratch, dir);
> > +       strbuf_addstr(&scratch, "/tables.list");
> > +       err =3D stat(scratch.buf, &stat_result);
> > +       EXPECT(!err);
> > +       EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissi=
ons);
> > +
> > +       strbuf_reset(&scratch);
> > +       strbuf_addstr(&scratch, dir);
> > +       strbuf_addstr(&scratch, "/");
> > +       /* do not try at home; not an external API for reftable. */
> > +       strbuf_addstr(&scratch, st->readers[0]->name);
> > +       err =3D stat(scratch.buf, &stat_result);
> > +       EXPECT(!err);
> > +       EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissi=
ons);
> > +#else
> > +       (void) stat_result;
> > +#endif
>=20
> Why do we ignore Windows here? And would it warrant explaining in the com=
mit
> message?

Because Windows has a different acccess control model for files and
doesn't natively use POSIX permissions. I'm not a 100% sure whether we
do emulate the permission bits or not, but I cannot test on Windows and
the other test where this was ripped out of also makes the code
conditional.

Will explain in the commit message.

Thanks!

Patrick

--VezmMCg0AwJZxLWP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWzg84ACgkQVbJhu7ck
PpQQ+A//cV+YEaFsG+3mQpYcBLEgO7eN/epcdVGEiylD5Jfaod7tkgCSyla6UtY9
cbt6EoPYU+0FeKPlL1NLSHPtT49jfxOL6P3/hYvwip/WBNT4y3E33RFGnyYelqww
K/te7b8HknYSq/BhmzmpGFJBY+3a6s9JgkpVdSk1i4EoL1n9vLiHsxmT9nl8NsAv
zn7mWpc1R5OWhvW9p5d5YGgUW1CxD4/zdAmMvRuj2pIiEhToVm82Qd143MNz21x+
0gVYjFtOnXecbABvY+ggVRy2Of3nfMt197B0MZu9TyN8TtttBciWZClFtnIxaE5/
YjdM0CH/PD8l5usWFwmOz3Ka4ci5dxJ1izSbPuwA/60TBOEn9MreCCer2qm2Ymer
g0qzFZAOOum1KZbQ+Ndfkl/47mrREvD2RebVsPphedHnsX3HJo6KJc3huvj9c32u
47sX9Ojzf/z7hyCSnIL9CxdBi2wlO4pApOVfHbl/3sTbMb+NEPUCUY48sL1xD7Tw
7lBLUAQ/wW99QaksNht7qZDOFI58euNozjfMuNlOgOrIfJDwsKwvFZX+01ON9jxy
dmuNsVWZX3iT89uW+HzBKT+t+8lN6sFTucpJ+jfh33ZFxgQEKbWlC4brKnQbOyKE
gUzHc5FvoqwwMbZstEXrH27aSQz2rfnUuPlw2/yPtCdPCCNnBa0=
=t2yS
-----END PGP SIGNATURE-----

--VezmMCg0AwJZxLWP--
