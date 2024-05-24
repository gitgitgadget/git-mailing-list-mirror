Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1C85930
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545712; cv=none; b=fwgPybfMqpoYi3mMatUy6dOQKGsLehwXLEmA6LjHJPZB7LVFLVA+/iNdfQUJUGt5tK4WKlCR9icgl2VFQAV316qT8fpmaQ5nzhX6LTC3aULfeF1J2pKSb7ulekrQyQz6TRd+nKsoQjM6zQ2+u6MCnhJjIHvvhUG4rTdO8oJKeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545712; c=relaxed/simple;
	bh=vRaESfYj5FscoNrnNCA88iukijwFXwBEwca0GhresWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZvroACXWsDaqFEEv1pqAZfAgI9gSqmZ/HFi3+Q/MMx8CW5LNUKasf0FDVO/GI+MCY8y3hcgZP/6LYxJjCKASUqNaFtAXHLpzfan5S6OYGNo0XJITsSWZ9AB6igRbykHCog00U/+VwYCl9xfn+rvwsIqpbcmDzDwgZa82oEzpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eF/W2p/L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WszER8jn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eF/W2p/L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WszER8jn"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0B12B114019E;
	Fri, 24 May 2024 06:15:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 06:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545710; x=1716632110; bh=7OvBFtuha0
	pupDO4wUMz+/Hn/NuWEnYPmqGPuN4HX88=; b=eF/W2p/L+Ei7dr6dh14FcJOMYS
	iejHvVoH0rY7jp7hpa4FLwTAw409lFwy4U/Ud6/zh6s9Ocsh86XLZz9/M6jPlJor
	SbxPqdEkdJLCe+y4BOJAZJujfi4L00uEIwfdPXtKD4p5O5FOvWKPkAccidQGj2NL
	vgq1B3Yh2QrLwYOoeAmaq3+PFPZ9gzXz+BznYXlEFESIUlTl5F4OyTOXEG3XfxX3
	4h//ZrKhSl5/QKCu0giEn1y4ePgtopc9jxHJlH2rgN2HDTs3uUZwpKYMm0aTOelL
	+G0eWdIGLzNy/ctPFUHlMHlDi9Ac/+62Oy2yolxbVlkak5frDqqLp+WGzjOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545710; x=1716632110; bh=7OvBFtuha0pupDO4wUMz+/Hn/NuW
	EnYPmqGPuN4HX88=; b=WszER8jn9+o+m342ZPQ3DWE3stgqJiqPTkEMsHtFf5EX
	DQopIVJCZWOOOS5dmKF6LkV9wyoXtaDwMGzSv1fOsw/o7xZeyXaZrfoDnrmtPTfL
	ZlOQ5gJxZO8IiOwNkicI7LZq2wgfCNn3rU1qQo7oGb4jzUnOFviZR4D7WRA/1s86
	E+Gp/0MljZoH3/ihahhnE7t32Qz9wvsSZzM9/Yz4lykaksdHId4vtW8C+iAv2XqX
	BdwC23xRfcvCSoa0bcpeTC4Nxv4z8bd5+CyTb8FPEXbaPqthSjVAM5sFYLD9nWSg
	bU1MQ7JbvbMTvA9Pyk06t4OiuYL0tq5Rmy391B81Mw==
X-ME-Sender: <xms:rWhQZmxOF3PjUwlL_VFuqddUAnmgz4j3PwpASM2KghERNvWwXZF0xQ>
    <xme:rWhQZiSI5yzEBT6kqR6ehMWwmgdTml_ZhMMOvsl2W-FEUGgjbTgyVSgXyFJwhqRDP
    B-xr98-ZvciGFHKTQ>
X-ME-Received: <xmr:rWhQZoWnddPOL-AUyPEA85s1xY06nm3Kj328Bis2lEFnWJHRMW1e61s10GNW4hOsFUGXUW9MzIe60dKUWqmBjDhgfJDvGaVSOWw3hj6QXcX9bKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:rWhQZsg9Gcff9aHK6exA3uDqmEuU14w9SQxIkSybyKm7NOngZDQE6w>
    <xmx:rWhQZoDC5BMBV5WqDZw99V7QDR7wip4pYX2xp7Q6X6GeEyd8Zl-84A>
    <xmx:rWhQZtJsDM6bRn3hAthQ7-KJ_k8V7t1M5no0y1z7NtAJ3fXMD7oFvA>
    <xmx:rWhQZvCSRMWXstikYiK760vxO9bbUD_raldh70Rba198QKNsrBaQnA>
    <xmx:rmhQZrPaMlVumcbTVdogpMJtIxp16ORJh_PUr8xlU4VfazWyU1hsSsaR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:15:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1440e735 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:15:05 +0000 (UTC)
Date: Fri, 24 May 2024 12:15:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/9] refs: implement logic to migrate between ref storage
 formats
Message-ID: <4d3eb5ea896bffffbf28ab4865b69901cc9edee7.1716545235.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yfsOdOdGk3xD2+PG"
Content-Disposition: inline
In-Reply-To: <cover.1716545235.git.ps@pks.im>


--yfsOdOdGk3xD2+PG
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
    concurrent writes may make use end up with weird in-between states.
    There is no way to fully lock the "files" backend for writes due to
    its format, and thus we punt on this topic altogether and defer to
    the user to avoid those from happening.

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


--yfsOdOdGk3xD2+PG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaKkACgkQVbJhu7ck
PpT1QRAAhlIeCNpy4p6RteHJGXWWr4om3z6Qe3W0CLkwm1A0vUflFK0iiGv73C21
VdLjcXtRdqLnQuIPsm4EkHIwgiyHOYW1tpGltFgMJ4eq7dmd8fsllwGTI5lMJCZo
BUaDzTnJRtTV6rOavA/XPe3Y3gxnLgrOv6yjKrc3CPe0XMUmp18jvYb2wVWEt7q4
0aVkhv6DuMlc0nmaxWATKN5RC1YtVbnLebM/+bk6CfNMFm6LIad3ybwiva/oTrjy
4usO5fpCB6xOw3y5GCuS80hyJMdd6e4xeobvs8e1nRycxXqgEpd6cDSsmjWlu+cN
h0Yf+QLcu1Ufa+Febqz3s5+wO1vITPFSKQDI6rzhAhoBUt5No4s+6mSxbJAC2w1T
n+puD5vzhwNO4lU+TiRiSGVjokqZ12m+Dtm6NEFngfRcl+NNSKSlBbkcACCe0vUU
eVWKDIbozOG49TOVGsRwKUhpx8FcIBT1B/I3z0SWhb01rGb7+X81EuScsS9l1EpD
G7Dk+IPiUjnfGI65iX7LwxPLtiFBdIdG2jrGRYp1tuEdTe+pH9/j3iPpvmrd4P0R
vSOdxNkX645aqrBVGSc/h3GV7HgizhEnyQ7FgXcFR6+QOBirN/9GXeIJvA2n+aLV
eNmDhkaNRJRKOlqncQvvDTGLh45KJ5eyMA5nm0Z1RMYCKezBeOQ=
=92QX
-----END PGP SIGNATURE-----

--yfsOdOdGk3xD2+PG--
