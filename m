Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72C13C673
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670172; cv=none; b=rA7Jrx2+aqxK69rzDpVjeudS82p3WUJWM4mcYA0ZPhOHvrrizjTamXipaFPms5HqaPpRLhZjUAbfsaJzZH5MntDfPuapwaTR934VO+IQBtagx8TZqpmkssOuqNteFCwXZ4ciiA9E4sYreKmTExpEvrAzx18lJk26LWmqZjRpnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670172; c=relaxed/simple;
	bh=uJwNTcFLT7KI7GJXA91C2jbopRfE0vKk/3+EdbsYDI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdzWfPuH8eOTR/MRiGKe/hmc+QI4QYPGFPWlM7kRG9UL1tiLFO2RtRk3CU/BVPUT4uFqaD4nLkOH/KKl0SaT+5LF0IGK3E5yjLRIhbkOhW/oOmNOILKuNMrV553j8woDQHc2xZjLlYiHe+B1pHc6NCiguqvSuZbuHz9Q7XtJuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZiRMWKIe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B9VnWV3l; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZiRMWKIe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9VnWV3l"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 58E8511401EF;
	Thu,  6 Jun 2024 06:36:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 06:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717670170; x=1717756570; bh=0s/1pwF4H+
	lWynEIDD2cw8mkJUONZR63BsL6P2lG18c=; b=ZiRMWKIe1pZRRwGUx7Cs1/jkCK
	c/zpMVLVyqQYmCO/ncRNzjeuwh0ZmUhef+tpIP0WNPp4jhCTrUYqWWtaaZNymQ32
	4sxmz8otWabH5Sa1YQSFDyVPbp0puRnYLlvpESSi2Z4eYGjTkRX1sRyfNUtcxEyC
	spRPrIrVCbEtrzGz0n9YYwRqYm0gtCPtQNCqa728ZmsymlZkClbkdOn0JOjFrQ7J
	enK3umWYknMESxJkeVJl3kpMYO2NIjAVBAGMALIuJR20Kkl/mfm2Uwu5GZK7jPsG
	VI5sacE3geRghXWKsLvjw6HoQw1zhPPldcOWltCOeL+zGtjMXFbq88pEn+6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717670170; x=1717756570; bh=0s/1pwF4H+lWynEIDD2cw8mkJUON
	ZR63BsL6P2lG18c=; b=B9VnWV3l4my4IJzFfjzw1wMAHyygmisBLPVF2hWFguXy
	96w+RoDE0s7MP4lwlmKEdcdzSTedO14UwJ7St5rAe8gmlKRHhOKaV02Nhj/SEuNA
	BtObG23R4JWUSWrLt+dgJ/7HWjWV0342L2tVqDA7R8M+FzAmkbcwlpE8HMZyo3QC
	p9A/d3/BzjmYsbIslhGqE067OGVL0KcKNU/npbbeAA2RDTibZOcLwyO9T0zSKPYV
	v6oJeMVhP5oYhwYJyq+hWWZouTzp6J1wdUq0wWwxNMZy7MZRm2k6gSApzJzXgzR3
	i0kU8YBhXq7jtV3GtNa5ZEYDfVgGhIVUyy9ZaTAfvQ==
X-ME-Sender: <xms:GpFhZv1C2q0SQAqi3BQfhvgAHakcpKoXbM3z_bSl7fDM47fVVZYucA>
    <xme:GpFhZuHvT42iBg5dSW19PDk6jgpIxr2LLussuTVdM6veIg5gIkweFLZyQjDcHEHfM
    s-fq_LOgtk5vnkJfg>
X-ME-Received: <xmr:GpFhZv6gWTXlg6bN1qY9Gi14iAKYoUPTIJ_UamY-6Cjc7dvFlfaeFAkhPAOhqoH7RHhJmSQ6zkYv1G3ph1zbuv5VA00wWSFKlj_25YLP_osIm0IB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GpFhZk0s2TAym5gNyT8-gapkHH0l28KC6EKIVXnhJBFNzpsVmIWaVA>
    <xmx:GpFhZiHPhMMZv3R1q3_hUkuPv0tLdlpSNCx3ySAP_wXHk6OsYM6zIw>
    <xmx:GpFhZl9z9qKWRC2_SE-gl0dwka4hHhz9IQGBlf9gVuqCyC2FrIIT7A>
    <xmx:GpFhZvkKyP6jdUM6TtZDgdmJLV8zL_SmSdTcxjtqEGHbmp8kEVjJ8g>
    <xmx:GpFhZuBF0KZCiLiJQXwpk87cqQbxIDL5PtdlYX4nP8OhkwZBL1NVq_Mw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:36:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6c63ca1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:35:36 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:36:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
Message-ID: <ZmGRFAL_hQSNZZHN@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
 <xmqqplt4y1gk.fsf@gitster.g>
 <ZlhjN7K8JKYz6Opd@tanuki>
 <xmqq34pzozsq.fsf@gitster.g>
 <ZlnJ83qSnGlQ0FWR@tanuki>
 <xmqq4jaehui6.fsf@gitster.g>
 <20240605104646.GA3972667@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6dHOgLqjBgpueqnV"
Content-Disposition: inline
In-Reply-To: <20240605104646.GA3972667@coredump.intra.peff.net>


--6dHOgLqjBgpueqnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 06:46:46AM -0400, Jeff King wrote:
> On Fri, May 31, 2024 at 08:27:13AM -0700, Junio C Hamano wrote:
>=20
> > I wonder if we can do something to separate these two concerns
> > apart, using a trick similar to what we often use with an extra
> > variable "to_free".  Doing so would bloat the refspec_item, but
> > unlike the references themselves, there won't be thousands of them,
> > so it may not be an issue, perhaps?
>=20
> I had a similar thought while looking at this spot a while ago, so I dug
> this attempt out of my stash. It's quite ugly, as you need to keep the
> storage pointer and the const pointer in sync. Especially because
> there's a lot of clever pointer indirection via match_name_with_pattern().
>=20
> So I don't think it's the best way to refactor this code, but I present
> it here for your amusement/disgust. This is on top of what you have
> queued in ps/no-writable-strings.

Just for the record: I'll keep such a refactoring out of this patch
series as it is already big enough. I do agree though that we should
ideally fix this interface in a subsequent iteration.

Patrick

--6dHOgLqjBgpueqnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhkRMACgkQVbJhu7ck
PpTmthAAnLC5scz0NwlFGCKAhoRe0NzAKOKz23HV10UNL8twNeRR4N/g8vhEiZQ9
r3t2QLEDJRD7nEcLeaFQd0IEQTFkVR59zaGLTgQYDhInZA9q/TgsuZU6hVqKZA/e
vqixXBpeyzoAH5HO1XoMSyXiP9H3/KEBuxLpOnTokH9Oe1y/dFZnev57XNiL8snY
jpg4XRZem4Ev2T8ppLxBqv6dcE8u139g7rJhHVWa0Eoh0WbZ7AN7zrlSjOxqkcEf
+df8sJ2p8pwsoM2XLos17uoiwH8WtE8B7OFzBQulYoFt2DF2MxmZO5fVw9OepycT
2C3nwAsBqbRFw6011oSfKzKVsMfxndzuCZ8c9KG8YAcaoK6pGasv67RnjKtP8h9x
tc+5QNv/MdfNrc+4tef777Lm5cLvDlEttdLDswpYUPagG1a/zL7hzjYLyhkNPfA6
dL/QjGWdO7RbXfNq/RAop03DpVZxAD22Q8+tB3hTCgknK3EILrDfAqvLb0AmvklE
yQofnQVBGqL6Gm1owBC+4HG4Fjgi/qHFHaUw0qNqW1o9M0fUileG5iYAlgeFQNI3
UecRaumlsyFsS+zl+6P/fMFgrxKcaF837+/Vqu8TpPJOBykhixIpIa7v+o/hqedI
QTK7ierhQCdGOcg/LfMjx6BVWvwTG6R/LgigvCzLuIUpKz6kB3o=
=36vw
-----END PGP SIGNATURE-----

--6dHOgLqjBgpueqnV--
