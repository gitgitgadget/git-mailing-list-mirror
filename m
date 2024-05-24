Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724085933
	for <git@vger.kernel.org>; Fri, 24 May 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557439; cv=none; b=lOW1FDHAVF6K8gOo/KfGP6HVgFv4BadLiT5kzj9CQQDEbHmX4yzjpBNOcANgr1df3NkAEFBsGixiW3HuiUtrtWlGvdm8OUhfCpFXgLdWOatIxbFdGuvLyddRssBu47N7/3afetLOl7krli3nidFrXJJBUQX9maquXPCOuE/h7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557439; c=relaxed/simple;
	bh=nj+xtS8yQwLfbe4eh6OihK0EkUsvQPhSudM7w2U4p2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOCIN9iqIxZX5CjCCEPcqSNvt61FxmnswiDKcPNMco3pIa85gky1EZ/q5GmMHQhd8rqM/iVicQTOlqv0f+PSMIsGkula24xrLMKjYf4NHB9qjtabHtnb8UlvG8FkUWfwQ7c0ZEE7gNZRKhoBHesPAtaiKJgk5OuacawWowR+beU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bhIfMfyo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YVSgan+2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bhIfMfyo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YVSgan+2"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id A6AFE13800E5;
	Fri, 24 May 2024 09:30:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 24 May 2024 09:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716557436; x=1716643836; bh=8P6axujHyq
	FbLmrg93klVlnb10FxRmmYl+Sbmez2p6w=; b=bhIfMfyoI3c9QYzZBEhcrXSpR6
	Feet5A+79axfbIfNNTDLLKozgz97oC2ClflAVwMdBLpxhWD3dzSqTyVhF4Ft54al
	w1dg3RyRi+ptvAGxz/2lmWem0/dG/PoQAgdnEFx9E+vrDEnj2izZENOaJ0ZAbMVh
	YM7oWjguVkcDtxRwcPAuREJicoDPkh7UMJs3woJ5RVc/wfBsJ3lpu3hwWESdXTxh
	2FXBL8HgCuIzjn/d1doGeanzUJxoG/DWg5vp/VYi9zVMQ+ZO5+juhCzv4xYOxBkk
	EqPG4aiEg18dH5wc/QFvAxLROX26BGVJZ7M7QR3i/bIHyVOUSOcHqgs7A16w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716557436; x=1716643836; bh=8P6axujHyqFbLmrg93klVlnb10Fx
	RmmYl+Sbmez2p6w=; b=YVSgan+2cgmCpdiT0s8AvMwdplENXtMbzEyKVleQ4z4c
	/E8LCOWs5thSJNZ+ERw6qSybTqFHBmIMu5wxBz0ESNhUSyxtg4NSLkGWjhPC24L4
	kXM6LTydpvDhxDjVhuVMEcOgiXl07Jx8pCbalGdNug+YpHIJeSMy3QEboFUArG4Z
	Q31/BCBuPr4WibYrNjQrtciECerZVtfAyyCFV24WoApsIVcTxnlzYPjH8QNbP/8j
	l+Hx4aXfeidZDdUPWF5w5WxyejJNG5zrl4hWcPHJUtN4TXdaIFGwq0g/OtNw6Nyd
	Q/RNLHH8Gj8Zp3UeERBSBOdA3dTfGoETMF9SPQFyRA==
X-ME-Sender: <xms:fJZQZo_v6cquAE6mTacJp32L4oYzJ17v9puqGJLr4765pLFuEm9aHQ>
    <xme:fJZQZguWn7SBmGm0vam096kjj4lqWR48faFqA4qzHAhtEPsLpz9-2IJrIG1CSduEd
    97GMfc0NpI-Cehyog>
X-ME-Received: <xmr:fJZQZuAcRRz2tI3c5hjFQrLIpjE1PIDJg9ZDHYGRsPDhfD--IGN0qR01LqEK0zC4RLgkeM_P9WAR745-KONXd3VIFfFauLM810BZvF-JG5RgOoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:fJZQZof3wURi1UAXTatHitNxkEuBM37UZ5gMcoJiMC7al-A9xF-R_g>
    <xmx:fJZQZtNysQk3AanUQ4VvyH_J3MJroBWZRepyWx1stR78A8SuJlOmTg>
    <xmx:fJZQZikSIuMUR2gURwQx3aMUC3xLGvDMAH_PvdqCQ_lpjQj8eynM9w>
    <xmx:fJZQZvsiPBCsh6lOgLQHstGoIEMMR3bHnwalDkN7-m28dAqXken4kg>
    <xmx:fJZQZge5FisGBMN_UiL5FqAPdk1Kpdi7JM3_-JkIU_MDchGxolkqFf_U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 09:30:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 782f2e9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 13:30:31 +0000 (UTC)
Date: Fri, 24 May 2024 15:30:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: ach.lumap@gmail.com, chriscool@tuxfamily.org,
	christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 3/3] t/: port helper/test-sha256.c to
 unit-tests/t-hash.c
Message-ID: <ZlCWeCJq6qxWrJvI@tanuki>
References: <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240523235945.26833-1-shyamthakkar001@gmail.com>
 <20240523235945.26833-4-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S/SJPAq+ggVzGTiZ"
Content-Disposition: inline
In-Reply-To: <20240523235945.26833-4-shyamthakkar001@gmail.com>


--S/SJPAq+ggVzGTiZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 05:29:45AM +0530, Ghanshyam Thakkar wrote:
> t/helper/test-sha256 and t/t0015-hash test the hash implementation of
> SHA-256 in Git with basic SHA-256 hash values. Port them to the new
> unit testing framework for better debugging, simplicity and faster
> runtime. The necessary building blocks are already implemented in
> t-hash in the previous commit which ported test-sha1.
>=20
> The 'sha256' subcommand of test-tool is still not removed, because it
> is used by pack_trailer() in lib-pack.sh, which is used in many tests
> of the t53** series.

Similar question here, are there replacements we can use for it? I also
couldn't see it being used in any test other than t0015 when searing for
"test-tool sha256". Maybe I'm looking for the wrong thing?

[snip]
> -test_done
> diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
> index 89dfea9cc1..0f86cd3730 100644
> --- a/t/unit-tests/t-hash.c
> +++ b/t/unit-tests/t-hash.c
> @@ -32,11 +32,24 @@ static void check_hash_data(const void *data, size_t =
data_length,
>  	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_HASH=
_SHA1), \
>  	     "SHA1 (%s) works", #literal)
> =20
> +
> +/* Works with a NUL terminated string. Doesn't work if it should contain=
 a NUL  character. */
> +#define TEST_SHA256_STR(data, expected) \
> +	TEST(check_hash_data(data, strlen(data), expected, GIT_HASH_SHA256), \
> +	     "SHA256 (%s) works", #data)
> +
> +/* Only works with a literal string, useful when it contains a NUL chara=
cter. */
> +#define TEST_SHA256_LITERAL(literal, expected) \
> +	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_HASH=
_SHA256), \
> +	     "SHA256 (%s) works", #literal)
> +

Same question here regarding the macros and whether we can merge them.

Also, we do have the same test data for both hashes, and if we ever grow
another hash it's likely that we'll also want to check for the same
inputs there. Would it make sense to have a generic `TAST_HASHES()`
macro where you give the input and then both the expected SHA1 and
SHA256 to avoid some duplication?

Patrick

--S/SJPAq+ggVzGTiZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQlncACgkQVbJhu7ck
PpQz2A//UmXpA4LiZfZ3hpE8A4TbZZtRRryBAWIEEd4gWOC0dOy/LtYybZYJAsMw
Ldma4TtzY38Lp5/dbnSdr6i0iClmYHjEPfmp5FtoBCM/pfza2yV/lWhx38zitpjK
NRVo9sKedOe0DRdb8Iv1uy6GAd0G41yuNoIAd3Eho0BGmduANiiCc/JgM7odIdIv
rOLdELwcv3j/o9oZ5TfSukx+cKpGhL9r7odRlSR2+9K6y/PbTwSnU8erE1fob3mG
j9c4ED7XqjlkSV6KYFpVPuuVIlIGQh0qL4wJFL1qjsZtQNxvbf6XQOVhDOH7wEld
9+grvFPJbMR2BrVbfSGD2eyt/+9xMXU7zQtOBHHtDKU9g+Z3Lcyp4Abul0gyOsNR
9ch9s0isnaGHT/4J/Ql+2M/aMdUZDPonWntHh/pJsrYNAKpmdOw7GlXB8HynxiU8
0z9bbvlgWB3NThNAc4Yy++jopn400Vsqp34mSLuZHb/ElqqOGjcUC5WItyzdQtHB
Ei4iLRMu84mlLrjG/EECloK8xuFOMUQDFbKbDqn5+nOT22+IONu09vIlfI4pNfKx
6Fk3/T6XEmMQAIcjmClxHr6cFPlMFYmVsMMY1htoO+lmrl/L18lECVLLmaw1dJr8
D1XiVdrpm0FK41N4mbxdncw4hbRc7fm31WsKwhxTMNPXniyUx+4=
=b8EI
-----END PGP SIGNATURE-----

--S/SJPAq+ggVzGTiZ--
