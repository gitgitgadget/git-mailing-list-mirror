Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2A7EEE0
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205238; cv=none; b=az1OAZWpf3XWHYLFozTVwmVwZZgaoKD4iu2P1D122k7tKKGkQkt9s0hr4qFd8SNjVnwWFVpWSWPqLVmYMMGNOjBi8cqJX7I8lPRRYBjvUsca05fsoldmkkcSr51m8/AmB9uRIzna12bCNXvscEZN0iTKVPcfH2pYqljhDWQ8TvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205238; c=relaxed/simple;
	bh=LfVltxN48LJ2Jmo+SFSWIbWGRtDJawZweVukQUzwpyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoTAHbNCDB0EivB1lDf847ndNV3QCGkX3TIePqHKcNy034ai+RAAMfNWq3dX4sxd6PHvis55yozBfuigoyYzvh0MHtY3gMQdXCKirYEjJqi/MFgCNngoJgQFim0CiQf9ehWHO0YYQO8P2Z0jbo5Wb7cmk+0yjL/l92G5Wt7X/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=crH1INQD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jHLZytAS; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="crH1INQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jHLZytAS"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 060B51800081;
	Tue,  6 Feb 2024 02:40:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 02:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707205234; x=1707291634; bh=+jCDiigl7h
	EdQ3cnyFSQR4hwEKMcCR4EIJGiGkaJAq8=; b=crH1INQDVIcAi5fkW6OIpi+rI6
	IvVFCqDgckbKi1W/jQXUe2IquK6T2mws9fPGWEVonzY+xLfYuRchC+/SyYQBMZfg
	Qjl1hwbpw0D7ifrbpANrIXq0EnXrwNO7wxnXqs+Tadlnudq9Nyzu3KqO4wn2HaCU
	E/pLrK9qPkMH63VaaYdO4iliubdLm29dT1GGt5Jy0Ojh0/r6I27sZQAO4zaVH0K8
	6IdmuMoarMI6D2WpFi0TtiN9x+WQJoqou3zqEZwAo31AhtFO7Ps9MD58mpIW/qJx
	hEOz3jV3itI5iqyuT68EvHGvwPbGnk+x1cwVo3LjeRS44I1R060/0Vf2Yc6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707205234; x=1707291634; bh=+jCDiigl7hEdQ3cnyFSQR4hwEKMc
	CR4EIJGiGkaJAq8=; b=jHLZytASHoIwPiOfrdNixFGNVqlCaPGJDiBnniT7VwvU
	PMpm4VIgywsJJ/RISF/ajg+889v5Grn5KavM6nQr4DVeNAUkksBGutSRIlehY5g3
	OSdLsmL2NN3/2I2fC5eVAfA8hSxweutA9vlg4cRRjbGpSTJf2QAvhxi68d9ZohnK
	OL6CHrbXd3rschDvvA4OhJ0ZCI30NGTKx998x04wA2OaEx3gtEBAWorC2LnvLkpz
	8/sP0Jn6yddnG6tb2O6euM+6JT9pULvRmk8GYDilvhiolxmvcDbe0A61IxJxnCiM
	ywQl3TwiMKGHWJ8RBoXdPy3ToGniADLtWqvRadIkQw==
X-ME-Sender: <xms:cuLBZc7Lk7E-9juosV-K2vFCREQy_Xzc8f74ZuE5mOh2DUEm06tOhQ>
    <xme:cuLBZd725jK-U2o6n2BncOdGfLYUhsR-73B-n3rAWXvuJyGOexLrKYLpsZ3wrcLct
    q6zmXykLo6MNt2U_g>
X-ME-Received: <xmr:cuLBZbfoKj4QkFyZfKUg_OfZhmfnX0FZv9zAyYWplHk9wjg36aTlvzWUENo1SsSkDW5ana4yynmpJJoqvSyPd59OsB0dMsbX_2PIjPPXMt7wyoQ5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:cuLBZRLs8ISdmTRkJ7fkvQr-far3Dlh266rRMD7mZT0EPh7YOj1FWA>
    <xmx:cuLBZQJ0iIe5qE07r3dUK_5cOOtcT8uzDv1nPJSrWVNav5CmxyeRvg>
    <xmx:cuLBZSzNEXyKgCjQU8M0-v-En0VMoYZYriNVp2cxLhK07ptfP4miDg>
    <xmx:cuLBZU0svu3TD5fulYqaR1xcj-o-zoD17TCJTjdxuam1TnL0QjwCS38tTJw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 02:40:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3e924b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 07:37:02 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:40:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/7] completion: improvements for git-bisect
Message-ID: <ZcHibljA82KSMqz4@tanuki>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240206020930.312164-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FALXyVoEo23B+U7O"
Content-Disposition: inline
In-Reply-To: <20240206020930.312164-1-britton.kerin@gmail.com>


--FALXyVoEo23B+U7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:09:23PM -0900, Britton Leo Kerin wrote:
> Relative to v4 this make the following actual changes:
>=20
>   * fixes GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME to 'master' for all of
>     t9902-completion.sh as suggested by Junio.  This change affects all
>     of t9902-completion.sh so I've put it by itself in it's own commit.
>=20
>   * uses BISECT_TERMS to avoid pointless processes as suggested by Patric=
k.
>=20
> The commits are also refactored as follows:
>=20
>   * squashes the introduction of __git_complete_log_opts in with it's
>     first use a suggested by Patrick.
>=20
>   * spreads tests across commits as suggest by Patrick.
>=20
> Thanks for the reviews.

This version looks great to me, thanks! I have a last set of nits to
bring this over the finish line (at least from my perspective). Each one
of them on its own wouldn't be worth addressing, but combined I think it
does make sense to send out a new version to address them.

Patrick

--FALXyVoEo23B+U7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB4m0ACgkQVbJhu7ck
PpQpbA//T8rilcF/VRjv0+lmFH6+no9z9/2vtADzOItwRCm5T3Lx/uSctCraS4nR
GKtrJ04ulUy1678qNK1yxwkUB5D1dEhHyH+b1NuHyztk4vwA1vi/K+AWjsQR/t2p
KHPB+2h3SoEhJ98RUf72UNcaopAcQEQ4+rlYc1bhSZ5rLBmwjwJrpraqSdZUTYZt
61VKdlNsLGtCK2RXmni6It7moJOf2g0qeXphdOzpweJfoHabN1BHxnj+gXrfDViF
xeznMqeVLqQHeGqHD44QfzvnbaFP+CZJjIqvo1sUS2f+g9MBre/ZGDLJ1nIRHzQ5
EqrDgQusB6HYHpJxcnLifdl0jfApTihtM/lKlnj3bCCuucVqVIXy0uCtTv03O0hL
03MY0JWYhvlQPde97AZrnw5T4p3CIPFGaclW5dHPsxupTmPaRCilUdNA9r+FHzD/
qZy1bP2SowMm/uHMedy/p1/HtYj7XPj47srricPvgl483OedskZ+oMHspTxdv/Gj
Stg6IvrWpel4NbRr8YCU/Igo8XkApXaoZ5XqUHHBRmkDNSiWqPWA6KBjoh2kZFFH
t820siFn+q8DPtjMg50BLxUHM2USlhlAMchuJA+EXMMsmOcsbsmuBmbran1jVM4w
NFGIitlVpmxS2hFCnhGEmz7Mk3BLiAHKLdyMxHNHQs7Y+9bLRYk=
=/Ojm
-----END PGP SIGNATURE-----

--FALXyVoEo23B+U7O--
