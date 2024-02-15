Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67912B7C
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985556; cv=none; b=htLsjj+9loPk/asbx2OOeJfyJGltpWwbQf4070N+ApLcuGdnThwHKEbBByCp+EfptqMspQoppJXsCtwTCDouZw8P4CwQLZ2jN4ggG595m/bruj90+Z3Yxi+VdcxA4jYKuSM27BUv1Ck74eJIvjXHwzSCBa+CWYNDmoSvSvBpmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985556; c=relaxed/simple;
	bh=CuewBXxU0lzTsgHWiRaXNk4EpbMjCHo7noH4lzXLjZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXP8dYUB2rVhDjCsCAymBvTBMmwiM3hd5q/SFYOCiyerLyq2BuMWq3f+glWizKXFMQ3Y8gcQsAnmrteSILlkLcNVlgVTzAuLGW8CLyHMhZ3sBsL9N7k4SVoZw5c6DwwyOPI0daB77qcazox3hrimrxG8HXPnbgeiENqcAiiUpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oxn85g9z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MxzM4Pzt; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oxn85g9z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MxzM4Pzt"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B49175C00AF;
	Thu, 15 Feb 2024 03:25:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Feb 2024 03:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707985553; x=1708071953; bh=IMGrO2ywS0
	jimCqZg9sHwGeGR7mHdKGOkTSDfFj0syg=; b=oxn85g9znBjlq0KZGqUzOiI8Ye
	xoFmzhX54tgiluJH1mnNhSQ9w79x7rJncOWCYHHsLdHu6Jzf4Lb2tv7eDSSCel8l
	aCOnBWEJ/B8Pk4HMfpChdPrhmzzmbACHPAXpxhGX6h+vOTherWL2fopQHbj7G4uY
	J0ilvu7wqA1C7YFAaiAoU9gcoIMnlIp3ROODfckhcg/LnWfyBzb2Zo7yagCLTLYj
	XSswbnc5Ev6tk1inEz1ZTA1Xzw0AjBfRUgBILahHyNRJtqq8IEaXaB1DbYSCG9ga
	KIiS5JNivOhXGJlTmfNEPXHpGWSVSQLW8oY1+IY5FVMKd0DtqCevbIHxr/yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707985553; x=1708071953; bh=IMGrO2ywS0jimCqZg9sHwGeGR7mH
	dKGOkTSDfFj0syg=; b=MxzM4PztdmOaO+rXR/jH4OWkRC/ALke/E7Lhh3sRn/4n
	WBRakh65SVxRefWC3bsOtGbFCRlO6i9AYmCKvU3vfkii85uy/zgMRy707V7H/L4W
	FGR5S2EWuwietJZdJ7jv7RD41BzmMsj2/TmeALHxI7gn3hSipvec7+qKnSj/oS6P
	2J/ucH9XpXPV1yMijBWuSOhvi9gl91vPRdGIbZu5zbWEKzV9xiQRNFxSYKubENN8
	kM5NysZMRddV5TzB2gw2mNz99N+ACfDzspkGhB+xc3xxmm6cTZ3ejnFm4PMyzbX8
	6E4YYFjJX2sp/Cep4movJS4lWd917bmu1qGkfMxqlw==
X-ME-Sender: <xms:kcrNZV-Ky5hKOpFrAGR1rSob7EbgfFTuksEcd3MSh9U3hRy-c7qLvA>
    <xme:kcrNZZtghSaK0n4_e-jI92UZZzMCCBaqa_7pxx4ojtHA296bT-IC8Pg4Iwpml9lGY
    Im-igkvIwn8U-hOpw>
X-ME-Received: <xmr:kcrNZTC82auMQrv4rVZtPGHiymT4grRmybiLT-tFiF-i_tF4ZI7rGSHxABIpfaQLqAJ7t7hIixP3LBLtuVeDEMczqTRvH6V_D7YXSdk1CQM7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:kcrNZZes6ysm-7DjJ5EcgeyiPD7KhmyWB2weCaWFG6jZ_GgLZt7uUA>
    <xmx:kcrNZaPq37knI82ybaFXj57eTw-7ajD7FSLW9cq0OvPSZ4wNXMBoAQ>
    <xmx:kcrNZbn1T3o5n7BIh4nWMaf617yHLWQ6Yt5f58hMvO3XUj4zLLIzpQ>
    <xmx:kcrNZTaJ8uuq5FuaiRhVtKc67-U65hdoFHQPhbIru967Wupj_89aBA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 03:25:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0aaeea14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 08:22:01 +0000 (UTC)
Date: Thu, 15 Feb 2024 09:25:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/7] t2011: exercise D/F conflicts with HEAD with the
 reftable backend
Message-ID: <24051cc246b9d515ee2ea0418e751e47629d7662.1707985173.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
 <cover.1707985173.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp13yGi/ikpLuabD"
Content-Disposition: inline
In-Reply-To: <cover.1707985173.git.ps@pks.im>


--bp13yGi/ikpLuabD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the tests in t2011 exercise whether it is possible to move away
=66rom a symbolic HEAD ref whose target ref has a directory-file conflict
with another, preexisting ref. These tests don't use git-symbolic-ref(1)
but manually write HEAD. This is supposedly done to avoid using logic
that we're about to exercise, but it makes it impossible to verify
whether the logic also works for ref backends other than "files".

Refactor the code to use git-symbolic-ref(1) instead so that the tests
work with the "reftable" backend, as well. We already have lots of tests
in t1404 that ensure that both git-update-ref(1) and git-symbolic-ref(1)
work in such a scenario, so it should be safe to rely on it here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t2011-checkout-invalid-head.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-he=
ad.sh
index 3c8135831b..04f53b1ea1 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -29,36 +29,33 @@ test_expect_success REFFILES 'checkout notices failure =
to lock HEAD' '
 	test_must_fail git checkout -b other
 '
=20
-test_expect_success REFFILES 'create ref directory/file conflict scenario'=
 '
+test_expect_success 'create ref directory/file conflict scenario' '
 	git update-ref refs/heads/outer/inner main &&
-
-	# do not rely on symbolic-ref to get a known state,
-	# as it may use the same code we are testing
 	reset_to_df () {
-		echo "ref: refs/heads/outer" >.git/HEAD
+		git symbolic-ref HEAD refs/heads/outer
 	}
 '
=20
-test_expect_success REFFILES 'checkout away from d/f HEAD (unpacked, to br=
anch)' '
+test_expect_success 'checkout away from d/f HEAD (unpacked, to branch)' '
 	reset_to_df &&
 	git checkout main
 '
=20
-test_expect_success REFFILES 'checkout away from d/f HEAD (unpacked, to de=
tached)' '
+test_expect_success 'checkout away from d/f HEAD (unpacked, to detached)' '
 	reset_to_df &&
 	git checkout --detach main
 '
=20
-test_expect_success REFFILES 'pack refs' '
+test_expect_success 'pack refs' '
 	git pack-refs --all --prune
 '
=20
-test_expect_success REFFILES 'checkout away from d/f HEAD (packed, to bran=
ch)' '
+test_expect_success 'checkout away from d/f HEAD (packed, to branch)' '
 	reset_to_df &&
 	git checkout main
 '
=20
-test_expect_success REFFILES 'checkout away from d/f HEAD (packed, to deta=
ched)' '
+test_expect_success 'checkout away from d/f HEAD (packed, to detached)' '
 	reset_to_df &&
 	git checkout --detach main
 '
--=20
2.44.0-rc0


--bp13yGi/ikpLuabD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNyo4ACgkQVbJhu7ck
PpRO+w/6AxGpeRn2+UEj2cnzlgmPiBLklkZfcVHS6vifSJSFb2mCil5Bc1bqFfK9
4FKQM7x2ejzTbJw1UpWc9Fvs1zDFA/ze+O7cv8O0gHJKDKZMYB3FISzUXUzxAm3A
aSEPVu9ndsPIEEMq6dIDPzWG7lmiiuf3tghZBwIFxo3ocW5LtZ3+LigSft55U1c5
7mMu5r4uiWiJ15dtwCH5iVrG9vR0T9A1inypDstjxpFWMVGo3eZWCZKjzgsw8Ukk
P56Qwj8HbglfZ3gRSmeT150FpJRgErQDbahY6huBq9ZQmJh6ZwztzsZr5dQrxSo9
1x0ww/74gnR0YNAWBYZMvxnyRGL0g/cAzQCIwR3Or/7Y4c0WbpdttcrpiQTADZWJ
GJ93jA/6lWV52lGRTT+eIxZ4Gp1LlQDh/J7etJo03v2Sj78Jbr2mtsKx4QmjwLSb
dDLOXy4BlENxjDj3iYzySgDYjaXxl6bgYevnV+5BMn4YYTtTH3ijFeq4REO+c+5Q
B9hO5508Ht9e/Xrv0D8OzC4A8FC74l4hVchzc1WWshc5Yik/fw5UFMfiqQdo/mHA
7bQc7rBOMWUtFb+6APvtedhAUX03j6OFfKajEM5eKof60r2cTtckA8zWjkFJd4Bk
J/IPIbiG4M/ZZbqrKPKTX0VN4TSdcUSbJRkb/q8o5SeEZ9CN/Dc=
=mpXZ
-----END PGP SIGNATURE-----

--bp13yGi/ikpLuabD--
