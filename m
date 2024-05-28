Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916254276
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877880; cv=none; b=QhwhjivdHX9w1PV40Bs7m8zfu+9meXQjyJMwBjfyCJHvPB+y+gAWIzU7sVaYqJGllihSIXPYhMQniV9p9uQMz2zP+wuyp8gfvc6zs1k89NSxxl2xND4VwgR0jRPR5EtpbersCdB4Fzv3kAXada0tb8MsdSPA50+ilDYboPSBIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877880; c=relaxed/simple;
	bh=GPdKSDkdw2FKhj0TJk+Rb6nZ+JwRUIiT32LuQ0XV3zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrVMlbWsGcyTKq3ZUhNPhxSsPaG93T79r5x2lgGKfx1m9l4I0qaXtTqOrXkxxJd+SCduIe/c+u9mjly7eMxabEZfR+IpQdqv10OQSyFnvAB7gC3GmzWxT0JyH4OJy3AuNmcmzFj+bx+UrdlcUV9OwK1zbbBWuaDitWPIbSEhI2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jNpIVZEb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AuzOonc2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jNpIVZEb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AuzOonc2"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id C6C1B13800F5;
	Tue, 28 May 2024 02:31:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 May 2024 02:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877876; x=1716964276; bh=scrZZTYbNf
	ygLKREKg80C7GXz7nED4hqJkGH7B4CTgc=; b=jNpIVZEbxKzv5pFlHf10qSiOfl
	pmImt91qOUor8aucK2JfErapsX9+DqhE5EUim0pcg0K9Jaba+ch5QU6C3eAtRD3r
	WKRNyjJu90wN2gKQI5xjEsK1s8uNAiztLtF2FdM0wn2vcsuGagqqz7D5Iudxd1y0
	u1c9zm5t7uw+o4dG+yeBHbbX8hy4gSTR4HMTXsEO59jjF80IA5LsAeWgr/Af/YMa
	J4BvNoNz9+nylavzPADqtbFVlgO5M5SXDQxhVqM951tcQKO8FCTkpmIaWlpgIgNf
	AG3AuLU2olfpAShdODoaGmQ5epUKKRGIHfbliJD+puwzRP7IkGsbnYHSIuPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877876; x=1716964276; bh=scrZZTYbNfygLKREKg80C7GXz7nE
	D4hqJkGH7B4CTgc=; b=AuzOonc2HXZbZEK0UXqzeeCN6bkugL4mrpzCJkiAOxmj
	Pu1gs1WLGsMS5l1wr0KNx1ryayi8jffqtd3L7PzEipCEzNSgla5btdzswwkhC/cj
	AJgYVzkkoaGhLwY/q8ePRPPCF7W1Xw/Myvxrm7zftKFR84L7PBfbGcAlkVi26SFh
	z4d0MlUqwiAsiO9Mzi/ks0VJuT9aVe5XT2Q3ykf44fALnRtDXdjDnnSPTkEy2GIy
	7ML4+MygN3MzHYE4lz4vLbyu53TejfenufH+Hf7w/STM6hOX7m/X621QrooFq/Fs
	rcxIv47Vr6g5qRn4X4l/K4VLP2+rd5OlxeTf+lNYxg==
X-ME-Sender: <xms:NHpVZrQPLXV50bdFpJ5-nd5D8aBZmWrCNP-jCBL_TUxCTZMoqrMPCw>
    <xme:NHpVZsyDMTofJvFS8xynyTpap0iYcOQBNz1mKuoZZuQcJv_W2ONH9bz66LQ7ztej-
    rq-a_k9baWlQv8KsA>
X-ME-Received: <xmr:NHpVZg2-7qJquvj1Um4WgzaKG5DOe_DzKnjV9nMttf_rv0BrtMOrNpgQNfZj7z5OSMhGR9ZGIMmJDCJLHK750zjpS6uQzCazb7Sab4oz01LiKqSm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:NHpVZrAFRp2lEJBfZkMT5978ut26LWsB7MEuBqphX_ekz5lRRAy4_Q>
    <xmx:NHpVZkhQcPpn7n9dNau55_rR9AL2uWQIYiiWsTph9sy5NlFh6VhU5g>
    <xmx:NHpVZvp6OX1zPCy1bQx5joXSUUcWPxDvwarH2ffAofjAmE8KroxqjQ>
    <xmx:NHpVZviJC5ODAfzZ8wI4cKDwkZyljc6pS2yPTvPPAeVduFnlKvybBQ>
    <xmx:NHpVZuaHHbfrTWzISyeCkt3OvxP65DFcDJTHE3sxg6g-4gJBwaVrkukt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:31:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6b4ee31b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:00 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 00/12] refs: ref storage format migrations
Message-ID: <cover.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="baQPq7Sy3y5TpaZd"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--baQPq7Sy3y5TpaZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that implements ref storage
format migrations.

Changes compared to v2:

  - Perform sanity checks for worktrees and reflogs before we create the
    temporary refdb directory.

  - Swapped out calls to `remove_path()` to `unlink()`. We do not want
    to walk up and remove empty parent directories, even though this is
    harmless in practice.

  - Release the reftable refdb before removing it. This closes the
    cached "tables.list" file descriptor, which would otherwise break
    removal of this file on Windows.

  - Fix a bug with worktrees where we store the current worktree refdb
    twice. This caused us to keep file descriptors open, which breaks
    removal of the refdb on Windows.

  - Simplify freeing reftable's merged tables. This isn't really needed
    by this series, but I stumbled over this while investigating why
    things break on Windows.

  - Improve error messages to add `strerror(errno)`, which helped me in
    debugging those errors.

  - Print path to the migrated refs if things fail after we have
    populated them such that users can recover.

  - Fix segfault when releasing a partially initialized "files" ref
    store.

  - Some smallish improvements littered across the patches.

Thanks!

Patrick

Patrick Steinhardt (12):
  setup: unset ref storage when reinitializing repository version
  refs: convert ref storage format to an enum
  refs: pass storage format to `ref_store_init()` explicitly
  refs: allow to skip creation of reflog entries
  refs/files: refactor `add_pseudoref_and_head_entries()`
  refs/files: extract function to iterate through root refs
  refs/files: fix NULL pointer deref when releasing ref store
  reftable: inline `merged_table_release()`
  worktree: don't store main worktree twice
  refs: implement removal of ref storages
  refs: implement logic to migrate between ref storage formats
  builtin/refs: new command to migrate ref storage formats

 .gitignore                 |   1 +
 Documentation/git-refs.txt |  62 +++++++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/clone.c            |   2 +-
 builtin/init-db.c          |   2 +-
 builtin/refs.c             |  75 ++++++++
 git.c                      |   1 +
 refs.c                     | 340 +++++++++++++++++++++++++++++++++++--
 refs.h                     |  41 ++++-
 refs/files-backend.c       | 123 ++++++++++++--
 refs/packed-backend.c      |  15 ++
 refs/ref-cache.c           |   2 +
 refs/refs-internal.h       |   7 +
 refs/reftable-backend.c    |  55 +++++-
 reftable/merged.c          |  12 +-
 reftable/merged.h          |   2 -
 reftable/stack.c           |   8 +-
 repository.c               |   3 +-
 repository.h               |  10 +-
 setup.c                    |  10 +-
 setup.h                    |   9 +-
 t/helper/test-ref-store.c  |   1 +
 t/t1460-refs-migrate.sh    | 243 ++++++++++++++++++++++++++
 worktree.c                 |  29 ++--
 25 files changed, 974 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/git-refs.txt
 create mode 100644 builtin/refs.c
 create mode 100755 t/t1460-refs-migrate.sh

Range-diff against v2:
 1:  8b11127daf !  1:  afb705f6a0 setup: unset ref storage when reinitializ=
ing repository version
    @@ Commit message
         storages though, so this is about to become an issue there.
    =20
         Prepare for this and unset the ref storage format when reinitializ=
ing a
    -    repoistory with the "files" format.
    +    repository with the "files" format.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
 2:  25f740f395 =3D  2:  7989e82dcd refs: convert ref storage format to an =
enum
 3:  6e7b9764f6 =3D  3:  7d1a86292c refs: pass storage format to `ref_store=
_init()` explicitly
 4:  03f4ac6ee7 =3D  4:  d0539b7456 refs: allow to skip creation of reflog =
entries
 5:  71f31fe66c =3D  5:  7f9ce5af2e refs/files: refactor `add_pseudoref_and=
_head_entries()`
 6:  6b696690ca =3D  6:  f7577a0ab3 refs/files: extract function to iterate=
 through root refs
 -:  ---------- >  7:  56baa798fb refs/files: fix NULL pointer deref when r=
eleasing ref store
 -:  ---------- >  8:  c7e8ab40b5 reftable: inline `merged_table_release()`
 -:  ---------- >  9:  7a89aae515 worktree: don't store main worktree twice
 7:  b758c419c6 ! 10:  f9d9420cf9 refs: implement removal of ref storages
    @@ refs/files-backend.c: static int files_ref_store_create_on_disk(stru=
ct ref_store
     +
     +	strbuf_addf(&buf, "%s/%s", data->gitdir, refname);
     +
    -+	ret =3D remove_path(buf.buf);
    ++	ret =3D unlink(buf.buf);
     +	if (ret < 0)
     +		strbuf_addf(data->err, "could not delete %s: %s\n",
     +			    refname, strerror(errno));
    @@ refs/files-backend.c: static int files_ref_store_create_on_disk(stru=
ct ref_store
     +
     +	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
     +	if (remove_dir_recursively(&sb, 0) < 0) {
    -+		strbuf_addstr(err, "could not delete refs");
    ++		strbuf_addf(err, "could not delete refs: %s",
    ++			    strerror(errno));
     +		ret =3D -1;
     +	}
     +	strbuf_reset(&sb);
     +
     +	strbuf_addf(&sb, "%s/logs", refs->base.gitdir);
     +	if (remove_dir_recursively(&sb, 0) < 0) {
    -+		strbuf_addstr(err, "could not delete logs\n");
    ++		strbuf_addf(err, "could not delete logs: %s",
    ++			    strerror(errno));
     +		ret =3D -1;
     +	}
     +	strbuf_reset(&sb);
    @@ refs/reftable-backend.c: static int reftable_be_create_on_disk(struc=
t ref_store
     +	struct strbuf sb =3D STRBUF_INIT;
     +	int ret =3D 0;
     +
    ++	/*
    ++	 * Release the ref store such that all stacks are closed. This is
    ++	 * required so that the "tables.list" file is not open anymore, which
    ++	 * would otherwise make it impossible to remove the file on Windows.
    ++	 */
    ++	reftable_be_release(ref_store);
    ++
     +	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
     +	if (remove_dir_recursively(&sb, 0) < 0) {
    -+		strbuf_addstr(err, "could not delete reftables");
    ++		strbuf_addf(err, "could not delete reftables: %s",
    ++			    strerror(errno));
     +		ret =3D -1;
     +	}
     +	strbuf_reset(&sb);
     +
     +	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
    -+	if (remove_path(sb.buf) < 0) {
    -+		strbuf_addstr(err, "could not delete stub HEAD");
    ++	if (unlink(sb.buf) < 0) {
    ++		strbuf_addf(err, "could not delete stub HEAD: %s",
    ++			    strerror(errno));
     +		ret =3D -1;
     +	}
     +	strbuf_reset(&sb);
     +
     +	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
    -+	if (remove_path(sb.buf) < 0) {
    -+		strbuf_addstr(err, "could not delete stub heads");
    ++	if (unlink(sb.buf) < 0) {
    ++		strbuf_addf(err, "could not delete stub heads: %s",
    ++			    strerror(errno));
    ++		ret =3D -1;
    ++	}
    ++	strbuf_reset(&sb);
    ++
    ++	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
    ++	if (rmdir(sb.buf) < 0) {
    ++		strbuf_addf(err, "could not delete stub heads: %s",
    ++			    strerror(errno));
     +		ret =3D -1;
     +	}
     +
 8:  4d3eb5ea89 ! 11:  1f26051eff refs: implement logic to migrate between =
ref storage formats
    @@ Commit message
             many reflog entries.
    =20
           - We do not lock the repository for concurrent access, and thus
    -        concurrent writes may make use end up with weird in-between st=
ates.
    -        There is no way to fully lock the "files" backend for writes d=
ue to
    -        its format, and thus we punt on this topic altogether and defe=
r to
    -        the user to avoid those from happening.
    +        concurrent writes may end up with weird in-between states. The=
re is
    +        no way to fully lock the "files" backend for writes due to its
    +        format, and thus we punt on this topic altogether and defer to=
 the
    +        user to avoid those from happening.
    =20
         In other words, this version is a minimum viable product for migra=
ting a
         repository's ref storage format. It works alright for bare repos, =
which
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +
     +struct migration_data {
     +	struct ref_store *old_refs;
    -+	struct ref_store *new_refs;
     +	struct ref_transaction *transaction;
     +	struct strbuf *errbuf;
    -+	const char *refname;
     +};
     +
     +static int migrate_one_ref(const char *refname, const struct object_i=
d *oid,
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +
     +	from_dir =3D opendir(from_path);
     +	if (!from_dir) {
    -+		strbuf_addf(errbuf, "could not open source directory: '%s'", from_p=
ath);
    ++		strbuf_addf(errbuf, "could not open source directory '%s': %s",
    ++			    from_path, strerror(errno));
     +		ret =3D -1;
     +		goto done;
     +	}
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +done:
     +	strbuf_release(&from_buf);
     +	strbuf_release(&to_buf);
    -+	closedir(from_dir);
    ++	if (from_dir)
    ++		closedir(from_dir);
     +	return ret;
     +}
     +
    -+static int count_reflogs(const char *reflog, void *payload)
    ++static int count_reflogs(const char *reflog UNUSED, void *payload)
     +{
     +	size_t *reflog_count =3D payload;
     +	(*reflog_count)++;
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +	struct strbuf buf =3D STRBUF_INIT;
     +	struct migration_data data;
     +	size_t reflog_count =3D 0;
    -+	char *new_gitdir;
    ++	char *new_gitdir =3D NULL;
    ++	int did_migrate_refs =3D 0;
     +	int ret;
     +
     +	old_refs =3D get_main_ref_store(repo);
     +
     +	/*
    ++	 * We do not have any interfaces that would allow us to write many
    ++	 * reflog entries. Once we have them we can remove this restriction.
    ++	 */
    ++	if (refs_for_each_reflog(old_refs, count_reflogs, &reflog_count) < 0=
) {
    ++		strbuf_addstr(errbuf, "cannot count reflogs");
    ++		ret =3D -1;
    ++		goto done;
    ++	}
    ++	if (reflog_count) {
    ++		strbuf_addstr(errbuf, "migrating reflogs is not supported yet");
    ++		ret =3D -1;
    ++		goto done;
    ++	}
    ++
    ++	/*
    ++	 * Worktrees complicate the migration because every worktree has a
    ++	 * separate ref storage. While it should be feasible to implement, t=
his
    ++	 * is pushed out to a future iteration.
    ++	 *
    ++	 * TODO: we should really be passing the caller-provided repository =
to
    ++	 * `has_worktrees()`, but our worktree subsystem doesn't yet support
    ++	 * that.
    ++	 */
    ++	if (has_worktrees()) {
    ++		strbuf_addstr(errbuf, "migrating repositories with worktrees is not=
 supported yet");
    ++		ret =3D -1;
    ++		goto done;
    ++	}
    ++
    ++	/*
     +	 * The overall logic looks like this:
     +	 *
     +	 *   1. Set up a new temporary directory and initialize it with the =
new
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +	 *   6. Change the repository format to the new ref format.
     +	 */
     +	strbuf_addf(&buf, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
    -+	new_gitdir =3D mkdtemp(buf.buf);
    ++	new_gitdir =3D mkdtemp(xstrdup(buf.buf));
     +	if (!new_gitdir) {
     +		strbuf_addf(errbuf, "cannot create migration directory: %s",
     +			    strerror(errno));
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +		goto done;
     +	}
     +
    -+	if (refs_for_each_reflog(old_refs, count_reflogs, &reflog_count) < 0=
) {
    -+		strbuf_addstr(errbuf, "cannot count reflogs");
    -+		ret =3D -1;
    -+		goto done;
    -+	}
    -+	if (reflog_count) {
    -+		strbuf_addstr(errbuf, "migrating reflogs is not supported yet");
    -+		ret =3D -1;
    -+		goto done;
    -+	}
    -+
    -+	/*
    -+	 * TODO: we should really be passing the caller-provided repository =
to
    -+	 * `has_worktrees()`, but our worktree subsystem doesn't yet support
    -+	 * that.
    -+	 */
    -+	if (has_worktrees()) {
    -+		strbuf_addstr(errbuf, "migrating repositories with worktrees is not=
 supported yet");
    -+		ret =3D -1;
    -+		goto done;
    -+	}
    -+
     +	new_refs =3D ref_store_init(repo, format, new_gitdir,
     +				  REF_STORE_ALL_CAPS);
     +	ret =3D ref_store_create_on_disk(new_refs, 0, errbuf);
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +		goto done;
     +
     +	data.old_refs =3D old_refs;
    -+	data.new_refs =3D new_refs;
     +	data.transaction =3D transaction;
     +	data.errbuf =3D errbuf;
     +
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +	ret =3D ref_transaction_commit(transaction, errbuf);
     +	if (ret < 0)
     +		goto done;
    ++	did_migrate_refs =3D 1;
     +
     +	if (flags & REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN) {
     +		printf(_("Finished dry-run migration of refs, "
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +	ret =3D move_files(new_gitdir, old_refs->gitdir, errbuf);
     +	if (ret < 0)
     +		goto done;
    -+	rmdir(new_gitdir);
    ++
    ++	if (rmdir(new_gitdir) < 0)
    ++		warning_errno(_("could not remove temporary migration directory '%s=
'"),
    ++			      new_gitdir);
     +
     +	/*
     +	 * We have migrated the repository, so we now need to adjust the
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct=
 ref_update
     +	 */
     +	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), for=
mat, 1);
     +
    ++	free(new_refs->gitdir);
    ++	new_refs->gitdir =3D xstrdup(old_refs->gitdir);
     +	repo->refs_private =3D new_refs;
     +	ref_store_release(old_refs);
     +
     +	ret =3D 0;
     +
     +done:
    ++	if (ret && did_migrate_refs) {
    ++		strbuf_complete(errbuf, '\n');
    ++		strbuf_addf(errbuf, _("migrated refs can be found at '%s'"),
    ++			    new_gitdir);
    ++	}
    ++
     +	if (ret && new_refs)
     +		ref_store_release(new_refs);
     +	ref_transaction_free(transaction);
     +	strbuf_release(&buf);
    ++	free(new_gitdir);
     +	return ret;
     +}
    =20
 9:  0df17a51b4 ! 12:  d832414d1f builtin/refs: new command to migrate ref =
storage formats
    @@ Documentation/git-refs.txt (new)
     +	Perform the migration, but do not modify the repository. The migrated
     +	refs will be written into a separate directory that can be inspected
     +	separately. The name of the directory will be reported on stdout. Th=
is
    -+	can be used to double check that the migration works as expected doi=
ng
    ++	can be used to double check that the migration works as expected bef=
ore
     +	performing the actual migration.
     +
     +KNOWN LIMITATIONS
    @@ builtin/refs.c (new)
     +{
     +	const char * const migrate_usage[] =3D {
     +		REFS_MIGRATE_USAGE,
    -+		NULL
    ++		NULL,
     +	};
     +	const char *format_str =3D NULL;
     +	enum ref_storage_format format;
--=20
2.45.1.246.gb9cfe4845c.dirty


--baQPq7Sy3y5TpaZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVei0ACgkQVbJhu7ck
PpQHMg/9F5Ud8roEcmtKn5Pb9/tfurhpK50a6INZlpTb/MJx2NuX2rIhQsQf+ldi
V6fXkFY+5NvitbZW0d4a1J2ItOxN+mSf0iCHfSTLt0MJFDwfM0koGu37JU0jW7cG
FRSkdkpKWniLkUKsCA+p8qgqFAqogycDqIbpGfk+yu8mh+raKirMiv8OIkE7d/80
CuMGbikpBvDvET9UG79Yoc1RLnJugAOZjURfUqtN23fBlvQAO5xxLBtAzt+tJPjq
IfNdN9tY1y4ZFk8RxU3Kt3ds1yPyyPCiv0KpDAcLVl70cM36QAt2iwFrVy4yvFzu
9uj48aAMD2vfPTgxsq8uxWc8IJWNQhcZxt/xa+t4Pj6BjROOeBj4j4O3FLGaad1Z
5zyZuSxCO474OKIk27NLKSVmhXyyeKKjtAxcCiWEEx8NqNMvN8tLsfF4Z1mb3BlM
zrcWP0Iep8k4DZDASYxAHcATR1F50NLLIaKtLPFWXZ0knbdDKYShcOYXvKON0zwO
EqpHm/Yx0VAkQ6O55fu6rnuPUJharzjJtlUBeQhfHqvu9S+LLDCFv0jsnKX9Fgiw
hfWn5s3vDK+ibk3ROBof/0yYMIlmwaSQu+2/CphaOL6swl4ewORV6eczGaVl+1Zu
GZsOrphXMDj4ss618SPHsZY9dFwX91Dpt4VsIsTLWPyXwh12HZI=
=9+RE
-----END PGP SIGNATURE-----

--baQPq7Sy3y5TpaZd--
