Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440904DA0F
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781326; cv=none; b=ZAQbqJCs9ht+aa1BFmNrspFSXIb6yJQAtwm4NNC8Bax5qO6cw4FkpWcuwxzQriSAE5LWyHXroBqoaiLRnu3p4BexRyfhzTDRB0sVE7D0RyP3ypW5ryMKX4WxQq3eACZDoaiw/HL1edx+IHtKa+nTqQvEscn//27+3fpNEMeJxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781326; c=relaxed/simple;
	bh=93RlWxKqGVPI+NpH2ywJnwrL7CoqXoJVap/fJZSgEgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBpP1iEhCnnlQq320IUBZDVehao1meWBRL5n11WjW3VXultDdXcLryFAJTpNfZeJk8vZCOvHCwsfZ10lv2qILat9guXmO42q9A9HFkerDEhCixtdieggAX9e+VMtM3jc7ylvRd/xAxtYwfNBjzHvdq8kOZPx9R2Svp6Qu9P9LO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bqxQY4Wj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRTv2bsf; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bqxQY4Wj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRTv2bsf"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 2DB573200B83;
	Thu,  1 Feb 2024 04:55:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Feb 2024 04:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706781323; x=1706867723; bh=BojGkNo8ja
	umBUTV720AUAdRGPnI19pzNA1FS0dOOlw=; b=bqxQY4WjYZ6kSs+vU/QTtIh78d
	ueMdND6Lpr8ibNXLmGGIA9tVchaP1Gaw5D+Oc8VLr2oZxsi7E7Q5rYZC4obcIgiu
	M9L2hj3yqQCjfUm/qFygeRUJv4D8Czwgcf78tOfElifk+tzs0cR2aE9tKhw+uEB7
	WPYNGLfIiCcmeG6wXKFw9I3QpO4g5fiEm0KaU84Iz6TSSb0NDIiF/bGgRGLavzKb
	5UBqAjzdmCrSbE4PaijQ/+8rGLSk2Uqyynuh6m1uxL9+JH5jMy+dM8kfG8zuQsdB
	FS9RPlnLZCGop2H5ieH2Xh2uh4oqolT8XK6CRaWezLlk+S1LOKDo6eFHQp1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706781323; x=1706867723; bh=BojGkNo8jaumBUTV720AUAdRGPnI
	19pzNA1FS0dOOlw=; b=NRTv2bsfir6P9ammJUrq8D61yNVtiWuNffgPNwNh7Y49
	+LnUir6ma2hxqVf3URPCDUh9BTrfrnYssw3COYdFKfatetrdVbKO9mWkVrXRA8I3
	hB8RL9P/dsiMvgdHFxgTXLxoQu8M0yUmlQhM78QfR6PjyIvNaL/r3OMw7DOSJhQh
	FJnH4ne7zxtdJ7+dDTs8peFhRz1CrASCR0WbL5oc1covhJJtt1gsN3nQ7kgrOogx
	gBlOul1KIeJQoCaJdI48lxr2C5wFWQe4Z1dzVDrM5fPFDu4zvChNkMnTivj1Ymhj
	5Moo0dgodTC9mLTzhH723EmXNgEKhz1bfTiEILBKkw==
X-ME-Sender: <xms:i2q7ZSdzTpjCcqaJxnDt71TZgmzr0phdHb50Ty49vExOn0pmKoJJIA>
    <xme:i2q7ZcMtxpb7QtDSjZq4RZqU-YW0JTmTgjqPw7-H0vIJV6gFuW17-9Y4A_gTmhwN6
    KuulD3NhUsZEDtwlw>
X-ME-Received: <xmr:i2q7ZTgGo4Dl1NKcFXzwVGtGWk-YLho6Yf0kkPQgAYX-we6VJaXrnAzK_Jj1nnKHT2KOqBj6clkBy_nVkJ6PCxmbyZUEVZ0Hp5d2YVXlCUXZww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:i2q7Zf9hg82hbTqSnqqqhuzvsFZA3JdHXBJtvhFsc1GOlDvvJNwwpg>
    <xmx:i2q7ZeuXU0DxBdT_SoeLirYQt4cZuVeYf-wnRzkZpDrP3OLpqGCgrw>
    <xmx:i2q7ZWFtn9VwlU4Z7InYvInEAhPVOms-QgCP9vEpcT0K0IZGBs-eDw>
    <xmx:i2q7ZX6X49yeKgL5Rj6FmI1qHMkfK_tikGgmOEHHetI9UMgEa3jlGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 04:55:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 267a9ea7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 09:52:00 +0000 (UTC)
Date: Thu, 1 Feb 2024 10:55:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/8] completion: bisect: complete custom terms and
 related options
Message-ID: <ZbtqiJ5_6pTZJ3P-@tanuki>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240128223447.342493-3-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eNEA/5KFc5r6iI5H"
Content-Disposition: inline
In-Reply-To: <20240128223447.342493-3-britton.kerin@gmail.com>


--eNEA/5KFc5r6iI5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 01:34:41PM -0900, Britton Leo Kerin wrote:
> git bisect supports the use of custom terms via the --term-(new|bad) and
> --term-(old|good) options, but the completion code doesn't know about
> these options or the new subcommands they define.
>=20
> Add support for these options and the custom subcommands by checking for
> them if a bisection is in progress and adding them to the list of
> subcommands.
>=20
> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 32 ++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 06d0b156e7..8baf330824 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1449,7 +1449,20 @@ _git_bisect ()
>  {
>  	__git_has_doubledash && return
> =20
> -	local subcommands=3D"start bad new good old skip reset visualize replay=
 log run help"
> +	__git_find_repo_path
> +
> +	# If a bisection is in progress get the terms being used.
> +	local term_bad term_good
> +	if [ -f "$__git_repo_path"/BISECT_START ]; then
> +		term_bad=3D$(__git bisect terms --term-bad)
> +		term_good=3D$(__git bisect terms --term-good)
> +	fi

Nit: instead of checking for `BISECT_START` we should rather check for
`BISECT_TERMS`. Like that we don't waste two processes for users who
didn't specify any terms, which should be the majority.

We could also parse the terms directly from the file... but I'm not sure
that is really worth it and feels a lot more fragile to me. So I'm not
sure whether or not that is a good idea.

Patrick

> +	# We will complete any custom terms, but still always complete the
> +	# more usual bad/new/good/old because git bisect gives a good error
> +	# message if these are given when not in use, and that's better than
> +	# silent refusal to complete if the user is confused.
> +	local subcommands=3D"start bad new $term_bad good old $term_good terms =
skip reset visualize replay log run help"
>  	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
>  	if [ -z "$subcommand" ]; then
>  		__git_find_repo_path
> @@ -1462,7 +1475,22 @@ _git_bisect ()
>  	fi
> =20
>  	case "$subcommand" in
> -	bad|new|good|old|reset|skip|start)
> +	start)
> +		case "$cur" in
> +		--*)
> +			__gitcomp "--term-new --term-bad --term-old --term-good"
> +			return
> +			;;
> +		*)
> +			__git_complete_refs
> +			;;
> +		esac
> +		;;
> +	terms)
> +		__gitcomp "--term-good --term-old --term-bad --term-new"
> +		return
> +		;;
> +	bad|new|"$term_bad"|good|old|"$term_good"|reset|skip)
>  		__git_complete_refs
>  		;;
>  	*)
> --=20
> 2.43.0
>=20

--eNEA/5KFc5r6iI5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7aogACgkQVbJhu7ck
PpSxaA/9GA5qyisYoO21ZhR7WjRJXhrLSNTUN0ovo/Zo6/6cicBwgxbwenwEdcQI
u0ciDBdrrUzqk/SpEvMJH6YjdeQ6J2TZ4Cg2V/ISLXZ7IdRUYNyKqABQgcdFKsDs
nB9r8wmbIkSVyJWlxY0IKvqZQOZkavC1gtJj2nfzIqlINxPPL6c+Pbd4+ZR3LasU
Aorkbq50tY99DPgxaehHkphBTpjeup/WFK01vEAVK5PUCAlczAaTgFnkW1XmKk+t
Ytr2nqQqT4REPEYpjd2AUF8LPuFOaLfUzTV1cGlPxbDnMkfK7UuNJHbPTCG2Gic7
2V850Hbqo/lP8XBCb7EqEoxCzoRJ0ZfM/FiSuYKcPi832X3ceTVMWusUrJ2X4J/T
MHJFVP2u+iDPhpoY3Df2JF+nydW90aeOScjKvIGOnVGRYucoCTv8LrgnNNKv0/UG
nRus13G52v/ilAcdSp34grq6WryvgEl6Mk8LcF6HozUt89FWV+FpaWNq7C/4aUb3
rFKuY0dnf3Xhvfz3ztzdfkGIE9oDlXy6w04WVAWHflQyvTMniLODnldXH2rZFHTN
G7g6r/FgDLFMNqVcog0EvthLMxAHzHEjHRNy4ckQq4UXmWOqnr5pmrCj4FDi+0XQ
3IBn9jzhOX1S6UBRMmWPDEQQRhMxkCld+XphOUhzNYSgNNvtTOE=
=3M3+
-----END PGP SIGNATURE-----

--eNEA/5KFc5r6iI5H--
