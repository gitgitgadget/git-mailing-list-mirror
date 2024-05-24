Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897BD2B9BE
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545681; cv=none; b=oaq5CJKJeUo66+3raVll38Ennl5LI2itdH8YOewgsV32gDuGuWV/GsMqC+rdfQP0f4OX1wzPvZqGVuRAJlHkLrbpVwVEcqTqydlu8OykYMAqrilcL6P2/6oapwKvl5Mm1g1DDBKid4pU6ZxfVYTvBtBk40/Ryz6P09dqtqVmGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545681; c=relaxed/simple;
	bh=sCstjH5bhG2vuUAPy1Ux4/i1gmNPGR2iqMQ4CQs+4YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7uYjugIRpkKku7SbGTRewEPiVArYp63zDwuyNIhg/DD+XWVdycJi3XFKvJF5nnuywABw6kVihiYAgOjaU5YVDa8VWhFRNM42vGERJDq2UQy5sX9hxxTYMd7A/GIUQDU404kfytyRlvNsqLrIwo/vbNGTqCVzhDOW/u3njfFYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dt2B2oCA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDN2QEOT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dt2B2oCA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDN2QEOT"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 99AAD114012B;
	Fri, 24 May 2024 06:14:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 May 2024 06:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545678; x=1716632078; bh=DSI2uEoRqK
	21j+mR6gAyV2zejo43W3AiVpunrkwMEbQ=; b=dt2B2oCAFrzkqRkxLdWA2Ke+nn
	Uo4GA4k8rY7/QrWSL3hw7+aMu1CaO37JiMYcLQNWDSSEFQF00Bka2CYcxjRTp2e3
	qAhGsy9JPyFgps1iYlMENjtvroKpnSWh1NbjWsT7olkr7Sz/Kd+UH7EklZdaw8dH
	NRD/wBYIMM8TtN0gkFhqINRsE298+MmflSv7DYIqe99kDJlW5q/9CvQjUrIHKq71
	k9MaEzz0nBBlIIch9OdVgftieQz51o8jWZhwAWw7M8yEdBOQNXSbF7Ig8bHhVJEe
	jSWUBq5E8LrByKhjPqEbtFMlW5RlVripZy+v1ZhN71/+ddZroQ65BPFgL7tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545678; x=1716632078; bh=DSI2uEoRqK21j+mR6gAyV2zejo43
	W3AiVpunrkwMEbQ=; b=QDN2QEOTFgnGGLFZXe2OywMjarto66SGmLuO2PbqaxcA
	l7DvyGvjqK+h8tfMO0mnVB02ce5S8Wjp6VFX1oPv1nSJd0/J8g3uiV8ekCp3d7qN
	JoOIRAeNZ7DXdm0ZESWsPHHZSS58JBHHPlo6fJoFuWdsPQCSf58GT13HY1jSEw40
	7pU/mspyoCoSBjboKHQqaNkNSFU97WfZbrfm+npbOoWkXBaRo4vZxnIrpTzMW69v
	3ESfsVBNViXKYxsJRPTjnnc3+D292Iqj8fZuWffCj/DRcQbL1WPycSoOvPagJdh5
	imkNEDNE70bynI3vpDBM/RPqaHnjgMUTqWtunIVJ8g==
X-ME-Sender: <xms:jmhQZuXtnnoSX0AM7aA0rNiItQAzMa2X1uppnbrMk6iBynsVoybNdg>
    <xme:jmhQZqkkeSyuTvUOczpj84uM-YKS8yMbCIsdbTfw_VTl1fzfsrSU3SECPOKnJBQLY
    9OMdj8mLywlBiO8KQ>
X-ME-Received: <xmr:jmhQZibKsBdhOKR-QnlWjBIVB7HI-kQZwBxkq-VKbuvAunsMOBsm660WYKhUfAgyX0ofF1QFKJAPI8hMsJTji6dPpGeTFS3Haz_b2LweLyyAEQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:jmhQZlWiz394X-Q0O7kST3kPrTfukNefAPsgBx37_JN8JOAG7XPffA>
    <xmx:jmhQZolA4I9_zqhpiuC4nRtB--1kDaEkoy4yFHz5t50RTFISCoq5hA>
    <xmx:jmhQZqcsqYmNwVdYn5NcLTsiHlKCYiGngjkF_3n_VOlT3h599XHRrQ>
    <xmx:jmhQZqGetwn3YeIL7vZ2HR7QYuNrl0sJiS0zIjqdAXyODXabZcQ6NQ>
    <xmx:jmhQZijgVeTgN44ds_jMpmnDNrbuon8-mi9bTYvkHCpZb5pgMfquGoJG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:14:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7835f357 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:14:34 +0000 (UTC)
Date: Fri, 24 May 2024 12:14:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/9] refs: convert ref storage format to an enum
Message-ID: <25f740f395b469ce410fc708ed90bf4e2516ec69.1716545235.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sR4FzGTgM4yXoIsH"
Content-Disposition: inline
In-Reply-To: <cover.1716545235.git.ps@pks.im>


--sR4FzGTgM4yXoIsH
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


--sR4FzGTgM4yXoIsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaIoACgkQVbJhu7ck
PpRgmQ/+NZtXWe9rtlDkrCNkHujyzT5vJ3mfybxXN5kFynIEFfXhmRiwehrD0w7w
ZLzktjle8ENS/x1ia4pYnIEjwIMxFiuWNWKZwZ1o1a7G5iK7BJoXx5quqMuhAfEG
+CcIj8QdORM8d8E5tBdLoo1ChcBY3FktPA3dfvAjfqqmeKjxQnPeDpGyWanu4+cG
fkezJtjiLhdDZEM1tGRi+LZJf9Mw8XxN5el9i6QM1/3xU8h9DL4Zz3GGwk6Obz6G
hLtHgarnXOuWJoMEWPlVEYmXbDg8fhORbQhW4D83tc4fXn9riaYH6HGl95qRGZ4r
JO6g5dG+Sq+gryd93pwZt2QOkN3d7PRZEP2UtNcFMorisdn+Gskvxbt0ISUe+FZr
MXSd8HCp0+/1m5oS80IRVTwe6Cl6LNqyStsVv+ATtl1igaJK+fYvi/SHS2/nDPfD
JnCqZpQP6tKfDSX0wTQ++tu4kfmnFG9irOz+49aYuW5F/cKzCfuEgXaHbZXsABBF
UlLIswuFu/Jl546cMBABeFGuajRT312sT5e5euA72VTSwo+DeLNiMujePwawHl3o
MnGOCH99Qv5Aq+sInSqwKd1kCIWQwdvhF4rgYl96qxojg0O//TMawDWwi6keqCc+
q0xSO+W3yXXTwcEsYvwG+EhzhLzL0pV7E6O9FGL/LXBwxovOce4=
=zUIc
-----END PGP SIGNATURE-----

--sR4FzGTgM4yXoIsH--
