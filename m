Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327436137
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933925; cv=none; b=JNZ8ghdY8HFeBu9WTQ/vnpwJxGnyqmkTkp7ctU1Zt7nutY9/5Xd4W/6iKzG5XI+RbSOq+Cjnq+NT1FOTmVAe0CH9gqV/WZmLA49QHRrkwy4r1t0FOopT+n7COAlWMwAqbqREgpSxHvdyHtoo2ApQxnrUt0ZtSocIkrJp1Z207c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933925; c=relaxed/simple;
	bh=EW13sedVTtNPQrj94I72CCYclpGNi4MtFz1XYoFg91M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+snHUCw8/C7Mcjn6+M+hs3aqlDOtJ/1x0srnIKiHFqVBYEuPclhOh6M3Q+VtX3c5p94635fSsmnfMCNKjqd7FDJfmIc0lpm5/V8/xYjyoe67EUtQSrrwd6pgqQwTUArjItl6F5nd0XrvTHRoBWce1IlsYVX/d+l1hhAVxZHFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rsxLzYJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j6FbB5wp; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rsxLzYJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j6FbB5wp"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 41F481C000BB;
	Fri, 17 May 2024 04:18:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 May 2024 04:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933922; x=1716020322; bh=I1mM2lEjVH
	DbT9Evr6S2sAY2W8wnbqH0i8raCvyoyWw=; b=rsxLzYJcEmYrS9tPQzEys3/E7s
	MzkUp28BML4SdKpPckXH76HaNmaNP9xIAeM7fXdAbQjaYsz6wNv0Evbap+Qzlg1F
	HXfL5FeCu5lb41ufx6KI3q28IvqMGIJHNjaDPPX2R/HRFM8bmcLBVT5AeSS0I36c
	fyq5j5E5nPPcG6Ct22heWFvJRfXs0V5geAA/6yZ4EsjLxMw2PqOM8hjsot8xSzAH
	X8ivGoYrv6edhOupudsDqyxIToFAB1VdfN6vJkj+2oEVR4NDnFvd8xg1Nzr4WDQb
	nPEdnnvuMtu/9h2SjN5aN8GW9dQqjQk3KaoKrPHjJr65xW1okKEE364Vpz3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933922; x=1716020322; bh=I1mM2lEjVHDbT9Evr6S2sAY2W8wn
	bqH0i8raCvyoyWw=; b=j6FbB5wpAS8IwMQpE09Hixj4M+UCkDfxMEEomOWcZFCa
	vKXzFppPrA7pazNsay4+bcO7IVSbMrcvviSVxpyAvFaEdjdWfhzH5LkzMQvoUNKp
	vm4w1MoXgKs+euZ0a3vZYWnxdtQT0ojzAxq2cnQFIpsGlY0OU+WRm2qqTJtiyH7E
	YRYbiDMnqk1jY53KZ/FaNuFuuqhLxezyj3mEwnmagVuM2pQKFHjdyNQcyCHNPQCw
	t/hL5GQq+NuzrXqzuWHDWt+f5r4iltJsVNuaT0UWWpI1FZ5UJVAxU2rUB6gFcy1Q
	94lEqwtysYyAYCCLbHxSwD/WemKBab7E8aIJI01fjg==
X-ME-Sender: <xms:4hJHZoJkWCiXV8jqb3whnp-6mI3mX1Cbx8XC7WEhzifGNRtXrhA4EA>
    <xme:4hJHZoKzvUO4MQvTFPYT4dOUYCjaxOx8-lRwBBlClr-pOUAeKuwjtYdUmCb5lDewW
    7SyJOI4OkzfZuufMQ>
X-ME-Received: <xmr:4hJHZouSRHbvMndo2EIUFQsQmwvU6bQN0J0sQ9QOAqjJzoTgVfYoUxxfh27HiWxUnkMZYscHF2bMcuIYKx8-mYm4Ymwwt43_yISUMDPCSj1rpGYGIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:4hJHZlaz4t1xJ9W7FgInCj5YxI2-fFk89BKnlJC_l8vGb2qwU3BSfA>
    <xmx:4hJHZvZjMUoI9WsZbP2Cj2AB5tp-X6uTkGUvnqYTeOtqzsm52bpkEQ>
    <xmx:4hJHZhAwhfJBqhL67D21_L6DwZjgBDrUp1QPZX5XiS_taxCFwZpZDA>
    <xmx:4hJHZlZoQY044zaJbmR47nxKmg5FAueVrB4jYc5M8VTDyur3AkC3OA>
    <xmx:4hJHZrGH_cNV9pzOUXTcLN8Spws71Yt9_pjoZnAvzrNGqg15UdMLYlUy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:18:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 29cd82d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:14 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/16] refs: refactor `resolve_gitlink_ref()` to accept a
 repository
Message-ID: <a8593b16a6ef85ede315f8937a6d447a03a46635.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KVP3V3TMgGhVaHhG"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--KVP3V3TMgGhVaHhG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `resolve_gitlink_ref()` we implicitly rely on `the_repository` to
look up the submodule ref store. Now that we can look up submodule ref
stores for arbitrary repositories we can improve this function to
instead accept a repository as parameter for which we want to resolve
the gitlink.

Do so and adjust callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 attr.c                      | 3 ++-
 builtin/submodule--helper.c | 8 +++++---
 builtin/update-index.c      | 5 +++--
 combine-diff.c              | 3 ++-
 diff-lib.c                  | 3 ++-
 dir.c                       | 3 ++-
 object-file.c               | 2 +-
 read-cache.c                | 5 +++--
 refs.c                      | 7 ++++---
 refs.h                      | 5 +++--
 unpack-trees.c              | 3 ++-
 11 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/attr.c b/attr.c
index 33473bdce0..6c6eb05333 100644
--- a/attr.c
+++ b/attr.c
@@ -1288,7 +1288,8 @@ static const char *builtin_object_mode_attr(struct in=
dex_state *istate, const ch
 			if (pos >=3D 0) {
 				 if (S_ISGITLINK(istate->cache[pos]->ce_mode))
 					 mode =3D istate->cache[pos]->ce_mode;
-			} else if (resolve_gitlink_ref(path, "HEAD", &oid) =3D=3D 0) {
+			} else if (repo_resolve_gitlink_ref(the_repository, path,
+							    "HEAD", &oid) =3D=3D 0) {
 				mode =3D S_IFGITLINK;
 			}
 		}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5076a33500..897f19868e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2600,7 +2600,8 @@ static int update_submodule(struct update_data *updat=
e_data)
=20
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
-	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->=
suboid))
+	else if (repo_resolve_gitlink_ref(the_repository, update_data->sm_path,
+					  "HEAD", &update_data->suboid))
 		return die_message(_("Unable to find current revision in submodule path =
'%s'"),
 				   update_data->displaypath);
=20
@@ -2627,7 +2628,8 @@ static int update_submodule(struct update_data *updat=
e_data)
 						   update_data->sm_path);
 		}
=20
-		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->=
oid))
+		if (repo_resolve_gitlink_ref(the_repository, update_data->sm_path,
+					     remote_ref, &update_data->oid))
 			return die_message(_("Unable to find %s revision in submodule path '%s'=
"),
 					   remote_ref, update_data->sm_path);
=20
@@ -3357,7 +3359,7 @@ static void die_on_repo_without_commits(const char *p=
ath)
 	strbuf_addstr(&sb, path);
 	if (is_nonbare_repository_dir(&sb)) {
 		struct object_id oid;
-		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+		if (repo_resolve_gitlink_ref(the_repository, path, "HEAD", &oid) < 0)
 			die(_("'%s' does not have a commit checked out"), path);
 	}
 	strbuf_release(&sb);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 20aa1c4c68..d343416ae2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -349,7 +349,8 @@ static int process_directory(const char *path, int len,=
 struct stat *st)
 		if (S_ISGITLINK(ce->ce_mode)) {
=20
 			/* Do nothing to the index if there is no HEAD! */
-			if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+			if (repo_resolve_gitlink_ref(the_repository, path,
+						     "HEAD", &oid) < 0)
 				return 0;
=20
 			return add_one_path(ce, path, len, st);
@@ -375,7 +376,7 @@ static int process_directory(const char *path, int len,=
 struct stat *st)
 	}
=20
 	/* No match - should we add it as a gitlink? */
-	if (!resolve_gitlink_ref(path, "HEAD", &oid))
+	if (!repo_resolve_gitlink_ref(the_repository, path, "HEAD", &oid))
 		return add_one_path(NULL, path, len, st);
=20
 	/* Error out. */
diff --git a/combine-diff.c b/combine-diff.c
index d6d6fa1689..4960d904ac 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1066,7 +1066,8 @@ static void show_patch_diff(struct combine_diff_path =
*elem, int num_parent,
 			elem->mode =3D canon_mode(st.st_mode);
 		} else if (S_ISDIR(st.st_mode)) {
 			struct object_id oid;
-			if (resolve_gitlink_ref(elem->path, "HEAD", &oid) < 0)
+			if (repo_resolve_gitlink_ref(the_repository, elem->path,
+						     "HEAD", &oid) < 0)
 				result =3D grab_blob(opt->repo, &elem->oid,
 						   elem->mode, &result_size,
 						   NULL, NULL);
diff --git a/diff-lib.c b/diff-lib.c
index 12b1541478..5a5a50c5a1 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -66,7 +66,8 @@ static int check_removed(const struct cache_entry *ce, st=
ruct stat *st)
 		 * a directory --- the blob was removed!
 		 */
 		if (!S_ISGITLINK(ce->ce_mode) &&
-		    resolve_gitlink_ref(ce->name, "HEAD", &sub))
+		    repo_resolve_gitlink_ref(the_repository, ce->name,
+					     "HEAD", &sub))
 			return 1;
 	}
 	return 0;
diff --git a/dir.c b/dir.c
index 2d83f3311a..f6066cc01d 100644
--- a/dir.c
+++ b/dir.c
@@ -3318,7 +3318,8 @@ static int remove_dir_recurse(struct strbuf *path, in=
t flag, int *kept_up)
 	struct object_id submodule_head;
=20
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
-	    !resolve_gitlink_ref(path->buf, "HEAD", &submodule_head)) {
+	    !repo_resolve_gitlink_ref(the_repository, path->buf,
+				      "HEAD", &submodule_head)) {
 		/* Do not descend and nuke a nested git work tree. */
 		if (kept_up)
 			*kept_up =3D 1;
diff --git a/object-file.c b/object-file.c
index 610b1f465c..a40300ce4a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2669,7 +2669,7 @@ int index_path(struct index_state *istate, struct obj=
ect_id *oid,
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return resolve_gitlink_ref(path, "HEAD", oid);
+		return repo_resolve_gitlink_ref(the_repository, path, "HEAD", oid);
 	default:
 		return error(_("%s: unsupported file type"), path);
 	}
diff --git a/read-cache.c b/read-cache.c
index a6db25a16d..447109aa76 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -271,7 +271,8 @@ static int ce_compare_gitlink(const struct cache_entry =
*ce)
 	 *
 	 * If so, we consider it always to match.
 	 */
-	if (resolve_gitlink_ref(ce->name, "HEAD", &oid) < 0)
+	if (repo_resolve_gitlink_ref(the_repository, ce->name,
+				     "HEAD", &oid) < 0)
 		return 0;
 	return !oideq(&oid, &ce->oid);
 }
@@ -711,7 +712,7 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
=20
 	namelen =3D strlen(path);
 	if (S_ISDIR(st_mode)) {
-		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+		if (repo_resolve_gitlink_ref(the_repository, path, "HEAD", &oid) < 0)
 			return error(_("'%s' does not have a commit checked out"), path);
 		while (namelen && path[namelen-1] =3D=3D '/')
 			namelen--;
diff --git a/refs.c b/refs.c
index 1d660d5ace..7703b7781c 100644
--- a/refs.c
+++ b/refs.c
@@ -1943,13 +1943,14 @@ int ref_store_create_on_disk(struct ref_store *refs=
, int flags, struct strbuf *e
 	return refs->be->create_on_disk(refs, flags, err);
 }
=20
-int resolve_gitlink_ref(const char *submodule, const char *refname,
-			struct object_id *oid)
+int repo_resolve_gitlink_ref(struct repository *r,
+			     const char *submodule, const char *refname,
+			     struct object_id *oid)
 {
 	struct ref_store *refs;
 	int flags;
=20
-	refs =3D repo_get_submodule_ref_store(the_repository, submodule);
+	refs =3D repo_get_submodule_ref_store(r, submodule);
 	if (!refs)
 		return -1;
=20
diff --git a/refs.h b/refs.h
index 346a81e9e3..90a7e2dde3 100644
--- a/refs.h
+++ b/refs.h
@@ -141,8 +141,9 @@ int peel_iterated_oid(const struct object_id *base, str=
uct object_id *peeled);
  * successful, return 0 and set oid to the name of the object;
  * otherwise, return a non-zero value.
  */
-int resolve_gitlink_ref(const char *submodule, const char *refname,
-			struct object_id *oid);
+int repo_resolve_gitlink_ref(struct repository *r,
+			     const char *submodule, const char *refname,
+			     struct object_id *oid);
=20
 /*
  * Return true iff abbrev_name is a possible abbreviation for
diff --git a/unpack-trees.c b/unpack-trees.c
index c2b20b80d5..304ea2ed86 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2318,7 +2318,8 @@ static int verify_clean_subdirectory(const struct cac=
he_entry *ce,
=20
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct object_id oid;
-		int sub_head =3D resolve_gitlink_ref(ce->name, "HEAD", &oid);
+		int sub_head =3D repo_resolve_gitlink_ref(the_repository, ce->name,
+							"HEAD", &oid);
 		/*
 		 * If we are not going to update the submodule, then
 		 * we don't care.
--=20
2.45.1.190.g19fe900cfc.dirty


--KVP3V3TMgGhVaHhG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEt4ACgkQVbJhu7ck
PpR6dQ//QPnUK8S9ybMfsu3TgB+k06OruRTJ4SSMsPS1X2d0DR8D2xeLTjDqDHE7
mpNBkZlhXxb81a69UEzTGNQ6InHwalcI3RUhbDYX2JpE6DqMEPEyhbM3bEDFKr6e
zbFdT84CqPDZiyOPyK/g5rOBH6bEbCqBBCiBn/GNC7Dh6oIisTH5/Fn0c/HItcgw
rvxWn0svVN8etv3kV0YvAg5qvk3v8avkGwyw3CoGEuMnVl+dsY8EmbANcGJw5wRG
Ol3M41Um9j+8OcbX3bcTyuaEngF2kk09QgKptU0zBNJNlvv6FB3oY9c+YZs1hcCB
oP6IoAX/zRoFdwa9QURVOU3D9HTtb8Uyo53vPI/rnUZrVDBkmmhgNEHxk2/k4AN8
rKpXDVq9R4HVfHLdtv+BSPsrWg24GhahNL7jqpvtT2ookApmoOgHxiADWG6pPBFw
2SgaJa3KRpqP8WCBfzzQvHUWsdcpIyiS1KNk74G/l6DjRCmiUbGnjxtCU51Idzou
kzHihFavNv0fCU2s3iSJDaPxg0Cv0+eZOUuJnxs82c9VRxh2R0BSV4KRBTFcEHjU
gJdojcxVrez677aJn4XqAHhCtLGPBhldPHmr3QLo515NB8bCqesEH+Eb7e/wsoD6
/ii3lMy6lrltho2atr+n2LX5QIA5EZuvsyX4lRCxYnyFHoK/bb0=
=iKJK
-----END PGP SIGNATURE-----

--KVP3V3TMgGhVaHhG--
