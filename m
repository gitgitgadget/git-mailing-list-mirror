Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AC16FF26
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073494; cv=none; b=HFcrNinJQggW6SSuWZjsCBgLoPIE4lJPeg+RAcEnplgC7ZwWwNElzeLAObMHfXnKHz/t3jVADasNJTuRdEZJduSfFUzvZuh1KEtPbbrhDJLkSCKHQyS5W2+y+ptS9nMwtPb1gZA/yETq6IVvf22bbufGsBS7xWj+8LrJzVHjqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073494; c=relaxed/simple;
	bh=P2hHE2jM0d04skkCsdX3YYasqXrYyBKf+/2Hc1XBBd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9RSi1za9DpeytvbM8fs4zGhydguB+aPFrVonKoEpNL06k4AuGya1BtPwrHPKrECRV4I12ec5+n4v89vdz9HFh3zaMZCjaqflfmqFcDspDLLcDRWAzLUyRgS3IT99JRZKtFBiGBRtKXxPSSepaqkOiXfBzkUBgNy7REQ7RfjQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f0rvosX6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZLFKtwY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f0rvosX6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZLFKtwY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id E6A8B13800DA;
	Thu, 30 May 2024 08:51:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 May 2024 08:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073491; x=1717159891; bh=83LAVfrObE
	FlzjdvJM6J7V0D3CLAtQLfZR8dFH0HCBA=; b=f0rvosX6G6CCHxiGCF0Ifj7sYQ
	C/uFJ8nzt/A8jqJPFa5KJjoFikPIBvDqyt+9MuNw587yHkGR3SQymxnczhDrPqSC
	hM7SWcTsIdeayzG/08zdLs/bWpBRnJd/8uZiMrTMSHGUYEUt1SW2FuFK0XsmHtlq
	7J79YuON9dL+KLztuBRpnwdaKTlE3L5hjd1yVFBVyY1dUFYXLF4SbNhbPUpEsFny
	Sv0/3XdGTgNfNGrgAPWn2fBnmfgEm1QtzvLihMHEY+iK5hOwBXNjKwXlyf6kHgI+
	VFCdF5vIvKjhY8zjH3P5+zMRd0ypgPbHzHAUvoTAL04dInTpQ/BKHlG2dshg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073491; x=1717159891; bh=83LAVfrObEFlzjdvJM6J7V0D3CLA
	tQLfZR8dFH0HCBA=; b=BZLFKtwYaiT23tpA2nEfzUzNWbZ0WlxHYOIyWTmY/DL0
	z6YOmXiRKmoYWl9Rc1/wKfUc+5yNL7QcOUGD9qhDdCTieVF4iGHPMl5GgA6A/kJZ
	5o1VzuN3XcET/ZsrCX95GiaK/hRp4HvvV9/DJLBZRGw2SvYAluixd7LcSkzRbzwy
	yw1O65ZNPgdy5TBJ8p1wldsFKB2AzPLrGWMkewusiinUFK7DBlOSE1Tj49ZbCLYS
	YjZWoOggXJ/kYJec0znkZF17ucEPsqvAPIcNpr1oIau60DtyJ2a9hHHqoCVW2YAv
	r0expBFgNm+pmfZ8XJchWx7hEuinfctMERzdsocMKA==
X-ME-Sender: <xms:U3ZYZnt_9bRK94r6hrsA-T1K3giT48nS1-p6RUkSPhLqje6OskztSw>
    <xme:U3ZYZoflaRTQOYwet_mGxQ1toeQynC1Cef2efL6qomiZib6No31GNte_pBn1toXqG
    SPA9IQZcF5lCjp8dA>
X-ME-Received: <xmr:U3ZYZqxcIneOxwSOoBqN47Fj0101Mi5c_PauMkpewZs6yHgQRswqPXsDRr_nKn2Bi7TlEBKD80MM21Jey90x-gjuGBf2VXBl0l1TYfifv8GOvAIw9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:U3ZYZmNpV3Q76PtNYElglk4Wjda9v49v0LDoKWszeiFLxBmoZ5QUcw>
    <xmx:U3ZYZn-Vbk-ukdXEQ-hLdd1BdeJwpwc1sXWMOv5XKxscPqbhlyvpwQ>
    <xmx:U3ZYZmVdYKDhtksiLtVOjIgcAgEfihbQ1piN8cs4klhHmDsXDRl_dw>
    <xmx:U3ZYZocTqv5I1jybQVH21xPHtfmMNPUmc1akriU16WXDnZOgyxtRFw>
    <xmx:U3ZYZqYqr6YLZOyUumZA30YoMkszp4hvaKsRaVWSbUPrsuG6tKclrUMq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1f1aa49c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:51:14 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/19] revision: always store allocated strings in output
 encoding
Message-ID: <502380c2cade79303980e9b6023048f5c21bf132.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cv61gCPqqGCsFZxs"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--Cv61gCPqqGCsFZxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `git_log_output_encoding` variable can be set via the `--encoding=3D`
option. When doing so, we conditionally either assign it to the passed
value, or if the value is "none" we assign it the empty string.
Depending on which of the both code paths we pick though, the variable
may end up being assigned either an allocated string or a string
constant.

This is somewhat risky and may easily lead to bugs when a different code
path may want to reassign a new value to it, freeing the previous value.
We already to this when parsing the "i18n.logoutputencoding" config in
`git_default_i18n_config()`. But because the config is typically parsed
before we parse command line options this has been fine so far.

Regardless of that, safeguard the code such that the variable always
contains an allocated string. While at it, also free the old value in
case there was any to plug a potential memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c             | 3 ++-
 t/t3900-i18n-commit.sh | 1 +
 t/t3901-i18n-patch.sh  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 7ddf0f151a..2ee6886078 100644
--- a/revision.c
+++ b/revision.c
@@ -2650,10 +2650,11 @@ static int handle_revision_opt(struct rev_info *rev=
s, int argc, const char **arg
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match =3D 1;
 	} else if ((argcount =3D parse_long_opt("encoding", argv, &optarg))) {
+		free(git_log_output_encoding);
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding =3D xstrdup(optarg);
 		else
-			git_log_output_encoding =3D "";
+			git_log_output_encoding =3D xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^=3D 1;
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index f27d09cfd9..db7b403bc1 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'commit and log output encodings'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 compare_with () {
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 4b37f78829..5f0b9afc3f 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -8,6 +8,7 @@ test_description=3D'i18n settings and format-patch | am pip=
e'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_encoding () {
--=20
2.45.1.313.g3a57aa566a.dirty


--Cv61gCPqqGCsFZxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdk8ACgkQVbJhu7ck
PpS3bRAAp+Rs6iHj/3cUkj/weOZ8LqGQY+Au4r+mskMzDXs+obeTBSM3ehA8w6E7
/GLbmNHsD1pWhWeASMFF+Cq/IBWKy8KWlWDW0E8fl/oDtdQpK+HrFheWFh392ze1
2/pwKVrGG+wy/fl24kzaCX3Dv0KXUic43DZr+/OzOZGb18E4LZyyn+KPGUD4D7ID
TgEOcPXDbg4QjXMkZu0uF5sqJdRSiiqltzkxSCx0kvKQ4DaZYgHcO54h3t3AyNxh
to5OPsxMycHonlC/7jQ40/ksSzdj2/nysHNXIIVWSYYxYKaNirqCbGkUNTq5xrsX
FY9se2QWbm92BwH+TWRpPflgsR03C8FRSdmn81cKRIBZHY0Knr3+80FXRWqx7weR
NyUQGCP3cMNBWMu17Cf0CFiNGWnempotF9XAa5sjAMKyfRK/Ncl5lIrNEBhatDhE
/VbgaK7VV+zcxZBky2vf/tekyULSEKxmuFlnkjAoTFppufT7VhkAmKCqMwLIVgtG
oi9TRDSJmx9WEq8AblfQCMW8u0Cgf32LzzUzS3GNjqk3MMonUTo4lpqCouqFA88Z
/8tC866u00HDe86R2mVNICuvoei0yCktHYjetLeIflsdBfxMm+Ncvpz5Z/dxJlh9
lQdqVzLiRWFQjvYL54R0QqLZDWKiHZo1w9X42Pos0+/+k50g9cQ=
=EVom
-----END PGP SIGNATURE-----

--Cv61gCPqqGCsFZxs--
