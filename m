Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47F296BD2
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879599; cv=none; b=WJ8KMjhnxgBXTWotPMxZC7BJgnX+q6pQuXcmy22vxbMu5s6uHQTz0Z0423dpmlmXJRL46o64m+A7RJs4QxGU4D+GatkbGwKh4q2qioiuvIoMHeaivu3xmIYOxNF/K41L9b3SSxyJVlhk6MxgWwjR+ENYx/LhMVcgFkh4YI77Ta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879599; c=relaxed/simple;
	bh=7YwsZA6YQb9S6TYb8+V16m0wPs2Oj7ua7a4ibEx6RC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1pRo4zmxDN8/Bj4mnaTBkd9ZM5mUaHnOAiAuVLhbfT2wTAo9MS5Ta79c7hHVmnm0Y/FIC5bLHg3AKv45iGkSOKP6g84dQ5yG6nkfyr+/cW9G9sOCuwyvACumnsJcPrTf1MdgUlvloE1p5ZmWpVkJvR2ZyLW0ptHqqXtdrnbk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SpdL9Dz9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=moZ0SR0P; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SpdL9Dz9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="moZ0SR0P"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0135414001C2
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 01:59:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 12 Feb 2026 01:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770879596;
	 x=1770965996; bh=AE6G35LmeQX0X40yC2NaS+8/XXuzrW5ziB0wCOh3U3E=; b=
	SpdL9Dz9JBkXFsF3RBswX7iv8HNbop8QZ6ihwUENQ1FPKL7Hf2lSnifbCjDlqiJK
	ji7T8aeCynLSmbzUoPZn43Rb56aa9c+balAG3La+S2sed7uxPh/i/yI5RMLs+qay
	53wZwsMUWLPy9++R7KCXsA332KbvvGzbUl44QJLifIx4L7KXV9sPG5hEwq+I88I+
	Tg+uAMC+Goi+JsVZnCQylcCkdxeaIA6VZkuT1cTBIQ3jnNrYV4a8MyPEWj5mprah
	FnpLr8BhzBRIlXG28f/HxUL6cLQAgt5YJSgykJzEkbXlNLbK1VuJJfdMjTdwgGNJ
	FV2/rRCWxDBXks3m4JzDvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770879596; x=
	1770965996; bh=AE6G35LmeQX0X40yC2NaS+8/XXuzrW5ziB0wCOh3U3E=; b=m
	oZ0SR0PP0XZj4KFpVSHpWfKab7t6TvJxyCjRrQutG8/QqXfKo0zMiIuYw98Bp0/h
	nBMnWj5ZM5XGgdncW707JXQBgXjbD+H0hTh2g4iwAug5fZvbCOtQ0lfsuG0C66l/
	f4fIRekTWW66n7f0w1HtpwPuX4fsRKQL+y2r3kZ17NEZ6fsqa9eSY1oWrF1j8vVP
	0PJysW+KA6XiPwaMYZuE++CWtzccpRzolAa4TnhzhIZYHCVNeu5eUyW6u5b16jP/
	1RI8WvX2nlVquzi561k32nCr2ymfZB+amUrQqkez50o7Rb30yl3Q/h7XBDlay4LR
	5kM9jYML6wCp4lfqEwLAQ==
X-ME-Sender: <xms:bHqNaUt6DynncLYe8Yw-w1dMYK2dhZASGON4jGhEQ34ecQIS6xTUWw>
    <xme:bHqNaYaIOtFiAVPNuBkfnQ-CKPDu_mGB0nx_dUitV1q3THRSXYyu_S0feR8yjjJQa
    kudFNduOFLkMtlJ_qzl6dq1pXflZvVKmbZeTRpsIYtFLWmt9yxlWg>
X-ME-Received: <xmr:bHqNaVbwPjgSmI8OP9npegHcnFUepnKj4Gr9JkrXG23WSEVRZmd5xXpkfYDEKdO8ZBKG83XhcmWZ55U7tJM95UldFzMLBSzWrcxOfDpj8rI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:bHqNacUZdwpTpuXg0XbVyL_06h5q47_w2S3UYtRozvo0avBqQjRy7Q>
    <xmx:bHqNaU3sna7taIWSvpXMiHrOPAj7PUF_ITWOzWUadxQT0Y1S7Q5c3A>
    <xmx:bHqNaba3MZo2luh7V0EXikZ2GxeFGwsw-5nXbg-nEeXaz_otZggbqg>
    <xmx:bHqNafrF_5DpdvKDuSOt3ENH0t5Y5C4NnNAJnqelF7On_jotCwkn8w>
    <xmx:bHqNaXdkqYVHojukoA03lkdHOBwBY4N7I5Cn1_tmGLZcpRALXKqesQaN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 01:59:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1c07d58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 06:59:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Feb 2026 07:59:39 +0100
Subject: [PATCH v2 3/5] odb: drop gaps in object info flag values
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-b4-pks-read-object-info-flags-v2-3-3bfa9bb149ef@pks.im>
References: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
In-Reply-To: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The object info flag values have a two gaps in their definitions, where
some bits are skipped over. These gaps don't really hurt, but it makes
one wonder whether anything is going on and whether a subset of flags
might be defined somewhere else.

That's not the case though. Instead, this is a case of flags that have
been dropped in the past:

  - The value 4 was used by `OBJECT_INFO_SKIP_CACHED`, removed in
    9c8a294a1a (sha1-file: remove OBJECT_INFO_SKIP_CACHED, 2020-01-02).

  - The value 8 was used by `OBJECT_INFO_ALLOW_UNKNOWN_TYPE`, removed in
    ae24b032a0 (object-file: drop OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag,
    2025-05-16).

Close those gaps to avoid any more confusion.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/odb.h b/odb.h
index bab07755f4..8e1fca7755 100644
--- a/odb.h
+++ b/odb.h
@@ -353,14 +353,14 @@ struct object_info {
 #define OBJECT_INFO_INIT { 0 }
 
 /* Invoke lookup_replace_object() on the given hash */
-#define OBJECT_INFO_LOOKUP_REPLACE 1
+#define OBJECT_INFO_LOOKUP_REPLACE (1 << 0)
 /* Do not retry packed storage after checking packed and loose storage */
-#define OBJECT_INFO_QUICK 8
+#define OBJECT_INFO_QUICK (1 << 1)
 /*
  * Do not attempt to fetch the object if missing (even if fetch_is_missing is
  * nonzero).
  */
-#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
+#define OBJECT_INFO_SKIP_FETCH_OBJECT (1 << 2)
 /*
  * This is meant for bulk prefetching of missing blobs in a partial
  * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
@@ -368,7 +368,7 @@ struct object_info {
 #define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
 
 /* Die if object corruption (not just an object being missing) was detected. */
-#define OBJECT_INFO_DIE_IF_CORRUPT 32
+#define OBJECT_INFO_DIE_IF_CORRUPT (1 << 3)
 
 /*
  * Read object info from the object database and populate the `object_info`

-- 
2.53.0.295.g64333814d3.dirty

