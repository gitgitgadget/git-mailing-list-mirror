Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641031BDAAE
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934808; cv=none; b=Dv3xhStP/ZoOPvbJGcR4OjSYS7kAxt9Owo7HicinKFhTp/8NQIpu/xu0EJw+24iOLBiwrKPWo52v93aLs5oVV+6u2l66HCUfvDVmabTO1CLyqXK29Fl+oDQoPK7iQKUGVN7Z4tmEuDfXOa8AWNp24647J4+TFt7H3z0TOP/6kXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934808; c=relaxed/simple;
	bh=PjSWDfbxvArxxbn6qzEY2HwHRNE4WNNY/7PSwjE7BEw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFfkp93dE7fpW3RwMlShNoXP817XuncBcBpSEPGt5GxjP7voC47pLXOZNss1DxtdYX2anTxouze/6KTz+5AO7aYVzC9yrOv7ouCNMVlC52H65RheMtLwZ4HUwQ4fogl129U/k9jEkqBQMMHIfbmcQAPinKyxv6LLN2hslCf3B/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AYyodQKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGAfdMKE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AYyodQKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGAfdMKE"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 78FCF1151B24
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 05:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934805; x=1723021205; bh=iQqR5G7Vp7
	DRu71uih2u0yJQtxAimCKed0kMbFuE9XE=; b=AYyodQKcSfEY4G1zN7jMvfTTbi
	1F5vyEcs9ScewuoNNIofgXCSvvBOuro/HDrF+M4pFxISUhqnE+TqbY8nDTNphHHV
	Y4X4gPybHC/B9uJRibjBDLbyXAt8ft2zadSf//skBjk/rt+/Oa4Cr2G7wFhBLknz
	crwfMe4/OLB5xpDE2I0srV/Tt+XuxokdhkuwxH8DYUuVtFd5P5isF8Dv5tjiKLUd
	f3XrTegCgN0Ij3+oz6f5+SJNznzZVgvAejFDJPuvy70YWdMe9xlyJWAg+IAQFyaj
	Dl+keamGe1twA/pEKsiVvgAi7JImH3PkmtEBxJgMJ32gXUl6V4yKR10gwc6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934805; x=1723021205; bh=iQqR5G7Vp7DRu71uih2u0yJQtxAi
	mCKed0kMbFuE9XE=; b=nGAfdMKE0mRx4t3IaW9pg6LRajaA/EGS17SXcQ4st4ld
	OV/xo1eoPKfGVK7WBlpRGX1k+iJCC8w6QOnniqBQcCJJwXnQBxJ5BGtXILheimhS
	/rkH2eFtnwBEn5Yvay/YoGA/Bl/a+IzB1HwlI154pHKb4Zg4/XRgmvW3fu27mjmU
	R8kBbUVSLsA8g7XZUEuZ9G+oDbsTbIxqDsrtEJ2PBjFAmzkilx4Z8RJKmI4QpUkk
	5SJuzk4brWmF8Mwc2MoZL69Xkdlb/kwAZg21Xc4dIFr5Jhh7OKJ1wTHGSqH2ScNa
	YRJQPGyTWH9lFST1ihU5kzBNTw8DSyZ80IMENUiOfg==
X-ME-Sender: <xms:FeaxZrk9XMZhJxhh7avD9p3Y8GM0uHieZwjpTBv0tFM3p4ayx6cEew>
    <xme:FeaxZu2ZPPGHamQ0oTxQQ33dIrvFfF2EsNhsG_TM0NyGODX3_DNlI45zkN8VRMUrx
    VDO0-_RjSTAn6Z9eg>
X-ME-Received: <xmr:FeaxZhrQ9Ixt0vMB3xdiOcNIWyojpyE0nnDn17jOJLExGSfrUg87chMJFlMGMGYtvg0a2MFSJ4_FRw0BFM0_xmkr7NLlo1FVkAssLAtduA0V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:FeaxZjljD6DSXL6ZZewlkh0YB0VcyHx1CSAbKWOFjrgYAFkEzL0JRA>
    <xmx:FeaxZp05ghwVc9KCd3tNy6k-HuxOaXPBCQrj5E8UDyS1FS7KgbfbIA>
    <xmx:FeaxZisy2OZ3FoDDmADoGtSmBwulACEFYhHNRfp6CJjmeKAXYzrWFg>
    <xmx:FeaxZtWPYYOB_fyWXzgUO4P9h1p3Q5XA0TOEGM0j5WkeQ_zJwl3p6Q>
    <xmx:FeaxZq88MApYpTwnYjYnQOY_LDpOBSX0FhpFKLnSap_MdpVWyaPPTlND>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e6b788ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:02 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/22] read-cache: fix leaking hashfile when writing index
 fails
Message-ID: <2810cada0af14c3331674a807b20d18e6c9af022.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LhLHEINikl5RNhsy"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--LhLHEINikl5RNhsy
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
2.46.0.dirty


--LhLHEINikl5RNhsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5hEACgkQVbJhu7ck
PpT3GA//ZCLcITH7VTmhqGCzPmTT/WMAo24moMZxJZHaGie2jCMtkYw93ESecp9G
Bcy+NsFXHN1HZQTN27/4O9a0LKTn8gxXKkcXl8ElmngAaHbGGRMGrTLwgZhGyds+
x/eT+MWebnYjTI4UwANjF2cNXd0DSN6/66lcMt2OFMK6EpvSwYybS7/Lor8zGoy0
LcpRhEe6QHjoRN7sVzHDalq8BcZw1AgQnQ+WunHVpCaIqK/NeirkbYW+gcTlQTC4
IYgvOdnQXXWYSKZIiGDdylwZYGDyxqm+IuMoMPiJ53yd59HdlxBp8zXNaWE6xgtO
N6CaR3ykSv+vLYl2R/++noHFmg5nC6PCKm016IeyAF2vhlqmionZZRqY+Ul9qR3w
GYrfpZmOqFa/9jGeE+i70Wj180BAR+VbN2Jr1vvHzulUFrAXC6IT8LH2IHr6cFG+
dVSozisH0C/LRmfU3NAjBk1iIushNy9+UuDbKD1YbCG412ghZhpGt9QtJ3fyV4uO
CsFtAdikGt4MbOag6gUeLPPGkjP3S9UbqSMv1RmIIzUqUisQI7NSXwoKty5k8lfz
5hz+Ffn4bcz0vsmhzCWPwcb9Xu74ZcqM3gXDIW96BbPg96tzUhprPvWPrcO8lems
GCYn6thrILxKI/U2LryDJrzmyhkL+I7BILTzESKmQhJD/jn7gMo=
=px6s
-----END PGP SIGNATURE-----

--LhLHEINikl5RNhsy--
