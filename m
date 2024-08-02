Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0122615
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577108; cv=none; b=fxqDgMtxiEBtqfvWysQjVO0+yTMP/PkL9J9UiWe5wVJFygY1SXfk333k7aPaYtoMzKa0ymrtLuXqTSk3Ccp5WG3jC79xnBFTvtbSTZNT7fs9tCxizDulfmXiUuKudnOZN4iSubiW9Lb7K7/AoUjkJtBR8Es8Pk99e/LhufKSkAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577108; c=relaxed/simple;
	bh=YyuxTjI+8fLZZZOx+TgWEZZqzCnksNdjDZVqXuFSjDs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kPdq4TKJQwGZTNvp/wKd4lLKISIjmldaokEpWHwZfR/iAntY1fQxYwuxYviWkPJQPIL4SBSLTmPEY/Hj83zGrHHfZJBWxc59tPN8uLtuUbWJeQptcR38K3e9t9wKjS8EbvXDigKtSCIr++9IJ+o5iUHA9hsF9nPVNqrId7OCi/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iY+ibn3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kxJoZLZG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iY+ibn3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kxJoZLZG"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CF9C01151AC5
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 01:38:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 02 Aug 2024 01:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1722577103; x=1722663503; bh=rudoq8oLuD9/tEAkH1yGZaxopVX4IBvx
	VRMWF9E7nmo=; b=iY+ibn3+Lq9vyeKvxCu9G7lPP0DKPRMel38axevycW6rbS9O
	6apcFIefsauG+4fyVpL6YBx/w7Bd7WWWgmRgiPEvnGIOM86qfZYSyhW3IObJgXgi
	3ya1RUALYxaLAVSGxbpKQ/3R9xfDTYNdxAdLJtwyE2Ga9hzIV/PebuNhg92dJ3rE
	8KN8zNBbeQEwSIIqVz0OK+niCUK6LH1+BI2vIjG6RNnUJ2OZdY+EvT4cajQy7Jfb
	xH7binKyqu3q8yEwJEfMHAC8ZtTcuXymqOE14hgamH0OrNJMaUA52RoT/e3numG6
	ZJlvYJflvRvV7SglWqlaiKyHGk3iiIIJwoN34w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1722577103; x=1722663503; bh=rudoq8oLuD9/tEAkH1yGZaxopVX4IBvxVRM
	WF9E7nmo=; b=kxJoZLZGRPBoS3c1h28ZcVBi02yA/qO4UzdDhgt5fbGWiqXUaah
	cLsvmdw1W0u+1aVELxkkqCZ5T3IaGdOUazd8zry+fskx/MBPekoYfM4cPVf2HfNq
	lJgk1YoZkAu7F1WXjGlrzo9h23iRbhzuX3Mtpc4kheapXu8XQtfjZVuHTJCaEohZ
	Pyw9N+e5Usz7j9VMTHitJeYE27/asE7bXr73L6WpeiE9RdcaQRyg+05ieicu+KBX
	imtf8cS9alMp+AQzdlqWca+zugB610SNqMPaGSB1SWmG7h1Bx6PK/ThLc8N23iUz
	itvX9yWsdldD9Mtse1AAH+zqEwDbXf3YxDg==
X-ME-Sender: <xms:z3CsZgcCmDe64H4KcltsjoDc7ZXnvXel34YrDSwInDDNH7qhBiS6Tg>
    <xme:z3CsZiND9XULK8jAIoYXyJE3PJvFP9sYBJOeV3L2oV7P9otRfHpzZS97z5RtmWN_Q
    I-v2-qM1mWPJiHX-w>
X-ME-Received: <xmr:z3CsZhhgY8kZ7HAMPs6ICV0hS0XQ_OH0p4xVAGuarNo6Acmr3piE6jHEkTKXPwZ2AUt8meuFhn8KU4wfEychj3hjwE9M6jvULDa6ssfp5RN0SXxu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeelgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:z3CsZl_mqLKhSHDV9LOfVkVjSM0WledxkzQdJhW_4nfsKUQAmhT5wA>
    <xmx:z3CsZss0u85yXN5RKmpuCI_EWI1QrAlpsAKxTHcoiskLRfRgdMOY-w>
    <xmx:z3CsZsF4Lm2lILtJIw0dZpEMMc3ebFeW7HicBW3dHz4wCggdHuPrXg>
    <xmx:z3CsZrNh0F-CiG6oT3lI6i3mIj9n1e03UnNqijvD4ZrgcetzLm7TQg>
    <xmx:z3CsZpW-7FZtE8vtPS_RvTS555jG0tJ98tAlgY6eLRnlkLRXRqy3tStv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Aug 2024 01:38:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 09d9670c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Aug 2024 05:36:48 +0000 (UTC)
Date: Fri, 2 Aug 2024 07:38:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH] refs: drop `ref_store`-less functions
Message-ID: <1d9add71065dabb3d7bf81529d04afbcf91e3a69.1722577074.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WbRm8YS67izrCbr/"
Content-Disposition: inline


--WbRm8YS67izrCbr/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In c8f815c208 (refs: remove functions without ref store, 2024-05-07), we
have removed functions of the refs subsystem that do not take a ref
store as input parameter. In order to make it easier for folks to figure
out how to replace calls to such functions in in-flight patch series, we
kept their definitions around in an ifdeffed block.

Now that Git v2.46 is out, it is rather unlikely that anybody still has
references to these old functions in their unreleased patches. Let's
thus drop them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h | 207 ---------------------------------------------------------
 1 file changed, 207 deletions(-)

diff --git a/refs.h b/refs.h
index b3e39bc257..9fbd2cdb2c 100644
--- a/refs.h
+++ b/refs.h
@@ -1086,211 +1086,4 @@ int repo_migrate_ref_storage_format(struct reposito=
ry *repo,
 				    unsigned int flags,
 				    struct strbuf *err);
=20
-/*
- * The following functions have been removed in Git v2.46 in favor of func=
tions
- * that receive a `ref_store` as parameter. The intent of this section is
- * merely to help patch authors of in-flight series to have a reference wh=
at
- * they should be migrating to. The section will be removed in Git v2.47.
- */
-#if 0
-static char *resolve_refdup(const char *refname, int resolve_flags,
-			    struct object_id *oid, int *flags)
-{
-	return refs_resolve_refdup(get_main_ref_store(the_repository),
-				   refname, resolve_flags,
-				   oid, flags);
-}
-
-static int read_ref_full(const char *refname, int resolve_flags,
-			 struct object_id *oid, int *flags)
-{
-	return refs_read_ref_full(get_main_ref_store(the_repository), refname,
-				  resolve_flags, oid, flags);
-}
-
-static int read_ref(const char *refname, struct object_id *oid)
-{
-	return refs_read_ref(get_main_ref_store(the_repository), refname, oid);
-}
-
-static int ref_exists(const char *refname)
-{
-	return refs_ref_exists(get_main_ref_store(the_repository), refname);
-}
-
-static int for_each_tag_ref(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_tag_ref(get_main_ref_store(the_repository), fn, cb_d=
ata);
-}
-
-static int for_each_branch_ref(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_branch_ref(get_main_ref_store(the_repository), fn, c=
b_data);
-}
-
-static int for_each_remote_ref(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_remote_ref(get_main_ref_store(the_repository), fn, c=
b_data);
-}
-
-static int head_ref_namespaced(each_ref_fn fn, void *cb_data)
-{
-	return refs_head_ref_namespaced(get_main_ref_store(the_repository),
-					fn, cb_data);
-}
-
-static int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
-				const char *prefix, void *cb_data)
-{
-	return refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-					 fn, pattern, prefix, cb_data);
-}
-
-static int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb=
_data)
-{
-	return refs_for_each_glob_ref(get_main_ref_store(the_repository),
-				      fn, pattern, cb_data);
-}
-
-static int delete_ref(const char *msg, const char *refname,
-		      const struct object_id *old_oid, unsigned int flags)
-{
-	return refs_delete_ref(get_main_ref_store(the_repository), msg, refname,
-			       old_oid, flags);
-}
-
-static struct ref_transaction *ref_transaction_begin(struct strbuf *err)
-{
-	return ref_store_transaction_begin(get_main_ref_store(the_repository), er=
r);
-}
-
-static int update_ref(const char *msg, const char *refname,
-		      const struct object_id *new_oid,
-		      const struct object_id *old_oid,
-		      unsigned int flags, enum action_on_err onerr)
-{
-	return refs_update_ref(get_main_ref_store(the_repository), msg, refname, =
new_oid,
-			       old_oid, flags, onerr);
-}
-
-static char *shorten_unambiguous_ref(const char *refname, int strict)
-{
-	return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
-					    refname, strict);
-}
-
-static int head_ref(each_ref_fn fn, void *cb_data)
-{
-	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
-}
-
-static int for_each_ref(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_ref(get_main_ref_store(the_repository), fn, cb_data);
-}
-
-static int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_da=
ta)
-{
-	return refs_for_each_ref_in(get_main_ref_store(the_repository), prefix, f=
n, cb_data);
-}
-
-static int for_each_fullref_in(const char *prefix,
-			       const char **exclude_patterns,
-			       each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_fullref_in(get_main_ref_store(the_repository),
-					prefix, exclude_patterns, fn, cb_data);
-}
-
-static int for_each_namespaced_ref(const char **exclude_patterns,
-				   each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
-					    exclude_patterns, fn, cb_data);
-}
-
-static int for_each_rawref(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_da=
ta);
-}
-
-static const char *resolve_ref_unsafe(const char *refname, int resolve_fla=
gs,
-				      struct object_id *oid, int *flags)
-{
-	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refnam=
e,
-				       resolve_flags, oid, flags);
-}
-
-static int create_symref(const char *ref_target, const char *refs_heads_ma=
ster,
-			 const char *logmsg)
-{
-	return refs_create_symref(get_main_ref_store(the_repository), ref_target,
-				  refs_heads_master, logmsg);
-}
-
-static int for_each_reflog(each_reflog_fn fn, void *cb_data)
-{
-	return refs_for_each_reflog(get_main_ref_store(the_repository), fn, cb_da=
ta);
-}
-
-static int for_each_reflog_ent_reverse(const char *refname, each_reflog_en=
t_fn fn,
-				       void *cb_data)
-{
-	return refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository=
),
-						refname, fn, cb_data);
-}
-
-static int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
-			       void *cb_data)
-{
-	return refs_for_each_reflog_ent(get_main_ref_store(the_repository), refna=
me,
-					fn, cb_data);
-}
-
-static int reflog_exists(const char *refname)
-{
-	return refs_reflog_exists(get_main_ref_store(the_repository), refname);
-}
-
-static int safe_create_reflog(const char *refname, struct strbuf *err)
-{
-	return refs_create_reflog(get_main_ref_store(the_repository), refname,
-				  err);
-}
-
-static int delete_reflog(const char *refname)
-{
-	return refs_delete_reflog(get_main_ref_store(the_repository), refname);
-}
-
-static int reflog_expire(const char *refname,
-			 unsigned int flags,
-			 reflog_expiry_prepare_fn prepare_fn,
-			 reflog_expiry_should_prune_fn should_prune_fn,
-			 reflog_expiry_cleanup_fn cleanup_fn,
-			 void *policy_cb_data)
-{
-	return refs_reflog_expire(get_main_ref_store(the_repository),
-				  refname, flags,
-				  prepare_fn, should_prune_fn,
-				  cleanup_fn, policy_cb_data);
-}
-
-static int delete_refs(const char *msg, struct string_list *refnames,
-		       unsigned int flags)
-{
-	return refs_delete_refs(get_main_ref_store(the_repository), msg, refnames=
, flags);
-}
-
-static int rename_ref(const char *oldref, const char *newref, const char *=
logmsg)
-{
-	return refs_rename_ref(get_main_ref_store(the_repository), oldref, newref=
, logmsg);
-}
-
-static int copy_existing_ref(const char *oldref, const char *newref, const=
 char *logmsg)
-{
-	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref,=
 newref, logmsg);
-}
-#endif
-
 #endif /* REFS_H */
--=20
2.46.0.dirty


--WbRm8YS67izrCbr/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmascMoACgkQVbJhu7ck
PpSk6A//draSxx+yzGmNiqBTRLGOUX8cqUYgxK/A4pa4C9fu8H815UVXIGSJdAh6
Jp4WtNmkzN/vIL/DiLj5mPrVNh8xLns949Bu0htACVVul5E9QnQTTFCaOgsgaSwt
G0XnR8qHabFPjx7WTGNKtTPR58bx+zyzg97MxojRjlOlNMXtkiqtI11uZ6Lrw/zn
ZAjuFgzvOr2DQbYJhE8wdbezpCCoM2gZAsdhHT7jsHcM08vQVOU9LHyjmEPoPntz
vKSg9tpwPt0NPGjk0bvtu4XQ+8A/Zx9zNLaD3JcKPXsovBIUrDeiAHbdcajaKz+p
H7Fcs6PxgKgvOuVerVHhPacFJy3j6ZzGEqkxrl337QeOwFIljCzgD4CkS0JYfoZU
y59RV9mRLN8AdDOXH/3siof0Mr13HZAL6cIHQnudgtdXkfluO4ggavfAuhOlYgb2
T6c3McAPBvYrP7FKVTvVjQggMhbNBSqq9Qw8Zc1sZ0yacXmaiDQ7pfH3pkLDcM9e
S3ihLWKJqRVQ5wIdeJ+dgz80+EzDdaUEgoB9HLqfslQZTb0UdtKgMcKyNlGn1yj8
WjzvqLgV3ALx50cPCTYIGOqemvGuEWDk01sWEXJmC9sbKGxON3uRX5GKoqJAE5/I
evkDLD+qNZfoSsd+F0DW46yq7+dfFGHd0pp6aA1LwuwLrCGlKj0=
=1adD
-----END PGP SIGNATURE-----

--WbRm8YS67izrCbr/--
