Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A917BA1
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589752; cv=none; b=oJ1/TDbSnR2f/q8MCFFmkqnoiSBKEKpHTrXXO9ARHRqLhFteYf3sLmi+fCRT1RI2T623WEBm149JiqFq+5z+Bt0KZrgW6AE/79Mpouko+6DQ6FD3o5zMNYCrBruzmSKQRS9FG96+MWzcXcHxCh2/koFnRUXd3d6Z3jOvytZ7cVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589752; c=relaxed/simple;
	bh=XJKEOV0245tSLBkr+QmT/bAPWUg6ghA6mCHqKTWg9J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td7xpdHcJgpxncL7bsUhqKZb0WYbaoEL/wp33qyMwQ5L3mnOcvGZQishY4RolEBVBPymo+FrAAhgwoiJ4zR1C+VU1p/PrJ3VKAMMFOKtfA6mMEKBHAetd8ZXim1bwO4jpmmkL49yU4gM6IW+y9qUu7cMM2NQwkJYGr9APdPOGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dfNGF7qC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qq69GV4i; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dfNGF7qC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qq69GV4i"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 74D2B11400AE;
	Thu, 22 Feb 2024 03:15:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 22 Feb 2024 03:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708589748; x=1708676148; bh=GGX70G6BeO
	h1oEjSEnLFe948R6dYC9hEiG/A3YvBGfc=; b=dfNGF7qC6Y4mEm5Kb2QZ1dg0qw
	Fxv+Ob2J96Uw6dU/ZRpCsVIR2iUd1tT/7Ofcg1n4WGhXlZYCzC2D2wmwAxlZKri9
	J0wGElwCzUzRSUPgIvlxYXy0JnN/4eKddbD6wWp46SNfqV3Qw2A1bcuLV5ADOXW9
	24y12hrOwRLtq6V33MbwF8blUmZ+sHL/NkTXB4684siD0JttoM9Eaj84IlV3+AxN
	NvjUyw4F0I5PqEDTw42EXb/3ZqqzAJLuAEAPuVzZl1Hc413nUmB0J9rLPJYthvum
	TTQUxBB1HP4l8UGhdXzPNSA4OvGsq3oxnYWoRLx9GTo9Kjm8FSdIiOFd8jEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708589748; x=1708676148; bh=GGX70G6BeOh1oEjSEnLFe948R6dY
	C9hEiG/A3YvBGfc=; b=qq69GV4ifuJg1A72NcbzKrmoyX1/92EQrdJQhcnWSYIZ
	NPemY23Mztm4maBguK72b8zRzsUz9fQqDi7ID2/hYY+KNg0hWmA1Y/gRowbBd5OV
	jjOUi3x6LVho6EFBldLc6Fo4vaRnDE7bb5VEkT1vXUH8lal08Hu6SXAX1oNnRWy1
	T8qljJrYwSIJ8HpswTIwdaYLeTQxTo+SPlwvYQyTkYF5IiEl0lmgAJUtmtDqDHAY
	evqaJINwY8Wu4X91tkyXBGagisovoRvsv+Pvbrw7nGv2Uw3B/Ygg6h+pqb4IpDn/
	xeHSYkJ9KPKWsd7avSUEduFm1gN5Ftbe1W6Vpz6x5w==
X-ME-Sender: <xms:tALXZWZ8vwwioZUvUcXuOf__vyVokw2kNYZSV46VpxC09StIHwoI3Q>
    <xme:tALXZZa3SeGRcCYjNsVWASUTv6kM0fizLzXtUA6mfMWRJFvWB_ENIGmzeyhDvlYYh
    KupBJQOanNlpVsxLw>
X-ME-Received: <xmr:tALXZQ9H_HDf-eK-bfe931YZKO_PPGFk2w9fyh2klkNqxVCRQL44hBeoelFS6rPXOXG3qHA_n4myKJiTkAbJV6WrSuOr4Nh2XwED8UO00_rAseIO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:tALXZYon-Yt1VKHlr2v_7fJoW6LodKeHCIp5Mk7ule_uICB9vNXBJQ>
    <xmx:tALXZRqWF86F6rJFyW5j0DIlaSSHbwZtpcxzS87o0zIWEbHj_Ut1Fg>
    <xmx:tALXZWThxF21Z3CunXaTR4dPXHsjZiEwa__A1OTpPb4RMLzarRe5fg>
    <xmx:tALXZYWPevNNx0Hc4zLtkc0VyxnswX6UV_o_EbuMf_efPHSUSY_JTw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 03:15:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bfb4485a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Feb 2024 08:11:39 +0000 (UTC)
Date: Thu, 22 Feb 2024 09:15:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harmen Stoppels via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH v2] rebase: make warning less passive aggressive
Message-ID: <ZdcCr2SAFJRgjhYD@tanuki>
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
 <pull.1669.v2.git.1708537097448.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1BU8nWs1e7yqnTgs"
Content-Disposition: inline
In-Reply-To: <pull.1669.v2.git.1708537097448.gitgitgadget@gmail.com>


--1BU8nWs1e7yqnTgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 05:38:17PM +0000, Harmen Stoppels via GitGitGadget =
wrote:
> From: Harmen Stoppels <me@harmenstoppels.nl>
>=20
> When you run `git rebase --continue` when no rebase is in progress, git
> outputs `fatal: No rebase in progress?` which is not a question but a
> statement. Make it appear as a statement, and use lowercase to align
> with error message style.
>=20
> Signed-off-by: Harmen Stoppels <me@harmenstoppels.nl>

Got nothing else to add, this looks good to me. Thanks!

Patrick

> ---
>     rebase: make warning less passive aggressive
>    =20
>     cc: Patrick Steinhardt ps@pks.im
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1669%2F=
haampie%2Ffix%2Fpassive-agressive-message-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1669/haamp=
ie/fix/passive-agressive-message-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1669
>=20
> Range-diff vs v1:
>=20
>  1:  4dfc578da84 < -:  ----------- rebase: make warning less passive aggr=
essive
>  -:  ----------- > 1:  a6f7a3a2477 rebase: make warning less passive aggr=
essive
>=20
>=20
>  builtin/rebase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5b086f651a6..6ead9465a42 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1254,7 +1254,7 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
>  		die(_("options '%s' and '%s' cannot be used together"), "--root", "--f=
ork-point");
> =20
>  	if (options.action !=3D ACTION_NONE && !in_progress)
> -		die(_("No rebase in progress?"));
> +		die(_("no rebase in progress"));
> =20
>  	if (options.action =3D=3D ACTION_EDIT_TODO && !is_merge(&options))
>  		die(_("The --edit-todo action can only be used during "
>=20
> base-commit: 96c8a0712e569dd2812bf4fb5e72113caf326500
> --=20
> gitgitgadget
>=20

--1BU8nWs1e7yqnTgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXXAq4ACgkQVbJhu7ck
PpReFg//fAivtJGaVbRs+QZGT8xeawZHs5ZNw+01r9bHcHJ/OFarafXWv9lhYHj9
b5mjOk5tZjgwJtHpUgBEVF53OHuFf3p61qBN0/YNEhxuDy0OxeGtOQNjBK+xyB57
JE09ohsZIfEEC80lelgFOdeZwp7Zpp6As1VB4mgUiYRjnFqdzhEBDl13NNZC91vp
01EZvg/8uAL04r7YSq4lGNmv9av96uhhjIzURSQnKHMW11bxn85A+myEdXMaQfgo
7OnsKxEKKdc4dfzNGHdcKJR6kYDq6DQoCtBG8Fm4fhbqkwjD6h0m3kSORHZlsWGv
EhttIEbvyvo1GLbyquTaExj/9jLwi1QBOWOWhJ3OdIF6KiOgW4ZXehAJdBkLHW9l
EeLp6e/ClA5nC/lb9oTpIyv/UTXS7LQZONyVKcOVtJGZhcBmmSu5xe6mLZ5Lk0aE
zMVYyEzWdzRlCvAXc6DZ/ta0XjuCWlCyCgcoESH9+6VLZ3fjmntjy3NMAJKWhofI
LMCu8vIgSDLnkHlMRB7P9Kr+bwa/t8ZmPvoe7mpQoV+DEcgQZysfSIZ9L5oMCq+N
0EclOVWWDyS8GTCd7x+oCDeW7yc/v1PPSPuoLCLK+youiqQIQNj4DsuTSHutXMH9
uq39rEeGi8sdhtnXNKpJzuZ3OrI9IYva/mjQ27Kpm3C1qReA9co=
=mSX7
-----END PGP SIGNATURE-----

--1BU8nWs1e7yqnTgs--
