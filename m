Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9B13CABA
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452728; cv=none; b=C2K95meXoSxPQMcSR71/MgjMSoke2A0Y/KDPJTSg6XPXnO9Els++tXLoipip8LvSnNMcRoGJhUXDQPsSdXCXMlHJCAYNnivaCQw1aNXzhMnNCt1eNX78/W/OhSZtc0e2u1DtWjeO5rZMPXRNPWpAs2cCx2u3GhD5Yfg86qUD9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452728; c=relaxed/simple;
	bh=vfecyi3rOmfsxP87EWpCIWImPcV1j9tGyCvxRynzsTs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIVVuM4IxqvDRw96DjmaPqDIARaD9acOz4Hx43vETA+zDpW1RoShSKy0nRB/KPbVxiEkJ1bH4Z9TSVyT/AuSLC9x23mNp3rcOQQ3WXmxfq1UO/Acf1LKNL2u5JZcdJBfJJuUhLL/kQFn3V+/1xSzeYMtYI74YTK3JAJoxeNxcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TOWkHqGm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oky1W1zG; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TOWkHqGm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oky1W1zG"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0B55F18000C8
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:25:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 May 2024 04:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716452725; x=1716539125; bh=cEVwiD6u6v
	XQmB1VSsUiTBiETpcyi/ihg6hwM8/JqiY=; b=TOWkHqGmSlhvQiXkhi9Q1t/5KQ
	FTsbJ0iVi3iLm6N1V3StcdQ3fRC8xLXHCjAyBtHuP8RwQg+DaudbA6+WN0hJfjqv
	x68SwniLHcnHMzRPOtPbS4Ys9UddXHlMapuTA+JmQ9i899KT+hxcHw8jkOPJMurn
	d4APeZoDWJi6sApKAO7lov9KsBvZJTPZAL+3cfILxMs1QDoWzguv3j4Z9Ck4rqhy
	NKw+SMHQkee3cZjDg1Z8mVrmzUjuy8z6pxzZy7adU1HV6LfAqcIWkG7Kry4Howuu
	Jbqi/+0ECCIjDs/aCV+ZuIjFAxydgNeDl4vnpTSAw3CD/RFur/Lxj70KEA4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716452725; x=1716539125; bh=cEVwiD6u6vXQmB1VSsUiTBiETpcy
	i/ihg6hwM8/JqiY=; b=Oky1W1zG0AFZdLZgJR7XEuQLcl9DO7QrdoVRCEqW4sez
	ZKCiHAu0K58GDH7Nv9gXf4Ot0YvcLZU5J5XYTu3NoAJfZQfKhxVkIqHzxjkYW69b
	GRnwvo9rGIC56yfMJmIfKZ7JizY0nNFIE0UPrNbvv6iPvDxQDPT9znizX3kBts3+
	jjrQZuDdAnzUSkOk4dCLIg3yjsS6qxWvGiD4lJoduHX0ISM7MVqjaJ88t8DiTC7X
	1nzJzztToIXQIeMfsy1w86zRy1IOUUtLMr6BAuVQI1YiCLvA0LXOJL7UjmcUdhbT
	Kd5OEUSXV3EJxUpOee5PxXWbupM/53sxvKpmwQ3QNg==
X-ME-Sender: <xms:df1OZnx0zoPjugpjcfCAg3pn8bWv-rdxGDuhVr1Vr2D_bm_2j8APqA>
    <xme:df1OZvQc1c0o9SQSM6d_Xk5biywyukePKs7UGD-JQ1AQIE0wpbOTVUxCbVLLam3Bq
    k7yhWKlDlNEgh8mTQ>
X-ME-Received: <xmr:df1OZhXkEFz65GHTXVzxH-EfSt3KfHJqyfhCC_uE9GXcUXaIQegX6_dMHq6L9MIT2zGhUQMyIIkDvyjkES3bEER760qL94Fv6RFjCnETVqTjv87GYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:df1OZhhnWx4Fqh40B7SjdzOLuhYCkugCrAoCcK2CaLQ_rw6K-hdSVQ>
    <xmx:df1OZpA57iEqk_w3i27bEiDVzlPQMPIOqC5I53dk-p9YxMh4fcK_fQ>
    <xmx:df1OZqJ-zOvXD-uV6FLMHOoVJENgs9G1TboFjS4FRvrZrxhnM27TYg>
    <xmx:df1OZoAIzcsU_8_i1MFAUTa4fuEoUbkFehYDt4iY7WKoCJe7wl_XOA>
    <xmx:df1OZm49n5iXtTCbFuofsPJMDvyXqGbis0FyJpum13sMy8zTiz2ZzJuw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 04:25:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ad475804 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 08:25:18 +0000 (UTC)
Date: Thu, 23 May 2024 10:25:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/9] refs: convert ref storage format to an enum
Message-ID: <25f740f395b469ce410fc708ed90bf4e2516ec69.1716451672.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NP3ddDo4gXa13zW0"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--NP3ddDo4gXa13zW0
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
2.45.1.216.g4365c6fcf9.dirty


--NP3ddDo4gXa13zW0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO/XEACgkQVbJhu7ck
PpRsKg/8CdIGt4KPwMi4oNrI2h6vPWBHVu795Br0vRUJivW64Dop1yBq50ZGRj5k
ybyZNjmnLAjQOYYj3J9FQsCGx2covr6o+7esEd97DbwhpLKzerdTdHHt99DfBmNA
wJ+buNKodjS+Rklopotwgemcx3MmMh8Z2GG9rRXUap5lG2bBSjuEyizRmHDvAkZY
+eNbq6+tOYNebv9KFs75WUzRKpxCkQVv3yeC6vM9DUjQozqr77q8djJsJW0BSSHi
T0Q+81Twkr20ZkfeqS6KuJRSH7kwHTAWEF8rOtaTQtuzttFS3Ed2WuDrJWvaiey8
fFAmGk/zfE+bS4IR3KvWl+L3SsD/I++Dlz7gmV4R9wpOo42CkrpLm641TwZHisMa
sjr+JwG4npQnBqCAFkJI6ySqJxieRHm9BBJENA4NFG+KxB2FF0DPQdxBnn32VvZE
UyXWJ1+AalKeSKkDO2yrJaafIzK977VSlHgmxGikNA5GQD8DfZq91DwHoB9LfGSE
wN2XgAsaB+uN+KNdJ6U3zRZpZcSLLEvDsWZwOqctkEAhvoTdUHH+Kn05yZRjcOMX
3da3ueZlHWNpldZGDgNdHC7CcZy3RRmsgWQ7FD9uapEY0r8K6C8b+cfsbSyxn94Q
kId0XcVjs8l2JDqDfp16cRNi1oC4RvnEidoY7ZBvnqICkn4VZ50=
=Dc4s
-----END PGP SIGNATURE-----

--NP3ddDo4gXa13zW0--
