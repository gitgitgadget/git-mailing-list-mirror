Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131CC266580
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708146; cv=none; b=Kll7TkH3SqqC1RK1O/vAYFTpuyCIyrZeAuatfqhlbC4T7m5Ua1D0O35iKh2pkQt2tyOtZDUXxb4fwgbmrgSRWqMPfYqRT6JlFOBY6KVYHz5bxbw+JPkkrHzyTbjaOVzglcmTPeQUnqliXsg5hbBEw6RfJx+uPVdGe0VyQMPruik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708146; c=relaxed/simple;
	bh=40L/KHtlsqy05SsN6FBss4TFl3MFZHSxnn/Hb9QjSE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H02OO8vjVrovFGmCerDWSLogX0enpsN1IT+X/O5sXqJnwfDv0FMsZmRhHUMG8uLs/SMMQBvlh4v1DSJDpoKRUGV5/uBbEB82P3XXH026H/4+vDGduabnInCYBTcWnFteNmO2maHr5gJYZWySRCyGxXssdlgpxzIIyOMZpvYnO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g0ouvi4u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=awCsizKY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g0ouvi4u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="awCsizKY"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 431D2140009C;
	Mon, 28 Jul 2025 09:09:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 28 Jul 2025 09:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753708143;
	 x=1753794543; bh=eURae8TESk0r2SgR/GhhXUylLiSwBDPaYIiTdWlGSaM=; b=
	g0ouvi4uCIgSlKQ1k115ckznoCxhmaWIOVdUGEmGaWBUmyrmvE3ok7fgCCGPDyvm
	YYEvhuQCd7oNTlUapc2w12uL0fDj4NJxGI5uUrx7UFJlNghFut7ZOpUXxTtrjwYa
	S1s6Yj4Lo9+v+mMtO9Rl8PbMYfdVggnT5/apqvIyE+o5AaYOEnMf2orlaeJBDinT
	gO64dUDeb2AbCKWjsn4goMZUam+3IqkDP5ttNNOKqgJ9JqMpI/7eucGvCGGbuIGe
	OkhYpxttRRVwEXbKXREWtuE8JA4Yvug0XHLbsldpe3OdgJPvcYtkr6biXdn1PJDy
	pIzS+6doyiH6iAeQ1Q9ICg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753708143; x=
	1753794543; bh=eURae8TESk0r2SgR/GhhXUylLiSwBDPaYIiTdWlGSaM=; b=a
	wCsizKYzrbrSS5j62GWkL5U+h2ZEVx+uU/BCNlS9s+ao4AvWJafH6lThpu/GuNW6
	eiUIQYSwAIKWbZgtezwZTOudlfOLEyKQn4WiCY67MJpoByAG9w7i0uVTMjcyBiN6
	nn3YrltgO1RaFnO01ki5eZ16IR0OGQEOHd5HaddmqraCdKNno4swgluDd+Bx3ok1
	S3cipq83/VBrjJ9HLs5Pa4YvpEt2Edf177llwxlkzRFRYRHanxQsV3IDoig7/1rG
	rtszqVQGqK6GGDO8zyBf9e74XHhqJ+s+doeGgyQOoCzHAByLOLCmljiCiHuP+sJC
	fLd0xE197X50pbDMKDLeg==
X-ME-Sender: <xms:b3aHaO-2Zp4dz6Gd2EMLHzVt4Q3sftoelPnWHvbdlS--xow1YUzNHQ>
    <xme:b3aHaJSrVA5ZnVFy4ZroEltOrj8ufWXdBdIw5xZikE72Pjo8TF-P_NUOCUythXMDJ
    R76Od_r1M32sYLozw>
X-ME-Received: <xmr:b3aHaAkUxIkT7XW0EscIgOKA5IuCl36ahbmCwZ1T7GG5d3HdrLeqAMx4GwOAO4A2zgyPOrK5nXCfzoXVT6ZZs200ukvrY2gnw-joZmzR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:b3aHaJTTCcZlNkAFqR6BK5JJbhm_FXoV7VFXOwHaBfiateic7Imtag>
    <xmx:b3aHaONbTNluo6kjUWp448Tf0x0_GS8_XA5voduQqXdaosCs2FYHaA>
    <xmx:b3aHaCUlQDftHCE8zjaNEMumJFKdaajTkV7FZJYL6vtqP9V4y9hnLQ>
    <xmx:b3aHaFf195aGLnV7V5E_AMaJ4R_WX2xxfG0IYojQoMpHsEwyHniIig>
    <xmx:b3aHaAv7WgfNJESZk4Ap4E1yA1_PIpAeKWIJxGg_jJWkYUBTgZT0hDgG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 09:09:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0095d493 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Jul 2025 13:09:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Jul 2025 15:08:46 +0200
Subject: [PATCH 2/4] refs: simplify logic when migrating reflog entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-pks-remote-rename-improvements-v1-2-f654f2b5c5ae@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>
X-Mailer: b4 0.14.2

When migrating reflog entries between two storage formats we have to do
so via two callback-driven functions:

  - `migrate_one_reflog()` gets invoked via `refs_for_each_reflog()` to
    first list all available reflogs.

  - `migrate_one_reflog_entry()` gets invoked via
    `refs_for_each_reflog_ent()` in `migrate_one_reflog()`.

Before the preceding commit we didn't have the refname available in
`migrate_one_reflog_entry()`, which made it necessary to have a separate
structure that we pass to the second callback so that we can propagate
the refname. Now that `refs_for_each_reflog_ent()` knows to pass the
refname to the callback though that indirection isn't necessary anymore.

There's one catch though: we do have an update index that is also stored
in the entry-specific callback data. This update index is required so
that we can tell the ref backend in which order it should persist the
reflog entries to disk.

But that purpose can be trivially achieved by just converting it into a
global counter that is used for all reflog entries, regardless of which
reference they are for. The ordering will remain the same as both the
update index and the refname is considered when sorting the entries.

Move the index into `struct migration_data` and drop the now-unused
`struct reflog_migration_data` to simplify the code a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index fd9a5f36b20..b820c3908bd 100644
--- a/refs.c
+++ b/refs.c
@@ -2942,6 +2942,7 @@ struct migration_data {
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
 	struct strbuf sb, name, mail;
+	uint64_t index;
 };
 
 static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
@@ -2974,14 +2975,6 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
 	return ret;
 }
 
-struct reflog_migration_data {
-	uint64_t index;
-	struct ref_store *old_refs;
-	struct ref_transaction *transaction;
-	struct strbuf *errbuf;
-	struct strbuf *sb, *name, *mail;
-};
-
 static int migrate_one_reflog_entry(const char *refname,
 				    struct object_id *old_oid,
 				    struct object_id *new_oid,
@@ -2989,7 +2982,7 @@ static int migrate_one_reflog_entry(const char *refname,
 				    timestamp_t timestamp, int tz,
 				    const char *msg, void *cb_data)
 {
-	struct reflog_migration_data *data = cb_data;
+	struct migration_data *data = cb_data;
 	struct ident_split ident;
 	const char *date;
 	int ret;
@@ -2997,17 +2990,17 @@ static int migrate_one_reflog_entry(const char *refname,
 	if (split_ident_line(&ident, committer, strlen(committer)) < 0)
 		return -1;
 
-	strbuf_reset(data->name);
-	strbuf_add(data->name, ident.name_begin, ident.name_end - ident.name_begin);
-	strbuf_reset(data->mail);
-	strbuf_add(data->mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
+	strbuf_reset(&data->name);
+	strbuf_add(&data->name, ident.name_begin, ident.name_end - ident.name_begin);
+	strbuf_reset(&data->mail);
+	strbuf_add(&data->mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
 
 	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
-	strbuf_reset(data->sb);
-	strbuf_addstr(data->sb, fmt_ident(data->name->buf, data->mail->buf, WANT_BLANK_IDENT, date, 0));
+	strbuf_reset(&data->sb);
+	strbuf_addstr(&data->sb, fmt_ident(data->name.buf, data->mail.buf, WANT_BLANK_IDENT, date, 0));
 
 	ret = ref_transaction_update_reflog(data->transaction, refname,
-					    new_oid, old_oid, data->sb->buf,
+					    new_oid, old_oid, data->sb.buf,
 					    msg, data->index++, data->errbuf);
 	return ret;
 }
@@ -3015,17 +3008,8 @@ static int migrate_one_reflog_entry(const char *refname,
 static int migrate_one_reflog(const char *refname, void *cb_data)
 {
 	struct migration_data *migration_data = cb_data;
-	struct reflog_migration_data data = {
-		.old_refs = migration_data->old_refs,
-		.transaction = migration_data->transaction,
-		.errbuf = migration_data->errbuf,
-		.sb = &migration_data->sb,
-		.name = &migration_data->name,
-		.mail = &migration_data->mail,
-	};
-
 	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
-					migrate_one_reflog_entry, &data);
+					migrate_one_reflog_entry, migration_data);
 }
 
 static int move_files(const char *from_path, const char *to_path, struct strbuf *errbuf)

-- 
2.50.1.565.gc32cd1483b.dirty

