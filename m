Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F012B95
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721884225; cv=none; b=W5lo19KaIJWgDRC1yUZAS+rB+JDEhDm9zsVK16HNUhZ7Sr/wHI4wri4h6ohukUpKAbFPkyriRwpuIXd3CjGjrdku8bQ3ESrS8yhMpoEArRKFs26CRoU+V877Z3uxE0R09nc3TYLtGgNAOQ9uCPpcaZkDwOeVPChnJg9QccAZTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721884225; c=relaxed/simple;
	bh=iSbdwkgPSVCIKFT/QiIgR/Fd22JIzIX1DNQYGbEu+kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb3BYegU2E0QXkmnK7a1G8XLzuHSMTCXSgrOJWI2y2k75wg39HIPWMe//AQxNqdNGeB7JAzY62gm7mMZaEzNyRVmViYqoF1D+tt3u9zZIcysrPIW76hnicj+WwDv4RQJ3t9lrH9/3LweahCldKPieA00m3bsKasqWqDNNL4NXFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hzeasaaF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMOUuVy8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hzeasaaF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMOUuVy8"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id E2C981380728;
	Thu, 25 Jul 2024 01:10:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 25 Jul 2024 01:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721884220; x=1721970620; bh=Ep0YlT/VlN
	HHLM03zirbBp7ww9swvpHDn4tDOkV0UGY=; b=hzeasaaFyE8lkSeTlFzZWLJv/U
	iYAR6pF583WK3/cfHiEd+SQ+mFqvgSa8+N4XDgAfwxOnTZhxMBbcRb4i+qOfkrUx
	TS+wdwQac+23vVkXC2eY9rvkhS8Ov7F8+YSUE9e3rQpi8D6uBv1XSl21pjfoR9Tq
	45s6P4F5qh1csKFNsfJnSzSqIk11V/rLvkDTouACZfxGKfeLqC84loT5cSyfMUz5
	Pb+J/wo1WIFfSxVgmNDhnbnIFjcZ+4BYUD2Dcc+BtAFwWZNIYO9t0hkDatPoEr1C
	PSGVu9gTA770OXVpykMs9xQt51rLAfjkDmYkB4whl5PZSpclUgzw1PrslBPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721884220; x=1721970620; bh=Ep0YlT/VlNHHLM03zirbBp7ww9sw
	vpHDn4tDOkV0UGY=; b=iMOUuVy8n7Vy8l6pJOokFIgTzlGW1Hw9ZtOpchDJPv9+
	dnjmgo0LlTr+GumgytAMl8/yYZki5PPOSsAdObV3eiNtJSeDiSN5nU1NLziJuU1e
	l2Ma9dS9F4xEg8dvzl3uUytWuOH2CCBac9MTJbyzw+aQPJCV518KODsgsabIRkia
	gDaZwB0QeRM9ymrVmAYah1SlmraroGsgPXGQ3QZk0KYVI+bO4WOXSB4OCI7tf778
	MdSVC3zs5MuXMOg1CDz4ZbOqCstTcknbaX5ujiFMo3P/AN6Pho1dDhoszFVCn/d9
	GN4Sg+fItp+SgqivwZVaZsrLjbFD1YQSMt4TcuDhFQ==
X-ME-Sender: <xms:PN6hZv8Inw04WbS1TdzJwAZsLtfRwYOPlb0blWfQP7OF6D_GNN4C3w>
    <xme:PN6hZrsK1mMi3_a3wbX-H8vn5mqywSxantocJOqM5X1PRxtEl6f3jxtFREoMlbPT6
    b_d88vwsktYFzdg4g>
X-ME-Received: <xmr:PN6hZtDritV6XD4IX-gqZuGPmlEuHgD3NOiJ8yy5raTJ8lSAqOAx-ttEmbISjo0XViTGz5lSbJzv65-QQo6H--Uc9kGQbs2mOlRpJlwmrg-xfULT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedvgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfhffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:PN6hZrezpsTM6focsyaoZnUwg5LVehBb0JwaOZh5G758LASAIDp4Bg>
    <xmx:PN6hZkOzaBsHrhQ4UOstqMC7qFnN3mDRQG9AoVGbt59wJDQ2D7ZbAg>
    <xmx:PN6hZtkhTZlFFZj5uX0SmDhaAxP8_vYglRzINMhhCPCOQtIGdVGO-w>
    <xmx:PN6hZuvw6Wb5mqo9wG8zAM5rTu_gfv2CJ_cYyLvumlCwei-W8kNikA>
    <xmx:PN6hZhqSsqwboiwWbLHXl7DswZx7MiwrLvv0MsAdpj45xGT0qM-VwSMF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 01:10:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b417e484 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jul 2024 05:08:59 +0000 (UTC)
Date: Thu, 25 Jul 2024 07:10:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 6/7] t-reftable-pq: add test for index based comparison
Message-ID: <ZqHeNnYrJneUmPTB@tanuki>
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-7-chandrapratap3519@gmail.com>
 <ZqDDS3EhXwDittDr@tanuki>
 <xmqqikwuydek.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="10TtioBgTABjw03/"
Content-Disposition: inline
In-Reply-To: <xmqqikwuydek.fsf@gitster.g>


--10TtioBgTABjw03/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 09:15:31AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > One of those reasons that we use the modulo-loops in the other tests is
> > so that the order in which entries are added is mixed. Here we add them
> > in priority order already, so that makes the test less interesting. We
> > might thus want to do the same here and scramble the order a bit.
>=20
> Wouldn't modulo-loops mean the total number of elements must be
> prime with the skip count, or something, which in turn means that it
> is harder to test certain corner cases of the underlying data
> structure (e.g. "what if the length is exactly a power of two?  A
> power of two plus one?  A power of two minus one?"  etc.)
>=20
> It certainly is much better than just inserting in the priority
> order (or in the reverse priority order).

Yeah. I am not a huge fan of those modulo-loop as they hide what the
actual test data is myself, but they are already being used in those
tests anyway, and that's why I proposed them. The better option, in my
opinion, is to just make the test data explicit by for example looping
through an array of input data and inserting it one by one.

Patrick

--10TtioBgTABjw03/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmah3jAACgkQVbJhu7ck
PpSdYQ/+NxSA6fBYUomCRQj2ltsp2IanRi8gmKLbvNcpHTowt6uP3vl9WE1oXt7T
slZwxwS5q7NO6CYg7YCByIZMg6Mj/8BWax9OBOoz/JelGwom7AF3GHo7ooWt19Fq
gKS//QUfvfVmdMuo3NLyXyNJu4pT+iP+tqDiZKFeilsORFYwHWK2m4KCA4qNSRHT
NXedbFkr7ppeOKPOk//XRYyP7S2NANNDJBRse3IE+mzDjfDFMl+j6rjV1gUUXVP9
r93X/bPxb7KI2w5qvHyt68qYMZLmDVg6/cS3QD/9KJ05RBaVsGQqUwt2BuxCzfTN
I83gY/fV6LX1dHzMk1Dq+KzNbtbJgv4VU6/VPd70LED6PTaTjK/kEtVSMViVwbHT
v5Gcw1p9FvmTnvwauPf8sRkifg5VwN9EsC4cKqP3aTr+aqsT18tizSkDdXCcI7cU
tCS3qvzHCqBSsMnOXDnYuaHLIcc1hHfOBsl9tKb/3vJQ1T9VT3SvPlVTNk2ZvxCp
73uwYKBHTqhnJMGlIFBApQmhVgX8BvfPkFwFYNRFdmr6svy8aI7xuR3APUfItK6H
aHQ4KQu9pGy6iY7MzsoK8oUfsd3m/cms1iupTBIlT5CZANmoNlGWFNZPGt9cQyLw
u5Kv7wrNG1Y/z9Rfh2V3OcCSTTEIK5b64WgMWX95at1G0T3UxM0=
=lXgo
-----END PGP SIGNATURE-----

--10TtioBgTABjw03/--
