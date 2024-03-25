Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371A128368
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360972; cv=none; b=QqpoqIDAYOYGwkfZw1hjpyuP0n45kXLcRGVcEjuGvx+BittksZBOwe+xiDCuNPIgaJuZxGip71TcdMiMZBVbxfT7pY73VBSxzeNfo+RG/I0evkjiA6NFOS8KXhHkLanhN241qQDcJEAMg0ZepM6yL1nItoFL4xCmnllc4A8EZ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360972; c=relaxed/simple;
	bh=O8xSshl6Dlex+qsYKwcudTfprt5u3o0SlS88O4FiZJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPrWx55RYbLgZjizWwhTXkrY0vap1ZtS8xxVlm568EvV9dr75rj6vjz5nW9ic2wILhaJzrUDQVMxtLCJgDZijsnBEFe6bG8rPh8NR/tcYpif7zkz7/BzoQYoQE88WyHZtHzqmOhRRl9VQkmzfvXn22ngCkchU/aS+xTuP+3oqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dVExGaUT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ER7QyGsG; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dVExGaUT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ER7QyGsG"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 18EFF11400A1;
	Mon, 25 Mar 2024 06:02:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 06:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360969; x=1711447369; bh=Ld9UXFv9km
	x1DA7JdSByfpyq3lf1+vB5G6uz4TlxKaU=; b=dVExGaUTDolU+bo69M7NnKu9oo
	75WX/1RH11Z/SJqZQ6mPNNQlG3d5xrcKtJWZr2Ageu2tiFDo9fUZQDysA9Qxe8bt
	nKhmvLDJvnA0r2bdoEF4vfYkH0cccntfqBIiDGQn/qVG00lGVq9RetNa8vq2Q/cX
	9oWA+bPvjKv8UzWj/ns8GCQjJEareF1nKjaGAreDAyyZZ8KP0u8xplMyxS8731Yq
	3QtHlUzTEPvGLerP2q8YMIXyV2QuAP2iPjjyFueodsOj7pv3iCnbureqFXICRQaZ
	FSk+/uqr+SHgWQaDfYAs+JvqSVylK5n6PaPEaJH3Ap8C/xO5dkYFfYe6Kpvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360969; x=1711447369; bh=Ld9UXFv9kmx1DA7JdSByfpyq3lf1
	+vB5G6uz4TlxKaU=; b=ER7QyGsGd5p6n5YBn1wKeDxOAocDoVMfRsi8jAT7eHuv
	YMga2ijYK8OSoj9tQhOPOruUSayBW8oqgieKFJ7791TjIgm0Zvs7b5J+12kz4sWx
	Ht8sxZtyeG4n1dOLHFY1cUpIAR0GBjbhqU84xPH1JRjYGf1d+beAqH86o3bLNkq/
	XAFbD4tyyIBzf1LCLEz2olz0qS/a1plA/e61QvvS9fcxZR+N6N6aUroqVvZJ4PL1
	/NPN8NktA/Bznh/L/xW9CXQzLb2uctdYr0j/xj+mwr/lVE/62/FkZQunaLHq+SNU
	z539ioftK9IhJEdOgoLttBZ7rXpx3NW2pxHP4x+2RQ==
X-ME-Sender: <xms:yEsBZioJAU-7P0DXxwjLwE4rmo0PHxFgLEOABd9zgmgz1STT7FjvFQ>
    <xme:yEsBZgq_WriHq3Jj_iFif296oksG8yil6XVoBq9g61xEL4R-Cf-j5vR69xw5r_1dl
    _pylS8_OpYKBorIRw>
X-ME-Received: <xmr:yEsBZnOr3sYbrMSrov4k9LAT-o8Q9uE9hri4xC3X5x0802GHsuFiLucODGyBIKyCFAEhlWjeturfeXMLTGo33q3ztSiA__i7mrgu3rDOhPmGJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yEsBZh6-v8cfpnCRlF3Fk6Es1WwTbikZPItvbrd21apqI9bqoMAbhA>
    <xmx:yEsBZh6rXtVjo0W6NzFRvVUBDoWpAelMozEbGYeVe1X6Wwm9TwosUg>
    <xmx:yEsBZhhsmivCyxNziX40MAZQhoIKC0F-oabwk9D7xts3V17sPLg_tg>
    <xmx:yEsBZr4nmzbEb7ALl7yKmH5WSADX2UHOQT4aQFf18y7MI3ZP3FEOKw>
    <xmx:yUsBZk2wFn2gazoKPuj-0XZro3RczF1IYPiAid3N9Y2ldVb4TFGNZw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:02:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fd42cb8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:02:38 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:02:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 03/15] reftable/stack: use error codes when locking fails
 during compaction
Message-ID: <95dda44672a253927d625685a3eb911463318f3a.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5yEAZ2VZIjZO3tVV"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--5yEAZ2VZIjZO3tVV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Compaction of a reftable stack may fail gracefully when there is a
concurrent process that writes to the reftable stack and which has thus
locked either the "tables.list" file or one of the tables. This is
expected and can be handled gracefully by some of the callers which
invoke compaction. Thus, to indicate this situation to our callers, we
return a positive return code from `stack_compact_range()` and bubble it
up to the caller.

This kind of error handling is somewhat awkward though as many callers
in the call chain never even think of handling positive return values.
Thus, the result is either that such errors are swallowed by accident,
or that we abort operations with an unhelpful error message.

Make the code more robust by always using negative error codes when
compaction fails, with `REFTABLE_LOCK_ERROR` for the described benign
error case.

Note that only a single callsite knew to handle positive error codes
gracefully in the first place. Subsequent commits will touch up some of
the other sites to handle those errors better.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index eaa8bb9c99..79856b6565 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -973,7 +973,15 @@ static int stack_write_compact(struct reftable_stack *=
st,
 	return err;
 }
=20
-/* <  0: error. 0 =3D=3D OK, > 0 attempt failed; could retry. */
+/*
+ * Compact all tables in the range `[first, last)` into a single new table.
+ *
+ * This function returns `0` on success or a code `< 0` on failure. When t=
he
+ * stack or any of the tables in the specified range are already locked th=
en
+ * this function returns `REFTABLE_LOCK_ERROR`. This is a benign error that
+ * callers can either ignore, or they may choose to retry compaction after=
 some
+ * amount of time.
+ */
 static int stack_compact_range(struct reftable_stack *st,
 			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *expiry)
@@ -1003,7 +1011,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 					LOCK_NO_DEREF);
 	if (err < 0) {
 		if (errno =3D=3D EEXIST)
-			err =3D 1;
+			err =3D REFTABLE_LOCK_ERROR;
 		else
 			err =3D REFTABLE_IO_ERROR;
 		goto done;
@@ -1025,7 +1033,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 						table_name.buf, LOCK_NO_DEREF);
 		if (err < 0) {
 			if (errno =3D=3D EEXIST)
-				err =3D 1;
+				err =3D REFTABLE_LOCK_ERROR;
 			else
 				err =3D REFTABLE_IO_ERROR;
 			goto done;
@@ -1075,7 +1083,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 					LOCK_NO_DEREF);
 	if (err < 0) {
 		if (errno =3D=3D EEXIST)
-			err =3D 1;
+			err =3D REFTABLE_LOCK_ERROR;
 		else
 			err =3D REFTABLE_IO_ERROR;
 		goto done;
@@ -1187,7 +1195,7 @@ static int stack_compact_range_stats(struct reftable_=
stack *st,
 				     struct reftable_log_expiry_config *config)
 {
 	int err =3D stack_compact_range(st, first, last, config);
-	if (err > 0)
+	if (err =3D=3D REFTABLE_LOCK_ERROR)
 		st->stats.failures++;
 	return err;
 }
--=20
2.44.GIT


--5yEAZ2VZIjZO3tVV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS8UACgkQVbJhu7ck
PpRXzg//arvTpCdOXlxK00Q0TXu5f9rU68I5JVz0YxeZAJQbcUrnbZC3UoOYkOVa
fRieocd2v1PhkFy+VKALHLW0xb4r66KB0Zx+wnVGUUoMGBmstpXaoLewJbBBpVTt
3StzDHEvKz7k7DcC/pW4g5ErzULHUBEZbqr/YQq+81OdWGA8VUCCng3MDzoCltiC
aAO8JriwAKnpk2JHg7exML47dSins3KxRJ3MUoiojHB7OjwkFENsyWCd/AL+J3wQ
vbgmTH/YaNwqhRhuvAA8C7wyXvh2QZibFUrd/MHqE9byQW+gu1P7y6DewkwEgpXB
mu2EQa8R3hagkOPKSjBVBI+9R/SwdJqFaPBKbY7YdPhBQzYuIITuMGltmyZNtF8F
Ses41XvXU4zzaeSR1FtOWCJJUxwlsypCAe6EAqGDEZ0nWMbvV9gLxfh/9r2HQOKL
uzd5YwdGDkLH/qNBVClsH00jFv4TpOxiE5S1h1eH1noWMlxBWdKMeD5y89HKyppC
b3BcKLuW3XSZuBP54pm/xqbPGnSn9u/wGQGaWCYs9mt8rEJO6nYfbgcRINoYosi+
p22pkao1MaB28KsXc0krzy190pLHdZhtrY/QGWeBrtqkKaCjgvG2FFEL9/mpaL3u
qlpzjJIYb27QLB/Swhd1STowmhIoazLAFPO1CFRbclXgewcVc50=
=zvgk
-----END PGP SIGNATURE-----

--5yEAZ2VZIjZO3tVV--
