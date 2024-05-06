Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6A6CDCE
	for <git@vger.kernel.org>; Mon,  6 May 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988090; cv=none; b=eYcCFVNfL+Kww43Zk9YJ3gt8svpK4Q0+BukrMGaP5eT0C3yubc1tAgj0gHXo9wAWCc0A/R1gm8Z7+MllLoGpIljWAMMqk52mXo1VBoRy8I2nsFYMgBGSo8Pm/djtD2Hs7JLNyT9jdz252v6ZnBetOiQNCF1y30OUMvKcxUWLLvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988090; c=relaxed/simple;
	bh=NR3iS+Qeb9ZURs8d71edPzfy9N3qBj81He0NfZQG4ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkISlI+ACkJbjbF9NIAbp37zjVdBsVzjYaHEXGYwusvQp9nhKseleQhYDMjOSLUiEFGLWbYGKVmUtBIFVMBuQd4gYJsTeqsXLlYhbzz9EkKBpHyvLqWMjOB0oBiJoY2wbJjShzMdsPiOafDKbEUYMSKaexNAQj6NX2jxp1Yb1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N9sMvFns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bpL3v4YC; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N9sMvFns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bpL3v4YC"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id D4B881C000F9;
	Mon,  6 May 2024 05:34:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 06 May 2024 05:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714988087; x=1715074487; bh=TPsmdhndrS
	REzCtwFQwxME8ypUdKzht56yijUtNCf/E=; b=N9sMvFnsJxH1gtvZpjbCZC+CQi
	6oY1XMlwHdWXIeEDhx1Xh/vFN98nrTvT6SgCJzoFCXvtntLkrUoDhL912P65Az3r
	vrOb21iRJxpYLdlQh/nGFTgbjk/AbJMNHsuMHlqX5jfRFDPzt5hj8KA8aNUUzeCR
	0oalhBQtkAQsRcqLouh8i/+ACBobP6HYUzREitXxQ+RcEBalZ6tW1i92ZS1ZFHl1
	1IaI/FIELNx4kQNw48eRKBubWrUSaKPiWUObC1YJ+vGi+6bEckXXZFdD3Dr0Bnng
	gJPS7QQxUOu3Y7KZqwH0njRNzxGu3x5RDaN2IddxfHNifkVL3Ll1+4UNFgbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714988087; x=1715074487; bh=TPsmdhndrSREzCtwFQwxME8ypUdK
	zht56yijUtNCf/E=; b=bpL3v4YCc0lG740C6lcHRiWNalFBw4wj5yETW0yMGrDV
	pZUTW2y7G8UX0dFzFpyS1OfQDhRF+VEWXTOYKwpWYfSmkgG7IdJb7LCtRhVmZpZn
	JjA2nDVvCz483BPNZt+OrUPA6Sb2THerDK9uTV8Qz34sYIbfJzppqs83mVjd8/LY
	+PfKcKjUW85eGhhKiF+6RF+lJT54YPYlQLlnfL6iuXCg+Pz/chFud8Yp2E6lp5az
	URIxew9hpn18stNfJnbvX7IGz3E9WLznyrgW/m4PpNJGXPGz7HptjhXjGyR13Zr6
	9P7kkK97XiF8XcfJipKAQ2ljSMqJK81SyUniH7i4xQ==
X-ME-Sender: <xms:N6Q4Zi5lEsLktl_21nLHMldIp5-k_ItlHGOckc6lc9tmW6EImn3ZEQ>
    <xme:N6Q4Zr6EGpvgkeZrXFi08LXCwZO6ndFVy-db5ENeIMyTZTA-303Vlcnt9byZfYM7A
    mN62eEjhOiYrXaQXw>
X-ME-Received: <xmr:N6Q4ZheRFfhYwEsVfqJ-1RSPU_kik7mDftHV2K44ccK4shUJvQfRbky0fneuuF-w981dHXfjCaI1So-HeFH-T3ggF2bwmgWxvHpe0kAcI82hJiyE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:N6Q4ZvLcoPkkYR115T3MPx8PClzEUQBIQgCMBEKT7va5LtRF-T64KA>
    <xmx:N6Q4ZmJDW5flmNpDYKX4886ODC65fLMZmOWkjVRnIALBf4ay8hIGig>
    <xmx:N6Q4ZgxZpAs-Ktipgav3R0AtExXPqtNCu_Z-knH1qlAx5Qi769u-ug>
    <xmx:N6Q4ZqJDqI7NPkkCC1WNVTtN1-C6QibEYhlQk_fuQfHD1KL6P0lg3w>
    <xmx:N6Q4Znq6Ru-wDkO9s56jOlWq36Rkhj3OtMFIae_ZwzbXaPFjLrbdv3LM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 05:34:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5bbb1084 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 09:34:39 +0000 (UTC)
Date: Mon, 6 May 2024 11:34:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/14] builtin/config: move "fixed-value" option to
 correct group
Message-ID: <ZjikMpvHnTK01YM6@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
 <ddcd8031d7e399b126344d82d3373a2b2ed7fb8f.1714730169.git.ps@pks.im>
 <CAOLa=ZR02Jf3-4zT9gMzVmzS1JNR1MCLDHCV+utR3B-N_acK=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Klxe3EFHyCsIBLXx"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR02Jf3-4zT9gMzVmzS1JNR1MCLDHCV+utR3B-N_acK=w@mail.gmail.com>


--Klxe3EFHyCsIBLXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 05:28:38AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The `--fixed-value` option can be used to alter how the value-pattern
> > parameter is interpreted for the various submodes of git-config(1). But
> > while it is an option, it is currently listed as part of the submodes
> > group the command, which is wrong.
> >
>=20
> Isn't it currently listed as part of the 'Action' group? Also I'm not
> sure if the last sentence needs to be corrected here.

It's what I actually intended to say, yes. But I agree with you that
"action" feels like the more reasonable way to put it given that we also
call them "actions" in code.

And yes, the last sentence needs to be corrected :)

Patrick

> >
> > Move the option to the "Other" group, which hosts the various options
> > known to git-config(1).
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/config.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/config.c b/builtin/config.c
> > index 59ae5996eb..054019b70c 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -643,7 +643,6 @@ static struct option builtin_config_options[] =3D {
> >  	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
> >  	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
> >  	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
> > -	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when=
 comparing values to 'value-pattern'")),
> >  	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
> >  	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot=
 [default]"), ACTION_GET_COLOR),
> >  	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [stdout-is-tty]"), ACTION_GET_COLORBOOL),
> > @@ -663,6 +662,7 @@ static struct option builtin_config_options[] =3D {
> >  	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (work=
tree, local, global, system, command)")),
> >  	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get,=
 use default value when missing entry")),
> >  	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readabl=
e comment string (# will be prepended as needed)")),
> > +	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when=
 comparing values to 'value-pattern'")),
> >  	OPT_END(),
> >  };
> >
> > --
> > 2.45.0



--Klxe3EFHyCsIBLXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4pDEACgkQVbJhu7ck
PpRy3w/+NJgUwJAW5MwHmVxOIeJa/rO2SulhqQyV2q+SvhoPNKCWccOMiEPWvF+S
faE8jSHZYoubDNir49Nr/v0vq2t/6z64Dx7/K+mIttFCFxF5wkAYeD6nSe3V8bg1
QWuli27yuh6hcC3MnFycN+uZO2YKh6WpJh/2LOSMa1/qApKy6OprjGexdt85eCAB
kDq+/Nix8wnoB7EsR9aCdhch0OKtiClsj40NHO1AuGLL0JQMY2PoGSrhC6t8y0GE
gHXQUIGqJ/2Zm5Kcne1tx/7+kooOozwA+BibTuQwRL3tEOsvdn9akx5LU9/YYFpj
Nd4/4exVumDVZlN40ee0cvNubzbqVB3+hvkxDdMAn1XBW47067+AVBKubjsHteDJ
hD9HZ42HH359WytnG+2A1gkZZMABiHbcfzC+Pw/Lh5ho5FMxMOSTH+VP5epPeN6b
zRJWcj0kv+SEI71bCf+qjGqt43ysNr0Wu2r4vRZYe1wFB/+p9OT+KbCtzBXPa+s2
DXQTLWWYpihYMxeTmKRWoRNV6bwiZ2jfr/tZl/ouqRjp0oE9uJIMWdra+2woXQ8l
0uMRaU5gUo2SCUaPNMWt2eiymoCzksYPwWw0abLXDsooQVX1ETnYuQiAGqFQCd5l
ZQ/T3oiDoivuyADtxKgEKCYox1jl1PD67e36CJpnYoP9kLi538M=
=Ib+C
-----END PGP SIGNATURE-----

--Klxe3EFHyCsIBLXx--
