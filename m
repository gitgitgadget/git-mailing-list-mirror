Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E93AFCE3
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289435; cv=none; b=CHgVOUZ0ghk5LoBLHehAzWlRev0BhcOZI5lyEKbvA8sjj1vgn7k/kv4lpsaWUTfbjScPabZ77roHkzuwi8sIuEYONFW25OJW2LSAZHrZ0KqDrytmG1YRBL0epyvVddLqs8+MvlJ100lCWOtFYQ2AuwH4Xuha0WBtE9/4/aaxiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289435; c=relaxed/simple;
	bh=+fsYrH2lEDNII02SDQwxQBoRS4oZLZs+o5i2N5Ecd+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B2CoutOLQcM5SQIYTTF2pCuVo2ZhQ6hnMxNSB3A3WIa86qD39mH7UWwxusFFog3pPEqR5DhFTZGbwjEMsNAmHTQz4fNi0px5VraeMWSMxdUY3Kmg87Bzu0QyWE+6Z9vnRGkkiC/n2xUtu+rxO161pSPrHxghLCaRBDBXaHlUZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ueEjQ4ON; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hYp+6uQX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ueEjQ4ON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hYp+6uQX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 607737A01D2;
	Wed, 24 Jun 2026 04:23:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 24 Jun 2026 04:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289429;
	 x=1782375829; bh=Osghc4lL8mdZTlWZaZBLaBMGd90EqJt7lSIbTIza1DY=; b=
	ueEjQ4ONKUzZBboQs0pj5meO5FjiD6gmRK9hAF9TS0EFyLBNI2H8g8mHnT/fOsxe
	rFw89WHVsNwj6rOVRK9BHFPxA6pfawai2/4/6a/A4km62DkYKe8MSilCEFe19OpG
	a+cnD+bwLJrrmlRfCsF4aocanXplQzmLzrvX9GbV5HWVP+csx4uGn5VaYqO06qOp
	9S1thypeUTvei1fyssBs++Q4puWY/cQr9Boo1D8eGTlE6/CD2D+LJcmR6Zas5SX+
	BJ0Fl6kkmw4sF8822kXR8ANQGW6KkOCXa3pig3U09ewSfEra4jQdIYvaC7GD+GD8
	VQKb1PXnm6J6mc4eU8Rp/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289429; x=
	1782375829; bh=Osghc4lL8mdZTlWZaZBLaBMGd90EqJt7lSIbTIza1DY=; b=h
	Yp+6uQXBKjVSYrSKZxbm451n02+MZt8RxrPJ4DS7cBds5s0L7LW11bka2BnFV7wr
	s2SvknnTteyX2wVePt6tukVu3KSbRsBJGLo5eM9NYShqtZ+P+5yeCNgWWjqMtku5
	GJJObcf7yHo8Urg9FosA0qeycAZ/Zusw8lNmAMvEH0Vm8U5FBDFDWMDYMC0Cbf0k
	9CjYULXkja7GiqCUTd+svrEyRTiSrTptEHAW36FzaWS1Jj8UHZkCRE/aDWkwSwcl
	GH/RvfxfcEdEqks5TiI7khXvNl40Jfjpv0e4Y0fMgfLQKC1/0p6W7wZL7W8LyjIZ
	yMEhZNoTdJj59yK0GqlIA==
X-ME-Sender: <xms:FZQ7ar5rf6mmuXNmogPvZrgbHh0xf2-cm5_w3R0BahGPz3vE3xzfIA>
    <xme:FZQ7am4zyZUC_UdJ2JR5CCYd8xaMadCn32oj3qNBvdwY-v6zRWywwwMfgejcEBCl9
    YVy-yCd9Wblpdk_0ocfX2mS8bpiRQ7wGtmHexi5Zdl_xbpylNfJ>
X-ME-Received: <xmr:FZQ7agGwkIzHSaUZQtWKzITIlfoBHd20X7JJ2mJwluppieu32H4lNZm4z_ik0ewivu6VAXwx4Pbxm9VSUijsH3mim83vs5ZIDBKaMFwI>
X-ME-Proxy-Cause: dmFkZTFTscqWTzOgOVM/4h4ujciNGkBDY0kDO0Jobz36NHnUpRxOxioedCPyL7xWpOQw3l
    jeETOFwa/qNaB9LTKJz+KOPAwg0TQnLAPBhWGEV0aANZMT2e+K2pZ2mucHNoI+yNJoefVi
    Qwu0XNTRUD95z8teh8/Tjx5/DjYDKfwL3x79bg2/Cb56q7qrGP6pqoT1wOcuounxmPsCqh
    LqWbDbnxbVYa1rS6yOPp7WFUt2jOL38SLXOkW50bowX305d0iyzxINuQFJR5GsAtOiUqds
    OPuNR7NpO1+GA2KWIwAO2JhHE9z4Xyxgp27UVzFsLE86cntwOv8mZEUCU8vz1LjbZcfdTL
    5liwQUpmHoVcv4ByZ5yybHe0vkeFmbeh7/ZE0a7IYVn79n2nhLdzQqKg9Cy0rlBiUC8gq1
    wG23msKi8GIP37RTf/ry3kTDf2Vmsqa7yJ81oSVrZGACFTlwa2pQSy3PyRsLjJsaAquL0k
    5eSuSVZv4iVNE7fQF/YnPf4M7Cp9v+4IGk9JXsows80qhwCN27tggJ8syYmfg6dblWwDX0
    TKeMdbQHssh1SLU0PxlD8rqzi9ncOvRPec83Mok3EgPWIsGu5j3C2/4c+9t7hZZ7+KvyEj
    zwuiR+uJO4zHciOFVVDtrX79MTl6b34W/AludR0zywyhV0MSRHCwRvFaDJ9Q
X-ME-Proxy: <xmx:FZQ7anQfgh5XlmMTiiXpyOPP4DI24pEaXzNkZwFb6nC_g0_Il6ZvHg>
    <xmx:FZQ7ahsaYGYgn-KqmBzomC-l_uwg7PfjTY645cYo0Rp9vOayuJwUVA>
    <xmx:FZQ7auxK2wYKp8lTIB4wc6e8wZrP7vVKK87oLqFPrlcrHBcQZz17pg>
    <xmx:FZQ7aj6h04WDTrHgofU__ePIKPGXigQevoO-VhaFDUL4_pNy7G9_PA>
    <xmx:FZQ7aoVd3ymZ_gmCzXRhQ8p0fGzdCYMigNQFfYAGKaoXBLZGEPLQqJ-S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a65800e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:11 +0200
Subject: [PATCH 08/11] reftable/block: fix use of uninitialized memory when
 binsearch fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-8-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
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
2.55.0.rc1.745.g43192e7977.dirty

