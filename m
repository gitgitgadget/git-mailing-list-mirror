Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0C13B28D
	for <git@vger.kernel.org>; Tue,  7 May 2024 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065904; cv=none; b=IKwgdPSg/RnFYvjcGNoqK6eaA0n99FXYOgpGq+Fc3BUmC/wK1EsTla+GJbYVEEeQ8dmODbtGSbr6FadJE3UwYcVk7EqdB4G2oM9ZyeS0c/h1Gz8rpXLBV7iru9JKbezOP67lP/MUXTMNDyAl9pZHvzozaJBJ8so8qNXBZtVsDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065904; c=relaxed/simple;
	bh=py7K7M32WsL+0tCFqR+YglvN18pzk+cqZKaXwGVi2gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ekx4m0GOgXHkv8JQ6B5HT5D9ggaaZedANE32k2vS/1K4TYJQPEGW95yOogH2pD0QMGCmjQPXxmrlZjNLbpKA3eSMl1mJt70ZLBczDHXCw33HdvJLMO9IoHtqDRjlShBhVg3XUCbVEJLuRGGwLMjRfPGC4xcgO0GO22lFVh/ISUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QXIwRww9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CCHbYcMY; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QXIwRww9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CCHbYcMY"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id F1C011C001A7;
	Tue,  7 May 2024 03:11:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 May 2024 03:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715065900; x=1715152300; bh=GpR9hbGGHu
	7Wi+TSfmD1AVdi0NwbNSECiy73Q7dwx1I=; b=QXIwRww907cTnHboi0QtubkO4o
	9meeMGMfKTnhlADFP/p1wZpALsNjw7jNE71UIQiiogAuZHuZfTUK7MIMu5IG38PR
	+az2aQpOo9nMcSRb/xII+mAwosL2PadDxHwadvo6jeADRCPY3L77bEG8q1+PfmiH
	IH6NpfKznELKc3SD0QQUojC7qdNdqDLZX/iPjMbFOzga9wwYSNgcL4kzazd67QXG
	tAlSQgL7s/Brt0F8/5bTeoJuwrypVxHYdf+YFV6EHgtrSg+13BC1NnsBbITGxYgN
	xkXQMXUfnll7yxj8FCuofxVnmCluShVgtLb4kNNGPHH2ziVCMhT/wN7IBHoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715065900; x=1715152300; bh=GpR9hbGGHu7Wi+TSfmD1AVdi0Nwb
	NSECiy73Q7dwx1I=; b=CCHbYcMYGZYsAwfjCdXh7xhYDtMJL1j6HeFdieMJIuFE
	pW0fSD+CdcMaX2WjpNaWAt6duMEkrFN3xXIleUCCg4nca3U2k9WqVRVAc1ixCf/c
	d4HP+xTvCor8pMZCPk8GqOWrgiljIBkyMHOTCIVTKiIbCs1YUf7cS8QnuDbfW+o6
	hP6UabnTXQFnWD13eJmo4pT4lUsun/JD01dE50Ooc11DoGeaIfF/GTivplh3gls+
	GXEPsMeYx7YhoglJsCtGYKmct1DUObiAcpsr4odGaDvssAl1nVds9x98srRLEfhH
	zvYPT2YyKvTwZcJDQZyJkPl377eA1X8dGdd+QChz3A==
X-ME-Sender: <xms:LNQ5Zu0Y5LGg4UKFxHZvtmrpTaPi2LuhLOjODZk495f1SquROBoVHA>
    <xme:LNQ5ZhGn9XQN8u-FXxyxDc0Yn8uVbwY_z8oN4cTyKl84ysijWpBPDeUayS2md9KPj
    8XRk3SE22iaPSiCDg>
X-ME-Received: <xmr:LNQ5Zm7AvTl-wCda8Gxzonxwq0TqAi7VGuK5yo-OcvYeUmEzA26mcEXMbfVQ6be3p13eVY1hsd4CxkTxhKKGnnem1wACTe0ctZztJgLCdhXn_3dZUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:LNQ5Zv0u-R4BrWy5A80GxXIS--G7_PL_WAIelwepNd3xLH_YlqvQhQ>
    <xmx:LNQ5ZhEU0AOxB6Xs3gHNh2sbHeKUqrGbPceOZnDHdyq2pbyIjFp_lg>
    <xmx:LNQ5Zo9tMlD9MdlDCaHTQyNA5bdr9X6VosDwCykC1mnO0CyqtEv4pw>
    <xmx:LNQ5ZmmxWOiKptzCU4W3gL2JfvhhdHW4Te5YKfT2U0hPrPXjyiokxA>
    <xmx:LNQ5ZlikvTmYSU2afGwcKFwEEb8c30J3ElMssRc2XUua3SqTMjqzDn7l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 03:11:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 93efdcb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 07:11:29 +0000 (UTC)
Date: Tue, 7 May 2024 09:11:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, James Liu <james@jamesliu.io>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 0/5] refs: remove functions without ref store
Message-ID: <cover.1715065736.git.ps@pks.im>
References: <cover.1714717057.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EVxA+z//lq4yBTdB"
Content-Disposition: inline
In-Reply-To: <cover.1714717057.git.ps@pks.im>


--EVxA+z//lq4yBTdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to remove
functions from "refs.h" that implicitly rely on `the_repository` to
obtain the ref store.

There's only a single change compared to v1. As discussed, we want to
give in-flight patch series a bit more guidance when they add new calls
to the now-removed functions. This is done in the form of a new section
with ifdef'd function declarations for every removed function. These are
easily greppable and trivially show the author of the series how they
are supposed to adapt to the new world.

Thanks for all the feedback!

Patrick

Patrick Steinhardt (5):
  refs: introduce missing functions that accept a `struct ref_store`
  refs: add `exclude_patterns` parameter to `for_each_fullref_in()`
  cocci: introduce rules to transform "refs" to pass ref store
  cocci: apply rules to rewrite callers of "refs" interfaces
  refs: remove functions without ref store

 add-interactive.c             |  17 +-
 bisect.c                      |  25 ++-
 blame.c                       |   4 +-
 branch.c                      |   5 +-
 builtin/am.c                  |  38 +++--
 builtin/bisect.c              |  44 ++---
 builtin/blame.c               |   4 +-
 builtin/branch.c              |  49 +++---
 builtin/checkout.c            |  35 ++--
 builtin/clone.c               |  36 +++--
 builtin/describe.c            |   3 +-
 builtin/fast-import.c         |  11 +-
 builtin/fetch.c               |  20 ++-
 builtin/fsck.c                |  11 +-
 builtin/gc.c                  |   3 +-
 builtin/log.c                 |   6 +-
 builtin/merge.c               |  34 ++--
 builtin/name-rev.c            |   5 +-
 builtin/notes.c               |  26 +--
 builtin/pack-objects.c        |  10 +-
 builtin/pull.c                |   2 +-
 builtin/rebase.c              |  18 ++-
 builtin/receive-pack.c        |  15 +-
 builtin/reflog.c              |  25 +--
 builtin/remote.c              |  37 +++--
 builtin/repack.c              |   7 +-
 builtin/replace.c             |   9 +-
 builtin/reset.c               |  13 +-
 builtin/rev-parse.c           |  25 ++-
 builtin/show-branch.c         |  22 ++-
 builtin/show-ref.c            |  19 ++-
 builtin/stash.c               |  23 +--
 builtin/submodule--helper.c   |   7 +-
 builtin/symbolic-ref.c        |  13 +-
 builtin/tag.c                 |  11 +-
 builtin/update-index.c        |   2 +-
 builtin/update-ref.c          |  21 ++-
 builtin/worktree.c            |  19 ++-
 bundle-uri.c                  |  12 +-
 bundle.c                      |   2 +-
 commit-graph.c                |   3 +-
 commit.c                      |   3 +-
 config.c                      |   3 +-
 contrib/coccinelle/refs.cocci | 103 ++++++++++++
 delta-islands.c               |   3 +-
 fetch-pack.c                  |   6 +-
 fmt-merge-msg.c               |   4 +-
 help.c                        |   5 +-
 http-backend.c                |  13 +-
 log-tree.c                    |   9 +-
 ls-refs.c                     |  10 +-
 midx-write.c                  |   3 +-
 negotiator/default.c          |   3 +-
 negotiator/skipping.c         |   3 +-
 notes-cache.c                 |   6 +-
 notes-merge.c                 |   2 +-
 notes-utils.c                 |   7 +-
 notes.c                       |   5 +-
 reachable.c                   |   5 +-
 ref-filter.c                  |  35 ++--
 reflog-walk.c                 |  27 +++-
 reflog.c                      |  20 ++-
 refs.c                        | 200 +++--------------------
 refs.h                        | 291 ++++++++++++++++++++++++++--------
 remote.c                      |  38 +++--
 reset.c                       |  29 ++--
 revision.c                    |  27 ++--
 sequencer.c                   |  61 +++----
 server-info.c                 |   3 +-
 setup.c                       |   2 +-
 shallow.c                     |  16 +-
 submodule.c                   |   6 +-
 transport-helper.c            |  29 ++--
 transport.c                   |  16 +-
 upload-pack.c                 |  20 ++-
 walker.c                      |   6 +-
 wt-status.c                   |  22 +--
 77 files changed, 1052 insertions(+), 680 deletions(-)
 create mode 100644 contrib/coccinelle/refs.cocci

Range-diff against v1:
1:  dba5df086d =3D 1:  dba5df086d refs: introduce missing functions that ac=
cept a `struct ref_store`
2:  4f34bb2e03 =3D 2:  4f34bb2e03 refs: add `exclude_patterns` parameter to=
 `for_each_fullref_in()`
3:  ffe83f7482 =3D 3:  ffe83f7482 cocci: introduce rules to transform "refs=
" to pass ref store
4:  5109468b35 =3D 4:  5109468b35 cocci: apply rules to rewrite callers of =
"refs" interfaces
5:  47eb6aee92 ! 5:  773873f244 refs: remove functions without ref store
    @@ Commit message
         the respective variants without the ref store are now unused. Remo=
ve
         them.
    =20
    +    There are likely patch series in-flight that use the now-removed
    +    functions. To help the authors, the old implementations have been =
added
    +    to "refs.c" in an ifdef'd section as a reference for how to migrat=
e each
    +    of the respective callers.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## refs.c ##
    @@ refs.h: int refs_reflog_expire(struct ref_store *refs,
     =20
      struct ref_store *get_main_ref_store(struct repository *r);
     =20
    +@@ refs.h: void update_ref_namespace(enum ref_namespace namespace, cha=
r *ref);
    + int is_pseudoref(struct ref_store *refs, const char *refname);
    + int is_headref(struct ref_store *refs, const char *refname);
    +=20
    ++/*
    ++ * The following functions have been removed in Git v2.45 in favor of=
 functions
    ++ * that receive a `ref_store` as parameter. The intent of this sectio=
n is
    ++ * merely to help patch authors of in-flight series to have a referen=
ce what
    ++ * they should be migrating to. The section will be removed in Git v2=
=2E46.
    ++ */
    ++#if 0
    ++static char *resolve_refdup(const char *refname, int resolve_flags,
    ++			    struct object_id *oid, int *flags)
    ++{
    ++	return refs_resolve_refdup(get_main_ref_store(the_repository),
    ++				   refname, resolve_flags,
    ++				   oid, flags);
    ++}
    ++
    ++static int read_ref_full(const char *refname, int resolve_flags,
    ++			 struct object_id *oid, int *flags)
    ++{
    ++	return refs_read_ref_full(get_main_ref_store(the_repository), refnam=
e,
    ++				  resolve_flags, oid, flags);
    ++}
    ++
    ++static int read_ref(const char *refname, struct object_id *oid)
    ++{
    ++	return refs_read_ref(get_main_ref_store(the_repository), refname, oi=
d);
    ++}
    ++
    ++static int ref_exists(const char *refname)
    ++{
    ++	return refs_ref_exists(get_main_ref_store(the_repository), refname);
    ++}
    ++
    ++static int for_each_tag_ref(each_ref_fn fn, void *cb_data)
    ++{
    ++	return refs_for_each_tag_ref(get_main_ref_store(the_repository), fn,=
 cb_data);
    ++}
    ++
    ++static int for_each_branch_ref(each_ref_fn fn, void *cb_data)
    ++{
    ++	return refs_for_each_branch_ref(get_main_ref_store(the_repository), =
fn, cb_data);
    ++}
    ++
    ++static int for_each_remote_ref(each_ref_fn fn, void *cb_data)
    ++{
    ++	return refs_for_each_remote_ref(get_main_ref_store(the_repository), =
fn, cb_data);
    ++}
    ++
    ++static int head_ref_namespaced(each_ref_fn fn, void *cb_data)
    ++{
    ++	return refs_head_ref_namespaced(get_main_ref_store(the_repository),
    ++					fn, cb_data);
    ++}
    ++
    ++static int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
    ++				const char *prefix, void *cb_data)
    ++{
    ++	return refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
    ++					 fn, pattern, prefix, cb_data);
    ++}
    ++
    ++static int for_each_glob_ref(each_ref_fn fn, const char *pattern, voi=
d *cb_data)
    ++{
    ++	return refs_for_each_glob_ref(get_main_ref_store(the_repository),
    ++				      fn, pattern, cb_data);
    ++}
    ++
    ++static int delete_ref(const char *msg, const char *refname,
    ++		      const struct object_id *old_oid, unsigned int flags)
    ++{
    ++	return refs_delete_ref(get_main_ref_store(the_repository), msg, refn=
ame,
    ++			       old_oid, flags);
    ++}
    ++
    ++static struct ref_transaction *ref_transaction_begin(struct strbuf *e=
rr)
    ++{
    ++	return ref_store_transaction_begin(get_main_ref_store(the_repository=
), err);
    ++}
    ++
    ++static int update_ref(const char *msg, const char *refname,
    ++		      const struct object_id *new_oid,
    ++		      const struct object_id *old_oid,
    ++		      unsigned int flags, enum action_on_err onerr)
    ++{
    ++	return refs_update_ref(get_main_ref_store(the_repository), msg, refn=
ame, new_oid,
    ++			       old_oid, flags, onerr);
    ++}
    ++
    ++static char *shorten_unambiguous_ref(const char *refname, int strict)
    ++{
    ++	return refs_shorten_unambiguous_ref(get_main_ref_store(the_repositor=
y),
    ++					    refname, strict);
    ++}
    ++
    ++static int head_ref(each_ref_fn fn, void *cb_data)
    ++{
    ++	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data=
);
    ++}
    ++
    ++static int for_each_ref(each_ref_fn fn, void *cb_data)
    ++{
    ++	return refs_for_each_ref(get_main_ref_store(the_repository), fn, cb_=
data);
    ++}
    ++
    ++static int for_each_ref_in(const char *prefix, each_ref_fn fn, void *=
cb_data)
    ++{
    ++	return refs_for_each_ref_in(get_main_ref_store(the_repository), pref=
ix, fn, cb_data);
    ++}
    ++
    ++static int for_each_fullref_in(const char *prefix,
    ++			       const char **exclude_patterns,
    ++			       each_ref_fn fn, void *cb_data)
    ++{
    ++	return refs_for_each_fullref_in(get_main_ref_store(the_repository),
    ++					prefix, exclude_patterns, fn, cb_data);
    ++}
    ++
    ++static int for_each_namespaced_ref(const char **exclude_patterns,
    ++				   each_ref_fn fn, void *cb_data)
    ++{
    ++	return refs_for_each_namespaced_ref(get_main_ref_store(the_repositor=
y),
    ++					    exclude_patterns, fn, cb_data);
    ++}
    ++
    ++static int for_each_rawref(each_ref_fn fn, void *cb_data)
    ++{
    ++	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, =
cb_data);
    ++}
    ++
    ++static const char *resolve_ref_unsafe(const char *refname, int resolv=
e_flags,
    ++				      struct object_id *oid, int *flags)
    ++{
    ++	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), r=
efname,
    ++				       resolve_flags, oid, flags);
    ++}
    ++
    ++static int create_symref(const char *ref_target, const char *refs_hea=
ds_master,
    ++			 const char *logmsg)
    ++{
    ++	return refs_create_symref(get_main_ref_store(the_repository), ref_ta=
rget,
    ++				  refs_heads_master, logmsg);
    ++}
    ++
    ++static int for_each_reflog(each_reflog_fn fn, void *cb_data)
    ++{
    ++	return refs_for_each_reflog(get_main_ref_store(the_repository), fn, =
cb_data);
    ++}
    ++
    ++static int for_each_reflog_ent_reverse(const char *refname, each_refl=
og_ent_fn fn,
    ++				       void *cb_data)
    ++{
    ++	return refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repos=
itory),
    ++						refname, fn, cb_data);
    ++}
    ++
    ++static int for_each_reflog_ent(const char *refname, each_reflog_ent_f=
n fn,
    ++			       void *cb_data)
    ++{
    ++	return refs_for_each_reflog_ent(get_main_ref_store(the_repository), =
refname,
    ++					fn, cb_data);
    ++}
    ++
    ++static int reflog_exists(const char *refname)
    ++{
    ++	return refs_reflog_exists(get_main_ref_store(the_repository), refnam=
e);
    ++}
    ++
    ++static int safe_create_reflog(const char *refname, struct strbuf *err)
    ++{
    ++	return refs_create_reflog(get_main_ref_store(the_repository), refnam=
e,
    ++				  err);
    ++}
    ++
    ++static int delete_reflog(const char *refname)
    ++{
    ++	return refs_delete_reflog(get_main_ref_store(the_repository), refnam=
e);
    ++}
    ++
    ++static int reflog_expire(const char *refname,
    ++			 unsigned int flags,
    ++			 reflog_expiry_prepare_fn prepare_fn,
    ++			 reflog_expiry_should_prune_fn should_prune_fn,
    ++			 reflog_expiry_cleanup_fn cleanup_fn,
    ++			 void *policy_cb_data)
    ++{
    ++	return refs_reflog_expire(get_main_ref_store(the_repository),
    ++				  refname, flags,
    ++				  prepare_fn, should_prune_fn,
    ++				  cleanup_fn, policy_cb_data);
    ++}
    ++
    ++static int delete_refs(const char *msg, struct string_list *refnames,
    ++		       unsigned int flags)
    ++{
    ++	return refs_delete_refs(get_main_ref_store(the_repository), msg, ref=
names, flags);
    ++}
    ++
    ++static int rename_ref(const char *oldref, const char *newref, const c=
har *logmsg)
    ++{
    ++	return refs_rename_ref(get_main_ref_store(the_repository), oldref, n=
ewref, logmsg);
    ++}
    ++
    ++static int copy_existing_ref(const char *oldref, const char *newref, =
const char *logmsg)
    ++{
    ++	return refs_copy_existing_ref(get_main_ref_store(the_repository), ol=
dref, newref, logmsg);
    ++}
    ++#endif
    ++
    + #endif /* REFS_H */
--=20
2.45.0


--EVxA+z//lq4yBTdB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY51CUACgkQVbJhu7ck
PpR12A//Z8+HBo6sETlQfxqiR4T1wzIgvmEFhfxbWQ/uk2mba4GwnXL+dkHT1S4s
MnxCUD8k2NbTzlYgUZblYPiz9VqYoWyoun11mt7lQ+lIF5v8Z9RxHDP9/0BB7NHb
8EzCvOVG/kKvoX+6sxJ5R5TJWKhGHL9ECinnIl09wOF+j1/Enr9kCeoz/X1qTEfa
W37KoxYCImW3NGzrCl03UC+aFUN/hADOtn6elrNJsAtUEDw+wYzzusryLTW2uvMb
JXOmb/jFX/b6nEd+lwHGjdg2wQ2kXXlZOOqTz+K24X1pAwGSKZUUayVOJpvQfE7M
XChLSQlveM+kkwo0H4BtZM19a/5fnHb47iDMHYn89eAeo3KcIvr/ciqDalaKpALq
hzk0rrmR+j0L36BDVVuwz53cqQXKTB13IYNz5ia8TPymJvQUL9YGUUxVh5y7GCVW
EapLJITrV8dfX/ZgqESGk+PGAw86leitVDU5PO2mkJ2iPyj24jNJGMfiBYrQC/7N
YL1R4VPIXZY/pv06g03sPP1nAWEk7DcoQphi+TY+NsH7urd1i0FAUHO44RBmFR9B
0x7g+JK+wPL+wbKOlmynnc9Rgw+A53prklenXwk+q94e5Tjpn/65qAYWG8yyuW9L
VF9zFS2Hc0/c0+lwZ5+eIu6XSpiTdeHljtIz4o2HqDzoxQvGaWI=
=Baef
-----END PGP SIGNATURE-----

--EVxA+z//lq4yBTdB--
