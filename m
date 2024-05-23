Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6613B7A6
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467130; cv=none; b=Qoetv/crQBVc4MknUL6Iq6a1q+ztUOZE57UuWD1+2pHeXsjSDYw/qCKplzAPxge44ZGYv4Cx0v2lG3ya0Ykycfi+MpFMzH04b6YTMtzW7akGPIsBh3Y+k5YtklUZyLSVLaZT4yG+4p2HKlyJFEZaavDamtMK9t3swAETZIIJAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467130; c=relaxed/simple;
	bh=fWiTtM1hiofnzvpyA8bd6k4WG1mSUR0r5CTRwLYqNz0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVgtUSkDZgb7Lljd/FSm9ZD2jI0xc3784Sz0OQYNtox9ySc9WVeh8+NQHnXoSm0LNl3VaFehHWkYSfqcbnrv4zfCVAFRNHLawBxTrn8ApXunrGJFtN66LsEaNM2BP7wVjAr6hm/c5a+x0DO4Tud2scj7h8Upn27ziUQwQKOcmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=htNAO6Bf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V4a2DiJY; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="htNAO6Bf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V4a2DiJY"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 976101C00155
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 May 2024 08:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467128; x=1716553528; bh=Eg1w2PYM9d
	k6Lgi5O1oet2oy1UgiajD+OzX+E+gmbM4=; b=htNAO6BfFBz4mN/5lxXDLvI55k
	EfgKyf2vp9vhWjWpJFP7wg9zFtB/MJzYpqgSEqeeGLumR2X+4hWbrTqeul+N4Uyl
	qNcxvh6nwuY/TDEqkS+7QBUXwyAEBaEfcPbtbu3tEmELxG5HIFl+Os/QU58CxzLr
	WiO9+IjdKnqI2BBus5hJkJc4CD8/HCA6ZtaRFZPqDjiBjxdd6aPwdmqxtj8Fcj4r
	ZnxEuDQ7+qFZr4l8D7NhDgVlYsVwjKw+kz1OoYWyUVAEKBSqhEjpuyd/en2KSZux
	1ClXzvWKQb+cQ6Tas8KRu+WByFFBPZPMyVpMJeK59Omk+ORAOGMe+pKHgC4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467128; x=1716553528; bh=Eg1w2PYM9dk6Lgi5O1oet2oy1Ugi
	ajD+OzX+E+gmbM4=; b=V4a2DiJYJtBYRzbVrKsEltPjbm86YOqLVSfcC0haQSR9
	fJpE3Nx7Ii0OWK8i7NBxnRyP3RyXbr7o0DHpk0/5o3z+eHXfI1VITN1xL41/ltPa
	6oruUPCvBmVwFRp4+mCRi0TLEhhlVmRO1QwXj+tTMSTG83XG9ZJsmXeY3edIIMaO
	6Pe9nFkl0RXXBThzpPCaDQ8vtoRrOXOueNfiOpz1hw22zeQ7/MNpJy4xbllVbMS6
	egg6FIcH0ngpgXnAZ4vIZFnOfRwo+dx529LKWt4SRgf8Jq0Z+idD5hOzPsEiuJ/E
	aNbArlQmQbrC6/TjqJv2JucP5ywGJudo0ctjBAHHmg==
X-ME-Sender: <xms:uDVPZmj993qzkUrcb6LgD25v0w7z_hqq790QVW-ydV_G2uhiuEvNgw>
    <xme:uDVPZnBxGD0LOPjcfTsP4aCmQgHOgDv-rym6Ice3gflUKwY9Y1JAMv3Uy5-gRO1FX
    dxLUdzRyQPGBy09sg>
X-ME-Received: <xmr:uDVPZuFE86PpJLOEU36neSnVeoH4lRrxcYSEWH4wEKiuqQhO41_2oo-5O4gv7gw90105esu4m1kVlQVrA0QoLoOGr5G9Y6dFIxp7kq8zJkZflZgT4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:uDVPZvTlxUDiAJ6hsJgQ3gZli5QL6cseImVFkOMPdnoMN3zAL2Iixg>
    <xmx:uDVPZjzlDzJW_sGAossBObNpsKq25SFqOmtGbyWk4Gkavh0fqSmyDg>
    <xmx:uDVPZt4e73TZnClN6KQ_9Na_D9Cwyza3Y2jxn1gU1N4kA3FbsNr0UA>
    <xmx:uDVPZgwq0Qqy1iO-GA_ykmU31cEVHWXAdxUfrTN925UJLj6taNwnNg>
    <xmx:uDVPZso78CYuNfTlpo5hiOFs_AkM1mHigoBxvel6A_YONcK2BrPFTvC8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:25:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7a203ab3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:25:21 +0000 (UTC)
Date: Thu, 23 May 2024 14:25:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/20] strbuf: fix leak when `appendwholeline()` fails with
 EOF
Message-ID: <d76079797f3a4ab55ee1dc6e6ee761dea021d70a.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+kbI2oJpHe1JON7Y"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--+kbI2oJpHe1JON7Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `strbuf_appendwholeline()` we call `strbuf_getwholeline()` with a
temporary buffer. In case the call returns an error we indicate this by
returning EOF, but never release the temporary buffer. This can lead to
a memory leak when the line has been partially filled. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 strbuf.c              | 4 +++-
 t/t1400-update-ref.sh | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 0d929e4e19..e1076c9891 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -691,8 +691,10 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, i=
nt term)
 int strbuf_appendwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	struct strbuf line =3D STRBUF_INIT;
-	if (strbuf_getwholeline(&line, fp, term))
+	if (strbuf_getwholeline(&line, fp, term)) {
+		strbuf_release(&line);
 		return EOF;
+	}
 	strbuf_addbuf(sb, &line);
 	strbuf_release(&line);
 	return 0;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index ec3443cc87..bbee2783ab 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -4,6 +4,8 @@
 #
=20
 test_description=3D'Test git update-ref and basic ref logging'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 Z=3D$ZERO_OID
--=20
2.45.1.216.g4365c6fcf9.dirty


--+kbI2oJpHe1JON7Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNbQACgkQVbJhu7ck
PpRa0Q//VqshMhJus0AvU3sGBImIuabcO370LFxtLfRT9Mqb98+pP5CeJTAKIcFQ
1wEP6Fgq1QatK//Ki4+ec+aDomVyjykN+sl3B6h9kKETKjk8b1wogZakELCU3/eq
1nAYH0H4P2C+f0cwvcENISg8c4YR2sXUDxa2mBAbrSnLEWHoiKxUIr5eWjgxKwil
EOjv8stVoaRdsyw1WG6LizNpNhfhQFUSNPEAUw7oeNheUmKS982hY5PPbKw3kn88
VaLQY2gueLOSCQM3/z8BJc8O0flRLNYx+iRYhPKTPBg3y8Ztv/0Eger2Asb7zPd0
em+tXbwOXXvc2FqdBd9SjdFbNgu1LjDK42OckCAKZygvpVfSjd3cNvQp9llkmqq9
4YVf0LWWU/3IC1zy4SXfmUZKV12XEY1Wpv1Bo9wpOjaVLNCIYWnUV0kFbk+DEWHp
BXK5TbsphBEMoqg9eLrzOm2hkZwCEe0e3sREMAtQZ8pvgauSjgiUDrWA0z8GXcm7
EAXEwY7bNq0DpkNLWVUVi5uF2LtuPtYNlm38tcFyi5DnRzgzLyYVF1d42oM7RCL7
8va0zFdqe6Xb5UTCdi1iyl51+Roa8Nl8htD0Z54iy+/7BV59fs3RdfDHwOhAbhGD
62DUzw/VW/BPica+POueReG4KJIU+DpBvMxcCEtNqsLtYmLvcjs=
=oyQS
-----END PGP SIGNATURE-----

--+kbI2oJpHe1JON7Y--
