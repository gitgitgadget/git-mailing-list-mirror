Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B412E5E
	for <git@vger.kernel.org>; Fri, 24 May 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536152; cv=none; b=oH0+BuuV6N9Y8bfmX8UrvfZaltL5boXDiNL0XCRnHsU2Q+4XTTIMXxJ/P8Rni9Olk6yvCCi5l88mOP1CsUr1W+XwUbZuFLHQEkq7ylIbhq1G0BX9IQvsb47P+HQ2KE05YUc5SF3l2HKN+8FnCqZfL09rJSpx9RNvUsQHdZVhr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536152; c=relaxed/simple;
	bh=I/YZYjIA94Qquu8MEneJEpraKQH1zLblLpBSDobYwVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsMDEtFp2KzeXSI+hDpDNi3OWLRysq2znY+5CyxcH12JsiyxK9nVmg76JuqFzkgORGJgCIp+HN3gh4G/0vMdxW7RB4ePTr33BqUmKgGVVzB9QPT50gNRkm7dZaAs8C5keItdfguJS7Hlm9IIEf5So95rNV8YlxPmSAsIt6CAnZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e0JnQkkT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bxNIFh2M; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e0JnQkkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bxNIFh2M"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A2A01114012C;
	Fri, 24 May 2024 03:35:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 24 May 2024 03:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716536149; x=1716622549; bh=BsJM6tC/3K
	o9OFi4bxzDKYgqqtjQeSFPrRaLy8NbDM0=; b=e0JnQkkTLgUH0J3hSz5k2jY9FC
	RopqARk13nTv714pOsITa+omFsQOyzmy98N+M4YVVXSKP0yFTE3ZnRlKHDP0/tg6
	jjPDn7lAl8UQLjvPQF/1wAA3lbSKuLPR+ykcskEgZ2+CmozQktTL4ahRl8tbDGEe
	MGHi41/Ps0svZZUyJranlk1rLEfPgjhE4HqDhcBprMl5W6WqXCmHMqELM7PZZNmH
	/rJmGNNMHChEgkufmYuRGgoHzfDwacTwt6M/xoM3vu/C5T1b1r/TmOltIvDmi5ZI
	Z7MxPhHenElhiTwji/UsX4XUXTVy06IG/fTGluRUQe8fCeC22DWIUPSeTcbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716536149; x=1716622549; bh=BsJM6tC/3Ko9OFi4bxzDKYgqqtjQ
	eSFPrRaLy8NbDM0=; b=bxNIFh2MVS5PMqfxoUp/Fm8pXEkS65lIo3dye8cA4tdc
	BPZoN4dadIOo+OnTEub8CaJ8a/qXYQckiyaUlnfDVxXpuESzgqdYIGAa7Xn8OMe9
	4dyPVBXrMYOa/4W2FunDXwxYd5b2X8ywQfwiP4ClFAZUbrexoOmgvuCc3eilgIHk
	tHi6hWXbZVlUYYuMucDSWYp1IAgz6Uua9xneKw0+78/Six1BgLvUmR+8ogdrGWd4
	jxNVM8baJMo8UAnVjDP9QnGDFz439q5oiVQmRvIXY5xjXpSrS5xbkDYoFO5l0JFt
	P473kIsEZpjOYEHZXMq8ORKINC2rNsYTvluh+zfoKQ==
X-ME-Sender: <xms:VUNQZv-RFSzHZPdCMYuZ7jF-CVu-Myd_7WsyWWFaJFyrdASp0XaAkQ>
    <xme:VUNQZrtfZCfQMbYxO2pv6ES97JdduWS-RUhQgDQl6TTG8RCmTJkoIfb1E2JCGqQnf
    tWTfuKXh1dXiBBN1w>
X-ME-Received: <xmr:VUNQZtAcg1VVl8BnoFnpxzeGAeM7zuMgKZht0jF3NRtF345kgj_BlX1tqmm6jR7GvAfiIfF_jHbfafHxTG_au0FcGKDSyVnCbSZvrMTiXye4nBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeegtdeiuedtgfeuvdfghfdtkeelkeeltedtleeggfeufeelgfeitddvgedugfeh
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:VUNQZreQWWmVGePO9YHATeY_oxtYjtTGRHi8frBaM9GPviIB5jqdyA>
    <xmx:VUNQZkPMHqq4rmH1_jr5-UPka_5lGcDZ9o_GdrEpyU-RPhJkStLsBw>
    <xmx:VUNQZtnGSwNbKlv3CRmFRHyO_S37cyqh_M2Nh6g21onqfmbSOzd84w>
    <xmx:VUNQZusxlGxzuJJn44IqAdLZMedAi64qlsR9pIuxbpPoFj9oX6V3hQ>
    <xmx:VUNQZtb-T-6-EO8L-tHxfinKOjXrGvCIDrSKQUTsaZm5O12k2nuqCYwz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 03:35:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8c715b48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 07:35:45 +0000 (UTC)
Date: Fri, 24 May 2024 09:35:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/9] refs: implement logic to migrate between ref storage
 formats
Message-ID: <ZlBDUncKuWsfrfXF@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <4e0edda6d3ef48509206d849ceb1f347e51251d9.1716451672.git.ps@pks.im>
 <CAPig+cSM2mcEByQ=kJz2nFRR6OoatoNnii7Wy3wAiGBHO0LWrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lweLN6eXE5Kj8sIi"
Content-Disposition: inline
In-Reply-To: <CAPig+cSM2mcEByQ=kJz2nFRR6OoatoNnii7Wy3wAiGBHO0LWrg@mail.gmail.com>


--lweLN6eXE5Kj8sIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 01:31:03PM -0400, Eric Sunshine wrote:
> On Thu, May 23, 2024 at 4:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > With the introduction of the new "reftable" backend, users may want to
> > migrate repositories between the backends without having to recreate the
> > whole repository. Add the logic to do so.
> >
> > The implementation is generic and works with arbitrary ref storage
> > formats because we only use.
>=20
> ECANNOTPARSE: This sentence seems to be broken grammatically.

Will fix.

> > It does have a few limitations though:
> >
> >   - We do not migrate repositories with worktrees, because worktrees
> >     have separate ref storages. It makes the overall affair more complex
> >     if we have to migrate multiple storages at once.
> >
> >   - We do not migrate reflogs, because we have no interfaces to write
> >     many reflog entries.
> >
> >   - We do not lock the repository for concurrent access, and thus
> >     concurrent writes may make use end up with weird in-between states.
> >     There is no way to fully lock the "files" backend for writes due to
> >     its format, and thus we punt on this topic altogether and defer to
> >     the user to avoid those from happening.
> >
> > In other words, this version is a minimum viable product for migrating a
> > repository's ref storage format. It works alright for bare repos, which
> > typically have neither worktrees nor reflogs.
>=20
> Worktrees hanging off a bare repository is an explicitly supported
> use-case, and there are people who use and promote such an
> organization, so I'm not sure if "typically" is accurate these days.
> Anyhow, just a minor observation, probably not worth rewording, and
> certainly not worth a reroll.

True enough. I would claim that most bare repositories out in the wild
do not have worktrees, mostly because they are used on the server side.
But in the end, quantity is rather irrelevant. I'll s/typically/often/
to relax the statement a bit. Does that work for you?

Patrick

--lweLN6eXE5Kj8sIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQQ1EACgkQVbJhu7ck
PpRy/g//ZIiJ48IrCFpkNlEfBYjcO7rzmm+TIlt46YgYWtNCEcO83U3mQhnmud+V
2jxIMS2z7C47HETM5eoEB1JKmKszCDtX9ZD0rHYMKVmwebZlOOb+VLdWzaamAtUK
F2QdEUbfUm/wckoz+YlCgzDjp496E1qUXFTadgdSJ22OpwBhIrIqyewXo4RqysGL
8zNIgxozhQrdQ2BJsyLHeC0UQABp8gA/lThQnO0G7DGO+Kk8IQEPE/eUjhuU2qXo
qVrpGuSfP+SAB9sKFYGaW8hVrTpj3qlPnSIZmZjI52q2qYgVkPCpWbx9lSaWxwVY
kKQSm74SqGUoeCpll+4sX2rSsulZGnpaoTqulCKUxXQ7yT/TzH17J8NbTDkwXPBT
m2Kdths/7D137eegZr4Y4cwEUEUJeb7ceA0pIEu71Sy7Q+BjlpPMeMarcXG/Rjmd
h5Z/2eDHeRlzE1RgDU/jewO+ymXyoGy0OdjBai2oRXTPvl2pvkBTOrTjPPAnDLqe
zo7HFCf93WpZdwrUhkIvR7AY02GXDcjf/2JjxUOFofITFojyXs/I1DSjYm1txWED
Oep7HNRWpj+I77yvmOii4VAUHWIalGMJbSEWvCyOBClrbEoHFBy4P2MZkxgygk58
1KI8Apn8ijPWELBDO9Vi8/pRadt4/Y37gZUw+HoRbUnRYocrlY8=
=XgOI
-----END PGP SIGNATURE-----

--lweLN6eXE5Kj8sIi--
