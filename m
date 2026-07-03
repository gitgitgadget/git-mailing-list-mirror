Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87193B14CF
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070663; cv=none; b=scQ9j4OgqAw1hcEIadodtc1Hamg69ESk88uBrnWuJt0+I1HkavzwmW2lIZfCPA0hYvK9yxrcvi7jRNoUZve/zaSKnHeJ7r3/61QrCFM9r6AU5Qoacr2p6AgNMV54mW/SoB6k9goWIHxbWzKpMI8RDLBdsH/Q4Jnyw29t2CnbFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070663; c=relaxed/simple;
	bh=JCxB/myrPoFZzDHrD7+gVahtD+oXIkh977qzgJuRdX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdUBVUfaXmOKHuodv8Pl0/y1nnG1D8kHZ1A5LKu8kFo7IQxxz79EuuTQkmOMHZ8QDjAo1myIMD9RXCMPpTohHeHqbXFDYnY9UzxDVa8bkC2C6btKLzVjP+ZpTmwHHFmB4KOYhGGPBg4itDyZqXaOS71oyGcluoR7myMba7Gi3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xl5odqIo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qkZmw3NR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xl5odqIo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qkZmw3NR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 30AA21D00104;
	Fri,  3 Jul 2026 05:24:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 05:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783070661;
	 x=1783157061; bh=Ozp/KmdrhgccsNQlaEtWMGGh0FKTeP27agwxTeHLYuI=; b=
	Xl5odqIode8tVmGfTMTRNo1d3mnoZ0jJvBZCA+qUiPh4nbTOdxqn5nzKzGQ+PxY9
	uCdWb7YP3SwT3yfkfpX72cpDKsl/bxP44hss9y6Yy8VKLzXV7EkDowEjt2zY4ja3
	g7dGEyKMjMCho+KWwnRaBDpK7pQjG3z7mQtm6X2NhyCiHzM62Vw32cn/dzolmSHq
	Ovy5TlIWD6VofAljcMTK01cYhG6sa16/B0OyDjBwu2gkMAZIpZoGTuNjdV61APtk
	9M2SSTZTkzAzSRixdUsj3Bl1e+7oy064SCTkw1LHlIYACepVna39UsCz3qrPWCR9
	Ejefy5Bv8MwRvbTIrcASIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783070661; x=
	1783157061; bh=Ozp/KmdrhgccsNQlaEtWMGGh0FKTeP27agwxTeHLYuI=; b=q
	kZmw3NRku2vkc/GZ5VpCqRvLDkNVkwCLy1mxrQ1cjKM/3Z9aZV3h3ROgJ5PkrjfS
	mNZ3GLvZnn+qDOcJuh81DNWslLIqu7O1JmzGhBgYaMhQr/3xI9fDLZC4zALb5nV1
	IqOsinSEvr9j/iAEXXXAQcG3sBfykyeo9NelCgSoK+dMWreiM7KTQ8TBfBlnnx2r
	LaYbO1IkX/bcUKTwDEQ8BLJ725bOrQY2Z2KjQZFw7I65olrl7gBsgPca7ywjSOhb
	elVMvyX+5eDYYlmU1O1fgQQA750tFmSZ8D2UVyPOAtK8Kmr/CsUVK9NcexSwBQY4
	Sh4WeO5Qw5R88FTv0Uynw==
X-ME-Sender: <xms:xH9HaqNSAbO4GM3g-x1pZJF4AeDPRxZ5qJRml-AbqnLpojgsE1esUw>
    <xme:xH9Hav2HPwteGALfAP_OwVSFQZabd2qJbW7O_kIWYTO9GoPHGqShgBg1i828fG0tp
    D5gxSoPjVCX9Qd6FyNc-L76mTsnSdD-kMC-UYErjXCASq9uwj9J>
X-ME-Received: <xmr:xH9HapnHiETHOat3shLd671BrFb2ygIDMZbEBoUXzFsoW6cxyPvXjx7xkKxSmiL9JAWYJIOqoO0C82llSzT7CuD2LAvQMg0YiaNQ-EmqZQ>
X-ME-Proxy-Cause: dmFkZTGzDKeA0b89E/teLvlg0KZl+qnUPKYPpjn2gBrRNb8t/+qAkTTZbJEMLHVMR2rg4F
    Zn7pHH1e3ZVVeqvySWoIg2jP0p6qEXA8rvJIxMpeZrsf9jGOi3qbPeEx46snlSSud/Uup6
    7lw7BUifHdxx+6VrF0QChTrfJVmx/3vj9EmgBtogyAJNqH6cvjz2sM05ISS4yHcJmAiF+Z
    nmWHqBgNnov0O38JK6N2T13h5IrkmozNXcfs4mH0I3UgdN3PbYNQrIFiHbM1DnEl2QO4Qb
    /7y7VNJORadIUa7C9HHf+1fr3HAsXHXor/SE8G6bXUOTHQjQkB3WoeboiLCtb0zXNpM6cr
    oaLlj9RcEXVWQUf19kTf2U8gyM7Irp47BGBynvokSSUAdpqf9AIssMahTAUtOHPCFLuZ/m
    v8HX99SiBTYBxfvmHBdzKcGV2Vc8ESAWIHNp179b1JMfEPvfpkVguFslqLq4fiQvaxzX9G
    Js96yK9xLprN+rXsxLFlF5M2Yndf3TxhMn/aXBsR5rwtGrFO6DNcFlcDzuJs1Jr5NzQneg
    YCPAA7xF/N4n3SVN7/XlnvVTS0zlhKn23R68h6RSu+AIiq2buuMsDbkcaDIuOMRdsxmMqb
    jb5iIMOzM+rDnJj6GfmfrQhRwi1oJJjI0H3poUiIHH5TJsHg1JJcSWodIn4w
X-ME-Proxy: <xmx:xH9HamWcPUZXR2K8yZ36WjJML-2dFO57cneFIAX1pcLb90S7qdYLmg>
    <xmx:xH9HavsR8Drbks1-BkP2izv8WeeljWmBoXhRR1Eb40ZwcMSdFe5Lww>
    <xmx:xH9HapaDvwkRvZKAyZtzI7Q0rymEqnkcOTa62QCkMRC67rI9Zccc0Q>
    <xmx:xH9HauUSRe-O9rrlRrgWWlR9iWI7vzF-2NaJzoZgQomQDg31xESdBA>
    <xmx:xX9Hajw0MrzNaA_TznMsB7Mn5IsmSFsxzqZidEJAPH5qF2f4EPqtDZa9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:24:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fdaf687e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 09:24:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 11:24:05 +0200
Subject: [PATCH v2 2/9] t0021: skip EXPENSIVE test that is broken without
 SIZE_T_IS_32BIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-2-79076a7e0c62@pks.im>
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
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

