Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEC613FD68
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826725; cv=none; b=eXtub7ZC/KXj4EC5wADhxeBBNoZbo87DMyiHYs+xqL4QppQgv9ZQL4sdavp1n6VkgLkbcRNHTSRA/zDlTfv+RU5h77QcZuc69ZPV1vCldcf1t2Y74Ewu8q5ZgAw6Bn1CVwnNwWl8g4pw+XilEoTQSb4kWoN4V3zf6nh3+JIx4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826725; c=relaxed/simple;
	bh=CAdYIDqLYr/BJ+mkYbxkyhhtBmIFpw9pDqAGNrtY2c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8HTbuSSxuEXENhr5yXMeeniIK0s6ZkQaiNHvaInfA2GKfkDccUG4a15OFBInkET/deHCsJxhGmbz6RZ3Gt691GjSpkBSuW6qxjn/cEvhGkTCOYqvikEsYBOlqIIoVJctg9s+747u+Gu706e0mZ2dwWd2+7rxrs9rObkVKdYSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WtU3lbCP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMPCl64P; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WtU3lbCP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMPCl64P"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id EA1A8138015B;
	Thu, 11 Apr 2024 05:12:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 11 Apr 2024 05:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826722; x=1712913122; bh=Yj+KF0mgnW
	9EGRhHBBwhrK+3wqDdwYSmnEbbs0SSWhE=; b=WtU3lbCPitADJejt/WvTbcEPgY
	zShFtKrW4iQhkKTtFK0oIokWmqgEjWKTbiWqt7+eSGq3qSTqp+Ua7Iq1h1g+2oVb
	td2/eAlS68LV6vByBDiPeQvk9xPYlScoYkNa7ouG2IAMwmx4NFfijAX3LMMe2AZk
	DkXTjMenXN5c1nPQljKduddny+sHrBTsN8rWzWY0a6CsWTsoSoc00ILkm/2lfqvj
	+ge22d5qa4M/R7t0lOzMmnzK28XBOWD9XpJVMi+Ea2gwR5ZbG/MWZMRPT+meJret
	v/0hSw6jGXvibzuBLaq9mlRaoXOngOmCrWpg8WnvS7uWOgu2IMuTRgpP2f2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826722; x=1712913122; bh=Yj+KF0mgnW9EGRhHBBwhrK+3wqDd
	wYSmnEbbs0SSWhE=; b=XMPCl64PBC4p2xJnkYnAkatQ1qNwDKh+cshhyVymgElN
	PNf2osAQGX5liRnbosz/peiKLTT8LMTPJzpDLTNLcoDj6mbOHJgg2ZkudqQ2Hsr3
	ostYbh8CZwNPZ5AZGlxoq0sbd7UnbWWmUUdsl7ix7WgO65dWfW+v4y2MmUYNgM35
	c3Dti91j9QzARgX3nSAqpTpksqNtifqjKPXimfIlmG0m02m5mAcEuDnZGlAYMEx2
	hbCdNMAz6V8BrIJ78/EiktQRqyclCvpt7x6K1FCqZ+1TUnWdu/thRuqE2Yts85QB
	Bmuf8GAjrbEhwfPykeX9+j4f4E4k1R7BlVIaGvfZ2Q==
X-ME-Sender: <xms:YqkXZgaNpsESdHy3sIuKyQ8fqVrJA60yhiIu1z_Fr2OJkhuVFmV1Sw>
    <xme:YqkXZraLG5TH4U9-6CM3y3ikmzEGXGOrWOTG9wGXEYFe_Gs4Am5wngfEAOi-9mzs3
    HigN4qGYLFNqCytqQ>
X-ME-Received: <xmr:YqkXZq9YaGbiUmcdn-M7DlQ2D--cb_qOPDhQmAloBhLzWLhSmMVT0VZAUzqK3tuDBJRd1ZbOthJmisLw751EUHYIjgaQF29SZ0lojdGeF4ajqc1V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YqkXZqpoUiIMLN6sGPuV83RGRp4-La2SoanV4P6vwH6XU-xiubX7xQ>
    <xmx:YqkXZroQG8yDKRnlCbIn7r5jKv589IZI2Va8D63P9IuHlDJ-OEBYPw>
    <xmx:YqkXZoTX63ARPccslbhCElqh4BWGrwyi-nX32EBAoCBvT5haxdWy-A>
    <xmx:YqkXZrrsWJDmh0QTl_-Jxk5s3gvv5gOxzTRvkNV3JhUoYEQTTKVk_Q>
    <xmx:YqkXZvfKKtiLWWqPtk0sHh6k2tWNhKkjVt1mD59Nn0jQuuwqiZCCQ9f0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:12:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c95de4bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:11:48 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:11:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <avila.jn@gmail.com>,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] refs: keep track of unresolved reference value in
 iterator
Message-ID: <ZhepXm4G1OJqo6jq@tanuki>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
 <6adc9dd26da4459d246591ce148c960b33bde336.1712597893.git.gitgitgadget@gmail.com>
 <ZhY3SUdrX2WifyZf@tanuki>
 <xmqqwmp5xmqy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IHVpapRclYfsb5gz"
Content-Disposition: inline
In-Reply-To: <xmqqwmp5xmqy.fsf@gitster.g>


--IHVpapRclYfsb5gz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 08:26:13AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
> >>  				    const char *refname,
> >> +				    char **referent,
> >>  				    int resolve_flags,
> >>  				    struct object_id *oid,
> >>  				    int *flags)
> >
> > I wonder whether this really should be a `char **`. You don't seem to be
> > free'ing returned pointers anywhere, so this should probably at least be
> > `const char **` to indicate that memory is owned by the ref store. But
> > that would require the ref store to inevitably release it, which may
> > easily lead to bugs when the caller expects a different lifetime.
> >
> > So how about we instead make this a `struct strbuf *referent`? This
> > makes it quite clear who owns the memory. Furthermore, if the caller
> > wants to resolve multiple refs, it would allow them to reuse the buffer
> > for better-optimized allocation patterns.
>=20
> Or return an allocated piece of memory via "char **".  I think an
> interface that _requires_ the caller to use strbuf is not nice, if
> the caller is not expected to further _edit_ the returned contents
> using the strbuf API.  If it is likely that the caller would want to
> perform further post-processing on the result, an interface based on
> strbuf is nice, but I do not think it applies to this case.

When iterating through refs this would incur one allocation per ref
though, whereas using a `struct strbuf` would only require a single one.

Patrick

--IHVpapRclYfsb5gz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqV0ACgkQVbJhu7ck
PpRKkQ/9E+KN9QKSB4BYASG2EUFfaDLv5naQCsFRRAGqIdE9usIbn7eb/hrZV4Xl
k/1WpsQbDr/cVSrvgOAefF5ajmEFuse9tfylZAFvX3WcFcLmbLhPtQBhyCa833bE
L68NVlG9W26o0arXSHFZgSQHGdT2VSXGgJS29lEqwJfvi2MUC5ZZ4BiU+bUqDk/2
Ec2YzWYWpn9AnjeQTBx8sNKZwLefYdjF4/fA+fTPRIjzzPYl3zUbytaaTZB+zWAX
XDy8AGHcf/xMSx5lIMLqXrHpLNhvt5WIqYGQqNOgdzZwl1ZDozRfpIc30SqLsybn
ofC5N+qYXzGSWWltZmOc2+APwFs6rJlzF+S2PTP6HRW+2kbtH0HK4JXhPNQvSfnm
6ajgWFIhbPgjc7B5VJV+7QdOZJFd4Qm0B1FU6/HEaigncjJ8m8AFe9CeElcBO54y
3qKOwaQnAHsRk4d7LF6GNDCrwP9SL0RVDMecXcpVuTYoshjpcgepPx+ap9XlS6bP
iv8zpTdP2vELAWPxDpj2UcLYdNS3h8hL2PXx2oC7VQutTP93fLQh96oyNU1KoCWz
GbMBFKG8yXWxM7cLzieCEmSt5b0Oa4pnqEDbevR7iGQuAwG5caEwZq0JqezwSgBR
SkjP/btTYGbNSb+E+cSiVlQH30UhUqVAigVjub9whRZUFcfGLhk=
=rCbo
-----END PGP SIGNATURE-----

--IHVpapRclYfsb5gz--
