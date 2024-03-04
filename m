Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0062383AD
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549337; cv=none; b=hWJvVxvGcS20jLKfSAm6E8qluDFja5Z2hMy5DNsf3PGzDdbQIIEzDuih8lMSoMq1418A8jmDfcvpARsPgRRUv4QOONMUzggeNvk/mOiw8z2CKYU4tRje5jjLm8fS5d2yRqvpQQ+UpvvV45V3nRTTCNK8ulSHI1ewpw3l+KzEGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549337; c=relaxed/simple;
	bh=y1zeAUqiajAojoHnxKSHDDj4KkA/PvrvwU20BLEEV3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoHT2NPcgxhajWe/9ksEWCuYwJiKnnlZVjPLQlkaP2+U3xFWz0XjSTDd9KHVQ0A0RuqBYigWgo64Z1tnTjNZfneUb/5xHDig0OZkDT4+d2OFVO3Qw66L8m9Cwp1N0TWbiV8zXeNR/Y/kFAHUd2KFbUdvDOh6OVwd7xV0nPcTpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R+xg7Mfl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWlmzP+M; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R+xg7Mfl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWlmzP+M"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id CA8A21C00084;
	Mon,  4 Mar 2024 05:48:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Mar 2024 05:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549334; x=1709635734; bh=71dMo+5GeH
	INm3DP5QUry1JnndlAJ33AB4Q7B0MV6KU=; b=R+xg7MflyhS/lUBXC8dUXizH5+
	oOhegLa3CyN3QRtv083TvN3lcNIS5pwPVelXMDqk3LfPJJbLZU+ytQJfdJA0ixZA
	BsckJYa+L0YCPkc7hLFz65bi9ru4pwnz5ctkIwUqKpORTFHLL78dIXoWCM4x/V96
	mg3gaxbtY44/z/3DBHYf4XjimYp7IRhVODEq+r1T4gyQzC/St1CyQjNXtkhqiD04
	KGfcAL3S+nxnsDM8mxqeerXwMM3KLuJ12BVeWYagzbKq0IFsVHD/Dnt3K0tpripZ
	qqqrXwwwDdjzNYa0w4Z7VBvDoioeX9gwU/NtBRKQzZ4DOQe5s2UZdu6lhawg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549334; x=1709635734; bh=71dMo+5GeHINm3DP5QUry1JnndlA
	J33AB4Q7B0MV6KU=; b=JWlmzP+M1omnrKlTg2opiCqIopQpoUCZghUsBcdQVAYb
	J4nBiUIUJlSu+lpmu+lirf0JPrJnmkcdHL62vfuSVnftrPzjSb8IUJTvLXu9mMP3
	qiS912W5SSPIN/wdiDoUhGFyJDehblE8PbKfUFBfqvAbtlxBriFVJ98y3TpeeTDi
	28oBjJc2ZXcRnE/uQpvFjONkpfRDGcG3tsCVxnBVtNP2vlQ9g/3vkSyALFThs97S
	DIUSiE6HnyK/YBtcxtyywmvpcZB0hGsK4xpgCFBJXG6uDzlecEYKSiGBcvDfJR77
	NrS398ipx9kgnUWJGvnBADO4+TFKcD4SMv3Kzp6Ufg==
X-ME-Sender: <xms:FqflZdtOU-YhcZI1Lmy_IvvyhhL0tVcPy0r-nNUPSjGzT89Wed8dwg>
    <xme:FqflZWdxK87k7h0RglwPLOpct_k_WSoCKifYe-3NixF17H_W3rorM2ksf8lxYK1KC
    w0ujUQXEbbEzNyqgw>
X-ME-Received: <xmr:FqflZQwrtqSIEy9Pyzch3eEt9yRiD5PC8qBfp1eHGaQ2LrBDzM3SJ-nKXpioKb80HmgY59rY7IrFZNHvP8YVOPYQsjCsnfNFhV-oGWWL2Tt5yno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:FqflZUOIMCg24sJU97Wtw7qSjwfjsL7j8QpXDtAgYC017K5ghJhfEg>
    <xmx:FqflZd_6HasdcwHuUufgFQDcidf5QV19KR9I2WKlpac-Dp24yoNRNQ>
    <xmx:FqflZUXHovOKOJUQ19ieR9FYazss_6hncYONo8n6wHU0khDR7JGqHg>
    <xmx:FqflZYbwYA-DYSh-F8RPQfbTLkJAjZ_on0QtbFbk6aH5zfwEoTZbV2pP6rk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:48:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d393f126 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:44:28 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:48:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 02/13] reftable/merged: make `merged_iter` structure
 private
Message-ID: <cb144e28a154ce19f4b2a98ef68ca3df103e3cb8.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22ydaZwhAMN9CMeW"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--22ydaZwhAMN9CMeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `merged_iter` structure is not used anywhere outside of "merged.c",
but is declared in its header. Move it into the code file so that it is
clear that its implementation details are never exposed to anything.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c |  9 +++++++++
 reftable/merged.h | 11 +----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 1aa6cd31b7..12ebd732e8 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -17,6 +17,15 @@ license that can be found in the LICENSE file or at
 #include "reftable-error.h"
 #include "system.h"
=20
+struct merged_iter {
+	struct reftable_iterator *stack;
+	uint32_t hash_id;
+	size_t stack_len;
+	uint8_t typ;
+	int suppress_deletions;
+	struct merged_iter_pqueue pq;
+};
+
 static int merged_iter_init(struct merged_iter *mi)
 {
 	for (size_t i =3D 0; i < mi->stack_len; i++) {
diff --git a/reftable/merged.h b/reftable/merged.h
index 7d9f95d27e..a2571dbc99 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -9,7 +9,7 @@ license that can be found in the LICENSE file or at
 #ifndef MERGED_H
 #define MERGED_H
=20
-#include "pq.h"
+#include "system.h"
=20
 struct reftable_merged_table {
 	struct reftable_table *stack;
@@ -24,15 +24,6 @@ struct reftable_merged_table {
 	uint64_t max;
 };
=20
-struct merged_iter {
-	struct reftable_iterator *stack;
-	uint32_t hash_id;
-	size_t stack_len;
-	uint8_t typ;
-	int suppress_deletions;
-	struct merged_iter_pqueue pq;
-};
-
 void merged_table_release(struct reftable_merged_table *mt);
=20
 #endif
--=20
2.44.0


--22ydaZwhAMN9CMeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpxIACgkQVbJhu7ck
PpSW0Q/9G2CuD80Ij1hQKselzyTruQEY7rELR7k7dEx5GNbVVZA6SDBFN/3daCyu
yBf60VdWhNf4x5bR+lfIdLOzVrBh9RcBgJfjKGp3wPiQHC5psyt10+C+JAwjUpZH
Nu5NpWlJvzWUN3skvmm4NvGTmEZTOP5hD+uTbup4Em4MrllIARzKgiiy7GdK7oHD
tgA+DDo5qNY/BmSp46WrF8x11rxVAhy+jL9BgD2FAdwDGy1SRyNUishcgKtj7LIm
RYf8ExdgntyDBsUrmhkuCl3WhOBxAoiukRAimLLhsp182eeIWqme10LAgp83caAu
A2b8EnlV/iKAqRtzFdyrzMpVxbzJEdVFfQx6zB8tXZ9nk6xkCcfSrfwQ+Nsn7wbi
pAVY8HhHpN6Q1F/Bp+smQ/MXF0miv2Ykhu6F8xE/ocNdJTfgw/GaHhzV5Wxa0EeM
UN04sOsAUM4pb8BDfmrZ15C/hh0TI4qfSLqkiDawz77TwubAl+qVLM8dCayaOMNs
VZCn2CkqtvCbObdoXClcdlzuu1kG3myJh9fe03wonJIBL/n19rv8AU2g3+SZu4JQ
pigkZG818kVbaxs8O6UnkmQV++8Km68eBDkLbV0vDpEMUcYZ7i+2rS8D3BayXWXW
7h1nVtu5PQM5RqwSSZ122UrVluuCiqik1VipROT6TCsKprKQPn4=
=pS3r
-----END PGP SIGNATURE-----

--22ydaZwhAMN9CMeW--
