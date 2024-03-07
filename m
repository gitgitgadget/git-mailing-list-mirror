Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1CB12BEAE
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817046; cv=none; b=Qvu0bIHNMJ3bMo1jaT/0HPjd2es3+1zz1kdZO+IcpmO6qqNYx2j9VRXF3mXb/9ZusTBKijuma2K/l1TdxGAcUdX1r5Y6gdhEH0ReuEluQ2UOyMrQ5ZXaJHbbRRDWJhZOG2BnbSgsJiT2Yzkd4d21eo75OSzQIrEnRLsHDE8f8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817046; c=relaxed/simple;
	bh=+elcvgt1GeMAyqFDIF9om3loTuUZD2Nwg7ULgJcKf6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDhbqWtZPN1E+SL1G72Uyo7xibi5a6kF6ZxTtSrptpQF53ighye/bt+4g/r8rg7pSXssyqebazrfVYJemLZkKlHhDRqTPxDhGfECuuT7DOL/zXpIpOZQeYC1ES+AjJlL3APdsHOZePMNS3NeMjiLnN1THCimIG4FUxu/g/CcYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WvVFzP/W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+Oj5eI0; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WvVFzP/W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+Oj5eI0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2326218000B9;
	Thu,  7 Mar 2024 08:10:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Mar 2024 08:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709817042; x=1709903442; bh=mcI3x3x7WG
	voNU2KWZ0fIac93P4h8FFt/3JNcq+c9sM=; b=WvVFzP/W/uDR2qRsRrzKQ5yv71
	VpZoKP/2dccL9T5ZyBwNmr37eWRT5YoacjJPPuuPYOLA0vioWJ31fcTJhDi3UF0L
	z+GAvB8P0DfGUeHXWOKW/D+6zovGwaTTqwbBWOrBxS2J4KwxHfG3LPSWBw1xpIXk
	K4BMPjaC98Xo0EPqzIUERDBusZtHbJI1p8LMFwIe8xo/akt5Fqm/G/L2EY3zJM+5
	eIoEJm2qQsh4qKIRhiMQqrGd3xVLPwIfylosNxMeIe0ejvCo8glCy3KulVoqAluT
	03U5uc2uFl2BEh3bVYp/HnV8iorR3eNijW/gsnifsQ+egcciAlpbQwx6QBCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709817042; x=1709903442; bh=mcI3x3x7WGvoNU2KWZ0fIac93P4h
	8FFt/3JNcq+c9sM=; b=U+Oj5eI0mf72zwhFx2Ug4FJCJzkn2CNM8DyjSCxM4TWj
	T8DuHXQG8vrEtt9wmpJ45taP956Zx4pC55dF1s2YfdUX6/JhTXnz8zw5bhN+j8mp
	iSlQtzWx3C8l1ZvAdcGAoitCbFj5hUO3WFq0wsOs02BqpZ44D9Zfvb7ZGd7YX3s3
	pcmQjld6YPkag37WtzsnFpsPRn3gu9Gj4mhingsbQrvgXaj2b4r0e6rHAjqRqrls
	8P/CirX03jFZn+9jUO71ka7SmzCr4K+B9iuG1Kli7xpR+NDKt5lZDf+V8NmAEApL
	fh/yiDKv8Qjxd9tDIhJ+uTtefhXHZU4aq/YhxvdAuA==
X-ME-Sender: <xms:0rzpZeslPU809PfTES6nAwRjGvDc2C2byHquI43BG3obMH1Fyp8Zkw>
    <xme:0rzpZTdjtLOqIPA_8RWe2U4ZdRSpahlh6JTJXYOHbye7H694c7vT4jBZmRR52eo7P
    IbAMfAPIomreONA0g>
X-ME-Received: <xmr:0rzpZZwABrUliWS1ytOSrLLcjF41pekSNZTk6OFUOAl021ELvbsPIRmq1aqhn2N4HHtOxzGVQLZ69aa06CRmGzd7X9azKUvDXTil0yWkHnxFUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:0rzpZZPWzZSuCfT6DBKdx-xPYgucD_RXdbFj0lAAORUBGV9r5uoxQw>
    <xmx:0rzpZe8yNNDzsv851GlY7R1jRF6vRZG9dGWwTpukmspv1Z-uts4duA>
    <xmx:0rzpZRUGN0PtdaMkS9917NjpAebYUmI36LCD-Hd3aCs-ANgt5fHq8A>
    <xmx:0rzpZSZNx6B-VQ9Bwz5iNiRvkd0pQvkvQXUKVNiOvnJMr3orXSUUnm4eA-4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 08:10:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b17900ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 13:06:10 +0000 (UTC)
Date: Thu, 7 Mar 2024 14:10:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] reftable/stack: register lockfiles during compaction
Message-ID: <c88c85443e8aeb299327402572c08bcac7d3f13a.1709816483.git.ps@pks.im>
References: <cover.1709549619.git.ps@pks.im>
 <cover.1709816483.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+O1/WQTjFFBiw94H"
Content-Disposition: inline
In-Reply-To: <cover.1709816483.git.ps@pks.im>


--+O1/WQTjFFBiw94H
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


--+O1/WQTjFFBiw94H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpvM4ACgkQVbJhu7ck
PpQXMxAAiZhw7LeUwrFwlV0pCx7RzHdW3jNhHvknZUxD8mK7YLCEHmxVkvvw0sJ3
onEVa7BPJxJxuvQc9D6J+xy0/wKh3za2gaQB6W3Fyn5NLP7bFYguUecdmtCVXBTm
HU7Ai99P6mvkt7U7XNf3bBOPqEYpiR/AN9/BeVnkf2TZZFTxuZPE2SdWMqR0dfrq
PudfQehRhNOV08TmO2USoE82SQmePvZ4BdbyaikXPiuZORZAhn5LLcgfrFQ8CUJQ
iT27u2RsomzJcWytVOrzFF5CsOBZYxNFcJYU8qViX2hITFw+SdBz6qUL2NbLc0SK
orK+HpIqfFRrPyzLoIGDfJW66AmgYxzjripi6YS4nrpeMcqIgohBE3SAcvBG6jVK
iesmmrm63S/m6UT6cjltGBTyIUap/M7IZT7ZDLa2pqq+G2evyNd1rI2TVfY+AzNy
o5lGK1DZYAm19mnXx7j3Zb7wTYo/+JnwitaJnxyatvKxS7BgjNIpSMBJUdSUXR73
SI6i3/DT3gwwxIietgiGpGoohQI6Ts/2r0VhosgfnlcXmrJOxf5xjsO9uUWf2naD
eShku+6UqDQ915RLhjseSFrMwbmfjmUeLf46aGsL8tJ0yKSxYmnw0WhS5gW0GqC9
B9FdsLtiG4CbDq/1TMrFXhoSqiGPIp8R7Wpg9hG5+JHt3NzLrPo=
=uAV6
-----END PGP SIGNATURE-----

--+O1/WQTjFFBiw94H--
