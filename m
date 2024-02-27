Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29420145B0D
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046388; cv=none; b=YFQ5jLOxiU9Vgu9In1bmSH9jBhO3JvljXcol6T5zYPCdxp6EMuZHdP1k2DaMdoipXa/ZfyTZmIEbShKuul6cnBA5OgOvzXNaE1LhcrngMw4kRcbVf75gjFR4DKKDr9/hIgzMkWlInHH2gaZfvvNvpjNvwZ52uMsGvIdwCOvuWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046388; c=relaxed/simple;
	bh=dXRwxPvX3ZtKz36jf/hOavFjwaqKjuDBqE+tP3ykPHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucYuacLW6zlZQSvizp7onL/3nNWcJnIyqP/WZfB/xaUMyQkseJHdKxAcGraJgpeBDtD5g6zaEM60MgKOreT266lktKpJbW5QL2jAFAMzlohK4iTHuJWSsd/9NQTKrbnuAxYT2HnF19IA8aq1Fsxn0mfmwx3XAwgfZr/nyYh4ABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pRsCWE0N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OnW8E6ed; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pRsCWE0N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnW8E6ed"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 20DC43200B8E;
	Tue, 27 Feb 2024 10:06:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Feb 2024 10:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046385; x=1709132785; bh=j48CfC6/L1
	wHmtjYYg57/946aqhtrahRWpXqh4yFD2Y=; b=pRsCWE0NjO0Z/m0KYYsoKi73Up
	ooRASAgb8Fz3XHtcclie4x/DRvdxB3m8wf9wUg6uuZNMs9TO7BVGN9oyXE2zJNBh
	x2bbaW3y78tTJqznJ2eOc0cxZkk+0c/ZhDGBHtcUJZpKrx4D01Np/J4xBdAxvlxd
	PxoJCeM1X5B3PolPmW6pMbdGaXG0HtxMIh0sK7WdoPSvYnNgQbYGMLaw40ZazhSe
	irMOCLkkdv+NBPANbTJnPZxbqWP4KHnm16LUfuC/k+4V7PR0NJM+U4VrxVSKTRXf
	IsCkkoFoE6VuVazBsiFznTgMOmy5+2k/OokLs8BUGAcbyADPLbJQI00CusYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046385; x=1709132785; bh=j48CfC6/L1wHmtjYYg57/946aqht
	rahRWpXqh4yFD2Y=; b=OnW8E6edC3vlwSMxo93kVUXAqkAxibHu/r9+2pbvzW2e
	GGc0OET6VeTtlz/xJwzOndjakv2q8ve2JwukpCzMjcX1txwXsg/AOQi6sMhjIIoj
	GN9Va/ST/ljtvV4Wr2HyVtO129fBbJ4bLztC3d0mId0QSEs26VqwaAKQN0LUoI4q
	9u5UaGZbtX97r2OtJgrDYJffvE1AO0G9U33usIKURQpLpHCiXp8ORuq+eHP5c/Rg
	5dk3fZdyBuQq6UC1vBhsBXKSIOeivM1+a+/CFgmRMqMGY26BdqVDVBU6G0iCsUDL
	15hcUfHY9bQaUpkoQ0gBEWm7QbSdfPaTaoPRpWqMSA==
X-ME-Sender: <xms:cfrdZcwjG1y0hZCRBnvTCfU3DWkvuQEwZWb_JcDVu0jtNWC4wobHSA>
    <xme:cfrdZQSivcla9OWzuzQHxhHIC1rUIa6YKMHjxjwqxszwVY0hkK_b1aQ0GpxEEx4JV
    tmgrrS5dAOmEA7GDA>
X-ME-Received: <xmr:cfrdZeXrXRCsi_EqgTqoyfboqz_dR-PobGR9wBnzxIPfiSVLshSZecINZF527uhEfcJT0qEIlXZFq-G2q1vPypR3NW6bEI5AYaiK-4ShInyCACAq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:cfrdZaia7Kua2zFOvBWELAl_DiE4fJC1Gur57yKgCoOxDy9rbyC63A>
    <xmx:cfrdZeCN1EUyPbgCK0ourVaqp81VQwAVKoz22aPXMRkKcExEaCkYGw>
    <xmx:cfrdZbJEXj6paaqaWK5ZVfBRv7_2k7oCdK3lIwc7zTQpsOvbHXyYag>
    <xmx:cfrdZf5SLevsidTJjQoDqa7OMmfeiIb1hMwp0Bz0mqbc91pTc-gShw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:06:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ede55dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:07 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 02/13] reftable/merged: make `merged_iter` structure
 private
Message-ID: <95e1ccafc42aef324b5d44580d16d9463d18d371.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Y6VU9wwztCjcqRt"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--4Y6VU9wwztCjcqRt
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


--4Y6VU9wwztCjcqRt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+m0ACgkQVbJhu7ck
PpTAVA/9GU7Ue6kL0hH4dTbHdPkjkSzxxb0tERfB9H+GVuuQKDKF9tSCZc1sqY6J
o6nSvvMbW1bIg1HTdCVlaCVnOaJuIewc+KSMWlazT/U+eDlUcunOzsmS0AHr6xgU
n5OzcGr+AuKLzKt8LK0Y93u1tdjNhGxgO2EEr0y0K7zheSc5iQON9Q21ikPZ1ufO
xAChO9wqaCAN5em5KFB1cumW8+ecIR0qdclk2w/6XnUZosUQ22BAwCaiMD3q2oWA
Rth9w0/FXdRK5t7C/uPl2qFfKfiEORchXTOvzXIheLWL2v57peHpww0/GyJVBxGo
nY5Qx+bwFOmHsNdAn0rFqH1h+Tnb6VT/JEo+yFkQ+xxJreVVqGvJCsMwrEQLwv/p
qGdjFZICp8wwRNxl0KxCeaGX0a6nGi6ci0e/wSYzG4bh1yZyti88CBX+pbODRywF
4WN3ckLekvasH0GYncYWcQlLfPFfd7b8vxfQN9dQq8iCxoGhpvKbKW4Im3HYye4A
/GwoNDy1j4MVn0KD9HErFGyWJQ9K3F+YlnpNffsjm+E4jPD+yDFCE846eP5DW7AD
GOc9B40LJcf1glb6DdUM+kdORd/ps93WuwLm8U6coQktJxAJkAX4CFVswJOBe3v0
+h4E84Oo1T1YGcjOm8MN4svDqkowE7x/dccWQ+sCbavvN6+cxJI=
=LPNc
-----END PGP SIGNATURE-----

--4Y6VU9wwztCjcqRt--
