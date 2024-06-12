Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979516DECF
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185246; cv=none; b=L7/LKo7cOFkuBFlbo57IEXwHSZi65UjHyviYXN0e44o0jHJXOrRZdMHJCKfRMemMq3TtaqWMeeWg2B9j3ebQwJKVXDnLdHxxl7uah1uWau+bJ/EpyXP/nVlompbpLliShLl7o3OLFTbLIM6KvwKfNGLDl41fQVXaYUa4XKbZZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185246; c=relaxed/simple;
	bh=tjeW00JLgvFq46V8sCcUtvb8Q+AacBocknxWnIuKyt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqsO3DM03vcJJatf7kXAMZPk62w/8zi5EUtGdS7O/tpYiWkGEM/4gzWcIgrirXUc2FKW0We/6C70v9IQS4eUPObng38fzvv1XaBCuvFTKzPTfA2bHtvNxk3yUoOBp4yOKTKcusUbNGtFdSXYn5J/hfImb4cuVgL5nsVsKPN6pI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oZ6Q8iUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQ7hL8Nt; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oZ6Q8iUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQ7hL8Nt"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9A4DC138014B;
	Wed, 12 Jun 2024 05:40:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Jun 2024 05:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718185243; x=1718271643; bh=B54qoy3WY5
	F+178+3FJIc7vkGlhBHJXmSnAac0nAqjA=; b=oZ6Q8iUfhAb3i3M0fOOhvdzhNq
	QTwBIIHNOA737fpK4iDtIT2Iz9oF1/VQqoYnc8Yxsa1Kj9GrN0H9mSmP9kDlrC4N
	TGDTNegMk8XEazhZzrRTrzCQvnapiiA7xSqcZKYuxusIlrOoaygunksR727vcMJ8
	WbbEKMaDJa4+jvvpuihLzvicn41X7So5By5MwMpmKve9h5+iWPHzDlCNQ/hyWJUP
	0kpCh5asDFtK7cqML15Jttb8+/Yb2za7Cvry7q2Mo4iN1XSJfHtJiGtXq3/i17iX
	I4xl87OgMb5bdiRl3jsuEn3uzwkHNgEoGAWbdA5lxw9++VHbNL/4f1/2SqOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718185243; x=1718271643; bh=B54qoy3WY5F+178+3FJIc7vkGlhB
	HJXmSnAac0nAqjA=; b=BQ7hL8NtP8uqJWNaWkIu/L5dI3h1NGsmQWPC/LA56NJm
	sv602YetGOcXS94ZBxedalExECNV9l1Hn2Sv7D4aYL5qmvOs+WHWwuA3xrrU80I7
	rtta5flgmIl7AfMtPjA8z33rcwUJz11xDabnyB//0FGkhovryCDXNTc+elc5mJBq
	MDY4/s6hDm+u3cuCmUpvfpPsPqWLysEJWA1zQGTe4kzBxOFKy+Y4qoDRNFpnz//J
	4uMgM0d5tsaCX32H3yVs6e5FHgiM5LLE3k52UwfmTOugximQEn9G/ESe17VXmoMo
	FtALKlenXP5SQLvTh6chSm6TkZr+TqHt97IPy9tj4g==
X-ME-Sender: <xms:G21pZnf1A1Q9GBOHRiAhlVLU15GZHcHmMETDLpiWFIv8xiuT3FknHA>
    <xme:G21pZtOJ4hehXAhkLZpDQUC2YVR6sG6s-hJc2J9hINmELTD6RbdwEBM7raRtmgeHP
    Pf3Xmu9K8dLe7VTyg>
X-ME-Received: <xmr:G21pZgiZLLMYlDzHpqwIyrVFW1wIwW3JX-itvFxRaDQfGsn6WT1JJ4nvMUqKCPV2gPxRRUNuD1BruE_JMOe4-wAy7QN32SocX9wS3vaxKwXmewDWrW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:G21pZo_EvaMZluWa0plVuB8EacJ0a8YkQehLeDXRiBSyV9CppGTIpw>
    <xmx:G21pZjvvfKh0Fw6VoXTULMas6ab_NOb1UyZDj7gqrNqvbrRCdKm4vw>
    <xmx:G21pZnF6azEQmLBAAmTphFBM170tLBp4jPQydMat-1cyPKpPDxpfZA>
    <xmx:G21pZqM5jusmWFpmOrLRs90AvWqvCD3XySInimgbrxCgoBodjzMvxg>
    <xmx:G21pZjJd5Ob_MsOd49S3ArNQAmO1ECOvokvUD2-OArkVhGRMillerIti>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 05:40:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id baac51ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 09:40:31 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:40:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 10/16] mktree: overwrite duplicate entries
Message-ID: <ZmltGAPQ2dAfW0kG@tanuki>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <b59a4ad8ab4b0e47373f811700eba59141fdc6c6.1718130288.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aA+gX80efAcRSEDu"
Content-Disposition: inline
In-Reply-To: <b59a4ad8ab4b0e47373f811700eba59141fdc6c6.1718130288.git.gitgitgadget@gmail.com>


--aA+gX80efAcRSEDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 06:24:42PM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> If multiple tree entries with the same name are provided as input to
> 'mktree', only write the last one to the tree. Entries are considered
> duplicates if they have identical names (*not* considering mode); if a bl=
ob
> and a tree with the same name are provided, only the last one will be
> written to the tree. A tree with duplicate entries is invalid (per 'git
> fsck'), so that condition should be avoided wherever possible.
>=20
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  Documentation/git-mktree.txt |  8 ++++---
>  builtin/mktree.c             | 45 ++++++++++++++++++++++++++++++++----
>  t/t1010-mktree.sh            | 36 +++++++++++++++++++++++++++--
>  3 files changed, 80 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
> index fb07e40cef0..afbc846d077 100644
> --- a/Documentation/git-mktree.txt
> +++ b/Documentation/git-mktree.txt
> @@ -43,9 +43,11 @@ OPTIONS
>  INPUT FORMAT
>  ------------
>  Tree entries may be specified in any of the formats compatible with the
> -`--index-info` option to linkgit:git-update-index[1]. The order of the t=
ree
> -entries is normalized by `mktree` so pre-sorting the input by path is not
> -required.
> +`--index-info` option to linkgit:git-update-index[1].
> +
> +The order of the tree entries is normalized by `mktree` so pre-sorting t=
he input
> +by path is not required. Multiple entries provided with the same path are
> +deduplicated, with only the last one specified added to the tree.

Hm. I'm not sure whether this is a good idea. With git-mktree(1) being
part of our plumbing layer, you can expect that it's mostly going to be
fed input from scripts. And any script that generates duplicate tree
entries is broken, but we now start to paper over such brokenness
without giving the user any indicator of this. As user of git-mktree(1)
in Gitaly I can certainly say that I'd rather want to see it die instead
of silently fixing my inputs so that I start to notice my own bugs.

So without seeing a strong motivating usecase for this feature I'd think
that git-mktree(1) should reject such inputs and return an error such
that the user can fix their tooling.

Patrick

--aA+gX80efAcRSEDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpbRcACgkQVbJhu7ck
PpR+Bw/9Hwe8ae9MIu5Ty4HTEcsdjDkIealI9/aSdmM6d1MipADbjTBjRRxKUwez
DGGfyLZfIDe+S5p0V+p0Gy0eeqdKn2nmefvRvYV0NKMVJbStlTPUicG6wCr4+6AZ
RDw/GGuElYp36kRMHl+6WwdYBjPcTHASbR4D3sSpIiK3o7mRXiDUtmC5wZb0ieLN
pPTP797mjSsJAryyjlvfl/xwDVeX1NSKrIQV+3y/whRBpI9oxAb33SG9FLj93hWR
czXqzJeNNI6CQD7OlQ44EVYNDQ1Yw0i00vPVNhc6Xn3EPSsjwkbtiS7GWIOVzrRq
HkKAjc0fUhggR+X+OCskSqTZI1oNpmo3MqNikuCtgSwUMZelvLpR6W94zvNDdpUX
O2u1NcW2rdqaIiZvklnQ9SMgi6nJHgt4ApMj4ylw8C4neI5tJDoVa4sx901+hlRg
Lo2coLBBmabNexJuhkb2jkEnpcr90ebhoQXJVPLNBQbBG0ezirtHbeytg75TE0eH
b+a9pRy1JqKuTBRteboa3ByXhiLrXTm9bCQLZK5NKjndDHBKWGMBvOnjSolx/t5H
0EAjWkHbyIvA7o7DUMbJB2pTv7eOsMi0tzpzDMjn4rHRlelv0dH/Nec3gG70FpHi
6EMpA3AYNeNxV/sQNqlO4sezKFw/5adVssTQ3CSApvJD3Pfw5+U=
=w09h
-----END PGP SIGNATURE-----

--aA+gX80efAcRSEDu--
