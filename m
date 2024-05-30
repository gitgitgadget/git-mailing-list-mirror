Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0216D4FC
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073474; cv=none; b=J5HNLKR9+94nlhH4369wOH0ZBGylyMoaBuvMGDCFj9MVko4nBJ5FWkig/MMBxcLS+7TqUzvlVL4/3FI2X66IW7wXep3u98nfcEEhg7bRnchUpRxkAJSe9bIOqelFik/cf5Si8B2tHrd9RRzE9nw8hkgyzZ+lv1ZGs/NmHIYVMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073474; c=relaxed/simple;
	bh=TqVp/5qSq/BhPOUg2+WBnLpb52RMdQmQNtiL9Ehh0c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poLdIAMMH6Iw8joLcr90sFiXYR+6uuRw63ynGE8NtqhR+cn9TkpUVHnOVBQL9/mO7lREGXI+XynHBodEG50iFp6NYWwiZ2ZQAQHTcchTrbv7ob3dmBtfcA8ojMDtf1JqCwv2vaPJeXJKhXobKPBCYiKEimAU+H4qSBzwm/fkGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SpA76QWX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNUPZh5w; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SpA76QWX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNUPZh5w"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C11B41140157;
	Thu, 30 May 2024 08:51:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 May 2024 08:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073471; x=1717159871; bh=qMB34Ngz4c
	RGU52Ks21UAzbkVcq6eGyDGIWJVDYpSJc=; b=SpA76QWXR+gS5EPM2NEOpDcW3H
	zWmvmuA2s22HmX2Jo5QE9qY9A/ghwYLs8LDZbQvd2zW9+19x2dFbrWA0orRkBjoy
	jrbBPjYNsT5e0eBY7jYGq9MSSNoznNAia+Cmd1l11wG3T2m062wBmXRmXJn6WfML
	FD7G9blPhpX1QXV8LgPuar6gPhT7LL4u8yIVXpU9ZKotuNMsgzb9l7LYUZ8NkTQ9
	g5u+vB7KOTB7r+AFikEQ74O06McGoQFLa1Md7U2XM5zUDXDZeOcoClE7+EoRqtaI
	avHQnCaHs4MAXpRqprdWCvs9ACTLni9di1vr/JYNTDNwxgzex1za/aX5MFZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073471; x=1717159871; bh=qMB34Ngz4cRGU52Ks21UAzbkVcq6
	eGyDGIWJVDYpSJc=; b=ZNUPZh5w81/1wYbrUUE7C8o6Fphi8RanPN951Q4JWKcF
	W5dQ0aoIPXZskvtc/z1FYUchapFOhvO0XY8HMWQ9bCbBLqqIts3iNz/TwB7IWT46
	Z64iif0j+E55yKAaoIDldQAgneVR217moRtoJXqyuthn/Lc29wzO/PRI+6Rh1eMB
	IHhSEqUeCPdXnPlRHoDhNnHxYaGyXyB1ZYWqBcUzJLA73SSAjnEZi0AgzmgHx9vj
	OdjSjffyyql2QOXfR5ya2FMXRWp0xIw6l8WMWVPLVhNMcvZ5XiR5I/PubMzEMtuK
	0qzh9StxlyujpTbMznWeuD0X9X1SAo+WHoUyKhLpmw==
X-ME-Sender: <xms:P3ZYZmkyZdGmo2rpPxcCdzsD5jU_zViV_G9k4rhVZFiNHkTnK8Ej4A>
    <xme:P3ZYZt3oIuLV_06zY60joojlAHgSKWXlFZfU4vQu7Q0ZoUzZF91Yd9B9OYVWIlrWk
    FLhNXwXYhZYSPQ8AA>
X-ME-Received: <xmr:P3ZYZkoMMO_npwwd1dd84RDE3NT3sdne1OB8jdrGMjv0Hp3dXQWtb8qVgY6gHV6EVH_wLKjIu-Ob_k_E4P0bouG_uxAcOSAVJgtskGdxBopfQ6R_Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:P3ZYZqkjm8eJ-QVIv6o7Pzt1sSrFx2dKSSr83kBMHK6V4lN6wWWKPw>
    <xmx:P3ZYZk3JJwlbWFakqco8sRgdl-w_Bw9C8UCTw6Ah0g71DusXoFjdvg>
    <xmx:P3ZYZhuArn42laqDtzyR5EnVXLmT4QRtX8NPRBjcdAcdEYFwHVWG-w>
    <xmx:P3ZYZgVf5qx_6iEwpHJI99IuOK9WA2ZH54U-1VvtjY_V2KWQf1sLVA>
    <xmx:P3ZYZhyunuSD2lW7Kr5PW5WSVS7s6UxJQh_x5iOh23lX60DY9c6Xhdsw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 04315bdf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:50:54 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/19] object-file: make `buf` parameter of `index_mem()`
 a constant
Message-ID: <e5d14a51738cd4972f35aa30f7b00ab4e6060d31.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HhhfpbCYKzmbkbY2"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--HhhfpbCYKzmbkbY2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `buf` parameter of `index_mem()` is a non-constant string. This will
break once we enable `-Wwrite-strings` because we also pass constants
=66rom at least one callsite.

Adapt the parameter to be a constant. As we cannot free the buffer
without casting now, this also requires us to move the lifetime of the
nested buffer around.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/object-file.c b/object-file.c
index c9e374e57e..46ea00ac46 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2483,12 +2483,13 @@ static int hash_format_check_report(struct fsck_opt=
ions *opts UNUSED,
 }
=20
 static int index_mem(struct index_state *istate,
-		     struct object_id *oid, void *buf, size_t size,
+		     struct object_id *oid,
+		     const void *buf, size_t size,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
+	struct strbuf nbuf =3D STRBUF_INIT;
 	int ret =3D 0;
-	int re_allocated =3D 0;
 	int write_object =3D flags & HASH_WRITE_OBJECT;
=20
 	if (!type)
@@ -2498,11 +2499,10 @@ static int index_mem(struct index_state *istate,
 	 * Convert blobs to git internal format
 	 */
 	if ((type =3D=3D OBJ_BLOB) && path) {
-		struct strbuf nbuf =3D STRBUF_INIT;
 		if (convert_to_git(istate, path, buf, size, &nbuf,
 				   get_conv_flags(flags))) {
-			buf =3D strbuf_detach(&nbuf, &size);
-			re_allocated =3D 1;
+			buf =3D nbuf.buf;
+			size =3D nbuf.len;
 		}
 	}
 	if (flags & HASH_FORMAT_CHECK) {
@@ -2519,8 +2519,8 @@ static int index_mem(struct index_state *istate,
 		ret =3D write_object_file(buf, size, type, oid);
 	else
 		hash_object_file(the_hash_algo, buf, size, type, oid);
-	if (re_allocated)
-		free(buf);
+
+	strbuf_release(&nbuf);
 	return ret;
 }
=20
--=20
2.45.1.313.g3a57aa566a.dirty


--HhhfpbCYKzmbkbY2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdjsACgkQVbJhu7ck
PpS+axAAo01chKvM2MZLI34ZBocddv9potn6YIXrTayJgdeMcuzeovF02ownwPBU
bOhNuluEqU30v1uAbOdLPmq/mkOCm+dLAi8HzfH3d1z8jJ3JaSzZfCFLp/rl3A5r
3fSJH4VSde8TW3LGbeHPKkCcRmEHl8z5tpS7uGhlsCeGsKZzhUCYqnmARqkw+1ON
Beg3ZXea7aFXBjLFQvKcpSeUn9ijjOou6w6j1sGKAmVHry/vU7IV/qCw/iLhYrMM
hwf18Du9OKM+f9cJS9TiPBv8/XrFKv6ZgDgG9ksIrIypyn7CV4nRPkl0j99J//wP
9WZDZz9ZzdcXn4YKkQhYSb4ZDyDpeubUlCzaQ0/g7weqfj3OWuRrgP4bP355E9CI
e984jaId1t43Hm51JUOwhSBjZhXWDB3Hlh8qnj5ycGpLIfPUh6TgfIVmOsvZFsyV
vRCGYFAAjP1xVWmyI1lCCUhBdVW2nbtohX06vpV4pNFdHZ8TZB3bRpamSnitWfa5
otGkPG3y0DWPmusLxLb3UnEyE3q3zBeZnp/r9zldWb9pF1UWw/Xh6ST5iytmZjBn
od+DQkm6hu3EdkpD9ouiz7qyBsLOTwdNSGHBOF5JdcwLwKQOEaO1XEzlIgp1r/A1
ejzXq8kRizkyFeYjn9ALiVZV3LTCmjC8TxivBhnVz3wEqR4luiE=
=mhP0
-----END PGP SIGNATURE-----

--HhhfpbCYKzmbkbY2--
