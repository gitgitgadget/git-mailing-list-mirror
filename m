Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB563D
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126019; cv=none; b=MVuCveGzNNcj+yUA65VvVL1d5X6tWsNG6BNLQsqhQrDPJ+Mcnv3OgDMdzpzb0FC0vH3erDlvC8PW9QMD9tf0o+oLMbeKmRqvsEc7zMoPCObmUqIaWzrHV4huYodO/hHudVsIs/Fsj8l5HkN7UsYF1ULJ3IzhmoprP6hWH3/mXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126019; c=relaxed/simple;
	bh=QyMxiqeVkL3q0K+VCAhGV6KCiUitrwaHLBp2mDrt/zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDC5uxalXxfh1uQLILSq+c4AqL6JX5AClmmEqKXbRdClH7hnwfT5PkWK/xfRSjv2eSdrUoh6D/PLXZB1cxczsw5bhbXOtFZ/6Vd2gxVuQOqQhWDsM+6RyFfXkvCTaO4nYLYhLsiozdH9DDObSB5Q4iLzJFbfV0C9nMdZ0Xvts74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I8aq9JUH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vBaaVwB8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I8aq9JUH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vBaaVwB8"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 64186138FC9F;
	Thu,  8 Aug 2024 10:06:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 08 Aug 2024 10:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723126017; x=1723212417; bh=uovY81k2C6
	fziKb3NoOv8QMwyxmAElagFGPCtHAZ0n0=; b=I8aq9JUH3zvnlcmgpIZ/udNBFt
	t29y9aFvmMucRqyufo9Rj2Nt3O7LJpVDh1/f073w2ortCwcNso0cSyNpf55eTm0w
	mwVMiQqDj5/lFBJQPh1SFE6WmCWVS0Ns2CQLPRBaPr4dYYVbmJuDzIHGZVGK29hc
	fEz2d4hEDZAhPaL8U7B7suwFPb6C8crwqfQUo2id06+ExVDZZwScQchwUnosnqOG
	o4NExTaah/tVkpY0+0/WOf+ymECPfSlKbqBs3PM0n41CpHqmNVRFijCxFpxsKTnx
	iGtTDkAXhynhLUTbaSpM/kRfQdtNJoLVC68veiG/cB7zi63u8exhJ7IxXD3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723126017; x=1723212417; bh=uovY81k2C6fziKb3NoOv8QMwyxmA
	ElagFGPCtHAZ0n0=; b=vBaaVwB81pzYwTC5WxzW/zYwiinZjyJ+0f5+o5RKmtN9
	BVePMkL1Ov9ZqvAaoS2vqgVLgnLX/pZERoOWY4pfkE/LmQD2X76kiFcjI0X748Y0
	BTPWCfp6FqnzHjToSXobou53Y669Doqc8pxspJTY0CsyR0Vi4GHjCns2kYokUVRD
	z2rmSpo4AnFcsBClmAHKesd3/Wgt6Qa8bRNPhgxuuVeEu/000rbJvhAZYiOFZEnq
	Zyrg+Vj+eaz+I+pGFX0yw/O2ZtXtFXrFK9IBoVlloOQqx9Z23m8EPv+ZUK5jcLRN
	L0Otjijj1523npkbqTulXDGKElHAmXL9yHjuSHL2vw==
X-ME-Sender: <xms:AdG0ZkasyGjo6HvHEOKql3ZWjWycJlymm2dllxJDMasYWJIJRi8P2g>
    <xme:AdG0ZvZZtrTfZDrSoo0lVr1F7BdqysOdYDOckRaYYBaOCnfXgoB7Wo0WtEo4RmFB3
    PvuCbRNK4CwM2dEcQ>
X-ME-Received: <xmr:AdG0Zu-pnwBeKIGlKhMgSpvTGf86MZAzo4eSTJdqnYs3lKvlrJv5oPQtlwu1ir9s-iC8R3_o6twDBBOLWyLPpMJtYwPY-BM2dMHVOzEEb0NPxtBj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:AdG0ZuqA3-U-U4b9SpmREMBa_DOmjuhWVLQCtdA1qb-WYRm-r3RSGg>
    <xmx:AdG0Zvrj962QmhgXl2bOppCM5d6F8WH-H3Ksd4IcYYwXarKbGlHT2A>
    <xmx:AdG0ZsRJvUC-ntNVbRygmWkveccHlzRBq9xD1SPL47QMFeXMIxkA0Q>
    <xmx:AdG0ZvoRLAwLBVZwDHZzKKblsfwGJLqa75caCJ-kAEXye-isDgEdjQ>
    <xmx:AdG0Zgkm7CSQUkEa1dg5WvTyCyjV21rYDb82D2fTY_NpT16Fz2VzIWbQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 10:06:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 608fbc7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 14:06:49 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:06:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 8/9] reftable/stack: fix corruption on concurrent
 compaction
Message-ID: <b27cb325fc59796a2cfdd8caac2132f982681257.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1723123606.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0JNHdDT8IbbteD+E"
Content-Disposition: inline
In-Reply-To: <cover.1723123606.git.ps@pks.im>


--0JNHdDT8IbbteD+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The locking employed by compaction uses the following schema:

  1. Lock "tables.list" and verify that it matches the version we have
     loaded in core.

  2. Lock each of the tables in the user-supplied range of tables that
     we are supposed to compact. These locks prohibit any concurrent
     process to compact those tables while we are doing that.

  3. Unlock "tables.list". This enables concurrent processes to add new
     tables to the stack, but also allows them to compact tables outside
     of the range of tables that we have locked.

  4. Perform the compaction.

  5. Lock "tables.list" again.

  6. Move the compacted table into place.

  7. Write the new order of tables, including the compacted table, into
     the lockfile.

  8. Commit the lockfile into place.

Letting concurrent processes modify the "tables.list" file while we are
doing the compaction is very much part of the design and thus expected.
After all, it may take some time to compact tables in the case where we
are compacting a lot of very large tables.

But there is a bug in the code. Suppose we have two processes which are
compacting two slices of the table. Given that we lock each of the
tables before compacting them, we know that the slices must be disjunct
=66rom each other. But regardless of that, compaction performed by one
process will always impact what the other process needs to write to the
"tables.list" file.

Right now, we do not check whether the "tables.list" has been changed
after we have locked it for the second time in (5). This has the
consequence that we will always commit the old, cached in-core tables to
disk without paying to respect what the other process has written. This
scenario would then lead to data loss and corruption.

This can even happen in the simpler case of one compacting process and
one writing process. The newly-appended table by the writing process
would get discarded by the compacting process because it never sees the
new table.

Fix this bug by re-checking whether our stack is still up to date after
locking for the second time. If it isn't, then we adjust the indices of
tables to replace in the updated stack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 107 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 5 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 54982e0f7d..3f13c3eb34 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1020,7 +1020,9 @@ static int stack_compact_range(struct reftable_stack =
*st,
 	struct lock_file *table_locks =3D NULL;
 	struct tempfile *new_table =3D NULL;
 	int is_empty_table =3D 0, err =3D 0;
+	size_t first_to_replace, last_to_replace;
 	size_t i, nlocks =3D 0;
+	char **names =3D NULL;
=20
 	if (first > last || (!expiry && first =3D=3D last)) {
 		err =3D 0;
@@ -1123,6 +1125,100 @@ static int stack_compact_range(struct reftable_stac=
k *st,
 		}
 	}
=20
+	/*
+	 * As we have unlocked the stack while compacting our slice of tables
+	 * it may have happened that a concurrently running process has updated
+	 * the stack while we were compacting. In that case, we need to check
+	 * whether the tables that we have just compacted still exist in the
+	 * stack in the exact same order as we have compacted them.
+	 *
+	 * If they do exist, then it is fine to continue and replace those
+	 * tables with our compacted version. If they don't, then we need to
+	 * abort.
+	 */
+	err =3D stack_uptodate(st);
+	if (err < 0)
+		goto done;
+	if (err > 0) {
+		ssize_t new_offset =3D -1;
+		int fd;
+
+		fd =3D open(st->list_file, O_RDONLY);
+		if (fd < 0) {
+			err =3D REFTABLE_IO_ERROR;
+			goto done;
+		}
+
+		err =3D fd_read_lines(fd, &names);
+		close(fd);
+		if (err < 0)
+			goto done;
+
+		/*
+		 * Search for the offset of the first table that we have
+		 * compacted in the updated "tables.list" file.
+		 */
+		for (size_t i =3D 0; names[i]; i++) {
+			if (strcmp(names[i], st->readers[first]->name))
+				continue;
+
+			/*
+			 * We have found the first entry. Verify that all the
+			 * subsequent tables we have compacted still exist in
+			 * the modified stack in the exact same order as we
+			 * have compacted them.
+			 */
+			for (size_t j =3D 1; j < last - first + 1; j++) {
+				const char *old =3D first + j < st->merged->stack_len ?
+					st->readers[first + j]->name : NULL;
+				const char *new =3D names[i + j];
+
+				/*
+				 * If some entries are missing or in case the tables
+				 * have changed then we need to bail out. Again, this
+				 * shouldn't ever happen because we have locked the
+				 * tables we are compacting.
+				 */
+				if (!old || !new || strcmp(old, new)) {
+					err =3D REFTABLE_OUTDATED_ERROR;
+					goto done;
+				}
+			}
+
+			new_offset =3D i;
+			break;
+		}
+
+		/*
+		 * In case we didn't find our compacted tables in the stack we
+		 * need to bail out. In theory, this should have never happened
+		 * because we locked the tables we are compacting.
+		 */
+		if (new_offset < 0) {
+			err =3D REFTABLE_OUTDATED_ERROR;
+			goto done;
+		}
+
+		/*
+		 * We have found the new range that we want to replace, so
+		 * let's update the range of tables that we want to replace.
+		 */
+		first_to_replace =3D new_offset;
+		last_to_replace =3D last + (new_offset - first);
+	} else {
+		/*
+		 * `fd_read_lines()` uses a `NULL` sentinel to indicate that
+		 * the array is at its end. As we use `free_names()` to free
+		 * the array, we need to include this sentinel value here and
+		 * thus have to allocate `stack_len + 1` many entries.
+		 */
+		REFTABLE_CALLOC_ARRAY(names, st->merged->stack_len + 1);
+		for (size_t i =3D 0; i < st->merged->stack_len; i++)
+			names[i] =3D xstrdup(st->readers[i]->name);
+		first_to_replace =3D first;
+		last_to_replace =3D last;
+	}
+
 	/*
 	 * If the resulting compacted table is not empty, then we need to move
 	 * it into place now.
@@ -1145,12 +1241,12 @@ static int stack_compact_range(struct reftable_stac=
k *st,
 	 * have just written. In case the compacted table became empty we
 	 * simply skip writing it.
 	 */
-	for (i =3D 0; i < first; i++)
-		strbuf_addf(&tables_list_buf, "%s\n", st->readers[i]->name);
+	for (i =3D 0; i < first_to_replace; i++)
+		strbuf_addf(&tables_list_buf, "%s\n", names[i]);
 	if (!is_empty_table)
 		strbuf_addf(&tables_list_buf, "%s\n", new_table_name.buf);
-	for (i =3D last + 1; i < st->merged->stack_len; i++)
-		strbuf_addf(&tables_list_buf, "%s\n", st->readers[i]->name);
+	for (i =3D last_to_replace + 1; names[i]; i++)
+		strbuf_addf(&tables_list_buf, "%s\n", names[i]);
=20
 	err =3D write_in_full(get_lock_file_fd(&tables_list_lock),
 			    tables_list_buf.buf, tables_list_buf.len);
@@ -1203,9 +1299,10 @@ static int stack_compact_range(struct reftable_stack=
 *st,
 	delete_tempfile(&new_table);
 	strbuf_release(&new_table_name);
 	strbuf_release(&new_table_path);
-
 	strbuf_release(&tables_list_buf);
 	strbuf_release(&table_name);
+	free_names(names);
+
 	return err;
 }
=20
--=20
2.46.0.46.g406f326d27.dirty


--0JNHdDT8IbbteD+E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma00P0ACgkQVbJhu7ck
PpTADBAAhJLyiC1ZjSF1CP1GxSvbgx0yaeO0S2WfO2Y3OULf39PTfUDQXcpKgJrB
8QQxWAc8ApuYwf52fzxJsmsJ/8GHlKg8+0EpT4a+uMOL/AyYaGmxKWtxvn2DEjRQ
c+W6W4S29byJtQHHHRCDPhAAlC57rBqqwQdJNHHqEnuBMJ/8RFGVMO5acHcWfj3i
cXsEfyi4TRZxK4aC89zE5hc+9batXQ2qKnc0pYN7XIZrw/noezH7zaVQ/Gr6tVLu
titPkAuQtgqR5beEZ3V1SfplgX/JhQ9LbcYhKabUeZV8aJzlWCW9iivLhiYhLcEd
RByCFsI+rmWs45Uk/QfR/y/wOcQjmwRrGrGFblEljnbRXmP3vE/7jpoM4NFd5d14
+ri9nXlgEQof0zyXRLeuMVjku7mZcVWb4uNLn+d+ldJmS3cueGojS5ew6pzslcxX
HM7nnBOTaDjLIkjF+ui9W3zJrNf1LimmFI6NBtCi/uQEjbPUxdTN6s4Btu0Rb3yo
aJkONQDOehQfwXGasuPRxw9qQld6ppMmjKwXDC6j4KHPMaCMZ+e3ahNFrVdRNIOq
5RPxjMu5VlxHor0SbrZ3VBQzpZAoRBlJ1RdFxEVf+fQURQshq0siwS3VgelQApN3
k0QmcdUgGTJYF26TTR2FKe0hozRvQfsOAEUnC5WCrAa5Q50XqQ4=
=lFMs
-----END PGP SIGNATURE-----

--0JNHdDT8IbbteD+E--
