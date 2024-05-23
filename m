Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63B13BAFE
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452751; cv=none; b=I8ArVXE5+8PzDfTp9tIZuWkgwwyTe/VBHR9U0fdhky9KaB9DZMWEiq8yDi8IAAa5X4k8oHtURwjecXvSbNYxsSIzIA0GT2thB9hNn1RWkno2qRDp6beH+mTroFbDF4j6OWWKTPIyCkzvecf+PS5ymzZ+zylDwQAgyUiZ6ZlHAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452751; c=relaxed/simple;
	bh=cfxVQW3Wgsrxx5gXhsNp/v72gEmeQLP6zz1akIOVTnM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBwNkKexDxeraA7yrUP6qBLsL/Tel/Ale0l3z25vTkOEqarHk3UVPVjwo6ZYbk3V/84JiASJvmIR1ju1UhEFsHRTfQsi2uK6znuxEPMz5DuFpddZDRgjeGvValyUZ91484o+HKJ6AIh+kgsH6aLTSOH1XDgiAZJckiu9gRSBx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cqpPmLQ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ifwlCjUz; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cqpPmLQ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ifwlCjUz"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2776B18000C8
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:25:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 23 May 2024 04:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716452748; x=1716539148; bh=9eL1R8g34f
	nLMTs7aL8mBTh56rjLEsQqSj9ZL7FdtZ0=; b=cqpPmLQ0dsIo/B0HshWL499DZr
	h+Al6KATWb4JXux9rTSqPEuEVEwpqHNq3IRrWHEulVlUdMMM1P0i7gjDOI5aTGf5
	IodUig7TZjLFPSIVxLzXbamOzMFkw9n3lA58rPgbOHBTlrg3KnkcKOFalDJlSBLn
	HSfwq8aPni+XQdRPmAj66wjCD9LQehGxSfIbcnIop8iFih6VXb1ZIFDPKDif1y1w
	0qg7TwXNp/wrPZcG3j7Pc2pDJOYIAKX5x258rGLH8W0pDlTrbunNQP1U64MJnTNO
	2yr/Kc7yApoSZ4pfsuhacMbS8i/nTBkO8q2K2mSIcxSH0f+tS54K/mdry1Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716452748; x=1716539148; bh=9eL1R8g34fnLMTs7aL8mBTh56rjL
	EsQqSj9ZL7FdtZ0=; b=ifwlCjUzRPGX/pnj8rydUPZ+IjHCEPMexoXYQekgcSug
	QN7uJCXvUfBilf5SDQV6DSfTokvtkHdbuY6G6xDcfeu4PTGP+Gc6h0XMO8xXUVNS
	qt5GGBQ3Mf0R7/Zl6w00o34A5LEsnvDB3avQTnkffr9Te95yHLB6Z+J9YprVJCX5
	7zfitg2I2mgo9pd1oO1OoWEIVC+H3dw+69Btjx+17igUkxZ6tEfdpWPEmgMq2YDt
	gdp1EwG5q7PCMwxzcarniefQOAYuoOERgPYJ5APd8i3aFXOo8e3xW9xIEP3Gd9hW
	U4kKpuE2tc4/2N/Aic5ZmV95fujeBLhoe2PRdistkQ==
X-ME-Sender: <xms:jP1OZp8LEVb7t-jTf-evNDzN8u5er4eF3xg_8bUEOnnHZa3eO-NXTQ>
    <xme:jP1OZtvoPNbLGYjdAI_fiNouUvjjuun9RXVBP8FFgsGeztwoNDyf4dr3KBg2QJ7na
    j94jp8BTC-Wt3IZ5w>
X-ME-Received: <xmr:jP1OZnA_aHycYlZFii1oYLTuLhvbpvn_kQCwJOEFq0t5zMhVKAXMMbTN_bJbXQdlkQ-K4nY_Mf2z5iNCcN0aSnk8NTU_ZFCPUEzkLPS6JBs93iJHFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jP1OZtcOhYEs9K6qj1EZnP_NiABjEvSa4600X8hOschhF2LyUcb7oA>
    <xmx:jP1OZuM_dA2iYVtNM6X0o-3hFSK7C3c0eAc6C_Ct0fv95bUg73hmPQ>
    <xmx:jP1OZvnBD2xTIJmt3mwqm-0zzWjAwGbZMoV3_FTZDBYAKDA6IGJP_g>
    <xmx:jP1OZoveJF0hMFEZ5yyvmGdhcKsrF2rP8_490K4Ge9XU4NUprF89Dg>
    <xmx:jP1OZg1-yB9tY3LMg6fAsi_gcWbJOlLAs49EWyaC71MQeVgwD5Czjx0O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 04:25:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c7077b85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 08:25:41 +0000 (UTC)
Date: Thu, 23 May 2024 10:25:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/9] refs: implement removal of ref storages
Message-ID: <b758c419c6320690b39a42bede04734fb2d760d7.1716451672.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+QQMphjgWkfNumLO"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--+QQMphjgWkfNumLO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to introduce logic to migrate ref storages. One part of the
migration will be to delete the files that are part of the old ref
storage format. We don't yet have a way to delete such data generically
across ref backends though.

Implement a new `delete` callback and expose it via a new
`ref_storage_delete()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  |  5 ++++
 refs.h                  |  5 ++++
 refs/files-backend.c    | 61 +++++++++++++++++++++++++++++++++++++++++
 refs/packed-backend.c   | 15 ++++++++++
 refs/refs-internal.h    |  7 +++++
 refs/reftable-backend.c | 34 +++++++++++++++++++++++
 6 files changed, 127 insertions(+)

diff --git a/refs.c b/refs.c
index 66e9585767..9b112b0527 100644
--- a/refs.c
+++ b/refs.c
@@ -1861,6 +1861,11 @@ int ref_store_create_on_disk(struct ref_store *refs,=
 int flags, struct strbuf *e
 	return refs->be->create_on_disk(refs, flags, err);
 }
=20
+int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
+{
+	return refs->be->remove_on_disk(refs, err);
+}
+
 int repo_resolve_gitlink_ref(struct repository *r,
 			     const char *submodule, const char *refname,
 			     struct object_id *oid)
diff --git a/refs.h b/refs.h
index 50a2b3ab09..61ee7b7a15 100644
--- a/refs.h
+++ b/refs.h
@@ -129,6 +129,11 @@ int ref_store_create_on_disk(struct ref_store *refs, i=
nt flags, struct strbuf *e
  */
 void ref_store_release(struct ref_store *ref_store);
=20
+/*
+ * Remove the ref store from disk. This deletes all associated data.
+ */
+int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err);
+
 /*
  * Return the peeled value of the oid currently being iterated via
  * for_each_ref(), etc. This is equivalent to calling:
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b7268b26c8..8b74518022 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3340,11 +3340,72 @@ static int files_ref_store_create_on_disk(struct re=
f_store *ref_store,
 	return 0;
 }
=20
+struct remove_one_root_ref_data {
+	const char *gitdir;
+	struct strbuf *err;
+};
+
+static int remove_one_root_ref(const char *refname,
+			       void *cb_data)
+{
+	struct remove_one_root_ref_data *data =3D cb_data;
+	struct strbuf buf =3D STRBUF_INIT;
+	int ret =3D 0;
+
+	strbuf_addf(&buf, "%s/%s", data->gitdir, refname);
+
+	ret =3D remove_path(buf.buf);
+	if (ret < 0)
+		strbuf_addf(data->err, "could not delete %s: %s\n",
+			    refname, strerror(errno));
+
+	strbuf_release(&buf);
+	return ret;
+}
+
+static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
+					  struct strbuf *err)
+{
+	struct files_ref_store *refs =3D
+		files_downcast(ref_store, REF_STORE_WRITE, "remove");
+	struct remove_one_root_ref_data data =3D {
+		.gitdir =3D refs->base.gitdir,
+		.err =3D err,
+	};
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret =3D 0;
+
+	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
+	if (remove_dir_recursively(&sb, 0) < 0) {
+		strbuf_addstr(err, "could not delete refs");
+		ret =3D -1;
+	}
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/logs", refs->base.gitdir);
+	if (remove_dir_recursively(&sb, 0) < 0) {
+		strbuf_addstr(err, "could not delete logs\n");
+		ret =3D -1;
+	}
+	strbuf_reset(&sb);
+
+	ret =3D for_each_root_ref(refs, remove_one_root_ref, &data);
+	if (ret < 0)
+		ret =3D -1;
+
+	if (ref_store_remove_on_disk(refs->packed_ref_store, err) < 0)
+		ret =3D -1;
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 struct ref_storage_be refs_be_files =3D {
 	.name =3D "files",
 	.init =3D files_ref_store_init,
 	.release =3D files_ref_store_release,
 	.create_on_disk =3D files_ref_store_create_on_disk,
+	.remove_on_disk =3D files_ref_store_remove_on_disk,
=20
 	.transaction_prepare =3D files_transaction_prepare,
 	.transaction_finish =3D files_transaction_finish,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 2789fd92f5..c4c1e36aa2 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,5 +1,6 @@
 #include "../git-compat-util.h"
 #include "../config.h"
+#include "../dir.h"
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
@@ -1266,6 +1267,19 @@ static int packed_ref_store_create_on_disk(struct re=
f_store *ref_store UNUSED,
 	return 0;
 }
=20
+static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
+					   struct strbuf *err)
+{
+	struct packed_ref_store *refs =3D packed_downcast(ref_store, 0, "remove");
+
+	if (remove_path(refs->path) < 0) {
+		strbuf_addstr(err, "could not delete packed-refs");
+		return -1;
+	}
+
+	return 0;
+}
+
 /*
  * Write the packed refs from the current snapshot to the packed-refs
  * tempfile, incorporating any changes from `updates`. `updates` must
@@ -1724,6 +1738,7 @@ struct ref_storage_be refs_be_packed =3D {
 	.init =3D packed_ref_store_init,
 	.release =3D packed_ref_store_release,
 	.create_on_disk =3D packed_ref_store_create_on_disk,
+	.remove_on_disk =3D packed_ref_store_remove_on_disk,
=20
 	.transaction_prepare =3D packed_transaction_prepare,
 	.transaction_finish =3D packed_transaction_finish,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 33749fbd83..cbcb6f9c36 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -517,6 +517,12 @@ typedef int ref_store_create_on_disk_fn(struct ref_sto=
re *refs,
 					int flags,
 					struct strbuf *err);
=20
+/*
+ * Remove the reference store from disk.
+ */
+typedef int ref_store_remove_on_disk_fn(struct ref_store *refs,
+					struct strbuf *err);
+
 typedef int ref_transaction_prepare_fn(struct ref_store *refs,
 				       struct ref_transaction *transaction,
 				       struct strbuf *err);
@@ -649,6 +655,7 @@ struct ref_storage_be {
 	ref_store_init_fn *init;
 	ref_store_release_fn *release;
 	ref_store_create_on_disk_fn *create_on_disk;
+	ref_store_remove_on_disk_fn *remove_on_disk;
=20
 	ref_transaction_prepare_fn *transaction_prepare;
 	ref_transaction_finish_fn *transaction_finish;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index bffed9257f..62992a67ee 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1,6 +1,7 @@
 #include "../git-compat-util.h"
 #include "../abspath.h"
 #include "../chdir-notify.h"
+#include "../dir.h"
 #include "../environment.h"
 #include "../gettext.h"
 #include "../hash.h"
@@ -343,6 +344,38 @@ static int reftable_be_create_on_disk(struct ref_store=
 *ref_store,
 	return 0;
 }
=20
+static int reftable_be_remove_on_disk(struct ref_store *ref_store,
+				      struct strbuf *err)
+{
+	struct reftable_ref_store *refs =3D
+		reftable_be_downcast(ref_store, REF_STORE_WRITE, "remove");
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret =3D 0;
+
+	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
+	if (remove_dir_recursively(&sb, 0) < 0) {
+		strbuf_addstr(err, "could not delete reftables");
+		ret =3D -1;
+	}
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
+	if (remove_path(sb.buf) < 0) {
+		strbuf_addstr(err, "could not delete stub HEAD");
+		ret =3D -1;
+	}
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
+	if (remove_path(sb.buf) < 0) {
+		strbuf_addstr(err, "could not delete stub heads");
+		ret =3D -1;
+	}
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 struct reftable_ref_iterator {
 	struct ref_iterator base;
 	struct reftable_ref_store *refs;
@@ -2196,6 +2229,7 @@ struct ref_storage_be refs_be_reftable =3D {
 	.init =3D reftable_be_init,
 	.release =3D reftable_be_release,
 	.create_on_disk =3D reftable_be_create_on_disk,
+	.remove_on_disk =3D reftable_be_remove_on_disk,
=20
 	.transaction_prepare =3D reftable_be_transaction_prepare,
 	.transaction_finish =3D reftable_be_transaction_finish,
--=20
2.45.1.216.g4365c6fcf9.dirty


--+QQMphjgWkfNumLO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO/YgACgkQVbJhu7ck
PpRLuw/9Ezy4KZc9OVYWF5/r/thQXNlP8lC+ClOZZXNurZv5fb/O96aBEdas1e6p
ZjtBFBhdKQjTU/1tYtjph1bxRdrxiB4AjjnDRhv68ag+mvBKiJLDP+RtUmCwuVbn
JMCk3GDze3ZQvX0EvtXXSCn8Nbrq8XeyqbMKud7GfZL0Q9sIRFwvu3oyAFuSrmvZ
HIv5ut6sVOYY1BCo0hbB0xLcmtdZQnoxEN7hHdBpa6QSeOykhU3O/zU09wNRC/LI
ztEb7zrVlJvtQ/U0YcqP3+IFzaARmJcHvdVT4vXMOMmHik9nN5++QXyIUw9/jdyJ
qBhDApW5L0AEV1v+dxdA365Ia1xlre/xlhl1LR4Dc8tPg2Sg1lcVzic9vzwlr/ch
B2s9RBSvtrw4GI3LzU45qzJRoQLyUuyg1Ib/+2DjlnH3r0nuQBJHVPCeyVWTK/lg
/5YtrbzFrwweZXwCcIGEpbrV8JLaHwtdUBHSmm5bfWgQrpySszoGHmoLv52Dn1eq
+HPR+T6f0um85LjrIfMcmrV0T1xz4Gr05KZ3/dMIza0vUmbD7iDNihFERZjQHQke
SXXYzN1/mbzHsMdbhVq+eu67YyUGtUASQpwzv9F2vCUNnIhgvGY67JMo+l3PMs1D
cwx92mR7d4vxKCADH40bJyR299sfxMFYZLwAwxCGO6cPTTS5sBQ=
=915C
-----END PGP SIGNATURE-----

--+QQMphjgWkfNumLO--
