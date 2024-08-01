Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1E184541
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508876; cv=none; b=liy/+UYB3Dh80TTGhqUDG7RK1gvKFVNgSS2tR+kLWVu786ct0aOuzlTrfCuxQTp0+hp1PMhH8kKdHrsy834qg1tHT3Zi1V6d0/Zi9qK7arY4euhqO27kpmmKfx1JTPWyKyS3V31Y+PwRQwx6SOtsHJs0hpfs3FsaEy/ePV2EbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508876; c=relaxed/simple;
	bh=gy4dXV2eFwdHK2hreYaKysAVvS6LGnm6V9v6Oqe9XEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKi2I+ypnIQGvP7HGJtB56HIqO4IhKztdlaOBld0yCUMd9MfFWxNP3m1ZjCmrQ5RnhxWu+V7Fa2CsejwLL6UszMCn2BrbqSDqhzaTvGQKlag8vzjrfnR4y1zW3D3VFwS9OVds59pkxumB7mGJm5D0LhSrzZmDpen2Jf52zaBCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OSZ43eY2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=izty3Kbf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OSZ43eY2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="izty3Kbf"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F35DF114ABE0;
	Thu,  1 Aug 2024 06:41:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 01 Aug 2024 06:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508873; x=1722595273; bh=UMJsJzgmI5
	bJkqLVv28i9wRSKdIzWD1ntABe0QYafeQ=; b=OSZ43eY2VldE/t4zvmchw6GOG6
	z2iPPA/vWILzNuItSp7iWx+Tvt4NVqtWyG3uxZUHvyzojK0CHlfd0RUFxXW8FYh0
	x8m53au5/MFG5tACDfJAaH0YdajrC1Ymtl1aAJJGopIrezsxC6q1OiH5xbBLEoUv
	yaZ4ITpnUlQSOHEXvbndBsZs414UQ8bsLQXcJHW9S/KEIlYPyCKfRitSoh4SqTKU
	p1qZll1p3s9tv7LXyF/+ByhxOfQFHLxFdM+ZmETWWMIS3ExJe37kTvUWdSNtTByp
	bCAe0bE75XuLhhKczZbRR9yCxDJUXIrRgoFBVCZQfErESkTOv3rorrTl4v5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508873; x=1722595273; bh=UMJsJzgmI5bJkqLVv28i9wRSKdIz
	WD1ntABe0QYafeQ=; b=izty3KbfqCEONosIIraOZ4wRbLy8i04KKJpd2AQnFWwm
	dxYhI7dZCUdtyi0FDcGaC35dekGh03pUB+w6hKFMROioIXkvYmSyo3hcknp8kRqx
	U6ruDWf08jgb3svKyQ8tMlCWMyZ73V8ejVVeejl9smYmpYvGFIlSqSQ5mxlRdQug
	ViASCqurS/c7RcUuGVOR0WFXr9L33ahgNMcYTPxMgiqWnOq5xqgjqF/iUs/CEGxn
	nFMwWOhTS8bR3BMVSoJLZvtVP+VO25Zktw6YiMH0zKYtwoY6qLDGfARhNohTPjjO
	h5olOlw9x2lkXxwP3Q8+pm5sCDwqtnq8HgLLKvr+/Q==
X-ME-Sender: <xms:SWarZkNNCLYuUviVUau4vKb86Wf_mRbYS2-aUfCqoh5v1_FeSiJbag>
    <xme:SWarZq8zrZJGl6D2Ons8LsNroqQwE1nDjMJ4AGlH_hMDDHbzcd4A98-TrlLCy_t-0
    3FVdxAZllzYF6wFUw>
X-ME-Received: <xmr:SWarZrST4m52Z_UuGbyhU5D_bx8MTqxuEPpbwmCFLlmAp3TcRJB4jcRHbZMvUIIDMBliv9KtKvZ2PomWBJIlQtqQwv80fNCEvC4nTPh8lpj_T8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:SWarZssHAE6GHZxRUGMvGcmxbBsO0A83a7-CRdPkIFO3SRgG7CtMzQ>
    <xmx:SWarZsd3a7JlMFwdQ-_6KMWC9AVQPbVFNNCQlm3zsFPMtrKJTbzVSg>
    <xmx:SWarZg1muQOMiAeCj3nzCss0w471S61C98YQ-No8wLOXHGdVZ444OQ>
    <xmx:SWarZg-zOfQMJy2P-FNO84HY-moE41QVvl3a4_85pCXJxl4OvB0liw>
    <xmx:SWarZhHfVQpJcw5glVvJx9UF_4nHw8-E8l5orgDourrAvFniflTUeQko>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:41:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3c8c1685 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:39:41 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:41:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 23/24] convert: fix leaking config strings
Message-ID: <5d2bf0f0f3d05f402df87588511b91c8246401c3.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qfF/WSWfMiQhmuHR"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--qfF/WSWfMiQhmuHR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `read_convert_config()`, we end up reading some string values into
variables. We don't free any potentially-existing old values though,
which will result in a memory leak in case the same key has been defined
multiple times.

Fix those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 convert.c             | 12 +++++++++---
 t/t0021-conversion.sh |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index 61a540e212..92ce04c406 100644
--- a/convert.c
+++ b/convert.c
@@ -1050,14 +1050,20 @@ static int read_convert_config(const char *var, con=
st char *value,
 	 * The command-line will not be interpolated in any way.
 	 */
=20
-	if (!strcmp("smudge", key))
+	if (!strcmp("smudge", key)) {
+		FREE_AND_NULL(drv->smudge);
 		return git_config_string(&drv->smudge, var, value);
+	}
=20
-	if (!strcmp("clean", key))
+	if (!strcmp("clean", key)) {
+		FREE_AND_NULL(drv->clean);
 		return git_config_string(&drv->clean, var, value);
+	}
=20
-	if (!strcmp("process", key))
+	if (!strcmp("process", key)) {
+		FREE_AND_NULL(drv->process);
 		return git_config_string(&drv->process, var, value);
+	}
=20
 	if (!strcmp("required", key)) {
 		drv->required =3D git_config_bool(var, value);
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 0b4997022b..eeb2714d9d 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -5,6 +5,7 @@ test_description=3D'blob conversion via gitattributes'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
--=20
2.46.0.dirty


--qfF/WSWfMiQhmuHR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZkYACgkQVbJhu7ck
PpRHCw/+KjcPFLUyeuuQr4ChCJ8g38mHs18ncQ2+U9onU1YTpw0hAkS0W3561z0R
DvAPBa+HRSI1QWEJjlFGAO0vV2teFZiF9QgFF2GRBIIh8frTzZMljVT+kCrtbrt0
yoRUpKHxyRRC9pk2+Fqlh2Pz/aVqnN1jES4+Fqu/qDJvNHo/3rBN+pP8UYtt5oh9
oMkUz9preCQMtCEQLHkjn8HjhT3tCdzFS8nTVNtV0Sd2vrl7XRZMQKlE1fLTR06c
m9ZrrIX+sWpnu+8enjBY/etxyj9o/1uNVyPTZTNrgUvfnBT5hz0PWWgehOpwSkKQ
M0PRbgZUAsU36nNpknHPjrBL0gxdd23pi1wE+grnLinuzXJAPoGW6UbH1r+fZGe1
coaT7RAstjPyDdZ2xe79XXh1c3WQy4pPPswqYuqJNTZyhqV8M3ouNhLMTYi7HUnF
arplxwSHjlkgVKsHCYaKeoBqVyhau17Vt3kqGNWFlnFOdW8gP4rSnTT+aYA+B7WC
QkSQg5EUgJ880DOXucc+M33JQVSoLPVL4ZuxOpyye+6B3EG2OGmDCoWRNvkBRjlt
cIcm9nXJJ1UqnKiYwBM8GwqzjwyT+jkwJp93dWJAGpJCM995DwEa77YLRS6szewh
bX2d4s8Kpku+/QG3r6Wh1wi3Z/5WCe6N9OG4WTncPd1IOg8GxS4=
=Mi+4
-----END PGP SIGNATURE-----

--qfF/WSWfMiQhmuHR--
