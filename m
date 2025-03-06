Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB2518EFDE
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273727; cv=none; b=O8mudzFDXoyvw4+nJijTxHM6NVb39nT9g3iaVh5jY1mNtZ4NUA12KbUbXWl0k1wnQiOXD+9K0apN0sJ9IMnaLrp1ZdLpSr6r/moZatkq7zKrJeKfIu1ihxlf5FnPVcGxL3oYdfdZ6bRtxrGRXTpvbvbycW7Eqyd/MbYNerR6Wws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273727; c=relaxed/simple;
	bh=5adQ0qQct2pehqMypYo1bjERL/f3sDcV8S82/y6nHcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGALKYkbHkOm0mw94wNJNi3lVgtmOP9zJykA0OyepiphuoFSqLGgjhnDuzOuaW9YxfVKAfI7pvwwLONORdKsLEa1iqCW2ZU44z7aAUKgYCKqt2xJaGHob57apa97c1YR+JBTF8NiH6tPPvgV4XDfoXqvW6F6RZFGqdmoIya6N34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QYrGd3i0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXXmZ2F1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QYrGd3i0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXXmZ2F1"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6ED3C11400C9;
	Thu,  6 Mar 2025 10:08:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Mar 2025 10:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273724;
	 x=1741360124; bh=jzPMSpng1BPHpC2pMuJy197lByckBPxGahRwFokrSCY=; b=
	QYrGd3i0zqMkYALkopv8YCpFggzw33e5vjVC/rD6iJcpjtorYcVVce1zYt+wHhHR
	kLOFiaW767Q/fv88efTiseHD8bET1dyCkUk4OCU5i+2IyXj6XDRQVwx9a2qA3gqM
	NrIvETAwUgw+lGYYR160eOvPQLTgbZp/YjGaMzds5lUoceHwOcDTuf6eQ5OnD00t
	T/wJh6pnGZhCAKyluCkrJXbdKcJNeBD/2LTChGX1qsUTuHRzswCErzJjISAt342k
	GaO6qOPUcV8ghokJemNbW5RUYUnNXYgtl9pfrfO2moaZQV5HRs9aLyvpJ9twKnA3
	nJUrzwy+Nk/bHnuBHONbPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273724; x=
	1741360124; bh=jzPMSpng1BPHpC2pMuJy197lByckBPxGahRwFokrSCY=; b=S
	XXmZ2F1WxAQdpYJXsIiznCmEMGKlPW+6CijILQXhFBiWeVmZKNTaGs7DmkOpSzmv
	AIls/nuZQgmJ69SIgVsAZ6+DIU4aejEWgav52K+NsiArGz10DFb7R9I/u8Wii3qh
	C0O950d5n74hps5FsFP3XdLZvEInXVpxBQGdh1pFJizWp4wLWZleXr+bDSijBzg9
	VqdP8hNCGeIIfNaD0cPsHJXoaScbUbqk14lTtxG40pP79aJ6yhFeNKH+YH7jVboF
	qC1LaPV5QJpzKZVb971IQV+bJCV2Jrivp37bmlxOkiCT8kVAgjHfaUBf6Kex+ExM
	cjHsDC92BU0B3B7tIkRpg==
X-ME-Sender: <xms:fLrJZ-T7_H0AH_NfBoe0GNNWPEszo9d8NfaZpS8XiXiCbC4oHuN4zg>
    <xme:fLrJZzw0LCUm0oFV600EnKTeqURhNslk9neFFDXvydXBNlnfZjXgTUK-2qzsEfuAG
    kZrOkc9NKjWFZOvlA>
X-ME-Received: <xmr:fLrJZ719cLHX8ytnsrwahcejO54e2po_vBwYvlGIcq2x0610UsGmZTBmZ4cJeavdCGf_l5Ot-Sir55-kHYPokmyuYNiBn7d7WSMb9cWO55N0dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fLrJZ6DD_LIFonFqRQFAOvDQMjNutuUzt8tQjoBLTVKPc3zGuxKTxQ>
    <xmx:fLrJZ3jPJKF2AV-6hDilRsrGw2PCQvtntTFtPSspO4buA7cNBNS3lg>
    <xmx:fLrJZ2rCmILDcjWWglr2rMroKJg7-zpXxXWg9v9ClmiU3arcLaqFfQ>
    <xmx:fLrJZ6iUC3JP9UeINiaq51QUUIs_q1ARTCbsoGbgHLll8TkbnYaXuQ>
    <xmx:fLrJZ3hFO-YDPSM_QWXYMDzYK8JKuwCrC2cNcsL93dLSUF6aEIP-fvEc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bcb13bde (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:32 +0100
Subject: [PATCH v5 01/16] object-name: introduce
 `repo_get_oid_with_flags()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-1-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Introduce a new function `repo_get_oid_with_flags()`. This function
behaves the same as `repo_get_oid()`, except that it takes an extra
`flags` parameter that it ends up passing to `get_oid_with_context()`.

This function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 14 ++++++++------
 object-name.h |  6 ++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 945d5bdef25..233f3f861e3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1794,18 +1794,20 @@ void object_context_release(struct object_context *ctx)
 	strbuf_release(&ctx->symlink_path);
 }
 
-/*
- * This is like "get_oid_basic()", except it allows "object ID expressions",
- * notably "xyz^" for "parent of xyz"
- */
-int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
+int repo_get_oid_with_flags(struct repository *r, const char *name,
+			    struct object_id *oid, unsigned flags)
 {
 	struct object_context unused;
-	int ret = get_oid_with_context(r, name, 0, oid, &unused);
+	int ret = get_oid_with_context(r, name, flags, oid, &unused);
 	object_context_release(&unused);
 	return ret;
 }
 
+int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
+{
+	return repo_get_oid_with_flags(r, name, oid, 0);
+}
+
 /*
  * This returns a non-zero value if the string (built using printf
  * format and the given arguments) is not a valid object.
diff --git a/object-name.h b/object-name.h
index 8dba4a47a47..cda4934cd5f 100644
--- a/object-name.h
+++ b/object-name.h
@@ -51,6 +51,12 @@ void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 			      int abbrev_len);
 
+/*
+ * This is like "get_oid_basic()", except it allows "object ID expressions",
+ * notably "xyz^" for "parent of xyz". Accepts GET_OID_* flags.
+ */
+int repo_get_oid_with_flags(struct repository *r, const char *str,
+			    struct object_id *oid, unsigned flags);
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
 __attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);

-- 
2.49.0.rc0.416.g627208d89d.dirty

