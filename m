Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355338DF5
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550661; cv=none; b=RXSL3vx9N3R30cawBv6jKKMJi0zARfBG/vWrY5dqLut+HkBBVxs7jYx0aVtdfpWW1sMvJPXZ2Gq01Vej9pOgYAMujGHiYbvA/tafCW0kJtXeIpBPEIJlBK+XrcGEBPDE+L/MercH7yIDY8nSCHtvV+W0earM7g1lJA29oTqFL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550661; c=relaxed/simple;
	bh=0+RGmJ9URKT3RmLAlGpE7xbVjcrJ+IKKtw1dkemQ6aY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB+gUNta4stNyZaCuvwMnbODasyHnK/mgLFSMqMTPCSm4P/9EFScTNj2O9gZhv458SE3J7EC5kw61ffP+vBwlNZJPTZVIbCz+jm0f6IH9x/6HaTJ1xJkre94z9AoFU0nKXsmeSIvI+1bFt9bDfz/0yT2bhz5BpfAyTDnyTi+UT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UND4sFKt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jiSySMaR; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UND4sFKt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jiSySMaR"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id EA85218000CC
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:10:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 04 Mar 2024 06:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709550658; x=1709637058; bh=4eD4/nUXB5
	Vi2wD4z8TBHizHXifrBG8YvaPxLXS4xNc=; b=UND4sFKt5aRzXVhrPgMoCzE6yS
	T9rMXBxxMrHGCCVOZ0A8gq35vvn/Sv+NVCpscXZHAv/EllP5yYKfOh++1AA1Bsc4
	/qog0XCeeWkkXP5vKi/MaKdDjYIBpPVqQvKkW1fXj0QmXjuWh/RfwJA3Q0x9v3CF
	z7FIV53xAc3ousEc8HKjC8QwAaa1XlJ4kwtLKzgF8/JVzJDCAfbEhsX5e50U1Q/4
	2zhvgPAHS3LcowD1+hLNxV/SlQALnp1G1ArG/q/Ehqex+olXD52MDxEsmpdk3k4y
	xz2uio32RLHOFYix/9OlCA9JXtq7RG+Wpzn0cdAz66TtP6npARQ43fzOhftQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709550658; x=1709637058; bh=4eD4/nUXB5Vi2wD4z8TBHizHXifr
	BG8YvaPxLXS4xNc=; b=jiSySMaRI+HBOxYtFtw4Heuk4M2HhJvIF4E1RQjgDrXG
	iduZElGcgy0QxpWeNnm95diOod5CuXZtpCwNcJImnY6FzbK1Do7ziYJXgYPO0M+8
	mzwN4QKSr4D4emofnZ1++bwMLDBYQPePuSHifY7mVbQIQxvtaXt5zKzuQyKKJag9
	J/rVOSQQhxlpigz/R8D5uzMHlNGGXFxjhVIJV1QpEPuO8c4x1GD+l0CA77m5hKnx
	re15uFfYxZ3Ml01tqLnv77LJXTvqX0QZ7saaie8piTA9r0uUp4vEcHDzR6OkpYeN
	mrQWk/KqnOxQ092h9k6NN5h2mCQHTupZwT5avvB9yw==
X-ME-Sender: <xms:QqzlZfy5C64YSdve2YYL1nVYWM7lw10AxO2C_0NPhqtt5I4PVRilZA>
    <xme:QqzlZXS0XOixf78FvAPSPQuYEoUNyYvAM602kZjMszIQSOXMv0ovFu-ha0PEKIcmJ
    ruIte9r-OOHWGqreA>
X-ME-Received: <xmr:QqzlZZVl6SOyA86E2usGhYhTls9U8FHmaKU9lhaVNW9kOtJEY9x_XS_jbvM45-DEj8v_4Rn0JP1XSO8MxHLh-n8QLJriaanlMQTrfm4KjiqhAH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:QqzlZZiK4xvYx_L8yujbA2ypOOPfFLeb57z0N_EXcbLQ2ltX6H-aTA>
    <xmx:QqzlZRBXyh5_sqau-tJkm7bOyp4G_zzt4Q6iCe2U6JNSRzp5zninUQ>
    <xmx:QqzlZSIOBopcbOelPHc1TScVokpz1OgTRWD_O3deZSIMwkU16ZbqSQ>
    <xmx:QqzlZe5QuHabTz33b1H4RWtdQglUOvZHVRyDb1fndl6RJUdA0dWc2yZBb5E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Mar 2024 06:10:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d2f64b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Mar 2024 11:06:32 +0000 (UTC)
Date: Mon, 4 Mar 2024 12:10:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/4] reftable/stack: register lockfiles during compaction
Message-ID: <45b5c3167fbfd64d8d1e14ed55bae94cb9cba28b.1709549619.git.ps@pks.im>
References: <cover.1709549619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OR2o+MUivpQWCKlk"
Content-Disposition: inline
In-Reply-To: <cover.1709549619.git.ps@pks.im>


--OR2o+MUivpQWCKlk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We do not register any of the locks we acquire when compacting the
reftable stack via our lockfiles interfaces. These locks will thus not
be released when Git gets killed.

Refactor the code to register locks as lockfiles.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c  | 255 ++++++++++++++++++++++------------------------
 reftable/system.h |   2 +
 2 files changed, 123 insertions(+), 134 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 81544fbfa0..977336b7d5 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -978,212 +978,199 @@ static int stack_compact_range(struct reftable_stac=
k *st,
 			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *expiry)
 {
-	char **delete_on_success =3D NULL, **subtable_locks =3D NULL, **listp =3D=
 NULL;
-	struct strbuf temp_tab_file_name =3D STRBUF_INIT;
+	struct strbuf tables_list_buf =3D STRBUF_INIT;
+	struct strbuf new_table_temp_path =3D STRBUF_INIT;
 	struct strbuf new_table_name =3D STRBUF_INIT;
-	struct strbuf lock_file_name =3D STRBUF_INIT;
-	struct strbuf ref_list_contents =3D STRBUF_INIT;
 	struct strbuf new_table_path =3D STRBUF_INIT;
-	size_t i, j, compact_count;
-	int err =3D 0;
-	int have_lock =3D 0;
-	int lock_file_fd =3D -1;
-	int is_empty_table =3D 0;
+	struct strbuf table_name =3D STRBUF_INIT;
+	struct lock_file tables_list_lock =3D LOCK_INIT;
+	struct lock_file *table_locks =3D NULL;
+	int is_empty_table =3D 0, err =3D 0;
+	size_t i;
=20
 	if (first > last || (!expiry && first =3D=3D last)) {
 		err =3D 0;
 		goto done;
 	}
=20
-	compact_count =3D last - first + 1;
-	REFTABLE_CALLOC_ARRAY(delete_on_success, compact_count + 1);
-	REFTABLE_CALLOC_ARRAY(subtable_locks, compact_count + 1);
-
 	st->stats.attempts++;
=20
-	strbuf_reset(&lock_file_name);
-	strbuf_addstr(&lock_file_name, st->list_file);
-	strbuf_addstr(&lock_file_name, ".lock");
-
-	lock_file_fd =3D
-		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0666);
-	if (lock_file_fd < 0) {
-		if (errno =3D=3D EEXIST) {
+	/*
+	 * Hold the lock so that we can read "tables.list" and lock all tables
+	 * which are part of the user-specified range.
+	 */
+	err =3D hold_lock_file_for_update(&tables_list_lock, st->list_file,
+					LOCK_NO_DEREF);
+	if (err < 0) {
+		if (errno =3D=3D EEXIST)
 			err =3D 1;
-		} else {
+		else
 			err =3D REFTABLE_IO_ERROR;
-		}
 		goto done;
 	}
-	/* Don't want to write to the lock for now.  */
-	close(lock_file_fd);
-	lock_file_fd =3D -1;
=20
-	have_lock =3D 1;
 	err =3D stack_uptodate(st);
-	if (err !=3D 0)
+	if (err)
 		goto done;
=20
-	for (i =3D first, j =3D 0; i <=3D last; i++) {
-		struct strbuf subtab_file_name =3D STRBUF_INIT;
-		struct strbuf subtab_lock =3D STRBUF_INIT;
-		int sublock_file_fd =3D -1;
-
-		stack_filename(&subtab_file_name, st,
-			       reader_name(st->readers[i]));
-
-		strbuf_reset(&subtab_lock);
-		strbuf_addbuf(&subtab_lock, &subtab_file_name);
-		strbuf_addstr(&subtab_lock, ".lock");
+	/*
+	 * Lock all tables in the user-provided range. This is the slice of our
+	 * stack which we'll compact.
+	 */
+	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
+	for (i =3D first; i <=3D last; i++) {
+		stack_filename(&table_name, st, reader_name(st->readers[i]));
=20
-		sublock_file_fd =3D open(subtab_lock.buf,
-				       O_EXCL | O_CREAT | O_WRONLY, 0666);
-		if (sublock_file_fd >=3D 0) {
-			close(sublock_file_fd);
-		} else if (sublock_file_fd < 0) {
-			if (errno =3D=3D EEXIST) {
+		err =3D hold_lock_file_for_update(&table_locks[i - first],
+						table_name.buf, LOCK_NO_DEREF);
+		if (err < 0) {
+			if (errno =3D=3D EEXIST)
 				err =3D 1;
-			} else {
+			else
 				err =3D REFTABLE_IO_ERROR;
-			}
+			goto done;
 		}
=20
-		subtable_locks[j] =3D subtab_lock.buf;
-		delete_on_success[j] =3D subtab_file_name.buf;
-		j++;
-
-		if (err !=3D 0)
+		/*
+		 * We need to close the lockfiles as we might otherwise easily
+		 * run into file descriptor exhaustion when we compress a lot
+		 * of tables.
+		 */
+		err =3D close_lock_file_gently(&table_locks[i - first]);
+		if (err < 0) {
+			err =3D REFTABLE_IO_ERROR;
 			goto done;
+		}
 	}
=20
-	err =3D unlink(lock_file_name.buf);
-	if (err < 0)
+	/*
+	 * We have locked all tables in our range and can thus release the
+	 * "tables.list" lock while compacting the locked tables. This allows
+	 * concurrent updates to the stack to proceed.
+	 */
+	err =3D rollback_lock_file(&tables_list_lock);
+	if (err < 0) {
+		err =3D REFTABLE_IO_ERROR;
 		goto done;
-	have_lock =3D 0;
-
-	err =3D stack_compact_locked(st, first, last, &temp_tab_file_name,
-				   expiry);
-	/* Compaction + tombstones can create an empty table out of non-empty
-	 * tables. */
-	is_empty_table =3D (err =3D=3D REFTABLE_EMPTY_TABLE_ERROR);
-	if (is_empty_table) {
-		err =3D 0;
 	}
-	if (err < 0)
-		goto done;
=20
-	lock_file_fd =3D
-		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0666);
-	if (lock_file_fd < 0) {
-		if (errno =3D=3D EEXIST) {
+	/*
+	 * Compact the now-locked tables into a new table. Note that compacting
+	 * these tables may end up with an empty new table in case tombstones
+	 * end up cancelling out all refs in that range.
+	 */
+	err =3D stack_compact_locked(st, first, last, &new_table_temp_path, expir=
y);
+	if (err < 0) {
+		if (err !=3D REFTABLE_EMPTY_TABLE_ERROR)
+			goto done;
+		is_empty_table =3D 1;
+	}
+
+	/*
+	 * Now that we have written the new, compacted table we need to re-lock
+	 * "tables.list". We'll then replace the compacted range of tables with
+	 * the new table.
+	 */
+	err =3D hold_lock_file_for_update(&tables_list_lock, st->list_file,
+					LOCK_NO_DEREF);
+	if (err < 0) {
+		if (errno =3D=3D EEXIST)
 			err =3D 1;
-		} else {
+		else
 			err =3D REFTABLE_IO_ERROR;
-		}
 		goto done;
 	}
-	have_lock =3D 1;
+
 	if (st->config.default_permissions) {
-		if (chmod(lock_file_name.buf, st->config.default_permissions) < 0) {
+		if (chmod(get_lock_file_path(&tables_list_lock),
+			  st->config.default_permissions) < 0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
 		}
 	}
=20
-	format_name(&new_table_name, st->readers[first]->min_update_index,
-		    st->readers[last]->max_update_index);
-	strbuf_addstr(&new_table_name, ".ref");
-
-	stack_filename(&new_table_path, st, new_table_name.buf);
-
+	/*
+	 * If the resulting compacted table is not empty, then we need to move
+	 * it into place now.
+	 */
 	if (!is_empty_table) {
-		/* retry? */
-		err =3D rename(temp_tab_file_name.buf, new_table_path.buf);
+		format_name(&new_table_name, st->readers[first]->min_update_index,
+			    st->readers[last]->max_update_index);
+		strbuf_addstr(&new_table_name, ".ref");
+		stack_filename(&new_table_path, st, new_table_name.buf);
+
+		err =3D rename(new_table_temp_path.buf, new_table_path.buf);
 		if (err < 0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
 		}
 	}
=20
-	for (i =3D 0; i < first; i++) {
-		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
-		strbuf_addstr(&ref_list_contents, "\n");
-	}
-	if (!is_empty_table) {
-		strbuf_addbuf(&ref_list_contents, &new_table_name);
-		strbuf_addstr(&ref_list_contents, "\n");
-	}
-	for (i =3D last + 1; i < st->merged->stack_len; i++) {
-		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
-		strbuf_addstr(&ref_list_contents, "\n");
-	}
-
-	err =3D write_in_full(lock_file_fd, ref_list_contents.buf, ref_list_conte=
nts.len);
-	if (err < 0) {
-		err =3D REFTABLE_IO_ERROR;
-		unlink(new_table_path.buf);
-		goto done;
-	}
-
-	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
+	/*
+	 * Write the new "tables.list" contents with the compacted table we
+	 * have just written. In case the compacted table became empty we
+	 * simply skip writing it.
+	 */
+	for (i =3D 0; i < first; i++)
+		strbuf_addf(&tables_list_buf, "%s\n", st->readers[i]->name);
+	if (!is_empty_table)
+		strbuf_addf(&tables_list_buf, "%s\n", new_table_name.buf);
+	for (i =3D last + 1; i < st->merged->stack_len; i++)
+		strbuf_addf(&tables_list_buf, "%s\n", st->readers[i]->name);
+
+	err =3D write_in_full(get_lock_file_fd(&tables_list_lock),
+			    tables_list_buf.buf, tables_list_buf.len);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
 		goto done;
 	}
=20
-	err =3D close(lock_file_fd);
-	lock_file_fd =3D -1;
+	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE, get_lock_file_fd(&tabl=
es_list_lock));
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
 		goto done;
 	}
=20
-	err =3D rename(lock_file_name.buf, st->list_file);
+	err =3D commit_lock_file(&tables_list_lock);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
 		goto done;
 	}
-	have_lock =3D 0;
=20
-	/* Reload the stack before deleting. On windows, we can only delete the
-	   files after we closed them.
-	*/
+	/*
+	 * Reload the stack before deleting the compacted tables. We can only
+	 * delete the files after we closed them on Windows, so this needs to
+	 * happen first.
+	 */
 	err =3D reftable_stack_reload_maybe_reuse(st, first < last);
+	if (err < 0)
+		goto done;
=20
-	listp =3D delete_on_success;
-	while (*listp) {
-		if (strcmp(*listp, new_table_path.buf)) {
-			unlink(*listp);
-		}
-		listp++;
+	/*
+	 * Delete the old tables. They may still be in use by concurrent
+	 * readers, so it is expected that unlinking tables may fail.
+	 */
+	for (i =3D first; i <=3D last; i++) {
+		struct lock_file *table_lock =3D &table_locks[i - first];
+		char *table_path =3D get_locked_file_path(table_lock);
+		unlink(table_path);
+		free(table_path);
 	}
=20
 done:
-	free_names(delete_on_success);
+	rollback_lock_file(&tables_list_lock);
+	for (i =3D first; table_locks && i <=3D last; i++)
+		rollback_lock_file(&table_locks[i - first]);
+	reftable_free(table_locks);
=20
-	if (subtable_locks) {
-		listp =3D subtable_locks;
-		while (*listp) {
-			unlink(*listp);
-			listp++;
-		}
-		free_names(subtable_locks);
-	}
-	if (lock_file_fd >=3D 0) {
-		close(lock_file_fd);
-		lock_file_fd =3D -1;
-	}
-	if (have_lock) {
-		unlink(lock_file_name.buf);
-	}
 	strbuf_release(&new_table_name);
 	strbuf_release(&new_table_path);
-	strbuf_release(&ref_list_contents);
-	strbuf_release(&temp_tab_file_name);
-	strbuf_release(&lock_file_name);
+	strbuf_release(&new_table_temp_path);
+	strbuf_release(&tables_list_buf);
+	strbuf_release(&table_name);
 	return err;
 }
=20
diff --git a/reftable/system.h b/reftable/system.h
index 6b74a81514..5d8b6dede5 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -12,7 +12,9 @@ license that can be found in the LICENSE file or at
 /* This header glues the reftable library to the rest of Git */
=20
 #include "git-compat-util.h"
+#include "lockfile.h"
 #include "strbuf.h"
+#include "tempfile.h"
 #include "hash-ll.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
=20
--=20
2.44.0


--OR2o+MUivpQWCKlk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlrD4ACgkQVbJhu7ck
PpRQzxAAg5XZtp92O5LrcA4n0LFFuzqfiOoZyzs8w+Xkb1wl5OIf+1Zdpm/H+vQO
I86CSkjGKS7yE2a70ScTjSgy6hdsyWDf/x3AOprk1oFmIiaSS4t9IzmX0XMEdOnA
ReWWFW0FPFYSm6apULs6nr3HIiNlWtTzOpqi2+2qDJmwyHeTSB3lU2/HZy3EZLqI
oi4MG6ATd8mC6psD8Axdr0LP/RBnvi9d6Y3bGIRXxiGEVIctnEHLJE1OCNcFxewB
Ju1gZpyVigkpaUz5opRkpTWAVtThf+bSbHmYrAntc238TMfPpANWvzFjncivZOaG
LcF9SSyFyAPODXQO9Np61PNdsDWOS5L0E3Z7LnOnthXdZTpIi1WtJ0srrYm8TvWM
UGpzSsfl8Q7DhBg0wJf69KrY0njSLGOKseOg0gF81cJW6jMzpe1qR8AqctJdxShL
Vji36ug5TQEJ6lECcFw7k2of2rNoCsFdXTwAyc+nNAkpwoNyKlfcZ8AKsX/uICeT
/qCQNH40IzurMMhSqVr5FNrvtgnKEEHYqKXtHW47w7aP1CewRi6EIjtVHc/N84r8
nRTd/mmrPjXdFTNLc6OJiqDUbStdR4nnaXFvzR5IgNH87XVgR4AK9xusnnYT6IKx
pxIOSImx3bQIB+KaUbnW0jPMWD6pvEnibK8Sb2CW0l5Ivxhc+gw=
=nmyz
-----END PGP SIGNATURE-----

--OR2o+MUivpQWCKlk--
