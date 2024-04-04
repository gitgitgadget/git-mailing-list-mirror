Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A861CD3C
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215982; cv=none; b=PZbkPA5lmnH2aSZ/VSfaOcdj+XQNO3u/wZk88pONhQvM8ZAk/YIH+VkAkKzCqlietXTHzMd9Xr3I75cE77jC2rRlzH9OxIFq/Jd+vkr3q4hizPEbxitSKGWK/jDhRfPV8ohzK7CpbJ1mAxV+Rxo6HB1X5+vbZfeI6qvOu47vUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215982; c=relaxed/simple;
	bh=2mQVeD+pGp1bvVnpPshMWKxpsIpIKI8+VVZCugxpAlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzBBpJHAoQJdeDKCpBA/wa67Occp5OgPCUFB3CDu8t1m0ECIVrAaBMk8tGxIJggT88ofuSn6QItQ60XhvXHAvV1T4Q9SANXIfLisUO5r6lXrXHKXRQGafUknVLVVf3g511p9j1gP9luL9PdlpmCnJxbl3P7eSclwq9K1FhlEl2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MnXQK+75; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W2h7RdAK; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MnXQK+75";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W2h7RdAK"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CF0F01140112;
	Thu,  4 Apr 2024 03:32:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Apr 2024 03:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712215979; x=1712302379; bh=2mQVeD+pGp
	1bvVnpPshMWKxpsIpIKI8+VVZCugxpAlw=; b=MnXQK+75Pv1qb8ZPVD1EdCeCvs
	rNAFRKSNYZ4ROIsPh2Tj073NZ38sb7Ib24GRQ28BnEJlih8uT/kW1+PJN/Q/typn
	DZpIWWTTDIboTLVbHi4jJpWB9aUVyaf3gX+ZRbpH+pOoEGZqBSEhVoQaa9N74F+p
	QkiAAP5/M1a+GbUkQZutsUS7Z6bgsY94+js/ipnqNaL3xuWCnQVJOKyLXmWYhq2W
	JKbKuavjveRD1yxUXpjLm9aS0DYUk4reCsOfUJiIJyBJUouZqTHKkBZxel44Nd5S
	CXwMxxQbGPDVN2lG1qjTq48CXbAHVa9q8gY/4P+WiuUuLPOASqDVLqrVUXtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712215979; x=1712302379; bh=2mQVeD+pGp1bvVnpPshMWKxpsIpI
	KI8+VVZCugxpAlw=; b=W2h7RdAKqShGu1E/EX71wvd0tLWTyvzJwEi9949V7J0M
	MXQD+IvkuA2vbQpDNWkuBZi34ZnOgiUtSZRZCQYcYO2tSSjF7j6j57FsSykCJsNH
	Cw/n9md+lbH34Q+Wdofwfkp2nQN0eqs3WjYXBlldg32Lcgcc8pS/eqA8YWF5OUD0
	sWNVBfZkXGPNS7NGMreGfnOupfo29+DxE0mt7Db/XHE2zAQfgZtTajo7FSHoro9i
	r9+BRUOF4B+YVF//FDnmO5oWdX+QFARA1Cf8TcOybE0lNAWR1h43VXtqbGihlupm
	baU/XYtYu/9rUyLvew+MqPv6mNBxEI5akKD9OToZwQ==
X-ME-Sender: <xms:q1cOZuybgsUIUi0qhmr2DjuqQKJzGmduQvUGloAgIDjcVxk5a6KJmA>
    <xme:q1cOZqSHOB7quddOa8PvjUDnJjBwBMDhMUQLxXxp94-YKMXE0c1PHIEGU1VijIXbX
    rXsb2asYQLLtr3Zpw>
X-ME-Received: <xmr:q1cOZgVxf-LtEmi6BxO6krBCOeOwPMPR4070olN7tV58D4bq2lAMoUbrkeTN9QTQ0Hs8XzOEdNxAeY8e4xwNOfrJ5HVasmToBztKwsZyECYpH7Qx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtd
    fhgeeftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:q1cOZkgJTbvhch2h7OpLZKqzp7A9nnQhQy4RWTxqlSehbS4Ms_FyVg>
    <xmx:q1cOZgBoxzBffnlijepL5uPBpYdnI8mmsx8BHOooKI_DPubMjnG11w>
    <xmx:q1cOZlLkPU2pI3Yt4AFdhrBD7QmpajNmmcaSjO4sJGIdvK55wly1FA>
    <xmx:q1cOZnB0sYju9rrQ8AQbL-JBY7kHFo6aNl38pEtpdQLN2eCQfRpG4w>
    <xmx:q1cOZj8hU49Jae2m1gBasYtNg8kq3dp5iMJAa7HcUoYrYcvW6fQE1Bbq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 03:32:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9a5b4a0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 07:32:55 +0000 (UTC)
Date: Thu, 4 Apr 2024 09:32:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/11] reftable: optimize write performance
Message-ID: <Zg5XqI-MCiGsux8o@tanuki>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
 <CAOw_e7ZFJVwV-vCP65kaT5jrvHeigWRyfsC0vfnk3B-S_dXz2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LGcNeTdlYtSA6xIj"
Content-Disposition: inline
In-Reply-To: <CAOw_e7ZFJVwV-vCP65kaT5jrvHeigWRyfsC0vfnk3B-S_dXz2A@mail.gmail.com>


--LGcNeTdlYtSA6xIj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 09:09:53AM +0200, Han-Wen Nienhuys wrote:
> On Thu, Apr 4, 2024 at 7:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> >
> > Hi,
> >
> > this is the second version of my patch series that aims to optimize
> > write performance in the reftable backend. I've made the following
> > changes compared to v2:
>=20
> Looks OK overall; I had a cursory glance.

Thanks!

Patrick

--LGcNeTdlYtSA6xIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOV6cACgkQVbJhu7ck
PpSjbQ/9GAT2PQeYHFBTqZ/VcKRvoQMdJuvmi5aAay4y2aPGerIChCvS7MLWqnZn
71Lbw+S7APaYjVUH7v7VidvShTc0Z91SZceHlhxDsPrL8mgZ0JclrXZ8wDxlHjGx
xMFLx/TNVjbWLrlenIE0/sI/r4kLTU5yCQzXRDDF9CBho9fEL4C68cquVy2xNlRy
KdBmVzuLd+l6UR/zacGLHVyjiahXZBAo5JLByQDf7eisAL29DfWPfu7n8WCkJaXB
JlJJB/BAM6fej4d9nt+uHfi/O8uqWNF2FCPKEUBAOX/bz7pwTlVrkQmrfPrYU9v7
zcUCa3fUMtjg7otrziTyCxMMCtqZ87OgmKtd0mQQskHJRdkweN9YLj3ISoglm3XT
2neNjbEtDt5WPjBLBaHxxYk6+Wfxr6zchj1GaAAZwVUu3UXAZfdLIhSGJqNfTFKV
6Rinwyy199I4Au6f1gzKOiN/MXKonGV1Rg+HTtjRKteWtD8cK32OAHZfnnFVlc/q
Osd28Lus6F+TvqOsyaw9tb5fq6kSJgQoaRBeC3r90HkXXwhGOEgRfR1/njmRDJIu
GFq27rV8wjQLMfZ4lF5xHhfwnZD1v42vZ4+SxvEF5aD9Hz7wx4WakEAptlgJ5ofz
eIkaJq1gs3uB0VGyK333GIe2HLgmOd7fvwcd9tOg+JisW5Eklho=
=MuJN
-----END PGP SIGNATURE-----

--LGcNeTdlYtSA6xIj--
