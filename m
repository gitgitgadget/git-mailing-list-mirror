Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620884DFA
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407061; cv=none; b=YP7heKGIcsvx8ZVaI67JZYCu9T+AOX9XxPJpaj0xawI26dk9stDEqU2R2l/EFC2S2baOWzcpF0k05zkosxkgqNYxH6+3DxS4UvnFjt29peJlaIpFFqfwdVQY5j6Yg4M/YRCqUcq3VGUhwzs1oD6PiZXSSIqGzv2AVv8BIJT4bZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407061; c=relaxed/simple;
	bh=u6kpesYwfcKBBJtODqEcTjoMr4p40odt7aqVqrqx07E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2WTDskPZMaVUHDb4cFl+6V8myh5sgIYdb+gTUsw79550Ymh8MtUReLHDy2cEMoKDCqnkkmpNvJ/QtUyp61ZANYYiBpfA+c5rGaxDjygu2Mb7PYRTBdj1uiWbKuyITliI4fV/wB3I4XGgeecwu8vioGV9xANai6DpIzYurcEPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KxFxVmmx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NVyA7UBq; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KxFxVmmx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NVyA7UBq"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id CFC52180009D;
	Mon,  3 Jun 2024 05:30:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407058; x=1717493458; bh=TzdOGx7UUz
	aLRqVKpdYP04UmUMXse/MvEyjvrD/6mV0=; b=KxFxVmmxqTWs6iPlFqDhlvjYYp
	33PtkfcjbpzVcBBu6BXpQSXLLD7snCE5HeVgX5RXMaNV22vrZppW6Wblq39eQ0jP
	L8kbBzkDIjMzZ9U1ccLTXEoEm2lHvc3I3ToSkStK+CSYlhpfSoit9JrXSFRmQtOv
	L5iZixn4N2bfIbJjmBZtVPxeyHSygn0nrUpunROLWSLxDzaMTdLa6oGhnZS3/J62
	nDQMScdoZj6491GSBQ2DnQSb7EYuYxF0VdXBQ3ghcx68hNVehVfniTULDQnV9kg5
	CTQYTc2TC6kuNgZ8gbdxzeD6B7EHtRjlKRWWhuEMlnjL8LhB/pZ/x/Egimeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407058; x=1717493458; bh=TzdOGx7UUzaLRqVKpdYP04UmUMXs
	e/MvEyjvrD/6mV0=; b=NVyA7UBqXq0kKz669ijnR4fJFXaD9iytMIk7l+wfSlTu
	VO7mJWORZ+C0YOw+Sh2Gdlyr1eKoNeE1Ql8bqQHlAtrYIojWezrWUclC7PNjeq59
	mPr5cGLF0iuCmF4eeei0asJkMK3TZGREyzW2CvsBoFyhnEX+XVuMBX/VniyEM/Cp
	2dl3egsSacLQZrMEiPApcO3IpcumjzBzYofCAckQHBv0LfpblVl8BCQeS5kpM8Gq
	AIIZPybe1nwqxnDd6LGOkSeUZUKbvDUDlv7HZ3aFf1VE94t/dKkxT4uQdX6O3LuU
	UZEy3RuIxwrdt/QhhSWn+iWcsWSYBXRV77iJNlKS0w==
X-ME-Sender: <xms:Uo1dZmpAt5Uv4Lr56bXPFn6HEcaNejXYxL94sgsqNN5HDp6ggkrEbA>
    <xme:Uo1dZkrFk_g5bdVhbMnya_qn3pdCjcyNZLwajJZIFpzWw6lsgAfvC9DVA2RdaVqqK
    6QmYMj3ITShyk0Z5g>
X-ME-Received: <xmr:Uo1dZrPUw53Y7iVhlS_9-Taz5CmZEC-WEz31uVsNtSBaI6VOig8Zvyw3b_18HCi5q2InEZtTREDyesmuiQas3llCnWNHff4DQCdTaIf8hgmh3cq2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Uo1dZl7OYbEjMWNQ6ssPS0OhyFpkF-lAKMux95JVJml_FDjidCXxmQ>
    <xmx:Uo1dZl4W-WTqRPmz0Xr8J3cjPJtWiP3H2O8D-9ofADTjxJtCx48cMg>
    <xmx:Uo1dZliWtWslnRbu0F5lEk9va22GUMP0RLgGsKURPAwsnPHZBFjPaw>
    <xmx:Uo1dZv6kIV1c8dpP7ptzxRSH5PTp9fHY3SeEmvZo62gbW-DvycUjWA>
    <xmx:Uo1dZjRRjBnl9Sa2ErQRVcroIDv-xlRs03QJKdxVCCB2YQL1uaowt5hJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 523562ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:30:33 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 10/12] refs: implement removal of ref storages
Message-ID: <f9d9420cf93025595e00aa4287bc0cc1a1c067ab.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CwgpDESBaNHPRiYP"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--CwgpDESBaNHPRiYP
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
 refs/files-backend.c    | 63 +++++++++++++++++++++++++++++++++++++++++
 refs/packed-backend.c   | 15 ++++++++++
 refs/refs-internal.h    |  7 +++++
 refs/reftable-backend.c | 52 ++++++++++++++++++++++++++++++++++
 6 files changed, 147 insertions(+)

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
index b7268b26c8..cb752d32b6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3340,11 +3340,74 @@ static int files_ref_store_create_on_disk(struct re=
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
+	ret =3D unlink(buf.buf);
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
+		strbuf_addf(err, "could not delete refs: %s",
+			    strerror(errno));
+		ret =3D -1;
+	}
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/logs", refs->base.gitdir);
+	if (remove_dir_recursively(&sb, 0) < 0) {
+		strbuf_addf(err, "could not delete logs: %s",
+			    strerror(errno));
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
index bffed9257f..e555be4671 100644
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
@@ -343,6 +344,56 @@ static int reftable_be_create_on_disk(struct ref_store=
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
+	/*
+	 * Release the ref store such that all stacks are closed. This is
+	 * required so that the "tables.list" file is not open anymore, which
+	 * would otherwise make it impossible to remove the file on Windows.
+	 */
+	reftable_be_release(ref_store);
+
+	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
+	if (remove_dir_recursively(&sb, 0) < 0) {
+		strbuf_addf(err, "could not delete reftables: %s",
+			    strerror(errno));
+		ret =3D -1;
+	}
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
+	if (unlink(sb.buf) < 0) {
+		strbuf_addf(err, "could not delete stub HEAD: %s",
+			    strerror(errno));
+		ret =3D -1;
+	}
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
+	if (unlink(sb.buf) < 0) {
+		strbuf_addf(err, "could not delete stub heads: %s",
+			    strerror(errno));
+		ret =3D -1;
+	}
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
+	if (rmdir(sb.buf) < 0) {
+		strbuf_addf(err, "could not delete stub heads: %s",
+			    strerror(errno));
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
@@ -2196,6 +2247,7 @@ struct ref_storage_be refs_be_reftable =3D {
 	.init =3D reftable_be_init,
 	.release =3D reftable_be_release,
 	.create_on_disk =3D reftable_be_create_on_disk,
+	.remove_on_disk =3D reftable_be_remove_on_disk,
=20
 	.transaction_prepare =3D reftable_be_transaction_prepare,
 	.transaction_finish =3D reftable_be_transaction_finish,
--=20
2.45.1.410.g58bac47f8e.dirty


--CwgpDESBaNHPRiYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjU4ACgkQVbJhu7ck
PpRAUA/+MwroV6YpDaHF500Ys2GKqDY/W8+d+xPuSTiazzwW3jgQsHvoDiFIdjKU
sIt0O3ZNnGGC9LhjGS6du0Oo9VzLJbUFabJD6wFVgu6gQTEm4V+i8zD0cKxbyup7
CwAA+JpDlAjLHPjLsFmBM/C0QuG3M+xXobC4Ia9VBXuuKOio3djQ6tXBsTlXCOxj
D3UjBy+gFjYw5cxxIv6MMWW6PWAHuem9TBlDcF3ph2sL89QZ28apcHy9+2JKuJ8A
WjLOpxdZLYjWRNjzebTlBkmGL2ESQS35KbrKk2tYrFXy7SpWUQZSZooIWhsx/+kP
oyTResFLjbnTl0uNLMfqAX2Z3VO4pvfb4K2ABwHYrcamiDSINFycuKM1WfzURfs9
7iFHwuf3YMtrtJjEbZjHm88McmKMYxO6rUOAddcPHu4MQwJPexPVx5rxGOndaVSx
TKR2JXEFzyv1GB18YvK6Q9SNfeAssLgXG+YP477D7NAoAjs8BHSzCUBkdVfWN6ko
gV6MJN1X+4eONMcfDFrP12QNjTrhOkGiErTv2b71mpMNwjUbAIZqio1rU5AcIF6m
3rqfQN0qGUaQ9yFXUF13cRSbPipTg7Y3C6EA8zlddvm6E4E0etu8Awiy4lATWCor
p/HD74yvB8+OJ59ijrFqc5IT8fxMsB5VJjlhfHwl6+eyFC7x7Lo=
=EYGF
-----END PGP SIGNATURE-----

--CwgpDESBaNHPRiYP--
