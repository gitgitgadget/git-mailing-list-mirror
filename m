Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ECC374FF
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353336; cv=none; b=LUSVwyYiLye0thG0FT/lAmR75kQRFqlP1G33qyjEWqoLdGFz4bDhQ9El0NprMvvI+HgsPdJAyp0jSA3+o6YiS6iw08+XtxOXr9GQM6YMJpIDc0kwAJbPix5vzw3KL/9fgxEvSkI9WxNzXUTIr4GEj6ZAOmFeybRZvaGSxfWR/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353336; c=relaxed/simple;
	bh=yu03h7l/9nI7ZtXAJqiIlsU/7TqbUdZFE39EZZ0Bn3A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPnlu4EFo6nF/hlJs72X5Og/5xveBdWFBdkhd8l1EagFtFLVNYk1xwI/DU/lFXDUcpwUHnkDe4N2ATTvvjCl9DVpEzvKW66A2d1Jtp9/MLVQ7PqGBZnVvegcFytdM0LkHGlsOZhmuEjfwkEkpbdsRxnHWpMadNbhPrpiAoIFv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XX0EpxyZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lhycnQbF; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XX0EpxyZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lhycnQbF"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 6A8705C00BD
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 19 Feb 2024 09:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708353333; x=1708439733; bh=RDXnKbZe4r
	ozpOfF3EjpZAmuxRV3WcgESeBcQ/LB/UY=; b=XX0EpxyZZ8tTC0cMUmfmY3qDGI
	uINznWzHPGWIzY5EB8BzFfKVWEncEzNKteXY8+7nXb5rF0yMccZCJU+yziebmtiT
	luLiTqM7IZ2ByWFEjkUjxQXHs3DAjz/k76XKSlkD1YyNJ/diRUIw+ekzmXtBT22S
	3xrSQjDCm4QxLpWWWY6vo040chVjcAdwXkR7KyyzTchCnlq1JwemdLy4VxJvRT3b
	WJIHMCxtl+HtY5Qujgp67PllEZ7HnzMeonK1KcAodejz0hUvRV1s6Z79H0Zq0I3r
	9GmQoEC6E8C2qNaqLDFk+IHr0UY8LEurdWU2G1ZANvzXtZa3N4bbBO0kf6Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708353333; x=1708439733; bh=RDXnKbZe4rozpOfF3EjpZAmuxRV3
	WcgESeBcQ/LB/UY=; b=lhycnQbFLYChvvtu4RdqJY9h7YcaniQGfnf6mtmMmk1p
	mB6EorK8dJAuKnFFv0S1ewoiLauVdg0BEY6Mvn9HR2S59iiNi5HHsplBz892YGme
	45it2eVddiNanVwebbJxmTSDZhYbB16lwsNtq/c0FtFS+7VtxNyL4ro9xcllN+aO
	f63xqTsaX/WPAWtOlBhe5vul2CEdz77BcJ4sr/a/8bd7JUfPzqFZO2LZAa3W2RcU
	6yZ83AGAICTowIgyN4Uzwr4DUV+J1WqRl6oiWxviOP9OD84N34RaatNTODOIscEx
	gwHsXVsBfhsmPcwKFY8uC3+GPA/JK9vB3sTp4Y8+Dw==
X-ME-Sender: <xms:NWfTZQpjd357eYri7FrKhN9oiT3fKUph0StEZ4-p25QY2XMIfhlpbw>
    <xme:NWfTZWpD_lw6UUWXfN6is3JkHOxt2mRUER0WVZsyC9qv_V3vj2dTMtMDkrvhQNpDM
    Zx8s7TEA5IgIJ7xHQ>
X-ME-Received: <xmr:NWfTZVNI7BGgjD9iWLhrUGuZeiZZxpYrayEOJx_Y0hHSaq7NoOadY9i549yjF0Gu8UPA5wtQppp-d6PHadtgeaOo8hfUFAc2B1bZtGqtDEVZug8Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NWfTZX7J_NWsIYbo-TG6y1qnwnUVufkmPkUNEYSTzZe7rBfmR7F5ZQ>
    <xmx:NWfTZf7CFHpIkXYQiKPs4mZNBGhKy0C5OTtMDH-G_1dAJosdizZk0Q>
    <xmx:NWfTZXjWFSnPRur91e5iorDGOYFvjXO7czo6KTxQqTGlGe1TYmtILw>
    <xmx:NWfTZcj8rDmm6-30nKdBcNUaBWPG31QoEdREaaZqLWr7wAB-BWgoFA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab32afef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Feb 2024 14:31:32 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:35:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/6] refs: drop unused params from the reflog iterator
 callback
Message-ID: <be512ef268b910852ff11df181d89c483ffc18ab.1708353264.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZaosCmxaEKclmNEP"
Content-Disposition: inline
In-Reply-To: <cover.1708353264.git.ps@pks.im>


--ZaosCmxaEKclmNEP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ref and reflog iterators share much of the same underlying code to
iterate over the corresponding entries. This results in some weird code
because the reflog iterator also exposes an object ID as well as a flag
to the callback function. Neither of these fields do refer to the reflog
though -- they refer to the corresponding ref with the same name. This
is quite misleading. In practice at least the object ID cannot really be
implemented in any other way as a reflog does not have a specific object
ID in the first place. This is further stressed by the fact that none of
the callbacks except for our test helper make use of these fields.

Split up the infrastucture so that ref and reflog iterators use separate
callback signatures. This allows us to drop the nonsensical fields from
the reflog iterator.

Note that internally, the backends still use the same shared infra to
iterate over both types. As the backends should never end up being
called directly anyway, this is not much of a problem and thus kept
as-is for simplicity's sake.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c                 |  4 +---
 builtin/reflog.c               |  3 +--
 refs.c                         | 23 +++++++++++++++++++----
 refs.h                         | 11 +++++++++--
 refs/files-backend.c           |  8 +-------
 refs/reftable-backend.c        |  8 +-------
 revision.c                     |  4 +---
 t/helper/test-ref-store.c      | 18 ++++++++++++------
 t/t0600-reffiles-backend.sh    | 24 ++++++++++++------------
 t/t1405-main-ref-store.sh      |  8 ++++----
 t/t1406-submodule-ref-store.sh |  8 ++++----
 11 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index a7cf94f67e..f892487c9b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -509,9 +509,7 @@ static int fsck_handle_reflog_ent(struct object_id *ooi=
d, struct object_id *noid
 	return 0;
 }
=20
-static int fsck_handle_reflog(const char *logname,
-			      const struct object_id *oid UNUSED,
-			      int flag UNUSED, void *cb_data)
+static int fsck_handle_reflog(const char *logname, void *cb_data)
 {
 	struct strbuf refname =3D STRBUF_INIT;
=20
diff --git a/builtin/reflog.c b/builtin/reflog.c
index a5a4099f61..3a0c4d4322 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -60,8 +60,7 @@ struct worktree_reflogs {
 	struct string_list reflogs;
 };
=20
-static int collect_reflog(const char *ref, const struct object_id *oid UNU=
SED,
-			  int flags UNUSED, void *cb_data)
+static int collect_reflog(const char *ref, void *cb_data)
 {
 	struct worktree_reflogs *cb =3D cb_data;
 	struct worktree *worktree =3D cb->worktree;
diff --git a/refs.c b/refs.c
index fff343c256..6d76000f13 100644
--- a/refs.c
+++ b/refs.c
@@ -2516,18 +2516,33 @@ int refs_verify_refname_available(struct ref_store =
*refs,
 	return ret;
 }
=20
-int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_=
data)
+struct do_for_each_reflog_help {
+	each_reflog_fn *fn;
+	void *cb_data;
+};
+
+static int do_for_each_reflog_helper(struct repository *r UNUSED,
+				     const char *refname,
+				     const struct object_id *oid UNUSED,
+				     int flags,
+				     void *cb_data)
+{
+	struct do_for_each_reflog_help *hp =3D cb_data;
+	return hp->fn(refname, hp->cb_data);
+}
+
+int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *=
cb_data)
 {
 	struct ref_iterator *iter;
-	struct do_for_each_ref_help hp =3D { fn, cb_data };
+	struct do_for_each_reflog_help hp =3D { fn, cb_data };
=20
 	iter =3D refs->be->reflog_iterator_begin(refs);
=20
 	return do_for_each_repo_ref_iterator(the_repository, iter,
-					     do_for_each_ref_helper, &hp);
+					     do_for_each_reflog_helper, &hp);
 }
=20
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+int for_each_reflog(each_reflog_fn fn, void *cb_data)
 {
 	return refs_for_each_reflog(get_main_ref_store(the_repository), fn, cb_da=
ta);
 }
diff --git a/refs.h b/refs.h
index 303c5fac4d..895579aeb7 100644
--- a/refs.h
+++ b/refs.h
@@ -534,12 +534,19 @@ int for_each_reflog_ent(const char *refname, each_ref=
log_ent_fn fn, void *cb_dat
 /* youngest entry first */
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn=
, void *cb_data);
=20
+/*
+ * The signature for the callback function for the {refs_,}for_each_reflog=
()
+ * functions below. The memory pointed to by the refname argument is only
+ * guaranteed to be valid for the duration of a single callback invocation.
+ */
+typedef int each_reflog_fn(const char *refname, void *cb_data);
+
 /*
  * Calls the specified function for each reflog file until it returns nonz=
ero,
  * and returns the value. Reflog file order is unspecified.
  */
-int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_=
data);
-int for_each_reflog(each_ref_fn fn, void *cb_data);
+int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *=
cb_data);
+int for_each_reflog(each_reflog_fn fn, void *cb_data);
=20
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2ffc63185f..2b3c99b00d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2116,10 +2116,8 @@ static int files_for_each_reflog_ent(struct ref_stor=
e *ref_store,
=20
 struct files_reflog_iterator {
 	struct ref_iterator base;
-
 	struct ref_store *ref_store;
 	struct dir_iterator *dir_iterator;
-	struct object_id oid;
 };
=20
 static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
@@ -2130,8 +2128,6 @@ static int files_reflog_iterator_advance(struct ref_i=
terator *ref_iterator)
 	int ok;
=20
 	while ((ok =3D dir_iterator_advance(diter)) =3D=3D ITER_OK) {
-		int flags;
-
 		if (!S_ISREG(diter->st.st_mode))
 			continue;
 		if (diter->basename[0] =3D=3D '.')
@@ -2141,14 +2137,12 @@ static int files_reflog_iterator_advance(struct ref=
_iterator *ref_iterator)
=20
 		if (!refs_resolve_ref_unsafe(iter->ref_store,
 					     diter->relative_path, 0,
-					     &iter->oid, &flags)) {
+					     NULL, NULL)) {
 			error("bad ref for %s", diter->path.buf);
 			continue;
 		}
=20
 		iter->base.refname =3D diter->relative_path;
-		iter->base.oid =3D &iter->oid;
-		iter->base.flags =3D flags;
 		return ITER_OK;
 	}
=20
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a14f2ad7f4..889bb1f1ba 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1637,7 +1637,6 @@ struct reftable_reflog_iterator {
 	struct reftable_ref_store *refs;
 	struct reftable_iterator iter;
 	struct reftable_log_record log;
-	struct object_id oid;
 	char *last_name;
 	int err;
 };
@@ -1648,8 +1647,6 @@ static int reftable_reflog_iterator_advance(struct re=
f_iterator *ref_iterator)
 		(struct reftable_reflog_iterator *)ref_iterator;
=20
 	while (!iter->err) {
-		int flags;
-
 		iter->err =3D reftable_iterator_next_log(&iter->iter, &iter->log);
 		if (iter->err)
 			break;
@@ -1663,7 +1660,7 @@ static int reftable_reflog_iterator_advance(struct re=
f_iterator *ref_iterator)
 			continue;
=20
 		if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->log.refname,
-					     0, &iter->oid, &flags)) {
+					     0, NULL, NULL)) {
 			error(_("bad ref for %s"), iter->log.refname);
 			continue;
 		}
@@ -1671,8 +1668,6 @@ static int reftable_reflog_iterator_advance(struct re=
f_iterator *ref_iterator)
 		free(iter->last_name);
 		iter->last_name =3D xstrdup(iter->log.refname);
 		iter->base.refname =3D iter->log.refname;
-		iter->base.oid =3D &iter->oid;
-		iter->base.flags =3D flags;
=20
 		break;
 	}
@@ -1725,7 +1720,6 @@ static struct reftable_reflog_iterator *reflog_iterat=
or_for_stack(struct reftabl
 	iter =3D xcalloc(1, sizeof(*iter));
 	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable, 1);
 	iter->refs =3D refs;
-	iter->base.oid =3D &iter->oid;
=20
 	ret =3D refs->err;
 	if (ret)
diff --git a/revision.c b/revision.c
index 2424c9bd67..ac45c6d8f2 100644
--- a/revision.c
+++ b/revision.c
@@ -1686,9 +1686,7 @@ static int handle_one_reflog_ent(struct object_id *oo=
id, struct object_id *noid,
 	return 0;
 }
=20
-static int handle_one_reflog(const char *refname_in_wt,
-			     const struct object_id *oid UNUSED,
-			     int flag UNUSED, void *cb_data)
+static int handle_one_reflog(const char *refname_in_wt, void *cb_data)
 {
 	struct all_refs_cb *cb =3D cb_data;
 	struct strbuf refname =3D STRBUF_INIT;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 702ec1f128..7a0f6cac53 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -221,15 +221,21 @@ static int cmd_verify_ref(struct ref_store *refs, con=
st char **argv)
 	return ret;
 }
=20
+static int each_reflog(const char *refname, void *cb_data UNUSED)
+{
+	printf("%s\n", refname);
+	return 0;
+}
+
 static int cmd_for_each_reflog(struct ref_store *refs,
 			       const char **argv UNUSED)
 {
-	return refs_for_each_reflog(refs, each_ref, NULL);
+	return refs_for_each_reflog(refs, each_reflog, NULL);
 }
=20
-static int each_reflog(struct object_id *old_oid, struct object_id *new_oi=
d,
-		       const char *committer, timestamp_t timestamp,
-		       int tz, const char *msg, void *cb_data UNUSED)
+static int each_reflog_ent(struct object_id *old_oid, struct object_id *ne=
w_oid,
+			   const char *committer, timestamp_t timestamp,
+			   int tz, const char *msg, void *cb_data UNUSED)
 {
 	printf("%s %s %s %" PRItime " %+05d%s%s", oid_to_hex(old_oid),
 	       oid_to_hex(new_oid), committer, timestamp, tz,
@@ -241,14 +247,14 @@ static int cmd_for_each_reflog_ent(struct ref_store *=
refs, const char **argv)
 {
 	const char *refname =3D notnull(*argv++, "refname");
=20
-	return refs_for_each_reflog_ent(refs, refname, each_reflog, refs);
+	return refs_for_each_reflog_ent(refs, refname, each_reflog_ent, refs);
 }
=20
 static int cmd_for_each_reflog_ent_reverse(struct ref_store *refs, const c=
har **argv)
 {
 	const char *refname =3D notnull(*argv++, "refname");
=20
-	return refs_for_each_reflog_ent_reverse(refs, refname, each_reflog, refs);
+	return refs_for_each_reflog_ent_reverse(refs, refname, each_reflog_ent, r=
efs);
 }
=20
 static int cmd_reflog_exists(struct ref_store *refs, const char **argv)
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 4f860285cc..56a3196b83 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -287,23 +287,23 @@ test_expect_success 'for_each_reflog()' '
 	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
 	echo $ZERO_OID > .git/worktrees/wt/logs/refs/bisect/wt-random &&
=20
-	$RWT for-each-reflog | cut -d" " -f 2- >actual &&
+	$RWT for-each-reflog >actual &&
 	cat >expected <<-\EOF &&
-	HEAD 0x1
-	PSEUDO-WT 0x0
-	refs/bisect/wt-random 0x0
-	refs/heads/main 0x0
-	refs/heads/wt-main 0x0
+	HEAD
+	PSEUDO-WT
+	refs/bisect/wt-random
+	refs/heads/main
+	refs/heads/wt-main
 	EOF
 	test_cmp expected actual &&
=20
-	$RMAIN for-each-reflog | cut -d" " -f 2- >actual &&
+	$RMAIN for-each-reflog >actual &&
 	cat >expected <<-\EOF &&
-	HEAD 0x1
-	PSEUDO-MAIN 0x0
-	refs/bisect/random 0x0
-	refs/heads/main 0x0
-	refs/heads/wt-main 0x0
+	HEAD
+	PSEUDO-MAIN
+	refs/bisect/random
+	refs/heads/main
+	refs/heads/wt-main
 	EOF
 	test_cmp expected actual
 '
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index cfb583f544..3eee758bce 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -74,11 +74,11 @@ test_expect_success 'verify_ref(new-main)' '
 '
=20
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | cut -d" " -f 2- >actual &&
+	$RUN for-each-reflog >actual &&
 	cat >expected <<-\EOF &&
-	HEAD 0x1
-	refs/heads/main 0x0
-	refs/heads/new-main 0x0
+	HEAD
+	refs/heads/main
+	refs/heads/new-main
 	EOF
 	test_cmp expected actual
 '
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 40332e23cc..c01f0f14a1 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -63,11 +63,11 @@ test_expect_success 'verify_ref(new-main)' '
 '
=20
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | cut -d" " -f 2- >actual &&
+	$RUN for-each-reflog >actual &&
 	cat >expected <<-\EOF &&
-	HEAD 0x1
-	refs/heads/main 0x0
-	refs/heads/new-main 0x0
+	HEAD
+	refs/heads/main
+	refs/heads/new-main
 	EOF
 	test_cmp expected actual
 '
--=20
2.44.0-rc1


--ZaosCmxaEKclmNEP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXTZzIACgkQVbJhu7ck
PpQUAQ/+PilPJFV4giF9ATYEudVA935wkinQx7jXrsamINagn5RodmIbmMcFW6an
+0qCe6jODGfJwVDLvBX80d4UnyY2msbHFSp8njL/uaK0zS25EpMXMcIC5uo6K54v
AAhikKVP3DUkIyFX40wkUlk1HbwTEzPTFUBfn3npJartBSrT+cpXe+vEXmuXRVB+
NwBgOTzcfWuLByAxeb+OYHM0ctPpDbT+Q1t+GO2v/3zEeqvUPmmM4TbvncESEpMc
5evq2MPRJd+H0DVLyYQs6O4A6LELcHLchZDcdKNANJMH0nkqNavn8jMpborC0d/I
bixg/rNSYrFSiA5MxOtIlw/sl+dq5rsOCEuWrAD1n9hqisfD0T+IfhhqGKVKLnRc
1kH4YipMWXv4DWB3ui/rMfVxLGyKIje1wUB2BbM8GYEC3MlKKxfAeCXF2L70pe+B
ci4u4SW/i5Q+bxgQX2O5T6685Ph5m8D+CzfA3dCnk4jPW64rS/cORQzYuini4qzJ
dJUPD2mD8zj6E2uBhjR/PZQVj7TIAKAvGrRbXF/tvBOZy5RE3wZrHTpbVfzr2PCu
TtkxAOGdnLQrgLoHPUVJq9quQGoTSehHOBNHE9bhazJKr+0L+wx3JZEnIi4lcxTv
WmQ87L1VagwBBVw2CxlNAayptFGKOWuInNP1DHLhAiG1ZlrHft0=
=SSwN
-----END PGP SIGNATURE-----

--ZaosCmxaEKclmNEP--
