Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1628F48
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877885; cv=none; b=iIF7cOvlJ//7MomPOqxOK1sJKeAaE6fVzhcIwzEyeBoW8QTk5RKwPUlOZa8pQwICSh8RK84dynC5KEah3TvHKoGYZZaaoO08IGX6DGhOsCYjUbM4VaVm4isKf1LttXajpQiMZXNKogH3PvsT6EfH0rMSCWnu28qKQXx8zpVtJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877885; c=relaxed/simple;
	bh=CkHKfHecGorTp9N5BTWAWpswkW4Sh1icE5PKbKW8th8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moPy2nY/Tx59guJF3k/2OrmTYB62/AhjL99uTegljvApjwX9/6Rtu4L11rTWaW3oQivKrOKfZfTpPHuqZi6SDtXKs1YUjmv9rKIBLPbOa9Y4hwgKFyVxVZq6XjKeNDQcWWr4aw25ddXaIBWdAWPdq6JizyMZAKTj1KHZZCe7C4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oJVR6y0/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k8VHQy0N; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oJVR6y0/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k8VHQy0N"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D974B11400AF;
	Tue, 28 May 2024 02:31:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 28 May 2024 02:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877882; x=1716964282; bh=UBd586fuFL
	siuMknaZkUi5d9i4IYO1TZEFA9oIyVcQU=; b=oJVR6y0/uW7dYGuQtQdyTDp0KL
	iiOrGhzjdehMY4u0ltGumymo/WWRXV5s9sIB+XJbWbhtFhu7x5eEolgvzGZReUgA
	ya2OXATPO93SkexG3DibXD2R+4a2f63aYXTEPeXktVYpFO2NUFkSfrQOHNHS0JtM
	IQGz/7xtiNnPBavWH6EppbyB7ZF3Wf6xp8gNIv8A3Qkn6b7uJ0+fPjTjM3oxHeh8
	AJ6Ynoa9WGUb2uIaNYe1khwR3s3b48IfL/F+qPv+oi7KVxERQ09EQjV1nZBH91Zp
	B+30vV0gO64dSm5/xenIjnizrBamLUZgoERnJKzfSmdESrafpABtdnrV8C0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877882; x=1716964282; bh=UBd586fuFLsiuMknaZkUi5d9i4IY
	O1TZEFA9oIyVcQU=; b=k8VHQy0NW6STldyHdF3fk4zm/5svTmKevcTupZMAGbch
	7lsewZNN4aie8GkPiM9FlqCgfaylFPpf61eXscnZRZh547DSN7LDL5qUry21YoT/
	c3c6tqBcuQ6VEA5hEkzEWEUsoohFDIujmSvcqTVkmrA/MQsfYYIIx2OZdorFB7Xa
	McfAq4AFL+2plqCLuz4LMxdpkbKK2bqKpsptCK/8ni7qqJ3y4hV5uL5r3J+9OhBD
	08yAObsX7jDQzEUtd4TyxG8iDDXB4/lwi3FTYNd53LczXb3vRzXPjnYHjtdIgyyF
	3E07UzL7aiGlLwRIfaIBVNIRJ5OUKp3aUFPsjOThXw==
X-ME-Sender: <xms:OnpVZiuM1NLsY7JWsLGOVKohvXfE8J0tjvZBkK4AUxt3vo8a5K8-5g>
    <xme:OnpVZndsCITKtQYZjKmi0yC29ZTkOpXIMDUU0UanZk3pQqYobAE8RN5OFcBvHIxHX
    1btFWfL4pn77D8V6w>
X-ME-Received: <xmr:OnpVZtxwHfDkKsRABZGdjeDSTWaL7zuEnBSCJ0lgYSPeTo82s39cIgWhaLPgWtW9ADbnUI5OCnT5P_V5UAAlFq_LocA4IWPdP3YbbHg2t9Mewjrj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:OnpVZtMhoseqm5E_vshv-QoHvPsxDFFHb0Kyg9pNcVLcsxqw94UwBA>
    <xmx:OnpVZi-9Mw9ZHN_NK_M5__kxM4QWxAPp0H6IuFhQoqBY59jhSJem4Q>
    <xmx:OnpVZlVjOp9Q0p7YMYRMCogelZNyUCbn9177HFbizkCALJBAAi7GZg>
    <xmx:OnpVZrc6FPypW3x2gtkJD1KvDVAndh7UDvdHzemHVKLiMGJPnyMN0w>
    <xmx:OnpVZplaQ3n3lEZ82C2GEk6dnII1q9r06ptpjWTL5Vai73-P8_mzl555>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:31:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 252152e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:10 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 02/12] refs: convert ref storage format to an enum
Message-ID: <7989e82dcd89c92f23de7ab4ebde96124aa6fe12.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jzOHRXYgPULHOZuY"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--jzOHRXYgPULHOZuY
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
2.45.1.246.gb9cfe4845c.dirty


--jzOHRXYgPULHOZuY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVejYACgkQVbJhu7ck
PpTioA/8CKopJ0Xe3cuFz7MpoPt6AedAApRmjYMoejpXZZH3HDxMVxza4GLskPDA
isird/0jljY8dF5Gq88jBrZ4VB0FCPyNZ706CGVdST+CywXJNVK5oBvxgVlLKgsc
qjm2XNiUpfzfKhvDXmjendKNpLVdAQvGWZNas/CF2sd3KqmAEeGeIZJVjKAJJ3HZ
tus6tLsu4Rw4ibvTOi38CNvBoOWK3AjhWP6ZVZe515VF2OR7gTKkYSrvZU3MxXtZ
Liu12d//FAfUmFwcgH7F+/JUUCSEuwsn9ieRLy8qoRNkB6tWmxVbTx9wuMaS9Ht1
uc1toXfQgZfAA8oIboJ/8QOfA8rjf/Sdfo/Y2TF9SFJIpzB4FnBAIMxHejTofUul
VcwcgoiX7qW4QxjIaiG/CDB9BY0K4DsmVNA6M5VW9PWsWvF4ggF2OUcb5mJcbMTK
2rPfKluFZz2quv4PN47CtpdxIDwFYYiYIy2Ihd6fLCTbjjLhRu2hykQRPku8NVHI
45631HvFnAfRowrAojkkjtwniqCLd80iJObYdGi+LqG9Tx7yN2zaYmJVaahLxD6l
z/TuoJvCGdMljSTEmVj84rGNvx3Hy6whyIPmwOEZnl66TOiCjVbj5ESp/DSrqDMm
ZRJ8sbGx0BflV2+gIHGZdXvhbsBGPdj03nxfLV9hbAZ9d7VnrEQ=
=tcXC
-----END PGP SIGNATURE-----

--jzOHRXYgPULHOZuY--
