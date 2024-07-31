Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACB1B29AF
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435312; cv=none; b=oim4YiQXAjiCKXhlxrRvnHX99qYYZjPV73PKFE94ODBXr5C4mCbz7d1+BGoaEI/4x4zCEUXzs/6snGFwonaglS4mfdfIx6p4qDqDTP1iw92ZahecRj0qj64ZtKEfGsdgRcdh1yr5grSVxpMjYmPpNtyEHLg9OvlbnBmsU6BT/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435312; c=relaxed/simple;
	bh=ndNjw8mUgbZEU4uqRMxX7J14L2Nd+9SZJrzEVSw5FQQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvLtFNAyuX+NGYs66iUtGj79QoEHwtYLZ7rNPxbdFwylLvUUh1Dj8x4/N5eOPeRQVhPGvW+K7SWrxgqpSsOPMu8HkSKgJijFR4tuGE53KFHXFM5l8Ccf2PnnO3hJ/BJImbFm6XDMYcH1NHIVZav5ZDoCQnaDHy+iCuunOzGvTJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qcWUnh3C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fRF47Cnl; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qcWUnh3C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fRF47Cnl"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id B2237138210F
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 31 Jul 2024 10:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722435309; x=1722521709; bh=rscWh81Ay/
	VFR3wNsJ1glfvD7RiTQZlUK/hNkJQFgZ8=; b=qcWUnh3CpHdJ1gLtOvWZsltL7A
	Eis61x0ospCTeWuU+y2gpLm3bgY+DOAZOdUKJGuBekWeGi5cUVW0TOEsXZ9nZlvJ
	hUqZocG+pYRGAv/HEhz1+YOqRcdOfQRLItbJvfvcirkaERB4X03KTRQ9oaEEnFLa
	vKjC2Qrk/lsmVF9yYPfpmxkdhVkbsOTsNebQcOT/GSviWlvWL8f9OqlZIVyf08Bz
	k0IFz0i5sb5QTmggDZFoyaIZoa8HEUIf069L0WozUxWQk43kbEcRfGr/PdAM2oJ3
	n0ndIWCps6SIsXeDnRVAQqb9bjG4O/mTQ7kUA0pOC5hfFCNLV/iXmxBWl4bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722435309; x=1722521709; bh=rscWh81Ay/VFR3wNsJ1glfvD7RiT
	QZlUK/hNkJQFgZ8=; b=fRF47Cnl/PProRIvxdDprZKP/iHCVQXpMUD/6vz4o6QW
	EH5VeZ0WSductxwOGxkXgMB7BuiVFibqyXVKIuw2x/2Rht36w9Dag3Fo6tVCdWxl
	UXiHzE3SJoirSu0ff9LLew7iFNNfSDL+//FMHemvjYuOBl49t665CXgw/pKkD3Yc
	245/TUc3/0GIwF0IKw421BdhXZ4tUeTngSUdoEWneo40tSXCv4VCe1O69MgvplqR
	UJZgZpQ3cfHmOiGOwnxSgdoXWR8/wfvZ4WYEZONGyNMsb9ChSD/ykMubIF9DkZn0
	gXrHPqNGwK+NHt8XuUC6LjFefd+MWKelNA4XZG9BSw==
X-ME-Sender: <xms:7UaqZsKOVSscSPrnJtrYcHmmI8WJTS7I_qI8kgQuCygiekVdYb66jw>
    <xme:7UaqZsIwfnB6BSB10pmC4lP4YiqMryLattJenKNVsNLCcd6sd9GZCqnnSSr_Ft-vu
    zGRQXUUIkUAyBLnTg>
X-ME-Received: <xmr:7UaqZstmwWuNIW9i1jF2zqvrrTkJHjtutq5NYx-BEzXR7vqaOkiuCmgbspGNQh003m3R63cmfMKWXk7Haf_lVehl8_K-yxygIFbJJN68gL-vgbdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:7UaqZpaSurVtEpae4UCOSo9Libw3Yf97MeNqJXvbZxxcvR9ubmoJQA>
    <xmx:7UaqZjbyrnIQHA6RUZ3WciJPnYB_OXUaWWKhebBRrRNuixbgccd6SA>
    <xmx:7UaqZlBByKBaTwbCabRqWzjg5Pv8Trn-WDz5Wgn_rzsZeEgEu4Ra7A>
    <xmx:7UaqZpZAT2it_aFgcaio5reeCajbwVF5Gubu3ynCIOKyZXTLlgKFPw>
    <xmx:7UaqZqwaHcNE0cZ8CXpxLmQXnw-GHa7Bjys32_EjIM-R7XYpZTvasQcX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8c9d40ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jul 2024 14:13:39 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:15:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/8] reftable/stack: simplify tracking of table locks
Message-ID: <40d9f75cf20d4b76adb1683709e054e264d4e06f.1722435214.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iS8p86OFg39pqzfe"
Content-Disposition: inline
In-Reply-To: <cover.1722435214.git.ps@pks.im>


--iS8p86OFg39pqzfe
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


--iS8p86OFg39pqzfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqRukACgkQVbJhu7ck
PpTsbA/6A5LEHYszLeXey0RUiri0IYUMN50M+bmBFuJpiHrQ3IUafJtfRoFmntQ0
31i3kPPTdqjK8r6LvJ2nnOa9OmPU9ytzfaaj6/PXRxq5tcVBHXhaJ0spcqeIf4as
pba1SN5CH4aK8kbJ8JvcCVa3bZWZNwNmg4+q+rIuXvxfHB6cfHTHRvd+Lwp6uy7Q
rU41LmyoB/v2tlvNdZW+T7NHKxXaDEY69Fr34zEYO/CBkpWSMjFOBR+e7LnVPrdr
cvOY5DJBCi0q3BaQ5hVmwPAuCtCgRmTpRqEzw0TJv2WQq9Bap6AzDS3HcBTD9V+E
xmWzrJnDb9NK2N7NEVy8mzsT3E1ugL4B8vSq2OPGfIR1pfJIth295PB3wu1V45gd
pr/FcPR6pGBAMbCd55eJ03vRba26qBOKFj3nN+SOqvTuoWjOpVWn0M0+90pnEFnl
/ZE4+W+nYz58dzIrGYfyZzDRgPePt2zmcL1EGWSYANTnQtKEJeWAW4NkyPKS9Q8T
Rr3ZTbQ93C5oMMC/PylSCtDAysw/Ess9QFjJMTbUeDFMR5r7etVXr8D+Sb9Oh61d
7cHjXirAMZXpVHCkiAxKpyJXzAVtOKwKXbvRDVnT7ASP0MslBMeIL8UAyE7dyiAY
7bVhhaX5000OW/eJNt2LPp+XNKCOejR50b3tU5PSfJQK6uX6WA0=
=PF/D
-----END PGP SIGNATURE-----

--iS8p86OFg39pqzfe--
