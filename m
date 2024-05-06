Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D581DFCE
	for <git@vger.kernel.org>; Mon,  6 May 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996383; cv=none; b=ZurpxAuKYOzQRJrZSHrO7vjWBSZ9NQOIyq7WEezdgNwbx2GiJ7fp4GIJPXLT7gsJjaQMnfFdy+J60tZQ3dHzJR24YPmtYuQKh8aR940x4duIRiQmUaEtKUukS17/+7of7g590u08xtmA3BnmmZFlzynHFdWz74PRwBd7wBbuUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996383; c=relaxed/simple;
	bh=gPR0BVQmd9pyJlqwY/zenRtY55Rmk0Nr54/VQ6lZsos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY6tkF4Ksj3L2385UHcr9uqiOto/f209akbj4+ox1Ysh3jpuKuxvRwEAGmgNUdKE/WiUwHxMOtr9fUNYlWY/T7PsQhFiMoMjivRqbDM+xAWsuavwvIASXrqabbn+Dsyh3Di5sQn26UFm+juo13DysmwzW4T0dn6xVe3z38mLqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o2c4tNkC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bFrl7udY; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o2c4tNkC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bFrl7udY"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id D7B821800132;
	Mon,  6 May 2024 07:53:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 06 May 2024 07:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714996380; x=1715082780; bh=0ikg4olQwD
	K1BoNduKkhDq253FylDh1AMqjnPRYbc7w=; b=o2c4tNkCxz5YWZ+0pGXfRlnI7H
	/Vm1Jc5xT69tT88SWbTo2WKkV9MGQK7kFG2kjLnrJNRy6mJ+aXUu8yy7cFrvopGU
	lKK8mf6DLFJX4DNy1AOtOMqyrMK4x7r+X6tsE7o9BOn9Rw0N6M4Bqzf6Y8u1JIoY
	GQdvwOGGej1QzEj4H/oIgyYZeKmpWkdBLX0pf4FxGFaBaPCMRC7soOR/xJA4Gdiz
	VbEHDWEnqCrcgIQuQjjZiOzkwQ6lsHFSXG0Pyhe7TwZGRNZx+w9CsfjoZbOnvaOA
	2SPxIMNmn/UOwa6M53GAUpI4H2d+tHJlzGSEJGVjijaDJ/bSo1Nm3En/iXyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714996380; x=1715082780; bh=0ikg4olQwDK1BoNduKkhDq253Fyl
	Dh1AMqjnPRYbc7w=; b=bFrl7udYZhd0Jh33nnEKcwvxrX6+VAVo6wQZUWQRRIST
	d4iAuxG4updLT2ML+ed05UqmPBEC6zK4SNyTlq8CfQ6c+HQ/XAp6TZn9luQnQ4Ez
	jf9kWGcsfciznhY9gbvsVRFe/0kpBwYgo1me54A+li6fppsx5EMTAEvFZW0Nupy9
	fEO3GegeOReDiti3PRc74Zi04t2W/9pnyl9Bs58gjy5VZn37rXWUuI4wVjZRnruZ
	kYLGhENUrX5Dl+JIjmLZLvkJf2AYUU17pdpRD8on2MnkuP0o/nv9oJiSpgxLQxyw
	mGJVD8vqIGBYcq9EL+vlskKwLJFwby2xJS+AcMA9rg==
X-ME-Sender: <xms:nMQ4Zi4h_SQRRN1_mOhxOL6Tg2f9Q1K_4aMhgJXo09dPh-yyotGkkQ>
    <xme:nMQ4Zr6Q9O16j9N76gIX3EyA3X_0rtyzqMWuJR6pep7q1R5uObg3ofal8MLupiZHZ
    lcOrgl6ejdGsTt-XA>
X-ME-Received: <xmr:nMQ4ZhettDXcQWcDysupG1uWi0ws_FISDFkEzmhcZT7X5IRrIzICimQruhrobBx-ANv4V5AgPCpUK6825NMDDbH-Jv9kviR_5ybd88xZ5N0Hwd5u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nMQ4ZvLIh_kAK9l89hGoibxOlLLDvQjfce_CAZ8CJq7HVBYHLa4hcg>
    <xmx:nMQ4ZmK_tZRzLQxF9aIsJ9KjibV26NqBOqwlztw0lRTTYutSD5A1kQ>
    <xmx:nMQ4Zgwlk4Z6mw1CtaxgsdS7LvsWyuVNGCgyjVEVZtYec5M7uwhbbg>
    <xmx:nMQ4ZqIfnYELwzge468tkaO0TKHqyG9KsMbvmG8qaGYd7jEL2q6hdw>
    <xmx:nMQ4ZoiHyfRaWFznSfO9tJI7pxJf9mNnF_m38tq2t78IbgCW9gOdbTLT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 07:52:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 671a0d1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 11:52:53 +0000 (UTC)
Date: Mon, 6 May 2024 13:52:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/23] pack-bitmap-write: support storing pseudo-merge
 commits
Message-ID: <ZjjEmGHYnw20wVBg@tanuki>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <ee33a70324589a98c2239530b03cc2d7afbdfb9e.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ql+bDKwKrFqfFVyb"
Content-Disposition: inline
In-Reply-To: <ee33a70324589a98c2239530b03cc2d7afbdfb9e.1714422410.git.me@ttaylorr.com>


--ql+bDKwKrFqfFVyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:43:15PM -0400, Taylor Blau wrote:
[snip]
> @@ -46,6 +48,11 @@ struct bitmap_writer {
> =20
>  static struct bitmap_writer writer;
> =20
> +static inline int bitmap_writer_selected_nr(void)
> +{
> +	return writer.selected_nr - writer.pseudo_merges_nr;
> +}

This function may use a comment to explain what its meaning actually is.
Like, `bitmap_writer_selected_nr()` is obviously not the same as the
`selected_nr` of the `bitmap_writer`, which is quite confusing. So why
do we subtract values and why are there two different `selected_nr`s?

[snip]
> diff --git a/pack-bitmap.h b/pack-bitmap.h
> index dae2d68a338..ca9acd2f735 100644
> --- a/pack-bitmap.h
> +++ b/pack-bitmap.h
> @@ -21,6 +21,7 @@ struct bitmap_disk_header {
>  	unsigned char checksum[GIT_MAX_RAWSZ];
>  };
> =20
> +#define BITMAP_PSEUDO_MERGE (1u<<21)
>  #define NEEDS_BITMAP (1u<<22)

This flag is already used by "builtin/pack-objects.c", which may be fine.
But in any case, shouldn't we update "object.h" with both of these flags?

Patrick

--ql+bDKwKrFqfFVyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4xJcACgkQVbJhu7ck
PpQMpw//SEaHwLP22WFwV37ePlpOhx70xBeT81pIdzCMnNCs9N+/cTdUsVzn6U+f
11lo6llDic7GQ/scutUKSmDmTc1//gxs1m51vpDtIF3P4ATa+wkefnm9ToqkxvPm
HXhqt7gyOIlaSHWhTvnUH26so8og52X/ZiqC/BxX7MTvm9U+Sk5CC7kglzZYWOTE
dyvcNCEz6aTrMUrA3fln7vthUXIL4dC+8zA1eeYOwKZr1ZMk17ruRxXAuVoIhcpt
7ksvOnFny7wCehP4mj6AiUxOb9+K+5/uc0bDssF/NAjI5VVSMmhduAYimB6fCU4R
5LFSIoeG8sEwr8m4N4jXIeXnx+vC6G0uw8cVhexRrhg7uDuFT0oN5G3b/etXvdhy
b0RSRkrFXka2rp4NIyox2XIRA3ILAybEPYZYOrSHyy7UAAfbfQTnXpCrSBd383vQ
1ApYpzOazzRLmJ7po2rT3RJxP2MjKCmNR0haqI59y1D1atIMAzqcvZ9A4lnksFO9
rLv3fYrBc0fDNf0DKe/EG355G8KxmXuDn5bXkhm+E7KfbfOtgzjToKQcWaywKTSV
EDZIokl+9ICcOiZ4/ruR+uG48OlTPpq26B/fLOBz1v/Vl6m1qYeEyd7C9umWCHXI
sFPGGVg/gJOxTMOfiL0gILHnwPz1kdx5ctqNFYVm4gKySZp8X1c=
=9VtI
-----END PGP SIGNATURE-----

--ql+bDKwKrFqfFVyb--
