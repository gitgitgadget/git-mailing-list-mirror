Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8E1428F4
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810158; cv=none; b=H2T1CH9M4e3PFqrcRx7bOMeYuDN533Y87mowjsHFw/+eit5QtHMguJ1EueBMn2EFUV+V6bltFRdCWNDClDzeRkvInm5LUQrNjhBczp67C7SbjT96pOkZg2tjvD/qt1UafEy8dbPcMs8UEaLnrx0I8FZXC5E33bSV7Tv1pYOUS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810158; c=relaxed/simple;
	bh=CEsEYdGSdfFwvbb8mEwKKABSkmQoKT29Fzde7m4Q0DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQZ4ykZ8IjrvMFyPgB2aOu+halv8fUs5B3wPC0NBrbJXuC2gs3SyU3aAFRasp05G1hnLUamTXAiyQCgiw46fi2bAHTTVQK5b0babqLMebiZv5pQJozOIniSOOvY4wG2/E3NOeMB49yFFH1SvYv3Gnd02q6nRmG+GRHvWhT5Ynjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YULUQA8i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6ZkCH+F; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YULUQA8i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6ZkCH+F"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8C5DF1380624;
	Wed, 24 Jul 2024 04:35:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Jul 2024 04:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721810155; x=1721896555; bh=RordFpuMGp
	e9ut80VkynktL0Pm1+Iw8XhHTJkJaGTAo=; b=YULUQA8iH0eF/piaek+1tiyIqZ
	h/f5b7yAED4Xq7yWaxaj8f6AGRTMlNLLL7aBrZ9JgMt/BM45mK+ED7cvYndV7AB2
	z5mFIDT+0TOmTQtpLa+eYSN6+Z1cdarASpRagF8T4pyEcWMRNfNAjHcK3RrPikZU
	Bo0Sm2HfBvvP0o+zF2MvfGJ4xBvngT1ScDbgHZb0BTkT+I2QqbN+6eN8LKh4O45A
	gIcruNUt+pyr8IIPeF2/5U5UX5bT81lywcZj/Wc7EYph3JqrT4JqFG4j2ISA7sUC
	500/wzXfXKb3ZC+6wMie/JG7zz9Bu/9h1dS8nPZMPCOh40u/hDBlXIl5rOVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721810155; x=1721896555; bh=RordFpuMGpe9ut80VkynktL0Pm1+
	Iw8XhHTJkJaGTAo=; b=M6ZkCH+FAhdpecHo6YGgoblmSNT98ToLd3D5PAR52t4x
	slx5kpUbILsiYrJye3nPms8rDz+Noy07mab9W8OqmvjAya0fBvjQKIF8A6EC7pfD
	LST2zUOD4CYVzKHgwRnG+dMkZIkZnKFhkwPZTUaiuo/asgcShUml7xF+gHsFptAe
	nYRggO930Ph2lhYtTLo/R61rGvQzOVj0mSqzXbE32KxCik6uEnr0w+B7L3t6klgf
	2F0t/x4A9G4HIMqUTq1eXKg7wfp/HJKKeIVBHQCP4KXNEIDMxZULLT8X9SN4I6xZ
	qGCoVIHrlij/3KabCceW2qMLbIakYm/xAfijNShjPA==
X-ME-Sender: <xms:67ygZlPNYxoPubRbELlVasmzASEoxuRyoSfPt9AxXDhP-XDGXPt8AQ>
    <xme:67ygZn8acXGNj_N1U4PRH8DFoZ_IirX8gKe7LXGyiAXgyr3e04rbPYEErensv-C34
    19qRPb0KYS4T8bzzQ>
X-ME-Received: <xmr:67ygZkS6anGbnsTgUYJywRM49pAKMczlPMytab-tSBLHQzlyv-JGSg9fFdlb_GdNFa014IddW0vTF9qjU3viCtb8nCX0JqRPemuDaq_DdkKJ-qO5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:67ygZhvTXSGFY5JNPY1kwVs6zBCSbeAE5o-rcxiHk_flg8VO1ld7Bw>
    <xmx:67ygZtfoxMMGAtvhEZsxJuA55dHfVEcleaTRmwnvksaKEGDN_G7xGQ>
    <xmx:67ygZt3pIt3QdMKFYF6k9xIcrcx9KH2GXvCzD0fV0tKK3niM_5VdHg>
    <xmx:67ygZp-yUzbQguMYp12llsIhXWN77qzN5jYDv_WEaA316rJHxltTWQ>
    <xmx:67ygZh7OWSZlYSZPHg_GZgfiJSLyoNk90eZrmuYBQq5AsfoYgrQGC-_N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 04:35:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 91e12081 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 08:34:35 +0000 (UTC)
Date: Wed, 24 Jul 2024 10:35:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 02/10] packfile: allow content-limit for cat-file
Message-ID: <ZqC85Z5QzfdvpOpX@tanuki>
References: <20240715003519.2671385-1-e@80x24.org>
 <20240715003519.2671385-3-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u4ngOrL1pCrfvDqZ"
Content-Disposition: inline
In-Reply-To: <20240715003519.2671385-3-e@80x24.org>


--u4ngOrL1pCrfvDqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:35:11AM +0000, Eric Wong wrote:
> From: Jeff King <peff@peff.net>
>=20
> This avoids unnecessary round trips to the object store to speed

Same comment regarding "this". Despite not being self-contained, I also
think that the commit message could do a better job of explaining what
the problem is that you're fixing in the first place. Right now, I'm
left second-guessing what the idea is that this patch has to make
git-cat-file(1) faster.

> up cat-file contents retrievals.  The majority of packed objects
> don't benefit from the streaming interface at all and we end up
> having to load them in core anyways to satisfy our streaming
> API.
>=20
> This drops the runtime of
> `git cat-file --batch-all-objects --unordered --batch' from
> ~7.1s to ~6.1s on Jeff's machine.

It would be nice to get some more context here for the benchmark. Most
importantly, what kind of repository did this run in? Otherwise it is
going to be next to impossible to get remotely comparable results.

Patrick

--u4ngOrL1pCrfvDqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagvOQACgkQVbJhu7ck
PpSZsRAAijGz4L1JjyzvTFnGvk1GBg7b1zrIY/suumFoyayJbxyLPdbGRbzFAk8N
grHX6pUWd2emuSsISaf9xIMZnn+wUkYSLhyGNtT/Avx40ZCCXXpwN0kfGbxU2Otr
ye5JY6q3b8yWE+J/FC11j9Vcuxg+p9hbJk19J2xeOmCdB1xy/wgkhh/rJo8HZoYm
8jab+Pdn730pWthL025bGlQFpkxXuGxpYjN2OvGtQ9KrJsnWzjM5c5fci2FjzYmo
AgyjZLRz4Dcu1M3WmqZEi1JKJdBXHsPKGgDjrwIgKvvIP+H4Sx1s5xA9fXC24MF/
cCIZ3r0UR5jl12uWFpFrSj/Nh1J4Z4WyZEMJOeyPYtZplVk7pFj6hAT9l2Uv3Vqf
LGHQ/lpsDEx1yF3mydda1rVMfLepzRqLdTvkQyPq8WdzYCCsX0DgfLpQOjqrzQVq
ptnwhXjxI4UR5xPRLD1DX3yGOMl+7HyTiCH+1xPRTLsz3WvhBZ1aektVZ7TPOrj8
/N2NOMu3QdGFT7sTLq9ITmhJmn/7j3YCdhHUZFoXgw0lq5R0BYGxaffB9DYUbfuH
fba5mhudTz/OHHrQXEQ0p2fRY7KDPpZPZpWuQTIlTry/oEcz+50xTnYoO15X3GXt
BTdDsoIW+Uhu3W4a1E+uf5Uc+xlQmhqcS2B9gMCDCJxtF2wc3iE=
=x8wo
-----END PGP SIGNATURE-----

--u4ngOrL1pCrfvDqZ--
