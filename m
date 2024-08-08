Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2329181BA8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095508; cv=none; b=kKCwX2REtjpel/rGLTa5PuzE2zzcUbCaBbliSpAyh5OItCONSkbIW6ZPrZzblC0aGHXY/xNMAuMhRjG82Ab0GNvsq/mWZzM0HlF1Ls88a8cR1eQMIWD+JFMmdQ0t6qUFO9CmJe5ZsM0BbpbFSHg8MT6gCOIxnD3GdJxo8rDWv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095508; c=relaxed/simple;
	bh=GatzvCEYOZEuu5Eki7lfa2+bkhN4ghNnKo8gPEPM2qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvpKJpXdk5f43cD5Sw4oeBBQ583ytYenLSLpOhqmH8RNgzedrzfaRq3HYH5UwI3ZZlUjnXU1eUOlPM8hALjCvidjgSxqULBqV1oSRELR9uJERx3Z90V+/Z8Tkp83EWFqR6oe8nuhrRO8NjILT5gULahsYZbbeON9GFxPUbZRLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DrVbuacB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kAWC9wdI; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DrVbuacB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kAWC9wdI"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 21827138FC99;
	Thu,  8 Aug 2024 01:38:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 08 Aug 2024 01:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723095506; x=1723181906; bh=Fguw/NbUYv
	jY39S8bECaIX4r2Vy1+lp59a8YCMn1SH8=; b=DrVbuacBGPcqP98xtPxxnprzEB
	BQ4Ue+8i2Ew8q91geHH7zFreeRb3Oh4xNNMfkkZTR1yWSED/FNf1luIZXSueOyTH
	u4KgxExM/IvA7u+JlIMTsO2vOtwUOExAgDP1u46kvmhb0/3y+EIbiJstCNe5CaF9
	Yd88N6alqkh9xck4OcZAXv587fMCDR+cwNSM18Q5mIqYWCX8Nc8M65XgAj9lWkNI
	K5QighMYTW9mgo9xokfRjcPevKg8DkROZmAnDjOZiPcDAfP0XaBR8lXboMozDHYm
	xEJh1Jbkra5F0ohb3pQZ3ez2W3sqrXru1o7zOTJrbpxM0opPsW5dodTpNpkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723095506; x=1723181906; bh=Fguw/NbUYvjY39S8bECaIX4r2Vy1
	+lp59a8YCMn1SH8=; b=kAWC9wdI0qpPBrxl/PG3tlcgFYCpmplhYElZP57ANcGG
	GVsFjmyEaXWIDjYjEk6GqfVI3MvectOhoj8OKGzUiQTQoeSQ+4gYoCHklU8F8qTw
	eFZyNmtUq2U/b/43hGcwL83jfnox1oJr56Kj2n0zpbVeEezC40ceJIqdvdt5OzFY
	dpsEAC1R0TYvAZaABf8Ywp5BxfER6/ISCJegEZZPcFB0iyxqkgbS1WTOU5KjfN2e
	88EZsFib3tbRVzQ5X8u3G/MOhlsRoL8Eh0Wx4O7Nyp3NTAhRPPaLcSKoWG5O6VRm
	pVjQUUPKINKNHCRcV+BdxYsj9bE3fV8WrExfp+2COg==
X-ME-Sender: <xms:0lm0ZkwiDgvFMFXddfgJAql2M4lSsU9BC1Gw0THC-pDVrCZLKFaOjA>
    <xme:0lm0ZoT-2jUNi1PwQ8HD_6GmohmlQiDZU5_pqatpkhRdhqilXv4dCKyq5p0Q6G1-7
    ewQAZksvmXOD2kc_A>
X-ME-Received: <xmr:0lm0ZmVO-b-AM9izx3XYEyh7JF8P1qFr0HruRgYk3TLwYTGdPek70xgWJzhucf5np1evJ-de7VXkWlponCYeX0L14YQs3wiSZHBv6oxiI6yN-xBz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheeg
    kefhjeehfeekhfevleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrggumhhonhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrd
    gtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgt
    ohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepshhpvggtth
    hrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhk
X-ME-Proxy: <xmx:0lm0ZiiLlNlZtUMd9U0LOzO3RM4qvlkApnQk63nnKSA8ewiBFxtAYw>
    <xmx:0lm0ZmD0aE7GvMgrOCKKxgdC9H7ILVEKL2GaFQqzLPF4MDajO5OhOg>
    <xmx:0lm0ZjLppLfJ8YYWUOJQXhf-7C1O3xa5vBhCRlzZqQjTP69fLNe-7w>
    <xmx:0lm0ZtDHbyMi9RZM1bDjtMU0OEYsDMS3BLiK55a5krb9GOLpeurtHA>
    <xmx:0lm0Zi2aXE5wM1CwgMkOqQ4OiCfuvQ00dnNt1kKWQ15pDmBEplO7bAmj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:38:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 714e663f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:38:18 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:38:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v3 3/7] t/clar: fix whitespace errors
Message-ID: <35682b7686e570a96a8432f6b8af1996ab8d748e.1723095269.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723095269.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JbAEs5lNlKwUaR5M"
Content-Disposition: inline
In-Reply-To: <cover.1723095269.git.ps@pks.im>


--JbAEs5lNlKwUaR5M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix whitespace errors in the clar that make git-apply(1) unhappy. This
has been cherry-picked from the upstream pull request at [1].

[1]: https://github.com/clar-test/clar/pull/97

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/sandbox.h  | 5 ++---
 t/unit-tests/clar/generate.py     | 1 -
 t/unit-tests/clar/test/.gitignore | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sand=
box.h
index 0ba1479620..7c177f3525 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -25,9 +25,9 @@ find_tmp_path(char *buffer, size_t length)
 	static const size_t var_count =3D 5;
 	static const char *env_vars[] =3D {
 		"CLAR_TMP", "TMPDIR", "TMP", "TEMP", "USERPROFILE"
- 	};
+	};
=20
- 	size_t i;
+	size_t i;
=20
 	for (i =3D 0; i < var_count; ++i) {
 		const char *env =3D getenv(env_vars[i]);
@@ -151,4 +151,3 @@ const char *clar_sandbox_path(void)
 {
 	return _clar_path;
 }
-
diff --git a/t/unit-tests/clar/generate.py b/t/unit-tests/clar/generate.py
index 931b4d60d9..80996ac3e7 100755
--- a/t/unit-tests/clar/generate.py
+++ b/t/unit-tests/clar/generate.py
@@ -264,4 +264,3 @@ def write(self):
     suite.disable(options.excluded)
     if suite.write():
         print("Written `clar.suite` (%d tests in %d suites)" % (suite.call=
back_count(), suite.suite_count()))
-
diff --git a/t/unit-tests/clar/test/.gitignore b/t/unit-tests/clar/test/.gi=
tignore
index 3e8ae0a3a5..a477d0c40c 100644
--- a/t/unit-tests/clar/test/.gitignore
+++ b/t/unit-tests/clar/test/.gitignore
@@ -2,4 +2,3 @@ clar.suite
 .clarcache
 clar_test
 *.o
-
--=20
2.46.0.dirty


--JbAEs5lNlKwUaR5M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0Wc0ACgkQVbJhu7ck
PpSHyxAAidemSmr3ZPOctmHuu+xuPiwpz+htWW2bGwvHNOcpPXhKcG88gM8To7i3
ElhZFcOC+qnRtfdort4XjPjZlyu0wcFtTvlOB0CmjRmjmXdmXh3ZDMnKUg+OMQjs
hGfQvfOiJsYwnJb8dpGSErJWdnHtLc8PPMdFUoMxm7W2jWhHJTOvvwy5id8nEfae
pwp9mzim/xEQaHmklcyoAlCHgOcyCGcmbgarjYtddkYQEeMwB6TijkUQivyATXSq
YfWRREzHwDg2SyJSNAdrlzmrTOzt+W69y5n1wj3kQhLvTG9wfQ5tT8YbrZgjTAj4
c1VenetE2+bDuqXgUCgdYs017WiIa3UnoVDlr9W9iEywE1n8+yvi8egVyuhr9fMM
DmghUpbeKJNJuzOpR+5A5g6rsoSgaQZ8jr4oHQ77SAz2liBoylV2iPVeMC6clVZT
/vYvjZgdMkHw1cZL9NsnupprZ8vRTccVQBPgiGlkq1Gchn1HjuJQyVuTn18VfORH
0pzluEurZbwZYF2moYvZu2h9uuSScOBrGMTKCD10r4IVPEp7K1YEIhoFE4XlTEcU
aDRAi9WSFYPBYdPJmyCuyRH81avGICE8g783jeOyQms1r20e0psIoMoiBShHGzv2
1QSoKA76oSSedBhzajx8DHou0mN/5IULncvqIRA3p0/WP8sngZg=
=RN/6
-----END PGP SIGNATURE-----

--JbAEs5lNlKwUaR5M--
