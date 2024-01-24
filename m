Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBAF17988
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085729; cv=none; b=WXcqIty3cE0nzFkqPGgrtHTFL0/l+hsTAK7J0n6qQ2B7nVXx7Sw+EXeTCNz0jbsis2viOYUnjAiklf1e0klQtXKSfgvCnbOBwz2p+uGfgQOa1v87351k2c76wnBG1ca+y3XOzbx/+Pzxyatx1UIOho4wQWt1k254j0U5V5iTH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085729; c=relaxed/simple;
	bh=UtGkEqNTXQkbp6VKkNz+FugnBcdddT5HDSFg9zMQA+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgAwmKSmNwnOHAUS5V/jQKk3vabMIILoKIlsOcrL7PIBteIx96gk785C+mRfNFdT8rrWvwJ2/UMWcDFsNjJXdyUqs9SPoieHDGILpBuP8pqpw0uXEBQoTTjlwDN7LaVFZJg4HWoAishXMJ32YZY6HMqtYYHtdbx3PcuYoR30jTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HaldnE5v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nN3q7Nlv; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HaldnE5v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nN3q7Nlv"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id A871532003F4;
	Wed, 24 Jan 2024 03:42:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 24 Jan 2024 03:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706085724; x=1706172124; bh=a4hC1ctIqP
	0cwNJl1gRH4stj6zD6WcMrOIA2t4QENkc=; b=HaldnE5vxrsglasCvWM9xv4DWz
	Z/dFvr2Wxqn9NbS2eqEWOyafdSEBbzBUDac3D+ZECEhJKaQuwOt3nF6R5EhMU1PX
	5MAm5mppJVyb3V2c/MHiQWLt4LXOa+z182FdSCm8F3O5CoU+qm1QqdL3JTJ3jG7C
	tvJh7PqNIHTI1NYFsbswO+0wBq+X49zjQcxJgD0bd2QmFq+oyTi8JI7jlFBrD1Gr
	T3QgBstb744TyykZFmh3cThaKsdnKCRqUVwLMorl4iLQgpIc7KuQwUcCnHokGnxT
	kPMRP2ofkvbR9pTl1Q1ot1+bAClMccJv/RclXlPLXuGjzEoluFOGuN9EMQZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706085724; x=1706172124; bh=a4hC1ctIqP0cwNJl1gRH4stj6zD6
	WcMrOIA2t4QENkc=; b=nN3q7NlvkuhMtivrqmoBqbN20s8rqkB2rWO/2K1ek3HH
	JhVfBhx/LoZysqIHHXzo8a8pRbqV/NVSQ2j2n+Hi/INGH4D+yfjSKoO/HKt+Rw2d
	noA4GGHAbsgTYsuZpT2UMCuaWeBaNOInOF36qmfQft4J3+LH7iDYBr/NqrAVeCix
	10s/F7RShYWlzwll1yKTXofBeuKwP0wNz9QCP37R33c+A82ULJj5FHy0S5z2UiCd
	gnK8pQvWfFqTTiLz7cb1z8bfIGFGH0J0v8VNSGZzvhDlDrkU2rDqF3RK0V6vJb5K
	hWTCIgorghG81spqmQD975h5H05DcOlMULxa3hSHVg==
X-ME-Sender: <xms:XM2wZYXhORP1cP6JWfxSMIxYOzVkH560y9IGVXnaB3MOWco35lwQJw>
    <xme:XM2wZcmf1LRR9YhnSGYQ_SVSqBE2kvrF3YuIJLeMKnALd6JkVnA4PHKb7PrUvjOID
    eFiljOc0dOhFJfMig>
X-ME-Received: <xmr:XM2wZcb2wpgG0oQsqimG7Q559loJ8kjoINR_dNNwSOt25CF9fRfuQJKaTd7ZfpMO1fxlaap2ZU5hthQL8oQ8-AM6jAfcE_SE50CRToQ2vWeyUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:XM2wZXViJKzhrQjmBXqoiaaU91VMWKfb8-6KICQ-lssbORRSZcdqGw>
    <xmx:XM2wZSnOEnLsdeoPFrILhVAnO_aimR3Kp4a62wX_T_wnGfHwjKeQzA>
    <xmx:XM2wZcc57ZNQerv8t5dD3rOgwa_MDpNVY0UYFIIhb_B5nbKj6JxWKg>
    <xmx:XM2wZXwXMGKkExpN5X_4iqmvCwUv-1tjYHZhA-P6hPWpIMHbrX9NGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:42:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 730832ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:38:53 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:41:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reftable: honor core.fsync
Message-ID: <ZbDNVouHgr-J2ptC@tanuki>
References: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
 <xmqq34unn8x4.fsf@gitster.g>
 <xmqqsf2nlnxv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cq0shnfyC78GeEtW"
Content-Disposition: inline
In-Reply-To: <xmqqsf2nlnxv.fsf@gitster.g>


--Cq0shnfyC78GeEtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:50:04PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > A comment and a half.
> >
> >  * Can't the new "how to flush" go to the write-option structure?
> >    If you represent "no flush" as a NULL pointer in the flush member,
> >    most of the changes to the _test files can go, no?
>=20
> Nah, that was a stupid comment.  These are used to populate the
> members of the reftable_writer instance being created, and it does
> make sense to have flush_func immediately next to writer_func.

Agreed (not on the "stupid" part, on having it next to `writer_func`).

> The part about using NULL as the value to say "do not use any flusher"
> still stands, though.  You do not have to expose noop_flush into the
> global namespace that way.

One benefit of explicitly using the `noop_flush()` function is that we
make sure that all callsites that should provide a proper flushing
function indeed do. A `noop_flush` in production code may raise some
eyebrows, whereas a `NULL` value could easily be overlooked.

Whether that is a good enough reason for the additional churn might be a
different question. I don't think it's particularly bad though.

Patrick

--Cq0shnfyC78GeEtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwzU8ACgkQVbJhu7ck
PpRzjA/7BANB0JC0UUPVGxr+ylj7gXGzc9rqiKSnToFFIrgG2+HKvWnfm3KpbPbN
7X5i7x1HeX083Mxf/UQSitVXQ+XSgQQ3LuG5n/5fDcq0rT7sz/av/rvK0waME16D
zqlQFOGQU9egFAO6JMl0X3SCtTOIg+E01CZgpBwGBtZvYvjLHfAd9xzfuBmZFUxc
JYzl5JzKz/c2UilbASfUkqNIA6s/XfR0epLruqXQkJ/t6aGENq8/qUFt2h3ssgEm
gkg0+pPzLGiYCsQChn7p/07bM4e/RmKuF48lPmEuNHomISoI1YmCVbDIjwWTldAE
iJWPd1KvF0MSIDmlS4wiM+8Uf51yn9sbTAAyf7xSEIHGSBy8K4dYr0U457A81kCI
XRfNZEzTT+MamNbjQyHuwgb5GV/NGeCph/XW3nFIQliqbave0wJXPdxQFEeNO6zv
ISL3pY7wBhNEe6rOQo6/Vhggwrg4WmOm/mrQNQJQXgcpCX+ONg9SJ8oEOvXEDkF7
7Fj3rGH9xK/5yeBxJ2NjT/Pk7VRJraOSN5VNPo2vWUUlmMKFrcc9OAV4U+Apcf1p
SpB83CU1ppXFSj1DF1wAv5AcHxGvkVOXHQ3eozHWA5dvGP886vAOwUh+FDhUzNyQ
gW7TYSBPUb/ir2mVx5kIlNrgUqlXXwCzC43fvSQppsn0VWI0YEY=
=PkjR
-----END PGP SIGNATURE-----

--Cq0shnfyC78GeEtW--
