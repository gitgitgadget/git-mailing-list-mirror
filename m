Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A13D649A
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083559; cv=none; b=taLhD9sv+U2ZI1ovCSmmXDfHYdR8muO/tZmU2DG8SKB1Xnoo/D77fGke1YizsL6kZeQaP3piR8SwKermJBuvieqEeCwNp+ACXqYruWprO33x2fyvxj10GwVt8FqJC0EJJUzF+Fyi4dni/bwab1HvTHw5vo3phQf1QPMDlNIRzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083559; c=relaxed/simple;
	bh=UHNnDFSkJo5bUHXAza61D9FWxZFCno4WIxWovQvQ1Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCSQmoidT2m7iiCdCJbJsDysaB7KfZ5fLBRF0/+JUSgMHXn5ZDf9FTErFYp5SN2j409CPQagy9GmzmPm/jp7TiGN91i8k5K4uTOtkEKEXb98nY8CHbVepG4dVHYF9HpEn9rVejJChf5lFckj+KrU5IoNL6zIzUEkW1XyqBWyfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cj2FOO3K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lq7Ira9v; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cj2FOO3K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lq7Ira9v"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E42C1D000B5;
	Fri,  3 Jul 2026 08:59:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 08:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083557;
	 x=1783169957; bh=+7bsfRBOrLBaeWYXerJmZ+mvKOu8AC/eX8orByQAY6k=; b=
	cj2FOO3K7qvRX4a5Af250wHw7Y1ui1IjaXF3fkBYiRhrE1+KpPVvql0Becm7vXos
	lgYJWBEsvVJhGrhwwAdUUMZxvyT10VmMbp+qMbm2HixjN5DgeqcDWPwC1MjZKC6U
	UOqJXhg8gtvkPX+D9wnegHub41fw0c5I3lqi29TGOknOqmflDCZ6tKyNP4AKK41r
	nQ4JL5tt6y/tq18McW51qkNYWM7iLUEBtlmqBiWtUSkfk15KsnyolQaxzOADvrdy
	MhJJAXrPPaNZXoguCxe4RV2Gr5h/TrO609tjwITkStt3OWIeRLt621iVv0bycK+/
	ghSjFzdAYKMTuip9UGq9Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083557; x=
	1783169957; bh=+7bsfRBOrLBaeWYXerJmZ+mvKOu8AC/eX8orByQAY6k=; b=l
	q7Ira9v4thVGSSvnDW/KrqISvrRnJpaYMwET1++MomG+b5CiD6DOzN/gLTTjHgrl
	mpOa6EZrvOdL7+3A07K2WmNpLmNjP/Lfz8kQ4fSOCJanqcne6Wb0aSRHPmEuX8fp
	IcEeLpZqdVMv3S8IDOHDdaaWxDtS/NO/YV9/AeyLAlnlPMwqAxRlJ4HBuXA2F769
	qaNLimE0jIJPiF7scLJA9O9BRp3t6rbwZq9HEmdh8W8meougA/5+5d5kLubeaCJe
	RYMtEtohirHvl4grGEzf+9u+ZUH+6bxoQFZo9/rbxH5xJ2fjv1UEDU8wx347Da1D
	5+z7R8B/1iys3G43Hloaw==
X-ME-Sender: <xms:JbJHauvrjBgj0HRNpRWADdzh-QwQAhQnILjn1JL1UHOh5eAsYQaxAw>
    <xme:JbJHaqdVyLnUOM-3MGXuXSh-2Nxj0h0s9EDt-xAlpuTmlHYmQRRXpEuEkDODUI7Ng
    drzLOu7odbkpRNaAfpiRvva0cj6_rBfETcGi_-RukMrQ5oyWuOh>
X-ME-Received: <xmr:JbJHauyPHk1iNDGXlOoabeal_YaygpndwoiW73igeOlHybdEkIU1D1fMP-EPQLd7BIQ1_RRNqY_ieRdPBJmEvEEyWPyQyRYrQjL14eC9-w>
X-ME-Proxy-Cause: dmFkZTF2gDQoqcduQc4Tu9Nd+mO1zvTXFp54QcScs7NFva7wOU+BkW8X153+XNQC4EO/pw
    YLJbJTxM5vKUsqZ7xFb3PrI9fIclYoJDDfOO8nlV4PrH1ulogculE60DlowcC4jpDhwwo/
    Lr0VhIteBcWcbB4yO+qk0u5otvJJ6hI8m0Q3Ik52hAYgLCP7sO+LP65grvBk0k/ThbSODj
    So0bGGCYpcduBBxIRyPNB4NPIDlq3K2Z7lmG9vNVXHAOwXjkhisA+N/ibAbl6GEDGNrp+q
    5Y2+rOWvUa7Uu9EeQYHMCQZtO8a+NxJSt4vVnLcjY/VYrzMTH2vJiHTNARAlF9EYN4CLqH
    SpfjnPbgjOvO/jBRZcb6CCOZSoY+urCdFXaTOPC2d3hPIsjBeiLaR/B4ywCYOFMQxGRalA
    uydHoeCfDz6AIkXFmZtVJ/geYCH0dT4Pyy7diKpJQyq3/NP8+8JnV4uSPi/zveDekt2Iej
    50o937dx+R7NoFvTeWgqKrEI7byiua7dQbTnE2lVq1ObanRIZJhbUgrzcYWotqyMeysCde
    y/BL+jpvFzO6OnNZJ6CapPZJzHOIj5lqiVet1izkjGhEsrvo1gHMQ6gg0FdetGA6R3732c
    058kUaomcGGztBHA9MJe0W35BIO34ymsj4gBVBNtDue4NY/Hs/tzEHBsb8lQ
X-ME-Proxy: <xmx:JbJHaoFdAXot3HzgWLSFUseA0rmtVaD_mOE0HvhZBxfHorlfVfG4Uw>
    <xmx:JbJHaqzrw-qQN1gjIUqedc5HTEhMVc0IE9rYTbBMUqbSEPv-PFT4CA>
    <xmx:JbJHahsuTrS0ehQrccCmLmqZqDVFVcT4HYZDGMeCTQj17Ar1c4nG6g>
    <xmx:JbJHav32hHVpFSRer5_SQwWaT9AZt4i3p6ybhygv6gnQBBBCbMvu9Q>
    <xmx:JbJHaiGplJKawwaJ-S7EQFA6X4Q1cjEI_irYBR-0JNsbKO_8Gj12zQ_F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:59:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de6bbb0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:59:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:52 +0200
Subject: [PATCH v3 09/12] reftable/block: fix use of uninitialized memory
 when binsearch fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-9-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When doing the binary search through our restart offsets we may hit an
error in case `restart_needle_less()` fails to decode the record at the
given offset. While we correctly detect this case and error out, it will
cause us to call `reftable_record_release()` on the yet-uninitialized
record.

Fix this by initializing the record earlier.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 4d285aefd7..89efce8751 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -517,6 +517,10 @@ int block_iter_seek_key(struct block_iter *it, struct reftable_buf *want)
 	int err = 0;
 	size_t i;
 
+	err = reftable_record_init(&rec, reftable_block_type(it->block));
+	if (err < 0)
+		goto done;
+
 	/*
 	 * Perform a binary search over the block's restart points, which
 	 * avoids doing a linear scan over the whole block. Like this, we
@@ -558,10 +562,6 @@ int block_iter_seek_key(struct block_iter *it, struct reftable_buf *want)
 	else
 		it->next_off = it->block->header_off + 4;
 
-	err = reftable_record_init(&rec, reftable_block_type(it->block));
-	if (err < 0)
-		goto done;
-
 	/*
 	 * We're looking for the last entry less than the wanted key so that
 	 * the next call to `block_reader_next()` would yield the wanted

-- 
2.55.0.795.g602f6c329a.dirty

