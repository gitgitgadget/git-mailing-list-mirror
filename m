Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734CC20ADEE
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459685; cv=none; b=JZe1yDlUyTJVICyEonoWPRw3kFBqvPU0G5S6SJfVDRQfHhokYcbGR4d8NWtHMkM3i5iQVmqdpWQaxILYA7ThskQuhaYq4mTvSfXZb0ijSjpHUNsGWe2zl2tw9j50eaowIxZb3qW5i0ovZLWfUsnSHy5+Edsn6QuXTVeNEKSgWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459685; c=relaxed/simple;
	bh=5kGw0eRJeOcTFJSZmTWFYRE1R9Eo0RanIZjLmuo3i7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCDzR3CqIicSoqT4X6W/A7BhtPA6vHhWz9V0SZJTo9HnnU0QoT6Da8qG4lPKOSpj/bOuXpC2npgUzHq9VcnEWWDWvucclkdzRydgii/6haktaUBHlawx417+GvOfVzcX0p8QzmAbUUd7NrG92LQ6J/pYeqx/9/fkLWeCf+A0Jlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S4xuE1dX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dVNWIiPh; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S4xuE1dX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dVNWIiPh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A1B281D00161;
	Wed,  6 Aug 2025 01:54:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 06 Aug 2025 01:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754459682;
	 x=1754546082; bh=80VQXVeiaMUn0RisxK3+0RGBQ5qPj7Qi8fx4J6R95wo=; b=
	S4xuE1dXdA5+EQkXN8DwGZ+sAKYDVX6XWvMoF9dI+c5jv3OS6qIdrISdgqtPivS7
	H0CBxHj0k7uraHq8qXWoTXBKvbz1gxNr7vsWnNW+Zwv0JvptwRvY6wdSV0n+sFF8
	bFYZVkIOQLp+B8LidFjSy3G80YU0H97qu9Ot9BUwE+YjCLTno0/GI9fh/S/h4y8J
	J9tuW1uaIwPPbAvI+80WI7inzPv/n4f1QTHzqQ6qGCpwUU3dvp2OAco6+gkam99J
	CejyltL517+R8eGGsy0OnVw0XofDnumQiQMbBwPp1JLX95X6zg3Lbtzi09R/Dg6W
	1muiti2RgZsxwk/Qob5wuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754459682; x=
	1754546082; bh=80VQXVeiaMUn0RisxK3+0RGBQ5qPj7Qi8fx4J6R95wo=; b=d
	VNWIiPh5enZ3MA79xSMnX+zyuvcBRUcvJF/lCXOSEBKaH8PD/CkMcs0GwwC287J2
	oWycsgkMhG8Q2qSXrsg6c9FFH+XFjrwv0pjhVv7MdAV7Xc8ymnEyHycoxRmH3zXk
	bT3UrrfL+yzoT3oCowoH5ugm3z7cplRu81E9gnkppex4pOCZysV0VtJjMADFYmOP
	i49BsJ7XvCpK1Wg3bbwfMk5KBJ6uCx76/RhfjsEK1MIfeEps7o+DMlJyhw8cFtOH
	g69o5aTiFgPoUYRRKs7pepssyL25JqTW2pG1ZQjcpId5oop1lMJoYYz1W9/NOo+x
	9U0qfKIlTCd10pHS7hgmg==
X-ME-Sender: <xms:Iu6SaHgsc3kwvmMTKb-1ajWNTZAcLg_a3kKdrVNUCQwQi6LK6TEaNg>
    <xme:Iu6SaPv3Q7KWlocgM701sfKmae8HBfGuIFtsUW8bQfnc3TIhN3WIdlgBBMnAtPVgT
    Enf4pVDrqnycycKJA>
X-ME-Received: <xmr:Iu6SaDgZlW0-ox1zde7P7zZh5ZfwW8pBJub5oBb8C5Kg7i82ux2Oz8tcNwetwpviBBaovXpAnPHpoAZ6lVH00mgxIxzhaxmhAFtrKIPM-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Iu6SaNbk4cgOx7-OUE-BN6VBRvkeaSaFHPIBF2QgZnC2W8jobQr_xw>
    <xmx:Iu6SaKYqEd7EzSGR50qjhJwWntodn8mhjZgIp5bRf38iRvEngVODhw>
    <xmx:Iu6SaKy1aNJ2F3HF4aUodlzqMephF-SUITPTRjX9aF_-fAGwIkptlA>
    <xmx:Iu6SaOfyzw7AhMoCZuxa7WOTy0QsIv9hFntSVpiR1MDzDTRhjJA-rw>
    <xmx:Iu6SaHOTf3rc9POOK0OmKihKC8uSgvmOuhM7nqw-GfufcqQhoVpOCc7M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:54:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76d42a2d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 05:54:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 07:54:17 +0200
Subject: [PATCH v6 6/9] refs: fix identity for migrated reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-pks-reflog-append-v6-6-a50839653766@pks.im>
References: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
In-Reply-To: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
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
2.51.0.rc0.215.g125493bb4a.dirty

