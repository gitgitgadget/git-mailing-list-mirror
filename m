Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27966D1A6
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877924; cv=none; b=R9mA10CSTePOqdYjaeQMSHBvBZmM01cYeBe9lo26yrWT9y0MVOgkxXS1SO2jJSeNPXEVFehpbQ7Q9rAzHAHPgN/fg5yWXuhl1IJpy9mhUZrN9dodQvu9anr43fzoikG4xT1/gFbTwirUELYQym4XRHgCgz2FfPrsSRgHXV0GuYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877924; c=relaxed/simple;
	bh=TZk7JWVuxvJZSSdoS7+17NAzZiiGsHTJ41f3XH9UA38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/uCqfOQzhqBlhFhUxsRpO4ZrVq8HzSu/VeHbaRCgabSCtf9OyWgNGywPsf3DVmHFV8RBPtqMkcPObVFrxCVNeAz7XHzLbtk5lY7b3wX+zBOxrQE/p+Wjb6GNfWTdmXy9I4q3iBufCBzzsURKUKS1zdPNdxKvXlxUwRtK11SqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RDrrL+m0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=REC5m8CW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RDrrL+m0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="REC5m8CW"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 144DB1140081;
	Tue, 28 May 2024 02:32:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 28 May 2024 02:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877922; x=1716964322; bh=2nFvyedBzw
	ijb5VkTKWmX4Qp+0moe1i7fiPBCTu90cU=; b=RDrrL+m0eZXTfYUyh8aFvGSwFM
	ap/Mbi+8Fi2B2+naD6BgwIbPUmFNKt6PvZhqwlUj3ILJf9fUMPkH/tKgUSHBsykY
	WYgjrRGkihO3++uTmuBciMZoV12jhDE8rswZeQKrn8/tFNWZgkOFt6PBZMZETBk+
	nB6c5dFpcTuh0mTCVyEsH7gfgRNGwepi2MEdyqxpmF4oU5d2VD9SqXRSL2MZhTUP
	YYo6m567gVcp5mV1jTKA/JQ5rheQUTMQuUTOcx5OxtuNpgrRIR05/Nuvt3Guqw91
	XHSSa4hWr3WcP+2YU1pKJtmNr9bq9dRXSOeWfsBizTIOF+kpF+yve5PoTqgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877922; x=1716964322; bh=2nFvyedBzwijb5VkTKWmX4Qp+0mo
	e1i7fiPBCTu90cU=; b=REC5m8CWLb9MhvEsCiZUyyWDwIPzkfFzddxQGVB3Y/p+
	t4u3qPbDbOvFYcuc8h2y8b2aabsfuXBqLt/tDdtlMsvx2ryqsVdwd7L555qs9raS
	LBWaMsuWRyKBftOHCb3XK1SyoGEr+4LoVl66kIEyGkNmoHyNE2Qw+wkHJSMpVcNp
	ptP8ODccxtlC/SSNXlPQXbRy21RmUfpYn5YlbtIPHaSslchG4p/1T4AHOt2m+68B
	KrF6nEhdzkUFr8uBK8L6Y8Gx9CXRpGICYmTJfXcqRVi33JONK0IEBlAxy5ODyUGv
	+Jgcyy3SxbC4Vi9PNAUcKquM32Chbd2KVi0ozVHvPw==
X-ME-Sender: <xms:YXpVZo0qmQRJVg9rE3RpEAnu_Lk9oJnLTEn5O1xdpir618jDVZ0THA>
    <xme:YXpVZjHoY1mlLlAZ0MqNneF5r5aPe1CjKlhuqyd5_jiB8CeMUT7LMu9n0MkD3syBQ
    Q0hqDjonatr6L0ehw>
X-ME-Received: <xmr:YXpVZg47slTV31YwSAGbs5L12V1aCZKRTMt_hi12_OFQ-jaQw7UThS3QI6qP9Rh81vYkbHFCYncAbZK1aGNYh2dgGcuQcT0XPgb7IofWSMmaqMpN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:YXpVZh0lvQrL1oOxxgyPCPn9HUDKNX26_IyS3qpesQYGNgjhi4_vNA>
    <xmx:YXpVZrGf4Boig5aWXXmptXah55mI-x1hpEJx4zdnir1g7PWvpA4Zaw>
    <xmx:YXpVZq-gL3fLuHAE1txcDRdVSAbsH993dbfSg4HGX_KPhLC35umYzA>
    <xmx:YXpVZgk2lt93o3jNWBLFfDBu27I-ywwYPNInukWpDnZj5P74wXTO7w>
    <xmx:YnpVZsMbSyzXuNsFO2NDY_TmXJcfU4qe9YZUv3KJrlUkWmHt-EoDcW4f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:32:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0f1c447e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:48 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 10/12] refs: implement removal of ref storages
Message-ID: <f9d9420cf93025595e00aa4287bc0cc1a1c067ab.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+1RoNhRJ1YI4dsIF"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--+1RoNhRJ1YI4dsIF
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
2.45.1.246.gb9cfe4845c.dirty


--+1RoNhRJ1YI4dsIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVel0ACgkQVbJhu7ck
PpRZWQ/6A5fNS7eBBa6whLdfvkAmE52p15FJjVbaOdlCQ8fE3OyNsxRn04hicCYn
vOmoTqgeJCoxHVYmk2yodD/VMTQMO7qTXOYvu+RjKgO7JpFoN82fuAvGpuBRs4at
jFrMsettwGWReaJjrBBQY2QpX58qeFmSQaMfjWKR7YUCA3i6Fvtx2blQ1dTeQsQr
JEfrhPZk7sUpcYpBSaeS+4bkBRSQbOszBwILGlC/uHEPfvo6ynP79oJUddj//NNZ
hJNVXapSbjzeYtFKC9DOoqXU6T7Cg9xLP2IpueFtCQArdcNlU6ueixqSzVpaKYKh
EeDIqB8ly14iaXVXXpHHmir9M3xtfO4PORTCTl9Na0RHhy75pFvCW9V7UNEIGPqP
q9GDE+sm+CHrZ+1JtgroPmsyH5efjrnaN0Wl5872qAWkBi8WF4ZdkB6JzFxyI0py
w6VSwFa428bdQrYCtVbVM9LblHLsCqivzndbbM0ltISDOLc+BaAoS9Npa7xfpvt/
DPgMxNu8k/ZAXvqGpme1ZhBPpjv7HVdfkbZQXA4v3QN07eX9Yl+buN2rvdyn2cal
32hOX6wxcDB8dunMLpSxIuqxxZ4WqMj/Ashs91G0gNx0iOFt/bPxlsFc3XfQ8Mqv
ErhlhY9/oh3wrWSJ/tzpzi1SLgGj8YldRwPVxXjCWs4FTARCepA=
=sjLf
-----END PGP SIGNATURE-----

--+1RoNhRJ1YI4dsIF--
