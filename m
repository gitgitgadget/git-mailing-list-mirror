Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD8179B7
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167358; cv=none; b=ANy9itctuN+JtXjWcgUynqzZe5/HFYEq9AYuYMM8fEMqYgs8B20ar5INt4jt7bjZVk1mPOhDD8Z7L5lljCHW5X8E7AVq7bZtmB2ifqHr3jZNr1r3O5xeXkqnlz+LhjvlF0RmnD20Hos+LO99JRfckxA4Av6wADhq3P3Yhi5fJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167358; c=relaxed/simple;
	bh=MxrN3RTQzGXWpSJ9/qWGSzGAZBGSwDdBl/fjbuo/QrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE4pCs1Mu6/lhwIQEQSUUZr25Akcjn8uNFfSGcVWFPWV3iJjsyKJHU+xkUHyOkraL8lD1Bv23cADxj2iGN/FWg0Io/avHAR597hepnxPqj445gJ4xEit2aTgnLeDb+dM3ZDp8Sg2nNnBonNri2xmKZzQ+xFI9l/9BapsbtbXnQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=noMX2H6C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjJo6FMt; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="noMX2H6C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjJo6FMt"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id C786A1C000B1;
	Wed, 12 Jun 2024 00:42:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 00:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718167354; x=1718253754; bh=MxrN3RTQzG
	XWpSJ9/qWGSzGAZBGSwDdBl/fjbuo/QrY=; b=noMX2H6CgDT7MiGBwIepP5V9oM
	TnTWxSFwVj/LF3bVal5FsU26tyrs/+TQ+Crxf8SSXCJxpj7PcUCk8SMUR9w4Rsq/
	pbuhcmP3x9wQn1NqUj7H1RkgFjf2UdrwY/KwcAitKfbikv47DZ8FVARCUbTRgkjy
	P6tcllyLMmmpx1O+xmR+vAHjvQ9uRvsZ2StD8v0BjAKBtqvUZ9V73+BtYzkRlw7l
	mztteTpVCaIyuXISkq7o04t5S0eceU2q+UxrvhR0DhAMXVi2AkBwVQlKVXs0Fdlv
	MPzrQ0JC1uM+nwUJi3YgNmm6FCz3YLHc7ow7+/Tt31S7IZfdV0RvNsXtF+1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718167354; x=1718253754; bh=MxrN3RTQzGXWpSJ9/qWGSzGAZBGS
	wDdBl/fjbuo/QrY=; b=BjJo6FMtgx6f3WpHctCG5toZ71XhI8msW1yxWwcOEKTR
	dUJElkMvi89kDObtfZtYyXSkP1XTVc6s/BEZbrXZddfdnrENNr5iFpSXiSzndDxZ
	Uj0voF8BIInt2YaCs/oX4NNqYnbwXPO5g60Hmfjl2IjDxcM5rMwE0IJbaCYuyA1L
	/ZtdTbzhRd/qiorvpiUqILag8BzwwswBidhb9Bmw5pQLt26ZUdiOfVcgOPW74Z6f
	A1zBjw66eLt2w9+TV+Fmj39VGq0rZ3+nopFDIT+8h8ckjTjQdB1F0YMzr3UriM2U
	WlpnXkXnAWMjg1/pPqJm/tgqax+pYcizSqftXgUaRQ==
X-ME-Sender: <xms:OidpZvg_wPdL3VwZxYLwMswiv1GTBHApi5lv-czihaeckk0uqX7A-g>
    <xme:OidpZsAo6oblG93mW6eewtWnev_CwVnREDlvK-Egq-kQ7dsQdOV24lfmM8pLMeSje
    P7ApHKIdGFhUDJa3w>
X-ME-Received: <xmr:OidpZvExsNrC9J7sPQOIfJQaL9yZSJCD--ZyD9efaXroBb3hjxDCYoFHLhwPLY4ECRUQ7Z465c50LBS4PKzs6Tc438ICFeHBEPg3bHL0U82a5RTwJd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelge
    elveehffeukeelfefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:OidpZsQ187axwGqP5aYVFakDcyPAarRX8TaVdV_BQYJUmp5fSyVKmw>
    <xmx:OidpZszAzyybxOnLrpZnWdRM7OWs4drr6ubNUCtpWkRplOhChy-Ehw>
    <xmx:OidpZi77ouDiyGQiLgQz5VykNY-a60vaB_GsgQiCSc7fq-Fj0lkFXA>
    <xmx:OidpZhzYFfj3h96dfAPgPJYJWjv5QD_Y6l6Bb4bLz_yM5lJLmm4Ikw>
    <xmx:OidpZo9YUvSXbxbLumBn0C7VrNb3Qp8ktvIkeRHpEzaLijnX8izaY6kt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 00:42:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 375aceed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 04:42:20 +0000 (UTC)
Date: Wed, 12 Jun 2024 06:42:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] DONTAPPLY: -Og fallout workaround
Message-ID: <ZmknNDRnYGCeqAoQ@tanuki>
References: <cover.1717655210.git.ps@pks.im>
 <cover.1718001244.git.ps@pks.im>
 <03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
 <xmqqed946auc.fsf@gitster.g>
 <xmqqjziw3arr.fsf@gitster.g>
 <xmqqsexk1s43.fsf@gitster.g>
 <Zmg-jl83UA0P2Dnk@tanuki>
 <xmqqtthzwfnz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sf8brRFP/BeOhZLp"
Content-Disposition: inline
In-Reply-To: <xmqqtthzwfnz.fsf@gitster.g>


--Sf8brRFP/BeOhZLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:30:24AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > But now that I see the full picture of this with different compiler
> > options I have to agree that this is not really worth it. Especially not
> > given that Coverity is able to detect such cases, even though that only
> > happens retroactively after a topic has landed.
> >
> > Let's drop this experiment.
>=20
> OK, but let's keep the CFLAGS_APPEND one ;-)

Sure, let's do that. I assume you'll just cherry-pick that single
commit?

Patrick

--Sf8brRFP/BeOhZLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpJy8ACgkQVbJhu7ck
PpRaNQ//YVazi9oUOSwl+tP8UhEA8polmxAHWPtKYMTo8AbkCOeTpIcI7yWyUnB+
EcuJUTpoTlbgVSrZUxy/DQ52Yg1D9yWKQhLxtnSA86oGkXV/rezjeiy25FdJKjWu
8ypRDjAWxepSi6sB3WOWwy2WudaIECYD5UOpIndczVKJBg4MKNEkZntBHSU27eHM
AH6wIjcWRXMfrUyr1gznP5UTzgpVG4MHYVD/COgFX35SbfZM4jwrHU9HIqHrxTV8
EBuBlyGW1kLthuTAylUPmSMpKvhWa2S42/Sba3ZPyx7XBH72c5gN5GnPavtAJJ8L
nLTM85/5xYcosEJRb94xOkH+Ryb8pxTYSaTVc+HKrP5Iezf3Pn8kgiqXN2vflocK
CgKmGVXjDFvAxYhnQTrLXdKMWwYNH/kGaVtNHW3/KtODEm0dh8FLklLpPvuqqspL
8SpaI2N12WvfFftSSECZVLActLEUjJSVzmCBQnakyYUs4M7MWrodIKVTqazk+kBA
07kZvU7faDX+9dXTu5Lzv5kh48WjrIts4kpLNMQnzGDxgK7L8yAFxXIuKoZOGJBP
aDVBf71c6oMzB1x+E8UOVvIrFAVrtOjENIr1aTNf7W6LYX7HFDuY77CHEVdpJQ1M
kfgo+4g95u3OxHpoLQNZ3OmZM6H979hovdA8UjB0r4KZ04eFbEM=
=KssJ
-----END PGP SIGNATURE-----

--Sf8brRFP/BeOhZLp--
