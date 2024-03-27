Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8EC31A76
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528974; cv=none; b=jMw+jwFM7bqir22Pg1x2pbfG/AUinS9OqqN3ruBKoQrk3UVYhrh4BeyQW65eLXcLoJHJjbRa20JYF5LeXe5oYoJUDzCc5AfAISVnVrMlXmwnhKXxiJdA0ds6/1y9dKf36PVTJvfV6+O8cRmWs7D2tJf0G/P3BiUPR73gmZ9z5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528974; c=relaxed/simple;
	bh=GwQrG9xzYAu+j8IYNSQDXVYfRy0Ey1tEV165HxzpbOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ixa6xYIuJ6W/5reyXaNLpiQON+hgXsKgO2Q31mu3628EFtAWGYAO8lOa6AMEfB9ml0NLCQhh0O0q/UF5+xVQ+mT9/9urLgIOvNwrLm/fLgnIIExdDbkfKsFp7Y7Rdu6lRWnslCmWUj+7c1Dj9pVJDBEPOLzPi6d0PDRV7f76o7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TPgmfC+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fYqR5+jt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TPgmfC+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fYqR5+jt"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3E7C61140110;
	Wed, 27 Mar 2024 04:42:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 04:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711528971; x=1711615371; bh=SFdopjwDlB
	gZE7CYIsJyyaehZqddsmSaR6tqTKz5fQc=; b=TPgmfC+1nPkIcFGlxbCZTc5XGS
	rixnJf56BjcbfnwoH9E9JfkNNSUj7KNXYk6zj/SY3XXS+10YDiEgVsO4M9nO0pbz
	IipF583rnx3/6k/1R9B/KaPhjeBEG8f65MVWdmLndH7a9CzxSQddLG6lQzPvQEKe
	7XpnGa9nGbzl7SHpjSw488tbqzu2WvltfFzHdNHSwKZugrKwLotHdiDzzoaT0IlC
	1H7yXwtFiB+POHWMD/PS0tc9dN2Qi6B3stI4ZjOJU+CHidlqTPEQZCE4ZvX+smjG
	SrQgivNbghmwMhJtOu1kIt+A1JYXiiKneyduknG8s1bhlVYR2B5KpFg0d0cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711528971; x=1711615371; bh=SFdopjwDlBgZE7CYIsJyyaehZqdd
	smSaR6tqTKz5fQc=; b=fYqR5+jtLybq7wBPQTWSKezZIjCfWgI0xCvLQcYztzez
	ZSdanSktRi3jZMYCsjuzqTxif02EzQXzYjWtZOVFW1Ei7JL+owFp8gkGjZdj3isl
	Rbbx5aOzneN2LDWfWwDQABBa0tGj3PxLKz3VcEdKmy6VGRXqK1zT4WSxeaJFDUyt
	VwDyxZ3rp8lZ6cH11E4wkF7DTJfYqWzZqv+XL8yXGruM/rLQ0wdwHpgBiHwtDqqS
	jsI737EHgXovDdahLlzajiQPD4EtBVc8Mpu/DePcBd1GonO6vJYlTY9Xftw+cLGc
	HPTSlDb8qPqrq0J8GGdIM9gjx+MfD678de9bDV+k+A==
X-ME-Sender: <xms:C9wDZhzRCs_VgOHcK3hcIbOpTk4R6HGIjX1lpLWZ-K3Mahv98-OdBg>
    <xme:C9wDZhRNQDU_3JV2TpTA0v4cFCBJAZvxZ0NEvlff6JL8A4V05hEXUkVazThTVvi06
    6SEiYG51NFvWno25A>
X-ME-Received: <xmr:C9wDZrUhcc8gvtl6xFsTz_geV6kcXAut5XMq0MFH_4GYhn6zYTNG_AzpX7due60Mk1aLDE9z8hw-djpMvrCvMCXqCQl_882chxqKTvLaXam-RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:C9wDZjhkM0VRfJhZNA_PtFzfbphquvWdl1z1sDh_1HaEqQjTJYTzVw>
    <xmx:C9wDZjDAz9KqT7ec0HJcEhbfw6o2DYbsc50d3ODrx1dINzqZxt7XRA>
    <xmx:C9wDZsKQRrbfSI3-r_9aCRbvgtSGQkfaoB6cUd5mOrq9D8hvmkpGzQ>
    <xmx:C9wDZiCAjyOoJ_-eW7FzQo-Huf4plspYNNFivpYBGQdNPM0X7rkGQQ>
    <xmx:C9wDZlBEZ2XMTgkrTngwyCPrD9h3cagIp0g_4Or5TZstHZ38FgctsA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:42:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 221ebf4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:42:36 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:42:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/13] builtin/config: introduce "get" subcommand
Message-ID: <ZgPcCJdHQ8NWeWv6@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
 <8ceced0fc58e9b4cf1c5e5b678e864f82c1b8c01.1710198711.git.ps@pks.im>
 <CAPig+cRwh4HCi=Q01tGJ0WOb59iE18HWSCNxGogcreOz+2w1WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nG/0y9454CLnL16t"
Content-Disposition: inline
In-Reply-To: <CAPig+cRwh4HCi=Q01tGJ0WOb59iE18HWSCNxGogcreOz+2w1WA@mail.gmail.com>


--nG/0y9454CLnL16t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:11:07PM -0400, Eric Sunshine wrote:
> On Mon, Mar 11, 2024 at 7:20=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > Introduce a new "get" subcommand to git-config(1). Please refer to
> > preceding commits regarding the motivation behind this change.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > @@ -80,6 +76,12 @@ COMMANDS
> > +get::
> > +       Get value for one or more config options. Values can be filtere=
d by
> > +       regexes and URLs.Returns error code 1 if the key was not found =
and the
> > +       last value if multiple key values were found. If `--all` is set=
, then
> > +       all values will be shown.
>=20
> s/URLs.Returns/URLs. Returns/
>=20
> It's not a new problem with this description (since you're mostly just
> relocating existing text), but I find the discussion of what is
> returned quite confusing and difficult to interpret. Breaking it down
> into simpler sentences might help:
>=20
>     Emits the value of the specified key. If key is present
>     multiple times in the configuration, emits the last
>     value. If `--all` is specified, emits all values
>     associated with key. Returns error code 1 if key
>     is not present.
>=20
> But, doing so may be outside the scope of this patch series and can be
> tackled at a later date (or not at all).

I like this description, so let's just go with it.

> > @@ -93,22 +95,16 @@ OPTIONS
> > +--all::
> > +       With "get", Return all values for a multi-valued key.
>=20
> s/Return/return/
> s/"get"/`get`/
>=20
> > +---regexp::
> > +       With "get", interpret the name as a regular expression. Regular
> > +       expression matching is currently case-sensitive and done agains=
t a
> > +       canonicalized version of the key in which section and variable =
names
> > +       are lowercased, but subsection names are not.
>=20
> s/"get"/`get`/
>=20
> > @@ -286,7 +271,7 @@ Valid `<type>`'s include:
> >  --default <value>::
> > -  When using `--get`, and the requested variable is not found, behave =
as if
> > +  When using `get`, and the requested variable is not found, behave as=
 if
> >    <value> were the value assigned to the that variable.
>=20
> Not a fault of this patch (and need not be fixed by this series): "to
> the that" should be either "to the" or "to that".

This was fixed via 86f9ce7dd6 (docs: fix typo in git-config `--default`,
2024-03-16).

> > @@ -506,25 +509,25 @@ you have to provide a regex matching the value of=
 exactly one line.
> >  To query the value for a given key, do
> >
> >  ------------
> > -% git config --get core.filemode
> > +% git config get core.filemode
> >  ------------
> >
> >  or
> >
> >  ------------
> > -% git config core.filemode
> > +% git config get core.filemode
> >  ------------
>=20
> Meh. We only need to retain one of these examples now, not both, right?

Oh, of course.

Patrick

> > diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> > @@ -17,9 +17,15 @@ do
> >  case "$mode" in
> >  legacy)
> >         mode_prefix=3D"--"
> > +       mode_get=3D""
> > +       mode_get_all=3D"--get-all"
> > +       mode_get_regexp=3D"--get-regexp"
> >         ;;
> >  subcommands)
> >         mode_prefix=3D""
> > +       mode_get=3D"get"
> > +       mode_get_all=3D"get --all"
> > +       mode_get_regexp=3D"get --regexp --all --show-names"
> >         ;;
> >  *)
> >         echo "unknown mode $mode" >&2
>=20
> The variables added by this patch to the `case` arms invalidate the
> suggested simplification in my review of [6/13].

--nG/0y9454CLnL16t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3AcACgkQVbJhu7ck
PpT5zxAAkqnuOx/tHsxzyrR6PJBR8FPdhbUX3tndWDvp6gnKXbhHrGgJpzpgThBw
Om6St2bvZJ7gS4+7QpM9Ph++Hut1tCUQjxDqBjLdd7svlbBxRtGauYvB9dbuevZ9
rI/XJG3uY0S6ryk81MR111r2Tyu7GzMpHdnDev4xV3HULtWDBCVSkMtbJpSsY3oe
yXC1hIvoYINnNL0yvnPO6P4F85DkAeIQSnmiss39CIhHcJ+eMpUDMUDIRFFTzsa9
99v0lKe6BVwPc2Hfvfw9AvZZ+mm8Q67jLRx8YVaKNUqXcxbDuNTe1Slvbu7waPx3
OFEEZbQLsBG51j/F5g6lF07sn5XVN+stK+O7Jw8lrRPsoXQCBSWrv48bTAO1BEcb
OVXXv3Gn6ujRfB/uBvaoDzHvZpiuQy7rEB5fNfu6W/vub3NjUeDaoCUcNgnfT2NP
BuLQiVskqILqyeIS5u9E5ZYKT529UCUdnCkOS2rIrAF74UDksRSyFTVF9zEMrezi
lP0Cuw0HCRQbPZ8/WG2e8w+6ffIFADplMfVHBs9TuuuCZLqsbC9dXF3R7jF7zvRJ
mO79CUo4NTOb8iqS8HOI0hFDMqj8Sv6rcxv6ig60q+85Axi7DaBTMcYhJ6xaePS7
nRCx4MepXImNcWsiznEEO+09wl/PS4/m3xYj0AqgcnVVAEiZkdo=
=mzJQ
-----END PGP SIGNATURE-----

--nG/0y9454CLnL16t--
