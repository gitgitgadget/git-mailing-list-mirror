Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E756A33F
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519066; cv=none; b=L7JniCmT2EarFGqVWwx8OxMuw+4pW1OcHxER7JOmSgcRJcPn2JJHBeXxmDQ2kxgrHTQKRW7qA/B/ge7MCJFXc2+4AS7QY+qBXDNcWew6SvXIn6Fwbt8eCboIQv8pGIqKTifM7wHUh1FyK7FhIxqR+4OsDUBhjuQ7qtN5BxNVruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519066; c=relaxed/simple;
	bh=VILpOV3p4jEa/c1BWr9OqNY2WMEIRsdcIs6nxfRmBZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixTU2tx8ezKv/9ATTyd2G2+aQQNmLAw8dDd5C0HPUtDkCdtV1clmr53yw4k8wGJmSd2i+Gk9MOpDHkZepYp8/XK6KtNzVS0SqcjiBl5OdOuFnM5FF8az1xpviA4dJAwUMn3H/uU4FQjVPlox1WkPOswSdLsVRP7FLtMC/DcYFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uVaBDLr8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RoCsjeXT; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uVaBDLr8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RoCsjeXT"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 0E6503200A20;
	Wed, 21 Feb 2024 07:37:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 21 Feb 2024 07:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708519062; x=1708605462; bh=a+rGFFP9nl
	5pchlO1fSwfZlprls/R7+ucjzL+FPd//c=; b=uVaBDLr8J6gX2vJpk1WV9yR4tH
	Nhp1vnYvdEAozedLnZlLDOmhP0BS7Ofi/QzwM8VbIxmlg6DRoWayJ3lPDM8B5hsm
	AWY4+v9kd7fOCTMk61a7/wFj30Bcx7S4Z2zvP4YFpz92JDt2H8Ogz4iHVAdCyR1O
	sF+KS4UJqq/chWf14uCfhsI/ly5WqJLzS1xrrikHEagK4xrCdFXYyHt+T6wbujBT
	XhDghP+Kk4aIhmmM1afv8Z6w9iuxO8jq4qoslCslRCeL/NQPt5dKPWvVeCiRhlQB
	VWNSVcQ/Nu7qMZN9pcMOpTmvKMGmGa5/e/dF06qCw3HKWm15h4zpoeIsw61w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708519062; x=1708605462; bh=a+rGFFP9nl5pchlO1fSwfZlprls/
	R7+ucjzL+FPd//c=; b=RoCsjeXTJ+HsDTBX5qhHNG9Y6jZOrCFt6o5PZcFnWE+/
	LrkTTu4JscedODfUsm3C5ih5VkvwKS2yfm6a/awfJDlunW/51b2vz+mr15giG58x
	d2ehpfmUtXx0Nxdz3cOXGh524lJyQac0inHGtoPgq52Qa+97SlNFgJ5IrR1vjLUc
	nM4KX+oM7ZVyD3nxWX5PxlKf6iM2o6jkM96v0XEXxyIrpXffVqMg07w2tbq1IyyK
	NCcjinjxyM7rz8MriNo7qrf8avmii+tnDFM9ggclZoytnt602dEE8S/EzwRssH8x
	u1d/vdZbCrYvK/dDpA5JZ7bNKsB/tgtPyHNRVaXDbQ==
X-ME-Sender: <xms:lu7VZdrMzcCuufUtLar-AevzELRoJ1y-aT7F0hskaTQQ7lnHSd8Y0A>
    <xme:lu7VZfowmir-ZN2q-ttRVkQ_3WLEvUK9ASupOu9h2J4qiHvbVE8o0O4dbTVQCeHfq
    WmDDzB76x0XV3glmA>
X-ME-Received: <xmr:lu7VZaPOf5U6tIV6x5ZCYzwB0c7HgcMd65jf-t3usfWTxQxxATcvjGse4PfvMoNVgP4XTZ5JlZihGHsp1DtNpzxP8hqd40lakISyE93vAeHq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:lu7VZY7ZOJjb929GaYx9ybZ_hn26NYqOgECeaROxRC7vhDY3S_v0kA>
    <xmx:lu7VZc751dK20ALnMhvoqntcGtaqV4u7nXEaGgwiAklo52KmP-xPjQ>
    <xmx:lu7VZQgNWXK9E-rXkbkGmZcNG_NOP0Irf-DcnhB9wjvb25d03vsmSw>
    <xmx:lu7VZaRIUK0e9LYgpf_eqfBNeKbZEhSdN6wYxIew-Vj_D4L3a5kn5A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 07:37:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd97f914 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:33:36 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:37:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/8] refs: drop unused params from the reflog iterator
 callback
Message-ID: <c06fef8a64759affaafbce35afb54357fd0487b4.1708518982.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708518982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="25RN9XJXjIBLPdYj"
Content-Disposition: inline
In-Reply-To: <cover.1708518982.git.ps@pks.im>


--25RN9XJXjIBLPdYj
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
index dc25606a82..f9261267f0 100644
--- a/refs.c
+++ b/refs.c
@@ -2512,18 +2512,33 @@ int refs_verify_refname_available(struct ref_store =
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
index 05bb0c875c..c7aff6b331 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2115,10 +2115,8 @@ static int files_for_each_reflog_ent(struct ref_stor=
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
@@ -2129,8 +2127,6 @@ static int files_reflog_iterator_advance(struct ref_i=
terator *ref_iterator)
 	int ok;
=20
 	while ((ok =3D dir_iterator_advance(diter)) =3D=3D ITER_OK) {
-		int flags;
-
 		if (!S_ISREG(diter->st.st_mode))
 			continue;
 		if (diter->basename[0] =3D=3D '.')
@@ -2140,14 +2136,12 @@ static int files_reflog_iterator_advance(struct ref=
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
index 39e9a9d4e2..4998b676c2 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1594,7 +1594,6 @@ struct reftable_reflog_iterator {
 	struct reftable_ref_store *refs;
 	struct reftable_iterator iter;
 	struct reftable_log_record log;
-	struct object_id oid;
 	char *last_name;
 	int err;
 };
@@ -1605,8 +1604,6 @@ static int reftable_reflog_iterator_advance(struct re=
f_iterator *ref_iterator)
 		(struct reftable_reflog_iterator *)ref_iterator;
=20
 	while (!iter->err) {
-		int flags;
-
 		iter->err =3D reftable_iterator_next_log(&iter->iter, &iter->log);
 		if (iter->err)
 			break;
@@ -1620,7 +1617,7 @@ static int reftable_reflog_iterator_advance(struct re=
f_iterator *ref_iterator)
 			continue;
=20
 		if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->log.refname,
-					     0, &iter->oid, &flags)) {
+					     0, NULL, NULL)) {
 			error(_("bad ref for %s"), iter->log.refname);
 			continue;
 		}
@@ -1628,8 +1625,6 @@ static int reftable_reflog_iterator_advance(struct re=
f_iterator *ref_iterator)
 		free(iter->last_name);
 		iter->last_name =3D xstrdup(iter->log.refname);
 		iter->base.refname =3D iter->log.refname;
-		iter->base.oid =3D &iter->oid;
-		iter->base.flags =3D flags;
=20
 		break;
 	}
@@ -1682,7 +1677,6 @@ static struct reftable_reflog_iterator *reflog_iterat=
or_for_stack(struct reftabl
 	iter =3D xcalloc(1, sizeof(*iter));
 	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable);
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


--25RN9XJXjIBLPdYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV7pIACgkQVbJhu7ck
PpTi5Q//aJdHU5PY2hPlMev3XPXL19GZR+YamVytHrin2Nx0A1S4Q59QnUi4aJto
pLuQIuS0SOWjSRkUkHy9J2S06I87n22sND1yhYjwyPZQnGihyc1+LoxjsoJO7NoR
rgi9aGD6ZNrB4D/WMjSOndu7klc1dgEuG/sh8Ouh/QJKOTHXMKUb/willNFIGjg/
VlKXhZgdsDAkCyRtpPR5gpUNjE6Vskq4ahA/tp9wrXT2vkByaZP2hZG31p9jBQlX
2OMAcKhUx+ttCGzFgYtMffjTAkRp1wtpAZ8XQUen/96O6eaFL8+gwcbAW59gCCZP
FRIdpiSjG5nQnCGNTl28cer/oeEeXaFFLJf0Hk/x3Hug7AFUbV3jNzQ5t0a/k/gt
I/9aON+R/sRyNfvvso2DoJZ+jHhAKaWBP6p/x0Ge3Jh7a5eoMqSrOA9vyC1hAdkf
lV06zXa5VjwTNersy+/mW19dxcyuJfsfuVFYgNmyXpgMDPvezfcwH5BGnYThmm4/
orxvw2vPZkXCh7vJi1GdmTiWqVuAGUeGQaNqVQsyJOEQW6xK+ayza9uI46ovPvLi
7yuzNU+MXdz4DjtkVfZwVYSBv4nk/IOd8JeapF8PpmHvFjfqXYQ/75leCjQtqC9T
H0/PS+CXfNMySMbXqy799M5YIANbHzpQyjDo4ITbKJ2lqW6Jf9Q=
=XBSl
-----END PGP SIGNATURE-----

--25RN9XJXjIBLPdYj--
