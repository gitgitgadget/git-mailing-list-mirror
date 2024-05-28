Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9B71739
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877929; cv=none; b=Z2XeIF7iy7nvCF1M39ud81u518K3qviGFU0U6lPy9QSnWhs+4fgnAozKZ/49lR3IFb1g0BnA2cL/GMci2NG8uY6/gqPbtxJuevnZ33n9bBdjt61pIYfEFg7CK6msGBDSzw1JogAXmHarhNlaSxyZBbMc22DHZzyUF3ZLLmnLDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877929; c=relaxed/simple;
	bh=TqcQEP5RW1UpAtHAjK1Fmf/i5HszT3fr7yfY49W+XwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmaOGKBLhWI6XRIzLy/xvPmzNmQv3nzddBXLtfP+gsF3/N9FNCcyb28ow/VgU966ffCVGRcPyzMBhkjPMrxxo4XVua2vI2Lxt92WOFUSljHiehoK4z1ge6Y8iij9anm30r1gjAmc2oDOXDnmCmagWMcTKPDF7c6oF1+RD17ASzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dIixkLrV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gn2pg/Qs; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dIixkLrV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gn2pg/Qs"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8D6A611400D8;
	Tue, 28 May 2024 02:32:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 May 2024 02:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877926; x=1716964326; bh=z6fQLnpixC
	IcEw9Wy+WbekPSgke18x8U3wMCT2oUyl8=; b=dIixkLrVbbJwDsWwkI76H6TLN6
	ZlqMQCDB0IyhU4lzd+R2YHldVzsWuXfmpxEymAHCF7lDRGw4peGjaKlkcXcIWP/k
	Z7/M7AUxCXbZGKOslpkMAjRmn5CoBv2216H20I8vkTucKna5SjOSngDEHF8Ntfo+
	SeXKvaZu6jbNoDK5ZW5PgQjs7GKlkSabSV1zZRTCTlVW1PQ7W9pk6ORu9EsjIXB4
	LPXjdwsY8cLJnCa0KzLnd2YcTtZWHrpRsEgcyYzHhfNZXOpq3HnsMIsV5AFDS9B0
	OPVaoeb7nN5fLBjYzg5d0PljoaQq3ty3uRgyh311bPriq7oh31QX88LRvdUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877926; x=1716964326; bh=z6fQLnpixCIcEw9Wy+WbekPSgke1
	8x8U3wMCT2oUyl8=; b=gn2pg/Qs/xTKbpcSlWYrR/zS9sdijSVBqlDuIWLD4L7I
	UvYw+Z451PY6AOStoF8DGO2DJZ1MCaq4krn2eHsB+NA3JoWm8t3goL4WrSqCY3ye
	2dYJ+0PeP/UdbBUAIOyGcLJ969WldRvfnaMRysQvurFICgORs5/ngGUuhWp7jOfY
	h+jzWmR2HEu9v3Mf/soVkI5QcYskpdZkMiP3fpAq6+e5eEBlamrnY4lmbTQrEVyw
	kBDoltOsublkno4eRatsS2ftjdueAPvXddVQOd+7Vfy+XYrFo3DJ2/LAoTV8VH7O
	0DgGHKhZW6T2YIveUMHHrKvqCpc47YOSxtmSYCK4Pg==
X-ME-Sender: <xms:ZnpVZgG3U-zFVuDtD2actYqsqmguNvPgFRnRInnJAUyKFsJ756x1PA>
    <xme:ZnpVZpXt8bCs_3WG70wIKYAo1gYtjK107gouk-6Il38gp7FgPnFtjwIDMGSndXTJx
    08xgDpex4Pywamh5g>
X-ME-Received: <xmr:ZnpVZqJeMuUI70S32hYj7IeRoj15lcJs_xouqcZqxOThBVb2Q5WhEv4-9BKtecUyI4ftQBVZkfgI4UoHwmE8eJD3hQJR4GXVegBLvfa3A5tN3UdZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ZnpVZiFDs9UVKgUYp2Mgn10LcCDbmKh7QwEBZ1gh7SWJW0_IMfZAPA>
    <xmx:ZnpVZmX_Usj9NOxgj8qb9T59jB0hndKrvyORi0iu9PL9qfZ8Oj9ORw>
    <xmx:ZnpVZlMYzmQvHqWfAk1raMizEXB6QULvT5XRiQRfTTqnwmJfDbbUDA>
    <xmx:ZnpVZt1-vO6AkzjrNSsU01ciuc-QJKJGCD_vkWfYgS_kgOEI0AanJw>
    <xmx:ZnpVZocaqm4twUFq3VqUwywEa57sL18KN5gDA4cE8yODo9JzFoLswK_j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:32:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3623a6c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:53 +0000 (UTC)
Date: Tue, 28 May 2024 08:32:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 11/12] refs: implement logic to migrate between ref
 storage formats
Message-ID: <1f26051eff8b7c18bb7114803454611272f84e19.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="okx4nk+0MPNjZKni"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--okx4nk+0MPNjZKni
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
 refs.c | 305 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h |  18 ++++
 2 files changed, 323 insertions(+)

diff --git a/refs.c b/refs.c
index 9b112b0527..f7c7765d23 100644
--- a/refs.c
+++ b/refs.c
@@ -2570,3 +2570,308 @@ int ref_update_check_old_target(const char *referen=
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
+	struct strbuf buf =3D STRBUF_INIT;
+	struct migration_data data;
+	size_t reflog_count =3D 0;
+	char *new_gitdir =3D NULL;
+	int did_migrate_refs =3D 0;
+	int ret;
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
+	strbuf_addf(&buf, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
+	new_gitdir =3D mkdtemp(xstrdup(buf.buf));
+	if (!new_gitdir) {
+		strbuf_addf(errbuf, "cannot create migration directory: %s",
+			    strerror(errno));
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
+
+	if (rmdir(new_gitdir) < 0)
+		warning_errno(_("could not remove temporary migration directory '%s'"),
+			      new_gitdir);
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
+			    new_gitdir);
+	}
+
+	if (ret && new_refs)
+		ref_store_release(new_refs);
+	ref_transaction_free(transaction);
+	strbuf_release(&buf);
+	free(new_gitdir);
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
2.45.1.246.gb9cfe4845c.dirty


--okx4nk+0MPNjZKni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVemEACgkQVbJhu7ck
PpSmmxAArfNuuyiQG2JugkMaMWCtoQbtbxMMLb53fWC0E6SuCzUuBa61+yFP02Qf
uXCj0s8eI00wRp/1gIsfTCBlioBoic60o5ABnS0ROk03b2v5xNkiAsM/M9JDI082
TpkcD633qtcQQZdEhHscKuOl40EzPlRrppyzgZNbB31xkqACZhm/DOxVX6ZfuTit
vOKww2tZ6M/h/oAe/o2ue5JFecBEriolZpLcCSzontSzuVx/5S7Tc4D/HPK6VIPI
fpn0tEJ6R9JwKJ0tz9ByD/gxV6H7ppS2vlOUSv92daMFbIzVHj1mpkABsXeuZ3ur
dLDdBllI/bsOhhYeRHN7FP4I+3rPnZnHNkuS2PoQWblBoZZUKN23F+cdalJrm1UR
yfUdoFDGJ/Iy7XxZCbBhns7oEeDLOJkKccAeayC5ccj9ZHPLmOwNuOll7woVMdb/
5TH5mQF6hXIHMB7YjI8MFKRmmyYf3LcHhgDNi49kteYhzit4It0eNK0hFClGK4un
Ni98g+/+2udi6tFNTaUpg2IrUA761Z4T+rNGcuiXe4Kt9Ulwoy8TqH62MFMSKheF
85QqfW83PJa9Y80/6WtIQdcRNO+KPw56cEOcXJ0qUBXDF//4Zey3jOPlSmQiVDZq
LE6rfbyNeKVmKw6QQtccrwG5PuqneBljgVkCKxdSVamH9WOz12s=
=n4Nn
-----END PGP SIGNATURE-----

--okx4nk+0MPNjZKni--
