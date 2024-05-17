Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2BA28DDA
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933900; cv=none; b=Pn8QxA0Ec7FaJ+4OloQk+MdLzMXOcS7NtlMEeJ69xwxk9DzXCTQeCDlGg2XbyrVvqYpDPy4IdAchWf/bULK8B2O75wXI/pIBikGNTfiY2nTsqHojudwZCtZnKh2rid8ZW/ayQeKl6Knr/hc+EwBOL+/za4Zm5zmEonsrwHBpCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933900; c=relaxed/simple;
	bh=sNWxtzyUsok471ZHVEzX88kCi6sokID4INWUsW2F7BA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dKV724IEqcmRw1jaDjAC0LdaF6TsVtBpI2c1LhIi505PlcjprxK4Jfw+7jPRrNWunlkA8tqTok4mYG9yvYarxCW8qs/aW2WProQpahaSJDJAn6u5H+vmjeNwvkOYX7w8gFkvtZiS9uAsr3rBdAHSXF36wXtkbH0LnWm0TTRergM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vUjRUFrP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e++6G5fq; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vUjRUFrP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e++6G5fq"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 99EE31C000BD;
	Fri, 17 May 2024 04:18:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 17 May 2024 04:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1715933896; x=1716020296; bh=iCgFDDx0c3JUoFS/q/OyrwW+rVRnLGrH
	pqaXnw1majo=; b=vUjRUFrPF2r8bnZtzF6JnNkWJFk5a0VIH2TdlbRJlbKGV4Aa
	MwCwJ6EstUNGtnqoB4T1bT9uU+LLn+DwEDNQ7u4K2awiERa9wUCAabX+sVGFTk8P
	AQd/tbt8iwFgMgFhJVT/M87hM+77hn11cvXK+OCWUPF57jptcfLbC0NSceueYyfd
	ItKOqpeFxIoAqwp4ovyHK+iXFaIthThnURDBgNc26DdlWM/Zsjh9V7JNKAkOWwbe
	2Tqz8N0zjb+6ps3EHjCytvGhwxo1dGUIHEruxzjnl5EK857Uw2ASq/N6i/HpmOzd
	C78P5hdJmcvsSsgF1emrfbdgR6ZcD+ko8Aumhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715933896; x=1716020296; bh=iCgFDDx0c3JUoFS/q/OyrwW+rVRnLGrHpqa
	Xnw1majo=; b=e++6G5fqrfJOypMLg+fxDXt2/bQQlymqOH6rNLmhLpU+PKL2rO/
	v9wO9qH5XApF55/nLrXJBLsaHNNu8y7A62CzZBPKecu8Vnt+HH1nq1dc9Qxtz8xj
	H5HBNFq4WYqrJTjJ4cXSoX/bN+SRJk0QJoBG8Undz0Ayz7bgYEgZZjqi/GH1LNYX
	xJCUaeTMycdp9JtLL2CYdrkLDr/SQejwNGslrqfJFcEZkivXfYMYaNXmMk9PgP3g
	HzaQOaY0zSzoDmz1qj3wdFDvmNYtrqcwFxXmcZ5BacQ59WkSEmbSlWQxOR/38HNy
	MKd5AupK/4YJiHABKx1GoSQdtY6AV5p9hjg==
X-ME-Sender: <xms:yBJHZsIVvqJrRCXnJvUlcJJXOyVrkgaZdW0TgYj7g26ib-ThKkuAAw>
    <xme:yBJHZsKrSaVO1KiWwDYVBwWrw2oFcpbmbl1Lyimwn5zyokFoLwEqdqEaXBxgMxY31
    zr7Z4izGr9mtgPHSQ>
X-ME-Received: <xmr:yBJHZsvF5hpmlHzG_gtAoEM7rM-30zua9ItGLHgYxoDCatfvx5lGxbaM89FfLNoCjPWPVYaJyhGQ4WNwTKgTd_B8DgCvelgPkwaW3Tu54tXhwdHXMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuefguedtueeiheetleevgedujeekjeehleejjefhhffghfevgfekueekjedtieejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:yBJHZpYF_m_3Z35S1G5qb195JTaurRgAYitRqXpX6kJO0MEJwRht9A>
    <xmx:yBJHZjbpuF6sEN1rA2Xu4B-KxZQ097R2s2OhvPwlMaFjPt4_RpdEaw>
    <xmx:yBJHZlBs8MhEeujXbX7oEuKqTs2KLCVnNIbJlo6jHvqT4tkCeUPP9Q>
    <xmx:yBJHZpaPCzxUsgMA91biyYD5fgxmBw1fSu4RpmARYzFYB9AET7waoA>
    <xmx:yBJHZvELfHeyJurN_Tx0W8rgJy7mxCaJAhN5Dhv1mnzIAdVmQZGVw-0Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:18:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4c3fcfc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:17:45 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/16] refs: drop all references to `the_repository`
Message-ID: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bBjy3pMjMl0twS+8"
Content-Disposition: inline


--bBjy3pMjMl0twS+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that removes all
references to `the_repository` and `the_hash_algo` in the refs
interfaces.

Changes compared to v1:

  - Fix duplicate word in commit message.

  - Rename `ref_store_create()` to `ref_store_create_on_disk()`.

  - Add a trace when calling `debug_release()`.

  - Add a note in patch 5 that the newly added reference to
    `the_repository` in `resolved_gitlink_ref()` gets fixed in the
    following patch.

  - Fix unsetting the worktree stack in `reftable_be_release()`.

Thanks!

Patrick

Patrick Steinhardt (16):
  refs: adjust names for `init` and `init_db` callbacks
  refs: rename `init_db` callback to avoid confusion
  refs: implement releasing ref storages
  refs: track ref stores via strmap
  refs: pass repo when retrieving submodule ref store
  refs: refactor `resolve_gitlink_ref()` to accept a repository
  refs: retrieve worktree ref stores via associated repository
  refs: convert iteration over replace refs to accept ref store
  refs: pass ref store when detecting dangling symrefs
  refs: move object peeling into "object.c"
  refs: pass repo when peeling objects
  refs: drop `git_default_branch_name()`
  refs: remove `dwim_log()`
  refs/files: use correct repository
  refs/files: remove references to `the_hash_algo`
  refs/packed: remove references to `the_hash_algo`

 attr.c                      |   3 +-
 builtin/clone.c             |   5 +-
 builtin/describe.c          |   2 +-
 builtin/fetch.c             |   3 +-
 builtin/gc.c                |   2 +-
 builtin/pack-objects.c      |   6 +-
 builtin/reflog.c            |   2 +-
 builtin/remote.c            |   3 +-
 builtin/repack.c            |   2 +-
 builtin/replace.c           |  13 +-
 builtin/show-ref.c          |   2 +-
 builtin/submodule--helper.c |  14 +-
 builtin/update-index.c      |   5 +-
 builtin/var.c               |   2 +-
 builtin/worktree.c          |   2 +-
 combine-diff.c              |   3 +-
 commit-graph.c              |   2 +-
 diff-lib.c                  |   3 +-
 dir.c                       |   3 +-
 ls-refs.c                   |   2 +-
 midx-write.c                |   2 +-
 object-file.c               |   2 +-
 object.c                    |  23 ++++
 object.h                    |  35 +++++
 read-cache.c                |   5 +-
 ref-filter.c                |   2 +-
 reflog-walk.c               |   4 +-
 reflog.c                    |   2 +-
 refs.c                      | 266 ++++++++++--------------------------
 refs.h                      |  51 +++----
 refs/debug.c                |  16 ++-
 refs/files-backend.c        |  59 ++++----
 refs/iterator.c             |   6 +-
 refs/packed-backend.c       |  67 +++++----
 refs/packed-backend.h       |   6 +-
 refs/ref-cache.c            |   5 +-
 refs/refs-internal.h        |  54 ++------
 refs/reftable-backend.c     |  39 +++++-
 remote.c                    |  12 +-
 replace-object.c            |  10 +-
 repository.c                |  12 ++
 repository.h                |  14 ++
 setup.c                     |   7 +-
 submodule.c                 |   3 +-
 t/helper/test-reach.c       |   2 +-
 t/helper/test-ref-store.c   |   2 +-
 tag.c                       |   4 +-
 tag.h                       |   2 +-
 unpack-trees.c              |   3 +-
 upload-pack.c               |   2 +-
 worktree.c                  |   2 +
 worktree.h                  |   2 +
 52 files changed, 408 insertions(+), 392 deletions(-)

Range-diff against v1:
 1:  360d034746 !  1:  4225a6928a refs: adjust names for `init` and `init_d=
b` callbacks
    @@ Metadata
      ## Commit message ##
         refs: adjust names for `init` and `init_db` callbacks
    =20
    -    The names of the functions that implement the the `init` and `init=
_db`
    +    The names of the functions that implement the `init` and `init_db`
         callbacks in the "files" and "packed" backends do not match the na=
mes of
         the callbacks, which is inconsistent. Rename them so that they mat=
ch,
         which makes it easier to discover their respective implementations.
 2:  3cc2b4e550 !  2:  050fb24e58 refs: rename `init_db` callback to avoid =
confusion
    @@ Commit message
         refs: rename `init_db` callback to avoid confusion
    =20
         Reference backends have two callbacks `init` and `init_db`. The
    -    similarity of these two callbacks has repeatedly tripped myself wh=
enever
    -    I was looking at those, where I always had to look up which of the=
m does
    +    similarity of these two callbacks has repeatedly confused me whene=
ver I
    +    was looking at them, where I always had to look up which of them d=
oes
         what.
    =20
    -    Rename the `init_db` callback to `create`, which should hopefully =
be
    -    clearer.
    +    Rename the `init_db` callback to `create_on_disk`, which should
    +    hopefully be clearer.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
      	wt_refs =3D get_worktree_ref_store(wt);
     =20
     -	ret =3D refs_init_db(wt_refs, REFS_INIT_DB_IS_WORKTREE, &sb);
    -+	ret =3D ref_store_create(wt_refs, REF_STORE_CREATE_IS_WORKTREE, &sb);
    ++	ret =3D ref_store_create_on_disk(wt_refs, REF_STORE_CREATE_ON_DISK_I=
S_WORKTREE, &sb);
      	if (ret)
      		goto done;
     =20
    @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     =20
      /* backend functions */
     -int refs_init_db(struct ref_store *refs, int flags, struct strbuf *er=
r)
    -+int ref_store_create(struct ref_store *refs, int flags, struct strbuf=
 *err)
    ++int ref_store_create_on_disk(struct ref_store *refs, int flags, struc=
t strbuf *err)
      {
     -	return refs->be->init_db(refs, flags, err);
    -+	return refs->be->create(refs, flags, err);
    ++	return refs->be->create_on_disk(refs, flags, err);
      }
     =20
      int resolve_gitlink_ref(const char *submodule, const char *refname,
    @@ refs.h: int should_autocreate_reflog(const char *refname);
      int is_branch(const char *refname);
     =20
     -#define REFS_INIT_DB_IS_WORKTREE (1 << 0)
    -+#define REF_STORE_CREATE_IS_WORKTREE (1 << 0)
    ++#define REF_STORE_CREATE_ON_DISK_IS_WORKTREE (1 << 0)
     =20
     -int refs_init_db(struct ref_store *refs, int flags, struct strbuf *er=
r);
    -+int ref_store_create(struct ref_store *refs, int flags, struct strbuf=
 *err);
    ++int ref_store_create_on_disk(struct ref_store *refs, int flags, struc=
t strbuf *err);
     =20
      /*
       * Return the peeled value of the oid currently being iterated via
    @@ refs/debug.c: struct ref_store *maybe_debug_wrap_ref_store(const cha=
r *gitdir, s
      }
     =20
     -static int debug_init_db(struct ref_store *refs, int flags, struct st=
rbuf *err)
    -+static int debug_create(struct ref_store *refs, int flags, struct str=
buf *err)
    ++static int debug_create_on_disk(struct ref_store *refs, int flags, st=
ruct strbuf *err)
      {
      	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
     -	int res =3D drefs->refs->be->init_db(drefs->refs, flags, err);
     -	trace_printf_key(&trace_refs, "init_db: %d\n", res);
    -+	int res =3D drefs->refs->be->create(drefs->refs, flags, err);
    -+	trace_printf_key(&trace_refs, "create: %d\n", res);
    ++	int res =3D drefs->refs->be->create_on_disk(drefs->refs, flags, err);
    ++	trace_printf_key(&trace_refs, "create_on_disk: %d\n", res);
      	return res;
      }
     =20
    @@ refs/debug.c: static int debug_reflog_expire(struct ref_store *ref_s=
tore, const
      	.name =3D "debug",
      	.init =3D NULL,
     -	.init_db =3D debug_init_db,
    -+	.create =3D debug_create,
    ++	.create_on_disk =3D debug_create_on_disk,
     =20
      	/*
      	 * None of these should be NULL. If the "files" backend (in
    @@ refs/files-backend.c: static int files_reflog_expire(struct ref_stor=
e *ref_store
     -static int files_init_db(struct ref_store *ref_store,
     -			 int flags,
     -			 struct strbuf *err UNUSED)
    -+static int files_ref_store_create(struct ref_store *ref_store,
    -+				  int flags,
    -+				  struct strbuf *err UNUSED)
    ++static int files_ref_store_create_on_disk(struct ref_store *ref_store,
    ++					  int flags,
    ++					  struct strbuf *err UNUSED)
      {
      	struct files_ref_store *refs =3D
     -		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
    @@ refs/files-backend.c: static int files_init_db(struct ref_store *ref=
_store,
      	 * a worktree ref store.
      	 */
     -	if (!(flags & REFS_INIT_DB_IS_WORKTREE)) {
    -+	if (!(flags & REF_STORE_CREATE_IS_WORKTREE)) {
    ++	if (!(flags & REF_STORE_CREATE_ON_DISK_IS_WORKTREE)) {
      		/*
      		 * Create .git/refs/{heads,tags}
      		 */
    @@ refs/files-backend.c: static int files_init_db(struct ref_store *ref=
_store,
      	.name =3D "files",
      	.init =3D files_ref_store_init,
     -	.init_db =3D files_init_db,
    -+	.create =3D files_ref_store_create,
    ++	.create_on_disk =3D files_ref_store_create_on_disk,
      	.transaction_prepare =3D files_transaction_prepare,
      	.transaction_finish =3D files_transaction_finish,
      	.transaction_abort =3D files_transaction_abort,
    @@ refs/packed-backend.c: int packed_refs_is_locked(struct ref_store *r=
ef_store)
     -static int packed_ref_store_init_db(struct ref_store *ref_store UNUSE=
D,
     -				    int flags UNUSED,
     -				    struct strbuf *err UNUSED)
    -+static int packed_ref_store_create(struct ref_store *ref_store UNUSED,
    -+				   int flags UNUSED,
    -+				   struct strbuf *err UNUSED)
    ++static int packed_ref_store_create_on_disk(struct ref_store *ref_stor=
e UNUSED,
    ++					   int flags UNUSED,
    ++					   struct strbuf *err UNUSED)
      {
      	/* Nothing to do. */
      	return 0;
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_ite=
rator_begin(
      	.name =3D "packed",
      	.init =3D packed_ref_store_init,
     -	.init_db =3D packed_ref_store_init_db,
    -+	.create =3D packed_ref_store_create,
    ++	.create_on_disk =3D packed_ref_store_create_on_disk,
      	.transaction_prepare =3D packed_transaction_prepare,
      	.transaction_finish =3D packed_transaction_finish,
      	.transaction_abort =3D packed_transaction_abort,
    @@ refs/refs-internal.h: typedef struct ref_store *ref_store_init_fn(st=
ruct reposit
     -typedef int ref_init_db_fn(struct ref_store *refs,
     -			   int flags,
     -			   struct strbuf *err);
    -+typedef int ref_store_create_fn(struct ref_store *refs,
    -+				int flags,
    -+				struct strbuf *err);
    ++typedef int ref_store_create_on_disk_fn(struct ref_store *refs,
    ++					int flags,
    ++					struct strbuf *err);
     =20
      typedef int ref_transaction_prepare_fn(struct ref_store *refs,
      				       struct ref_transaction *transaction,
    @@ refs/refs-internal.h: typedef int read_symbolic_ref_fn(struct ref_st=
ore *ref_sto
      	const char *name;
      	ref_store_init_fn *init;
     -	ref_init_db_fn *init_db;
    -+	ref_store_create_fn *create;
    ++	ref_store_create_on_disk_fn *create_on_disk;
     =20
      	ref_transaction_prepare_fn *transaction_prepare;
      	ref_transaction_finish_fn *transaction_finish;
    @@ refs/reftable-backend.c: static struct ref_store *reftable_be_init(s=
truct reposi
     -static int reftable_be_init_db(struct ref_store *ref_store,
     -			       int flags UNUSED,
     -			       struct strbuf *err UNUSED)
    -+static int reftable_be_create(struct ref_store *ref_store,
    -+			      int flags UNUSED,
    -+			      struct strbuf *err UNUSED)
    ++static int reftable_be_create_on_disk(struct ref_store *ref_store,
    ++				      int flags UNUSED,
    ++				      struct strbuf *err UNUSED)
      {
      	struct reftable_ref_store *refs =3D
     -		reftable_be_downcast(ref_store, REF_STORE_WRITE, "init_db");
    @@ refs/reftable-backend.c: static int reftable_be_reflog_expire(struct=
 ref_store *
      	.name =3D "reftable",
      	.init =3D reftable_be_init,
     -	.init_db =3D reftable_be_init_db,
    -+	.create =3D reftable_be_create,
    ++	.create_on_disk =3D reftable_be_create_on_disk,
      	.transaction_prepare =3D reftable_be_transaction_prepare,
      	.transaction_finish =3D reftable_be_transaction_finish,
      	.transaction_abort =3D reftable_be_transaction_abort,
    @@ setup.c: void create_reference_database(unsigned int ref_storage_for=
mat,
     =20
      	repo_set_ref_storage_format(the_repository, ref_storage_format);
     -	if (refs_init_db(get_main_ref_store(the_repository), 0, &err))
    -+	if (ref_store_create(get_main_ref_store(the_repository), 0, &err))
    ++	if (ref_store_create_on_disk(get_main_ref_store(the_repository), 0, =
&err))
      		die("failed to set up refs db: %s", err.buf);
     =20
      	/*
 3:  282fbe35a7 !  3:  4beecb0944 refs: implement releasing ref storages
    @@ refs.c: static struct ref_store *ref_store_init(struct repository *r=
epo,
      ## refs.h ##
     @@ refs.h: int is_branch(const char *refname);
     =20
    - int ref_store_create(struct ref_store *refs, int flags, struct strbuf=
 *err);
    + int ref_store_create_on_disk(struct ref_store *refs, int flags, struc=
t strbuf *err);
     =20
     +/*
     + * Release all memory and resources associated with the ref store.
    @@ refs/debug.c: struct ref_store *maybe_debug_wrap_ref_store(const cha=
r *gitdir, s
     +{
     +	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
     +	drefs->refs->be->release(drefs->refs);
    ++	trace_printf_key(&trace_refs, "release\n");
     +}
     +
    - static int debug_create(struct ref_store *refs, int flags, struct str=
buf *err)
    + static int debug_create_on_disk(struct ref_store *refs, int flags, st=
ruct strbuf *err)
      {
      	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
     @@ refs/debug.c: static int debug_reflog_expire(struct ref_store *ref_=
store, const char *refname,
    @@ refs/debug.c: static int debug_reflog_expire(struct ref_store *ref_s=
tore, const
      	.name =3D "debug",
      	.init =3D NULL,
     +	.release =3D debug_release,
    - 	.create =3D debug_create,
    + 	.create_on_disk =3D debug_create_on_disk,
     =20
      	/*
    =20
    @@ refs/files-backend.c: static struct files_ref_store *files_downcast(=
struct ref_s
      static void files_reflog_path(struct files_ref_store *refs,
      			      struct strbuf *sb,
      			      const char *refname)
    -@@ refs/files-backend.c: static int files_ref_store_create(struct ref_=
store *ref_store,
    +@@ refs/files-backend.c: static int files_ref_store_create_on_disk(str=
uct ref_store *ref_store,
      struct ref_storage_be refs_be_files =3D {
      	.name =3D "files",
      	.init =3D files_ref_store_init,
     +	.release =3D files_ref_store_release,
    - 	.create =3D files_ref_store_create,
    + 	.create_on_disk =3D files_ref_store_create_on_disk,
    ++
      	.transaction_prepare =3D files_transaction_prepare,
      	.transaction_finish =3D files_transaction_finish,
    + 	.transaction_abort =3D files_transaction_abort,
    =20
      ## refs/packed-backend.c ##
     @@ refs/packed-backend.c: static void clear_snapshot(struct packed_ref=
_store *refs)
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_ite=
rator_begin(
      	.name =3D "packed",
      	.init =3D packed_ref_store_init,
     +	.release =3D packed_ref_store_release,
    - 	.create =3D packed_ref_store_create,
    + 	.create_on_disk =3D packed_ref_store_create_on_disk,
    ++
      	.transaction_prepare =3D packed_transaction_prepare,
      	.transaction_finish =3D packed_transaction_finish,
    + 	.transaction_abort =3D packed_transaction_abort,
    =20
      ## refs/refs-internal.h ##
    -@@ refs/refs-internal.h: typedef struct ref_store *ref_store_init_fn(s=
truct repository *repo,
    +@@ refs/refs-internal.h: struct ref_store;
    + typedef struct ref_store *ref_store_init_fn(struct repository *repo,
      					    const char *gitdir,
      					    unsigned int flags);
    -=20
     +/*
     + * Release all memory and resources associated with the ref store.
     + */
     +typedef void ref_store_release_fn(struct ref_store *refs);
    -+
    - typedef int ref_store_create_fn(struct ref_store *refs,
    - 				int flags,
    - 				struct strbuf *err);
    +=20
    + typedef int ref_store_create_on_disk_fn(struct ref_store *refs,
    + 					int flags,
     @@ refs/refs-internal.h: typedef int read_symbolic_ref_fn(struct ref_s=
tore *ref_store, const char *refnam
      struct ref_storage_be {
      	const char *name;
      	ref_store_init_fn *init;
     +	ref_store_release_fn *release;
    - 	ref_store_create_fn *create;
    + 	ref_store_create_on_disk_fn *create_on_disk;
     =20
      	ref_transaction_prepare_fn *transaction_prepare;
    =20
    @@ refs/reftable-backend.c: static struct ref_store *reftable_be_init(s=
truct reposi
     +
     +	if (refs->worktree_stack) {
     +		reftable_stack_destroy(refs->worktree_stack);
    -+		refs->main_stack =3D NULL;
    ++		refs->worktree_stack =3D NULL;
     +	}
     +
     +	strmap_for_each_entry(&refs->worktree_stacks, &iter, entry)
    @@ refs/reftable-backend.c: static struct ref_store *reftable_be_init(s=
truct reposi
     +	strmap_clear(&refs->worktree_stacks, 0);
     +}
     +
    - static int reftable_be_create(struct ref_store *ref_store,
    - 			      int flags UNUSED,
    - 			      struct strbuf *err UNUSED)
    + static int reftable_be_create_on_disk(struct ref_store *ref_store,
    + 				      int flags UNUSED,
    + 				      struct strbuf *err UNUSED)
     @@ refs/reftable-backend.c: static int reftable_be_reflog_expire(struc=
t ref_store *ref_store,
      struct ref_storage_be refs_be_reftable =3D {
      	.name =3D "reftable",
      	.init =3D reftable_be_init,
     +	.release =3D reftable_be_release,
    - 	.create =3D reftable_be_create,
    + 	.create_on_disk =3D reftable_be_create_on_disk,
    ++
      	.transaction_prepare =3D reftable_be_transaction_prepare,
      	.transaction_finish =3D reftable_be_transaction_finish,
    + 	.transaction_abort =3D reftable_be_transaction_abort,
 4:  52798936a2 =3D  4:  9ca54a12e8 refs: track ref stores via strmap
 5:  1d48289809 !  5:  d7f8b2f40d refs: pass repo when retrieving submodule=
 ref store
    @@ Commit message
         move the global map into `struct repository`. Like this it becomes
         possible to look up submodule ref stores for arbitrary repositorie=
s.
    =20
    +    Note that this also adds a new reference to `the_repository` in
    +    `resolve_gitlink_ref()`, which is part of the refs interfaces. Thi=
s will
    +    get adjusted in the next patch.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/submodule--helper.c ##
 6:  7b4ea1ffd2 !  6:  a8593b16a6 refs: refactor `resolve_gitlink_ref()` to=
 accept a repository
    @@ read-cache.c: int add_to_index(struct index_state *istate, const cha=
r *path, str
      			namelen--;
    =20
      ## refs.c ##
    -@@ refs.c: int ref_store_create(struct ref_store *refs, int flags, str=
uct strbuf *err)
    - 	return refs->be->create(refs, flags, err);
    +@@ refs.c: int ref_store_create_on_disk(struct ref_store *refs, int fl=
ags, struct strbuf *e
    + 	return refs->be->create_on_disk(refs, flags, err);
      }
     =20
     -int resolve_gitlink_ref(const char *submodule, const char *refname,
 7:  4d55dbbceb =3D  7:  977f3a8510 refs: retrieve worktree ref stores via =
associated repository
 8:  160e64e42a =3D  8:  5306122d58 refs: convert iteration over replace re=
fs to accept ref store
 9:  50c5d72c6a =3D  9:  423d7b3fb6 refs: pass ref store when detecting dan=
gling symrefs
10:  f03626ac00 =3D 10:  3c6f814158 refs: move object peeling into "object.=
c"
11:  eb60ce5771 =3D 11:  272cd49357 refs: pass repo when peeling objects
12:  09ca848e7d =3D 12:  e02e76701f refs: drop `git_default_branch_name()`
13:  da10714a45 =3D 13:  afa9184884 refs: remove `dwim_log()`
14:  7ce6b7454d =3D 14:  c1a2dc4e69 refs/files: use correct repository
15:  ab0c793739 =3D 15:  20c2bb4cbb refs/files: remove references to `the_h=
ash_algo`
16:  9cd554166f =3D 16:  5ebe81d8c3 refs/packed: remove references to `the_=
hash_algo`
--=20
2.45.1.190.g19fe900cfc.dirty


--bBjy3pMjMl0twS+8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEsEACgkQVbJhu7ck
PpRxDxAAihwE+gMqA74VPGUlrVL5wCPX4ICH+JCJ9oWgIT4CVreu6KNv6u+S4fLM
W31wgkjaioUozCWsd2QC2MXj3gaNRvxXMf8Yb3ThsveulJFU6m8daF0ZA99wWkeQ
7b7FTeSCNqGAv/R8Mtr+AM3MVzbvcs7DQ3l7Cm19/2ffXO4PYoJ6xi4Gko7ymBhH
Fqkg7/vMUkdLG9aHtoquFS8zRF9WgR/wiZQ68fF+iwnqUJwkWNFrYs3DmCNEVMNs
Jf933kAWIbUERaW0LxfLpaDMnvTaAUZ1XeIEpqDRdk+5l/1vhmMHYhF0ZxSc2SqR
xJFijSsyVtXhooC76IITpE78mxSKnMRI+xCdq37ow2V/fIWLH3PML93QhcEjW2aP
cfFzJuO440hK12KGs2nTGgQ7hKB5EAyg0K9hTtGeidd4YPVrQt/iB1ABdS6yNrcU
27NgqH0RwGbVl1OzEx0tssmElQuDqySx1aemJajXjiasZ8Gzcq0JVCB6Lg8mnJ19
ic6rzD0axXJOKkI8ckC78Bv0icvf6oi+L8veUWKF2bWH56EzcP0w79xhhbbWcrEr
DkQM/8ABIK2yrs6ZbrGB8coO3xGdO1aSQuGLYfgsgBAwPDtEk8woAA25wppH8n2R
4zilEhp3B/PiG/O89Ow2hpGH5jHONzeltMPTPYlG4vG6pwIWTYU=
=Od/H
-----END PGP SIGNATURE-----

--bBjy3pMjMl0twS+8--
