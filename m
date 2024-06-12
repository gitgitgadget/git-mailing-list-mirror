Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4316DED1
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185262; cv=none; b=n8KRU/f6TkQygwHGPYbo9TD3BzTZa1FiFe9fGp22U99OZcVU96tLLUVf33vmn7Pzsh4YNb37S2CvNhPlrUqwevZAn/GdzzcZZqN2rJwhDRTlg0d1SgHYdn8rC6JrgyhuKuLy28toKyQhZ+jzFc/yApz+vu++Rblk2RjBx7BhLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185262; c=relaxed/simple;
	bh=X3SntwOS8GMy5pQjwRJ9mS/Ds59+gxlrLZpDTPlYYkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emQkZ2eOV7lBKW8cYAzBF+DAziIb2XkSgkl0JqH81GXSZYrZA70Oj402kmCrO1fFdlil98vrpYIQ6x9mXchS45IcrwHWUBpaz7H+xX+ZX/SV9wTMY9zelgjWLFb+t7cB4k1M2EuDOhSB+8tbsnHohe6a3m62BnTJDxHzpbWb4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ft4JrB3m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKdxJ4EM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ft4JrB3m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKdxJ4EM"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1F0BA13801AC;
	Wed, 12 Jun 2024 05:41:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 12 Jun 2024 05:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718185260; x=1718271660; bh=f31kKqEBTX
	z4AJa5vX97Stj9BLX2cq1bp1PiYfp+3I0=; b=ft4JrB3mDjaZWgJ77sm6ZuOmOF
	xPIYMnHaPhBlYHZNHnRbs0mLSo3VoBGIqhc6P3JPJo9k71VG1qTZN33oT0eLaowU
	DA46KlcIW2pT0LDp2pQJDyKCYK38Bviz7HCYi5KGOB5MxK3+WkBlhqPi8teRH8Af
	gJ3FTYEAYbdK8zdDvJu1xcwOA/O4xgIqASpcn+JBw1e+T844dfZJYN+Qw/9Qeq+v
	DchoQ35qzxL+iWbl0MuG5qtfIxoiDrezKEMPWg7v0hRrArjz8Bf9CYzwnSZwf+ME
	5oI/uVzv7Zvca9flE/lR8T0v/9qKWfJt93zXPg4Gv7SP6KcN7alJkGBDfNEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718185260; x=1718271660; bh=f31kKqEBTXz4AJa5vX97Stj9BLX2
	cq1bp1PiYfp+3I0=; b=UKdxJ4EMaKXXRnkoRvkFkulG8vGPDCAPL7kVlutSloxc
	ic6bpIPMaD6HWO6nmr+HfDXqkAH9zZmcDf/eFoNm8b3ft2otRDx7n/isuKvwcN+y
	eFiDXgsydYb9FUEmmIppkK54bbWQ4GgyWOrARinZshMXAZc6YFLHrFtL/DO9jjBq
	dJDNUo23mDAXqs+rhESqx0Jp4UdfPuX/I7Wbg6mFfWnVM3yh05yculiapCLXh8ud
	v+BgZOHDR7/cJvpu+OM+DPki3UOyzi7fnx2OTCs7ZQgIUYKLaRoTWmsORvdurtMa
	p+GiS2tUzTf0rEeIRfD8YNdlivvobcj0g+wQAt/Eqw==
X-ME-Sender: <xms:K21pZmmFRPKYgk6BTSQfc32Z-_rSpykhw5Kg7C9FjK3UNKRjHxYjpg>
    <xme:K21pZt0_ywlfyn7cDALra_8UP_9M-k98U6KxX_4HJm16DWLaGTAsfcxAd25i5THjw
    L2-FZHX8qGCwnznAg>
X-ME-Received: <xmr:K21pZkoXB0RNP1LmyeL5V0wABVU3C-Hlsast3VBYgywFkPhjMXX0FmslB31aJfM51lg2EaeZn_9nZq8DrCwWXfOpZa25BKLkBg78N8_a8gY8ogpfpas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:K21pZqnSDD-pAl4w2at3p2-0TeA9Trju8HKYbB3L3042jWuQmsyjNg>
    <xmx:K21pZk1MyVtE6SiiJN68BPYfKwTcIQy_VHBLEBxMkMGss_N6llpkEQ>
    <xmx:K21pZhtHJY24FHQj3wrn663AecUHXEe3Ts6voruVsYDizco-HWCU5g>
    <xmx:K21pZgUaQwAw5P0YiHBsN7RGtcVA1gECS0g9G3iYLMbU5LCSpLKFlg>
    <xmx:LG1pZhxVh0qfxipZvLQLkk2XlEjYK5n4GveogNw2KoJAgjrSk1UKuSOX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 05:40:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0fee68ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 09:40:47 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:40:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 14/16] mktree: optionally add to an existing tree
Message-ID: <ZmltKHI-Vz1L44r8@tanuki>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <df0c50dfea3cb77e0070246efdf7a3f070b2ad97.1718130288.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tolv3iW5MZdf4Dmu"
Content-Disposition: inline
In-Reply-To: <df0c50dfea3cb77e0070246efdf7a3f070b2ad97.1718130288.git.gitgitgadget@gmail.com>


--tolv3iW5MZdf4Dmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 06:24:46PM +0000, Victoria Dye via GitGitGadget wro=
te:
> diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
> index afbc846d077..99abd3c31a6 100644
> --- a/Documentation/git-mktree.txt
> +++ b/Documentation/git-mktree.txt
> @@ -40,6 +40,11 @@ OPTIONS
>  	optional.  Note - if the `-z` option is used, lines are terminated
>  	with NUL.
> =20
> +<tree-ish>::
> +	If provided, the tree entries provided in stdin are added to this tree
> +	rather than a new empty one, replacing existing entries with identical
> +	names. Not compatible with `--literally`.

I think it'd be a bit more intuitive is this was an option, like
`--base-tree=3D` or just `--base=3D`.

One question that comes up naturally in this context: when I have a base
tree, how do I remove entries from it?

Patrick

--tolv3iW5MZdf4Dmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpbScACgkQVbJhu7ck
PpT27A/+J3tweLBUKdKx6en51H2PA2t3dAYgL934KFKmy84EkVvczj2EWJ+CPuyC
1emuzu3TJp8ooWHQ7ez2mMwYVCZAVzx+udqd0ha5iZDlQNk/2qUB8/GYtRkgbMlY
OSJDwFxDrgh2ymtbnxOQG4iOigrF4D9BEFXImlmrwqetH6lcglIejneB+xsWWGTH
lyWtp0lMRhyhDzqo9mW1c+b2SgLreUHzDCqCSKmEWS80mikzcPWu61me4Khehv+h
+TBAAhbK9V1lorR5DY0j5BEhBVc/UavPgx4Msf+PKumpwSxgY+OIohtjEE7U5H2e
VfFos75r60B6tN94XKYFQ1bJx4ScWbeMSb5tEsmJnrrXsiNPNJhYOTB8nTeQTsF1
Y3HhZ8Z7wU8uE7uQKMW7/4Tzf1VlwyMwH24Gaz5lh6VEFRmXyMYGxS1/KeJJuzkC
y/0GNB01IbSITu7iic4i/VwYNbvs7BZXe9m7kQ4iZDnL77csjsSXmEo+j3VeMdQC
DDkIL2xYEJWEXvq8y2wHX9rhlf85+BOIr6MP8+S89X2dWddTaJ27hQpVXQrbYL+a
Mx6OnohS/s91U7rVzHY3TTgVngsq0N4pIggWMcVcEOCBU10Xqg5Dt8krY7znrnhU
FSraEkG2pqTHzWx40Se0knF5R8M0DhsFBJdYyYB+swO/qXREUdA=
=1i+y
-----END PGP SIGNATURE-----

--tolv3iW5MZdf4Dmu--
