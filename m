Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500331E53F
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032253; cv=none; b=E7444KT+LFIV8BIP3zmtkkE5sEcMWysH0ut3YPs1ShpUOT5SJxTxs+QRmXkZ7yMbvO1U0DoW71xfAAJHkOKVOOVjT0WxaisN3WeHL7xcyZe4FYxi/r89MwEVqWSlb4Bsle29LBUml3u75CXfCQHlGkynQe5MJ11neyuPCLfMygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032253; c=relaxed/simple;
	bh=iQQAMAJaCQHCT/LnlRciuF2w495d1gkb1P4zaO6Wal8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReqlSjUVeftIBD4AV80E5POGjcK4AC53IWKhG8MsJq0GUEGPPg4zLu97fh7iMXpmulg5ZchPQLSlPHE0MhP9D5SjZOgLJ4gDQ7jXGY1kbQ3vre7cnuXfkGWv6txjPZAjramYEdOSpOhyfdZXLJKiZ8L7HdBweZ7WxoMnCofnLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Iv5zLvTD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DjrVj+Rv; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Iv5zLvTD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DjrVj+Rv"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 1BE221C000A9;
	Thu, 21 Mar 2024 10:44:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 21 Mar 2024 10:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711032249; x=1711118649; bh=7LadHkH22Q
	B8npGbIooQN7ZZgTm5jEXnWqn0mIl/E7w=; b=Iv5zLvTDk3v0i5dHyZEKGWNGLk
	DqfIl/FfT1A3pRFAn+6cuH6jFL9tHyokb0gSKthX7qZ3I/VOqpiiyUKPQIYwH8yk
	4Aay7xWsh/nCMLauqXMfsMVEmDHcajM4EP5s7oo/eayZJP7LZnBr2VLjnFWGqE5r
	Vsa9xfD2RwuJV0dmnx0FW6817ji8UBH44Lmu9zTPtUanIKxHUvCqRUBIWhMSxute
	paT/xIxulkgGHw6HBETMpAykCbJ+s1tcXEg0ARlXSdJSzt7zdZolMpZhDrD/jOyu
	WAK+LOa2TizVnR45B7CET9koH977Mjpfy4dI3xUa1xGVO+mdPBkrKucM6rqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711032249; x=1711118649; bh=7LadHkH22QB8npGbIooQN7ZZgTm5
	jEXnWqn0mIl/E7w=; b=DjrVj+RvayHZunJDqhU8Gi4TqwWMzN6W0a9dJOuS/McM
	2/uhdm2bT9VtDh9TAXRumDLkXSno9ALYrIIDALHcR+InAPlNlSE+79vb0g9lMQe4
	BIhugbwWAJIBSORHGi+ajLQPuR8UyDKUbkIVeb0ZGFdf4dY1HCndfPH9A9978su0
	EVieVZs0oFMa6Oud+3Lu09H6xYfIgSdB97uCCqMLbVv0hfXf/xeRf0cbBL0CO6fG
	G/lg7SD4eKFXTer9tbRIgV4Qc5RhMYXSFN6mxFkzIX8k+WKvg4eY94LbsvAWcxyn
	O6XkI4ctLtMzcUaLOD2PR6R8qRCduVpGDa31Wob+bA==
X-ME-Sender: <xms:uUf8ZdMdnCI20m6o82DqzAP-UDD61QDKatviVwwuSVhmKuY4tuDhZg>
    <xme:uUf8Zf9gvr9oVtQA7yrayDHS_h8o2N7-wII3dq1pKHBvGlLnLMIRROoCwg8Sketvj
    _wbc1s2ZPocSUQO5A>
X-ME-Received: <xmr:uUf8ZcS-qDMflxpU13Ta6WRckaco59MwMtvNxDH3cuUW_B_vLVq4wf4byeC32NEzuyaGjyoHDWOBufkDTce4T5baIRqXyQAW35TVccnZbQ52sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeelheehvdeiueeuffehieegleefvdeggeehhefhjedtueettdfhieefkeeikedtgeen
    ucffohhmrghinhepuhhnrghmvgdrihgunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:uUf8ZZu90LNMGUZgyqfZdKxUAimlbQ1gNhXVgz29uAQ7ML31J7P-Qw>
    <xmx:uUf8ZVfBYYtpEcVJOtS8MgKCABNMW0BKmnqNLUUvRZvUJ5gh4N1PnQ>
    <xmx:uUf8ZV0YbluLAx2XTEmETWmFXQ1CP3a6w2z6AHBXDa1aT9iUXcMoqg>
    <xmx:uUf8ZR9_HWaz40Li73pWR4Q3OhwlZy4icczPLs_9PpeRaMgkdPUaew>
    <xmx:uUf8ZeGrgWBffAke2QPSILOx5EjkSAEclhV606T0r1poCexf15E7ibJOeBk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 10:44:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 811e2844 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 14:44:03 +0000 (UTC)
Date: Thu, 21 Mar 2024 15:44:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 1/5] maintenance: package systemd units
Message-ID: <ZfxHtetjUIUByqeF@tanuki>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-2-mg@max.gautier.name>
 <ZfwqCv889UdI0mU6@tanuki>
 <Zfw4XNJdZqgZhvOv@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bJU7MMvyk69Od8uu"
Content-Disposition: inline
In-Reply-To: <Zfw4XNJdZqgZhvOv@framework>


--bJU7MMvyk69Od8uu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 02:38:36PM +0100, Max Gautier wrote:
> On Thu, Mar 21, 2024 at 01:37:30PM +0100, Patrick Steinhardt wrote:
> > On Mon, Mar 18, 2024 at 04:31:15PM +0100, Max Gautier wrote:
> >=20
> > It would be great to document _why_ we want to package the systemd units
> > alongside with Git.
> >=20
> > > Signed-off-by: Max Gautier <mg@max.gautier.name>
> > > ---
> > >  Makefile                              |  4 ++++
> > >  systemd/user/git-maintenance@.service | 16 ++++++++++++++++
> > >  systemd/user/git-maintenance@.timer   |  9 +++++++++
> > >  3 files changed, 29 insertions(+)
> > >  create mode 100644 systemd/user/git-maintenance@.service
> > >  create mode 100644 systemd/user/git-maintenance@.timer
> > >=20
> > > diff --git a/Makefile b/Makefile
> > > index 4e255c81f2..276b4373c6 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -619,6 +619,7 @@ htmldir =3D $(prefix)/share/doc/git-doc
> > >  ETC_GITCONFIG =3D $(sysconfdir)/gitconfig
> > >  ETC_GITATTRIBUTES =3D $(sysconfdir)/gitattributes
> > >  lib =3D lib
> > > +libdir =3D $(prefix)/lib
> > >  # DESTDIR =3D
> > >  pathsep =3D :
> > > =20
> > > @@ -1328,6 +1329,8 @@ BUILTIN_OBJS +=3D builtin/verify-tag.o
> > >  BUILTIN_OBJS +=3D builtin/worktree.o
> > >  BUILTIN_OBJS +=3D builtin/write-tree.o
> > > =20
> > > +SYSTEMD_USER_UNITS :=3D $(wildcard systemd/user/*)
> > > +
> > >  # THIRD_PARTY_SOURCES is a list of patterns compatible with the
> > >  # $(filter) and $(filter-out) family of functions. They specify sour=
ce
> > >  # files which are taken from some third-party source where we want t=
o be
> > > @@ -3469,6 +3472,7 @@ install: all
> > >  	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > >  	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_=
SQ)$(bindir_SQ)'
> > >  	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
> > > +	$(INSTALL) -Dm 644 -t '$(DESTDIR_SQ)$(libdir)/systemd/user' $(SYSTE=
MD_USER_UNITS)
> >=20
> > I wonder whether we want to unconditionally install those units. Many of
> > the platforms that we support don't even have systemd available, so
> > certainly it wouldn't make any sense to install it on those platforms.
> >=20
> > Assuming that this is something we want in the first place I thus think
> > that we should at least make this conditional and add some platform
> > specific quirk to "config.mak.uname".
> >=20
>=20
> We probably want that (conditional install) but I'm not sure where that
> should go ; I'm not super familiar with autoconf.=20
>=20
> I just noticed than man 7 daemon (shipped by systemd) propose the
> following snippet for installing systemd system services (should be easy
> enough to adapt for user ervices, I think):
>=20
> PKG_PROG_PKG_CONFIG()
> AC_ARG_WITH([systemdsystemunitdir],
>     [AS_HELP_STRING([--with-systemdsystemunitdir=3DDIR], [Directory for s=
ystemd service files])],,
>     [with_systemdsystemunitdir=3Dauto])
> AS_IF([test "x$with_systemdsystemunitdir" =3D "xyes" -o "x$with_systemdsy=
stemunitdir" =3D "xauto"], [
>     def_systemdsystemunitdir=3D$($PKG_CONFIG --variable=3Dsystemdsystemun=
itdir systemd)
>=20
>     AS_IF([test "x$def_systemdsystemunitdir" =3D "x"],
>   [AS_IF([test "x$with_systemdsystemunitdir" =3D "xyes"],
>    [AC_MSG_ERROR([systemd support requested but pkg-config unable to quer=
y systemd package])])
>    with_systemdsystemunitdir=3Dno],
>   [with_systemdsystemunitdir=3D"$def_systemdsystemunitdir"])])
> AS_IF([test "x$with_systemdsystemunitdir" !=3D "xno"],
>      [AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])])
> AM_CONDITIONAL([HAVE_SYSTEMD], [test "x$with_systemdsystemunitdir" !=3D "=
xno"])
>=20
> Would something like that work ?

Probably. But while we do have autoconf wired up, the primary way of
building Git does not use it, but rather uses `config.mak.uname`. I'd
recommend to have a look at it to figure out how we handle other
build-time options there.

Patrick

--bJU7MMvyk69Od8uu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8R7QACgkQVbJhu7ck
PpT8MxAArN6wIw0PM04EPGJ5QBojmyZ8gXj9N2Vgi7NwRPWpUC7SkGPiaiXiX7Cu
32QEkaVUDP3ejMpjkSBSbFaVr+CAEez5rPQZFBHHSlG/G8/MpOrQQWid77pq1iSa
5QLYiYaGQOQodsaSsCTXR/8Z3UNfv4FUA2A54MAPYtU+s+kTyjyJ5x+MrLntXDP+
Br+znadUzXA+e/aiK/3gNZH1Ir+CDgXmSJj8iUGLLq6RaHtd40R3RNGZ9+t1dD88
KIrQ12hNBsKJg6M5hN9b+7ytix7Htq4/oIlSXyMy0LOeVmuww1//Bq3+14G//8oK
Z1J9M7Fw2s+s4fhKZ9c2PuhRA05XBp9ApSToJrG/iXPHQUswOs+CUhwedH3b90DR
Ge+XEp9yL96VNp7B4SKISqTsd53rYNe62v2aYbGIqxMpK4SJIXlEODZzHNCNqEqZ
CxlBYBneXlZ6QJlQ0a/W2QSjZAwm9e5ltXrGDBuAvvoHV0L0ixMMcqYCQQ4u982U
izV1L1Lp+nJZfIfnP+YjG5ncFaEy04jNEB8hlFBiWOcB6l4cypP+Is7WESy8QsEX
VI4lt6jI1J8oyrvSp2u86hDD6jACgrtMSGgXpjo5Ch2V08iA/KOJEVa4SNLvQPPi
uzGdbCvHsxiKeMD78bqdVKtmJzQ+DOsIsM0XyZBWmSh2RU0oCMg=
=GTPI
-----END PGP SIGNATURE-----

--bJU7MMvyk69Od8uu--
