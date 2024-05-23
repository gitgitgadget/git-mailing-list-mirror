Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1539F51016
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452755; cv=none; b=TFpXfrrM3lMD8JDW+kTdijVMqq+8a3qoSMFvww3HX+KcW6RPkdhi2Qsyvcbmz0Dl175HmpHgWdPzIuWkpvhC0E+CPR015dRtWkw+yFIv+hEk7sDZAdHFM7PfPXTj8xBeyWLSfNJz2o5peK501qUWlPVb/RKK9tjk+igTzGVdnmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452755; c=relaxed/simple;
	bh=xzwWi9SxHd59hik97biEOTDb1L5NNZr4Qc1/N/qZOgQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI1ccQRS0EyOGbqT1RuyVVx0DkrfMEimlxVUVmsVEJCganKnUJt+nwF0KFT0ox1MjnZLa6DN6cxsFlAbdCU8zyNHbH1/bPavERaj5z+v+F/dhpsGfFgvG8jrJCT5ADQJ8ptc9AY2/K1IxcOKbtws2/j3eSxolvTNUiwj/nv3ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J4uvaNMU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3ynRAA9; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J4uvaNMU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3ynRAA9"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 86E9A1C001C5
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:25:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 May 2024 04:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716452753; x=1716539153; bh=KG+bOf6kWy
	rnZ2f8H4NvAlubPSzt7AIDWcUOUQsmODk=; b=J4uvaNMUBH6n8t6gTsE1KvEepV
	yfQClCn0UGp0Jw6K1bEfZmpFiod03pXwKiVFChxixNmEL3vcl1zKFIEloRfnafxq
	YaLvfccQwZLzoQa4wvmHgXgTGZ9OnSMV4oOry0OpRnYORCLGcEXWHkkEGMIvbYMU
	o5XxatYrWp+sdG41iBxh7kjVowh8y/tibvu1gmKZJhZ4lDo3CuVMYYidnuT78DZU
	T1iEq9qaMy7AviOEuWBbGkLzQBe5TyNJI8V4ousBM3/9G+i1qwhzofvqNthp9R/Z
	GSsiZquPmysJ13zvypPWuKvmarOOHQR8VBXe3/vzFYb2yeMNEkvAnR2Xu11A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716452753; x=1716539153; bh=KG+bOf6kWyrnZ2f8H4NvAlubPSzt
	7AIDWcUOUQsmODk=; b=c3ynRAA9deW+znBI7ZmF8z5MpEZEDpQgZxAOCJkLszBd
	Sdcm7pzTrq0AnwqI8aAQgdV/okUHIvRd6xZ4wDZ8e1BmNfDhYVI8eWgpZuJe545f
	mELDUImMfPJ6cs5mb+4vrWmSvgkYbIKbj0h0sBlK+U3PCgbt4TceyvEKidiBJaqk
	tGVe4uLwW2VZMBW/HiVSsJgYmYH6LLE/BwUe9KfLRlWOJfHwg6OVTjKrPpC7rxQ/
	nOWZru7pPwyPKojZiv6mZUS74yOy6YgAv0jVRoIU1qAYkwRzwAzkJ5BS1HFZQi4G
	1FX2o65DBNJISVqqkOXdVYNTD7op23qIGK2fKx0uaA==
X-ME-Sender: <xms:kP1OZjDsqB-e7IVyJv143BzTa_St5HVkpTnxxfL-IPBmU2Rj8T_GcA>
    <xme:kP1OZpjMVeOmsvLWbNbvXauSqoKlmdliNWYz3YROBl7OQPZbbWf-QH5w6nDQ9NTAR
    ApSWAH2T72wiTvBDA>
X-ME-Received: <xmr:kP1OZukE2USXBb3doInIciLeMAT7N_pcpaQVtEiDTJxoKl2msOnsTuMq3Y1BScx1FTJB_s2g7xbkFkMZ3SXvNnRZIItwq75VucSLHI0kxr2uP7eSFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:kf1OZlzZfySy4GVwt-SqjED41eNbjnqd9pAyeywbkBjSp4NVUcaBRg>
    <xmx:kf1OZoT4y8xFqEh1J13SyvPvaE2ZfElgEyh2d__vk5mZ_aBgrt71YQ>
    <xmx:kf1OZoYEtob94JfDlqjHB4ch4wh_ArXD5Lej1dzYPURggh3SywmNyg>
    <xmx:kf1OZpTitbVf0Y4e6qaqm9e8SB5IpOyk6TzStzrMHtbyqerrh3vohg>
    <xmx:kf1OZjI0HsbPlx4paGnYzKGIutQTNB6QEmxYt9gK75U1ypy158vGUoqz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 04:25:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c25947ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 08:25:46 +0000 (UTC)
Date: Thu, 23 May 2024 10:25:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 8/9] refs: implement logic to migrate between ref storage
 formats
Message-ID: <4e0edda6d3ef48509206d849ceb1f347e51251d9.1716451672.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xisy7MMsdpZDmJTK"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--Xisy7MMsdpZDmJTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With the introduction of the new "reftable" backend, users may want to
migrate repositories between the backends without having to recreate the
whole repository. Add the logic to do so.

The implementation is generic and works with arbitrary ref storage
formats because we only use. It does have a few limitations though:

  - We do not migrate repositories with worktrees, because worktrees
    have separate ref storages. It makes the overall affair more complex
    if we have to migrate multiple storages at once.

  - We do not migrate reflogs, because we have no interfaces to write
    many reflog entries.

  - We do not lock the repository for concurrent access, and thus
    concurrent writes may make use end up with weird in-between states.
    There is no way to fully lock the "files" backend for writes due to
    its format, and thus we punt on this topic altogether and defer to
    the user to avoid those from happening.

In other words, this version is a minimum viable product for migrating a
repository's ref storage format. It works alright for bare repos, which
typically have neither worktrees nor reflogs. But it will not work for
many other repositories without some preparations. These limitations are
not set into stone though, and ideally we will eventually address them
over time.

The logic is not yet used by anything, and thus there are no tests for
it. Those will be added in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 284 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h |  18 ++++
 2 files changed, 302 insertions(+)

diff --git a/refs.c b/refs.c
index 9b112b0527..4ef2dae5e1 100644
--- a/refs.c
+++ b/refs.c
@@ -2570,3 +2570,287 @@ int ref_update_check_old_target(const char *referen=
t, struct ref_update *update,
 			    referent, update->old_target);
 	return -1;
 }
+
+struct migration_data {
+	struct ref_store *old_refs;
+	struct ref_store *new_refs;
+	struct ref_transaction *transaction;
+	struct strbuf *errbuf;
+	const char *refname;
+};
+
+static int migrate_one_ref(const char *refname, const struct object_id *oi=
d,
+			   int flags, void *cb_data)
+{
+	struct migration_data *data =3D cb_data;
+	struct strbuf symref_target =3D STRBUF_INIT;
+	int ret;
+
+	if (flags & REF_ISSYMREF) {
+		ret =3D refs_read_symbolic_ref(data->old_refs, refname, &symref_target);
+		if (ret < 0)
+			goto done;
+
+		ret =3D ref_transaction_update(data->transaction, refname, NULL, null_oi=
d(),
+					     symref_target.buf, NULL,
+					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
+		if (ret < 0)
+			goto done;
+	} else {
+		ret =3D ref_transaction_create(data->transaction, refname, oid,
+					     REF_SKIP_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION,
+					     NULL, data->errbuf);
+		if (ret < 0)
+			goto done;
+	}
+
+done:
+	strbuf_release(&symref_target);
+	return ret;
+}
+
+static int move_files(const char *from_path, const char *to_path, struct s=
trbuf *errbuf)
+{
+	struct strbuf from_buf =3D STRBUF_INIT, to_buf =3D STRBUF_INIT;
+	size_t from_len, to_len;
+	DIR *from_dir;
+	int ret;
+
+	from_dir =3D opendir(from_path);
+	if (!from_dir) {
+		strbuf_addf(errbuf, "could not open source directory: '%s'", from_path);
+		ret =3D -1;
+		goto done;
+	}
+
+	strbuf_addstr(&from_buf, from_path);
+	strbuf_complete(&from_buf, '/');
+	from_len =3D from_buf.len;
+
+	strbuf_addstr(&to_buf, to_path);
+	strbuf_complete(&to_buf, '/');
+	to_len =3D to_buf.len;
+
+	while (1) {
+		struct dirent *ent;
+
+		errno =3D 0;
+		ent =3D readdir(from_dir);
+		if (!ent)
+			break;
+
+		if (!strcmp(ent->d_name, ".") ||
+		    !strcmp(ent->d_name, ".."))
+			continue;
+
+		strbuf_setlen(&from_buf, from_len);
+		strbuf_addstr(&from_buf, ent->d_name);
+
+		strbuf_setlen(&to_buf, to_len);
+		strbuf_addstr(&to_buf, ent->d_name);
+
+		ret =3D rename(from_buf.buf, to_buf.buf);
+		if (ret < 0) {
+			strbuf_addf(errbuf, "could not link file '%s' to '%s': %s",
+				    from_buf.buf, to_buf.buf, strerror(errno));
+			goto done;
+		}
+	}
+
+	if (errno) {
+		strbuf_addf(errbuf, "could not read entry from directory '%s': %s",
+			    from_path, strerror(errno));
+		ret =3D -1;
+		goto done;
+	}
+
+	ret =3D 0;
+
+done:
+	strbuf_release(&from_buf);
+	strbuf_release(&to_buf);
+	closedir(from_dir);
+	return ret;
+}
+
+static int count_reflogs(const char *reflog, void *payload)
+{
+	size_t *reflog_count =3D payload;
+	(*reflog_count)++;
+	return 0;
+}
+
+static int has_worktrees(void)
+{
+	struct worktree **worktrees =3D get_worktrees();
+	int ret =3D 0;
+	size_t i;
+
+	for (i =3D 0; worktrees[i]; i++) {
+		if (is_main_worktree(worktrees[i]))
+			continue;
+		ret =3D 1;
+	}
+
+	free_worktrees(worktrees);
+	return ret;
+}
+
+int repo_migrate_ref_storage_format(struct repository *repo,
+				    enum ref_storage_format format,
+				    unsigned int flags,
+				    struct strbuf *errbuf)
+{
+	struct ref_store *old_refs =3D NULL, *new_refs =3D NULL;
+	struct ref_transaction *transaction =3D NULL;
+	struct strbuf buf =3D STRBUF_INIT;
+	struct migration_data data;
+	size_t reflog_count =3D 0;
+	char *new_gitdir;
+	int ret;
+
+	old_refs =3D get_main_ref_store(repo);
+
+	/*
+	 * The overall logic looks like this:
+	 *
+	 *   1. Set up a new temporary directory and initialize it with the new
+	 *      format. This is where all refs will be migrated into.
+	 *
+	 *   2. Enumerate all refs and write them into the new ref storage.
+	 *      This operation is safe as we do not yet modify the main
+	 *      repository.
+	 *
+	 *   3. If we're in dry-run mode then we are done and can hand over the
+	 *      directory to the caller for inspection. If not, we now start
+	 *      with the destructive part.
+	 *
+	 *   4. Delete the old ref storage from disk. As we have a copy of refs
+	 *      in the new ref storage it's okay(ish) if we now get interrupted
+	 *      as there is an equivalent copy of all refs available.
+	 *
+	 *   5. Move the new ref storage files into place.
+	 *
+	 *   6. Change the repository format to the new ref format.
+	 */
+	strbuf_addf(&buf, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
+	new_gitdir =3D mkdtemp(buf.buf);
+	if (!new_gitdir) {
+		strbuf_addf(errbuf, "cannot create migration directory: %s",
+			    strerror(errno));
+		ret =3D -1;
+		goto done;
+	}
+
+	if (refs_for_each_reflog(old_refs, count_reflogs, &reflog_count) < 0) {
+		strbuf_addstr(errbuf, "cannot count reflogs");
+		ret =3D -1;
+		goto done;
+	}
+	if (reflog_count) {
+		strbuf_addstr(errbuf, "migrating reflogs is not supported yet");
+		ret =3D -1;
+		goto done;
+	}
+
+	/*
+	 * TODO: we should really be passing the caller-provided repository to
+	 * `has_worktrees()`, but our worktree subsystem doesn't yet support
+	 * that.
+	 */
+	if (has_worktrees()) {
+		strbuf_addstr(errbuf, "migrating repositories with worktrees is not supp=
orted yet");
+		ret =3D -1;
+		goto done;
+	}
+
+	new_refs =3D ref_store_init(repo, format, new_gitdir,
+				  REF_STORE_ALL_CAPS);
+	ret =3D ref_store_create_on_disk(new_refs, 0, errbuf);
+	if (ret < 0)
+		goto done;
+
+	transaction =3D ref_store_transaction_begin(new_refs, errbuf);
+	if (!transaction)
+		goto done;
+
+	data.old_refs =3D old_refs;
+	data.new_refs =3D new_refs;
+	data.transaction =3D transaction;
+	data.errbuf =3D errbuf;
+
+	/*
+	 * We need to use the internal `do_for_each_ref()` here so that we can
+	 * also include broken refs and symrefs. These would otherwise be
+	 * skipped silently.
+	 *
+	 * Ideally, we would do this call while locking the old ref storage
+	 * such that there cannot be any concurrent modifications. We do not
+	 * have the infra for that though, and the "files" backend does not
+	 * allow for a central lock due to its design. It's thus on the user to
+	 * ensure that there are no concurrent writes.
+	 */
+	ret =3D do_for_each_ref(old_refs, "", NULL, migrate_one_ref, 0,
+			      DO_FOR_EACH_INCLUDE_ROOT_REFS | DO_FOR_EACH_INCLUDE_BROKEN,
+			      &data);
+	if (ret < 0)
+		goto done;
+
+	/*
+	 * TODO: we might want to migrate to `initial_ref_transaction_commit()`
+	 * here, which is more efficient for the files backend because it would
+	 * write new refs into the packed-refs file directly. At this point,
+	 * the files backend doesn't handle pseudo-refs and symrefs correctly
+	 * though, so this requires some more work.
+	 */
+	ret =3D ref_transaction_commit(transaction, errbuf);
+	if (ret < 0)
+		goto done;
+
+	if (flags & REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN) {
+		printf(_("Finished dry-run migration of refs, "
+			 "the result can be found at '%s'\n"), new_gitdir);
+		ret =3D 0;
+		goto done;
+	}
+
+	/*
+	 * Until now we were in the non-destructive phase, where we only
+	 * populated the new ref store. From hereon though we are about
+	 * to get hands by deleting the old ref store and then moving
+	 * the new one into place.
+	 *
+	 * Assuming that there were no concurrent writes, the new ref
+	 * store should have all information. So if we fail from hereon
+	 * we may be in an in-between state, but it would still be able
+	 * to recover by manually moving remaining files from the
+	 * temporary migration directory into place.
+	 */
+	ret =3D ref_store_remove_on_disk(old_refs, errbuf);
+	if (ret < 0)
+		goto done;
+
+	ret =3D move_files(new_gitdir, old_refs->gitdir, errbuf);
+	if (ret < 0)
+		goto done;
+	rmdir(new_gitdir);
+
+	/*
+	 * We have migrated the repository, so we now need to adjust the
+	 * repository format so that clients will use the new ref store.
+	 * We also need to swap out the repository's main ref store.
+	 */
+	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), format, =
1);
+
+	repo->refs_private =3D new_refs;
+	ref_store_release(old_refs);
+
+	ret =3D 0;
+
+done:
+	if (ret && new_refs)
+		ref_store_release(new_refs);
+	ref_transaction_free(transaction);
+	strbuf_release(&buf);
+	return ret;
+}
diff --git a/refs.h b/refs.h
index 61ee7b7a15..76d25df4de 100644
--- a/refs.h
+++ b/refs.h
@@ -1070,6 +1070,24 @@ int is_root_ref(const char *refname);
  */
 int is_pseudo_ref(const char *refname);
=20
+/*
+ * The following flags can be passed to `repo_migrate_ref_storage_format()=
`:
+ *
+ *   - REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN: perform a dry-run migration
+ *     without touching the main repository. The result will be written in=
to a
+ *     temporary ref storage directory.
+ */
+#define REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN (1 << 0)
+
+/*
+ * Migrate the ref storage format used by the repository to the
+ * specified one.
+ */
+int repo_migrate_ref_storage_format(struct repository *repo,
+				    enum ref_storage_format format,
+				    unsigned int flags,
+				    struct strbuf *err);
+
 /*
  * The following functions have been removed in Git v2.45 in favor of func=
tions
  * that receive a `ref_store` as parameter. The intent of this section is
--=20
2.45.1.216.g4365c6fcf9.dirty


--Xisy7MMsdpZDmJTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO/Y0ACgkQVbJhu7ck
PpRKqhAAjjpZdO7BHV32jyawuR2eN2pv91f+Ir9bt6Lhvs3fBKlc+VhuTa3AX3Uu
fTcdaDdPQFmdTUB+TGqOdlrJ9TgXmDZd2lGNakBgqyy+88UWbQ45sTF7XxzPvPEm
3KaIFC1XDsAxztB0QTiZ6bYKmIThXjG2mUPHA1HwrAtcsLii1aNdcpE18RyU2xwA
9u4pJDvA1J9PbyJFp7fZgd+K+mbCoF00Rjl9CQR8hk4BKZjcSI5UabnAJsI1a2ZV
YM11dPk7ky+o3irtErqCx3d+o/FlSYO+dmo0oy8GKFbAKIc5UpntlDGdjfARRWeg
LeueFOBRXON6YvApPfq2MBc1whm8w44BFrz0hwr5tIKioSycowupLZVeSmEgSg5e
19EJGrL2tO81+nLKV4d06tj6tii1d2sYuLHwWh5Y7lNYWCmfGerCGwmZscYMFF5B
LV+nutg7kf4BMPAN33ns/49PholgKGAlwLvWA5YE9qnnuBl5df8KjzpFflNs91Ei
EWwaZX+UN+4FYBf7pBTrQK77exOcYjyEUNdbVvOEpiBqAyHodD6jtocwlGviOom0
bqAoTqSwLtIUiOJEhFPMt+Ref8nlpASH1HzuDiU3RuiH2tA1AJ2MdUvzYOv+L7x2
6Khgth8CFPSKCErlr5CxDlcQmpLHvayBoOn0NqV7FaeXNTvL0+U=
=zEMz
-----END PGP SIGNATURE-----

--Xisy7MMsdpZDmJTK--
