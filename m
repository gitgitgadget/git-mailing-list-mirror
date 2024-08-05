Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE9F15574D
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863305; cv=none; b=W4gA4UGW6nLQiFGewjI6WMYSicrKMleeyWBjXKVc1SCgUpSF8xX9g6qRJHndv1EVvD/M5wG6qlLpzM71AWbC9XbwU+zQNoI/K8rbYpXKOMBNqyUvG2S1zVKknTZPMypKjuzj+gKmUzcsyp91mNkvvw8IzalOv8DCqGy9SubN8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863305; c=relaxed/simple;
	bh=MOALVfFqh8Au/t6BO864DbrpOJbCzHsP7/Sf06f1mSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnHVdXSSDKn3UqUaO3zPyFRvGQKd5nL1wsgake5RO56RZ6dLLqR/zthZl/eHabq2XsSqgaO5T+PX0BTDASsHJcC5H0pW1uzLicZE3XMA5+lmfviNDSnRSAfbfw59jiRlkai84xqljzo7OYoLTJjVhMSafwOB37IwT4yNmJ5TTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EaipVMkf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R96aohp+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EaipVMkf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R96aohp+"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 424F41151B79;
	Mon,  5 Aug 2024 09:08:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Aug 2024 09:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722863303; x=1722949703; bh=kxm/gXzt4Z
	gQQ56nRNKDvwwun8WWArxfwXkVhtOCBSs=; b=EaipVMkfmq//qP3xCtiLZNG+fm
	Uukr7umuYDcFIb1MkTCSduFgXC2aQ4LYOs04A2qdLx+X5mbS6QpBH1xNJHg1R/d4
	KeNNf2wVqSFW0Tulso58KRfajG04mQkgbPDiboaHT5RXBaEuzBNAJTPBgB2EUeu0
	H2MnxpCjmCFxFMuq0ONErKjktsqQKyWF3MqceypGm0Hi+VkMaKftw10aQ+NyRwzf
	A5MjHisuWM6Mleifkpq34IMCwhuV9JA7suOlZrbPS8dBcd5L2MJti+oYB3NWgwgZ
	awSiuhodX+ep/sfJ9FRkBjOqBhWtYUJfD7SfIeUHVT4alBr8GMNRvRKDVITA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722863303; x=1722949703; bh=kxm/gXzt4ZgQQ56nRNKDvwwun8WW
	ArxfwXkVhtOCBSs=; b=R96aohp+H95q7m97WYwi1Fbio69QtP2spMbyvyYJ+Oo8
	KX2SogFEuQgE9VEvoY5oe5M5RJWLYqptrahc3IIEX3hrDNkIRSiHrnlbsB3WvKl8
	G+IqAq+PXhEvRSkTrEdRbWNw0hQV6drMSaxA/czr3PBo74fzUcFoW+JUNmdILFx9
	zCGZe1r7wmz1Oz9kS6Dek/U5F28xx6kRebO7v5OmulUFGyWA0VPSIEeJHWLl9vwU
	ZVDjh55x2xlWLQxvvHWDqxbiwvWcr5z33xswtkndPU74fsfxoj2gSCabRL4XfygO
	x6NQFiluUrUAV5bhnbPKe5M222NFagTvHUmjN/io+g==
X-ME-Sender: <xms:x86wZps26gIVSJhpFgu1d-PZbmUIrqeYp2qPx02vzG4D3W6SKYNJzg>
    <xme:x86wZieeorNYHqAuhLSgeZrTKwbMkw41PZp7wTRo27NB_cH6tBE95dRwkOpiq81B4
    Cejhzv2BwEEK-KG9w>
X-ME-Received: <xmr:x86wZsy4qCstzauKW0zqmX1-DWhT4nH8HBLccNpOApm4KtfDFbsBanhLELttDb7gfzxVVihLDhJTFKu0xZYSQ9TkfX7aCtlG28BGEtNFc3I7HdVb4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:x86wZgNj0bXSDZVK08a43QsMWOzeDlE9dsKs4cQ3upIU2ukrjXCPsA>
    <xmx:x86wZp-eI6a12TEOBZmj_UOqxGNQvYk_BPBUPPbNZhHeodE4zr_fCw>
    <xmx:x86wZgUAKFtcA16mMjpXoefjUBm-Gc5QfJ73bVIPxst8FpT-gxan1A>
    <xmx:x86wZqcRRo1ow4s_8Aa6n8f7P9HS630C5lEm-QjP2amTr9sCbrla7A>
    <xmx:x86wZkaBjJm8WvB3RQl0emKpulxvO3OF5-3QqqqJVG8Wm_H5p_IfAGUy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:08:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba3e2f40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:08:21 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:08:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/9] reftable/stack: fix corruption on concurrent
 compaction
Message-ID: <ff17414d261065d9eff01335040f5aca3a048059.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8XxaCRznp0vOiaS9"
Content-Disposition: inline
In-Reply-To: <cover.1722862822.git.ps@pks.im>


--8XxaCRznp0vOiaS9
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
index 54982e0f7d..51eb4470c7 100644
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
+		last_to_replace =3D last + (new_offset - first);
+		first_to_replace =3D new_offset;
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
+		last_to_replace =3D last;
+		first_to_replace =3D first;
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
2.46.0.dirty


--8XxaCRznp0vOiaS9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzsMACgkQVbJhu7ck
PpR+qA/+JOPxi1lbWaGiwu84XkGemz60K6SRF58FynCxEwPlqadd99ECE5WWGRxd
uwiqvlVa8rM8doThNWB5ocIebeBABNPncLH8hKOWz8cCVjiwoQ7FjuAzcC/UN7vs
Vi4XbyimKOpCIxUgbs9zGGseItTbDWH2aGb/MWnIq1j/ZGqVhNNZA87wnbKqOmOP
UTr1JEqfxjqfqgYsemJISqTmhhlJr8Kj2gN09NpW42hCbIHGCMuQxis/vX/maf1v
6NX8d5MJoPwR7UcOR7R0eMiAihusq3TI//uAq+/BYHHzDJDJeqwx5zBvBm+dagaA
jzlMWULPMKsxHQTz1xQnhJ6mU6B6yN6IOuKzT5rS39N2rXUSFpEN+qRauxV3FFp+
Xre6O4bzrG+BDCmZro6MU+7aYgB5oam1m8T+N0/lZ74xGfdU/PnR3d2OZQftDS+W
bszTzxl6BFJ1k8ZfQgg5YS0RxWXEPyCH84yu3Hg/95p3fqW9A30E4e1j4dzvzXYW
zx821BgXl6TgbXVZqNYNHOs+xXYK9t4gn3T086CT/OAcWiXygJCRghXW+dQPVgCJ
AsCdrn6m7Ret/3HL3nozL6QUSOv03akszPKO/7RJJuNf3d9BPwaXIlzHES7T/5aT
O06gZIkvSAZU6ZmIKDeFhCMx+BaZR/hP7hwtYzDOvbkDGDPjirY=
=qeW9
-----END PGP SIGNATURE-----

--8XxaCRznp0vOiaS9--
