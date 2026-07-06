Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FE3CBE97
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319056; cv=none; b=Uuavii6JHLYnxtQNXTncGtdNaYkuZluHVk5iy6AKDsJHzLPugqWC8bTJ7xqKR6ZGTm2PhHau+i/Uk5MQM3TxIlJpj3gulLAOkqmyRDbJzhIPMPHqTB41iFI9+5XtmaouAA3SJz/bZAlsAYeW4gOX5BKIseMr5UPKvey21/H2Gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319056; c=relaxed/simple;
	bh=JCxB/myrPoFZzDHrD7+gVahtD+oXIkh977qzgJuRdX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0E71S5hSXfrdhJUFhK58magRzLOlTwsBOsT2xZF/hKprZjwNhsgooJu/KsGhvalkfrU0XzCtEn1yXE+Tl5syarDaro/pkTSfmuddCOi/G6D1yLctGR8hZSfGMBEduIfc+K/gco0WqE5pjg5gFvBCAt2nglHGbeRIYbDhdcJyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bykZqtWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lr47Bgcu; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bykZqtWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lr47Bgcu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61FE47A00E6;
	Mon,  6 Jul 2026 02:24:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 02:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783319047;
	 x=1783405447; bh=Ozp/KmdrhgccsNQlaEtWMGGh0FKTeP27agwxTeHLYuI=; b=
	bykZqtWlWPCIL/SeXfd3RTKnTVVMIO3s5dIJboQuzPy2UdkBDdiCOa2dVT2qa3kd
	OFFXgh/91XWnci9/MghBAm1ybxHJTITxFl6drNkGYwYuKz26XIGxj9IJPdZd8xAA
	Fxq7r6JIG4df7yISezdIW5sus6azotqInBWK4PeaMLKpWDYb2/Brsm1MF5EVqtVJ
	KjxB03fXMDSirAABHghP1bKk9I3YL/0Y8qYGHIbXXfEnHygJ9lOjGzRQJnJWq9yP
	ahS93Jwfi/5QwvcTx+TB2r9MeYVn019ShpSRdaemrApOHPBa+VcIfVzT84qA+xbV
	DxQxUaDE9WxQqsQ7gP0Txw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783319047; x=
	1783405447; bh=Ozp/KmdrhgccsNQlaEtWMGGh0FKTeP27agwxTeHLYuI=; b=L
	r47Bgcu6hijkklRRU25hDli+Bo5PPB21tXZGU1PZPQSsdG5+NbsSQ+38jrMASNs9
	mjjLs0D8l8TZW9fyNv+jrBtqFkZBHyOPecUHpdumrR9jknf/ExXzkTPMZDIK5YJD
	zRJ7iUYYjGtvowp+NiKlq2tWMf2tsYfgTe4BuI7WtEsMkCz8eKZTbgPIU8SW6IX3
	S6zreD8cg9U+jlHZ6pEUsiH8aHBZ2u6hcTygufoJAYOWPjfnnHs5QokjeTXjVdQM
	RNMcT9DTNF+6M2sbbzhhH/FUjZH8K03mDFJOAuqU6hmkWBHWkHF9TZZKDMBhSTXe
	KLWxV7Bm6SZ68n6o6NDSw==
X-ME-Sender: <xms:B0pLaosqJFQ9eyzDgh2POr4vfew32M20ZnY5ZmUcsKqcMZM2wvIyMw>
    <xme:B0pLasXl7y6DzJDOZguu_kdgJinneXYkWswlOBEIt9jTGksf7olYCKEGZ2Tkhbh6i
    KgrQNroZcvNe--4zkHHvxzNV1k4WTi2un8nSlct6DZDU4MXGei4gzA>
X-ME-Received: <xmr:B0pLasFlQs-OMDNSfNhpbopPkZtvFP8-wbqZkn5Ff88DNkv_-2FcZrbqHNDEL7Uf50Uf28542RzTjlkDlru_6Y53SDKd_bIim-LDg30yk_4>
X-ME-Proxy-Cause: dmFkZTGlIFJfvr9JjAUQqv3z9uzuI1TcAwCQgQC66pe+YtTvthMsaKYODAiYejZhaxWS94
    841aslbvo93PfbzETnU8H70ped2+XjEP+TKhKPd53H4rY+u+tL7GrH8AS3qHI0BlKr6zK3
    kuio88I+FAUzPfHelz5KBao/fBgYvHU2ards45tbzzuoQF9BIDWVOfgCQeV1WHXE25n8GX
    xYBV2C/AR6rWNwC8N1YRFPEnxtOKP+G8umMxB+a0vwblCkPX3EnGR46g2El8k5uulaFdEl
    BKPmOemAPFyBIXPXYvD2g/oA37H2vMMQhQe85NUkbU/7fSsV2z9Lr1xcEUFne/swzN4eOF
    ipqynFqVUeFxv4uZlG+1/+Pp00PB6iPzWrfsn87Amo+9jas9+8kOd2jFwn/4XWsm25hozc
    HB4LhOkF4HYKlk3axel9n6ZjALDKFMEmzhbZM+43ywYjdeNbUaKejj8Uqrqnc9lrmGk+bi
    v4Uuxi4czAsBrcNWury7FFmV7KOHXQS86b3TFaFdB+5F84DoxcRUimVc0CeHTHk3aZMBIg
    0OT9SpqGKsLFfE/eTq+vmZZzaD06VkJoPjrsx3XIkE7MXhBLO2EQHHFaj4uavO8sadJ9Mk
    4uMV7dIRtun5nxptt101s1PNhVGzTVnzwsOsqWODeeHlZQYeD1ixWx1xLh8Q
X-ME-Proxy: <xmx:B0pLam3jPZhEXH6JM1J4xU5Tyu_TQH8WMd1E0HfCxYF8gl__EySnuw>
    <xmx:B0pLamOAP9BNogFpIpn7uSvEwTQrTLNiunqc2VugQAXv8wmSCvnNhw>
    <xmx:B0pLat71ovEiSLigeGIoVgV-mYgTKZdU5uLyhRLAZbM6cYvt8SJ3gg>
    <xmx:B0pLao1rKc6QOb3mrmlSiXCgnAAVhxSRZOoipDXNSIuAm8wy36lylA>
    <xmx:B0pLakRAUc81uEtFX_JeFrHjWlHM_twj3RWE0c_vwMNzdktasck-C6la>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:24:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66a7a8db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:24:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 08:23:57 +0200
Subject: [PATCH v3 2/9] t0021: skip EXPENSIVE test that is broken without
 SIZE_T_IS_64BIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-2-4f6c5a37fd1f@pks.im>
References: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
In-Reply-To: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

One of the tests in t0021 writes a 2GB file and then roundtrips it
through the clean/sumdge filters. This test is broken on 32 bit
platforms because they typically don't handle files larger then
`SSIZE_MAX` well at all.

While our CI has a "linux32" job that should in theory hit this issue,
we never noticed it because we didn't use to run EXPENSIVE tests until
7a094d68a2 (ci: run expensive tests on push builds to integration
branches, 2026-05-08). And after that commit, the test does not fail but
instead hangs completely.

Ideally, we'd of course properly detect this situation and then test for
it. In practice, this turns out to be hard as the test failure are not
reliable as they often (but not always) run into ENOMEM errors.

Instead, skip the test altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0021-conversion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 033b00a364..7b9a0ca877 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -296,7 +296,7 @@ test_expect_success 'filter that does not read is fine' '
 	test_cmp expect actual
 '
 
-test_expect_success EXPENSIVE 'filter large file' '
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'filter large file' '
 	test_config filter.largefile.smudge cat &&
 	test_config filter.largefile.clean cat &&
 	test_seq -f "%1048576d" 1 2048 >2GB &&

-- 
2.55.0.795.g602f6c329a.dirty

