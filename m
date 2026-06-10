Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD83D4103
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081575; cv=none; b=D5m6uzvxgHNhYA65B+7jaQkDHPZM/oFs8JOZttFHiBuKqRhsB0r3Ouh4vnwqmUZPaZASXdgdOi8ffC8O/Jxh9bRZiJcm1i1RjlvUFXXPwo3IueFG8drSWhh0SgadI5w0/N3MolQxyHbB0MJAiuCKK4eNTvn5QlticE2TpFGWQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081575; c=relaxed/simple;
	bh=l7mEArfKresbtfQ6OHZg0MW5Y1N/uV+1WFZK79K9wic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOv4VxVyFIHu7kmmLzvhYUvenmEtzpQwUTcPF6m3+g7bjuWZgVS5OiegUdPW7lSVbOE4ntai77TmKa33X39g9kqQs/UftUAGjkezp0iHcSV2R+GqkIdyYc+rG9CqtosjE3BvkuE6AUWD4CyY/NcNLUG51c93MeU/VlcIKyqlTN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U1pH6nX+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kafvfsby; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U1pH6nX+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kafvfsby"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E47451D00097;
	Wed, 10 Jun 2026 04:52:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 04:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781081573;
	 x=1781167973; bh=jqshMETqu6TfI5fE9romGWAmGMF9Uu+1PZZuhZP6xsQ=; b=
	U1pH6nX+rNRVEXCMBwppWpDdexggXgKRqmk24FogTVM0HQ1+PxBTH6xiq4JBn/Zt
	ThmeyHIkVCGr4iTduloNQpr1TVTUMaPhqXPd6iwQIKKI8dMv1EYs4gAr8ssDjxLc
	kKUv6F4ooJHmVBTtJHtMRGy2msoFQ3KqsJjGdxEJHqkWhNjfDT+Twp9uex5WauQr
	uAYeV3Z5xGMWaDUim5ZxsEx7LZxwYtBjRP4PvPBmScvnb3s2LbZ11GQhp8kUdE9A
	JHTS/tSUQ1uAuiHv7+4HoyiXug1lJnE2gBK/9o9/vwkuK3zL6XQGIyB8eenU7Lw/
	EmnF9VZVMWEaEgsgBTQDvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781081573; x=
	1781167973; bh=jqshMETqu6TfI5fE9romGWAmGMF9Uu+1PZZuhZP6xsQ=; b=k
	afvfsbyeo4D9Oan82zNU15ZuMfhM6xedOxGaSgBsRoprNB+3YaDYrcee2q6rb5UQ
	5LXQ3a2hXxo+tGE2FdiFPGGvvwvmkC1i6GgKDcyVnxNqPqFjRLEkuKcJWPCts0ow
	pbD2iOcKkLEpnF6ef3kfaRRjtJfBomy1x+CrdUNtx9Hzp5gLanLNveTGAVMDDsMh
	F73WnA9NMT6VKgYIC6bDoEC9Zy6hhnhnFsjzeWYUrxf1+D/cFqGDT5QwXOQqa9MC
	evQtbhKeh4zSGD/94qxrwggndt5XJ+BVsm1ZipWsi2PLzTljFJ3ea5Cm9yJmlpuS
	b85koU8fZGew99RNdJczw==
X-ME-Sender: <xms:5SUpahL45lvTH5K00m7UsX4Bdv1LGi241JXZikI3U_iJ-57g8d2edw>
    <xme:5SUpaur1cHYoqvbPj0X4ocC0OLRi4S02HwXGdm-3ljjkOn-34tGhF0IcNAHwxnZhM
    OgKUSc_CbyLC4zgddPWBbmkXq0faI7GcQcI4vJPweNp7LL5PzHS3g>
X-ME-Received: <xmr:5SUpapyt1r8-jEmdNSfKW5jwGDlLV7CQOm5B64Nw1x9-tkm-8lizKWpyyAsaqVqVRcAbBRWICR-7zAxAIB6VCucEcvHIgq6Tmn199mnX4w>
X-ME-Proxy-Cause: dmFkZTF/iC3EZ3ej+MEI5OZ52EXmJ/TXvV4dUJC8U1ZO1riGGImkArj5j8jvPHQCT3dgAn
    x6bpMacACpM3l1rT/ILW2rb46G3l/pyvukBvnCEQtke2fdwOZDTjdAkfWjhP4gv0X2+j6j
    LQ/4rwoaY0X9hygmgmSNNpJHXODEgV5dItXT7qcmb4cGDTj2O1Ka0ILQkoeMwTDE5Lhf2D
    VVhmudBQR/pwqwGqxqgINq7JliwCb84puvN32j3zuIRU6qQvorcNcgds4YwFEYGeE6VRSO
    G/XW17ntokjTblT+byQdJobwstwXH/LnQUtxYvM+s5Hxq+34QB9dsXu7dLGkgBQVLVPxG5
    CkkLgen+9dZ88vukGDr2fmZcGM7uHLchIWLn6RZMPWJOYKFtWolovAf1B+U9lxTHJDCOL3
    3HTKDc4ReoTTBGyswkNFQtO4xAlj/vSZf621wd2titbiZwJPtmCq8XScBAZqqr4nzr5Zxr
    /NG82d26eCq2CSifxDUT8jqOFWvyAf5GtEKEgW9FVsx28hjczMN8+lzfTUmncZzzllb0hf
    ESbDn9is1wcw2PB6J32ags1FK4xl35ZX+NRfoO/cM7LflfU11kdnpt0/J5mmfIBRoPpgXx
    fO/f2u4j08uWcUeOGkSNRWQkoZnkn/gmU3WQWFaSZVDzCOtQ93Tj1WriHo8A
X-ME-Proxy: <xmx:5SUpaiNtLuZPu2XduDWM_FughNCNnosrPrVrqGkCjRP2zKAcjxxofg>
    <xmx:5SUpau4xTwSMf6yHgpeZhGiJQf73BORgvGEwNMoD2_lypBaROkVBYw>
    <xmx:5SUparlXbV8XynI9jRBRwQ1HOd9jaQzW-IG1scka_4-CfqEUVPuefg>
    <xmx:5SUpanTqrXOFcWwkUAsU_HbqzpH6j8ACtNGg0bxYdjyIe39FSLZ8Iw>
    <xmx:5SUpavcHs-oGxmcY5QIZeVGYUvikT2XILjdrvj7gUKiWm4hHIgjlF9_w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:52:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6dba1436 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:52:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 10:52:28 +0200
Subject: [PATCH v4 08/10] reset: stop assuming that the caller passes in a
 clean index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-history-drop-v4-8-70d5f0ae8c25@pks.im>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
In-Reply-To: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
index abe36ba116..2b82e80c67 100644
--- a/reset.c
+++ b/reset.c
@@ -164,10 +164,11 @@ int reset_working_tree(struct repository *r,
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
@@ -194,7 +195,8 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
-	prime_cache_tree(r, r->index, tree);
+	if (reset_hard)
+		prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
 		ret = error(_("could not write index"));

-- 
2.54.0.1189.g8c84645362.dirty

