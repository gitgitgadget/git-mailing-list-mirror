Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542A241668
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300793; cv=none; b=o3Yg/5j9/Iau4dBPNHexkS22zx8YPjjTKOflHxk4kqCzksk3nQaO0uVf8jU5x2MrQ3+d6d7SJzRjVIojxPc2PPeL8EXosh9MsEjulC6Q1+GEIYGSQwwMU1KTbwKpMoDJPL2kre9K1gNBAU3JIw71XM2HrX9izdLRcCQ4NLb/F/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300793; c=relaxed/simple;
	bh=xoE04JBSlfrb6poTnNc6Mb32CcosRC81FxULNxgLTII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWHI6wZt4Odxz6VuRGrvohRJsVn00yZuHfdPIWJKzozVkHgCBVfeZaRMAc2/7P8fTHgYdjQtgNOp7V50W03s/pUW+gCZu9zV4io1d3g292m29UaW1VaoOtvlVbvxpWaWLQOa2yWKb9Jbt3SWSVxcDC2LrHPn3m0G/uHZoo6PqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cMUZ9Un/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gobpicKh; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cMUZ9Un/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gobpicKh"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1AE4D7A00CB;
	Mon,  4 Aug 2025 05:46:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 04 Aug 2025 05:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300790;
	 x=1754387190; bh=iCMzdte/Y1TdVjQahqa2k/AkoJOGEFlfrFmr2AHiY6o=; b=
	cMUZ9Un/c2WPAGqIIVXFnS8iKa4cvrkInu6sful8jX1IMGcMQcd1lwmWy4c6DfsQ
	zwKdE6uMhYFItvdyhYJoMSmFCqT+cYBGSqz5c+jHNw+KDGmD7SYSIWRHCObx9UYK
	mq5e5ac21FZF4gBolVXlifPN19PfSPK/fPepWsClRGwnv3Cm6msNlmvoPGoroGOv
	Wv0JfLENdE2eT26zcnxKPU/9SSgd1XLruV010wUhiPo2ZYlFx0uSxj7StvbJD5Z8
	ByM66sGNhgqY3q75ElnUga0NdHmMkHuacGHnhik3RH8CQnJ033FIQyw8VsiSi/Lw
	k2GIVaiWEycYeizgfck4tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300790; x=
	1754387190; bh=iCMzdte/Y1TdVjQahqa2k/AkoJOGEFlfrFmr2AHiY6o=; b=g
	obpicKh43TZ3X3g+lXCXTmKZkUzP8qreZp63Tu5XLNOsKLjZJKeXP62wsi7GQSE5
	fesdPP5MEBoPYif0IzSUdFS1QOTKYh6Zq5SA/jug32Y43nkun/cAJJ8XAFc21Y2B
	YaFYQgYoCnhnJez6QaB7EJx38MbvdBA4h5ohF7eGZoUpP6TyTdpJxifqyqc+gJu/
	ZLPZ8Ro4zWeZ5hU6I0mRLFeHwBzH/Nlvc5lpw2+O+og/O3vrhHigHy2ZFAduH6Ax
	m1yYcg2X3xM8sFTzBb2at+QPkWT7yQZmsXEUdHFTLXbaEnRg9O4AsvDZFWySo+Xv
	OuRl+nnsFdSQ6nzRdsIaw==
X-ME-Sender: <xms:doGQaK00XEXohnre9UQ_tEtun6-YTRVyVUVnV5Im1r_X448AzmGrPA>
    <xme:doGQaJ-wL3x_yrY9U9mIsOHwyLZvbFS1LQ-bYsuQtyVxCY0gj5W4EkNBprYqMMeUE
    waL_YdvG7BdKxAbMg>
X-ME-Received: <xmr:doGQaCrDHXv0Zcle0G6FzAWM8j7UVmeasG0YGnWUaewValuzBi-cG_h6Xqcjp41x7xOI3x-x6HHDetK0nWaRPcXxZxH35PU1m_qemmd-vNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:doGQaLQEPAFn__lQvksQq51-1VUrgh0-MX1GbU3n1VIovTbV5Y1M0w>
    <xmx:doGQaNNuWfKqleez5ZUHXbJw5tctrRZ_7Vc9aNRmjFqj9UIli9Dl-g>
    <xmx:doGQaBi-MHcuUsOK5UOkqwfaQNdA5TDPs8wRTf9aT4br74kQa6EScg>
    <xmx:doGQaClndhA-fdILU7bfpb9spt6-IYEZBesi4l72gsNnzjCk-eLeSA>
    <xmx:doGQaEYbaEvdgtg4ztvhTkntu6IoJdCZFwL8bPkHiGLDk26-A1X-PBfR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a645171 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:46:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:46:06 +0200
Subject: [PATCH v4 6/9] refs: fix identity for migrated reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reflog-append-v4-6-13213fef7200@pks.im>
References: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
In-Reply-To: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
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

