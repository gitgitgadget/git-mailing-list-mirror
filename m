Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9683CCC
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545015; cv=none; b=Mke69AsvuhTtcz9v//2UOfOpOMCYefLNZTJK4wP2oT3rRa9TukqbY/i1ruWIODQ5c7UrMOI9P1gBYOd4e3MRhdrKvPpcjsriOJMNf7cfKb/eP06VBagxMuaf4iV6YGf4Ugv3lu9mbN1+OJdjTkA26Z5RRbcgIv4xqEcB2I+IUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545015; c=relaxed/simple;
	bh=jQUf30iKzOXNZHmIlwxmH7SvCoLpCB3uPrLQrrJdWYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JycoFoO9pIaCoAlL8+OU5gTEd8skWZRHoV3Pl0Gua4C3yxLl3rrL0oKYwMAowC0A4/1xnb8GmANZpd4aC1WRdEorJJpvv/smcGEONX8Yz5ntx83jz0wgdf/d2zQMcHzGRYEfplNly/Y+Z0Zn/aa/N3mWfkSoNfDrrApoSjdUAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QSuoyU/U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J7jdjRW2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QSuoyU/U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7jdjRW2"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id BB6E413800EE;
	Fri, 24 May 2024 06:03:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 24 May 2024 06:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545012; x=1716631412; bh=DUhxDpLVvP
	sr2cH02D+9p+Y3Bp2+c+9zLus/kPYlyoY=; b=QSuoyU/UiGjm/fCwtPDg1fnbdj
	fMZtn7ktbWAKoW62S8qIMfWUU+YJIZx7aJxJjBP1inqr4ON+a4O62E5ts6RUU2jX
	xATTF4xQp0LeqKV2DMQgRN0Vt5sc/DTB8Bz7FzobFI2N1lYM8zkoch1/t1LI5c+U
	KCsQje2OmjMnXWWxwnEKFEUP+DiMpwoFk0/Rz/khIv4JebD+rx+2c2Dv5gi9Ov+o
	DS2wAwqwZODv/UXwj1kSFK5Co5IWQ+Mc7Z67cNaFQJDBzA2kKjuCOSli9DHW95M0
	81Df3XcqoQpxdTIA/QZjKo6IC9OiVT+0aLf6bJOTHYuoq1QZRwzyaXR44VZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545012; x=1716631412; bh=DUhxDpLVvPsr2cH02D+9p+Y3Bp2+
	c+9zLus/kPYlyoY=; b=J7jdjRW2GTt9e4pMDTcJfP4WMzzYvUEcwSbTRaQHE8/r
	51az4ataYEhJFp66GC5d2zlP7/AaH6LL7swXrWYvAN7nbayT6HLyaRS6KvlgHRWi
	w2ZwuXgmHezeY9TEjHmA749qeqX+e2xPm/OWmd+lpFoKeu823X1e+XGobwPB1y9k
	2ucMMFIDtMEMUOy+Z7aw1OPlp1CegYGpNtkllyBPqyBzJs2fw6zqIgq9MhIEcENN
	p96+Y4jLyS6w3WhrE40uxOQqQylN7M9KKIXf/93/o4Q169S4h0wnTHC1dqM7MAKu
	dJT0E1YHeBOM0v/SOmhRNU0IfKasTSYKDE4en9u+WQ==
X-ME-Sender: <xms:9GVQZl91xga4WkMnDveheAiX3IYcMc0dlhqV9f0KUvj7Vb3Wz0ogWw>
    <xme:9GVQZptvfQ3Z_hE8wKm7r5_uvrDi6DAlL1NzJJ_O82u1gRB129uJkXVuZcO449s19
    kA2QALu6ipiLG9z8w>
X-ME-Received: <xmr:9GVQZjAf8rTG6i53DqXo-qLbuqJPDdjcielQR-ENtNU0aJZ4nBlTf73qcdRwFEXMYRmYj4O8_KvQEPjFc4lzRlZwOsbq54wdld41dYt6D2Mdqwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9GVQZpfTPziXPVF_kuHiAy1Wj7kkPURO8-gBjL-uH2D-DUqWL4zlGg>
    <xmx:9GVQZqOFvojNuOMydXhzKNY5Yd9RZB0ac3b-R1113rsj3Sw_RAY56w>
    <xmx:9GVQZrn0WXKNIomWnjVzR1khLpo7YHJJXRCwQrLX6ygmiHvtLKnOMA>
    <xmx:9GVQZkv6VP1CqplYiafOOCioOol8P6_4y4GGminHqDMejAeEBVLalA>
    <xmx:9GVQZnrY_Me0ny8shJe30gtueNim-nZa3usr5gXMebYb68bvIJd5n-ss>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:03:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4097e10e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:03:28 +0000 (UTC)
Date: Fri, 24 May 2024 12:03:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/21] strbuf: fix leak when `appendwholeline()` fails
 with EOF
Message-ID: <9dd8709d1b3b350008218133986befdb2ae74bae.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bWuZ05evGVE1NhW+"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--bWuZ05evGVE1NhW+
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


--bWuZ05evGVE1NhW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZfAACgkQVbJhu7ck
PpSxTw/+PotT5BKnYhMd2vMVlbOOF4CQ+5/NCAruViqDRr7vslmdPoR0bhpUl7Ks
5EJQYOo9e+H52IdwzLN9FwRZiRJ0rqz+n5o4w9udJUaqbH1NF1XR6MFFUDNu0lhK
NtsFNckbaTe+jbeCGPTrNadaeFHdF0SPzzWMD5P0xnef81WqLS+QEidrF6sptecI
eVINUBy1C/2GDSbbJ2om2HwpO8GbI5k2jTLjXJfzT5YOav4MDX+HAmpNUOu5KRba
ZRSFebbxzrVprXO+m/fza+g+emJQSZyeDsOX5gnKNKRVyCzB7ZTBszWTVvl8ITkj
Pr7KYVgkunB5VGq40Ukhdwo4YdpFhIyX6vgsfJz2DUqW2FTt88bz4Anhq0k/XTno
XqZPBuWFYW9NJDt/ELlDoWXuVoIRxOTX1E0gHQj8bvZ1TTKC4iIKpsOoviggasxI
SKG/lcvts5yhWy/u82ZemojkbgYACyHUPGClxvVYe4Sk1z8HlvhXOj83Pg1YWsMN
K/WJ4A5gHP03f8OwFxdxHl75+W/uYBtKssAmpAqQt8lfUKmxYPFG1ylXiP8JBawp
29Zf5GEzgk+DjMkAYjgGxfdRqlu/rAQXrQWDVP7MeZ7aaPFffhqX92G3V5KZmkU7
eDZJdq89UupnTE6fbQYmkZT/GAUyzMAAgJO7cv1TI8NHAJm2XrA=
=8g5t
-----END PGP SIGNATURE-----

--bWuZ05evGVE1NhW+--
