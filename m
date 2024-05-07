Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ACF13BC0E
	for <git@vger.kernel.org>; Tue,  7 May 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065925; cv=none; b=FDLMnCLnOnAQGC7iT/AedFpoiHk1v7x6G7xZARrD1H+TFYxH5I4DGKNTkTT7X7C/q8mKREFkgI+3o6sW6Q75HGfb+im3+Q/kgld5AKy6s+5zpb5u4o5oeek0e64OJLGmLqIolvD1HqD60JPw9FnDRJyAiHOInHAOUW9eQ4qGCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065925; c=relaxed/simple;
	bh=MasK++kfLhb/h9DcZqf5bq/r4723LkcTHbcTBOA5Z6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGQdmaQ5UXUw8HyGkU73NE9x8uxf1LV9rr0LGE1DOTwo9qrBHnIflTNAVwKbsqzejyMB+jygtPLNVZHjY1O2bS+ynurphtvDHrPkwEuFl/tjdgBZn+wEl75EPNY+9KZJTNKLnTj6e5Pc8uNVNObyodlyFARUMVfHrXml12uw1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WCHEtxbp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g2W1v99p; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WCHEtxbp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g2W1v99p"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 5BA941C001AD;
	Tue,  7 May 2024 03:12:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 May 2024 03:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715065921; x=1715152321; bh=xj5I+ih3d+
	S58da9H8QkTtKcPv1f9KIrvdN8zNjQgVY=; b=WCHEtxbpYF0f7cFz5xPZgPbmIt
	ss0xZ/pFslwzRTMFWh8ynomkxfAnXWQfRosCV9S5cQnjjiEIWw7cSg6oXIs/VPnv
	UMM/I+EPOkwJBYsUlbL6JCZYImnkbZbf1mEW33qlEAntgAP++T/vyAV6/NKflOjF
	fRwJa2EbrbvjOxfBYdpHjXwVym58MfgTJIgSR42sLsqXCr5nrDa2Rom5pxxtE4tA
	T8oJpuhfZ2mBVWVSCdOB1WakdDczgY10xwGhi/zpd0FxHlefofRklG9DfY7l7tvY
	cmLuX6SRK66CqZN+wKmE5I3i5U8Tj1tFqOnFZ1XcxEuShjbwPqaLmaVv88fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715065921; x=1715152321; bh=xj5I+ih3d+S58da9H8QkTtKcPv1f
	9KIrvdN8zNjQgVY=; b=g2W1v99pt2HhW1OH9y0eIymOhuNNg6szQRZbDuCoB/Ps
	8Bdyjt6ruYTJOu2TFFaQfAttoqJLrmjWYjJrU/CrWEoHVFllnF522oJKynWlxA4j
	lCuhdDmqxENpBMZOkajHcsNJJGrGLOGW+b5wihrGkvnmbSZOsJ+TwITRY06osHAq
	zJnDFzcapnkTDbGBRCIPZHynYOEK51x1uhJzH6dTYbQLq43ZLbBnmk5mlEaOOLpm
	YwQQvI9osOpRBuhJot1hsxX/R1I5XlyzOHMLicg6MbKWDdvmLDlgi/K+HieILiGB
	Z2aa6dcURa76AqeBrBcDixmNw0SIwmXsEatILh5fKA==
X-ME-Sender: <xms:QdQ5ZkZ4jGdFBazAnogP7HxN16Wj8nZgPm4vD9GU5vit6lcjVHciYQ>
    <xme:QdQ5ZvY1XCeETY5muuoscHPcQUPIhKOgUZUrXXS-fKk2dHgIpjUYj2dW374Yj7Jlv
    ktNVJRu-IdipSyJAw>
X-ME-Received: <xmr:QdQ5Zu9V5qTQysUY8WRlkjLXQrmDqH0OrCYHulWF01s80JYzwfq8D9WlFrH8oaUDL7ugOqORO6OeSKTJS3KL20pziwXGpq8w_qIyGxfB-X8FLbDdIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:QdQ5Zuq8fubkRt-W2kNvi2epsrAFgViwSxb_nEBla08Hw-mPTPJqmw>
    <xmx:QdQ5ZvpvrFE5xaT3nLwEt2fCql-mDm9Qo0k73yQ9Ci0Qcfdti6xTmg>
    <xmx:QdQ5ZsTlZDqWQF-TDAc0li5xitAfKv4xADWogk4joKqCvpfq8M8AaQ>
    <xmx:QdQ5Zvp9sb4lCdw5je4M9WDza0CURXUz0wImPV9LVyeMkV9gYmyvwQ>
    <xmx:QdQ5ZgkSM6JGf7016PULaf2pMh826l9qNSvN6Z6VX9IEmCuCC8WAP_7n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 03:12:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 01905f0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 07:11:53 +0000 (UTC)
Date: Tue, 7 May 2024 09:11:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, James Liu <james@jamesliu.io>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 5/5] refs: remove functions without ref store
Message-ID: <773873f244a271140be8eb1b051ceb842cbae5ec.1715065736.git.ps@pks.im>
References: <cover.1714717057.git.ps@pks.im>
 <cover.1715065736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="23s7TY/zOW8fq8Aq"
Content-Disposition: inline
In-Reply-To: <cover.1715065736.git.ps@pks.im>


--23s7TY/zOW8fq8Aq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The preceding commit has rewritten all callers of ref-related functions
to use the equivalents that accept a `struct ref_store`. Consequently,
the respective variants without the ref store are now unused. Remove
them.

There are likely patch series in-flight that use the now-removed
functions. To help the authors, the old implementations have been added
to "refs.c" in an ifdef'd section as a reference for how to migrate each
of the respective callers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 198 ----------------------------------------
 refs.h | 279 ++++++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 209 insertions(+), 268 deletions(-)

diff --git a/refs.c b/refs.c
index d398731d74..a26c50a401 100644
--- a/refs.c
+++ b/refs.c
@@ -384,14 +384,6 @@ char *refs_resolve_refdup(struct ref_store *refs,
 	return xstrdup_or_null(result);
 }
=20
-char *resolve_refdup(const char *refname, int resolve_flags,
-		     struct object_id *oid, int *flags)
-{
-	return refs_resolve_refdup(get_main_ref_store(the_repository),
-				   refname, resolve_flags,
-				   oid, flags);
-}
-
 /* The argument to for_each_filter_refs */
 struct for_each_ref_filter {
 	const char *pattern;
@@ -409,33 +401,17 @@ int refs_read_ref_full(struct ref_store *refs, const =
char *refname,
 	return -1;
 }
=20
-int read_ref_full(const char *refname, int resolve_flags, struct object_id=
 *oid, int *flags)
-{
-	return refs_read_ref_full(get_main_ref_store(the_repository), refname,
-				  resolve_flags, oid, flags);
-}
-
 int refs_read_ref(struct ref_store *refs, const char *refname, struct obje=
ct_id *oid)
 {
 	return refs_read_ref_full(refs, refname, RESOLVE_REF_READING, oid, NULL);
 }
=20
-int read_ref(const char *refname, struct object_id *oid)
-{
-	return refs_read_ref(get_main_ref_store(the_repository), refname, oid);
-}
-
 int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
 	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING,
 					 NULL, NULL);
 }
=20
-int ref_exists(const char *refname)
-{
-	return refs_ref_exists(get_main_ref_store(the_repository), refname);
-}
-
 static int for_each_filter_refs(const char *refname,
 				const struct object_id *oid,
 				int flags, void *data)
@@ -530,31 +506,16 @@ int refs_for_each_tag_ref(struct ref_store *refs, eac=
h_ref_fn fn, void *cb_data)
 	return refs_for_each_ref_in(refs, "refs/tags/", fn, cb_data);
 }
=20
-int for_each_tag_ref(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_tag_ref(get_main_ref_store(the_repository), fn, cb_d=
ata);
-}
-
 int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void =
*cb_data)
 {
 	return refs_for_each_ref_in(refs, "refs/heads/", fn, cb_data);
 }
=20
-int for_each_branch_ref(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_branch_ref(get_main_ref_store(the_repository), fn, c=
b_data);
-}
-
 int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void =
*cb_data)
 {
 	return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
 }
=20
-int for_each_remote_ref(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_remote_ref(get_main_ref_store(the_repository), fn, c=
b_data);
-}
-
 int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void =
*cb_data)
 {
 	struct strbuf buf =3D STRBUF_INIT;
@@ -570,12 +531,6 @@ int refs_head_ref_namespaced(struct ref_store *refs, e=
ach_ref_fn fn, void *cb_da
 	return ret;
 }
=20
-int head_ref_namespaced(each_ref_fn fn, void *cb_data)
-{
-	return refs_head_ref_namespaced(get_main_ref_store(the_repository),
-					fn, cb_data);
-}
-
 void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 			const char *pattern)
 {
@@ -632,25 +587,12 @@ int refs_for_each_glob_ref_in(struct ref_store *refs,=
 each_ref_fn fn,
 	return ret;
 }
=20
-int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
-	const char *prefix, void *cb_data)
-{
-	return refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-					 fn, pattern, prefix, cb_data);
-}
-
 int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
 			   const char *pattern, void *cb_data)
 {
 	return refs_for_each_glob_ref_in(refs, fn, pattern, NULL, cb_data);
 }
=20
-int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
-{
-	return refs_for_each_glob_ref(get_main_ref_store(the_repository),
-				      fn, pattern, cb_data);
-}
-
 const char *prettify_refname(const char *name)
 {
 	if (skip_prefix(name, "refs/heads/", &name) ||
@@ -1024,13 +966,6 @@ int refs_delete_ref(struct ref_store *refs, const cha=
r *msg,
 	return 0;
 }
=20
-int delete_ref(const char *msg, const char *refname,
-	       const struct object_id *old_oid, unsigned int flags)
-{
-	return refs_delete_ref(get_main_ref_store(the_repository), msg, refname,
-			       old_oid, flags);
-}
-
 static void copy_reflog_msg(struct strbuf *sb, const char *msg)
 {
 	char c;
@@ -1223,11 +1158,6 @@ struct ref_transaction *ref_store_transaction_begin(=
struct ref_store *refs,
 	return tr;
 }
=20
-struct ref_transaction *ref_transaction_begin(struct strbuf *err)
-{
-	return ref_store_transaction_begin(get_main_ref_store(the_repository), er=
r);
-}
-
 void ref_transaction_free(struct ref_transaction *transaction)
 {
 	size_t i;
@@ -1396,15 +1326,6 @@ int refs_update_ref(struct ref_store *refs, const ch=
ar *msg,
 	return 0;
 }
=20
-int update_ref(const char *msg, const char *refname,
-	       const struct object_id *new_oid,
-	       const struct object_id *old_oid,
-	       unsigned int flags, enum action_on_err onerr)
-{
-	return refs_update_ref(get_main_ref_store(the_repository), msg, refname, =
new_oid,
-			       old_oid, flags, onerr);
-}
-
 /*
  * Check that the string refname matches a rule of the form
  * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
@@ -1506,12 +1427,6 @@ char *refs_shorten_unambiguous_ref(struct ref_store =
*refs,
 	return xstrdup(refname);
 }
=20
-char *shorten_unambiguous_ref(const char *refname, int strict)
-{
-	return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
-					    refname, strict);
-}
-
 int parse_hide_refs_config(const char *var, const char *value, const char =
*section,
 			   struct strvec *hide_refs)
 {
@@ -1630,11 +1545,6 @@ int refs_head_ref(struct ref_store *refs, each_ref_f=
n fn, void *cb_data)
 	return 0;
 }
=20
-int head_ref(each_ref_fn fn, void *cb_data)
-{
-	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
-}
-
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
 		const char *prefix,
@@ -1729,30 +1639,12 @@ int refs_for_each_ref(struct ref_store *refs, each_=
ref_fn fn, void *cb_data)
 	return do_for_each_ref(refs, "", NULL, fn, 0, 0, cb_data);
 }
=20
-int for_each_ref(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_ref(get_main_ref_store(the_repository), fn, cb_data);
-}
-
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 			 each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(refs, prefix, NULL, fn, strlen(prefix), 0, cb_data=
);
 }
=20
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_ref_in(get_main_ref_store(the_repository), prefix, f=
n, cb_data);
-}
-
-int for_each_fullref_in(const char *prefix,
-			const char **exclude_patterns,
-			each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_fullref_in(get_main_ref_store(the_repository),
-					prefix, exclude_patterns, fn, cb_data);
-}
-
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     const char **exclude_patterns,
 			     each_ref_fn fn, void *cb_data)
@@ -1780,24 +1672,12 @@ int refs_for_each_namespaced_ref(struct ref_store *=
refs,
 	return ret;
 }
=20
-int for_each_namespaced_ref(const char **exclude_patterns,
-			    each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
-					    exclude_patterns, fn, cb_data);
-}
-
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_=
data)
 {
 	return do_for_each_ref(refs, "", NULL, fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
=20
-int for_each_rawref(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_da=
ta);
-}
-
 int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
 				    void *cb_data)
 {
@@ -2063,13 +1943,6 @@ int refs_init_db(struct ref_store *refs, int flags, =
struct strbuf *err)
 	return refs->be->init_db(refs, flags, err);
 }
=20
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       struct object_id *oid, int *flags)
-{
-	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refnam=
e,
-				       resolve_flags, oid, flags);
-}
-
 int resolve_gitlink_ref(const char *submodule, const char *refname,
 			struct object_id *oid)
 {
@@ -2323,13 +2196,6 @@ int refs_create_symref(struct ref_store *refs,
 	return retval;
 }
=20
-int create_symref(const char *ref_target, const char *refs_heads_master,
-		  const char *logmsg)
-{
-	return refs_create_symref(get_main_ref_store(the_repository), ref_target,
-				  refs_heads_master, logmsg);
-}
-
 int ref_update_reject_duplicates(struct string_list *refnames,
 				 struct strbuf *err)
 {
@@ -2623,11 +2489,6 @@ int refs_for_each_reflog(struct ref_store *refs, eac=
h_reflog_fn fn, void *cb_dat
 					     do_for_each_reflog_helper, &hp);
 }
=20
-int for_each_reflog(each_reflog_fn fn, void *cb_data)
-{
-	return refs_for_each_reflog(get_main_ref_store(the_repository), fn, cb_da=
ta);
-}
-
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 				     const char *refname,
 				     each_reflog_ent_fn fn,
@@ -2637,58 +2498,28 @@ int refs_for_each_reflog_ent_reverse(struct ref_sto=
re *refs,
 						     fn, cb_data);
 }
=20
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
-				void *cb_data)
-{
-	return refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository=
),
-						refname, fn, cb_data);
-}
-
 int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
 			     each_reflog_ent_fn fn, void *cb_data)
 {
 	return refs->be->for_each_reflog_ent(refs, refname, fn, cb_data);
 }
=20
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
-			void *cb_data)
-{
-	return refs_for_each_reflog_ent(get_main_ref_store(the_repository), refna=
me,
-					fn, cb_data);
-}
-
 int refs_reflog_exists(struct ref_store *refs, const char *refname)
 {
 	return refs->be->reflog_exists(refs, refname);
 }
=20
-int reflog_exists(const char *refname)
-{
-	return refs_reflog_exists(get_main_ref_store(the_repository), refname);
-}
-
 int refs_create_reflog(struct ref_store *refs, const char *refname,
 		       struct strbuf *err)
 {
 	return refs->be->create_reflog(refs, refname, err);
 }
=20
-int safe_create_reflog(const char *refname, struct strbuf *err)
-{
-	return refs_create_reflog(get_main_ref_store(the_repository), refname,
-				  err);
-}
-
 int refs_delete_reflog(struct ref_store *refs, const char *refname)
 {
 	return refs->be->delete_reflog(refs, refname);
 }
=20
-int delete_reflog(const char *refname)
-{
-	return refs_delete_reflog(get_main_ref_store(the_repository), refname);
-}
-
 int refs_reflog_expire(struct ref_store *refs,
 		       const char *refname,
 		       unsigned int flags,
@@ -2702,19 +2533,6 @@ int refs_reflog_expire(struct ref_store *refs,
 				       cleanup_fn, policy_cb_data);
 }
=20
-int reflog_expire(const char *refname,
-		  unsigned int flags,
-		  reflog_expiry_prepare_fn prepare_fn,
-		  reflog_expiry_should_prune_fn should_prune_fn,
-		  reflog_expiry_cleanup_fn cleanup_fn,
-		  void *policy_cb_data)
-{
-	return refs_reflog_expire(get_main_ref_store(the_repository),
-				  refname, flags,
-				  prepare_fn, should_prune_fn,
-				  cleanup_fn, policy_cb_data);
-}
-
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
@@ -2793,12 +2611,6 @@ int refs_delete_refs(struct ref_store *refs, const c=
har *logmsg,
 	return ret;
 }
=20
-int delete_refs(const char *msg, struct string_list *refnames,
-		unsigned int flags)
-{
-	return refs_delete_refs(get_main_ref_store(the_repository), msg, refnames=
, flags);
-}
-
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg)
 {
@@ -2811,11 +2623,6 @@ int refs_rename_ref(struct ref_store *refs, const ch=
ar *oldref,
 	return retval;
 }
=20
-int rename_ref(const char *oldref, const char *newref, const char *logmsg)
-{
-	return refs_rename_ref(get_main_ref_store(the_repository), oldref, newref=
, logmsg);
-}
-
 int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg)
 {
@@ -2827,8 +2634,3 @@ int refs_copy_existing_ref(struct ref_store *refs, co=
nst char *oldref,
 	free(msg);
 	return retval;
 }
-
-int copy_existing_ref(const char *oldref, const char *newref, const char *=
logmsg)
-{
-	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref,=
 newref, logmsg);
-}
diff --git a/refs.h b/refs.h
index a28de62fb5..d02dd79ca6 100644
--- a/refs.h
+++ b/refs.h
@@ -72,22 +72,14 @@ const char *refs_resolve_ref_unsafe(struct ref_store *r=
efs,
 				    struct object_id *oid,
 				    int *flags);
=20
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       struct object_id *oid, int *flags);
-
 char *refs_resolve_refdup(struct ref_store *refs,
 			  const char *refname, int resolve_flags,
 			  struct object_id *oid, int *flags);
-char *resolve_refdup(const char *refname, int resolve_flags,
-		     struct object_id *oid, int *flags);
=20
 int refs_read_ref_full(struct ref_store *refs, const char *refname,
 		       int resolve_flags, struct object_id *oid, int *flags);
-int read_ref_full(const char *refname, int resolve_flags,
-		  struct object_id *oid, int *flags);
=20
 int refs_read_ref(struct ref_store *refs, const char *refname, struct obje=
ct_id *oid);
-int read_ref(const char *refname, struct object_id *oid);
=20
 int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refnam=
e,
 			   struct strbuf *referent);
@@ -118,8 +110,6 @@ int refs_verify_refname_available(struct ref_store *ref=
s,
=20
 int refs_ref_exists(struct ref_store *refs, const char *refname);
=20
-int ref_exists(const char *refname);
-
 int should_autocreate_reflog(const char *refname);
=20
 int is_branch(const char *refname);
@@ -334,18 +324,6 @@ int refs_for_each_branch_ref(struct ref_store *refs,
 int refs_for_each_remote_ref(struct ref_store *refs,
 			     each_ref_fn fn, void *cb_data);
=20
-/* just iterates the head ref. */
-int head_ref(each_ref_fn fn, void *cb_data);
-
-/* iterates all refs. */
-int for_each_ref(each_ref_fn fn, void *cb_data);
-
-/**
- * iterates all refs which have a defined prefix and strips that prefix fr=
om
- * the passed variable refname.
- */
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
-
 /*
  * references matching any pattern in "exclude_patterns" are omitted from =
the
  * result set on a best-effort basis.
@@ -353,8 +331,6 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn,=
 void *cb_data);
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     const char **exclude_patterns,
 			     each_ref_fn fn, void *cb_data);
-int for_each_fullref_in(const char *prefix, const char **exclude_patterns,
-			each_ref_fn fn, void *cb_data);
=20
 /**
  * iterate all refs in "patterns" by partitioning patterns into disjoint s=
ets
@@ -374,23 +350,16 @@ int refs_for_each_fullref_in_prefixes(struct ref_stor=
e *refs,
 /**
  * iterate refs from the respective area.
  */
-int for_each_tag_ref(each_ref_fn fn, void *cb_data);
-int for_each_branch_ref(each_ref_fn fn, void *cb_data);
-int for_each_remote_ref(each_ref_fn fn, void *cb_data);
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *=
cb_data);
=20
 /* iterates all refs that match the specified glob pattern. */
 int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
 			   const char *pattern, void *cb_data);
-int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
=20
 int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
 			      const char *pattern, const char *prefix, void *cb_data);
-int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
-			 const char *prefix, void *cb_data);
=20
 int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void =
*cb_data);
-int head_ref_namespaced(each_ref_fn fn, void *cb_data);
=20
 /*
  * references matching any pattern in "exclude_patterns" are omitted from =
the
@@ -399,12 +368,9 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data);
 int refs_for_each_namespaced_ref(struct ref_store *refs,
 				 const char **exclude_patterns,
 				 each_ref_fn fn, void *cb_data);
-int for_each_namespaced_ref(const char **exclude_patterns,
-			    each_ref_fn fn, void *cb_data);
=20
 /* can be used to learn about broken ref and symref */
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_=
data);
-int for_each_rawref(each_ref_fn fn, void *cb_data);
=20
 /*
  * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.
@@ -460,7 +426,6 @@ int refs_pack_refs(struct ref_store *refs, struct pack_=
refs_opts *opts);
  */
 int refs_create_reflog(struct ref_store *refs, const char *refname,
 		       struct strbuf *err);
-int safe_create_reflog(const char *refname, struct strbuf *err);
=20
 /**
  * Reads log for the value of ref during at_time (in which case "cnt" shou=
ld be
@@ -484,7 +449,6 @@ int read_ref_at(struct ref_store *refs,
=20
 /** Check if a particular reflog exists */
 int refs_reflog_exists(struct ref_store *refs, const char *refname);
-int reflog_exists(const char *refname);
=20
 /*
  * Delete the specified reference. If old_oid is non-NULL, then
@@ -498,8 +462,6 @@ int refs_delete_ref(struct ref_store *refs, const char =
*msg,
 		    const char *refname,
 		    const struct object_id *old_oid,
 		    unsigned int flags);
-int delete_ref(const char *msg, const char *refname,
-	       const struct object_id *old_oid, unsigned int flags);
=20
 /*
  * Delete the specified references. If there are any problems, emit
@@ -509,12 +471,9 @@ int delete_ref(const char *msg, const char *refname,
  */
 int refs_delete_refs(struct ref_store *refs, const char *msg,
 		     struct string_list *refnames, unsigned int flags);
-int delete_refs(const char *msg, struct string_list *refnames,
-		unsigned int flags);
=20
 /** Delete a reflog */
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
-int delete_reflog(const char *refname);
=20
 /*
  * Callback to process a reflog entry found by the iteration functions (see
@@ -560,17 +519,7 @@ int refs_for_each_reflog_ent_reverse(struct ref_store =
*refs,
 				     void *cb_data);
=20
 /*
- * Iterate over reflog entries in the log for `refname` in the main ref st=
ore.
- */
-
-/* oldest entry first */
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *=
cb_data);
-
-/* youngest entry first */
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn=
, void *cb_data);
-
-/*
- * The signature for the callback function for the {refs_,}for_each_reflog=
()
+ * The signature for the callback function for the refs_for_each_reflog()
  * functions below. The memory pointed to by the refname argument is only
  * guaranteed to be valid for the duration of a single callback invocation.
  */
@@ -581,7 +530,6 @@ typedef int each_reflog_fn(const char *refname, void *c=
b_data);
  * and returns the value. Reflog file order is unspecified.
  */
 int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *=
cb_data);
-int for_each_reflog(each_reflog_fn fn, void *cb_data);
=20
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
@@ -606,23 +554,17 @@ const char *prettify_refname(const char *refname);
=20
 char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 				   const char *refname, int strict);
-char *shorten_unambiguous_ref(const char *refname, int strict);
=20
 /** rename ref, return 0 on success **/
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg);
-int rename_ref(const char *oldref, const char *newref,
-			const char *logmsg);
=20
 /** copy ref, return 0 on success **/
 int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg);
-int copy_existing_ref(const char *oldref, const char *newref,
-			const char *logmsg);
=20
 int refs_create_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg);
-int create_symref(const char *refname, const char *target, const char *log=
msg);
=20
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
@@ -636,7 +578,6 @@ enum action_on_err {
  */
 struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 						    struct strbuf *err);
-struct ref_transaction *ref_transaction_begin(struct strbuf *err);
=20
 /*
  * Reference transaction updates
@@ -867,9 +808,6 @@ void ref_transaction_free(struct ref_transaction *trans=
action);
 int refs_update_ref(struct ref_store *refs, const char *msg, const char *r=
efname,
 		    const struct object_id *new_oid, const struct object_id *old_oid,
 		    unsigned int flags, enum action_on_err onerr);
-int update_ref(const char *msg, const char *refname,
-	       const struct object_id *new_oid, const struct object_id *old_oid,
-	       unsigned int flags, enum action_on_err onerr);
=20
 int parse_hide_refs_config(const char *var, const char *value, const char =
*,
 			   struct strvec *);
@@ -927,7 +865,7 @@ enum expire_reflog_flags {
=20
 /*
  * The following interface is used for reflog expiration. The caller
- * calls reflog_expire(), supplying it with three callback functions,
+ * calls refs_reflog_expire(), supplying it with three callback functions,
  * of the following types. The callback functions define the
  * expiration policy that is desired.
  *
@@ -964,12 +902,6 @@ int refs_reflog_expire(struct ref_store *refs,
 		       reflog_expiry_should_prune_fn should_prune_fn,
 		       reflog_expiry_cleanup_fn cleanup_fn,
 		       void *policy_cb_data);
-int reflog_expire(const char *refname,
-		  unsigned int flags,
-		  reflog_expiry_prepare_fn prepare_fn,
-		  reflog_expiry_should_prune_fn should_prune_fn,
-		  reflog_expiry_cleanup_fn cleanup_fn,
-		  void *policy_cb_data);
=20
 struct ref_store *get_main_ref_store(struct repository *r);
=20
@@ -1068,4 +1000,211 @@ void update_ref_namespace(enum ref_namespace namesp=
ace, char *ref);
 int is_pseudoref(struct ref_store *refs, const char *refname);
 int is_headref(struct ref_store *refs, const char *refname);
=20
+/*
+ * The following functions have been removed in Git v2.45 in favor of func=
tions
+ * that receive a `ref_store` as parameter. The intent of this section is
+ * merely to help patch authors of in-flight series to have a reference wh=
at
+ * they should be migrating to. The section will be removed in Git v2.46.
+ */
+#if 0
+static char *resolve_refdup(const char *refname, int resolve_flags,
+			    struct object_id *oid, int *flags)
+{
+	return refs_resolve_refdup(get_main_ref_store(the_repository),
+				   refname, resolve_flags,
+				   oid, flags);
+}
+
+static int read_ref_full(const char *refname, int resolve_flags,
+			 struct object_id *oid, int *flags)
+{
+	return refs_read_ref_full(get_main_ref_store(the_repository), refname,
+				  resolve_flags, oid, flags);
+}
+
+static int read_ref(const char *refname, struct object_id *oid)
+{
+	return refs_read_ref(get_main_ref_store(the_repository), refname, oid);
+}
+
+static int ref_exists(const char *refname)
+{
+	return refs_ref_exists(get_main_ref_store(the_repository), refname);
+}
+
+static int for_each_tag_ref(each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_tag_ref(get_main_ref_store(the_repository), fn, cb_d=
ata);
+}
+
+static int for_each_branch_ref(each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_branch_ref(get_main_ref_store(the_repository), fn, c=
b_data);
+}
+
+static int for_each_remote_ref(each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_remote_ref(get_main_ref_store(the_repository), fn, c=
b_data);
+}
+
+static int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+{
+	return refs_head_ref_namespaced(get_main_ref_store(the_repository),
+					fn, cb_data);
+}
+
+static int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+				const char *prefix, void *cb_data)
+{
+	return refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
+					 fn, pattern, prefix, cb_data);
+}
+
+static int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb=
_data)
+{
+	return refs_for_each_glob_ref(get_main_ref_store(the_repository),
+				      fn, pattern, cb_data);
+}
+
+static int delete_ref(const char *msg, const char *refname,
+		      const struct object_id *old_oid, unsigned int flags)
+{
+	return refs_delete_ref(get_main_ref_store(the_repository), msg, refname,
+			       old_oid, flags);
+}
+
+static struct ref_transaction *ref_transaction_begin(struct strbuf *err)
+{
+	return ref_store_transaction_begin(get_main_ref_store(the_repository), er=
r);
+}
+
+static int update_ref(const char *msg, const char *refname,
+		      const struct object_id *new_oid,
+		      const struct object_id *old_oid,
+		      unsigned int flags, enum action_on_err onerr)
+{
+	return refs_update_ref(get_main_ref_store(the_repository), msg, refname, =
new_oid,
+			       old_oid, flags, onerr);
+}
+
+static char *shorten_unambiguous_ref(const char *refname, int strict)
+{
+	return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+					    refname, strict);
+}
+
+static int head_ref(each_ref_fn fn, void *cb_data)
+{
+	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
+}
+
+static int for_each_ref(each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_ref(get_main_ref_store(the_repository), fn, cb_data);
+}
+
+static int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_da=
ta)
+{
+	return refs_for_each_ref_in(get_main_ref_store(the_repository), prefix, f=
n, cb_data);
+}
+
+static int for_each_fullref_in(const char *prefix,
+			       const char **exclude_patterns,
+			       each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_fullref_in(get_main_ref_store(the_repository),
+					prefix, exclude_patterns, fn, cb_data);
+}
+
+static int for_each_namespaced_ref(const char **exclude_patterns,
+				   each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
+					    exclude_patterns, fn, cb_data);
+}
+
+static int for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_da=
ta);
+}
+
+static const char *resolve_ref_unsafe(const char *refname, int resolve_fla=
gs,
+				      struct object_id *oid, int *flags)
+{
+	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refnam=
e,
+				       resolve_flags, oid, flags);
+}
+
+static int create_symref(const char *ref_target, const char *refs_heads_ma=
ster,
+			 const char *logmsg)
+{
+	return refs_create_symref(get_main_ref_store(the_repository), ref_target,
+				  refs_heads_master, logmsg);
+}
+
+static int for_each_reflog(each_reflog_fn fn, void *cb_data)
+{
+	return refs_for_each_reflog(get_main_ref_store(the_repository), fn, cb_da=
ta);
+}
+
+static int for_each_reflog_ent_reverse(const char *refname, each_reflog_en=
t_fn fn,
+				       void *cb_data)
+{
+	return refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository=
),
+						refname, fn, cb_data);
+}
+
+static int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
+			       void *cb_data)
+{
+	return refs_for_each_reflog_ent(get_main_ref_store(the_repository), refna=
me,
+					fn, cb_data);
+}
+
+static int reflog_exists(const char *refname)
+{
+	return refs_reflog_exists(get_main_ref_store(the_repository), refname);
+}
+
+static int safe_create_reflog(const char *refname, struct strbuf *err)
+{
+	return refs_create_reflog(get_main_ref_store(the_repository), refname,
+				  err);
+}
+
+static int delete_reflog(const char *refname)
+{
+	return refs_delete_reflog(get_main_ref_store(the_repository), refname);
+}
+
+static int reflog_expire(const char *refname,
+			 unsigned int flags,
+			 reflog_expiry_prepare_fn prepare_fn,
+			 reflog_expiry_should_prune_fn should_prune_fn,
+			 reflog_expiry_cleanup_fn cleanup_fn,
+			 void *policy_cb_data)
+{
+	return refs_reflog_expire(get_main_ref_store(the_repository),
+				  refname, flags,
+				  prepare_fn, should_prune_fn,
+				  cleanup_fn, policy_cb_data);
+}
+
+static int delete_refs(const char *msg, struct string_list *refnames,
+		       unsigned int flags)
+{
+	return refs_delete_refs(get_main_ref_store(the_repository), msg, refnames=
, flags);
+}
+
+static int rename_ref(const char *oldref, const char *newref, const char *=
logmsg)
+{
+	return refs_rename_ref(get_main_ref_store(the_repository), oldref, newref=
, logmsg);
+}
+
+static int copy_existing_ref(const char *oldref, const char *newref, const=
 char *logmsg)
+{
+	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref,=
 newref, logmsg);
+}
+#endif
+
 #endif /* REFS_H */
--=20
2.45.0


--23s7TY/zOW8fq8Aq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY51D0ACgkQVbJhu7ck
PpS+9BAAmoOajcwxnbI/1Yqf/fNuG/S/YIg3/M4/ryS1FoOMGVrgX1EmkFyI53Qn
bzWnhSTTdmC9nJ8dNteNjd9NVUrxnVgcl4fWL6bDdj9iFpJQh20/iOsvM0TX1TDf
eGUrvbY2wopMKIZA/6hajrNpby/NM73QjfASmE0udt9UHLXtDijyG/8DN63I6acq
9hRNqCsGUDJSTjmk9sCA1XFLg/VQvt1bJ9RSg83AD24RAe3kmgF5ScDzBTGxFiP5
wBuLeZX2Th6TxftZ1vCFEEyzdZvKzFzIFBoBpaT0OSd1A1mp+ym8fPJZDwqtlQzg
Q26BJREjh1pLFOvvsHNJskSsrDNGXVP3AhE+j6Evzo7qIj+jH36LQSZbyWARgxM+
zuI+ZU+ge7BGh6f/5RrxnqvfzN0/QsTWMDmj5SNqdWmuVTOqtqsyljP8HXzGnz2z
hTmQXRZI+xxotPZb7oEU9lNUaOSsnKdGTvwSeo6erEjAaUTzemOYUhD9Zx43t3Nz
fAQgerQNAjMtGv30kkKCEykm+dluPeineGmfXmt8znhCsvoxPuGnn2Lyhazg5HRF
iGAM2gzoqDflOxcpAMg7nNLIVdZH6f6M646763wp/Cp0CJgOcyHCE5aQoL8VqL+s
rRVwpmQqcJtA32ksXg7D55uMt3xn+6xviUHbX8PVGXLUzWtfiAs=
=hCXj
-----END PGP SIGNATURE-----

--23s7TY/zOW8fq8Aq--
