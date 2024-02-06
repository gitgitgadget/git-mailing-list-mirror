Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE683A0E
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205243; cv=none; b=kHs9DaDixkjWKwjiJn+PsQWpYsGtLdknht5/IlXQczAtncEuKHxsYZ6X3pXR2T0iHXd9nCikyoDYAWZD7UM8yfPmu8sLdttZUz71Ay0Hk5MWaq01LIsXd1hZCJt7/lOkxS9YVGyi6wrUpUt4MbuEJFMG5GEDfIJBOSOESeMslf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205243; c=relaxed/simple;
	bh=bIgKsf2kGdZOlxAM4Be74DMYdJHYjNUC6GXH37HS510=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdIrLFinXDm2RrQnuU0T9Dr4YgkwmhTM5HW7XgLkVvdTxqy3jGPdAbdhmz7UysJPlHMMmwEV2N866x7gAZlLZx5h0xwiAVu2ENpDy3xyE3Q4JBsV8R809Aq3Vi+/5qofidUVRoDCgSi9zfSp9mmc0alkZtHbHS6xBlK8xK2OwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OJw4567m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vmFqlbpE; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OJw4567m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vmFqlbpE"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id F0EE51C00079;
	Tue,  6 Feb 2024 02:40:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Feb 2024 02:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707205240; x=1707291640; bh=+uP8gVRSzt
	0YgQxpngLETOjP/ojRrU1s62RB/VmFsxg=; b=OJw4567mp/i2eufRXRSev+aWiE
	if2B64hPhXf6lTBNaRLrvm8hb6x0Gsf0tPFN/C7Vi9ell7n1qVhSPybPm+9ncmpU
	mUsQ9KFj0DHIu0CUUU3Uh1rZb3upWz9pcxcbpmGqdxm8cEo/ooQYNbU0DNEYHnU+
	pX4F/7OiskJCw/SGuM72s8SMga0k1bYLw8U6AV7sdcBYSB4QZmpZcZsfU1Ltr6HL
	KwFnAP0U3KoHr9hEfMiwwpl6L33YIx75DnvHt4y+v2hLmwBLQuLe7kE9jPvwvyHP
	MjIqb2PRK+4jJRd+K1m31NTJb/Ap0HwVlwkvJtic6jZtzCKp5y0d61IbUSzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707205240; x=1707291640; bh=+uP8gVRSzt0YgQxpngLETOjP/ojR
	rU1s62RB/VmFsxg=; b=vmFqlbpEg+jfWy3DsJ226J+ac3I7m1AO4dlZ9DTWuhSV
	jofNohpAhWAHV+3ypbT2MSAt8Um/y5ShjmauDyRhYpJtbJ+gz+sNHXVUEvU2sQWK
	6veqvTQ4WM3zxAunxElWPDaKCRrKHKo/eKCHQK9rqo459Y2Egzo4m/VTR3XuXfe4
	yctfOsLJdwzzakWjs0HRdVE9SVRnhXls+AazliyyRncdc75OZJZTpMXIGjy/rr61
	FTy+FI0pBxlLIGFXJckEDN3lA/fpRQFUF4EToHeardK5KozyrWxtmKWNLPVX8zle
	WLMdrwUdKrViFbfJ/h1ZcZjPzPefgbw6PJbE9AHfjw==
X-ME-Sender: <xms:eOLBZSkm_gTReg4WNPXnGpWmTbwP0mjPvEWOu5c7gMGqvAksPSz4uw>
    <xme:eOLBZZ0xQXp42z2sRQx2g9imrb3bIV72iuFoT_lz7yyHTG8If92gd5AsmRLSg7Tt0
    9FTI3bmJJi000yrjw>
X-ME-Received: <xmr:eOLBZQqGcXpSCOXXmAdsUCnKMW-43Sl2osmdBCRjyPOTcTluG4WnM7a3H-gL5UpUzGH78ghyu0RhPS3gbsuhKDDmEl1FGmRykBwsTkH-D8zorSXF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:eOLBZWl63qLwixEBHFxocbF4eitBXVRp3rV0WNsNPyKJsavNJdKpcQ>
    <xmx:eOLBZQ05xF2bBBbvdNN__rW119wx0i-ijujts5XOlYL4zRu2MyHiGA>
    <xmx:eOLBZduUsJZMcO06PK8wUYyfiV-wf-pKR3lbTd_-DmNEIuHV1dqpvg>
    <xmx:eOLBZdyahoe5u9D0Wfo7lIStlcatC3Ggx4BAt506sW7nxgooKBrrs7kxbMs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 02:40:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f02bf5ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 07:37:10 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:40:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/7] completion: bisect: complete custom terms and
 related options
Message-ID: <ZcHidsY0X5-7rw2V@tanuki>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206020930.312164-4-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8JuxwKtWRa2UU6yf"
Content-Disposition: inline
In-Reply-To: <20240206020930.312164-4-britton.kerin@gmail.com>


--8JuxwKtWRa2UU6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:09:26PM -0900, Britton Leo Kerin wrote:
> git bisect supports the use of custom terms via the --term-(new|bad) and
> --term-(old|good) options, but the completion code doesn't know about
> these options or the new subcommands they define.
>=20
> Add support for these options and the custom subcommands by checking for
> BISECT_TERMS and adding them to the list of subcommands.  Add tests.
>=20
> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 32 ++++++++++++++++++++++++--
>  t/t9902-completion.sh                  | 15 ++++++++++++
>  2 files changed, 45 insertions(+), 2 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 06d0b156e7..6a3d9c7760 100644
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
> +	if [ -f "$__git_repo_path"/BISECT_TERMS ]; then
> +		term_bad=3D$(__git bisect terms --term-bad)
> +		term_good=3D$(__git bisect terms --term-good)
> +	fi
> +
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
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 7388c892cf..409a5a49d5 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1321,9 +1321,12 @@ test_expect_success 'git-bisect - when bisecting a=
ll subcommands are candidates'
>  		test_completion "git bisect " <<-\EOF
>  		start Z
>  		bad Z
> +		custom_new Z
> +		custom_old Z
>  		new Z
>  		good Z
>  		old Z
> +		terms Z
>  		skip Z
>  		reset Z
>  		visualize Z
> @@ -1334,6 +1337,18 @@ test_expect_success 'git-bisect - when bisecting a=
ll subcommands are candidates'
>  		EOF
>  	)
>  '

Nit: missing a newline between the tests...

> +test_expect_success 'git-bisect - options to terms subcommand are candid=
ates' '
> +	(
> +		cd git-bisect &&
> +		test_completion "git bisect terms --" <<-\EOF
> +		--term-bad Z
> +		--term-good Z
> +		--term-new Z
> +		--term-old Z
> +		EOF
> +	)
> +'
> +
> =20

=2E.. wheeras here we have a newline too many now.

Patrick

>  test_expect_success 'git checkout - completes refs and unique remote bra=
nches for DWIM' '
>  	test_completion "git checkout " <<-\EOF
> --=20
> 2.43.0
>=20

--8JuxwKtWRa2UU6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB4nUACgkQVbJhu7ck
PpQXVA/9GyUeSMx79nH4xDb0xJzoxoirHMY1rBmlBCeXJ435s/auY4NzCBK1zBTn
ZkbOsiNdG/Qi2duFVBkmcM8JZSjn3c2us6EHoa2bHElUVH6tL37ZLxMyaxiKkcd7
l0Xl+yXfzPn0QgFSKMF4zwhzTiKZG6N+YUpy8n8g2QOE4NeWZpLM996K3KAYIKIt
u7J9K69Lmr3tCpCZhA6n7gfGOyfFibSikotCampQqM4OCcEFEpI7PaIZzT9GV7xH
ZddsuKX96SE7NZUHgjCJiD73NL0mvgZwURLRzUmjOb9vPHc5L4nTRaxfRvKIBji7
2GPmBD2ZVZ4pK7Is03ykJrFoxqprTEq9YTrq2wEZkldyxUvmDKCprgulDOCCPdUH
y3CduwM6iLONeo6slLmuPC12/3TqnJyT0LHLOn8XDNfw2PFpYCcm99LJQeqWQV7h
OQphCfydavGXcfstwPnDTBTfApa/zgjoDIoF6RA9kwOj9HVccMWo5xRz38z7Y7E0
5HMtzwwEXp+qWDZPVAUBLFRc2uJBzJOgD5fFU3Ro1BhzwSuKYlv3P6utl3QDgWwZ
sDoLNXefBmx+66bQgfCMn3lmokWLO2IE7mXqySTGVl4YZLhE8IxgLtUNrnDtJ5V6
Bi86uYl+t36eahiPT8XXiWpk7Bz6h0Um56UPlbQ9c1/THDDfNS4=
=rvnv
-----END PGP SIGNATURE-----

--8JuxwKtWRa2UU6yf--
