Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B691AC88B
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973829; cv=none; b=kQK7sJwvnQ64wJpCFjO0PS0Q3OXLVGW+ePxA73QyouuS+O8hkOOroSDS8xe+hVC+O+1HbbsHABrPkC391DKZu4HMZAwz6wMamKBWUmSFoOytn6+ter4a1a93HDjY9qWpfYgC8dTrJoYpUOxMfbBd8TrDORcKlt7U8oNcTDhJwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973829; c=relaxed/simple;
	bh=pJF++1kX/Dxlx7Ic57akibkGnjyKluwJVDvht2aBH/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPjbRvIar3CKac7sOG0G8FK+eylnI3S4c/2DiswfxF9ai3C6L2udpSR0G/IwbyR9BrpoYJyhhP6Qf3/x4wSaEehfFKAwE2mlLN9N743kelPa1+TzrCmh5vke4lFyqvpp8HJ/GZ8t6cKyi5dFK3GU7eNH24YFb/bjp3UDlgyXgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RFD62/St; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTUqfhQY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RFD62/St";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTUqfhQY"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2360A14002E4;
	Thu, 31 Jul 2025 10:57:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 31 Jul 2025 10:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753973826;
	 x=1754060226; bh=r24VkGC4AT6naxFZ29ExOMnTCe7Pa42s8f5NcH63XeI=; b=
	RFD62/StaK2IGBAczUkXhqgBSnC4K5d5IQyAfY/ACqq2PyE7rEfqjNho5yW/LUyi
	50gt/9/QHBDwAMM9/UHwU9+Cro5QSYNBB19Sa9LOndzo+C65RjDWUrsicHPDHaZt
	OJOFj8+Io2AK5Uxtp/tWRiMk9nBpHq6q5R26rNjXx+yootXJXn+eTU7gPyVuxJmi
	wVM1p8CuhREiRlVasGORcULrCKogZzLQOZFAfeL1jWb+/kmT1aZqm19pdqog7oZD
	ffLrda654d7l1nURZA/cOC9n1R2xzQvCTpQM4xCbD9dritggP8ZnDTkMmpmUsSO/
	G30XDxr5NGTPSY9UsXQUvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753973826; x=
	1754060226; bh=r24VkGC4AT6naxFZ29ExOMnTCe7Pa42s8f5NcH63XeI=; b=j
	TUqfhQYB0om9Zd3tMF1aF64Eh7nBE2d499FNc4NYkf79nJz+sD5qgF9ew1EBxtD+
	AXA4ubb+evLnA7MESV+tatQDMiw3Xj0HPObqMfKUuoQ1KtKu1MHnMci3g0zRQF0V
	73ha3ptaMmdqEdHel7k1g+uJHa9txJtdsDf30SFYr8q0OLbqHtx9clxXI6xCBzge
	JhJM2qFqMTGLfng67tMGwtu3mKSy3RgSAV6Hh5BwBXA1LJm7B7OTGN1sTrDTHm1Y
	9/kQt/+nl7vWRoYEbcjheitKzO/ZQp8nlb8Ptve3HSLv3OOOMlvGV0jvuV++Vlhp
	Xzu6TjFa7AVaXrC4PEUoQ==
X-ME-Sender: <xms:QYSLaL7CZx8y7_KYfJR179XTXy_xboTVu0DFBsJRz4chIQyw300hjg>
    <xme:QYSLaJX5DyxUBMhGlCUj3r8rygpnc2Kzyhs8JXahfgK-0WwnTYYIW3rDpC9WtvksC
    Nx6DeUpdKQ2hoWyPQ>
X-ME-Received: <xmr:QYSLaC6SUkwrkYBbE-XOCyybKaqQZg62QutbHTvCC4Xj3Xi1_Bt0IiMcn1667Ia3GdwC3LfR0FQG3h5TjwVUWzajfU_j6lYMcpVqXpI9oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhhtggrrh
    hltdekudegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QYSLaMpgW7uDvol8W5DvcvY0y66tiMDWGr7A8Y-W0t6ako4oZJP7HQ>
    <xmx:QYSLaNnQRdSCUtW3d-zHkUvcV9tP4ckW7Nkrh_Y2-hQ5R8vR3ZWZcA>
    <xmx:QYSLaANZcd9VhcaJIO9l8Z6Q6XfhUvq0oIVKaonQkhJr8sXcKi-Xmg>
    <xmx:QYSLaJOczaC-bz5f3II9PCWFhs1TzgLg3wSB0rSNev5HCHZbQMGv9A>
    <xmx:QoSLaIVH4inKskbxObJHk3BOfO2ADBcSf6XQ4zGiF-22i77GIW7Q_wPH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 10:57:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6a1b830 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 14:57:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 31 Jul 2025 16:56:50 +0200
Subject: [PATCH v2 2/6] refs: simplify logic when migrating reflog entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-pks-remote-rename-improvements-v2-2-dda6f083674d@pks.im>
References: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
In-Reply-To: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
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
index 6ed0cd6ddc..04c9ace793 100644
--- a/refs.c
+++ b/refs.c
@@ -2941,6 +2941,7 @@ struct migration_data {
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
 	struct strbuf sb, name, mail;
+	uint64_t index;
 };
 
 static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
@@ -2973,14 +2974,6 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
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
@@ -2988,7 +2981,7 @@ static int migrate_one_reflog_entry(const char *refname,
 				    timestamp_t timestamp, int tz,
 				    const char *msg, void *cb_data)
 {
-	struct reflog_migration_data *data = cb_data;
+	struct migration_data *data = cb_data;
 	struct ident_split ident;
 	const char *date;
 	int ret;
@@ -2996,17 +2989,17 @@ static int migrate_one_reflog_entry(const char *refname,
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
@@ -3014,17 +3007,8 @@ static int migrate_one_reflog_entry(const char *refname,
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
2.50.1.619.g074bbf1d35.dirty

