Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F85156F3C
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863292; cv=none; b=Qlh+dcNkIxmUsCPnxD29/TD9/4codXO+n96v1mQPnsxosOmVxkl2gcJC5OcQv17RoCwa69xzTSGjCWUFSjKIZnRmq+jL14xe4ogbeV1/TacqOj2X8/dxyNyhVhGtUb+P6O2pcZ8Z356Un9ONo6gdyDeQSsjJkbdDsHyTAo/NPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863292; c=relaxed/simple;
	bh=cijCqyF7TPHslqc8hPTiK61SpL7F8WrswfpkDPxKUoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bldg0oNcc0Z3s8PK3RE+TPqw1rFYqDH2U+kNEPHZabGZsWx+SoeMHOFtiN7zGLcMcY/qM47yeEWkU+/OAkW2eTaBh3m9Rd45soJibmM0rcKd1alaURXh58YFtw9ViCtn+gWZ5iFa4hjNI+GAWbxZCap3fOLlZLC3DufHZQsGBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MFfMUWcO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GFSQ/JVo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MFfMUWcO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GFSQ/JVo"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D85A91151B53;
	Mon,  5 Aug 2024 09:08:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Aug 2024 09:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722863289; x=1722949689; bh=/e00MIv4lk
	nCw+yX09KbKEVXBeUqzkVeJ0OORjPxiTU=; b=MFfMUWcOK4MaOjxS2ge7Q6fMRD
	T9Y1Egx/20wd0U6qYcyYGF68RHu07Byr00x9KxeseHCn1cJXCs2dXOqOes/dFd2M
	2JBOGCteUopOrx1kJ64wPxHDYoQSMB9NScHzOM7sRyK7ZndZE6aUi49H/fYH3Jiu
	pLPalskmfQcunVDaUBMOkCBajFPbbns1bMxBtQeU3n4+0PJpOKMMeJE5ZiEi9uKU
	B/ht8iPyNibNLzix/jm719bK0pi8dUHuvBtRWtc50cZ9TQgt/sRUjmKQh6IUHSoW
	q+8EVwvnpsPmot6/RPtLrKfY6bFmzRPJt23RwhmawTiSbBTt2fr/edpang/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722863289; x=1722949689; bh=/e00MIv4lknCw+yX09KbKEVXBeUq
	zkVeJ0OORjPxiTU=; b=GFSQ/JVolXfx6KJDoopI3Bcx5/opOHYX7UvMnFtsHfxs
	UrOAamhNNIhpzHNFspBnV5vBzem9ASsR4+ku7GJ5VP+wKP4x67nwU1NyWZGzZBXk
	ACGEeXhNaJfQU+wHIReT2j0W12IL+ldK0eSqyxPelR+bqT5X2Xuexl8kMF8e3lyw
	pQGOMJ/mk1EBUOBdiDmZa2NhKHHPXWPvuUs1RcJDCQhxHWC5XN3i74x1bAtesptC
	CVoJYeWwJolUd1NokebNSSEsiFizilJ8h8tf4IrOFWV5v5znBq029D4FKn0BSs7m
	dd5WD9LCq5sV+dytIkpYzfcEdX8XkRYskm2kxvFvXw==
X-ME-Sender: <xms:uc6wZmHWelbNBOZxmiTkoEXDTno0qhnmI4CMjQkUsVDYPsl4CoT4ag>
    <xme:uc6wZnWJSjaznExzMTbVIo750ExGYcDSxj9-ELDj6C12d6sJa-DDnhuZ3LPh6yP-E
    WLLGAUPwx2j3kc8mQ>
X-ME-Received: <xmr:uc6wZgL9dzr4TKL4e1Ag5GC5iTITI3HtiD0FRTuBJgLkSkK9WEJunN-hQwSgyVL3v3qfYAkhMeOqVGAn2X9R48lB7p36z8JMsMjXM0E_PiJIOwyrww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:uc6wZgHyIfF_PjHQcgBeMswn5w1cesCTUckow-vhvhnjVlufy0nHHA>
    <xmx:uc6wZsW0EF5CgQGaoYyPk1AIlNyjYGD_dtEn1zWoAnbe3sFGzR9cBQ>
    <xmx:uc6wZjOSCAztQBugK4vDrzNuEbzEh62xGT_cP7fK8t6GKAD6VawPAg>
    <xmx:uc6wZj2joUacKyMOU_K3d-wY67ZsRlCGYuXS7xeIxzMeFZM7lSdMEg>
    <xmx:uc6wZjTr75O6FmpPjqUqVHwjn83OwMWyXl2F1Q2Z7Twi0m68UjDphYNe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:08:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7ba2821 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:08:07 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:08:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/9] reftable/stack: simplify tracking of table locks
Message-ID: <73e5d104eb96d4b1894ee3fb1ddf7be7e187ec91.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wC5ypPSljxZwtj0j"
Content-Disposition: inline
In-Reply-To: <cover.1722862822.git.ps@pks.im>


--wC5ypPSljxZwtj0j
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
2.46.0.dirty


--wC5ypPSljxZwtj0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzrUACgkQVbJhu7ck
PpSWIQ//TmWvtp5X7NSoQgVY+PUGG97HekbB0xHewW6TWXgfx15UuhSI9mAQFZp4
JwwvXs1DGroCNW4EMhxCqsPUGItUuqlLRm+GS+kG3wxFHt1i6CsJmnhzJ8vhjiz2
iAJ1Wrhn03roRkPGVpXvsN7xRlHHLE6s4k51C0B/lfFYJJ4d3+wBqJ3xS81W1cZd
GH4Vx3w+Ts41hIt8pLa9IY40awDRw3RlJsSpsmFDghV3779yrYprKcxHTRUP2ky2
jSZGxah+5vWG0wW8ObUFvXSfrAE2JQmVaftiu/uaAgv90EmmXRH3Iqh/Fi9Y3jwP
fVDNk1+tkoTk7lhD94Z7Ks1M6jBg7YPmcehxVfdU6Z1wvwsgQh9FFkBG01iGRJ2J
bq9MJa4D3M2PlheQqQcXGXb2GXcB6wAACHavUW5qTVvKqOFWru388kMWaDUtr780
mot4YQP5GiVHXfjY3mhKeHgTImyoHgI7k4HpQ7msr5Aajesk4BlS974OT0qybUfy
V2TXHgUjWv0qpCKFlTc1AafQt0chW7eROdAcftJZyPmENIMTvJeEyIAj4r2Gx2QG
2XDVgYgu/PObetw+00fsaylvSvxuJUehJNaY9W+FTB24Dx9PlfY7pBiD9VetBCKu
3ZSs57J3ZCmci0670bADEPoPOiUUDILM+ARKwqwhw/QwypNN94E=
=OIoz
-----END PGP SIGNATURE-----

--wC5ypPSljxZwtj0j--
