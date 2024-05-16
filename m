Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F25130A7C
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846683; cv=none; b=Ki9/R34djJxn8WF4Nrhh1QJGLVu+nzjInQw7T97BgVo4VBWIRIoFu0fYsdp03oXuyPnLsE/eG9XwsmaBMQ9iHJw3nye5CniWsmwhE6TxC2xugf+UaAxlMyzt3GP5wqidASXsw1edLkSbORKw56qKxjIiyXDtyf5hTXQWfLVLd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846683; c=relaxed/simple;
	bh=RiQvg4NR+6SrLvtPDxVDRxF5jXser0Fxmwf70TteTlo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh/HvSMECDthZ2G74T08/Avuvh/NtaAgyM8y/Z8XsV6NHanPACVkpJZC/iIymtXUjxKsNQTTecSxQ35IhWPdtpThmaBePqCVzXW+n6xcdH4sNYriZak2YLZFzpoiSdnxPSVEjVAizebjSRcGthMpzB2AsX7AwNXk/Xe6ZQmRwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EOCe3Fyh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q59K3WcN; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EOCe3Fyh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q59K3WcN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2943A1380282
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:04:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 May 2024 04:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846681; x=1715933081; bh=9N2ivfh72J
	hXuQm/au9koCqc1hN3aSykZcndVoB2vQ8=; b=EOCe3FyhgPHixXoyPtW854yXev
	naDayW1JYu2pE0F2qmLgRv4jErJ8SEtyQRy0KcaxGGiK8OE5RJx23xMs9D6bgyAx
	gVpTKqhql86fPuS6gLxklP+ZM9LHZLLgQBXWo42cfGQAJW+dD4yfMl9g+rDq3qY0
	s9A7h78ehuQsCQctQkYuaaCLbzecD1/T6gPR1bSYt3gpVDZmUiinEIT3SqQSoHJG
	JGYbxAuxSoiBKTys5yrxtIfoJ1GrsyYhDh4ytRZvSCLu5Qfr8AkxthB+8ct4S+ck
	OJf3bm68VlxQMvTQ2PrHMr002a9gXjPopSKQfKhWjKf5/NW0EeSyYxzy0Xog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846681; x=1715933081; bh=9N2ivfh72JhXuQm/au9koCqc1hN3
	aSykZcndVoB2vQ8=; b=Q59K3WcNA8+aOR3MkEfjck6e8sDGJ9MEv0I1HyrYPaWl
	EiCWpRhsdJJgwng+aFh2xy5z9pNpAfrUOJ/X7HLIvT6IIIY8S5AMy3Gk1fnjP0tZ
	USgT7ac4Z3siANAjoxVsDieF1TxQEL3o5LIjEbslfaCFqdQQSgE2I43+JGkNvgQK
	Qjb2GuqHyc0zUKs32Pn2v6cWv7iEpj5vraK4mVfHdg9E0h2FyHAg6JPv6VhgN0EX
	t4CFNczVx+VgjmawhB3JGT5K2zIUW369CJBy7CtvRo9XyVyhneX8TysEgX0L09YW
	Vm+Za1IMH6h4LjfjyVSqYjbCQ9KWTQ0XRjRCGLp06w==
X-ME-Sender: <xms:GL5FZgrNBtNBrJ_oNIH2-5NU7UJ1hUz8PtN3TM76bNDNuqVgDgmrtQ>
    <xme:GL5FZmplSu9d8rk5Ej1N_F_iolQ4d2WQx8mjjOJDkrTIf2tow32Brw88qen162_BF
    SXRptfxwQJUnhztug>
X-ME-Received: <xmr:GL5FZlPC4hopDlpqEg1CHrFdvyLYtZu7j_nQ2a-oJb_lgK3hajMAxCK54dwtUWealbS5AqNJiXNxMqhz6nRAkcSUoCHwyDbc8Xe64WgL0dIyqGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GL5FZn67ipCnIre4tY-RTuCZj-JN4PUincZ62Uy13xfTz1mW9aoYeg>
    <xmx:GL5FZv7M8IdJAu4qA3N4XFk2qJoOgHkcacvJfpIYzPTWUluV5QSufw>
    <xmx:GL5FZngYwvhTh5SN0p1Jd3y8WzEp3xq_cGvpNkj4ZA1YxpFqIWIIiQ>
    <xmx:Gb5FZp7M3V0eg-frwAb4MLwNo7LNYHcPMEbbLOwlOp_fVfRf5LWuKQ>
    <xmx:Gb5FZpR44kLw0DkVtZqmTIw_U-aFcBHSlVbDOYjj6wAHgDiT2fD6E_pJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:04:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 69e04e85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:15 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/16] refs: refactor `resolve_gitlink_ref()` to accept a
 repository
Message-ID: <7b4ea1ffd255245ff7b4f00a7d77599dad61f80b.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tP5VwzuQulBshtCT"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--tP5VwzuQulBshtCT
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
index 86008ce7b4..40e241216e 100644
--- a/refs.c
+++ b/refs.c
@@ -1943,13 +1943,14 @@ int ref_store_create(struct ref_store *refs, int fl=
ags, struct strbuf *err)
 	return refs->be->create(refs, flags, err);
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
index fc1a873e8a..5a2b493507 100644
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


--tP5VwzuQulBshtCT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvhUACgkQVbJhu7ck
PpSmbw//e4OdUqYwXBUuGj4i5Jbyzza4VRcUFT9W4g/wlo3bSOXoEUUHEb/yAf/R
i+oxQLZ6Ygu2BGFLKxr9Hu0Q8lA+Q57XWizBUXn2RA2cgO7iPWvU88OvXC5Nf/o7
J06GW45f8cfph0nNfRXiMdQpn/4ELfloTV9FFtUiPZ9mBFDUOj29grkD8d6JWtAH
fUzE/NNUEgJRaJBp0V4xsvkPbI/XdI80pED9ZGCgxFd41ztxHCGgzD1+fFsofWKB
ru2W1rp0jBwuIChVnKZk2c8WKhjXblQKxyA7Z/r3ixfW7K5iUt8MFnibPN3nM1GY
86qYBAdRRWBrxaqf9PwNtgZ1eHavcrUT0QJPidKiHA6ljg5ywha3bJ//9HeheL6t
HMo1jbAl4DLLi2G0OHTSDiEPnSrOBHtj4zbG6Y9i01BuwHLuHmgBudIXlIfsHqbn
8tb4SqpSnzjJO4aJNmkpvBniAH68vjjBMmpnj1KL8wmkvWSn9hZIAgF96IGxoULc
Kzg1MgTSO4+SgMriZsIWwwpzCU4weTTrqJmNGOiHwaLd0g34OxPCkKeui2mTh90M
0h5I+yXUjYwFm8p6C69W8181CgQXNFhOiuWw9av+dAPopftIQHXZRKKvwO7f/zwA
A/eP3kgJinufMiqb4bbNRpJf6Df3w4fMWAc3Co6GezWyQ5smc6I=
=KPW7
-----END PGP SIGNATURE-----

--tP5VwzuQulBshtCT--
