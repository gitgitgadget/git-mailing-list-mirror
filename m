Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F279B8E
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024658; cv=none; b=sasnLusWBxuomSpmpF+qFrJ6x9EimwP5mQ6quWmaCP4QvvfoKOHzp6k5eet2AzpMzkrXEZOYs1idpmg1z1vb36fALLOPKBIbvnoJXE6xQRBT0YaarFqsGvHPep/LVMNWqchamnY0HxPGI+ORB7X3yr8NybXLj8MeI6R9jljZJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024658; c=relaxed/simple;
	bh=gI3nruv8DLkJxaJ+RJlYJsu78jZ8zIWOrXRJy1PAE7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e503XmLpghLK0OHGuqE2c5rBPGvc/Ku67OKp5cdNDDd+d+DUgLpFGO8tJwRnmIRfEVEgl1F8MISgq4fpqa/AgXZwkNVagHo3kw0PFD7l5Dw+BhunggZ8Cl0rbZxbBfP1+66LUqoWHyMlbtuaMO2IRSyhfTNHY452hrjxsaKHJ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FEXg0kek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tjh+1vRK; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FEXg0kek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tjh+1vRK"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 5F0771C0008A;
	Thu, 21 Mar 2024 08:37:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 21 Mar 2024 08:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711024654; x=1711111054; bh=jGq+84qWU4
	Wx4BtUWnlZJrm5rsIaMoA8nXpFu0R9fxo=; b=FEXg0kekVUSvvKPly5bUE7yVHT
	Ro/KCGvqOrzYM+/lnwZNZYkIWS3tNuoOytywBwwWayPXd9PQDC6elya7USksQbdT
	roXLNibQEyzEnLfJ91PgtYaNFwVkhpvLtWYx9S2Ox8SJtlxtBtYmRpRpHAOpgRDu
	picQPlqcAK9o+YbZCgmi4AE6AibVw4fjZqgli1rOQAl4D3B5ipGj/uyon91rwSvk
	1X+99vqDMF8HcHZk9fk/H7dTQdspFg3qGzX18bmD4ATujDMa3Ha5NnWpJrZ+zlYO
	+KQ/w0sSLZjGvNUperuy526sU/R/jUmvHKO4JJdVI3YVr06Ub063D8zNiPLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711024654; x=1711111054; bh=jGq+84qWU4Wx4BtUWnlZJrm5rsIa
	MoA8nXpFu0R9fxo=; b=tjh+1vRK+GkSK9RCxpV6bwzf+5wCQQ3FKZD+CCipm2aZ
	QZGWppCgFy4SVPZIp6gZBHExR4J0B/oKfl2BJjLCcrwZ8cWQSL6KLQmvsds0t/Fp
	4UQKncIrZc6hU2D1l/UZfLYD0Ks8tp2rxLwwOA5uzssREcWoULDwagzj5qzdu0h7
	mOY/ZVKn4UR0OANlTcuounBuOhab9Gu0z2IHWKwfK4QTg9/V1SuQ0aUWZkvZRXXe
	EctlAmY3CZByPIPDhnK77Y4uTuPsRzrKrS6oWlZwBH1ffSwG3ppeggr4obj4l/GY
	G8bbqh/ugSpE+PY5mdmfNzbON9l6NgXjMGQiVlfOiw==
X-ME-Sender: <xms:Dir8ZXPMp0gZBDeZhv5LvH35lyHSH4FfvBythByYkSNwdAZsZpVaYQ>
    <xme:Dir8ZR97Gy1wGHUO27mWq2A_NTkol7CoVXkgkokDdMn0F1SxX5c9cUv_f3iLyqyLs
    qK-TRfWXwpDA28eng>
X-ME-Received: <xmr:Dir8ZWSeRT_COiNHDQO6Z4r7nhISPQZjfPpS31G2GyHkCQRKy8frwiaIHWPR4qeYPvTg75mPQN70pmM8PM8ugyM7C09c1DWNSSQmJR8lLykHqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Dir8Zbu0BX4mZvXGDUXohvg_I036CRCwnSPjlEHHjR6xAAAFVRpaaw>
    <xmx:Dir8Zfe5dcvolXMyxIlKLsjG236lPEiPu6aBVcfg2ENmY-6rpDrT9g>
    <xmx:Dir8ZX20zoiq4pr5PC2PEzYOYUISQftUptzPcGltB2IhLkwGtnZs1Q>
    <xmx:Dir8Zb-4BDJW0AW20UrCGHjJpd3CtQ-AjQhZb4fsaHzBm3tl2gqQDQ>
    <xmx:Dir8ZQH5biweaHof4v1kSqpot7M5zE2uLgI9ZMnEuJ0BZ-Dto32FPRKXTII>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:37:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df9c1ac7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 12:37:28 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:37:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 1/5] maintenance: package systemd units
Message-ID: <ZfwqCv889UdI0mU6@tanuki>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-2-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JNH5XexEgcR/DsfD"
Content-Disposition: inline
In-Reply-To: <20240318153257.27451-2-mg@max.gautier.name>


--JNH5XexEgcR/DsfD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 04:31:15PM +0100, Max Gautier wrote:

It would be great to document _why_ we want to package the systemd units
alongside with Git.

> Signed-off-by: Max Gautier <mg@max.gautier.name>
> ---
>  Makefile                              |  4 ++++
>  systemd/user/git-maintenance@.service | 16 ++++++++++++++++
>  systemd/user/git-maintenance@.timer   |  9 +++++++++
>  3 files changed, 29 insertions(+)
>  create mode 100644 systemd/user/git-maintenance@.service
>  create mode 100644 systemd/user/git-maintenance@.timer
>=20
> diff --git a/Makefile b/Makefile
> index 4e255c81f2..276b4373c6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -619,6 +619,7 @@ htmldir =3D $(prefix)/share/doc/git-doc
>  ETC_GITCONFIG =3D $(sysconfdir)/gitconfig
>  ETC_GITATTRIBUTES =3D $(sysconfdir)/gitattributes
>  lib =3D lib
> +libdir =3D $(prefix)/lib
>  # DESTDIR =3D
>  pathsep =3D :
> =20
> @@ -1328,6 +1329,8 @@ BUILTIN_OBJS +=3D builtin/verify-tag.o
>  BUILTIN_OBJS +=3D builtin/worktree.o
>  BUILTIN_OBJS +=3D builtin/write-tree.o
> =20
> +SYSTEMD_USER_UNITS :=3D $(wildcard systemd/user/*)
> +
>  # THIRD_PARTY_SOURCES is a list of patterns compatible with the
>  # $(filter) and $(filter-out) family of functions. They specify source
>  # files which are taken from some third-party source where we want to be
> @@ -3469,6 +3472,7 @@ install: all
>  	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$=
(bindir_SQ)'
>  	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) -Dm 644 -t '$(DESTDIR_SQ)$(libdir)/systemd/user' $(SYSTEMD_U=
SER_UNITS)

I wonder whether we want to unconditionally install those units. Many of
the platforms that we support don't even have systemd available, so
certainly it wouldn't make any sense to install it on those platforms.

Assuming that this is something we want in the first place I thus think
that we should at least make this conditional and add some platform
specific quirk to "config.mak.uname".

>  ifdef MSVC
>  	# We DO NOT install the individual foo.o.pdb files because they
> diff --git a/systemd/user/git-maintenance@.service b/systemd/user/git-mai=
ntenance@.service
> new file mode 100644
> index 0000000000..87ac0c86e6
> --- /dev/null
> +++ b/systemd/user/git-maintenance@.service
> @@ -0,0 +1,16 @@
> +[Unit]
> +Description=3DOptimize Git repositories data
> +
> +[Service]
> +Type=3Doneshot
> +ExecStart=3Dgit for-each-repo --config=3Dmaintenance.repo \
> +          maintenance run --schedule=3D%i
> +LockPersonality=3Dyes
> +MemoryDenyWriteExecute=3Dyes
> +NoNewPrivileges=3Dyes
> +RestrictAddressFamilies=3DAF_UNIX AF_INET AF_INET6 AF_VSOCK
> +RestrictNamespaces=3Dyes
> +RestrictRealtime=3Dyes
> +RestrictSUIDSGID=3Dyes
> +SystemCallArchitectures=3Dnative
> +SystemCallFilter=3D@system-service

Curious, but how did you arrive at these particular restrictions for the
unit? Might be something to explain in the commit message, as well.

Patrick

> diff --git a/systemd/user/git-maintenance@.timer b/systemd/user/git-maint=
enance@.timer
> new file mode 100644
> index 0000000000..40fbc77a62
> --- /dev/null
> +++ b/systemd/user/git-maintenance@.timer
> @@ -0,0 +1,9 @@
> +[Unit]
> +Description=3DOptimize Git repositories data
> +
> +[Timer]
> +OnCalendar=3D%i
> +Persistent=3Dtrue
> +
> +[Install]
> +WantedBy=3Dtimers.target
> --=20
> 2.44.0
>=20
>=20

--JNH5XexEgcR/DsfD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8KgkACgkQVbJhu7ck
PpRjzg/8DdbC1sXgTj7NcXJUJQ1klxN+HLpjTV14IM6uqEE4AtISA5SJE7CzRO4F
ujw+f96rv5PRZHfwO8CfEWnJwNOHvXhK5uzDPNFkQVe380mFq2puwNiAUTSl4uD1
zgNvcDS8uJKCZfQikRHWu/swxtleHoq1hDjh3aiQHWOtfE9b/8rEl8bck6mXua8l
oi5NmhBE2X0OOhSAe1ktPRj6ZF7Ym04NHRuyz7Werv9OJRYqsjoqE1v7QVxqPs3w
3EfCnRdpTM8P3as+Ut+iCGpO8h2zaZvirAXFjoV7u12pcy1kTymxBOUxb+y/y4ZW
Mxuogx6qCIutEhPG9yE6xQEKF4Y9WBPxK0fIc0oqMDgslbQ6hUgbuvbPWIO5b71a
Q96I1JRUQG1wELbTujVePjvm2BDkodYQYp1O8kzaG4JQEy3Lnm8CxLDbCwuKYWl6
5YINilMz0ILdU8Tzm5JHkC4A6c6WV4KjnEmVBZ6sYjRTrFKD9ZYrQUJqPrikFe6N
ByxtRZfQewMF6PvAsEFqf7jqGfha4SVROsv619yPrGC+Hj/4Ut9sOOv6wVgAisDM
9Cni6oee2jA+z0YcS8Wp3HIAW0qI1nFFkg/jPLKu2QHl85gDAPv1UJrXH9DMahs5
8tkXayn7Cg3//Txwib/GPavf/cbY5gOhK6+sjfemVSNwZKB2j+0=
=j70w
-----END PGP SIGNATURE-----

--JNH5XexEgcR/DsfD--
