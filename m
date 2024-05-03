Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94303139586
	for <git@vger.kernel.org>; Fri,  3 May 2024 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717686; cv=none; b=tCTzvkO7VRvk6VghME5l7CU9+tScuJ3G9tkbiwfeTq56E02dRV3vuU/fc5vPU+QK12j2bUq/Vov5oYlEJt4QLlWtfuhXwLRD3shuCkZq/3ZdsF5q7Rn2OkbWhZE0T/okexiH6w7EvrRg7Xign/XtXKyUp4b3f8YLttg3K7eK/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717686; c=relaxed/simple;
	bh=DHsgqpNgSycuw6qfRyQO6XXa10aZ004dntJkLGWKBwg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMYZXJkIETFZi8j2ZFEZ2ll3c+Ii1/vT9NSoPZr8xsv0n/omHCJoLDbgE0RbDC+lQ34zYjzOfmRG2ai+T8Rea0JUbxlkfswJKqSPALa6yLrk4L4Tr/bGh3GDhihZOoy+5WOCVRMyw0s7+rLxXfxIGKwYQEs44iXE3slX3y0pEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JxKhh7mJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d6Z+eEnC; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JxKhh7mJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d6Z+eEnC"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id C24611C0012E
	for <git@vger.kernel.org>; Fri,  3 May 2024 02:28:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 03 May 2024 02:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714717683; x=1714804083; bh=E9HPH89/OY
	eGx2/35t4/MF1FLQvD/IMaNwtpeT/48QA=; b=JxKhh7mJBCDehmUmc7YUbsxZDX
	vEQNrW3Jz/1vn0FJwF5PQCsvyRbFWVOVifgKk0yOvvWIXvduC4slsjrZxA5vt4w4
	g5xkdKff0AhW5XkiZCJfzXxXcG7lnfj5XH4HkLmEJlKda6+QgZvnHN4zLAkqSBXu
	bTwZH/sCwN5oTexCUT4+By09U/8fEWg2jyBExHAiban8vFn6f8zxjhJx6VcNc3vk
	npQ0lc841UEb8NmIVCLacexy+PjpLuoEKiXB+K/PKlGdggPboN8aRylSoHlUUVki
	G8AwZuxzdg8KK9xWaQUdBOH6P5vJUp2aPh8gHCVOIlQogQJf+BglD6RxxpEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714717683; x=1714804083; bh=E9HPH89/OYeGx2/35t4/MF1FLQvD
	/IMaNwtpeT/48QA=; b=d6Z+eEnCOa6ySGaYo9R70B1683rCtS/QgT1JsliDEUQB
	rttifBF5eMTjHRnH+DmpKwZx6NGWMFCoAvBJ1iY+HE+8m+fNfrVz1XFSPhH54AQn
	WQTzIqxLFroefYXbMHkMD/rAU4hqUJg41EtO6g3bhFxVw78M4rZTYhOsV1CVMunx
	jLfm2wDdqAkJYKI78fCLqexS2MIyojWT+rAhQDiGml2wXxFv6+IAfMt83GXz/X/b
	najl7EcKTH5Y49W7d6obde0g/WE1ZA1fk/k+2c1rIym0u80qRGHQWAwGE0/eXdbR
	zFauaKGntlKAY6DaBIC/KOSvP46RN8IeO/TIePfDIA==
X-ME-Sender: <xms:84M0ZhvEX_tHJqeKaR4Qra-XIiv2JNTn9XWsNXEp5y0qWra4AZaOHw>
    <xme:84M0Zqfd0IySaXMP24kAKIdf-VbwEQ8bFwiatnZn1_c8gphgWVjkGRrJHMfa6Csia
    9gYLLNkBTI2MJroxQ>
X-ME-Received: <xmr:84M0ZkzCZrs3AEaQ-teHsm9f9xN1SwK4sfvUkcpP6CrprsBTzdOSyvP7YOYfTNjSO1fv5ZFZ2coNK4qGcKBMSSVMlGlagH3bl8jPej8HM0hctxt7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:84M0ZoNuRGjX9K0fgP_1SSw17Q2_UCkNXKOhPgvVjRHJxGXGO3ypJA>
    <xmx:84M0Zh-EdJcndZ93N9Y1rkfYc4LX7GQ4GxDzlySMiDhXPlyGV3Y-FA>
    <xmx:84M0ZoW3yloa8blWiFRKhD1vqBxJ8pEweWXZVapUUHLJ72JSOA0cxQ>
    <xmx:84M0Zicza8B2SuYmtcNvtzWXM08StjEgbOw6XOOwEKMkAggFwPlcsg>
    <xmx:84M0Zjmnu2LWmVa-f5Ehlm1w1Z9UYWtmw3iUzCHSGWpb_qyrOkXAaQ_b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 May 2024 02:28:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7fab56a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 May 2024 06:27:34 +0000 (UTC)
Date: Fri, 3 May 2024 08:27:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/5] refs: introduce missing functions that accept a `struct
 ref_store`
Message-ID: <dba5df086d9dbbc2801f946abef47714b41d3750.1714717057.git.ps@pks.im>
References: <cover.1714717057.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i/95rgXT0pzB1ac7"
Content-Disposition: inline
In-Reply-To: <cover.1714717057.git.ps@pks.im>


--i/95rgXT0pzB1ac7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While most of the functions in "refs.h" have a variant that accepts a
`struct ref_store`, some don't. Callers of these functions are thus
forced to implicitly rely on `the_repository` to figure out the ref
store that is to be used.

Introduce those missing functions to address this shortcoming.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 65 +++++++++++++++++++++++++++++++++++++++++++++-------------
 refs.h | 13 ++++++++++++
 2 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 55d2e0b2cb..7cafda1c25 100644
--- a/refs.c
+++ b/refs.c
@@ -400,19 +400,29 @@ struct for_each_ref_filter {
 	void *cb_data;
 };
=20
-int read_ref_full(const char *refname, int resolve_flags, struct object_id=
 *oid, int *flags)
+int refs_read_ref_full(struct ref_store *refs, const char *refname,
+		       int resolve_flags, struct object_id *oid, int *flags)
 {
-	struct ref_store *refs =3D get_main_ref_store(the_repository);
-
 	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags,
 				    oid, flags))
 		return 0;
 	return -1;
 }
=20
+int read_ref_full(const char *refname, int resolve_flags, struct object_id=
 *oid, int *flags)
+{
+	return refs_read_ref_full(get_main_ref_store(the_repository), refname,
+				  resolve_flags, oid, flags);
+}
+
+int refs_read_ref(struct ref_store *refs, const char *refname, struct obje=
ct_id *oid)
+{
+	return refs_read_ref_full(refs, refname, RESOLVE_REF_READING, oid, NULL);
+}
+
 int read_ref(const char *refname, struct object_id *oid)
 {
-	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
+	return refs_read_ref(get_main_ref_store(the_repository), refname, oid);
 }
=20
 int refs_ref_exists(struct ref_store *refs, const char *refname)
@@ -542,7 +552,7 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_remote_ref(get_main_ref_store(the_repository), fn, c=
b_data);
 }
=20
-int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void =
*cb_data)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	int ret =3D 0;
@@ -550,13 +560,19 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	int flag;
=20
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flag))
+	if (!refs_read_ref_full(refs, buf.buf, RESOLVE_REF_READING, &oid, &flag))
 		ret =3D fn(buf.buf, &oid, flag, cb_data);
 	strbuf_release(&buf);
=20
 	return ret;
 }
=20
+int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+{
+	return refs_head_ref_namespaced(get_main_ref_store(the_repository),
+					fn, cb_data);
+}
+
 void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 			const char *pattern)
 {
@@ -583,8 +599,8 @@ void normalize_glob_ref(struct string_list_item *item, =
const char *prefix,
 	strbuf_release(&normalized_pattern);
 }
=20
-int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
-	const char *prefix, void *cb_data)
+int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
+			      const char *pattern, const char *prefix, void *cb_data)
 {
 	struct strbuf real_pattern =3D STRBUF_INIT;
 	struct for_each_ref_filter filter;
@@ -607,15 +623,29 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *=
pattern,
 	filter.prefix =3D prefix;
 	filter.fn =3D fn;
 	filter.cb_data =3D cb_data;
-	ret =3D for_each_ref(for_each_filter_refs, &filter);
+	ret =3D refs_for_each_ref(refs, for_each_filter_refs, &filter);
=20
 	strbuf_release(&real_pattern);
 	return ret;
 }
=20
+int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+	const char *prefix, void *cb_data)
+{
+	return refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
+					 fn, pattern, prefix, cb_data);
+}
+
+int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
+			   const char *pattern, void *cb_data)
+{
+	return refs_for_each_glob_ref_in(refs, fn, pattern, NULL, cb_data);
+}
+
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 {
-	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
+	return refs_for_each_glob_ref(get_main_ref_store(the_repository),
+				      fn, pattern, cb_data);
 }
=20
 const char *prettify_refname(const char *name)
@@ -1733,18 +1763,25 @@ int for_each_replace_ref(struct repository *r, each=
_repo_ref_fn fn, void *cb_dat
 				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
=20
-int for_each_namespaced_ref(const char **exclude_patterns,
-			    each_ref_fn fn, void *cb_data)
+int refs_for_each_namespaced_ref(struct ref_store *refs,
+				 const char **exclude_patterns,
+				 each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret =3D do_for_each_ref(get_main_ref_store(the_repository),
-			      buf.buf, exclude_patterns, fn, 0, 0, cb_data);
+	ret =3D do_for_each_ref(refs, buf.buf, exclude_patterns, fn, 0, 0, cb_dat=
a);
 	strbuf_release(&buf);
 	return ret;
 }
=20
+int for_each_namespaced_ref(const char **exclude_patterns,
+			    each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
+					    exclude_patterns, fn, cb_data);
+}
+
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_=
data)
 {
 	return do_for_each_ref(refs, "", NULL, fn, 0,
diff --git a/refs.h b/refs.h
index d278775e08..10982dcf03 100644
--- a/refs.h
+++ b/refs.h
@@ -81,8 +81,12 @@ char *refs_resolve_refdup(struct ref_store *refs,
 char *resolve_refdup(const char *refname, int resolve_flags,
 		     struct object_id *oid, int *flags);
=20
+int refs_read_ref_full(struct ref_store *refs, const char *refname,
+		       int resolve_flags, struct object_id *oid, int *flags);
 int read_ref_full(const char *refname, int resolve_flags,
 		  struct object_id *oid, int *flags);
+
+int refs_read_ref(struct ref_store *refs, const char *refname, struct obje=
ct_id *oid);
 int read_ref(const char *refname, struct object_id *oid);
=20
 int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refnam=
e,
@@ -375,16 +379,25 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data=
);
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *=
cb_data);
=20
 /* iterates all refs that match the specified glob pattern. */
+int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
+			   const char *pattern, void *cb_data);
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
=20
+int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
+			      const char *pattern, const char *prefix, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
=20
+int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void =
*cb_data);
 int head_ref_namespaced(each_ref_fn fn, void *cb_data);
+
 /*
  * references matching any pattern in "exclude_patterns" are omitted from =
the
  * result set on a best-effort basis.
  */
+int refs_for_each_namespaced_ref(struct ref_store *refs,
+				 const char **exclude_patterns,
+				 each_ref_fn fn, void *cb_data);
 int for_each_namespaced_ref(const char **exclude_patterns,
 			    each_ref_fn fn, void *cb_data);
=20
--=20
2.45.0


--i/95rgXT0pzB1ac7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0g+4ACgkQVbJhu7ck
PpSrOw/8D6rc9IDRQUthkXlg+/SbTJjHZewd2Bsd6eCPdo6NFS4KDsJyGES3nt0D
D2aclrBwWlndeqMsFFxgKsgR5pWZPFc+57D61Twhf/0r3Q4r9R75DO1qrW+JVF2f
cmoW5gCgOSpyulOXPxvd7GBIbzsMH+Dxc4HWfqDtU/H/YZKilWdtW2QlHU0Dukpc
6MqDO9GiMgTZyYZME5RORosXN29vjABJVZ0PYLte+1X2UD9BSK/gxtle+o8cLNsI
tGlM6ZypVBjuwao1Mmle/YCRR848RnakzTN1ffwlFWWIPUxu785zXzRoCFVFdkdb
XckfLQ1g3zHLV1hgmtEPVuF0HKqoIuqQQnrw9aIdCh/AgWCRDy3dMoaqtfrtSK/o
LSZ9/DoR9N5HhuxfFvFrGSbOyhNQ66RQXG3/dbwT7BvL6N+PNZmopZ77OttfnBbz
w9/3pYIdaXxXUdz0ACFOBJEFoss0xY9yfg03QNHXjNq1F2N61xKiGvowoLm3swml
P9yaNaxXq3ZNbqLI0KVIBj0YxWdQXi7AqV545jFWWtHhiMm71cUL6fjm7PgDVUZg
24aq3kxkztpj5qa8y/P4GYRkpYuqG57YWzPB2sXXns96RP0PzPp9ERfDMyg67Azc
SJ6SMZRlLFabY3RPkrSVcaPoBxEMWrZUCREfWBYyQX7+JcIOXdQ=
=fXyS
-----END PGP SIGNATURE-----

--i/95rgXT0pzB1ac7--
