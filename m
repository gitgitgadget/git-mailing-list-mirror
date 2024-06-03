Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D212BF39
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407067; cv=none; b=hIR/lB9KR+aVmyxrwa9xamz9KRZdIoFLOdZwKzPQ8Z3Yx4o69DK2npldXWZRaASwTCU+Yj+3Ey8napwztUF5flTzWgudjKTgDyEpT963gCHlGhAyaa9U6fGRluuDr0az7+Q+xPqjGEd36N4u9GMA97ItWc04KRm8h+khHOd5bLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407067; c=relaxed/simple;
	bh=YCXhvAymmm6s4dvJFpl6WgOk1584b+lUyBgLHhjt/80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq+/X/5VsUjUFKGVsZnStjk1nufd4/uxrmJLhdRRvETCCc8hJgwJbl6gJCGvFs53Xrvrzcmfa9f0SVAwjFRM14/zo714QmKXQGkzMtTJgmUjmQCuY1JO60xwlLhZaMwQZHfzUp2Fd1C80NxCGWwysIu1lWQPq2aREG5JXM6KW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cobZuTyg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KwAA8GLD; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cobZuTyg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KwAA8GLD"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 22B241800076;
	Mon,  3 Jun 2024 05:31:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407064; x=1717493464; bh=jiLXsxVSFx
	Ant4yWM9GFpaI88V2X3W15TxDViHITFq0=; b=cobZuTygT/I1sxOJYqI7IJ7+kT
	VPhT3yfUYc2AC2d458SssMdQszzHfhypKa7njz/t1IVqDNqY3RcyLNXzZSBTRTIc
	51M3yKFWvqtZX4ClfnNbrGiRtt2U27/8z/LaPYN1TicNJdGwWeYR44fGTBgmCvwO
	3hAdrd6hDqvhBismPB+w5RcjOFSJ3kqAAsDQKZxjS+fS1dLyWXCMCezLtQC1Femz
	uMkC/bEHGeXDjoAypF8pkAwLgoXKx0u+mtg61/FzdKmS0FNkj9mTR/FjiNMidB5d
	8w+GNPY8xyAxFPe1qk/82lBY4qCU7Pe2BsorIRYNEB4MtGM0EWy2DE8cQRcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407064; x=1717493464; bh=jiLXsxVSFxAnt4yWM9GFpaI88V2X
	3W15TxDViHITFq0=; b=KwAA8GLDGgIGefU7VZxrR9Hjzby2JWtZZw7xl1oOn0VW
	oMAkMMJvUFt6YcP5EAkbWlftg5jH5j0A9VnXFSpm3BH2h/FB3XBxHcDuWcGAZzbL
	spb9b0pSPmcFUAyk/UiuOoLuKNpq8KF3yzUT1nKS6714T8L9bYNJ5yLMelx2oQG+
	4NTKsozqBuRVadaZXNbOrJ/zoiMnR9WIaM7+vm6yciK83qDPP95bOlmDtK4M0UkN
	Z7xiBuR8BNW/CN+cU6r8wnXnlSwl2PhfSNNQFwXU1hj4eUuwYgQKVrcPSogNuys4
	FVx/ca+Mf5FOhoK25YulneNQDvSOhBosWKTEXqU/0w==
X-ME-Sender: <xms:WI1dZqveQXtMsVm6gqYBNAxPBcempYAkY6qMDxfKF5CTCScDMfTC6A>
    <xme:WI1dZveMs4DsTkwBLszXon6vFhK-Xkae9US0zal7OAfxInWsRT0RDhmb2SZbXvIAS
    WBZDAeApiGq7H8DRg>
X-ME-Received: <xmr:WI1dZlxHLTohJCcIXLLe1gWfmd_r7R9NR8bGQTNv2xmxbUIqSKyC4mw6zXVfRdkBbZVuP73wlsCzxuKXwI5ehfmfCpqSNqddg2hJm0J23W2WJT-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:WI1dZlN2F0kFtCg4Jc3q9_0KhQW_Q4BsG5N-E0UEx5myA5Wf4msSpQ>
    <xmx:WI1dZq-3E37xicjAOje2qjFK3Wynijg2E1HEpWoPedR6M_-3dfXylQ>
    <xmx:WI1dZtULp_1ta6TlVii1FnEdKVZTX-RvAS4uiaPUwiHf4hMij6LnHA>
    <xmx:WI1dZjf5uiVeFg3sZMHWOr1CRG2RMoko4SzAhjcZ_NxDHDm3wvFxPg>
    <xmx:WI1dZhmHYBH5-soIHogfJu6izgBQtQR6ugB3Zzqc0Mxyok74b7Rn1ksC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:31:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fb7eb77d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:30:38 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:31:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
Message-ID: <1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sCZS4gnJ8ib/ffuZ"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--sCZS4gnJ8ib/ffuZ
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
2.45.1.410.g58bac47f8e.dirty


--sCZS4gnJ8ib/ffuZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjVMACgkQVbJhu7ck
PpRMlBAAg239J8Ly7Z/dpX2n6nrGPOlrva2GsdmQDukC2Bj7EmO3b3YytVQ3a5uQ
gndDR/s5ae1DfmGnCr9iVGn9Tosz7E7p896SVYAAHy+HAICalmTyuaFZmkpXDJs6
8fVkTYDvHKKizvJS7+n1oBizjSvGaMKkVmeALoTwKs3vqnEY2XADlBXWCKKUNJoU
nylZYOXb/V8iJ5FqEtpPleO+FdDLXW8ZSXnsCb+BkIIT6J9TuBqYrZ+piJE94jAw
PkCSX7UsWLelUwssLdhBY9IO/+HhYEprnslclyYYNTIw9PP/QqJH0HBnRCQwAkg5
AMJEPcGKcQ6gk6cVkr5OBpGb0pLeKtSeMPjQtG9z73FxWf9poh1Qm8GqkAiHhetT
UQo7s9yJb78CWO5UzRkAinP3t75kltAwcwqE4ftwRfvGUq1zG8HRo4bzY5E3tGFX
Vb9Ydk46YRRYqad9aJgN6CFsbmegE53YeWzk0l2aC6/koMhjiWdKIXj5RYwXfxSs
SekctWJpriIN8Bvan5IZPt+vg5Hl2Q7phVNcH87aX121SfMgRFLWaxbBEkIfTzP4
asyKTUlnjyO0Vc7aRWJn9h3ozmM2AJ/crxegfCS0le3GMCE/Ne59i68OrccC3NCo
J5F7uwFSboAkAHQjy2xhAlCVkQzZfu7kiZaIJOT1jZwI4OW3CPw=
=RWmS
-----END PGP SIGNATURE-----

--sCZS4gnJ8ib/ffuZ--
