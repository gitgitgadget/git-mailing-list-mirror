Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A88279903
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406717; cv=none; b=mF+gG+FdqvFuGUX1uWiZboCv6qX6rJJEL6h7qXqBlTX4BILtX9+gKZFJ1nK7/lXQj5AQvZfWZ+T5HhnUYfpToOGV0GmCuvqyzjpfZPP2fODsJl7U3TcZGWTTcYJ2Pyo8lT2Moo4Wz8Ct/RmDhVOHS9XYHw2RK4dZ5hDIeelIucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406717; c=relaxed/simple;
	bh=bBL7lzZHA03TaonPOqm0Ud0vhHF9cvXRn6i3VYwHeWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELyMlNBVIcXWCcgDdM6GDlPX7czvaGmYTUjYqSdsd9ZgBaLolXf8iXzqU6qiHpnXoDi4jLn6qEg5ZaxMN9Sj5vHkEEGkYWp3Ury1PIm76n5tn9RXIKTbUNPxewuRQ9VPZ7HT8y8iBh12Sh+PeI6nK1q628vfJJFk6GQFyP+r0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BudQyNYr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lk9Dx8m5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BudQyNYr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lk9Dx8m5"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C044F140014B;
	Tue,  5 Aug 2025 11:11:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 05 Aug 2025 11:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754406714;
	 x=1754493114; bh=iVjEpcd4liAqcJjXvLA23M74fFWXeAoAheuzsVvvBCs=; b=
	BudQyNYrzC6kCvsx+H+v+PmAuWVJqEZuo6HHO3lUsj2KZh12GPu7W5ogDwXY4Skx
	25nFOTQtOZAu3NdvhNpsKiPjSp8a5syjvlFKTNQDGi7eO4CgVEl8TteKGpAH+Ni5
	VUdlF/8hesxyUFRcIk6jA4F1yWhakbd6zYr+A7wPzERX0OQrF2gLpQrLb/PWlIBm
	jsXyZBnpoAPu+aOrB9ZjXNNG8/IA+C00e2GLJciSIriRv0ng9u+gezPzawsWpxQD
	sEpb/yMYkQFQgMJNWKFppsuOMdP1zPBWbZT0QPYgVYBGagV0e8IGaQVowcsDO+iJ
	Wzyy4xtOTdcn0pG0u2JBEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754406714; x=
	1754493114; bh=iVjEpcd4liAqcJjXvLA23M74fFWXeAoAheuzsVvvBCs=; b=l
	k9Dx8m5957k4v6+vaaxjP0DWyEYWDzmtSvfKgb6mnCGc3UTwdQbuDbRe5ViBba1j
	IGOIMdL2Y+Zs2RLujdfYCVGEv7su5oqq5YtZb3pWCjnWUpdhhSxZNGf4pmBOfh05
	zaAVE5bwCScw+WAGq6TYT1rpKtPLxcQ517RDVg4QoLsjZWC3CUmNRkSvwuR0RHez
	OOu9G3GHu9+sJz0qjOxmnva9m4Bo7sz1EJNUOQ+fLQksS9exGk2mqPo8XuVBHsYW
	I0kQeLDdH31cyMPKOE+QIMJ1s64ioIlqiOsTmHWew/OmYMpDBXsgJv7Ba5ozzFVP
	IG+GblpUR3ga0Ey2U2FlA==
X-ME-Sender: <xms:Oh-SaLJwQZO9wx4_6SLZYUDds_c4Z-t6EbvPaAW1QRCwT4ahIyN3TQ>
    <xme:Oh-SaMC8UkWPukt2ns-oUK1ulAgKTcdsa9YSv3U_E7oLdIktC_orPzovDmXIzDa-6
    -V5QK4lr1gq7rQKqw>
X-ME-Received: <xmr:Oh-SaDeTW2gXkJZ-QgnIswYhZGGAn5vk8CJyApRU_29vn_I38Cqorl7pf_scMOSo_GiuIJGaw24Fd5KNHBWY8oeoDNmodqZPm1FbW9k5Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Oh-SaD1IdZ-psKcmlKASqsk8ApvfnBYUMu0lXt4_Jd2gS1ZH-NwCOw>
    <xmx:Oh-SaChGtNNVzN5qPd7pZB0K0ioNcipjWjoOrJ3-tv0I6uAJsxJygQ>
    <xmx:Oh-SaEnLsEA17hYSQc-mlHervPovt5FyfwcCvbUtJcAXYlpTyuYMcg>
    <xmx:Oh-SaAYLAo_kX0AzKXQrY6vuf6JQQHnbAAXNvwl3RhuU0ih8osMOHg>
    <xmx:Oh-SaG_Af1SGRGNR4sppMoXyxG9OYqnjBCD-G_TsJnGrANz3BVt4sQhj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:11:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73298511 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 15:11:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 05 Aug 2025 17:11:33 +0200
Subject: [PATCH v5 3/9] refs: export `ref_transaction_update_reflog()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-pks-reflog-append-v5-3-050997db09d5@pks.im>
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

