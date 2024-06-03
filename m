Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECB128379
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408037; cv=none; b=FqMbyHhtdShHrBHGlUDHuWhcwK5QssmyiUhcEqt/c9IrciZmLK7uL5P4Dbsp+z49TrXXcaZI5L4Ae7hHzMWlnAbtUb3RnlUTVo7LohC+JRzvmgKIMVmJErqFtMdyWZbXT0D909HocVVSWANikCwlUDwRUwzzs1IeNOpZpzrFltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408037; c=relaxed/simple;
	bh=Yi2f/CvQ+v3GSRvK+sci52p+d8gm3rn9IXRic8KoTsU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZxCbz4hrr4Tw79T1OiqJXVSaG+fJDxK2mFgoCie2xT0SNkQu1EPlh2NlRp5u/UoriIyO9LPuwRBQBgyICcV6n7Pbbp+PCDGtAOtMa5zUfkZDr3lsqyW1KE0SZHIEQ9BGqcL8rmRY6h+4V4UMLeA7SJVMDcMWW1S9L45dtMjX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FnPjF/ZU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvaWTnTt; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FnPjF/ZU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvaWTnTt"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4787C1800099
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408034; x=1717494434; bh=P7NdMM4+U/
	HgXUZsEWJpQGFv/281rTVDFZQiyPVn4Ak=; b=FnPjF/ZUYyJ5O1xoYxqbd/mxMW
	IJFnI8wcNiivIh1q4tOrx/yphBJSegIaU5HH68Po8ExuoydHT/X7IXzF3bjaC935
	vOiipq5RUpqzPiTDLIuoEA77aCmU0ww+Em00apifaMEyQP4yk9PUzzEoq54tVFJA
	Z90F83me5CJca6U8+sCPVemQhb9yCCRORQw614Dr0xRuCmQvfTctIMbd08wMwERL
	dBR9k6pCUek4r1jPjHI9wgX9QbmbQu21HHtTj/Zdp/+yqybzZCz9za2uhJVi2a9M
	amwVP7LCNU8jGlXYKtcHDiaxKJv4fM43ojL7K01RGUSjb/NiBILAB2/r+mJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408034; x=1717494434; bh=P7NdMM4+U/HgXUZsEWJpQGFv/281
	rTVDFZQiyPVn4Ak=; b=ZvaWTnTtkpx/6Pr7SU+xGZburzGgncA/OIYL3ulSi9QM
	7pmQISrbPJuw96a+9RhOob99t6a1920QPGskbPxI5mv7JLQ62aToxVtuMtbX/MmY
	b6QK3nI02Up2Au8chQ9NmB53sC/FIM6rWLYWhyopRcyR4qry1KTydq4SOUdF3hjM
	hH15pg3gkpRHOlYgmRLbA0sttDrkoVmhMJ9APr72kUxVemA0fBlHIZEZhc046AZw
	pXkbk6kHoM6ouYE6QZem2hEwraBr7wMyq1bxqn6OHTtcy4Mwc4Te4Hg+wEgunMw2
	tg4UD3GAbF2AK4Zd4ykOirAjA2Tml5zv/hG0JWy4hg==
X-ME-Sender: <xms:IpFdZuM8tnLIFO2732AGWDVpLd2Nmc5YUmBUNoOI8VzyFWG7949Tqw>
    <xme:IpFdZs_6hdVep4FE4PtdOIxC6pf3VSiIf86FfIBo3AaiJSJVjsFCcO5IxTPXhM0F-
    7H9XT9rv-y86Q0JRw>
X-ME-Received: <xmr:IpFdZlQclvmm2lqbOUXvVlOEROa-FbwGb_fcPQRjd_JyyJB9Qc3xudrY3A7_6-YGU_EvTkCdI-goOC_fZcQbQFR3gI5IUqChcjl1CvGO40tF0KoY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IpFdZuvzsFxsiEUeLQv-4TOMqZR5YrItvJ2gjiPf_TjQZKg0lQIbPQ>
    <xmx:IpFdZmfBZFVGkVMuMR1h4Kg7ndaVTJgiY8846JY6040XFv1GA07S7w>
    <xmx:IpFdZi1_g_813FRT2ljfaiWtDs6Q-rbBHvF-r_SPnW-aJ6V_laflyg>
    <xmx:IpFdZq8lWaUGYulEHLCpTz4HqaKNxBxwYjwiOU8YKlYquqif347urQ>
    <xmx:IpFdZqFxnCtCLbhd4ryjs4xEHedvYU7FTCc7H82NBIP7hxdypWXQb5Tr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c0e92ee5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:49 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/29] object-name: free leaking object contexts
Message-ID: <2ac24bf942fcc78fbbeedc05d663b5011dfb7ff1.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gXqv/Ezoj8397Lyi"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--gXqv/Ezoj8397Lyi
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
2.45.1.410.g58bac47f8e.dirty


--gXqv/Ezoj8397Lyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkR4ACgkQVbJhu7ck
PpTBVA/9GIHnYQdHRKd/2yubDwaSnUmYTBDZmAteYkb2syyphP2+nneE+o2HiR1d
h7L2HX1JF0PoeqXPNyaKCacCygA2hsGBmC5C7aWS08tc0QN0nwO1gVEuLpyYtceW
PmBzBMATBwd0W4qXgi6LG4lp0mtYkW0CUmH4wyV3QxOElA9p7XX7mxkLdQatVS/p
m76M7Qljbd27qqUEtFyr48CwBaEuidY0Rke/SeYy/OR2dl4ysDwFh5jRPE0sj02+
IKKcvYlzpT8DPk2DWhEuxMfzLM2LNHSIWc4aIY+sACuQyEx1XxprcAIVIRMxPtU1
AOrRYZyKWHozqv89sPY42FCJTuivp0yBbFCbIGlkmOtBq7NGfHaA3upj3OzOG+20
+NLT3E411zqWWNsuQ+QYrKEEz+6PlQ7w6wL8ZKRCt+dnFLydAUsFg/dVYIDs0zfc
Hj8rABxPnafoWRePNr0msZ/Fw8E+kYyVcJ7G73Ksp9lVNfXPd55EtjNJl6MePt1q
k/qHpLrisHohXU4US7LZRN6cNb8ZI3e/QYMS1i2l655Ec4+CDevFebzvIYMdrCXv
8W60XLsCgxQHAeYoOb6FsgLfITT7ZMh7g2MrdE2Keeu48m5NlkdLD0z1WV7hA4v1
QVngDB9s4Fd8hkbu8xy8jTBTAhDDiNF95NM+QJxhaf3HARuA1BE=
=JI8u
-----END PGP SIGNATURE-----

--gXqv/Ezoj8397Lyi--
