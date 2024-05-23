Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75B13CF8F
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452724; cv=none; b=NJXw2fYmnHBFkiJrHFkXtm93R3awp52ZDjjyzCMRj1tNd6phEw+gwYygkAaDCzXZvh4fI5umwZDvQ6cGi1LGhM06jbSybBtChJbARvKjtGpm/jpVOnKMWoyfn4IKfFF0Ap1MkQjuFrk9YB/4+3Sc1RDSJCGEO/M6SAfxRt/qiIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452724; c=relaxed/simple;
	bh=Mo9mLEo0a+9EHvpEpc3nvFLOAghevQJH0oVUAv5ZkXE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxM/ZoDdmi5XFQiwwRTc1EaijRd46UCNLFD8f9RssMPeTAudctFeof7sUNzaYm9azygQ2GBQ9OTtSCOh5rHqo+uT39Uf24beuu+0PI/6IAA4zkNrI4x4Ymtzb4pclhsTDVMMcLHjnzpTijjpFEoiIPfdx/hVQkP/3xGzCk7iTOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DaWNF5Uk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gk67pg7u; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DaWNF5Uk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gk67pg7u"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9D8E11800113
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:25:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 23 May 2024 04:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716452721; x=1716539121; bh=5KG9VSNFoA
	GX99+cDrdR4I9xRsUAA+C4DtCW0KSW+cY=; b=DaWNF5UkfGwOg14lVNCVOdKl4y
	lg78kSrwvKwD+3jvOIlgTtg4jfoirGpK3nnbrFNtP5Fj8IOxk5jxDViFmwDqMBJ6
	DmmLnnXaZNzT2WGDNO9e0fXvSCbpOmxUB7E3qyrx+SVcvOsqXR+zzCUOKQdcaLd0
	9jG8LLViqAMSkxJzYC4MguxhixnIUJUWoKInUe33N8Cvxn6rUPH9B9QngXPtbEaa
	GvgXk2Zb396KHb5UMfWiFN6D5bfwmjQhEYB6eGpsTvr3VRhf9yBNGLOMb0PxpA/p
	CizznVr8TkiAVkJw+i9YTxGM6bEK+vguxTWTBpJuodS2O4iqmwWK1uqO5yBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716452721; x=1716539121; bh=5KG9VSNFoAGX99+cDrdR4I9xRsUA
	A+C4DtCW0KSW+cY=; b=Gk67pg7uPh6viItb+V3ULH87gpWOVNOcJwSyvTCMZM5G
	MJFPkJCX64O9a/T6zI6SeHUD3A20sg4I6Sg2nLqGk1bF0MQUvFxHezPodDNSJjId
	gjhXwd3RtS7SFvnrrDQ07zUw/SUgtuhIkcXFeSoesDuzrw5EeaJdi270Yq/lWkzZ
	f366chMJrj/+RQV3aF5gafFOlIawHcuvLkclM8Mk1e8UY29tLd5yTKsuieszzmdn
	mz9x0EvA0riE7ifMnH3T3E1t5tP/Gy1/ruVCYm24XlgPTy+OZjX9E2ARlthOBbJO
	JKqZmludO3BAXfLqRY+qFu7AB1jN9aZoni5MqhyvKg==
X-ME-Sender: <xms:cf1OZiWIf944jxWsh3h5u-6GRH6ZKEcdPsl-YGTBPfOz8GSUOqPzsg>
    <xme:cf1OZulRsDABkLzSwGUWujBGvYHHZdyopoygWBTDdCGwvkBeeFQ5WdmxjmkEi2aRq
    HkqENGND4Ga5f9dXQ>
X-ME-Received: <xmr:cf1OZmaO1qy3Yd1DsJyIJiqwPooHYa0iebms3ZsYDGxDgP6shdl-qHrbte9KWRPU2lZG93D9rdhmYbfMn7OliTJL0JhEn2mGt3FJGMtIwuJaAOrBrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:cf1OZpWxNVroJlVNy9Q4ODtIvqsE1DVNCDIsbdH3-zVMYnc2yx8mwA>
    <xmx:cf1OZsk-CM6g5mrRXm14A62ITKcIcSpWaGDy5FYYaxknwlxZRcUF2Q>
    <xmx:cf1OZuftHdKiPy1_wyXTRH1M24fiWm12absYdujaFgK_GxOrVLLhyQ>
    <xmx:cf1OZuFmDXBgG-kqWu-G_7qIAqYj1vdvu3MpVBSvaWctnh5IwFDAfg>
    <xmx:cf1OZot6F0vBt5wZpukpLSovaajCCx_iekPIJkDhcIyWTwuaUjYQiJsw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 04:25:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f612c304 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 08:25:13 +0000 (UTC)
Date: Thu, 23 May 2024 10:25:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/9] setup: unset ref storage when reinitializing repository
 version
Message-ID: <8b11127daf4c1d06eed4a0c83dd3dc981ffdc728.1716451672.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7U7q3Ocl72hO58cT"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--7U7q3Ocl72hO58cT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reinitializing a repository's version we may end up unsetting the
hash algorithm when it matches the default hash algorithm. If we didn't
do that then the previously configured value might remain intact.

While the same issue exists for the ref storage extension, we don't do
this here. This has been fine for most of the part because it is not
supported to re-initialize a repository with a different ref storage
format anyway. We're about to introduce a new command to migrate ref
storages though, so this is about to become an issue there.

Prepare for this and unset the ref storage format when reinitializing a
repoistory with the "files" format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/setup.c b/setup.c
index 7975230ffb..8c84ec9d4b 100644
--- a/setup.c
+++ b/setup.c
@@ -2028,6 +2028,8 @@ void initialize_repository_version(int hash_algo,
 	if (ref_storage_format !=3D REF_STORAGE_FORMAT_FILES)
 		git_config_set("extensions.refstorage",
 			       ref_storage_format_to_name(ref_storage_format));
+	else if (reinit)
+		git_config_set_gently("extensions.refstorage", NULL);
 }
=20
 static int is_reinit(void)
--=20
2.45.1.216.g4365c6fcf9.dirty


--7U7q3Ocl72hO58cT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO/WwACgkQVbJhu7ck
PpRv5BAAqlsI6jO2Tx72S3RScCDemln9p+XMQXd8QgsuRGfMJvJPWF/cRirplQTD
d2AoZFgT/svJ9lzUy3d9G1Orm6ZD1BAeIgpB639JQpnUMMnC9EMmE8ZoNoFGJsLY
LLIotFJOwq/0PsDT4pc+fhRMieiS5goriOrpbe7Td7iy1kY25OJzsOQp0n3doyDT
nypEr3fdk5XGz1nA3p/X+qH3prxEBD3z1H5a6t19oq2ZkgJ029USOaB6Mkgd1LCv
h72G1ZVe2PvArXX4Y74DFAV/RWoO3H8geelkuuDlQOw+mBtRIFXSAune7QMUrVnJ
7H+KyTj/2tFrVtmogQQC3X7HeStgn2eo8I2H4+595msDKMYZGbwrU57zo1aks9fL
wJkJc306WG4i0OgPkdc5NQMI8vtzrFKfgno/TJOH0eBzHGfDeR+kFaRziESlJvTz
GvOuW+Ka40ANDU0TzHqXv6BvYPM0CCuqg9Mb2i2plE5SrhWE0BDt7R6DQJ2pH9Hp
SraDg+vOyZiku+wLFPGtfIlQeie+oBhtPyFnzUJUuV9xSn+XQfe1mlnsrFKPjH+g
jXpRWZLWvFPyT1gXK6N0tfPuSSdhLDQWZmt+n8B/cW5tMlsRAIyW9SX7pqbNi9BZ
n4w+VUdP1APIGcbJnqzxfXtUUyRuJBTQ+pK23MGaH7hcjeYbnYg=
=Jj0l
-----END PGP SIGNATURE-----

--7U7q3Ocl72hO58cT--
