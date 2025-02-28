Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882A25C6EF
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734813; cv=none; b=K5GjUK/KKMK9vy4TgnksOfy5oD5evLXOxiunmBDdp06mfk9sQCQSinRb3bXXBV+pdZlhNHcx6cLedRAahxxZSJAYVhNPtzl4anjwwfGCnUJpQFizbwjsURYtsN1CgjrTqBRx2mTmXCEpAXY7lq3tZLgXRtwsx1Y94+ZWeRGqECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734813; c=relaxed/simple;
	bh=nqqym1ttkdoRs11Ats98QbjhGX3F7T9IVHzyX4O6dR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ssipjw7wbFDRbZAKdmsVZuQFx4ddchs9hMd6KRU3YJlRCWphCWHk68XOUUcH1e/mAeELoYi3J2iEI41NvIt891DM1ua2/ocDl+SR2w/8UndLLSsw1ryOLrKVXAKLo2E5N9isLQPmlVhvN4O/N2y2lPl3KmneLxJVCqgncgj9wUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=llFYtC1g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AW+rAN/h; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="llFYtC1g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AW+rAN/h"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98F1D11403D3;
	Fri, 28 Feb 2025 04:26:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 04:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734809;
	 x=1740821209; bh=KG0UsEEFgmzPud1sQMphHRxdMdJrmrhCyqydzvacPwU=; b=
	llFYtC1g8hUvsNSg14K7gpkGNNNnPDLAyRsAQ1Mbks9nO85VuhQCR8xs4wEo1w0Y
	BtXehWYoWp2l41qSVS6mRLQVBgwMT5gwu6StaMApa45wrIPFytID65wsGNXAiuQR
	N3LtDxMpt+oCA/kyvd24Y77510SFPwzQLG0qSbjpgljfoOic0+YDlVWeoQlaSUev
	NE20n81FoNoX4YKzB1k3sLq33SNfpmL+nObeHiYW4e1nx2oZ+9k0N6Tfzx9AUppf
	ns9cWQyuapSgQSv1bZoejcdYPsaESPtGMXcuMTO8LuCMBptEeTlM8YkJcTe2PLZa
	dUHzDvLT1phc6rumgQAaAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734809; x=
	1740821209; bh=KG0UsEEFgmzPud1sQMphHRxdMdJrmrhCyqydzvacPwU=; b=A
	W+rAN/hiPgpx8HMuOZXKxy3IQ2KbhnZwk8P/7neuaieQDEivCYNHZW4PSNDQhaKj
	zRWPTexRLZdPLf7GJI4xTbrakmI8EZU23BdrUB2yyggVqOxHkBcM98+uWRHl1otx
	BQr6tNzAPyiDKoRuE6UeLewVO7OctUVXpoiBCf52l0sVlEZJIHQSIzNKMRurmmw9
	nEeFsxzD6hO8WxE8yPxtQnEp/LO1ZlQ/HBsQhWXjX7D4HEfBh6Z0/RBokiTEZvVu
	YvWDuOJ2tGPOCdfpMBoKYwcYoFWxFkMxqfif+m0imHzxwfLfF+QolpMV5zfnYCgy
	4+bMQ9TBRwQE/zqPi95Lg==
X-ME-Sender: <xms:WYHBZ9BKAelvx6tNAF7rNu4We_zJi1_wtHq_1c6Mt-tbunZlmIx6lg>
    <xme:WYHBZ7jWef7l6MTJzk8699ArB76NpwLy1HwjxgfS3quv9ZiTKRMjbtgx-SXFPOf4H
    fvoUH9MuBZKeVjuGA>
X-ME-Received: <xmr:WYHBZ4kUykn2i6BHawOAEynNiYBhjF_KoHyn-Owj-UMzjAUWwKZ2wpMNT4y4onfR7yEm-Wc1FQny6YjVF9Ba4ecokWXkJW5R_9ZlP6k1KCxH3clI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WYHBZ3xArfqhFabzXY_Bw43C4dOlW-JMdP7Vzz0CM0cTzDiZYREwlg>
    <xmx:WYHBZyShR5qfuFw_enPenOkMPFxuztDRnE10rJal995RT85fRBsctg>
    <xmx:WYHBZ6aQXFGFdakiYTOjpAHcx7e6Bbyyz-aW-ZSDmfbGXNMAm73ElA>
    <xmx:WYHBZzRMBI6_Q1mJyPQ-cUgiY9_hU2sLafJ7xlveneMI2JLsq5TudA>
    <xmx:WYHBZ_R-Zs6PKkdcUrvtUxgvILfGnCG0c29tkaoLmnllajGrwGZByIye>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fbcde295 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:38 +0100
Subject: [PATCH v4 01/16] object-name: introduce
 `repo_get_oid_with_flags()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-1-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
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
2.49.0.rc0.375.gae4b89d849.dirty

