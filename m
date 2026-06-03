Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FC3E5A23
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503265; cv=none; b=HzzdJ+lo9x7cTaIoNSDC4I1IWvgmnENhzIUNM4mPSYab/UhdIpOqopA582ecNLWd3PLkxtgPhVp5pQOsvf9Q13KCOMMx70U2S6W0MSEMHh9WFQHVfEzz6dWwzCHMsnmSsdt6rKCns4i3Wyn3hGboP/MWoPim4heIYP4+Ai1gdzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503265; c=relaxed/simple;
	bh=SoDRkYnuBJM4J8O4XgE1K0tmBrwfs13qdB9aCshySaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h6M0C3iSa7nMZ7ZY0JZ2/cAEk3P0H8YX7BrmFBrzolGywGALh84kf0OFxvnVUt0tZP2h4x0fG6ztVvUD1/9TPutiuOpS/K0CASIPNEs3WaQy67Z4Qs2baVj4e0+Pvcn9kAPVc3QoyeJyK1orA4BWMezGmb/mu74Ntstlsfgpe8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=We8WlZ3b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUfMO7op; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="We8WlZ3b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUfMO7op"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 290CE7A0142;
	Wed,  3 Jun 2026 12:14:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 03 Jun 2026 12:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780503263;
	 x=1780589663; bh=Xa694lzuZDZFQT4eQSEdnvnYzWL3GKOF6LqeTyK59I8=; b=
	We8WlZ3bqciP1qRPhmlFKd5VpKc4ZD9YPOH8qsahw4QJF7C5xPrmKaDDTH1aD5B4
	48wRiFvCpQiM7+z4+HuWfUSwXCtd7YX2NCQVKBfXl2EIakrElNb9Uj7pjXeUNtBD
	jQsBcE8eT2+tvoUE2B33dA4EXummOcudTO2ECgnA2Ycwkz9tZbfGIMpLeF5Y8Ban
	E3P+iKXInPHHoqLxCgOEsWvwkuOn67Nv2UsBTLwTH5eyKagtuJy24C3VukBasj02
	hzNU0y4kZwUoJTAa95GFXB9vfq1G4KwFaz9ygBLMH27ZycNNED9KO0p4W462ogKF
	1t8NJsVJvU5Wu6w/mKDgFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780503263; x=
	1780589663; bh=Xa694lzuZDZFQT4eQSEdnvnYzWL3GKOF6LqeTyK59I8=; b=W
	UfMO7oplWir1gtgAhRPjOwLXiX14dMWOS4f6K7X6auPdCibKH79jnXDXqfJ0ZWGC
	9ZaQSNcEeYUbx9UHhlcKpPJxlDzMKpvnutem+k1xwUz6WUB7SMtS3h3vdWcvRlWF
	1yswPU/AdhVS0hdQ3XgYgoapOm+26X8nlDYZ6BSnO07JPOhNO1w4JmwPKjtZCPlq
	Yu/1qID7g5qSBNGDVdc64lmFr5mizyTJAfSRKLsRP97Sk/5I+r6c3qfh2ucFyNRc
	Qs4h5/OIFGYeNLM2EVDGWs/IQ8Ysu+TXPntjDMLfS4EloPB3rID1yDqqsyi9RL9Y
	m47aWxkjuIlu4y09/WMzA==
X-ME-Sender: <xms:3lIgakbEFCKjMEaOMdd_Pk5OZXpnTIbQjeEYJxJg0r5OCJt-GriVJw>
    <xme:3lIgam1tiIH-ggGS0GWs48_r8bP7KsaVsn2iatbVI266-9hmed6C_gazYPUAYklFz
    y6Zp5AVR0kUN41DXF2xzm3goJgOvoDato7_VP-gbhRJ9btz85ZrBg>
X-ME-Received: <xmr:3lIgasWNYFQeOskMYFP92mTfHFZ-RXy1Q-lydYUX8Wb1xgxVilqR1Z7-daxTxwF8tPsVh3ncBlYHa0gKX4LoA2fFRyZbDpnQbPzLsCptZAzl>
X-ME-Proxy-Cause: dmFkZTF303RwjvoG23zVORmNkQdgK0/lwRZFrNrNmP2pxhNsiENMBgzPf28PXU7BO4U0rO
    NEWnUDOvDGyd9P/ZLzAkKCZ21/4nS5KC1Y0DVDMUNy6zqU1eoIl8He2NsoIHLtBoOkYG6P
    DSdciAlVROnUH2OWmZ1IhCWA0uA+a7xcLGGLoOXFKRCkxmw9+fZaVQ393Lr3WtqndDB66a
    D+qbJrAVuL4k4fgE21/oLpqkjCoaTXDR23q2jsinaYqHR+LHOnuOG9Ue18he76R8Nl/Ah1
    stmIX3y218Vr5roSnYu5FRGzV1602fPwmxxELScJnsmzljGS44IK0zp4OAzWRqkBN/UrCT
    7BEVkgQJfJ690QWFKfcscbfRy8c9uFKLE1uo9GW7NLHYv9DPorMyURPhrkC+cYuYkxwF+6
    IdUFvN6FU24VWJvboZ7qhseeve/8eENUZUZaRq7lywklse1qpXdGE0cndn5epk81L1ti9b
    vNGS920mhSpbJLSBEP07mj4lvX+wsIhmzwu4A8BK6YwIk2ixoNkdvwCqvKdVC+fM2S8I61
    4BtU6K77XMcCct8NH6WYFUMdeZmLD6s9J/WwrKGP5haDopDsBuHTJCUFDH0x7OUwolFj5q
    Ib2fYxlu4psLkKUQzto7qlgb/bv0AJZ8+6PBjxKs5YzhX7nI70hQ2srM8VIw
X-ME-Proxy: <xmx:3lIgaoXe4RxGI5QUCUnyiFrSUnR3CYTiyZEgjX1k0_Z07GbYntSOnQ>
    <xmx:3lIgaje4FB1taxS88kkRCOF_X9_4f82L7wd16chqJxEIp3I88fx3Xw>
    <xmx:3lIgapVamY78dfInKaXGybmcEWnBED5pBshOx-132Ji_zwOk44SgpQ>
    <xmx:3lIgakd53KP6QAqFqi-shxrsHt7RKCHEsCxPZOx7gSi9oPLlQ1XuvQ>
    <xmx:31Igau1B793cs3ybAJ2TYCS3oYujff7xgD4D3rV4Jwp23HnCpUBfLJ0v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:14:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7122edf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 16:14:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 18:14:06 +0200
Subject: [PATCH v2 7/9] reset: stop assuming that the caller passes in a
 clean index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-pks-history-drop-v2-7-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
In-Reply-To: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In 652bd0211d (rebase: use 'skip_cache_tree_update' option, 2022-11-10),
we updated `reset_head()` to stop updating the index tree cache. This
was done as a performance optimization: the function is only called by
"sequencer.c" and "rebase.c", both of which assume a clean index before
they perform their operation, so we know that the end result will be a
clean index, too. Consequently, we can skip recomputing the cache as we
can instead use `prime_cache_tree()` directly.

In a subsequent commit we're about to add a new caller though where the
assumption doesn't hold anymore: the index may be dirty before calling
`reset_head()`, and consequently we cannot prime the cache with a given
tree anymore as the index and tree will mismatch.

Adapt the logic so that we only skip the cache tree update in case we're
doing a hard reset. While we could introduce logic that only skips the
update in case the incoming index was dirty already, that doesn't really
feel worth it: after all, the mentioned commit says itself that the
performance improvement was negligible anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reset.c b/reset.c
index 7ff72de5d2..05eb80216c 100644
--- a/reset.c
+++ b/reset.c
@@ -166,10 +166,11 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	unpack_tree_opts.dry_run = dry_run;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
-	unpack_tree_opts.skip_cache_tree_update = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
-	if (reset_hard)
+	if (reset_hard) {
+		unpack_tree_opts.skip_cache_tree_update = 1;
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+	}
 
 	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
 		ret = error(_("failed to find tree of %s"),
@@ -196,7 +197,8 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
-	prime_cache_tree(r, r->index, tree);
+	if (reset_hard)
+		prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
 		ret = error(_("could not write index"));

-- 
2.54.0.1064.gd145956f57.dirty

