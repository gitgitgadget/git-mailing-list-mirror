Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F84145FF9
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044061; cv=none; b=ENMFP1iULV/K2gNRKMvBlT1Gpx3b6v8WOIM70gNDjliyWFiEfla5WARyE1F9b2w76uHtCis+Gw9QIfZz3CxucplpP7I7jvMyJ8ypANz7pMbD4XIqW3ZlPSXzKXAX3FU5qp0KZCC/3VgIeyAr95OEbECfxTurLc5Ffoglw7YA67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044061; c=relaxed/simple;
	bh=r+cUeqiqu5YOxPPdxa7ufRyWLgvZxk3PDr6SNonKfmg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kqbMrxneItSoZMwUMG+Y1olt+hSDjBA8qKeUG9OOcvCC5F8e6Pr0vCPnrxXswYTIGaqE6yuV1orVg0cSUjeFAFlZRXElZyVLyk/y/dFIejlApYcIeH+1fMPdnzPIx5AqIsAglwClAqd+JrL7onFL+DPAD445X2UBSElpc0cshuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P7ItG0Oc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pAlGNiRR; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P7ItG0Oc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pAlGNiRR"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id DE0871C0007F;
	Tue, 27 Feb 2024 09:27:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 27 Feb 2024 09:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1709044058; x=1709130458; bh=YwDUiSNmVQkHTDjBHf+sDHUL1vcvnOg8
	5w2YOkYbBq4=; b=P7ItG0OcDEN+Sn5KgAwl+6Zj9qWmJJ3rFTnV2wRxEWgrXizv
	wNebm2SVSSriUOwuBTdN78rLD9wPlMfpZj9rc3IhIc7jIRS6ugIwzQ6zdJbrEHOI
	t+5J4qsn2fwpz4SdHnZbw5faYsjo0pP+JwqlBfAAYPgC5Pd/NnfXSLuU7abEvl7m
	1XsVEdl8zESpHXDCEft1qRP0/uY7AmC44+zgDfwAgLUz4Q5pUxKzAjLoajI5liks
	1K8/hqpniPqyA+/A3sDmBK6mbeDiL5MZ3NSJk/dI43YH7ElXxRrpEi2lW0pzWtMX
	nXPlF42TVG5zazqBxShSyWqIrsznH/qtq1qQ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1709044058; x=1709130458; bh=YwDUiSNmVQkHTDjBHf+sDHUL1vcvnOg85w2
	YOkYbBq4=; b=pAlGNiRRk/Cw2dF+bPDS+Ol7HfBIIlcP2Od0jQoGP1sc+UPLAli
	qRlZ8Mlw9lEnLCH7/Z0fdpZedhOfcr/sawjjvKjCqgkd7wGd/RtdRMDtx2VRyQzL
	BFeojBA5J2PzcOT2AkH6yGw9cGBU2TjB1WtX0pwzlSrF7+s29Lb/pEgzXsVcbw1f
	o+3055WVg0mxY1DfMs2/Gbg9qP43VLhhgV7x1IVFWYOvsYftvPlHQK4vMKFM9Yrd
	gDxY9z/QjZIcBQkAfgOW8525S6bBjVfzAOm5kVZe6gpjvnFQTJh+v3Nxdyi2g7jt
	/9UrABLU543D5JK6HRCoxwpco/3OW0oRkeQ==
X-ME-Sender: <xms:WvHdZbIjqh4Ow_j4t-nrYJ2mBYN_HWN2BiAYkaHhDwx9FUPx_xI3Mg>
    <xme:WvHdZfI6kXbxUvcGQAl_nORDoMv9L2Cyo52CTYiW768DZIKDuTts0IoC3IpTOxCXv
    fCS4YbevP_ouhwlng>
X-ME-Received: <xmr:WvHdZTvdQyFFTpNfg1JfIuxHq60QYvjCiqk1gjFzMcFAqa4DdZF0RaOOW2lsb9AqUDJQk8pXmXka1zrGT8YSaHpLqQxaWZPfPPpKvYoPwhsQSycD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eugfeutdeuieehteelveegudejkeejheeljeejhffhgffhvefgkeeukeejtdeijeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:WvHdZUag74PaeJKa4fmhO2iIevpEIAEje1fPSJaL3C0ES0L4clm3Hg>
    <xmx:WvHdZSbm0SeWkv4jT-rarKksk5MOYdGr1InVJuGnIpmvqWJZ3HYKmg>
    <xmx:WvHdZYC-EykOiSYWsrkLmefG1Vpt9z7LWFkz205usvGlfIbH5U6dPw>
    <xmx:WvHdZSF0BX1KbxXyCZ8XHfAkFhNUHIKtMXRWbfUklW77Ioru1ei6kHXr7mM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 09:27:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 53469f67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 14:23:19 +0000 (UTC)
Date: Tue, 27 Feb 2024 15:27:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>
Subject: [PATCH 0/2] builtin/clone: allow remote helpers to detect repo
Message-ID: <cover.1709041721.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f+wwjf3s3XLxedMq"
Content-Disposition: inline


--f+wwjf3s3XLxedMq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series addresses a regression reported by Mike in Git v2.44
where remote helpers cannot access the Git repository anymore when
running git-clone(1).

The root cause of this is that we have started to initialize the refdb
at a later point, after the helper is spawned. This is required such
that we can initialize it with the correct object format, which fixes
clones of SHA256 repositories with the reftable format and when using
bundles.

The proposed fix here is to partially initialize the refdb with just
enough data such that it can be discovered. The fix isn't pretty, but
addresses the issue. I also couldn't come up with a better idea than
this.

Patrick

Patrick Steinhardt (2):
  refs/reftable: don't fail empty transactions in repo without HEAD
  builtin/clone: allow remote helpers to detect repo

 builtin/clone.c            | 46 ++++++++++++++++++++++++++++++++++++++
 refs/reftable-backend.c    |  1 +
 setup.c                    |  9 +++++++-
 t/t0610-reftable-basics.sh | 13 +++++++++++
 t/t5801/git-remote-testgit |  5 +++++
 5 files changed, 73 insertions(+), 1 deletion(-)


base-commit: a2082dbdd315aa4dd3f315545e5b3ab3b3e2d894
--=20
2.44.0


--f+wwjf3s3XLxedMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd8VYACgkQVbJhu7ck
PpTN4g//S+iS86/KgnL16Rn9hg0uoXHBOesf9JPSpH2QCmDBxhoTLOlde1ms96p5
aLNcUgIIbFY+56nb98Rs66sSrskMTt3sni5ImkbG1cQyP8mp4iPjhsKlrTD/MTV5
E500FWeLmFBrq8ckTUscSVW6aZV2+uI++DltIQY54567/rxRSBAE6FigjL2+YSsA
4eA4+3foCcn4qvMbcWmdO2ZxC5+qaapPm8JgeALL7Jj9oB8niwBMItH6l1TId8pv
Nu7438L0p11ANrOnYovEn+iOuSZ6CfMfoJi9SjfKd9PoBq8b2yP21DJpApGshpgE
sV02TOE+iwlyc9dADr67K8XLwyYOtA6Pyu92Tnr62ndZ/VtHGQ1gU7SsCAGmNJPw
UcFwFiP8f091TlEHwxiO5xJkMZ3xynqTjMbeRmfvw3ya5+Hsar19DnPhKRKjBBQB
1l43dJh0jxbpvatAGuameJwGotb6LvIaf0kowG5FK0nK3PIEarW+aHzAZB+n6Fs1
vMw0Qh5lXQTix9xCwrGSaC7avDQI8mHzjOtIcQlFvFf2B6gNHkxjIEqsqi1Nwb+T
ElXkQAa0bMbYqooy6IgHJ5Azfn3yN+8beGlPu954YzllS3tinMo71RrbwqohdTLl
8KHQXE0QszvIX7J27dLCoEG0z2OVm+2MxIgDFkO5PCj2aYjlSpg=
=7s4D
-----END PGP SIGNATURE-----

--f+wwjf3s3XLxedMq--
