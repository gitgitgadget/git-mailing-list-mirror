Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21F246BBB
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300783; cv=none; b=eawdIt7l9AQIGlAFdUmvOgBMELowmHANcmkpHkYQMIfBRwyd780xWI0je0np36SV3AdfstVmLnOm5gOWb1Z5PAVpabITtV+/4XlhChtmSK9qyTCQAeifnlUpcmwggBrGV+KV5sL5ynuLZP/aHA356TXYiLlqdsWrJHQ65QX2zoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300783; c=relaxed/simple;
	bh=bBL7lzZHA03TaonPOqm0Ud0vhHF9cvXRn6i3VYwHeWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAyqX5OCrDIDnk6GLuy8mJ3yAEs4ENOK2y8GhPibdL1VTUI3vK2ZDD1FhqCWqxiIfI0CMO1B6Pgc703vtpRjTElFubTTqMMSjLkQKTLTu3lTwV94TE9sa3huc/Yx5wVrAeoRdOq9i+DgyHLcA5OLBSabelbsR4/7ZaQRcWkwhu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D45g0J6C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIoOgosb; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D45g0J6C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIoOgosb"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D178E7A00D3;
	Mon,  4 Aug 2025 05:46:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 04 Aug 2025 05:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300780;
	 x=1754387180; bh=iVjEpcd4liAqcJjXvLA23M74fFWXeAoAheuzsVvvBCs=; b=
	D45g0J6CrNt5c4LmB+eZDnWL4O7Vd2PBgsH9tbp3LfI9tHBDkXWg4WWKUHtUS5hJ
	XH5qahmi4Hq83D/71RZUDV/cu3ZN7W8qZ8Z+g4u4QCR/fAHzB6pWQvqGxfpM4COW
	CZMAaqg/8ShvcdJoUlysXJnrxHC+WVS81YmBdz2zJFxVIR54A+gbxKDFmmnpY89N
	fvdzeFO15s41UTA41qofZotsuf68pm/qpa8hSaJ+DZC6RXdbXRJDSSq8p6YyxwSo
	jPSZZgyKdPAZANZub0P8XFt2N6PuaSAVg3GoWrJANl1VzC0HGvQnow4dZO7vT+a8
	rrT+fDkkVh++cybXwp9rwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300780; x=
	1754387180; bh=iVjEpcd4liAqcJjXvLA23M74fFWXeAoAheuzsVvvBCs=; b=k
	IoOgosbpa+Sbw0z0Hn5foKw61RTqIt74H8K7eBo2qSG8LJxHyevNJLXVDFOFv1YS
	aw+EphMw1f2HddwezWBaYl3iaI5vneVoa2dr50Q65kaqmV3MRjB/o7iaajQ5uLwF
	+gWWuh2asYAJLOdRTAnadI4ZXnVdrrwlsNEyb98Kinb8ILnCFXhwefX9TJ61s+57
	Q+APXC0ZG6g2/dmJYxr4rRDfQ5DT4FxLnGXzAuWCi0DRLA2jU6lk+CfLER0HDVtM
	ihZcm+mVZADFY4zpOe4pGTxiixl4dNbmwMSzgtQzqHHGIs/vq9cwyWFfOSomTWuE
	5IRXfPZtcflc0bwSWhcog==
X-ME-Sender: <xms:bIGQaE957jmvYbW733Q0Y7TQ4M_wd6tTQpuZxeCtSLk0cQGz9JEnxA>
    <xme:bIGQaJl1eMnNS9glpYYORzPd2_wrzBQUZtv3EDd5pQA7j6hqjDACHQPLuOr2z1CUI
    rmyqKnwBYZKqT8Lng>
X-ME-Received: <xmr:bIGQaJw9iibXiJh8hpXzgQ4v7xIt_SjKndMngBJiW7au1DBePE8Lxi3rNLiyHqaVOljVgBSI5jrd2s1BNPmJmnbVljy72iAtOfaJmt5UWCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:bIGQaD6ThjEk1FYhQLCM7N0Aghi3_sT6OpKPIF1Qj7bwzhYlQu1OzA>
    <xmx:bIGQaJUbYJEJIpkJ9GGNVKV_UkFqZxAUKVHh38r4nKcGJzOF-EdRKw>
    <xmx:bIGQaLKYFqsGK1dWNGT39EUhxC_91Op5c39s4sgi1nfqZOhv23z5kw>
    <xmx:bIGQaLvWsr3WA9K_HccUba3yCGYOfe8n1ILi3wH-Jn3yHF-093zR9g>
    <xmx:bIGQaBC4j-WcoM_lQE36_SV_LDhN07r6znB4C_QHcxFm3AzxWbS0lgLu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 238e6f70 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:46:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:46:03 +0200
Subject: [PATCH v4 3/9] refs: export `ref_transaction_update_reflog()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reflog-append-v4-3-13213fef7200@pks.im>
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

In a subsequent commit we'll add another user that wants to write reflog
entries. This requires them to call `ref_transaction_update_reflog()`,
but that function is local to "refs.c".

Export the function to prepare for the change. While at it, drop the
`flags` field, as all callers are for now expected to use the same flags
anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 29 +++++++++++------------------
 refs.h | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index dce5c49ca2..8aa9f7236a 100644
--- a/refs.c
+++ b/refs.c
@@ -1371,27 +1371,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-/*
- * Similar to`ref_transaction_update`, but this function is only for adding
- * a reflog update. Supports providing custom committer information. The index
- * field can be utiltized to order updates as desired. When not used, the
- * updates default to being ordered by refname.
- */
-static int ref_transaction_update_reflog(struct ref_transaction *transaction,
-					 const char *refname,
-					 const struct object_id *new_oid,
-					 const struct object_id *old_oid,
-					 const char *committer_info,
-					 unsigned int flags,
-					 const char *msg,
-					 uint64_t index,
-					 struct strbuf *err)
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info,
+				  const char *msg,
+				  uint64_t index,
+				  struct strbuf *err)
 {
 	struct ref_update *update;
+	unsigned int flags;
 
 	assert(err);
 
-	flags |= REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
+	flags = REF_HAVE_OLD | REF_HAVE_NEW | REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
 
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
 		return -1;
@@ -3019,8 +3013,7 @@ static int migrate_one_reflog_entry(struct object_id *old_oid,
 
 	ret = ref_transaction_update_reflog(data->transaction, data->refname,
 					    new_oid, old_oid, data->sb->buf,
-					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
-					    data->index++, data->errbuf);
+					    msg, data->index++, data->errbuf);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 46a6008e07..253dd8f4d5 100644
--- a/refs.h
+++ b/refs.h
@@ -795,6 +795,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
+/*
+ * Similar to `ref_transaction_update`, but this function is only for adding
+ * a reflog update. Supports providing custom committer information. The index
+ * field can be utiltized to order updates as desired. When set to zero, the
+ * updates default to being ordered by refname.
+ */
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info,
+				  const char *msg,
+				  uint64_t index,
+				  struct strbuf *err);
+
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be

-- 
2.50.1.723.g3e08bea96f.dirty

