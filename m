Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53A22422A
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524599; cv=none; b=OGA3gmc5ys+O7LPhPukHtlCvFn5b+HeGDxPFYDv4yZ3RxLaqKeQyAvkEmeX0k1//xnnxLCfNAemWDT8UGM/JWUjORxtcgo+1AFPYQpg4DvgZ/0umlsqXzyWaSASfgmzNF6xZRSK/QHCqDoPicDM3j3Zs1oa/gwBU38DDF2GPVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524599; c=relaxed/simple;
	bh=duhx3urVDpoTWLN7HQi6/3VFgii8hB1dIsVxbHSYGMk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=Id8ZMSkHV/uQTGrUFs82yfs6teA2eTtU2J+PVvZ3HbE7aUf/sJ+ZIUIbgN72TtwckbNZ7oZlLQxYfMjMF9K3/nzJeMkGH+0zaHj6gMaXfBdQPgbCg0suv6M7lsWr+OIG1GpSz9URsF/E0aP69OnWGjOEir9dqsb3XUFJhS3YFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=W/6EMUrT; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="W/6EMUrT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757524591; x=1758129391; i=l.s.r@web.de;
	bh=S9jQEb2iuG0nq+cpoA8QcphaQ43+FvgcqWE/9bNxapo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W/6EMUrTqdAajo+JcaMTMOC/HFIZ6/uGInPBNyPyCSkshyx4oha7U9SnmkeH/FFN
	 76j/Z34tSONx+hWbT82Vc3aDXd2G9UWNwZaniqNa4KsLJ1vBwNxv3W2stNv8YfS9n
	 rMavzDJlLB9jfqEPjwABP2Dusju5ntwL8aVM/nikxFvvRu6d1qyEWRiCJ1u5UP6BM
	 OhmvgMlxWvE0sbs1orBgT/FP+C/3gLnFfZnEk01q2+ydgZxmPur0Puu21yBVussy+
	 DlOC2SecDrob8W/kOWwVTgCN1/CHKAoTVTn3vTzGVItj+5IPq7YteZ883fbRRnLs9
	 JpWkkGBpa8qRR9KIig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.159.98]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1ZN-1uQe2q11yB-00bwBv; Wed, 10
 Sep 2025 19:16:31 +0200
Message-ID: <906196ac-2fd7-4c07-9e8f-22d67b0b64f9@web.de>
Date: Wed, 10 Sep 2025 19:16:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use repo_get_oid_with_flags()
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cP9w+Ugp2greHjwAN/wtggF3Jxs5zJ6KL/GNBiFBaB5e/f5d75F
 GQ0KopLZSV3gBZg6YKpx+KpqaGuY461J9fi5uUzv8MhGDcXYxkukbJBaMTqu70wTDB+Q+d2
 yh0E0ZUSDmEIzi2118yMfxGNvpzP0D+UdnB0Lw+OXtFYqOf/uPQXwolvCDTLBAdq+1eAdGk
 Uf4eiY9jJA/1ng1bVmizQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:19zT2cDIi0c=;0z+CDChjsClvmlfIbg3bSHUIUol
 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
 GWt9/Crjoy5GqIfuAR4ZfCc1JBVN1zSq727Fr

get_oid_with_context() allows specifying flags and reports object
details via a passed-in struct object_context.  Some callers just want
to specify flags, but don't need any details back.  Convert them to
repo_get_oid_with_flags(), which provides just that and frees them from
dealing with the context structure.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/ls-tree.c     |  7 ++-----
 builtin/rev-parse.c   |  7 ++-----
 builtin/stash.c       | 14 +++++---------
 list-objects-filter.c |  9 +++------
 object-name.c         | 30 +++++-------------------------
 5 files changed, 17 insertions(+), 50 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 5d55731ca3..ec6940fc7c 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -373,7 +373,6 @@ int cmd_ls_tree(int argc,
 		OPT_END()
 	};
 	struct ls_tree_cmdmode_to_fmt *m2f =3D ls_tree_cmdmode_format;
-	struct object_context obj_context =3D {0};
 	int ret;
=20
 	repo_config(the_repository, git_default_config, NULL);
@@ -405,9 +404,8 @@ int cmd_ls_tree(int argc,
 			ls_tree_usage, ls_tree_options);
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
-	if (get_oid_with_context(the_repository, argv[0],
-				 GET_OID_HASH_ANY, &oid,
-				 &obj_context))
+	if (repo_get_oid_with_flags(the_repository, argv[0], &oid,
+				    GET_OID_HASH_ANY))
 		die("Not a valid object name %s", argv[0]);
=20
 	/*
@@ -447,6 +445,5 @@ int cmd_ls_tree(int argc,
=20
 	ret =3D !!read_tree(the_repository, tree, &options.pathspec, fn, &option=
s);
 	clear_pathspec(&options.pathspec);
-	object_context_release(&obj_context);
 	return ret;
 }
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 44ff1b8342..9da92b990d 100644
=2D-- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -708,7 +708,6 @@ int cmd_rev_parse(int argc,
 	struct object_id oid;
 	unsigned int flags =3D 0;
 	const char *name =3D NULL;
-	struct object_context unused;
 	struct strbuf buf =3D STRBUF_INIT;
 	int seen_end_of_options =3D 0;
 	enum format_type format =3D FORMAT_DEFAULT;
@@ -1141,9 +1140,8 @@ int cmd_rev_parse(int argc,
 			name++;
 			type =3D REVERSED;
 		}
-		if (!get_oid_with_context(the_repository, name,
-					  flags, &oid, &unused)) {
-			object_context_release(&unused);
+		if (!repo_get_oid_with_flags(the_repository, name, &oid,
+					     flags)) {
 			if (output_algo)
 				repo_oid_to_algop(the_repository, &oid,
 						  output_algo, &oid);
@@ -1153,7 +1151,6 @@ int cmd_rev_parse(int argc,
 				show_rev(type, &oid, name);
 			continue;
 		}
-		object_context_release(&unused);
 		if (verify)
 			die_no_single_rev(quiet);
 		if (has_dashdash)
diff --git a/builtin/stash.c b/builtin/stash.c
index f5ddee5c7f..87acefb82f 100644
=2D-- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1089,7 +1089,6 @@ static int store_stash(int argc, const char **argv, =
const char *prefix,
 	int quiet =3D 0;
 	const char *stash_msg =3D NULL;
 	struct object_id obj;
-	struct object_context dummy =3D {0};
 	struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("be quiet")),
 		OPT_STRING('m', "message", &stash_msg, "message",
@@ -1109,9 +1108,8 @@ static int store_stash(int argc, const char **argv, =
const char *prefix,
 		return -1;
 	}
=20
-	if (get_oid_with_context(the_repository,
-				 argv[0], quiet ? GET_OID_QUIETLY : 0, &obj,
-				 &dummy)) {
+	if (repo_get_oid_with_flags(the_repository, argv[0], &obj,
+				    quiet ? GET_OID_QUIETLY : 0)) {
 		if (!quiet)
 			fprintf_ln(stderr, _("Cannot update %s with %s"),
 					     ref_stash, argv[0]);
@@ -1122,7 +1120,6 @@ static int store_stash(int argc, const char **argv, =
const char *prefix,
 	ret =3D do_store_stash(&obj, stash_msg, quiet);
=20
 out:
-	object_context_release(&dummy);
 	return ret;
 }
=20
@@ -2235,7 +2232,6 @@ static int do_export_stash(struct repository *r,
 			   const char **argv)
 {
 	struct object_id base;
-	struct object_context unused;
 	struct commit *prev;
 	struct commit_list *items =3D NULL, **iter =3D &items, *cur;
 	int res =3D 0;
@@ -2269,9 +2265,9 @@ static int do_export_stash(struct repository *r,
 			struct commit *stash;
=20
 			if (parse_stash_revision(&revision, argv[i], 1) ||
-			    get_oid_with_context(r, revision.buf,
-						 GET_OID_QUIETLY | GET_OID_GENTLY,
-						 &oid, &unused)) {
+			    repo_get_oid_with_flags(r, revision.buf, &oid,
+						    GET_OID_QUIETLY |
+						    GET_OID_GENTLY)) {
 				res =3D error(_("unable to find stash entry %s"), argv[i]);
 				goto out;
 			}
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 7ecd4d9ef5..acd65ebb73 100644
=2D-- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -524,12 +524,11 @@ static void filter_sparse_oid__init(
 	struct filter *filter)
 {
 	struct filter_sparse_data *d =3D xcalloc(1, sizeof(*d));
-	struct object_context oc;
 	struct object_id sparse_oid;
=20
-	if (get_oid_with_context(the_repository,
-				 filter_options->sparse_oid_name,
-				 GET_OID_BLOB, &sparse_oid, &oc))
+	if (repo_get_oid_with_flags(the_repository,
+				    filter_options->sparse_oid_name,
+				    &sparse_oid, GET_OID_BLOB))
 		die(_("unable to access sparse blob in '%s'"),
 		    filter_options->sparse_oid_name);
 	if (add_patterns_from_blob_to_list(&sparse_oid, "", 0, &d->pl) < 0)
@@ -544,8 +543,6 @@ static void filter_sparse_oid__init(
 	filter->filter_data =3D d;
 	filter->filter_object_fn =3D filter_sparse;
 	filter->free_fn =3D filter_sparse_free;
-
-	object_context_release(&oc);
 }
=20
 /*
diff --git a/object-name.c b/object-name.c
index 732056ff5e..52d87348d1 100644
=2D-- a/object-name.c
+++ b/object-name.c
@@ -1858,55 +1858,35 @@ int repo_get_oid_committish(struct repository *r,
 			    const char *name,
 			    struct object_id *oid)
 {
-	struct object_context unused;
-	int ret =3D get_oid_with_context(r, name, GET_OID_COMMITTISH,
-				       oid, &unused);
-	object_context_release(&unused);
-	return ret;
+	return repo_get_oid_with_flags(r, name, oid, GET_OID_COMMITTISH);
 }
=20
 int repo_get_oid_treeish(struct repository *r,
 			 const char *name,
 			 struct object_id *oid)
 {
-	struct object_context unused;
-	int ret =3D get_oid_with_context(r, name, GET_OID_TREEISH,
-				       oid, &unused);
-	object_context_release(&unused);
-	return ret;
+	return repo_get_oid_with_flags(r, name, oid, GET_OID_TREEISH);
 }
=20
 int repo_get_oid_commit(struct repository *r,
 			const char *name,
 			struct object_id *oid)
 {
-	struct object_context unused;
-	int ret =3D get_oid_with_context(r, name, GET_OID_COMMIT,
-				       oid, &unused);
-	object_context_release(&unused);
-	return ret;
+	return repo_get_oid_with_flags(r, name, oid, GET_OID_COMMIT);
 }
=20
 int repo_get_oid_tree(struct repository *r,
 		      const char *name,
 		      struct object_id *oid)
 {
-	struct object_context unused;
-	int ret =3D get_oid_with_context(r, name, GET_OID_TREE,
-				       oid, &unused);
-	object_context_release(&unused);
-	return ret;
+	return repo_get_oid_with_flags(r, name, oid, GET_OID_TREE);
 }
=20
 int repo_get_oid_blob(struct repository *r,
 		      const char *name,
 		      struct object_id *oid)
 {
-	struct object_context unused;
-	int ret =3D get_oid_with_context(r, name, GET_OID_BLOB,
-				       oid, &unused);
-	object_context_release(&unused);
-	return ret;
+	return repo_get_oid_with_flags(r, name, oid, GET_OID_BLOB);
 }
=20
 /* Must be called only when object_name:filename doesn't exist. */
=2D-=20
2.51.0
