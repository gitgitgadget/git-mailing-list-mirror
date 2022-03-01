Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C11FC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiCAJex (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiCAJeu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:34:50 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5B5F8F4
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:33:49 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3EA785C021A;
        Tue,  1 Mar 2022 04:33:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Mar 2022 04:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=342M7DnLmCkA4aADhmXNC72DSdxDUizWZpcAKm
        iiTdE=; b=Jn7246bPmfjiRKIDmHmO7Nng5GPPdg5C34/z0MkvkWcKciQbWCH1cK
        /KEmmqN4icndt4DOy8te9+acQDZlE9EhZon4oxfZDmcddNIggqNLgN8x44GhBSNI
        hfbIYSqU+orETTF0q/2VQIvPUJnOg7TvPc89//eyzmYsoYwv0EnqMcxliPONm9Hq
        CJzN9A+F9AFMrys5PNCtlpNXJpV4esGfENSeLolg1Az3h+XsMflDVPNVBbNiTFqY
        MUPIzpwbZiAxTgJr/2t1RJEhlACkIKKpoRMmvSbUGOywqsThtYtVcdoBgmAG6prs
        brhG3m7eYlNt5Vfd0AyXt5DbLb/uZ8tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=342M7DnLmCkA4aADh
        mXNC72DSdxDUizWZpcAKmiiTdE=; b=j8jOwqp0QhFktk9C45Qo5qhhLJqlK3Iqf
        iLOJW70XoTWP3hVzllLhlCzlcFWsZggTN56004RbVp6Ku2Ph7wM5WCQfw+640crW
        4RNbfwYignLT31HYrqqNfsq2GFI8yK9o8giiZuVj+oCEOk2AyQhPL+Wq2XaB8r2T
        4UO5yj2t03qFAt2mW5p3BOpC4XzVDIYQDCSrFpRaf6yebYTGqEHiIovfXdvvZw+Q
        IjwR/XtGEpKWPI3lnrMxyoByr7dlTu1cvUn+oNaxuZM78HvYLromwd44sBELU2Fb
        UUAugtTGxD/oKw7MDHC1QIRttGiAa8z2XD64c1nKYjHa8f5hk+eog==
X-ME-Sender: <xms:fOgdYkyu129V0Yjbm7bUvEIJFrxlGDq-cL4XisAnTWYYp0ksls_igA>
    <xme:fOgdYoSac0O5HTfizaXWbvd6NKdsdqUjlPwYF8e-cpSEaHMNuEQi8J5zsGH4kr5k3
    54iHZVPZF0gO2ydww>
X-ME-Received: <xmr:fOgdYmW6G3afOrtTOdODvyGvU2nOUwWYXf2DIjKASdLPTfc-_pQfhNSIXsaK2HCN0XlvwW_K2ytGeTEU-vr2oynY2t9Osxb9jQ8-tXq6ZrV8tp6YJ2dxRUCv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:fOgdYiiHROOHO1TX72NBftA3WOwR_KZYFcyoamquM2Qp9B7yX1XMdg>
    <xmx:fOgdYmBAv9pohN7t_kauiO9Hb8jMikO0OI8La8tumBsqOTK4jg9WJQ>
    <xmx:fOgdYjJFqxBraG-gq0icj71tcc4Z0Ag97qZyTl2H7Ufgz4KHAXwgGw>
    <xmx:fOgdYhrfPUYxSjPcq0l8maPLteWQZXWWo9VVG9-ifoBzRdr-w6XnWw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 04:33:47 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c950ba61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 09:33:47 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:33:46 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 3/5] refs: add ability for backends to special-case
 reading of symbolic refs
Message-ID: <29eb81d37c8fef63858d8e066795e308692d219c.1646127015.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
 <cover.1646127015.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZOQnAlKm9xeDTzed"
Content-Disposition: inline
In-Reply-To: <cover.1646127015.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZOQnAlKm9xeDTzed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reading of symbolic and non-symbolic references is currently treated the
same in reference backends: we always call `refs_read_raw_ref()` and
then decide based on the returned flags what type it is. This has one
downside though: symbolic references may be treated different from
normal references in a backend from normal references. The packed-refs
backend for example doesn't even know about symbolic references, and as
a result it is pointless to even ask it for one.

There are cases where we really only care about whether a reference is
symbolic or not, but don't care about whether it exists at all or may be
a non-symbolic reference. But it is not possible to optimize for this
case right now, and as a consequence we will always first check for a
loose reference to exist, and if it doesn't, we'll query the packed-refs
backend for a known-to-not-be-symbolic reference. This is inefficient
and requires us to search all packed references even though we know to
not care for the result at all.

Introduce a new function `refs_read_symbolic_ref()` which allows us to
fix this case. This function will only ever return symbolic references
and can thus optimize for the scenario layed out above. By default, if
the backend doesn't provide an implementation for it, we just use the
old code path and fall back to `read_raw_ref()`. But in case the backend
provides its own, more efficient implementation, we will use that one
instead.

Note that this function is explicitly designed to not distinguish
between missing references and non-symbolic references. If it did, we'd
be forced to always search the packed-refs backend to see whether the
symbolic reference the user asked for really doesn't exist, or if it
exists as a non-symbolic reference.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                | 17 +++++++++++++++++
 refs.h                |  3 +++
 refs/debug.c          |  1 +
 refs/files-backend.c  |  1 +
 refs/packed-backend.c |  1 +
 refs/refs-internal.h  | 16 ++++++++++++++++
 6 files changed, 39 insertions(+)

diff --git a/refs.c b/refs.c
index 1598fb13e2..0b79bdd7c3 100644
--- a/refs.c
+++ b/refs.c
@@ -1673,6 +1673,23 @@ int refs_read_raw_ref(struct ref_store *ref_store, c=
onst char *refname,
 					   type, failure_errno);
 }
=20
+int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refnam=
e,
+			   struct strbuf *referent)
+{
+	struct object_id oid;
+	int ret, failure_errno =3D 0;
+	unsigned int type =3D 0;
+
+	if (ref_store->be->read_symbolic_ref)
+		return ref_store->be->read_symbolic_ref(ref_store, refname, referent);
+
+	ret =3D refs_read_raw_ref(ref_store, refname, &oid, referent, &type, &fai=
lure_errno);
+	if (ret || !(type & REF_ISSYMREF))
+		return -1;
+
+	return 0;
+}
+
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
diff --git a/refs.h b/refs.h
index 1ae12c410a..23479c7ee0 100644
--- a/refs.h
+++ b/refs.h
@@ -82,6 +82,9 @@ int read_ref_full(const char *refname, int resolve_flags,
 		  struct object_id *oid, int *flags);
 int read_ref(const char *refname, struct object_id *oid);
=20
+int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refnam=
e,
+			   struct strbuf *referent);
+
 /*
  * Return 0 if a reference named refname could be created without
  * conflicting with the name of an existing reference. Otherwise,
diff --git a/refs/debug.c b/refs/debug.c
index 2b0771ca53..c590d37720 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -435,6 +435,7 @@ struct ref_storage_be refs_be_debug =3D {
=20
 	debug_ref_iterator_begin,
 	debug_read_raw_ref,
+	NULL,
=20
 	debug_reflog_iterator_begin,
 	debug_for_each_reflog_ent,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f59589d6cc..f3428a9f12 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3286,6 +3286,7 @@ struct ref_storage_be refs_be_files =3D {
=20
 	files_ref_iterator_begin,
 	files_read_raw_ref,
+	NULL,
=20
 	files_reflog_iterator_begin,
 	files_for_each_reflog_ent,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 27dd8c3922..f56e2cc635 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1684,6 +1684,7 @@ struct ref_storage_be refs_be_packed =3D {
=20
 	packed_ref_iterator_begin,
 	packed_read_raw_ref,
+	NULL,
=20
 	packed_reflog_iterator_begin,
 	packed_for_each_reflog_ent,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6e15db3ca4..001ef15835 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -649,6 +649,21 @@ typedef int read_raw_ref_fn(struct ref_store *ref_stor=
e, const char *refname,
 			    struct object_id *oid, struct strbuf *referent,
 			    unsigned int *type, int *failure_errno);
=20
+/*
+ * Read a symbolic reference from the specified reference store. This func=
tion
+ * is optional: if not implemented by a backend, then `read_raw_ref_fn` is=
 used
+ * to read the symbolcic reference instead. It is intended to be implement=
ed
+ * only in case the backend can optimize the reading of symbolic reference=
s.
+ *
+ * Return 0 on success, or -1 on failure. `referent` will be set to the ta=
rget
+ * of the symbolic reference on success. This function explicitly does not
+ * distinguish between error cases and the reference not being a symbolic
+ * reference to allow backends to optimize this operation in case symbolic=
 and
+ * non-symbolic references are treated differently.
+ */
+typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *=
refname,
+				 struct strbuf *referent);
+
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
@@ -668,6 +683,7 @@ struct ref_storage_be {
=20
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
+	read_symbolic_ref_fn *read_symbolic_ref;
=20
 	reflog_iterator_begin_fn *reflog_iterator_begin;
 	for_each_reflog_ent_fn *for_each_reflog_ent;
--=20
2.35.1


--ZOQnAlKm9xeDTzed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId6HkACgkQVbJhu7ck
PpQa/xAAnBCJkMY0aZXTo9nOeiBRLzzWSPNLq7iiDQDb/o3i3l2QKK9L9oIHE0vj
thubbqb1p4Ptmov60bDOEebMb+Qtv78R8Rt15fyZCIqusrpSsGazOQp/7ni329zb
wc9t5dcWx5PIt+EEhrmubc6B5zaKzHePUe4LRRglnsx0FUwKXF2JI5f7lpwrdT9b
CoEgFswTzpVSpd3O/gZ16lDLaIP6pgcmfc2llPB/72EAhndiZEzfQfg85I9x2c1B
OPpMtkXy7yNVV1c6mMLEC0stNtiWIs28xfKr9DYzg2wtNFibwqlDcriW/qOBv+9Y
GJ2GaW7RcQA11EfRVp/Pb7l0DYh8DWqLAsniHSuUxKIQkinAEIE1TzPppYlfdUho
Is72REcyhOa7bV03a3jwbHLhnvMpUPfppfUEwndip0p01QqlNhEjD5pqdBT0DUpz
Gh3MNUHLRi5XIV7gP8ffCdGw5DKSDjXj2urWrijn9xM+75z40Yx5f1bG5h4p0r1p
mnNqkNS8g3oxhldgP2CTuaoj95g3lZnQx3gkyj6hsYI78X/ctPmuFA013z20ETNw
n2LhCLSX8dUNKd20XCbO1H97oeVKlQpU6VjW3BfcZHunHhlQhJ8lnQ7NclRyeNq0
A2+zi0ez+fQUtCFv6FOC2eLhtp41xATfZE83lkzydrvrATL6SwU=
=OxHD
-----END PGP SIGNATURE-----

--ZOQnAlKm9xeDTzed--
