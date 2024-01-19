Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A81D518
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647905; cv=none; b=ag09GyUZAOz3Pty989fZ4NGANiDsnD306cLYumTEmLCksF8jfRlJ/p/KmkH1RyxpgN6YnH8CmVuoNt9fM1k9enZdG2DNLZnIxENCR4qAVqgALSg6ljXoVntT/Ii0ruFVHyfY/Yr4P1jhSyo+RCZIzNoBnAViXWJD6yS1kIGpxqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647905; c=relaxed/simple;
	bh=KZySysox4Q9W75z7S7U0L1ZgBSF6A0jhZXwk7bdOOqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFs1Fafv6/0QqL8q0GF6onJ7Yx2S73lIYvJyuBChYT79sgyn/sw9xezgY3UZEGz5E3KzALUPHgXRP/HPWEqcpCAFN0p+h0hU2SJ3jBmYoAXPL/WDhsfsCpXZw02IgAzEm4h7DU97p6BlG4J+PfgCjVumTiyMrqLwqXYaH5ugZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JtXshRBs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yDO3L4Qp; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JtXshRBs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yDO3L4Qp"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id E64F43200A3E;
	Fri, 19 Jan 2024 02:05:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 19 Jan 2024 02:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705647902; x=1705734302; bh=llyDsF6NKW
	3d57/tmiXHMfS1oPJniELA2WGTzPB4jLs=; b=JtXshRBs44Zs6fi0zHfD1m9xkB
	f/XedHOXe0Xz1V12kcVpFPZY4ALkJYrNsTnBEe7wJ+0mZvRwPHGzPcG8QioaZk0z
	hwzj+fXITS0KcicmmP4WonsHyc5MI5JfB9nOYV2waaq2qdwOCd4NhS+9tBBDkZqQ
	WwQitSYK4PkWg/5bVqylkrubLWmlTLMKH9oqqMEpNppXGUjOBf0PVNJl7Zr8lSeX
	3vDwO7Fglu2W736hLDhp+M77AIh4KZFi2jtUQ2BQFF0T4KwUPY1CzGsMcn4g0po2
	HFvTgPA1ObQdip92YIFBpelkL8ulgvC93fl22UeuodWw92E0qpE+Kw0A9UKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705647902; x=1705734302; bh=llyDsF6NKW3d57/tmiXHMfS1oPJn
	iELA2WGTzPB4jLs=; b=yDO3L4Qpy5MGV8otoni4vs62WlwMhcD91IjlzE5CeErc
	muCde8vCH0l3PQG91jKvySAMTWg6wHFxzgB6PTvYklta1nO8otq4lMgl+ftTIM3T
	+MbZ1xk9LKUr968mKRcY+gYjY3676GCWhG2FgNRdc2lS7HPn4QbQX/WJpmmW9Aga
	tDh3O70KiyaF1GnNYSoPovWs9INXTbk93hEeTSxL0hTKV7CR0g0MDndo2yL+r1ad
	65rjVTIUEggzNwEEpHGKUFiKErUHK3COe3mTLmuqaukfOZ51cM1PGM2bJk7MEjMA
	Uzbvzm9RVaKlWVHERy2mKjSK8s5d3z6VjYvrbfBdXw==
X-ME-Sender: <xms:Hh-qZWlfYnmtxgrbnCvS_F5tUv7ckCiYXl-VewTtVi13vPPHHaf4-Q>
    <xme:Hh-qZd0RXVuQ6H_9RSqhEQXOUXNQf5_0DIcgTYDHG29Wnls1wNzPdyjt3VTcrVh-G
    6E6zUQxICztXsoj1A>
X-ME-Received: <xmr:Hh-qZUqByZn_NNHsiTi5PJu55IYzq9JxV0CoDJZshOofqf-b-P2nSZvQ3eo9BTpR3Oo2I-lMprWXuujLegDE02h7AID7OZTBvWWf8ZTHOw_h_fIPGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejledguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Hh-qZan0DyZA_sVnHHqxAnGartHEyGfuOmrYXVBH0X2wO6f9mAqSRg>
    <xmx:Hh-qZU3GquAe4nVXvGtUiPKalVPDss7B5La8suWINdvLDYKc2LJryQ>
    <xmx:Hh-qZRs5wiyCExCn9sVsS3qXFrbk0IFosuoqP5HFRI0NpMYE2Ffleg>
    <xmx:Hh-qZR-Mxz_e1ueMtJE11ll7ZnAaOfYZls63JYKZhG7DW9vSyYhvqQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 02:05:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c749f66c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 07:02:04 +0000 (UTC)
Date: Fri, 19 Jan 2024 08:04:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] completion: custom git-bisect terms
Message-ID: <ZaofG9EPCPx-G_Ph@tanuki>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240118204323.1113859-5-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+DsAQN8QVI0uM/VE"
Content-Disposition: inline
In-Reply-To: <20240118204323.1113859-5-britton.kerin@gmail.com>


--+DsAQN8QVI0uM/VE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:43:22AM -0900, Britton Leo Kerin wrote:

Missing an explanation.

> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 63ca8082a4..ad80df6630 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1583,10 +1583,19 @@ _git_bisect ()
>  {
>  	__git_has_doubledash && return
> =20
> -	local subcommands=3D"start bad new good old terms skip reset visualize =
replay log run help"
> +	__git_find_repo_path
> +
> +	local term_bad term_good
> +	if [ -f "$__git_repo_path"/BISECT_START ]; then
> +		term_bad=3D`__git bisect terms --term-bad`
> +		term_good=3D`__git bisect terms --term-good`
> +	fi

We do not use backticks in our codebase. Please use `$(cmd ...)`
instead.

Patrick

> +	local subcommands=3D"start bad new $term_bad good old $term_good terms =
skip reset visualize replay log run help"
> +
>  	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
> +
>  	if [ -z "$subcommand" ]; then
> -		__git_find_repo_path
>  		if [ -f "$__git_repo_path"/BISECT_START ]; then
>  			__gitcomp "$subcommands"
>  		else
> @@ -1619,7 +1628,7 @@ _git_bisect ()
>  	esac
> =20
>  	case "$subcommand" in
> -	bad|new|good|old|reset|skip|start)
> +	bad|new|"$term_bad"|good|old|"$term_good"|reset|skip|start)
>  		__git_complete_refs
>  		;;
>  	*)
> --=20
> 2.43.0
>=20

--+DsAQN8QVI0uM/VE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqHxsACgkQVbJhu7ck
PpSqsw/8CWgeGDiFczT0StuQ4DIQNn6+B8CBecwV29pUvIOzCn8U6IvsxlQkJNX2
QzK2ebzwLXUJV90nzo0OBbTqBi2OzN9BJqnnVu6PfzdQJzhgfUYTYeioE0HaASrr
pkEs9r/c9reGUeSyR2SG4B8AZrSwJjqZ8THNCvdAvq8MdvZPhGGaGY57h2AvaSX2
pKM7dyvuz7279xu2E3S1MIifILxxzRPKATy3YWohdsBVrVVhSviSIxFSQPhsy8X6
+hMYp0ExESO6lQR+fVSpIF8FoilHRXIMBL+3Lxc0Usa3Z/EANmWt4eoeBZ7OPlMM
t/GZLOpTcLCCg7Yg5asyay1Af9kKhsTdVWabyDQpXZ7sUCwH8MhDrTNmKaRzEHnR
BWrXBHIkbT4Ek0uk5cx2pp7akrXG8Xw86MpnyUh1s+hPAtGxCpnbBKznzO7ygj9N
ebmmP58eVL3elzCL0ujtid02nXXsLiaFwTemMMO50rg13RMtWXua62HwzPzvH8kK
uCdtCRLiucHwp5oFQ+qAQHLMHQDaEzHsNHd5CVc5MJq85xYdHTisA9fK5+95DK3Y
yp2cPcScjlqlTm4e16t5/rje/aAmH49iHeYbiytEWHab+JorKmS5BPe4DF1anuWW
BIvVM1gh0GanP6B5ee+czBlp4uZWbu9mmPU+XgPTTQMSQfjxWt0=
=6niP
-----END PGP SIGNATURE-----

--+DsAQN8QVI0uM/VE--
