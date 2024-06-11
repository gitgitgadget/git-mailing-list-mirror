Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E53176ACD
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097606; cv=none; b=ZRGmVx7ousLyLVxBJMC3WPMgPi213WtvubYYCrqvf9UEU1vVzAvHC9CmwWnaf26Ti7Q2nnPowYiQrOafNJyGu2h33lOm4WUSROMuXSwDJYphU0uT6gnymsBytYDuUdp9cRNy195iwApLeAOhMh7NMYlFbPpuqyLOuzf5NLj+m9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097606; c=relaxed/simple;
	bh=FYNB0wgs/2NowNHUyWJ7xPDfi37in0ujRqrt51KFjPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOHIo+84CBxn6zIu4c7YAQt54tJFCl6FL8KuC/hvHw0veOKBicG5v9dJArACr6nCchxoVH4ung9YKT3q7TQBQMoyGJeRKZt3bhkikjtzqoT/EeB05Lh3TvtZ75dItwAn+8jUSrmESVNzQLbM7FYDEjXIXfPq8Z8EQFSMDYaSGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LmXrjkYW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cr87MYl1; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LmXrjkYW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cr87MYl1"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6A8BE1800115;
	Tue, 11 Jun 2024 05:20:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 05:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097603; x=1718184003; bh=EG8nePZiLt
	SsyI4EZrCN7EEt2JB81hNk+RK447HpYbY=; b=LmXrjkYWcY5QaZpXW5/mCzkVd7
	FPk5Y5WeBJYcJ0RWjCKr9P7vqMuXpEwjsnS5j5NU1WLhV1V3RTPZ/zddaLzWP7IU
	aA741jjr8XTuATH/x+75Utq1yzX6wg7BHTDexyaOfUmXEh+rYwJ1EGyK5JmyHU25
	Jb232Q3lBhcXGflaBUm/GlbkQKEZvjrL8ca9obW1o3ywn6mtBX9p0JT9Wg24pPc2
	iQIbHXtOt4x3xdMUyBieGl7yyEUHRiFAboWBi9MPDCEwxf1UmiFGR19CncNHgy/9
	bzzn7iBvp7ffRe3SBlwbbuhk+WjV7+9Aih65ORoWFxwNLkPO2AHis0LVBq0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097603; x=1718184003; bh=EG8nePZiLtSsyI4EZrCN7EEt2JB8
	1hNk+RK447HpYbY=; b=cr87MYl16eDVpJvVENoT8TuXoiJPnq3J2siWd0qCJKw8
	0eYXp8KVu8hATZKYS4bwoT9gvkwgcz5Chu9k9rCdB+y03ZdDfsq6cUgVnEIQUNAh
	ntWJ3H3/A5wLNWn0AL9PNPnAsW3oE3/Xuh94Q4McYXwu//ykd5Uk7IJ6gdJ18HiI
	R9uA2p/h864y6e3LMLseVAEnI2UI3M0HFfTbC4JW7xCocU4MVSxXBnvYlPTAgqqV
	NHETGBuIelwoAdOcSLGXRHZn+LQ73FcYGRQBgNbmNlCCkksfxpLSjnSJ6uyPUDbX
	XAKmfLvIMjYavdowZostChmD1jOBX3eRySMzwFN9MA==
X-ME-Sender: <xms:whZoZu98byxTI4wxj5pPXaYMMgFROBqQlGUQckUgP_ixO17vtLEjDA>
    <xme:whZoZusHAcxRd_d-1-crauDo--_2c_c1Eh-WbaZwCwjH4CxjTcU9jBREwyertf5qX
    urNUcaztytogjF26w>
X-ME-Received: <xmr:whZoZkDZkddvGSUEOUru6kXNlRswCSSfZZoW15fEP8m2RH-xBcWLgrxIOT_XDq6cdL9nGHL212MUD4dibvNUoGcfxja2HNxvnKD4eq5vJFnzmqInakxn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:whZoZmdsLN7LSXQ4u0udC9hyyEtxw4Vo3DqryCsNKE8bDphrBuPz4A>
    <xmx:whZoZjN2hv_olzEMfpGEJRbR7IYCaQRIAmhEv7IUffPoGHWLR_xL4g>
    <xmx:whZoZgnCXEyf0RHDhft8UpEjA9JHep-haAkkHOhZuXoY61goKelkxw>
    <xmx:whZoZltFvPq2OW5nG5On4vJ5jXhkHfRkx9uoaPIL7FOmNAvhRSvrYA>
    <xmx:wxZoZsr_bfydE0z_CkGLk6gghi3DVTBoEa0GHYVIrrvWGkl7ioyW04cW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 101446a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:53 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 10/29] object-name: free leaking object contexts
Message-ID: <bdb738932856b8d8e3847471e515253f61d9d711.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wd7mZhcgLe12Xu3S"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--wd7mZhcgLe12Xu3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While it is documented in `struct object_context::path` that this
variable needs to be released by the caller, this fact is rather easy to
miss given that we do not ever provide a function to release the object
context. And of course, while some callers dutifully release the path,
many others don't.

Introduce a new `object_context_release()` function that releases the
path. Convert callsites that used to free the path to use that new
function and add missing calls to callsites that were leaking memory.
Refactor those callsites as required to have a single return path, only.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c               | 17 ++++++----
 builtin/grep.c                   |  4 +--
 builtin/log.c                    |  6 ++--
 builtin/ls-tree.c                |  3 +-
 builtin/rev-parse.c              |  2 ++
 builtin/stash.c                  | 12 +++++--
 list-objects-filter.c            |  2 ++
 object-name.c                    | 40 ++++++++++++++++-------
 object-name.h                    |  2 ++
 revision.c                       | 55 ++++++++++++++++++++------------
 t/t7012-skip-worktree-writing.sh |  1 +
 11 files changed, 97 insertions(+), 47 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 43a1d7ac49..18fe58d6b8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -102,7 +102,7 @@ static int cat_one_file(int opt, const char *exp_type, =
const char *obj_name,
 	enum object_type type;
 	char *buf;
 	unsigned long size;
-	struct object_context obj_context;
+	struct object_context obj_context =3D {0};
 	struct object_info oi =3D OBJECT_INFO_INIT;
 	struct strbuf sb =3D STRBUF_INIT;
 	unsigned flags =3D OBJECT_INFO_LOOKUP_REPLACE;
@@ -163,7 +163,8 @@ static int cat_one_file(int opt, const char *exp_type, =
const char *obj_name,
 		goto cleanup;
=20
 	case 'e':
-		return !repo_has_object_file(the_repository, &oid);
+		ret =3D !repo_has_object_file(the_repository, &oid);
+		goto cleanup;
=20
 	case 'w':
=20
@@ -268,7 +269,7 @@ static int cat_one_file(int opt, const char *exp_type, =
const char *obj_name,
 	ret =3D 0;
 cleanup:
 	free(buf);
-	free(obj_context.path);
+	object_context_release(&obj_context);
 	return ret;
 }
=20
@@ -520,7 +521,7 @@ static void batch_one_object(const char *obj_name,
 			     struct batch_options *opt,
 			     struct expand_data *data)
 {
-	struct object_context ctx;
+	struct object_context ctx =3D {0};
 	int flags =3D
 		GET_OID_HASH_ANY |
 		(opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0);
@@ -557,7 +558,8 @@ static void batch_one_object(const char *obj_name,
 			break;
 		}
 		fflush(stdout);
-		return;
+
+		goto out;
 	}
=20
 	if (ctx.mode =3D=3D 0) {
@@ -565,10 +567,13 @@ static void batch_one_object(const char *obj_name,
 		       (uintmax_t)ctx.symlink_path.len,
 		       opt->output_delim, ctx.symlink_path.buf, opt->output_delim);
 		fflush(stdout);
-		return;
+		goto out;
 	}
=20
 	batch_object_write(obj_name, scratch, opt, data, NULL, 0);
+
+out:
+	object_context_release(&ctx);
 }
=20
 struct object_cb_data {
diff --git a/builtin/grep.c b/builtin/grep.c
index 5777ba82a9..dfc3c3e8bd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1114,7 +1114,7 @@ int cmd_grep(int argc, const char **argv, const char =
*prefix)
 	for (i =3D 0; i < argc; i++) {
 		const char *arg =3D argv[i];
 		struct object_id oid;
-		struct object_context oc;
+		struct object_context oc =3D {0};
 		struct object *object;
=20
 		if (!strcmp(arg, "--")) {
@@ -1140,7 +1140,7 @@ int cmd_grep(int argc, const char **argv, const char =
*prefix)
 		if (!seen_dashdash)
 			verify_non_filename(prefix, arg);
 		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
-		free(oc.path);
+		object_context_release(&oc);
 	}
=20
 	/*
diff --git a/builtin/log.c b/builtin/log.c
index 4e4b645a21..37ecb3ff8b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -682,7 +682,7 @@ static void show_tagger(const char *buf, struct rev_inf=
o *rev)
 static int show_blob_object(const struct object_id *oid, struct rev_info *=
rev, const char *obj_name)
 {
 	struct object_id oidc;
-	struct object_context obj_context;
+	struct object_context obj_context =3D {0};
 	char *buf;
 	unsigned long size;
=20
@@ -698,7 +698,7 @@ static int show_blob_object(const struct object_id *oid=
, struct rev_info *rev, c
 	if (!obj_context.path ||
 	    !textconv_object(the_repository, obj_context.path,
 			     obj_context.mode, &oidc, 1, &buf, &size)) {
-		free(obj_context.path);
+		object_context_release(&obj_context);
 		return stream_blob_to_fd(1, oid, NULL, 0);
 	}
=20
@@ -706,7 +706,7 @@ static int show_blob_object(const struct object_id *oid=
, struct rev_info *rev, c
 		die(_("git show %s: bad file"), obj_name);
=20
 	write_or_die(1, buf, size);
-	free(obj_context.path);
+	object_context_release(&obj_context);
 	return 0;
 }
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7bf84b235c..bf372c67d7 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -367,7 +367,7 @@ int cmd_ls_tree(int argc, const char **argv, const char=
 *prefix)
 		OPT_END()
 	};
 	struct ls_tree_cmdmode_to_fmt *m2f =3D ls_tree_cmdmode_format;
-	struct object_context obj_context;
+	struct object_context obj_context =3D {0};
 	int ret;
=20
 	git_config(git_default_config, NULL);
@@ -441,5 +441,6 @@ int cmd_ls_tree(int argc, const char **argv, const char=
 *prefix)
=20
 	ret =3D !!read_tree(the_repository, tree, &options.pathspec, fn, &options=
);
 	clear_pathspec(&options.pathspec);
+	object_context_release(&obj_context);
 	return ret;
 }
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ab8a8f3b0e..2e64f5bda7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1128,6 +1128,7 @@ int cmd_rev_parse(int argc, const char **argv, const =
char *prefix)
 		}
 		if (!get_oid_with_context(the_repository, name,
 					  flags, &oid, &unused)) {
+			object_context_release(&unused);
 			if (output_algo)
 				repo_oid_to_algop(the_repository, &oid,
 						  output_algo, &oid);
@@ -1137,6 +1138,7 @@ int cmd_rev_parse(int argc, const char **argv, const =
char *prefix)
 				show_rev(type, &oid, name);
 			continue;
 		}
+		object_context_release(&unused);
 		if (verify)
 			die_no_single_rev(quiet);
 		if (has_dashdash)
diff --git a/builtin/stash.c b/builtin/stash.c
index 7859bc0866..628d848a0b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1018,13 +1018,14 @@ static int store_stash(int argc, const char **argv,=
 const char *prefix)
 	int quiet =3D 0;
 	const char *stash_msg =3D NULL;
 	struct object_id obj;
-	struct object_context dummy;
+	struct object_context dummy =3D {0};
 	struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("be quiet")),
 		OPT_STRING('m', "message", &stash_msg, "message",
 			   N_("stash message")),
 		OPT_END()
 	};
+	int ret;
=20
 	argc =3D parse_options(argc, argv, prefix, options,
 			     git_stash_store_usage,
@@ -1043,10 +1044,15 @@ static int store_stash(int argc, const char **argv,=
 const char *prefix)
 		if (!quiet)
 			fprintf_ln(stderr, _("Cannot update %s with %s"),
 					     ref_stash, argv[0]);
-		return -1;
+		ret =3D -1;
+		goto out;
 	}
=20
-	return do_store_stash(&obj, stash_msg, quiet);
+	ret =3D do_store_stash(&obj, stash_msg, quiet);
+
+out:
+	object_context_release(&dummy);
+	return ret;
 }
=20
 static void add_pathspecs(struct strvec *args,
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 4346f8da45..c95ec3509a 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -542,6 +542,8 @@ static void filter_sparse_oid__init(
 	filter->filter_data =3D d;
 	filter->filter_object_fn =3D filter_sparse;
 	filter->free_fn =3D filter_sparse_free;
+
+	object_context_release(&oc);
 }
=20
 /*
diff --git a/object-name.c b/object-name.c
index 523af6f64f..0471fafc98 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1757,6 +1757,11 @@ int strbuf_check_branch_ref(struct strbuf *sb, const=
 char *name)
 	return check_refname_format(sb->buf, 0);
 }
=20
+void object_context_release(struct object_context *ctx)
+{
+	free(ctx->path);
+}
+
 /*
  * This is like "get_oid_basic()", except it allows "object ID expressions=
",
  * notably "xyz^" for "parent of xyz"
@@ -1764,7 +1769,9 @@ int strbuf_check_branch_ref(struct strbuf *sb, const =
char *name)
 int repo_get_oid(struct repository *r, const char *name, struct object_id =
*oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(r, name, 0, oid, &unused);
+	int ret =3D get_oid_with_context(r, name, 0, oid, &unused);
+	object_context_release(&unused);
+	return ret;
 }
=20
 /*
@@ -1802,8 +1809,10 @@ int repo_get_oid_committish(struct repository *r,
 			    struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(r, name, GET_OID_COMMITTISH,
-				    oid, &unused);
+	int ret =3D get_oid_with_context(r, name, GET_OID_COMMITTISH,
+				       oid, &unused);
+	object_context_release(&unused);
+	return ret;
 }
=20
 int repo_get_oid_treeish(struct repository *r,
@@ -1811,8 +1820,10 @@ int repo_get_oid_treeish(struct repository *r,
 			 struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(r, name, GET_OID_TREEISH,
-				    oid, &unused);
+	int ret =3D get_oid_with_context(r, name, GET_OID_TREEISH,
+				       oid, &unused);
+	object_context_release(&unused);
+	return ret;
 }
=20
 int repo_get_oid_commit(struct repository *r,
@@ -1820,8 +1831,10 @@ int repo_get_oid_commit(struct repository *r,
 			struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(r, name, GET_OID_COMMIT,
-				    oid, &unused);
+	int ret =3D get_oid_with_context(r, name, GET_OID_COMMIT,
+				       oid, &unused);
+	object_context_release(&unused);
+	return ret;
 }
=20
 int repo_get_oid_tree(struct repository *r,
@@ -1829,8 +1842,10 @@ int repo_get_oid_tree(struct repository *r,
 		      struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(r, name, GET_OID_TREE,
-				    oid, &unused);
+	int ret =3D get_oid_with_context(r, name, GET_OID_TREE,
+				       oid, &unused);
+	object_context_release(&unused);
+	return ret;
 }
=20
 int repo_get_oid_blob(struct repository *r,
@@ -1838,8 +1853,10 @@ int repo_get_oid_blob(struct repository *r,
 		      struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(r, name, GET_OID_BLOB,
-				    oid, &unused);
+	int ret =3D get_oid_with_context(r, name, GET_OID_BLOB,
+				       oid, &unused);
+	object_context_release(&unused);
+	return ret;
 }
=20
 /* Must be called only when object_name:filename doesn't exist. */
@@ -2117,6 +2134,7 @@ void maybe_die_on_misspelt_object_name(struct reposit=
ory *r,
 	struct object_id oid;
 	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE | GET_OID_QUIETLY,
 			       prefix, &oid, &oc);
+	object_context_release(&oc);
 }
=20
 enum get_oid_result get_oid_with_context(struct repository *repo,
diff --git a/object-name.h b/object-name.h
index 064ddc97d1..8dba4a47a4 100644
--- a/object-name.h
+++ b/object-name.h
@@ -22,6 +22,8 @@ struct object_context {
 	char *path;
 };
=20
+void object_context_release(struct object_context *ctx);
+
 /*
  * Return an abbreviated sha1 unique within this repository's object datab=
ase.
  * The result will be at least `len` characters long, and will be NUL
diff --git a/revision.c b/revision.c
index 75e71bcaea..82c0aadb42 100644
--- a/revision.c
+++ b/revision.c
@@ -2130,30 +2130,26 @@ static int handle_dotdot(const char *arg,
 			 struct rev_info *revs, int flags,
 			 int cant_be_filename)
 {
-	struct object_context a_oc, b_oc;
+	struct object_context a_oc =3D {0}, b_oc =3D {0};
 	char *dotdot =3D strstr(arg, "..");
 	int ret;
=20
 	if (!dotdot)
 		return -1;
=20
-	memset(&a_oc, 0, sizeof(a_oc));
-	memset(&b_oc, 0, sizeof(b_oc));
-
 	*dotdot =3D '\0';
 	ret =3D handle_dotdot_1(arg, dotdot, revs, flags, cant_be_filename,
 			      &a_oc, &b_oc);
 	*dotdot =3D '.';
=20
-	free(a_oc.path);
-	free(b_oc.path);
-
+	object_context_release(&a_oc);
+	object_context_release(&b_oc);
 	return ret;
 }
=20
 static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, =
int flags, unsigned revarg_opt)
 {
-	struct object_context oc;
+	struct object_context oc =3D {0};
 	char *mark;
 	struct object *object;
 	struct object_id oid;
@@ -2161,6 +2157,7 @@ static int handle_revision_arg_1(const char *arg_, st=
ruct rev_info *revs, int fl
 	const char *arg =3D arg_;
 	int cant_be_filename =3D revarg_opt & REVARG_CANNOT_BE_FILENAME;
 	unsigned get_sha1_flags =3D GET_OID_RECORD_PATH;
+	int ret;
=20
 	flags =3D flags & UNINTERESTING ? flags | BOTTOM : flags & ~BOTTOM;
=20
@@ -2169,17 +2166,22 @@ static int handle_revision_arg_1(const char *arg_, =
struct rev_info *revs, int fl
 		 * Just ".."?  That is not a range but the
 		 * pathspec for the parent directory.
 		 */
-		return -1;
+		ret =3D -1;
+		goto out;
 	}
=20
-	if (!handle_dotdot(arg, revs, flags, revarg_opt))
-		return 0;
+	if (!handle_dotdot(arg, revs, flags, revarg_opt)) {
+		ret =3D 0;
+		goto out;
+	}
=20
 	mark =3D strstr(arg, "^@");
 	if (mark && !mark[2]) {
 		*mark =3D 0;
-		if (add_parents_only(revs, arg, flags, 0))
-			return 0;
+		if (add_parents_only(revs, arg, flags, 0)) {
+			ret =3D 0;
+			goto out;
+		}
 		*mark =3D '^';
 	}
 	mark =3D strstr(arg, "^!");
@@ -2194,8 +2196,10 @@ static int handle_revision_arg_1(const char *arg_, s=
truct rev_info *revs, int fl
=20
 		if (mark[2]) {
 			if (strtol_i(mark + 2, 10, &exclude_parent) ||
-			    exclude_parent < 1)
-				return -1;
+			    exclude_parent < 1) {
+				ret =3D -1;
+				goto out;
+			}
 		}
=20
 		*mark =3D 0;
@@ -2217,17 +2221,25 @@ static int handle_revision_arg_1(const char *arg_, =
struct rev_info *revs, int fl
 	 * should error out if we can't even get an oid, as
 	 * `--missing=3Dprint` should be able to report missing oids.
 	 */
-	if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, &oc))
-		return revs->ignore_missing ? 0 : -1;
+	if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, &oc)) {
+		ret =3D revs->ignore_missing ? 0 : -1;
+		goto out;
+	}
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object =3D get_reference(revs, arg, &oid, flags ^ local_flags);
-	if (!object)
-		return (revs->ignore_missing || revs->do_not_die_on_missing_objects) ? 0=
 : -1;
+	if (!object) {
+		ret =3D (revs->ignore_missing || revs->do_not_die_on_missing_objects) ? =
0 : -1;
+		goto out;
+	}
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
 	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
-	free(oc.path);
-	return 0;
+
+	ret =3D 0;
+
+out:
+	object_context_release(&oc);
+	return ret;
 }
=20
 int handle_revision_arg(const char *arg, struct rev_info *revs, int flags,=
 unsigned revarg_opt)
@@ -3062,6 +3074,7 @@ int setup_revisions(int argc, const char **argv, stru=
ct rev_info *revs, struct s
 			diagnose_missing_default(revs->def);
 		object =3D get_reference(revs, revs->def, &oid, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
+		object_context_release(&oc);
 	}
=20
 	/* Did the user ask for any diff output? Run the diff! */
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writi=
ng.sh
index cd5c20fe51..d984200c17 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'test worktree writing operations when skip-worktree is=
 used'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.45.2.436.gcd77e87115.dirty


--wd7mZhcgLe12Xu3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFr4ACgkQVbJhu7ck
PpT+xw/+Ne0eupnaUdVbVZjP3thMBK24jZ+DNbx3c4NGjEAThjzvpa/o14lyysEF
yW1bIKH0Q0Xub1mtdxBHFN31mEq6VyoNkwqRSQCvCGgDIounX1d6gVuaSSCe3mvf
IbbS2iGhA3EHaxXiuILhyU0uNQZ4UE0ceNC4eXaxPIhunDsW5WxOHNNPpFz4LPcc
9P9kyp0oCnj9bvZyrx9o+R0KQiQ1Lm9xU2iTxsuh75SkF3pR9ikv1D0zbrRySmPO
3NjFkEjAYUe0wKStr5wu3sSb0smcXI5cepArsg6wrbDGyT2zY+u0BInphHAT9euL
BEZpVl64NHmucbvFx5dlFebtVHycBnvxttMw9SyOHS/Ujn9AbGjgxgb0wy45aBth
X0w9MzM4YZZexk0c4aiSuu+GDtN9Oi14RdGEqA6Qam7VxWJyq3rt+0mjw05CsMM0
GyW05BPIBQJp7jFqDLqWqoSqNt6kIqkxjPkhPo3GyulnOaMr7V2PEoecrFRIPW2x
6AGGLNmA08MtE4IMb+zU3ZQaJb6J0NAAgw5N7O22SqlYDeo00wO77HwpjagqiyqJ
HUCvCIPk0hC3/LAjxGPTuCjrgJ+UlQZNOWdPu8kV6DewPzc4SIV4eSOyYwFa17ua
PdwNq+EkCgPeAxF+Njr2N2D26nAahr25brcRgIRhUoUbqu4tanU=
=t0bp
-----END PGP SIGNATURE-----

--wd7mZhcgLe12Xu3S--
