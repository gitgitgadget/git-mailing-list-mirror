Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC41411FC
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486983; cv=none; b=p3JcinSYDBxHvlXcg6MeVF+7GbqNzMQUm45K2PtO1Dx2Cubi0ksqn75F0lVYqml28rqUafp3oRnfxeU3KFLh4nt2p9rihsE59z05tJYDEfCZmtGqMZaEun+56grFLaoMbWjPSMWhxam9NeCXf1YBoZ2JQSkuV4o+abQBN05bv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486983; c=relaxed/simple;
	bh=WAbzwO17R9rO9WaXse2xR6MxmQSKlHlOevzHoFim9Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtFM3jRpb2sM6f9fsq9FBfBJUrs0QLZS+QHFoo5GVt4XRsT4xGGAcIDrV2STBZLBJNxSA0A9bTPpv67qQthWlp370r+itm02NkaYqj33t4eecY64np3WAojDJl1e5qXy6bXmB3La+U10JnMqjJsZCw8RTGXSY7JtGaewzdE/7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=apOXBwyf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qxx/WFqF; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="apOXBwyf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qxx/WFqF"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3795B1800132;
	Tue,  4 Jun 2024 03:43:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 03:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717486980; x=1717573380; bh=OIQAPnEE7L
	8mlKTYMaWEhKbhhxCWm9GNCJdQElib7Lo=; b=apOXBwyfllxCv57evCf07pFCCo
	z2duQddWr8bAgMNfsv2GBo9mhfFhCGACH96iAAvAUr7UlejjTAfawu1nFpOuWo7i
	W9CLr3QzBkh4XHSnI+uQwauz8uBpjX+R0306WwZbI7f9V3B2vnl6im8pTtfXn48d
	0km9xOruTfO0qeuwgd/MDSHrYLUtyKODnDrOc0iOoUYdRsYv6mvAk2GtVRYqBmXq
	KfpV8/UJKIuuxOrUTqh3QcqyTvGR1kNYA8ZC4sTaJbtqoB+Kk56CXPM04qgCZs7I
	kUToMXWzRhRA1y0c8XYBDQIZrtXkwx3bfSz585h7LpfXyPQ8je0OMVqrWoxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717486980; x=1717573380; bh=OIQAPnEE7L8mlKTYMaWEhKbhhxCW
	m9GNCJdQElib7Lo=; b=Qxx/WFqF/q6Tsl49BqdTqU3Qp8Sybf1EfRc1anuRstYD
	NlblMvTf149iwiopUzCa9eo8viWnuV/vnYUPc07Ii6GZS9Od5yWLbigGiewLwyst
	r7vJdOKoyX6Mg+fhZssqeRh0Qg+Iei/fUxq1F81t8CkhUqHLJhhcZvfB6peBM4Ob
	XimWYlzBIZ/Reqz8UoNvXaLWJAuFcd163dFQPZ+AIxWhS1ZeyKlFVWfDm4v3KMg9
	bw64sOB8We0kl/DN0qQtD+cavhvJRGDY0gU6bV7GKSrls6KpBtgE+ua7UaBO2o2v
	WvhGaY7Z/aVE9SBfu8yHkIKNRVfKvH907Fs78S7IdA==
X-ME-Sender: <xms:hMVeZptShtAheHciEr-oPtwb9Na-1AZdDD24MtacK5TmhE17txffeQ>
    <xme:hMVeZieKQlBQciHM53HBHK4v1xHYZfd8RYg0KooX-L0V62hPTztSyx5bTN4dovVN1
    iDsdSxCrw7SqoDUwQ>
X-ME-Received: <xmr:hMVeZsw0yBmUKQS2NhPv3at7-cAOW_FX3uHThimlCH0qorpnhQ0kUZM4AN0k7UOwI4KvxZmRpuwqUn4tyP26Yx2EHzPeb4qmPtN-MAaCq76YdI-d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hMVeZgMvobJCIo-qsFqNS2xoWhbmEdpEG4Jm5xJIWWnvo62JEbJn3A>
    <xmx:hMVeZp965QvpvlQ8NFgTevkvUasYddJkt6upgzXhYvsZVDTgk1tp2w>
    <xmx:hMVeZgWsWqpHEoDXssu8XfQkeJchCoJYYSD0JTlPDRg2xz3o76zbBQ>
    <xmx:hMVeZqdNYVwq4SAvU60rrLZ5BtY0jf-wwtX53UEAAUAKby6xB9ucKQ>
    <xmx:hMVeZrKcg0ZdTmsx8LENV-UDJV9qpyWsyfSyRYsjc6pm0hISWKl3Mx12>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 03:42:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7bd137b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 07:42:33 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:42:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/13] sparse-checkout: free sparse_filename after use
Message-ID: <Zl7FgVPHGiXJYSah@framework>
References: <20240531112433.GA428583@coredump.intra.peff.net>
 <20240531113545.GJ428814@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vCxDX9cdkYjGyCDM"
Content-Disposition: inline
In-Reply-To: <20240531113545.GJ428814@coredump.intra.peff.net>


--vCxDX9cdkYjGyCDM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 07:35:45AM -0400, Jeff King wrote:
> We allocate a heap buffer via get_sparse_checkout_filename(). Most calls
> remember to free it, but sparse_checkout_init() forgets to, causing a
> leak. Ironically, it remembers to do so in the error return paths, but
> not in the path that makes it all the way to the function end!
>=20
> Fixing this clears up 6 leaks from t1091.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/sparse-checkout.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 356b7349f9..3af9fec1fb 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -500,6 +500,8 @@ static int sparse_checkout_init(int argc, const char =
**argv, const char *prefix)
>  		return 0;
>  	}
> =20
> +	free(sparse_filename);
> +

I wonder whether it would make sense to merge this patch and patch 4
and then refactor the code to have a common exit path.

Patrick

--vCxDX9cdkYjGyCDM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZexYAACgkQVbJhu7ck
PpSGdg//U9nGz9FiL8JUFToUg+zQmS7736/JWhW1MmTCZKHQPCz2p7Hcc2FM3tnx
4XTlyLgvFddMsqlx7ke2B1cy4xkHbm7BvUxUPVJx36tFENyYF2icX9PBsaBgmTqF
q6cvPzg21gzjftZPzNjmg6uqST0JApcy0kK85n8+wIFcMtCEqgIbJMPgZfdGO6P6
MiJs8pDdq+OHs5v+e1XWFrJ+/rC7yqVYk9UOBBueP6A0mOl+dG+jneJOsYziSzdi
TRUQA2e1iQZYnZf1+ZEjsOdaz330aw+53RDwbMoUGGK5ojkxZi4QdFF5hM0M115p
9SSt3LpVyz0XDEWwTL0bAOJDj+aNUdsEUm/UmYex5mXBo0JRYqzARQWtXzpyaN8E
+laxSzp6YH0Ah/yvczoktUTvL2fmVYs+NZuaPwizmga0S9DNJBUGAMmPeGReSqNC
LV38+T4VOCJGVYA0ZhXxuDX6WrFKU7xdb3FzTxy5c7vbC8ZI76zqc7ADmmHvxJiE
CJnmQuu3tawzlwHii6/hchDKHA/KJozdXNTcbZsrTDUcaqOOpF3y2QhcDZoWmZaS
A9MMVzpitAnW6DgRjw54J5Lk45QBb8k4le6AExnovLw75YZChiYi1z0UEzCweb1f
GS+C5aI8fXke/LxIygWZQP+879kWRZ2yYPXHPyLuagkiUN+pssc=
=iBnv
-----END PGP SIGNATURE-----

--vCxDX9cdkYjGyCDM--
