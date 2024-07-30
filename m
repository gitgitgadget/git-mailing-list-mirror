Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C8195F1B
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328299; cv=none; b=AMciyE642UiFGNO7plop4/APK+5CvbgO1Hd3+2hF9B+D9QJfavTvgskgw3rFsoYKGBZCt9L8YKLkvjew6/D2bIV/UPqD4Esb2iOONJlxhqOT9WDxD1zY5AU5dyMZradryqS9xCBrVF/4S2ez6PixWwbTXsrFaJJ548QHChgQFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328299; c=relaxed/simple;
	bh=tS6nLJILt9cqOh/pZjf0S2yNbJ5cHAGR1InJ4K7yrAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q95R5kH/beboD1GnX0+G/osxKPjUX8QKsBbZO5pja59T4DEO40eIKff/fr0kDwy+r8ik47TxcgG4hE2eTr7iBn8B0Wyb6UhKQf6ZTIPPKldi8q44ia/ERqxO0CLUGA5cojxPEQpDzyFEqIEeqIrJWb+B0gPAIoleJvVIRfzBTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YfWYIAc+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r0J+uL3l; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YfWYIAc+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r0J+uL3l"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E756E114025C;
	Tue, 30 Jul 2024 04:31:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Jul 2024 04:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722328296; x=1722414696; bh=tS6nLJILt9
	cqOh/pZjf0S2yNbJ5cHAGR1InJ4K7yrAk=; b=YfWYIAc+RJ/LDElxXdJr++lHIG
	qEq6xYz4IBe20p7YEU9mXTLw22cbCI+2Q5ngEX4qjn1Aa8NBcv5V793CDXUX1ImJ
	tAoQMseg4aDgGPTjNW75Il3tUPdSpbJbGbn1ZKdezSoNXoayyxt/FypQFy+4ITuJ
	AXYdxVq8xJ0iDW6MnMIC93lbnc+3M5C9MaFfAtOwzgdSRYXVl+Auco/XLFfFs1Ow
	5I7uOHn7z3Wkqtv4/5axrsX+7zWldrcgAynKp459BKe6mkNf/8Oq7II63/Y1tewD
	YAByFNJ+m/1aNpGU/ZN/dQ0MyQ57YGY/z7mYmQRChU9HwLEBqGdySynjYhVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722328296; x=1722414696; bh=tS6nLJILt9cqOh/pZjf0S2yNbJ5c
	HAGR1InJ4K7yrAk=; b=r0J+uL3layv0RteaKop+1JVGe3wIHgX38dlFGeJ0OoMt
	skBoNJKQDewOEUJa5/YMAHvHqQs8SmFqd1NIsOtPuVhc/ha/B73+sJfAZfvnQuKH
	hKslvmv8WgmGC7hpJfva/xHFj87qPRvfAO5S5ArQyLusewI+AEn5hFNHUfM3Yq2l
	vE/wY2zBbMfCCm1IBadXkZ70SNLHeVPMjgv/AFjxPT8R6Cr69TOYuXKjc0LS96ee
	QJj2/jOzs3xxQW8eHF9zs4qITl3+xN8U29qOyIXbRJmVsyv3bfjrZv6kZl4D6J65
	pSWi8a7Bw3a//OEkKPrtJ9bDiPKBH3CbaXhcMotYmg==
X-ME-Sender: <xms:6KSoZqbwOXoaBK5vWrVsoQGxk69hBafCWUfQDbWow3xLP2ZYfVDIYg>
    <xme:6KSoZta23i0JU7bllZ7N8PBfPacZFqRagIFvHHk3p4QV6ABPAQuxnY6xrCXMDdfYN
    34z53WWPI8cffPq0A>
X-ME-Received: <xmr:6KSoZk91wLjNhJTVkZH7nQDD56c7VipEhRaDfORN6eR9g2Bm7Or4-2GKEIj3_cuPI82HYHgYF_Lx57lYuFvCADLBJgB8FeqSqHpQaExeZtwQn4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:6KSoZspYDn_WFjIHhrhYDzIetKyOIqDB8i8SbJknYySIFjyBB3Dlmw>
    <xmx:6KSoZloOXT_-TV-VGPTtshi48l_9Ig6AtrVefKRPHMaW9qXbJFaL-w>
    <xmx:6KSoZqSUYl3MrsfEaxh1UAgqu-cR0fCN6h6_eQYEojCYqX43MHTHAg>
    <xmx:6KSoZlozUgb-gMkYrUuupeYV-gLmT3PnSLZjXXoIvlUEXlA05ReOdg>
    <xmx:6KSoZmfLPHM6ky2LKTqn34dSXDLXwItME11KD0lGvxJINdSJNLhUlmsl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 04:31:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id facafd38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 08:30:07 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:31:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 05/10] refs: set up ref consistency check
 infrastructure
Message-ID: <Zqik5Lwya6bvxxl1@tanuki>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYptLyOxAfKwDi@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yehgTV9QWQDlKBK7"
Content-Disposition: inline
In-Reply-To: <ZqeYptLyOxAfKwDi@ArchLinux>


--yehgTV9QWQDlKBK7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 09:27:02PM +0800, shejialuo wrote:
> The interfaces defined in the `ref_storage_be` are carefully structured
> in semantic. It's organized as the five parts:
>=20
> 1. The name and the initialization interfaces.
> 2. The ref transaction interfaces.
> 3. The ref internal interfaces (pack, rename and copy).
> 4. The ref filesystem interfaces.
> 5. The reflog related interfaces.
>=20
> To keep consistent with the git-fsck(1), add a new interface named
> "fsck_refs_fn" to the end of "ref_storage_be". This semantic cannot be
> grouped into any above five categories. Explicitly add blank line to
> make it different from others.
>=20
> Last, implement placeholder functions for each ref backends.

You're carefully explaining what you are doing and where you are placing
the new callback functions. But you never explain why you add those
functions in the first place, which I would think is much more important
than explaining the placement of the new callbacks.

Other than that this patch looks good to me.

Patrick

--yehgTV9QWQDlKBK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaopOMACgkQVbJhu7ck
PpRVCxAAhj75RrYeW+Xbsw6TwlJWwp01LqkJRSHTpXaaBprkWxQVn4oa00mupaGG
ds4kCcVtEZ1uYxOba93j5XlSwp81JFx74hLpCPx9EWuXLuszmbDodZCWIroz5V6F
z/2oK3soo8F3KCVVHYFyX1bRowtCovJujr6dHB3V61jqMXhGTxlFop3PtdPqngZE
JUKFZ6TKUO7A1UKesRgi8iytJcmLOfIX9DjRoVkzmpiIn3XDKvQdRYXaCNYbztwC
y6CEqC+RQbTFcF45pLF9jXhJTwPtUEv3mv0Zi6eMNRFvq7YotEKO6fuI/25cWa7E
y9reu7BU3Etwqj4E2ppzfOkIGW9pwXSaLpjpm6abgAEJeYOLBKdG/rv4Z/wf9nVC
fKCTA63D2tuzfKkEJD/NC1LArVl5qqgyxY+RO7/Krvd4ia9tjrN+8ehvgNflv4eV
6QJhDGk0d0M9hJ4qRXUISSmM0Sez7vtSuHLk2PLEbbMXyWkdqS4oDsIBfLkeYNOR
GcUZhg93nmkN2Yrae+XqaC8H414DLD47TYA6DTlVQF8PHpilbgii4AWwru+eqIVC
CZGPI07ZDa9zf7/Nw6JMizbJoPr7bSG+42J/OsE5zt/fIYoimpxcfk2lGXFJcCgd
MgHnLoVbptxUSHkdmvrGsnEX42bd2RBql8Yahl1yZSffDthbdVE=
=qRkT
-----END PGP SIGNATURE-----

--yehgTV9QWQDlKBK7--
