Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19D657B0
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463394; cv=none; b=Fh9Mpl3L27tBfwwmfG0Ho/PuzTgXWf0DZmmIvp9+6qNz9XaphdCs3njKdoOpG0abqpYuR0gY4QjLG614xPVaLZUEMys0tbVr3qdctGxpT8UxxEluS+23oqrXZKMGr15OYus8dYdVZ3xC7TSc1SpSetEKIGidzYNSV2OkiiJbs/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463394; c=relaxed/simple;
	bh=ZgiNiAdjfpDB24AoBnpXD6ACwBIDTGkv13eHEA7OTtY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bNhYJY+PVrFV4o+GIcgjQmhJMifkKFycNQm9Em/QpFXyx5U65j/aVT5f4a4ozGeccEcVgyo/jI+yhfuBLejhsBOxvTr9Y2XSdS2+GNF1M8tniuAP3XKanA0t6RB+tC6Ti/a7H2lzOjC+MfZPmU2EbaxFvWc0mR39Z40nNTHOm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dax2Aoou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x75mjvLZ; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dax2Aoou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x75mjvLZ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 887803200A67
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 02:23:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 09 Feb 2024 02:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1707463390; x=1707549790; bh=G4wfsC7tLty6dWt5KdbJTLMcSoYUYoM+
	rvBC6uWBWXA=; b=Dax2AoousES7i7sAWRLaNIW7Q2SIUb2tyXeheIj2mQsFEmLO
	ZWOz3lah8U59u5ZQu0iadiq6FTZLBSR/rv8wbVvTxuqJjsrj5uofu99cM/bEVD2/
	Y7eeDxfABxhLqNs2dWkcVfdQlXsEfu+lhjpMdRcD202Zoan+HZJwWrGgYwXSPyon
	MGJOcG8t0ZoAsQ5xoALI2Ckyw/zZC2kLLWD+45j2Cxbo8M/m/2k0hEv/ZpjEvX8/
	SyZZ4ygjBStRJcuhFfH7XW5T6sp5whHPahEcOnRKWQ4xtOF1MeQ34iy7k0s8o0Wi
	G/DZmkByQs1wp8lH6kHvmSoiuyGu9XWjvBIj0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707463390; x=1707549790; bh=G4wfsC7tLty6dWt5KdbJTLMcSoYUYoM+rvB
	C6uWBWXA=; b=x75mjvLZaIKCIaGrBhdMJFzvE/7EbnDJbgZSbhaTU2AnxoB9sWz
	scl6ugkc5JPfE7rNG8EF82kLcVotQDfnTU39g6ldEVLQDoj+lPZulIVIk0J9Szra
	F5JIUHT3rgMxQ7+5vF/4PUhTyWokqGhQs97MyfvGPS0PMpZUJeCxKYYTcIVNcTSd
	nfqZmY94aw72yiboqTiIIG6rUSHCvwxvyWr1LCxiDIP2flIIgOEBEZK8SbuRpbkF
	oMXn2doFp/qYmdC3WtKkGV4V398LC3s8TcxaUmM3X3V8UO1GqscHpgTFzoC3b/4S
	GgCifUKezLoDzNIokCv2ADPf2EFbl/kNp+w==
X-ME-Sender: <xms:3dLFZUNqw5eXHVzSqhfmBe3kqLO0abp3YZPqyle3ncLQezKZlMBUEQ>
    <xme:3dLFZa-MZoeMg-mSZ8ESvQTealCm8kVkG3oSVWtS3BZtUohpZCQIktPAHVPYGZ1t9
    42ETsFmB0hPVGtl4A>
X-ME-Received: <xmr:3dLFZbR4wzNwuu5TBN_PE6w78yQICPrV4IuKDEIMP1nNeNpVWxYXUh2stma797xI0qy6l5fNv-Z1Uzwt2ClYC4nio-Gf7q8sbpfCim5fi67tfI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:3dLFZcuIf0tDt0UfgJ6UDiTEcilbxhuOo6MyT_R9H-wGkPiuswtdNg>
    <xmx:3dLFZcdkmxsM-LjHagzTwGjsmu16t1S-Aa-4EarEgdPfq4evcQrXrw>
    <xmx:3dLFZQ1PD1iow10DP9FfKi4vJJMuu49_A_XubQz3xq3-SRmcmASBlQ>
    <xmx:3tLFZUl4e3rJWFOVzIztoISA3p0f6HdamGgOQlaMHjzkrA9FXuaS6A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 9 Feb 2024 02:23:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4f54931 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 9 Feb 2024 07:19:31 +0000 (UTC)
Date: Fri, 9 Feb 2024 08:23:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/7] t: drop more REFFILES prereqs
Message-ID: <cover.1707463221.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PDcx7tW0ccPMkrWK"
Content-Disposition: inline


--PDcx7tW0ccPMkrWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series is another step towards less tests with the REFFILES
prerequisite. Some of the tests are simply moved into t0600 because they
are inherently exercising low-level behaviour of the "files" backend.
Other tests are adapted so that they work across both the "files" and
the "reftable" backends.

Patrick

Patrick Steinhardt (7):
  t: move tests exercising the "files" backend
  t0410: enable tests with extensions with non-default repo format
  t1400: exercise reflog with gaps with reftable backend
  t1404: make D/F conflict tests compatible with reftable backend
  t1405: remove unneeded cleanup step
  t2011: exercise D/F conflicts with HEAD with the reftable backend
  t7003: ensure filter-branch prunes reflogs with the reftable backend

 t/t0410-partial-clone.sh         |  6 +--
 t/t0600-reffiles-backend.sh      | 91 ++++++++++++++++++++++++++++++++
 t/t1301-shared-repo.sh           | 16 ------
 t/t1400-update-ref.sh            | 50 +++---------------
 t/t1404-update-ref-errors.sh     | 37 ++++++-------
 t/t1405-main-ref-store.sh        |  6 ---
 t/t2011-checkout-invalid-head.sh | 17 +++---
 t/t3200-branch.sh                | 29 ----------
 t/t3400-rebase.sh                | 10 ----
 t/t7003-filter-branch.sh         |  5 +-
 10 files changed, 125 insertions(+), 142 deletions(-)

--=20
2.43.GIT


--PDcx7tW0ccPMkrWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXF0tgACgkQVbJhu7ck
PpQP9g//Rf6E8ZBPjlOSR1WmOCH8zJSUM8aED8ZdcZ/8X6ewEssF6paioYt2hvxZ
bL3yr6aqJggJaTTRWp86RWL8fI8M2QVB5Ow00UirSZoe/8hQlHRyk4J61DfqvP0k
5EXYaz1BQ6CIhs/REOFvVCIzqZE/bVnylMlTCyQHbSKwd9VLkkTfCNYF1/cwUmtj
VeKbaD01qUPQxwgNdlw3bcEBxBAI+WJWINe0Tvuf8TF3jv6cw/Cf6h6Tb1gJCIuI
8UsjRkXwwIHAO29oJm7PQPr86DciUsVSd1f1LXByLwEkJ6Zc/GAr7KaMqRdGaJ2z
gcNi6e0/zM/sbf24E6feJTZ5mh2lHKcmUKbdo1IU1BMiVdRP7qolS1NYaV1q6E5y
Eov2a0ytmd/8dmW8sVhy14++uXaE/2ISEspdqbhQiXkRZwHC2esie1MFoCnmz57O
MY7AF4i0JrNhs8s+VwotVlkdfPUzZ7G551S6atYY4n+rPCjXDQOnmXLqrcJxYfH0
sdfJMIYrj0FYFV5/hqV9vI8l6/OzdCMMtfEpCJxt3ZrbsVqSRraRbOji6oaPKaXB
OLmABlLHadm7aUBrS5nxhX5hgXiE2JaIB1eWjGPjBu0p0VhYFWxQcvbitPfQ7EX3
fssvtlELPbPEAFR5pN9kT72i2Dt4LffSUkefzpTqGm4EcDzuCVA=
=hv4y
-----END PGP SIGNATURE-----

--PDcx7tW0ccPMkrWK--
