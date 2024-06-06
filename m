Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6DD38F9C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651786; cv=none; b=AhdQTr5otke4GMl6SDqo7VZlR6BW1w1tYYKd1buOPZ7mdUlhKncdMkX6deiIfwRjQMmqlKAsoDmfXydh7C5egK6mjfumd1zbiYcgstuWW/4OfD0r3MdsVNchHDX4urV4nlQTEWhARAAp5GTz9hivYjPmDfJGDFOM35fcqTV+WFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651786; c=relaxed/simple;
	bh=GWsPpmc/e8WlZsLw60fwdL0NJea4HGKtxXdmiTChUmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiKRudbfxeAMkQdTFBRD3xOONDvEFlVqAEAqdbUVHpBkVisg4azk0eia/1RW61yYolu1tGDrcAiz+J/NNjXWYGSorms7RWwGHpqcUPzbZJrst6luF8QLY2RfWUA3jFBuzLk8f3n5GsRWnv0YGCdlQvzqaftaFkviBgdTfhtdSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fHzk787e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CLyoRi5M; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fHzk787e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CLyoRi5M"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 99B3E1C001CF;
	Thu,  6 Jun 2024 01:29:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 01:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651783; x=1717738183; bh=YBjFRcmq/9
	dGqKp+ruDeWDGb9J0m4MXTI9lpZeQ36hM=; b=fHzk787eNwxUL9dl2qP+lhsiO6
	N17FYf15P5sW531cyOjdTUZL6Swe4ZDHaoZK4BuWIMVeUbjiB9C4KnscXvgaXKK6
	z9lbRRr2ddboJnTYw3V1an43ESGfWM6mNiJzrY12YaAyOAeuS/wr6AfIldkkMmYZ
	Wo+NM6xrhqzLpkq4+itnbaMyjClJAHaCYpe1PLiT8kWyPm8pBKMHm+q2CEJY3VUY
	T9zvVh3VKT1isVrsF+n7JVkahNmM9iykUNbEBBDqkfGIWJsVfrNI7r1dy7SECQsU
	+7Vz8mPzU5+y8k2Dzrr7rpa5vmNMTXVI3p/rz7JIwZKivv/Z6ohhv20VeWgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651783; x=1717738183; bh=YBjFRcmq/9dGqKp+ruDeWDGb9J0m
	4MXTI9lpZeQ36hM=; b=CLyoRi5MYYUCPOVGuI/ncw0DcGHh+sPfVJkvzOs5CQVe
	1ybre0EWfHJgd47JYkLFN0w0rQ3oq7qHSrFo3nsEs7a+6BHF605Rbq6XUYTdYrBq
	oOVBSvvtUlAn7XXZ44sgBduIskEbgMNnRBJbjCp55XlVftNilQMGelWYUY2ANJvD
	TazS41eFuYAesl3Sv20d4+hp60sjq9/MruqNAsqGkyLs+d4MxAkym1/scSrrY74A
	sKgXgmRl3P7jZTJhqyRKaAvJ/SJ/fxCtP68G2tbLbtEHxzq+z7nIQcsypMhpj/VG
	s11dwDnR2TtGZixWjc63nzXG7TtCawholnNq2RaLvQ==
X-ME-Sender: <xms:R0lhZueV-07iV9fVojG2f4wib3LZ98D6QqJYn-KcoIAXjaPEmf8vYg>
    <xme:R0lhZoN5tnQgHCYsGI73GOfC3vv8uSet2R8x_6Q7_ieHmjllWso5bKDcruBzWq2l2
    QKjOjLulswh9fllJw>
X-ME-Received: <xmr:R0lhZvjGATmlGSyQsi6r5JdOa4RtYJc-8peEm66pEtJ3V67fR92GC0UgK22UkoRp2kCxNnFmQA7E-5-6dTHDEN1a2PugrVjfuGrpeVP_UyJMRBMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:R0lhZr_zB6AXD3nAFEGFdB6Af61oGMvEMyhpqgbAgf0LbQ7086vsLA>
    <xmx:R0lhZqsmuNowlDdhXErqxBXegCThK6urlMW6Nx5yViJe0FcUKPF4Dw>
    <xmx:R0lhZiG1sANTKJzkzEsM97wwqa_ejak4Dc8ZM7hsLPl79zjsoEk60w>
    <xmx:R0lhZpNWAmD4YTqjrP0Z835IdM7Yf4SbXQdczr7iJwApYm_o58Mlmg>
    <xmx:R0lhZn9qDTE6uHiEPDONJ9UPjemNLVkoIch511CfF6Y1BjTF8B_gJAR6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 82111a79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:29:11 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 10/12] refs: implement removal of ref storages
Message-ID: <7b5fee21856d970bdf6cd423d2b354e610e78df6.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="06GrAdbcIM2z1KW4"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--06GrAdbcIM2z1KW4
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
 refs/files-backend.c    | 62 +++++++++++++++++++++++++++++++++++++++++
 refs/packed-backend.c   | 15 ++++++++++
 refs/refs-internal.h    |  7 +++++
 refs/reftable-backend.c | 52 ++++++++++++++++++++++++++++++++++
 6 files changed, 146 insertions(+)

diff --git a/refs.c b/refs.c
index fa3b0a82d4..31fd391214 100644
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
index de8cc83174..e663781199 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3342,11 +3342,73 @@ static int files_ref_store_create_on_disk(struct re=
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
+	if (for_each_root_ref(refs, remove_one_root_ref, &data) < 0)
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
index bffed9257f..da6b3162f3 100644
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
+		strbuf_addf(err, "could not delete refs directory: %s",
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
2.45.2.409.g7b0defb391.dirty


--06GrAdbcIM2z1KW4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSUIACgkQVbJhu7ck
PpTnKQ/+KsfP8/IkKa1ySsPCjdvKe4mGukG5rEU0Z2L85X6OOe3UYtn+XLxrkE7n
wlLa5hfoS5inOjz8zEn5jGXCrIQWOKdtXzKw/o7s9zgDtxmzeECX836AG3yVYrOP
YpfnFK1y+oSp/YAwGpTKVphSmg2ezfCzgUFf7RBC7LaIU6kcssorX/Pk9XctA1c5
rulU0LoJzAGaJlE17ctGF2GyX/1G046jGLb6pIxMNKfWxc27r9l07k7FxDA3s3mF
txJVtBjAxQl5stbhXwyQMp3UOid1loK/6Biy+UBgluW75f8I+wMqDjPamaj9VTXR
ZGgW8xH2BYrWUtRV3fYXJ34dxA8WdUxjDXwgZxISTIbFWJj9zjjHLyGQEWywzsZ8
uh7p7T+mOezIHZqXyksGeWnBDv+s/rAuTxwaXLAJWTKj+cRT4g6PfxTjFSPJdkit
5Sg0bjP9lABf/smhVorT5FEVxmRRz+ZCJcYfLkDvEJwlI9KgeXLL2km6+Y9l44r/
D5Qty/RkC1myoa9GRKq8ZtoY4vJ2aiydNCRpIa0l06gMusQSiDU1FZwgQULf0wer
5jRKXBQK5DnWNpZlaBIuwFU634ZajCtdpGtlPm8iMyPK0iX87dVnht+YQfEuH2Au
OZsX6vwHnrOLqZhms6SseLXmMspav6iyLyvFK/regkFPXHvYHLI=
=HwI/
-----END PGP SIGNATURE-----

--06GrAdbcIM2z1KW4--
