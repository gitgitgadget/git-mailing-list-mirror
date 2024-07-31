Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9591B1512
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435322; cv=none; b=V0dbu6Y4oQ1wNroOL0fTCuCgpboc7q7vptZnDhtkbIP9mtaOUy4rnJ1K88xuwhPd/GO0WB3oU9EnGWlDJQjgocLngy41v/U8WvRzF94rPSjVtHKCmdkIitu1WB+ENrv0RLX0ENgOWpT7fW6+Hnhm8mEaE3oaPPvyKl0QVaHhzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435322; c=relaxed/simple;
	bh=+x4xHX5edfHpQX+vj2n6XFJJRzH9zhxGX4ho8aKMwEA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH7v30AtoK0EkwX47swWu8Es07rl3wFtOXigzYXjz3V/CnzKGjMix4qwAxE30zjLjttxODtr2iWDLcz6Ist7QNaCEyk39hQbmkBDrqSEfU2KUotQIEQ+lttFnYeDGuYi1dF5ZaKsE0MFQWBzoISq1IGB1cb6pp1iqQZWTnYAhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UKhllHAv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t/lbT6mg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UKhllHAv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t/lbT6mg"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5E714138215B
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 31 Jul 2024 10:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722435319; x=1722521719; bh=tRTLmq+AjB
	oBCztpJO2rvaf7ZsfDOIGoj0+C0AXkxII=; b=UKhllHAvkbGhXGxpstTOCY7Mfo
	OfbP1c6JFxViTwNxlnimQIApTO1+SKVpMoGgybzlAPIHm8Tw93JWN/Mu7phtz8Pk
	o/Mg5NEDd9bi0y7LTzzyvzR3uVY+vqitzkb0eXx+qoCTM5b+Wygy76Nz8JMLlmcY
	0HNa95x5veB8uM5ISqeLR1JyUDqHzSQ6ti1eik2uYauX/Te11LPy3IyJkr3+7hSs
	rdwcnscuMuGwRLOb6WbyAGVrxJeppHXPdTqKc9FEUASGcKChaNh/Gv9qbZa/TBoc
	mCHC78NUOytlwXMpJWJGnXGZN4M6b5WhSnhOPNfQaO5DWNrvl39goyDGnpog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722435319; x=1722521719; bh=tRTLmq+AjBoBCztpJO2rvaf7ZsfD
	OIGoj0+C0AXkxII=; b=t/lbT6mgIh8YtrU/JAilc62d/W2YtoN+lJUAYC/WIoyw
	h4IBQ3uvK5nIOLeXwl1OSxOXZyEh/CddK0pIjf2GGYoBET+TRy/4V9KSDejWUhdz
	P5TTudP9AqoT6cty56Mn6CKNcKKdU4F3IsZCy1ecag9ET6PjHTrgMI8aCHsfAImh
	TaFUzkFi3fnsLAUBKoBVqFHdVnoR8VID+eKzJq1Ht4mFZVUTuVAfEzlMfqz5PPJv
	U2YbRIKTdURDaXsLhXMIdqpCFAjgp1pGz5M1ht20+1XZRR6p+Cq3oguidabj9k82
	T1nCpnuWz2RVQSQ1Mf1CciqItVnJJfmw+7IoNaKVeg==
X-ME-Sender: <xms:90aqZtqO-jFyA29oEQruNvnqchYjVWwI_lGXLUEK6y_97DAZHXbJ0g>
    <xme:90aqZvrK9Gjvlt0kJRA5he54sJdhyQq9Ge14IL9LIW9FQQTZEB6otQ_try1T8KPde
    YSYIXeX4A9c6Z_cEw>
X-ME-Received: <xmr:90aqZqNgb4B6rWeydX-Dk-5toS7XKf04okHny9mg1mb4g1LW_ciSV9LbZNUXy9HJ6ITKd10KYrbzM4F77A5Vq1K5W8W2HWK9KS-VT97pmL_bO8bB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:90aqZo4DZnVyjJaguQh8s79MwU-y5k6kBEbimVLMze_4iWBYweJuaw>
    <xmx:90aqZs7bzEr0pBy9W2wB8PXwRMBkHdXoel4O-SmEhnkQSl4MWkjmbg>
    <xmx:90aqZghHg62XpkxhtkSW2oA8ifiuZrStMySHU4NpE408VJKmH1_S2A>
    <xmx:90aqZu7_s7CMbQE2HmTT0fmRsaiX8jd6bqti-WshHOYs-QWfoGa-FA>
    <xmx:90aqZqSyOE_JL_lEdaN7iC51GjLtc9Yhav0RKg6r1BOILcvSe2ItpiV9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 70f74262 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jul 2024 14:13:48 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:15:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/8] reftable/stack: use lock_file when adding table to
 "tables.list"
Message-ID: <9703246156152e1c8c92b4237c8dc3a9ef59901a.1722435214.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9iAr7Sn4n8geRxzz"
Content-Disposition: inline
In-Reply-To: <cover.1722435214.git.ps@pks.im>


--9iAr7Sn4n8geRxzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When modifying "tables.list", we need to lock the list before updating
it to ensure that no concurrent writers modify the list at the same
point in time. While we do this via the `lock_file` subsystem when
compacting the stack, we manually handle the lock when adding a new
table to it. While not wrong, it is at least inconsistent.

Refactor the code to consistenly lock "tables.list" via the `lock_file`
subsytem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 9ca549294f..9cc91a262c 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -567,7 +567,7 @@ static void format_name(struct strbuf *dest, uint64_t m=
in, uint64_t max)
 }
=20
 struct reftable_addition {
-	struct tempfile *lock_file;
+	struct lock_file tables_list_lock;
 	struct reftable_stack *stack;
=20
 	char **new_tables;
@@ -581,13 +581,13 @@ static int reftable_stack_init_addition(struct reftab=
le_addition *add,
 					struct reftable_stack *st)
 {
 	struct strbuf lock_file_name =3D STRBUF_INIT;
-	int err =3D 0;
-	add->stack =3D st;
+	int err;
=20
-	strbuf_addf(&lock_file_name, "%s.lock", st->list_file);
+	add->stack =3D st;
=20
-	add->lock_file =3D create_tempfile(lock_file_name.buf);
-	if (!add->lock_file) {
+	err =3D hold_lock_file_for_update(&add->tables_list_lock, st->list_file,
+					LOCK_NO_DEREF);
+	if (err < 0) {
 		if (errno =3D=3D EEXIST) {
 			err =3D REFTABLE_LOCK_ERROR;
 		} else {
@@ -596,7 +596,8 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
 		goto done;
 	}
 	if (st->opts.default_permissions) {
-		if (chmod(add->lock_file->filename.buf, st->opts.default_permissions) < =
0) {
+		if (chmod(get_lock_file_path(&add->tables_list_lock),
+			  st->opts.default_permissions) < 0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
 		}
@@ -635,7 +636,7 @@ static void reftable_addition_close(struct reftable_add=
ition *add)
 	add->new_tables_len =3D 0;
 	add->new_tables_cap =3D 0;
=20
-	delete_tempfile(&add->lock_file);
+	rollback_lock_file(&add->tables_list_lock);
 	strbuf_release(&nm);
 }
=20
@@ -651,7 +652,7 @@ void reftable_addition_destroy(struct reftable_addition=
 *add)
 int reftable_addition_commit(struct reftable_addition *add)
 {
 	struct strbuf table_list =3D STRBUF_INIT;
-	int lock_file_fd =3D get_tempfile_fd(add->lock_file);
+	int lock_file_fd =3D get_lock_file_fd(&add->tables_list_lock);
 	int err =3D 0;
 	size_t i;
=20
@@ -674,13 +675,14 @@ int reftable_addition_commit(struct reftable_addition=
 *add)
 		goto done;
 	}
=20
-	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
+	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE,
+			      get_lock_file_fd(&add->tables_list_lock));
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
=20
-	err =3D rename_tempfile(&add->lock_file, add->stack->list_file);
+	err =3D commit_lock_file(&add->tables_list_lock);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
--=20
2.46.0.dirty


--9iAr7Sn4n8geRxzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqRvMACgkQVbJhu7ck
PpTXwA/+P7YFXwZ69M0KPV7jsOOitXrBCUGad9h1vHn2NwsgF/THQeGTAu1TMAZX
adskfv940MK9+LbExO66MoZTIEq67atzO8hzl5Zr0vupfNvlaZGnEKZbh5HlTE4H
yDPdf1gNSd9fOcPx2UfwrbrF7j4wS25bmyJdydDFoQexjqOnXxL2lOddzH+QK7Ax
7tK0fDKOsiNYANqs3Qxt5tKrcWjVLvpNUl/GnFqHKBfLh3+FKh/19NRGdHtKLdmd
uKsAiAO55Hi8/1KnulabLIylgltsjJp7E1PYNv30aNuudlCBlRWrSC/mDVBXjBgd
3c43frFy5sYGFBdWfCSAmCs2Xt5VxsZgBplonDrPDaLC8vYXeN4sD2kRXq43nkT/
5HXdx+EojKVK0v6Vo6gnDg7DR2rR37Kx7Tyxjk5Jsu0LK7eqNi9LZoqhM9X/Svjd
30iiEpc3YoCBJ/jVqNHhs+JqcuLDpPDysv7VfOd0r0R7obAxlOkV9R0QOlnHczId
s8JF+remuqpwN/d8B5TVriaXzjcN9BY3gO7OZZZ+G+8q2h5hGsNC4WS59z0a8Kdz
HHaSDoZ8sSXU+xV91woi610r41mtYG5HIxrly2XmO0oGeKUsG+mHxYGJKVU6fMKl
oLOUMtJZUpq6qNRxyzyRvllhW7YnF+ARFSIIBYEkKpiIYsMD+JU=
=JI42
-----END PGP SIGNATURE-----

--9iAr7Sn4n8geRxzz--
