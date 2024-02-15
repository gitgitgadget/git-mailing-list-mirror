Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FB9134CC
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985540; cv=none; b=NDHkrxbuR0I2sUHVubxQwfqOaVD1m/N2iqbEvaURfHLBB467owS0NdB7I75yOHaRxWRbj20OySOHMvHNDHQ2E5oC/0nlCZ3Ls57R6qo8gCbWk78thM8fWJYF1LdvWdqVKhEkUxc2leBPB2HJ6gH2kN4oMvHUJk+90LDgkmsMlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985540; c=relaxed/simple;
	bh=1FbRW2BUER9MhVnivjqEi1viFH9E67KE+xkZ1ookr9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCNlmHe1i1S3iJ3GVz3JUEFKT+MgL3m6BK5yZB1Tranmsq6e3iLS88aMumw/EoOk/m3Icds3ExVALbu5mTd2KFxxMYeglMVKT8cRuELwM9wHrhlJDIMpmEA0LDzGz8wgjQAbePxeLFZjrfr/zQ/k/tDZx37Wsq8TSyy4Dh4Doyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bk2Fvtr2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N8vQFDY6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bk2Fvtr2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N8vQFDY6"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A2F8213800E8;
	Thu, 15 Feb 2024 03:25:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 15 Feb 2024 03:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707985537; x=1708071937; bh=K3wgQYVEqW
	NliaVt1m44FsXq1WsYguJUG0yTnEEBdIM=; b=bk2Fvtr2gL5wAfh5UL9I1hdehp
	62S+9ZpjsmBfJLYoV6/5dhqrEposNbNs6nIr1jXfVsuePZSEUHyFeRDTaIXVDnOm
	IN/EL5b+RkI/zeuax23nxwk/zWssh8UfvTZKU7Xgt5Bz6nHoSbR4nqRZ72lo7Ju/
	web+5z3zbb8jm6AkgCMueTkbS3gZyXncUr+4MRd8EAhLr/gnks+ma2ZXE8wX4r4+
	v55bM24n2nTDDk8Uh3tzk5Xy4t4KPWRvO8+2k9deygP34GA5B7JG/QNrYnxURZLW
	dIjTcMNAc2aNc/zIMDrGpptJUAxl/Ppt3EONxtwtZOwRR+HyNRFzsNBPObgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707985537; x=1708071937; bh=K3wgQYVEqWNliaVt1m44FsXq1WsY
	guJUG0yTnEEBdIM=; b=N8vQFDY64ys7PXsOw/Lr2SGCQ5+EIg6AiOLcyLta+XpN
	gZXipfwMSUAvE5F/PO1XRAw8R0XKlzof6Xe5KmPdsR/n3GHcffztOwdylzjd9GcP
	F0pVsbKXGnd64qAP2XKmZlx6pnNbbpoqCutEw1NHHJylpMii9+Gordz06Qg0Wgu3
	PXuYdhLzlnn8o1T1oJBqVsIYlf1HaaA6Lmit8l7vspl44nXQgEmMD0e+a9OIhljA
	vCuMq5A3dvreSjlSoJYZJkm901r4QFtpQfVpfGZnSzYyI0pIxuZRsGRew6YPv/z5
	ieCG8oRrsACJATFKoz1PTjtNrx2xaTC+tzDj6F6TDA==
X-ME-Sender: <xms:gcrNZeKrhE82eG6tu5DdptWnO7D2EPnKIqHqNzDXp_pLYkt2hcw64g>
    <xme:gcrNZWJXOMb85DkuO8x-mzn3xFbDextzlyN345CQx2h7EXeJfYj2fHvPlyr9eVop4
    tbtshyVjBrUSiSQMA>
X-ME-Received: <xmr:gcrNZeuYN4Zzgr671r0YqksgyX9ulvHHWIKQ_QDyULNtxzstqzfK0pSrXAXsn0NnXvSW-bJazA2ikrwqrpULXIZ8WeIqKnz_QVWk0HvZiIMC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:gcrNZTaqliAnth-nzrONuzo5zuSm7Aof4Nz53Ek4hxkHVbZl016W7A>
    <xmx:gcrNZVbBHjfB4rQBbIOl2qr6Y_ov2sYRixx7OrDP9PI6KohslnkFsw>
    <xmx:gcrNZfAx-mn-swkHKAxNtgAAAPAdycUvuxO98fn_dNk9u2frU7BoKg>
    <xmx:gcrNZZHlnDvjjCjebqiN-AWtz_gXRh1anSRGOIAJ1O8L7P-jdM6XsQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 03:25:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3324e75a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 08:21:44 +0000 (UTC)
Date: Thu, 15 Feb 2024 09:25:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] t0410: convert tests to use DEFAULT_REPO_FORMAT prereq
Message-ID: <2dd87f3126cedd39cb5b113053c90ee35ae0e5ff.1707985173.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
 <cover.1707985173.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wLQkrdE2vUAY2qP/"
Content-Disposition: inline
In-Reply-To: <cover.1707985173.git.ps@pks.im>


--wLQkrdE2vUAY2qP/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t0410 we have two tests which exercise how partial clones behave in
the context of a repository with extensions. These tests are marked to
require a repository using SHA1 and the "files" backend because we
explicitly set the repository format version to 0, and setting up either
the "objectFormat" or "refStorage" extensions requires a repository
format version of 1.

We have recently introduced a new DEFAULT_REPO_FORMAT prerequisite.
Despite capturing the intent more directly, it also has the added
benefit that it can easily be extended in the future in case we add new
repository extensions. Adapt the tests to use it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0410-partial-clone.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 6b6424b3df..0f98b21be8 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -49,7 +49,7 @@ test_expect_success 'convert shallow clone to partial clo=
ne' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
=20
-test_expect_success SHA1,REFFILES 'convert to partial clone with noop exte=
nsion' '
+test_expect_success DEFAULT_REPO_FORMAT 'convert to partial clone with noo=
p extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
@@ -60,7 +60,7 @@ test_expect_success SHA1,REFFILES 'convert to partial clo=
ne with noop extension'
 	git -C client fetch --unshallow --filter=3D"blob:none"
 '
=20
-test_expect_success SHA1,REFFILES 'converting to partial clone fails with =
unrecognized extension' '
+test_expect_success DEFAULT_REPO_FORMAT 'converting to partial clone fails=
 with unrecognized extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
--=20
2.44.0-rc0


--wLQkrdE2vUAY2qP/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNyn0ACgkQVbJhu7ck
PpSrFw//caGwvvCOLBlsWRDOEcLxAiDhdPFGLKzvQu1qCMBDvpkVdP8+jDQ8TsxC
hzNu1/k08itOtwNQouu9J2aFk1r3gdZXK2l7ju0Dk2Faz1wobd41I6KOXblPHu5Y
HCk+lwIJEFQVSyXnqxSY9YjCXVLMPs6QcfFpMtcVJrMjTaAIYJjU1awHqSjZZLL5
YGF4nRvksUFvOBHtEB/TcJEwcahV5e1Ohc7J5vTjnHvV/cOR4p0iABpFUZBKcQyh
a9+6PNnL1tiBrpjaFr0LrpRIOlKRrRWbziesnM3AhiimSB8TPcBhkxpdT2mVRht5
otWK50cQAkzVvYWeHyR1Eq5bDQezvbMHXd/LezBImQtRQt1o0bUbmcneIe2i/AiP
y0Zqd2tceVQXFKMBNkuMJIcu/B0nTO5u/u7S8neoezKwHkaF8MJ4NxMILOmQzSmk
/Rz4sDSq1LrS1iNCGZxTiCdRvWl9yQeuF9Y0t7D3jrbBQW6FYpwbZ05IWbFRr/Aa
35azxbjzer55rK+yiMQrhogFYf1/o9T6iMFWyz/lOei73nYJDuGaO1QdIpWXUSxy
F1wki//xb3Htqw0YoslYM7XU/xZRdQwKD5aPYSY2QuntNPyZXvZ3KuDzNh6VtzPR
5rpsP7Mrk8Uhlw7iNzjn6kiw1vHFi9MNMwz6b2RPHrlqPR0MTPU=
=nHZF
-----END PGP SIGNATURE-----

--wLQkrdE2vUAY2qP/--
