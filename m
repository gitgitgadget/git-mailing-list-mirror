Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692A282E5
	for <git@vger.kernel.org>; Fri,  3 May 2024 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717705; cv=none; b=ROP6wcjTdg8z195qzfBPFr6naqaePXAMIa0J0DeOOQKhSJZDXx8aJTDSj4v/V/A5G4qRrn1LIKRzasnt0xQ0aokiMUvUwP+KCJxFSfFvpVYCaIMSd4BcRPEttDUlBG+tiuadx06RRgCWLygIfT8V5Usx24Azz6mQol3/6UKpj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717705; c=relaxed/simple;
	bh=hkR7K5sDxGO4LzpzrHED03BCTVVyImoC2aG9NQ5gI/Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPidSvTQypqlLesNcMvcgj0WkxrBWXZ478UUTBEDNQXD19aAaRXpJafi0CICIqsTNZyX3oZtYP1G38ZCxUOI+uvrrph8Y9LFonK9sPLx0CIuU1AiOQXlHs1KjbYoBTDwlVSR2khE8h+efi4gkoiUepyV6H3d2LY4jVm6YUwLiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vNGUIl0D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWRin/zP; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vNGUIl0D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YWRin/zP"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id E0DF118000F9
	for <git@vger.kernel.org>; Fri,  3 May 2024 02:28:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 03 May 2024 02:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714717702; x=1714804102; bh=7WNf9VoSWz
	Il9f/1wg++miawMPOTI6t18icEURLR8bo=; b=vNGUIl0Die5N6rTjtHfS4jBycJ
	C3AaZyIQPWokt7iRurFKpWpcFChln5br0F5aXIpZAcSj2r2vf91w7ADaS9uS7PEW
	enDEHsoKmYeWe4qZq9mnJXMln6KgwSKAoaZWAFKdcZUZRGl04rE/A06inX+twTb8
	EKQieIOX4gGQM3sp8roS+sLsi1O4S4W73Ub4DYTJIQOi7F0573PEV7cz90AWROda
	AOxu5WVKpCAf7x3V3/Yl9AzCDQDnKe+PKl7ndXGFlPVyvPOMFp0abqLDMJzWsQqn
	TLlmcpZgtQpqFRFagC1ge23BzCJ8zmFl/lYV1DU/7dF2OfAreQXkpaY/A9eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714717702; x=1714804102; bh=7WNf9VoSWzIl9f/1wg++miawMPOT
	I6t18icEURLR8bo=; b=YWRin/zPOAh9H7TmARHa/nUCzFiuPb72ej7QKg+VahGr
	QZVltOfSZdc33iWyNTQ0TlBTx4qjWU2198SWjKBqy5cdA0UK2ojQvC/Mcz1s9GVK
	zEX4OWbsTfGT3JAPDE4/XTXQoV6uARCnjWVgeA9SWYslWcRSyRXIde7go5KFl1bX
	8qw29cOHfrdFa4QSYbITugM0DqDW1XbJJG35p21drn4b69W81deEtKPgG8MKA7j1
	QH6NJsYLdcvJhnrqMZSLwtIVDBYKBf2qTt/KohZp6aGDmpZ337Msr31Sa6q17kof
	pj7isBOkR+5pignsPwvevcXRX2Tbc79NpRrpSUxmGw==
X-ME-Sender: <xms:BoQ0ZmkJzlNwVnD34aDzsD1WzqV02OnEh3kAEXl9y69r9cRKrKNesQ>
    <xme:BoQ0Zt1z8M1acIh07NJXw3c-Qog7ts7CQE9iC3LNKmONfwEToPqTshWEIMCM4gIDf
    t4PwTeuRgdJyrwQqQ>
X-ME-Received: <xmr:BoQ0Zko7liS0VDSNwRGJOcM9QOqBdzT5tfx5P7J3_ryPs5nwq_as9npFpNVgII9E0hLAoa_5PKwBUmlRQzQij5VDE9L-6gN_AtfUOK3PHD1W3XPM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BoQ0ZqkmV6aLbPy7uFwzyRpdIJckvp1h3z033laHOiXr76VrZhiG_w>
    <xmx:BoQ0Zk0Q543uF5WOoO3toOqIdESZ0su0on87uG2MeifmAVSBMg5Dwg>
    <xmx:BoQ0Zhu76VETTz3PceoDSGyTEbAE9IUKXxUVBhMVBCcPO4YRhR_ELw>
    <xmx:BoQ0ZgV-IDio7qb-VoOgqMhMUuDOeRpRaKLZe3WLSNhcSR1ggCdE0Q>
    <xmx:BoQ0Zh_-AjtcM33hqwvRLPk6v9WwwXuFjKZHkRuAberjPZQG4blb1URY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 May 2024 02:28:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d5613405 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 May 2024 06:27:54 +0000 (UTC)
Date: Fri, 3 May 2024 08:28:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/5] refs: remove functions without ref store
Message-ID: <47eb6aee922b1e17caa76b2e7366d9bdf26aa6e1.1714717057.git.ps@pks.im>
References: <cover.1714717057.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="klTyGH4r69cFKYLK"
Content-Disposition: inline
In-Reply-To: <cover.1714717057.git.ps@pks.im>


--klTyGH4r69cFKYLK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The preceding commit has rewritten all callers of ref-related functions
to use the equivalents that accept a `struct ref_store`. Consequently,
the respective variants without the ref store are now unused. Remove
them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 198 ---------------------------------------------------------
 refs.h |  72 +--------------------
 2 files changed, 2 insertions(+), 268 deletions(-)

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
index a28de62fb5..2582a8f311 100644
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
--=20
2.45.0


--klTyGH4r69cFKYLK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0hAIACgkQVbJhu7ck
PpTmbQ/9H10A/SE97D1J5gz4wVAm3fSsE5RdzeOt7e4Mk0yrv94tJHKTivmDRF+F
nGy9DsCgipwIgXuFz6yQQ/xg/UZhlwHZ/2jX6eTq5EYA/eeOAdZ+eBk3NMcS83YE
OzxcnHWoZosT0TwHyDbLijCDibAETnuifdqgh/t5pbaFrn23I0Yi/xpPrGPmjrxs
pJG+eOE5f1Nrcmf0byzMyfoqdRpnFY/adbPXYl/iEopXVWH3xCHcojI9g4js8Gy+
DZxqxnk+xpYykEsFIfXMrNVrm2fFJY+e7k4sA9vAWDLs6YEA3MdxkEULSWIp3YTC
km9FU0oXfd3XAt4rNzb+YmwyxgUya+bFfWUiGnZfSnbydME7DKqlWDWgr8YA70IT
x2x1Mpr0ymyA5ROANftIc9OkVa7ff7UYCHFCdH4HiKxebpPdTO/Zh4ElNcM4w/Kv
A5YskMugwuSwwVB6p1mFM6L+BLuwu+yBMl1GH9M3NL47S0N6Fvyv3ZYyl/Evhady
C5HGHILaMW/7AHl6gO8KcvNnQhMiPWDraKcvqUvA2QwMg8179gafIBK+HU23hlRj
y9csLUev6b2YKg+L7NRztf9EmMoHcHTNI+gzDGZxhZqKfyeXAT3KBUJiBkdd8MY7
YOuVNVqDiZoODlEzOhZPCFG7eNCeqwdA6yWcrKNfEhQwuk98x80=
=wvQd
-----END PGP SIGNATURE-----

--klTyGH4r69cFKYLK--
