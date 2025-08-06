Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FE820469E
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459674; cv=none; b=U7pG/xMX3WthM1DITkTBArOqSDg+JPNayqWU0AefBb0bcPXjOf9Th3bduQpJAghT9s0oEaMxCOti2zAXvoKfSrCC2UpJI3fISZFlwwLWgMNcG5mRIKmI8nJHObEeg84OVvLA3GDX+tsUriHip3CkTnZ23JZqKh6uCERMRTCGtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459674; c=relaxed/simple;
	bh=JpVgQD8umDzUAncaB7l73TUpGXgJePOBiVvBdc7fLVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSMijIDOaJ41q992arcQrYQq3nr1szSZpZF6UjwU3trnVPweifN9zlN0Dr7F3Hwoht9pNOjZW6A+CoJNb3cuMTBMkzhh+4aYrjuo//ZzHX7o1aSwNc0A3TLTxes1lI3bUPeTgS5lL2fDgP4/UkDRe1Tv94m2Mz1HEjzrp8XWbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e7Nnyj0H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJ4WbRVd; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e7Nnyj0H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJ4WbRVd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F346C1D00151;
	Wed,  6 Aug 2025 01:54:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 06 Aug 2025 01:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754459671;
	 x=1754546071; bh=kSrRPmH3zCh4eDmQgjVs/axNoFGZQ525q5oGuWjrHJo=; b=
	e7Nnyj0HrgoTlfzv9/D4HyHO76/+atvJP7qrzr0FQ6fj11EE+3++5WEKuOIQzM42
	d78eu73YXZ1Ds3hl8t8O9uFnioLWrRgISs07/+GO7jUIbNSprgr0o/BbZN+CCIId
	8u2U3rzw/esj1IyFJoyFT6l4QzXUUhiXDxYVpMDy9LhOo8U7KoJzbrtlMcGc+1iV
	PIrWq68feEPp+LXXXw2AEzhkSxNQPRco+gotnbsYgNVqBvsQutAiKrSjGn7/Ob/c
	koIzWyCEv0toT3qq64AJvbC6ufcquuHAX0C0edf8o8GFaJI0+bY98LG1z5AE7l1f
	va9lV8pja41uan5SnlNZvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754459671; x=
	1754546071; bh=kSrRPmH3zCh4eDmQgjVs/axNoFGZQ525q5oGuWjrHJo=; b=f
	J4WbRVdlBAwvnoYiMsFRhUYgngBW3gDSoW47RHgbEVtg6PM/rvjGmeUdA2BBlFn4
	sYlRmfIuzYPuCAuIn4oa/X+ALPIXgkDZhq+wgADQGzQ/x1l0I3o+zp8nCK7hFIwM
	92o/FR6NBfLNyGCGD3hAZ0o3H7g39rBbTxpidCABbLqrGq8OaUFt2fgcYBNm2r0F
	Z34sxkxbMjdaskqPRfS9f3yNOpDnBVh11I5nkjW83Z0CHjrBw2thfkUHNpjFjeOL
	Mt4gX89io8t7d1z1TkSYs6hUEMXSWqMsUbgG1ORClPi9mCZxFSpvqd4CvFuzzuwz
	/HiZtwL2Ks6VV8+mQ4/ag==
X-ME-Sender: <xms:F-6SaLHyugCRMKOzVwbS7ShWtaWS4bSz0Ng-tJ28qBcHni9jf69jHg>
    <xme:F-6SaECUdvIgW9zwfcff8oIxuhx0WSvDOf0Ylvp8cXyFXHISgRPZlOdJGHmzjJ9r6
    nGggEvKHopptzWwNg>
X-ME-Received: <xmr:F-6SaJmgIyEd96b2CxJYnxx981IveiWWCKw-HsDsHKVZRIchbEaVzIgHcb4WcoRl9X7Y3rBrX4XrD-lKZ5om1qFNoPU0DjxbjdGAyjFsFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhf
    rhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:F-6SaCOvnjUThs2Ze294K4Oatqm1HTQtFFf5vc6hLYZhHnwV3W_icg>
    <xmx:F-6SaG97MA3WD2bAj6uB2Kxubi0HIB2Dlh8_-sV5zQUF1zw9X55hkQ>
    <xmx:F-6SaEGxnswcsT53uTALtvoeuWEiJwpxeBaLJRr9Lbw_sYkbIk4gRA>
    <xmx:F-6SaFjvLzvLH8xHpkOJ2d3IGNSRsCuxkF8dJFQQz0qBGcxTTeaINA>
    <xmx:F-6SaIzR8C5K2NxfNlx_doQKCySkZvqM_tWTOZgY-HNSqP39mkMCUE8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:54:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54e748b9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 05:54:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 07:54:14 +0200
Subject: [PATCH v6 3/9] refs: export `ref_transaction_update_reflog()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-pks-reflog-append-v6-3-a50839653766@pks.im>
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
2.51.0.rc0.215.g125493bb4a.dirty

