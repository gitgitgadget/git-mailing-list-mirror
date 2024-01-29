Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A715B5C9
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527946; cv=none; b=q0+HkWqeFd3iSMJN1FbnlierSIX/l78yWcFJXiorChGZIpibuXy37mbOUtkQEAGEp7fcjlTxH+VWGXMDMBHK96GMUnsUbCawk87SsUn6u9DQVSMZJTFQywCIa0+6CbRlB6tjzRMrKMvoy9A20fCM9ALApjGVdFKQL+0a1W6+PvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527946; c=relaxed/simple;
	bh=sSNaC4xcVAFeOwZo77i8POOPLsjNS1abFPnLgMtbY0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJEiR4mpBhWQ42FWKm2PPV+h1aIl/7V0DjIZIayTul+2iBZADYWNCODeAewZ1teR0a6C2XAPZZ8qSL9tkmcsZLNumokuc9L6PSrO9wo9cSJHboSO9KnIqQcI978XLWIHzxLBrtQcvxh4CcaNouNq5fdpga9lpAVywlHAm4etPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qrHF6EmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0cLtuTB; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qrHF6EmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0cLtuTB"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id E7CE95C0089;
	Mon, 29 Jan 2024 06:32:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 29 Jan 2024 06:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706527943; x=1706614343; bh=xKyJbX19dh
	pRvKIiIx6YxXip1CaKrrUoGiQeT2rT9Ds=; b=qrHF6EmVHPPndIj3GnfVpxzHxN
	SRChF9BTv+JIDTH2ARI/UVsSLi7qxD14PHiHvgj7SzcBVRwXJ7oPv5vxpkRL3y0E
	tnTJUzE3p8tQDJKiEcW3IVE50XATm8SQFaW7bCEMPdQ2Vj/HKDDAsotEkxsjNYOF
	oBktXqv+mPWzx5anUk7As5wIwOWX8o50MHQUaIVXarnkiAA1DRocOf6sSIuojQyR
	N/WewmvcNHze64KQjG5XbLMmNdO0Br9Pk/h3YLAPkdEIrVY5yROUn9j+Dv5ITa2K
	7LujvRRYRwY7AzbUCzQeoOjfXmrTmToBDp5txvEL6j9yjKv950UByrubBJxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706527943; x=1706614343; bh=xKyJbX19dhpRvKIiIx6YxXip1CaK
	rrUoGiQeT2rT9Ds=; b=B0cLtuTBvwEHSfAriigeQVUuSkEXS/tZ1D5ER1et/vu7
	SMppMSumv7Z0pKsQ5AqwGRHopcz2ldxR28IY0a/BykFaCUyGa4EoVahCg3ElMHQt
	qboBoLkfsg7WMUYF48flJEYry2s64jg0VlTqCEA9JEYggMMRHwDAWcrpriApanzh
	DFpIFA2l4qM7fcf8YPbkdiK2ROCBIGixNaKhTDYzFkNmjP12NZ3V2KL1AhcEHPHp
	d3C3/NKjm4GkWAhLX9vXtsQThn6VzfiACU6RuSUtuDnvr2W91BKqdrxiIC1OLHd1
	FtMl2XWte+8Nnjukd0MsJyoWbCX1tM8yK1sYKHpE4A==
X-ME-Sender: <xms:x4y3ZcBhiirjJxJ_1QobRVrMBcssmJFo0FnAOgJ1LM7FcqFVXimfOw>
    <xme:x4y3Zeg6tFVT7yUEkDqhDQ46PVRnT1qqTC_2Xox5bJNdi0EU3vHT-LRL8RvOM53hI
    uY1XyZBTGqaPz1v1A>
X-ME-Received: <xmr:x4y3Zfnc6d-PmLLHwBHqQbKQgh9taWJIOGaL8y9FaEs5WCpRS7SHZs3SDVCfW5YHS-ZHU8g8aHoqZ1j4GGd9qX0Dyk9YqsXAxKv0oZZG0AD24Mo7YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:x4y3ZSw4ilt90Q5GslZiGqPvmEIDcKXRRKCGbnErm6_tLSSsX2aARw>
    <xmx:x4y3ZRQ3JVXGGg9QM-IutWs7S5mXnp7-CubmF-UhIImmB7_voaVBlQ>
    <xmx:x4y3ZdYHq0_ILOjtVH1ePUCWeEVhD4yct3nfsMyuhyG_6MDbTIGn5Q>
    <xmx:x4y3ZQKdZzNL_T8T8W9wmotKUqZ0rkQtcrfJj84ljjQO3aUkYR7fDQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:32:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e70b525a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:29:05 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:32:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] config: add back code comment
Message-ID: <ZbeMw5tgY9S6k6y6@tanuki>
References: <cover.1706466321.git.code@khaugsbakk.name>
 <48d66e94ece3b763acbe933561d82157c02a5f58.1706466321.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Iibwz/nqm5B/qeeH"
Content-Disposition: inline
In-Reply-To: <48d66e94ece3b763acbe933561d82157c02a5f58.1706466321.git.code@khaugsbakk.name>


--Iibwz/nqm5B/qeeH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 07:31:40PM +0100, Kristoffer Haugsbakk wrote:
> c15129b699 (config: factor out global config file retrieval, 2024-01-18)
> was a refactor that moved some of the code in this function to
> `config.c`. However, in the process I managed to drop this code comment
> which explains `$HOME not set`.
>=20
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  builtin/config.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/builtin/config.c b/builtin/config.c
> index 08fe36d499..b55bfae7d6 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -710,6 +710,12 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
>  	if (use_global_config) {
>  		given_config_source.file =3D git_global_config();
>  		if (!given_config_source.file)
> +			/*
> +			 * It is unknown if HOME/.gitconfig exists, so
> +			 * we do not know if we should write to XDG
> +			 * location; error out even if XDG_CONFIG_HOME
> +			 * is set and points at a sane location.
> +			 */
>  			die(_("$HOME not set"));
>  		given_config_source.scope =3D CONFIG_SCOPE_GLOBAL;
>  	} else if (use_system_config) {

Thanks for adding the comment back in! The patch looks good to me.

Patrick

--Iibwz/nqm5B/qeeH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3jMMACgkQVbJhu7ck
PpRxyRAAjf63aV+axUJys4qvwc/VkM6tZbHosz6r6+kykTYQBFtUPzt/db7kZ7mv
l+RA/q9EwMsSaGGQvHeHO0PxG3Sbagz+cjMfVEvaeDu5K88KkSt6LoZRXQZm6Qfr
TPU5GWFQutim9VRKhnJs3xexLNr1H4Dyt2H6M75IcguW5fKDaAFdKSgBSZNCA+pB
sciZKbchAzlautkGV9Kt41rtVIAB5ulPwQgpSrC+Lv6u0JB1rrKV4VluKH7S/TCQ
/bp7X5tFxLvTXzy0phyj5oyQvFgnAjxx8S8GJQVwDd0lYgIcZljtIurHbA2YE50d
xTWVWNyuFJ2L0YWqcel0+UQuST+OsH9ql2DWX63fTQY+TylcEKTOy5C2EDsAeBiI
7Uizr4J1HDJL6T1lUmd0pDkxvEoqmRa/n7kIhjxtJE1zMlpz6bOiW2/q3ZCUCI3D
fBrRzj8FDkCYQSlgqLNcYKRxqbUEYHBHym1oEUKocPOo+GYW7nsUVHmRDm42Zgg4
Hf7ufqnFzF4SnaC4OA3IHYaWz4iGrBGMBjgvxttmMLu6nKvmlV2CLZLF/MeD3MpP
syPnzNGbY8XS6vjcoRuwLitHo5VWoOPm49M2fEmK6ODdzOtSpzn/xyMnaMtrESOQ
ZHsX/k6Y7vLJCaYBQHFtxfemllJ4EaNZ1ofHdFvY0GI8R+nJxu8=
=oFOj
-----END PGP SIGNATURE-----

--Iibwz/nqm5B/qeeH--
