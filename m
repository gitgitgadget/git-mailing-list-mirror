Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360CD145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504658; cv=none; b=r4gMUJFtd+TXAXadxT7udFNfsHr+ljsCQTFKGaf2VOT+gTCzczW+m5pbhZa+Kxxk5mjvV3hqAL3WsK+Ro6JPr/IKp60tH55yzLqGu1WV5jzGC08ogGC48fuAm0W7l3nLmElbBzgd42aRfnZzgbk88AMEIu5fIZMeXTPb2rRXb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504658; c=relaxed/simple;
	bh=jOJvrtiK1ZZQG9O+umhj6DRg9XmcpF6KqWyddA+R11U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHFygkVm9K3YOIPkhtTqYx9QJOjVWDM6S/NYiOzZOnz6rXw3zoJJ1rTIOZOxQ0uvqjsBAvCyqHPW8ZSYJ1Ho9WRYLyDHQDVh5Yri+bWD1rD6sRIb8ZXgCM0mIuNgCiOZ4NqRdC7PFx3G1bXZ/3ZIJv4rl5r5IbtBSm1tNGQmaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mgR/9/Kx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=blJLztyZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mgR/9/Kx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="blJLztyZ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 61C9311400DB;
	Tue,  4 Jun 2024 08:37:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 08:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504656; x=1717591056; bh=kSpHFFIK7Y
	z6ix+Y7at8eXoRcuYDsq7+BNCaKaN30Uo=; b=mgR/9/KxR/9ZBgNvzWeLNzLB4u
	oENMpUQL5B8b010Wdx7h/kq1Lmx8jxNycNCHnw/R1CdCW3teVG1Ye9JUFHGfiZai
	lESdulanL1pHBxvAZEVe5KH2lqaC7mtXm3yGVeJtP+bidYTdSuG8qP2bd9JaXfNd
	iXkinECvmeE6YQvFyyAfXy3RSGK0PsFdIbs6Q94n71pAVgkdey/WDCR0YrG01Pqn
	tPqz3EFEewBYomex1dwl7PgX7EKhw1hui0TlnpJlV1SD1GwU2hi4YRcRT1B4jyNG
	1tAbVv/7QX8TveTTB3xog1ePA8Yw+rbOkyGmChX3yFxytUKJ3Oyspex/HmXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504656; x=1717591056; bh=kSpHFFIK7Yz6ix+Y7at8eXoRcuYD
	sq7+BNCaKaN30Uo=; b=blJLztyZkfRAq3hlUPlTnepB9epKxgiuPFTfWUIOUlu6
	QI+kcF7wq/W2v3IdZxWPfQnWCwiPJ4P+aWjjRa7UvL4v1B4KtLcDft3Md3vdXtiS
	ESKfnkUQkqnz5Av4TGav8SLSSP7sWpNE7N2UJRkputlpnqO2RqQ81+naFxDiWc4Q
	+qLZ1yeEy0vxaiIWdoVFyBpAlVu5xHuTaWkO6i6c/nKVt9mfg2UCSbD2WeD668yf
	0jeObsLFP/8VoFRnuyX/XMm5orIXjxTG1loMavV0HxIM7nRXXvZ2YYHUN5hNQQpe
	iBBklmwF417MTWq8YPbXJO9WkzvwfRnlFM7ZGWtZTQ==
X-ME-Sender: <xms:kApfZmR5RAUoJQ0cXDiYulfvKHh81g3XE0nLjGcm49k_pxtcaTsNJA>
    <xme:kApfZryjXasGPxig1Kjjx2pZ0cxi7UI6It-y3lhyHvfghCtr6goRkUs5UzYaHgNjr
    Tjos-82Nf1dEpSctA>
X-ME-Received: <xmr:kApfZj33qQiFywjKbsuMTfoKz40wzmDjMYw9hut3LzClaB8--ysiG0vNYfi_zqidRjRAInVBaop6xh9anaHYFh5pWCGOUe9k0jdJUQ1A3b1esbD_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kApfZiB_nnszTuPewqbNe6BuPnj0HFdOKLJm2UIt2-A8ZNIyPgadqQ>
    <xmx:kApfZvikdjaVX0iuumVrl-M-3bkmefzsZQ0GIfNGpTlTFmIj6173Zg>
    <xmx:kApfZuqpQW7VAt80VDPIH-MEw_IBulMr89C8qTEw94dIHaMsvWLI3A>
    <xmx:kApfZigm8_KtP5NpI0igxPPsOxIoG7ljI5F4Uv0APS96RPqcTuM8pA>
    <xmx:kApfZvdRxAaiA6DRYT0BK_DY2Ilh84x5bIzz6kGtz3Vqp3BKIw5zbYvm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1828b72c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:08 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 09/27] line-log: always allocate the output prefix
Message-ID: <b717af02f0958b0c204164ba92453ea7845186b7.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zgzQT7SKAVKOKKGU"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--zgzQT7SKAVKOKKGU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The returned string by `output_prefix()` is sometimes a string constant
and sometimes an allocated string. This has been fine until now because
we always leak the allocated strings, and thus we never tried to free
the string constant.

Fix the code to always return an allocated string and free the returned
value at all callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/line-log.c b/line-log.c
index bd3e663c24..67c80b39a0 100644
--- a/line-log.c
+++ b/line-log.c
@@ -899,14 +899,12 @@ static void print_line(const char *prefix, char first,
=20
 static char *output_prefix(struct diff_options *opt)
 {
-	char *prefix =3D "";
-
 	if (opt->output_prefix) {
 		struct strbuf *sb =3D opt->output_prefix(opt, opt->output_prefix_data);
-		prefix =3D sb->buf;
+		return sb->buf;
+	} else {
+		return xstrdup("");
 	}
-
-	return prefix;
 }
=20
 static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data=
 *range)
@@ -927,7 +925,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, s=
truct line_log_data *rang
 	const char *c_context =3D diff_get_color(opt->use_color, DIFF_CONTEXT);
=20
 	if (!pair || !diff)
-		return;
+		goto out;
=20
 	if (pair->one->oid_valid)
 		fill_line_ends(rev->diffopt.repo, pair->one, &p_lines, &p_ends);
@@ -1002,8 +1000,10 @@ static void dump_diff_hacky_one(struct rev_info *rev=
, struct line_log_data *rang
 				   c_context, c_reset, opt->file);
 	}
=20
+out:
 	free(p_ends);
 	free(t_ends);
+	free(prefix);
 }
=20
 /*
@@ -1012,7 +1012,11 @@ static void dump_diff_hacky_one(struct rev_info *rev=
, struct line_log_data *rang
  */
 static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *ra=
nge)
 {
-	fprintf(rev->diffopt.file, "%s\n", output_prefix(&rev->diffopt));
+	char *prefix =3D output_prefix(&rev->diffopt);
+
+	fprintf(rev->diffopt.file, "%s\n", prefix);
+	free(prefix);
+
 	while (range) {
 		dump_diff_hacky_one(rev, range);
 		range =3D range->next;
--=20
2.45.1.410.g58bac47f8e.dirty


--zgzQT7SKAVKOKKGU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCowACgkQVbJhu7ck
PpTlsw/+JFrH12PCMHktsbPS+EjsBb+M9GcmXjLpSxWMSJNxIgY9hW52imlmzT/3
7ICngwk/KMcuxZW8xsc9tMcuMJQ4T5UbdFb9T5k5wGWG6coewWKc3BqGflUbzMCI
T33zFVLTMLOY4K0jg+Wm4AMx4YSOvCVG5SSEWDBnyOoEnDaHpaY5ZbQ/OmdTeveJ
aVZHr4AF9QiyiwnmOt5nv6QU42nGWlDsBilv1B3pLuEWUD7VqAZNdkYXch0f/ycG
2kFmgrvj/Q+TZJB90/zY0XruP5oa6ZxrznH0nDD8eDiD+EpwWxXo7M9+12yaLYaM
3S3in5A/jDqwCBXeiXaLtEpy5KwyvAGh0o4nke9rXm7NnD+EsDyl1dY9hK9YfSu7
kUToqFUBk/HXkr/aaSDkVJqT/rJQy+aU075jn2vdCfB7/L/kJcpjGXzrEOP9woBy
ZPN2JCFjrAzdptR0ZWAT4vyE2F6V7Bcm4ZYvWrr62KnWGukvw4qBtjLVu53RE+qz
ast6J/G2lEMZlrddcxET8bKtlUftEKs2b7PsYipeovw7WHT/b7rZAJgCjUiQypdg
KDWb9JrEegEKgyp1LFLZzUHO4Cbv/N2VJZ6Pe33/oZBtKebq62vWZY5638HHprrI
0r5DodO7/4aaNJMIZ3AX3HD0xtwtJS3qDV856FZxJN/w1RhZve4=
=NVFg
-----END PGP SIGNATURE-----

--zgzQT7SKAVKOKKGU--
