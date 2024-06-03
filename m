Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402C824A4
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407588; cv=none; b=mzazYa0E+gFZs68TXyb7JIY+Olm7iPPOb3l+/nMqDBDm+P4wODBzqCgeqifNCfGwRWgA8K1f7A6Lb+ipkmpoPdsRV359JpcU9zW0Z3eLFQO0zlAHpdl8krSaCdP1/YGqkicCU+yOgLRJyPEPZO1PkcRrxhzhE+8tx5DAO5GB4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407588; c=relaxed/simple;
	bh=1Lzu1RQk3KKHJCDcJ2apZzjagPAP0Iqt0Qh3Pst/Jx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/wrGtRX9/RZ95HH8EezRo01VMAQif1j3+QXi568TczAwH2q5Vdat+3Ooz7gSR3SAZFfiXB32CPRqQpJNczJtS+n9zGEnuIAZULCjbr5dJvXXVNsq5bAvp3RT0HiDYCzaBM9YZe+Mgt7AllTCbtlTmCgEbmbFYU+DtVnZpNeV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IMhZPAtv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PxGkCWf9; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IMhZPAtv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PxGkCWf9"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 9F7071C0008D;
	Mon,  3 Jun 2024 05:39:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407586; x=1717493986; bh=7NdJf0kpIv
	ZeIrbjliLJPdIIvJjnMY7H4TOFBd0Sim0=; b=IMhZPAtv1EWssCx03xaK46onvP
	MM3bvbUlViaIq8EjD7TT6oiqg9zLQmLPmbnzDs2YzZLNUOrfeuANRKTgEUi+vmFb
	Qkb2JbHqNprEu77P6NUamTf4u3QD9xuEVZjTB4vTzZF2mcjW2odbVIyYisQwgUo2
	pA4p2w+FHmUKlPtJbWyPbtVNUvpmvlSRnMUdNewO/Y0Yo9M1m7tbzxdmyFnDRdKH
	NYrxbcLyy33W9bE4d0kiDVInlDu11Xvp/3T+/w0NuPEM5QDkPUnTuxZB8h4RAsUt
	OjutGcjK4qgSA5wHSFbjZVwTta0aoRBIzwxyOyE3C6BV02CSGq7vmCDA/N7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407586; x=1717493986; bh=7NdJf0kpIvZeIrbjliLJPdIIvJjn
	MY7H4TOFBd0Sim0=; b=PxGkCWf9DZ31QdIp1l+ql98qKyueQeed7wpegzsl+0Ak
	TQRUSQ7OBH6pYvhxX027ZmRjVF282WHFInnQAnGvQTVau303JHZovI+hjZK+NaE2
	EagSo9Kwj+OEVE0BMXBT0sOMwGCTIVOBLBQYJIExza4US81WRoBcrnceboR03IfY
	XwcUi9FsrR5h9+aHPSZPtfN9+i9/DUZSIh7sNd2fTYmF9CI5vKA5gcu22OtGp8MB
	z0oUAQ/SIjYG0RdB1SfjXxxKm5aDJyUk17qkerry24Xn5C8TiXi7ozCoAT5gB7/i
	/ko6qEO5ux13o+657JvsQKccYGBaRe9HlZQc2CXvJA==
X-ME-Sender: <xms:Yo9dZsfpuTbvt27-rAWUlR_h0UfxZDQOQAQg7WjdV8ArbRuK4COG3g>
    <xme:Yo9dZuNvm7I17uYy7R0GIkUIjlCNUEdlReoOKETOb_lKRe8s3qOxeaA2mDFpdqcoq
    H97GzxQiQOInAF4cQ>
X-ME-Received: <xmr:Yo9dZtjtWKkhFiyK8OxGQmSf7mtByaVD1RQMl2HN9FrsiYGcs3GqvAPMi0BG5sjVEIfBNPDpb0mx8o1x7a0eOXEcuM2sFfbX4F4z62U1rqwFOzNz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Yo9dZh_BkNgDPd7khSODRBL2bxLrDzjhFkYFAc8zMJDMXi8B6UYICg>
    <xmx:Yo9dZovY-2nQt_mwB6P5DC8ns9sT8vHCTC1rKeDaClEgMIqyL0U-AA>
    <xmx:Yo9dZoGx0g-g0sHtFfarTRrlUjwOq_cbgxR-x3IfhYABY5T21elKtw>
    <xmx:Yo9dZnMLufseGKi-EJVIkiduIz9RtfNmoLmbXY9Hp6Mslge5OcZrZg>
    <xmx:Yo9dZkJmtZKBnqkhDIMfgIkaqZiEyrNL8TldIXD7kWhXcu1YGZ56BM6M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7c70d360 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:21 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/27] entry: refactor how we remove items for delayed
 checkouts
Message-ID: <6fcb7d6685e171c5ec781ed86058906129232fd0.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mbh1v3Ooe5nqxasr"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--Mbh1v3Ooe5nqxasr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When finalizing a delayed checkout, we sort out several strings from the
passed-in string list by first assigning the empty string to those
filters and then calling `string_list_remove_empty_items()`. Assigning
the empty string will cause compiler warnings though as the string is
a `char *` once we enable `-Wwrite-strings`.

Refactor the code to use a `NULL` pointer with `filter_string_list()`
instead to avoid this warning.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 entry.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index b8c257f6f9..f291d8eee6 100644
--- a/entry.c
+++ b/entry.c
@@ -167,6 +167,11 @@ static int remove_available_paths(struct string_list_i=
tem *item, void *cb_data)
 	return !available;
 }
=20
+static int string_is_not_null(struct string_list_item *item, void *data UN=
USED)
+{
+	return !!item->string;
+}
+
 int finish_delayed_checkout(struct checkout *state, int show_progress)
 {
 	int errs =3D 0;
@@ -189,7 +194,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
 				errs =3D 1;
-				filter->string =3D "";
+				filter->string =3D NULL;
 				continue;
 			}
 			if (available_paths.nr <=3D 0) {
@@ -199,7 +204,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 				 * filter from the list (see
 				 * "string_list_remove_empty_items" call below).
 				 */
-				filter->string =3D "";
+				filter->string =3D NULL;
 				continue;
 			}
=20
@@ -225,7 +230,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					 * Do not ask the filter for available blobs,
 					 * again, as the filter is likely buggy.
 					 */
-					filter->string =3D "";
+					filter->string =3D NULL;
 					continue;
 				}
 				ce =3D index_file_exists(state->istate, path->string,
@@ -239,7 +244,8 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					errs =3D 1;
 			}
 		}
-		string_list_remove_empty_items(&dco->filters, 0);
+
+		filter_string_list(&dco->filters, 0, string_is_not_null, NULL);
 	}
 	stop_progress(&progress);
 	string_list_clear(&dco->filters, 0);
--=20
2.45.1.410.g58bac47f8e.dirty


--Mbh1v3Ooe5nqxasr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj14ACgkQVbJhu7ck
PpQNHRAAlnVvD14/D9KbLdc01xpxdCLqNsqtQMMeOy+lJfB/+rq6EgUqYFZZmxLR
j61moSprvqfDg7VkZmiTKBXt8/W0aDhV3/hUzR2m3krVjZh6/I7Zt6ZnJWKKZHPT
wsM4rfzV0fcfSpfePdBkDZojSAU7A+/OdNQu8TaqhU2c5yHctQeTFNJjkfk0bi2h
oRLMYWJtyLp518VaTJ8c7c80kq6aiUwNcBK/kCe+x/RuQDt7gGKV2TT9s54+Pp0p
aOLOOvX9zwVoGUmm0L6bxNsY0EgrV6X9EBvlhLdVrHDcy3hMQBxAiz0Di1AJn3Wu
fZ7GRlVUmpp3rGudLC7+5IMCImZrUIAuLLCH043w6MFXQ0DKzPoVuZ9KqfcfNCxk
akof5VDWrrpDzoamcHw9zgw2oJSg0baKW4y7vl9PyXOLAXKNBWJjHHZ5hiLH3YMv
S2fxzcRzIQtbKDBLwBV5UMH+Neugp/gyfkD1N+Z7epuTMkbqgE0H3KVUN+NwqjAa
IUWSU3S4NlhG6QoMIkeoLj1Goro1ztGvlMifdSaYi3toNaC3BHXRNho/WVwuG//C
oOBFpbxrGJY23PjUx0ZJtHTUzUlnEhDe+gaeWnub1PpvU4uUuoEBuz6ZyPhrx9BK
9K1OE7MEQGiT24E/hPUOfnJR891iZHD8oCjkKW5PcsrXacpa6mc=
=my+Y
-----END PGP SIGNATURE-----

--Mbh1v3Ooe5nqxasr--
