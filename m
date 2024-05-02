Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8A152797
	for <git@vger.kernel.org>; Thu,  2 May 2024 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634980; cv=none; b=N+5kTJjRX7L7Yh449CAidgtpPEuBRBOn6ItBwP266pm+AN47JeKzJlpWfYsSWUsAAlDTlxu2JnRPHN1I6lBvF+t/QAxp9+JzUiZsQynx32cuob2UXyt+KNxRQyluJghLnyanGHkDcP62Bf2OGFq+HISuzxxVY1NQ+rtePCJlVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634980; c=relaxed/simple;
	bh=Y7Ga+d99UIVzkNXsKl3e8aYRui6f9OdnAYd0a9UducA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWPNWA1+mRpF4dASZ2rstVvjDXNV/WI5+YdBRxy4jcmzeEsxPGLfnzYGHGj00UWhqme31LSDD3dZVnAOS4PiqNtg6vMVONAKEhJt5Luf5ZuuOlTym1oCTJMYBcEKJ6VyJ+xu9ADpPRwg0rReINRZW3TLV67KLD+jswPYLz9Tlow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FuET6ZDG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CozjH3aG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FuET6ZDG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CozjH3aG"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2328E11400BA
	for <git@vger.kernel.org>; Thu,  2 May 2024 03:29:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 May 2024 03:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714634977; x=1714721377; bh=Bu7NvV5pOF
	90ZhmPPu6pbufH3P+Bx0gCwOQcZN2yvzI=; b=FuET6ZDGEVpk2t5d/Bnb6pJjd0
	qwmtIIwpRyxIsqhkGfawqk83gPU4emZ84BnzypWjHr5PPvY7ZpgqNsTQ2vFptJvy
	6PnqY24l5YvvUAQuL/5eAhaz+Nzug1tfAqFtMghvbtLeMqeo+gkPrRK/WMowrng2
	8pz8ecL8i7A89q+x4c5JDQrU+A10oTJyUFxEws6hNXBaJG0FYzwQSqtOcDqd+1Wg
	ZpSqv90XbhBvaQ5F33ILO06r9X7dl/NjLNl5siT2+nROVgBN/0GpyXpi8yNxiOaJ
	FbkvsQPcvLsePTfSOU3PbuvgMvRcLj8tPFUeRfsRbd8x75nkyPDEOqQlzqNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714634977; x=1714721377; bh=Bu7NvV5pOF90ZhmPPu6pbufH3P+B
	x0gCwOQcZN2yvzI=; b=CozjH3aGjm7hEovqf4HWRq4K9G1IeDDF8Eozliqw40QG
	1YAUNK6LhKH1FmPvySQzy8MmEoNUqttLUzKAlEwzGfJmV2NSA2KdvSnPUzCMtoy5
	oV0TvAxr3qi+Ky8KvI6kT0LE82KmhrXL1ADsqumy1TeqRc4NK7FsOc6oNmzF9am7
	O7fVD7HfnfEjQclLIMCqG/Poo2lAKapPOUhK4B5AL8vQe5e2/Fbgi1TEGXzYVjHb
	U1ynAczZJnLTq611rGJqbTvxamTejizfVexiYxDOOOyz085RFJUkrv8dGh4CYxH6
	NZGi52gE5KuVwTV6LDDVB0W07aauQNmiHXKM9D0Fkw==
X-ME-Sender: <xms:4EAzZqYS8XIHWPv39LdtLaDZbhZSg3Xj5eOF_b8HKZj0v8pJ73VjYw>
    <xme:4EAzZtYwZPRxD5bwuZFqds1imexvYFJzL0s5O2RegN9m4WRVhq8RKgXG_4igBDZxW
    BAVo38PCpQ5SSz5Kw>
X-ME-Received: <xmr:4EAzZk9nMaN5jlRoizXjJIrz1QM312g46rnALoAPgIXwWcZ9ctJsEQOFilY3nbw6uT7d778K5VFfDx7fujPRV3Y-VvjqTW5-H2D_S5wQMunSWMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:4EAzZspikeIvFjELaBsZQIcHW6huGd0hr4X8wYNQx21cx0gexhs64A>
    <xmx:4EAzZlpQJJH3j55HeEKgmenNuMrKDGi4QWZ4er38Eqfj1VQve-uQIw>
    <xmx:4EAzZqSuhQyvYfKLRjz7FzTDvCx0WxkMAYBbWbb-zlqeWpN4T-N3Fg>
    <xmx:4EAzZlpFoBmqAinn-_FCjOtb4mcctgmvX_O7jIJitoCy3a-2KKZxvw>
    <xmx:4UAzZmA9olk7zaghghRcKwmN2ALKDFhWgJIf1LHNKxge00GrCqxx2sF0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 03:29:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 167f2dad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 07:29:08 +0000 (UTC)
Date: Thu, 2 May 2024 09:29:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 00/11] reftable: expose write options as config
Message-ID: <ZjNA2zNH5twH5qj0@tanuki>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ho3A/mDjwxaqF+Qo"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--ho3A/mDjwxaqF+Qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 08:51:27AM +0200, Patrick Steinhardt wrote:
> Hi,
>=20
> the reftable format has some flexibility with regards to how exactly it
> writes the respective tables:
>=20
>   - The block size allows you to control how large each block is
>     supposed to be. The bigger the block, the more records you can fit
>     into it.
>=20
>   - Restart intervals control how often a restart point is written that
>     breaks prefix compression. The lower the interval, the less disk
>     space savings you get.
>=20
>   - Object indices can be enabled or disabled. These are optional and
>     Git doesn't use them right now, so disabling them may be a sensible
>     thing to do if you want to save some disk space.
>=20
>   - The geometric factor controls when we compact tables during auto
>     compaction.
>=20
> This patch series exposes all of these via a new set of configs so that
> they can be tweaked by the user as-needed. It's not expected that those
> are really of much importance for the "normal" user -- the defaults
> should be good enough. But for edge cases (huge repos with millions of
> refs) and for hosting providers these knobs can be helpful.
>=20
> This patch series applies on top of d4cc1ec35f (Start the 2.46 cycle,
> 2024-04-30).

Ugh. I actually intended to pull in ps/reftable-write-optim as a
dependency because I know it causes conflicts. But I screwed this up as
I thought that the topic was merged into "master" already, even though
it has only hit "next".

I'll refrain from sending a new version immediately though and will wait
for reviews first. Once those are in I will pull in the above topic.

Patrick

--ho3A/mDjwxaqF+Qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzQNoACgkQVbJhu7ck
PpR+2w//euWPKvYGTBm14pRaRX4ou2RK4LPl+9N8jmvn3qwxFiZgOeztQuAQheJ0
Hz09HDHfuQDn5CwIq+ZIrN3DEiJJqjjB5w56S7vNRdHIt82bcCEMlZxsiE7T5NKc
H2qLmo15g3DH66sxrt4dfDAmYG/OSQkLhnLEJhUVciJbuel4ibEceI+WMllytEsf
6SpZfadl+jNgwRMhBuyCuItHydSEbI3hwDqNpwm1G3Pkpbxo62lUQhO7NR7nQmRv
FYGgqjhAyY5r+nvnO8IH3PNXz86rPTbrby7l27vqAe5UribYdSiza7TXYCOHCyg8
IEGWeIwmC+2tqYoCZsr01L86yhUqb2QXZS4Iv5mko2mARsT7TztGeF/WI/Lw9Sp1
awK3KWiFVwOcXJ2kmP1xs37xNYwGkEcyl0XX5o/tanUbcwwB31w+QEtlkLLaxLQ+
1SyNK8BYEzOxwTUN8FQZU2TEgJdt4XyeT/rBttYRd1RQi0Vqhzvqv+pHy/JTV9F/
N37KzhrVOXl4mQ0PCMHzvJTyBHysorefkuWqi5ysqMBoQa3dwmrNutdKu5oqqAAP
ij08Sett/xpWCXjrJl4pPBvgX3n/hMmnbmpu+WRoUKZSbObqqwuSzCcYecpTjx85
3UQsXONll3DTeHkf2or9IKaNzzgQxXjc8MP6pUK5I+o1CMoBfw8=
=knKr
-----END PGP SIGNATURE-----

--ho3A/mDjwxaqF+Qo--
