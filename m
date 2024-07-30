Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6A145FEF
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 05:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316970; cv=none; b=brC1JGa8D7UQ0wzXR3ik8bu3elc4hkBCtmyfi40epvdladblYeQIH49RQPHkEfxZVA43K1gJUgnR4a3rBHeF6LP8L57I8pYX5EN1Wb2RJD6o8SiH/M7+cgjTrqxGRPg3dtdS2hfsnTTf7cIi1nmjUxFSvq6F3M/oUZlStG20Uac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316970; c=relaxed/simple;
	bh=Zsc7b6yCVYOxuhpk9NbHrtqRMqbE8OzTmEtUFlItwsE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UQIWFkoo6mTo/0Fn3AVRIX85UNgESfk3glFU1XD/WSKnlakLbhC8faPDKsbnYzNsSsFwCANwp26VsUW51khpmkGPetgwMf/dYMpkDHaa7x66aqfb2sx0UbZT+g+GUccRDlxMSCW5D+UhmKmWuVdsfUr5ybzQT60qc0sz/yADviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xz2dFYz7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Icq7I4HX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xz2dFYz7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Icq7I4HX"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 15B0F1140459
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:22:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 30 Jul 2024 01:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1722316966; x=1722403366; bh=TN9fU1Hiqr/3olTvRYxpv8nhQVS8vfki
	VyKOUF+2NCw=; b=Xz2dFYz7qDy9Sbw8/8eM83BcSQhR7ujqGqiaznJdQ+Cm3hO3
	aXEvT2tcBWIQ3kWZhCC0L1THCNy1Q8RxPlr5W/X7WiD5uaJhEPwENBlvA5iB2wz0
	r2h/RSa8rpPyF9lqQbLxwcHu6CcF8B3Q/akYDPN5M9mtot2yqAIwsNlSm2ZkFoLH
	N+fIMKwHY4ttLYzrigusV3s6M34bEFMrQs5muBHxNnx4pEph9tCm8t/j0NxdL7Dv
	VHxHF3fhG7sv1ZMvOikoUuSh7OyR8TofY4pbFRjJNqJ8C+1OcFiKSqVVffYToBhh
	Wmov00pXYrL4cshNhv0qLPpxe7cAg2LAxJwydA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1722316966; x=1722403366; bh=TN9fU1Hiqr/3olTvRYxpv8nhQVS8vfkiVyK
	OUF+2NCw=; b=Icq7I4HX1AnStWGqm535qcA0eQaBG6jVRaQBK59akVCfDnjj0q9
	IzRwOo2nnTGZ5yDFI6MxozoSP+90OKN8PKGBPpTa8nzAaUq/IssA0QhKWPIkQnot
	JvpedHnSNgvfiFViEEZCNNA1hJafMLieB+IcaFhrPVct7vz13UQyS8zPfYBcapMM
	SIByKB9m/yXt9JOZh+yVIoNXVWHy8yachWY4UFLDrgT+OGkLTZQ0g8s+E+wa8k9z
	wzM+2h1pWVMpLlAB3yrYytWoTwipBNt5TuGuD54X0qm/yB7g3QfnVHskVsIe45IY
	PSKwvinkx8xEYtf23+isl/N4hH5BmzjG59Q==
X-ME-Sender: <xms:pXioZsYofAl-8KiYvcpze3ZMADn3f8bWeLAfoaU0Pq5a2Qi8lzx2kA>
    <xme:pXioZnZc_Sh5N_UrukTL6fF0mnHY0VzTDk2ppnueboJlcaq_I3rTECHyRr9Y6UkAj
    VBknRs2XEj2BaV0cA>
X-ME-Received: <xmr:pXioZm-6Gp25JTR6rXLN6eg5-e5lKEYPhdHEcFIazsAfNZB9iFd2WPbCcIi0b3h5JTq4f9v_qHjBolGdgLgkccADF1z_yRqs6dIPRroK589dPSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:pnioZmqHGE2iIMF6u01ptxrq7DdmM-GR55lcdAyGrd5u5rwxuy68Ig>
    <xmx:pnioZnqoFtuWLjH7SvpM3u50aGyJ7bK5Jyfv0Gwf-mRoNc19F7-Utg>
    <xmx:pnioZkT0YUEyGsCgdaCV2OjMvdMj9lRzDZgej7cda9Pp7wOYMNYFng>
    <xmx:pnioZnqqd3Er4zg88eYqtbJFW1kdq0U-UHcwspHr44HUuVFHVAT5NQ>
    <xmx:pnioZgBW7a-5O0NhNv_qTUBAx9xx50UdPtIZB4cFFkl1_cRxr6QnJhcO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jul 2024 01:22:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id daa6b019 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jul 2024 05:21:17 +0000 (UTC)
Date: Tue, 30 Jul 2024 07:22:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/5] refs: stop using `the_repository`
Message-ID: <cover.1722316795.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1CKLlyiCmwO09Spj"
Content-Disposition: inline


--1CKLlyiCmwO09Spj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series removes use of `the_repository` in the refs subsystem
and drops the `USE_THE_REPOSITORY_VARIABLE` macro define from those
files.

Patrick

Patrick Steinhardt (5):
  refs: stop using `the_repository`
  refs/files: stop using `the_repository` in
    `parse_loose_ref_contents()`
  refs/files: stop using `the_repository`
  refs/packed: stop using `the_repository`
  refs/reftable: stop using `the_repository`

 refs.c                  | 16 ++++++-------
 refs/files-backend.c    | 29 ++++++++++++-----------
 refs/packed-backend.c   | 14 +++++------
 refs/refs-internal.h    |  3 ++-
 refs/reftable-backend.c | 51 +++++++++++++++++++++--------------------
 5 files changed, 56 insertions(+), 57 deletions(-)

--=20
2.46.0.rc1.dirty


--1CKLlyiCmwO09Spj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoeKEACgkQVbJhu7ck
PpSEKg//ZaHBF3kdR6qdFOFQQqroYwpoT97G9hXpY4NwXrHbLgzOne+/nVE3Rq8c
TMo4CB8/3WQx81mwKEvoaS2xv0oLDISKxHD7fzHOqUgxITXCnBQNyS5THh2B4JEZ
ZZJcylDhFDY4Rgs6fBbQFwbwgaEW246oPePZl+fvHOlNYoJQwoxk5XvEHZS+x/le
08yDYVVsH+sMkbDF1DEZCFcIsq9WfDWSqX29ol6d0h5+4poMoaOUo2Sn+mgtinan
RbQyyW1zf1ijXreyzHSuAMU3p0v4dvcSHNUQfFhNKFp7gxUdf2PXX1mcM/U2Pg6O
s5SV8kj7Qc53J3CIDxBs4n7qZrdRAKdb1YtP8XEJbi/el7OyahhLTHMzvvondZsg
EVZWjyxRZpr4b3b4lZarNJGlwlnk07VDrxzoYRpn0Nmq2wwHs/CZsIT6yrA5iD+I
GrfOxMyMztwzCAD6VP9gn7YxCJAH39yS6t3Ei3ZEyvQtBmvxKnOViTDy85Ca6bq7
XJLxclhjxbZ5C9yP2gpXF19aTVOl8SuO6FU+LMYs6G5oVTZxOuCEwOpkf9D9+TVk
fnwxGFt/5sxfkMCd28Pzp16Fu0RFtMHVyS2noz8SqfdKJ9+ZpL/z4VXq7YabFQ2x
yC6R2/mmlG86uUbQFUSEUfB3W0a+3aJVxkXZVM5Wdr+vd4TkJLQ=
=6qK9
-----END PGP SIGNATURE-----

--1CKLlyiCmwO09Spj--
