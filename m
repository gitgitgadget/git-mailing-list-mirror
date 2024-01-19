Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F88537E0
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670963; cv=none; b=BNdYZUp7ozXb1hGgooOmNZAiZEJXK0oLBrwQpM9nZ21zFwg3hatQ9J0KucR4vLPz/EIbPUNoIyAIiK9FW3FRRC2eOCRf+EoSCdAwFyPtqek5SIAzJV9jMqn7CdKg4uKHnSIOKksjrA3e7JFIyOH+EkyKu2rAAQBXIIdTMB5tNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670963; c=relaxed/simple;
	bh=9rAH5EQDe/LhCcxTpvn7gfESU/fxk3HvZGtinke5Msg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8D650Ziojls3y2psqkzu4XfhNEQQEjaB8yStiA37jeEqLZjNX83dESYdoqr6VZ09RVcLL7LoKvjatjz4Odq29L4BbEB5s66AnOWVtl73SHrTtUTj6AFxhrHA96mamt952nN98yRl94FMdtJsnZH3EVEUCBtGUyadgWTmLOcYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fUTis1tj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jCCqVQA3; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fUTis1tj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jCCqVQA3"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id A2A2B3200AE1;
	Fri, 19 Jan 2024 08:29:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 Jan 2024 08:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705670959; x=1705757359; bh=EhDcpZJcVD
	cXE88uYN74HyfsdtTJ+HgAfEXAHFet2cU=; b=fUTis1tjButP7k5yJTmCKHD/6G
	SPj3wI65+YlBXElwj77aZSs5MeCFl8t84ziUIRs5lN4RMbzK/3XJUFzzq5s36gCC
	qIJBeKBrmYMXVWaJTYnceVBVfNk41DeM9rHBRJpWZj9mOzr+GycguQnAI5aUFqhw
	6pgzhidbo1kM3KOGmhneTitMEWNDTu6yPMyF92T2U2XckP/sx4sp2f7OreeopShL
	Dfikh2r3z9oDDWyK+XI38gLe/izTW2pROhmXcarzWzDoTMtoDLgIXBauCqY/lv7G
	5NoO5dD/ApTS3k5ZCL4gS0Pmlp9UyZK7SZka1I8SDD1b4dhF3y4yfqnxN+XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705670959; x=1705757359; bh=EhDcpZJcVDcXE88uYN74HyfsdtTJ
	+HgAfEXAHFet2cU=; b=jCCqVQA32CTb3OYf6zxFDQiwFYFg06H5oshLL0nKo3JO
	rIlOk+D9m6sM2BPjMOEW43Ykmaow4pvATBmk5DLjL6WLVHVZXZIn8bO4ax35vDOR
	0TAQ+yngmyvtxGpIk2Oh4KJwjbmUGcUBjxpOzTvxySokgoHhac9bnzciWj1cw4sj
	0PVwKcSyd1gl2BC+9UCF8Ss2yDcrgAyE281oHRbgjjijPw6MQwb0kZVFnrK2+Iz0
	y03HMdiLfmD65uLL2eCHXZ7BYd7EbEC7iMT0LZJU07nwMSOiylNCnre3i/9HXltK
	fGQaqWfxXw6GJVdP/SS33O31nxzQ4/twDiWGek4I1g==
X-ME-Sender: <xms:L3mqZcgWRXf25aoksy2X43npgd4pjsQmcyDW9XGX0vafjuxxclfcFA>
    <xme:L3mqZVB_OJNM6vPpWr8AaxpuWBQ51Zd2NYgToS1juXH2LhKXLAGFiT-LFUY6gQFKl
    Ukn5ro_SgCPgni-2g>
X-ME-Received: <xmr:L3mqZUFtkCZrOxddvAvD3gy8efMNNOxAyTS0hMlmaqZJr6IBEXXZ6aKjzcZ7SudEjB76pnGuksEnQXNG98MHBggPODx343rVmpi5VO-tctyN7HqKlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:L3mqZdRWdoiebzas-tJTkeOMyVK6T5eEpkktEmZfqIrH2I5aFfiN9g>
    <xmx:L3mqZZw0GYyXMgMIpanyQ-S2i-Ht3_8qKYfztuVU_T3qSTtwyax2tw>
    <xmx:L3mqZb4qtpQNGPaq2Z1F9umThhM4ygPg8kt_JZfSJAYFi0reUos5Og>
    <xmx:L3mqZaroKWt6peBlJYv_Q9brNp20TXVvwbe9i7IZwKFauufyL9G7rA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 08:29:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ce923d62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 13:26:20 +0000 (UTC)
Date: Fri, 19 Jan 2024 14:29:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 08/12] t1415: move reffiles specific tests to t0600
Message-ID: <Zap5LM78CdeK5mTR@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <9d10526369525a0ceee2d75742399130ccf885ce.1705521155.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p3xDPUHHpweU6QFu"
Content-Disposition: inline
In-Reply-To: <9d10526369525a0ceee2d75742399130ccf885ce.1705521155.git.gitgitgadget@gmail.com>


--p3xDPUHHpweU6QFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 07:52:31PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>=20
> Move this test into t0600 with other reffiles specific tests since it
> checks for individua loose refs and thus is specific to the reffiles
> backend.
>=20
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t0600-reffiles-backend.sh | 20 ++++++++++++++++++++
>  t/t1415-worktree-refs.sh    | 11 -----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> index 0b28a2cc5ea..8526e5cf987 100755
> --- a/t/t0600-reffiles-backend.sh
> +++ b/t/t0600-reffiles-backend.sh
> @@ -502,4 +502,24 @@ test_expect_success 'empty reflog' '
>  	test_must_be_empty err
>  '
> =20
> +# The 'packed-refs' file is stored directly in .git/. This means it is g=
lobal
> +# to the repository, and can only contain refs that are shared across all
> +# worktrees.
> +test_expect_success 'refs/worktree must not be packed' '
> +	test_commit initial &&
> +	test_commit wt1 &&
> +	test_commit wt2 &&
> +	git worktree add wt1 wt1 &&
> +	git worktree add wt2 wt2 &&
> +	git checkout initial &&
> +	git update-ref refs/worktree/foo HEAD &&
> +	git -C wt1 update-ref refs/worktree/foo HEAD &&
> +	git -C wt2 update-ref refs/worktree/foo HEAD &&
> +	git pack-refs --all &&
> +	test_path_is_missing .git/refs/tags/wt1 &&
> +	test_path_is_file .git/refs/worktree/foo &&
> +	test_path_is_file .git/worktrees/wt1/refs/worktree/foo &&
> +	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
> +'

Given that this test exercises git-pack-refs(1), should we move it to
t0601-reffiles-pack-refs.sh instead?

Patrick

--p3xDPUHHpweU6QFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqeSsACgkQVbJhu7ck
PpTefRAAoIpFBIWtPJWvCtqbdG7HHUtNxnzzC9l3SwH+Kl6Shyt1bObqFz0CJhjW
pHcmhnuTIx0KKshNbyLkC6RHWZUOCmOSHeZwjZTKuLg90bbOuBz9zPid5TzZxixr
zgBdMeAgphI1xJ+tX7I986wNeh0SNJMBzVKvH4NHLs+tEW53z3jQnwF5UtZHCKwj
4eE5aJx41cCoThtdNXdTY3ZbjsfT1JniKcKFUzJejNYwQ2UaGsY4mXIPe3SEtl2G
RZDb7ER7sksM4ffewGw2jxKjPfUZgU1/cvYQcT+qg80+oWti5p0A1KSwKCeJBobA
NfSFWHkLoQSJs8teddd7hX6pKyYtSEVv7lCjBpEl0eO6cQBXiuCCer8u3YfkmxQI
I1CrOy/aBf42aipT2J3VC6ETOAL+W6EOA7FDWWUQtlG4rKqZzvL73myXIpqDRSnK
PpXV/1UARK9CcmZ+xyndFqaNzPZ82d5tpHP9GfAGLEnt59z43yz0a/+M8PNH6eZp
NJFv/I72NMdTa7G2VSUEFB/XC94MNCmoZuUDHgrxnjxY9aYyxe+UuS/hNTQk5C/a
7C1a2+ZOvpS3+B8qvzf9BE4isGSzh/ABUeyL2/Udton4DoHbGAzS/GFiROHFC4F+
m/OADV1neupoj1/+VY1bCm0gMlArh1Su6FGsCK8I3rs3E3GGAjQ=
=Ka+8
-----END PGP SIGNATURE-----

--p3xDPUHHpweU6QFu--
