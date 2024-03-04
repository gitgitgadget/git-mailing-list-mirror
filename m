Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558EC38DF5
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550667; cv=none; b=NwOYRRZh5NSXXD5XdUc3Mvjefo9EzKAlCmYzb1VNStbiHgnwnyUkwNYn41Pc/LCRGQfqkWzwBB5UmwQbH3J2pxGg/7bznMhbta86r/Jp6m9jUAfizm37RXSp0FlKnA8hrUtStnUOvUYu0u+KtPYlaD2+onteALH6K5U4mm47rfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550667; c=relaxed/simple;
	bh=wlBh0bdOl4ViHhEe8h5NncPShgIe1ofNP57aufIg5XI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJplFkKAPxCX5q4HXlU+6H21OpaFOfT2odYhbilXMdk6z8Z84FSOi8+f1jVRhcUgXoW2beJ4jxghUIyWBcUmLg1C12wT12RkzNltOsAEthCefcLh/XC93jtxcGOUOKnVnc6u3oZKdVYLM70jjXf5IDj5Zyy9oeuVWeSwPuiielM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iYDw1oR7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPORKC+n; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iYDw1oR7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPORKC+n"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 8D80F1C00079
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:11:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 04 Mar 2024 06:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709550662; x=1709637062; bh=8e2edTElmQ
	EzH3yRnJcJDvPM90Dtc6xso8I9nLOMgOo=; b=iYDw1oR7lobKbDXQBqFKN77RTM
	3abSyQS4LOh/yeAR8lm5jYTk+o9fpr28x5ANoluT6ZodfSC9DyMbHZPa0Vye8AZb
	94uydUuDhfSMMyQnyDKrb0Pi/zd6b5rUhRjl9Pbtkba+J5RCo1t+EtNO2aHFkCeH
	YJYPF9NMj6vi7R5awHTDJ50hSfJTFZsG7F/SrX0g+nPA4xKYQVG3+S1fs8squ0uG
	zbiri1S6JWIHpl7y0cSYm/BdjwBOHhAf1PMBsumc3zIqOmKhakFbKt83aWOczrDn
	CH8pj3UFO0Bi9eRGiwyyBQ98+LTmVD5jmvgN5jWmYxvACCbKlaM+bIg/Rc0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709550662; x=1709637062; bh=8e2edTElmQEzH3yRnJcJDvPM90Dt
	c6xso8I9nLOMgOo=; b=KPORKC+nvPqTMNL69HtxMTkmzFRoTkGs2loxJbSngfyG
	mbbjZEaHnECA1q9E6WxHOVBOfkClmQVNKZwml5Dw78NqZ3CyTYTo+TQTdKgjAK1R
	7HQ3eJn1XXnD6v4MbnDLwXAH2s95S+nDcxV6fH/4cBzMmzJrMwEZf4F0dSTEwGXd
	5KDS0gVEe6qxQd6u1NMj9+E/7XNO99N8bxiRlIzd9a+qr+7uzTGLfCcdH2AFxIYS
	6rNj1S7uvtkn4OJ2g/bRCXS+6TptSZJ2IlgK2kCr8uTx7jbGINH2T59iKkGfnQ/i
	io6RMTv3CLNhP06Ld5GJJhQI0+dsVN8g47aE5/TmuQ==
X-ME-Sender: <xms:RazlZVaUwWfILlfh6B2njnjKx5caUHGpikADnIo1iiQIbHSwJaw7ag>
    <xme:RazlZcaI77MwAY5edInK5OEfgwuxyoYpuc6W217swTSHFE30sYxxQC8OhgDeucDy1
    rXol7Goh_u6yQvq1Q>
X-ME-Received: <xmr:RazlZX94x5NEjapfKJXlsD6reBDtA8nOwiaJIniXu0GrkBlf934lE91QW2cbcVpG19jFEJhjs3Oj7F1y_JVuCEJZFSFwf7ALEvd6eYuZf2PQHSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:RazlZTrUJ56BdcAipHQi4Vjd4PcwKb0ThdgHzzxWwjvA-7gEve4ziw>
    <xmx:RazlZQo9XU2zrmFqgDGSmp1YwHP4k23zg7Kg3LxZg8medq9KYCZUwg>
    <xmx:RazlZZSVqCdsN97afHcgqC7_WZPARiT3mvkQrDlyM6FVoSKKv8IXQw>
    <xmx:RqzlZdBsq-3I2w5S3z0RC1bvTtbjrh9Tlhf-HgmvdQ_SRdGsw6868Nuf7EY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Mar 2024 06:11:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ad151f7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Mar 2024 11:06:36 +0000 (UTC)
Date: Mon, 4 Mar 2024 12:10:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/4] reftable/stack: register compacted tables as tempfiles
Message-ID: <b952d54a05e1c0cf47371f78e3901cfb2119e246.1709549619.git.ps@pks.im>
References: <cover.1709549619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34k/Hya+Qge5uyAQ"
Content-Disposition: inline
In-Reply-To: <cover.1709549619.git.ps@pks.im>


--34k/Hya+Qge5uyAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We do not register tables resulting from stack compaction with the
tempfile API. Those tables will thus not be deleted in case Git gets
killed.

Refactor the code to register compacted tables as tempfiles.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 53 +++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 977336b7d5..40129da16c 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -827,51 +827,57 @@ uint64_t reftable_stack_next_update_index(struct reft=
able_stack *st)
=20
 static int stack_compact_locked(struct reftable_stack *st,
 				size_t first, size_t last,
-				struct strbuf *temp_tab,
-				struct reftable_log_expiry_config *config)
+				struct reftable_log_expiry_config *config,
+				struct tempfile **temp_table_out)
 {
 	struct strbuf next_name =3D STRBUF_INIT;
-	int tab_fd =3D -1;
+	struct strbuf table_path =3D STRBUF_INIT;
 	struct reftable_writer *wr =3D NULL;
+	struct tempfile *temp_table;
+	int temp_table_fd;
 	int err =3D 0;
=20
 	format_name(&next_name,
 		    reftable_reader_min_update_index(st->readers[first]),
 		    reftable_reader_max_update_index(st->readers[last]));
+	stack_filename(&table_path, st, next_name.buf);
+	strbuf_addstr(&table_path, ".temp.XXXXXX");
=20
-	stack_filename(temp_tab, st, next_name.buf);
-	strbuf_addstr(temp_tab, ".temp.XXXXXX");
+	temp_table =3D mks_tempfile(table_path.buf);
+	if (!temp_table) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
+	}
+	temp_table_fd =3D get_tempfile_fd(temp_table);
=20
-	tab_fd =3D mkstemp(temp_tab->buf);
 	if (st->config.default_permissions &&
-	    chmod(temp_tab->buf, st->config.default_permissions) < 0) {
+	    chmod(get_tempfile_path(temp_table), st->config.default_permissions) =
< 0) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
=20
-	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd,=
 &st->config);
-
+	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush,
+				 &temp_table_fd, &st->config);
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
+	err =3D close_tempfile_gently(temp_table);
+	if (err < 0)
+		goto done;
+
+	*temp_table_out =3D temp_table;
+	temp_table =3D NULL;
=20
 done:
+	delete_tempfile(&temp_table);
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
+	strbuf_release(&table_path);
 	return err;
 }
=20
@@ -979,12 +985,12 @@ static int stack_compact_range(struct reftable_stack =
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
@@ -1059,7 +1065,7 @@ static int stack_compact_range(struct reftable_stack =
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
@@ -1099,7 +1105,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 		strbuf_addstr(&new_table_name, ".ref");
 		stack_filename(&new_table_path, st, new_table_name.buf);
=20
-		err =3D rename(new_table_temp_path.buf, new_table_path.buf);
+		err =3D rename_tempfile(&new_table, new_table_path.buf);
 		if (err < 0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
@@ -1166,9 +1172,10 @@ static int stack_compact_range(struct reftable_stack=
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


--34k/Hya+Qge5uyAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlrEIACgkQVbJhu7ck
PpTGfA//ceVnnIanKXVUb7ps1KTAtZ2mFU9EXY2voiBGaHVbpdLDxfzNpIk3hqmM
qRdr8ShA9QKHOkXBR4F1wxm8Z+a96sj7hwwmYfevAhrzMs3skrc1csNf110BnT/q
BhCi47wniqm3AdgYVjNjfR29fQW8HTu4UG3xZJ16pqktPF69hDnkCdlsuXsUudY8
0vWMv5q71/rmgkmbigKYMPD3KHIUCJzgNaULu9N8itLB8VYUNxqyc7Rb31V7fldE
2y7VS9nfYy1CBmmOVaioL1U1OYzkmLV2AalnDFSSWAJLsC9qqqGcBUYPU0x5A5YY
1eo2aDJ+skXLU1eJEz17HThQ6QH5LoCM2skABi3sCSje3xY8HhPYLwgmUkGbzaHz
y/XVaeTQdg60pkY+WWERIEI7zP4hf868up7735H6xDAjdCNKFw0NHz7YzUCAvB64
fv8nKXjskS8qcCCe9+euXGN/LHMSy+Ql3r/6tpO+9wZVbCi4O3Gd0ZZMmcxO2zS6
ksqd5PA+ETNfuhN3aGLpeH/gzVjNkgm3KeDUDzJetVzoC65dZU1XDCz1nrOrBue5
sIgqQEDRzj5DrqtNqdo0qPgzK/g3wqAnS2NUstf7DYCzw0sDxoUkKbgLT/wKDgNg
4wxwu8X15sHBxw7pFhugAsPNSmT1YHGKlG6X+Xze/c+p68O6c9I=
=BksH
-----END PGP SIGNATURE-----

--34k/Hya+Qge5uyAQ--
