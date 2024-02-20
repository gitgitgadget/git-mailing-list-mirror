Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7C62146
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420004; cv=none; b=mNbkqfe0iakpJH4wLoNEUM/414Sh4qTJFZlrck0B75lxEfRQzpU2fhH/mFTzOzCePTHu9/xyCMcSGbNeqatV8NE5jb7zJ82iNKKDOj0Et43+nVicun1xkjvFbTV33h952uGYcJ1T4FoDKyqmLHJYXYRXkju259/nk4+zskLkwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420004; c=relaxed/simple;
	bh=Gvz/qCwq0k8EBjt5nZvIvl4ov1DVxzY3hhZDMzdnfwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWav6ArZ5cB08pR/Pu9ozwJUbCd94NveBO7hWyXBLkH7ILK1BDMVJ7hjekk0bvtU6vVXB0wb2f3rJGutyYOrhAQ8reO4LVu1aNYPkdpiJiMujp6eEMqQCBZ7VllXWVjpzJaBY/8PLzEIVLLf4TQLSjnW+LhcRe1/KSZNf+YzF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M4HDw0EG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hzVYxulC; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M4HDw0EG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hzVYxulC"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id E779E1C00095;
	Tue, 20 Feb 2024 04:06:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Feb 2024 04:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708420001; x=1708506401; bh=MDW4MsVM2Z
	MCvM709H8pwuvaLhrBXH0VlkWz1p2CpFI=; b=M4HDw0EGIpfUGgs/gKp0l4vnYm
	QCjeZ1KE3lv8ZdmMZsWGZmwnElPpMB+/vb9i+82tRiLQBF0MS6e2ptb/29TIKvoB
	lVPX9Tfpgp4i8lUtNHN0G2SycrrTittNkW964gUvi4qQb2C1LJGsTwJiTjhJ1a04
	3bVxOFo3sgds0dxmDzcfIUKvREmQjynHRXz25nULPI1IKEzgFgGFCsp52jEH85d4
	dAHI68Up6Yk22/YOIk0sHUH8bgvhp/Y3tBsNC0l1WJ41GlB9FSrXEWChFA5YcuHO
	knORs4x6lIF7d1fFbYlX4x3d/An0MNFLiLfxurRrQhRXJjjEVzExDPR8s5kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708420001; x=1708506401; bh=MDW4MsVM2ZMCvM709H8pwuvaLhrB
	XH0VlkWz1p2CpFI=; b=hzVYxulCYybQfaTkE/pnjT7y6G9L92wVCWPS5F2jcq2x
	r6zPf6tlMMlw9uBfhshIt5CPb5vsnzWOPbLM4lUl+xKdBQWbqG6djRijslLD9ka4
	HPm02ACb49gU/KM/bqSmWKVYHKyMg8dompgK4ECq21Arg9ayw6hthj1Mw/UNq0iU
	b+ZOnzBb9dHkxbhtMKUUVjrOXmqHH6cxgaIMtWZu/DqobO5PbzMlMFykKqxulkx2
	+XPqXGW7kedrL8njchsO6vu7xPV8OtOofLoseCJi6cBdAWuGOiwzg7KxdlUGa8qS
	4BLF2F9yU6Jed20YVQa3mg/yyBss78uZJBqSFW7NmQ==
X-ME-Sender: <xms:oWvUZVMcvsVLDZWqHHNSX1YyKk7MtZ2ftxXps96R7ERYKqB_z2Twtw>
    <xme:oWvUZX-93l2faTraNN7BIozPcPvpN_BZLPjv0z6q3hzTujHOPBKNMd1CjQpCUYCIR
    azwU_USkL-fw5-rXA>
X-ME-Received: <xmr:oWvUZUQhi-DI_tG8VDPTleCnyxNbvTBWZTryngfYDcZGYFNtagSDywuhBDuFVNyqiavUcCXHHWO39OBaqcD-hCZCM5mmKlahFttGGBy9qlX5bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfe
    efgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:oWvUZRuus4KvpEeqLG67Yuo0GybdekZsQ8JJRUg_Xzrq_O1F_EYCAg>
    <xmx:oWvUZdcnFTzPLHjXLgTaloHbkKAb-kmWVZM3Ta02IK8pwfXPk22DxA>
    <xmx:oWvUZd2850OvaePvRTHMxf53ItqNqVebNQuWeLSXZXSBZnv98pgxuw>
    <xmx:oWvUZeq4VuqW9Yr_6DzQZss7xVZTmQ3gIsB23c1wkIeIOjOjUNr6HZ4nRtw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 04:06:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2afaf932 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 09:02:38 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:06:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/7] refs: drop unused params from the reflog iterator
 callback
Message-ID: <240334df6c7d0e95f67fdeddb8b8a381a59245fa.1708418805.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708418805.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/I0/70X96IfGrOii"
Content-Disposition: inline
In-Reply-To: <cover.1708418805.git.ps@pks.im>


--/I0/70X96IfGrOii
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
index 51d57d98d2..48cc60d71b 100644
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
index 70a16dfb9e..5247e09d58 100644
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


--/I0/70X96IfGrOii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUa54ACgkQVbJhu7ck
PpRr3Q//Wgrq3s4mQU/Wqj5pXw3Ve34Xk7sNKgAuS3YAvm+OjxK2S5RVfmS1OLho
pDwHA11TRNL1jgR2GXu9J55Yvouh31suht9dSK6pVS1XBVcPyGrc4MGMLhWkdOUG
cvzdd95VvnHeXXmIprtaJvuyHULBsTLJPW4yrjWwsBQBN6l0KLCvjsrZBDp5Mci7
eAFO9cVUhwF7ziGYnim40tZlzsn1OFPMoSfT7Lf32GwTtFgRiHGsqSeWimWYh/1C
0QY5Z6zY638VTWWC52oJKberHQ7qTnCBlxDOryfosEsfcni9gn4b0Qp1Otm2i+Vn
2c6C0AEYrfm4QJyXwyiLcNlAxKuGJfpb6zAKJc3+m8B189Sru5pCCF6z9eIjsI94
mCeOK/3cNvxrd2zzBEOVCuYPknjr48njcPL4mA+xYorwsJbphfwfxtNYY36qSyHB
vYKvesqboDw9/NdgFf8d73t7YxKRmzF+fqa/XXqz69zfeJgg/SG28uEKG4saCnpH
mqX1w/bM9BMqb2X2vPMYC/LwXelc0Nm4xxqwOaYwBuwAvenX/jvWcHVPNZEUJIE3
0Qh8FFzkrU16HNSwunXzHN6vI06jeEcgJOfgMiXQ7GKEnMfOTEMACqzzNZlZ/Vxe
ZOgO+OEUne3a9DH8AKFShyCfBShAr761aU4oE8LtzKzkP3N0JZg=
=Djej
-----END PGP SIGNATURE-----

--/I0/70X96IfGrOii--
