Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A79025948C
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734781845; cv=none; b=qmEmVLpxB0HimVJBMdXAi6Sa7uLaW2GrCXSOdXaVBSwE1dST0n76s8wR3A9ezSEFrS3FsJeKdi/mwtI7DLw/uXtbLHYX7mHkHdaYtkhUR7nr4qgV8bdRTO4gPJE7fo6Ye/h74yLmjdt5Z/JyQeGaULozTN5ErPtPvFGTum7/vN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734781845; c=relaxed/simple;
	bh=vku1HFQRs6UMu+Gc/vGiPfYMkU57DtM9YdBI/1Hg3ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/xMP7Z8O1HdWL71a5cinWzvo3LaDziXaio/H5YRK787O395nmB/CMVIKfaAW4K38b4iuvYwSzYA23odePWHkEC6MsC+79RemomlR1WdKaxZUvs1olMDpK+s+i4rWYkYwPYJoWrEQ1tPAj71cIWDjEyOLo1dgaQeC4HMySUcDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eHqD6BYX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SzdaooQ+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eHqD6BYX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SzdaooQ+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 362761380210;
	Sat, 21 Dec 2024 06:50:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sat, 21 Dec 2024 06:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734781842;
	 x=1734868242; bh=Cl6qGnLWYCsy1zl4jZlE6icRrSalOwXdbojrzrIyEAc=; b=
	eHqD6BYXTJ8z9wa0iz+2c7wC+ztRb9G2DU2stORz4bYBf3R1PmI/8mTtRTpVcGro
	korRSKYm+rlySkIzUyuuOmsb3xCsRTj6ZrNgwoPs80sGCXPFqqmgNzAhbTRiQ5aB
	wa9/SqU6gy2QydVrnbMuIJGJZaAOfIVqYWVX+rUJHi6wXtyGbsBNC1MW6fuvpV2t
	B+24+j58RXKo+4kPM14zgsR98pVRl1KmAWw1LWqcpz1WHZT4wshgP+StfLmcCdIZ
	pl5zv7jqYUtc5CFxXZRTUqx2aCLrQ9HVxfzvWu4BhEtGFmbRDPS0TbB+rnd6/SY4
	0jn0qB1evenn2yXXY4BebQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734781842; x=
	1734868242; bh=Cl6qGnLWYCsy1zl4jZlE6icRrSalOwXdbojrzrIyEAc=; b=S
	zdaooQ+OuHoNNfEWVGDLJC7iRX3ZuA+yJ4lEhv7WxFGWoC+EvhvicnXP7GknCa0E
	RL8jXXCTmf+hPtvQK6h+joKzQYCBhgc55prL/RRYE6G1P41AraS6SEpuFneExfr9
	tFDcz6Wd+RLxAynn4uk+QaL/9Ecc6ASS1u5QMnsFivOZVwFEvj6jfYnLXrS9ZtAS
	1Lsnsu5fLf7ufytg3YgBFbs5l4uL8qmYIliASm2qBywmUeZin3UttCPs7gmWdtV3
	kvlCzDT5FyYj+JlsUPmKLlVO3P5Q5PpbAvba32UQFo3I+kNxzS800tv45cJy/zbC
	ujIg+TCQAytSFbB3Kd87A==
X-ME-Sender: <xms:katmZyCfymYzok3otr3nyFPuhDGUhsqDXUDnf2wqVvVEka94sY4upg>
    <xme:katmZ8icsoipjpMJVedZkAXR2JsaAUEKWBRmlcHMaJ4AeM3Z6xFrOwIxDsXKRyrcr
    3tH9aUwlQ3Gf7ZnjQ>
X-ME-Received: <xmr:katmZ1nJqJzhzaHPoljuLpYUCjxxd7hsdISy71CQy4_BW9jaZrZsZ44x7UW95NtYn1-IQHCeBKAU4Ebu5LdM0fy6PUQgUXlqNnrL7v2dViWXWfkjhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghn
    uggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggr
X-ME-Proxy: <xmx:katmZwwds2na5N01QANrraXIwNuqjo8AeOQ5lWzJvY3z5QUYcBmLUw>
    <xmx:katmZ3Tqr1jCDyYqS4w1WUOZHmlgAlJzyyZowlsfSIenAhulwJbYTA>
    <xmx:katmZ7anYQvftKrDaZIny1gBuzGmK5u4sSRBSYR87vOp6JnCtjo4JA>
    <xmx:katmZwR-p3fHCi5o1oVKCqSWzxkXWXIwiehGXyMqMQhTjx_n4Xsbpw>
    <xmx:kqtmZxcOt0tgCQnGHSoyQxAdq2pKLZ9RGGGiM4EPqmmAo5hSkYjHzAh9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 06:50:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e961b332 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 11:48:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sat, 21 Dec 2024 12:50:08 +0100
Subject: [PATCH 2/4] reftable/merged: fix zero-sized allocation when there
 are no readers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-2-12db83a3267c@pks.im>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
In-Reply-To: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

It was reported [1c that Git started to fail with an out-of-memory error
when initializing repositories with the reftable backend on NonStop
platforms. A bisect led to 802c0646ac (reftable/merged: handle
allocation failures in `merged_table_init_iter()`, 2024-10-02), which
changed how we allocate memory when initializing a merged table.

The root cause of this seems to be that NonStop returns a `NULL` pointer
when doing a zero-sized allocation. This would've already happened
before the above change, but we never noticed because we did not check
the result. Now that we do we notice and thus return an out-of-memory
error to the caller.

Fix the issue by skipping the allocation altogether in case there are no
readers.

[1]: <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com>

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index bb0836e3443271f9c0d5ba5582c78694d437ddc2..e72b39e178d4dec6ddfca970b5af71b71431397a 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -240,14 +240,16 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 			   struct reftable_iterator *it,
 			   uint8_t typ)
 {
-	struct merged_subiter *subiters;
+	struct merged_subiter *subiters = NULL;
 	struct merged_iter *mi = NULL;
 	int ret;
 
-	REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len);
-	if (!subiters) {
-		ret = REFTABLE_OUT_OF_MEMORY_ERROR;
-		goto out;
+	if (mt->readers_len) {
+		REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len);
+		if (!subiters) {
+			ret = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto out;
+		}
 	}
 
 	for (size_t i = 0; i < mt->readers_len; i++) {

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

