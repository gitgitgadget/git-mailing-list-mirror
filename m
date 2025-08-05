Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2827A130
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406725; cv=none; b=UQ/maYR38rmu44o87UQa/fWhb2WDyjp5w8m6HetBnYpZ9wKtZIc453nh4Ym443oYe5fuqruVekYkoZyglwyFpEID8C1VR1HNxlVc3aIOBAqtXhlW9WHru3EpYAedUy/iLpFPh3phZ/5iBE5sXPhtqO1YjfksviYcwa5/fNRXU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406725; c=relaxed/simple;
	bh=xoE04JBSlfrb6poTnNc6Mb32CcosRC81FxULNxgLTII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEwlbQTZRJO/9XxNdVqn8nKDMnbg5WQmPICit9V4AZdxLIKIZdqLWmICxg1bomcu/XrPLkBHkQCswADG9tjW4a3AuDS+0YdmF0VIc7Z3al1lw/s3MqvZFSeGnWgaPYCw6WNZKqLnr1cWM1YTSt9kuOx0iSF2JDAvbrVgExzVFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bJlkkqco; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Py7E7o3E; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bJlkkqco";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Py7E7o3E"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2701DEC018B;
	Tue,  5 Aug 2025 11:12:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 05 Aug 2025 11:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754406723;
	 x=1754493123; bh=iCMzdte/Y1TdVjQahqa2k/AkoJOGEFlfrFmr2AHiY6o=; b=
	bJlkkqcoLCHOhdkmuz7XvaT7FSQCP21lzlFOIE+yhNg+HQ27SmBFukA4d562SzGj
	xivdOA0PJ+uS19z/asg5Wcy26myrCl8L4OUBBC/kciwWVxC8vGpRhZirsYBY2n7/
	bmRvDQcZ9t3QmwoCnTPwUZS6IRSx4A6DsS80jBhDfuA5jqeZT1pHNKanRbWilNHO
	l8gOf6/66/D+XdZWPGd8+93DWPGX/mSg0Ax9iugGSVIFTfd62at5UIhkUUuFf78C
	5Dq3cpkJNdiV7bvSGq7tYuSIHKg3VB3DfYxouK9PO6eEI8VC2PAnl/UusR45GsSI
	uj0bPN7FbOHfN/PqY3zFRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754406723; x=
	1754493123; bh=iCMzdte/Y1TdVjQahqa2k/AkoJOGEFlfrFmr2AHiY6o=; b=P
	y7E7o3ErEPBlfOQPQ7vmJ4K1AXOA+zye5EYvV9BN13kUvjaIRUkJI/s8YAuoiuvj
	Ct7DHIdcVuNFZuUepJSBqdwkiw9JyibSrz8h0P1WrkXNgMRgRxcFAdeQ0be6xiKR
	IOcRixHiMfCDixJ6W8AgJdEc5FKawYPwsJa6XgNOdagj3jdvnbiT27VpyMimS938
	KLd28CM0pnZleeHmkplb4defqVid0Ans5dHjh3h0WUj7W6u9KIWNBEm2F5X/z5rP
	4iXXU3IiwctQ46IEP0nJozmFoLi3wPvhpPeHaL1gnJIyFNlVjQ6ziCJurZvDMdAn
	F1pwMyctWrf7Z3TeZlrgA==
X-ME-Sender: <xms:Qh-SaCgXy1aKf7Q3LuySlVw2XAAN25s88kQnW8Taw6gvOps3YOGDow>
    <xme:Qh-SaP6gRPu4V-1JpByowPFHoakJCTG_NjDe9BIkmcpRX7hLQAZhGTvWuScVUVaMk
    BXawA1LjQzq_xOffQ>
X-ME-Received: <xmr:Qh-SaJ11kWDQOOSRewBdYi36BspDynbTzefSXzTfZIe_s4FxmZ6bN1eIBnu38i46TYIRJVN41_Kj5vsVNyaT2WspOUjqIitvfNIScol1Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:Qx-SaKtR1uHw_A0aQINsC_Y6wAKb1MbcBmzRY_AGMcZZlC2kBTyA-Q>
    <xmx:Qx-SaP4d5lr2d5OCbxqAXU0QC8wOekhrNfkZybmEooeo65xFT-n39g>
    <xmx:Qx-SaGf1GyZ_-NzGtqfEGH_IwweMOCog7bm6-NscCNQhuFfaWnfZ9w>
    <xmx:Qx-SaMztIV2X22HGdUcYWe1kDI4Yo5gNlQMKdC1UfMXtdelkEDqFgQ>
    <xmx:Qx-SaJ1WBIJ67BeUMSkAsqt1hMl47HHooRMmO5dtslYJkI2JOpN3hB7P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:12:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3c1d767 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 15:12:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 05 Aug 2025 17:11:36 +0200
Subject: [PATCH v5 6/9] refs: fix identity for migrated reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-pks-reflog-append-v5-6-050997db09d5@pks.im>
References: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
In-Reply-To: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

When migrating reflog entries between different storage formats we must
reconstruct the identity of reflog entries. This is done by passing the
committer passed to the `migrate_one_reflog_entry()` callback function
to `fmt_ident()`.

This results in an invalid identity though: `fmt_ident()` expects the
caller to provide both name and mail of the author, but we pass the full
identity as mail. This leads to an identity like:

    pks <Patrick Steinhardt ps@pks.im>

Fix the bug by splitting the identity line first. This allows us to
extract both the name and mail so that we can pass them to `fmt_ident()`
separately.

This commit does not yet add any tests as there is another bug in the
reflog migration that will be fixed in a subsequent commit. Once that
bug is fixed we'll make the reflog verification in t1450 stricter, and
that will catch both this bug here and the other bug.

Note that we also add two new `name` and `mail` string buffers to the
callback structures and splice them through to the callbacks. This is
done so that we can avoid allocating a new buffer every time we compute
the committer information.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8aa9f7236a..a5f9ffaa45 100644
--- a/refs.c
+++ b/refs.c
@@ -2954,7 +2954,7 @@ struct migration_data {
 	struct ref_store *old_refs;
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
-	struct strbuf sb;
+	struct strbuf sb, name, mail;
 };
 
 static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
@@ -2993,7 +2993,7 @@ struct reflog_migration_data {
 	struct ref_store *old_refs;
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
-	struct strbuf *sb;
+	struct strbuf *sb, *name, *mail;
 };
 
 static int migrate_one_reflog_entry(struct object_id *old_oid,
@@ -3003,13 +3003,21 @@ static int migrate_one_reflog_entry(struct object_id *old_oid,
 				    const char *msg, void *cb_data)
 {
 	struct reflog_migration_data *data = cb_data;
+	struct ident_split ident;
 	const char *date;
 	int ret;
 
+	if (split_ident_line(&ident, committer, strlen(committer)) < 0)
+		return -1;
+
+	strbuf_reset(data->name);
+	strbuf_add(data->name, ident.name_begin, ident.name_end - ident.name_begin);
+	strbuf_reset(data->mail);
+	strbuf_add(data->mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
+
 	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
 	strbuf_reset(data->sb);
-	/* committer contains name and email */
-	strbuf_addstr(data->sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
+	strbuf_addstr(data->sb, fmt_ident(data->name->buf, data->mail->buf, WANT_BLANK_IDENT, date, 0));
 
 	ret = ref_transaction_update_reflog(data->transaction, data->refname,
 					    new_oid, old_oid, data->sb->buf,
@@ -3026,6 +3034,8 @@ static int migrate_one_reflog(const char *refname, void *cb_data)
 		.transaction = migration_data->transaction,
 		.errbuf = migration_data->errbuf,
 		.sb = &migration_data->sb,
+		.name = &migration_data->name,
+		.mail = &migration_data->mail,
 	};
 
 	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
@@ -3124,6 +3134,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	struct strbuf new_gitdir = STRBUF_INIT;
 	struct migration_data data = {
 		.sb = STRBUF_INIT,
+		.name = STRBUF_INIT,
+		.mail = STRBUF_INIT,
 	};
 	int did_migrate_refs = 0;
 	int ret;
@@ -3299,6 +3311,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	ref_transaction_free(transaction);
 	strbuf_release(&new_gitdir);
 	strbuf_release(&data.sb);
+	strbuf_release(&data.name);
+	strbuf_release(&data.mail);
 	return ret;
 }
 

-- 
2.50.1.723.g3e08bea96f.dirty

