Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D55117BA5
	for <git@vger.kernel.org>; Fri, 17 May 2024 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929724; cv=none; b=R+g/g30Wg6D+pMboY8PbcV2byMn9nq8vQ9PEcQ0Qy2iuGAQcO7pyFDPdzlhsi5vGAoTFlfwd3HB1FEpdZGJbUk/djTnEFc7bg2gTgxv6A1ULHW8TGWFbC1Zgr2MCW1U9OQAri6D1yiX2uZWI1H8lWTI5vr6AYotGZsHsIeIGdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929724; c=relaxed/simple;
	bh=vBKSeXlrVVzMJJ7PCZRdgNadleKw8fmTvD7O1J2s1/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCXJjMPuBo+3kKmcXgIp7cH2oZx44OgcZGaRc4kFm5O4qjl9UU5afWOYoxD/ORYDXuILAm3Fgk+JxLwier6DkbsQZEqcTJXOIjNWdvCm8uFk6UqhWXvatt0sKAhINrdRroygixVwthJh8kNr/dUAFyIWaiFOprLo6WBYPiQw7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m5/w0AiV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPDTP2yT; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m5/w0AiV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPDTP2yT"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9B317180018B;
	Fri, 17 May 2024 03:08:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 May 2024 03:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715929721; x=1716016121; bh=vBKSeXlrVV
	zMJJ7PCZRdgNadleKw8fmTvD7O1J2s1/E=; b=m5/w0AiV9oVDMU9vmtOeOC/DR0
	xEfV37vl3ik235YKknv+stusW8S5wxnWH63YazqgaQHQYkV+Xp1KQOwj5Otft/zn
	WMwsW2LVaBA8xGrwpJH+qKQR6MfRDk+OTAT435WgauktYRiI1qjvuUsT9MrQ5DR8
	yp7c1k5oh10wepHmzLi1JfDCIfXYq2FTyvpu2QziiLLj/++VCM7nKqgOgPgxaJd5
	yC9ClN4BfLaJqOicryq1UJZZ74k8WkGkoXECluzyZKfhWdjICtCcdpX3gS/Fa2+D
	fYv1YaAKShnCT1u26HtW7eOfGm3XdSburVgQJpa1vBp5LBqDahPrW5V4Cx0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715929721; x=1716016121; bh=vBKSeXlrVVzMJJ7PCZRdgNadleKw
	8fmTvD7O1J2s1/E=; b=KPDTP2yTYk+yudFX5LzvezIx3pLOx7jssUxVvD73Aq8b
	J5IwoEOoCJAQEqfXdWFN4tO4xt9TA+TlVQyuf2oUz695RBAWFV3kxRYi+K+Y9hiu
	92tcMz90nu4z2NCIiMjSHRbrjEEW4fuSlvP+sZ+X/kaV6Abg9R3nxC6FigWJNgXa
	yd6tUjW1o1y701vQRGbDFfwytyxw7giOTRVZt3MgES1Hs8zR3v6ppkZ3BLtwfCZD
	tCaUY1EKtq0IGFNfa/BEnNKaBfh9Gb8pReSN0juG1yrkkDlh0mHDikKkETnYijzY
	/EsnhU6mP73mgNnz+VtmV1bKwQEm+JdkR01FNHdgOA==
X-ME-Sender: <xms:eQJHZmZoNKRdaoXPYzDrd9_kxQZBUnmTrmxFdzx0hUTE34lY8SrVHg>
    <xme:eQJHZpYzGvolh9nh1-N4QA3mIBaDAa4xYcGGUCu_QaWmRKnBS4lS5eruxSNz30acz
    7x5rsUmz0toEeFfnQ>
X-ME-Received: <xmr:eQJHZg8TKaFLrlI8B3C-b0dCKJWZ9xdeChk_XzCI5T76SRB35AzSPu2qzxo6vlhramKbUR2KVsggzwcGRkL_w-cyzb70uiQ0JYdS7GqAkJ-zeFwWig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:eQJHZooDVF5mt8H2csURbG5MgKNjHDzNfnm6Kqlj0ZQzFgQrndxd9g>
    <xmx:eQJHZhpCb9D3PU04MZJuopW6m6b0eNelj9WAoXSiTtGInTT15QwmCQ>
    <xmx:eQJHZmQdobFji0x0UeegCe3Beze7s9JtJzP7MpHtkCFPTUnNtbPa3w>
    <xmx:eQJHZhrtzqS4TvM8WRzaZhdtZI8vt1aJzFHC8OSEtw-IhIJPmzL14w>
    <xmx:eQJHZo248mg4Kz8zhwc3OM9_MJ2uJAAjJH5JrFiE1eT-dgjZK8RVMGS2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 03:08:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c06bdf81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 07:08:11 +0000 (UTC)
Date: Fri, 17 May 2024 09:08:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] refs: drop all references to `the_repository`
Message-ID: <ZkcCc5w6zcj4wYZW@tanuki>
References: <cover.1715836916.git.ps@pks.im>
 <CAOLa=ZThWW0ToK3x-GBynSPZ0E_ssKRd_bLH8ayy0QD4gkOGpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7GNtTjxF/23WMo3q"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZThWW0ToK3x-GBynSPZ0E_ssKRd_bLH8ayy0QD4gkOGpw@mail.gmail.com>


--7GNtTjxF/23WMo3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 06:57:46PM +0000, Karthik Nayak wrote:
> Hello,
>=20
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Hi,
> >
> > in "ps/refs-without-the-repository", we have removed all functions in
> > the refs API that could be trivially converted to accept a proper ref
> > store as input. This was a mechanical change, and because the resulting
> > patches were quite large by themselves already, I decided to push out
> > further dependencies on `the_repository` in refs-related code to a
> > follow up.
> >
> > This patch series here is that follow-up and removes all references to
> > `the_repository` in "refs.c" and "refs/". This includes both explicit
> > use of `the_repository`, but also implicit use via `the_hash_algo`.
> >
> > The series is based on 19fe900cfc (The fourth batch, 2024-05-15) and
> > pulls in "ps/refs-without-the-repository" at c8f815c208 (refs: remove
> > functions without ref store, 2024-05-07) as dependency. It applies
> > cleanly to both next and seen at the current point in time.
> >
> > Patrick
>=20
> The commits here were easy to follow. Apart from some small nits, I
> don't have any changes to suggest here. I did confirm we no longer
> have 'the_repository' anywhere in the refs code. Which is super.

Thanks for your review!

> BTW, should we also remove the migration code added in refs.h, since
> 2.45 is now released?

The migration code has only been added in v2.45, so it should only be
released in v2.46 :)

Patrick

--7GNtTjxF/23WMo3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHAnIACgkQVbJhu7ck
PpQ9ihAAhSU5Zx6XTJwPvsFFre7+ypDwjhC/orMvx1eFkcFDKNv33/WLJray9qGB
/PB28QPMIj0ACbsVWHEpBRdzrCn7LkiLBYhn+9U1JTBVtoeFfj8DT/xDXZFyvO1J
XACLVwr+dR3tecuH19CEgIwLmvNRmk2xgt7lm8tOwBNdWCWutgQWjgIQN1QiRK9M
f4HJ0enupcoKKYDorEcPGTWd4WhrUJ44kqPysKPiPvWEXl9Rr/HZ7UbRgLyyYGMt
WuLKDqAWSId9aLMlAw9bzZikle9593CyGMynV+AtY0oU90WkYEyTd8wiGcMS1mWL
F3Gv078anxfmmfLbrwO+UMS210Lk/xXoa9Ms3XWG2dXBG/21+DDte1WG8Sj3IbDj
4Vma96bQXzLQaxaKReISSJiH07E2bfHrq/XYt5oijeP6p/QsIfxpkaGQDTZ0ykXZ
sv9/FonUnpE/PdnKTsz8Nw7w/vhOKkysWDA33z04zU9fpXsUAmJOf71eVJ6kFBk/
gGO3Kdc2C3nTETrUklgM7b2jjHhDDrWaakH22hFlFaZZILWnYQuSv6r/2jwNneWY
60eLPC3sjXjLn30aRkZ5GufAMDUplGLTY0yAC1xQXsdkwOjXgwPhmGwp54qYUfOK
J1EVnPCqX1LQDj8WzAWEuIDmsknTTM22YfgvnFN4KL7hIg3rB5E=
=dKHt
-----END PGP SIGNATURE-----

--7GNtTjxF/23WMo3q--
