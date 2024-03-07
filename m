Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E08380
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794980; cv=none; b=uN9ocruaDjgFLYP8zBgDxx7Z5tCvCAkUJ0vIp2UxQPtc9o7UYDYzIesoNhcMoKhfSqjzJ2C8+4eBGt3Tww9OcBw5tAJ+U6GeL/3THS1QmfjBa9oa0G7MNJeT0ka+/NXBP67vWvolWudI8nJ31W1/gVqd+lkHmXqT4oghVfDNSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794980; c=relaxed/simple;
	bh=z6ou3aFBmE7qz0YBr7HOPhWCF4t1l9jRMRawtcnwPM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avcfuxHqmq4D7oYA+yFnXT/FOPAkFYjh5+ln4hMs5ugsKKmdmpbla6V9YRadGSNYzaD678OuBx9bQKODt47wJlp/PZ9ZzZz7m5SUUB7BLpp2ZvJIPzf4pKmloVPXRbU0FIB15JGCKyWgq5PfKUiErM2jBcyFKCjAlMXvvNjvFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jDLODpxa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BlokXzI+; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jDLODpxa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BlokXzI+"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 6BC181C00090;
	Thu,  7 Mar 2024 02:02:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 02:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709794976; x=1709881376; bh=iYcccTXMQc
	tAkOf8xfAhxSE0tYMnrgzxV3P3TqANwyw=; b=jDLODpxam7De3GWDZGoWOt76qP
	ofl5JX4ggwLrmjPIVliihvOr6rzWDUn/cTdA+Uqv0EcCZ5li1QUi/LfDcXdXJB+o
	GVdsLVqXu8tRMDdXOIz+aGcyC92tY2Hfb9TZ8PXsxpnkTKjvufloqNRjTt+2jjde
	++I7ZoWKoDw/MnSUFfowOtofpFU0wB7qiUTUCHeRl7lgoQNj925qafHRGPpEy5rK
	QdHsRNwZcChlavKJ75DnwpuaF2rl1bck0mOUzMG1SFTEwMoCLT6fbRz7pOqvRwkH
	Z2a3HbcsFcIrG7Glx6OqxbF3ox20W/K1eIk03O+l7Q/wPTG8IuYY9xc84v2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709794976; x=1709881376; bh=iYcccTXMQctAkOf8xfAhxSE0tYMn
	rgzxV3P3TqANwyw=; b=BlokXzI+g29qSb3n8f2uUIqB9nUp0ruIph84UkKB6W/Z
	3gVEQjRm0bKGdN+CqC/6wVa1cbvVrWaQOCOEdEYAb7hVLRiBRkIpoKtHm0JT9Hu7
	q1nnE8d9xAnsXpb/Sl5Otwi8txaJia97kXPepXLCvWCzLGi51BTQqZgx0Uss645h
	qxwFVVlAIPqYiv4gR+7MUXf4GGOVNRajO/ip6y/qRztiQ/JGKgrd26ufByqrXgIV
	RMAxX5jpYvAEus118RZ7nuqIQiSk7pP7pT8o/GvaG5G+DWbO0wTUez1u1kdTuXI0
	/IkZKzjmsAAQAG8MW4wIrTxZkNFUX/so63UWvCPgIA==
X-ME-Sender: <xms:oGbpZbSK3OdgCbmG-7TyX68jJFqE9SZYbbuSaZyspvQOerZ9WhheWA>
    <xme:oGbpZcziahsSKM2XsJYlAzEwSqwkPXS91rUJ2LWnGaWXmHtgL7qeGlP2I3tt2diPS
    0L139ap8bqRDKl13g>
X-ME-Received: <xmr:oGbpZQ0xtqfDJ5qZn0L4zFwais7B9OBi0ERhTL0DlyHEWYKUR64ufGuVr-HVPsevRPwTCJIOkQmCOia5qD6OPB0ttWCpUb5KqJpm_GKP-hMVuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:oGbpZbD8g9srFi8YuTgF89cnCo4AeXyLPzTOBAofuivCbfPlLL8iNw>
    <xmx:oGbpZUh7vNouUq8lYf0m6uwG82dMLV42QfIlEXQckJ6xvndTS5eUtg>
    <xmx:oGbpZfrJSRB3Kz_l-m9LMt9nacKBQfPZJG1kJL--NwLQcjz_QlC4RA>
    <xmx:oGbpZXupEIly408dv6EExuaTS_DxI2mHBk6d5hhXaFQvrsqylfm9_3Aqhs0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 02:02:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a61a2e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 06:58:23 +0000 (UTC)
Date: Thu, 7 Mar 2024 08:02:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] builtin/config: use `OPT_CMDMODE()` to specify modes
Message-ID: <ZelmnLhGl4Vpb1Qf@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <41e5bf1d6aa35a32f961b7f9d82a70781674eed0.1709724089.git.ps@pks.im>
 <ZekBznq74P3QVsSC@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/hk6jp5O6pZQcNgt"
Content-Disposition: inline
In-Reply-To: <ZekBznq74P3QVsSC@nand.local>


--/hk6jp5O6pZQcNgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 06:52:46PM -0500, Taylor Blau wrote:
> On Wed, Mar 06, 2024 at 12:31:42PM +0100, Patrick Steinhardt wrote:
> > The git-config(1) command has various different modes which are
> > accessible via e.g. `--get-urlmatch` or `--unset-all`. These modes are
> > declared with `OPT_BIT()`, which causes two minor issues:
> >
> >   - The respective modes also have a negated form `--no-get-urlmatch`,
> >     which is unintended.
> >
> >   - We have to manually handle exclusiveness of the modes.
> >
> > Switch these options to instead use `OPT_CMDMODE()`, which is made
> > exactly for this usecase. Remove the now-unneeded check that only a
> > single mode is given, which is now handled by the parse-options
> > interface.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>=20
> > +	OPT_CMDMODE(0, "get", &actions, N_("get value: name [value-pattern]")=
, ACTION_GET),
> > +	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [value-pa=
ttern]"), ACTION_GET_ALL),
> > +	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: nam=
e-regex [value-pattern]"), ACTION_GET_REGEXP),
> > +	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for t=
he URL: section[.var] URL"), ACTION_GET_URLMATCH),
>=20
> Expanding a little on my reply to Junio later on in the thread, I
> suspect that these would translate into "get", "get --all", "get
> --regexp", and "get --urlmatch", respectively.

Yup.

> > +	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching vari=
ables: name value [value-pattern]"), ACTION_REPLACE_ALL),
> > +	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"),=
 ACTION_ADD),
> > +	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [value-=
pattern]"), ACTION_UNSET),
> > +	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [v=
alue-pattern]"), ACTION_UNSET_ALL),
>=20
> Same with this one turning into "unset --all".

Yup.

> > +	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-na=
me new-name"), ACTION_RENAME_SECTION),
> > +	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name=
"), ACTION_REMOVE_SECTION),
> > +	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
> > +	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
> > +	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: =
slot [default]"), ACTION_GET_COLOR),
> > +	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting:=
 slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
>=20
> These two could probably join the other "get-xyz" modes, and similarly
> become "get --color", and "get --colorbool", respectively. It looks like
> that's where they lived originally... perhaps I'm missing something as
> to why they were moved.

Yes, although I think putting it into the `--type` parameter might be
even better.

I'm still a bit torn on whether we should do this all as part of this
patch series or as part of a follow-up patch series. But if anybody
feels strongly one way or the other I'm happy to adapt accordingly.

Patrick

--/hk6jp5O6pZQcNgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpZpsACgkQVbJhu7ck
PpR3og//e0lP0x6im9g/kbi1nN2W4i6K0tR+85u52ZzcGGp8TqqCGZT+6RQR9CD0
6afkqlmCmeXhCletnzecvnUeQcthaAdzcck7dFEN85Bd2BaTGdhm8iuAHpVOALoY
FlHbjoPBq/LOllA71rSRBSSQ24SzUDc4WMeSPn5cuW3XbWibTXn0SPGS/uMEEkD0
W8Xz0cLwyaVnK26ZhDo2uS+OeUW1aiKAsG+Yb8BEssJdjRzs4ZWytSOuqTV4dOG5
gfGDy7kUlVP7VWVtwFnVmEPoRxcD2YI4ZtFL2F154PPMwNgR5c20FBDFehJo4Xmw
yHDBjrZF1pPAS41AoAnoSFgambVrQseSUAdIwXgPkcR4t/Y95ZlG35GNx6CTAAYT
5gp3OdBNzUzd+6QHFY4/5Uliwuk7QPS7g9tNV2JGmJ9UDrvFAAtQ5c03t6Em3oQT
cUiRYj+iQhjJoP4IZaB2gHDz5zxi0lK0xplwztAv0XkfiCGsLGO4dhLlJKdY6m8t
I6K5ECx9z3xgRYT7tIJJM+v5DfO6bzGtdE3ZKkdVUKPwTpIwf10a3MlNk4dqX0rC
IIpRhhC+FOnnVKYq4RE8NYF8SjgVyvunhN40kJTeUfqYDfKhWsisyNtoIlaLZTqC
HxW8di/Yanv62N/KMqI2DIcWY5EGLB25/YViGMH17o1SsD3rrUI=
=SlIf
-----END PGP SIGNATURE-----

--/hk6jp5O6pZQcNgt--
