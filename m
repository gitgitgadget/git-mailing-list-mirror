Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2C376F8
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549333; cv=none; b=EIqZNmAcKzHLDm5Ih4y6IaVVHkVAcniFadzi5Dn2MR7bYFbmxrtDTbML40VT6APgjtmmKLYeL4wxX+b5pJP8kEtvoHqjNuqRIRO2MG+qbkvmZkWTodve57ATRc7DWcQlivZ9MgHbLC2N8C5H0Z52Evkprm9ROuyfCOEjj4q1FA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549333; c=relaxed/simple;
	bh=PI9F2zHjmqZtYcxgwr14JmZrAtFJtG/tTXJQXmLzZig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP/8ymnx2BRVtuyezm+alJJBc3c6nfusMiUANJYfTTRBmrd7rYhG+HNZKZUtC7bRH0e69vEu4wu875cSDYAmztouYyRSqWkKcpXWsmgm+WKYXxfVPqs2VNKEB6gZbd8vtI+HQbs48Mo91ydwmnYLF8zSNpvouhayz2fYc7hGvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rTEFRewO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fERqxe8i; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rTEFRewO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fERqxe8i"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id BE4AF1C000A9;
	Mon,  4 Mar 2024 05:48:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Mar 2024 05:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549330; x=1709635730; bh=GO3jA8OnA5
	aYEUHVXhm0MtQ4q0T1BE1Ho5FVbO1zNXA=; b=rTEFRewOwNRv0VljQUfn6mZGLO
	Dtx9aRxUPIOOSf9/grzcmCmjI3AMVyf7i9ASoE7WEpkkeQJaba6KvDS/4c7EW68r
	5QzTn0Ucr619jWKh4YHs24B14kqO0IIoOt1wEqDPX9EadM2DzjoOdB16rEnXWAMG
	XlCL3BxXIHgXOFRRMqLvEdQdOjWAZh70pupkm2K7x9ucipHknPPBB3svhPJBZcGu
	xybN+8a6NtPxcxeHtnRepuz20/Fm7uUA3U3DZ16Rvs6xok5Id9UgrSKJB9FAub3K
	syMpefMi/cPNkjFCZ/8PHd3jT9UGLb7s0EY6eGhZP0dAz9PN9+j8v5uteDZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549330; x=1709635730; bh=GO3jA8OnA5aYEUHVXhm0MtQ4q0T1
	BE1Ho5FVbO1zNXA=; b=fERqxe8itm1Xg+bpR9AEmOHst2fZnDwMPkzChQ8Ek0mq
	DHcl6q2dW8U14HaU4hNVJLD/Z2yBWElMICn+vZqytH9MVqs4iuOQwyVr1D6ZmTjF
	OLmc1jgdF2OQcLJhWkslpWmubMn7Tr/++GvH7hvvD5NMmOy21zHNPkoeqi7ZgQL/
	L9H+zscG/webYCLqcDmPSHg5tiir3/zjKnw2+lPcF1seJDUWFe08WfAdByfnqcql
	q/JMV8dY8Jh9iEzmnkckg1HarQ6XPrPexd9hmLgy+AgplIyQcERflleTQxLD3Z0f
	0v3zTI8KB8yeWuw+3NLfqTStjEbdF8pLFBS98fbseQ==
X-ME-Sender: <xms:EqflZSpPr6brCzDeyHDfEc5W334kl4E-a2jKo8I1nXHQB7mRYjwWRg>
    <xme:EqflZQqNcii02gk36jK--TG6r0PQi8j3JpsRJQ08CPvYLc0EtFxaCQAW6f8359xOO
    zaEZJ65Doqw34GSAg>
X-ME-Received: <xmr:EqflZXNhFcyK3faFmvm-PYvgbHy_soONniWGKzj6L88J60b5lDlXIngHDOp7hFxYHUWcopP4f7oyFtwxcfjhD5KMMWbqLNySs4zwawNffabID-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:EqflZR48j-9AElFX9K5sAhQ2s_D7ZowBzM0F-mLAwBdXXaiSck2tRQ>
    <xmx:EqflZR5R61ufa9FFdLUUE8gcVVPLytEkW3yhzhOW8dK7LE6fMFi0IQ>
    <xmx:EqflZRgaodro6dLx2lgDcIh4BTaYcEC3BI_9D7SDz2VBPI3hpfeOUQ>
    <xmx:EqflZbmqGdE-pm0Nq6ppUiwROHTsVzW7Vf1kZQoMH3qalo0ASR4PLH7f7lc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:48:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a9d953c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:44:24 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:48:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 01/13] reftable/pq: use `size_t` to track iterator index
Message-ID: <c998039333739d07ed2c68c5bbedd6129efbd1fd.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+2JCke/3VeV4AY5R"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--+2JCke/3VeV4AY5R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable priority queue is used by the merged iterator to yield
records from its sub-iterators in the expected order. Each entry has a
record corresponding to such a sub-iterator as well as an index that
indicates which sub-iterator the record belongs to. But while the
sub-iterators are tracked with a `size_t`, we store the index as an
`int` in the entry.

Fix this and use `size_t` consistently.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/pq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/pq.h b/reftable/pq.h
index e85bac9b52..9e25a43a36 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -12,7 +12,7 @@ license that can be found in the LICENSE file or at
 #include "record.h"
=20
 struct pq_entry {
-	int index;
+	size_t index;
 	struct reftable_record rec;
 };
=20
--=20
2.44.0


--+2JCke/3VeV4AY5R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpw4ACgkQVbJhu7ck
PpRUCRAAgSxzAShkm+Bje25haRqA5fUsnCLuL+PKYxn4EKq9VN2msypvSGyUIl5D
ZpR19wN63/u1U6zXb3qYISFSU9fvP3yzO7PzI9RZ28w1nutwL1JTvvowgzn1k5We
Dr3eBpnXJrOpI4r9vw6XvzY/s0/VM5UrOyrEt+LkOEhzNSuZ+6s1oQPXscb/qyp7
xgJ5mY+kluM7dNdz7JguEKUPV7T/DFX0bk3BN6MOyM+/fl8FBO1ZWUXgkL9ktUaD
K+j52NDtIczKzw1hULqTghbsKx+zw7LaZfRMHxOOu7Xqjhk2hgXGpyIIMdf5TH3F
63abdG58J7bPiVaLUd0ai8o5js2U7SuWXWsn/7wlucjzlxm1JDWxScHPYedjAg9U
IYL/5k7oIPQD1dGG6eJzjArTOgUNdJsHBcmk7pgi5BlhgRn75pLhVMdCsG8IweAf
JufNCU/14MVOCJ8aXdJbB8bzdTYxO0ak1r5+KqwHwLMTPhwPaXSN2g23SKLk+zHA
3KKB9L0rpF82J5JfGfR32sKXD6R40beMPi9iapE2Hm/TOxoDX7xxQKvY/F2RDayU
UhoVhsBr+804/9P1ibRbSDvOFjE9BJ3jNGVnNN/kH1o4RYGLhCUspXMlCHo/cP5A
gnmOpL0two/NMAMCQ5xhYIp7CAWtKhf1in0VCVFmhXIUuAwKea4=
=/Rqw
-----END PGP SIGNATURE-----

--+2JCke/3VeV4AY5R--
