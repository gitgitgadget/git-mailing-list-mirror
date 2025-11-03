Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F2D2C11DD
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155743; cv=none; b=YaJTb5J09lg1APmr2y65bcmyP31ytpHgVtARq2i24M7oVGntBY3xUptvCAoTXSX0aw1jIepJ/PxJL4S4C2uueiWIhqBfYXjZJCdhojmZPznuKWp4MfjOOcfVuG8m/HJhpeiv86r6+Af1XaFTbCWVwatCen0PfZo2sBQAqIcmawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155743; c=relaxed/simple;
	bh=OSTxvVqeytRp3+l5EWeTOd/lJPI+JxAxg8C7iRsTErI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2f9pqlV5A0RPJeKDBP2T6G4Wjfg4AQUu9bqO0kJNtmo5BxNrs9IX5l7oDRYpM4Is7JhV/lIWmeFcdFrkRHHJQtISGZJ5ThTppepFCiq8wKy7Yi8GDAwAXVxmeDe9ORUq0A5kY4QYRfhsfTWJ7IlZpSeLFgS7XVO3mR6pzsj3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SRUXuZNt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tz2TCqzD; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SRUXuZNt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tz2TCqzD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 73D061D00112;
	Mon,  3 Nov 2025 02:42:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 03 Nov 2025 02:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155741;
	 x=1762242141; bh=kzEYWsaqXybZc1zc+P8mMLj9ooEkubE4f+sy5qw0v1E=; b=
	SRUXuZNt5XtdBSTY7bltuBMwauEhjIcLEktwpKXEUeMzZmbPhwejbGr2YN1FSPlx
	7txYuk5ekq/n5Y+uoLIl0raJf0P9vH4cCpyJRUEk2sQ/DoLRijWV4FymDRFnZ1Hy
	+jUNcAfszfR9nfLI+i5JO8V47Lz3z4DvSAytNYZUYH8gJMNlNSC1a8tQ1cDgflg3
	Rq1qNHHzdQ6Ss5xIVTSafQtdsuxtpqyzSpA9y/xd3SytqH3vLhoLitW3wtgqnRd7
	Z02UEW2tVl3ZHtaCkPON89DQLz8PX0Q+EbjzRPG2wxM5Ug5C2tjtYEfLrGHtiOp5
	5OF6izxQsBNOBafSpXwJMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155741; x=
	1762242141; bh=kzEYWsaqXybZc1zc+P8mMLj9ooEkubE4f+sy5qw0v1E=; b=t
	z2TCqzDTLPE0fFv0gAG//p8bcTRMZBIX/OnqQ/DcJ7nilSFHrm5J3VMUA/PjUMnj
	MiIDAgidyWnp4YSugOzbpINxHnK8BLTc+ZOrAiJ+A2tv0QbC3bVAwhzap3wuqp5z
	AeRIlvZWku5GlLFPeJLq8kY1ZnZdO++9VJ9oiPbKTatdeejO5jRbgei3B7ZK65SL
	OEO/a9pouN89gs9faLCuOydvJ+zMAdOd1TfakGGB/nzBc1QwfY6saldSD1bgE7xi
	SZtaByA4lJ0W35ALyYvz5xSLHBKwes7zCKTUnC3D4m3DjfwxAHnLpASxM7ZbDDIm
	Swbb2EYIviP8gjaf8+IFg==
X-ME-Sender: <xms:3VwIaWqE3hDVjHsqyRAc5uHYYISXIF2cLQBhNq1u7Za3T2RdRPbLIA>
    <xme:3VwIacGUP8nG-9qOV4IySb2RC2-ep0Csq34nlxQ9uv6I2pj_XkjFakei_c9lncxGZ
    7P8S3Ily9bKSBIORm8w4cIriplgOwYfab_SAb4RvlCmDpyvh23V8A>
X-ME-Received: <xmr:3VwIaYnEIYQ0n8__-DqKwlkmGXMptCLPMcgCGGSH2-u_UGMCBLElIJI36kSKaF4sBWjadN-mjI3SdqpkJU6Gzbt5MldUb8xCO5Ci5mb2xlgV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:3VwIaflHCn4erVqhDlPfCQF92cz68g9YA7mx1QtyxOCdUaR7bmKVoQ>
    <xmx:3VwIaZvW95hYkW95avfXuQWcfa_XeToAKrXcaFtk1GtjXq6Ey9VzDA>
    <xmx:3VwIaSkjyxcdJQMtgNUTSkUZdl4TU3kvkNQDBE8Qk79KmyZNBQbf1w>
    <xmx:3VwIaUvYswgylaiCIARdrFOQssOQOncRhCT9UQZRuo6mLasfEGb_0g>
    <xmx:3VwIaUFajV8jCxmbYygJXrnyxQzklWXtUkCXORMst2QdiDv4Fu10aAGr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8cc01db0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:41:59 +0100
Subject: [PATCH v3 04/13] object-file: move `fetch_if_missing`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-4-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The `fetch_if_missing` global variable is declared in "object-file.h"
but defined in "odb.c". The variable relates to the whole object
database instead of only loose objects, so move the declaration into
"odb.h" accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.h | 8 --------
 odb.h         | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/object-file.h b/object-file.h
index 3fd48dcafbf..097e9764be1 100644
--- a/object-file.h
+++ b/object-file.h
@@ -7,14 +7,6 @@
 
 struct index_state;
 
-/*
- * Set this to 0 to prevent odb_read_object_info_extended() from fetching missing
- * blobs. This has a difference only if extensions.partialClone is set.
- *
- * Its default value is 1.
- */
-extern int fetch_if_missing;
-
 enum {
 	INDEX_WRITE_OBJECT = (1 << 0),
 	INDEX_FORMAT_CHECK = (1 << 1),
diff --git a/odb.h b/odb.h
index 2bec895d135..2346ffeca85 100644
--- a/odb.h
+++ b/odb.h
@@ -14,6 +14,14 @@ struct strbuf;
 struct repository;
 struct multi_pack_index;
 
+/*
+ * Set this to 0 to prevent odb_read_object_info_extended() from fetching missing
+ * blobs. This has a difference only if extensions.partialClone is set.
+ *
+ * Its default value is 1.
+ */
+extern int fetch_if_missing;
+
 /*
  * Compute the exact path an alternate is at and returns it. In case of
  * error NULL is returned and the human readable error is added to `err`

-- 
2.51.2.1041.gc1ab5b90ca.dirty

