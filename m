Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27140C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 12:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbiBWMgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbiBWMgG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 07:36:06 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB2D9E9DC
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:35:38 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DCFD53201464
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 23 Feb 2022 07:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=VO041jxTbrMxPNE4/i+uf8ccmMznPA7J/VmHh3
        Xrjto=; b=LRGjQT3dGkkiJP2CSDv3WPSwkA1y46qSxmtPXUR7Cpq32/Suww98xT
        BdCsFXYD78ZjAy4YBg4/re7uZ/wrGwmp2hoPXG5qbAkxU1iiqmCG4Vnr+crhZ+jh
        mS3yX25HGe216J3HBRUUKY1jccsLdwdEgtgfD9rAU9aXlONGl5fvyefWuoqTlfjh
        MulWmb67PEWum04QQsdISoAZMsFiRlnFkL3Sn4dXi5yl8V3BdV0yJ3Oly7BmYcmD
        a7Gt207ikYSc3F8pIT6QpH/q9EtngGx0vOX09lb5pMAYYO0Z3e03K9LveKn56X2f
        xwwzG+z8GlcdyjZD68CJKv5S95KHZ6sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=VO041jxTbrMxPNE4/
        i+uf8ccmMznPA7J/VmHh3Xrjto=; b=XdKCtxGRw/h5jRakGZfE+wc4Z8XaM5QZp
        QeQXHh3dzVnifyyjRKTfZUenQrmOIuuMkYJL13JhYQ50FnPRCV/Fmu9rbcTuB+sr
        kRTuNt/cyrsGLRA1syAvV84rv5rOnQa3btD6Tz417Ah6aoyKMgr7/QbXvCGp3Jmf
        aWXsRKd5GH6+10R6rr42Eoc+yPqStT3LFW+5j8Yuht11M428d5MCia3rS5FO8o+C
        /gppXMRnz6VGAvE+PTODNAuoTdqCWrcdnKFntTBZquKUNalojTzjiGOgXoxR1+3c
        sfERd3bYlpiCnzuxV/H8iho4B8EkIqe/weLAi5M1VEPFE8YTmD1/w==
X-ME-Sender: <xms:GSoWYhBw0oZYaBYeyBHCjFOq-eUSYmTeGCH4Uiss9-z4RTsM3oq0YQ>
    <xme:GSoWYvgy_u5kv816xfpvLiHQfS7-L8tVIdtSATgQRMfyL8V152KY0cJCHpJdPQWo4
    UW9BSoLZaALvdL7RQ>
X-ME-Received: <xmr:GSoWYsnbBiiJrhq2KOtuc1HljGfMIIOClt3f9DZ3CnPziFODucrlvRlxrFRfYJRV3F0suTzYk9wHR4aSiScb8Y0KasE_XrMAVD-o5u61_IRzKgjuyuiGWnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GSoWYryWkWTLlo-Id6V4gY90iOIgQ_HoVLQaTf4umKvXYWEali6dzA>
    <xmx:GSoWYmTa_djqACZmAmhObKDJ4BYrE0gHlKW2ssIXgMbuwDXZ9F1crA>
    <xmx:GSoWYuZwYgNK9DHo9-On4IqIdBBLVvhDaMLzs0oETu0LNQfxX91MhQ>
    <xmx:GSoWYtPMCIYuuu6l0wpqkwZJ8aylEaRamKikISbnFJBN5NPluI1-1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:36 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id cc34f9e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 23 Feb 2022 12:35:36 +0000 (UTC)
Date:   Wed, 23 Feb 2022 13:35:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] refs: add ability for backends to special-case reading
 of symbolic refs
Message-ID: <28cacbdbe2e7dd38f96ea2d37aa438adb9e5a270.1645619224.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mCtVdkBczx+FAIpG"
Content-Disposition: inline
In-Reply-To: <cover.1645619224.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mCtVdkBczx+FAIpG
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


--mCtVdkBczx+FAIpG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIWKhYACgkQVbJhu7ck
PpT0XQ/+Lj2xLXjPB3uzIKYr208RwnE9rzOiMzTpsCdVernwIsLrpvr+cDSeaisD
o5fH+uA9yv4zeZGrt9i1jZ170BryjoFqcpfRsL8X3GU7KE6oVS42unfnz7KGjcc+
FevqFd4H3NA9YCQvO3l6FGWB8pGQMXnzpLNAQ5DQW6AxdWDIIJi2B0GWESVmT7VG
EWcBLkd6obco319bTWPkbv2LHESBYN/9H41b9jtku82SsaOdwx6ufVHptjr3H0wr
dS49FuBnMcLNWHZyTrCRpEI/DAk0Bt94KzNcBOLYu1fY/YUHG8MCGpraKtkxqmm2
B3k8FAxL2OHcUoeDC/Gr4nNiwZ/exicQhVbxyWmjvIzue9N1XoANhESlUbxxGELo
dipy/w5gWCnC8JefxCpu/syXjyclz2JVhZz6ZgmX22YCc5RYQ6ICq9aEjI22g4o6
JIl+dqoM6pQ8ODYjmxPTe9hiQ4imlOObKyjvgZpJILPxeVoWBQFayspH25DjbsxO
LKqFFVXDfjDh3/rRu8KVWjVgJNBEzBWTH4PrhkZj0JPmbksR7rFedT5f2UQpIgkG
gmWev+ktYNndRp3FmyZhkeLQZy0P8j5is+V6iOc4q/gX99X+h/TAoe8X6qZIAEsI
PQy3AUyVi9E7f6XGuHn9JdwYYEOtLSciEjduNV71L/8PviLnzoU=
=Zkq7
-----END PGP SIGNATURE-----

--mCtVdkBczx+FAIpG--
