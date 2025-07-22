Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E72E424A
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183285; cv=none; b=M8O+VDHLA3kthaPjJAsz10HVo27Ld2WzUfvBAiDj8Ovif9qR7h+iKKqXHtiP8IABK6WrxF9Tt6TNmkMJUb5Ly5ang9+VhgKk/srsOD1Y2yeXukzkePCl9ThVJJLdTgSLdJDCYGTmYtsOZSnXaY7HSxFlyEkMMefy0rCR4I2AjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183285; c=relaxed/simple;
	bh=Qyr1l8PG4WOg8bUgqaqZGb3fbd472cB2IZpvm5s6ozA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkVnIS/RnVLoU1jy2jiwOh5roSzH+jhaaTLE6KLWoEMPad4Zgh+qoKL++lHZmbX4+s78G0wO+CtZBibnm7xlUmcATqpC1A26Y2oNDvyBbpBMEM1DhP5uIriG/G6ViNeb4k+/mduiO1BWkMLJu9/vdlh1+EANjTfk+9fEEiJUoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ckhgwafg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J5eAKbYZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ckhgwafg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5eAKbYZ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 88E0D1D0020E;
	Tue, 22 Jul 2025 07:21:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 22 Jul 2025 07:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753183282;
	 x=1753269682; bh=+rU55NvWbGYwSxVJie9ndIhFnBxj9iCT7ulRjK6VQTw=; b=
	ckhgwafgdyamuXX1c92rARNGtaBmj5Zi1Fkqo5q7UT15AzP/acUQll4D4mPb0D9g
	z2S98tCWHxQ0mxW1CRXxtC/HUa8ZDkwUieKKAFdI9mFacExRAEvBhDJOQpXVV4LO
	Pnf6Jybr/ef9I6dguSXO4dROk0+CXMrBnwuaYcUGkKoEYy7Y6swhylbqBjAwJ440
	00eMixEWXFflrDsJXb9iy5o3jYqKsGu7EQjpP9NnhcLIvaxBn6E9ZlQXlJlVYpy5
	AJQU69m5Sqgv88lmVCAxFGf58VvogndCG4euvhkWOx6+/ia9SnvK49377zy19w9q
	6VWvGXkc87obI4BkxbSxJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753183282; x=
	1753269682; bh=+rU55NvWbGYwSxVJie9ndIhFnBxj9iCT7ulRjK6VQTw=; b=J
	5eAKbYZfTp/Q9I2DHO/m3WomFuEGitfqgAIeb2tMwO2kp3KkE/MjOylMX/8TWouc
	eWQk3JsIWREJMPgbBWWK/bI/Z9g8WpjqeMcU1XjVVCrKG77e25GMSjypa/Kaq7sx
	lcnV82QY4XBvUr+hoeZXfU8ke8cSW7Kd5/r0AfdFzRp3/8/s1libIvnXm/OlKiOR
	b+KRxjFn3SY8dPoKnYHYNTrMuKA3ralydPgULxbM9dsQp60M2xe4kAvhzvRpXwO6
	RGeFBME3CzslpkYip/pU+ifzgXLFBeACrPe3TwoKO5sLrMhLVaZLHnNLMu7j2uhL
	dS2cd5JLh0000yFX3zDkw==
X-ME-Sender: <xms:MnR_aJmUTf7KKpSBnJ06BAbBcfFe1wazD55_Om2tFwmuPBToYzEFFQ>
    <xme:MnR_aFCx3tncEEjiQEyd3kgqTujSUnjt1ORFd2V1SVlNjqvKI2jx_RGpb1cRrNgfo
    QXU86RkR9ENN9ZSow>
X-ME-Received: <xmr:MnR_aBeoudTTuc6ZXR0OEnkwA-4UTVBHjwTxP080ZHuYoL2b6xicSGrbJw6OLCiQHVEwZOCs_tWiwgzpeNzCsX3avOdGF2t2XfaGszaHWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MnR_aIK5CzGph8X9O2ooskCHKU3tFkFCYFPljh2RxJJbBsDBpqUG4w>
    <xmx:MnR_aMezGMgfsJ8UqJlsmI2xRZ3bf7XEfkWYLfbekjX2MflOSoRuAg>
    <xmx:MnR_aH0IEo3tvMhuhAORXJ1r95fZG6eZ7DOaVLy9LAudXZkzP_802Q>
    <xmx:MnR_aNjiWy_KSmNyGftfqKDjoYbjOrvoOn7Rgb1K_HgCEt-HaNempA>
    <xmx:MnR_aP0CpApIph7n290KhDAsAg4tjMdDfPYrd5M9QvBx8_IGtaGAuH3K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 07:21:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a0973c5b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 11:21:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Jul 2025 13:20:55 +0200
Subject: [PATCH 6/8] refs: fix identity for migrated reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-pks-reflog-append-v1-6-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 188989e4113..64544300dc3 100644
--- a/refs.c
+++ b/refs.c
@@ -2945,7 +2945,7 @@ struct migration_data {
 	struct ref_store *old_refs;
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
-	struct strbuf sb;
+	struct strbuf sb, name, mail;
 };
 
 static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
@@ -2984,7 +2984,7 @@ struct reflog_migration_data {
 	struct ref_store *old_refs;
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
-	struct strbuf *sb;
+	struct strbuf *sb, *name, *mail;
 };
 
 static int migrate_one_reflog_entry(struct object_id *old_oid,
@@ -2994,13 +2994,22 @@ static int migrate_one_reflog_entry(struct object_id *old_oid,
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
 	/* committer contains name and email */
-	strbuf_addstr(data->sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
+	strbuf_addstr(data->sb, fmt_ident(data->name->buf, data->mail->buf, WANT_BLANK_IDENT, date, 0));
 
 	ret = ref_transaction_update_reflog(data->transaction, data->refname,
 					    new_oid, old_oid, data->sb->buf,
@@ -3017,6 +3026,8 @@ static int migrate_one_reflog(const char *refname, void *cb_data)
 		.transaction = migration_data->transaction,
 		.errbuf = migration_data->errbuf,
 		.sb = &migration_data->sb,
+		.name = &migration_data->name,
+		.mail = &migration_data->mail,
 	};
 
 	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
@@ -3115,6 +3126,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	struct strbuf new_gitdir = STRBUF_INIT;
 	struct migration_data data = {
 		.sb = STRBUF_INIT,
+		.name = STRBUF_INIT,
+		.mail = STRBUF_INIT,
 	};
 	int did_migrate_refs = 0;
 	int ret;
@@ -3290,6 +3303,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	ref_transaction_free(transaction);
 	strbuf_release(&new_gitdir);
 	strbuf_release(&data.sb);
+	strbuf_release(&data.name);
+	strbuf_release(&data.mail);
 	return ret;
 }
 

-- 
2.50.1.465.gcb3da1c9e6.dirty

