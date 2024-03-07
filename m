Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B012C7F2
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817049; cv=none; b=EWgkv97d1L7Sj+/o/Q9+9MFopZdeEI8q0K2zEHeoaHdNy4g4H5f7M9p0gGKOekEVEpfNGlslRCZsnT+CAjBNx6pQAwaT1YpsQT+B2KFL+UG0Ih1wRVRFwUOZKBzf4E2EXKrHW5uGdLxVssW70hyW4Yh/VXNIxDEaFTZxBOMIQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817049; c=relaxed/simple;
	bh=uzGX44TzN5zPfiEsPJ9jOnDG08pUr/K7jdOpUXVBoNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPZQF1QMf0L58HsLWcpbQNl5nefkZuW13i0kjK9KPqvrempayafwWu1RcIsrOr4QP5wsuSd2JfO6HGblC7j9amvWqilqP5qqZNcfGaEZl8qqAZ7Sa3eOhMHcHo1G2+aZs9cv0UNet7mgABce+8i8/YrieLSe+HAeRSYvqNWVQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JEdxlNkU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HASfVZpk; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JEdxlNkU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HASfVZpk"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 7BBB91C00094;
	Thu,  7 Mar 2024 08:10:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Mar 2024 08:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709817046; x=1709903446; bh=5akIEwU6i3
	NnSJeFzTK18lH2I3P2cCWFAde52o3LRhs=; b=JEdxlNkUIWz6h5khJ+jkwDdGd2
	fGEgrc6Jmy6xVlhBjwmi1gcJnDRRC596W6D5juRI4YzwEBD8jErDvBNxX4cWk/LH
	/hEqOXSfCJELlR6gMX4xjVz/gChNf3Zm5AjKX+h6S+EVP1QjfQiiDOk311rZfU5x
	cg2j/uINgBZIughnvbqeKW5E+AyZp+hRyjLnRKkQD71dKIqmqDr/TdOKqkwHjEYm
	lsAtgbzzHXvrjh/HQNv8xSteDRdYFk0RIKpEEjMU4wjB3Yihvz5zEuBuLowwbEE+
	soNClS7jpCm+0DhF4R1c1j/TPcx2PoWcKX77SFqKFVGpNrwLnH0IDj/zooUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709817046; x=1709903446; bh=5akIEwU6i3NnSJeFzTK18lH2I3P2
	cCWFAde52o3LRhs=; b=HASfVZpkVUqQgYG2xtSqtIXH+OnwNjB5FOeCQ3hXV5sE
	s9HJuUHIaOhw9uG0X1NEEVimC0i41H/E0EB030DI1jH4F0IpjLmwc5YXbvquGciI
	aYMV4JrXSgpfZ2+hWPExaaeFYtuDO9xjiMc47MAb9mLv8PqUbVUaGk9qqsqmXpZY
	0fYSZJiEt/P5gWQWS6CJTKW/FgPhrwZAjzGVDG+ReAsribafsEn6X+Y7AIRSu1A3
	+DKPbY4Z+DcIs0kjq+ZswccWTWol7lpxD72b71Qd6GBWeQwLZxgjuyhT1450lqXj
	YiXGhXa6LQVbTFBfPVIFNYZrv/aW9zPZCWlEETTe9Q==
X-ME-Sender: <xms:1bzpZXr8rzsq-b-KHbbQrpyl7Pp2pnHH1PuUTgdQ6HWTDVVOD1ErTg>
    <xme:1bzpZRo4MlsZZWrzS76xlLxAyO9kNDRq8GSggqsYwcHM2uKVgf3531h62rodBLN8z
    1an8EDTrY-R43FyrA>
X-ME-Received: <xmr:1bzpZUOXIS4SM-SsWQeUm6mWLy6qUO9Qao9NSztLD89b1qTQ4HqPYAqH2N1O_DOT7_2CJ3aMOUuwu5ReJTkOLY_hpJHER0JNsVSNwG1aMj1L7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:1bzpZa4F26J0_0cvaoE4rAm-gvSq2Y-C6i7MhxAfijH7WdBIZj4tAQ>
    <xmx:1bzpZW6DB3sFVGloiiyNECD4fW-j8KEfGdSIwabuev1Ldh9XFCBbvA>
    <xmx:1bzpZShmljAuhXkM3OKblPhl3vlyZRnOGGD_xZx9x76SbRks1rFv0g>
    <xmx:1rzpZR3T_rUIipGn96Hl4J-cv0OIfftLiNS-B9zzLwLp5YTdisq0WALUTJc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 08:10:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 504233dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 13:06:14 +0000 (UTC)
Date: Thu, 7 Mar 2024 14:10:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] reftable/stack: register compacted tables as tempfiles
Message-ID: <4023d78f084c8df7ffd6c5ed68b8d0eadc713fd0.1709816483.git.ps@pks.im>
References: <cover.1709549619.git.ps@pks.im>
 <cover.1709816483.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lN79MXWR07AZL+0L"
Content-Disposition: inline
In-Reply-To: <cover.1709816483.git.ps@pks.im>


--lN79MXWR07AZL+0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We do not register tables resulting from stack compaction with the
tempfile API. Those tables will thus not be deleted in case Git gets
killed.

Refactor the code to register compacted tables as tempfiles.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 54 +++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 977336b7d5..1ecf1b9751 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -827,51 +827,56 @@ uint64_t reftable_stack_next_update_index(struct reft=
able_stack *st)
=20
 static int stack_compact_locked(struct reftable_stack *st,
 				size_t first, size_t last,
-				struct strbuf *temp_tab,
-				struct reftable_log_expiry_config *config)
+				struct reftable_log_expiry_config *config,
+				struct tempfile **tab_file_out)
 {
 	struct strbuf next_name =3D STRBUF_INIT;
-	int tab_fd =3D -1;
+	struct strbuf tab_file_path =3D STRBUF_INIT;
 	struct reftable_writer *wr =3D NULL;
-	int err =3D 0;
+	struct tempfile *tab_file;
+	int tab_fd, err =3D 0;
=20
 	format_name(&next_name,
 		    reftable_reader_min_update_index(st->readers[first]),
 		    reftable_reader_max_update_index(st->readers[last]));
+	stack_filename(&tab_file_path, st, next_name.buf);
+	strbuf_addstr(&tab_file_path, ".temp.XXXXXX");
=20
-	stack_filename(temp_tab, st, next_name.buf);
-	strbuf_addstr(temp_tab, ".temp.XXXXXX");
+	tab_file =3D mks_tempfile(tab_file_path.buf);
+	if (!tab_file) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
+	}
+	tab_fd =3D get_tempfile_fd(tab_file);
=20
-	tab_fd =3D mkstemp(temp_tab->buf);
 	if (st->config.default_permissions &&
-	    chmod(temp_tab->buf, st->config.default_permissions) < 0) {
+	    chmod(get_tempfile_path(tab_file), st->config.default_permissions) < =
0) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
=20
-	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd,=
 &st->config);
-
+	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush,
+				 &tab_fd, &st->config);
 	err =3D stack_write_compact(st, wr, first, last, config);
 	if (err < 0)
 		goto done;
+
 	err =3D reftable_writer_close(wr);
 	if (err < 0)
 		goto done;
=20
-	err =3D close(tab_fd);
-	tab_fd =3D 0;
+	err =3D close_tempfile_gently(tab_file);
+	if (err < 0)
+		goto done;
+
+	*tab_file_out =3D tab_file;
+	tab_file =3D NULL;
=20
 done:
+	delete_tempfile(&tab_file);
 	reftable_writer_free(wr);
-	if (tab_fd > 0) {
-		close(tab_fd);
-		tab_fd =3D 0;
-	}
-	if (err !=3D 0 && temp_tab->len > 0) {
-		unlink(temp_tab->buf);
-		strbuf_release(temp_tab);
-	}
 	strbuf_release(&next_name);
+	strbuf_release(&tab_file_path);
 	return err;
 }
=20
@@ -979,12 +984,12 @@ static int stack_compact_range(struct reftable_stack =
*st,
 			       struct reftable_log_expiry_config *expiry)
 {
 	struct strbuf tables_list_buf =3D STRBUF_INIT;
-	struct strbuf new_table_temp_path =3D STRBUF_INIT;
 	struct strbuf new_table_name =3D STRBUF_INIT;
 	struct strbuf new_table_path =3D STRBUF_INIT;
 	struct strbuf table_name =3D STRBUF_INIT;
 	struct lock_file tables_list_lock =3D LOCK_INIT;
 	struct lock_file *table_locks =3D NULL;
+	struct tempfile *new_table =3D NULL;
 	int is_empty_table =3D 0, err =3D 0;
 	size_t i;
=20
@@ -1059,7 +1064,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 	 * these tables may end up with an empty new table in case tombstones
 	 * end up cancelling out all refs in that range.
 	 */
-	err =3D stack_compact_locked(st, first, last, &new_table_temp_path, expir=
y);
+	err =3D stack_compact_locked(st, first, last, expiry, &new_table);
 	if (err < 0) {
 		if (err !=3D REFTABLE_EMPTY_TABLE_ERROR)
 			goto done;
@@ -1099,7 +1104,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 		strbuf_addstr(&new_table_name, ".ref");
 		stack_filename(&new_table_path, st, new_table_name.buf);
=20
-		err =3D rename(new_table_temp_path.buf, new_table_path.buf);
+		err =3D rename_tempfile(&new_table, new_table_path.buf);
 		if (err < 0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
@@ -1166,9 +1171,10 @@ static int stack_compact_range(struct reftable_stack=
 *st,
 		rollback_lock_file(&table_locks[i - first]);
 	reftable_free(table_locks);
=20
+	delete_tempfile(&new_table);
 	strbuf_release(&new_table_name);
 	strbuf_release(&new_table_path);
-	strbuf_release(&new_table_temp_path);
+
 	strbuf_release(&tables_list_buf);
 	strbuf_release(&table_name);
 	return err;
--=20
2.44.0


--lN79MXWR07AZL+0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpvNIACgkQVbJhu7ck
PpQHjA/7BdsF6TKByo+B3Ms0Bzx1vfMYBOfsd8pgknZkL9V5jLIBnAjzJGeF9Kt0
fWJsIrl/bPypNQGKQss5WXDA+IZhMokX4KVwyPSoKxrNI6Xpu/XjjaeO8FpgzTBW
bppbO/O6I+c/JiCWwAfvb8G3E/fbm40SYQ0hazFqXnH5/0Jx/fESe8EJhfiDrrEz
U54ptREYFUpu718dkP2ocxu+KXcqNkDnNbJixadxYNBvp41Byl5ot1hLHptxCDzV
1TolAzhSvtlSYU3MOhRPYot+gukgj9WCaS0vbbxHnemZXgI5viRzvf0VyWkOdNDw
9WyDpMPgCDOW17fncbaabJSJkErdSnjj9BjZZ85UKeqvGya4fm7Zgb8A5yvVhTsn
M26RpOZDRiGtJo9yqFr7TYti85a18IEt7XAPs/vMPMD9c7qlcINcBe12Wl4O3OFb
TzLdiSkYf3SEaCjctV3Y6keS46b4Ns6lIrPlcs/fuPFDqhK4UMOVc0B0eGRL75cr
i8bP5IL1boxdp8uOgwvr3CB21gTLcYqzzkmk70qpGzo9IjasySZRJKE++3y3fwEO
7UokwLi//MnTnvzcLTjW3EhjwK7XzDuF04QfAdP+6Qb5146g4AsOcTxXvS3JbG3d
LcwPqtppUASlB0nu1SrXtcpLmNBJeDYSHIRGxsf4PZO/D/n0L/A=
=Etxz
-----END PGP SIGNATURE-----

--lN79MXWR07AZL+0L--
