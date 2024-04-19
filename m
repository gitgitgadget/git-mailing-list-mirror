Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DBC7FBCE
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520309; cv=none; b=bvPtnC0staYz8quRzp5YeSP1mDHwwPAVYYA+qM5xtjrQZ93GU8UmoZCaX+VarJkvGijC6oRPlFfDDzBskjRSwjf9y8wLySkEzs0UAFEfEqQeeVJLUWZsJz9e7s0TlJalAEu8YhTqmSwR+/upDWLk0b+7N5HnjOq8XDjO6C+YG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520309; c=relaxed/simple;
	bh=VorqWIQYVMZXnKL+awTu/3AWoDWOXwiXa4Iq3+348rE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNiKVqynF+xoQbTrv4PzXR9n0+i8M4u3kt1hIhJkRfTjDIieHf6oUHaAtYPQdOReBhl8Pd0S6AQ+Q8WOxPTtjAGtr9ST34R67a0k52V7j0VWZyHutTsZ1l+ezNkCtgsD3Ju9NctWAtcF4ZudAUQwJPNYBIKl/yRIPYtTlHL7ffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qFI0H7vD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPIZTzEQ; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qFI0H7vD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPIZTzEQ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id EA164180008D
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 Apr 2024 05:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520306; x=1713606706; bh=OSEIt4xkbg
	DRrJncCAIen+6gxaNbOxF7JrkRRQY91So=; b=qFI0H7vDASvdnsUyqlbO06KhkO
	AyJ58EmqphrFrgZqhRw9nQ8PKAfgBICRV9la+7r35dsOpCYHJMoFUeiWRN3aLCPs
	hjYz7DLN1Nie7PlwlHKINfR1EFkKvBat1a609xO5R3Ch+Lo36b/f2Qtka0E+VWD+
	IxBOPFLZrJjFsXHEoe9nO46isUaQ8kT0BzmZJ0aWOBf/wocMMC70Xkp/7/3TKkQt
	/bXdSYVEkTszOpLVgz7+LAKGR2Ez4DVly67/1IHZM9AyuYid0/ZKEmdcrHfZSDdn
	kV+z+8ySraXCF7cDrMVnYl66jlhoX1MOJ/YvgdcPHomQ18fgCpau5ASmeWxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520306; x=1713606706; bh=OSEIt4xkbgDRrJncCAIen+6gxaNb
	OxF7JrkRRQY91So=; b=gPIZTzEQjdfl2SrJCGizaaG/7IChwj6Y2UzJ2fgLqk8a
	v5xVWIkuBFhgRITagZA7TKJ0bbr88YEQs3+gLrLjT3tasW4i5+fimdEGPvh36gAt
	G04Q4s/Fn5Ws52BmFhOJG7YlIpVa7FwAlWAUHxhcefkM83cpFHWESo7MgJ+d30yq
	ozeWctt7map6uaABZxn3auZ95MeWIH4iceKZDCUpzGUxEvucy2REnfPTyTpaFSdn
	vPU5dUjM4tbZ4gEsX0Y6tJKm7FrNKBtFU4bIzHuSuO4GVslSUKiU+dRIZTEx/+vV
	joMGfS45+zsPHv7o5/EOSAGUEmhtV7WRYMKkk5J08A==
X-ME-Sender: <xms:sj4iZpqd8oZCFVAIKh0Fn1oXmnAQSec_RpN0_I2PFLtzx-42BSiX-w>
    <xme:sj4iZrqS04zSex21uMoHceA-jXF9hoOOS9OmidOTdY0akW5hjM6mctcsEOPj-As9b
    9nLqkRpOiOMoqdEfQ>
X-ME-Received: <xmr:sj4iZmPtwJJoR7-OV19pu8QKFP-z8WpATG1POf3VluDbcCzrQj-o1eFE1nCdPLbQ_HFeJiY3M-ZJ_XfFg4phLV8zGYrU_--d1tAvyL4L_XEL4INRAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:sj4iZk5xk8dv_xc3Nmlbbb_75wewQodtNB5JHVImkDV-2ulvtiDNQA>
    <xmx:sj4iZo4Wv8WPXIYKh5JCwLoVAQvuwRiJCoo3VUWomLXnA6ZStkrsDA>
    <xmx:sj4iZsjKblDmnDpgtQnDLXfLy9FD33ElMObWj7_emulabilrQjlXxA>
    <xmx:sj4iZq6YWZzAlSQ4VgyCR-_SVgWfBqpZT3YckbS1UNAuYbyxtk8_Cw>
    <xmx:sj4iZmQY_jrDTHJvKxG3po8OxmY3HgZ-DjkC_mxw0ZqUMchvPi15hrLw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fe14caa2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:51:19 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/11] builtin/bundle: abort "verify" early when there is no
 repository
Message-ID: <bc4bda3508d22038fa05c510a5ffae53b0af1ceb.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O41lVS/WsHYRgPxn"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--O41lVS/WsHYRgPxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Verifying a bundle requires us to have a repository. This is encoded in
`verify_bundle()`, which will return an error if there is no repository.
We call `open_bundle()` before we call `verify_bundle()` though, which
already performs some verifications even though we may ultimately abort
due to a missing repository.

This is problematic because `open_bundle()` already reads the bundle
header and verifies that it contains a properly formatted hash. When
there is no repository we have no clue what hash function to expect
though, so we always end up assuming SHA1 here, which may or may not be
correct. Furthermore, we are about to stop initializing `the_hash_algo`
when there is no repository, which will lead to segfaults.

Check early on whether we have a repository to fix this issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bundle.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 3ad11dc5d0..d5d41a8f67 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -140,6 +140,11 @@ static int cmd_bundle_verify(int argc, const char **ar=
gv, const char *prefix) {
 			builtin_bundle_verify_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
=20
+	if (!startup_info->have_repository) {
+		ret =3D error(_("need a repository to verify a bundle"));
+		goto cleanup;
+	}
+
 	if ((bundle_fd =3D open_bundle(bundle_file, &header, &name)) < 0) {
 		ret =3D 1;
 		goto cleanup;
--=20
2.44.GIT


--O41lVS/WsHYRgPxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPq4ACgkQVbJhu7ck
PpTpuA//YD9NyRZG/J8S2uethw6CRwRQ549I4kNZpKWvC3KHRYQACvoHoY1BXqLX
TJxVM4/Yins/VR+ls7LJKQTVqCgnh2z4QgKiFPqCzw0Na9QfnnQLHpWOb/bY/Hq8
qWt4iG6/AirVLv3RrgbD+I6QOX0rs1FGSJx1DzIYdwYi5iPcaCQ0yB0HBzZYpoyx
mGCMVoFuxuOnGQNjs5bVxCDhKI7SGipf4EiHM6SEc7/+ryK1SsVLt7pAi2RsdLjj
ZZhBx+sTQ+HjHYtUCGkNbO6I4R/C53sleiISlESWQLRi75pFzCVYUUND9hVHOHlL
2KYa2LEhm62UFTB+yVJvqt7mqK9dJ+az61xQh6MzwMczHIxS4mPNhuHOfpBJ57u2
sWMm6pCx9iJOLGQBgMo93oYiJFKHRHpaMbNNx/DcTSRukOgVHx+dz070K4DEXxo9
/fafF5V6K5dtJ4pz9AAQ2b6YfPSCKCYm7n1qVEdG5ghvnoukJnt1dduEqPVbgNWu
/Yjjh4KCrMD9MiMeD4ZAPg6jjD9gM7sJ0k26XYbJUJ7UoC19UQrv8j8pp6tN8Elm
xgvIlplkk/GkT/F3pvPL/Qf1GqSqoLFjwrTZC4wJVEWYm+ahdRF9wtEd8nJaT19k
knTMh6QysgzDYhrbcDSar0V0vXOWfC1wJcdvakOCurcQ5U+wGbw=
=o4zC
-----END PGP SIGNATURE-----

--O41lVS/WsHYRgPxn--
