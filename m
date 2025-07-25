Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769328A72F
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426732; cv=none; b=ZwP+6VoUHq9I7x6jPO8LHY6N2dOw6rMoPdlAdqTVnE1kxcIj2LdCQyYHWMj5XXwWWxeCjKAasToo3L4YPIJvDkS5rarK5eUjh+VPNHQf/XtLtDW1WyqK2vTvJ3r8W6UvdSzWiOgiiJ2AcxLDQ/wW5umGKSPQfuZrRm3iGbH/Q4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426732; c=relaxed/simple;
	bh=dn4KdCOORsxLxGqlSeOjyHexgXwz0BO0lHyrolaXWj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQ7K7Z6hG5YcKTqhr1i15elqs3MQfeH3uZynSxtGMNG3ut5dHxia8SdjTEeQa4YSZCwzFmCO6ywIXDA2/tsCS8s99mNx8iCKZjqVP5XRjDa284aiPPZtrirNy9hAcpOK5DSGWqt1mgc9K39AFe45hYbWn38finTs8BJAkQkqd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=opfPw2Fi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ERi45Ww1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="opfPw2Fi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ERi45Ww1"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DBE52EC01D7;
	Fri, 25 Jul 2025 02:58:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 25 Jul 2025 02:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753426729;
	 x=1753513129; bh=gWMqIKyOulfN6Zxp0KSba9OR0OZIe3hSTZN77cLH+Gc=; b=
	opfPw2FiQ2RpmxF1X06nmZynbDGYM+C4s4rRiuEh5JDxHrOGl9peE0sUtBw9Mt+s
	MZdi/n6wQnJmr2oDTMqRq6TNt2YAn/aNzqa1c8/uAspmcn1SsaSnw05tEj5aRkT3
	oCzvcGAqtGPGG7lQe8/vqHj3wkKTbLYf6YEcXuBG5Z8H8oug/N9UanLHqzDaevot
	F/BW5lJdyRwKJsU9NCgR9eUr0FAXQKvuPgFWnC1sgml1nZ2yc2BixZwwayqZ30xV
	xf6r4qnuaRn1Es3Hb1Hs901xLGa6t9IvoHaxBx/+KEFuddKtt08V+bMoKXsMss2s
	8GYWgTjC9HlNIY4Jq+x/dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753426729; x=
	1753513129; bh=gWMqIKyOulfN6Zxp0KSba9OR0OZIe3hSTZN77cLH+Gc=; b=E
	Ri45Ww1ShidUzAOkWkYHNE/7u1QH+8JstQTZdD+8ahUjyo9pJNgVgyaWbft0KQ4U
	/kHRpLoEBT8+cQNKOVv7lQ+x7HpLk7fBxj600Mbt4x9DcWOeaODKZGFuS4rIZwsm
	gG0XPhzH1c8MDHx2JIB3reZmea/8UC5U27DUbnOF0bBZbI8FR8TG/vHU3RU/WkuE
	/0OIVi0fPvEsgBFOpYJ01exOvLtDTTiDksqiD/lAKw5fafX/1uMgxXcFs82vV8iq
	2b0lCW3jPVQXiyXbtLTovw0RBG5wFoSwQ0NvRU9jJpHhcT188q4UiRGrca/9V1ro
	rmdTvrQBiEfpgEjDJn/DQ==
X-ME-Sender: <xms:KSuDaLa4b5v6NiZ1pbzDTZx3rSUfb7g8DGmaE-784aNYspxcZLnlzg>
    <xme:KSuDaC2EEPMGHkYaVaYGCWUjw2Gf_ifOQT8OxP0FArh0ortQpgCBZZ4M4DCcWRn33
    yzvxpxb7quyR-rFhQ>
X-ME-Received: <xmr:KSuDaOYkMhhdouywWpMkLaQQgrsA1-ez6IIfi4mktmT3yXNgAT3fZVLx1H7DE4XTwAGAymWIrd8Dnr3Y-TkNCXUEaTwQr6eSXtOC0EvSZuUf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrh
    druggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KSuDaCIp_jjMuS3eaI6Otn1T6niTKLQV9NFbnV4njmVvyNWYb1844Q>
    <xmx:KSuDaFEutJNBSE9InZyZb2kF_1oiI3CrjaC_u5cPCtu0_9G8Wgeamg>
    <xmx:KSuDaBv1CMTLGgoRc3GZy2TsAtdFseXYRRrYFNVLjwQmyX7rHtJDCg>
    <xmx:KSuDaMuiuOFgK5jV1GdyN1RxxX4QdEac6qfzFbRZiuye1yU1XxNBig>
    <xmx:KSuDaL52yNUq-m-wzMfX_WaLBCLtBGu0dprpq3i_AR0t3OeacnQvUhxi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 02:58:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d902e8e1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 06:58:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Jul 2025 08:58:28 +0200
Subject: [PATCH v2 6/8] refs: fix identity for migrated reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-pks-reflog-append-v2-6-e4e7cbe3f578@pks.im>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
In-Reply-To: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>
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
index 8aa9f7236a3..a5f9ffaa45d 100644
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
2.50.1.565.gc32cd1483b.dirty

