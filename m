Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA24E1AAA9
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265098; cv=none; b=jYHDEU30EIsOs9V2fRNoA4g4kEoPKfSv/VRjYkYmVZwOGAjDK5ni8I4fYApZ+QNV6ZAeFT8YknRm9wxszPyAnHnjkHViTYTx3J2q4cpJnkzulTpKV5na42iMHYkMkZdPbUw7oh+lVTghAG93htIlPNMvkO/tLi82pi5rhD6KXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265098; c=relaxed/simple;
	bh=BjEU06imblAVLteYIqBRpYkY2dKerValnvpZAFPfRsA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dQiwaYeh+k+GJyXZRGELxjf52yf9KiUx36TUK2HCRyGkH0gCXpYmBHNhedDtf8Tr101eVADcrDOEOAG3aK54KYo1HoJL+u0TDuJgNLKP6QJZImfCq0HkAQivN78MIR4A1/2z9C472fOK6pFRSzB2a7iAM7GdsVMGE85JjboN8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mfi5PjPw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UL9MTQzf; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mfi5PjPw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UL9MTQzf"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id AF9AC5C010A
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 26 Jan 2024 05:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1706265095; x=1706351495; bh=GN3fK8zdf1ZUvJEXtt4pPSsXIoTvKslP
	t2CvGbogHJg=; b=Mfi5PjPwDm2/riloTQG70BQOBtrp9Ji6fbto6WnXCHvMeaFb
	T7s9U6F6dLv2xFrPQV5zKfLHItj7rZWfxTflJphO44MG+tRHxDO/eXv8jRe8WjaV
	N+MScq71itO68M1H9eYsJZ8/NUDt3cHPF3Sm/jV5OXpSKVSM4ZtPdwBAjHyPgz/8
	Ge29fMqkBKOjneBH4I03nlwxLGRK4bDgRGtKe1yFv+KdqEvrWo6cGRAFkKMBmhHr
	AqXajcjCeSERvigp42t8fFJflzhfjH0uXtpngFN7YcMPgLObCYiH4Zo+m/I8yjSf
	jI+Ct32/W+ajeS9s+EQLr0VYMHcgs6K3ifUveg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706265095; x=1706351495; bh=GN3fK8zdf1ZUvJEXtt4pPSsXIoTvKslPt2C
	vGbogHJg=; b=UL9MTQzfBOTuEQ+7t+XVErUuBFqSfeYnZr6rhswa5gAuQTynyL0
	DzlLmJ0lqIl+wGCxlaDOyIZBYuscY8gE8EDUG2qCt/H/qtrKbcUv1Cb8ZN7c02qy
	81QD+4jZfBttjewy7+CAMsWjKV0Uox1sOI7e3yUSBZKevwGJA9aMnIg60QU9EpGz
	1KuFIAr76c3u9F9IeMzjfvYsMN0ZjBQmwPLGjtoVlSNBgnqeQoM07Whf4Xf0zejc
	XfPDK/TsFOrDizcapmDqPM0cJIuFJlLdiLM3stGc5HuB9zXnrsEhOIp1b9BMexBu
	Iadf5Rrjw/OJCZ6CoqGKdNW+ch10bxMA3kg==
X-ME-Sender: <xms:B4qzZUzJnd721mFndrHNkPUTzdxeyxtIW1the1g9QWp9bwMk4f5i2A>
    <xme:B4qzZYQZD07QXjMqvd8omHokZUz8yjtNt03Nlc7KFaKzFr-KX5jr4ZNytE-hAEy5e
    pyNnbkxMby6nQmSsQ>
X-ME-Received: <xmr:B4qzZWXNasI1_zKeEhzN-rboMVAxgDD0xYCzlOAbWbefRiY95vSk_K2CAgJ3YWGEzcldZ66sRiHrIRQl9K-PpKQ-hk2C67BmNIldw-8bp0nEtqbNjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:B4qzZSieAfDem7K_VkILPM2PqX0HP1oP-IgCDiF2vSs1dae6vPex8A>
    <xmx:B4qzZWAL7F3tJu1HPG3JPinMTE-Ax1mnAxzlaxb-OHxRn2upbGq_GQ>
    <xmx:B4qzZTK0H00B0S-sm-3p6bcyZa8I-heKsNpV1Yyc4CgPe-rQhC2reA>
    <xmx:B4qzZd94o4wykJcyp3IYMXknBfDEgpA6BfcCMkSAZAZYmUUvfiDVWQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca649801 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jan 2024 10:28:22 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:31:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/5] reftable: fix writing multi-level indices
Message-ID: <cover.1706263918.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SXBMKCB9rbIgpkBV"
Content-Disposition: inline


--SXBMKCB9rbIgpkBV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

yesterday I noticed that writing reftables with more than 250,000 refs
led to the last block of refs in the table not being seekable anymore.
As it turns out, 250k refs was the boundary at which we start to write
multi-level indices for refs.

The root cause is a bug with how we write multi-level indices: we did
not flush out the last block of the previous index level, and thus we
didn't index it in the higher-level index. This patch series fixes this
issue and also polishes surrounding code a bit.

The topic depends on Junio's jc/reftable-core-fsync at 1df18a1c9a
(reftable: honor core.fsync, 2024-01-23) due to a semantic merge
conflict in the newly added test.

Patrick

Patrick Steinhardt (5):
  reftable/reader: be more careful about errors in indexed seeks
  reftable/writer: use correct type to iterate through index entries
  reftable/writer: simplify writing index records
  reftable/writer: fix writing multi-level indices
  reftable: document reading and writing indices

 reftable/reader.c         | 30 ++++++++++++++++++
 reftable/readwrite_test.c | 56 ++++++++++++++++++++++++++++++++++
 reftable/writer.c         | 64 ++++++++++++++++++++++-----------------
 3 files changed, 123 insertions(+), 27 deletions(-)

--=20
2.43.GIT


--SXBMKCB9rbIgpkBV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWzigEACgkQVbJhu7ck
PpRdxQ/+KE1EYVWva8WHKdYeAve8lc8Julj2mtEGYFS/AipavFdDgkkToPiMqrMd
eFEAfjt/b+5teDFw+AE+McggYmHbqaDJRv34C5UWaH92YQ8wNx9vmwKI0Jbz5YLn
sjfNxcrxqnL9U6RAenenc84deu72dMw3b9V5pIHACKenCYeJphJ8fhGSMNS98NmE
A3oW2FsH1gKIE0qs7w3jHa2HzdZ04qLR9xwHyJfUfO05YerPaToXT8l4AikA5of/
AM8qdG0rOppV9fHROuX1hIi0HEIpSa9FdhlBnR0PZWHZgFBo+gt0vhTmPeekJ7N6
MBJHBKs64XgMLH9o2hNR9uhOwo0ejMsdxBaM2S69XARyJaaLTrKRqdyHSXM+z2gp
ApJLBKAKjJQJX2fzB8enjq+ZZ+pczSOOCJ8ZkK0DWz5xBuwOk0fq1gBLuKRkmORT
QDFP9FWgnOPKAs0eFRPd8lw3NpsXrwhuEAd3rGcJ1YyiZ1qg8sQmNplpCwHFz6yD
t+FOMcGat45azNgB0B1mLX1qyZqqTH1dtAdSiHXlBPsYwpYSrBNDfe5TDc6hHWhn
hkZg5CN8xukJOYdSRfJuK61n1Vd9qBrIvxnIFfvry4WXXGSrsSueDftIc1KgCAYE
GhVE1hnQ1VmG0mfuMgsGNcLdxBhjx+ZEDDOhLmQcxdS15ztySVg=
=F3G7
-----END PGP SIGNATURE-----

--SXBMKCB9rbIgpkBV--
