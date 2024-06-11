Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95682176FB6
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097573; cv=none; b=Fb7Z3tsC97f7tRHig4i9rS6hphIqYVPoZi1vg+oGwuFcSkbih+5PpZYWd9I1KBwW9ZPy4eOME+PF8+SVhokDD9AM8Uo6ijIhf3PXNrWV472zsBsukylpW/7MjM+7zxVARrR1FBGCO+eOomY79TO+HgIdWiZ1twAI4gr4wldF86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097573; c=relaxed/simple;
	bh=s+L1fJHIdFgmESsJATeNy90ipyLiMfdpJUEhOYZzK30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGFu4Uu1x0NXnoze2xe+cdvEhO3Yxk8+KzqGSp7spfTI5Tp4hXQgsDbwkYwBlYHYX1cexaTH6qAdpiQKNCm8H56vwMtzPETIiML8mdHvOqN2QYZSsUTmvydwp+YFUd/1I1iHEpc4oI6ICUM3u5YlMAyIFp3PBxCxh+2Sngk6TGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=llC3KEI+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dcozMnH+; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="llC3KEI+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dcozMnH+"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id AF194180012A;
	Tue, 11 Jun 2024 05:19:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 05:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097570; x=1718183970; bh=VfqMPyP1Y1
	whilEikaaGCSxLpu0iErYtiNxrEQ6lUuA=; b=llC3KEI+3dqVo1NFFWL50TQxk6
	HZ/lqiSCf2vcZef5W8Iizau8dQRPf89ktZTS/PAHYvO8jli81OS2dl6CZOtTgzTH
	aKRQyMjVEBzPAlDo1kve5xLcl86MChOzElk7izAFOhehUeWMGxAZCbyE0G0fE/mZ
	Pf+ILviuGE6Py6tQQ/7tQPvgAM3jY5cOpJdlCHQhMSscbUWKmqu8vi1XYeZNSvFe
	8mqMmzWlR1vffRdWa8mjzMFUqdT7rBej+shErWZHdQn6qJRuY1kI4r16BwUCBGtC
	Fj55Msu9CHnvasGXk+Sdc5rrlzaRkGBazDsIpCPEWzQvkZ+kcaAQsh6ze7Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097570; x=1718183970; bh=VfqMPyP1Y1whilEikaaGCSxLpu0i
	ErYtiNxrEQ6lUuA=; b=dcozMnH+kLmCrCDnWimu2JkXirZHRc9nvFlPkFwZ3PpW
	c5adE658QpVNJczs8bHLuRo8LtycIst3Aq20IJQEmv82XzzhR8XVDzlTL230+ZtN
	f4cU5zqiM5UccfPYhYHmQyDqeMNiNl7wM1BBUtgu0uAuSake/fg5cELAAT2Efs83
	oBohfot+GQ4/o+5two3zEk8mLkkdTT4OY6eAPXnd8USexi/w0PAz2SfG/31n65zb
	Xus/jee6LfrR2n1ozRBbT7VwTAn+he4EJ6JZkmJU3+V95uxZNUV5XYR7j3BvrB1e
	k8g3utPy9EHYWkH9fX9a/FjUhCpki08zfThK9nyGJw==
X-ME-Sender: <xms:ohZoZjWLtbGiSCKmTyombMnHREF1b1OIuuRXJS8j3Fxi-dyclMRqBg>
    <xme:ohZoZrn_L1jmm5qo_Sy87qd2bruAh-IBobhB-PK51WIaMhMkD-PbUlIxmhSeFQtef
    LEYc1a1lf-8GCidmg>
X-ME-Received: <xmr:ohZoZvZvHNB06ZNgrmbCvF5-k0YSjmaMrGQEZJ5rWAXgcB9bMcyNvfM3YHz-De4Ci8T65VkcNpEbiWo3cDqXCawrB6Q2CT9NXCUmEYXH7efwVR3x2Ne1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ohZoZuUbXvgw52cFY_LaqNsNOEC0wXI8V_KRJRPPBkntopY-hls0qw>
    <xmx:ohZoZtligdYVRLvShahtqMqJuxOaeCOV6mAtUgcEL3akmxdReAkANg>
    <xmx:ohZoZreo2GJt29fQxGXURGdloklSQ000fT1PAiugXVLgTdl75dTYlg>
    <xmx:ohZoZnHRJWva5HaceTFEhH88QVQmpFeJdVdOjhPyAxPNRO7_KcLy6Q>
    <xmx:ohZoZjjO0j-fvHjARXHe7AVpPYBaVcmf_JnLAmdQNQUBmRdI29O59vt7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:19:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id df3209aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:20 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 03/29] notes-utils: free note trees when releasing copied
 notes
Message-ID: <c5f49bf9305940f6d96a71468f07c3f0effd533e.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FdeXHMLyhCMCm3Tp"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--FdeXHMLyhCMCm3Tp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we clear most of the members of `struct notes_rewrite_cfg` in
`finish_copy_notes_for_rewrite()`, we do not clear the notes tree. Fix
this to plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 notes-utils.c                         | 1 +
 t/t3400-rebase.sh                     | 1 +
 t/t7501-commit-basic-functionality.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/notes-utils.c b/notes-utils.c
index e33aa86c4b..671d1969b1 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -187,6 +187,7 @@ void finish_copy_notes_for_rewrite(struct repository *r,
 	for (i =3D 0; c->trees[i]; i++) {
 		commit_notes(r, c->trees[i], msg);
 		free_notes(c->trees[i]);
+		free(c->trees[i]);
 	}
 	free(c->trees);
 	free(c);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index e1c8c5f701..ae34bfad60 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -11,6 +11,7 @@ among other things.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 GIT_AUTHOR_NAME=3Dauthor@name
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-f=
unctionality.sh
index cc12f99f11..52f5e28154 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -9,6 +9,7 @@ test_description=3D'git commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-diff.sh"
=20
--=20
2.45.2.436.gcd77e87115.dirty


--FdeXHMLyhCMCm3Tp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFp4ACgkQVbJhu7ck
PpSV0BAAljQpeyei1lZera1xjNhjGxY98DXdeVMHKQzKXKcYe5+9Js7kDfW1MSu+
Pw2Yze1qPUD3mdHsLYwSXHwgY4xH6d0bjrXQXUOJRstksqvLNdrxFRnY5CRQH4fm
jzvuZwP9myGUVpF18y8pP8V/jos+ehhiJw81ca8mbu/WkWr05Gr+0FftmVli7rZ1
Q8H/AV1U0SVDZ2fboGZLFTB1pW8fGE9lnVTK7tWF6cIW8hdUOFp+XYdBymXjB4jI
9lmMXbMdrJqLH85T0YEvWz4zF+y/mmTYg9+71W4sTcrVd4wAtP5KlPDJHFDDthkX
84kqjPubeDRnwFT3Psf83KJoh6NOCHZrRuFtUWbalDNraqOtSuuQ4rWA8xzFcIC1
nTMzu2hBuhBO6I+2klVHtj995kVM0KIOGeBH9dtg15Z2RjFOBhWURpuaEItp5Snl
3xTyDved7lBPUmnVYyusWhpRoD4alz192LcCPc4bBswOVwmbYTeQEs7K5y4hfYMA
00btpyjyUiVLJz15exVkStHhgWR6dRvuhrKh3KnQGFDJVGPph9Tqe8JRazedK1y0
WknucDxhY91y8/sKbHsiHrwQ87q1g+/U8b/uKWYpBqpL/bdFqbJGiBWsLieeNIVO
7G1tmDKoSCL+YkH+0n/NUsMUJgpMmLone+bfElQHCNh/n0BdzkU=
=doIo
-----END PGP SIGNATURE-----

--FdeXHMLyhCMCm3Tp--
