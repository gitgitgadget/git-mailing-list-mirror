Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870A38FB9
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564622; cv=none; b=goZWsA3c6vvdjebHgR+jnQ0CsKt7VsGAzbK8Bly1tc3Hb5OPj/ALt3//EppwShxq8piI+OwtgWwUH+jpDVVQBWjYZi2YcvJ2s+R+lEgah30s1ggs9//1Hkncs8eXL5IbEsGYf/g/00ifw51drJOseq3i5igOvXyhy8TjvsI+0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564622; c=relaxed/simple;
	bh=BcQ7n7Pzdtjy+QYm0zHhDUEDxUgmMBXGevCfs7EQ7Qk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVGZSeGh0A0qORnljGL+UDOuUU/NOrE5jbEWfK9HslZwgjx8iTbBm3p1aHM9m54mkh6B7bMcAEs0/Hi5pzbTzvV3BJf9d/1JAVqopbzJtU6Nw8GquRir8qoCnwOFwku5+8Fcf7Ro0R3AgXc3T81RXKrSveN1f7KYJSZ1DBzzuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b746AjML; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9dUS12l; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b746AjML";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9dUS12l"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 116DB1800144
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 01:17:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Jun 2024 01:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717564619; x=1717651019; bh=qThwoCcfSB
	BESCRhBYwfYjpmcra+ZGjIYFsspLpQWhA=; b=b746AjMLAJzjdvYEkaH/S9hqrN
	k/nt47XlqDk5qJ0vfqORxYV5BQrR1Bhoh1l5G6rsIlMStL7kbjl5+SS21PX0lnfe
	WoJRgrFn0jOqK9i3u15QvSTwcypDZU1mGbuBsqax9i+iNvB9/VLY+7U0WNtzp4qd
	vs4jxi/jHFECkqf+MltM2gxsCdigSy6FQ/LLSBNs8TtDUqfNolS2d02DcIpiv2Yk
	rCVtye6aeQ2TVdAZ0fI4MaxgI3v53nuC5USH/M+m1Hs8sC1Ro7Na5qdzcVlG70G5
	dweRWnu2TduF+ra4mdkA0Uh4vE3SFX6CI3YfQI2LCUv0X3Mu9TZ0tf0paIqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717564619; x=1717651019; bh=qThwoCcfSBBESCRhBYwfYjpmcra+
	ZGjIYFsspLpQWhA=; b=Y9dUS12lCRI2Ttw20GU8477XRUcBwEy95DqAtbQzy6MB
	fn3hircpt+QODCxohQ4dH1gCOUVuP3W0Mz5J2xFhHR9CCN/y5kfROEqv4igE7XZP
	Oq+52TFipnM0qzUKj730C/TcW8Tj9GkYq3pU6Vnhc/WWRqdz0MWrNHO1OdhtLYhe
	4ISMNOTJsWPZxw0vdmtkGalgOubh1ThS/saeU3MOSyQdRhqlDrOt0dcVfbujubxZ
	8BCEWUFPIpZs4hu3EbXkOKgTQTasU9WD8QKR+6EZ3NEDZUYurdQ+/D3403FooYUz
	xIA+FW+o4epcxQU8m6p/UDCYdurj9IQWPLBUmieEog==
X-ME-Sender: <xms:y_RfZqzInsf5V-OPXhi0xg9nyVwDC7V5yDXE5wZ4U7mKQeZ7PHnT3w>
    <xme:y_RfZmQVbBXUKbcbp4sYSVMyb4ZciCcET72JWAGfgz4QHbG4IncDXkHaPGBFBa5Ix
    cNqmUeHt0NbmtAuxg>
X-ME-Received: <xmr:y_RfZsVLzaFo5TlsXOmHDbrChfUZ8q4eIeYlS_CgCudOSoYS6HJWZ9JuS4ny36l4kotxID8ne5buZhxeM2CPem1qWZmkBMtsNUPu8rXBG91VE5fHGqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:y_RfZgit-0olHyi--7V4U6nfcIiHdfZaoHBurN14GMN-6mUK1RK-fA>
    <xmx:y_RfZsCgQbpD4eGA_aL8ucg4b2UoFGNegBBWDwIItbS35pDhil_-mQ>
    <xmx:y_RfZhKORHYxa_SDUvj1mz1GrfdUkmvBm_jsLTqsK8XTsb0s3mej5g>
    <xmx:y_RfZjA7Cvq4bsZvhD1cmu25Tt9RNqiYvhQc-zDrP1on7TwJDMrzYw>
    <xmx:y_RfZl5RaBDB7d8O_y21Wtf7SfFArc_nYKqqMldJIwzYH2mO8g42Mvi0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 5 Jun 2024 01:16:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f32aa4c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 5 Jun 2024 05:16:30 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:16:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/4] gitlab-ci: add job to run `make check-docs`
Message-ID: <a44d57a7328e5964111ae9b3abc87cba93d9a1d7.1717564310.git.ps@pks.im>
References: <cover.1717564310.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+dYUejXRFJJKZgLF"
Content-Disposition: inline
In-Reply-To: <cover.1717564310.git.ps@pks.im>


--+dYUejXRFJJKZgLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add another job to execute `make check-docs`, which lints our
documentation and makes sure that expected manpages exist. This job
mirrors the same job that we already have for GitHub Actions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f676959ca0..37b991e080 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -122,3 +122,12 @@ check-whitespace:
     - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
   rules:
     - if: $CI_PIPELINE_SOURCE =3D=3D 'merge_request_event'
+
+documentation:
+  image: ubuntu:latest
+  variables:
+    jobname: Documentation
+  before_script:
+    - ./ci/install-dependencies.sh
+  script:
+    - ./ci/test-documentation.sh
--=20
2.45.2.409.g7b0defb391.dirty


--+dYUejXRFJJKZgLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZf9McACgkQVbJhu7ck
PpRTcxAAkY9gJ5wMlFMbxzTmyzCJS8p6zFSAZaec7gFaJbfVC/9weIwt+V0s8Fjz
kJkhoxBDRS+UPkNybEpbAjk1p4GMXqGxSHeGoGzIffRYjtkidHrJ9JFH7KKejy7a
qpC975HALIlS2xjU8PNqQ+F80Qf4yHnPVRR5U1p3aX2wBCldO6M+qmGiTggb3Lig
1ziV8A63uz6AkAPa+Q4KrG+7ofKS/+JjxKoQm2IuN73XdU5hc6dLW8XajGuPgJB2
L54XP7E94wZWRyfu+EyN5Uv6YgCLL5/QrXnU9auHAog4H5IW53VDBYacsbudjS5s
SRMgYa3UMb+J1yzKl3JlHglQiCtd2rLmr+gv6B2gwdgfbNdETUmWneV0ukXzICOR
zRBRsCjCE96WvXtmU7gRKiuwiUnWax27jGYT3h5WRjbgAnEvcddERBTRXUZVbPT4
Kd8MGMhufUcWa2OcJM66Mr7Gayz4if+Y97QJY6hLi/m4kXF11deO+iHHNx+T6Igu
1tAIGjYBw94vt9N31MORcpLmvOwynuNj7TiFD1qKlrf+xG+LafdqkyIFLFdfZMbW
R4FntS89R9H3IdDT9FTTmOP+apKCzKJ5fdkhfJHB3Vs8ppWLJNTIf6pJUIi1uFQA
If834SGgkgA2Q8muTDCdTNU5gVL1XAeubZ6kGmfJhYTTU+3BgFw=
=xF2d
-----END PGP SIGNATURE-----

--+dYUejXRFJJKZgLF--
