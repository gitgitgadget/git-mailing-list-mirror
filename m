Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FF2E639
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669736; cv=none; b=oiEXcdfC18Rk50/HRxb6rNrUEh6NeKTFzC7MaP9atN26r/blHWh2PLH9yZ+yfNzlz6M1qNXEcv4OcWZ/hVAFGwyW/jLwj9jNTTkJ4oVdm95Th5AWLAFCdqzaIWmx2DL8s22CPBSkMIXV4/rihvD1FhL2BOTgalA3YIOl4RwsK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669736; c=relaxed/simple;
	bh=5Wha2Wy7/+6KsBdylQvEM/KZ40FYVTjAvA9I3kl2qMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjCfvb9iSUp6rTNKb+PkEordcmBH2V2olPEte0ErWMrVGDFVe7BReOjIQ31D9HHal1fAOWnq/ktnnpbmWX7AzNj2JJpXZ44yUD0oMkhdOcmII+ZyR1gbJpgy8UHZvNyhP+QXLshbu7eoGW6w33N1ZJM2Cc8IHpOcqnD93tD3bz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TYLTNRwB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QAg9IfRw; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TYLTNRwB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QAg9IfRw"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 97B161380153;
	Thu,  6 Jun 2024 06:28:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 06:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669734; x=1717756134; bh=IcTt8SZE0B
	MqJsvfr7q1ynwWjeAJ9VJ3u7Kw/RLuHYY=; b=TYLTNRwBC3HA4r0TvtvkjqAKF3
	gPBXqd+jbXWomoVUh/693aL232g26M9L+j2uNzJNGOIgxwwuX0iw3lnyZL2uG4g4
	MkgIQjLncZopxRi3ZSXk1+RuCSAa9FVXlsMwpYunJlKeLclJwwVziw+twpfHVZ6L
	1F6dN376SxClY81oG1WJJ8+I6/LkaOSgMHYzfbU7hbrXzqt/UIF8Xgn8QsyxG/lI
	4+j8jPdMLDMF82tHHut5413z1TW0vPyyoP0eBXRP5L+cJxMrNyEaRfmRVeg8JkUk
	o8yAytjSdeUD7LngLzC3CxWetT9KqCL61CtTRBweWnB7jaoYQkvphStPm8hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669734; x=1717756134; bh=IcTt8SZE0BMqJsvfr7q1ynwWjeAJ
	9VJ3u7Kw/RLuHYY=; b=QAg9IfRwsSG6J28ITMSRVOtVIZRwZ3jvqaZJES/u+PXo
	vsYMCi6dElp9+AnC1fHwaIY4cZFjbhlmm0kvHEeg600o2Q2HKRPBGrphXuoyyldU
	uBypN/Uc7OQ5g6C0K6cDeRoXyP7hniPcjuGu2FA8cbsvbxi8derKLhVSijGi8yZ5
	en83tjHTO7XnhO97elf+MEw6cehbGbO1CF4nr9zaLtsRUGh46mOSHaSe5asQC/nl
	qUJubkzluaOs/6YpcGBrGxyyNGgn0Hsq7mcdXev9twIicjW8GMGFhKUkINuNpn/k
	kEGoFZYpGx70oFQrCKCpHK+5Smw2v/SNzImcUgwRkQ==
X-ME-Sender: <xms:Zo9hZlnpsykd30CAty8imBfkcNybDplUzJ1aOsZfETQ72pXB5VRqdA>
    <xme:Zo9hZg1tQvnEyy5kcSn64xkavvc-_2K9BRtMG5D41hfv_VULqWUrOa2bSundfCpn6
    ggKTZUWpiJa52wZVw>
X-ME-Received: <xmr:Zo9hZrp0npQWU-2pN6pX-TGHLtyTXTAf6-PwWTjBK1DftKhREOFwkizCHzVYp4GULpESUvSdXSE2_tiQYlY9oyDKc-L6xcHfTvaTPtdDa2ZsttET>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Zo9hZlk7stCQBGb0qCM4eCCUxh9YIBE9eWtodpjZUhbXlGNSk5Ajcw>
    <xmx:Zo9hZj3_hB3CPxd5HYnIbCvnka2n1zaLyzwJVCz6WqTNYTQxSwgYkw>
    <xmx:Zo9hZksXFMLfIt_Xm68kiq670gXI3LfaQ4_jlG3UI3Irf0bHHOx7wA>
    <xmx:Zo9hZnXePKWdRh_RUqUF2uXY0SxShGrTZWDmKKQa1rS35akagxXUkg>
    <xmx:Zo9hZuTm3UH-40iGaALkpWWq8ZQuVo5vt0m88UqU_PCbrcnCxymkHmyW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a4db751b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:23 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 14/27] pretty: add casts for decoration option pointers
Message-ID: <ed8f07aa59030ece540dbf8c7d64733b8b234d4c.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="arCZf/TkT3ipQryZ"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--arCZf/TkT3ipQryZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct decoration_options` have a prefix and suffix field which are
both non-constant, but we assign a constant pointer to them. This is
safe to do because we pass them to `format_decorations()`, which never
modifies these pointers, and then immediately discard the structure. Add
explicit casts to avoid compilation warnings with `-Wwrite-strings`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index ec05db5655..1df9d635fb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1584,8 +1584,8 @@ static size_t format_commit_one(struct strbuf *sb, /*=
 in UTF-8 */
 	case 'D':
 		{
 			const struct decoration_options opts =3D {
-				.prefix =3D "",
-				.suffix =3D ""
+				.prefix =3D (char *) "",
+				.suffix =3D (char *) "",
 			};
=20
 			format_decorations(sb, commit, c->auto_color, &opts);
--=20
2.45.2.409.g7b0defb391.dirty


--arCZf/TkT3ipQryZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj2IACgkQVbJhu7ck
PpRslQ//ZUOea3UBJQt9HEazE7lK2pgGUjpnUx7hOE7+zcDu71vo/ObvxrhHrxZw
Js/NUpecQqVIJbOuPE9GlxWHeEg8aqa3Bgouh8isp9j1awTfdq2q3d1ulqVhnwX6
uTy6e0qKSN7RTqTNs+4oxK4iaBXgTVlAnJdRKtzCCw4KornvnSHo5BDawE/doXFy
nTza3dO2m1lFXV7czUbyf4rqo/Lfc4QLpu+68nmOxv3iOlbq1UAl+6wtSB9RobMk
VFxTirNAbGZL02ADOWFh8npMNWUnshzL3yt/yZ2KQ0yoKzJ1b8h1AqFnw8ml9k7e
/sj3TrsdjEgfI6t273GMIQwrpESIqsPSbzXt7dX01NIzJYeM9oC3gKvrFeHzA2cN
Jbu7zOg0dchlmFV2ZeA4o5LlT+GoxewGdvu/GSTHkAiTAbC4162aJ/d1FuEt/WI1
07bd7OBHGu9f98msFng2VNMfaJFFYCV1CrIrXm1gjpbpjp2ulMbhsIlGNzZ2NWst
Lp/CGMW9qtqshRk9t4ofXt/2uPo3jsTWuBGG7r3ag3PIsspPSdNTwJOnGfjE7Zx8
feuJRWE2hU1mG9+VIyXsVGkF3LGJyxVh+AFSeWuWUoqd2n4TZDGPOySKwD2iRrJt
A5510wrsY7IJv0ZgL2Vxta7UmWg2+vgdtgLtILgIZXf7/syqqBE=
=DGe+
-----END PGP SIGNATURE-----

--arCZf/TkT3ipQryZ--
