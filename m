Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41B84A35
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407023; cv=none; b=RrMLVBN5up/nkM0DLEU4yIvq6NxAQuHr1Hkpuh/hEHFhjo1Wz1/xAXIJzc2NvfZ+28arx1wZYEEZqDh9w+fGAKoQvqWR64FZd3diRU9W1C2f9vLoj0rC+eeMmdMBAvWBmGVl4C4niKGRu+ZSSMxbEHXFjcHzcA1oF2QOnrnZw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407023; c=relaxed/simple;
	bh=LygTzIrf1FTz8xR1Kzdxlswm2YR1aLFoIqBFW7fBgNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFzpC2UnYrVejm5MTszAlCL0lWFCvJ+PUg9l63ZLjiFOZWQo5pH5Ws7QLKsMDxKnSyMdR+gFq30yrqaGRgWM7OlmrDW/K5RE0zZbEn5qdcJPhPkwUKzqsJX6MCZ5pxf+j2oC56+hyswb+tVmdIeRyWrdrdbT16173SkC5wzQeME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CTJEaYbL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PgA1qwGR; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CTJEaYbL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PgA1qwGR"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 944531C000EC;
	Mon,  3 Jun 2024 05:30:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407020; x=1717493420; bh=iLxCRqpN1z
	lPqW0l1wZc18W3cEVtYm/wVQoO+P3RUDw=; b=CTJEaYbLzYO+AY37djojsv0YNA
	zvCXVWHLMrEvdRgWoqOsf0Xw1jdusf0EwEQwKeh28nkZRdiJBgX7pETgvq5Wdthm
	0GWFfahT+oVPQ2MdCav89/ZfNO3RghH5E1mFQQUWd2p4bHnEnFjxBz6h+bBrIgvN
	5xDWTIzf7ufIvVShPNm1QknI50IO9SSnq+2KSBdcAYUWKKC7s/8tS5CWBltF4Z7q
	w5XRAhtZKP6fiMiKu87HUXKaQf+q7tHmwSUpwlYU9AVEpDQUqtkhj0LP5G79kqZm
	/Lw/TKbod/u/lu0X6KPS5+fRebiR0bqTJv6BWqS/0YIhQBtciqjglecDN9oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407020; x=1717493420; bh=iLxCRqpN1zlPqW0l1wZc18W3cEVt
	Ym/wVQoO+P3RUDw=; b=PgA1qwGRnmc+ZwZu8YPyGZFJaSr4dK65ff7qRRKMIiU3
	xONprZU7R+OJvjXWEg9xikcHVNIBW7cl+6SKMLFsY5/T3Ep1NEAQqux6hb8+49MV
	aUCp+zb4472xcEJVW+EetUxCoL7IiHjPWLu3Zf+1skz5cb54gD3NTTf6SZvCemIY
	Cb9Z3CjmS+X0SGSSNyoMwktXfPml+XPpM5+n8VOhbpggJ3Yfnt5Qq+NoAmGi/3Hp
	NHDJ8BiSgt1UxJQHHPQpLuXBL2fL3dg/xlECQgQ4RGDCekHY4af5OIc8jZLKP8+T
	lxIzRRG63RBfTyC0/DUkoUIzqIGraIcgxnV24TQ1JA==
X-ME-Sender: <xms:LI1dZhaQeGUokWDku9njI32oEK2ogXQYhk4GoyttAY8a2HRGbmQ8kw>
    <xme:LI1dZoY5B7ZjH4ZbI4gr2FAu1rnBMP8bwUDQ4KS0NsQ0WagewBYNyM_RqTXYHfE3m
    yZylLZ4AG-yx44H3g>
X-ME-Received: <xmr:LI1dZj86qjFrkEUotQ5nFm-yjCLEn0B4N6qdIS6COAR1xsbk9lsbvy8YM6ICSEC98KE7RuJyxYpp7_9lJvf6K9HjJGU3Gq4780dCOE1SUrJD1RDy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:LI1dZvrSxq5VLYZzRxgALxd-j70vSUdwdsjsEnTpdgNBZTwTgAJijQ>
    <xmx:LI1dZso08JJpLCKfKsDYB6rVBpgzjVmaf-8DKdOVSrFkjHVliEVzRw>
    <xmx:LI1dZlSS0rYW8LV1maTqSZN_pvgeiEo2YU74fRrCA6YuTQwaf0Z1Hg>
    <xmx:LI1dZkpXLTcxYNMqXZbyRkNn0IWp1-NBAmRY6bDO4XkedIKZAVBaXA>
    <xmx:LI1dZhDzwM-1v9SXv3Oc03JlansG7526SBLx1VJo6kh29MQ18NnRHOoi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8ae29166 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:29:54 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 02/12] refs: convert ref storage format to an enum
Message-ID: <7989e82dcd89c92f23de7ab4ebde96124aa6fe12.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iY/OvtLvJ5+Ih1/W"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--iY/OvtLvJ5+Ih1/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ref storage format is tracked as a simple unsigned integer, which
makes it harder than necessary to discover what that integer actually is
or where its values are defined.

Convert the ref storage format to instead be an enum.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c   |  2 +-
 builtin/init-db.c |  2 +-
 refs.c            |  7 ++++---
 refs.h            | 10 ++++++++--
 repository.c      |  3 ++-
 repository.h      | 10 ++++------
 setup.c           |  8 ++++----
 setup.h           |  9 +++++----
 8 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 1e07524c53..e808e02017 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -970,7 +970,7 @@ int cmd_clone(int argc, const char **argv, const char *=
prefix)
 	int submodule_progress;
 	int filter_submodules =3D 0;
 	int hash_algo;
-	unsigned int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
+	enum ref_storage_format ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
 	const int do_not_override_repo_unix_permissions =3D -1;
 	const char *template_dir;
 	char *template_dir_dup =3D NULL;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0170469b84..582dcf20f8 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -81,7 +81,7 @@ int cmd_init_db(int argc, const char **argv, const char *=
prefix)
 	const char *ref_format =3D NULL;
 	const char *initial_branch =3D NULL;
 	int hash_algo =3D GIT_HASH_UNKNOWN;
-	unsigned int ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
+	enum ref_storage_format ref_storage_format =3D REF_STORAGE_FORMAT_UNKNOWN;
 	int init_shared_repository =3D -1;
 	const struct option init_db_options[] =3D {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
diff --git a/refs.c b/refs.c
index 31032588e0..e6db85a165 100644
--- a/refs.c
+++ b/refs.c
@@ -37,14 +37,15 @@ static const struct ref_storage_be *refs_backends[] =3D=
 {
 	[REF_STORAGE_FORMAT_REFTABLE] =3D &refs_be_reftable,
 };
=20
-static const struct ref_storage_be *find_ref_storage_backend(unsigned int =
ref_storage_format)
+static const struct ref_storage_be *find_ref_storage_backend(
+	enum ref_storage_format ref_storage_format)
 {
 	if (ref_storage_format < ARRAY_SIZE(refs_backends))
 		return refs_backends[ref_storage_format];
 	return NULL;
 }
=20
-unsigned int ref_storage_format_by_name(const char *name)
+enum ref_storage_format ref_storage_format_by_name(const char *name)
 {
 	for (unsigned int i =3D 0; i < ARRAY_SIZE(refs_backends); i++)
 		if (refs_backends[i] && !strcmp(refs_backends[i]->name, name))
@@ -52,7 +53,7 @@ unsigned int ref_storage_format_by_name(const char *name)
 	return REF_STORAGE_FORMAT_UNKNOWN;
 }
=20
-const char *ref_storage_format_to_name(unsigned int ref_storage_format)
+const char *ref_storage_format_to_name(enum ref_storage_format ref_storage=
_format)
 {
 	const struct ref_storage_be *be =3D find_ref_storage_backend(ref_storage_=
format);
 	if (!be)
diff --git a/refs.h b/refs.h
index fe7f0db35e..a7afa9bede 100644
--- a/refs.h
+++ b/refs.h
@@ -11,8 +11,14 @@ struct string_list;
 struct string_list_item;
 struct worktree;
=20
-unsigned int ref_storage_format_by_name(const char *name);
-const char *ref_storage_format_to_name(unsigned int ref_storage_format);
+enum ref_storage_format {
+	REF_STORAGE_FORMAT_UNKNOWN,
+	REF_STORAGE_FORMAT_FILES,
+	REF_STORAGE_FORMAT_REFTABLE,
+};
+
+enum ref_storage_format ref_storage_format_by_name(const char *name);
+const char *ref_storage_format_to_name(enum ref_storage_format ref_storage=
_format);
=20
 /*
  * Resolve a reference, recursively following symbolic refererences.
diff --git a/repository.c b/repository.c
index d29b0304fb..166863f852 100644
--- a/repository.c
+++ b/repository.c
@@ -124,7 +124,8 @@ void repo_set_compat_hash_algo(struct repository *repo,=
 int algo)
 		repo_read_loose_object_map(repo);
 }
=20
-void repo_set_ref_storage_format(struct repository *repo, unsigned int for=
mat)
+void repo_set_ref_storage_format(struct repository *repo,
+				 enum ref_storage_format format)
 {
 	repo->ref_storage_format =3D format;
 }
diff --git a/repository.h b/repository.h
index 4bd8969005..a35cd77c35 100644
--- a/repository.h
+++ b/repository.h
@@ -1,6 +1,7 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
=20
+#include "refs.h"
 #include "strmap.h"
=20
 struct config_set;
@@ -26,10 +27,6 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NOOP,
 };
=20
-#define REF_STORAGE_FORMAT_UNKNOWN  0
-#define REF_STORAGE_FORMAT_FILES    1
-#define REF_STORAGE_FORMAT_REFTABLE 2
-
 struct repo_settings {
 	int initialized;
=20
@@ -181,7 +178,7 @@ struct repository {
 	const struct git_hash_algo *compat_hash_algo;
=20
 	/* Repository's reference storage format, as serialized on disk. */
-	unsigned int ref_storage_format;
+	enum ref_storage_format ref_storage_format;
=20
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
@@ -220,7 +217,8 @@ void repo_set_gitdir(struct repository *repo, const cha=
r *root,
 void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
 void repo_set_compat_hash_algo(struct repository *repo, int compat_algo);
-void repo_set_ref_storage_format(struct repository *repo, unsigned int for=
mat);
+void repo_set_ref_storage_format(struct repository *repo,
+				 enum ref_storage_format format);
 void initialize_repository(struct repository *repo);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktr=
ee);
diff --git a/setup.c b/setup.c
index 8c84ec9d4b..b49ee3e95f 100644
--- a/setup.c
+++ b/setup.c
@@ -1997,7 +1997,7 @@ static int needs_work_tree_config(const char *git_dir=
, const char *work_tree)
 }
=20
 void initialize_repository_version(int hash_algo,
-				   unsigned int ref_storage_format,
+				   enum ref_storage_format ref_storage_format,
 				   int reinit)
 {
 	char repo_version_string[10];
@@ -2044,7 +2044,7 @@ static int is_reinit(void)
 	return ret;
 }
=20
-void create_reference_database(unsigned int ref_storage_format,
+void create_reference_database(enum ref_storage_format ref_storage_format,
 			       const char *initial_branch, int quiet)
 {
 	struct strbuf err =3D STRBUF_INIT;
@@ -2243,7 +2243,7 @@ static void validate_hash_algorithm(struct repository=
_format *repo_fmt, int hash
 }
=20
 static void validate_ref_storage_format(struct repository_format *repo_fmt,
-					unsigned int format)
+					enum ref_storage_format format)
 {
 	const char *name =3D getenv("GIT_DEFAULT_REF_FORMAT");
=20
@@ -2263,7 +2263,7 @@ static void validate_ref_storage_format(struct reposi=
tory_format *repo_fmt,
=20
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash,
-	    unsigned int ref_storage_format,
+	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch,
 	    int init_shared_repository, unsigned int flags)
 {
diff --git a/setup.h b/setup.h
index b3fd3bf45a..cd8dbc2497 100644
--- a/setup.h
+++ b/setup.h
@@ -1,6 +1,7 @@
 #ifndef SETUP_H
 #define SETUP_H
=20
+#include "refs.h"
 #include "string-list.h"
=20
 int is_inside_git_dir(void);
@@ -128,7 +129,7 @@ struct repository_format {
 	int is_bare;
 	int hash_algo;
 	int compat_hash_algo;
-	unsigned int ref_storage_format;
+	enum ref_storage_format ref_storage_format;
 	int sparse_index;
 	char *work_tree;
 	struct string_list unknown_extensions;
@@ -192,13 +193,13 @@ const char *get_template_dir(const char *option_templ=
ate);
=20
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
-	    unsigned int ref_storage_format,
+	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch, int init_shared_repository,
 	    unsigned int flags);
 void initialize_repository_version(int hash_algo,
-				   unsigned int ref_storage_format,
+				   enum ref_storage_format ref_storage_format,
 				   int reinit);
-void create_reference_database(unsigned int ref_storage_format,
+void create_reference_database(enum ref_storage_format ref_storage_format,
 			       const char *initial_branch, int quiet);
=20
 /*
--=20
2.45.1.410.g58bac47f8e.dirty


--iY/OvtLvJ5+Ih1/W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjScACgkQVbJhu7ck
PpRR3g//SEtKAFjyZCHNRZUUefhL7Mg+7F1tKcaS2G9wA+3M4jmwAxbMAzv//Bga
90c7v4ZEoszkJ3NOIA/69FhEA4K6WDe6oI+bKEgooRDxBEny8K9UA1OMBa9TOMWH
EgYecT+Xbtvop0d1HfKgAI6yrcerFfUFDvqEbqIx17TrAK6TEy1PIk9BUlcT2dFY
DghUAKZKg49XGApJ2HTwHHJEQ1JVAE9qKS78b5uKFz7w4sre4CzCC633mfLCsyOT
P/TGxUIBPqQLJ8AyT2KFgu0nmQnr7ajxpubY6WlkHPjTwyBPgwTF94wCzA58yP84
kgYxxlfYEk8DW47++68HzP5dPrjdz4WOpNPSq7A8jfzJA1AIyAQF44jxe4UV3I18
xOOR6gk4bJ4DqjgJpgYttxoIDH2vdEqlh9WGuH1pypNrO1If8oe4y87f1gS9d1PB
nMWHzLlH6f4vIwN2gTjGKBkW1AjKQbgO+On5BNzTY0vn8kjc7wFB8rXpalB6FtsC
WYj1XbTAul62WXJTssT3JHyukgH4VFE6FEqs/I4lWrDoQv43Lh36wsVK5UWXhRXH
TrWDjY2HIN8Kp2LZ/vkM06FXQ/MzEeJe9D5FvDz2FwTNJHkBDXjlOW2c2NQ2OSzI
2gXuv/zJ7z+hxvcmK8ngtqnJbLDlvQJf/JYThrNZr6zLNiaCOCc=
=2RT2
-----END PGP SIGNATURE-----

--iY/OvtLvJ5+Ih1/W--
