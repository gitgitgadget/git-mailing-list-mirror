Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53854FA9
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015218; cv=none; b=HHPUvORqsMLMmwgSeTzT6vSxaHfhWay6GXt7jNTDxP1x5ymCc9IWFx/+TzZ+5xbq6uERCArX6esmhlupGInmHgTbLsonBYAf5zpnwA8/Wx2xhC2bauOHOJOBk8BRwrZwAaiXpSJ/fYZDnVEDDy1X8grLWR6COwEyuSx4yQb4tiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015218; c=relaxed/simple;
	bh=LoKwyrGUODlbDKKnWwDnZKLIZfl24OMnmUoT1F5y9xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZnai90dBhENM7wSvsKZNKA6+QmDv4TIHdLirbUmrvNq0BW2sMFUDq3s3dMsSeXMUhrLNI9YAVjCaT7U39y8cBqCPpfGFpb7fI4cvY/IwXdWlyGuCzTATxZhqb4UeGXUleNtC4m7yslV6AfcJ+ESSssiUj0TIhTGPYSspkd+ERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gFRxTNTu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drbERh0P; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gFRxTNTu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drbERh0P"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 361E6138006A;
	Thu, 21 Mar 2024 06:00:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Mar 2024 06:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711015215; x=1711101615; bh=d4y5sK5ud1
	X3gUlJT2qRHXQV7Xap+ZVZIWOyhaSiPXk=; b=gFRxTNTuMIUjahU8mjFXgGrmYM
	eCDU+t6c/PKQgxv8qeiCFi080ejjDjN3Xs9Y921mGth/vkTNIMfKUGGpIYKRNj5x
	CdzKGOAIgUv7zz/EC+JQqBcDTzyZux57YwmkVqHnFIsiBdi0FKivtTfn57O+HeXX
	QWbT0SiazrkBWY5I+QaK5G8ELtRNkY37r8Mv5eBLQJt/QGuO5EI5L2FaVgb+Agpn
	X91Vi1Srvqyci8/cedDk2AMZqdN2K97CV17EQTJiOYaxkMG7c5ELXSU6ZHyl1u9D
	l6xXiseh8Uwa/IDazw+MwbNqG1ZK57Fsvaee53Bp+FAv7g8fnZ3Gv8KQinPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711015215; x=1711101615; bh=d4y5sK5ud1X3gUlJT2qRHXQV7Xap
	+ZVZIWOyhaSiPXk=; b=drbERh0P+cIrVkeQnlaX310tYQe13+nZLIBi6U44809v
	nxYmi5k9WdqS+9IZCfzvH4IZq53XUBwqBMldUiksH9K8JhydWHXeFFswYGuhOz5L
	/Hxu0sTIgq3RA43T+Jcpu0WlCzEmsM6kmTAGFuSs58h9DS7TyMEbp9/tLroeve8c
	Qc3NaMDJuFB5DFm4Fri14uHtiqn1n5ym35DcZOHfHPtqiXt1lbanLnQTSPjR9+h5
	QsxQuzqpbOa5FVDTwCH9BsF9h/7peZlCmcigeq3RI9iz/jUU7jvppiheroj+MQEZ
	q4uOUxZI1Fpa/2cJ4M/aXXt4l8W7sxQMdZyXUApOZw==
X-ME-Sender: <xms:LwX8ZQuifZi6Oh4u3TH1OAziPFosR3QUwbn01KNjdn0DeRUb5qxNbQ>
    <xme:LwX8Zdf8LQGnxEcahrRnoAsgmJ27vB5YIJKnRRX059VQQ6o_JMuJ24YDJH6t-Wyxo
    _aR4d1jRhkFx5TMlg>
X-ME-Received: <xmr:LwX8ZbwpUlHMWMFPqSLz9Sp_6AebQTyFHGN5NRCmGzhgWHkFs0LQx8c7QgdVObFjhQZI8_NVtDgG38cgru9Hn_pl3Y7ZD2NFJ3xlPjK9AU1BrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:LwX8ZTMZrjf2iWfia3Es9ghr7079NLCWX509rEln7ynrIjxnHrBGgQ>
    <xmx:LwX8ZQ9RDNEjl3DHXUNphf6703dT9cwC6OmgbPTQ7wGCx63xhwLzbg>
    <xmx:LwX8ZbWZzE_O1RoC2dvX_1qGw2nFi_bookbdmRUsbiXvBcxIuEWlxQ>
    <xmx:LwX8ZZehr-e8BLbQYUi0SLuIS647VHO2pVOezXi-5l3kA8LSvwvP0Q>
    <xmx:LwX8ZfagqOTwv4d4iaegRdwDmMKfLG1J0NUBynM502_FRpEHE5GrXA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 06:00:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 48d3db8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 10:00:09 +0000 (UTC)
Date: Thu, 21 Mar 2024 11:00:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: clarify file options in git-config `--edit`
Message-ID: <ZfwFKyE-eOJo0zl4@tanuki>
References: <20240316050149.1182867-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fjAlkxIQxONZOjp8"
Content-Disposition: inline
In-Reply-To: <20240316050149.1182867-1-brianmlyles@gmail.com>


--fjAlkxIQxONZOjp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 12:01:24AM -0500, Brian Lyles wrote:
> The description for the `-e`/`--edit` option references scopes
> inconsistently: system and global are referenced by their option name
> (`--system`/`--global`), but repository (`--local` is not. Additionally,
> neither `--worktree` nor `--file` are referenced at all, despite also
> being a valid options.
>=20
> Update the description to mention all four available scopes as well as
> `--file`, referencing each consistently by their option name.
>=20
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>

I know that this series has been merged to `next` already, but as it
didn't get any on-list review I just wanted to mention that this series
looks good to me.

Patrick

> ---
>  Documentation/git-config.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index dff39093b5..6876803253 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -275,7 +275,8 @@ Valid `<type>`'s include:
>  -e::
>  --edit::
>  	Opens an editor to modify the specified config file; either
> -	`--system`, `--global`, or repository (default).
> +	`--system`, `--global`, `--local` (default), `--worktree`, or
> +	`--file <config-file>`.
> =20
>  --[no-]includes::
>  	Respect `include.*` directives in config files when looking up
> --=20
> 2.43.0
>=20
>=20

--fjAlkxIQxONZOjp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8BSoACgkQVbJhu7ck
PpTlaA//RedSp5XGuuzAKeiL0tspz2axq9G+3R5MCBd4fibOITci4yviEBqr9Sfx
5cKKKLfVfkLLbj6GHgeZtRhnYwdXnvh3YH1X0Pa8JCfvEl7Y+QHdEA3+h2rJJP2r
a1ytuHohi9QpgxhvHBtC64kqHT27dLF+00rUMLSIpiAUqzrCu3EZZcW93vh3yp6x
kubsWP+QcIW60tjwe+hUUx4Twjfn0BiagwrhWu4H9Bqvt6fzd8Pv8rX+j4I4w/Gm
MVHinLn92d/iKqlbtzAKmSjRJcjOaEEzc8noNL19cOXoesRzdWaIU47x5UYvayVo
zy0BX88IToJcC0pGjmfqLLbxo+rmeNh+ZlhK6wVvOFcxTMdGV4Sv9SFRI45z/NEh
uRjxX6Dg9yzplChjBY9SoWXbo3qi+NKyYxpbXP3AfE8goGsEDKCj4InZ93aleOyT
e/fV5K8ce/BYiTfMnd27XuDRFGtJWvN+ju5hZN30k42LwRag7HuzG/Zp4RucVHMa
FlrfOufkIW9G8BNWUeOEiAprExqLPcfBPk01g4Ggwm38IzOaRRVqVw9jeCx/66Nd
aSZPihA7/w9jYMOl0znGsP7NWDCgup8sPQgCaB+BUNPUK1+Mky1hzD4LYPplctaD
HhlN3URTnPPfb+yH5ezI7BBlPPxGHv3xmE/fk8bke1IFFSAaO3A=
=rgFR
-----END PGP SIGNATURE-----

--fjAlkxIQxONZOjp8--
