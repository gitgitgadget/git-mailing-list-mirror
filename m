Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3FE183CA5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504713; cv=none; b=WZPX+ISsAmLeV3YJoV8bc0LB89RxumFtrqTetBzie3C+rm1IbG+/kBh0SYtN2bmJvPWOmCfPFLqoY8+wRMDJazOMZv5wJ5YdH6rLnrcE7RMtOCl74HrqBfpfUrQhfgMCzWcKLtOyoRb78K5iVjXci5ekSG12MovU14tx6O7iuao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504713; c=relaxed/simple;
	bh=54vHaakJvy4hpbroVerEgRQpdt0uIwP+L7ixkiim58A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixI73/wT5m+Os2tS66oFHAhIIZ3aW33iYTuDCUY1SFN88wO/ixCoMOHu0UTggcMVZH1ZKqoPuD+fPgGC/1zw1cIOq6hwmwb0b9B/vKP0G2f8O/19UmWRtKvcldZneCvfy2nYGR1BO9aqyt9LEO3kOPIngT9K+By1+Wdit36hl+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nCqLd5RD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WRYDsk8S; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nCqLd5RD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WRYDsk8S"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4EA031386991;
	Thu,  1 Aug 2024 05:31:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 05:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722504710; x=1722591110; bh=qQ7+u6b+4l
	SaQeKT1sheuj8/2zyyXJ+mjnzDBL/Dnt8=; b=nCqLd5RD+yj27qRtnIrPN1Koew
	xuOoRgAiSP30FkVVlDA5aCZ6L96Wq4XXH3GWGZQ4udqOlEJP8oOzFH1UA9VADKza
	sF/XxgCtPBLs1ekvPucAwgXU4MCkYhdO6eyIgLjVuGAvJJzFQ4B529gDS+HZLAXG
	J7vbrzZAnYjU2mcwk0Kl77/QoUtf/Bh3eElWa02VgYGTVnI4mxXtfgdKuGcuviDp
	avSbpUu5QzhuVYqLN+DCMlxbdeK32gVdWU19HTE1SAEInIGBjevOV4BnDTKYSPDC
	E7eaDAaZfcZJEeS5vtXHQJrteV7yefPONWMYOgfogbsG4xc5VxRfU/rld+wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722504710; x=1722591110; bh=qQ7+u6b+4lSaQeKT1sheuj8/2zyy
	XJ+mjnzDBL/Dnt8=; b=WRYDsk8SCPW4pgSE/UYa6s+sIT6kEamQqox1ForiFhkL
	wcZiWp5MbE/7GNF63AH7UOwlshpk+RcMhOYy+npTAiw4uw0izYES+nvM0yFR91VD
	BP54BNVMhKN2Yj4+iROAFipLkrStugliFpQf4eHGLUM3WvlQbwU36oafdGnkJC+t
	H/49Wbv/VvvFKCWtJziLRz47j1ExQ9juBCnGG6pcdzW2sFYp/IXN4Tg2BruIz5cR
	ecOAnqoLa7jS7/7vxYasV34rohoTM9EofPIKEZKiz1I8C5gx9EQTYesYWdKeUpj6
	uXBQ5B+89Jr95zPGQFkXsl3kAm3vzDnjG+E1BveRgg==
X-ME-Sender: <xms:BlarZqWY_vaj_usGkX-m8ez-Oy5XM7jyDFnKya6CUq7zMj_H6h6q_g>
    <xme:BlarZmlYnf1AiFTQw8DTp4bPUfd4LUU34NXNnECe6eS54u_WaXg2TNcGB95bPYoHn
    mE7_RXlrti-qNjWHQ>
X-ME-Received: <xmr:BlarZuZSmd8ygrj9A_PDSbtC33ro_VJTDzhEjkTA2BT2dZ6Ao2wJuhAxWo0yrc5KvdNZIQF1RpW4t0LYeFBDprXVR0jsQ7bAHGLShiTJ7Xu1MgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:BlarZhVcrhk6hfvmNbq9fmJ_BGNld3VeI651jtzrkHS8WW8vS9Aopw>
    <xmx:BlarZknXl-tVJVVcT1NS6Ra1GrquQGQZ00TmeHsHJAsAcOiu5vdbcQ>
    <xmx:BlarZmfcRAGWgq5ZQO4tlUm6WCGE9F9BFLZTZhD8C_fSf9sV1DqyFQ>
    <xmx:BlarZmHz51tfHeC6wkMd2SaxDrxi03Q_uq_Dr_EvdHROT7FVJB6wFQ>
    <xmx:BlarZiZxB2otsuec7h63E40dYSzdu7ARL6oFUQFEidaZGu3vHlHnyAwi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 05:31:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 761c563c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 09:30:17 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:31:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 0/3] Introduce clar testing framework
Message-ID: <ZqtWAvbX9jwYBnWH@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <xmqq7cd18srf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tVIbbiUXPcXq4SAJ"
Content-Disposition: inline
In-Reply-To: <xmqq7cd18srf.fsf@gitster.g>


--tVIbbiUXPcXq4SAJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 08:51:00AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >   - The clar gives us the ability to pick which tests to run via command
> >     line parameters, which I personally like more than picking the
> >     specific binary to run.
>=20
> One thing I am very unhappy about the current t/unit-tests/ is that
> the GIT_SKIP_TESTS mechanism is not effective at all.  If we can
> wrap clar's test selection syntax inside t/Makefile to work with
> GIT_SKIP_TESTS (or its superset equivalent), that would be a great
> plus.

Yeah, I guess that shouldn't be too hard.

> >   - The clar replaces some test assertions that we already have. They
> >     feel a bit more mature, but overall there aren't all that many
> >     assertions available. If we wanted to pick it up, then we'd likely
> >     have to add some more wrappers.
>=20
> That is a slight bummer, as importing an externally developed one is
> with the hope that we won't have to enhance or maintain it, but
> we'll see how much burden it will be.

The clar exposes generic helpers like `cl_assert`, but also comparison
functions like `cl_assert_equal_$t` for pointers, integers and strings.
If anything is missing, it also exposes the building blocks to add
project-specific assertions so that it would be easy to add for example
`cl_assert_equal_oid`.

One thing I have been missing is non-equality comparisons like
`cl_assert_lt_i`/`cl_assert_gt_i`. But adding that to the clar itself
and upstreaming it should be easy enough, also because we know the
people maintaining it.

Other than that I think it's mostly fine and should serve as a good
baseline.

Patrick

--tVIbbiUXPcXq4SAJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarVgEACgkQVbJhu7ck
PpT9WA/+Nk8V9MCkGUv/p6unGaVuePfF1Y9gS2uFdr4uvi9aztR5frPRhdN67B8d
ce2GOHawJ5TdYP5ujptNEjVAB4qBy/U0G3U6tVWJgoRLKwOJqtlEw8Kb7G2KCrdG
/8dqmjQKL6sJfc97zQMujs+MLfPM7cqd4eus2fUqvy9RnXOzz9ryOOxtmu80asIu
v6YCs7syBaQDkmPWx6NPObWKCYjdeg/2Ms4ORoAk4CAnut6+aK7RixLQd7upjNTF
chPJy0FR0mrKzdSP2A/dNpqkfBIXRjpVj4nZ4R3mycgvgBWgjxvRiy2NeWUlna8I
6VFX26z09fKumbydvfl/TANqkSIso79wAxhxQXXGBSiriy7YqZnLqscTvcgUNxYg
U2xXjDYDOYeEwFEbcANiEov5zFgIZPCQO94C38MOqn/PognTkdcTlFb56ghgWrh5
NC1xnzj4FQkwpv8p/uHKQAX8Bu8GH7NX33jP0Vvj+26q5RqWdMBb6FUMQ6T8jNPo
iM7H3UPaXehuExi2kcB7D1OeUTSsWjrCFKjvIjO9AQE7CS062mHgKZ4nOEgPxG5m
1oMBjS+3mYyUlU5CkyCWqSRG/mqLy85qNvhwM3eZRDY1mHbeJDDvwb+OiHcveY63
yUw52UPF+N5eBrQJKsBi5kVKHCGWrmDO40NsLUL6GCta5xh3hf0=
=ki4t
-----END PGP SIGNATURE-----

--tVIbbiUXPcXq4SAJ--
