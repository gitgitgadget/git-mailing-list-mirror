Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95A170A3D
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508707; cv=none; b=i0moePNeFGjYFxlBoGE/rSqlO5bh4sWhKsqNINew/Pk4LEuM/m19kWu/BtxXNwHXYiZK2wgjVt8J1o3DLyq5r18AK4gXpkBIF76f9p/tcJgjWLSgQCQoOyRYI9HWRuidUsxbpIs4guVffnpKELiYkyiWyrSxwgSpMglwBLhNYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508707; c=relaxed/simple;
	bh=bfD5beWF8lH3TatkkMaFk2bj6mX5WPHFLwfSg+PhD6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCic3sB/hYq/IawCiIPinwszSGzUG/7sDa8mrlpVcjqoCgcP0WQGo8L98gwplrvSKAAxc2tMl1CqhxkHlE9mXvWNt7VgElnkdDmKbyPANQGh2K7iT775pWH7oCC54Fa3qhcnDm0UzVU+6Xcb1JYxTWJghmJBEDNY+038icZGZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R9HoebvB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U99yLaZ3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R9HoebvB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U99yLaZ3"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id AF0721388042;
	Thu,  1 Aug 2024 06:38:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 06:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508704; x=1722595104; bh=igtUrbvTjX
	GG1aBNIproiBQPQsv779VhxdAQjYTIRLI=; b=R9HoebvBzVWqXweCSIkyLtPLAf
	jS6fUca6iUD1yWfC4Tdnmwd2QueHLgh2YcZTvqXHZCC1Mr22rINbXPVZhYRaCjyG
	L9Ka5hjz6zsK4vWmMEenDwveyabKE0v/y9X390vcXABvBoSaTgARQo9ncujwerxw
	zgoLXn0oFfUdQKBXa34aUp9ZvqhbH3wsjwAxc/UY9CLkuypQcFhdVWKwzquqLfcD
	w/B9uvxtYv74ZwNEUX8v3dD+Xob9DlZQ97SwuRp/24oIfQDZBSsy5AiX9QPW6WJF
	DjRTVHOerVl/9MxXnqhOwQ8zTm9N4E0kk2XKP0SgIaEl+btSPcMc90Mdz5Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508704; x=1722595104; bh=igtUrbvTjXGG1aBNIproiBQPQsv7
	79VhxdAQjYTIRLI=; b=U99yLaZ3eR9P4OpD+qGLTISGSI8y8N4ncm6e79Gf4QTu
	aM7Hvb++fd6yxh8ngAblG/VpOzaE5Wz4ZNKpKAUMHqDhOQxKmldolwTzpGHUvfwh
	UxqIA5WYI2Y7RLhVPE3RjWqD7a1Ds6H7jynN2PQIX9MHV6U/sy05rYQXHl4hAOPr
	lLdI1pLT1GNeVmOkXqdBKwrnYeJGFe+YZUXOlPl6gQoAMuX2TbVmdRNZ3mQeOv+0
	9OxrXWOKIn2h7ZUBva1GMINQt/g3+Y5pOGbYjRr2EVL1lC7wcA/S3srkI3JC4ib5
	1YtooJqjdF3NJC0UTTusEUi3rbdQ7mkN7TV+Tbq2xA==
X-ME-Sender: <xms:oGWrZlgB6OQ7uS_U99vJzEA5QIW4Iz-WUaDf3cTRiENGOEWWIYaqsQ>
    <xme:oGWrZqC-E73SK3maO5Ckjho-iifHoCi5V6YGDHq8Sdn599Z5JjZKbAfn7qzkCH9PN
    TBXp5nFh9zmmUcoKg>
X-ME-Received: <xmr:oGWrZlFCjLEcxvxfRILrjuTO012-Qyjkfhy-EbetRJhTcIErojJEXkXEdGI78tWQ8zV00hZ0oR_rWpHkZ_RM7SNKXx0cmYp__74LgZb2Ovua49o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:oGWrZqRu3EFWeuZRCV81MfIzfOXVVM6QLdJiz4sL4VxLeVmX6f33ww>
    <xmx:oGWrZiw4tonM6IEMtpAvo8tTdfTE4Pc-m2wnQKT7RyuULkjk76R8bA>
    <xmx:oGWrZg4PhMorilJEmZJsXOA-e4Nj_NVzF4IpgXUjOuBUa9XRLZP-Iw>
    <xmx:oGWrZnyORld_ccTwoXD05YH6L4NTsnYljznUZFsA8SD3oyCdQEp_Pw>
    <xmx:oGWrZprejcJPGPoaE2qvmY0vUDGpJe8n9A8-Z8zObDopuJSwFmkCceps>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:38:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ef2fe2c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:36:51 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:38:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 03/24] builtin/describe: fix memory leak with `--contains=`
Message-ID: <65027d13b75a684d60112b12019871342939f2d7.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hhbBKOVI5MxjwkrM"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--hhbBKOVI5MxjwkrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `git describe --contains=3D`, we end up invoking
`cmd_name_rev()` with some munged argv array. This array may contain
allocated strings and furthermore will likely be modified by the called
function. This results in two memory leaks:

  - First, we leak the array that we use to assemble the arguments.

  - Second, we leak the allocated strings that we may have put into the
    array.

Fix those leaks by creating a separate copy of the array that we can
hand over to `cmd_name_rev()`. This allows us to free all strings
contained in the `strvec`, as the original vector will not be modified
anymore.

Furthermore, free both the `strvec` and the copied array to fix the
first memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/describe.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index cf8edc4222..739878db85 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -619,6 +619,8 @@ int cmd_describe(int argc, const char **argv, const cha=
r *prefix)
 	if (contains) {
 		struct string_list_item *item;
 		struct strvec args;
+		const char **argv_copy;
+		int ret;
=20
 		strvec_init(&args);
 		strvec_pushl(&args, "name-rev",
@@ -637,7 +639,21 @@ int cmd_describe(int argc, const char **argv, const ch=
ar *prefix)
 			strvec_pushv(&args, argv);
 		else
 			strvec_push(&args, "HEAD");
-		return cmd_name_rev(args.nr, args.v, prefix);
+
+		/*
+		 * `cmd_name_rev()` modifies the array, so we'd leak its
+		 * contained strings if we didn't do a copy here.
+		 */
+		ALLOC_ARRAY(argv_copy, args.nr + 1);
+		for (size_t i =3D 0; i < args.nr; i++)
+			argv_copy[i] =3D args.v[i];
+		argv_copy[args.nr] =3D NULL;
+
+		ret =3D cmd_name_rev(args.nr, argv_copy, prefix);
+
+		strvec_clear(&args);
+		free(argv_copy);
+		return ret;
 	}
=20
 	hashmap_init(&names, commit_name_neq, NULL, 0);
--=20
2.46.0.dirty


--hhbBKOVI5MxjwkrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZZsACgkQVbJhu7ck
PpT74g/+Pi5e0yU4tFMJ7p+xtADvHuVvWJY5WzYPD9f3jS8EOY+q/cLcJ4Z/zUBg
OtTM98fP7+rVX1ZPg8RXBwmYPuZqEKahKbQIL9C+nLxHNmplvAYfs8oETFVqj7Rb
wyfvZHZXYL5QnNhFrX70EUVIVerVWfoCIW24mlqKdfp0Q66La3CTP0besD8xbOho
ShZ2LOh6oqMmkS9Tbp4B+NIIMKag12O8kxVIt3Zx1FLhKAtjGSNGFL5BxqHM82CK
qnYu/lr3sbozd+JHz9EeEs07iX6M+g4wpl3W42T6DGH1HJSlN5G8N9UFMJmj11n9
nkk6wGdqJf5sMko0zBSOoHPaVtDYHN32YcT4HUCeTB3Fx+TaktT9epkE6Q8bc79v
QS0GinvVrt7z7vtlw4VA/dwDYQIbKO/c3Mz/y2rNwo9d6XUWpDY2gmJFc4lQsWOW
3u9Y+OIuaBHo3X/Apc+Ms3CGD/SUvVmJE0VBTC5gJ5njcktzLkW99taRwaSrh8EC
TFWdB1WHYsmvDXeQm2HPLs5NT1sfVg0u8+Y0qkI2pDaW0RFXdmWdc5SbbzWR53Az
qkcvzhfYVE/PfkgXP4hG/etOxeI9iMfZPqRgu3vMlVfm11AebDsj4qoeLvvhrXXE
ZOlWn5/w3dADHBYG/HFuXDqwfWaNFmHklPeCgFDa4GyItatO964=
=6LhE
-----END PGP SIGNATURE-----

--hhbBKOVI5MxjwkrM--
