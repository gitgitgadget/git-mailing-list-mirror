Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D738F9C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651792; cv=none; b=Vcdp0bmHe5bpfdb7bSohavwga3f0wg/udLoO7DUZoK54grVaffJkyOxhxYtF1GoC9ESy99CB7rZ56xU2ktbAS2c+WEkky4S/qSCIwFjgfKl3dP8nVb/Szz5+1jWkjddNqp0AU3TIEpKJGhgs5n0nLTYOO5l9oqJVCs4W9fOccHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651792; c=relaxed/simple;
	bh=1tr9XhwRvfMdT/ifnal/9H4ylbW1BX/8wNio8OszqXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4NRloCLmUo/FeBOM75EUOIi0je4Y7L3D7+VrabmaQGOD/cMEiup8eG6YC/FNbAJxU2enJ55SfgZDE2ud8nUifI68B6g5GKLjoFfVH8C2AIO51rbESjPnbhkPUG2DO+iw48b3GexxKcIm6dD6J9RNq+aNTmBPvpkUkNngIPAC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CKHb2+G3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLLrRO+K; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CKHb2+G3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLLrRO+K"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5B16E180019C;
	Thu,  6 Jun 2024 01:29:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 01:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651789; x=1717738189; bh=o2qBq0Y8NU
	8IavnD7S1O7juVcY8HOGyY7cdGbq5FODc=; b=CKHb2+G3M3JoH5aXy2cc7xwbKX
	QnMdN4/6trn/LjVdItOAm341lB6vpuxCHg7U02J41wzTkdjtNumsWfxtdiVExTR/
	xa/kY2SYJlxDKLs99jnLHTVdGImKbDeaUX93qMZoJmcTZ9il/lhyvg4B9JVMSa47
	/+dzM383eYYWSkzRjSnQemeXuBV4OtCk4jt1LSDTU9EXL6Y6/7ZUjT4AvFIm656t
	U0c+x5X1luB/FvShTSMRId3hZPxsErUQHtiIyTQrEAErRzWOlsY+NC54TBaXeLOh
	ydshptS7QWSiyGlsCKg2aHy1fX5IfMxefcIQPC01u2/QtxlNwD0I2gU0ep9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651789; x=1717738189; bh=o2qBq0Y8NU8IavnD7S1O7juVcY8H
	OGyY7cdGbq5FODc=; b=FLLrRO+KXuzqyDyIrvVx0EWlnjT3HxmdGWooQ3przo1S
	FGNKtdOhi+i8XrrIkmXfhw5tIS0KAXpl4fJ0kZAnhZ/S9hBNLnUw6FvIWVXkL/4l
	8r49+/t03nicVL9NDiIQyJT0Sh1kASANTM9ofJzfHvnNS2H5n9EeK+hEVGDDYMpL
	DvGFAOe22TQiNWn4tDIgbu9vtMfg+X3rvO3hYZ27zJe8idEPoGJJ/x/vWVBWWVpJ
	DXGfmBeM4O4s6f72bsCkLl2xZ8z6QD+50w8QFanixz6cEBcf8XD4oHIy+9hzJDhG
	IDNBKy9IKRUSHSUKTEQ3vrPARrsBrwnHl0/lWM76jw==
X-ME-Sender: <xms:TElhZirWBOpvEwH0pCPSl1V56grbdllLpdYoYFzEjqP_e-sXATp8_w>
    <xme:TElhZgoIJx-zt-JsQ9Em-F37YJI-2B4M9V-O0PkWVW6kvBDhmy0vrvPepR5GjwjmV
    LiR66W3FLDLHVc5pg>
X-ME-Received: <xmr:TElhZnPAb2GI3F_tsvdkn1d1n_Reilxy2yQ3Q4UJBhm_x6J29jvWMU9ROnTiyehhcO9hvsBfUUWaXCNysszqneN3saUPtpO_03-WJZPYJ56ckpnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:TElhZh6vY0xznY2-EeFTtEvyUg5uo7Iiy3d35RpX_tSsxe_5XNvVtg>
    <xmx:TElhZh5IssVd5rd1WjzdheXY9t3WkRvsz9VpbQ3NR3FaRxp-y43N5g>
    <xmx:TElhZhhFQlo30aaJZvljx0uQwy122TiV5AwPCV5pdB6NM1JQRbEzDQ>
    <xmx:TElhZr6MCO1G5b40dspox4w0-Kz1pAzuWhP9O_LO0SXzujUx_jMuVw>
    <xmx:TElhZsao6o2FtrN9ZZAZ9jmsJrlg6ci7qrhKfaNpLgPAjqm1hCDi_6u0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4f99c112 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:29:17 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 11/12] refs: implement logic to migrate between ref
 storage formats
Message-ID: <893d99e98ed820ad210540de190d706cc057b2ee.1717649803.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gPADlXq7HknV91I2"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--gPADlXq7HknV91I2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With the introduction of the new "reftable" backend, users may want to
migrate repositories between the backends without having to recreate the
whole repository. Add the logic to do so.

The implementation is generic and works with arbitrary ref storage
formats so that a backend does not need to implement any migration
logic. It does have a few limitations though:

  - We do not migrate repositories with worktrees, because worktrees
    have separate ref storages. It makes the overall affair more complex
    if we have to migrate multiple storages at once.

  - We do not migrate reflogs, because we have no interfaces to write
    many reflog entries.

  - We do not lock the repository for concurrent access, and thus
    concurrent writes may end up with weird in-between states. There is
    no way to fully lock the "files" backend for writes due to its
    format, and thus we punt on this topic altogether and defer to the
    user to avoid those from happening.

In other words, this version is a minimum viable product for migrating a
repository's ref storage format. It works alright for bare repos, which
often have neither worktrees nor reflogs. But it will not work for many
other repositories without some preparations. These limitations are not
set into stone though, and ideally we will eventually address them over
time.

The logic is not yet used by anything, and thus there are no tests for
it. Those will be added in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 308 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h |  18 ++++
 2 files changed, 326 insertions(+)

diff --git a/refs.c b/refs.c
index 31fd391214..1304d3dd87 100644
--- a/refs.c
+++ b/refs.c
@@ -2570,3 +2570,311 @@ int ref_update_check_old_target(const char *referen=
t, struct ref_update *update,
 			    referent, update->old_target);
 	return -1;
 }
+
+struct migration_data {
+	struct ref_store *old_refs;
+	struct ref_transaction *transaction;
+	struct strbuf *errbuf;
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
+		strbuf_addf(errbuf, "could not open source directory '%s': %s",
+			    from_path, strerror(errno));
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
+	if (from_dir)
+		closedir(from_dir);
+	return ret;
+}
+
+static int count_reflogs(const char *reflog UNUSED, void *payload)
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
+	struct strbuf new_gitdir =3D STRBUF_INIT;
+	struct migration_data data;
+	size_t reflog_count =3D 0;
+	int did_migrate_refs =3D 0;
+	int ret;
+
+	if (repo->ref_storage_format =3D=3D format) {
+		strbuf_addstr(errbuf, "current and new ref storage format are equal");
+		ret =3D -1;
+		goto done;
+	}
+
+	old_refs =3D get_main_ref_store(repo);
+
+	/*
+	 * We do not have any interfaces that would allow us to write many
+	 * reflog entries. Once we have them we can remove this restriction.
+	 */
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
+	 * Worktrees complicate the migration because every worktree has a
+	 * separate ref storage. While it should be feasible to implement, this
+	 * is pushed out to a future iteration.
+	 *
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
+	strbuf_addf(&new_gitdir, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX=
");
+	if (!mkdtemp(new_gitdir.buf)) {
+		strbuf_addf(errbuf, "cannot create migration directory: %s",
+			    strerror(errno));
+		ret =3D -1;
+		goto done;
+	}
+
+	new_refs =3D ref_store_init(repo, format, new_gitdir.buf,
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
+	did_migrate_refs =3D 1;
+
+	if (flags & REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN) {
+		printf(_("Finished dry-run migration of refs, "
+			 "the result can be found at '%s'\n"), new_gitdir.buf);
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
+	ret =3D move_files(new_gitdir.buf, old_refs->gitdir, errbuf);
+	if (ret < 0)
+		goto done;
+
+	if (rmdir(new_gitdir.buf) < 0)
+		warning_errno(_("could not remove temporary migration directory '%s'"),
+			      new_gitdir.buf);
+
+	/*
+	 * We have migrated the repository, so we now need to adjust the
+	 * repository format so that clients will use the new ref store.
+	 * We also need to swap out the repository's main ref store.
+	 */
+	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), format, =
1);
+
+	free(new_refs->gitdir);
+	new_refs->gitdir =3D xstrdup(old_refs->gitdir);
+	repo->refs_private =3D new_refs;
+	ref_store_release(old_refs);
+
+	ret =3D 0;
+
+done:
+	if (ret && did_migrate_refs) {
+		strbuf_complete(errbuf, '\n');
+		strbuf_addf(errbuf, _("migrated refs can be found at '%s'"),
+			    new_gitdir.buf);
+	}
+
+	if (ret && new_refs)
+		ref_store_release(new_refs);
+	ref_transaction_free(transaction);
+	strbuf_release(&new_gitdir);
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
2.45.2.409.g7b0defb391.dirty


--gPADlXq7HknV91I2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSUgACgkQVbJhu7ck
PpT1dA/+JAcjh2Wd7xl5jdTR26QuEcB2cBYACVqy4Vbsno4SRBx4GWEMLpmsBTpo
i2khl9ser1t6jSKCM+ilvvLtPqokurXSXxfioVS6MayHgSyxKZggrnvHos/1msX2
DvpzDsbNEo58Xy7j/hDPL5uxK0JW377WEQauPGf9sd3vh7cw6DJEufpSNSqYoLQE
hMomQLTGGME4WLPgqSUqEdBJm0e7hP22m1uKOBEUcReBQXy2vwe7Qr1wpesiUsLn
e0oHghm6cwOp708UW3NMUb5K9VFOm3bYcC54smyerit9QdyrQm9xJ4S/JUI7PF28
LKeGHaCIyG0RQ0XQmqveQNC10ccyw4qUdC8NJkIV59LqzFRD7GduTcpLzOYF065Z
Ep4LAWMYjmDcGTWyDrxyl+yE554dw+Y+zCslHbl0vPH3UtYyjLip4BNkPu+HN5pF
NjMn6fJypZjnMXRlLbdL3hInqe5YsoNZZ+19nXtSyAuYbharUs66rMS/UWbIBn6m
BO1ek85I2lYg0JTaybCHZXO4zCPum5d1Kf4YaMDI9mw6vpmLTKAHf1mbdFzeng89
KrQHYisFXpujH/6zlPkRgkodtxhNH+3Uk74f5+gAAKJJCrr6+bZEgKTVu4sKWbJ+
Tl3lulno6xZOdM1bEeekIFxVfozF7lKlVxE2FAyZOFGqjpWtF2g=
=aPNj
-----END PGP SIGNATURE-----

--gPADlXq7HknV91I2--
