Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCA7F7D1
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407598; cv=none; b=Uu2/TgAMBBIKNMXwVIkBwISiAWWLqyrESdg41nV5R/9tBmW2AvopThcPSpaKzee8W4pBT2uISZxfh5gXgeIb0XUoklnHSyhVoXVUdMR46CiwDMM2yxtvGaCaBIRRg2nA1VePhXJj5TwS3s5JrSe1XdIzNseP8FG43q8kDi1sz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407598; c=relaxed/simple;
	bh=4UULHodI+CZxiqIbIOTI/WBFmyfI7+e3NThPffIlvsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8aLco7bHteM4te0YYSep2CXj/9ZKNlklPytRrbzZCGIrrNz+2cy8/nOhL241rIWfygqzzuNVKcR0aHAkNcCp0mFrx6su1/cRj5SNCgTEOzMpY3f/WzyDOBcR6WTS/uz7AAaPQ0sNdbNQ+NTdT7YSexQohzFLU5sPDFIKovlOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bleLu5fQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PqFzmf67; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bleLu5fQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PqFzmf67"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 57B941C000FC;
	Mon,  3 Jun 2024 05:39:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Jun 2024 05:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407595; x=1717493995; bh=6YhehegdF+
	eLHed2qsydZVV4y2SuLBMsiiagce25zMI=; b=bleLu5fQQkDFnyTwN69m22+y3u
	l7v1hoBp58eknWaQs6dtDJ/CxNgu6xXYple3+1b42MyfD32YAouz4Wk7u9tZMJWL
	7tYjYlPrfOj36CziGgyzPacVJKZssxUjkL6Ow/de+YQctt+WiX0qjLLV0RbNfKmp
	/pJQUrCCu5eUsb3dli/SIylp0fyS8jvDLPz090tWpfGiIyFeeiAD31xZWtd4p0a1
	MU6sGu/wzYFJ1/5JZHJOE+mqq4E5KrURK78V+BM9TJfPw3Anl4e/IVM5k8dxyTK1
	l5pNYkDzIrY4Sc50o/d00fEiaLiiMIfqEW1pXaJrSFa+LU0WzQoAguYLnDhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407595; x=1717493995; bh=6YhehegdF+eLHed2qsydZVV4y2Su
	LBMsiiagce25zMI=; b=PqFzmf67KA70hATnOgJN/kUA+IdF9fE9uHhT76FlneOy
	XQVDa0BfiXP7XwlqzSy5B69kjRg/ABw7q58rYdc4IgJV26eJyWgCqRT/pfEOYJcu
	IA1FF/DJm2jOd1TGqFMCgWcMx0Bl11GGyaPRTg2rPX/38y6wnnJQhEcmEOko+GWh
	HFnQgX5RxExFuGJzLWtGLxLVJ60sQckEDs7yG3KqTJGpW4qDRZq00kz5SC/FDst0
	n7Gn/rfhTyf2q49qC6VzfwpLkZN1CNQMuw6OS0bd+OuvdS01kcGHopknKeFbNC1z
	2WbZFbLeVU0fagkY9Nby07CW2izUyFAQvD5hOYBzVQ==
X-ME-Sender: <xms:a49dZpRmLDA8ju_DuHi0-eEZcvwym_vy2tAJ9AowbMcuqaHq5dTsnA>
    <xme:a49dZizBdpcQG1zVY5sWGKhmwDzQo18K6NgF-x_kU4zB_rDMTaQi0ukUQ3zKLIpQy
    U4NqogRsQXITvxiwg>
X-ME-Received: <xmr:a49dZu0fDmOVQoZQpUeH9Nsd1MNt7CNOAnaNrO5cQirFCpYS8oHV9la_cqzwqnXpNwJZ8YOF-gwOMQUPG9LQaM21xOGffhZeX3HpnVy5Y6MA6cLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:a49dZhDyERcl37jA60VrArpbHRr8PNS1W9wDFI3W-UGE8jsWg-qIPw>
    <xmx:a49dZig1IjXa2LvEkkSrPI7pZ1aEAvFu4uJ5028_SnYC2aHTOrlyxg>
    <xmx:a49dZlouGY1eomjqhvDOVdq_ifvfK3x48Qcp2NZJpJ4edojlQJuVXQ>
    <xmx:a49dZtgp8-wRmf4SmwLUmnFwyTAZNU3CQC-tI-Y45GmGKJCm8-IDWQ>
    <xmx:a49dZjtFs1LD-B-uY9KgLLi4OAGdg0e0coLQlqQzwHLWcJHtoWOaGA9Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a54517b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:30 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/27] object-file: mark cached object buffers as const
Message-ID: <384b4c896756b6c709506a23bb2f751bf1fbab03.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mh83h655AGkRj2Rp"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--Mh83h655AGkRj2Rp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The buffers of cached objects are never modified, but are still stored
as a non-constant pointer. This will cause a compiler warning once we
enable the `-Wwrite-strings` compiler warning as we assign an empty
constant string when initializing the static `empty_tree` cached object.

Convert the field to be constant. This requires us to shuffle around
the code a bit because we memcpy(3P) into the allocated buffer in
`pretend_object_file()`. This is easily fixed though by allocating the
buffer into a temporary variable first.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index 610b1f465c..3afe9fce06 100644
--- a/object-file.c
+++ b/object-file.c
@@ -277,7 +277,7 @@ int hash_algo_by_length(int len)
 static struct cached_object {
 	struct object_id oid;
 	enum object_type type;
-	void *buf;
+	const void *buf;
 	unsigned long size;
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
@@ -1778,6 +1778,10 @@ int pretend_object_file(void *buf, unsigned long len=
, enum object_type type,
 			struct object_id *oid)
 {
 	struct cached_object *co;
+	char *co_buf;
+
+	co_buf =3D xmalloc(len);
+	memcpy(co_buf, buf, len);
=20
 	hash_object_file(the_hash_algo, buf, len, type, oid);
 	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUIC=
K | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
@@ -1787,8 +1791,7 @@ int pretend_object_file(void *buf, unsigned long len,=
 enum object_type type,
 	co =3D &cached_objects[cached_object_nr++];
 	co->size =3D len;
 	co->type =3D type;
-	co->buf =3D xmalloc(len);
-	memcpy(co->buf, buf, len);
+	co->buf =3D co_buf;
 	oidcpy(&co->oid, oid);
 	return 0;
 }
--=20
2.45.1.410.g58bac47f8e.dirty


--Mh83h655AGkRj2Rp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj2gACgkQVbJhu7ck
PpSPAw//dhzBt9wQntL9u93GPtxOlU+yRKM4he23j06ngUpeQDvMofkLi7ikF5E9
SUogkzIxlX6vJ4nTfS616xrxNtAh9nOx1+OOBf0ZNrSnolcIkMMIgealW4Mfr3kB
540VNAJBjR9hk5PjSYA3ZkDR8HKMk9w7MC+1NlUcjb+7PAuyxI5snw2aBGRrfvBX
KeF7sDz9a1ie9lS8IOKFgXgfBFpgAZ52e8Ey/KbPJw+OmTRuVWTuK+XuBEe+FZi9
yQ+0oLv/c9tsuV/aTys+q/Un3XdWVe0EAET9Emi93oULQYkxs/DPHuZdMOQCqr7O
znebZQqVrdNfm7QiPoXo4oYcnCVaSaozn2F3ZL+YpgiBvw835t9DOonhcHv4kfki
8x1FEblvzUDf5u15co9EbvQZW8lhmMTrye6zybbwox91ShCbnenEAyHlHDaFQIj4
EKTket3oMZn1BZTx40F4SyrOuuRRe5qU+1LmfMsB7sbC+b+1ecZUMUAQdAv1rgD3
9nHJh1pjIpya8I9DA/qaih16G+JJKdD4b3LdvIk2yXpbxtMLVaDoYxeBgzIi/mCW
U6hp1BWjmVqoiStVtNDKeVY4K6g1I7WtLtki0OhSQ3j9n+8YRjRVuFN6Q/rrHQRw
0JJsoGKXwrYt45f0XZIOvXcZSNJZVXWrl41viNIQuM9m2eZ3bsA=
=c5rp
-----END PGP SIGNATURE-----

--Mh83h655AGkRj2Rp--
