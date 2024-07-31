Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B241B4C29
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435325; cv=none; b=l56TQyqoYicM9nuCca0y2WUIcbRjwdRxcNSLoQnCZD+J/BPp7jmWWgHu6alnmTsXeMp/yyN/vjNSjSiOQWEls362INIvI6jRPwxKNsS62KTZlMJkDWuitaaw4vuh0DfmbJaOIfRoO+W9oCtto/BnpbRy/y3vVX7UDwynIbEUW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435325; c=relaxed/simple;
	bh=O34PZl8uT/u6hMqOdbe/xJNk5sgOyMqz+2BpMxGI3iQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptYIUOodQC7q06Lantdhxho/vPk35Xa0HW3x4UN4EIHSYLl4vogDIJCqhblUaUgKuMI7llhEHsKY/3foLAarV74HfdWkECJTfqd8RGzQaIhBvKOtTsd8EEN4UHt70ORMS4LxJJCVUcEY87hMaJdsalO9HFxS59GDEpRQHVSTvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gxzQUyR7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kcqd19QW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gxzQUyR7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kcqd19QW"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 37D471382135
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 31 Jul 2024 10:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722435323; x=1722521723; bh=Ffn48IIzr9
	k/H28o6JaqtHKAHOFvpbIFWked0Dplr+Y=; b=gxzQUyR7ObNhR+HN5vV6eH27H4
	VC9uBc7qybvuiptCvO49Up4apT20UyKbJ3wcsjUHb18c3mP1vWxGIXpr5rXOSU6a
	PAiwLmJzDfPbzcnUP1CUs9r9UCcDR6ERIFxJJ4gjpz/Hy+ljMqyGyrH737C8gQmU
	82eywwIPIzn16KMxAVmwf2I7zYxUoFGooaUEbTMeF3kVmX44CUmWKc8iJ/RGu0W2
	KGRyPaF9c255nJEKt6x8OBo46G/R1QeeDqvJNr1iQ0XaNVCRVFkG42HNv7zi1pGa
	mRGNEwvhRiGmpttA++5FSAsdclKl5JGlh0okZYAm0l/JqLOxoaBv4r8XfEkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722435323; x=1722521723; bh=Ffn48IIzr9k/H28o6JaqtHKAHOFv
	pbIFWked0Dplr+Y=; b=Kcqd19QWjZs7UUEFsDZ+Nrc5nS3nkpF3cWpRmySgXV+i
	Haob1NYBdOPCVcZmF0RUxkujMj4BU+TMW+0xPOjM1WLVPp1wn3bqBRjXN91ebBgj
	wpnyCfQiKxkBsIP8rPf8Jb1QVw5tJHZSitqe9R+rdSxS0NaONTBg0TkqauiSaxl5
	vg+0boJZR9EbUMfKbjUm6S3ZGasCvD0wJHXYGugADQpED0U3T4Z8sZJJcUVPN+37
	1k4eBsy41wzj3lyuXhDMSRZlfsHiwjLT6L6vYuc1ZLVy3RjedLR7/GSVbl46rdaC
	J73F/s3/t0K+d541NKKNiYDSdWLRwd9vkXGSnP9aCg==
X-ME-Sender: <xms:-0aqZr13i-D4ltLLNslK32wN7u5IIZzjn9O9I6CmSfxGH-iR34kV9Q>
    <xme:-0aqZqHlJ3nCdKjPnpisF4-2xDd1lsZJM0ZQc2F8-u4ZOxh1aFlQnSf2A0geGahgN
    NU8nRjKmbreQ3yVRw>
X-ME-Received: <xmr:-0aqZr7DF7Q4VEfU6C-3BBLHow5xecOYYZP_ZgPm0Oe-s_5ECwxpdJBCIxnfWXhHeB4fa8v-nuaY3AIwIATik5hyVBHrcQpR99y8sqZCuQSXx1gm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:-0aqZg14BoTr17IVOC-nLfqLjaQUgeFNK9ZU8AHu_qc3z7uJaMyHaA>
    <xmx:-0aqZuGP3DRIVmrbxO87CvWmQEry9KrASdb1OFG8NMkqGgCC-RhZnw>
    <xmx:-0aqZh8FgO1-WVMX9WBDG39CtBN-rE3grzZKHha8AOh2KWBAJXg6Vw>
    <xmx:-0aqZrmZTTHBFlZ4ka7BbWkCOCHRiugncDQUxrfgYXuMGOS2FX6Yyg>
    <xmx:-0aqZgOYnZFpOg26QmQgEFc3UY_zNz732gAg0C6ihoYwStXKt4_l6C5c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 507202cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jul 2024 14:13:52 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:15:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/8] reftable/stack: fix corruption on concurrent compaction
Message-ID: <b746565bf0ff80fff60821bdeb79867ad646c142.1722435214.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MfoBN966/TrHkSBl"
Content-Disposition: inline
In-Reply-To: <cover.1722435214.git.ps@pks.im>


--MfoBN966/TrHkSBl
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
are compacting a lot or very large tables.

But there is a bug in the code. Suppose we have two processes which are
compacting two slices of the table. Given that we lock each of the
tables before compacting them, we know that the slices must be disjunct
=66rom each other. But regardless of that, compaction performed by one
process will always impact what the other process needs to write to the
"tables.list" file.

Right now , we do not check whether the "tables.list" has been
changed after we have locked it for the second time in (5). This has the
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
 reftable/stack.c | 101 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 5 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 9cc91a262c..2b1ac58120 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1021,7 +1021,9 @@ static int stack_compact_range(struct reftable_stack =
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
@@ -1124,6 +1126,94 @@ static int stack_compact_range(struct reftable_stack=
 *st,
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
+		last_to_replace =3D last + (new_offset - first);
+		first_to_replace =3D new_offset;
+	} else {
+		REFTABLE_CALLOC_ARRAY(names, st->merged->stack_len + 1);
+		for (size_t i =3D 0; i < st->merged->stack_len; i++)
+			names[i] =3D xstrdup(st->readers[i]->name);
+		last_to_replace =3D last;
+		first_to_replace =3D first;
+	}
+
 	/*
 	 * If the resulting compacted table is not empty, then we need to move
 	 * it into place now.
@@ -1146,12 +1236,12 @@ static int stack_compact_range(struct reftable_stac=
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
@@ -1204,9 +1294,10 @@ static int stack_compact_range(struct reftable_stack=
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
2.46.0.dirty


--MfoBN966/TrHkSBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqRvcACgkQVbJhu7ck
PpRxdQ/9Ev0sRjvFRXBcJdnzxM2cHoauuUQFT9mSRWABYKRBW+ua5h848hHHzbYz
3+8zPKK9+AIi3SZrb4rkccDRMsTkbigoHfUQsIhustE9LFjkILh9kN1cVKV4rfYR
ZnhoCowBE9pApsxq1w09ZaH/JAekAEM0GheF/KSeQqOAGGL+WNnl9zmugCIVasBG
Y2Ndk9EToDKr7MU3XKqmNqdZp5jDgvl4+epxxeQcBbMyXgV2HwzCGcPrMPSxduIW
Yt4vt+7Kf1WtJyF3s3/2nS0UiuswBct1vsbCFwy34jV8jVyzjYLD9DrguUWWbsZ7
OqmAqFo2EF1eocbiC5n/Sdl81OAZXDZjoqhcoXNJXFqWdFMCloBQhCJbExr3k90s
coOOWX/iE2xiuyQnnXSjDq0q3+d3SFmGZfScf3Ld09Sftg6CTRfqMfE6nEY+al3n
Ducz5T2yQpF+5HmN7VcxwE1z4hb1SrWbBHi7kxV+mya748WGVmkhU58xhRssqT04
4a3uWEqL5uueadcGsM8WAMpcQr3AyvNrp3tUvm5QwH3A0lCxQtWQH/uTL2tixJb+
oOttsvnIEARo8Fh5thbw4+5+JQZ8ESLOBEMMTE5nWO0iyUB3xlKI6Hg2T9Hxc1vb
gQD/ZXSO7Ypfy6M4b/i2TVATCcZEgXE4U4DVCWVnP4UoWwwm8Yg=
=MlJ3
-----END PGP SIGNATURE-----

--MfoBN966/TrHkSBl--
