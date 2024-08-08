Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86A18A6B3
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122304; cv=none; b=kB5jKCvwDtOAHtZqPm5SnVSG7lZRp9TRQPADPAbANJBZ6X7zmMyvRRYIqxsg8sUT4nvRcLPaROLZSJWTqrvOy2WR56blArfgmo2YiNVjLJryNpdneWZFeQq9MieQKGDwSMMp7YlZ5Sk66cHcVevIlZOXfUjSkaiq+1oz+cjXaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122304; c=relaxed/simple;
	bh=iXqj58fsFC1ve3ODz1PaJg6QS4Ws+Hq1mTRfn2sxL6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzRQuVdMk3zwZVVS2cSYmmlq0AXBTpNp7d2+Fbdru6Ck/AsHy381QEFt4XuGd6rEK0GOeSENX2X37iJrd1rdj92jHcCLdRUij2lGaZodLpFw3XLjnCHNCCYELn2+uAkexF0qtGKHhqvJ9q7b02d+qE054KgIii3t6YM866FHhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=of9raoDy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ibc6x7xL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="of9raoDy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ibc6x7xL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 93CED138FC71;
	Thu,  8 Aug 2024 09:05:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 08 Aug 2024 09:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122301; x=1723208701; bh=4FvdSQWPjY
	IemZ0Du2zyCYBl60k8zWgwI/IrCQXUi6s=; b=of9raoDyyk/O1wdsqFeLKV299w
	JH+qxu9gkDIhPnTJBQoiX3nY7trh5ACcuaQwzhuMcaLMDPAchnd/QoHYOXFv4dm6
	eSRbSWMmRp1lsF4/g7JvMBpcqR/Hiyvj3jwZnt23YhoG+HWgTU64fC+mdP1GfWYp
	l9vCcjYusYEsxcyCVRld1lKStlYqmsKNNyY3HkViqAOJNHflsO2GUns6WxiEMpEY
	it7iVUadE/gKgfj9ZO5fCTpR5+f/iHeg2tx0cQUfTFTQrAwLKP6uAonJAOJf2SSV
	gPY2xjdocqp9cvMbkyx3QtXeSZyzjsAK1B5hzEOnG2oZwHPOA5vbHrcwce/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122301; x=1723208701; bh=4FvdSQWPjYIemZ0Du2zyCYBl60k8
	zWgwI/IrCQXUi6s=; b=ibc6x7xLeG5eiPlH9fmqjZZCzFEND1JtOPxKAbpETv0R
	hCqwVKjgaCHkEVk0/bGue54q7SkX2KY6eYcy2bhvQKmbAhccgJ38I+m3W1rHb3P4
	VmroMtuioDRMxeDADCqDdINZCyn/dR7YPX/c3yHql1EaGj8x/4+tRjuA6RK5C0UR
	AuCYwTGntGUVFELneUh5/WRDwsAoQhaBxo6E7fHv9Jt4UIOhItcO92jzH92MRBhA
	WC+1VvTGFcvzPjiyKk56QwV4F3CctNdw5PPRlm6c5uaiKJbc3ockHa3PuAPksVVQ
	6R7+kVIfy7ulGLlObGzrooFUFrKQrl1Dxx/RRr1aVQ==
X-ME-Sender: <xms:fcK0ZlkZ_x4wYecXJSKqnTW9fEIkD7tEemhdVF0-owdRL-_BZTJ12w>
    <xme:fcK0Zg3dZTcf2hjbUSvuOjdOiNq-Dh7AZVBK6DtmU-VpRHlySm0V62RXFMbbxJkKp
    kOM99xLCruMp2-HHw>
X-ME-Received: <xmr:fcK0ZrokVSBWo9qweIJuuVPrPmTic8J8dw1cPa79wbVFkuuFmx8Ftrn5QW77NUNE2TND_Z3Kr3UWNYFLxG-97z22Q29_LXBsBiq0k38srHsAL8ck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:fcK0Zlkrm68rLxF7rR7xMJfvA3eloMrRvd0d3gubixwqTZBK6sBT7A>
    <xmx:fcK0Zj0vU46FUvgzo1oo0bYsp-BxvQaEGktB1dgEhLZcAHrGyzu72w>
    <xmx:fcK0ZkuH_khwH9ruMn0PNaNIS6_ScIck40a6vLRit36IQ1aXRzBbMA>
    <xmx:fcK0ZnWOrvctnaSqDvF625OrszmxtHHnHizmfUNL3MtFunpUb8rkxA>
    <xmx:fcK0ZkxrVocMTcIZHQ-_fqZxX2m6j42GcCpEQ4vIlo0_6e4y7UkCM4P0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0e91a42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:04:53 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:04:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 06/22] read-cache: fix leaking hashfile when writing index
 fails
Message-ID: <f8b7195796610d81fe03b52eb990ef8301d5679b.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GIWweXi0jQnk6/H2"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--GIWweXi0jQnk6/H2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `do_write_index()`, we use a `struct hashfile` to write the index
with a trailer hash. In case the write fails though, we never clean up
the allocated `hashfile` state and thus leak memory.

Refactor the code to have a common exit path where we can free this and
other allocated memory. While at it, refactor our use of `strbuf`s such
that we reuse the same buffer to avoid some unneeded allocations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 read-cache.c                       | 97 ++++++++++++++++++------------
 t/t1601-index-bogus.sh             |  2 +
 t/t2107-update-index-basic.sh      |  1 +
 t/t7008-filter-branch-null-sha1.sh |  1 +
 4 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 48bf24f87c..36821fe5b5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2840,8 +2840,9 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 	int csum_fsync_flag;
 	int ieot_entries =3D 1;
 	struct index_entry_offset_table *ieot =3D NULL;
-	int nr, nr_threads;
 	struct repository *r =3D istate->repo;
+	struct strbuf sb =3D STRBUF_INIT;
+	int nr, nr_threads, ret;
=20
 	f =3D hashfd(tempfile->fd, tempfile->filename.buf);
=20
@@ -2962,8 +2963,8 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 	strbuf_release(&previous_name_buf);
=20
 	if (err) {
-		free(ieot);
-		return err;
+		ret =3D err;
+		goto out;
 	}
=20
 	offset =3D hashfile_total(f);
@@ -2985,20 +2986,20 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
 	 * index.
 	 */
 	if (ieot) {
-		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_reset(&sb);
=20
 		write_ieot_extension(&sb, ieot);
 		err =3D write_index_ext_header(f, eoie_c, CACHE_EXT_INDEXENTRYOFFSETTABL=
E, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		free(ieot);
-		if (err)
-			return -1;
+		if (err) {
+			ret =3D -1;
+			goto out;
+		}
 	}
=20
 	if (write_extensions & WRITE_SPLIT_INDEX_EXTENSION &&
 	    istate->split_index) {
-		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_reset(&sb);
=20
 		if (istate->sparse_index)
 			die(_("cannot write split index for a sparse index"));
@@ -3007,59 +3008,66 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
 			write_index_ext_header(f, eoie_c, CACHE_EXT_LINK,
 					       sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret =3D -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_CACHE_TREE_EXTENSION &&
 	    !drop_cache_tree && istate->cache_tree) {
-		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_reset(&sb);
=20
 		cache_tree_write(&sb, istate->cache_tree);
 		err =3D write_index_ext_header(f, eoie_c, CACHE_EXT_TREE, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret =3D -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_RESOLVE_UNDO_EXTENSION &&
 	    istate->resolve_undo) {
-		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_reset(&sb);
=20
 		resolve_undo_write(&sb, istate->resolve_undo);
 		err =3D write_index_ext_header(f, eoie_c, CACHE_EXT_RESOLVE_UNDO,
 					     sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret =3D -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_UNTRACKED_CACHE_EXTENSION &&
 	    istate->untracked) {
-		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_reset(&sb);
=20
 		write_untracked_extension(&sb, istate->untracked);
 		err =3D write_index_ext_header(f, eoie_c, CACHE_EXT_UNTRACKED,
 					     sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret =3D -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_FSMONITOR_EXTENSION &&
 	    istate->fsmonitor_last_update) {
-		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_reset(&sb);
=20
 		write_fsmonitor_extension(&sb, istate);
 		err =3D write_index_ext_header(f, eoie_c, CACHE_EXT_FSMONITOR, sb.len) <=
 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret =3D -1;
+			goto out;
+		}
 	}
 	if (istate->sparse_index) {
-		if (write_index_ext_header(f, eoie_c, CACHE_EXT_SPARSE_DIRECTORIES, 0) <=
 0)
-			return -1;
+		if (write_index_ext_header(f, eoie_c, CACHE_EXT_SPARSE_DIRECTORIES, 0) <=
 0) {
+			ret =3D -1;
+			goto out;
+		}
 	}
=20
 	/*
@@ -3069,14 +3077,15 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
 	 * when loading the shared index.
 	 */
 	if (eoie_c) {
-		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_reset(&sb);
=20
 		write_eoie_extension(&sb, eoie_c, offset);
 		err =3D write_index_ext_header(f, NULL, CACHE_EXT_ENDOFINDEXENTRIES, sb.=
len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret =3D -1;
+			goto out;
+		}
 	}
=20
 	csum_fsync_flag =3D 0;
@@ -3085,13 +3094,16 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
=20
 	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
 			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
+	f =3D NULL;
=20
 	if (close_tempfile_gently(tempfile)) {
-		error(_("could not close '%s'"), get_tempfile_path(tempfile));
-		return -1;
+		ret =3D error(_("could not close '%s'"), get_tempfile_path(tempfile));
+		goto out;
+	}
+	if (stat(get_tempfile_path(tempfile), &st)) {
+		ret =3D -1;
+		goto out;
 	}
-	if (stat(get_tempfile_path(tempfile), &st))
-		return -1;
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
 	trace_performance_since(start, "write index, changed mask =3D %x", istate=
->cache_changed);
@@ -3105,7 +3117,14 @@ static int do_write_index(struct index_state *istate=
, struct tempfile *tempfile,
 	trace2_data_intmax("index", the_repository, "write/cache_nr",
 			   istate->cache_nr);
=20
-	return 0;
+	ret =3D 0;
+
+out:
+	if (f)
+		free_hashfile(f);
+	strbuf_release(&sb);
+	free(ieot);
+	return ret;
 }
=20
 void set_alternate_index_output(const char *name)
diff --git a/t/t1601-index-bogus.sh b/t/t1601-index-bogus.sh
index 4171f1e141..5dcc101882 100755
--- a/t/t1601-index-bogus.sh
+++ b/t/t1601-index-bogus.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test handling of bogus index entries'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'create tree with null sha1' '
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index cc72ead79f..f0eab13f96 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -5,6 +5,7 @@ test_description=3D'basic update-index tests
 Tests for command-line parsing and basic operation.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'update-index --nonsense fails' '
diff --git a/t/t7008-filter-branch-null-sha1.sh b/t/t7008-filter-branch-nul=
l-sha1.sh
index 93fbc92b8d..0ce8fd2c89 100755
--- a/t/t7008-filter-branch-null-sha1.sh
+++ b/t/t7008-filter-branch-null-sha1.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'filter-branch removal of trees with null sha1'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup: base commits' '
--=20
2.46.0.46.g406f326d27.dirty


--GIWweXi0jQnk6/H2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wnkACgkQVbJhu7ck
PpQlNhAAi90FEWNK27pIdBJCmrtgBz/pXn0tfMYj/2Kkkhgh+1A2CUWbQ2coUJYM
5msDfHC3Og5ECqNm9Bp4Hcl/apa6YUwFP5P1ptCD+xTTrtJ9e5SgN92h8p3coXAd
I5vQvP0N2M2THAU0zCRECqblu/+zLhyVJnZRHa0vx1fy4DiVn4I+uziansXNKi/I
1z0rhERNehdOSr3+w/K8Hwl8/pWcvMnmsiKQLGDdik+rKHU9qtATI3EtJZ1ke7AI
qUcq/ggdzut8po+9Ds9qCD4DC8UkCvo5RHa34elB2Dh+fQ+jNlyukEsRcn+76bvn
JAvR/0QtXlNP9ksNq4SNtL+6nR45cNCyjm4EmN7fpfa80uvXN0vNFuRq+bJVqYlI
sl2oSjV9xKGF1lv1sV5tWOy5k2VRSr6qE+kcbr9Ib3KdPSyQ+/zKwwgbao4YlG8R
3q8qRgJvnO4bPFu9JSRA8VnNUyoFY6S916Z8fJ1vRBQc1qAND5sJ2RDjvfkVrXF7
WE62g7zCvtXhAaWq8kG4j92RdzIQiPthj32lyiyOfhm1LupunUf/3lFk3QBt4S+N
P5mckMij9KP9cpMIbc6jXKZ/5x+fYp83/aD+CKWV2RhjgRudXAlgvHbFz6NHuARo
vFRW4a9rMfW+OvAl5H8XVkMKP596ibqM+nBuSEnVSBjQKyUJ5TI=
=TtdO
-----END PGP SIGNATURE-----

--GIWweXi0jQnk6/H2--
