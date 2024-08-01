Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E55184546
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508881; cv=none; b=WOjl0QtxNTh9icV8ARhxvPXoXi5kHc8Opo/UW8CK9H+3FB7gJEI4bIpq9XFhtcl5ozFcEV+5Xn1X/DYNbFTfKjTFetHynlITttdnNZ2vYIcc9tF2su2Xzbhb81d1nnY286jmyWugdUgqh0UI/sN/evGnWqv8c608qKKqPyG30gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508881; c=relaxed/simple;
	bh=HuPUtDMYEDAJHUMOvCG3UvPEm45Dt45ZQopfKebsk/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjT/V2DUoJKSAjuHhm7qK04QPRlcpSGkRGtHFpcmuJCVi+Ptfg3JZ0XtELPZ85XPonbGd0OC80oeeGcAHllz0sYfJKiE+9JU2h98WW66w9vje4bSfgZmsgEOfldM9SI6P5IqeMsN7cE1eZparmJZMsTNGAV8fXFn0h80pvxBUjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=in9d/SwD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSMvOPzf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="in9d/SwD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSMvOPzf"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 52A93138783D;
	Thu,  1 Aug 2024 06:41:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 01 Aug 2024 06:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508879; x=1722595279; bh=29RrOxR8nP
	sUVeCZjA0JrTrauARyJgRLh6JPoY0NymA=; b=in9d/SwD5R6JVwUGNS0lpcYLU1
	H++clqorRm6UfPfpO03ZB6EZdnxO5AbFYnq1UOQsBrDB8bjJT1VII7zxUWjJjtIY
	CUwMl4xghV5snU3ZhBbAv2+c/7bhFBswYD9qFqFSe5f0vGs6EKiBSiFvH/Uq5jcB
	ni7f7TeDlbacOKkBMVfF66NsZz+1fa7a9pLUmEzVHiNnAY0TuI0QF2EB2HAp6DZH
	CkdNh/Zp/1cJj3p1qCV3qTphr+7B4vTKXhtSC1NtZvSE13LwkvuThBiPr5HjVhew
	zghcT+EzpjgKDr40LbPmwBsXdP5X+KuTMnqw3wjTY882H4wSwGC12F9BEuhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508879; x=1722595279; bh=29RrOxR8nPsUVeCZjA0JrTrauARy
	JgRLh6JPoY0NymA=; b=YSMvOPzfBdEvsOiTJbo3tjgiZh+M3a8Cdy6/LtuMcF1z
	TS+W7YGPwekkp5JfptbDw8EzC6sSqOYq0NFRq3qhsu71EVgj3GYnRjACPNFrx6rI
	euDDPM3+a+T2W3czf7YkxqT8VJ6OAeei/E+X/teZrL71nWDdcRPWkfbrBti1CSSa
	k0L6cjxztKhMpHq0zFgu24fotGozW82xnYaurtsRdWRHyPOgouIrI/TSgh/F6Zxf
	B2OEyIlaxWuUs1xTDBrkdZChBvk0kd7m2JDaWuK+XgEyTbn2wNjKXCHUOfqBsN0y
	X9fcPoxqEw/Bl33wDBd80gI2a8NwAecjk0uV8bNj+w==
X-ME-Sender: <xms:T2arZryRuBg6uDVjNRAvvfaV3WR5zrIVoOhHb-qHODREnCOriWMweg>
    <xme:T2arZjQRywLcv7kUgMeKfjxesntHnw_2C2T4vdRiDUiw6bhQ38joVtucLsNAdQ1Zc
    tXbPgEhlvHinygRbg>
X-ME-Received: <xmr:T2arZlVjO40ISm_5PqwnIoToqNrWWviRyJkzZne103I5wwaKVm9rTfEbuJ6PIzTZaTJVOHQKQjenfWXa_4pWr-6gIDrImNJdVT2NcthRmu7s2Ho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:T2arZlgVxwo2FuZqaRPLdZhepGZC3z7Khbr1CX3TjyUyzjRoQwV6uA>
    <xmx:T2arZtDqVK34u04odjrbifs4_OHaO2B1f7e8i-Qrve-WbnilnlRPHg>
    <xmx:T2arZuJ2xXB_OHVmmVu1BFih1KeW-aO47Syo3KfqloThcdkKeHIHqg>
    <xmx:T2arZsA72HMSdwOuz3tYfdgarsVw9s_rGtzlo8ghFKbQ4fobzaRwig>
    <xmx:T2arZg4HSrYg_MABvI_trwboxvGBoC6fRSwMbM6F2svndzgO0F9Nh33o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:41:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c85d2e8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:39:46 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:41:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 24/24] commit-reach: fix trivial memory leak when
 computing reachability
Message-ID: <6db1829c79401009c81cd34322274e4196114fcf.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E8D1/U12IgAZAPUs"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--E8D1/U12IgAZAPUs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We don't free the local `stack` commit list that we use to compute
reachability of multiple commits at once. Do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-reach.c             | 1 +
 t/t3201-branch-contains.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index dabc2972e4..02f8218b8e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1227,4 +1227,5 @@ void tips_reachable_from_bases(struct repository *r,
 done:
 	free(commits);
 	repo_clear_commit_marks(r, SEEN);
+	free_commit_list(stack);
 }
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 800fc33165..6e587d27d7 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'branch --contains <commit>, --no-contains <commit> --m=
erged, and --no-merged'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
--=20
2.46.0.dirty


--E8D1/U12IgAZAPUs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZksACgkQVbJhu7ck
PpRWuBAAp/JW4Fblj16BZmE1XgG7FA9PIib4GlsI4aDCLXMdJJHRifEQWZV2LB8R
q6k5UUu2NVjhonL6XpJlCvojuSJ7OTkeEdSDkXPiyNCPB9QInWvmgdalGPzT/UZx
WB74DzuNfPOCdLJPGQi6xhmrm+v2QXIMP4WIXwmRoPo2FJ2kZGol0gLeG3aALF+S
kNGtR/yeFgNRbmNeFGTa70rL9nSeCVLAPoB8N9aZ7EXskLd+Foswb3/Bf49+Qm+7
QkjEU0uitVcm1gzxTWaXzwnfbS+z3xwlFKAolKnq18VWFqdl/P9KnyC9fnRbfmUC
myfCs2sUQCdXa5B6bh/r4UfzVU4A6x4HeeUia9XWvKNwXgH6jlc9VoFskl6ba/u4
KqkT05yS871BqSG9PrPeA4g0vuBvsFzqCpgrkaesAty8WgGLjb8al5Ab8MpTtid3
iSMERsV6cVtcB0wnlhlKq0IFGDP99abVSNyI15M7xR4AcNuVWJSnVoe7T2RlsTfY
KuLOjJgiZGY8Bj2HZuHGMjDNKicy43MH3oLcpuw82XWlSjc13JsKRBaAX4MxRHww
OcIJDC0RPxhguIkFekDsvhikO3A+bR45hONVON2t8OD+DuWjC5YCXMVQdO+TLwbT
F4PwJSRWLOVrVtdJ/LwSN+jnn0zScXktJj3Qu+knw37kZ2/1Qbw=
=2DNs
-----END PGP SIGNATURE-----

--E8D1/U12IgAZAPUs--
