Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19F4DA1F
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781316; cv=none; b=p10RA+xnonihKI0wtzH92a/rGRjP9m3svQCUiCvqRDNn51eTjdC2cEgsmxhdm0Zz7AKsdKXfl4Z+8ysLBaPpIVLzLFhkxeBsF00bq0Vpi8w68feiANI4eWbtS6cSQ12t0F0mNLtbGNttowIqeYOWdEDkm7DHLAFoqab3W9XhYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781316; c=relaxed/simple;
	bh=fFyq45MpvFtYBB1TLxnefiT3dG6CKA2ixtML5GK0DsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/10I9TKkcP3zRyJR45gMPK5M8K23sNG6UQWc2dXy0mdyVgKBQAS3tsoHmcn40nmSinfjRTNyE+l1/dfZ4ZuBb60ZKoh5m8J6eO4vzztIoAhyscKW1l5JuvHGhfvsE4ALsOlTLyqghdT3QinOUzXqwNA1fJyuQ0AUdOY9Hsbmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hwC7D9dk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oavUqYGU; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hwC7D9dk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oavUqYGU"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 117BE1800089;
	Thu,  1 Feb 2024 04:55:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Feb 2024 04:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706781312; x=1706867712; bh=tocdUc6OI4
	zh14m3y+F2nDKALdsllt2rqESdwo+geKk=; b=hwC7D9dk7zTYHbhu0KnNIhnVNj
	7lFPn+RqLjgrET9lRPZS2CSnJ8DWdDiLefOihXo9A7fO6WneUX7q21DjYtI12Zf/
	PTD6DiplVcEyIYgeDdGTXA8PbLZ80ioAv0EqdjVASA4D1t4ykLn2BenJQVV2wltJ
	nVlkiWUipXItGdkWco2z8rHSgUP6LY7y3IW2kXG/mSEu3QuwwmiAvA/Pekbk05Ro
	mibRmevQDWsKKyMpcrn4i5+ndlbfCXPakJ48wUtm+kFnpJP/TEmMaqnn/5bF4jUw
	vz9HYjCX785PdDceMNrc085egNKQLlEXISKpZGkO2jNBK2JY4a0vXIB2pgWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706781312; x=1706867712; bh=tocdUc6OI4zh14m3y+F2nDKALdsl
	lt2rqESdwo+geKk=; b=oavUqYGUEHiznau7R+nMhzx6wI2+1C86lHkMAxN9ynsZ
	ckcY+9WtJa18Iw4hxVFrZDdJ2GXVE1QLH3V7VdGM/Olu15I78UFIZrHmr6yIDLHd
	x58jP13ZQOJafG3AO9pWeNhf/fdXmsoBOgIjwHzdzx8hXAT32YqNCNRntC4cN2G/
	SVmEwbFyvECkSPWGgqbpe9piBVStitsWQH2qOCeMnHO7zhuugIwQmkp7U0vRx1/q
	3qlL8k4o5diswIYOavaqX1Lnys6Ppko0850uEjQuhkHvVmmduzv/QKdP2HwVf/sg
	1YHq5ybryfIw94XM7PRxYN1F0SEZYEDtmVNewkcrUA==
X-ME-Sender: <xms:gGq7ZeXcx7_ODaNwihrnihO2jqTssjmo5qspyAxcb0lT-45-zMcMfA>
    <xme:gGq7ZannoLn72bbWwjH9Fe0pLYTDdgzQ96Y5xiyeHOZrZ4_E3apJRaQF2PFspvECS
    P2IxY8GHLoCMZ9s7w>
X-ME-Received: <xmr:gGq7ZSbR0K5R3ZaB0Km5HkQT51S2FxJbGjYSUeavV6P3HwncfJquZZzoYfGVs2OSSr-1D09Oh6AYQt2pKpfzVpc-KGcyLG8XNKPGo1MUHutVww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:gGq7ZVWdvBKEpfbdXR7li4k8N4IVrnoI9R1nQXMRQL3_pgGrXtTgcw>
    <xmx:gGq7ZYkfSWzfz4-i3ISQzWy7LiT8_ZRX12zY0RmKCCDeJZa-PTw-uA>
    <xmx:gGq7Zacfqi5ias1wdEDVk9zZokHAocRUcLUsLXtbVMcuPQtbpx0uLQ>
    <xmx:gGq7ZSgzYt_9ctNY1cJM5CAjaQ72uNaHmcr3aRgD-ctx5yTHf0OwLqcHR74>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 04:55:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f4a0fa3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 09:51:48 +0000 (UTC)
Date: Thu, 1 Feb 2024 10:55:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/8] completion: bisect: complete bad, new, old, and
 help subcommands
Message-ID: <ZbtqfasgTQv9i8ih@tanuki>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240128223447.342493-2-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MFvVv9OY16lO+aVM"
Content-Disposition: inline
In-Reply-To: <20240128223447.342493-2-britton.kerin@gmail.com>


--MFvVv9OY16lO+aVM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 01:34:40PM -0900, Britton Leo Kerin wrote:
> The bad, new, old and help subcommands to git-bisect(1) are not
> completed.
>=20
> Add the bad, new, old, and help subcommands to the appropriate lists
> such that the commands and their possible ref arguments are completed.
>=20
> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 185b47d802..06d0b156e7 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1449,7 +1449,7 @@ _git_bisect ()
>  {
>  	__git_has_doubledash && return
> =20
> -	local subcommands=3D"start bad good skip reset visualize replay log run"
> +	local subcommands=3D"start bad new good old skip reset visualize replay=
 log run help"
>  	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
>  	if [ -z "$subcommand" ]; then
>  		__git_find_repo_path
> @@ -1462,7 +1462,7 @@ _git_bisect ()
>  	fi
> =20
>  	case "$subcommand" in
> -	bad|good|reset|skip|start)
> +	bad|new|good|old|reset|skip|start)
>  		__git_complete_refs
>  		;;
>  	*)

I didn't even know that `git bisect reset` takes a commit :)

Patrick

--MFvVv9OY16lO+aVM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7anwACgkQVbJhu7ck
PpTEpg//SscrZ+/9nwfV58PTso58ubCACwGPpzqGXNGn3k4f9s4F5wmYUUXFKA+5
OqSN4A7CYF3qE8JH5CCDdYaVfTPsPwZX2V+jbqr4oHTy2mWfkjzMPCkhrrZhNmQL
R5y4AprkOgy+jQRIL5vAzRABLae+ryZXfqoBZAxErK2YszTfadG88Q3cq0lN2HaH
mrgtt/wmyeqwxwK3693CTKQAxaLa7EID8nLEiadBI01q//8cO+3HrXwfD7TNAYPZ
vOUwYBzg+Zr86Pi2ucRu3efQwLu4Y6VEm8j6WTCX2XgVBoWwXCX0jTko5Pxl+01g
95kCE0x6pWg2CHrT3B+1zlXoK+493AoASA5FlbRXK94csK/SGj/bHmyQ/tm+4gcj
4Qic3vSA6ys5kmzn2qAhc8cfgNZxPy2EZW5c4LUNt+5vbh4RXkqgm9PUGA8cTaFA
r/7Gf36FLjf549TQMugZkVaV/TCCX1dWEC9vtDUPd9Gys6ZsMG+fOwLxG/xu+xwa
EB+CF6PC44ZPS4iYmgAq4wc49u2HhFmlzgSPJVffGr9sgM/a5ic1P8nS7le7spFj
+cjY7jBCKt3PiuEHeghjkaniPHpeLO1ypjASZE8IFbDqaQZZ2sOGL/mkrpJdedE/
RAbLteM1NgwHZ01fsEG81eH+BAPq1LP4hRGh0R2tVMADYaVAyE4=
=tLyg
-----END PGP SIGNATURE-----

--MFvVv9OY16lO+aVM--
