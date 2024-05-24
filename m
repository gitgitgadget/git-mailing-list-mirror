Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42E85261
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545707; cv=none; b=UQyWY6L5eok/541fKaoD8UlJw0GE1ry++s+/Y3hLsNpzA8c/Evdhur1Sk5W1Vy42NMnVQf2M9XAE9P9zCultrCyzhFXCZgpjEQby9c6+heACU1AXGsLi4IujaBjoQxYx80Y6hfIbLJMH6/kD/cBRoXTgqXU4qD0p14WbIz86Sqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545707; c=relaxed/simple;
	bh=S4roNQp/iGbmHc+Gzb9aKrzD5pSkfHk5OGcHBWQfZ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV1R7VYpDjv/T7zHARyVaIcWJwtth1I4PTLo18G9czBUOT1cg4/onAstNRDIucxXbDaraQIdM/9cewJQ9EqRm+F7EZrl2eooHexAs6micCoDYyM2DiJQgkmp3GRiSuZ78Z56rOcfG/UMuRWD2Dg5w0aBJIlTuMvajEg7GTaNetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K2JkeUDQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DuQ4gjLd; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K2JkeUDQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DuQ4gjLd"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C4E2C114019E;
	Fri, 24 May 2024 06:15:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 06:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545704; x=1716632104; bh=cwoVDG6pgK
	qgHzcEFhocVZfEkJ8NpMc3x1gz/UtLXhA=; b=K2JkeUDQz/ldmzkzXJ4IuPhDH5
	VHV192eRuXiCnTOLg6hz67Gj2/1SUmi1BL0+djFne67bzRTPx2QtIA9l0csRwTo1
	PXvbOeqFIcAeyVeWMzu9MZ/PQgeSn4haUoC24Mw6xdX0Jto1WG7UVTp8NwQzkAnp
	RkFokm6IBYNrE23NF4c1cIDF98PaUQt02giu4hedZ3z+7X0S/h5GSNiXflQvo+CF
	bN7YYqIX55o150wtc/WXrcI+bOd3t7nVMkPGG3eYos513Usjtz9d+WhtsP2s5G2n
	Xq3ofnwolNLt61+Ul+JM0V2b3ppnebkVepXu2KuH39HUAWWlzXycJjYgxIzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545704; x=1716632104; bh=cwoVDG6pgKqgHzcEFhocVZfEkJ8N
	pMc3x1gz/UtLXhA=; b=DuQ4gjLdznZs2/0wU7cW5lTjuzjXbt1dn/uZywUmL99a
	5PTpGu8wCkfDjafIF1wjHfKqJx99KVJjzxXFDwBJiem/wHB6Vrb7lhKK3h360gtv
	CL6ydpP1cQz4F2Bdlr789D+raO+/UzhNreo138RPE5sRtf/yp7EqnTp699KEzjNz
	+qEWCfc9VLuMW8W27Eb7TN+J9T9gVC4/NsRTVJvR9e7brUw2IgSlyP1+vGapyn0w
	TL92J7paAjjdRM7YMrVLn6Xf3x6L+V/s2WKjiGE/XRjiNzSGTagT+maWaUau2QEw
	MtGdK4e1T2c0PdthsRjjCk1xcjE8J0xbg5PUvaNq4A==
X-ME-Sender: <xms:qGhQZt0dbR66ehwgUniv4qlvcuenAqRaTAejNkjxYhu_LEv8kBhw6w>
    <xme:qGhQZkFh_HKB3LWD2OVkBf93dfDW-fEcdjg1M9-kd8tTKkoHDbyexwR8AKdo7wXea
    Tuq05ZUpuyKsv3uTQ>
X-ME-Received: <xmr:qGhQZt4mIrK2E7PQ4YatBqYCNnCMM5JwgR8eMMiXhLB1t16Ywt0ReFUvc6w4omRVOCGOm7z6t98pNmg9KGq2a9jV7J2RkRMUQ2g86gCPLCX28CM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qGhQZq1sASWuK5Ii3IiCCuaayRCIa_TWs2CoZsluHcO-sNYhFl3u-Q>
    <xmx:qGhQZgF4_np-4CEYSLP4dGiGtw63O1_YqvrKt9UA_q8ogBP4bHpGMA>
    <xmx:qGhQZr-a_P0A5O3bncfq2qktMCkqPzcGY62vAUnSgsjKh-GUAbYY0w>
    <xmx:qGhQZtkOR9Qqy5HK-l5PkEe2e-csDySXLUGih1voBJiwMbLdr9aF1A>
    <xmx:qGhQZkD574XgVUbCcpi8GGfPOg3dlTdp4q-87zvv1mRf9sCvCMGxU0qm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:15:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a2f3a1b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:15:01 +0000 (UTC)
Date: Fri, 24 May 2024 12:15:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/9] refs: implement removal of ref storages
Message-ID: <b758c419c6320690b39a42bede04734fb2d760d7.1716545235.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nn9FPHiwZxpbmbZX"
Content-Disposition: inline
In-Reply-To: <cover.1716545235.git.ps@pks.im>


--nn9FPHiwZxpbmbZX
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


--nn9FPHiwZxpbmbZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaKQACgkQVbJhu7ck
PpTUnQ/+Ic76i18P/86lFrdlDSW4BpA4ohvgdQWsBna5AxjiBTaBTvF4gWcvF3q8
0EfIFNBdzFTrtzHITdj370/HNDDfKdE/PRNe+NSlcL6cUeT8k+OhgBZ/9Cuubaoa
FVOOwJlLTq6gZc3h3TeS13nafcsr27UCiiOwiqhp5JY/CW2/QmkNq1SjKY9dWnGB
dhhZpXKCDEkjduqk2/xlGA5LPGFsu/yg6GeMylzwdOaGCBEsBIYlb9SGBANH6lKp
b3+PY+U1eqxyOV5FbC+KZXjZEMTh4NBwDE/eb8tc3sf6WhPepvxDXj/6NVV4ThRr
h4EfLw1HscAUY2MHaCpQo/Luy5gGiLSTHV4y3VD5rh/a1j9499EuVj7MbDdO9oW9
scJ+1NYc85vOYIA2lIYUAcjMUVxN0coqF9MNUQxslrEKQepGWd1UZPu9VaZ5gfta
0tSX5a2VG3dKhVLQHbaOJVX/qFCXQ2S7YH6uNXXlstBIFtXHV+AqS95Qvquc+bba
G8kQOhKULRcucs6oIRY07OeJv6jAa1SLESldjNty3iIf23OqqZjFcV9s6NQnQ8Fk
7UAKmAdd9fBX+9+aneSGkHP+GHDPvf+IBjV6OzeU0XcQKEtd7i85rDfBZdMp1+Fz
kDUp7xQNgRkXR9PZfRgKTJvO63ZxIMyMtOxF9kVBCxQ64sBhpQs=
=8T/o
-----END PGP SIGNATURE-----

--nn9FPHiwZxpbmbZX--
