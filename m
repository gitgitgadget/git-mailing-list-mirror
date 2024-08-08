Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22218C33B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126005; cv=none; b=G7SguJwAgNvD0LKjxh0rtZ0JSwcdZ+CwVf90Hib1tJ0EP6HlJCMf5hCXIu0AHdHadUPxfJEQAuSBjaPOrw1eUCblZ3fO42W5jn/ECWOYpWMDKvssPJGDR+12J0I6XBdCSklA55nR8fM58uhuWMAkiTYXoZ1yrVl9Pyt4LrybJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126005; c=relaxed/simple;
	bh=jMZ3sgBxIQdQkSerdJiZl++k/hrD5XHjmuE5SFJjkiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4TSkLPq0IKBUXz12vc3v0bD3MOcfGyO/fU6hE8SgoYRIl8id4PXIC5+1vv30dYdg1iSFg0NvQwXJHNdfzMWoyNaX3/HS/Ll/7LMaHHd/xt4ZczFEWo4vUr2tpUrVDxIsQU7D7Nl1ui3TW72zGDQppoRJ7a5YDtWmlkk/s0rI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l+vTGW3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzpASW+6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l+vTGW3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzpASW+6"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id A341E1382465;
	Thu,  8 Aug 2024 10:06:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 10:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723126002; x=1723212402; bh=3Y2Evq854Q
	qvq/I+HlxmYF20Q9Rw3K0VlF9giBOEUFk=; b=l+vTGW3/uh1djQh6ZzpcPqsDio
	KYT5GWJCwF+VBV7Z/L8YAisN2Ok4uWaNX/k/Ayt+qxwRFIz96LEJajoiEv3ZkZzJ
	KgnLAuV12Uw94THyGv4oawu/3Ua4auYnPOkwtuqA1k/4HoLgpPPLvvo1JLMvu5FJ
	0Y/S6ONiS74JN5EtdrwJHmqSp3179tw2fUPRMuo2367u0od7IBhx9nC8jX2ID8Og
	55FVwbpbbNXibdarfHZ4cAzP0jfVDw8w/SxEaq+nSIRLCYonfuWT4Lck818r+2N6
	EnpGX89ftqgGzWaMOGbHXfY2tnnK0JumR4yuS1St+YG2Vu7sIK2U7YrEga5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723126002; x=1723212402; bh=3Y2Evq854Qqvq/I+HlxmYF20Q9Rw
	3K0VlF9giBOEUFk=; b=jzpASW+61UlWClbWn/hmBhSG1Bbmey32kRoq4wSrQerh
	9g0vw8c9liyZZXIlJmhxh+y1WX7K3Pez6YAEh0gV3IzaYkUOcRAshVtVkz+kMNIo
	rlELa1bzuoDAa+C/tlCqktEnVcyjeRY9uy5abvphjw6r3fpQ+2iOgTzUbJzv7vIs
	TcuJuAIgJx+jiDPta0KEL3rKsmPqJ8RWc1wDrHi/ax7NNehzaXzK5jWdCRE5sjh2
	yHQoaVbM7OS5a2AnFFIWcnkdJvC2cHUttSQ1W+8658wSvUMfOiy45zeaACYygTHB
	BUJIZKdQtpms9N/k+HSRqHqJk3CjnrsdQJiDIdPyYA==
X-ME-Sender: <xms:8tC0ZilUpR-UQavcczaD4002mCB66PCEiHbpzKaBK9EpWVP3Y2uoKg>
    <xme:8tC0Zp3Hw25D6TalDjaLj6kFjbFMs8UdgvZJC5NUc3Y-aX_ijJKw1ZeiJ4C1qu7oD
    WevFCMdLO4Vo4Gcfw>
X-ME-Received: <xmr:8tC0ZgpkzzCTfZ7I6NNVRh51cvAg66lN0-BNjAzloSd56ozhIoxz7TAu8ySZkE_FRtuHIoEb9eV2uM0GPS2Cfqz8BiqCbW68AEV4SIv5yaT5SLEm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:8tC0ZmkASkbcZ0cX8nMbizpRHRZDydvetpvHoII536WY3UYNv1hQNw>
    <xmx:8tC0Zg1H8BS-ELU_5DB9f8tkuYcniFT4BOu7RB9qNgb1v3WBPGms0A>
    <xmx:8tC0ZtuKBhEGjuC93GrjhUUf1kLl5tn1Re3J9RQXioWgxed6idTp0g>
    <xmx:8tC0ZsVyC39F7e9RewKBOm1ftMCprdtB0ano4d99LHi2JjTkN7eZ5Q>
    <xmx:8tC0ZjS1LMPiRPRtJSn-DrHs21fpq7GGfJz0RJF_PnKF06SNqDezwJs7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 10:06:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 457c794e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 14:06:34 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:06:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 5/9] reftable/stack: simplify tracking of table locks
Message-ID: <812a45f3d2ec0709801f95a1eab1ad4b31fc20bc.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1723123606.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KeWlNu2PndiD0v9O"
Content-Disposition: inline
In-Reply-To: <cover.1723123606.git.ps@pks.im>


--KeWlNu2PndiD0v9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When compacting tables, we store the locks of all tables we are about to
compact in the `table_locks` array. As we currently only ever compact
all tables in the user-provided range or none, we simply track those
locks via the indices of the respective tables in the merged stack.

This is about to change though, as we will introduce a mode where auto
compaction gracefully handles the case of already-locked files. In this
case, it may happen that we only compact a subset of the user-supplied
range of tables. In this case, the indices will not necessarily match
the lock indices anymore.

Refactor the code such that we track the number of locks via a separate
variable. The resulting code is expected to perform the same, but will
make it easier to perform the described change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index e5959d2c76..07e7ffc6b9 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1016,7 +1016,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 	struct lock_file *table_locks =3D NULL;
 	struct tempfile *new_table =3D NULL;
 	int is_empty_table =3D 0, err =3D 0;
-	size_t i;
+	size_t i, nlocks =3D 0;
=20
 	if (first > last || (!expiry && first =3D=3D last)) {
 		err =3D 0;
@@ -1051,7 +1051,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 	for (i =3D first; i <=3D last; i++) {
 		stack_filename(&table_name, st, reader_name(st->readers[i]));
=20
-		err =3D hold_lock_file_for_update(&table_locks[i - first],
+		err =3D hold_lock_file_for_update(&table_locks[nlocks],
 						table_name.buf, LOCK_NO_DEREF);
 		if (err < 0) {
 			if (errno =3D=3D EEXIST)
@@ -1066,7 +1066,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 		 * run into file descriptor exhaustion when we compress a lot
 		 * of tables.
 		 */
-		err =3D close_lock_file_gently(&table_locks[i - first]);
+		err =3D close_lock_file_gently(&table_locks[nlocks++]);
 		if (err < 0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
@@ -1183,8 +1183,8 @@ static int stack_compact_range(struct reftable_stack =
*st,
 	 * Delete the old tables. They may still be in use by concurrent
 	 * readers, so it is expected that unlinking tables may fail.
 	 */
-	for (i =3D first; i <=3D last; i++) {
-		struct lock_file *table_lock =3D &table_locks[i - first];
+	for (i =3D 0; i < nlocks; i++) {
+		struct lock_file *table_lock =3D &table_locks[i];
 		char *table_path =3D get_locked_file_path(table_lock);
 		unlink(table_path);
 		free(table_path);
@@ -1192,8 +1192,8 @@ static int stack_compact_range(struct reftable_stack =
*st,
=20
 done:
 	rollback_lock_file(&tables_list_lock);
-	for (i =3D first; table_locks && i <=3D last; i++)
-		rollback_lock_file(&table_locks[i - first]);
+	for (i =3D 0; table_locks && i < nlocks; i++)
+		rollback_lock_file(&table_locks[i]);
 	reftable_free(table_locks);
=20
 	delete_tempfile(&new_table);
--=20
2.46.0.46.g406f326d27.dirty


--KeWlNu2PndiD0v9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma00O4ACgkQVbJhu7ck
PpQr0g/8C0XojfqSwZz3JtAPkxmek0YMQjnoXNXD0emVF/uACklQqSjPMQ4ru6f/
SHb/nUkAFB+KT5BUClt429tqYVDPXAdK8+d55Ev+S07iO6vWhrju3lhJ1YctAYPo
gRvO6/nW0lYTVnftatmBR9irUXWdi4h4b4WCu7kIQMY66FvTXDP+MoLa6kp2Ee+j
Vo26cml4TSheyV9NGiUVUQ9i2HUWalAO6+K+iCEQXzmJh0ndQAcwOfK49ig3cPTB
2yRUR9kvGg94Nw2ssz22BE6sD+yUB2Do6NobuJSykACt8rOWoEZ60DJSD1oEsohh
B5EA3QrjlWj7FSUuomtwdAPz7J4hr3G2ZkVY7tHk7CtX0TzP+F7souhFoLnLZQ2z
lCF/tyAPblNQvpFWJ+T1LAh3KvpVmSUsKEVkXcUYgxjkfelauqmyfshcM9NZ77BM
cYM0NrBKunh/DrBweVMAQZTLJriYkD1RSjtUUBVnv8IvW/W/xHDcPx5eNGLZIPP2
XdJiVwSTXa1SB7rxOs2R8vqJLRsT+C41Lh8azdlq6hmyvzsBNqAJdmjND3CxK3aD
W6zF3kxhK37368w6bE1O9yXgMCRu/3sDeILdsgQMbQgVxus0uKVVD8Uz91aVbxH2
uiQsA0a1dHoMeWEdKwI/3oCBHx5t4t25WNK637/tyZM00GFdOns=
=vief
-----END PGP SIGNATURE-----

--KeWlNu2PndiD0v9O--
