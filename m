Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F501F93E
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707291758; cv=none; b=Z1pQWesLO7Q2ZmJBTz36Pdi84DHj5EE/459txPVeofTUq+0/ZJn29KBOZrbgwrJHr6RMBIVfS8xBxFMwvj2hh1Ebd1rIDv59ThALibmIutiB59k4n1wacTmRboj3ae5g/aB0X4Yw/Uxf1TGKLr1X1eargfvtF0+25tNBkUDZcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707291758; c=relaxed/simple;
	bh=0PiGXbvsqlDTdEkGmh6Fosx3F+N+LPFINfwhSohxCB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3Qv47ZAJgSMHoa13uimex5RA7rhqp+p+fhluA8HHQdnoaMCTbDxW7YuaFdPSQnn8VKm/s1wdl+41LOIPbKgoGRyeQbEk6d5qUULwVWm8hv9RTDKF0amh6JLYT0mrOka6ycGAjMr7OIMuz8yLgn2z2/M8YpTFFz7XgLkRlI8LYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U36FYpSi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pTBdQaZ5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U36FYpSi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pTBdQaZ5"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 83E0513800A2;
	Wed,  7 Feb 2024 02:42:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 07 Feb 2024 02:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707291755; x=1707378155; bh=bhqyjDPaTN
	SS7cypOqKmFv3Yr98Ynd0xNsybpokqgzc=; b=U36FYpSiu+p+25vPqnh+EW9L3+
	zsC4I7OPby51SPmHPPdV1CTowv7/vZMrKx+TLMQPdT8LaYA15EPVrHMcQXHDxbnN
	OcZCWFBn7//GEi9I+xb+7Ls7IL1ttL4y3b7b3EoUa6FeSarJpwNDfKSTZfuGuFsq
	VdQXzPyr1jilfXYrU1AQvG96nvlZSZCA+TehxPL2KZDNX9OhJzPUmX/lt7NGC1gm
	ehBo5fUH4E5Cac/O4z0JnCPfpjTc8iM25fKj0obwoFwyPIB19zhW3JvV87aesrv6
	V9YCzkMDLJk275QS4gBeC0YjCZMGvY6LQfy9umzv1GTEIHhqof2IJxpJL3KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707291755; x=1707378155; bh=bhqyjDPaTNSS7cypOqKmFv3Yr98Y
	nd0xNsybpokqgzc=; b=pTBdQaZ51gv4hdkrAiOqg4cW3VL1+7w7yVw24LiJTmjn
	Wuz0g+J3llG53mryjDnP59jHNkZjLiRvQyAtXsCRxLKzwACjd9qFYtOLItK2AxwT
	YcO46/UPR82AOiSeBUUPrJQNXCDqdflyFORzWD4gRvFCdiZN0y7U0fTEP1kI9L7b
	yLJ6DzhYtfTThRgh23vLpcMHzYVN4y9fwoajQjAhS+524UtInqJwpSMHAucCvLde
	he6WP1zjJ/kxHDJCo2SN2PAp47YrQaZQBbfUtTMgiTF37zxAVCtRmfE/CounUJIb
	SES5mF8bTYnNhvRHQrt5WQegd3O5+NhBSF+KnFZC+g==
X-ME-Sender: <xms:azTDZcA_lzWAZpcB188zZ88T6GhyAYiBIgHpijazy_aWSZjYy5qKtw>
    <xme:azTDZejAokHEbp-kmIOrmOZRrlyBi4trC9vo8UTNOjuTdFMlxoeXnIYvAgk0FKT21
    UsCFT-Nu1a3T_GlnQ>
X-ME-Received: <xmr:azTDZfnq3CiMUI60u5j-RoIrRf7FxqGzpHR4gpBRfLThfva1hNyf6nwONChYDeLHTKQBBAszK6ak8gzC0Xhpu4oyzomlWzc12GIVwDpEnnQgrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:azTDZSwum7F1OxW09fvxZbZNI_JC16CaVw0fmpxaO5lpt83UDXbw0A>
    <xmx:azTDZRT1Yf-Gwhuf7KT3wDn7ZlFQ6dn1mxscmQJH0cxsuX3iTQO2FA>
    <xmx:azTDZdbtO4YMLHHABlKCcnAX5XrFSo2FCAZ9tlJZ5HbnFJosFPjdsA>
    <xmx:azTDZTf4B7ZAvWU6z5ty7CJkov7lK5eV3cEZFRqhMLo3sD_gydW-Rg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 02:42:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a302640d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Feb 2024 07:39:00 +0000 (UTC)
Date: Wed, 7 Feb 2024 08:42:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] merge-tree: fail with a non-zero exit code on
 missing tree objects
Message-ID: <ZcM0ZhXqCv17c5bN@tanuki>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
 <a3e8ae8611484f95df15490ea8f1abcec8f4cb36.1707212981.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ykgh+QMbNqU/Osxq"
Content-Disposition: inline
In-Reply-To: <a3e8ae8611484f95df15490ea8f1abcec8f4cb36.1707212981.git.gitgitgadget@gmail.com>


--ykgh+QMbNqU/Osxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 09:49:38AM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> When `git merge-tree` encounters a missing tree object, it should error
> out and not continue quietly as if nothing had happened.
>=20
> However, as of time of writing, `git merge-tree` _does_ continue, and
> then offers the empty tree as result.
>=20
> Let's fix this.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-ort.c                      |  7 ++++---
>  t/t4301-merge-tree-write-tree.sh | 10 ++++++++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/merge-ort.c b/merge-ort.c
> index 6491070d965..c37fc035f13 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1659,9 +1659,10 @@ static int collect_merge_info(struct merge_options=
 *opt,
>  	info.data =3D opt;
>  	info.show_all_errors =3D 1;
> =20
> -	parse_tree(merge_base);
> -	parse_tree(side1);
> -	parse_tree(side2);
> +	if (parse_tree(merge_base) < 0 ||
> +	    parse_tree(side1) < 0 ||
> +	    parse_tree(side2) < 0)
> +		return -1;

I was wondering whether we also want to print an error in this case. But
`parse_tree()` calls `parse_tree_gently(tree, 0)`, where the second
parameter instructs the function to print an error message when the tree
is missing.

>  	init_tree_desc(t + 0, merge_base->buffer, merge_base->size);
>  	init_tree_desc(t + 1, side1->buffer, side1->size);
>  	init_tree_desc(t + 2, side2->buffer, side2->size);
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-=
tree.sh
> index 7d0fa74da74..4ea1b74445d 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -950,5 +950,15 @@ test_expect_success '--merge-base with tree OIDs' '
>  	git merge-tree --merge-base=3Dside1^^{tree} side1^{tree} side3^{tree} >=
with-trees &&
>  	test_cmp with-commits with-trees
>  '

Nit: missing newline.

> +test_expect_success 'error out on missing tree objects' '
> +	git init --bare missing-tree.git &&
> +	(
> +		git rev-list side3 &&
> +		git rev-parse side3^:
> +	) | git pack-objects missing-tree.git/objects/pack/side3-tree-is-missin=
g &&
> +	side3=3D$(git rev-parse side3) &&
> +	test_must_fail git --git-dir=3Dmissing-tree.git merge-tree $side3^ $sid=
e3 >actual &&
> +	test_must_be_empty actual
> +'

Can't we avoid the subshell by using curly braces to pipe the outputs

Patrick

--ykgh+QMbNqU/Osxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXDNGUACgkQVbJhu7ck
PpQ8ZA/+Nqgiuk2rC5Dpp72lB+UerzwNfHbcQNLbr8Q97OXYrPZMpQsW49CkvrPC
yhCLdNNwHD6UQManznDo7dwNJgUgHuflY4COfM+nE7mP/tPUfAEYiF5HHjdKUSV/
Rt1OwCVJpCs271tBgva7CnVRRSCTEoroXsy5f8aqZQkfx5zv4aIzLadqpaGPwnMO
g525qK1UrQGVj+hzSrnxde47HZ6flaqZB/xY5slWJnxjYHNauytOJ05/6K61+RMr
hTljaGi5y0LepOzruYrBt6Fn5Nd6+8Won50UpSkTH3wwb9iJeQG15/ZK+yyN60RH
98stlGvL1VVNIOchUn6uu7ucQAFOIuf3zCgREOKCekfMHonU+IaOdUH/dqJKungy
IkmBag/GnYRr5fkKVjaB3Nm7u3lOWeP0rtHbTmY7RsWyD8xegjtzXgun9irGlpRB
Y1/jR6ngCJQL+N2HYiLQO/b4SFTVZ50Hwa0UGoSxN2WoeyQeBe7wx3GrcVXdf7DD
o9wAzZcNJNuBbcNxxBok3rLpm3MaHM9V59XrzoTqDbNyOjmP74I6uitv+rlauSXt
GPWJS4E4IIRVfThLwN1s7aN3d/g4yZp4lsSLyq1Q9Accu+INr9lObpEe20ypqvTb
3AHJXG1MwyAvyXhjuOSpnuvPgjvrvPnR8cbRkE8UuUc8CV84FsU=
=XmuO
-----END PGP SIGNATURE-----

--ykgh+QMbNqU/Osxq--
