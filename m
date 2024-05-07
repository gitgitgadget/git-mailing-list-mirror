Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE685937
	for <git@vger.kernel.org>; Tue,  7 May 2024 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065905; cv=none; b=QUQqBRXd6izehD7uAJ4ZgqLh6cl+EmDKjcwESqb6eundvFjzBpdH8gXMA5TuO+D0wIjHpQQ90XPm4klpHPF27w9Q6kWGSilJ2bSM/e+aS5m8FA1EbSoAd5kx+j63kRNuv4osL6q3UkrZ6oVXTeh3x9M7SMx2p8NVvccaei4mTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065905; c=relaxed/simple;
	bh=2YHzOlu0mEbfCoTT69ia3vyhfmbnl6XRMvIXBI2Db/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEpjeZpZcL8ULCi3IxZNkYZwfFIisHfeCNHNg5eQfOh4cUIPaB3EawRxXBwIz9PC6jwo5xrqJ43Zc6jBV9bFvk1PDXrUpXChq2OyynW/fJKy1CjSoOpBTIvF9KCUdgAI66hEEUj+2deX1o28/m6Z/6a0wW4GkAsFU/KJJuU19wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lSiNqkEa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OCOHCGTd; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lSiNqkEa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OCOHCGTd"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3242F18000A9;
	Tue,  7 May 2024 03:11:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 May 2024 03:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715065902; x=1715152302; bh=eHI5vlnX6B
	Xjf4rMiwrAcquM2rx5/k6feoMkRxrp8mQ=; b=lSiNqkEa0x9yG9k+G+6c0BLcqA
	IhPT8SGt9Nnu0wy6PTsQjjH9sDxVuwRmf1cALa51syyFZcfebeR7ErshrmrHyGpg
	2vGUZPaDlqNd3RmbNiGF6IenzO8x1Gn1DuDBytOOmVOsSVyGE6SU/Mw/TBxfXJOh
	/pWPs7PkXM9LwAx6/3GhBqkXjPRu/OcZ9FKJLdDcksO1c27vioGeKW+eP122oucS
	2hXzwjc9ClTIuVjEfC8dPnvuE1jeb+kkQFdJnOvbJkCbOjOKPavSo+uJR6XEH3pv
	qSHTS6gJ4tm9ArwZGoDsZvE0xKzub5rjLh8ac6rHMMOkbGg8agt8Qp01S92A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715065902; x=1715152302; bh=eHI5vlnX6BXjf4rMiwrAcquM2rx5
	/k6feoMkRxrp8mQ=; b=OCOHCGTdmDuDd5nY2lKC25gOylAa2s3uNWyJpWeBaDSN
	aveiMcJJ8ZWQH+ogKlzjzEXdNvdoRHjtZNSqbmZkOFc7oAIg9XtC2/RSn4/uMFVI
	oI+5G14HkV7mGAO4R24CMV/GKzHo0WfMmBmiLoKsWvxmEOckZarPxtlTR7JclRev
	8qpsXduNp9HNIRPBd7iiCfUSywYs2ugYWVfotPRKI7zVn1lDYoYvDMoJf40o53d+
	HyRywC9vZAPROi766fB0xMv1U6OwH4xSftevIaU2XBTijapSKQQiFubdWSppBzgG
	afbPxuchnoZsWWh8Wl7K6ha0Yyeb7DKFITOCfZOSqA==
X-ME-Sender: <xms:LtQ5ZupLm2mjG7KTfDaewiJNw2U2SUsa7wj5n4Qiv2693Dv53moc5A>
    <xme:LtQ5ZsqqAa3g9l5Vep4u3TScWb5xSG6WfHUxWr8n44nIbrBqfTkcD1HNituOffemD
    -1TJUqFJR3StqAfbg>
X-ME-Received: <xmr:LtQ5ZjOMv77rxuYzoZOD0dXc1XDobTozgfmNGQ_HQMjMoHqMspoSzlDg0zXn-iAU01ugCP2aTiIh9TdAU1ot_MjOA1DvgEEERsKlAPpD7nA8BOiOaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:LtQ5Zt7vaw1xtxtBrnJJltEFow7zBa79nlfP5aGfS0NsOUyMFrTB6A>
    <xmx:LtQ5Zt5ZYpHfpcQspieuaHbrMCtbe1tiBXGysu884PRWN_XnqRFMWA>
    <xmx:LtQ5ZthTLCElWDs1ETOYC--PcFFlXw29EY-N99SPIqhbWK37O8heuw>
    <xmx:LtQ5Zn5U8QAx8egBd4T3yqFQsMBxAk2J4Tg2PVlvrGWyfu_E-9O5Mg>
    <xmx:LtQ5Zg21vc9Pm3t6IxjTGHQVCHnTn87SpVKCjNj7v9L88HMVwfieo0NX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 03:11:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 56c2dad4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 07:11:34 +0000 (UTC)
Date: Tue, 7 May 2024 09:11:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, James Liu <james@jamesliu.io>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 1/5] refs: introduce missing functions that accept a
 `struct ref_store`
Message-ID: <dba5df086d9dbbc2801f946abef47714b41d3750.1715065736.git.ps@pks.im>
References: <cover.1714717057.git.ps@pks.im>
 <cover.1715065736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bJHXLIxyMy+7kknQ"
Content-Disposition: inline
In-Reply-To: <cover.1715065736.git.ps@pks.im>


--bJHXLIxyMy+7kknQ
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


--bJHXLIxyMy+7kknQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY51CoACgkQVbJhu7ck
PpQqrw/9FuSjF2q0vCKn6+Y7Ky9lpFTEN0ZjgBK9E3Fz2cXeQK6+f7GQUaaZvqb4
uclgQ3WgBKlLfprnGrpGeUZnhqHUsl2xmjzuw+1UyZGIsKHZ0+KQSqPeMw8h4Qih
1fksr6xjC04KO53ltLLc6cElMw/h6ge4Jm20lFkVBDb0JQvwehLx/r6+8BD0fe1r
kyibCR53CANAHhrql/hQ/fCNN6ha6DPKTLxbT/POZdlY8Aw1BFDyQ6Aqm38IaD0l
dt27p/zhqmXCqilXbOqsYLv9pFNOw7SMYkkFy1lbdwoGm8OTP6LBDfKqfZfG4LtC
LmIrdeCYWVjDmWh0fND7NMHPCdl+gMS96wZd0Muk0wa862e8DrDeUKM7MNjqusNY
6lOyB13+WvNXy/P5wExZynotbZHZlpza0XuJRTv5iKlMK4UzyMD4Bp2HYGz5QlqF
SIb3BUkPR1vsTNo1n0mjAbGncmJEKvUhtkf8kvLgw+l7lJ7UwGbvNkSn8jgr4aeQ
aHz1cI8T/94CI99z6zHxGemYzXwnDtMydPpCDavfzjkZe9f+3r2j2pEtC/dCihVi
OiEzSBeLTY1UV62dNelEObU53rAgpJby4XK7QecvQSFR6GgkQ1+C3icy1asDiA5J
LSi966DGQFX8C9/lZMGHcbFvDdy76pzg6xI6uBTyEI9EnpxuaR0=
=Fct3
-----END PGP SIGNATURE-----

--bJHXLIxyMy+7kknQ--
