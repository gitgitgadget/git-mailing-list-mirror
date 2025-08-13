Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030142D29AC
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066356; cv=none; b=nXV6aH3FraBvzVWDGsFFVXhf5+Wf0J16ApDHFomzXcgYtJzkeII36cGJyMTQX6ZTiMmwQ7Oco5oAYTxFu9mRHbbUvyQb6KS/7PXUbNqsvl/bRhm6njHPyDCpTUZ5YkSJKcIL4FwCAar04Pf7mcwImR8kEaH312AL5BaEXHisYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066356; c=relaxed/simple;
	bh=jveQM3VHaNUtbydlkFR9cwgva5Zk4CwcET+zU+T5gP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AI8LNmHkooE56MKOAN0dsFYcAz/LSIWe/2T20j0rktaFs9i67d3S1rX4RwxmHTfp2VNGrHOGxPan3bFSHNHqS6alrpRhINwdDs5zvnDzP68aE3TzVVLGafVqmnBVepxe6xB79X60bk1qSTiwhVkw8EG6X5yDt/0w/j2ezf7DMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G24voUE2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aq6qYa2v; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G24voUE2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aq6qYa2v"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D51407A0174;
	Wed, 13 Aug 2025 02:25:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 13 Aug 2025 02:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755066352;
	 x=1755152752; bh=kjmdt/qxAeRDMGjbEG31Z6Ksa/TXTRWBbuxbawNeLaw=; b=
	G24voUE2gBnpuDWjiDZNJJn/DVqr2lGB7JjVHqi1G5+GNRTU3Bncr9MsxyY8uZ1x
	W4oN3YNhcx++KoahoVNZjjQTSDThGilXknKlc/MBZgQRf61B2RiJusTQjmC6aQX3
	SI1vrkNDh5cFXj+aym1CylKFuyikGx2ocZEGVfWv4lzJ+nkqI7drRS2DX3nKyK/h
	egYJ22w4NudNW0l+ftHj7sedaManLOQc4A4Yc18Fikpizj4/uprfjtbgcpoquK/S
	8h/9+QyVVVFsuJ0xYdT+H+JU5kbynEymUn5QefWAqnW6sHhA5Sk/iL9EHwVJxeh4
	hfaxBB23GP8Zp56E6bkWDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755066352; x=
	1755152752; bh=kjmdt/qxAeRDMGjbEG31Z6Ksa/TXTRWBbuxbawNeLaw=; b=A
	q6qYa2vR0grLWzo7fpSNfM0iLaSC75lMd90a5hPi8U6ILH2g4zf+UuvEIp0cbJwx
	FESfZDPhVRGNw3AdB9xMDtiMZhyy2uvqf5kKQhHrOr9UVrbS+Sn/rwVxG0oh73ED
	tLX4mT4NOTJHzCdqkzdvKDGcIUmumIqG5xDHKkBSNAxqBKkrPKOSjgk6eXSpikZm
	+qNsFV4dHChMZljcyDuMPE81nd078MM0ez005z9njU0udjBIDTXE9+JTX7pdJl2v
	VA1+szAukAUa7d+2cLQ4ZN80sguwH9nJV78BDnGXLaeO40D3g/Ollip9pZ8+Y8Mi
	zK145aFMFxalnK8UGKBIQ==
X-ME-Sender: <xms:8C-caMyhWkb2nFu62BftWUtv4VIvvpYtWpm49xL8nsVSUzTmukn86w>
    <xme:8C-caLy-FhXjX4KIQ6L7C87mq1j5GzxZ-sd4Gh9W2U8ZYPT-_YzMh-K_wTa3yY7rb
    ZWcH7P_vvwQ3HIuXw>
X-ME-Received: <xmr:8C-caExI_cyigQiuzloFUVBwYmhCWOssax5ob1FVvBoWyUIeSwI7yMLESumZTFC4-fh084Q-_Y-FrfNR1sXTbo68E5oWULe3E8d51qM4YEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrrhgvnhgrsh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8C-caFbN8ZkOL1gRxPFqRG8TO-wEYOFuHTvqtylHYlc3bm4w_2gwGQ>
    <xmx:8C-caFULtK1N-G6xm57Ykgi7UI5ohPIe3evRLHOGEcm_i0vRPsIlJg>
    <xmx:8C-caDh5bDYOEoG0osDHm2jVPqCaTs54n4o_9lYCH7Wylh5MeD-mVQ>
    <xmx:8C-caDsuKegaEMTef7swKKvsdpnkwePPKb265ClAIerSof4S83K1Vw>
    <xmx:8C-caEtX4vgItDgsypops2lv4ivSrouWTYLZTmRZZrO9vqOjRbEYAa46>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 02:25:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id da803e16 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 06:25:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 Aug 2025 08:25:30 +0200
Subject: [PATCH v4 6/8] reftable/stack: handle outdated stacks when
 compacting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-pks-reftable-fixes-for-libgit2-v4-6-42b5544c8e2a@pks.im>
References: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
In-Reply-To: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

When we compact the reftable stack we first acquire the lock for the
"tables.list" file and then reload the stack to check that it is still
up-to-date. This is done by calling `stack_uptodate()`, which knows to
return zero in case the stack is up-to-date, a positive value if it is
not and a negative error code on unexpected conditions.

We don't do proper error checking though, but instead we only check
whether the returned error code is non-zero. If so, we simply bubble it
up the calling stack, which means that callers may see an unexpected
positive value.

Fix this issue by translating to `REFTABLE_OUTDATED_ERROR` instead.
Handle this situation in `reftable_addition_commit()`, where we perform
a best-effort auto-compaction.

All other callsites of `stack_uptodate()` know to handle a positive
return value and thus don't need to be fixed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1ce4d90cb8..af0f94d882 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -579,9 +579,11 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 	return err;
 }
 
-/* -1 = error
- 0 = up to date
- 1 = changed. */
+/*
+ * Check whether the given stack is up-to-date with what we have in memory.
+ * Returns 0 if so, 1 if the stack is out-of-date or a negative error code
+ * otherwise.
+ */
 static int stack_uptodate(struct reftable_stack *st)
 {
 	char **names = NULL;
@@ -850,10 +852,13 @@ int reftable_addition_commit(struct reftable_addition *add)
 		 * control. It is possible that a concurrent writer is already
 		 * trying to compact parts of the stack, which would lead to a
 		 * `REFTABLE_LOCK_ERROR` because parts of the stack are locked
-		 * already. This is a benign error though, so we ignore it.
+		 * already. Similarly, the stack may have been rewritten by a
+		 * concurrent writer, which causes `REFTABLE_OUTDATED_ERROR`.
+		 * Both of these errors are benign, so we simply ignore them.
 		 */
 		err = reftable_stack_auto_compact(add->stack);
-		if (err < 0 && err != REFTABLE_LOCK_ERROR)
+		if (err < 0 && err != REFTABLE_LOCK_ERROR &&
+		    err != REFTABLE_OUTDATED_ERROR)
 			goto done;
 		err = 0;
 	}
@@ -1215,9 +1220,24 @@ static int stack_compact_range(struct reftable_stack *st,
 		goto done;
 	}
 
+	/*
+	 * Check whether the stack is up-to-date. We unfortunately cannot
+	 * handle the situation gracefully in case it's _not_ up-to-date
+	 * because the range of tables that the user has requested us to
+	 * compact may have been changed. So instead we abort.
+	 *
+	 * We could in theory improve the situation by having the caller not
+	 * pass in a range, but instead the list of tables to compact. If so,
+	 * we could check that relevant tables still exist. But for now it's
+	 * good enough to just abort.
+	 */
 	err = stack_uptodate(st);
-	if (err)
+	if (err < 0)
 		goto done;
+	if (err > 0) {
+		err = REFTABLE_OUTDATED_ERROR;
+		goto done;
+	}
 
 	/*
 	 * Lock all tables in the user-provided range. This is the slice of our

-- 
2.51.0.rc1.215.g0f929dcec7.dirty

