Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B722159918
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078128; cv=none; b=fSJTNIWD8lJ4zudyuwA/JGPDyNbCKcZ03odWaOFYnD/NaIMzSdfLOjxHAGbWbTwf+unEP9x5iF3B3S2XFg27zsyR8jANuLKUv3G7+dckzAxes/4lZP01QNSldCnZsrh2Ny0UxT0DRwV6AGuog2ePqle6+8v90wbcZ4NVfjVe7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078128; c=relaxed/simple;
	bh=dkZixg/NoojFvBGlL4/3aTmduzukYBK9sMxf3iCnPJc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss2qcopIT167b1JuYKZrousERFZErJCqB/bjMRDddz1q3Msbj6tathh5jNZOGl4Xs82CvugbbTmEwvycufX7c/Lhwmrc7kC1K+YC5Dc52o5E7Z94yOdowDP5MoZFB5r1hvOhsQi1lszQzTcyXqdPge7QHIutQrQlhVTVJnWpUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=divenHED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CRQZdQsl; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="divenHED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRQZdQsl"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 35A9418000DE
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:15:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 13:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078124; x=1712164524; bh=wqe7Tp3eOx
	n7A+LHTiwr/XTrtMb64wIs7APPAyIWe/A=; b=divenHEDzSr7IGFOPZIlY4h6WQ
	1x/u92HB8C6bqSRVG3uBYlvOsNqaT/aArEG1q0aOWaUBufArcQ1UjEi2ht+YZoht
	H4lHG2y6SmqCIlbTcp7c2XUgRBx4hoX10mV7KwGQCdcvLv4cHDyuvlvSCMu5V+Fo
	lAsGEfBxLo93NrsnYftg9dPHw4fe6APHj9SZ1izTRK7iUpnACVPuvAICa91HhLtq
	SSFrqrwdBOMlthxh4zmdtgFxyo/deb+KiyY2jV2JxjYefQbx0YsWM2wEkuhMZQ0A
	Z6hukcX0V9sb30T37+aB1K5WMA1cCn48Vtt70M81QAlVJIelYkwvE5Nppd2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078124; x=1712164524; bh=wqe7Tp3eOxn7A+LHTiwr/XTrtMb6
	4wIs7APPAyIWe/A=; b=CRQZdQslw1iAEb7xt1MRS9mN4cS127EBpLyQEEoYRMUU
	+6Th/tKV+oE16X46pLoD8+JAiHaUSZrm0UIh7aLFA0L2QiSV39wKlEYyTIMfQ39i
	kgk+33WJNPMVU3Nr9HpnPo4tedQtsPrI+MH/bQ+spWH9YtXv4Fafh+Il4Kv82XNo
	aZiyeDMSX1HFFDHhPH3PPUO72KoCkuvo9IXRFL40rBvNmXc9tfDeBDS565JpJKMV
	/ewBFY9VTSfhS/VwsNxxtaex4WA+Ry938Wf15MqkNoBhBhewSjYLd3YbirZ96caG
	9TVpus8wTcp9cjnxyAZcPDIEQsFU3Z1ZZtVCFXwYKQ==
X-ME-Sender: <xms:LD0MZpBa4QA3QbjIKg3zKVnpaIk0CxDwQMIaZ4jUFybVeYJQnYWHfg>
    <xme:LD0MZngLB3zXfviFp5ehqyZbbUOnqihuKLnG46Epmua0yttgCI2N2n2wa96rNtToR
    8zwrwng1E1IeQCBNw>
X-ME-Received: <xmr:LD0MZkkKTr3gKcrw_fFqO4ODK8IaYXrMSr8X5-EXfqggMbAC1rmnzMB5XWNAwxvkVUVAXOfHs0t5pEuw0_w-YHpPniCobZEpJjxQexBgw2e65LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:LD0MZjxjp8VBMAyDJ5q0AsmYMJRJYV8zWibDF4Vx46zdfPuCvnpHVQ>
    <xmx:LD0MZuTsAEvgF38XvcIi45beE_BBfl4nzR0mClpfv7zaebyngiHIfA>
    <xmx:LD0MZmZRUF_OT8bai_QpKf9vzhe9mUeFWEgk9WRi5CVZr_yF_Gcx9w>
    <xmx:LD0MZvTd-a5VgovdCKc-3OREoCYFODTVXsCOieinyyYn0ZR-oeGLbw>
    <xmx:LD0MZpcy_9MpXpYOMjds80Fl3tgGEyDihUF861Nyz69LD9T9lOrvYjsh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:15:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 581f04db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:15:11 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:15:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH v2 3/7] reftable/refname: refactor binary search over
 refnames
Message-ID: <Zgw9Jt9nkoupo38Q@tanuki>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
 <9ffcf45c32f22245c9978436affcefa914fc6927.1711361340.git.ps@pks.im>
 <zvw6ezlchqyl5tq4zuia7az5b3i4swwvtm42muwe4i7gngswgz@ztujhb4ruewm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oyb3bOgKslJvVI+/"
Content-Disposition: inline
In-Reply-To: <zvw6ezlchqyl5tq4zuia7az5b3i4swwvtm42muwe4i7gngswgz@ztujhb4ruewm>


--oyb3bOgKslJvVI+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 11:27:01AM -0500, Justin Tobler wrote:
> On 24/03/25 11:10AM, Patrick Steinhardt wrote:
> > It is comparatively hard to understand how exactly the binary search
> > over refnames works given that the function and variable names are not
> > exactly easy to grasp. Rename them to make this more obvious. This
> > should not result in any change in behaviour.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/refname.c | 44 ++++++++++++++++++++++----------------------
> >  1 file changed, 22 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/reftable/refname.c b/reftable/refname.c
> > index 64eba1b886..9ec488d727 100644
> > --- a/reftable/refname.c
> > +++ b/reftable/refname.c
> > @@ -12,15 +12,15 @@
> >  #include "refname.h"
> >  #include "reftable-iterator.h"
> > =20
> > -struct find_arg {
> > -	char **names;
> > -	const char *want;
> > +struct refname_needle_lesseq_args {
> > +	char **haystack;
> > +	const char *needle;
> >  };
> > =20
> > -static int find_name(size_t k, void *arg)
> > +static int refname_needle_lesseq(size_t k, void *arg)
> >  {
> > -	struct find_arg *f_arg =3D arg;
> > -	return strcmp(f_arg->names[k], f_arg->want) >=3D 0;
> > +	struct refname_needle_lesseq_args *f_arg =3D arg;
>=20
> nit: Looks like the `f_arg` variable name is a remnant from when the
> type was called `find_arg`. Do we want to rename this to `args`? We=20
> could also rename `void *arg` to `void *_args`.

Yup.

> > +	return strcmp(f_arg->needle, f_arg->haystack[k]) <=3D 0;
> >  }
> > =20
> >  static int modification_has_ref(struct modification *mod, const char *=
name)
> > @@ -29,21 +29,21 @@ static int modification_has_ref(struct modification=
 *mod, const char *name)
> >  	int err =3D 0;
> > =20
> >  	if (mod->add_len > 0) {
> > -		struct find_arg arg =3D {
> > -			.names =3D mod->add,
> > -			.want =3D name,
> > +		struct refname_needle_lesseq_args arg =3D {
> > +			.haystack =3D mod->add,
> > +			.needle =3D name,
> >  		};
> > -		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
> > +		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &arg);
> >  		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
> >  			return 0;
> >  	}
> > =20
> >  	if (mod->del_len > 0) {
> > -		struct find_arg arg =3D {
> > -			.names =3D mod->del,
> > -			.want =3D name,
> > +		struct refname_needle_lesseq_args arg =3D {
>=20
> nit: In the other commits we use `args`. Do we want to be consistent?

Yeah. Given that it was my own argument to be consistent across
callsites I should rather make it truly consistent :)

Patrick

> -Justin
>=20
> > +			.haystack =3D mod->del,
> > +			.needle =3D name,
> >  		};
> > -		size_t idx =3D binsearch(mod->del_len, find_name, &arg);
> > +		size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &arg);
> >  		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
> >  			return 1;
> >  	}
> > @@ -71,11 +71,11 @@ static int modification_has_ref_with_prefix(struct =
modification *mod,
> >  	int err =3D 0;
> > =20
> >  	if (mod->add_len > 0) {
> > -		struct find_arg arg =3D {
> > -			.names =3D mod->add,
> > -			.want =3D prefix,
> > +		struct refname_needle_lesseq_args arg =3D {
> > +			.haystack =3D mod->add,
> > +			.needle =3D prefix,
> >  		};
> > -		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
> > +		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &arg);
> >  		if (idx < mod->add_len &&
> >  		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
> >  			goto done;
> > @@ -90,11 +90,11 @@ static int modification_has_ref_with_prefix(struct =
modification *mod,
> >  			goto done;
> > =20
> >  		if (mod->del_len > 0) {
> > -			struct find_arg arg =3D {
> > -				.names =3D mod->del,
> > -				.want =3D ref.refname,
> > +			struct refname_needle_lesseq_args arg =3D {
> > +				.haystack =3D mod->del,
> > +				.needle =3D ref.refname,
> >  			};
> > -			size_t idx =3D binsearch(mod->del_len, find_name, &arg);
> > +			size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &arg);
> >  			if (idx < mod->del_len &&
> >  			    !strcmp(ref.refname, mod->del[idx]))
> >  				continue;
> > --=20
> > 2.44.GIT
> >=20
>=20
>=20

--oyb3bOgKslJvVI+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMPSUACgkQVbJhu7ck
PpSkeQ/+MlNCeAQ1GDF+CYxQjrZEGkyMP+NkJregiRPDC8Ld0P2o3N6SL/xl3kj3
1VUfYr2D5d3udym7QDpPZJZVs3i83pAK4TysLT4cZmUkcVkptviE2Q/sGWeWL+dS
73/l1UTlU6ftT9/mJS0xIauKxT8ge1+t/nj6yb5AsV3UEc/whjtrJWIj15C0wRC+
Iq2hgpaQDgZBN7YSMvsCBZrJgpo6shRJeVKGmwgrIrMxV0f2HjRRlDEkeMU9fri4
A+tlRpQsjs1+fP2b962ewpCH5Qbs84Vw/euVTP5ROJbD8cAUPJHdTLQ7yrywlckd
x6oc9LSF6ccdOwqLtEukjzglxWCs3ZRKfZB5Kdwwf8lyVjm0c/T1zCGOWqOvHTMM
E2zpG2db0HGpxJpKvTh6WF6EXGJgBEPhCEElIQFbrs8yXKt0QPKAJ8aUyFKfqGfH
iC1QlkJU0roSDy35e6lPBEzBcLffY+0PI8RojDHiyLirr0jGYm0mlJxuuiyYPFB+
LlqS85PxYg/JYa+f8ftOkgD659jNvXAkSeO1waTISsXFEfF+GhDneoTYmPulqWHw
JfDOpE4GCoDuGG93pgRurEB1QoYcuRwDAUtZn/gxXOMJO7WqUrYgjuCjUH2v4Z1W
95ofZDCZskYluzQG6dwhITdWyHdMTM6/mnwQCKjat//PR5ZvXW0=
=FuHD
-----END PGP SIGNATURE-----

--oyb3bOgKslJvVI+/--
