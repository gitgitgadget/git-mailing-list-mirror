Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D185656
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407669; cv=none; b=iM0PTpfFwhG3JRQRdkR26ZpVXOmJQu/L6gOXpuZX6r8R7hNI9OxwDu7PkA3IDN+Se7apj0gL4IxmhR74DRq+U8mhsBaefBJG81Zt/QKs6LW+N2jXToNO/sMBYQIt+IB3nPSc978BfMEbGoTAqgTyHHTQWTgyfAGLlHKn89S1ENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407669; c=relaxed/simple;
	bh=lio3sDbPmmikL3j41zFb3FuHXXv4/8IYB/UMZ6/ZUWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b52oB/Kx1RG5EW8JwR2z9X8b3GR9OSH5oxrWNrn5BSpQyeUwyutBnFBTXnKVvvWRsq2R3IRiEBarAll6FReuPihgkcvsq9+HKnL8IWTRR8ME8/xxceETU5flaBPH/zUUvtzJNITvNQb8N7dtFlkXQ924+jToY3nLCZ+qhsVB05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a3igbV9T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z0r3UeDq; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a3igbV9T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z0r3UeDq"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 4B0CC1C00090;
	Mon,  3 Jun 2024 05:41:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407666; x=1717494066; bh=HvGnvMFqmY
	Xk8kNT9oWT4/pOdSWYuy/xMHTt58GgqDM=; b=a3igbV9TPl2ubEMcxlwMr3s5F+
	jS2fsaDvps7SnKIenwxAJLiwZ5Aub9Mi4lAF7LwW4bRjYlP+zaXF0TlIMI5ELEn5
	GuqxU/8hJt7Bv/myRiJ3GTca1ea1NBGPH0E5N1FLeGeKuxkM4pPWqhR+IwN9bvrS
	9JjogKAMRLMQK+Hc/cdRSQx+QvHXoQ/XEw6XeYg4lRF66oOpzSON4UzyX2TwEAxy
	6u2Cr+TNMpVRFokGW4nOIZky8HcIn2Y5Zcr+eZlf964M/3TgX3NBKIin0wwroxOZ
	Rr6TLZeJyGzPldIItUdoLFBIWB8d6zuhvPJDUY898GpJoP1xV1eVqNF5HKgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407666; x=1717494066; bh=HvGnvMFqmYXk8kNT9oWT4/pOdSWY
	uy/xMHTt58GgqDM=; b=Z0r3UeDqkqtXrjKCuQ0cL/hMaSHA6c7zdSj7PMPj6Sfk
	ZZzk3v1qfoQ6dcz1Yj2BBioX1SV+i80qBr6In+Y+TFnl/ZQlXYHNjpvRGXTW6cUz
	ESMHgOUPhuIVEdNeNtIzHpHoVISiAog4MsEg+wD0o/ETOP63bfkhyQHvXUWTt8ec
	rFTa5X+LD3SMedmkBTUwadaNZoq5AJPYMjYxEw1ZJ3jRLte6pBzmetd1DD4kyJxg
	KSJLpGAbBGXBx+2DJBhp6B9dKdbjycR1J+Yd14dVXW/VlfTIHokZ8r9tK6dTOzqB
	iSpjLC8Pmub1lBCXJ1rFXuQsWC4CukLNE1ZWrEGjZg==
X-ME-Sender: <xms:so9dZpo9LsKzLzyttkBR6Vy_OrglYxzqoZU0NOyba79QWgqofG6XdA>
    <xme:so9dZrqy9tb0Vu1kPCgfRilws3DCkKzlaMwzErGrF7L6MAon0J30sUGMvO091m5vs
    Bj4cFfhaomPxVtAkg>
X-ME-Received: <xmr:so9dZmONdTK44pQKEEYvSqDnWtx3UR6rjKiU_CW27clEq24J3J0ewWymr54FAcO0Xtoxfo_QXl6mzVJu7RrEKmHOWr0TxI2H38xxMhwffq-9Pejo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeehnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:so9dZk6RO49G_MikZU8b7wYmmkDWReq0EsAfA0zg4ZqqnLu0Ksx2pQ>
    <xmx:so9dZo62FFWC1h7TaJRgeYHbln7oKcxquboLMpHE3IgE2eS3oSSnCw>
    <xmx:so9dZsjqo8V_anoNS-mHVtxHhOESCi43ECavdsxr5aA-FSFx6hD-0g>
    <xmx:so9dZq44uL76qOJh797CD4f3hrqQBkNhoOwAlpn9lGyZbGQNphpJTA>
    <xmx:so9dZmnhg1Vq0O814CbXp4mEnyZoab9UKGww3z2tLV70ihiWvXk_sWlW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:41:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b660448a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:40:41 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:41:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 26/27] builtin/merge: always store allocated strings in
 `pull_twohead`
Message-ID: <84c0149c8fadd5b3f002593873bea3d447832f2a.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MfrRXcNQWSIv89He"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--MfrRXcNQWSIv89He
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `pull_twohead` configuration may sometimes contain an allocated
string, and sometimes it may contain a string constant. Refactor this to
instead always store an allocated string such that we can release its
resources without risk.

While at it, manage the lifetime of other config strings, as well. Note
that we explicitly don't free `cleanup_arg` here. This is because the
variable may be assigned a string constant via command line options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index daed2d4e1e..fb3eb15b89 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -611,17 +611,19 @@ static int git_merge_config(const char *k, const char=
 *v,
 		return 0;
 	}
=20
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat")) {
 		show_diffstat =3D git_config_bool(k, v);
-	else if (!strcmp(k, "merge.verifysignatures"))
+	} else if (!strcmp(k, "merge.verifysignatures")) {
 		verify_signatures =3D git_config_bool(k, v);
-	else if (!strcmp(k, "pull.twohead"))
+	} else if (!strcmp(k, "pull.twohead")) {
+		FREE_AND_NULL(pull_twohead);
 		return git_config_string(&pull_twohead, k, v);
-	else if (!strcmp(k, "pull.octopus"))
+	} else if (!strcmp(k, "pull.octopus")) {
+		FREE_AND_NULL(pull_octopus);
 		return git_config_string(&pull_octopus, k, v);
-	else if (!strcmp(k, "commit.cleanup"))
+	} else if (!strcmp(k, "commit.cleanup")) {
 		return git_config_string(&cleanup_arg, k, v);
-	else if (!strcmp(k, "merge.ff")) {
+	} else if (!strcmp(k, "merge.ff")) {
 		int boolval =3D git_parse_maybe_bool(v);
 		if (0 <=3D boolval) {
 			fast_forward =3D boolval ? FF_ALLOW : FF_NO;
@@ -1294,7 +1296,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	if (!pull_twohead) {
 		char *default_strategy =3D getenv("GIT_TEST_MERGE_ALGORITHM");
 		if (default_strategy && !strcmp(default_strategy, "ort"))
-			pull_twohead =3D "ort";
+			pull_twohead =3D xstrdup("ort");
 	}
=20
 	init_diff_ui_defaults();
@@ -1793,6 +1795,8 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
+	free(pull_twohead);
+	free(pull_octopus);
 	discard_index(the_repository->index);
 	return ret;
 }
--=20
2.45.1.410.g58bac47f8e.dirty


--MfrRXcNQWSIv89He
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj68ACgkQVbJhu7ck
PpTG1A//ULHEsc3i5lVv15WLPF0lDbMo3pr1GWgh8ITay6DehSHNOraxwuPIai66
0SMb3p++VCGdjUvVYwsDVK5Ln864SBxnsMQMmODe7Z4mUCgnj6gmmSaF03X/2T8j
UfQYccdszJhJrkx5YZ3f2p2YZn/USmQWYeRZ5MzNApn8v3oHCm9AB40LXIEisqO5
yYM2aCczMJACflxrx0MyN3CSV4+fkSSRr5MpM66R/IMTnRl2lM7UZibhtfr+nE15
rU0tdW5dDF4mV/BTetp1AYUe8rftuLr4ClwXcQIy7UY8xOnO59VH2RZQQFOHtMr2
4yM6jWvf+D8WkstaPTqXFqVypsW6Tym3a/U/04ci/JF98YH8v01x/8azJKUmi0BE
AgWQlr0GqmiUhF0TRYGMmaTfX2MJn4Ep+QcrCk4BdI+Ykh6RJz0rAVOnfOMNuFTy
8h4PJSUAPzt1Q2MOlaoNupQ9IbwAHogm/2OUe3z1BwKfOtgHHMC3nELtuf0oMHRj
hAAOaozEJCaR/SqR2ebS3VpDqgt423qYUIv/5IILRg/uMpd6huE7GyK8lYKLJm57
Ggol4+cZsTG7X8dCp7RbZAoefgk/rcaQee4LyTqR39yHjQJLGz1BXd0QtpyRG7ga
iVZht38KngHQiByYwwV82gc1CnwrGMCeFhg9jp8/Xd27W4w5rN4=
=yAvD
-----END PGP SIGNATURE-----

--MfrRXcNQWSIv89He--
