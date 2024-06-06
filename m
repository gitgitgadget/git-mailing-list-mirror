Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965F37165
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651749; cv=none; b=OJD4UzzitH8Hr5WNiNYn+j1aQ3PiQ6mhhSM6tDUj6z4SaZVs6iMEi5KAe2LxeBHnaMGemP5Xswwe58yZJTBd/Q8D8reSmbW+Nan19Nf6ASzI14Fm/b2RIgK5qACGEt6uteNnx0DSrkBoDtXv+hY86IidWcVFchYM3fPZvsG68YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651749; c=relaxed/simple;
	bh=4mZ6dYhPboWNNR3zp51vV4n94sLfwBmUGcvQObk5/I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pog89pjeOWEwzHnzSWTQpYLpmQThiWwzT3/4kanJGYpvfVG7Fqyv+IhdmTCI5yynwdj7qpkp7brdXrxpQl5z6LWz0CZgaxFpFv38eF/Sm+69KbNXHDGSAllL1UE2etpUTJxjNFGFTrG1dRpKrOlBwTK39wX4mhKEqAtxBRDt7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U8Q80xpg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aYEUedfO; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U8Q80xpg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aYEUedfO"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id CBF851800196;
	Thu,  6 Jun 2024 01:29:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 01:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651746; x=1717738146; bh=dnOYK+t8m8
	yUHZU96a9PmpWMeg5XmeVJ/z1Y3a95+6A=; b=U8Q80xpgK0PWLzrWX/aZ+vQxxB
	WLBsDma0OyrZCFODU83IndVtI2wOHqVAXoGrdJVagI8p5TQ1JNbMfC1m1NL9CaSW
	GpWJyqvSwCLgUpgtNPcILfapq7Za6KcXv9ODTw+uiMPXT7nT0VehaxZcYpcqcRFh
	M7z7QvoJ5UZS0AOqutn8jaTOcYfwh0bF9lp08KDEimgZWPB69sPcWyMRloQriNoS
	grFPWvuethZSit8nHA0PusJcjbzN/eMAqqn7HoPY6wuXSRS5fvu4QkUTnXq0U7LU
	LjRMsOtsoO+TOhQEj6elG6SC7N8mamalbYmhFxJJSfYC4Wt0XTQesPVzm2/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651746; x=1717738146; bh=dnOYK+t8m8yUHZU96a9PmpWMeg5X
	meVJ/z1Y3a95+6A=; b=aYEUedfOJ4idaDdqGGLiMA0AKDsfY+OTpL145M0WBSjD
	Vvb6ieH29G2TzqM/JNA3OesrkFowZrsbDBLoQZdOdn79HXWSeI39amD1L9lM3g/i
	Pq5VonFNnzVgfZ/f4YtPF2NdldEYRZJVSLFzT1iXiP9IyjYuWxqi/ayRPx4gk6ZR
	fErywzMdvXRgPOLy6BG467uwnh2gMntEfEj0krqk0FwqwUb/02f3ZAFg5+h5TxxB
	j3jL4D6yw6uudQgEA0JejwCbqJWZBOPcHmpcC5Uma0FO2seq8vZSj6SceVxn1/im
	xpaPrevka97pAywzTsgCXSzKtmfn/qOCy6txp6F/HA==
X-ME-Sender: <xms:IklhZiLouLdN2KMYFwr0pSZNIGaY3U009kY-eEyVLVRfdnkbvyK8Xg>
    <xme:IklhZqJ-lx2TZD3bMgPYKl7-b1K7VfVXJk2k1AolwmupES55D4V37rwJTjOtCaj7V
    4vLwjoBnPMT-tSdNg>
X-ME-Received: <xmr:IklhZivP_uW-AkyQr51Gj9QYHF7RokiYjOL_BtGVgYMPp5vTxyEDcgoVu7D-rZG9dRj_ABeo34R86wMeao7b3kEoAbioV8LR2QewpexL9fxvT53y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IklhZnZDJmbi_0xrivfGv2UKOBK--qJ_5gFhFZB7MpyJFi3NOwAMdA>
    <xmx:IklhZpaB8p_HWuSaE8qy-bnNn9gI8BTaWW9vKGMGqeosTaX6Auvdsw>
    <xmx:IklhZjCN3AV4lcd2usFmGTDvlB9rqSaqbjcIxWyG16bthJe-Jv0syQ>
    <xmx:IklhZvbOnuAHRO-pOdnT5ZKE5aP-Bv0Mo-oHOgxCeeLFfyJ6Pde4CQ>
    <xmx:IklhZl71RcbrFEPM--ODY0O7CptSXFosbXNogPbYWqKUp7bEy3uGOU_K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e145832b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:28:34 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 02/12] refs: convert ref storage format to an enum
Message-ID: <7989e82dcd89c92f23de7ab4ebde96124aa6fe12.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vrXKZTxBshynQ037"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--vrXKZTxBshynQ037
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
2.45.2.409.g7b0defb391.dirty


--vrXKZTxBshynQ037
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSR0ACgkQVbJhu7ck
PpQTiA/+MZzsKk/H6F1/ex1HiSUwNCVf6akdr+9Wo0xiRUKOJa+uBKDrMy/8PyzL
4vMKUC1zTdaFDd+KrnAazzvexKAa9kXKXSfBwwtTJkSfKr4k25h620GsXF38N6zS
vrbbb1TDNmu0opaiQpPQd2nLvhEy7jDcKMCF1efbqftrxZUhNwPvXfCfxAuNLMI7
8Y24q/t7vPbh3pEQbKmNjMTD9C3vtLGRJuR/6pB9TsZfsylx6BhhmYnHAAq7BOah
ksMtjpUziFaHeVkutGWkYEsEbkhkl5pp9Qk+dzr8WI2Dmri097HcklsGKsi81HwE
d14qRdOmhs3Jr+LdzvMYhsGSi700HaCOTVBVPIZsz8j8vaf+EZuXBEfrFp1In/A+
ifVpmEGZZ/l+N/7wmTIeq88gaI+EE64cGbiwHcJYbSiDyeADOexSeToWWNZEQQgU
+h7l5WuWHn7HXxSz+jdrRJjkHnZvT8sXkNE+8rkWfmG/1aMVe2U7FBHWZHTb6BRg
1fupr/BbIuHncwJfoTTcsAcRqg1phQbD/qd7k+7FmKQT0I2IpMyOeJUMXUNDxeM2
zsQ6oyXP9++G3IEMl1L0HBvlWX7D2kMmKzk/iqifY26WEjU862dEdiVUglt1bZVk
6udkNzkBNYlid744sVn04VF5VOKyk4e64hpvwV8gROhsUl3eanw=
=YFiR
-----END PGP SIGNATURE-----

--vrXKZTxBshynQ037--
