Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4B281525
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779350; cv=none; b=Ureo0I7XVpeoBEp5gpmGk9USf5FxI4aS13motRUUTZ9p/XEAFwCyADCewzOh2huytLn6gsdF7ekgaSCFm/peyBOzUHC+L++exkPOfn//QOn/e5K5K/u93suiRaI6wg3N620i//UUFCPSvPAaBlgPq+GCM4UPlsjjmmiw1YUTRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779350; c=relaxed/simple;
	bh=RKLvHwhxsPPdkR7Iw81lho4xZvaYjVULOQSlB9gLQO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eDeNr/IAA9DU5d5eVMeNFuLm7Rp6Q4CzdA0Oy4uUbKT/xyPt9pn0/Ry3LSrEXBE9x9eB/Ot1vCwk5wSkS68O5E7mBaOKDcpPti2l7/WxpxIcOjlJIvLs3Ka4GE5t6+bdQLMw2VgOpzN1RJARq2Xairlx3i2GSoPvFrZo2oCBYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=imxOrOsv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvD2SB/+; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="imxOrOsv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvD2SB/+"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C1CB1D0054A;
	Tue, 29 Jul 2025 04:55:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 29 Jul 2025 04:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753779347;
	 x=1753865747; bh=W1HK+QH72Rxd+gzsYvF+YhofiQpJT/ohmKPRqCbyoTw=; b=
	imxOrOsvhJU5iOfj69PVmsYxqUadFQUqwCUVBSJcaI+ytFXy1LMMMYCIxTdi9VlU
	MxrsXXW1xeC2XI1uOJWyRq8Wk3ixnJJoApL+m3cBAOv7XQx4mY7bUgizhp8jZvjf
	9DG/IibjC106Lq17G2eBC/F+03UZkVKssr3RjkvGtEbqwNgEBOck3dA4pgZ8UTdF
	lMHrTtVOCdA+bYX3T2Ao49bWoU/b6spyQ+z7RlQOoUvT3vzMP8dTlTofQ62kgS8O
	S3dimpvInZ32kcLFnenHS4gvkmUkKdqE2EpHqgEXgsEERSksow2cJWpy6OqrOzTo
	lEyG0P+R/QdR3sYB14lZYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753779347; x=
	1753865747; bh=W1HK+QH72Rxd+gzsYvF+YhofiQpJT/ohmKPRqCbyoTw=; b=c
	vD2SB/+Ldly+qTTLIUgrd+/wIgyBpqD8a1RfiIIrjppfMcquvWDeKuf15z6f+2Wt
	qsLgj7QoptCSdcvV0iJcC2aBxCQ5HkVQTq58uGUn+Nq2AZeidP7MEwl1DG2rJJrQ
	Lpd7vG/mhIVqQRSKC+WVoulQDFq76jXy9uae+Ki7inAf3QXOeiGBMJleTx5QBsVm
	wGGpNSdEDwSHGUBCZZS3zKmaIy1g7aE8pp9auElU3nSiNpOQTT6qtEGYiRCCSX41
	9JileZeBL1jKeF2bg3KBN1vN4PIQXmY4PMF3jxB6CwouoS3J6pY2nPqVUe+aiwiz
	39sgSVu655TmlQxCuCZng==
X-ME-Sender: <xms:k4yIaI-j7Ro0Jf3XmhKK9oRUmu7zS_kV41WjMddOPnevfPyTQFVEwQ>
    <xme:k4yIaFrTgc81Pg9DbQ5bBEV2pCUxxZd8jifjaO7ex83IB513IATr1YlK4M6qzGqhA
    SYF5ejbhQ6fE1x5aA>
X-ME-Received: <xmr:k4yIaCQJomKlTGACjcsddHXz8h0a0YI7WO8up1uoQ6vvj7CAbcOZTbD5UsBlccidLyIrRamaBvrdJffKBS2UCyqWvgZg8Mo4ovS51mtz-b0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:k4yIaIPyBUqRIFZVoC36bjTThon_LtPISyDazDDtFbuJbp7P8iRWCA>
    <xmx:k4yIaAjwNNCBTos9D9EraGib-vSKvwHRliVBuFUwmbDRaupwcA93zw>
    <xmx:k4yIaFlKXeUjNR777FLywQhoOqLGNo32Fe5-soxC7bQPlkN2EXuEpQ>
    <xmx:k4yIaMjWNqWP3Re3yIhPfh5LNAsCdGv0o7TzyGiiRYXBCB1gL_8HmQ>
    <xmx:k4yIaKQRPlTwdq3fYovNvsWLMASnkgvz1CsEUUiEi3P6qSaxLCfL5AA->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:55:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a7d24dd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:55:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 10:55:24 +0200
Subject: [PATCH v3 6/9] refs: fix identity for migrated reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-pks-reflog-append-v3-6-9614d310f073@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
In-Reply-To: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
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
2.50.1.619.g074bbf1d35.dirty

