Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4932857C9
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779341; cv=none; b=m1HHAwnf7EUaCVmd8/p1KcorzC1r0T0/zxGXLs9CnTkJl30l/4VUiGqHgw2VKuO1BcWbE9lVIzZAFgoRD2Wsf5ZtxmldwyAm7a+JCsrV4SotFtdU7XwVq+X0v26yitCLVFmcHQXyv/9MJ0qOB+oow6g7G2dsxOqHzh9qovVLY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779341; c=relaxed/simple;
	bh=NPkcVkZ/EQBCiDrCP+UnAs5yShQnmTAhpnBxzY3rtn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U0VqR0RwVHLk53+TawcxeSP3x4cFkyBQLY1mAZtqq+cUdmaHSHsyg+MDK0fWDGzKWgdDNfVwwpMzGuj7qVVb/CYj3PFs16RQE973yaIkS0JhNP6TWdeToMc1mqEkh5ABoCpt8FkdX3g6kdK5j8N6gEBTOHu51AGcYRXXi8qf5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZpgOm97A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDPDeWEb; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZpgOm97A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDPDeWEb"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 369307A03AA;
	Tue, 29 Jul 2025 04:55:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 29 Jul 2025 04:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753779337;
	 x=1753865737; bh=x/65wWWmxkmTy7b+KJWCQAFOChsODdtN2o4AehTn10w=; b=
	ZpgOm97Aks71TJmTgnD7g0cQRfpUxIziZajSe8G9+pNCtyg4IS74p8DLZXzn2gqT
	fdaVmiGSPHaWC/wKmazF1vfdQfWmxlxNKS+tier4Igxf1o5foiUYtbDjZDGnS6wS
	Qa/WjnfTM5LkCEi3fcSgZW4Bn3WWcRoST1PSCjZ1aLrWzyh6NvYd7KxhuGPdeMon
	h7/hoOxY5OlDR9VwD2OONtO93/sFrSw6QBr4QDPOCuWc4GD4JI43IMQaKJCKssei
	xsx6yiQq3htra2G8E+KPF39Qg8v/BvNBS6tvQdAj6gY4pT/7xfTHoG5lZWuUmFAo
	rjJSFOqgzJHXvSzacXsNUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753779337; x=
	1753865737; bh=x/65wWWmxkmTy7b+KJWCQAFOChsODdtN2o4AehTn10w=; b=h
	DPDeWEbVBlyTC7J3Sj8YlurQZZmRviZix7goOV35850k++SjVdjFA44AbAnKsOpB
	ynnAEObKizwqySIRGfKyRujyT76J+07cIuBIP2RPHWeqM02VyJxpq0Z0mRYoJFUJ
	GZ4CMGxBDXIBfjWqU0r/C6ZDwSEodKlecrSI5udSE1ZMICwftGowZN4DHrPbLeu/
	Nxy3Uq0tXpFEUIf4iNSUD021ztNbNrvIYipw6lyjFQq1ALDYam/ZcPvcCCPwj1H9
	AJlleimhPoMRSuA0UEQCLnedm2s5OO6q8YOiFcBfWo4zR7tcVMJ978oVzv+HxE/h
	CF03GQjiDLl/dw6q+Bceg==
X-ME-Sender: <xms:iIyIaGT2X-WXM9J34MQE2DvYDdR-lY2x3GWtxoQxypXlwEBos58y9Q>
    <xme:iIyIaIqVh0SuvFhfdQ-MzxTS7P1pnTi0YWWETvizfzfG9TRintlYqi-aSTHqPliGM
    8bvVHmZBErhgR-ekg>
X-ME-Received: <xmr:iIyIaDld2ZLhgG8Sf9qqcMuRi672z9sAh-SQeQR7wXXMGYPH8YVkE9heBUrzwMPzaUDzJTXZKvrzjVqYR05IFqvQdWmWYsIUa7KdZ8RWWc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iIyIaBcXWrB2n8qXBwZRmOrTKee0C-KxA9Qkl34mQy6bGUMjTEljLA>
    <xmx:iIyIaPo08FN-yvbxQkycCX4pIg__t0_NlyAxpRJvTajuYuBYBQIQrg>
    <xmx:iIyIaLMmXvhsCna_P4tiMvYmRrGPnVqbWj9GYyYzOCbl4S6vU0ZIpQ>
    <xmx:iIyIaCgzq7UMzo1IoYLMPHJMMW2qcVobT1iELAGQTDt_xHKMiWiZOQ>
    <xmx:iYyIaHuyRVr8TzgtR1W8y4p-9dSFGi28cE2EsSho6qogfuJx6YEk2VX2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:55:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c9e5c8c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:55:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 10:55:21 +0200
Subject: [PATCH v3 3/9] refs: export `ref_transaction_update_reflog()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-pks-reflog-append-v3-3-9614d310f073@pks.im>
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
index dce5c49ca2b..8aa9f7236a3 100644
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
index 46a6008e07f..253dd8f4d5d 100644
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
2.50.1.619.g074bbf1d35.dirty

