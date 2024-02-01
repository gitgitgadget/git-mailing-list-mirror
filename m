Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FA15AADA
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772808; cv=none; b=ostp01f3rLuyvkrXKcxC/fwzUr3QPKoqF09T16JbsQJ02g7KBW2ZxM+WlTsngOd5cjEjh0N8p0VPXubuJdrJFYNfVDpKTwiCE15Ouvyh9jkBPAznXSBrZP9O93OhyUj5fTBsZRCyuiqYyeD4H4Nu+a/0Itmo/RFET6MKjH7desY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772808; c=relaxed/simple;
	bh=J/yK1aPIcEnEY/LhFO5/jHiTEXqnpGWpdcEAzN793S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqhaNEvuIOJsekC1a/++k3zuHpF3bR92fZupcveoovUsf5MVxwBrECwFeIJNMMwYrzfmsXOSlAFXNL9jdJJ+tbaDQULYaBJBwxcvWuoVKJDRlbcmk86rz2Mf6ZilblnoDyR+WzGuVAVZ2Ne6RF4josYgmoS05AOoFvgHq2WJr6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U2TsxuTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wj7zbbA0; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U2TsxuTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wj7zbbA0"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 4754E1C0007D;
	Thu,  1 Feb 2024 02:33:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 02:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772805; x=1706859205; bh=1VOQR6ox9W
	o77Oi/3L5T7VKQXxzAqoyA1gj2ti5kNrk=; b=U2TsxuTETBxGS5PpGOayXQ+xae
	Zg72CiSWUcuHFg0K6MGXycF3KIeHrDESFScVb5cGNWw2vYvfrH7FjAeFFWf3PYws
	nQOD7Dy5WyojODs6pJ6mJ5dXgYca070p+nmqe5YEbzE8c3xVcadIcDUd3yL09dBb
	7IeqJuQZPstM8XK1U73FS9FMqs2QhJeKDqjYs61V1Z/enOvPJuAklbLXy1PI7w5g
	RQW6ykRwNt4yFqTV64qvxjculk8Mm3q/NAl/c0fLZHWQUbLKCyK/qsaElo7jIlbl
	d3/TcJhVgG7UZkoVUGGdsZhOZmyw8+Kijvyku8LVcUexEaVl2mudURTR76WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772805; x=1706859205; bh=1VOQR6ox9Wo77Oi/3L5T7VKQXxzA
	qoyA1gj2ti5kNrk=; b=Wj7zbbA0TYMYzOpCVZ4VSD76sqnOVd+j5CHdcb4uwFx1
	BkQauhT13+bvfb3fWviugQDGww+Xb+Kdp0MhuAghm1Ec+HbJv5BFC/lAvxxPEzi0
	nwVjAShfIUdcoq4bKhzeEJF2JGE2bym+pgSFVS6AOHR6U9BJoYpVGtMTphWHjMnt
	/WzYP5fx3q2ZgoSa4uCha9BJBeo1Z4THbQImIUQZUUoWZHgpNxPMXW32oKRn9wvH
	nBi9T0r2CJo9p6aaFsNW10KlMEihCZJcDWbmCYqts9Jd1CgGmPG+XLvqNtByZGZR
	mxX9kff6GZdbg1+rG1QcsdhbVrKi9dn2IpqITsAcVA==
X-ME-Sender: <xms:RUm7Ze0ZFWDxDeBG3DaPajnDGSVBn66NDCBkF1D-1YusPRJxaIczuQ>
    <xme:RUm7ZREUuZKBFBeparx_vFT4uL6AulylkdVhWZS0I-HY5jzynvIdt0XfkzdRkR9g3
    -jordrlVildmF-WSA>
X-ME-Received: <xmr:RUm7ZW4p4fX6oeMtc6t-v1dfHEs2nxiLd_A5kMNJ0QSLOQUklywMWBlQtm01FDWfB-IACZilrYRprEd2Tv49fS6Ia_ywGMYTxy3giz-2cRlQPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:RUm7Zf3jYtZHRF-Uk0m5xvaVmzPBWpDWxjJQZcPMZc1iRpuE0GDARQ>
    <xmx:RUm7ZRElcPDn7fTqOCIWscL_RMuRXgdfzxKSGuyr8HbdQZlvyBypww>
    <xmx:RUm7ZY-qn4sdsHONPHTyxaXVYKLOpoyTwSZi68lSYW6LDK9SSP-m5g>
    <xmx:RUm7ZRAz14fyVSnfKIPSRU_zfwy-i_R7RC5M74jMb4eOyGLtr-ys7Fufv7g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:33:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3d6631e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:30:02 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:33:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/9] reftable/merged: refactor initialization of iterators
Message-ID: <8c1be2b1599011f57479249c19f4e4742b7d8d8b.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B/TnGC8Vq1hfX1al"
Content-Disposition: inline
In-Reply-To: <cover.1706772591.git.ps@pks.im>


--B/TnGC8Vq1hfX1al
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor the initialization of the merged iterator to fit our code style
better. This refactoring prepares the code for a refactoring of how
records are being initialized.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 0abcda26e8..0e60e2a39b 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -19,24 +19,23 @@ license that can be found in the LICENSE file or at
=20
 static int merged_iter_init(struct merged_iter *mi)
 {
-	int i =3D 0;
-	for (i =3D 0; i < mi->stack_len; i++) {
-		struct reftable_record rec =3D reftable_new_record(mi->typ);
-		int err =3D iterator_next(&mi->stack[i], &rec);
-		if (err < 0) {
+	for (size_t i =3D 0; i < mi->stack_len; i++) {
+		struct pq_entry e =3D {
+			.rec =3D reftable_new_record(mi->typ),
+			.index =3D i,
+		};
+		int err;
+
+		err =3D iterator_next(&mi->stack[i], &e.rec);
+		if (err < 0)
 			return err;
-		}
-
 		if (err > 0) {
 			reftable_iterator_destroy(&mi->stack[i]);
-			reftable_record_release(&rec);
-		} else {
-			struct pq_entry e =3D {
-				.rec =3D rec,
-				.index =3D i,
-			};
-			merged_iter_pqueue_add(&mi->pq, &e);
+			reftable_record_release(&e.rec);
+			continue;
 		}
+
+		merged_iter_pqueue_add(&mi->pq, &e);
 	}
=20
 	return 0;
--=20
2.43.GIT


--B/TnGC8Vq1hfX1al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7SUIACgkQVbJhu7ck
PpQIYA//TlxnSbz6uftulENeY+NgjkwdIZpv0772mrOqxiYbwaW6d/RgECHELU/i
LInsdynnAQLxQ3dXyFNYBQqtxAqTcVr4C7ShhnnZUMCfBEKsoYm4JyPzKj/crt65
byxpMyD9A9C7hR//yTm6yE304zmzN5oJBv3jvarPMm2as2PzSqthlvl7qWq0cF/9
QtzVRUrwpOni3Ro1nbAwitV84AXJObq7jL0U1DTtdc3FvliqDUr4x/Z6Vx+sSwJP
7k6mM6iyhDRUQib6neqp9RUQM9LoYRG3F9OK3wnIwtr32/lPHDHsthiXdzxCdRq0
D66zQbDsl5B7zIfodinuknsoBWEC/sO2LaeDSrEO+At4EPXFuV2nqMSsxRyMHpvG
w6hnI1G3TbEUIbZIDPHFMnIhRPrtCkXSbb+XGsWplHqR/aabVWZ7UPmuhcYy4JCp
1O8djX52Xgi8ychS985pcLNrir66Sft9BrnxR8z015/jCQkz97ptXJK4an31h0Vu
QS1N02kqQMUiRPLYiQz3HB5O9nN5zPR1qMg5HTvHJHPJ2oycW0t0aTAgqHseS/C0
s54ae70Y5gjARtdWHQqW6OHr6GQOcQ8dcHhJ3s9a5winy79kVrj33oc4bnPdFa/8
rfV3SMeLW5wU/ABCmS5VPQDbf8cc117AHwGvCZiC1WiytA372Ds=
=3z2h
-----END PGP SIGNATURE-----

--B/TnGC8Vq1hfX1al--
