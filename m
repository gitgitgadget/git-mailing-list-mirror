Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4B374F7
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549354; cv=none; b=SD4YeMqLCbUXjuue7zXUy8egI4r/QIkSHIxK7FDr0BVYImI7RmKhKNMBcLThXZXypjw3EgWQafnqTwphviAu8bmu+Qgz/Or4TSMtZ1LgDuySjnI0y9xbCiO2JnXGHs1PgcN+I3qN40nqWpvPSc1GIA9xxB6DDM/CYM9JLkTFS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549354; c=relaxed/simple;
	bh=NcrkbZlSmigEVwHejqtTk0By0yABRtTg03F/Hf5q3nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNyepQKCzv6lgs9GTQM0OL6rsdtBjUZ/gTWRg5l0yFqO5neoES2FdY8kO2iIqKdvQIU5jtlBtpS4SIBIqRnglECAJuZ6Kpetdc127Z+CMNeXzgbsKNDsyt7whNVQxsScZtawr4JoJ09YOuT1M6V8GZyjS8TwYvYQEkqZ8pQEEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jeQgNV0y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f1ycUS7M; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jeQgNV0y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f1ycUS7M"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 9E9941C00077;
	Mon,  4 Mar 2024 05:49:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Mar 2024 05:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549351; x=1709635751; bh=tIyRvDKLhw
	FxkuLPYRQD9XSRYkmbf7xWGrEsn58SABk=; b=jeQgNV0yKgBGbSAKMHCaG3kI7D
	tQv45hDndWh/CyMDApvaIwZ+OaaMZkSaTzGDWV8cAyAtQbVOLQqW6/zfptcqXj+n
	YKRv4gFXOAgn+oGiZXm6alC+OuYwDICbamrK/BEHLMaktxOsnCQfUrogq5XQgYTi
	Kc6HdUFWCTXFXj943KStX7ODyDd0QkDWfsnsB1U1X54LHrb0ltRJ3rUSxhwzn2gO
	yKq4Qra1NxlFTlyuSOnT3w/MUh+DPPWOkZ+1i4xqt3iOwo9yd0IhiY4gEgz25SVA
	FkbCb5LJODWCCRUa0UwLGdkl4FKkLyShD8FWVtlt9/JhKj5Lexyv//27vV6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549351; x=1709635751; bh=tIyRvDKLhwFxkuLPYRQD9XSRYkmb
	f7xWGrEsn58SABk=; b=f1ycUS7McljeqaNXaL6U1pZIkg0vPD1NptSZWPjiclgp
	ZX+6YvyKm0+XhP+kxHDp9ahyjg3R/1+ussPIKbBxO7DdMLOJ4kzWo7h4CG8OErQu
	+WWHxngem8ICqh1okE4cy8rGZTq/FoUenEIs/4Lmx2QLtubEyBbtuB9WqIWzkJng
	cfgOtJs7yObaLd8H+K+4jPmGL68EqP5LYCYMrvZgHw2KsdnBgivatYbO3GjEF44H
	bQkct0kcS0VmWu6j8CMrmLuXl/OBdnf8lXIqiF/5M4tAfXS7QrFP+pCuggx82NGZ
	5+zWAxnmCNILiKaovY9GCT+4UKwQE1502t6CsFFveA==
X-ME-Sender: <xms:JqflZdGY2Iwv-ZzkegwFXMJ4AVTlAoNkB4hAddwwUCblZ7TZAIEYuQ>
    <xme:JqflZSXzJvjQcjQFxQqvy9Qb4HdZ5utoYmIgT-aTdlLOPMlNk3VTRgCJdiZYrdYbZ
    sLChoyNRghivaprMA>
X-ME-Received: <xmr:JqflZfIchdqPkwfKnlQgC2GE3uBk9NgzOXgoOOIOem98Q_tjzHJWibq3T_az-CffYstbkt8hfIRgO6z4_gYWgTQBNyQVLPcDWEfpPwj8UTJ9w70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:J6flZTErqnIusIQ11hQ4uc_EyJBPmTcxc4fwmMLZQdA-Hu4AuSfpMQ>
    <xmx:J6flZTUuskBnvSnw-GE5RSfi5jTyYFck1dZSn7cWTcUWhkB62N29Rg>
    <xmx:J6flZePmI7FzavylUxi4EsRKsbLUzD9ert2v7rklWTOQGiWzeG0mMQ>
    <xmx:J6flZeQlf2MMisgRIKqbMhRXE3UWyUuCRRpWjiyKnS_dh1OAAPf318rbFcQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:49:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7eadf927 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:44:45 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:49:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 06/13] reftable/merged: handle subiter cleanup on close
 only
Message-ID: <0ab1be740ef3f067b6464f9982324f5ff7815ee9.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cLg4nf3LezLYeb+e"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--cLg4nf3LezLYeb+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When advancing one of the subiters fails we immediately release
resources associated with that subiter. This is not necessary though as
we will release these resources when closing the merged iterator anyway.

Drop the logic and only release resources when the merged iterator is
done. This is a mere cleanup that should help reduce the cognitive load
when reading through the code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 29ad09f3d8..d9ed4a19dd 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -46,11 +46,8 @@ static int merged_iter_init(struct merged_iter *mi)
 				    &mi->subiters[i].rec);
 		if (err < 0)
 			return err;
-		if (err > 0) {
-			reftable_iterator_destroy(&mi->subiters[i].iter);
-			reftable_record_release(&mi->subiters[i].rec);
+		if (err > 0)
 			continue;
-		}
=20
 		merged_iter_pqueue_add(&mi->pq, &e);
 	}
@@ -79,13 +76,8 @@ static int merged_iter_advance_subiter(struct merged_ite=
r *mi, size_t idx)
 	int err;
=20
 	err =3D iterator_next(&mi->subiters[idx].iter, &mi->subiters[idx].rec);
-	if (err < 0)
+	if (err)
 		return err;
-	if (err > 0) {
-		reftable_iterator_destroy(&mi->subiters[idx].iter);
-		reftable_record_release(&mi->subiters[idx].rec);
-		return 0;
-	}
=20
 	merged_iter_pqueue_add(&mi->pq, &e);
 	return 0;
--=20
2.44.0


--cLg4nf3LezLYeb+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpyMACgkQVbJhu7ck
PpR+4w/+NeF2KZXpA7prERfu0TJHwBgJb1ADTlsAz6z6BeWukj+C3KxouxaNYYlZ
ID7ow3Z/SNabOqqbaRiELJGLLVceq77OYnLyzhg3An/VSImYIQvYTgTFaHqn8btV
MmIQh8R6GixL5/iOcL0BKZl4Jn4mW8Er2BqC+ylSXCDSX3jZNwDYuHzYGDqOXo0z
HLMm/fuTbBNn9USZ/Zzp15RTc7IwdTgUrgggWNvK5fGAB75+hfmINELD6pkjH6ap
vCvDir2Lvq9T5Ea/cg1wGe3Pfh+2VVTVshFLmsMNaUAOvkOQ+m7qSvN1jSUOSZIb
MxTIF1A12aaSvNEc36PRh5hHTmfVY5CR66PUmgtedA/ayDGxU5A5WpkaxhbPQO8O
3NhuX2pYNDRul8Zo6dJjsZnXjFZLg/YV3jrW+SobIR5r0VpO21kH+h0CRScbXJSa
3BhN0XvyBDhwQEoH+i2zN0jkQsVGaq3V/tq46x9JfPaCHO34jCInt9f0UviSTVgd
YcGWn8dCMfpUgvxu83iSxVJfxND4O6th0ZSt31Hqw8DIN9BXVJ5E/qM+l8Vlr6cl
GB5EkojYmzEfCKHAINpCXsPsi8qpHG3ErM+tfYtQ5MiXBnHrWGYg3wmOm7oGiGhp
+g6PCvII5A5Q3DyT/rlPESp1aPKeWIS5Um3K78E9ZmBoi8N0bZo=
=vx35
-----END PGP SIGNATURE-----

--cLg4nf3LezLYeb+e--
