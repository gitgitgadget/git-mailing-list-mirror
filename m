Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635ED480969
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905761; cv=none; b=cnM56yXpRmpKDwpSGNTsZZo6hyKQab0VMMskNUoKmd6ugu9EGgcpNn28W+6foHgM/pQPeDvpiATOsV+PKhjXOmCWqIYW3dVMnAPYPqZOVgpbDrdCE8MQlRVWv/C1r/H6e+PrlX5LZseYcCOMFMcuh5DyV4059dSigIfXr50vXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905761; c=relaxed/simple;
	bh=s4b4PXssiWClMrmaRKYv+XkJ/mlrQ84jmDeJxlErfxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lS7x3hrMZalQqfQJblj6i2XU4SXRsbujsg7HleCy+uh421s+GNRvr5OaLYRAQwKhLTpbsiFkAtM84neRw8eyUTFjSXEPpf1AGrcEqQCDvEB4qGQghQcV/WiTWxlyO3QFopd5ckFMXxjDi9xCIzW++NhA+Rbp3iqfJ6GMjQzxYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jXEfjy3l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6ESlrsN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jXEfjy3l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6ESlrsN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A3461EC01BD;
	Wed,  1 Jul 2026 07:35:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 07:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905759;
	 x=1782992159; bh=tO2+BozRPrG5uNUeAU5ki1+oldWWUrAmEqFPuTW/9gs=; b=
	jXEfjy3lTpkqZcNsBZXo6ktxJMvi0H9wUzZdWJBpq8qhrWm2HZS0y6JCv+iqqMwi
	LJk/B+f3q9ZGBS1mEAGlSwp9Pi/PSsoGS2+t2cgwhYgmeDReRzYtMxmCV53H8qWF
	k64yB8berEubGoIPR1wdGIKEi36IntRaWkSY8/SzhFg8Ks8S3je+UmCy5DUvA2Ra
	dt+sK8sJk2yRY5/apc8kgcE/+9ZDYfK4vruEsZuBHIE8m/F/XTUC6/LRGl7iZiWi
	YInzRrHyAZQ4ishD6m3LUDJQPifAdLx2cl5RV6v1S/GKlru9gXgtFU8O+A695oiS
	dYkh3v8T96kWGzf2MOsdCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905759; x=
	1782992159; bh=tO2+BozRPrG5uNUeAU5ki1+oldWWUrAmEqFPuTW/9gs=; b=b
	6ESlrsN4db7TntBDXiLz8QXvC3PRy891tBgh3y0d2goHToU5/N9+s9QZhl1No9R0
	iVMODTVA8VCPyEA8JtoTzIQ6Z2I2DVEOTUlOVfan5vOl+v8BEf35xazGpFK6ZWsw
	fFQmePBed3Kr0hwivBIX54btoLnPtqvvNzk/gg/2QCKtKGtDGleN7UnFQbwY67gz
	2Sk01RUUn4ZB7brBAiaPWhlxPqYEpc0IGyuz8cQraifm+p8Gwcdv5EFimJo5F7EJ
	YML39xUp8ghx1t9ge+XnSKJYfdIRBVFrmD3zkIv/zYjmKCJVVx7RtU4BBo1w2yXb
	FDybQ29is7qzt5dgzyAmg==
X-ME-Sender: <xms:n_tEauG9tkdk59ZdPevnTcRV0Aao_8n3dNXCP2Ffe7UfNX9bMyQVnA>
    <xme:n_tEaopuwMSaER_DwGTQeuqn0_ZvyOcT_M8HIOg5KAkhaY2J6rnWy3nMPESI1q_p9
    BPg7jtzjhFBehQVjNZS4HHQ2VJT7R6qfjcIHSCMPdhAHb8YJgly8w>
X-ME-Received: <xmr:n_tEavbb7KKqqSrzlXW68YNCRL7S9WrbcTtfo53Vi4fuT2YDFze6hVNreRUy7gw0_YwdI6GnjkKw5U72T_Gl2rMKLPP_Bu-5WcMfmDgNveo>
X-ME-Proxy-Cause: dmFkZTEdGaAhIXfrVWP0kL4LFdZVEX575FY+QSltmV7sQQ+9y0j7FHTtnJY3e3/aQVK+gj
    saMpoXDLVFre+anN0RIC3rR44nDR9cmkroS+L2Bfo28y8eS7ByLmXpQ4hc5STJkv1ejgPe
    wckBcCIQ4J8YiDX66WcIVSF24zuenendtAynq4EWE4Z3UQtD4xRAWmeTxSq2aPz+mMyGkG
    Yab53IshpFQMiKJ5OHM+62CuSJ++nHRjUQpxgWjy3UJPtXoeZGNhtIk81IY9X78hiiFIB2
    KdG2pTR5bqTR/3EsfoEjeTlMtLtvu4JFHuf+CLrL73JpIAWlD3F+tL74JqXNem+jWzY/VJ
    i6uWUiQsz5G5BDy6Cwa2emKq/l6acSdK0zUgOCDYsvzDv0Hjx8e6vRGnduH60hcdy2wHFP
    j+CvOj2uRJBFPCebevw6WfCHzSIhIPDVk0/bgqyyRYs04dc0VCzOKp18uzoQ7/cpXWs/SS
    8EJsdlR3/ymffnc9xgLZ55vuUxc+LY0J5GaJ/HyWt5fkuoI7ZhgsGtcIOcZ+Xf8rJonVRR
    ytzVghUXqYFRvRG+GjbyTiFJ/+/oOSRAnWnMq2OiRzNHr4GebS5kZpkdbn+x8KHgmJ54l5
    Gu1WsC8HOHUHDhmQdaRxaP1hhtHcUr+qN7GP1fnitGEH33tZ8WauNCIEtiEQ
X-ME-Proxy: <xmx:n_tEapXKcNaiZIz-GbGTrFoIvIkcmbqqU5VA4zL3q_nAKT2g7MS0Jw>
    <xmx:n_tEag-WbKmJ1jqaAg9oiuq5mMJbX6BoEYrwMHzij_d8vAweEQZCow>
    <xmx:n_tEaq9irwhjgrnNpI9tBoLGRfVJ-TLFqp9MeCi40IrsmPMb3TQZRA>
    <xmx:n_tEaoQa7utbfNYUs1LiPw6xy0ihMhMj0N6lbLLoG6DHPA0axh7Dag>
    <xmx:n_tEaljwWya47YaxP5S1c3Q2xoYTvAHa3Cq1o_KzwXvl4X3xEBwURpc2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:35:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f68425d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:35:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 13:35:35 +0200
Subject: [PATCH v8 08/11] reset: stop assuming that the caller passes in a
 clean index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-pks-history-drop-v8-8-19b5cdf1facd@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

In 652bd0211d (rebase: use 'skip_cache_tree_update' option, 2022-11-10),
we updated `reset_working_tree()` to stop updating the index tree cache.
This was done as a performance optimization: the function is only called
by "sequencer.c" and "rebase.c", both of which assume a clean index
before they perform their operation, so we know that the end result will
be a clean index, too. Consequently, we can skip recomputing the cache
as we can instead use `prime_cache_tree()` directly.

In a subsequent commit we're about to add a new caller though where the
assumption doesn't hold anymore: the index may be dirty before calling
`reset_working_tree()`, and consequently we cannot prime the cache with
a given tree anymore as the index and tree will mismatch.

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
index 06f375f296..ff87e3e357 100644
--- a/reset.c
+++ b/reset.c
@@ -167,10 +167,11 @@ int reset_working_tree(struct repository *r,
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
@@ -197,7 +198,8 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
-	prime_cache_tree(r, r->index, tree);
+	if (reset_hard)
+		prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
 		ret = error(_("could not write index"));

-- 
2.55.0.795.g602f6c329a.dirty

